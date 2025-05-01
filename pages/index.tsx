'use client'

import Link from "next/link";
import { useState, useEffect } from "react";
import { Configuration, BooksApiFp } from '../js-client';
import axios from 'axios';

interface BookType {
    id: number;
    title: string;
    author: string;
}

export default function Home() {
  const [books, setBooks] = useState<BookType[]>([])
    const BlankError = { type: '', error_message: '' }
    const [counter, setCounter] = useState(0)
    const [title, setTitle] = useState<string>('')
    const [author, setAuthor] = useState<string>('')
    const [error, setError] = useState(BlankError)

    const config = new Configuration({
        basePath: 'http://localhost:3000', // Replace with your actual API URL
    });
    const booksApi = BooksApiFp(config);

    const createBooks = async () => {
        const response = await fetch('http://localhost:3000/api/books', {
            method: 'POST',
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify({
                title: title,
                author: author
            })
        })

        return await response.json();
    }

    const getBooks = async () => {
        // const response = await fetch('http://localhost:3000/api/books', { method: 'GET' })

        const request = await booksApi.books();
        const response = await request(axios);

        // const data = await response.json()
        // setBooks(response.data)
        console.log('asdasd')
        console.log(response.data)
    }

    const handleClick =() => {
        setCounter(counter + 1)
    }

    useEffect(() => {
        getBooks()
  }, [counter])

  return (
    <section>
        <Link href={'/'}>back to home page</Link>
        <br></br>
        <button onClick={handleClick}>Click me {counter}</button>
        <br></br>
        <Link href={'/books'}>books</Link>

        
        {books?.length > 0 ? (
            books.map((book: BookType) => (
                <article key={ book.id }>
                    <p>ID: {book.id}</p>
                    <h2>title: {book.title}</h2>
                    <p>author: {book.author}</p>
                    <br></br>
                </article>
            ))
        ) : (
            <p>No posts available.</p>
        )}

        <section className="right-96 fixed top-10">
            <input className={`block mb-3 border-spacing-1 text-black ${error.type == 'title' ? "text-red-400 border-red-500 border-4": ""}`}
                name="title"
                onChange={(e) => {
                    setTitle(e.target.value)
                    setError(BlankError)
                }}
                value={title}
                type="text"
                placeholder="fill in title"
            />
            <input className={`block mb-3 border-spacing-1 text-black ${error.type == 'author' ? "text-red-400 border-red-500 border-4": ""}`}
                name="author"
                onChange={(e) => {
                    setAuthor(e.target.value)
                    setError(BlankError)
                }}
                value={author}
                type="text"
                placeholder="fill in author"
            />
            <input
                className="block border-spacing-1 bg-blend-color-burn align-middle w-auto via-red-600 hover:scale-y-90 hover:scale-x-75 bg-slate-400 rounded-full text-center w-50"
                type="submit"
                value={'Create'}
                onClick={(e) => {
                    // eslint-disable-next-line @typescript-eslint/no-unused-expressions
                    e.preventDefault;
                    createBooks().then((response) => {
                        if (response?.error_message) {
                            setError(response)
                        } else {
                            // setTitle('')
                            // setAuthor('')
                            // getBooks()
                        }
                        
                    })
                }}
            />
        </section>
    </section>
  );
}
