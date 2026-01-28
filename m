Return-Path: <cgroups+bounces-13483-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPg3LgyUeWmOxgEAu9opvQ
	(envelope-from <cgroups+bounces-13483-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 28 Jan 2026 05:43:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FB69D0DD
	for <lists+cgroups@lfdr.de>; Wed, 28 Jan 2026 05:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A1C0300623F
	for <lists+cgroups@lfdr.de>; Wed, 28 Jan 2026 04:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CB13115B5;
	Wed, 28 Jan 2026 04:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1/3Qq1u"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE237C8CE
	for <cgroups@vger.kernel.org>; Wed, 28 Jan 2026 04:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769575432; cv=none; b=lIq597PlO7mSpIvXOBXhfGlZUlMtRHACdNoPYQJaBpqkFe/00DOYvIl2GTlHiphBe10/b4m0BpfIqARf2G6cndzcHkBL/cP3JPHgCJlM3bftjdIKlpAMQErG3JQWJLTPVcxxjfN6SgC+gvOvheK5SgxgFvaCdkadAxVJQgKIi7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769575432; c=relaxed/simple;
	bh=y3AG4ItZTE9YrI/yAlycILOMdlCMh4FiHB0Xw38NcNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsbMC0N0RLJdvBgVJQEpCf8CLHJi93d01zixuhFR0KxSzaMlzPBp1AmhNLlxzW8Fza8FmkNHBeiawOcyoKtfRruy9YkmJphQl/YchYwBpL9xlgQp/lfQ3NQgcWfhnf2qKz5CzP1VP54Ub80ucUunI4TMJ4CRDL/ZTonrn58jQ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1/3Qq1u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769575429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5s8pAN3XHJbPx9PP65YrQaQggkzkJ9pEpC05YMysnA=;
	b=M1/3Qq1uY733JgHgvrtK/dQBBv4wUdP6jWmLkKupUt2M9hiVCM8vbmwHQzKHJVVGYbUBIP
	SUP/TOn0Ff70ewGBnUUYX5jZvg3LJHZF3PjQ0S/vAx5G5JpVKCWCrHvqGBDLO0zjiCUnEs
	3cgWJYRx1tgRmdc5jko43RRmQD8j2WM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-Y8yRFISjPVaxi2pqybcVTg-1; Tue,
 27 Jan 2026 23:43:46 -0500
X-MC-Unique: Y8yRFISjPVaxi2pqybcVTg-1
X-Mimecast-MFC-AGG-ID: Y8yRFISjPVaxi2pqybcVTg_1769575424
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 029BB1800365;
	Wed, 28 Jan 2026 04:43:43 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A37C18002A6;
	Wed, 28 Jan 2026 04:43:39 +0000 (UTC)
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
Subject: [PATCH/for-next 1/2] cgroup/cpuset: Defer housekeeping_update() call from CPU hotplug to task_work
Date: Tue, 27 Jan 2026 23:42:50 -0500
Message-ID: <20260128044251.1229702-2-longman@redhat.com>
In-Reply-To: <20260128044251.1229702-1-longman@redhat.com>
References: <20260128044251.1229702-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13483-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,test_cpuset_prs.sh:url]
X-Rspamd-Queue-Id: 12FB69D0DD
X-Rspamd-Action: no action

The update_isolation_cpumasks() function can be called either directly
from regular cpuset control file write with cpuset_full_lock() called
or via the CPU hotplug path with cpus_write_lock and cpuset_mutex held.

As we are going to enable dynamic update to the nozh_full housekeeping
cpumask (HK_TYPE_KERNEL_NOISE) soon with the help of CPU hotplug,
allowing the CPU hotplug path to call into housekeeping_update()
directly from update_isolation_cpumasks() will cause deadlock. So we
have to defer any call to housekeeping_update() after the CPU hotplug
operation has finished. This can be done via the task_work_add(...,
TWA_RESUME) API where the actual housekeeping_update() call, if needed,
will happen right before existing back to userspace.

Since the HK_TYPE_DOMAIN housekeeping cpumask should now track the
changes in "cpuset.cpus.isolated", add a check in test_cpuset_prs.sh to
confirm that the CPU hotplug deferral, if needed, is working as expected.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c                        | 49 ++++++++++++++++++-
 .../selftests/cgroup/test_cpuset_prs.sh       |  9 ++++
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 7b7d12ab1006..98c7cb732206 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -84,6 +84,10 @@ static cpumask_var_t	isolated_cpus;
  */
 static bool isolated_cpus_updating;
 
+/* Both cpuset_mutex and cpus_read_locked acquired */
+static bool cpuset_full_locked;
+static bool isolation_task_work_queued;
+
 /*
  * A flag to force sched domain rebuild at the end of an operation.
  * It can be set in
@@ -285,10 +289,12 @@ void cpuset_full_lock(void)
 {
 	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
+	cpuset_full_locked = true;
 }
 
 void cpuset_full_unlock(void)
 {
+	cpuset_full_locked = false;
 	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 }
@@ -1285,25 +1291,64 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
 	return false;
 }
 
+static void __update_isolation_cpumasks(bool twork);
+static void isolation_task_work_fn(struct callback_head *cb)
+{
+	cpuset_full_lock();
+	__update_isolation_cpumasks(true);
+	cpuset_full_lock();
+}
+
 /*
- * update_isolation_cpumasks - Update external isolation related CPU masks
+ * __update_isolation_cpumasks - Update external isolation related CPU masks
+ * @twork - set if call from isolation_task_work_fn()
  *
  * The following external CPU masks will be updated if necessary:
  * - workqueue unbound cpumask
  */
-static void update_isolation_cpumasks(void)
+static void __update_isolation_cpumasks(bool twork)
 {
 	int ret;
 
+	if (twork)
+		isolation_task_work_queued = false;
+
 	if (!isolated_cpus_updating)
 		return;
 
+	/*
+	 * This function can be reached either directly from regular cpuset
+	 * control file write (cpuset_full_locked) or via hotplug
+	 * (cpus_write_lock && cpuset_mutex held). In the later case, we
+	 * defer the housekeeping_update() call to a task_work to avoid
+	 * the possibility of deadlock. The task_work will be run right
+	 * before exiting back to userspace.
+	 */
+	if (!cpuset_full_locked) {
+		static struct callback_head twork_cb;
+
+		if (!isolation_task_work_queued) {
+			init_task_work(&twork_cb, isolation_task_work_fn);
+			if (!task_work_add(current, &twork_cb, TWA_RESUME))
+				isolation_task_work_queued = true;
+			else
+				/* Current task shouldn't be exiting */
+				WARN_ON_ONCE(1);
+		}
+		return;
+	}
+
 	ret = housekeeping_update(isolated_cpus);
 	WARN_ON_ONCE(ret < 0);
 
 	isolated_cpus_updating = false;
 }
 
+static inline void update_isolation_cpumasks(void)
+{
+	__update_isolation_cpumasks(false);
+}
+
 /**
  * rm_siblings_excl_cpus - Remove exclusive CPUs that are used by sibling cpusets
  * @parent: Parent cpuset containing all siblings
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 5dff3ad53867..af4a2532cb3e 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -773,6 +773,7 @@ check_isolcpus()
 	EXPECTED_ISOLCPUS=$1
 	ISCPUS=${CGROUP2}/cpuset.cpus.isolated
 	ISOLCPUS=$(cat $ISCPUS)
+	HKICPUS=$(cat /sys/devices/system/cpu/isolated)
 	LASTISOLCPU=
 	SCHED_DOMAINS=/sys/kernel/debug/sched/domains
 	if [[ $EXPECTED_ISOLCPUS = . ]]
@@ -810,6 +811,14 @@ check_isolcpus()
 	ISOLCPUS=
 	EXPECTED_ISOLCPUS=$EXPECTED_SDOMAIN
 
+	#
+	# The inverse of HK_TYPE_DOMAIN cpumask in $HKICPUS should match $ISOLCPUS
+	#
+	[[ "$ISOLCPUS" != "$HKICPUS" ]] && {
+		echo "Housekeeping isolated CPUs mismatch - $HKICPUS"
+		return 1
+	}
+
 	#
 	# Use the sched domain in debugfs to check isolated CPUs, if available
 	#
-- 
2.52.0


