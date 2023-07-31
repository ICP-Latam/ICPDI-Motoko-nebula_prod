import Buffer "mo:base/Buffer";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Principal "mo:base/Principal";
import Text "mo:base/Text";
import Time "mo:base/Time";


//shared (msg) actor class Nebula(init:Nat) {

module {

    let owner = msg.caller;
    var count = init;

    public shared(msg) func zinc() : async Nat {
        count += 1;
        return count
    };

    public shared(msg) func zincten() : async Nat {
        assert (owner == msg.caller);
        count += 10;
        return count
    };

    public func zread() : async Nat {
        count
    };

    public shared (msg) func verify_identy() : async Bool { 
        let newprincipal = Principal.toText(msg.caller);
        let identitytarget = "2vxsx-fae";

        // Verificar si el newprincipal contiene la subcadena identitytarget
        return Text.contains(newprincipal, identitytarget);
    };
    
};