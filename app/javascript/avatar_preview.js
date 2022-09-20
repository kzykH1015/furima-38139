document.addEventListener('DOMContentLoaded', function() {
  const avatarForm = document.getElementById('avatar_image_preview')
  const previewList = document.getElementById('previews')
  if (!avatarForm) return null;
  console.log("555")

  const fileField = document.querySelector('input[type="file"][name="user[avatar]"]');
  console.log("222")
  fileField.addEventListener('change', function(e){
    console.log("222")
    const alreadyPreview = document.querySelector('.avatar-preview');
    if (alreadyPreview) {
      alreadyPreview.remove();
    };
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
    console.log("222")
    const previewWrapper = document.createElement('div');
    previewWrapper.setAttribute('class', 'avatar-preview');
    const previewImage = document.createElement('img');
    previewImage.setAttribute('class', 'avatar-image');
    previewImage.setAttribute('src', blob);
    console.log("333")
    
    previewWrapper.appendChild(previewImage);
    previewList.appendChild(previewWrapper);
    console.log("444")
  });
});