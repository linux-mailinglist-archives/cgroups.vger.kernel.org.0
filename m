Return-Path: <cgroups+bounces-14253-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MdUMl2DnmmGVwQAu9opvQ
	(envelope-from <cgroups+bounces-14253-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:06:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A81191C09
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31089314E23B
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC413016E0;
	Wed, 25 Feb 2026 05:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SC4hrhtS"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBACE3002D1;
	Wed, 25 Feb 2026 05:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995685; cv=none; b=nujPY1Bsg9PAN5zY5+8P/yzNJJ94b51U8dbYSX751+b6iAl5SJHqwfi1ICfvrDenpOD5JewIsxGvsx8YClO/CRfFGf2i+C3zLZjXTjNMRet/EQIAweEwbUL2xECp5sfQwyGbQnjUe683c/sfq1hmL2cNEfLKSpZW6t5DwwfjAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995685; c=relaxed/simple;
	bh=78W9E5VoKOH0MhqlfJeeYcbnJzFOFRCC2/kU4D5M7bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYMkBroeKxyDPUo5C6OVyKb4SOfOe8HzGj4W0jyc//0/fVJbCSGzrGX2t3qAM79TeR0Ftgd/7H4t+NSUPe20zN7qmSibe9BaM0UZ97N8N+ze2n9z01y903xEU1Ujqp2DwxeLNfMT56ijLPmDWVnOgYtmQq8CQGtU3Nunw1livAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SC4hrhtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A4AC116D0;
	Wed, 25 Feb 2026 05:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995685;
	bh=78W9E5VoKOH0MhqlfJeeYcbnJzFOFRCC2/kU4D5M7bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SC4hrhtSbbNoySAN0HNOTVBxiWqOWkH3WBDz3wV8Hsm6Ma/4yu+l1jWKElcWdnLat
	 4omHOAM5W1ihJ2kdtU4A64rnwGMIZAitRNoE58XqCeziyB+thU5ymZhSFnNnrMi6Hp
	 2Z3fzgZmpZnlkFSFJFz+8NsWv1/cFKKhFwPrD3jlYaasTBDveSudajdPXGtTymOm/f
	 ORuIQihzdpIRDiGlCKpcRvRA9KqHIEzWsVv3M6HBkHUX9BU/ZXQj3cv1pWRc7RgXhj
	 6Sk/qtFjzkQYt78ia8nk5NdYV/grg3Ksg9O9CuC2x3AmJryJYfWlC2l9wsLCe9FoFz
	 sW8V2V/f75n7A==
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
Subject: [PATCH 14/34] sched_ext: Make scx_prio_less() handle multiple schedulers
Date: Tue, 24 Feb 2026 19:00:49 -1000
Message-ID: <20260225050109.1070059-15-tj@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-14253-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 69A81191C09
X-Rspamd-Action: no action

Call ops.core_sched_before() iff both tasks belong to the same scx_sched.
Otherwise, use timestamp based ordering.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5d13b9b93249..3d46e6e125c7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2805,16 +2805,17 @@ void ext_server_init(struct rq *rq)
 bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 		   bool in_fi)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch_a = scx_task_sched(a);
+	struct scx_sched *sch_b = scx_task_sched(b);
 
 	/*
 	 * The const qualifiers are dropped from task_struct pointers when
 	 * calling ops.core_sched_before(). Accesses are controlled by the
 	 * verifier.
 	 */
-	if (SCX_HAS_OP(sch, core_sched_before) &&
+	if (sch_a == sch_b && SCX_HAS_OP(sch_a, core_sched_before) &&
 	    !scx_rq_bypassing(task_rq(a)))
-		return SCX_CALL_OP_2TASKS_RET(sch, SCX_KF_REST, core_sched_before,
+		return SCX_CALL_OP_2TASKS_RET(sch_a, SCX_KF_REST, core_sched_before,
 					      NULL,
 					      (struct task_struct *)a,
 					      (struct task_struct *)b);
-- 
2.53.0


