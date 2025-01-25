interface PostType {
    id: number;
    title: string;
    body: string;
}

export default async function Posts() {
    const data = await fetch('http://127.0.0.1:4000/api/posts')
    const posts = await data.json()

    return (
        <section>
            <h1>Posts</h1>
            {posts.data.length > 0 ? (
                posts.data.map((post: PostType) => (
                    <article key={ post.id }>
                        <h2>{post.title}</h2>
                        <p>{post.body}</p>
                    </article>
                ))
            ) : (
                <p>No posts available.</p>
            )}
        </section>
    )
}
