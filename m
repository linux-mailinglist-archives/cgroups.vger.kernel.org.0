Return-Path: <cgroups+bounces-14272-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ALKF9mDnmmGVwQAu9opvQ
	(envelope-from <cgroups+bounces-14272-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:08:41 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0348E191C69
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DBA43067131
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38CF32A3F1;
	Wed, 25 Feb 2026 05:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfARTaN6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB2330B20;
	Wed, 25 Feb 2026 05:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995705; cv=none; b=AoIRoVlz7lErHCfzCD9XmWebj9gon1FkLtTT+zV2fiuKnJFV+ta9DKeFQ1BtTSvldivBn6DJWsP1lgw9V7vheUPR1PF3Xn9H86B5f/c57sFGH1ZfaeIes5zGg7xJs49dVgR5rQlIAjkvjzyWO2H9BjNCZ6ZSTYnhhPliN5LJBgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995705; c=relaxed/simple;
	bh=obJOehZu2XvTRQguZuGzwr3rxugKGbfNoVPxrdGfYTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHGoaJ3+LiDDQ8TPcDhT+mTraRju5/JqT7Uy450Cy1lcvLzauDJIfmNf7mYIwKSYnSDpY7hCtKX1ZMfZkHHmfPM6yVxP4rXOLDI3CvppRwMDHJS1EVLZ+SpsWqxBe93I+yrD45bhM4Ts4biu9jc58IAY/G9IuWVd7ZWPczs8Zek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfARTaN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AEBC116D0;
	Wed, 25 Feb 2026 05:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995705;
	bh=obJOehZu2XvTRQguZuGzwr3rxugKGbfNoVPxrdGfYTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EfARTaN6GVpcjNoUEyWvilShbFEMw8jwEuXysGp4koPvYHWyqstX4Nws57ahmwyfd
	 87yM2/Z4ZYwJ9kGYWopu3UlsheyXdH1psrODIxtg0LSLt3St90xsD1nIM/KSV1Gtad
	 wFMxQ9bMkEtLOIuTAAkUAv/BwCHURboJ5cFx0kFwJG6WlyG9D5u4mk5PtmxyxjNOJd
	 OeqJpFpJUhbGyE3UgNqExFNtjCYdD90wZD9/mlf7ABUKa4/MtiTjeD5UcxOTGRxURl
	 ioHe+NFNR9+qxTjfG55h4i6WdtYhjoyyWLrT+9mFpllHFiChRnz6aY/N50mQ8rB9oR
	 AC3N9/3UrlgQw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 33/34] sched_ext: Add rhashtable lookup for sub-schedulers
Date: Tue, 24 Feb 2026 19:01:08 -1000
Message-ID: <20260225050109.1070059-34-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225050109.1070059-1-tj@kernel.org>
References: <20260225050109.1070059-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14272-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0348E191C69
X-Rspamd-Action: no action

Add rhashtable-based lookup for sub-schedulers indexed by cgroup_id to
enable efficient scheduler discovery in preparation for multiple scheduler
support. The hash table allows quick lookup of the appropriate scheduler
instance when processing tasks from different cgroups.

This extends scx_link_sched() to register sub-schedulers in the hash table
and scx_unlink_sched() to remove them. A new scx_find_sub_sched() function
provides the lookup interface.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 50 +++++++++++++++++++++++++++++++++----
 kernel/sched/ext_internal.h |  2 ++
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5d08971b0832..eccb67a78e90 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -27,6 +27,16 @@ struct scx_sched __rcu *scx_root;
  */
 static LIST_HEAD(scx_sched_all);
 
+#ifdef CONFIG_EXT_SUB_SCHED
+static const struct rhashtable_params scx_sched_hash_params = {
+	.key_len		= sizeof_field(struct scx_sched, ops.sub_cgroup_id),
+	.key_offset		= offsetof(struct scx_sched, ops.sub_cgroup_id),
+	.head_offset		= offsetof(struct scx_sched, hash_node),
+};
+
+static struct rhashtable scx_sched_hash;
+#endif
+
 /*
  * During exit, a task may schedule after losing its PIDs. When disabling the
  * BPF scheduler, we need to be able to iterate tasks in every state to
@@ -285,6 +295,12 @@ static struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos,
 	return NULL;
 }
 
+static struct scx_sched *scx_find_sub_sched(u64 cgroup_id)
+{
+	return rhashtable_lookup(&scx_sched_hash, &cgroup_id,
+				 scx_sched_hash_params);
+}
+
 static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch)
 {
 	rcu_assign_pointer(p->scx.sched, sch);
@@ -292,6 +308,7 @@ static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch)
 #else	/* CONFIG_EXT_SUB_SCHED */
 static struct scx_sched *scx_parent(struct scx_sched *sch) { return NULL; }
 static struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos, struct scx_sched *root) { return pos ? NULL : root; }
+static struct scx_sched *scx_find_sub_sched(u64 cgroup_id) { return NULL; }
 static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch) {}
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
@@ -4806,26 +4823,41 @@ static void refresh_watchdog(void)
 		cancel_delayed_work_sync(&scx_watchdog_work);
 }
 
-static void scx_link_sched(struct scx_sched *sch)
+static s32 scx_link_sched(struct scx_sched *sch)
 {
 	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
 #ifdef CONFIG_EXT_SUB_SCHED
 		struct scx_sched *parent = scx_parent(sch);
-		if (parent)
+		s32 ret;
+
+		if (parent) {
+			ret = rhashtable_lookup_insert_fast(&scx_sched_hash,
+					&sch->hash_node, scx_sched_hash_params);
+			if (ret) {
+				scx_error(sch, "failed to insert into scx_sched_hash (%d)", ret);
+				return ret;
+			}
+
 			list_add_tail(&sch->sibling, &parent->children);
+		}
 #endif	/* CONFIG_EXT_SUB_SCHED */
+
 		list_add_tail_rcu(&sch->all, &scx_sched_all);
 	}
 
 	refresh_watchdog();
+	return 0;
 }
 
 static void scx_unlink_sched(struct scx_sched *sch)
 {
 	scoped_guard(raw_spinlock_irq, &scx_sched_lock) {
 #ifdef CONFIG_EXT_SUB_SCHED
-		if (scx_parent(sch))
+		if (scx_parent(sch)) {
+			rhashtable_remove_fast(&scx_sched_hash, &sch->hash_node,
+					       scx_sched_hash_params);
 			list_del_init(&sch->sibling);
+		}
 #endif	/* CONFIG_EXT_SUB_SCHED */
 		list_del_rcu(&sch->all);
 	}
@@ -5873,7 +5905,9 @@ static s32 scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 */
 	rcu_assign_pointer(scx_root, sch);
 
-	scx_link_sched(sch);
+	ret = scx_link_sched(sch);
+	if (ret)
+		goto err_disable;
 
 	scx_idle_enable(ops);
 
@@ -6134,7 +6168,9 @@ static s32 scx_sub_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		goto out_put_cgrp;
 	}
 
-	scx_link_sched(sch);
+	ret = scx_link_sched(sch);
+	if (ret)
+		goto err_disable;
 
 	if (sch->level >= SCX_SUB_MAX_DEPTH) {
 		scx_error(sch, "max nesting depth %d violated",
@@ -6925,6 +6961,10 @@ void __init init_sched_ext_class(void)
 	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
 	register_sysrq_key('D', &sysrq_sched_ext_dump_op);
 	INIT_DELAYED_WORK(&scx_watchdog_work, scx_watchdog_workfn);
+
+#ifdef CONFIG_EXT_SUB_SCHED
+	BUG_ON(rhashtable_init(&scx_sched_hash, &scx_sched_hash_params));
+#endif	/* CONFIG_EXT_SUB_SCHED */
 }
 
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 99c8a304b726..52ef7f68d298 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1014,6 +1014,8 @@ struct scx_sched {
 	struct list_head	all;
 
 #ifdef CONFIG_EXT_SUB_SCHED
+	struct rhash_head	hash_node;
+
 	struct list_head	children;
 	struct list_head	sibling;
 	struct cgroup		*cgrp;
-- 
2.53.0


