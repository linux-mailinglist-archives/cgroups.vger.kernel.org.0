Return-Path: <cgroups+bounces-4381-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4F2958EED
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 21:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6181DB21F51
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 19:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82027169AE3;
	Tue, 20 Aug 2024 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibyvbCFR"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2891165F11
	for <cgroups@vger.kernel.org>; Tue, 20 Aug 2024 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183779; cv=none; b=kSVhlBnhjQTjt3UT8stsISUihiavnGxu4xl+soB4SDainGK3Q87wdm2+OPm/ugkq8ZXnR4X658VSYQvmVR0qUj69UAmeKh64Z4y/5C1Oomb1rJTtDN7UrzD4eDd5uMhsUhZVOnHGFY54H9SMe6QGLBeLE4ZXRINUAT8n1UlXnek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183779; c=relaxed/simple;
	bh=18cPMSaDtaY+lxHJME2xrBNGIO0S/92DLC/TXWVkzfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKTtYrOd8B0a4e4jZm7ZyhYa2ZXaARwS+INtC9xk4SKdnN+wu5/EYid5mQobbe1AgDAfuDN2QX/2udDdzQibNqltCj9D3pOr04aJ+VbEPVTz3Xe+lLPHg4Ic62B4gSE66Oe60J22yFupaC8ZvPfk4GWI9y+7StWctWXioNsM+EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ibyvbCFR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724183776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXWHRdiKeY3vLGIwaF2E78Blh3Oa1dH56pxG/kH/jxM=;
	b=ibyvbCFRCay24FbKyvPVfhCh8495g4+KXN9XYlSaPrk1i7qMI694ldt/jgnlYYLr1YAuPH
	Sx1eY2bAaEM9u0j+TchkEmWWAUWGi2wvq6uaxG2W/+3tPAB3QWUpFmCC+Fcxmp+vwEjn7d
	3x9zhHu/VEQpGU/FUMMuu5LiMfxH6gM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-tznN8F2mNKuvOyc2cDphlw-1; Tue,
 20 Aug 2024 15:56:11 -0400
X-MC-Unique: tznN8F2mNKuvOyc2cDphlw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B0801955BF9;
	Tue, 20 Aug 2024 19:56:09 +0000 (UTC)
Received: from llong.com (unknown [10.2.17.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73A6F3001FFB;
	Tue, 20 Aug 2024 19:56:07 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 2/2] selftest/cgroup: Make test_cpuset_prs.sh deal with pre-isolated CPUs
Date: Tue, 20 Aug 2024 15:55:36 -0400
Message-ID: <20240820195536.202066-3-longman@redhat.com>
In-Reply-To: <20240820195536.202066-1-longman@redhat.com>
References: <20240820195536.202066-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Since isolated CPUs can be reserved at boot time via the "isolcpus"
boot command line option, these pre-isolated CPUs may interfere with
testing done by test_cpuset_prs.sh.

With the previous commit that incorporates those boot time isolated CPUs
into "cpuset.cpus.isolated", we can check for those before testing is
started to make sure that there will be no interference.  Otherwise,
this test will be skipped if incorrect test failure can happen.

As "cpuset.cpus.isolated" is now available in a non cgroup_debug kernel,
we don't need to check for its existence anymore.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../selftests/cgroup/test_cpuset_prs.sh       | 44 ++++++++++++++-----
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 7295424502b9..03c1bdaed2c3 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -84,6 +84,20 @@ echo member > test/cpuset.cpus.partition
 echo "" > test/cpuset.cpus
 [[ $RESULT -eq 0 ]] && skip_test "Child cgroups are using cpuset!"
 
+#
+# If isolated CPUs have been reserved at boot time (as shown in
+# cpuset.cpus.isolated), these isolated CPUs should be outside of CPUs 0-7
+# that will be used by this script for testing purpose. If not, some of
+# the tests may fail incorrectly. These isolated CPUs will also be removed
+# before being compared with the expected results.
+#
+BOOT_ISOLCPUS=$(cat $CGROUP2/cpuset.cpus.isolated)
+if [[ -n "$BOOT_ISOLCPUS" ]]
+then
+	[[ $(echo $BOOT_ISOLCPUS | sed -e "s/[,-].*//") -le 7 ]] &&
+		skip_test "Pre-isolated CPUs ($BOOT_ISOLCPUS) overlap CPUs to be tested"
+	echo "Pre-isolated CPUs: $BOOT_ISOLCPUS"
+fi
 cleanup()
 {
 	online_cpus
@@ -642,7 +656,8 @@ check_cgroup_states()
 # Note that isolated CPUs from the sched/domains context include offline
 # CPUs as well as CPUs in non-isolated 1-CPU partition. Those CPUs may
 # not be included in the cpuset.cpus.isolated control file which contains
-# only CPUs in isolated partitions.
+# only CPUs in isolated partitions as well as those that are isolated at
+# boot time.
 #
 # $1 - expected isolated cpu list(s) <isolcpus1>{,<isolcpus2>}
 # <isolcpus1> - expected sched/domains value
@@ -669,18 +684,21 @@ check_isolcpus()
 	fi
 
 	#
-	# Check the debug isolated cpumask, if present
+	# Check cpuset.cpus.isolated cpumask
 	#
-	[[ -f $ISCPUS ]] && {
+	if [[ -z "$BOOT_ISOLCPUS" ]]
+	then
+		ISOLCPUS=$(cat $ISCPUS)
+	else
+		ISOLCPUS=$(cat $ISCPUS | sed -e "s/,*$BOOT_ISOLCPUS//")
+	fi
+	[[ "$EXPECT_VAL2" != "$ISOLCPUS" ]] && {
+		# Take a 50ms pause and try again
+		pause 0.05
 		ISOLCPUS=$(cat $ISCPUS)
-		[[ "$EXPECT_VAL2" != "$ISOLCPUS" ]] && {
-			# Take a 50ms pause and try again
-			pause 0.05
-			ISOLCPUS=$(cat $ISCPUS)
-		}
-		[[ "$EXPECT_VAL2" != "$ISOLCPUS" ]] && return 1
-		ISOLCPUS=
 	}
+	[[ "$EXPECT_VAL2" != "$ISOLCPUS" ]] && return 1
+	ISOLCPUS=
 
 	#
 	# Use the sched domain in debugfs to check isolated CPUs, if available
@@ -713,6 +731,9 @@ check_isolcpus()
 		fi
 	done
 	[[ "$ISOLCPUS" = *- ]] && ISOLCPUS=${ISOLCPUS}$LASTISOLCPU
+	[[ -n "BOOT_ISOLCPUS" ]] &&
+		ISOLCPUS=$(echo $ISOLCPUS | sed -e "s/,*$BOOT_ISOLCPUS//")
+
 	[[ "$EXPECT_VAL" = "$ISOLCPUS" ]]
 }
 
@@ -730,7 +751,8 @@ test_fail()
 }
 
 #
-# Check to see if there are unexpected isolated CPUs left
+# Check to see if there are unexpected isolated CPUs left beyond the boot
+# time isolated ones.
 #
 null_isolcpus_check()
 {
-- 
2.43.5


