Return-Path: <cgroups+bounces-14286-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CnxE12FnmnRVwQAu9opvQ
	(envelope-from <cgroups+bounces-14286-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:15:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7C9191E14
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65E0831533CA
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A12366DC4;
	Wed, 25 Feb 2026 05:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofy4SDi4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2507366824;
	Wed, 25 Feb 2026 05:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995725; cv=none; b=G+6WIIgMHG/0sJj5fRnRb+YfaPQdc9nfzcqukli9f3K8XA6DUQlyrHrlDbzSTPgwf+lUYzF+ttnEjY4YRGcPQ63IvSukGXZoxl0/JIGOJ3mIUn315SwCoQKn7TwhnK14BOuBPH9DS+jrevGHH2z10Hbnkf7KSIuHFpMDlXdJlqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995725; c=relaxed/simple;
	bh=e480gCxfrYOE+ldnQTd5yjbsJAHLy6bo3xZveHQsHn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4Da7z25C56M+JzQqqEbSSd+R86z1Olms/p5lUquFXNJg1pAdR6WktPVzr34+n0JEDogLvWUOEij1p7gvpZRpiR/ENhJH9z3CREoGAcKcwwAeIrEwCykhHtS3lBMRshtFFvB75R3bFQ+ErfRy6V9gIkjn6s0CFbRyjjJntnkD8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofy4SDi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683FAC116D0;
	Wed, 25 Feb 2026 05:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995725;
	bh=e480gCxfrYOE+ldnQTd5yjbsJAHLy6bo3xZveHQsHn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ofy4SDi4ZXeA3EpHDCqy+lJCMQJXIlW8wAyvzI5Em/mPb4aRe4JNT9kFUL7Warwae
	 yfmdqGUHlM/OwVGew5t275GgU9kabcO/PYfHxRjuloqMo8j7iIAuUG+TMOO5NlqtI1
	 ilwAORZd0RPLK9FgNwZeaBsxVyhF5CzSXcBoE7qj4lfcUCmLVwN1FjnX0c8h1CkQ60
	 JbU4RtdjDYNXvCy3Pz9ztlBGMKdwhBrXld+RxlcgY3v6D1Fea8EazsVYvx5lXQ6I57
	 rSHfX5naCEum9LwPSHDkbutITk1Ax11WnPWAfAZDrVpdiuDdaevbZ1hT8lvlotd0Pg
	 KAd05GvWP8DFQ==
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
Subject: [PATCH 12/34] sched_ext: scx_dsq_move() should validate the task belongs to the right scheduler
Date: Tue, 24 Feb 2026 19:01:30 -1000
Message-ID: <20260225050152.1070601-13-tj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14286-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA7C9191E14
X-Rspamd-Action: no action

scx_bpf_dsq_move[_vtime]() calls scx_dsq_move() to move task from a DSQ to
another. However, @p doesn't necessarily have to come form the containing
iteration and can thus be a task which belongs to another scx_sched. Verify
that @p is on the same scx_sched as the DSQ being iterated.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f16ce4deed88..33e9129a8073 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6651,8 +6651,8 @@ static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
 static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 			 struct task_struct *p, u64 dsq_id, u64 enq_flags)
 {
-	struct scx_sched *sch = scx_root;
 	struct scx_dispatch_q *src_dsq = kit->dsq, *dst_dsq;
+	struct scx_sched *sch = src_dsq->sched;
 	struct rq *this_rq, *src_rq, *locked_rq;
 	bool dispatched = false;
 	bool in_balance;
@@ -6669,6 +6669,11 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	if (unlikely(READ_ONCE(scx_aborting)))
 		return false;
 
+	if (unlikely(!scx_task_on_sched(sch, p))) {
+		scx_error(sch, "scx_bpf_dsq_move[_vtime]() on %s[%d] but the task belongs to a different scheduler",
+			  p->comm, p->pid);
+	}
+
 	/*
 	 * Can be called from either ops.dispatch() locking this_rq() or any
 	 * context where no rq lock is held. If latter, lock @p's task_rq which
-- 
2.53.0


