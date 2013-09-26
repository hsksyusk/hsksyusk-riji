# config/deploy.pl
use strict;
use warnings;
use Cinnamon::DSL;

set application => 'hsksyusk-riji';
set repository  => 'git@github.com:hsksyusk/hsksyusk-riji.git';
set user        => 'hsksyusk';
set password    => '';

role production => ['topecongiro.com'], {
    deploy_from => '/home/hosokoshi/dev/myriji/',
    deploy_to   => '/home/hsksyusk/dev/hsksyusk-riji/',
    branch      => 'master',
};

task deploy  => {
    update => sub {
        my ($host, @args) = @_;
        my $deploy_from = get('deploy_from');
        my $deploy_to = get('deploy_to');
        my $branch   = 'origin/' . get('branch');
        run "cd $deploy_from";
        run "/usr/bin/git add *";
        run "/usr/bin/git commit -m 'deploy new entry'";
        run "/usr/bin/git push origin master";
        uremote {
            run "cd $deploy_to && git pull && ~/perl5/perlbrew/perls/perl-5.16.2/bin/riji publish";
        } $host;
    },
};
