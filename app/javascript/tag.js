document.addEventListener("DOMContentLoaded", () => {
  const tagNameInput = document.getElementById("item-tag");
  if (tagNameInput) {
    tagNameInput.addEventListener("input", () => {
      const keyword = document.getElementById("item-tag").value;
      console.log(keyword);
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `/items/search/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const tagName = XHR.response.keyword;
        const searchResult = document.getElementById("search-result");
        searchResult.style.display = 'flex';
        tagName.forEach((tag) => {
          const childElement = document.createElement("div");
          childElement.setAttribute("class", "child");
          childElement.setAttribute("id", tag.id);
          childElement.innerHTML = tag.tag_name;
          searchResult.appendChild(childElement);
        });
      };
    });
  };
});