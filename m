Return-Path: <cgroups+bounces-15401-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDq6FN3r5mnF1wEAu9opvQ
	(envelope-from <cgroups+bounces-15401-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:15:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E2B435F0C
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 05:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B1AF3074CD8
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 03:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A02A3A6EE4;
	Tue, 21 Apr 2026 03:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bm9x71Zw"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB65379EDC
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 03:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740877; cv=none; b=EyymKTCu/OXgD+gChNfsAHTsCh1CSOz0ckq7Pf70AstocFFWfHTJ421oqA3kouH8hWF9J7jBwesKJX4t5pr83nHjMuVBo5kUAlMsETsr/Bh0im3muBYk4SCpTPv4ZXy45rAaKyFJ3ao5pExtMMlgZqHTpuiXQULNvUw/MJCoQIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740877; c=relaxed/simple;
	bh=pdahzaI6TYYLoH1na7BPnX7x2KDai2pfXdzq/9hklYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPGgIhtLbqf4JdCUlq9tX0mT8TnOg56bTWjp72hToGa5kb9vEJZbhM/VNaucqmyjtiFXcO5Fu+2J+JBDWXbmHGeO+MeVuOHYsRmRYTJanWUbHzXOCz1u64e9bHTL0XMvpoC1bmA2YSg97QIso9aQqHTp6gLWB8biUcWA7xPgn+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bm9x71Zw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776740874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=id5gu+CSXzoxxDihrOTSOMQURNR0EZCi73AeA6doMCM=;
	b=Bm9x71ZwYqhNoTiKmYPwc6BBhyIMnMlZyMS2VKu81R1meaWt5epLNi1ZgB0jBfn41au6nc
	whNxBb+0S5c5OeIW//tQehOFlwOLwtrvRkt7hV+XZ+Q+J8lAc9qrzWwELazeObiFFA97Pe
	4qs55BOtEHNMeYjScNjONJc3UdI5PaY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-eswoHUPCNHOcZgPwTq7aKQ-1; Mon,
 20 Apr 2026 23:07:48 -0400
X-MC-Unique: eswoHUPCNHOcZgPwTq7aKQ-1
X-Mimecast-MFC-AGG-ID: eswoHUPCNHOcZgPwTq7aKQ_1776740863
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFC621800367;
	Tue, 21 Apr 2026 03:07:43 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C546C19560AB;
	Tue, 21 Apr 2026 03:07:36 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Costa Shulyupin <cshulyup@redhat.com>,
	Qiliang Yuan <realwujing@gmail.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 23/23] cgroup/cpuset: Documentation and kselftest updates
Date: Mon, 20 Apr 2026 23:03:51 -0400
Message-ID: <20260421030351.281436-24-longman@redhat.com>
In-Reply-To: <20260421030351.281436-1-longman@redhat.com>
References: <20260421030351.281436-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-15401-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_GT_50(0.00)[53];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8E2B435F0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As CPU hotplug is now being used to enable runtime update to the list
of nohz_full and managed_irq CPUs, we should avoid using CPU 0 in the
formation of isolated partition as CPU 0 may not be able to be brought
offline like in the case of x86-64 architecture. So a number of the
test cases in test_cpuset_prs.sh will have to be updated accordingly.

A new test will also be run in offline isn't allowed in CPU 0 to verify
that using CPU 0 as part of an isolated partition will fail.

The cgroup-v2.rst is also updated to reflect the new capability of using
CPU hotplug to enable run time change to the nohz_full and managed_irq
CPU lists.

Since there is a slight performance overhead to enable runtime changes
to nohz_full CPU list, users have to explicitly opt in by adding a
"nohz_ful" kernel command line parameter with or without a CPU list.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst       | 35 +++++++---
 .../selftests/cgroup/test_cpuset_prs.sh       | 70 +++++++++++++++++--
 2 files changed, 92 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 8ad0b2781317..e97fc031eb86 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2604,11 +2604,12 @@ Cpuset Interface Files
 
 	It accepts only the following input values when written to.
 
-	  ==========	=====================================
+	  ==========	===============================================
 	  "member"	Non-root member of a partition
 	  "root"	Partition root
-	  "isolated"	Partition root without load balancing
-	  ==========	=====================================
+	  "isolated"	Partition root without load balancing and other
+		        OS noises
+	  ==========	===============================================
 
 	A cpuset partition is a collection of cpuset-enabled cgroups with
 	a partition root at the top of the hierarchy and its descendants
@@ -2652,11 +2653,29 @@ Cpuset Interface Files
 	partition or scheduling domain.  The set of exclusive CPUs is
 	determined by the value of its "cpuset.cpus.exclusive.effective".
 
-	When set to "isolated", the CPUs in that partition will be in
-	an isolated state without any load balancing from the scheduler
-	and excluded from the unbound workqueues.  Tasks placed in such
-	a partition with multiple CPUs should be carefully distributed
-	and bound to each of the individual CPUs for optimal performance.
+	When set to "isolated", the CPUs in that partition will be in an
+	isolated state without any load balancing from the scheduler and
+	excluded from the unbound workqueues as well as other OS noises.
+	Tasks placed in such a partition with multiple CPUs should be
+	carefully distributed and bound to each of the individual CPUs
+	for optimal performance.
+
+	As CPU hotplug, if supported, is used to improve the degree of
+	CPU isolation close to the "nohz_full" kernel boot parameter.
+	In some architectures, like x86-64, the boot CPU (typically CPU
+	0) cannot be brought offline, so the boot CPU should not be used
+	for forming isolated partitions.  The "nohz_full" kernel boot
+	parameter needs to be present to enable full dynticks support
+	and RCU no-callback CPU mode for CPUs in isolated partitions
+	even if the optional cpu list isn't provided.
+
+	Using CPU hotplug for creating or destroying an isolated
+	partition can cause latency spike in applications running
+	in other isolated partitions.  A reserved list of CPUs can
+	optionally be put in the "nohz_full" kernel boot parameter to
+	alleviate this problem.  When these reserved CPUs are used for
+	isolated partitions, CPU hotplug won't need to be invoked and
+	so there won't be latency spike in other isolated partitions.
 
 	A partition root ("root" or "isolated") can be in one of the
 	two possible states - valid or invalid.  An invalid partition
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index a56f4153c64d..eebb4122b581 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -67,6 +67,12 @@ then
 	echo Y > /sys/kernel/debug/sched/verbose
 fi
 
+# Enable dynamic debug message if available
+DYN_DEBUG=/proc/dynamic_debug/control
+[[ -f $DYN_DEBUG ]] && {
+	echo "file kernel/cpu.c +p" > $DYN_DEBUG
+}
+
 cd $CGROUP2
 echo +cpuset > cgroup.subtree_control
 
@@ -84,6 +90,15 @@ echo member > test/cpuset.cpus.partition
 echo "" > test/cpuset.cpus
 [[ $RESULT -eq 0 ]] && skip_test "Child cgroups are using cpuset!"
 
+#
+# If nohz_full parameter is specified and nohz_full file exists, CPU hotplug
+# will be used to modify nohz_full cpumask to include all the isolated CPUs
+# in cpuset isolated partitions.
+#
+NOHZ_FULL=/sys/devices/system/cpu/nohz_full
+BOOT_NOHZ_FULL=$(fmt -1 /proc/cmdline | grep "^nohz_full")
+[[ "$BOOT_NOHZ_FULL" = nohz_full ]] && CHK_NOHZ_FULL=1
+
 #
 # If isolated CPUs have been reserved at boot time (as shown in
 # cpuset.cpus.isolated), these isolated CPUs should be outside of CPUs 0-8
@@ -318,8 +333,8 @@ TEST_MATRIX=(
 	# Invalid to valid local partition direct transition tests
 	" C1-3:P2  X4:P2    .      .      .      .      .      .     0 A1:1-3|XA1:1-3|A2:1-3:XA2: A1:P2|A2:P-2 1-3"
 	" C1-3:P2  X4:P2    .      .      .    X3:P2    .      .     0 A1:1-2|XA1:1-3|A2:3:XA2:3 A1:P2|A2:P2 1-3"
-	" C0-3:P2    .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:5-6 A1:P2|B1:P0"
-	" C0-3:P2    .      .    C4-6 C0-4:C0-3  .      .      .     0 A1:0-3|B1:4-6 A1:P2|B1:P0 0-3"
+	" C1-3:P2    .      .    C4-6   C1-4     .      .      .     0 A1:1-4|B1:5-6 A1:P2|B1:P0"
+	" C1-3:P2    .      .    C4-6 C1-4:C1-3  .      .      .     0 A1:1-3|B1:4-6 A1:P2|B1:P0 1-3"
 
 	# Local partition invalidation tests
 	" C0-3:X1-3:P2 C1-3:X2-3:P2 C2-3:X3:P2 \
@@ -329,8 +344,8 @@ TEST_MATRIX=(
 	" C0-3:X1-3:P2 C1-3:X2-3:P2 C2-3:X3:P2 \
 				   .      .    C4:X     .      .     0 A1:1-3|A2:1-3|A3:2-3|XA2:|XA3: A1:P2|A2:P-2|A3:P-2 1-3"
 	# Local partition CPU change tests
-	" C0-5:P2  C4-5:P1  .      .      .    C3-5     .      .     0 A1:0-2|A2:3-5 A1:P2|A2:P1 0-2"
-	" C0-5:P2  C4-5:P1  .      .    C1-5     .      .      .     0 A1:1-3|A2:4-5 A1:P2|A2:P1 1-3"
+	" C1-5:P2  C4-5:P1  .      .      .    C3-5     .      .     0 A1:1-2|A2:3-5 A1:P2|A2:P1 1-2"
+	" C1-5:P2  C4-5:P1  .      .    C2-5     .      .      .     0 A1:2-3|A2:4-5 A1:P2|A2:P1 2-3"
 
 	# cpus_allowed/exclusive_cpus update tests
 	" C0-3:X2-3 C1-3:X2-3 C2-3:X2-3 \
@@ -442,6 +457,21 @@ TEST_MATRIX=(
 	"   C0-3     .      .    C4-5   X3-5     .      .      .     1 A1:0-3|B1:4-5"
 )
 
+#
+# Test matrix to verify that using CPU 0 in isolated (local or remote) partition
+# will fail when offline isn't allowed for CPU 0.
+#
+CPU0_ISOLCPUS_MATRIX=(
+	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
+	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
+	"   C0-3     .      .    C4-5     P2     .      .      .     0 A1:0-3|B1:4-5 A1:P-2"
+	"   C1-3     .      .      .      P2     .      .      .     0 A1:1-3 A1:P2"
+	"   C1-3     .      .      .    P2:C0-3  .      .      .     0 A1:0-3 A1:P-2"
+	"  CX0-3   C0-3     .      .       .     P2     .      .     0 A1:0-3|A2:0-3 A2:P-2"
+	"  CX0-3 C0-3:X1-3  .      .       .     P2     .      .     0 A1:0|A2:1-3 A2:P2"
+	"  CX0-3 C0-3:X1-3  .      .       .   P2:X0-3  .      .     0 A1:0-3|A2:0-3 A2:P-2"
+)
+
 #
 # Cpuset controller remote partition test matrix.
 #
@@ -513,7 +543,7 @@ write_cpu_online()
 		}
 	fi
 	echo $VAL > $CPUFILE
-	pause 0.05
+	pause 0.10
 }
 
 #
@@ -654,6 +684,8 @@ dump_states()
 		[[ -e $PCPUS  ]] && echo "$PCPUS: $(cat $PCPUS)"
 		[[ -e $ISCPUS ]] && echo "$ISCPUS: $(cat $ISCPUS)"
 	done
+	# Dump nohz_full
+	[[ -f $NOHZ_FULL ]] && echo "nohz_full: $(cat $NOHZ_FULL)"
 }
 
 #
@@ -789,6 +821,18 @@ check_isolcpus()
 		EXPECTED_SDOMAIN=$EXPECTED_ISOLCPUS
 	fi
 
+	#
+	# Check if nohz_full match cpuset.cpus.isolated if nohz_boot parameter
+	# specified with no parameter.
+	#
+	[[ -f $NOHZ_FULL && "$BOOT_NOHZ_FULL" = nohz_full ]] && {
+		NOHZ_FULL_CPUS=$(cat $NOHZ_FULL)
+		[[ "$ISOLCPUS" != "$NOHZ_FULL_CPUS" ]] && {
+			echo "nohz_full ($NOHZ_FULL_CPUS) does not match cpuset.cpus.isolated ($ISOLCPUS)"
+			return 1
+		}
+	}
+
 	#
 	# Appending pre-isolated CPUs
 	# Even though CPU #8 isn't used for testing, it can't be pre-isolated
@@ -1070,6 +1114,21 @@ run_remote_state_test()
 	echo "All $I tests of $TEST PASSED."
 }
 
+#
+# Testing CPU 0 isolated partition test when offline is disabled
+#
+run_cpu0_isol_test()
+{
+	# Skip the test if CPU0 offline is allowed or if nohz_full kernel
+	# boot parameter is missing.
+	CPU0_ONLINE=/sys/devices/system/cpu/cpu0/online
+	[[ -f $CPU0_ONLINE ]] && return
+	grep -q -w nohz_full /proc/cmdline
+	[[ $? -ne 0 ]] && return
+
+	run_state_test CPU0_ISOLCPUS_MATRIX
+}
+
 #
 # Testing the new "isolated" partition root type
 #
@@ -1207,6 +1266,7 @@ test_inotify()
 trap cleanup 0 2 3 6
 run_state_test TEST_MATRIX
 run_remote_state_test REMOTE_TEST_MATRIX
+run_cpu0_isol_test
 test_isolated
 test_inotify
 echo "All tests PASSED."
-- 
2.53.0


