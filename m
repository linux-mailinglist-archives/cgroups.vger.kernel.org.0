Return-Path: <cgroups+bounces-3107-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 821A28FD3C2
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2024 19:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146452875F9
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2024 17:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B56913A3E5;
	Wed,  5 Jun 2024 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjjYthkE"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68488139D19
	for <cgroups@vger.kernel.org>; Wed,  5 Jun 2024 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717607961; cv=none; b=GEUVKix9vCODq/sqi1ApW0m85VzjGTlRd3O4DvJXUmKSoSiUCxePIg66upyiyYsAQKql2xy4pcs7jWFeIHjIbvWzdfIGkkjr9ZOiE5ANgGEVDfBybAl56Vx+A51htDr8UyG9F4uFw/JLfyTffTwOMPAvmQbOG3h/8h1yBeM7Blc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717607961; c=relaxed/simple;
	bh=L7TEEYUwd/2QW/RotNsPJyMCg3/E412I4pJuYUPXeAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m3A4s3eoYp5Ws8QIeLbTTb+j4M34aKyHK4XSKGiO7baqR+3r3ImafL7Ouqo5Wj9Xwn5EhD5oXwDxn4D6crghs4GBMwx08x8oEApLRtChVmw8POZOYdP176KxDD5p7PQ444XfSRYwe8Macik2FxE34vnV40K01OyZapNRqkvkvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjjYthkE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717607958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rst5dx+i2MhU1C2WQIxk51g9B7fqZtrRVu4iWF7JOiI=;
	b=EjjYthkEKYn7UDj8vFoKxje+BTMuRJ2/yTVSW9Hk7dxHEsWhFI8IRLMhh0oY/5O1FeCCOa
	HzrJG25h9vebL2KUQB/wJaz6N0VHi7JyCxed6xcGExhGlgy5p+jp875x0e2/s1J17H/qrz
	U1cP1JCulnaWaP7ORpnJjRMWigCXtbE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-QEn5BuBdNHq-Gj_7nXMYlw-1; Wed,
 05 Jun 2024 13:19:15 -0400
X-MC-Unique: QEn5BuBdNHq-Gj_7nXMYlw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3668F195E918;
	Wed,  5 Jun 2024 17:19:14 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.216])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9244F1956055;
	Wed,  5 Jun 2024 17:19:12 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xavier <ghostxavier@sina.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 2/2] selftest/cgroup: Dump expected sched-domain data to console
Date: Wed,  5 Jun 2024 13:18:58 -0400
Message-Id: <20240605171858.1323464-3-longman@redhat.com>
In-Reply-To: <20240605171858.1323464-1-longman@redhat.com>
References: <20240605171858.1323464-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Unlike the list of isolated CPUs, it is not easy to programamatically
determine what sched domains are being created by the scheduler just
by examinng the data in various kernfs filesystems. The easiest way
to get this information is by enabling /sys/kernel/debug/sched/verbose
file to make those information displayed in the console. This is also
what the test_cpuset_prs.sh script is doing when the -v flag is given.

It is rather hard to fetch the data from the console and compare it to
the expected result. An easier way is to dump the expected sched-domain
information out to the console so that they can be visually compared
with the actual sched domain data. However, this have to be done manually
by visual inspection and so will only be done once in a while.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../selftests/cgroup/test_cpuset_prs.sh       | 29 +++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index b5eb1be2248c..c5464ee4e17e 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -161,6 +161,14 @@ test_add_proc()
 #  T    = put a task into cgroup
 #  O<c>=<v> = Write <v> to CPU online file of <c>
 #
+# ECPUs    - effective CPUs of cpusets
+# Pstate   - partition root state
+# ISOLCPUS - isolated CPUs (<icpus>[,<icpus2>])
+#
+# Note that if there are 2 fields in ISOLCPUS, the first one is for
+# sched-debug matching which includes offline CPUs and single-CPU partitions
+# while the second one is for matching cpuset.cpus.isolated.
+#
 SETUP_A123_PARTITIONS="C1-3:P1:S+ C2-3:P1:S+ C3:P1"
 TEST_MATRIX=(
 	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
@@ -233,10 +241,14 @@ TEST_MATRIX=(
 								       A1:P0,A2:P1,A3:P2,B1:P1 2-3"
 	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3  X2-3:P1   P2     P1    0 A1:0-1,A2:,A3:2-3,B1:4 \
 								       A1:P0,A2:P1,A3:P2,B1:P1 2-4,2-3"
+	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3  X2-3:P1    .     P1    0 A1:0-1,A2:2-3,A3:2-3,B1:4 \
+								       A1:P0,A2:P1,A3:P0,B1:P1"
 	" C0-3:S+ C1-3:S+  C3     C4    X2-3  X2-3:P1   P2     P1    0 A1:0-1,A2:2,A3:3,B1:4 \
 								       A1:P0,A2:P1,A3:P2,B1:P1 2-4,3"
 	" C0-4:S+ C1-4:S+ C2-4     .    X2-4  X2-4:P2  X4:P1    .    0 A1:0-1,A2:2-3,A3:4 \
 								       A1:P0,A2:P2,A3:P1 2-4,2-3"
+	" C0-4:S+ C1-4:S+ C2-4     .    X2-4  X2-4:P2 X3-4:P1   .    0 A1:0-1,A2:2,A3:3-4 \
+								       A1:P0,A2:P2,A3:P1 2"
 	" C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 \
 				   .      .      X5      .      .    0 A1:0-4,A2:1-4,A3:2-4 \
 								       A1:P0,A2:P-2,A3:P-1"
@@ -556,14 +568,15 @@ check_cgroup_states()
 	do
 		set -- $(echo $CHK | sed -e "s/:/ /g")
 		CGRP=$1
+		CGRP_DIR=$CGRP
 		STATE=$2
 		FILE=
 		EVAL=$(expr substr $STATE 2 2)
-		[[ $CGRP = A2 ]] && CGRP=A1/A2
-		[[ $CGRP = A3 ]] && CGRP=A1/A2/A3
+		[[ $CGRP = A2 ]] && CGRP_DIR=A1/A2
+		[[ $CGRP = A3 ]] && CGRP_DIR=A1/A2/A3
 
 		case $STATE in
-			P*) FILE=$CGRP/cpuset.cpus.partition
+			P*) FILE=$CGRP_DIR/cpuset.cpus.partition
 			    ;;
 			*)  echo "Unknown state: $STATE!"
 			    exit 1
@@ -587,6 +600,16 @@ check_cgroup_states()
 				;;
 		esac
 		[[ $EVAL != $VAL ]] && return 1
+
+		#
+		# For root partition, dump sched-domains info to console if
+		# verbose mode set for manual comparison with sched debug info.
+		#
+		[[ $VAL -eq 1 && $VERBOSE -gt 0 ]] && {
+			DOMS=$(cat $CGRP_DIR/cpuset.cpus.effective)
+			[[ -n "$DOMS" ]] &&
+				echo " [$CGRP] sched-domain: $DOMS" > /dev/console
+		}
 	done
 	return 0
 }
-- 
2.39.3


