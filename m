Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74667E35B
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2019 21:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388645AbfHATd6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Aug 2019 15:33:58 -0400
Received: from nwk-aaemail-lapp03.apple.com ([17.151.62.68]:32838 "EHLO
        nwk-aaemail-lapp03.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388600AbfHATd5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Aug 2019 15:33:57 -0400
X-Greylist: delayed 5355 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Aug 2019 15:33:56 EDT
Received: from pps.filterd (nwk-aaemail-lapp03.apple.com [127.0.0.1])
        by nwk-aaemail-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id x71I2HkA032086;
        Thu, 1 Aug 2019 11:04:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=sender : from :
 content-type : mime-version : date : subject : cc : to : message-id;
 s=20180706; bh=4pyxIMgdcs9ruixtsPnEaV4NLKA7nF+9EPMnboTP4lc=;
 b=f68So1dFPS6qaIItQdMmPD7Tk7PUJ5r1L1MIg61yLiha2bMx+TXSGzE6i2y3eqaTzBlO
 WHVMsF3S/XYsPoFYnb5FTF5c5U68rBVZ+tIjG34hIX87G1UGyr7JHm2MvrinHeVdvC6Z
 RompOMNKMYeNTO4tYXIchkq2wfu1AzQYaiKEGMmPTdxXMlddKeH9MVUPY5xdQbKh5uNZ
 t3DGHdhMwJefsiiRGYlsr/FioQgng4nYOYYoPkFi6dsQD2jMi2YkZZR8zbWqPrQ1EADZ
 sBvGncD40q3/DZQZw/rWPYzsoDhwRCL5G3GRCT8YDYR0iVHUOPgiQgPV+Ti+Z+aMkdvj ig== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com [17.40.76.7])
        by nwk-aaemail-lapp03.apple.com with ESMTP id 2u2qm4uyq2-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 01 Aug 2019 11:04:37 -0700
Received: from nwk-mmpp-sz13.apple.com
 (nwk-mmpp-sz13.apple.com [17.128.115.216]) by ma1-mtap-s03.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0PVK00C2OKVJXHF0@ma1-mtap-s03.corp.apple.com>; Thu,
 01 Aug 2019 11:04:36 -0700 (PDT)
Received: from process_milters-daemon.nwk-mmpp-sz13.apple.com by
 nwk-mmpp-sz13.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0PVK00K00K8FWJ00@nwk-mmpp-sz13.apple.com>; Thu,
 01 Aug 2019 11:04:34 -0700 (PDT)
X-Va-A: 
X-Va-T-CD: c6fc7d606f718adcbce9ac4fa35a5d82
X-Va-E-CD: 0c38ba6fd3bbc32530cb69a65f6d6f9e
X-Va-R-CD: 7c65c22d999398119e0623f4c2c495bc
X-Va-CD: 0
X-Va-ID: 5581b639-911f-447d-b037-e1cac5669b68
X-V-A:  
X-V-T-CD: 021e426745e118905edfce2f8e2ddccf
X-V-E-CD: 0c38ba6fd3bbc32530cb69a65f6d6f9e
X-V-R-CD: 7c65c22d999398119e0623f4c2c495bc
X-V-CD: 0
X-V-ID: d944695f-2805-43f3-a015-06e4f17a0dda
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-08-01_08:,, signatures=0
Received: from iceman.apple.com (iceman.apple.com [17.228.212.91])
 by nwk-mmpp-sz13.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0PVK0042QKV2GQG0@nwk-mmpp-sz13.apple.com>; Thu,
 01 Aug 2019 11:04:14 -0700 (PDT)
From:   Masoud Sharbiani <msharbiani@apple.com>
Content-type: multipart/signed;
 boundary="Apple-Mail=_CB8B0DF1-FADB-47F7-B24E-A6A4DA793A4C";
 protocol="application/pkcs7-signature"; micalg=sha-256
MIME-version: 1.0 (Mac OS X Mail 13.0 \(3570.1\))
Date:   Thu, 01 Aug 2019 11:04:14 -0700
Subject: Possible mem cgroup bug in kernels between 4.18.0 and 5.3-rc1.
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     gregkh@linuxfoundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com
Message-id: <5659221C-3E9B-44AD-9BBF-F74DE09535CD@apple.com>
X-Mailer: Apple Mail (2.3570.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_08:,,
 signatures=0
X-Proofpoint-AD-Result: pass
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--Apple-Mail=_CB8B0DF1-FADB-47F7-B24E-A6A4DA793A4C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hey folks,
I=E2=80=99ve come across an issue that affects most of 4.19, 4.20 and =
5.2 linux-stable kernels that has only been fixed in 5.3-rc1.
It was introduced by

29ef680 memcg, oom: move out_of_memory back to the charge path=20

The gist of it is that if you have a memory control group for a process =
that repeatedly maps all of the pages of a file with  repeated calls to:

   mmap(NULL, pages * PAGE_SIZE, PROT_WRITE|PROT_READ, =
MAP_FILE|MAP_PRIVATE, fd, 0)

The memory cg eventually runs out of memory, as it should. However, =
prior to the 29ef680 commit, it would kill the running process with OOM; =
After that commit ( and until 5.3-rc1; Haven=E2=80=99t pinpointed the =
exact commit in between 5.2.0 and 5.3-rc1) the offending process goes =
into %100 CPU usage, and doesn=E2=80=99t die (prior behavior) or fail =
the mmap call (which is what happens if one runs the test program with a =
low ulimit -v value).

Any ideas on how to chase this down further?

(Test program and script have been pasted below)
Thanks,
Masoud


//=E2=80=94=E2=80=94=E2=80=94 leaker.c =E2=80=94=E2=80=94
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <stdio.h>
#include <errno.h>
#include <signal.h>

#ifndef PAGE_SIZE
#define PAGE_SIZE 4096
#endif

void sighandler(int x) {
   printf("SIGNAL %d received. Quitting\n", x);
   exit(2);
}

int main(int ac, char*av[])
{
   int i;
   int fd;
   int pages =3D 4096;
   char buf[PAGE_SIZE];
   char *d;
   int sum =3D 0, loop_cnt =3D 0;
   int max_loops =3D 100000;
   // For getopt(3) stuff:
   int opt;

   while ((opt =3D getopt(ac, av, "p:c:")) !=3D -1) {
       switch (opt) {
           case 'p':
               pages =3D atoi(optarg);
               break;
           case 'c':
               max_loops =3D atoi(optarg);
               break;
           default:
               fprintf(stderr, "Wrong usage:\n");
               fprintf(stderr, "%s -p <pages> -c <loop_count>\n", =
av[0]);
               exit(-1);
       }

   }
   signal(SIGTERM, sighandler);
   printf("Mapping %d pages anonymously %d times.\n", pages, max_loops);
   printf("File size will be %ld\n", pages * (long)PAGE_SIZE);
   printf("max memory usage size will be %ld\n", (long) max_loops * =
pages * PAGE_SIZE);

   memset(buf, 0, PAGE_SIZE);

   fd =3D open("big-data-file.bin", O_CREAT|O_WRONLY|O_TRUNC , S_IRUSR | =
S_IWUSR);
   if (fd =3D=3D -1) {
       printf("open failed: %d - %s\n", errno, strerror(errno));
       return -1;
   }
   for (i=3D0; i < pages; i++) {
       write(fd, buf, PAGE_SIZE);
   }
   close(fd);
   fd =3D open("big-data-file.bin", O_RDWR);
   printf("fd is %d\n", fd);
   while (loop_cnt < max_loops) {
       d =3D mmap(NULL, pages * PAGE_SIZE, PROT_WRITE|PROT_READ, =
MAP_FILE|MAP_PRIVATE, fd, 0);
       if (d =3D=3D MAP_FAILED) {
           printf("mmap failed: %d - %s\n", errno, strerror(errno));
           return -1;
       }
       printf("Buffer is @ %p\n", d);
       for (i =3D 0; i < pages * PAGE_SIZE; i++) {
           sum +=3D d[i];
           if ((i & (PAGE_SIZE-1)) =3D=3D 0)
               d[i] =3D 42;
       }
       printf("Todal sum was %d. Loop count is %d\n", sum, loop_cnt++);
   }
   close(fd);
   return 0;
}

///=E2=80=94=E2=80=94 test script launching it=E2=80=A6
#!/bin/sh

if [ `id -u` -ne 0 ]; then
       echo NEED TO RUN THIS AS ROOT.; exit 1
fi
PID=3D$(echo $$)
echo PID detected as: $PID
mkdir /sys/fs/cgroup/memory/leaker
echo 536870912 > /sys/fs/cgroup/memory/leaker/memory.limit_in_bytes

echo leaker mem cgroup created, with `cat =
/sys/fs/cgroup/memory/leaker/memory.limit_in_bytes` bytes.
echo $PID > /sys/fs/cgroup/memory/leaker/cgroup.procs
echo Moved into the leaker cgroup.
ps -o cgroup $PID
sleep 15
echo Starting...
./leaker -p 10240 -c 100000=

--Apple-Mail=_CB8B0DF1-FADB-47F7-B24E-A6A4DA793A4C
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

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
Y2E1ZzEuZGVyMDgGCCsGAQUFBzABhixodHRwOi8vb2NzcC5hcHBsZS5jb20vb2NzcDAzLWFwcGxl
aXN0Y2E1ZzEwMTAfBgNVHREEGDAWgRRtc2hhcmJpYW5pQGFwcGxlLmNvbTCCASoGA1UdIASCASEw
ggEdMIIBGQYLKoZIhvdjZAULBQEwggEIMIHKBggrBgEFBQcCAjCBvQyBulJlbGlhbmNlIG9uIHRo
aXMgY2VydGlmaWNhdGUgYXNzdW1lcyBhY2NlcHRhbmNlIG9mIGFueSBhcHBsaWNhYmxlIHRlcm1z
IG9mIHVzZSBhbmQgY2VydGlmaWNhdGlvbiBwcmFjdGljZSBzdGF0ZW1lbnRzLiBUaGlzIGNlcnRp
ZmljYXRlIHNoYWxsIG5vdCBzZXJ2ZSBhcywgb3IgcmVwbGFjZSBhIHdyaXR0ZW4gc2lnbmF0dXJl
LjA5BggrBgEFBQcCARYtaHR0cDovL3d3dy5hcHBsZS5jb20vY2VydGlmaWNhdGVhdXRob3JpdHkv
cnBhMBMGA1UdJQQMMAoGCCsGAQUFBwMEMDcGA1UdHwQwMC4wLKAqoCiGJmh0dHA6Ly9jcmwuYXBw
bGUuY29tL2FwcGxlaXN0Y2E1ZzEuY3JsMB0GA1UdDgQWBBR5OmXQsx80at576fQVWG/05OardjAO
BgNVHQ8BAf8EBAMCBaAwDQYJKoZIhvcNAQELBQADggEBAMavb8+8hvTGbqNfz0g9P4Alj5YKpTnW
pt1NNuyl9qR+QVooK8oMbGTB6cbSSKX7lcAW7motP5eRF0EiKXiu+IIgPhmDWKkbKnrrWK9AGhVn
xpm3OCnRHt2b+zYbkGGty0HYncIRdy3acTr+0T9Vs4xANJHwBIqUnkW5XKbPiZkv+EVKAsnL5CYD
npLI/uslfLquUYe6o8XIBVNYhmxEcxeCXbeESEk/KutdL+JcV4SpNoEB6Y4Dk1ZnHYOZRiLV3ZEG
neaCYYxam7SPWxeXqLtgeQMEEPgqj6pj430BQ/NKmCqdwRv2Sd0wXlKEDMul7jmWVUiRd6Nijgy5
7E2hn9MxggMgMIIDHAIBATB2MGIxHDAaBgNVBAMTE0FwcGxlIElTVCBDQSA1IC0gRzExIDAeBgNV
BAsTF0NlcnRpZmljYXRpb24gQXV0aG9yaXR5MRMwEQYDVQQKEwpBcHBsZSBJbmMuMQswCQYDVQQG
EwJVUwIQDNpHL/RwufOMyUmvGQQ2czANBglghkgBZQMEAgEFAKCCAXswGAYJKoZIhvcNAQkDMQsG
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwODAxMTgwNDE1WjAvBgkqhkiG9w0BCQQxIgQg
vnsk9yvJdyTHTNsykPX6Y9lptenzOf8l+ketcxJTpnswgYUGCSsGAQQBgjcQBDF4MHYwYjEcMBoG
A1UEAxMTQXBwbGUgSVNUIENBIDUgLSBHMTEgMB4GA1UECxMXQ2VydGlmaWNhdGlvbiBBdXRob3Jp
dHkxEzARBgNVBAoTCkFwcGxlIEluYy4xCzAJBgNVBAYTAlVTAhAM2kcv9HC584zJSa8ZBDZzMIGH
BgsqhkiG9w0BCRACCzF4oHYwYjEcMBoGA1UEAxMTQXBwbGUgSVNUIENBIDUgLSBHMTEgMB4GA1UE
CxMXQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxEzARBgNVBAoTCkFwcGxlIEluYy4xCzAJBgNVBAYT
AlVTAhAM2kcv9HC584zJSa8ZBDZzMA0GCSqGSIb3DQEBAQUABIIBAJdc4Cu7pN+fGw31vpLXm1zl
WRyOUlvFk0mUB/Qaafq9RX31VrRrPVgNA+ViEVbxnUPGciDSBeMbpPyyvN0HQx1cuimVLsnn6bqr
xY8TUXWRSI/Dau3RkCE5iciqI4olSKRgx0d0ZGpd8J1/kGs/oQch0EYfYJvOlgA0pQbG59Ubvnc5
eH6QdBnkFnXnImk/M1+NkQYqaWcqAqe0IGf2Pv50/PGja5suqlADLXOSneWfoZTbjY0EmVz3mIaz
s6M2ILfMKBsLd2CduBOl6MDulzETP+o6HBnzf6eL0NCF5str6XsafjlEHI57Gb2x6HHjYEXJishf
ZlOlCsYPZOvUeEMAAAAAAAA=
--Apple-Mail=_CB8B0DF1-FADB-47F7-B24E-A6A4DA793A4C--
