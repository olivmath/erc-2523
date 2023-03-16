import React, { useState, useCallback } from 'react';
import { ethers, Contract } from 'ethers';
import './App.css';

const abi = [
    {
        "inputs": [
            {
                "internalType": "bool",
                "name": "initvalue",
                "type": "bool"
            }
        ],
        "stateMutability": "nonpayable",
        "type": "constructor"
    },
    {
        "inputs": [],
        "name": "flip",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "get",
        "outputs": [
            {
                "internalType": "bool",
                "name": "",
                "type": "bool"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    }
];
const contractAddress = '0x5fbdb2315678afecb367f032d93f642f64180aa3';

function App() {
    let [wallet, setWallet] = useState("Connect Wallet");
    let [value, setValue] = useState(true);
    let [provider, setProvider] = useState(null);
    let [signer, setSigner] = useState(null);
    let [contract, setContract] = useState(null);


    const connectWallet = useCallback(async () => {
        if (window.ethereum == null) {

            // If MetaMask is not installed, we use the default provider,
            // which is backed by a variety of third-party services (such
            // as INFURA). They do not have private keys installed so are
            // only have read-only access
            console.log("MetaMask not installed; using read-only defaults")
            provider = ethers.getDefaultProvider()

        } else {

            // Connect to the MetaMask EIP-1193 object. This is a standard
            // protocol that allows Ethers access to make all read-only
            // requests through MetaMask.
            provider = new ethers.BrowserProvider(window.ethereum)

            // It also provides an opportunity to request access to write
            // operations, which will be performed by the private key
            // that MetaMask manages for the user.
            signer = await provider.getSigner();


            contract = new Contract(contractAddress, abi, signer)
            const currentValue = await contract.get();

            setWallet(signer.address)
            setProvider(provider)
            setContract(contract)
            setSigner(signer)
            setValue(currentValue);
        }
    }, []);

    const flipValue = useCallback(async () => {
        if (!contract) return;

        const tx = await contract.flip();
        console.log("⏳ pending transaction...", tx.hash)
        let counter = 1;
        const intervalId = setInterval(() => {
            console.log(`⏰ await transaction ${counter}s`);
            counter++;
        }, 1000);
        await tx.wait();
        clearInterval(intervalId); // Cancela o setInterval quando a transação for concluída
        console.log("✅ complete transaction", tx.hash)

        const currentValue = await contract.get();
        setValue(currentValue);
    }, [contract]);

    // Initialize Ethers only once when the component is mounted
    // React.useEffect(() => {
    //     initEthers();
    // }, [initEthers]);
    return (
        <div className="App">
            <h1>Flipper Smart Contract</h1>
            <button onClick={connectWallet}>{wallet}</button>
            <p>Current value: {value ? 'true' : 'false'}</p>
            <button onClick={flipValue}>Flip Value</button>
        </div>
    );
}

export default App;
