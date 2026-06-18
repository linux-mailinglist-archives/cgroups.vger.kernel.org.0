Return-Path: <cgroups+bounces-17066-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QxigEFFiM2oBAAYAu9opvQ
	(envelope-from <cgroups+bounces-17066-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:13:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A80F69D3F1
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 05:13:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="VsaYj/jr";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17066-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17066-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0655A301A5BF
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 03:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDB333DED5;
	Thu, 18 Jun 2026 03:12:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B0433DEF9
	for <cgroups@vger.kernel.org>; Thu, 18 Jun 2026 03:12:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752356; cv=none; b=FhVMyhQxbKgBE9/HsKnnKYAUGi+Szx1DBASEvqXql+ZIH5wGCAANw/mrtepq1tORVrNfMKWsjkuOn9Wo2yLEyrW4Jn2qenoLPDQNfpfphhcl5APnMgx6nD1GD3pWKB49KCJIKGdsoFgx+2X+HS5CRWye/V25dft4GLNE/Ed/2eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752356; c=relaxed/simple;
	bh=1wFtiEBV/eExa/0fk9lHm27dQyGmUqkvypCV6YhwRzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q/vopwg6620mImx9p0Zqhwr85CK1KtK36ZNxpyLS17XqFhedjOsfQKGDnmSke+rMOq3pkaMoHvbtG0r8De16XbQSdfg5HGp1YgC0r85tfbzq1Y+hCqda0vYS/N6CtHunztXahPAb/Rs6E22ZIp9Y61a9ifCDYN9u/V9VaGNalzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsaYj/jr; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c6a97e1d1bso3231815ad.0
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 20:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781752355; x=1782357155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=115mykkTwm3kAcmxwjkRrMY9t8k6+X+EEMpEx7hgUEU=;
        b=VsaYj/jrf+ZEe5Imp3Ek8cO/T2bMuZNeZTotlq3vYw8xilW7zHAGNKorbVZdo3YJSq
         aIBB0cD/0HMBDeUaDLkvJ834mUUS33tDonCbToIMcorUcxlLR4V+scQ7bu5nnJbjuz+A
         L2aVa/LLqsOkG1hoC3GRhgwYxotJl8xbGtv00+WzMjQgrblHsDuXs7QALbjCEA0UxpZp
         LRSlXzk0ixotFpQzgR7+3g5yW43Q2T9hunXg2yFsPi4XSduYvxGEgTilfe8OPNUtL+jd
         3Fvx2D5yh4bv0soZV0neOlkkfSFRb2dF00j3fZ7ogOqBYnvZz0b/o3zldRW4ljdjRq9H
         M4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781752355; x=1782357155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=115mykkTwm3kAcmxwjkRrMY9t8k6+X+EEMpEx7hgUEU=;
        b=Ai1uNr2myp3kYvTIxKwEoZVSWr/7UNsdDyyf5rocumgn2BwpxZSRvfaFq5X3/AZC0/
         0vR8BTNUH/rUMt3Tf3ohk5hy7CxAq5s0uxoxXjc8mG/vaaCKJdtQ7aNHwDKaTGIdg1se
         Pog2pxPITuefBIX/B9DMsinSiLX8VjfQB4v5Y1q7BpTuBZWfFbiHS6cTMvuEc1cUo1DM
         f1GRaoUikfNWZuEkxdAXWFQY5zf1cAGuHgexHT2rmbXjktZt0SFsISdUhEkeFfffkwjT
         L1ZS97YeOcXCXkgZx2z7LKehA+WiNUuVrTI/xEdFHmCw5A1p53EPgOUMDSv+M+NPzQnc
         IvBA==
X-Forwarded-Encrypted: i=1; AFNElJ+ViPhAJoiXoOguFgdQSJynvuA5MKgfU2pcNfBdtuuZb0nDmYbB95/Sphlevy28d8mpCzQguk1Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8HDdUwqJ+DuAUMjF/3X9c9UJJskFadZ97/bR1NLMU1onITdr2
	FccujZDSKzKki1coASw3G7L0arHLUPRmcr+62HuroxIyR8f30VaDiusx
X-Gm-Gg: Acq92OH7qEsUJP3oKcN7oFWYjjOD+ICLvN43quYdgZHbZ6NrKycwtaXKJ9mklhnocyL
	b3n3fUqUWVyqBcjFlbvQlp/CHtoyCiv8XLdt/NWSLfI8b1Z2g3KfjY8B6Rs0cuDTbh9idaKJi7w
	0scE3y7uQh0GwTD96izd01VBhBxmibVJp/Op/KLU1eayb+0KhUGufdSOZ+yd0yqgXu7g+EtvVkQ
	0/JIqk0N++THSAbUE8BTmEucirywdT0uLKCtKJ+aVilHdv25YLHGAa09xRMgxkX6mIXs0VVKDax
	PQTd/LSk5hAejAhKZNJedtM4LLQ3BYiIGIt+KZ62+dWGr7xUgJ+eA8Cj1vjQqQvhv/8a1xJNwxB
	oA8bkqP3Y+VFvyyFXB7RSj+RnOE2C4Dpcp7Upidx5i0nJOcb4w8xBNHfOW3+qMlBpm8No7ZhvPz
	8vJVKUqidXs08lKe+49Plsfg==
X-Received: by 2002:a17:902:ced0:b0:2c0:c625:400d with SMTP id d9443c01a7336-2c6e52debf1mr15847925ad.37.1781752354656;
        Wed, 17 Jun 2026 20:12:34 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a403b242sm60152975ad.31.2026.06.17.20.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 20:12:34 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Thu, 18 Jun 2026 11:11:22 +0800
Subject: [PATCH v3 11/13] cgroup/cpuset: Extend isolated partition to
 trigger kernel-noise isolation
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-wujing-dhm-v3-11-28f1a4d83b68@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17066-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,chinatelecom.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A80F69D3F1

When a cpuset isolated partition is created or destroyed, also drive
kernel-noise housekeeping types (HK_TYPE_KERNEL_NOISE and
HK_TYPE_MANAGED_IRQ) through housekeeping_update_types().  The sched
domain mask (HK_TYPE_DOMAIN) is updated first via the existing
housekeeping_update() call, then the explicit callback chain in
housekeeping_update_types() invokes subsystem apply() handlers to
toggle nohz_full, managed IRQ migration, and RCU NOCB offloading.

The update runs outside cpuset_mutex and cpus_read_lock, protected
only by cpuset_top_mutex.

Signed-off-by: Jing Wu <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 kernel/cgroup/cpuset.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5c33ab20cc208..67b93bd4d58f2 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1347,17 +1347,30 @@ static void cpuset_update_sd_hk_unlock(void)
 		rebuild_sched_domains_locked();
 
 	if (update_housekeeping) {
+		static const unsigned long noise_types =
+			BIT(HK_TYPE_KERNEL_NOISE) | BIT(HK_TYPE_MANAGED_IRQ);
+
 		update_housekeeping = false;
 		cpumask_copy(isolated_hk_cpus, isolated_cpus);
 
-		/*
-		 * housekeeping_update() is now called without holding
-		 * cpus_read_lock and cpuset_mutex. Only cpuset_top_mutex
-		 * is still being held for mutual exclusion.
-		 */
 		mutex_unlock(&cpuset_mutex);
 		cpus_read_unlock();
+
+		/*
+		 * Update the sched domain mask first; it must succeed
+		 * before the kernel-noise types because workqueue flush
+		 * and timer migration depend on the sched domain mask.
+		 */
 		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus));
+
+		/*
+		 * Drive kernel-noise types through the new explicit
+		 * callback chain.  Tik/rcu/genirq subtypes react
+		 * through their registered housekeeping_cbs apply()
+		 * handlers.
+		 */
+		WARN_ON_ONCE(housekeeping_update_types(noise_types,
+						       isolated_hk_cpus));
 		mutex_unlock(&cpuset_top_mutex);
 	} else {
 		cpuset_full_unlock();

-- 
2.43.0


