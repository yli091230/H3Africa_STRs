
stutter='../stutter/stutter_b1b2_final.txt'
stutt_dict={}
def_stutter=['0.9', '0.05', '0.05']
with open(stutter, 'r') as f0:
    for line in f0:
        recs = line.strip().split('\t')
        if len(recs) > 6:
            stutt_dict[recs[0] + ':' + str(int(recs[1]) + 1)] = [recs[3], recs[4], recs[5]]
        else:
            print line

print 'step 2'
with open('hg38_info_full.bed', 'w') as fo:
    fo.write('\t'.join(['chrom', 'start', 'end', 'thresh', 'stutter_p', 'stutter_down', 'stutter_up']) + '\n')
    with open('hg38_supp_threshinfo.bed', 'r') as f1:
        l = f1.readline()
        for line in f1:
            recs = line.strip().split('\t')
            key = recs[0] + ':' + recs[1]
            if key in stutt_dict:
                out_line = '\t'.join(recs + stutt_dict[key]) + '\n'
            else:
                out_line = '\t'.join(recs + def_stutter) + '\n'
            fo.write(out_line)

