Return-Path: <cgroups+bounces-15745-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMTvDPzGAWqSjgEAu9opvQ
	(envelope-from <cgroups+bounces-15745-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:09:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE8C50D5C7
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F04F3045EE6
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409C837B02E;
	Mon, 11 May 2026 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ewnTeeEs"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B39237B019;
	Mon, 11 May 2026 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501241; cv=none; b=beKrbu4ctS4aKOaO76kWHaI6JYjC/+i7lrxABN5ji3BSXPv/L8WA2n7WEYWJ2KS/N1UmX6U8x9XPXSZQefhuS9J5PIDaNBf6ViBdaqQCkmIDA2HIJeDA/qsslenSS/jui/NB1VRLzdm6K+1tjC2Lp59kj5jNCTjgXqLocdPXuDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501241; c=relaxed/simple;
	bh=74XIwVKXNdZdW2lgIMAjqDEX5lPpAsOLQAevkzqcgxU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jlFDwjYljH7JNheFWKYtrvhdJ+9LhDcmR1ZHP4TCrK6qs2zVur6F6m7KJsbh4G+o2roPu4ebCn+7nXeQqd4MNJHpOnfDR5dP7ioi+V9B0Gv1Mcouov2GUcvgMQJ4uTKDrdNodHSG1Wc7NiQfhRov1HhxMqjZb+cAruaSRKpt+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ewnTeeEs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=/nBno72/K1OUhxB+muvWZ/oNtRySVk9xDO45q62blsY=; b=ewnTeeEsMU8nUt37TAm0yjckfz
	GYMDoTRT5Vqxq8/OjWMvWgIQ9a899LBv4ZoyQVvpI6yxLLT4iO1Njb0svRpYA2IOjYpmC39UTsWhv
	H58x6UfG4D0DXNWtQtT+ORERZ9dZ3JvazORCHE1iL/NHBbY9VP5aNesTCLzqsRYOV8JPp+C2rQqXs
	A1ktYUeJ6p3HHsATxB6XSin6umm8DIvCA8y7vim5ElIwZ00UwoTUoLv0hcyOlbSgN66nJF0/mPwRO
	NpDq54iAshYiaIABii/smhW6TDzTqk1w71MJSWEwKh7VarRL4U5sDlw++uJcxzZc6HInUDAqA9gXe
	l/sb41JQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPPZ-0000000BZMS-1x3u;
	Mon, 11 May 2026 12:07:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 115B8301261; Mon, 11 May 2026 14:07:00 +0200 (CEST)
Message-ID: <20260511120627.176946327@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 11 May 2026 13:31:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: longman@redhat.com,
 chenridong@huaweicloud.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 jstultz@google.com,
 kprateek.nayak@amd.com,
 qyousef@layalina.io
Subject: [PATCH v2 02/10] sched: Use {READ,WRITE}_ONCE() for preempt_dynamic_mode
References: <20260511113104.563854162@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 5FE8C50D5C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15745-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Action: no action

Robots figured out you can read and write this concurrently and got
'upset'. Gemini even noted sched_dynamic_show() can generate
'confusing' output if it observed different values during the
printing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   15 ++++++++-------
 kernel/sched/debug.c |    5 +++--
 2 files changed, 11 insertions(+), 9 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7743,7 +7743,7 @@ static void __sched_dynamic_update(int m
 		break;
 	}
 
-	preempt_dynamic_mode = mode;
+	WRITE_ONCE(preempt_dynamic_mode, mode);
 }
 
 void sched_dynamic_update(int mode)
@@ -7784,12 +7784,13 @@ static void __init preempt_dynamic_init(
 	}
 }
 
-# define PREEMPT_MODEL_ACCESSOR(mode) \
-	bool preempt_model_##mode(void)						 \
-	{									 \
-		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
-		return preempt_dynamic_mode == preempt_dynamic_##mode;		 \
-	}									 \
+# define PREEMPT_MODEL_ACCESSOR(mode)					\
+	bool preempt_model_##mode(void)					\
+	{								\
+		int mode = READ_ONCE(preempt_dynamic_mode);		\
+		WARN_ON_ONCE(mode == preempt_dynamic_undefined);	\
+		return mode == preempt_dynamic_##mode;			\
+	}								\
 	EXPORT_SYMBOL_GPL(preempt_model_##mode)
 
 PREEMPT_MODEL_ACCESSOR(none);
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -239,6 +239,7 @@ static ssize_t sched_dynamic_write(struc
 static int sched_dynamic_show(struct seq_file *m, void *v)
 {
 	int i = (IS_ENABLED(CONFIG_PREEMPT_RT) || IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY)) * 2;
+	int mode = READ_ONCE(preempt_dynamic_mode);
 	int j;
 
 	/* Count entries in NULL terminated preempt_modes */
@@ -247,10 +248,10 @@ static int sched_dynamic_show(struct seq
 	j -= !IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY);
 
 	for (; i < j; i++) {
-		if (preempt_dynamic_mode == i)
+		if (mode == i)
 			seq_puts(m, "(");
 		seq_puts(m, preempt_modes[i]);
-		if (preempt_dynamic_mode == i)
+		if (mode == i)
 			seq_puts(m, ")");
 
 		seq_puts(m, " ");



