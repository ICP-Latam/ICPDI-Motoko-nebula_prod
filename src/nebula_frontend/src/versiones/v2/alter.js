
function readPosts_incannist_v1(arrayofposts){
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


//no funciona muy bien
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

    resultHTML += `<li class="mt-2"> <form id="idp_${idpost}" class="delform"> ${index} ${label_titdesc} ${button_html} </form> </li>`;

  };
  resultHTML += '</ul>';
  resultsDiv.innerHTML = resultHTML;
};


function readPosts_incannist_v3(arrayofposts){
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

    resultHTML += `<li class="mt-2"> ${index} ${label_titdesc} ${button_html} </li>`;

  };
  resultHTML += '</ul>';
  resultsDiv.innerHTML = resultHTML;
};