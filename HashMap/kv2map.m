function m = kv2map(ks,vs)
m=java.util.HashMap();
n=length(ks);
for i=1:n
  k=ks{i};
  v=vs{i};
  ov=m.get(k);
  if ~isempty(ov) && ~isequal(v,ov) 
      error('inconsistent key-value pairs.');
  end
  m.put(k,v);
end
end