{
  description = ''Basic wrapper for WebGL.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-webgl-master.flake = false;
  inputs.src-webgl-master.owner = "stisa";
  inputs.src-webgl-master.ref   = "master";
  inputs.src-webgl-master.repo  = "webgl";
  inputs.src-webgl-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-webgl-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-webgl-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}