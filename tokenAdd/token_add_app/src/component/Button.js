import React from "react";
import { Button, Card, Nav } from 'react-bootstrap';
import "bootstrap/dist/css/bootstrap.min.css";

async function tokenAdd()
{
    alert('btn clicked');

    const tokenAddress = '0xd3cDcF5A9fDC569Df326FCd11e35991D2f22c540';
    const tokenSymbol = 'DDMT2';
    const tokenDecimals = 18;
    const tokenImage_01 = 'https://polygirls2023.s3.ap-northeast-2.amazonaws.com/test/DDM_01.png';
    const tokenImage_02 = 'https://polygirls2023.s3.ap-northeast-2.amazonaws.com/test/DDM_02.png';

    try 
    {
        // wasAdded is a boolean. Like any RPC method, an error can be thrown.
        const wasAdded = await window.ethereum.request(
        {
            method: 'wallet_watchAsset',
            params: 
            {
                type: 'ERC20', // Initially only supports ERC-20 tokens, but eventually more!
                options: 
                {
                    address: tokenAddress, // The address of the token.
                    symbol: tokenSymbol, // A ticker symbol or shorthand, up to 5 characters.
                    decimals: tokenDecimals, // The number of decimals in the token.
                    image: tokenImage_02, // A string URL of the token logo.
                },
            },
        });

        if (wasAdded) 
        {
            console.log('Thanks for your interest!');
        } 
        else 
        {
            console.log('Your loss!');
        }
    } 
    catch (error) 
    {
        console.log(error);
    }
}

function B_Button()
{
    return (
        <div>
            <Button variant="success" onClick={tokenAdd}>Token Add</Button>

            {/* 
            <Button variant="primary">Secondary</Button>
            <Button variant="secondary">Secondary</Button>
            <Button variant="success">Success</Button>
            <Button variant="warning">Warning</Button>
            <Button variant="danger">Danger</Button>
            <Button variant="info">Info</Button>
            <Button variant="light">Light</Button>
            <Button variant="dark">Dark</Button>
            <Button variant="link">Link</Button> */}
        </div>
    );
}

export default B_Button;