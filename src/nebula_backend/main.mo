
import Text "mo:base/Text";
import Principal "mo:base/Principal";
import Array "mo:base/Array";
import List "mo:base/List";
import Buffer "mo:base/Buffer";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";


actor Nebula{

  type Candidate = {id:Nat; name:Text; identity_registrator:Principal;};
  var post_submission_id = 0;
  var candidate_submissions =  Buffer.Buffer<Candidate>(0);  

  //isolated
  func checkif_already_candidate(msg:Principal): Bool{  
    var candidfound = false;
    Buffer.iterate<Candidate>(candidate_submissions, func (x) {   
      if (x.identity_registrator == msg){
        candidfound := true};
    });
    return candidfound
  };

  public shared (msg) func a_addCandidate_submission(namex : Text): async (){
    let newcandidate = Buffer.Buffer<Candidate>(0);
    post_submission_id += 1;
    newcandidate.add({
      id = post_submission_id;
      name = namex;
      identity_registrator = msg.caller;
    });
    candidate_submissions.append(newcandidate);
  };

  public query func a_getCandidates(): async [Candidate] {
    return Buffer.toArray(candidate_submissions);
  };

  public func a_deleteCandidate_byid_safe(idx: Nat) : async Text  {
    var status_query = "No encontrado";
    var index = 0;
    
    Buffer.iterate<Candidate>(candidate_submissions, func (x) {   
      if (x.id == idx){
        status_query := "Candidato encontrado y borrado";
        let x = candidate_submissions.remove(index);       
      };
      index += 1;
    });

    return status_query
  };


  public shared query (msg) func whoiam() : async Principal {
    return msg.caller;
  };

  //--------------------------------------------------------------------------------

  var post_counter_id = 0;
  type Post = {title:Text; desc:Text; author:Principal};
  //var post_db = HashMap.HashMap<Nat, Post>(0);
  //var post_db = HashMap.empty<Nat, Post>();
  //var post_db = HashMap.HashMap<Nat, Post>(5, Nat.equal, Nat.hash);
  //var post_db : HashMap = HashMap<Text, Post>(0, Text.equal, Text.hash); no jala
  var post_db = HashMap.HashMap<Text, Post>(0, Text.equal, Text.hash);

  public shared (msg) func b_addPost(titlex:Text, descx:Text): async Text {
    post_counter_id += 1;
    let nuevoPost : Post = {title = titlex; desc = descx; author = msg.caller};
    post_db.put(Nat.toText(post_counter_id), nuevoPost);
    return "Post: " #titlex# "correctamente agregado"
  };

  //[C]
  public shared (msg) func b_getAllPosts_resText(): async Text {
    var fullquery = "";
    for ((key, value) in post_db.entries()) {
      fullquery := "(" #key# ", " #value.title# ", " #value.desc# ") " # fullquery
    };
    return fullquery;
  };

  //[C]
  public func b_getAllPosts_resArrayiter() : async [(Text, Post)] {
    return Iter.toArray<(Text, Post)>(post_db.entries());
  };

  //[C]pendiente no se como retornar un buffer
  type TempPost = {id:Text; title:Text; desc:Text; author:Principal};
  public func b_getAllPosts_resBuffer(): async [TempPost]{
    let query_buffer_bydbhashmaps =  Buffer.Buffer<TempPost>(0); 
    for ((key, value) in post_db.entries()) {
      let tempPostx : TempPost = {
        id = key;
        title = value.title;
        desc = value.desc;
        author = value.author};
      query_buffer_bydbhashmaps.add(tempPostx); //add para buffers
    };
    return Buffer.toArray(query_buffer_bydbhashmaps);
  };

  public shared (msg) func b_getAllPost_byid(idpostx:Nat): async ?Post {   
    return post_db.get(Nat.toText(idpostx));
  };






}; //endcannister

