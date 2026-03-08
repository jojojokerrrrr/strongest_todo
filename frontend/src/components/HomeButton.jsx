import { useNavigate } from "react-router-dom";

export default function Home() {
  const navigate = useNavigate();
  return (
    <>
      <button className="btn btn-primary btn-ghost w-full" onClick={() => navigate("/tasks")}>ホーム</button>
    </>
  );
}

