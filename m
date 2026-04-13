Return-Path: <cgroups+bounces-15257-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF55DuGe3GkEUgkAu9opvQ
	(envelope-from <cgroups+bounces-15257-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:44:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BD93E86BE
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 031B030066A8
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 07:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94786397E91;
	Mon, 13 Apr 2026 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfXeGHxD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257BF397688
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066257; cv=none; b=MZ5VNv3fmRLJPtlX0/GuLYJSG445+dzhhqr1ghf8KpNj/bfOwVbTgo/dRcf7sZNIVnPP7Im6O9dGFsRN2QOWB0lEBHiTjaWq4IlH/G7bgpYnktC4mR9A3MCP9zCUwqAP8b7hzZE+GN6kHkqIF0qN5Ra64zRd2wD7guE3arRSA/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066257; c=relaxed/simple;
	bh=abNstHmJGgw4JbpWqL555msiifzgY+9+aN3eQVlKCX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a/MAG7qkBuo4bQ0GHAzuIJECHZehvEmqZn+1ytyMX1mETEZ+OiupKpnk6X4H7d5wYXFZygbAaeVrBpUE/3sGFLMm0XTVrDKSOFSorFbY8KKsofkBiZ+nK+zv/piN1W8PnTYH4uzXL1Jw+cKxR+10N0szKV8n9XtRBipfPWh0ntg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfXeGHxD; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c1fcce8f8so6903835c88.1
        for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 00:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066255; x=1776671055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EF3HsX1PiWlQS1SWUgySjoqh/zlAKHa5r5Dv0SN822Y=;
        b=OfXeGHxDXjLlvoZJQLl2fIyr2B7Ezrmrc+Ir2bzbbK7z4cugW2V3aOao4CC1jCFf9/
         KkiyEWtA9IQ61ZMNyufOzSeQlYQn12b5HoZujPMJGD/QijERHfLBqXfuuebIhGseJ/sc
         HqRHyx9DrQFL1QQ3tGiLfAQiLQj969T+3JE/bnRN/O0bdfd3eJhHhPQ+g8MfVPWjclpw
         i1y4fo+fzljdwsDlavcuqNQAQ9sTfWraQVCDFDGa78J6daPlwai6hkt+hqdV/MP0eaPp
         vTaHIpac17q+ITfiX9s9Q4AVTfZBMhv0g0GuryusQ1pOLZpnaPsSVhVvxtsKJ9VMJG3c
         bT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066255; x=1776671055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EF3HsX1PiWlQS1SWUgySjoqh/zlAKHa5r5Dv0SN822Y=;
        b=JLYpBZACKY9rPiuuWUmLVpSIPjF3Y68xDXX4lc5NIeO5/InLVC0Z2WK5Q6ogmX46iX
         HS3A2AzxEJHN6n/of/Kr2HEC08YGma1MeIUWaKxYfIJIlAoguJ3MzlRbZheu+RzildKB
         dIBJ3Thml20T5Ef9cdDpiACdgC2US2cQ4Bw1YY00uUtgcpmiAuVlkOgVgXJjuwlhzKvS
         LJ++Z6d18+Ht7I03N7kkpV3ctfSjDonwomg1E9+EC3kp8cBQMBOL+JLvWFoQDBs2jzsy
         Ixlx8w3U0lqBJRd+P5Tgq385MvOCyhTq6Z8Jc9CuMsBstEdbpE+zKLHGv4/A7mregWVc
         g5lg==
X-Forwarded-Encrypted: i=1; AFNElJ98Go+04tbl6h0+uOHExf1QWGROJSXRsFhi2GvKHUenTejLBuI+PW4Ig/fKZP7RY2YaMp92Tc6W@vger.kernel.org
X-Gm-Message-State: AOJu0YwuHz4+ouozaK0aYQ3y+n9E+6jiyFBgQPRANLeZkqXD42OHBQdJ
	156o0TfRtToUiK3EeCNFX/DyeDB30b0wEBFcfamPQXpSHjkKthgDAWaq
X-Gm-Gg: AeBDiesGCf42vehIRxJxuYsi17EGECatMXJwKClTOFnFQ61kTRD5vTF/A+cBWWK+l9o
	F7kOG9RNcCSx53SqGXe1Kb5Xqhm1enJY0t286EEYKAtngIoNS7d5draE3DUq/7+xG0Iu9KzTBUN
	GIoFHUV5xPDc47N1k/RlbOupD6rnhyhQzeiW0Qy4eH/tsfNI3kqzF+eCEU/H0437d2/H9n+LmQj
	TtU8T4IFCYn0CZPjNyVkBVEqI/jI5xFHQ9APLxQqnig3VVGADJ7iEGaQvtCuDefKvfAukqtVmVD
	vrSMKRJSIMOTP3u85KcFxGpkcEyVJb48NlGDYWhRp7aST4s3VvNWXn8grAQus8NF0AedTDxbZOV
	Hktn1wZRlWcDxI64ml9kkGWhRC2MMmlI3hPralLGZZX9aiwsUrn/EFMX1bFU4YQIBnhUaONZDOz
	2JAPSKvI0hprL6/KcWR6D2AKd3x7o=
X-Received: by 2002:a05:7022:47:b0:128:d4be:7428 with SMTP id a92af1059eb24-12c34edee4bmr7057521c88.19.1776066255198;
        Mon, 13 Apr 2026 00:44:15 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm12884610c88.15.2026.04.13.00.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:44:14 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Mon, 13 Apr 2026 15:43:11 +0800
Subject: [PATCH v2 05/12] genirq: Support dynamic migration for managed
 interrupts
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-wujing-dhm-v2-5-06df21caba5d@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15257-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,linux-foundation.org,suse.com,cmpxchg.org,huaweicloud.com,lwn.net,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8BD93E86BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Managed interrupts currently have their affinity determined once,
honoring boot-time isolation settings. There is no mechanism to migrate
them when housekeeping boundaries change at runtime.

Enable managed interrupts to respond dynamically to housekeeping updates.

This ensures that managed interrupts are migrated away from newly
isolated CPUs or redistributed when housekeeping CPUs are added.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 kernel/irq/manage.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 2e80724378267..31e263d9f40d0 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2801,3 +2801,52 @@ bool irq_check_status_bit(unsigned int irq, unsigned int bitmask)
 	return res;
 }
 EXPORT_SYMBOL_GPL(irq_check_status_bit);
+
+#ifdef CONFIG_SMP
+static int irq_housekeeping_reconfigure(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct housekeeping_update *upd = data;
+	unsigned int irq;
+
+	if (action != HK_UPDATE_MASK || upd->type != HK_TYPE_MANAGED_IRQ)
+		return NOTIFY_OK;
+
+	irq_lock_sparse();
+	for_each_active_irq(irq) {
+		struct irq_data *irqd;
+		struct irq_desc *desc;
+
+		desc = irq_to_desc(irq);
+		if (!desc)
+			continue;
+
+		scoped_guard(raw_spinlock_irqsave, &desc->lock) {
+			irqd = irq_desc_get_irq_data(desc);
+			if (!irqd_affinity_is_managed(irqd) || !desc->action ||
+			    !irq_data_get_irq_chip(irqd))
+				continue;
+
+			/*
+			 * Re-apply existing affinity to honor the new
+			 * housekeeping mask via __irq_set_affinity() logic.
+			 */
+			irq_set_affinity_locked(irqd, irq_data_get_affinity_mask(irqd), false);
+		}
+	}
+	irq_unlock_sparse();
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block irq_housekeeping_nb = {
+	.notifier_call = irq_housekeeping_reconfigure,
+};
+
+static int __init irq_init_housekeeping_notifier(void)
+{
+	housekeeping_register_notifier(&irq_housekeeping_nb);
+	return 0;
+}
+core_initcall(irq_init_housekeeping_notifier);
+#endif

-- 
2.43.0


