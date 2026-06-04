import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { login } from '../../services/api';

export default function LoginPage() {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const navigate = useNavigate();

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        try {
            const res = await login(username, password);
            localStorage.setItem('token', res.data.token);
            localStorage.setItem('role', res.data.role);
            navigate('/dashboard');
        } catch (err) {
            alert('Credenciales invÃ¡lidas');
        }
    };

    return (
        <div className="min-h-screen bg-gradient-to-br from-slate-900 to-slate-800 flex items-center justify-center">
            <form onSubmit={handleSubmit} className="bg-slate-800 p-8 rounded-2xl shadow-xl w-96">
                <h1 className="text-3xl font-bold text-white mb-6">G-ENNOM</h1>
                <input type="text" placeholder="Usuario" className="w-full p-3 rounded bg-slate-700 text-white mb-4" value={username} onChange={e => setUsername(e.target.value)} />
                <input type="password" placeholder="ContraseÃ±a" className="w-full p-3 rounded bg-slate-700 text-white mb-6" value={password} onChange={e => setPassword(e.target.value)} />
                <button type="submit" className="w-full bg-blue-600 py-3 rounded-xl text-white font-bold">Ingresar</button>
                <p className="text-center text-slate-400 mt-4">Demo: admin / admin123</p>
            </form>
        </div>
    );
}
