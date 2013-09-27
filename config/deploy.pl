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

role development => ['localhost'], {
};

task deploy  => {
    update => sub {
        my ($host, @args) = @_;
        my $deploy_from = get('deploy_from');
        my $deploy_to = get('deploy_to');
        my $branch   = 'origin/' . get('branch');
        remote {
            run "cd $deploy_to && git pull && ~/perl5/perlbrew/perls/perl-5.16.2/bin/riji publish";
        } $host;
    },
    push => sub {
        run "git add * && git commit -m \"\" && git push origin master"
    },
};
