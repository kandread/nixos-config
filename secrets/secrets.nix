let
  kandread-amd = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFTqwBQYrzkMON3F/Q76F78lLHEP2zGCywgJyTbN2Krr";
  kandread-thin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDu+OCI7tXho10We9ADP06sC5Z1G9/TrG9lXOw84NnW3";
  users = [ kandread-amd kandread-thin ];
in
{
  "umass.age".publicKeys = users;
}
