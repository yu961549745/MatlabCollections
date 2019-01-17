function s = excelcol(n)
assert(all(n(:)>0),'input must be positive');
s=arrayfun(@(x){mex_excel_col(x)},n);
if isscalar(n)
    s=s{:};
end
end