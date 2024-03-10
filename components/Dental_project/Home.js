import React from 'react'
import './Home.css'
import { Link } from 'react-router-dom'
import bg from './bg.img.jpg'
import About from './About'

function Home() {
    return (
        <>
        <div className='container'>

            <div className='content'>
                <h3>"Restoring smiles, Restoring confidence"</h3><br/>
                <p> Where beauty, Health,and confidence converge.</p><br/>
                <ul>
                </ul>
                
            </div>


        </div>
        <About/>
    
        </>


    )
}

export default Home
