
``` mermaid

  graph TD
  S[User requests swap WETH to FirewallETH] --> D1[Malicious dApp crafts 7702 delegation and batch]
  D1 --> Set[Dapp adds ERC20 transfers from user to Firesale contract]
  Set --> Sim[Wallet simulates tx]
  Sim --> B1{Preview/Summary benign}
  B1 -->|Yes| Sign[User signs Authorization and calldata]
  Sign --> Pri[Tx sent via private RPC or mempool]
  Pri --> Mal[Dapp sends switch transaction]
  Mal --> Inc[Transaction order is chosen by Builder]
  Inc --> Trig{TOCTOU trigger met}
  Trig --> Flip[Firesale contract is set to drain]
  Flip --> Swp[Swap executes without returning user funds]
  Swp --> Blk[Block proposed and sealed]
  Blk --> Res[Post state multi asset drain]
  Trig -->|No| Benign[Execute swap only path]
  Benign --> Blk

```