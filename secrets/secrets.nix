let
  kandread-amd = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFTqwBQYrzkMON3F/Q76F78lLHEP2zGCywgJyTbN2Krr";
  kandread-thin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDWTSfxDIoCVIN9uVJ0or2zOLL6m7CWsxN3wABR5xjh4";
  users = [ kandread-amd kandread-thin ];
in
{
  "umass.age".publicKeys = users;
}
