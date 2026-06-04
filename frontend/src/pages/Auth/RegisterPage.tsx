import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { register } from '../../services/api';

export default function RegisterPage() {
    const [form, setForm] = useState({ username: '', password: '', email: '', companyName: '' });
    const navigate = useNavigate();

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        try {
            const res = await register(form);
            localStorage.setItem('token', res.data.token);
            localStorage.setItem('role', res.data.role);
            navigate('/dashboard');
        } catch (err) {
            alert('Error al registrar');
        }
    };

    return (
        <div className="min-h-screen bg-gradient-to-br from-slate-900 to-slate-800 flex items-center justify-center">
            <form onSubmit={handleSubmit} className="bg-slate-800 p-8 rounded-2xl shadow-xl w-96">
                <h1 className="text-3xl font-bold text-white mb-6">Registro Empresa</h1>
                <input type="text" placeholder="Usuario" className="w-full p-3 rounded bg-slate-700 text-white mb-4" onChange={e => setForm({...form, username: e.target.value})} />
                <input type="password" placeholder="ContraseÃ±a" className="w-full p-3 rounded bg-slate-700 text-white mb-4" onChange={e => setForm({...form, password: e.target.value})} />
                <input type="email" placeholder="Email" className="w-full p-3 rounded bg-slate-700 text-white mb-4" onChange={e => setForm({...form, email: e.target.value})} />
                <input type="text" placeholder="Nombre de empresa" className="w-full p-3 rounded bg-slate-700 text-white mb-6" onChange={e => setForm({...form, companyName: e.target.value})} />
                <button type="submit" className="w-full bg-green-600 py-3 rounded-xl text-white font-bold">Registrar</button>
            </form>
        </div>
    );
}
