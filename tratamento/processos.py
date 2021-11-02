from tratamento import kepler_spline
import numpy as np
from tratamento import util
from tratamento import binning

# Funções para o tratamento das curvas de luz
def processar_curva_luz(tempo_total, fluxo_total):
    tempo_total, fluxo_total = util.split(tempo_total, fluxo_total, gap_width=0.75)
    spline = kepler_spline.fit_kepler_spline(tempo_total, fluxo_total, verbose=False)[0]

    tempo = np.concatenate(tempo_total)
    fluxo = np.concatenate(fluxo_total)
    spline = np.concatenate(spline)

    finite_i = np.isfinite(spline)
    if not np.all(finite_i):
        tempo = tempo[finite_i]
        fluxo = fluxo[finite_i]
        spline = spline[finite_i]

    # "Achata" a curva de luz (remove variabilidades de curta frequência)
    # dividindo-a pelo spline
    fluxo /= spline
    
    return tempo, fluxo

def phase_fold_and_sort_light_curve(time, values, period, t0):
    time = util.phase_fold_time(time, period, t0)
    
    sorted_i = np.argsort(time)
    time = time[sorted_i]
    values = values[sorted_i]
    
    return time, values

def generate_view(time,
                 values,
                 num_bins,
                 bin_width,
                 t_min,
                 t_max,
                 normalize=True):
    view, bin_counts = binning.bin_and_aggregate(time, values, num_bins,
                                                bin_width, t_min, t_max)
    
    view = np.where(bin_counts > 0, view, np.median(values))
    
    if normalize:
        view -= np.median(view, axis = 0)
        view /= np.abs(np.min(view, axis=0))
        
    return view

def global_view(time, values, period, num_bins=2001, bin_width_factor=1/2001):
    return generate_view(
    time,
    values,
    num_bins = num_bins,
    bin_width = period * bin_width_factor,
    t_min = -period/2,
    t_max = period/2)

def local_view(time, values, period, duration, num_bins = 201, bin_width_factor = 0.16, num_durations = 4):
    return generate_view(
    time,
    values,
    num_bins = num_bins,
    bin_width = duration * bin_width_factor,
    t_min = max(-period/2, -duration * num_durations),
    t_max = min(period/2, duration * num_durations))

def generate_example_for_tce(tce, time, values, period, t0):
    period = tce["tce_period"]
    duration = tce["tce_duration"]
    t0 = tce["tce_time0bk"]
    
    time, flux = phase_fold_and_sort_light_curve(time, values, period, t0)
    
    g_view = global_view(time, flux, period)
    l_view = local_view(time, flux, period, duration)

def print_percent_done(index, total, kic, bar_len=25, title='Processando'):
    '''
    index is expected to be 0 based index. 
    0 <= index < total
    '''

    title = "Processando KIC {}".format(kic)

    percent_done = (index)/total*100
    percent_done = round(percent_done, 1)

    done = round(percent_done/(100/bar_len))
    togo = bar_len-done

    done_str = '█'*int(done)
    togo_str = '░'*int(togo)
    
    t_estim = (total-index)/4

    #print(f'\t⏳{title}: [{done_str}{togo_str}] {percent_done}% concluído. Tempo Estimado: {t_estim}', end='\r')
    
    print('\t⏳{}: [{}{}] {}% concluído. Tempo estimado: {:.2f} min.'.format(title,
                                                                   done_str,
                                                                   togo_str,
                                                                   percent_done,
                                                                   t_estim), end = '\r')
    
    if round(percent_done) == 100:
        print('\t✅')

