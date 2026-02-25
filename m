Return-Path: <cgroups+bounces-14245-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PnFEFOCnmmTVwQAu9opvQ
	(envelope-from <cgroups+bounces-14245-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:02:11 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA7C191B39
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 168CF30383CA
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD0C2D5410;
	Wed, 25 Feb 2026 05:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOsEbQ31"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5272E1EE0;
	Wed, 25 Feb 2026 05:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995677; cv=none; b=W+h8DIf/iv8zFNT9RAMPF8XmtwbCeuNImzwOmdiULn3ymkvVNTBa0JbJRIxeS/Ffr5vJhOfkCvzuGFcopqOIxaHi1FNnuOIV7kVljFR8LbBJiqQWkzS7pb5niJ5yyelFLBB1V6UvXCxlMwZ+j8XG7iujx7sNBLoIbCTyasXHtnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995677; c=relaxed/simple;
	bh=ixLkCDNjZdvYVjmlQWnMYuMVE5pGYNYKGBL8rTh+X0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzHx7arPw/mjI6xcF1Rue0W+08GQjFZlfE3MIVziSQxGSYki6FyLiyhKVkzTd+sXMR/HPB5W9Y8TuAUVX1jUvz0ILRn9D3YKDGy6grt9S5/U/VHu74ebBwturqDqu00TzrisNaIDaZ6SCQtO2ghRyagLWlxs0z4TP6v6My/sL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOsEbQ31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DDDC2BC86;
	Wed, 25 Feb 2026 05:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995677;
	bh=ixLkCDNjZdvYVjmlQWnMYuMVE5pGYNYKGBL8rTh+X0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AOsEbQ31UMElQlL5zSa4fLXqbYTeXNv3T+JwlaFQuxCo4kc3kkC7D/+ZzEDUEFPHj
	 L6a0N7Fe8BjbONSpN2f4BJTe0CifCRykTzvGFdQ4eMsnVdmwlgqVCr9rX00wPzgmbb
	 489pbOxpHPoN/akwCIPAYVAkYpcbbrrW+eL9eLBpG4zUid4B0n+FhxGOQxP9+3B066
	 8znAygyRyK+LlXtQKM0b++2caWOYslzzo2U16IWsULQGkDY/aFVj+ucpdLgI3CV/N9
	 AqZYkNpx3DjkuuggNIvHRzExNdRCGrkaJ3yBdmnn0IcV6mAOpx/kSHwJ/fvsO3OHej
	 Li+ZFmmTHCRJQ==
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
Subject: [PATCH 06/34] sched_ext: Reorganize enable/disable path for multi-scheduler support
Date: Tue, 24 Feb 2026 19:00:41 -1000
Message-ID: <20260225050109.1070059-7-tj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14245-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCA7C191B39
X-Rspamd-Action: no action

In preparation for multiple scheduler support, reorganize the enable and
disable paths to make scheduler instances explicit. Extract
scx_root_disable() from scx_disable_workfn(). Rename scx_enable() to
scx_root_enable(). Change scx_disable() to take @sch parameter and only
queue disable_work if scx_claim_exit() succeeds for consistency. Move
exit_kind validation into scx_claim_exit(). The sysrq handler now prints a
message when no scheduler is loaded.

These changes don't materially affect user-visible behavior.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 75 ++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a136773461ea..499b4fce8704 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3263,8 +3263,8 @@ void sched_ext_dead(struct task_struct *p)
 	raw_spin_unlock_irqrestore(&scx_tasks_lock, flags);
 
 	/*
-	 * @p is off scx_tasks and wholly ours. scx_enable()'s READY -> ENABLED
-	 * transitions can't race us. Disable ops for @p.
+	 * @p is off scx_tasks and wholly ours. scx_root_enable()'s READY ->
+	 * ENABLED transitions can't race us. Disable ops for @p.
 	 */
 	if (scx_get_task_state(p) != SCX_TASK_NONE) {
 		struct rq_flags rf;
@@ -4423,24 +4423,12 @@ static void free_kick_syncs(void)
 	}
 }
 
-static void scx_disable_workfn(struct kthread_work *work)
+static void scx_root_disable(struct scx_sched *sch)
 {
-	struct scx_sched *sch = container_of(work, struct scx_sched, disable_work);
 	struct scx_exit_info *ei = sch->exit_info;
 	struct scx_task_iter sti;
 	struct task_struct *p;
-	int kind, cpu;
-
-	kind = atomic_read(&sch->exit_kind);
-	while (true) {
-		if (kind == SCX_EXIT_DONE)	/* already disabled? */
-			return;
-		WARN_ON_ONCE(kind == SCX_EXIT_NONE);
-		if (atomic_try_cmpxchg(&sch->exit_kind, &kind, SCX_EXIT_DONE))
-			break;
-	}
-	ei->kind = kind;
-	ei->reason = scx_exit_reason(ei->kind);
+	int cpu;
 
 	/* guarantee forward progress by bypassing scx_ops */
 	scx_bypass(true);
@@ -4584,6 +4572,9 @@ static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 
 	lockdep_assert_preemption_disabled();
 
+	if (WARN_ON_ONCE(kind == SCX_EXIT_NONE || kind == SCX_EXIT_DONE))
+		kind = SCX_EXIT_ERROR;
+
 	if (!atomic_try_cmpxchg(&sch->exit_kind, &none, kind))
 		return false;
 
@@ -4596,21 +4587,31 @@ static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 	return true;
 }
 
-static void scx_disable(enum scx_exit_kind kind)
+static void scx_disable_workfn(struct kthread_work *work)
 {
-	struct scx_sched *sch;
+	struct scx_sched *sch = container_of(work, struct scx_sched, disable_work);
+	struct scx_exit_info *ei = sch->exit_info;
+	int kind;
 
-	if (WARN_ON_ONCE(kind == SCX_EXIT_NONE || kind == SCX_EXIT_DONE))
-		kind = SCX_EXIT_ERROR;
+	kind = atomic_read(&sch->exit_kind);
+	while (true) {
+		if (kind == SCX_EXIT_DONE)	/* already disabled? */
+			return;
+		WARN_ON_ONCE(kind == SCX_EXIT_NONE);
+		if (atomic_try_cmpxchg(&sch->exit_kind, &kind, SCX_EXIT_DONE))
+			break;
+	}
+	ei->kind = kind;
+	ei->reason = scx_exit_reason(ei->kind);
 
-	rcu_read_lock();
-	sch = rcu_dereference(scx_root);
-	if (sch) {
-		guard(preempt)();
-		scx_claim_exit(sch, kind);
+	scx_root_disable(sch);
+}
+
+static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind)
+{
+	guard(preempt)();
+	if (scx_claim_exit(sch, kind))
 		kthread_queue_work(sch->helper, &sch->disable_work);
-	}
-	rcu_read_unlock();
 }
 
 static void dump_newline(struct seq_buf *s)
@@ -5115,13 +5116,13 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 	return 0;
 }
 
-static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
+static s32 scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 {
 	struct scx_sched *sch;
 	struct scx_task_iter sti;
 	struct task_struct *p;
 	unsigned long timeout;
-	int i, cpu, ret;
+	s32 i, cpu, ret;
 
 	if (!cpumask_equal(housekeeping_cpumask(HK_TYPE_DOMAIN),
 			   cpu_possible_mask)) {
@@ -5368,7 +5369,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 * Flush scx_disable_work to ensure that error is reported before init
 	 * completion. sch's base reference will be put by bpf_scx_unreg().
 	 */
-	scx_error(sch, "scx_enable() failed (%d)", ret);
+	scx_error(sch, "scx_root_enable() failed (%d)", ret);
 	kthread_flush_work(&sch->disable_work);
 	return 0;
 }
@@ -5500,7 +5501,7 @@ static int bpf_scx_check_member(const struct btf_type *t,
 
 static int bpf_scx_reg(void *kdata, struct bpf_link *link)
 {
-	return scx_enable(kdata, link);
+	return scx_root_enable(kdata, link);
 }
 
 static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
@@ -5508,7 +5509,7 @@ static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
 	struct sched_ext_ops *ops = kdata;
 	struct scx_sched *sch = ops->priv;
 
-	scx_disable(SCX_EXIT_UNREG);
+	scx_disable(sch, SCX_EXIT_UNREG);
 	kthread_flush_work(&sch->disable_work);
 	kobject_put(&sch->kobj);
 }
@@ -5636,7 +5637,15 @@ static struct bpf_struct_ops bpf_sched_ext_ops = {
 
 static void sysrq_handle_sched_ext_reset(u8 key)
 {
-	scx_disable(SCX_EXIT_SYSRQ);
+	struct scx_sched *sch;
+
+	rcu_read_lock();
+	sch = rcu_dereference(scx_root);
+	if (likely(sch))
+		scx_disable(sch, SCX_EXIT_SYSRQ);
+	else
+		pr_info("sched_ext: BPF schedulers not loaded\n");
+	rcu_read_unlock();
 }
 
 static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
-- 
2.53.0


