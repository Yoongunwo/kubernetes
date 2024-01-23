# elrepo란
# Enterprise Linux 용 커뮤니티 기반 저장소이며, RHEL(RedHat Enterprise Linux) 및 이를 기반으로 꾸며진 기타
# 배포판들 (Federa, CentOS, Scientific Linux)을 위한 커널 모듈, 파일 시스템, 도구, 라이브러리, 애플리케이션
# 을 제공한다.

yum update -y
yum install yum-plugin-fastestmirror -y

# GPG-KEY란
# GNU Privacy Guard-KEY의 약자로 배포되고 있는 패키지가 안전한 패키지가 맞는지 확인하는 일종의 인증키임
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
yum install https://www.elrepo.org/elrepo-release-7.el7.elrepo.noarch.rpm -y

yum repolist 

yum --enablerepo=elrepo-kernel install kernel-ml kernel-ml-devel -y

# 부팅 가능한 커널 확인
grep ^menuentry /boot/grub2/grub.cfg | cut -d "'" -f2

# 부팅 가능한 커널 설정
grub2-set-default "CentOS Linux (6.7.1-1.el7.elrepo.x86_64) 7"

# 변경 확인
grub2-editenv list