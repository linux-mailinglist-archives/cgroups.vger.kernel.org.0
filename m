Return-Path: <cgroups+bounces-13610-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKBDM2gFgWn5DgMAu9opvQ
	(envelope-from <cgroups+bounces-13610-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 21:13:28 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F85DD0FA4
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 21:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 236C8304F961
	for <lists+cgroups@lfdr.de>; Mon,  2 Feb 2026 20:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B3137F8BC;
	Mon,  2 Feb 2026 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSdmTnYS"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1CD30F52B
	for <cgroups@vger.kernel.org>; Mon,  2 Feb 2026 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770063155; cv=none; b=jtV7uu+zdJhTxAd08CPaGfDvMYZITwio/7zkf1Ptr0Fkv0jqOI4llSyMYmpJMpoWtOMe79ycz5zu9HmnLLQkw6xZRckahKUrcnSO0/vriJ/jhRDIqjUUn2odhfkfTFJ1+uequOag+BZbtuhl1dyzbsRxHFRCMW4m5yfFzzYHor0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770063155; c=relaxed/simple;
	bh=Hm7XCq3SMImg6pRfTXbFKknXEyJcIM9zBNfJjwJRK74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Srdb6HpiHbMLo+zhbU+7mFAnR1guWZ7XNjfd/8a9lmbdBnIlq4LzM1MVyiXHk1ViCTHhe6xLFHgx/EN3EZBZoPw3GFNxuiYQTTAg8ypyp110jBzClQdyBc9YSBcfr2N3Gs7VqHgV43YXIgNPkgV4g0toPFko8Tm7SZo7Z9+tv38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSdmTnYS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770063152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1061982895WSLlRIxm/QVlhN5JGCQNQS9arw2R6vJ94=;
	b=DSdmTnYSIC9ObiET6BiBra+Vwg987px05Prf0unIBhqi4tPaR4PZp858ctaGyM2nQeV+k7
	iJiYJGGEhf6qPfTufwMqTaN96GzzMmfq1DSCYOZa4z9E0apF2L4SMg/yFk13/oG4DzGRRj
	c3t+eK+RrUoXdNaDTlk//SPPzLoEvbU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-VKDMjuTwPX-ZLnBwKKPTWw-1; Mon,
 02 Feb 2026 15:12:28 -0500
X-MC-Unique: VKDMjuTwPX-ZLnBwKKPTWw-1
X-Mimecast-MFC-AGG-ID: VKDMjuTwPX-ZLnBwKKPTWw_1770063146
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFB271954234;
	Mon,  2 Feb 2026 20:12:25 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5552619560B2;
	Mon,  2 Feb 2026 20:12:22 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH/for-next v3 2/3] cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug to workqueue
Date: Mon,  2 Feb 2026 15:11:43 -0500
Message-ID: <20260202201144.1669260-3-longman@redhat.com>
In-Reply-To: <20260202201144.1669260-1-longman@redhat.com>
References: <20260202201144.1669260-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13610-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,test_cpuset_prs.sh:url]
X-Rspamd-Queue-Id: 8F85DD0FA4
X-Rspamd-Action: no action

The update_isolation_cpumasks() function can be called either directly
from regular cpuset control file write with cpuset_full_lock() called
or via the CPU hotplug path with cpus_write_lock and cpuset_mutex held.

As we are going to enable dynamic update to the nozh_full housekeeping
cpumask (HK_TYPE_KERNEL_NOISE) soon with the help of CPU hotplug,
allowing the CPU hotplug path to call into housekeeping_update() directly
from update_isolation_cpumasks() will likely cause deadlock. So we
have to defer any call to housekeeping_update() after the CPU hotplug
operation has finished. This is now done via the workqueue where
the actual housekeeping_update() call, if needed, will happen after
cpus_write_lock is released.

We can't use the synchronous task_work API as call from CPU hotplug
path happen in the per-cpu kthread of the CPU that is being shut down
or brought up. Because of the asynchronous nature of workqueue, the
HK_TYPE_DOMAIN housekeeping cpumask will be updated a bit later than the
"cpuset.cpus.isolated" control file in this case.

Also add a check in test_cpuset_prs.sh and modify some existing
test cases to confirm that "cpuset.cpus.isolated" and HK_TYPE_DOMAIN
housekeeping cpumask will both be updated.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c                        | 37 +++++++++++++++++--
 .../selftests/cgroup/test_cpuset_prs.sh       | 13 +++++--
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d705c5ba64a7..e98a2e953392 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1302,6 +1302,17 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
 	return false;
 }
 
+static void isolcpus_workfn(struct work_struct *work)
+{
+	cpuset_full_lock();
+	if (isolated_cpus_updating) {
+		isolated_cpus_updating = false;
+		WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
+		rebuild_sched_domains_locked();
+	}
+	cpuset_full_unlock();
+}
+
 /*
  * update_isolation_cpumasks - Update external isolation related CPU masks
  *
@@ -1310,14 +1321,34 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
  */
 static void update_isolation_cpumasks(void)
 {
-	int ret;
+	static DECLARE_WORK(isolcpus_work, isolcpus_workfn);
 
 	if (!isolated_cpus_updating)
 		return;
 
-	ret = housekeeping_update(isolated_cpus);
-	WARN_ON_ONCE(ret < 0);
+	/*
+	 * This function can be reached either directly from regular cpuset
+	 * control file write or via CPU hotplug. In the latter case, it is
+	 * the per-cpu kthread that calls cpuset_handle_hotplug() on behalf
+	 * of the task that initiates CPU shutdown or bringup.
+	 *
+	 * To have better flexibility and prevent the possibility of deadlock
+	 * when calling from CPU hotplug, we defer the housekeeping_update()
+	 * call to after the current cpuset critical section has finished.
+	 * This is done via workqueue.
+	 */
+	if (current->flags & PF_KTHREAD) {
+		/*
+		 * We rely on WORK_STRUCT_PENDING_BIT to not requeue a work
+		 * item that is still pending.
+		 */
+		queue_work(system_unbound_wq, &isolcpus_work);
+		/* Also defer sched domains regeneration to the work function */
+		force_sd_rebuild = false;
+		return;
+	}
 
+	WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
 	isolated_cpus_updating = false;
 }
 
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 5dff3ad53867..0502b156582b 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -245,8 +245,9 @@ TEST_MATRIX=(
 	"C2-3:P1:S+  C3:P2  .      .     O2=0   O2=1    .      .     0 A1:2|A2:3 A1:P1|A2:P2"
 	"C2-3:P1:S+  C3:P1  .      .     O2=0    .      .      .     0 A1:|A2:3 A1:P1|A2:P1"
 	"C2-3:P1:S+  C3:P1  .      .     O3=0    .      .      .     0 A1:2|A2: A1:P1|A2:P1"
-	"C2-3:P1:S+  C3:P1  .      .    T:O2=0   .      .      .     0 A1:3|A2:3 A1:P1|A2:P-1"
-	"C2-3:P1:S+  C3:P1  .      .      .    T:O3=0   .      .     0 A1:2|A2:2 A1:P1|A2:P-1"
+	"C2-3:P1:S+  C3:P2  .      .    T:O2=0   .      .      .     0 A1:3|A2:3 A1:P1|A2:P-2"
+	"C1-3:P1:S+  C3:P2  .      .      .    T:O3=0   .      .     0 A1:1-2|A2:1-2 A1:P1|A2:P-2 3|"
+	"C1-3:P1:S+  C3:P2  .      .      .    T:O3=0  O3=1    .     0 A1:1-2|A2:3 A1:P1|A2:P2  3"
 	"$SETUP_A123_PARTITIONS    .     O1=0    .      .      .     0 A1:|A2:2|A3:3 A1:P1|A2:P1|A3:P1"
 	"$SETUP_A123_PARTITIONS    .     O2=0    .      .      .     0 A1:1|A2:|A3:3 A1:P1|A2:P1|A3:P1"
 	"$SETUP_A123_PARTITIONS    .     O3=0    .      .      .     0 A1:1|A2:2|A3: A1:P1|A2:P1|A3:P1"
@@ -764,7 +765,7 @@ check_cgroup_states()
 # only CPUs in isolated partitions as well as those that are isolated at
 # boot time.
 #
-# $1 - expected isolated cpu list(s) <isolcpus1>{,<isolcpus2>}
+# $1 - expected isolated cpu list(s) <isolcpus1>{|<isolcpus2>}
 # <isolcpus1> - expected sched/domains value
 # <isolcpus2> - cpuset.cpus.isolated value = <isolcpus1> if not defined
 #
@@ -773,6 +774,7 @@ check_isolcpus()
 	EXPECTED_ISOLCPUS=$1
 	ISCPUS=${CGROUP2}/cpuset.cpus.isolated
 	ISOLCPUS=$(cat $ISCPUS)
+	HKICPUS=$(cat /sys/devices/system/cpu/isolated)
 	LASTISOLCPU=
 	SCHED_DOMAINS=/sys/kernel/debug/sched/domains
 	if [[ $EXPECTED_ISOLCPUS = . ]]
@@ -810,6 +812,11 @@ check_isolcpus()
 	ISOLCPUS=
 	EXPECTED_ISOLCPUS=$EXPECTED_SDOMAIN
 
+	#
+	# The inverse of HK_TYPE_DOMAIN cpumask in $HKICPUS should match $ISOLCPUS
+	#
+	[[ "$ISOLCPUS" != "$HKICPUS" ]] && return 1
+
 	#
 	# Use the sched domain in debugfs to check isolated CPUs, if available
 	#
-- 
2.52.0


