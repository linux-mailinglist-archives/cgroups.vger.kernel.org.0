Return-Path: <cgroups+bounces-13900-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIDbCBwFjmnO+gAAu9opvQ
	(envelope-from <cgroups+bounces-13900-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 17:51:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF2812FA6E
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 17:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57E8531705DA
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BA035DD01;
	Thu, 12 Feb 2026 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJFp++jU"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C5B35D60A
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914896; cv=none; b=XVkE2Re8NCoQgQzmFB3I1lg0UsOvl2g5hCWN7IBh7DJRWdcjeYMR8GBL1ywzpP4a08G9t2filrd2cJvAYiBZfyNDnWrLwDt/O0rGAg08wHerHaBNjKm0WcGUQB/qGbc3rzXKKY0AkksJJ0MEAH3XPK2zHIVaFWkE5kkxVPNyMtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914896; c=relaxed/simple;
	bh=cJNvne/ZLJKp+G6468ZX9HggWJl+I1tTdNbXK0Elgd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/Uz469Ka0C2ogojFyClOEGPuxgCZjKEmUPXUXmTjul8WapXQfi/7KfHNH0XIV1Gu/dZgNq7FcYSAh+0zd0r5FQtqj0pxUqXMvMH+8VstCaBjTcr4YoZQ264HtufT+t1LM0t4FjgSTeJ67ilv19wxNkWodLGAB5JG+dVZ6MKdUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJFp++jU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770914894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMXLyoHDIGkd1WS8t/CaMj6jAYKwVeoWZxQZ060QjgI=;
	b=fJFp++jUlU5HGZ8pmbjZSJwOwFDZM7YnUwf/PX6AjfBq5Hb2BPbOU4OdWLke1Ky4EOVjq+
	z1W5qy5j1PIGImOakjuQJQX3D9+G62SoNzmkklXlrENT9GZOZXEOLQstAJD0eDBFQfw5jh
	NkFEKJhjPUZpMleB8hUSPmKwQtzFAUY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-z40GFMGmOKuntaRGRm0B4g-1; Thu,
 12 Feb 2026 11:48:09 -0500
X-MC-Unique: z40GFMGmOKuntaRGRm0B4g-1
X-Mimecast-MFC-AGG-ID: z40GFMGmOKuntaRGRm0B4g_1770914886
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7179D1955BE0;
	Thu, 12 Feb 2026 16:48:06 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.194])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33AE118003F5;
	Thu, 12 Feb 2026 16:48:03 +0000 (UTC)
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
Subject: [PATCH v5 2/6] cgroup/cpuset: Clarify exclusion rules for cpuset internal variables
Date: Thu, 12 Feb 2026 11:46:36 -0500
Message-ID: <20260212164640.2408295-3-longman@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-13900-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 7EF2812FA6E
X-Rspamd-Action: no action

Clarify the locking rules associated with file level internal variables
inside the cpuset code. There is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 105 ++++++++++++++++++++++++-----------------
 1 file changed, 61 insertions(+), 44 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a366ef84f982..e55855269432 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -61,6 +61,58 @@ static const char * const perr_strings[] = {
 	[PERR_REMOTE]    = "Have remote partition underneath",
 };
 
+/*
+ * CPUSET Locking Convention
+ * -------------------------
+ *
+ * Below are the three global locks guarding cpuset structures in lock
+ * acquisition order:
+ *  - cpu_hotplug_lock (cpus_read_lock/cpus_write_lock)
+ *  - cpuset_mutex
+ *  - callback_lock (raw spinlock)
+ *
+ * A task must hold all the three locks to modify externally visible or
+ * used fields of cpusets, though some of the internally used cpuset fields
+ * and internal variables can be modified without holding callback_lock. If only
+ * reliable read access of the externally used fields are needed, a task can
+ * hold either cpuset_mutex or callback_lock which are exposed to other
+ * external subsystems.
+ *
+ * If a task holds cpu_hotplug_lock and cpuset_mutex, it blocks others,
+ * ensuring that it is the only task able to also acquire callback_lock and
+ * be able to modify cpusets.  It can perform various checks on the cpuset
+ * structure first, knowing nothing will change. It can also allocate memory
+ * without holding callback_lock. While it is performing these checks, various
+ * callback routines can briefly acquire callback_lock to query cpusets.  Once
+ * it is ready to make the changes, it takes callback_lock, blocking everyone
+ * else.
+ *
+ * Calls to the kernel memory allocator cannot be made while holding
+ * callback_lock which is a spinlock, as the memory allocator may sleep or
+ * call back into cpuset code and acquire callback_lock.
+ *
+ * Now, the task_struct fields mems_allowed and mempolicy may be changed
+ * by other task, we use alloc_lock in the task_struct fields to protect
+ * them.
+ *
+ * The cpuset_common_seq_show() handlers only hold callback_lock across
+ * small pieces of code, such as when reading out possibly multi-word
+ * cpumasks and nodemasks.
+ */
+
+static DEFINE_MUTEX(cpuset_mutex);
+
+/*
+ * File level internal variables below follow one of the following exclusion
+ * rules.
+ *
+ * RWCS: Read/write-able by holding either cpus_write_lock (and optionally
+ *	 cpuset_mutex) or both cpus_read_lock and cpuset_mutex.
+ *
+ * CSCB: Readable by holding either cpuset_mutex or callback_lock. Writable
+ *	 by holding both cpuset_mutex and callback_lock.
+ */
+
 /*
  * For local partitions, update to subpartitions_cpus & isolated_cpus is done
  * in update_parent_effective_cpumask(). For remote partitions, it is done in
@@ -70,19 +122,18 @@ static const char * const perr_strings[] = {
  * Exclusive CPUs distributed out to local or remote sub-partitions of
  * top_cpuset
  */
-static cpumask_var_t	subpartitions_cpus;
+static cpumask_var_t	subpartitions_cpus;	/* RWCS */
 
 /*
- * Exclusive CPUs in isolated partitions
+ * Exclusive CPUs in isolated partitions (shown in cpuset.cpus.isolated)
  */
-static cpumask_var_t	isolated_cpus;
+static cpumask_var_t	isolated_cpus;		/* CSCB */
 
 /*
- * isolated_cpus updating flag (protected by cpuset_mutex)
- * Set if isolated_cpus is going to be updated in the current
- * cpuset_mutex crtical section.
+ * Set if isolated_cpus is being updated in the current cpuset_mutex
+ * critical section.
  */
-static bool isolated_cpus_updating;
+static bool		isolated_cpus_updating;	/* RWCS */
 
 /*
  * A flag to force sched domain rebuild at the end of an operation.
@@ -98,7 +149,7 @@ static bool isolated_cpus_updating;
  * Note that update_relax_domain_level() in cpuset-v1.c can still call
  * rebuild_sched_domains_locked() directly without using this flag.
  */
-static bool force_sd_rebuild;
+static bool force_sd_rebuild;			/* RWCS */
 
 /*
  * Partition root states:
@@ -218,42 +269,6 @@ struct cpuset top_cpuset = {
 	.partition_root_state = PRS_ROOT,
 };
 
-/*
- * There are two global locks guarding cpuset structures - cpuset_mutex and
- * callback_lock. The cpuset code uses only cpuset_mutex. Other kernel
- * subsystems can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
- * structures. Note that cpuset_mutex needs to be a mutex as it is used in
- * paths that rely on priority inheritance (e.g. scheduler - on RT) for
- * correctness.
- *
- * A task must hold both locks to modify cpusets.  If a task holds
- * cpuset_mutex, it blocks others, ensuring that it is the only task able to
- * also acquire callback_lock and be able to modify cpusets.  It can perform
- * various checks on the cpuset structure first, knowing nothing will change.
- * It can also allocate memory while just holding cpuset_mutex.  While it is
- * performing these checks, various callback routines can briefly acquire
- * callback_lock to query cpusets.  Once it is ready to make the changes, it
- * takes callback_lock, blocking everyone else.
- *
- * Calls to the kernel memory allocator can not be made while holding
- * callback_lock, as that would risk double tripping on callback_lock
- * from one of the callbacks into the cpuset code from within
- * __alloc_pages().
- *
- * If a task is only holding callback_lock, then it has read-only
- * access to cpusets.
- *
- * Now, the task_struct fields mems_allowed and mempolicy may be changed
- * by other task, we use alloc_lock in the task_struct fields to protect
- * them.
- *
- * The cpuset_common_seq_show() handlers only hold callback_lock across
- * small pieces of code, such as when reading out possibly multi-word
- * cpumasks and nodemasks.
- */
-
-static DEFINE_MUTEX(cpuset_mutex);
-
 /**
  * cpuset_lock - Acquire the global cpuset mutex
  *
@@ -1163,6 +1178,8 @@ static void reset_partition_data(struct cpuset *cs)
 static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus)
 {
 	WARN_ON_ONCE(old_prs == new_prs);
+	lockdep_assert_held(&callback_lock);
+	lockdep_assert_held(&cpuset_mutex);
 	if (new_prs == PRS_ISOLATED)
 		cpumask_or(isolated_cpus, isolated_cpus, xcpus);
 	else
-- 
2.52.0


