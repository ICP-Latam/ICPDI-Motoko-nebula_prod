

//option1 (no jalo)
document.querySelector("#testbut").addEventListener("submit", async (e) => {
    console.log("Entro el submit delform");
    e.preventDefault();
    //console.log(e);
    //const res_get_allposts = await nebula_backend.b_getAllPosts_resArrayiter();
    //readPosts_incannist_v2(res_get_allposts);
    return false;
  });
  

//option2 (no jalo)
const button1 = document.getElementById('cer');
button1.addEventListener("click", function(event) {
  event.preventDefault();
  console.log("but1pressed");
});

//option3 (no jalo)
document.getElementById('testbut').addEventListener("click", test());
function test(){
  console.log("hello");
};

async function deletePost(idpost){
  console.log("entro el delete");
  const req_deletepost = await nebula_backend.b_deletePost_byid(idpost);
  console.log("lo borro, cargara posts...");
  const res_get_allposts = await nebula_backend.b_getAllPosts_resArrayiter();
  console.log("corgo los posts");
  readPosts_incannist_v2(res_get_allposts);
  return req_deletepost;
};