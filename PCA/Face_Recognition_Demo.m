clear
close all

load FaceData

%% finding the cloest face to FindFace using top N1 components
N1 = 20;
FindFace = 2; 


for whichFace = 1:48
ID{whichFace} = sprintf('person %d',ceil(whichFace/3));

numFaceSamples = size(faces, 2); % Get number of columns in data set, this is the number of samples
meanFace = mean(faces, 2); % Calculate the mean of the data set, 3600x1 (60x60 image)
A = faces - repmat(meanFace, 1, numFaceSamples); % Subtract the mean from every point to center the data set
[V, D] = eig(A'* A); % Get the eigenvectors and eigenvalues of A'A
[Vf, Df] = eigsort(V, D); % Sort them
U = A*Vf; % Use the math trick to get the eigenvectors of AA'

for i = 1:numFaceSamples
    normU(:,i) = U(:,i)/norm(U(:,i)); %Ensure that the eigenvectors are unit length
end
c = normU' * A(:, whichFace); % Project the centered whichFace face onto the eigenvector axes
c_t(whichFace,:)=c';
end


for i = 1:48 
    fd(i)=pdist2(c_t(FindFace,1:N1),c_t(i,1:N1));
end

[~, sortFd]=sort(fd);

figure(100);
% keyboard
subplot(1,2,1);
viewcolumn(faces(:, FindFace)); % Visualize whichFace face
set(gca,'fontsize',20);
title(sprintf('Find face %d',FindFace));

subplot(1,2,2);
viewcolumn(faces(:, sortFd(1))); % Visualize whichFace face
set(gca,'fontsize',20);
title(ID{sortFd(1)});

figure(10);
subplot(2,3,1);
viewcolumn(faces(:, FindFace)); % Visualize whichFace face
set(gca,'fontsize',20);
title(sprintf('Find face %d',FindFace));

subplot(2,3,2);
viewcolumn(faces(:, sortFd(1))); % Reconstruct whichFace using all of its coordinates in PCA space
set(gca,'fontsize',20);
title(sprintf('1st Cloest Face %d',sortFd(1)));

subplot(2,3,3);
viewcolumn(faces(:, sortFd(2))); % Reconstruct whichFace using all of its coordinates in PCA space
set(gca,'fontsize',20);
title(sprintf('2nd Cloest Face %d',sortFd(2)));

subplot(2,3,4);
viewcolumn(faces(:, sortFd(3))); % Reconstruct whichFace using all of its coordinates in PCA space
set(gca,'fontsize',20);
title(sprintf('3rd Cloest Face %d',sortFd(3)));

subplot(2,3,5);
viewcolumn(faces(:, sortFd(4))); % Reconstruct whichFace using all of its coordinates in PCA space
set(gca,'fontsize',20);
title(sprintf('4th Cloest Face %d',sortFd(4)));

subplot(2,3,6);
viewcolumn(faces(:, sortFd(5))); % Reconstruct whichFace using all of its coordinates in PCA space
set(gca,'fontsize',20);
title(sprintf('5th Cloest Face %d',sortFd(5)));
