Return-Path: <cgroups+bounces-14269-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFH+DqOEnmmGVwQAu9opvQ
	(envelope-from <cgroups+bounces-14269-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:12:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AD9191D29
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 346A630B6F84
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA173254B3;
	Wed, 25 Feb 2026 05:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpDWarz6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE031B80D;
	Wed, 25 Feb 2026 05:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995702; cv=none; b=eNZX918si49TWthaqgMFY/6jT8DyaGG9avnNS2aUc/oxlc+7Z3dbqHY1iseYBY21dA3hLt0nVp9Ng7GtCTP7V2tGPTIGuXkCL9HGnyFdeL/MvOpZYdRT5vjhxhjqdSltbGWd26gbenlAZ53H8MAK6BtfigyI1U0hA0Z7fOAkfqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995702; c=relaxed/simple;
	bh=WH/LnE0l3TISc+xilD8xl57abk/Sgt7bfhuHwUelS9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLLXb5uoNoKx0MB00dBOsnxI7pXgRqc/Z7Hj8qyCfblbxvsv6d5QHB4deJbxc4hZL0/qbnaLvF5/1Nv0tKIPTNBOUSqtqxzMoJs5T+7qCtr8lWb4ICb/u7R+R1V1UuzFK04FtKGy5rZPCkwIJQq/zCYvz9McZadZv7zA2N/vQ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpDWarz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA0AC116D0;
	Wed, 25 Feb 2026 05:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995702;
	bh=WH/LnE0l3TISc+xilD8xl57abk/Sgt7bfhuHwUelS9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OpDWarz6+lJDKozdR69tz4YLMpmCOc8IX5nPsOfAfZ67Ed8UxErsbz0IBfo7sW9cD
	 kYCB9CkpGHLubq/zz8+sysbuZGP4FVtIqnyJOq1tn0PTncFEo3B6YuIIQxNH1/n5n2
	 UXNnuZZ+dDJ5QycODVqpRfQ1nGN5BdyxTfEbxFaW+uIxQGSpnSy1uhg2IfnxgteUBy
	 qAkVKJbpXfDn5WYyWBdeIFMSO/NUH2nWVJssfM5YH6LA8WZmD5iWHDx87gOzPdLFG0
	 yEIK+ys4ah2cRxFK8AfpKVtstkm/yPQHTpN26AA5YoDYRx4hJ2J9xX9BxsYX6Ax1xV
	 fYjwQLkr56fOg==
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
Subject: [PATCH 30/34] sched_ext: Add scx_sched back pointer to scx_sched_pcpu
Date: Tue, 24 Feb 2026 19:01:05 -1000
Message-ID: <20260225050109.1070059-31-tj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14269-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95AD9191D29
X-Rspamd-Action: no action

Add a back pointer from scx_sched_pcpu to scx_sched. This will be used by
the next patch to make scx_bpf_reenqueue_local() sub-sched aware.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 3 +++
 kernel/sched/ext_internal.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d26a92bc6be9..131fc275f10a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5631,6 +5631,9 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	for_each_possible_cpu(cpu)
 		init_dsq(bypass_dsq(sch, cpu), SCX_DSQ_BYPASS, sch);
 
+	for_each_possible_cpu(cpu)
+		per_cpu_ptr(sch->pcpu, cpu)->sch = sch;
+
 	sch->helper = kthread_run_worker(0, "sched_ext_helper");
 	if (IS_ERR(sch->helper)) {
 		ret = PTR_ERR(sch->helper);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 0a19af6ad3ff..cd5bd70fe30c 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -933,6 +933,8 @@ struct scx_event_stats {
 	s64		SCX_EV_SUB_BYPASS_DISPATCH;
 };
 
+struct scx_sched;
+
 enum scx_sched_pcpu_flags {
 	SCX_SCHED_PCPU_BYPASSING	= 1LLU << 0,
 };
@@ -953,6 +955,7 @@ struct scx_dsp_ctx {
 };
 
 struct scx_sched_pcpu {
+	struct scx_sched	*sch;
 	u64			flags;	/* protected by rq lock */
 
 	/*
-- 
2.53.0


