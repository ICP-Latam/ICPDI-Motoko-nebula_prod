function readPosts_incannist(arrayofposts){
  let resultHTML = '<ul>';
  for (let post of arrayofposts) {
    //Example post -> ['3', {title: 'asd', desc: 'ads', author: Principal} ]
    
    console.log(post)
    let idpost = post[0];
    let titlex = post[1]['title'];
    let descx = post[1]['desc'];    
    let button_html = `<button id='b${idpost}' onclick='deletePost(${idpost})' class='btn btn-danger'>X</button>`
    resultHTML += '<li class="mt-2"> [<strong>' + idpost + '</strong>]: <label class="me-2"> [' + titlex + '] [' + descx + '] </label> ' + button_html +'</li>';

  };
  resultHTML += '</ul>';
  resultsDiv.innerHTML = resultHTML;
};

async function deletePost(idpost){
  console.log("entro el delete")
  const req_deletepost = await nebula_backend.b_deletePost_byid(idpost);
  console.log("lo borro, cargara posts...")
  const res_get_allposts = await nebula_backend.b_getAllPosts_resArrayiter();
  console.log("corgo los posts")
  readPosts_incannist(res_get_allposts)
  return req_deletepost
}
