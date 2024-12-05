Return-Path: <cgroups+bounces-5768-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 126B99E5F2D
	for <lists+cgroups@lfdr.de>; Thu,  5 Dec 2024 20:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9E61885AF7
	for <lists+cgroups@lfdr.de>; Thu,  5 Dec 2024 19:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B03922D4E9;
	Thu,  5 Dec 2024 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQII/k/2"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EDF22D4F1
	for <cgroups@vger.kernel.org>; Thu,  5 Dec 2024 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733428290; cv=none; b=VTKl1MZkmnCpsvnsmt9WbTt+gnVo/yiBX1LrIbuLa8Ht3w7Imw0cCpKYg2ulBk1cGthYZ5nJD/AC1MOhQGIzrIQ5Gc0rn5QwfubtLsgTGsDCOiaanw46MSRFJEmQ8aTQBILd9lQq1kATsgF4Gwq3C1Yll5zFs7XE+OBRwu6wCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733428290; c=relaxed/simple;
	bh=aj/TDHD0CAOq7FGfGfcEU3eaakPg3oCuSNECP9NsCEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NI+9U43TBtq346SqX16nCyrcjZDYDcHSaY2ogVtJ5uLKAYprTOqds5kthn2U8V7X+rO/HC+yThT9NDeIX2qrGUh9tpHc2Kmg1pOC7k1OuUW0HCXHcz+kP9f7vxVOHXs63nOoLRY10h4Br9+F3hOoNsffS5J7aX8h/FEGrCZ2Pxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQII/k/2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733428288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TGMa02p59Vq5W9KNHvnbrbM6563qeJi/DcjgzffieMg=;
	b=SQII/k/2Bu38LYGthyE1EcCGcJTO4Y+QvtmiJia/DLqBdK6bh3bVQR/RBdraKhq1GKmYtS
	kbUOZxr1iGs5XYU8KS/525ESS23GWpSUFn6c7WNzqCxw+n65cHAL0CpM9h06HrJYfWSp3l
	q72Ce8V7H+PsMdErQUG8QeMhu0Fm91Y=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-HLV9w-mZOrajCjc8HTNz6A-1; Thu,
 05 Dec 2024 14:51:23 -0500
X-MC-Unique: HLV9w-mZOrajCjc8HTNz6A-1
X-Mimecast-MFC-AGG-ID: HLV9w-mZOrajCjc8HTNz6A
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 657F41956046;
	Thu,  5 Dec 2024 19:51:22 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.90.143])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E95E19560AD;
	Thu,  5 Dec 2024 19:51:20 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup/cpuset: Prevent leakage of isolated CPUs into sched domains
Date: Thu,  5 Dec 2024 14:51:01 -0500
Message-ID: <20241205195101.31108-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Isolated CPUs are not allowed to be used in a non-isolated partition.
The only exception is the top cpuset which is allowed to contain boot
time isolated CPUs.

Commit ccac8e8de99c ("cgroup/cpuset: Fix remote root partition creation
problem") introduces a simplified scheme of including only partition
roots in sched domain generation. However, it does not properly account
for this exception case. This can result in leakage of isolated CPUs
into a sched domain.

Fix it by making sure that isolated CPUs are excluded from the top
cpuset before generating sched domains.

Also update the way the boot time isolated CPUs are handled in
test_cpuset_prs.sh to make sure that those isolated CPUs are really
isolated instead of just skipping them in the tests.

Fixes: ccac8e8de99c ("cgroup/cpuset: Fix remote root partition creation problem")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c                        | 10 +++++-
 .../selftests/cgroup/test_cpuset_prs.sh       | 33 +++++++++++--------
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f321ed515f3a..33b264c3e258 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -890,7 +890,15 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	 */
 	if (cgrpv2) {
 		for (i = 0; i < ndoms; i++) {
-			cpumask_copy(doms[i], csa[i]->effective_cpus);
+			/*
+			 * The top cpuset may contain some boot time isolated
+			 * CPUs that need to be excluded from the sched domain.
+			 */
+			if (csa[i] == &top_cpuset)
+				cpumask_and(doms[i], csa[i]->effective_cpus,
+					    housekeeping_cpumask(HK_TYPE_DOMAIN));
+			else
+				cpumask_copy(doms[i], csa[i]->effective_cpus);
 			if (dattr)
 				dattr[i] = SD_ATTR_INIT;
 		}
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 03c1bdaed2c3..400a696a0d21 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -86,15 +86,15 @@ echo "" > test/cpuset.cpus
 
 #
 # If isolated CPUs have been reserved at boot time (as shown in
-# cpuset.cpus.isolated), these isolated CPUs should be outside of CPUs 0-7
+# cpuset.cpus.isolated), these isolated CPUs should be outside of CPUs 0-8
 # that will be used by this script for testing purpose. If not, some of
-# the tests may fail incorrectly. These isolated CPUs will also be removed
-# before being compared with the expected results.
+# the tests may fail incorrectly. These pre-isolated CPUs should stay in
+# an isolated state throughout the testing process for now.
 #
 BOOT_ISOLCPUS=$(cat $CGROUP2/cpuset.cpus.isolated)
 if [[ -n "$BOOT_ISOLCPUS" ]]
 then
-	[[ $(echo $BOOT_ISOLCPUS | sed -e "s/[,-].*//") -le 7 ]] &&
+	[[ $(echo $BOOT_ISOLCPUS | sed -e "s/[,-].*//") -le 8 ]] &&
 		skip_test "Pre-isolated CPUs ($BOOT_ISOLCPUS) overlap CPUs to be tested"
 	echo "Pre-isolated CPUs: $BOOT_ISOLCPUS"
 fi
@@ -683,15 +683,19 @@ check_isolcpus()
 		EXPECT_VAL2=$EXPECT_VAL
 	fi
 
+	#
+	# Appending pre-isolated CPUs
+	# Even though CPU #8 isn't used for testing, it can't be pre-isolated
+	# to make appending those CPUs easier.
+	#
+	[[ -n "$BOOT_ISOLCPUS" ]] && {
+		EXPECT_VAL=${EXPECT_VAL:+${EXPECT_VAL},}${BOOT_ISOLCPUS}
+		EXPECT_VAL2=${EXPECT_VAL2:+${EXPECT_VAL2},}${BOOT_ISOLCPUS}
+	}
+
 	#
 	# Check cpuset.cpus.isolated cpumask
 	#
-	if [[ -z "$BOOT_ISOLCPUS" ]]
-	then
-		ISOLCPUS=$(cat $ISCPUS)
-	else
-		ISOLCPUS=$(cat $ISCPUS | sed -e "s/,*$BOOT_ISOLCPUS//")
-	fi
 	[[ "$EXPECT_VAL2" != "$ISOLCPUS" ]] && {
 		# Take a 50ms pause and try again
 		pause 0.05
@@ -731,8 +735,6 @@ check_isolcpus()
 		fi
 	done
 	[[ "$ISOLCPUS" = *- ]] && ISOLCPUS=${ISOLCPUS}$LASTISOLCPU
-	[[ -n "BOOT_ISOLCPUS" ]] &&
-		ISOLCPUS=$(echo $ISOLCPUS | sed -e "s/,*$BOOT_ISOLCPUS//")
 
 	[[ "$EXPECT_VAL" = "$ISOLCPUS" ]]
 }
@@ -836,8 +838,11 @@ run_state_test()
 		# if available
 		[[ -n "$ICPUS" ]] && {
 			check_isolcpus $ICPUS
-			[[ $? -ne 0 ]] && test_fail $I "isolated CPU" \
-				"Expect $ICPUS, get $ISOLCPUS instead"
+			[[ $? -ne 0 ]] && {
+				[[ -n "$BOOT_ISOLCPUS" ]] && ICPUS=${ICPUS},${BOOT_ISOLCPUS}
+				test_fail $I "isolated CPU" \
+					"Expect $ICPUS, get $ISOLCPUS instead"
+			}
 		}
 		reset_cgroup_states
 		#
-- 
2.47.1


