// Blacklist all file attachments
/*window.addEventListener('trix-file-accept', (event) => {
  event.preventDefault()
  alert('File attachments not supported!')
})
*/
// only images

/*window.addEventListener('trix-file-accept', (event) => {
  const accepted_types = ['image/jpg', 'image/png']
  if(!accepted_types.includes(event.file_type)){
    event.preventDefault()
    alert('Only supports attachments of jpg or png files!')
  }
})
*/

// File size

/*window.addEventListener('trix-file-accept', (event) => {
  const max_filesize = 1024 * 1024
  if(event.file.size > max_filesize){
    event.preventDefault()
    alert('Only supports attachments files upto size 1MB!')
  }
})
*/