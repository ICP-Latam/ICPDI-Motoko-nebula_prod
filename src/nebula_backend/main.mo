
import Text "mo:base/Text";
import Principal "mo:base/Principal";
import Array "mo:base/Array";
import List "mo:base/List";
import Buffer "mo:base/Buffer";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import HashMap "mo:base/HashMap";

actor Nebula {

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
  var post_db = HashMap.HashMap<Text, Post>(0, Text.equal, Text.hash);

  public shared (msg) func b_addPost(titlex:Text, descx:Text): async () {
    post_counter_id += 1;
    let nuevoPost : Post = {title = titlex; desc = descx; author = msg.caller};
    post_db.put(Nat.toText(post_counter_id), nuevoPost);
  };

  public shared (msg) func b_getAllPosts(): async Text {
    var pairs = "";
    for ((key, value) in post_db.entries()) {
      pairs := "(" #key# ", " #value.title# ", " #value.desc# ") " # pairs
    };
  return pairs;
  };

  //how to iterate a hashmap for get posts use trie
  //if u want to select especific data by key use hashmap

}; //endcannister

