import { nebula_backend } from "../../declarations/nebula_backend";

const resultsDiv = document.getElementById('results');

document.addEventListener('DOMContentLoaded', async (e) => {
  e.preventDefault(); 
  const res_get_allposts = await nebula_backend.b_getAllPosts_resArrayiter();
  readPosts_incannist_v2(res_get_allposts)
  return false;
}, false);

//document.querySelector("form").addEventListener("submit", async (e) => {
document.querySelector("#formadd").addEventListener("submit", async (e) => {
  console.log("Entro el submit formadd");
  e.preventDefault();
  const button = e.target.querySelector("button");
  const in_title = document.getElementById("title").value.toString();
  const in_description = document.getElementById("desc").value.toString();
  button.setAttribute("disabled", true);

  // Interact with foo actor, calling the greet method
  const res_addpost = await nebula_backend.b_addPost(in_title,in_description)
  //const greeting = await nebula_backend.greet(name);
  button.removeAttribute("disabled");
  document.getElementById("responsepost").innerText = res_addpost;

  const res_get_allposts = await nebula_backend.b_getAllPosts_resArrayiter();
  readPosts_incannist_v2(res_get_allposts)
  return false;
});


document.querySelector("#idp").addEventListener("submit", async (e) => {
  console.log("Entro el submit delform");
  e.preventDefault();
  console.log(e)
  const res_get_allposts = await nebula_backend.b_getAllPosts_resArrayiter();
  readPosts_incannist_v2(res_get_allposts)
  return false;
});


function readPosts_incannist_v2(arrayofposts){
  let resultHTML = '<ul>';
  for (let post of arrayofposts) {
    //Example post -> ['3', {title: 'asd', desc: 'ads', author: Principal} ]
    
    console.log(post)
    let idpost = post[0];
    let titlex = post[1]['title'];
    let descx = post[1]['desc'];    
    
    let index = ' [<strong>' + idpost + '</strong>]: '
    let label_titdesc = ' <label class="me-2"> [' + titlex + '] [' + descx + '] </label> '
    let button_html = ` <button class="butdel" id='b${idpost}' onclick='deletePost(${idpost})' class='btn btn-danger'>X</button> `

    resultHTML += `<li class="mt-2"> <form id="idp" class="delform"> ${index} ${label_titdesc} ${button_html} </form> </li>`;

  };
  resultHTML += '</ul>';
  resultsDiv.innerHTML = resultHTML;
};

//<form id="idp_${idpost}" class="delform">



async function deletePost(idpost){
  console.log("entro el delete")
  const req_deletepost = await nebula_backend.b_deletePost_byid(idpost);
  console.log("lo borro, cargara posts...")
  const res_get_allposts = await nebula_backend.b_getAllPosts_resArrayiter();
  console.log("corgo los posts")
  readPosts_incannist_v2(res_get_allposts)
  return req_deletepost
};