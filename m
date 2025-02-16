Return-Path: <cgroups+bounces-6559-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B46DDA37413
	for <lists+cgroups@lfdr.de>; Sun, 16 Feb 2025 13:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 996007A2B8A
	for <lists+cgroups@lfdr.de>; Sun, 16 Feb 2025 12:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201E918DB29;
	Sun, 16 Feb 2025 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXoQOopC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B40114D43D;
	Sun, 16 Feb 2025 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739707357; cv=none; b=iGCnLYbNe1KpcpIqkJAg1HwdaYZQpmeeHSQrUZRlX4Ni2O2kLuU/AZSCaHNJwzYaDYDspeThGOA+2tI91Ib9r3r3ww8tBrCZ3H63ocTw+4vQu0o3XTIgzAR5qatnpS/fUW5XwzzYL8cGWiYTzkIBEuuviy7RNcmRoO7zwj6wObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739707357; c=relaxed/simple;
	bh=hZ8/iVQ5s08p2V4vsm0sdgPhGPjrrIjdgmny8XSe5Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WrQVYDsJucXu1i9TgKNQQCU9rhxlPDVtxYA8CcEYHLoaILWPsyIvJDTg9wkiPZsjuB7quw5oQfQvgs6ku64Qz9pg8lh+j1qrYqNlU0MlPABsGtOIWLTCEK1zvQ1nnJ/M0utIPsm72TWy77kVKW+lUhSjlFpWA6BGaZoU2JtYFvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXoQOopC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220d39a5627so50558765ad.1;
        Sun, 16 Feb 2025 04:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739707355; x=1740312155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=82WigbKU8K6bF5i7jEXR0EoBUFDRYWWxYd/tjoD8mAs=;
        b=hXoQOopCFD2V5np1oXPJhx6n8i2I+WVOSniBe+FiqAHd0qyvqS+5859cIf3bgRO8xl
         K0dF7bGz4NxEKgcvQkGrEpsv4ggkr8aauEsOctTwQsaoBgZnoUKzDNd4gEecoKxr2k37
         PQvv/WGeDejgfKcPTkNnRJJwy6/9N0oq4/M4xsJhDdlmAmiyuZsP6oOw1dOnpEE2S/iP
         typbS1UJuMkVWh3KCKR87w42xm90QjmWjIxl9AkGJsvzKGOm2EyM/OFMsmtexcSFN9Zo
         qOeHfVyRKKSPDWXz7N0IInmadMg3I/Cxmee3zSbW1uSfHKT3aRGyTe3sRfQIqDcY0VCm
         +PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739707355; x=1740312155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82WigbKU8K6bF5i7jEXR0EoBUFDRYWWxYd/tjoD8mAs=;
        b=dlmEirXTkRSs+UDD9ce3bbxNY4JemikDAgLrXBKLDuwhUV/D6eT56bh0vm2l1v+LyM
         T9DDrMJ76GSuTd0Xf8G9LRbLbmdwbS6jmaZ38E7NONEloSItvyTEof6ob29lKWMfSKKY
         nQGGT4eQ4Mw0UrVyis1Z9lnM5k02xb7IGYR2tzDXQleaxMwswqMoXDLeZHbOi3S6bPzF
         a1s2/hMqwrkcPT7iq2btkayN1jRaTWHjkVdO6nwZSlzjgWGNQdoWS5GCHJGuydDv0eYv
         nshbjvmsRyyl4J+m6TrTeONzQXosi4MLPpguMKQH6CCgcZ3rFIInuvG95QCWAM3HLKY7
         N8PA==
X-Forwarded-Encrypted: i=1; AJvYcCUZDBQCd+POmvUer7znF/WG2V2e6HFKdHualRMWO34uZVLPvP0zedUTcZNK8MqtyeTEJHvu2ZaV@vger.kernel.org, AJvYcCVdNcnBbTvqK4DDwiZe6Rqhh6MU+QQTd+DCpuNa4lMseapYGN7z9odKUlNy/qGcM8g7i2QmoO7E@vger.kernel.org, AJvYcCWOF/+S0LUXpTMD+1Jy97R+bEZj3CrochGevrOiOVUAuxINfSYwSLSpUEq22SstrUnrz5mvNrpeIJoyAmmx@vger.kernel.org
X-Gm-Message-State: AOJu0YxWfe0/fLz67T5kQP+3j8y4jsj89ZAfgv91M2JfVinmHvdkenKE
	qB+WxRzGtp1X8mBth/FCjHPhv5QrqBAySCQWvPoVPKPtlO9FlECC
X-Gm-Gg: ASbGncsZ2e1djrXPzvjBtQYaO5qmRbnY+XKhDcsqmZdBZfvL17S1t2PzlZJhFg4M6rQ
	JHSpSlxRrVlYw6pFaKyVuaHo/n7WPkFQkJW9kj2KjbTI8o8l7UsbCHrGALEs1bWH94TV+svhLfg
	jVK9raknhWdB7CXgXECKD6uWJamCkHdlEVQcYtkba7b1afCrIzMMaW/3qL3vN0chhKPUtXSu29P
	ETWCk5gNPd5hDN//p4Zdd02r8OmaspsMDHIuU/wB3duCVB7ZN65cdZqnM0qIWhfFPKtX8YBZ27X
	IcB6dNBADTtb5JnhvrY=
X-Google-Smtp-Source: AGHT+IErcCjOiHya8dVFasaPJCiSrh08Dpt+kq1hL0br1lZQvSwuAwOU/Wv3CBTQ2n9JWQBjRD9s0w==
X-Received: by 2002:a05:6a21:6b05:b0:1ed:e7cc:ee89 with SMTP id adf61e73a8af0-1ee8cc0335fmr10408406637.26.1739707355394;
        Sun, 16 Feb 2025 04:02:35 -0800 (PST)
Received: from pop-os.. ([2401:4900:65bb:caef:d8d2:fa8c:9c6d:c932])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324256896csm6181753b3a.40.2025.02.16.04.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 04:02:34 -0800 (PST)
From: Aditya Dutt <duttaditya18@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Aditya Dutt <duttaditya18@gmail.com>
Subject: [PATCH] selftests: make shell scripts POSIX-compliant
Date: Sun, 16 Feb 2025 17:32:25 +0530
Message-Id: <20250216120225.324468-1-duttaditya18@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes include:
- Replaced [[ ... ]] with [ ... ]
- Replaced == with =
- Replaced printf -v with cur=$(printf ...).
- Replaced echo -e with printf "%b\n" ...

The above mentioned are Bash/GNU extensions and are not part of POSIX.
Using shells like dash or non-GNU coreutils may produce errors.
They have been replaced with POSIX-compatible alternatives.

Signed-off-by: Aditya Dutt <duttaditya18@gmail.com>
---

I have made sure to only change the files that specifically have the
/bin/sh shebang.
I have referred to https://mywiki.wooledge.org/Bashism for information
on what is and what isn't POSIX-compliant.

 tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh   | 10 +++++-----
 tools/testing/selftests/kexec/kexec_common_lib.sh     |  2 +-
 tools/testing/selftests/kexec/test_kexec_file_load.sh |  2 +-
 tools/testing/selftests/net/veth.sh                   | 10 +++++-----
 tools/testing/selftests/powerpc/eeh/eeh-vf-aware.sh   |  2 +-
 tools/testing/selftests/zram/zram_lib.sh              |  2 +-
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh b/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh
index 3f45512fb512..00416248670f 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh
@@ -11,24 +11,24 @@ skip_test() {
 	exit 4 # ksft_skip
 }
 
-[[ $(id -u) -eq 0 ]] || skip_test "Test must be run as root!"
+[ $(id -u) -eq 0 ] || skip_test "Test must be run as root!"
 
 # Find cpuset v1 mount point
 CPUSET=$(mount -t cgroup | grep cpuset | head -1 | awk -e '{print $3}')
-[[ -n "$CPUSET" ]] || skip_test "cpuset v1 mount point not found!"
+[ -n "$CPUSET" ] || skip_test "cpuset v1 mount point not found!"
 
 #
 # Create a test cpuset, put a CPU and a task there and offline that CPU
 #
 TDIR=test$$
-[[ -d $CPUSET/$TDIR ]] || mkdir $CPUSET/$TDIR
+[ -d $CPUSET/$TDIR ] || mkdir $CPUSET/$TDIR
 echo 1 > $CPUSET/$TDIR/cpuset.cpus
 echo 0 > $CPUSET/$TDIR/cpuset.mems
 sleep 10&
 TASK=$!
 echo $TASK > $CPUSET/$TDIR/tasks
 NEWCS=$(cat /proc/$TASK/cpuset)
-[[ $NEWCS != "/$TDIR" ]] && {
+[ $NEWCS != "/$TDIR" ] && {
 	echo "Unexpected cpuset $NEWCS, test FAILED!"
 	exit 1
 }
@@ -38,7 +38,7 @@ sleep 0.5
 echo 1 > /sys/devices/system/cpu/cpu1/online
 NEWCS=$(cat /proc/$TASK/cpuset)
 rmdir $CPUSET/$TDIR
-[[ $NEWCS != "/" ]] && {
+[ $NEWCS != "/" ] && {
 	echo "cpuset $NEWCS, test FAILED!"
 	exit 1
 }
diff --git a/tools/testing/selftests/kexec/kexec_common_lib.sh b/tools/testing/selftests/kexec/kexec_common_lib.sh
index 641ef05863b2..b65616ea67f8 100755
--- a/tools/testing/selftests/kexec/kexec_common_lib.sh
+++ b/tools/testing/selftests/kexec/kexec_common_lib.sh
@@ -96,7 +96,7 @@ get_secureboot_mode()
 	local secureboot_mode=0
 	local system_arch=$(get_arch)
 
-	if [ "$system_arch" == "ppc64le" ]; then
+	if [ "$system_arch" = "ppc64le" ]; then
 		get_ppc64_secureboot_mode
 		secureboot_mode=$?
 	else
diff --git a/tools/testing/selftests/kexec/test_kexec_file_load.sh b/tools/testing/selftests/kexec/test_kexec_file_load.sh
index c9ccb3c93d72..072e03c8b1c3 100755
--- a/tools/testing/selftests/kexec/test_kexec_file_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_file_load.sh
@@ -226,7 +226,7 @@ get_secureboot_mode
 secureboot=$?
 
 # Are there pe and ima signatures
-if [ "$(get_arch)" == 'ppc64le' ]; then
+if [ "$(get_arch)" = 'ppc64le' ]; then
 	pe_signed=0
 else
 	check_for_pesig
diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 6bb7dfaa30b6..e86f102f9028 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -137,7 +137,7 @@ __change_channels()
 	local i
 
 	while true; do
-		printf -v cur '%(%s)T'
+		cur=$(printf '%(%s)T')
 		[ $cur -le $end ] || break
 
 		for i in `seq 1 $CPUS`; do
@@ -157,7 +157,7 @@ __send_data() {
 	local end=$1
 
 	while true; do
-		printf -v cur '%(%s)T'
+		cur=$(printf '%(%s)T')
 		[ $cur -le $end ] || break
 
 		ip netns exec $NS_SRC ./udpgso_bench_tx -4 -s 1000 -M 300 -D $BM_NET_V4$DST
@@ -166,7 +166,7 @@ __send_data() {
 
 do_stress() {
 	local end
-	printf -v end '%(%s)T'
+	cur=$(printf '%(%s)T')
 	end=$((end + $STRESS))
 
 	ip netns exec $NS_SRC ethtool -L veth$SRC rx 3 tx 3
@@ -198,8 +198,8 @@ do_stress() {
 
 usage() {
 	echo "Usage: $0 [-h] [-s <seconds>]"
-	echo -e "\t-h: show this help"
-	echo -e "\t-s: run optional stress tests for the given amount of seconds"
+	printf "%b\n" "\t-h: show this help"
+	printf "%b\n" "\t-s: run optional stress tests for the given amount of seconds"
 }
 
 STRESS=0
diff --git a/tools/testing/selftests/powerpc/eeh/eeh-vf-aware.sh b/tools/testing/selftests/powerpc/eeh/eeh-vf-aware.sh
index 874c11953bb6..18fdf88936f0 100755
--- a/tools/testing/selftests/powerpc/eeh/eeh-vf-aware.sh
+++ b/tools/testing/selftests/powerpc/eeh/eeh-vf-aware.sh
@@ -36,7 +36,7 @@ done
 
 eeh_disable_vfs
 
-if [ "$tested" == 0 ] ; then
+if [ "$tested" = 0 ] ; then
 	echo "No VFs with EEH aware drivers found, skipping"
 	exit $KSELFTESTS_SKIP
 fi
diff --git a/tools/testing/selftests/zram/zram_lib.sh b/tools/testing/selftests/zram/zram_lib.sh
index 21ec1966de76..923dbeb64eaf 100755
--- a/tools/testing/selftests/zram/zram_lib.sh
+++ b/tools/testing/selftests/zram/zram_lib.sh
@@ -37,7 +37,7 @@ kernel_gte()
 
 	if [ $kernel_major -gt $major ]; then
 		return 0
-	elif [[ $kernel_major -eq $major && $kernel_minor -ge $minor ]]; then
+	elif [ $kernel_major -eq $major && $kernel_minor -ge $minor ]; then
 		return 0
 	fi
 
-- 
2.34.1


