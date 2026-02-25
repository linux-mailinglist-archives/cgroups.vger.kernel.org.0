Return-Path: <cgroups+bounces-14267-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FfOBbaEnmmGVwQAu9opvQ
	(envelope-from <cgroups+bounces-14267-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:12:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2C3191D37
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 951F0311A715
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D013195FD;
	Wed, 25 Feb 2026 05:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hja/8XeL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D1313E1A;
	Wed, 25 Feb 2026 05:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995700; cv=none; b=GOJNuHfOGSw6C23mJ2DSvzO1NOrb02a84RFmBgAlKkFQ/Il6ezNUoWPw9CWxTyplhtF7g4kZ2Q1BhKpMQ2p+Rx+f3pk7h8OMwC0eyf18q+Qf+o3Fl/NCRyLJ8wMdZ7KIeb/lbv04YwWGzKiQOW8kC8M2+WyJ34cqGAXMmXI85Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995700; c=relaxed/simple;
	bh=6ybH007v82MGV8MZyuPwTZoO3XpV9c7hdoSBx/ckPJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyvSx6gC8Vo+bbnTkQMGppKk+R761LkbHrISoBKBhY0UTWRfz5X7ZU/T+/nnikonWRTBBpMKreH0ggd+PEHi3BrlQgnc5lEEcS5FPwGm30ePxDGmGdRq4/K05b4OXq6GIsyN+Uq6cmsBaiE1p0pJpkZ1vul27DHyrE3aH/cEW20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hja/8XeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC379C116D0;
	Wed, 25 Feb 2026 05:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995700;
	bh=6ybH007v82MGV8MZyuPwTZoO3XpV9c7hdoSBx/ckPJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hja/8XeLJLt+zRPqAZu1tDutFPUnzBLCDqZh3+F+8q3/YMT+J15gdgGh+eA20kXYY
	 U5teHOZGQhiK1X2jKdX30fsisVN842smsprTo2hse/d1v/IPfG3O2lXQIERMFlrN/P
	 q8BiccoIKrYQic3DLDAbeJcYXwHu/HP6AcHelUn/wfEWw3jY6YCV2n+MSMtBKU+8Ol
	 6d6IY+Fwtr0ZuxOFExaLcEkgLOVcTTySeS1ij2GZBd9qJXzTJUu7PN6W5BHaiGDNb7
	 oD/qIim/5dRY4MlIR+wdM7LvBxgRjVkVXBR+x2yACnonKBw/aQdg4X0GfYxnlnJmMO
	 DTERVeE6P/i/g==
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
Subject: [PATCH 28/34] sched_ext: Support dumping multiple schedulers and add scheduler identification
Date: Tue, 24 Feb 2026 19:01:03 -1000
Message-ID: <20260225050109.1070059-29-tj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14267-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E2C3191D37
X-Rspamd-Action: no action

Extend scx_dump_state() to support multiple schedulers and improve task
identification in dumps. The function now takes a specific scheduler to
dump and can optionally filter tasks by scheduler.

scx_dump_task() now displays which scheduler each task belongs to, using
"*" to mark tasks owned by the scheduler being dumped. Sub-schedulers
are identified with their level and cgroup ID.

The SysRq-D handler now iterates through all active schedulers under
scx_sched_lock and dumps each one separately. For SysRq-D dumps, only
tasks owned by each scheduler are dumped to avoid redundancy since all
schedulers are being dumped. Error-triggered dumps continue to dump all
tasks since only that specific scheduler is being dumped.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 54 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2a1db509bcbc..ea29e77abb46 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5156,22 +5156,34 @@ static void ops_dump_exit(void)
 	scx_dump_data.cpu = -1;
 }
 
-static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
+static void scx_dump_task(struct scx_sched *sch,
+			  struct seq_buf *s, struct scx_dump_ctx *dctx,
 			  struct task_struct *p, char marker)
 {
 	static unsigned long bt[SCX_EXIT_BT_LEN];
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *task_sch = scx_task_sched(p);
+	const char *own_marker;
+	char sch_id_buf[32];
 	char dsq_id_buf[19] = "(n/a)";
 	unsigned long ops_state = atomic_long_read(&p->scx.ops_state);
 	unsigned int bt_len = 0;
 
+	own_marker = task_sch == sch ? "*" : "";
+
+	if (task_sch->level == 0)
+		scnprintf(sch_id_buf, sizeof(sch_id_buf), "root");
+	else
+		scnprintf(sch_id_buf, sizeof(sch_id_buf), "sub%d-%llu",
+			  task_sch->level, task_sch->ops.sub_cgroup_id);
+
 	if (p->scx.dsq)
 		scnprintf(dsq_id_buf, sizeof(dsq_id_buf), "0x%llx",
 			  (unsigned long long)p->scx.dsq->id);
 
 	dump_newline(s);
-	dump_line(s, " %c%c %s[%d] %+ldms",
+	dump_line(s, " %c%c %s[%d] %s%s %+ldms",
 		  marker, task_state_to_char(p), p->comm, p->pid,
+		  own_marker, sch_id_buf,
 		  jiffies_delta_msecs(p->scx.runnable_at, dctx->at_jiffies));
 	dump_line(s, "      scx_state/flags=%u/0x%x dsq_flags=0x%x ops_state/qseq=%lu/%lu",
 		  scx_get_task_state(p), p->scx.flags & ~SCX_TASK_STATE_MASK,
@@ -5199,11 +5211,18 @@ static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
 	}
 }
 
-static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
+/*
+ * Dump scheduler state. If @dump_all_tasks is true, dump all tasks regardless
+ * of which scheduler they belong to. If false, only dump tasks owned by @sch.
+ * For SysRq-D dumps, @dump_all_tasks=false since all schedulers are dumped
+ * separately. For error dumps, @dump_all_tasks=true since only the failing
+ * scheduler is dumped.
+ */
+static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
+			   size_t dump_len, bool dump_all_tasks)
 {
 	static DEFINE_RAW_SPINLOCK(dump_lock);
 	static const char trunc_marker[] = "\n\n~~~~ TRUNCATED ~~~~\n";
-	struct scx_sched *sch = scx_root;
 	struct scx_dump_ctx dctx = {
 		.kind = ei->kind,
 		.exit_code = ei->exit_code,
@@ -5220,6 +5239,14 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 
 	seq_buf_init(&s, ei->dump, dump_len);
 
+#ifdef CONFIG_EXT_SUB_SCHED
+	if (sch->level == 0)
+		dump_line(&s, "%s: root", sch->ops.name);
+	else
+		dump_line(&s, "%s: sub%d-%llu %s",
+			  sch->ops.name, sch->level, sch->ops.sub_cgroup_id,
+			  sch->cgrp_path);
+#endif
 	if (ei->kind == SCX_EXIT_NONE) {
 		dump_line(&s, "Debug dump triggered by %s", ei->reason);
 	} else {
@@ -5312,11 +5339,13 @@ static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
 				seq_buf_set_overflow(&s);
 		}
 
-		if (rq->curr->sched_class == &ext_sched_class)
-			scx_dump_task(&s, &dctx, rq->curr, '*');
+		if (rq->curr->sched_class == &ext_sched_class &&
+		    (dump_all_tasks || scx_task_on_sched(sch, rq->curr)))
+			scx_dump_task(sch, &s, &dctx, rq->curr, '*');
 
 		list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
-			scx_dump_task(&s, &dctx, p, ' ');
+			if (dump_all_tasks || scx_task_on_sched(sch, p))
+				scx_dump_task(sch, &s, &dctx, p, ' ');
 	next:
 		rq_unlock_irqrestore(rq, &rf);
 	}
@@ -5349,7 +5378,7 @@ static void scx_error_irq_workfn(struct irq_work *irq_work)
 	struct scx_exit_info *ei = sch->exit_info;
 
 	if (ei->kind >= SCX_EXIT_ERROR)
-		scx_dump_state(ei, sch->ops.exit_dump_len);
+		scx_dump_state(sch, ei, sch->ops.exit_dump_len, true);
 
 	kthread_queue_work(sch->helper, &sch->disable_work);
 }
@@ -6333,9 +6362,12 @@ static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
 static void sysrq_handle_sched_ext_dump(u8 key)
 {
 	struct scx_exit_info ei = { .kind = SCX_EXIT_NONE, .reason = "SysRq-D" };
+	struct scx_sched *sch;
 
-	if (scx_enabled())
-		scx_dump_state(&ei, 0);
+	guard(raw_spinlock_irqsave)(&scx_sched_lock);
+
+	list_for_each_entry_rcu(sch, &scx_sched_all, all)
+		scx_dump_state(sch, &ei, 0, false);
 }
 
 static const struct sysrq_key_op sysrq_sched_ext_dump_op = {
-- 
2.53.0


