Return-Path: <cgroups+bounces-17638-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ntZpIDdnUGo0yQIAu9opvQ
	(envelope-from <cgroups+bounces-17638-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:29:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A93E736F91
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:29:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="FAwlXME/";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17638-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17638-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BE4B30277C6
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 03:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA711991CB;
	Fri, 10 Jul 2026 03:29:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1003F3672A5
	for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 03:29:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654160; cv=none; b=IaRg9SlHEdWpz61e7+ob6oLT6eBKT6m3fzuJ47SXlbMGx2l1TAZQerFL3tuOgv8lCeyI/4AddZhbjmrIwNL/ci2S8N50I8+68aCv3vIFLAk+wgU3Hv3brWraJ4EX4xF37jxig1mbQMv3gyDDKskSkhBc/eRqv8KysxL59aKiL+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654160; c=relaxed/simple;
	bh=XLXzIgc0ems38hTXhytSCLWNSTJ6/lnczDaOsWqzk80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kEbRTJA2ONfoIJ3gXDTwUgyhkmiSRjavBS1A2ftbXKeolQQtxVXjyttyTDpO8LZukmCBIrMTzyBjSErWLXgApPsSf7JrsOkpDx2OLHErFIMLiP8JOki7TxGopv1TXXiFYr8zcKVIRO00DPMGKmleDco33MLCj5G/5dM2QGPmkwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAwlXME/; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caea3f742bso4787765ad.0
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 20:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783654158; x=1784258958; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=foKf2OzW/IJk9qSRNXtj3QHT8NO8zJPjssJk6y4CFnQ=;
        b=FAwlXME/ZU8CIggt766MxOWFrtD1DEAq+1QJV89HtJ/4qNAdyqlrf/mhagoGSGEkRn
         simFefKR9u1kk0tTchJvpGxeImcfcMQ+B3g9eTnnkDEH9XXJLiKeNBiBoFJhpiNoTROV
         JPfNXiOvjRdsXCNgbxO6KYKDP20enDacVWXEzfyJzG3eTFqBg1o+IgDB+qgBK4SpH1bV
         yjUrAOOQSD0c67wB5qVWQYidOMm3XPFPFvlrZxewjKtLcSQg5kZIti0sNZqwA4jlgV1T
         5fy1b02DQ9S97U8n8/oJN3AhnVlmiLR1Dx9eL1uSHP/O9VPhJb8mU8FiWzuxGLj7+ByE
         oXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783654158; x=1784258958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=foKf2OzW/IJk9qSRNXtj3QHT8NO8zJPjssJk6y4CFnQ=;
        b=IVL2nujNOVLEN8WGLMuzNNagzI9UofbxiJopYkT/Fort8MmqZ+6Yhgdwdrjeo4EC4D
         5vq+E1CNURqZ9w/q+cV9/nkBObkvzppCC4KZSGFSRFB8GYMUvKIfOHcS7P3bJpMogngF
         25C4BrjQcKCbrL1rbabt1vT06CCaPKJ8Skhzez5pgZ6Nw7V8q7OnCHTklSIbvsZ+NSTW
         2lve/JNN0J0/rQmDHeQtrgx5C06sFu+6e/DSLq99hSglmMWqtB5aHVKwLcsr3g2IDaDN
         WDsZTp6SOnk23VzY2oBwRWP6SZya1cjhRwvxmucElcWxtMZFHIOs07CgieFnKF4geupt
         lhZQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPWBLlsM9uJwlaIH+VmjwGXCQ/KjCzRZeIS2gbMnIe6T2ihusBQwXiKAEYhwHxWF8OD72/Md4V@vger.kernel.org
X-Gm-Message-State: AOJu0YzuJq3oTpNGKnPf2Fja/qZjxRocPBsRIylIZe/lnAdaWDgPEbYv
	rBoCOxCKkrCf9lzDYexPlL151Dy96sT2zb3sUP9jzyqrH+gPhwZ/occ6
X-Gm-Gg: AfdE7cnIKvizcLuddKAPRCww5EkIY3Ul9VCmgzBOk7Ew+PlfooraY3oVnoOFrYCxXzE
	rCLuO8sNKG0dtm1gIodlFK0vLfdNYDzkQP9VjlWR/wi4JHEXGcymH45E66yHaTImZ1FlWsocloS
	XA5SYZ1NHvQY8A4/c/TAs0+0b4FCmhVjt5p4d4LI1R3LOCttO7GsbAeq9WbsibXTzNhVBI6XJR8
	SnOSgPfu302lpcF+K8ZjhEw9BMf1pp2Era2Bb6fl2JWwK3BWwgs31gfdi8FWjtoczkmcaN24nsp
	WybockiJPTqyFwIPqraDFG4ESKWgC1ewBfi1s+p4D+sWMo1KLOuSuSafWdhO0mkWusuaPquJTRi
	omUzUCcUUwiLUlk1qcVYKYK6Gk/R7Ti0yapkjI9lMVO/FWSMS4pOiBwDodCJmeo4rx8pmSlIIRF
	rIcScX9j/rcDU=
X-Received: by 2002:a17:902:f78b:b0:2ce:6d4a:5b8a with SMTP id d9443c01a7336-2ce6d4a5c71mr56853935ad.38.1783654158257;
        Thu, 09 Jul 2026 20:29:18 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm53436465ad.15.2026.07.09.20.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 20:29:17 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Fri, 10 Jul 2026 11:28:17 +0800
Subject: [PATCH v4 06/11] watchdog: sync watchdog_cpumask with
 HK_TYPE_KERNEL_NOISE on isolation
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-wujing-dhm-v4-6-2e912e5d9645@gmail.com>
References: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
In-Reply-To: <20260710-wujing-dhm-v4-0-2e912e5d9645@gmail.com>
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
Cc: Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, 
 Qiliang Yuan <yuanql9@chinatelecom.cn>
X-Mailer: b4 0.13.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:longman@redhat.com,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17638-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,chinatelecom.cn];
	RCPT_COUNT_TWELVE(0.00)[33];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,chinatelecom.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A93E736F91

The watchdog is initialized at boot to run on all housekeeping CPUs
(HK_TYPE_KERNEL_NOISE). When a cpuset isolated partition removes CPUs
from that mask at runtime, watchdog continues running on those CPUs
because nothing updates watchdog_cpumask.

Save the boot-time watchdog_cpumask as watchdog_cpumask_boot, which
captures the user's intended coverage (possibly narrowed via kernel
parameter or sysctl) before any runtime isolation. Introduce
lockup_detector_hk_update() which intersects this boot snapshot with
the current HK_TYPE_KERNEL_NOISE mask and reconfigures the detector.
This ensures that isolated CPUs are excluded while honoring any
manual narrowing the admin applied at or after boot.

lockup_detector_hk_update() snapshots the RCU-protected housekeeping
mask under rcu_read_lock(), then updates watchdog_cpumask and calls
__lockup_detector_reconfigure() under watchdog_mutex, matching the
same locking discipline used by proc_watchdog_cpumask().

Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Jing Wu <realwujing@gmail.com>
---
 include/linux/nmi.h |  2 ++
 kernel/watchdog.c   | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index bc1162895f355..0bbe562de67b7 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -37,6 +37,7 @@ extern int sysctl_hardlockup_all_cpu_backtrace;
 static inline void lockup_detector_init(void) { }
 static inline void lockup_detector_retry_init(void) { }
 static inline void lockup_detector_soft_poweroff(void) { }
+static inline void lockup_detector_hk_update(void) { }
 #endif /* !CONFIG_LOCKUP_DETECTOR */
 
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
@@ -120,6 +121,7 @@ void watchdog_hardlockup_enable(unsigned int cpu);
 void watchdog_hardlockup_disable(unsigned int cpu);
 
 void lockup_detector_reconfigure(void);
+void lockup_detector_hk_update(void);
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR_BUDDY
 void watchdog_buddy_check_hardlockup(int hrtimer_interrupts);
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index c18c3e9781d7b..26463f6d3a39d 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -53,6 +53,8 @@ static int __read_mostly watchdog_hardlockup_available;
 
 struct cpumask watchdog_cpumask __read_mostly;
 unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
+/* Boot snapshot: user's intended watchdog mask before any runtime isolation. */
+static struct cpumask watchdog_cpumask_boot __ro_after_init;
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR
 
@@ -1348,6 +1350,27 @@ static void __init lockup_detector_delay_init(struct work_struct *work)
 	lockup_detector_setup();
 }
 
+void lockup_detector_hk_update(void)
+{
+	cpumask_var_t new_mask;
+
+	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
+		return;
+
+	rcu_read_lock();
+	cpumask_and(new_mask, &watchdog_cpumask_boot,
+		    housekeeping_cpumask_rcu(HK_TYPE_KERNEL_NOISE));
+	rcu_read_unlock();
+
+	mutex_lock(&watchdog_mutex);
+	cpumask_copy(&watchdog_cpumask, new_mask);
+	__lockup_detector_reconfigure(false);
+	mutex_unlock(&watchdog_mutex);
+
+	free_cpumask_var(new_mask);
+}
+EXPORT_SYMBOL_GPL(lockup_detector_hk_update);
+
 /*
  * lockup_detector_retry_init - retry init lockup detector if possible.
  *
@@ -1390,6 +1413,7 @@ void __init lockup_detector_init(void)
 
 	cpumask_copy(&watchdog_cpumask,
 		     housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
+	cpumask_copy(&watchdog_cpumask_boot, &watchdog_cpumask);
 
 	if (!watchdog_hardlockup_probe())
 		watchdog_hardlockup_available = true;

-- 
2.43.0


