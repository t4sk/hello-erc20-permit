const { expect } = require("chai")
const { ethers } = require("hardhat")

describe("VerifySignature", function () {
  it("Check signature", async function () {
    const accounts = await ethers.getSigners(2)

    const VerifySignature = await ethers.getContractFactory("VerifySignature")
    const contract = await VerifySignature.deploy()
    await contract.deployed()

    // const PRIV_KEY = "0x..."
    // const signer = new ethers.Wallet(PRIV_KEY)
    const { chainId } = await ethers.provider.getNetwork();

    const signer = accounts[0]
    const to = accounts[1].address
    const amount = 999
    const message = "Hello"
    const nonce = 123

    const hash = await contract.getMessageHash(to, amount, message, nonce, chainId)
    const sig = await signer.signMessage(ethers.utils.arrayify(hash))

    const ethHash = await contract.getEthSignedMessageHash(hash)

    console.log("signer          ", signer.address)
    console.log("recovered signer", await contract.recoverSigner(ethHash, sig))

    // Correct signature and message returns true
    expect(
      await contract.verify(signer.address, to, amount, message, nonce, chainId, sig)
    ).to.equal(true)

    // Incorrect message returns false
    expect(
      await contract.verify(signer.address, to, amount + 1, message, nonce, chainId, sig)
    ).to.equal(false)

    // Incorrect chain id revertedWith ChainId Incorrect
    await expect(
      contract.verify(signer.address, to, amount, message, nonce, chainId + 1, sig)
    ).to.be.revertedWith("ChainId Incorrect")
  })
})
