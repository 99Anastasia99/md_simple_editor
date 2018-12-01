# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

md_simple_editor = () ->
  $('.btn-toolbar .btn-group button').click ->
    att_class = this.classList
    rgex = /md_/

    option = $.grep att_class, (item) ->
      return rgex.test(item)

    if option.length != 0
      option = option[0].toString()

      text = if option == 'md_h1'
               "# "
            else if option == 'md_h2'
               "## "
            else if option == 'md_h3'
               "### "
            else if option == 'md_h4'
               "#### "
            else if option == 'md_h5'
               "##### "
            else if option == 'md_italic'
               "_  _"
            else if option == 'md_bold'
               "__  __"
            else if option == 'md_list-ul'
               "\n* "
            else if option == 'md_list-ol'
               "\n1. "
            else if option == 'md_indent'
               "> "
            else if option == 'md_underline'
               "<u> </u>"
            else if option == 'md_table'
               "\n|Header|Header|Header|\n|:------|:-------:|------:|\n|Left alignment|Centered|Right alignment|\n"
            else if option == 'md_minus'
               "\n<hr>\n"
            else if option == 'md_link'
              "\n[]()\n"
            else if option == 'md_camera-retro'
              "\n![]()\n"

      textarea = $('#md-editor #md-text textarea')
      insertAtCaret(textarea.attr('id'), text)

insertAtCaret = (areaId, text) ->
  txtarea = document.getElementById(areaId)
  scrollPos = txtarea.scrollTop
  strPos = 0
  br = ((if (txtarea.selectionStart or txtarea.selectionStart is "0") then "ff" else ((if document.selection then "ie" else false))))
  if br is "ie"
    txtarea.focus()
    range = document.selection.createRange()
    range.moveStart "character", -txtarea.value.length
    strPos = range.text.length
  else strPos = txtarea.selectionStart  if br is "ff"
  front = (txtarea.value).substring(0, strPos)
  back = (txtarea.value).substring(strPos, txtarea.value.length)
  txtarea.value = front + text + back
  strPos = strPos + text.length
  if br is "ie"
    txtarea.focus()
    range = document.selection.createRange()
    range.moveStart "character", -txtarea.value.length
    range.moveStart "character", strPos
    range.moveEnd "character", 0
    range.select()
  else if br is "ff"
    txtarea.selectionStart = strPos
    txtarea.selectionEnd = strPos
    txtarea.focus()
  txtarea.scrollTop = scrollPos

initializeEditor = ->
  md_simple_editor()
  $(document).off 'turbolinks:load page:load ready', initializeEditor
  $('.preview_md').click ->
    preview()

$(document).on 'turbolinks:load page:load ready', initializeEditor
