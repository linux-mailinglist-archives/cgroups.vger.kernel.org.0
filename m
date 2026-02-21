Return-Path: <cgroups+bounces-14097-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE0RCu3/mWlgXwMAu9opvQ
	(envelope-from <cgroups+bounces-14097-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 19:56:45 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9B416D9BE
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 19:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5EB5306DFCC
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 18:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951F73126CD;
	Sat, 21 Feb 2026 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4gvZ/WB"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106B630F808
	for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771700126; cv=none; b=KeGtR94Ghw7hAlzFjj0xvYAdg0PE/HB6s8bJeOmmFHwVyMqxmo+FFG8ybeS/+ob0xcdpM3SE5Jh3TyRybr4Bvo+iC/AnW0Hxz3HCAUnob9DtrevsX69u/waXZ1VTz9XuzKl/apfS7uCM5IuWAnVYA0KTKdPvqlKBEVxxcsdnxoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771700126; c=relaxed/simple;
	bh=zj1nzFsQKy7G9JLp3bdrBW08Nt2BFrGjPQK/n7+/h8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XluY2n4IZFUX5cUd6tOykh8Mw1KffhK6vHPgSjQ9ojcULJnwRA8NCaT2UDwKqPPDCmF7JxBI/8hhUSKWkWr5ua7xFORKJhELEMO+yXD/0p86eK53lBvbfEsUVm3QdySYBo3m8hRw3s2yb+VZQXOW1rmoc3ZRU5w17zwcBct+jYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4gvZ/WB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771700124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xKg+N2bAOrd2PMcoX6bAcqgeV9uYlmhLKffPR6U/E6o=;
	b=h4gvZ/WBMnsFlJUUlW94dAwnu5z9lNLCJ5qpqHTx5SFRCJSZFE91Ye7FBmu3wtTILYBeVH
	nOzoShBBbJE7jX+4zIevkjSP4lsioelUdz1IqlUby1T/boQwTcThy0G9GpCXoxqihfVs0G
	E8ew6NtgwJ+nCGUl3FIKxA2RAfbqZ0E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-oGt6ycoXM6Gzk6jQt95DkA-1; Sat,
 21 Feb 2026 13:55:18 -0500
X-MC-Unique: oGt6ycoXM6Gzk6jQt95DkA-1
X-Mimecast-MFC-AGG-ID: oGt6ycoXM6Gzk6jQt95DkA_1771700117
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42E7A1956052;
	Sat, 21 Feb 2026 18:55:16 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ADF4A1955D85;
	Sat, 21 Feb 2026 18:55:11 +0000 (UTC)
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
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v6 7/8] cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug to workqueue
Date: Sat, 21 Feb 2026 13:54:17 -0500
Message-ID: <20260221185418.29319-8-longman@redhat.com>
In-Reply-To: <20260221185418.29319-1-longman@redhat.com>
References: <20260221185418.29319-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14097-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A9B416D9BE
X-Rspamd-Action: no action

The cpuset_handle_hotplug() may need to invoke housekeeping_update(),
for instance, when an isolated partition is invalidated because its
last active CPU has been put offline.

As we are going to enable dynamic update to the nozh_full housekeeping
cpumask (HK_TYPE_KERNEL_NOISE) soon with the help of CPU hotplug,
allowing the CPU hotplug path to call into housekeeping_update() directly
from update_isolation_cpumasks() will likely cause deadlock. So we
have to defer any call to housekeeping_update() after the CPU hotplug
operation has finished. This is now done via the workqueue where
the update_hk_sched_domains() function will be invoked via the
hk_sd_workfn().

An concurrent cpuset control file write may have executed the required
update_hk_sched_domains() function before the work function is called. So
the work function call may become a no-op when it is invoked.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c                        | 31 ++++++++++++++++---
 .../selftests/cgroup/test_cpuset_prs.sh       | 11 ++++++-
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3d0d18bf182f..2c80bfc30bbc 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1323,6 +1323,16 @@ static void update_hk_sched_domains(void)
 		rebuild_sched_domains_locked();
 }
 
+/*
+ * Work function to invoke update_hk_sched_domains()
+ */
+static void hk_sd_workfn(struct work_struct *work)
+{
+	cpuset_full_lock();
+	update_hk_sched_domains();
+	cpuset_full_unlock();
+}
+
 /**
  * rm_siblings_excl_cpus - Remove exclusive CPUs that are used by sibling cpusets
  * @parent: Parent cpuset containing all siblings
@@ -3795,6 +3805,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
  */
 static void cpuset_handle_hotplug(void)
 {
+	static DECLARE_WORK(hk_sd_work, hk_sd_workfn);
 	static cpumask_t new_cpus;
 	static nodemask_t new_mems;
 	bool cpus_updated, mems_updated;
@@ -3877,11 +3888,21 @@ static void cpuset_handle_hotplug(void)
 	}
 
 
-	if (update_housekeeping || force_sd_rebuild) {
-		mutex_lock(&cpuset_mutex);
-		update_hk_sched_domains();
-		mutex_unlock(&cpuset_mutex);
-	}
+	/*
+	 * Queue a work to call housekeeping_update() & rebuild_sched_domains()
+	 * There will be a slight delay before the HK_TYPE_DOMAIN housekeeping
+	 * cpumask can correctly reflect what is in isolated_cpus.
+	 *
+	 * We rely on WORK_STRUCT_PENDING_BIT to not requeue a work item that
+	 * is still pending. Before the pending bit is cleared, the work data
+	 * is copied out and work item dequeued. So it is possible to queue
+	 * the work again before the hk_sd_workfn() is invoked to process the
+	 * previously queued work. Since hk_sd_workfn() doesn't use the work
+	 * item at all, this is not a problem.
+	 */
+	if (update_housekeeping || force_sd_rebuild)
+		queue_work(system_unbound_wq, &hk_sd_work);
+
 	free_tmpmasks(ptmp);
 }
 
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 0c5db118f2d1..dc2dff361ec6 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -246,6 +246,9 @@ TEST_MATRIX=(
 	"  C2-3:P1  C3:P1   .      .     O3=0    .      .      .     0 A1:2|A2: A1:P1|A2:P1"
 	"  C2-3:P1  C3:P1   .      .    T:O2=0   .      .      .     0 A1:3|A2:3 A1:P1|A2:P-1"
 	"  C2-3:P1  C3:P1   .      .      .    T:O3=0   .      .     0 A1:2|A2:2 A1:P1|A2:P-1"
+	"  C2-3:P1  C3:P2   .      .    T:O2=0   .      .      .     0 A1:3|A2:3 A1:P1|A2:P-2"
+	"  C1-3:P1  C3:P2   .      .      .    T:O3=0   .      .     0 A1:1-2|A2:1-2 A1:P1|A2:P-2 3|"
+	"  C1-3:P1  C3:P2   .      .      .    T:O3=0  O3=1    .     0 A1:1-2|A2:3 A1:P1|A2:P2  3"
 	"$SETUP_A123_PARTITIONS    .     O1=0    .      .      .     0 A1:|A2:2|A3:3 A1:P1|A2:P1|A3:P1"
 	"$SETUP_A123_PARTITIONS    .     O2=0    .      .      .     0 A1:1|A2:|A3:3 A1:P1|A2:P1|A3:P1"
 	"$SETUP_A123_PARTITIONS    .     O3=0    .      .      .     0 A1:1|A2:2|A3: A1:P1|A2:P1|A3:P1"
@@ -762,7 +765,7 @@ check_cgroup_states()
 # only CPUs in isolated partitions as well as those that are isolated at
 # boot time.
 #
-# $1 - expected isolated cpu list(s) <isolcpus1>{,<isolcpus2>}
+# $1 - expected isolated cpu list(s) <isolcpus1>{|<isolcpus2>}
 # <isolcpus1> - expected sched/domains value
 # <isolcpus2> - cpuset.cpus.isolated value = <isolcpus1> if not defined
 #
@@ -771,6 +774,7 @@ check_isolcpus()
 	EXPECTED_ISOLCPUS=$1
 	ISCPUS=${CGROUP2}/cpuset.cpus.isolated
 	ISOLCPUS=$(cat $ISCPUS)
+	HKICPUS=$(cat /sys/devices/system/cpu/isolated)
 	LASTISOLCPU=
 	SCHED_DOMAINS=/sys/kernel/debug/sched/domains
 	if [[ $EXPECTED_ISOLCPUS = . ]]
@@ -808,6 +812,11 @@ check_isolcpus()
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
2.53.0


