Return-Path: <cgroups+bounces-16719-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W0b5OEi0JmoQbgIAu9opvQ
	(envelope-from <cgroups+bounces-16719-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:23:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A53D6561DF
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:23:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=V1suc8Ul;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16719-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16719-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69D2B30BCDC1
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D2A37C0F5;
	Mon,  8 Jun 2026 12:16:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C0337B417
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:16:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920968; cv=none; b=ScK/MbY/8gfY9X5uE6OoF3tWXtiCQV/3cdkGhLYE4S/oC+m+uPNwS0r9wc6y6HglZ4zSa8+nfab7fBwGy7wRpdGRqux9+sX4nT99DO1RsjwRZR3qooMmpyy5EGPTMgysXz3ImCa7NIneuEjUEutS4dzI9NcsS1kznxix3kmKIX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920968; c=relaxed/simple;
	bh=to3vSgHXdNomWchO0GTrjo+buXnOSkm5uMW+MO2JWIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mv8aog8Dp+5touwqmm+zDIaHlR+JWkjYHJscUtpbrB6WERrbqfJ4UOet9fNpHHzRQVX7ulfvmoDowrU0P+NiGjxSCDpFr7P6JQHHBrPi7kLJo4N+aZj6ZuWCKU6bCBxW5KVOSmcp/aAxRN3q26FpcWNkbxOkyktg6A7uY1hSKBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1suc8Ul; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso3009766f8f.0
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920965; x=1781525765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2iHCNH12Qn8fPKVTKO+hnsoSrEhmuO/S50hcL98V7o=;
        b=V1suc8Ullt/ErqOqvAuhf2J+rk0P99Yuh9l6lfG6T/8zFDBMsJ0DWk2x5EivJGth1E
         50zV5+08KP7/xPICDbPCt/7prvXai6e29ZJJSTn8MUZd/dxBOg7fBew+JICwSuukob6P
         1i6vpRT+3HsDc1sV6JkkwQ+B6oCmVqDUHqFn787SBCwzJeGwVi2VoEvH0Av+WeUQXxvf
         CWbVIWfHWfi7JiHUKTc2hiZBFUY0NWiaw2+Q8DHWeYmhzfwUZxcW2iX1ryMWIUCRGC86
         068KmKA2//ht7RvUXnn488aOiRNQWEjbhYTGH3TfLsq/fQNdNmq00rCxVn22JtYGiElQ
         4S7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920965; x=1781525765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L2iHCNH12Qn8fPKVTKO+hnsoSrEhmuO/S50hcL98V7o=;
        b=THVK6jwyQh8CC5LIVZfdPwbFaFobK+NPQxTPnvV9c7LKSCN1nnS8/BiCjnuXssaciC
         f3Lzlm6qNbiZCyanPGNN5Hn9Ja/sjI+Se16292FUyEQroHp9Sm+qxnomBf8OBlSuWxiL
         ddUMZ3/48wCbI5eKbk/AE9rqrE+nsQR31udZtnDh6lvxh9OnT5avXB0toTmyVEnjKTkz
         I2ONfRReatuwfTbeMu6JwwLI4SSdTyMVU2d9euMJ4xuoWkM5WhH88t3HaIkxcVyFnOnV
         BkEBGNSR/AVNetWOE7IZqLMP/2oV9TT1JKGTnuFP/O2aVHZQ1PJf1wUYEcYqBqerVUOu
         Zefg==
X-Gm-Message-State: AOJu0YzdhNOykspfX8HWwLu7voTFqzaK4pb47ciG1WijDB9Z/oYKVeTQ
	igRZEBGehAM4SWwp708V6aj40efewb2P3o+IFEsvl8lVhaug/LklXt+Z
X-Gm-Gg: Acq92OFbhscA4CLrJAwqv2+oYFrmr5hMy88U1eGD+jsZH4UKnt2mAbydWcO0zQfUEVo
	CNGZftqIuOWRWOS4doYr76JMrO3esOjBeNzklCSVQzA+qdhqjRl6D2E+wMDAV0n0MstCbyyFX1K
	k75uOP+PRY8VF8MnKKu/1jKAPe71wq6PPiksTZDarMr5LO2YF2k9UBr4zaSfwudRNSCGgWZMLRg
	4xLz3ShDkHRmu54EMEDeY+XcwnFpWhatQ/ecw+C0sbe23IkuH+5D5Ecl2mUIhwjHUSexlna6oR+
	9a2Yv05ytPU5Ao38FFzWWfDlXY+jYVBgoEjjfQdIxZ59MvajrvVJfzhOKGkBHByzXzhLhwr2ji+
	MhNLce9RE13PVZU5cHzVS3bBVzahv6FSTa3qd+/CuRxyvZhV2yyFQnAN1T4Xb05YA2wt2GbYhLd
	RP7V7k50DHVivRLExrq7WebPG7eO2ydoQ1dPxcaWvrDA==
X-Received: by 2002:a05:600c:8b83:b0:490:b106:4fe8 with SMTP id 5b1f17b1804b1-490c25e268dmr253370545e9.33.1780920965147;
        Mon, 08 Jun 2026 05:16:05 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:16:04 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v6 18/25] sched/rt: Update task's RT runqueue when switching scheduling class
Date: Mon,  8 Jun 2026 14:15:37 +0200
Message-ID: <20260608121546.69910-19-yurand2000@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608121546.69910-1-yurand2000@gmail.com>
References: <20260608121546.69910-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16719-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A53D6561DF

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/rt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a32b1f68e645..fc7af6bda3f8 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1897,6 +1897,25 @@ void __init init_sched_rt_class(void)
 	}
 }

+#ifdef CONFIG_RT_GROUP_SCHED
+static void switching_to_rt(struct rq *rq, struct task_struct *p)
+{
+	struct task_group *tg = p->sched_task_group;
+	int cpu = rq->cpu;
+
+	if (tg == &root_task_group)
+		return;
+
+	guard(raw_spinlock_irqsave)(dl_bw_lock_of_tg(tg));
+	if (!rt_group_sched_enabled())
+		tg = &root_task_group;
+
+	p->rt.rt_rq = dl_bandwidth_read(tg)->active_context->rt_rq[cpu];
+}
+#else
+static void switching_to_rt(struct rq *rq, struct task_struct *p) {}
+#endif
+
 /*
  * When switching a task to RT, we may overload the runqueue
  * with RT tasks. In this case we try to push them off to
@@ -2095,6 +2114,7 @@ DEFINE_SCHED_CLASS(rt) = {

 	.get_rr_interval	= get_rr_interval_rt,

+	.switching_to		= switching_to_rt,
 	.switched_to		= switched_to_rt,
 	.prio_changed		= prio_changed_rt,

--
2.54.0


