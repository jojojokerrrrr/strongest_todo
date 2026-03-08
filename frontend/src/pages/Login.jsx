import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { api } from "../utils/api";

export default function Login() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const response = await api.post("/sessions", {session:{email: email, password: password}});
      const token = response.data.token
      localStorage.setItem("token", token)
      navigate("/tasks");
    } catch (error) {
      console.error(error);
      alert("ログインに失敗しました");
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-base-100">
      <form onSubmit={handleSubmit}>
        <fieldset className="fieldset bg-base-200 border-base-300 rounded-box w-xs border p-4">
          <legend className="fieldset-legend">Login</legend>

          <label className="label">Email</label>
          <input type="email" className="input" placeholder="Email" value={email} onChange={(e)=>setEmail(e.target.value)} />

          <label className="label">Password</label>
          <input type="password" className="input" placeholder="Password" value={password} onChange={(e)=>setPassword(e.target.value)} />

          <button className="btn btn-neutral mt-4" type="submit">Login</button>
        </fieldset>
      </form>
    </div>
  
  )
}