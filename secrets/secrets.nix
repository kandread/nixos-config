let
  kandread-amd = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFTqwBQYrzkMON3F/Q76F78lLHEP2zGCywgJyTbN2Krr";
  kandread-thin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDWTSfxDIoCVIN9uVJ0or2zOLL6m7CWsxN3wABR5xjh4";
  kandread-theli = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJR845DlRwHJcCrHPHZIptWDBhlmTxxNEjF72S1imAHr";
  theli = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICd1aBNsi53jMCy0a9rv+VlS0Ymr6TPM3+MRJj4wMncr";
  users = [ kandread-amd kandread-thin kandread-theli ];
  systems = [ theli ];
in
{
  "umass.age".publicKeys = users ++ systems;
}
