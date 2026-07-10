Return-Path: <cgroups+bounces-17635-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jIjKLR1nUGojyQIAu9opvQ
	(envelope-from <cgroups+bounces-17635-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:29:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 302A9736F79
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:29:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TOqZeRep;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17635-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17635-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EC583036E90
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 03:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E97367B92;
	Fri, 10 Jul 2026 03:28:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4FF361641
	for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 03:28:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654131; cv=none; b=D9wwXgjaHneqzrtZb39QqjX/qqFeikIYCozfgWOTghrWd0KplbWYoHRODJZVKHQI01ZXA/T/HCnLnP2CYP7AsbEWrsGgD2PSCHYbtNhuUC5CJYvBLn5vKGvsTiiPiAUefuIEwE7jPK0sFpracdCfqC5Y0KYpLKCGp9kkp7GY7eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654131; c=relaxed/simple;
	bh=DSH1dsD7ufyJUSitPhujJbKPkynswivD0Ay115xuL8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uVdCfaVjJEn/hjXUutltUNfykxa8XonPWtHrxniYIR5sw4R9/FOU03hOGqOYD7BQ1CmhaBJYnzNdh3mYQae+r3SPU+hNQwJgdfBrY+CQ6xtc0lx9XSIeNI9CBX0UwjNbCsc+Zc0hRIxMbuwfWpotm6kFiC+6pXUva7360lDkzTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOqZeRep; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2caf4496889so3430515ad.1
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 20:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783654130; x=1784258930; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8OHQR36SH5DHkwv4ahYjdM9a+G5jG41FdFMZ2BcZsNM=;
        b=TOqZeRep6oegsbqogMXnoxA1Rl9xdeE5wTH4F3P1nrrQZoy03wVa7K5pG04W8Je6N6
         iYxhrF4ccDJjIVym2aNTT6Pf4ElV2wq6jDKLnoVG5X49+Y5/+e9WeRxIG5KjHM7UM+S7
         pNa9ryubNJodOkwUmNDEbOYJl+JOnZznJAPznk9MmvXxk+1E/YUfxSJ1+teWOatFBujw
         U4DyC85XyO0CgHkS1GO8DQHlxXOkmAHNIpHbqEu4ZnxFBgE2eF3cipGp4QbWKlA/EW7k
         KIwSgYtL2cP9/itQ/izW2ZTrJ0hZph4+HRXDuXMwc6EmBhj6V4wX6QzHzyGLvoX2gEdf
         kpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783654130; x=1784258930;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8OHQR36SH5DHkwv4ahYjdM9a+G5jG41FdFMZ2BcZsNM=;
        b=MUENsJnPMHywIZbYO5IH19uxUvMS3A6ypsz25ds6rZDxwiJIRNSWOH11xhT1p6i3IQ
         7oaPzEjDBj8JHTDdljXccqFSgHZCDAc5OS3n8uhsSoD4P6n1sWYbhL2WiJUxJboPxSv9
         ipVMK9mcQjKZouyfXPjPuSCn2xQEj0JP1Dbq1cNRjvYWwCQeR6D0Fax39aacDEXtqIB/
         B6J6ESLma1L8x7aRqdlS47grlIPJ4y54TzxQYs/dRMnwF49hsarf/KwMQDf6g8bA3ThK
         Nk1njLkqeIygj64joUoXPiWUpzXNJW4URfqzobeE7j9hCjxr5LL2xpxuKXyDiymiALOi
         4Xgw==
X-Forwarded-Encrypted: i=1; AHgh+RqjxaMYTk32mtyWKpyMulb2u2nprwKsekYui+NM5uU4RcMsiv8pn1np7rz1l1zgzXpvQiBw9xTk@vger.kernel.org
X-Gm-Message-State: AOJu0YwTUhnihF7WGGsKwxrArKaUQbppCIwwrf/q4svwdZmnxa7jT+Nh
	srN72pAGKysoc0KsJ2dKtcyVne0GaQq12U2xEoZ0R2z0T9+ZC+04lz/H
X-Gm-Gg: AfdE7ckfmMtH1yW5GTKAW+pxcrPiAoTcjMJZVquzVee8RbrggWHqZ9Or7bdT1MVg9/k
	7VvbHtqfpoDR0t0fGXdkr87DIezFgPGKxq+6mGzilUcKmyavQ5UajEcGRVwV99r702mZYwShzY5
	MxDcWURJ1jhV9vOTc4bdgf1jnx0WB7Y/bmrwB5c5kOHh8mQZGg1jxRkc1iRMt6n8BuGUgLgdGd8
	b1kJt+gb8l8QD2GkZ3w2nxSQWdICjdTQZHt1YwAxY7Wz+2D7vjuA92KDw0jCnjHL8+GZuR1FkKN
	DLEUi9FIcc5CKDFWY4MwZIkKpyYg3O4Rvagka5dmPd6htsqXM89xYyj10EwIrLuvfNTfIzQzdCO
	lJ+6yJLrZVHbOMjQ6RCGscuMqRjkzV1oh8KXmrJBsB8Tvaf2KiAjPuXrJdO+jYidGwfPLXXluOb
	5+vUshF95f2mI=
X-Received: by 2002:a17:902:d2c7:b0:2c9:994c:9a5 with SMTP id d9443c01a7336-2ce8298a501mr18775855ad.30.1783654129682;
        Thu, 09 Jul 2026 20:28:49 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm53436465ad.15.2026.07.09.20.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 20:28:49 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Fri, 10 Jul 2026 11:28:14 +0800
Subject: [PATCH v4 03/11] cgroup/cpuset: Drive kernel-noise housekeeping
 updates from isolated partitions
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-wujing-dhm-v4-3-2e912e5d9645@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:longman@redhat.com,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17635-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chinatelecom.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 302A9736F79

An isolated cpuset partition already updates the HK_TYPE_DOMAIN
housekeeping mask.  Extend it to also update the kernel-noise masks
(HK_TYPE_KERNEL_NOISE and HK_TYPE_MANAGED_IRQ) so that creating or
destroying an isolated partition reconfigures the full set of
housekeeping cpumasks.

The sched domain mask is updated first because the workqueue flush and
timer migration paths depend on it; the kernel-noise masks are updated
afterwards via housekeeping_update_types().

housekeeping_update() and housekeeping_update_types() are called after
dropping cpus_read_lock and cpuset_mutex, with only cpuset_top_mutex held
for mutual exclusion.

Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Jing Wu <realwujing@gmail.com>
---
 kernel/cgroup/cpuset.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5c33ab20cc208..80f43a24d3c8a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1347,17 +1347,36 @@ static void cpuset_update_sd_hk_unlock(void)
 		rebuild_sched_domains_locked();
 
 	if (update_housekeeping) {
+		static const unsigned long noise_types =
+			BIT(HK_TYPE_KERNEL_NOISE) | BIT(HK_TYPE_MANAGED_IRQ);
+
 		update_housekeeping = false;
 		cpumask_copy(isolated_hk_cpus, isolated_cpus);
 
+		mutex_unlock(&cpuset_mutex);
+		cpus_read_unlock();
+
 		/*
 		 * housekeeping_update() is now called without holding
 		 * cpus_read_lock and cpuset_mutex. Only cpuset_top_mutex
 		 * is still being held for mutual exclusion.
 		 */
-		mutex_unlock(&cpuset_mutex);
-		cpus_read_unlock();
+
+		/*
+		 * Update the sched domain mask first; it must succeed
+		 * before the kernel-noise types because workqueue flush
+		 * and timer migration depend on the sched domain mask.
+		 */
 		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus));
+
+		/*
+		 * Update the kernel-noise housekeeping masks
+		 * (HK_TYPE_KERNEL_NOISE and HK_TYPE_MANAGED_IRQ).  The tick,
+		 * RCU and managed-interrupt state is reconfigured as the
+		 * affected CPUs are cycled through the CPU hotplug machinery.
+		 */
+		WARN_ON_ONCE(housekeeping_update_types(noise_types,
+						       isolated_hk_cpus));
 		mutex_unlock(&cpuset_top_mutex);
 	} else {
 		cpuset_full_unlock();

-- 
2.43.0


