function []=visualize_feature_maps(net,blob_name,space)
%space 为 特征图之间的间距
blob=net.blobs(blob_name).get_data();
blob_width=max(size(blob,1),size(blob,2));
ceil_width=blob_width+space;
channels=size(blob,3);
ceil_num=ceil(sqrt(channels));%每行或每列特征图个数
Map=zeros(ceil_width*ceil_num,ceil_width*ceil_num);
for u=1:ceil_num
    for v=1:ceil_num
        w=zeros(blob_width,blob_width);
        if(((u-1)*ceil_num+v)<=channels)
            w=blob(:,:,(u-1)*ceil_num+v,1)';
            w=w-min(min(w));%保证为非负数
            w=w/max(max(w))*255;%归一化
        end
        Map(ceil_width*(u-1)+(1:blob_width),ceil_width*(v-1)+(1:blob_width))=w;
    end
end
Map=uint8(Map);
figure();
imshow(Map);
colormap(jet);caxis([0 255]);%伪彩色显示
colorbar;
title(blob_name);