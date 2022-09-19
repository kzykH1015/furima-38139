document.addEventListener('DOMContentLoaded', function() {
  const avatarForm = document.getElementById('avatar_image_preview')
  const previewList = document.getElementById('previews')
  if (!avatarForm) return null;

  const fileField = document.querySelector('input[type="file"][name="user-avatar"]');
  fileField.addEventListener('change', function(e){
    const alreadyPreview = document.querySelector('.avatar-preview');
    if (alreadyPreview) {
      alreadyPreview.remove();
    };
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
    const previewWrapper = document.createElement('div');
    previewWrapper.setAttribute('class', 'avatar-preview');
    const previewImage = document.createElement('img');
    previewImage.setAttribute('class', 'avatar-image');
    previewImage.setAttribute('src', blob);

    previewWrapper.appendChild(previewImage);
    previewList.appendChild(previewWrapper);
  });
});