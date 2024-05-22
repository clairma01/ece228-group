% Use to extract bounding box info from the provided .mat files and store
% it in .csv
% Change paths to folder as necessary

% right now, only going through folders in (camera folder?) 1, since it has
% data from the full 14 days
folderpath = 'D:\Edited\1\';

% hide pop up visualizer
set(groot,'defaultFigureVisible','off')
% iterate over folders by day
D = dir(strcat(folderpath,'*Edited*'));
for k = 1:length(D)
    subfolder = D(k).name;
    subfolderpath = strcat(folderpath,subfolder,'\');
    SD = dir(strcat(subfolderpath,"*.mat"));

    % iterate over individual .mat files in each folder
    for i = 1:length(SD)
        fname = SD(i).name;
        filepath = strcat(subfolderpath,fname);
        s = load(filepath).DATA;
        if ~isfield(s,'XXc')
            continue
        end

        XXc = s.XXc.';
        YYc = s.YYc.';
        XX1 = s.XX1.';
        YY1 = s.YY1.';
        XX2 = s.XX2.';
        YY2 = s.YY2.';
        WIDTH = s.rect_WIDTH.';
        HEIGHT = s.rect_HEIGHT.';
        newtable = table(XXc,YYc,XX1,YY1,XX2,YY2,WIDTH,HEIGHT);
        csvname = extractBefore(s.FILENAME,'.');
        csvpath = strcat(subfolderpath,csvname,'.csv')
        writetable(newtable, csvpath);
    end
end