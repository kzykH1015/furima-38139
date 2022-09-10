document.addEventListener("DOMContentLoaded", () => {
  const tagNameInput = document.getElementById("item-tag");
  if (tagNameInput) {
    tagNameInput.addEventListener("input", () => {
      const keyword = document.getElementById("item-tag").value;
      console.log(keyword);
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `/items/search_tag/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => { 
        const searchResult = document.getElementById("search-result");
        searchResult.innerHTML = "";
        if (XHR.response) {
          const tagName = XHR.response.keyword;
          tagName.forEach((tag) => {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "child-tag");
            childElement.setAttribute("id", tag.id);
            childElement.innerHTML = tag.tag_name;
            searchResult.appendChild(childElement);
            const clickElement = document.getElementById(tag.id);
            clickElement.addEventListener("click", () => {
              document.getElementById("item-tag").value = clickElement.textContent;
              clickElement.remove();
            });
          });
        };
      };
    });
  };
});