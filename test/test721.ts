import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers"
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs"
import { expect } from "chai"
import { ethers } from "hardhat"
import { Signer } from "ethers"
import { Contract } from "ethers"
import hre from 'hardhat' 

import { MerkleTree} from 'merkletreejs';
import keccak256 from 'keccak256';
import { extendConfig } from "hardhat/config"



describe("Test of ERC721", function () {

  describe("Deployment", function () {

    beforeEach(async function () {
      this.ContractV1 = await hre.ethers.getContractFactory('EPASSVer1')
      this.ContractV2 = await hre.ethers.getContractFactory('EPASSVer2')
    })

    it("address check", async function () {



    })



  })

  




})
