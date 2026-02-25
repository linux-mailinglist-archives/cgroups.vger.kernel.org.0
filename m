Return-Path: <cgroups+bounces-14260-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPTfFwWEnmmGVwQAu9opvQ
	(envelope-from <cgroups+bounces-14260-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:09:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B9B191C9B
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E26D3100F0B
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4675831195B;
	Wed, 25 Feb 2026 05:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD7KBozF"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDED30FF36;
	Wed, 25 Feb 2026 05:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995693; cv=none; b=BK9ye06fg3Zaw1LjLLA0vYFBjuOToR7boeT/YXvEKshckIZrL92Ci1LgL2ZDwdStejA1NJjt5eoMuRWOIsL9dBY6nl6MUhLquRXA3ag033nLza67cViEwewIKXOMD/Cl/1Rq39BcLf2f2gZATrJAKwXgyXtqmTKJ/Bbr7ssMGpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995693; c=relaxed/simple;
	bh=3/mKhjAXqvZ0FAsZItI7vRYMA/HK0yR/LO3DfP+GPhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sz6d5s3vKHt82I1LtuGowN9wKA37zuDokwOY/GRHvjHberu3tugWyHhrqXzEY57d567g1f+ON5vLqTsTlWeFOBFlXEYqKAIlYo9xtg1RQeMcunqy25GxToBHFFk5sMltiZ/oXRrsm3D89S42ZvqUB/Tq2/Wb5qJNLhD8DzPjM+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD7KBozF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88235C116D0;
	Wed, 25 Feb 2026 05:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995692;
	bh=3/mKhjAXqvZ0FAsZItI7vRYMA/HK0yR/LO3DfP+GPhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jD7KBozF39orCPeQSV8q7oy+0jMu2YbdKTzDPVhWCRtu6bme+ak5oG9npuGTDH3X1
	 R4l50jThfmAJgAZbl8RjesuggpKHYpZUPBmUJl0xoI7/8/x3cwsLZc+5SeIx2/r979
	 7xk8NWeUt6gH065EYsmprXPUHgtqB7OWObp4ulVnAHuGyZFUYU8Psu5lwzxCwTl/Yk
	 48JJUYLO9+ZiCEOtjYYbLrr2oHijo/50OWCu148r7Pwvz94gg6UxsiKr5coxXQLOtL
	 eNQn3StJwzPDjzn5y0Dat/P0B7eRepecj9imaerQweSG+VEhVokyKmNd8ud0EdoyEq
	 w60CLdN27iuSg==
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
Subject: [PATCH 21/34] sched_ext: When calling ops.dispatch() @prev must be on the same scx_sched
Date: Tue, 24 Feb 2026 19:00:56 -1000
Message-ID: <20260225050109.1070059-22-tj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14260-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 14B9B191C9B
X-Rspamd-Action: no action

The @prev parameter passed into ops.dispatch() is expected to be on the
same sched. Passing in @prev which isn't on the sched can spuriously
trigger failures that can kill the scheduler. Pass in @prev iff it's on
the same sched.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 99ef2a1cc3ac..ed1491df0829 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2388,9 +2388,10 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 			       struct task_struct *prev)
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
-	bool prev_on_scx = prev->sched_class == &ext_sched_class;
 	int nr_loops = SCX_DSP_MAX_LOOPS;
 	s32 cpu = cpu_of(rq);
+	bool prev_on_sch = (prev->sched_class == &ext_sched_class) &&
+		sch == rcu_access_pointer(prev->scx.sched);
 
 	if (consume_global_dsq(sch, rq))
 		return true;
@@ -2414,7 +2415,7 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 		dspc->nr_tasks = 0;
 
 		SCX_CALL_OP(sch, SCX_KF_DISPATCH, dispatch, rq, cpu,
-			    prev_on_scx ? prev : NULL);
+			    prev_on_sch ? prev : NULL);
 
 		flush_dispatch_buf(sch, rq);
 
-- 
2.53.0


