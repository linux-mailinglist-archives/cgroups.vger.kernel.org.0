Return-Path: <cgroups+bounces-14285-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Fu8CLyEnmmGVwQAu9opvQ
	(envelope-from <cgroups+bounces-14285-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:12:28 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D13191D3E
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B6B43002339
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B83036655A;
	Wed, 25 Feb 2026 05:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSECFtl2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C371336604D;
	Wed, 25 Feb 2026 05:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995724; cv=none; b=ftPQHRjGTncYif5tV3UIFvUn8shySYKOVQLILkqyJcXLhiNkmbhgAOn0YKw5OypktzN4Mrz+TVO1C0phlUORCUl0jzhfzL9CULEspJVrCkpiQilY/RhCdqmbtlvBorO7L0SbN5g8Kr5jA9K/9551NEntu95TfDMI9WagBQGuqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995724; c=relaxed/simple;
	bh=w/c64nr325jXHKbzpOvdTsz0Ayst/zD/MZrsL6jhC9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoF0vKiqzSU3laDwqJtlCge8E7XsZAqg4fxG6nSy2z3JFpi0iDcRGbDROjhBHDcnqduXArAzmy0EkfroEWuWNFD819pJxD/9ByL3Q8MS/H3JpfqI1kl12diRWcyIGA0Yf/GBsGZwaaORxgq5bHnVROuVN8DS1nlV6GsEdKbOPk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSECFtl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BCBC116D0;
	Wed, 25 Feb 2026 05:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995724;
	bh=w/c64nr325jXHKbzpOvdTsz0Ayst/zD/MZrsL6jhC9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NSECFtl2TNxo3D4FUWAQHehhQ6LwI4aeYTH4xTxxn8qpQ/ZZ7UhM8caYbiq5ALNuI
	 Gzno7pfeWegYOcMJXml+nj/Qg6EmbqTdYDHp7ErkJipHTEHTyCO/0QOWKptKuQdFeC
	 pry9KKaDP/JkOMBMHU8TZGRw8PYXA6qXT0hJI324921sJnzLjVVlKe5T5ckYSD6rYh
	 +AnvD0zluxjelfHvwb7ZWc4oQAddKxM2czCqbaT5Cg7l8oVDSkqfFbysL6kOYem3QY
	 UF4HvTxEExmJK+e497jmerGXcf6N7F6jUii7F/MID1R/KHgvo32h3ooV7rXN08T/Ca
	 WNQeOFOKEUDuA==
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
Subject: [PATCH 11/34] sched_ext: Enforce scheduler ownership when updating slice and dsq_vtime
Date: Tue, 24 Feb 2026 19:01:29 -1000
Message-ID: <20260225050152.1070601-12-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225050152.1070601-1-tj@kernel.org>
References: <20260225050152.1070601-1-tj@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-14285-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: B4D13191D3E
X-Rspamd-Action: no action

scx_bpf_task_set_slice() and scx_bpf_task_set_dsq_vtime() now verify that
the calling scheduler has authority over the task before allowing updates.
This prevents schedulers from modifying tasks that don't belong to them in
hierarchical scheduling configurations.

Direct writes to p->scx.slice and p->scx.dsq_vtime are deprecated and now
trigger warnings. They will be disallowed in a future release.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 56ac2d5655a2..f16ce4deed88 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5872,12 +5872,17 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 
 	t = btf_type_by_id(reg->btf, reg->btf_id);
 	if (t == task_struct_type) {
-		if (off >= offsetof(struct task_struct, scx.slice) &&
-		    off + size <= offsetofend(struct task_struct, scx.slice))
-			return SCALAR_VALUE;
-		if (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
-		    off + size <= offsetofend(struct task_struct, scx.dsq_vtime))
+		/*
+		 * COMPAT: Will be removed in v6.23.
+		 */
+		if ((off >= offsetof(struct task_struct, scx.slice) &&
+		     off + size <= offsetofend(struct task_struct, scx.slice)) ||
+		    (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
+		     off + size <= offsetofend(struct task_struct, scx.dsq_vtime))) {
+			pr_warn("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()");
 			return SCALAR_VALUE;
+		}
+
 		if (off >= offsetof(struct task_struct, scx.disallow) &&
 		    off + size <= offsetofend(struct task_struct, scx.disallow))
 			return SCALAR_VALUE;
@@ -7096,12 +7101,21 @@ __bpf_kfunc_start_defs();
  * scx_bpf_task_set_slice - Set task's time slice
  * @p: task of interest
  * @slice: time slice to set in nsecs
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Set @p's time slice to @slice. Returns %true on success, %false if the
  * calling scheduler doesn't have authority over @p.
  */
-__bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice)
+__bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice,
+					const struct bpf_prog_aux *aux)
 {
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = scx_prog_sched(aux);
+	if (unlikely(!scx_task_on_sched(sch, p)))
+		return false;
+
 	p->scx.slice = slice;
 	return true;
 }
@@ -7110,12 +7124,21 @@ __bpf_kfunc bool scx_bpf_task_set_slice(struct task_struct *p, u64 slice)
  * scx_bpf_task_set_dsq_vtime - Set task's virtual time for DSQ ordering
  * @p: task of interest
  * @vtime: virtual time to set
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Set @p's virtual time to @vtime. Returns %true on success, %false if the
  * calling scheduler doesn't have authority over @p.
  */
-__bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime)
+__bpf_kfunc bool scx_bpf_task_set_dsq_vtime(struct task_struct *p, u64 vtime,
+					    const struct bpf_prog_aux *aux)
 {
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = scx_prog_sched(aux);
+	if (unlikely(!scx_task_on_sched(sch, p)))
+		return false;
+
 	p->scx.dsq_vtime = vtime;
 	return true;
 }
@@ -7995,8 +8018,8 @@ __bpf_kfunc void scx_bpf_events(struct scx_event_stats *events,
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_any)
-BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_RCU);
-BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_RCU);
+BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_IMPLICIT_ARGS | KF_RCU);
+BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_IMPLICIT_ARGS | KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
-- 
2.53.0


