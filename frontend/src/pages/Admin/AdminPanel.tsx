import { useEffect, useState } from 'react';
import { getSimulationConfig, updateSimulationConfig, runSimulation, getPlants, getAnomalies } from '../../services/api';

export default function AdminPanel() {
    const [config, setConfig] = useState({ active: false, baseConsumption: 100, variability: 15 });
    const [plants, setPlants] = useState([]);
    const [anomalies, setAnomalies] = useState([]);
    const [loading, setLoading] = useState(false);

    useEffect(() => { loadData(); }, []);
    const loadData = async () => {
        const cfg = await getSimulationConfig(); setConfig(cfg.data);
        const pl = await getPlants(); setPlants(pl.data);
        const anom = await getAnomalies(); setAnomalies(anom.data);
    };
    const handleSaveConfig = async () => { await updateSimulationConfig(config); alert('Guardado'); };
    const handleRunSimulation = async () => { setLoading(true); await runSimulation(); alert('SimulaciÃ³n ejecutada'); setLoading(false); };

    return (
        <div className="min-h-screen bg-slate-900 p-6">
            <h1 className="text-3xl font-bold text-white mb-6">Panel de AdministraciÃ³n</h1>
            <div className="bg-slate-800 rounded-2xl p-6 mb-6">
                <h2 className="text-xl text-white mb-4">ConfiguraciÃ³n simulaciÃ³n</h2>
                <label className="flex items-center gap-2 text-white mb-4"><input type="checkbox" checked={config.active} onChange={e => setConfig({...config, active: e.target.checked})} /> Activar</label>
                <div className="grid grid-cols-2 gap-4 mb-4">
                    <div><label className="text-slate-400">Consumo base (kW)</label><input type="number" className="w-full p-2 rounded bg-slate-700 text-white" value={config.baseConsumption} onChange={e => setConfig({...config, baseConsumption: +e.target.value})} /></div>
                    <div><label className="text-slate-400">Variabilidad (%)</label><input type="number" className="w-full p-2 rounded bg-slate-700 text-white" value={config.variability} onChange={e => setConfig({...config, variability: +e.target.value})} /></div>
                </div>
                <button onClick={handleSaveConfig} className="bg-blue-600 px-4 py-2 rounded text-white mr-2">Guardar</button>
                <button onClick={handleRunSimulation} className="bg-green-600 px-4 py-2 rounded text-white">Ejecutar simulaciÃ³n</button>
                {loading && <p className="text-yellow-400 mt-2">Generando...</p>}
            </div>
            <div className="bg-slate-800 rounded-2xl p-6">
                <h2 className="text-xl text-white mb-4">AnomalÃ­as detectadas</h2>
                {anomalies.length === 0 ? <p className="text-slate-400">No hay anomalÃ­as</p> : (
                    <table className="w-full text-white"><thead><tr><th>Fecha</th><th>Consumo real</th><th>Esperado</th><th>DesviaciÃ³n</th></tr></thead>
                    <tbody>{anomalies.map(a => <tr key={a.id}><td>{new Date(a.detectedAt).toLocaleString()}</td><td>{a.consumptionValue} kW</td><td>{a.expectedValue} kW</td><td>{a.deviationPercent}%</td></tr>)}</tbody></table>
                )}
            </div>
        </div>
    );
}
