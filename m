Return-Path: <cgroups+bounces-17056-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w72zBv9hM2ro/wUAu9opvQ
	(envelope-from <cgroups+bounces-17056-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:11:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA52469D3A5
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:11:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=djEp0eok;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17056-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17056-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F7B53040F82
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 03:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A56C32B12D;
	Thu, 18 Jun 2026 03:11:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B36331EAC
	for <cgroups@vger.kernel.org>; Thu, 18 Jun 2026 03:11:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752293; cv=none; b=odaTyX+Sb6qeJHk2P4hs+dj/5Usx8+kkhnNe6yB8OeCStqCINEslLEV0sud53yK8r+L4BnoKF1tsZz69Siat564hikLEuk9dvM7f3F9nm92yZEJuc/YwLtleJ6s1yL30s1Uyd6Cn2phvKYOg0P3fK1WDH/gkjPTP/083NEDoKIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752293; c=relaxed/simple;
	bh=LFnUvZsdMV36HeugdzJp7p/REa5uLOArHKOIqQWkJY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ILbEDDkEzRbB1+zu1dh7zIHfNWktKEsFIeQOI8d3aob9d+0d6ZuGhNFg8O1IYA4qCcQ2/9BL52rcfUkF7dlu+hV2Qpug8byqzHJRNhx7lyZmmNzPbKkJp6OpTjWNQ3oAycXLWMd4Za2qL7ZClUmhkzRHwg7Ql9jXGvL3yKwIEIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djEp0eok; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c3546924so4124625ad.3
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 20:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781752291; x=1782357091; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzKJaLY4P29xr36n94cF6pafuVv3SDEbWpOz12HsOhM=;
        b=djEp0eokhQ2NMzAcX24vYUFw7KCOYo04rjPuhwnJxmAZUa3gbFVTm+4j3DGzDUGPyI
         DIKUBNI+QvlSbkuKWdia3u4U+ICMFPC3G4vw5fJBciBwb87g6yNhgaJ79ePKvvyAG1to
         9AFC9zVvEUuU9Tqk5/+GOczqNlBGwyrLCrfNsLfoW0VUE4mzaoS6FrnEaeP8/8TNjG4V
         eCAKW3knJoh8YMN/rAVJAbLfn/W5c2Jte6eAUKlcwCD9/yVhgUqSsEmstPkEWKKeoC1l
         /djM+oK4tN5Iayfhe9A6NKs26Jrap7Gkn+J4WbhSaj8NM5Idz3QanszWiLIJseWhGKgR
         xHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752291; x=1782357091;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WzKJaLY4P29xr36n94cF6pafuVv3SDEbWpOz12HsOhM=;
        b=BaQGMFOdlnV5L7PtRrvCmJgTmVu5RvDPsbF5boEIwE27+i3PiVICGk1VmZtguUTSNe
         KmDvS/0Rfx7+/Q+7JjpM7pxwe6e885rVKDNOC7kMreA59zcwXFwh/MIdcGax91KCuXMI
         AXO81tYFOf8aElpGh+v8K8/gQzV6o63+1bvr54sRFWuF3XGyptG3vl3UhKxZ7tWe8Km3
         AmwYKPih/a+YifykS3Ny1lSAd7JbqzBZ3DDivGVHzc+3Gqjufz6nJRGomorNe9j3YL9z
         KB1BpHzFOYEbn0AzRGpXrhDYkrjVn4HjQZvYw0zvYNFEXJEYydAxYqaTrivbG6lEGcjK
         HIRA==
X-Forwarded-Encrypted: i=1; AFNElJ+OQ0DBmrIcJb1U5GRmBBa+ZMCTQwWXJgUHME1o1Kkd7xCCkMo1NhmCnUfW8/l0BHGN1Z/aRkN1@vger.kernel.org
X-Gm-Message-State: AOJu0YzPx5KdK/hRJNlYmlPwUqLUZiD4Wfm9xKOSye9rNPgRc1/7td1s
	QMJvNIE4IX+Z6y9kTmLS44NhvxBfeZcoSV2ZCGEfKfcxbk1X5EWHggh2
X-Gm-Gg: AfdE7cnrtXb6vvHg9ZYlHhAEshWAPB2qRcFx5sB/t6XISBaDBFixrHFa6/s5rS8eT7c
	P9xbNvaSDqEJHb0mj0f0F5vJOma59plJMdZUPpMgD6ZmorRntUrCPXFzz6HOwq4Dq5Cn51AZDCN
	unhsixpR5HmNI8SSP0vPoTgjOzv/XSaAKb5CO8eFGGJ1fqHXRw4ot33FS6svDdVm0JUTA3gEROL
	Quqf6Y/4G4RPyzaK6MFxsaJBrb6iOB7ngwP+nyIKmO7huyt8F7iuofxPYBJnT8wc30C+rPvSbKo
	yp4p2JZ9SAjKLyQDVANIw7VDHtsxeGNBxW52AcZqboKlTsqVbfan/q8NVyoL1y9wbBjt+IZ7Ew5
	zjvv+5lKpRaABshAe5bgNHLSDklIl1Dyo/Xz0BSuutdDoOPIYwPi8A1C9rQdqnpV/7sEDlvc67L
	N5c7A3p19CzUA=
X-Received: by 2002:a17:902:f688:b0:2c6:c66b:4b03 with SMTP id d9443c01a7336-2c6e4746cb1mr16305205ad.10.1781752290966;
        Wed, 17 Jun 2026 20:11:30 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a403b242sm60152975ad.31.2026.06.17.20.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:11:30 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Thu, 18 Jun 2026 11:11:12 +0800
Subject: [PATCH v3 01/13] sched/isolation: Replace notifier chain with
 explicit callback interface
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260618-wujing-dhm-v3-1-28f1a4d83b68@gmail.com>
References: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
In-Reply-To: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
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
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Tejun Heo <tj@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17056-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,chinatelecom.cn];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,chinatelecom.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA52469D3A5

Replace the blocking notifier chain with an explicit per-type callback
table (struct housekeeping_cbs).  Each subsystem registers callbacks
at initcall time; pre_validate() runs before the RCU pointer swap to
allow rejecting the update, and apply() runs after synchronize_rcu()
when the new mask is visible to readers.

The table is limited to HK_MAX_CBS (4) slots per type, sufficient for
the kernel-noise subsystems and avoiding unbounded dynamic allocation
in the update path.  The interface provides deterministic callback
order and explicit registration, giving each subsystem maintainer clear
visibility into when and why its callback is invoked — unlike the
opaque priority-based dispatch of notifier chains.

Signed-off-by: Jing Wu <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 include/linux/sched/isolation.h | 31 +++++++++++++++
 kernel/sched/isolation.c        | 87 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index cf0fd03dd7a24..f362876b3ebdf 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -46,6 +46,33 @@ extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
 extern int housekeeping_update(struct cpumask *isol_mask);
 extern void __init housekeeping_init(void);
 
+/**
+ * struct housekeeping_cbs - Per-subsystem callbacks for housekeeping mask changes
+ * @name:		Subsystem name for diagnostic messages
+ * @pre_validate:	Run before RCU pointer swap.  Return -EINVAL
+ *			to reject the update.
+ * @apply:		Run after synchronize_rcu().  Reconfigure subsystem
+ *			state.  The new mask is visible to readers.
+ *
+ * Register subsystem callbacks at initcall time.
+ * Invoke callbacks in registration order when the corresponding
+ * housekeeping mask changes.  Skip types not present in the update
+ * mask.
+ *
+ * Replace the notifier-chain pattern with deterministic callback
+ * ordering.
+ */
+struct housekeeping_cbs {
+	const char			*name;
+	int	(*pre_validate)(enum hk_type type,
+				const struct cpumask *cur_mask,
+				const struct cpumask *new_mask);
+	void	(*apply)(enum hk_type type);
+};
+
+int housekeeping_register_cbs(enum hk_type type, struct housekeeping_cbs *cbs);
+int housekeeping_unregister_cbs(enum hk_type type, struct housekeeping_cbs *cbs);
+
 #else
 
 static inline int housekeeping_any_cpu(enum hk_type type)
@@ -73,6 +100,10 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
 
 static inline int housekeeping_update(struct cpumask *isol_mask) { return 0; }
 static inline void housekeeping_init(void) { }
+static inline int housekeeping_register_cbs(enum hk_type type,
+					    struct housekeeping_cbs *cbs) { return 0; }
+static inline int housekeeping_unregister_cbs(enum hk_type type,
+					      struct housekeeping_cbs *cbs) { return 0; }
 #endif /* CONFIG_CPU_ISOLATION */
 
 static inline bool housekeeping_cpu(int cpu, enum hk_type type)
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index ef152d401fe20..aae4dff7fbfc8 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -28,6 +28,93 @@ struct housekeeping {
 
 static struct housekeeping housekeeping;
 
+/*
+ * Maintain an explicit callback table indexed by housekeeping type.
+ * Invoke callbacks for affected types in deterministic order:
+ * pre_validate() before the RCU pointer swap, apply() after
+ * synchronize_rcu().
+ */
+#define HK_MAX_CBS 4
+
+static struct {
+	struct housekeeping_cbs *cbs[HK_MAX_CBS];
+	int nr;
+} housekeeping_cbs_table[HK_TYPE_MAX];
+
+/**
+ * housekeeping_register_cbs - Register explicit callbacks for a housekeeping type
+ * @type:	Housekeeping type to register for
+ * @cbs:	Callback structure containing pre_validate() and apply()
+ *
+ * Callbacks run in registration order when the mask for @type changes:
+ * pre_validate() before the RCU swap may reject the update; apply()
+ * after synchronize_rcu() reconfigures subsystem state.
+ *
+ * Return: 0 on success, -EINVAL if @type or @cbs is invalid,
+ * -ENOSPC if the per-type table is full.
+ */
+int housekeeping_register_cbs(enum hk_type type, struct housekeeping_cbs *cbs)
+{
+	if (type >= HK_TYPE_MAX || !cbs)
+		return -EINVAL;
+	if (housekeeping_cbs_table[type].nr >= HK_MAX_CBS)
+		return -ENOSPC;
+	housekeeping_cbs_table[type].cbs[housekeeping_cbs_table[type].nr++] = cbs;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(housekeeping_register_cbs);
+
+/**
+ * housekeeping_unregister_cbs - Remove previously registered callbacks
+ * @type:	Housekeeping type
+ * @cbs:	Callback structure to remove
+ *
+ * Return: 0 on success, -EINVAL if arguments are invalid,
+ * -ENOENT if @cbs was not registered.
+ */
+int housekeeping_unregister_cbs(enum hk_type type, struct housekeeping_cbs *cbs)
+{
+	int i;
+
+	if (type >= HK_TYPE_MAX || !cbs)
+		return -EINVAL;
+	for (i = 0; i < housekeeping_cbs_table[type].nr; i++) {
+		if (housekeeping_cbs_table[type].cbs[i] == cbs) {
+			housekeeping_cbs_table[type].cbs[i] =
+				housekeeping_cbs_table[type].cbs[--housekeeping_cbs_table[type].nr];
+			return 0;
+		}
+	}
+	return -ENOENT;
+}
+EXPORT_SYMBOL_GPL(housekeeping_unregister_cbs);
+
+static int housekeeping_pre_validate_cbs(enum hk_type type,
+					 const struct cpumask *cur,
+					 const struct cpumask *new)
+{
+	int i, ret;
+
+	for (i = 0; i < housekeeping_cbs_table[type].nr; i++) {
+		if (!housekeeping_cbs_table[type].cbs[i]->pre_validate)
+			continue;
+		ret = housekeeping_cbs_table[type].cbs[i]->pre_validate(type, cur, new);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
+static void housekeeping_apply_cbs(enum hk_type type)
+{
+	int i;
+
+	for (i = 0; i < housekeeping_cbs_table[type].nr; i++) {
+		if (housekeeping_cbs_table[type].cbs[i]->apply)
+			housekeeping_cbs_table[type].cbs[i]->apply(type);
+	}
+}
+
 bool housekeeping_enabled(enum hk_type type)
 {
 	return !!(READ_ONCE(housekeeping.flags) & BIT(type));

-- 
2.43.0


