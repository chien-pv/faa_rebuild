CKEDITOR.plugins.add('insertimage',
{
    init: function (editor) {
        var pluginName = 'insertimage';
        editor.ui.addButton('insertimage',
            {
                label: 'Insert Image',
                command: 'InsertImage',
                icon: CKEDITOR.plugins.getPath('insertimage') + 'image.jpg'
            });
        var cmd = editor.addCommand('InsertImage', { exec: showMyDialog });
    }
});
function showMyDialog(e) {
    $('#insert-image').click()
}
