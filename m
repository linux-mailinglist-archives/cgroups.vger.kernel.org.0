Return-Path: <cgroups+bounces-14298-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AN1BrGFnmnRVwQAu9opvQ
	(envelope-from <cgroups+bounces-14298-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:16:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D45E6191E56
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41ECD30A02EE
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3FF37AA73;
	Wed, 25 Feb 2026 05:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd2r9Ckb"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F15C37A49F;
	Wed, 25 Feb 2026 05:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995740; cv=none; b=LFZjQpNv+kI8AYE3aQP/SQrIi9vUaiM1/9ZIwobt5JwUSV/6uQEY2s3gMtd3C/ZrfSELTbDHHWrkP52/1MBDG8P+PPTXYrP69w3Au23miAISHnpTHpsENbR+PDy+p2nE/jtbFHIz628znWpndcuV8MWNB+Lia+fIin7TPArobvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995740; c=relaxed/simple;
	bh=KhOJxXjJ6O7tJ1Xlz2wkgxsoCbGBWHgNEEBYJDMSjtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2Wa+VZ+VJotDHwvkcrVve0GcdJ7Mj+RATZABVCWGPhbSoXq20DC+UXIuflhmEuGZugPJ8tppsfWGCSX98VHeUODXeGPCS/F3C9umZTsou834t1BpCGZagUbLMaMGqCdLWF7nEghyAAo2bLupMfBZw9rAlxwYKUzJ0ywULtdQ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd2r9Ckb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1F6C116D0;
	Wed, 25 Feb 2026 05:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995740;
	bh=KhOJxXjJ6O7tJ1Xlz2wkgxsoCbGBWHgNEEBYJDMSjtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qd2r9CkboTeUH160vVAZ4fZsDRRbAdBdWDCajz2EC6a4fyWJ8dvn7FYCPwRhNRMbP
	 Ozo77ZBe0yM9pkReUasOLzgFMOsWP5a10L26qVepblJ2i/eIbMwLYPANH6FCbO5Z/B
	 CyrykPkutfD0nxa2tYoYQnmeiThqfKqOAKwx6I0+wZrt5EWwnMPiubeqXGadIycAzL
	 jiNDqQgCQAarAjXtq82eQ6FBQXQ7VX5R//gjiA1EvfcayffHezQmtVk2HiDbT6AlNF
	 YnO0YNCSLFUy4sunDzj4cWpsahSkd11uMApV3yyfEcqgpZ5turvQO61dbx4ZO2HYy0
	 Q4VaOeMYPkQlA==
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
Subject: [PATCH 24/34] sched_ext: Dispatch from all scx_sched instances
Date: Tue, 24 Feb 2026 19:01:42 -1000
Message-ID: <20260225050152.1070601-25-tj@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-14298-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: D45E6191E56
X-Rspamd-Action: no action

The cgroup sub-sched support involves invasive changes to many areas of
sched_ext. The overall scaffolding is now in place and the next step is
implementing sub-sched enable/disable.

To enable partial testing and verification, update balance_one() to
dispatch from all scx_sched instances until it finds a task to run. This
should keep scheduling working when sub-scheds are enabled with tasks on
them. This will be replaced by BPF-driven hierarchical operation.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5490bfd77c92..9551bfb0567b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2520,7 +2520,7 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 
 static int balance_one(struct rq *rq, struct task_struct *prev)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_root, *pos;
 	s32 cpu = cpu_of(rq);
 
 	lockdep_assert_rq_held(rq);
@@ -2564,9 +2564,13 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	if (rq->scx.local_dsq.nr)
 		goto has_tasks;
 
-	/* dispatch @sch */
-	if (scx_dispatch_sched(sch, rq, prev))
-		goto has_tasks;
+	/*
+	 * TEMPORARY - Dispatch all scheds. This will be replaced by BPF-driven
+	 * hierarchical operation.
+	 */
+	list_for_each_entry_rcu(pos, &scx_sched_all, all)
+		if (scx_dispatch_sched(pos, rq, prev))
+			goto has_tasks;
 
 	/*
 	 * Didn't find another task to run. Keep running @prev unless
-- 
2.53.0


