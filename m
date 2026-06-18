Return-Path: <cgroups+bounces-17060-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ceFiF5FiM2ocAAYAu9opvQ
	(envelope-from <cgroups+bounces-17060-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:14:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE28269D446
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:14:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lE0c4K8i;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17060-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17060-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 112213088E3E
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 03:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32C7338595;
	Thu, 18 Jun 2026 03:11:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56433331EAA
	for <cgroups@vger.kernel.org>; Thu, 18 Jun 2026 03:11:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752319; cv=none; b=Cv3rsRJX38rBI4XzyjTYcM8dHxQNUF4NSRwwHhEBCqpnsv8aQDRYqSOa3XEzW2v/Bv+SMBl05dasNANj18MrLgATzY1V3htFKaH1Z6YT0O3joT4MOkZx03FtYTSir8l+OCGAwqlEQh/Sk5sBVYKecdC3NE9vkr2NlLmFiLEiaw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752319; c=relaxed/simple;
	bh=su/86e8IzEx6KCsYE6y2QU0JcZeTp1olU2GBvdI7t20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VrXKoeXM3cWN2zXkcN5HryQvnVn0l3vPGYkhFbbKQmMqh3iwjyfDqrqy75vVzm8vU7pWRfQbJqqvEnIxQeMTr8nhxH/+Le2trV59eTRTJOFXbg4XAioUwCfF2A/g615VMla9vusYzkAc0cYJd3nYKuzo/kWS5gm98uCnozW+ZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lE0c4K8i; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf22d29dabso2822215ad.2
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 20:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781752317; x=1782357117; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1y36uZa5QHApqDykuJpc+gggPAc0ysbP66IjBiya9ds=;
        b=lE0c4K8itEg+Udz8swnAs0DMm9NEQS93H7SjpXkhcvWUEwJnhnU/xR48vyy0XhXk2N
         MdJOogr7iXhhOwXLm0xDH0XwHqsrCgzUwchmzmjqkqHXNPy+xwSPGJLrLXbULNlz0Otx
         egOr0btUqP8K22O1JJkbUWEFsozL3Zi3FpSjZYnZzFKg9kR/vr4OBKDeODwa9Vsqd4Vd
         xIEgBQ/ocu1aXvcqqRmg2ztmLlc26PqWk/qIZzukj3Lw4HSDQI0GAsm2hUmGKOAAdEUE
         T7JbVmotbagk9OmX2uQG0MVyO6sU2GwTb0lW0oSkG174onZS+pxv2BuUMA9jvA9xwk26
         XjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752317; x=1782357117;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1y36uZa5QHApqDykuJpc+gggPAc0ysbP66IjBiya9ds=;
        b=omJc6NODnNfCe1Ly93otPvUylRwbsD77PPa/K4NYDCaCyHQq0ZcTCRDVG8RsZvrxic
         hKG6Bnv88SxKwoolL9W1JHAX+HKxijaojcZNAM+Aq5mvn3qYdnhQRIF0pDo+HGrJW6Ab
         wdu3uFzHX5U5qWCWiPTa9BJUCAQzY9uSUtKvdsLQ2nTF5SyQn/iBoA6Psb12yOQV8RnB
         NiiIB4g24YLNzfWORQ9GiS6pkPgMt7unDv7r1P1ByAkEBYYODjb4Cly/FZCJwgywFLsI
         4HW1Fdqu7USfDSokH7HftqtiY3hpXChjfY9oZehBPTYLuk7SxQxLBUB1i6ypc3d6tCY3
         f3pg==
X-Forwarded-Encrypted: i=1; AFNElJ+VkHHXPIc7nK0rJTcx8ots13TwaodzABKuIMPMT/JjC945uR9/qOgbwyANOSFDoCDiVmpzC9bn@vger.kernel.org
X-Gm-Message-State: AOJu0YxE/qvR1O+DaPP3RM8VAKiB0ZZw9oM0JaUVNWS1qSjDn/JGqmDX
	VI3JP1MzzyHrmXThsj6u1lEsY4rDNH7IbFCUNTzeTjv4zR2PW0LzeUs0
X-Gm-Gg: AfdE7cnxK6fn4CLfftrfwMWpgNIeGv4a8tFu+8LHbJ3I/5iAJWJ81J7P/88iXXHIkLC
	LzpVTe6rAwgU+xSK5Eg0GJk9HW3PkbYy5F01Jt7MmRLYSCVDgkNRXAx3RdQTS3u+xb1AFIoqOn3
	L4NXafT3YcdmiMwIK+LtcxRNnyex7L5dYCShO1WqkjsuMlX2AY5LO0Wpfrqhe+FmM0ix2MZudXp
	naau5ep5gMtrlHgr5mOG/J8boWlLEzwE6raMXeGbUHLiZYV5JzEF7GJXklPhVWsz8QMaKGS6che
	jmwXBiPCsNFwm6g89Tn1Iv0VoEXf1Jn+mqRA8eghAAg5TCx/Rljszyik8DZZE/UzRM49XSxyOKh
	L8P3NSmu/CqV5rscgxj7gQVGZYdtnxNGUt4gWXeE/OGt8ovtGD1/tv6kJxz5cR6W9OiaHnxqUGt
	JnBT+/1f66LuU=
X-Received: by 2002:a17:903:240e:b0:2c0:a360:45da with SMTP id d9443c01a7336-2c6f34744e6mr5011065ad.32.1781752316749;
        Wed, 17 Jun 2026 20:11:56 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a403b242sm60152975ad.31.2026.06.17.20.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:11:56 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Thu, 18 Jun 2026 11:11:16 +0800
Subject: [PATCH v3 05/13] cpu/hotplug: Reserve CPUHP states for nohz_full
 and managed IRQ down-paths
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-wujing-dhm-v3-5-28f1a4d83b68@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17060-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,chinatelecom.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE28269D446

Add CPUHP_AP_NO_HZ_FULL_DYING and CPUHP_AP_IRQ_AFFINITY_DYING to the
cpuhp_state enum.  These dying callbacks are invoked during CPU offline
before the tick is stopped, enabling clean tick handover and managed
IRQ migration when a CPU transitions between isolated and housekeeping
states.

The existing CPUHP_AP_IRQ_AFFINITY_ONLINE already handles managed IRQ
restoration on CPU online.  The new dying callback completes the pair,
migrating managed interrupts away from the CPU before it goes down.

Subsequent patches register handlers for these states.

Signed-off-by: Jing Wu <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 include/linux/cpuhotplug.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 22ba327ec2278..075cfa8161334 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -186,6 +186,8 @@ enum cpuhp_state {
 	CPUHP_AP_SMPCFD_DYING,
 	CPUHP_AP_HRTIMERS_DYING,
 	CPUHP_AP_TICK_DYING,
+	CPUHP_AP_IRQ_AFFINITY_DYING,
+	CPUHP_AP_NO_HZ_FULL_DYING,
 	CPUHP_AP_X86_TBOOT_DYING,
 	CPUHP_AP_ARM_CACHE_B15_RAC_DYING,
 	CPUHP_AP_ONLINE,

-- 
2.43.0


