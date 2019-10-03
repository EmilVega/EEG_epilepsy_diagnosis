function cell2latextable(table,path,name)

if ~exist('path','var')
    path = pwd;
end

if ~exist('name','var')
    name = 'table';
end

path = [path '\' name '.tex'];
fid   = fopen(path,'w');
[n,m] = size(table);
fprintf(fid,'\\begin{tabular}{|');
for j = 1:m
    fprintf(fid,'c|');
end
fprintf(fid,'}');

fprintf(fid,'\n \\hline \n');
 for i = 1:n
     for j = 1:m
         if j ~=m
            if ischar(table{i,j})
                 fprintf(fid,'%s & ',table{i,j});
            else 
                 fprintf(fid,'%g & ',table{i,j});
            end
         else
            if ischar(table{i,j})
                 fprintf(fid,'%s \\\\ \n ',table{i,j});
            else 
                 fprintf(fid,'%g \\\\ \n ',table{i,j});
            end
         end
     end
     fprintf(fid,'\\hline \n');
 end
 fprintf(fid,'\\end{tabular}');
 fclose(fid);
 