import { create } from 'zustand';

interface EnergyState {
  currentKw: number;
  setCurrentKw: (kw: number) => void;
}

export const useEnergyStore = create<EnergyState>((set) => ({
  currentKw: 0,
  setCurrentKw: (kw) => set({ currentKw: kw }),
}));