defmodule Explorer.Chain.ProxyContract do
  @moduledoc """
  The representation of a Proxied Smart Contract.

  "A contract in the sense of Solidity is a collection of code (its functions)
  and data (its state) that resides at a specific address on the Ethereum
  blockchain."
  http://solidity.readthedocs.io/en/v0.4.24/introduction-to-smart-contracts.html
  """

  require Logger

  use Explorer.Schema

  @typedoc """
  * `name` - the human-readable name of the smart contract.
  * `compiler_version` - the version of the Solidity compiler used to compile `contract_source_code` with `optimization`
    into `address` `t:Explorer.Chain.Address.t/0` `contract_code`.
  * `optimization` - whether optimizations were turned on when compiling `contract_source_code` into `address`
    `t:Explorer.Chain.Address.t/0` `contract_code`.
  * `contract_source_code` - the Solidity source code that was compiled by `compiler_version` with `optimization` to
    produce `address` `t:Explorer.Chain.Address.t/0` `contract_code`.
  * `abi` - The [JSON ABI specification](https://solidity.readthedocs.io/en/develop/abi-spec.html#json) for this
    contract.
  """

  @type t :: %Explorer.Chain.ProxyContract{
          proxy_address: String.t(),
          implementation_address: String.t()
        }

  schema "proxy_contracts" do
    field(:proxy_address, :string)
    field(:implementation_address, :string)

  end

  def changeset(%__MODULE__{} = proxy_contract, attrs) do
    proxy_contract
    |> cast(attrs, [
      :proxy_address,
      :implementation_address
    ])
    |> validate_required([:proxy_address, :implementation_address, :optimization, :contract_source_code, :abi, :address_hash])
  end

end
