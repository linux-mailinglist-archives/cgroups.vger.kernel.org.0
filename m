Return-Path: <cgroups+bounces-15253-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOGzHcOe3GkEUgkAu9opvQ
	(envelope-from <cgroups+bounces-15253-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:44:03 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA583E8691
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFD413016265
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 07:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC22D397E67;
	Mon, 13 Apr 2026 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdsYd+sq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D4A3947B0
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066217; cv=none; b=HQ8HfuuI0/AeNSduJVLhwmugKQWjDXX/64E2PIcloplYjll7RlJ5iaytZdDf8gv8TrjjTvxG9ndhEHOL587aRr2ZcnBB8x08+I/+TnahadUYUMSWf3VeG5aUqw1+0by7UCRsG1JwM2bBc1bH6jzwcA/6bEWw62Xs9vEp3stz92c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066217; c=relaxed/simple;
	bh=rTHf4UhK6kWkIWPvhrP0nC+nWJz71sfU6irjbkXjF94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tE41KkHYfcMTMFJFhUyTuba+m4RztzKjWybzvCXFLHhI/sTh0W6mErxvCEhTcsvccv+IgsTi8GD6b7vG5K91d+azFEBYvbMnrkF+2oGVAUIJD0TvMKln8NkkQo1cCxcT//0tGscYFlGB2UtFUBRVmxOnd/sRKO6t7lz2fxjIZrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdsYd+sq; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-128b9b7e3edso5429809c88.0
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 00:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066215; x=1776671015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XnF7VA67yV6q+bGidLmOjD6jCKMoavIh1c7OZfJv2nE=;
        b=MdsYd+sqDbrkF6hJRgJP+zfVWfsaWHt44qgzzHBORFCNt+0XS8wZT4yfbJf8gYcrH2
         Km1p+LGSup6E1GJ87DCRHisGxCe9SsH9M394SHZkDdhh62NWIEsGtVxQdGSnb57k85hh
         zMqgOYzeAGS300fAm7/VibRsxf59x76cmusCObNP+9Ggy8BNkDVZE6Jw6Y2JQeP3hagh
         ldY241t0cS5H1W4ToBdXPX1mmw12BpGZXA/WlTA0kHqmk3E922VWRoAsjIMv6PG79wY8
         UwX3jvIo/xMSvl2S2HeQ7yS57VCBuy/a3DO+rPTdEnqpVDyb17Sq7a9hYwQGLC8onNc9
         2Nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066215; x=1776671015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XnF7VA67yV6q+bGidLmOjD6jCKMoavIh1c7OZfJv2nE=;
        b=XNcNecI0Q1LC+YFwsafGaIdKCzeR12I93lvKlx8hRP6RBxSCMTTP31inDBfuGD2iYx
         0O6YaAwxExgsihsWPlQ4mmr/W61Y1+3YhP5piqtIL1IBFK53fg9XFGFNPiN3kBNnnIWc
         us4YqHffpYVNi3sw0RaVvGAi014IeJFos7DhKT/h42QZM99gstcn2GIS8yYkuhCOkmoS
         2YRZe3AEpE50Wt5ZocObByux01v048HC2FGbS+vB7Qvz6CtYucefQhjWyavc8KA9tFrJ
         EKQy5XPbVnReTxim1KRBB0jN98uQY+R521eRYUY77jJjkBrvdTINjGGihMiOyp4kqcyg
         ajwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7TMcn1LBwXRDzwsF1LuACO8FeOPZ+hdHUE1Ay7Cu1E9uaHC9LrtLsxJWLpHmPUw+gL4gfM8gB@vger.kernel.org
X-Gm-Message-State: AOJu0YzivhHzifbFB5IIZUCtaov4T2dxCrQ+PCQEO6n5CW1ww+GtZlpH
	9Nsdpw3VQdp/Y0xa/X90aw0AWzvXkLq2CAQB40eFDzjDHoCee+wB8zUR
X-Gm-Gg: AeBDiesPhaTPF5786L+GKlhFG41vIcXXcVZAZ85U5rZ4EElkWPOT2hnf9uZdtl07/xQ
	orafqK6LKsDixSzbCr6f/QYmcWXDxD4Tp3KJglRJPRB4eVR9tITvxHAuEvAIOwiFsLi6A/7RCIM
	WMJJ6oTlrQt2YkdgVIRFQvYjDqq+cueJlSJ0tpge3zKoPOCREXGngb+i+SU9E4Es7VVmq70o2LT
	awBg7DnigwfwI2nl+NWstsHgGc3tCTdqO3FYZhRM+pubciKh0lCJZHkxr+Xtncjov4Wk2MRXEb/
	Rjuans9zcVLoaRnpgCALNna990MP0KNPxI889SOgGSMefGBmLgGIlm6JU1j3BGFPEv4Pv/WV21+
	zk23YLl9tArEDR/2ck3fZegt3/h/ptcyoOQYC3YqBPD6nPUaQcji/ay8af5/xVOpXnKDOYR0o79
	hDPnpHZ420P/RrK9eEmrIaGSwyRic=
X-Received: by 2002:a05:7022:eac5:b0:128:d2b3:5df with SMTP id a92af1059eb24-12c34ecea05mr6569881c88.23.1776066214618;
        Mon, 13 Apr 2026 00:43:34 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm12884610c88.15.2026.04.13.00.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:43:34 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Mon, 13 Apr 2026 15:43:07 +0800
Subject: [PATCH v2 01/12] sched/isolation: Separate housekeeping types in
 enum hk_type
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-wujing-dhm-v2-1-06df21caba5d@gmail.com>
References: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
In-Reply-To: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Waiman Long <longman@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15253-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,linux-foundation.org,suse.com,cmpxchg.org,huaweicloud.com,lwn.net,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BA583E8691
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Most kernel noise types (TICK, TIMER, RCU, etc.) are currently aliased
to a single HK_TYPE_KERNEL_NOISE enum value. This prevents fine-grained
runtime isolation control as all masks are forced to be identical.

Un-alias service-specific housekeeping types in enum hk_type. This
separation provides the necessary granularity for DHM subsystems to
subscribe to and maintain independent affinity masks.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 include/linux/sched/isolation.h | 20 ++++++++------------
 kernel/sched/isolation.c        | 10 +++++++++-
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index dc3975ff1b2e1..b9a041247565c 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -17,21 +17,17 @@ enum hk_type {
 	/* Inverse of boot-time isolcpus=managed_irq argument */
 	HK_TYPE_MANAGED_IRQ,
 	/* Inverse of boot-time nohz_full= or isolcpus=nohz arguments */
-	HK_TYPE_KERNEL_NOISE,
+	HK_TYPE_TICK,
+	HK_TYPE_TIMER,
+	HK_TYPE_RCU,
+	HK_TYPE_MISC,
+	HK_TYPE_WQ,
+	HK_TYPE_KTHREAD,
 	HK_TYPE_MAX,
-
-	/*
-	 * The following housekeeping types are only set by the nohz_full
-	 * boot commandline option. So they can share the same value.
-	 */
-	HK_TYPE_TICK    = HK_TYPE_KERNEL_NOISE,
-	HK_TYPE_TIMER   = HK_TYPE_KERNEL_NOISE,
-	HK_TYPE_RCU     = HK_TYPE_KERNEL_NOISE,
-	HK_TYPE_MISC    = HK_TYPE_KERNEL_NOISE,
-	HK_TYPE_WQ      = HK_TYPE_KERNEL_NOISE,
-	HK_TYPE_KTHREAD = HK_TYPE_KERNEL_NOISE
 };
 
+#define HK_TYPE_KERNEL_NOISE HK_TYPE_TICK
+
 #ifdef CONFIG_CPU_ISOLATION
 DECLARE_STATIC_KEY_FALSE(housekeeping_overridden);
 extern int housekeeping_any_cpu(enum hk_type type);
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index ef152d401fe20..e05ed5118e651 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -15,9 +15,17 @@ enum hk_flags {
 	HK_FLAG_DOMAIN_BOOT	= BIT(HK_TYPE_DOMAIN_BOOT),
 	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
 	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
-	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
+	HK_FLAG_TICK		= BIT(HK_TYPE_TICK),
+	HK_FLAG_TIMER		= BIT(HK_TYPE_TIMER),
+	HK_FLAG_RCU		= BIT(HK_TYPE_RCU),
+	HK_FLAG_MISC		= BIT(HK_TYPE_MISC),
+	HK_FLAG_WQ		= BIT(HK_TYPE_WQ),
+	HK_FLAG_KTHREAD		= BIT(HK_TYPE_KTHREAD),
 };
 
+#define HK_FLAG_KERNEL_NOISE (HK_FLAG_TICK | HK_FLAG_TIMER | HK_FLAG_RCU | \
+			      HK_FLAG_MISC | HK_FLAG_WQ | HK_FLAG_KTHREAD)
+
 DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
 EXPORT_SYMBOL_GPL(housekeeping_overridden);
 

-- 
2.43.0


