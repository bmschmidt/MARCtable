from pymarc import MARCReader
import pyarrow as pa

def parse_value(name, record):
    if not name[0].isnumeric():
        return getattr(record, name)()
    value = []
    if not name[-1].isnumeric():
        field, subfield = name.split("$")
        fields = record.get_fields(field)
        for field in fields:
            value.append(field.get_subfields(subfield)[0])
    else:
        for field in record.get_fields(name):
            v = {}
            try:
                subs = field.subfields
            except AttributeError:
                # If it has no subfields, append the whole thing
                value.append(field.value())
                continue
            for i in range(0, len(subs), 2):
                v[subs[i]] = subs[i+1]
            value.append(v)
    return value

def parse_file(path, fields = ["title", "650$a", "008"], n_max = 100):
    holder = {k: [] for k in fields}
    with open(path, 'rb') as fh:
        reader = MARCReader(fh)
        vals = []
        for i, record in enumerate(reader):
            for field in fields:
                holder[field].append(parse_value(field, record))
            if i > n_max:
                break
    for k, values in holder.items():
        all_same_length = True
        for val in values:
            if val is None or len(val) != 1:
                all_same_length = False
                continue
        if (all_same_length):
            holder[k] = [v[0] for v in values]
    tab = pa.table(holder)
    return tab
