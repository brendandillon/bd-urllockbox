var $newLinkTitle, $newLinkUrl;

$(document).ready(function(){
    
  $newLinkTitle = $("#link_title");
  $newLinkUrl  = $("#link_url");

  $("#submit_link").on('click', createLink);
  

  $.getJSON('/api/v1/links')
    .then(function(links) {
      links.forEach(renderLink);
    })
})

function createLink (event){
  event.preventDefault();

  console.log("win")

  var link = getLinkData();

  $.post("/api/v1/links", link)
   .then( renderLink )
   .fail( displayFailure )
 }

function getLinkData() {
 return {
   title: $newLinkTitle.val(),
   url: $newLinkUrl.val()
 }
}

function renderLink(link){
  $.when(
    $("#links_list").append( linkHTML(link) )
    ).then(function(){
      if(!link.read){
        $('.read-block').last().append("<button class='mark-as-read'>Mark as Read</button>")
      }
   }).then(
      $('.edit-link').last().on('click', editLink)
    ).then(
      $('.mark-as-read').last().on('click', markRead)
    )
  // clearLink();
}

function linkHTML(link) {

    var readStatus = "Unread";
    if (link.read) { readStatus = "Read" };
    return `<div class='link' data-id='${link.id}' id="link-${link.id}">
              <p class='link-title' contenteditable=false>${ link.title }</p>
              <p class='link-url' contenteditable=false>${ link.url }</p>

              <p class='read-block'>
                <span class="link-read">${ readStatus }</span>
              </p>
              <p class="link_buttons">
                <button class='edit-link'>Edit</button>
                <button class='delete-link'>Delete</button>
              </p>
            </div>`
}

function clearLink() {
  $newLinkTitle.val("");
  $newLinkUrl.val("");
}

function displayFailure(failureData){
  $('#link_form').prepend("FAILED attempt to create new Link: " + failureData.responseText + "<br>");
}

function editLink() {
  var parent_link = $(this).closest('.link')
  $(parent_link).addClass('edit-box')
  $(parent_link).find('.link-title').attr('contenteditable', true)
  $(parent_link).find('.link-url').attr('contenteditable', true)
  $.when(
    $(this).text('Submit changes')
  ).then(
    $(this).off()
  ).then(
    $(this).on('click', submitChanges)
  )
}

function submitChanges(){
  var parent_link = $(this).closest('.link')
  var id = $(parent_link).data('id')
  var title = $(parent_link).find('.link-title').text();
  var url = $(parent_link).find('.link-url').text();
  $.ajax({
    url: '/api/v1/links/' + id,
    type: 'PUT',
    data: {
      title: title,
      url: url
    }
  }).fail(
    displayFailure
  ).then(
    $(parent_link).removeClass('edit-box')
  ).then(
    $(this).text('Edit')
  ).then(
    $(this).off()
  ).then(
    $(this).on('click', editLink)
  )
} 

function markRead() {
  var parent_link = $(this).closest('.link')
  var id = $(parent_link).data('id')
  var title = $(parent_link).find('.link-title').text();
  var url = $(parent_link).find('.link-url').text();
  $.ajax({
    url: '/api/v1/links/' + id,
    type: 'PUT',
    data: {
      read: true
    }
  }).then(
    $(this).siblings('.link-read').text('Read')
  ).then(
  $.post({
    url: 'http://bd-hotreads.herokuapp.com/add_link',
    data: {
      title: title,
      url: url
    },
    dataType: 'jsonp'
  })).then(
    $(this).remove()
    )

}
