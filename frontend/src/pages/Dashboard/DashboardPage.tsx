import { useState, useEffect } from 'react';
import { LineChart, Line, BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import { getPlants, getConsumptions, predict } from '../../services/api';

interface Plant { id: number; name: string; }
interface Consumption { timestamp: string; powerKw: number; temperatureC: number; }

export default function DashboardPage() {
  const [plants, setPlants] = useState<Plant[]>([]);
  const [selectedPlant, setSelectedPlant] = useState<Plant | null>(null);
  const [data, setData] = useState<Consumption[]>([]);
  const [prediction, setPrediction] = useState<number | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => { loadPlants(); }, []);
  useEffect(() => { if (selectedPlant) { loadData(); loadPrediction(); } }, [selectedPlant]);

  const loadPlants = async () => {
    const res = await getPlants();
    setPlants(res.data);
    if (res.data.length) setSelectedPlant(res.data[0]);
    setLoading(false);
  };
  const loadData = async () => {
    const to = new Date().toISOString();
    const from = new Date(Date.now() - 7*86400000).toISOString();
    const res = await getConsumptions(selectedPlant!.id, from, to);
    setData(res.data);
  };
  const loadPrediction = async () => {
    const tomorrow = new Date(Date.now() + 86400000).toISOString();
    const res = await predict(selectedPlant!.id, tomorrow);
    setPrediction(res.data.predictedKw);
  };

  if (loading) return <div className="flex justify-center items-center h-screen">Cargando...</div>;

  const chartData = data.map(c => ({ date: new Date(c.timestamp).toLocaleDateString(), consumo: c.powerKw, temp: c.temperatureC }));
  const avg = data.reduce((a,b) => a + b.powerKw, 0) / data.length || 0;
  const total = data.reduce((a,b) => a + b.powerKw, 0);
  const eco = Math.round(85 - (avg / 250) * 20);

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-900 to-slate-800 p-6">
      {/* Header */}
      <div className="flex justify-between items-center mb-8">
        <div>
          <h1 className="text-3xl font-bold text-white flex items-center gap-2">⚡ G-ENNOM <span className="text-sm bg-emerald-500 px-2 py-0.5 rounded-full">LIVE</span></h1>
          <p className="text-slate-400">Optimización energética con IA</p>
        </div>
        <select className="bg-slate-700 text-white px-4 py-2 rounded-xl" value={selectedPlant?.id} onChange={e => setSelectedPlant(plants.find(p => p.id === +e.target.value)!) }>
          {plants.map(p => <option key={p.id} value={p.id}>{p.name}</option>)}
        </select>
      </div>

      {/* Tarjetas */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div className="bg-gradient-to-r from-blue-600 to-blue-700 rounded-2xl p-6 shadow-xl">
          <div className="flex justify-between"><span className="text-blue-100">Consumo promedio</span><span className="text-2xl">📊</span></div>
          <div className="text-3xl font-bold text-white mt-2">{avg.toFixed(1)} kW</div>
          <div className="text-blue-200 text-sm mt-2">vs ayer: +2.1% ▲</div>
        </div>
        <div className="bg-gradient-to-r from-purple-600 to-purple-700 rounded-2xl p-6 shadow-xl">
          <div className="flex justify-between"><span className="text-purple-100">Total período</span><span className="text-2xl">🔋</span></div>
          <div className="text-3xl font-bold text-white mt-2">{total.toFixed(0)} kWh</div>
          <div className="text-purple-200 text-sm mt-2">últimos 7 días</div>
        </div>
        <div className="bg-gradient-to-r from-emerald-600 to-emerald-700 rounded-2xl p-6 shadow-xl">
          <div className="flex justify-between"><span className="text-emerald-100">Predicción IA</span><span className="text-2xl">🤖</span></div>
          <div className="text-3xl font-bold text-white mt-2">{prediction ? prediction.toFixed(1) : '--'} kW</div>
          <div className="text-emerald-200 text-sm mt-2">para mañana</div>
        </div>
      </div>

      {/* Gráfico línea */}
      <div className="bg-slate-800/50 rounded-2xl p-6 backdrop-blur-sm mb-6">
        <h2 className="text-xl font-semibold text-white mb-4">📈 Consumo histórico vs Temperatura</h2>
        <ResponsiveContainer width="100%" height={300}>
          <LineChart data={chartData}>
            <CartesianGrid strokeDasharray="3 3" stroke="#334155" />
            <XAxis dataKey="date" stroke="#94a3b8" />
            <YAxis stroke="#94a3b8" />
            <Tooltip contentStyle={{ backgroundColor: '#1e293b', border: 'none' }} />
            <Legend />
            <Line type="monotone" dataKey="consumo" stroke="#3b82f6" name="Consumo (kW)" strokeWidth={2} />
            <Line type="monotone" dataKey="temp" stroke="#f59e0b" name="Temperatura (°C)" />
          </LineChart>
        </ResponsiveContainer>
      </div>

      {/* Gráfico barras + Eco Score */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div className="md:col-span-2 bg-slate-800/50 rounded-2xl p-6">
          <h2 className="text-xl font-semibold text-white mb-4">📊 Consumo por día</h2>
          <ResponsiveContainer width="100%" height={250}>
            <BarChart data={chartData}>
              <CartesianGrid strokeDasharray="3 3" stroke="#334155" />
              <XAxis dataKey="date" stroke="#94a3b8" />
              <YAxis stroke="#94a3b8" />
              <Tooltip />
              <Bar dataKey="consumo" fill="#10b981" name="kWh" />
            </BarChart>
          </ResponsiveContainer>
        </div>
        <div className="bg-gradient-to-br from-slate-800 to-slate-900 rounded-2xl p-6 flex flex-col justify-center items-center">
          <div className="text-6xl mb-2">🌱</div>
          <div className="text-3xl font-bold text-white">{eco} / 100</div>
          <div className="text-slate-400 text-sm mt-1">Eco Score</div>
          <div className="w-full bg-slate-700 rounded-full h-2 mt-4">
            <div className="bg-emerald-500 h-2 rounded-full" style={{ width: `${eco}%` }}></div>
          </div>
          <p className="text-emerald-400 text-xs mt-4">Reducción de CO₂: ~18%</p>
        </div>
      </div>
    </div>
  );
}