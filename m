Return-Path: <cgroups+bounces-17391-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TTYNK5E5Q2pyVgoAu9opvQ
	(envelope-from <cgroups+bounces-17391-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 05:35:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF346E01B1
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 05:35:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=fTjnCdHj;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17391-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17391-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D477E304C07A
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 03:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060FF3D34A2;
	Tue, 30 Jun 2026 03:34:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709282E5B02
	for <cgroups@vger.kernel.org>; Tue, 30 Jun 2026 03:34:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782790476; cv=none; b=ZaxWoWGVNFRWdxH6TwMJNjubo+IqyT4iI1tFgZ5zXOJE2x/rErAegOJNLWSWSexUA5ANwezZKw78xe4swuIfNKd+B4rOfBCPP7w2lwt9xIlB6kWswsVtBwmmSRig59ard9VICQLmOisRNOi/HDDICd+ag7wCRp2HvI068xzNtR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782790476; c=relaxed/simple;
	bh=1zYP7AWMSe2LQisOmozCIZ1pT9vYhHKFeXF2hVezRR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBmG3kn1zN2GwFB614hDvePo6ZA9SYjmyL9qnYXqDo8e6u3QXv3eGQJ1EUbWG9FMCCsoST7a+BYDqCVnhT986J798CPVLLlWIx1d4/hAC4AI240DuJYyUm5Xunz29XkqhE72U7BA4/k+FlP29yiUGEr5XQHb9kKxjkAF2XgyhrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTjnCdHj; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782790474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gzCGdoJz9K05gSMHoIBcKzVJ6IPdjGcSgO5/nHPKeq4=;
	b=fTjnCdHjCIQfrywf6s+3uTTHXk227eu3arsZ8D6IHrspuUuwAihDSwcw4Lr6U61zzhBV3a
	Bao4qAU8vp6xwoAERzU2WT0Qce202kuV1kZ2F+qg3idWKnZPkcbXfyF6z7z+QymaIDx6q/
	/M4uWSFjGrClIMAJEqisoHrrnMC2zVU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-WL1UO3kwMpOOUu8O2vHasQ-1; Mon,
 29 Jun 2026 23:34:29 -0400
X-MC-Unique: WL1UO3kwMpOOUu8O2vHasQ-1
X-Mimecast-MFC-AGG-ID: WL1UO3kwMpOOUu8O2vHasQ_1782790467
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 631811955BE3;
	Tue, 30 Jun 2026 03:34:27 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.200])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA535195608D;
	Tue, 30 Jun 2026 03:34:22 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ridong Chen <ridong.chen@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next v9 04/11] cgroup/cpuset: Put all task attach related variables into attach_ctx
Date: Mon, 29 Jun 2026 23:33:37 -0400
Message-ID: <20260630033344.352702-5-longman@redhat.com>
In-Reply-To: <20260630033344.352702-1-longman@redhat.com>
References: <20260630033344.352702-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17391-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:juri.lelli@redhat.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:longman@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AF346E01B1

Put the task attach related cpuset_attach_old_cs and
cpuset_attach_nodemask_to static variables into the new attach_ctx
structure to improve readability and ease maintanence.

No functional change is expected.

Suggested-by: Ridong Chen <ridong.chen@linux.dev>
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Ridong Chen <ridong.chen@linux.dev>
---
 kernel/cgroup/cpuset.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1a78d0590737..47aa8f2fdfdc 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -362,6 +362,8 @@ static DECLARE_WAIT_QUEUE_HEAD(cpuset_attach_wq);
  */
 static struct {
 	int in_progress;
+	struct cpuset *old_cs;	/* Source cpuset */
+	nodemask_t nodemask_to;
 } attach_ctx;
 
 /*
@@ -3015,8 +3017,6 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	return 0;
 }
 
-static struct cpuset *cpuset_attach_old_cs;
-
 /*
  * Check to see if a cpuset can accept a new task
  * For v1, cpus_allowed and mems_allowed can't be empty.
@@ -3048,8 +3048,8 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	int cpu, ret;
 
 	/* used later by cpuset_attach() */
-	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
-	oldcs = cpuset_attach_old_cs;
+	attach_ctx.old_cs = task_cs(cgroup_taskset_first(tset, &css));
+	oldcs = attach_ctx.old_cs;
 	cs = css_cs(css);
 
 	mutex_lock(&cpuset_mutex);
@@ -3152,7 +3152,6 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
  * allocate from cpuset_init().
  */
 static cpumask_var_t cpus_attach;
-static nodemask_t cpuset_attach_nodemask_to;
 
 static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
 {
@@ -3169,7 +3168,7 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
 	 */
 	WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
 
-	cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
+	cpuset_change_task_nodemask(task, &attach_ctx.nodemask_to);
 	cpuset1_update_task_spread_flags(cs, task);
 }
 
@@ -3179,7 +3178,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	struct task_struct *leader;
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
-	struct cpuset *oldcs = cpuset_attach_old_cs;
+	struct cpuset *oldcs = attach_ctx.old_cs;
 	bool cpus_updated, mems_updated;
 	bool queue_task_work = false;
 
@@ -3191,7 +3190,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	cpus_updated = !cpumask_equal(cs->effective_cpus,
 				      oldcs->effective_cpus);
 	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
-	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
+	guarantee_online_mems(cs, &attach_ctx.nodemask_to);
 
 	/*
 	 * In the default hierarchy, enabling cpuset in the child cgroups
@@ -3230,7 +3229,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 			 */
 			if (is_memory_migrate(cs)) {
 				cpuset_migrate_mm(mm, &oldcs->old_mems_allowed,
-						  &cpuset_attach_nodemask_to);
+						  &attach_ctx.nodemask_to);
 				queue_task_work = true;
 			} else
 				mmput(mm);
@@ -3240,7 +3239,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 out:
 	if (queue_task_work)
 		schedule_flush_migrate_mm();
-	cs->old_mems_allowed = cpuset_attach_nodemask_to;
+	cs->old_mems_allowed = attach_ctx.nodemask_to;
 
 	if (cs->nr_migrate_dl_tasks) {
 		atomic_add(cs->nr_migrate_dl_tasks, &cs->nr_deadline_tasks);
@@ -3693,7 +3692,7 @@ static void cpuset_fork(struct task_struct *task)
 
 	/* CLONE_INTO_CGROUP */
 	mutex_lock(&cpuset_mutex);
-	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
+	guarantee_online_mems(cs, &attach_ctx.nodemask_to);
 	cpuset_attach_task(cs, task);
 
 	dec_attach_in_progress_locked();
-- 
2.54.0


