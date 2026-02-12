Return-Path: <cgroups+bounces-13902-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AANTO3MFjmlf+gAAu9opvQ
	(envelope-from <cgroups+bounces-13902-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 17:53:07 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD5312FAAC
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 17:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E738A30363A9
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 16:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B0F35DD05;
	Thu, 12 Feb 2026 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBaoYLz1"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADAE35EDA7
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914906; cv=none; b=C8V2J3SQxxlXTFltSEoigqDXXzJEugfU3X4IVJssvo80pTWtRTFAQ6JXOix3HVCXejpvEEFN+pJJ9ZBpn8Wrls+8uk6LECWxa5VuJbmwZN+m66e8ZA0jiq2OI3mBjH8ScQGIGEed15ptksgDzgxEmwkiDw95rnTUXohvF5QDBiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914906; c=relaxed/simple;
	bh=wRty8/J2pFM4dDwWYkfELVBdIV2Rf3GmWv2P4m107Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fF1Q31AHDqIDUbzVAhPPClVF8UtyQ7WLy8jX5zxoYws+w+rWJvFnm5BXO1Zs4uRAfCcZM3XoUI9L30OdSXQuuYzdDzbbxbpPRSeCAsBZgL4t+1DvZyV7XeYt9FZV/mhn5yg4tzrmV5/TQU4idNPHBRZN9PjCM8ZbP3GAmFC/P/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBaoYLz1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770914901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LhafozxLtbCRF/ar7/h7DrTiUYnhUT7qKI+AsTwZgJM=;
	b=YBaoYLz1n0tW64mM0mh/v4dAuOLhqBi+i6fR388IcspegFn8QcxXzInBxZgfp7fUniZZrz
	2ra14QLuevCg7vqq5PkSS4RmSGF0nTAqQs4p0jvUafxeTa80jLvXjweldQwMWh8ZEYUZQ5
	2tGJR7UDqdd4HaNf+ZTa8VH6gVQSb3k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-nu4QUERNN460wplI7OHY6w-1; Thu,
 12 Feb 2026 11:48:15 -0500
X-MC-Unique: nu4QUERNN460wplI7OHY6w-1
X-Mimecast-MFC-AGG-ID: nu4QUERNN460wplI7OHY6w_1770914893
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 333D818007E9;
	Thu, 12 Feb 2026 16:48:13 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.194])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D564F1800286;
	Thu, 12 Feb 2026 16:48:09 +0000 (UTC)
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
Subject: [PATCH v5 4/6] cgroup/cpuset: Don't update isolated_cpus from CPU hotplug
Date: Thu, 12 Feb 2026 11:46:38 -0500
Message-ID: <20260212164640.2408295-5-longman@redhat.com>
In-Reply-To: <20260212164640.2408295-1-longman@redhat.com>
References: <20260212164640.2408295-1-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13902-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BD5312FAAC
X-Rspamd-Action: no action

As any change to isolated_cpus is going to be propagated to the
HK_TYPE_DOMAIN housekeeping cpumask, it can be problematic if
housekeeping cpumasks are directly being modified from the CPU hotplug
code path. This is especially the case if we are going to enable dynamic
update to the nohz_full housekeeping cpumask (HK_TYPE_KERNEL_NOISE)
in the near future with the help of CPU hotplug.

Avoid these potential problems by changing the cpuset code to not
updating isolated_cpus when calling from CPU hotplug. A new special
PRS_INVALID_ISOLCPUS is added to indicate the current cpuset is an
invalid partition but its effective_xcpus are still in isolated_cpus.
This special state will be set if an isolated partition becomes invalid
due to the shutdown of the last active CPU in that partition. We also
need to keep the effective_xcpus even if exclusive_cpus isn't set.

When changes are made to "cpuset.cpus", "cpuset.cpus.exclusive" or
"cpuset.cpus.partition" of a PRS_INVALID_ISOLCPUS cpuset, its state
will be reset back to PRS_INVALID_ISOLATED and its effective_xcpus will
be removed from isolated_cpus before proceeding.

As CPU hotplug will no longer update isolated_cpus, some of the test
cases in test_cpuset_prs.h will have to be updated to match the new
expected results. Some new test cases are also added to confirm that
"cpuset.cpus.isolated" and HK_TYPE_DOMAIN housekeeping cpumask will
both be updated.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c                        | 85 ++++++++++++++++---
 .../selftests/cgroup/test_cpuset_prs.sh       | 21 +++--
 2 files changed, 87 insertions(+), 19 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c792380f9b60..48b7f275085b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -159,6 +159,8 @@ static bool force_sd_rebuild;			/* RWCS */
  *   2 - partition root without load balancing (isolated)
  *  -1 - invalid partition root
  *  -2 - invalid isolated partition root
+ *  -3 - invalid isolated partition root but with effective xcpus still
+ *	 in isolated_cpus (set from CPU hotplug side)
  *
  *  There are 2 types of partitions - local or remote. Local partitions are
  *  those whose parents are partition root themselves. Setting of
@@ -187,6 +189,7 @@ static bool force_sd_rebuild;			/* RWCS */
 #define PRS_ISOLATED		2
 #define PRS_INVALID_ROOT	-1
 #define PRS_INVALID_ISOLATED	-2
+#define PRS_INVALID_ISOLCPUS	-3 /* Effective xcpus still in isolated_cpus */
 
 /*
  * Temporary cpumasks for working with partitions that are passed among
@@ -382,6 +385,30 @@ static inline bool is_in_v2_mode(void)
 	      (cpuset_cgrp_subsys.root->flags & CGRP_ROOT_CPUSET_V2_MODE);
 }
 
+/*
+ * If the given cpuset has a partition state of PRS_INVALID_ISOLCPUS,
+ * remove its effective_xcpus from isolated_cpus and reset its state to
+ * PRS_INVALID_ISOLATED. Also clear effective_xcpus if exclusive_cpus is
+ * empty.
+ */
+static void fix_invalid_isolcpus(struct cpuset *cs, struct cpuset *trialcs)
+{
+	if (likely(cs->partition_root_state != PRS_INVALID_ISOLCPUS))
+		return;
+	WARN_ON_ONCE(cpumask_empty(cs->effective_xcpus));
+	spin_lock_irq(&callback_lock);
+	cpumask_andnot(isolated_cpus, isolated_cpus, cs->effective_xcpus);
+	if (cpumask_empty(cs->exclusive_cpus))
+		cpumask_clear(cs->effective_xcpus);
+	cs->partition_root_state = PRS_INVALID_ISOLATED;
+	spin_unlock_irq(&callback_lock);
+	isolated_cpus_updating = true;
+	if (trialcs) {
+		trialcs->partition_root_state = PRS_INVALID_ISOLATED;
+		cpumask_copy(trialcs->effective_xcpus, cs->effective_xcpus);
+	}
+}
+
 /**
  * partition_is_populated - check if partition has tasks
  * @cs: partition root to be checked
@@ -1160,7 +1187,8 @@ static void reset_partition_data(struct cpuset *cs)
 
 	lockdep_assert_held(&callback_lock);
 
-	if (cpumask_empty(cs->exclusive_cpus)) {
+	if (cpumask_empty(cs->exclusive_cpus) &&
+	    (cs->partition_root_state != PRS_INVALID_ISOLCPUS)) {
 		cpumask_clear(cs->effective_xcpus);
 		if (is_cpu_exclusive(cs))
 			clear_bit(CS_CPU_EXCLUSIVE, &cs->flags);
@@ -1189,6 +1217,10 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
 			return;
 		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
 	}
+	/*
+	 * Shouldn't update isolated_cpus from CPU hotplug
+	 */
+	WARN_ON_ONCE(current->flags & PF_KTHREAD);
 	isolated_cpus_updating = true;
 }
 
@@ -1208,7 +1240,6 @@ static void partition_xcpus_add(int new_prs, struct cpuset *parent,
 	if (!parent)
 		parent = &top_cpuset;
 
-
 	if (parent == &top_cpuset)
 		cpumask_or(subpartitions_cpus, subpartitions_cpus, xcpus);
 
@@ -1224,11 +1255,12 @@ static void partition_xcpus_add(int new_prs, struct cpuset *parent,
  * @old_prs: old partition_root_state
  * @parent: parent cpuset
  * @xcpus: exclusive CPUs to be removed
+ * @no_isolcpus: don't update isolated_cpus
  *
  * Remote partition if parent == NULL
  */
 static void partition_xcpus_del(int old_prs, struct cpuset *parent,
-				struct cpumask *xcpus)
+				struct cpumask *xcpus, bool no_isolcpus)
 {
 	WARN_ON_ONCE(old_prs < 0);
 	lockdep_assert_held(&callback_lock);
@@ -1238,7 +1270,7 @@ static void partition_xcpus_del(int old_prs, struct cpuset *parent,
 	if (parent == &top_cpuset)
 		cpumask_andnot(subpartitions_cpus, subpartitions_cpus, xcpus);
 
-	if (old_prs != parent->partition_root_state)
+	if ((old_prs != parent->partition_root_state) && !no_isolcpus)
 		isolated_cpus_update(old_prs, parent->partition_root_state,
 				     xcpus);
 
@@ -1496,6 +1528,8 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
  */
 static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 {
+	int old_prs = cs->partition_root_state;
+
 	WARN_ON_ONCE(!is_remote_partition(cs));
 	/*
 	 * When a CPU is offlined, top_cpuset may end up with no available CPUs,
@@ -1508,14 +1542,24 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 
 	spin_lock_irq(&callback_lock);
 	cs->remote_partition = false;
-	partition_xcpus_del(cs->partition_root_state, NULL, cs->effective_xcpus);
 	if (cs->prs_err)
 		cs->partition_root_state = -cs->partition_root_state;
 	else
 		cs->partition_root_state = PRS_MEMBER;
+	/*
+	 * Don't update isolated_cpus if calling from CPU hotplug kthread
+	 */
+	if ((current->flags & PF_KTHREAD) &&
+	    (cs->partition_root_state == PRS_INVALID_ISOLATED))
+		cs->partition_root_state = PRS_INVALID_ISOLCPUS;
 
-	/* effective_xcpus may need to be changed */
-	compute_excpus(cs, cs->effective_xcpus);
+	partition_xcpus_del(old_prs, NULL, cs->effective_xcpus,
+			    cs->partition_root_state == PRS_INVALID_ISOLCPUS);
+	/*
+	 * effective_xcpus may need to be changed
+	 */
+	if (cs->partition_root_state != PRS_INVALID_ISOLCPUS)
+		compute_excpus(cs, cs->effective_xcpus);
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
 	update_isolation_cpumasks();
@@ -1580,7 +1624,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	if (adding)
 		partition_xcpus_add(prs, NULL, tmp->addmask);
 	if (deleting)
-		partition_xcpus_del(prs, NULL, tmp->delmask);
+		partition_xcpus_del(prs, NULL, tmp->delmask, false);
 	/*
 	 * Need to update effective_xcpus and exclusive_cpus now as
 	 * update_sibling_cpumasks() below may iterate back to the same cs.
@@ -1893,6 +1937,10 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 			if (!part_error)
 				new_prs = -old_prs;
 			break;
+		case PRS_INVALID_ISOLCPUS:
+			if (!part_error)
+				new_prs = PRS_ISOLATED;
+			break;
 		}
 	}
 
@@ -1923,12 +1971,19 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	if (old_prs != new_prs)
 		cs->partition_root_state = new_prs;
 
+	/*
+	 * Don't update isolated_cpus if calling from CPU hotplug kthread
+	 */
+	if ((current->flags & PF_KTHREAD) &&
+	    (cs->partition_root_state == PRS_INVALID_ISOLATED))
+		cs->partition_root_state = PRS_INVALID_ISOLCPUS;
 	/*
 	 * Adding to parent's effective_cpus means deletion CPUs from cs
 	 * and vice versa.
 	 */
 	if (adding)
-		partition_xcpus_del(old_prs, parent, tmp->addmask);
+		partition_xcpus_del(old_prs, parent, tmp->addmask,
+				    cs->partition_root_state == PRS_INVALID_ISOLCPUS);
 	if (deleting)
 		partition_xcpus_add(new_prs, parent, tmp->delmask);
 
@@ -2317,6 +2372,7 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
 	if (cs_is_member(cs))
 		return;
 
+	fix_invalid_isolcpus(cs, trialcs);
 	prs_err = validate_partition(cs, trialcs);
 	if (prs_err)
 		trialcs->prs_err = cs->prs_err = prs_err;
@@ -2818,6 +2874,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	if (alloc_tmpmasks(&tmpmask))
 		return -ENOMEM;
 
+	fix_invalid_isolcpus(cs, NULL);
 	err = update_partition_exclusive_flag(cs, new_prs);
 	if (err)
 		goto out;
@@ -3268,6 +3325,7 @@ static int cpuset_partition_show(struct seq_file *seq, void *v)
 		type = "root";
 		fallthrough;
 	case PRS_INVALID_ISOLATED:
+	case PRS_INVALID_ISOLCPUS:
 		if (!type)
 			type = "isolated";
 		err = perr_strings[READ_ONCE(cs->prs_err)];
@@ -3463,9 +3521,9 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 }
 
 /*
- * If a dying cpuset has the 'cpus.partition' enabled, turn it off by
- * changing it back to member to free its exclusive CPUs back to the pool to
- * be used by other online cpusets.
+ * If a dying cpuset has the 'cpus.partition' enabled or is in the
+ * PRS_INVALID_ISOLCPUS state, turn it off by changing it back to member to
+ * free its exclusive CPUs back to the pool to be used by other online cpusets.
  */
 static void cpuset_css_killed(struct cgroup_subsys_state *css)
 {
@@ -3473,7 +3531,8 @@ static void cpuset_css_killed(struct cgroup_subsys_state *css)
 
 	cpuset_full_lock();
 	/* Reset valid partition back to member */
-	if (is_partition_valid(cs))
+	if (is_partition_valid(cs) ||
+	    (cs->partition_root_state == PRS_INVALID_ISOLCPUS))
 		update_prstate(cs, PRS_MEMBER);
 	cpuset_full_unlock();
 }
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 5dff3ad53867..380506157f70 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -234,6 +234,7 @@ TEST_MATRIX=(
 	"$SETUP_A123_PARTITIONS    .     C2-3    .      .      .     0 A1:|A2:2|A3:3 A1:P1|A2:P1|A3:P1"
 
 	# CPU offlining cases:
+	# cpuset.cpus.isolated should no longer be updated.
 	"   C0-1     .      .    C2-3    S+    C4-5     .     O2=0   0 A1:0-1|B1:3"
 	"C0-3:P1:S+ C2-3:P1 .      .     O2=0    .      .      .     0 A1:0-1|A2:3"
 	"C0-3:P1:S+ C2-3:P1 .      .     O2=0   O2=1    .      .     0 A1:0-1|A2:2-3"
@@ -245,8 +246,9 @@ TEST_MATRIX=(
 	"C2-3:P1:S+  C3:P2  .      .     O2=0   O2=1    .      .     0 A1:2|A2:3 A1:P1|A2:P2"
 	"C2-3:P1:S+  C3:P1  .      .     O2=0    .      .      .     0 A1:|A2:3 A1:P1|A2:P1"
 	"C2-3:P1:S+  C3:P1  .      .     O3=0    .      .      .     0 A1:2|A2: A1:P1|A2:P1"
-	"C2-3:P1:S+  C3:P1  .      .    T:O2=0   .      .      .     0 A1:3|A2:3 A1:P1|A2:P-1"
-	"C2-3:P1:S+  C3:P1  .      .      .    T:O3=0   .      .     0 A1:2|A2:2 A1:P1|A2:P-1"
+	"C2-3:P1:S+  C3:P2  .      .    T:O2=0   .      .      .     0 A1:3|A2:3 A1:P1|A2:P-2"
+	"C1-3:P1:S+  C3:P2  .      .      .    T:O3=0   .      .     0 A1:1-2|A2:1-2|XA2:3 A1:P1|A2:P-2 3"
+	"C1-3:P1:S+  C3:P2  .      .      .    T:O3=0  O3=1    .     0 A1:1-2|A2:3|XA2:3 A1:P1|A2:P2  3"
 	"$SETUP_A123_PARTITIONS    .     O1=0    .      .      .     0 A1:|A2:2|A3:3 A1:P1|A2:P1|A3:P1"
 	"$SETUP_A123_PARTITIONS    .     O2=0    .      .      .     0 A1:1|A2:|A3:3 A1:P1|A2:P1|A3:P1"
 	"$SETUP_A123_PARTITIONS    .     O3=0    .      .      .     0 A1:1|A2:2|A3: A1:P1|A2:P1|A3:P1"
@@ -299,13 +301,14 @@ TEST_MATRIX=(
 								       A1:P0|A2:P2|A3:P-1 2-4"
 
 	# Remote partition offline tests
+	# CPU offline shouldn't change cpuset.cpus.{isolated,exclusive.effective}
 	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 .   0 A1:0-1|A2:1|A3:3 A1:P0|A3:P2 2-3"
 	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 O2=1 0 A1:0-1|A2:1|A3:2-3 A1:P0|A3:P2 2-3"
-	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3    P2:O3=0   .   0 A1:0-2|A2:1-2|A3: A1:P0|A3:P2 3"
-	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3   T:P2:O3=0  .   0 A1:0-2|A2:1-2|A3:1-2 A1:P0|A3:P-2 3|"
+	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3    P2:O3=0   .   0 A1:0-2|A2:1-2|A3:|XA3:3 A1:P0|A3:P2 3"
+	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3   T:P2:O3=0  .   0 A1:0-2|A2:1-2|A3:1-2|XA3:3 A1:P0|A3:P-2 3"
 
 	# An invalidated remote partition cannot self-recover from hotplug
-	" C0-3:S+ C1-3:S+  C2      .    X2-3   X2-3   T:P2:O2=0 O2=1 0 A1:0-3|A2:1-3|A3:2 A1:P0|A3:P-2 ."
+	" C0-3:S+ C1-3:S+  C2      .    X2-3   X2-3   T:P2:O2=0 O2=1 0 A1:0-3|A2:1-3|A3:2|XA3:2 A1:P0|A3:P-2 2"
 
 	# cpus.exclusive.effective clearing test
 	" C0-3:S+ C1-3:S+  C2      .   X2-3:X    .      .      .     0 A1:0-3|A2:1-3|A3:2|XA1:"
@@ -764,7 +767,7 @@ check_cgroup_states()
 # only CPUs in isolated partitions as well as those that are isolated at
 # boot time.
 #
-# $1 - expected isolated cpu list(s) <isolcpus1>{,<isolcpus2>}
+# $1 - expected isolated cpu list(s) <isolcpus1>{|<isolcpus2>}
 # <isolcpus1> - expected sched/domains value
 # <isolcpus2> - cpuset.cpus.isolated value = <isolcpus1> if not defined
 #
@@ -773,6 +776,7 @@ check_isolcpus()
 	EXPECTED_ISOLCPUS=$1
 	ISCPUS=${CGROUP2}/cpuset.cpus.isolated
 	ISOLCPUS=$(cat $ISCPUS)
+	HKICPUS=$(cat /sys/devices/system/cpu/isolated)
 	LASTISOLCPU=
 	SCHED_DOMAINS=/sys/kernel/debug/sched/domains
 	if [[ $EXPECTED_ISOLCPUS = . ]]
@@ -810,6 +814,11 @@ check_isolcpus()
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


