Return-Path: <cgroups+bounces-17640-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N0AvJOdpUGoPygIAu9opvQ
	(envelope-from <cgroups+bounces-17640-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:41:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A61973709E
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 05:41:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Bt8EBiUI;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17640-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17640-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1D913043467
	for <lists+cgroups@lfdr.de>; Fri, 10 Jul 2026 03:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D721E367B82;
	Fri, 10 Jul 2026 03:29:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975B5367B73
	for <cgroups@vger.kernel.org>; Fri, 10 Jul 2026 03:29:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654181; cv=none; b=QN7zsEW/I7gpR2wo82hK18PX9PlWEWvzBLOK5TDnUxHfdwLT4MtjyM6Ydwaf6Jgqjw6BtByyp7hqlJhg6Ot61xjKztEQZwFu4zrxMBENoSWe2kwIY6XuEsKO3lDRNSej7xPstaP38BBhTLPOHsGBPl8JwCAMvFsdqVtfgmxGbfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654181; c=relaxed/simple;
	bh=0kVUx60+5alzmI6kgDLzOujtVEhari+4UwkUd1VMwS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XfaeOnNwUi3AowO940CHZnX7YrI1P+0Jku5cU7i+KhOtNjpP0fClT5SqyO5t0Hh8OP4PYAl91KV+kGKTXeUsH7Y9MJwwUa+6JaqwuhhyzcmKM7qARF3WwyolZ/tDzO6VNsKb7FHNXs5GNzBIrt2vgI8xkajfwbolLIML4J2GuQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bt8EBiUI; arc=none smtp.client-ip=209.85.214.178
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so3688275ad.1
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2026 20:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783654179; x=1784258979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mrKXut03HXmQzwP+VjNkq+G+JdZqPXgKjkWKKkzd7+Y=;
        b=Bt8EBiUI2V1wO/K1l4Lhczu1qbvAKxWWLcDVIaRqro2iD8040Zp0B29lShkQSOZqIF
         RaOhkFfd1jw/2JevWdAHN8MDl5/Rz0LVgkys/NG3qmkDACsvZMr340yo6cR/p02sVzfa
         Wk9sXELAFSfRZ5D4FDm71dyKQu+mri5cQXtazs71jcl8Mm9Yjp/z6zpCtpJ9GVDo1TVn
         RpxfAuT8075tF4tdEsYCPsgxzgZGLVEixqLXb1RCniZ7rBI2z7gnaoRFyKFDhjnNO0j5
         L8Y1cQ1BlE36/M4ZUDZCg3C5jESYopsnCGY1gF8nyvHYKsqEr6NamSU+iOItO9Pg8Wa+
         4WJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783654179; x=1784258979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mrKXut03HXmQzwP+VjNkq+G+JdZqPXgKjkWKKkzd7+Y=;
        b=GF/iNdUYmwqii83J854jRIw/ClpN1Yys8ubEOPhBjtIjY7a/NYdyZDbFWkarlLHAX2
         w1hBUbWDvyhvMTxNZ65CZzClfWptmNmBQ+HzKS3tBaQxhfRcaOn5De10ZCLoPE2UEOT0
         QGrrTzGrmfD+v4T8WqeGcCYwDelglnJtjPpm3FORhX4kmpsrwHHYmGi8XK9JcEpzaGn0
         sKKLuBw8t3Da8FRQKlGCUf9ZDwpD/iLVIKk7M4UcDmCBnyDNfJQfjE/QDSrNoV1BPzmr
         gj+zrYeoKWdaRAtS3uJVxf+J3D59I7A0otOJb6tTnPCjErot5VdRZMZeFxXzZxbZdTcQ
         qH9A==
X-Forwarded-Encrypted: i=1; AHgh+RpOtHMDfAnwu0vIfOQ7wCE7096dB0fAMoI2kudoAujwOUJ3t6gF1J/MWSESDBoqb72Y8bd1Ox9/@vger.kernel.org
X-Gm-Message-State: AOJu0YyiW9ISGjiLc3zeS7eIoWRMYkHL9YaPrFiS04FT7sCmphQkv4gL
	JgXFU1y3/at0AdFA9VVXdxe6zcc/Xka/pmNGS6ScWy3Nis1AqKAarm1Z
X-Gm-Gg: AfdE7cmc2+ETsAICPRJ8pbkiDogO9k5z01NbXvJNP2pUqt7bUTfSvxRaG2HVRXcKcK7
	J8WYcajx8N4Lgu1JaynfVoYxv1wKMCbq7lXX90D61kqwUN6VJ/6pyilEvOJepekC1sx/WEHK5PR
	RlTrsF/jlzSjAVla3l6nMxVbioW3/yr1Hlj3IYd/1X5uxKzu8cNY4IJcN40+mkwEFeGE+teoaPp
	d6y9A8qYba6OcjraAur3Out2wwWKwt0C6v1QGFoAA889vw4NFHiiOXWKrG5Z/fDyd4Sncuf+Kfy
	LkYjjqRWK2ABRGDy73lu2/5vwOazdW/b8OO8uP41QBvCOmaPdUFFPz8zkP5kf+mEKlpu6H2UcyU
	kYRiKkiDOKEPpqwSWcVQHqMjBkqQwwxc+EBVC0URWFqDZgZShp675e61JJLGCXmJj8D5QwTFTyO
	XeBrC2dllQGkS02wV9gw6EvA==
X-Received: by 2002:a17:903:2411:b0:2c9:b396:1a55 with SMTP id d9443c01a7336-2ccea394d5dmr102447495ad.12.1783654178893;
        Thu, 09 Jul 2026 20:29:38 -0700 (PDT)
Received: from [127.0.1.1] ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm53436465ad.15.2026.07.09.20.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 20:29:38 -0700 (PDT)
From: Jing Wu <realwujing@gmail.com>
Date: Fri, 10 Jul 2026 11:28:19 +0800
Subject: [PATCH v4 08/11] cpuset: add dhm_cycling_cpus mask to suppress
 transient invalidation
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-wujing-dhm-v4-8-2e912e5d9645@gmail.com>
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
X-Rspamd-Action: add header
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[chinatelecom.cn:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:tglx@kernel.org,m:longman@redhat.com,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:realwujing@gmail.com,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17640-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,chinatelecom.cn];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A61973709E
X-Spam: Yes

When the cpuset code cycles a CPU through hotplug to apply kernel-noise
isolation (remove_cpu followed by add_cpu), the CPU disappears from
cpu_active_mask temporarily. cpuset_hotplug_update_tasks() sees an
empty effective CPU set on the isolated partition and issues
partcmd_invalidate, tearing down the partition. The subsequent add_cpu
brings the CPU back online, but the partition has already been marked
invalid and requires manual user intervention to restore.

Add a global dhm_cycling_cpus cpumask protected by dhm_cycling_lock.
The isolation cycling path sets the bits for CPUs being cycled before
calling remove_cpu(), clears them after add_cpu() completes.
cpuset_hotplug_update_tasks() checks whether any of the cpuset's
effective exclusive CPUs are in dhm_cycling_cpus and skips the
invalidation command when they are, treating the transient empty-CPU
state as expected rather than an error.

A global cpumask avoids the need to walk the cpuset tree to find the
owning cpuset during the cycling loop which runs without cpuset locks.

Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Signed-off-by: Jing Wu <realwujing@gmail.com>
---
 kernel/cgroup/cpuset.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 80f43a24d3c8a..62eb6798a0c3e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -156,6 +156,14 @@ static bool		update_housekeeping;	/* RWCS */
  */
 static cpumask_var_t	isolated_hk_cpus;	/* T */
 
+/*
+ * CPUs currently being cycled through hotplug for kernel-noise isolation.
+ * Protected by dhm_cycling_lock; read in cpuset_hotplug_update_tasks() to
+ * suppress transient partition invalidation during the offline step.
+ */
+static DEFINE_SPINLOCK(dhm_cycling_lock);
+static cpumask_var_t	dhm_cycling_cpus;
+
 /*
  * A flag to force sched domain rebuild at the end of an operation.
  * It can be set in
@@ -3708,6 +3716,7 @@ int __init cpuset_init(void)
 	BUG_ON(!zalloc_cpumask_var(&subpartitions_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&isolated_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&isolated_hk_cpus, GFP_KERNEL));
+	BUG_ON(!zalloc_cpumask_var(&dhm_cycling_cpus, GFP_KERNEL));
 
 	cpumask_setall(top_cpuset.cpus_allowed);
 	nodes_setall(top_cpuset.mems_allowed);
@@ -3804,6 +3813,20 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	if (remote && (cpumask_empty(subpartitions_cpus) ||
 			(cpumask_empty(&new_cpus) &&
 			 partition_is_populated(cs, NULL)))) {
+		bool cycling;
+
+		/*
+		 * Suppress transient invalidation when the offline is part
+		 * of a hotplug cycling step for kernel-noise isolation.
+		 */
+		spin_lock(&dhm_cycling_lock);
+		cycling = cpumask_available(dhm_cycling_cpus) &&
+			  cpumask_intersects(cs->effective_xcpus,
+					     dhm_cycling_cpus);
+		spin_unlock(&dhm_cycling_lock);
+		if (cycling)
+			goto unlock;
+
 		cs->prs_err = PERR_HOTPLUG;
 		remote_partition_disable(cs, tmp);
 		compute_effective_cpumask(&new_cpus, cs, parent);
@@ -3821,8 +3844,21 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	if (is_local_partition(cs) &&
 	    (!is_partition_valid(parent) ||
 	     tasks_nocpu_error(parent, cs, &new_cpus) ||
-	     cpumask_empty(subpartitions_cpus)))
-		partcmd = partcmd_invalidate;
+	     cpumask_empty(subpartitions_cpus))) {
+		bool cycling;
+
+		/*
+		 * Suppress transient invalidation when the offline is part
+		 * of a hotplug cycling step for kernel-noise isolation.
+		 */
+		spin_lock(&dhm_cycling_lock);
+		cycling = cpumask_available(dhm_cycling_cpus) &&
+			  cpumask_intersects(cs->effective_xcpus,
+					     dhm_cycling_cpus);
+		spin_unlock(&dhm_cycling_lock);
+		if (!cycling)
+			partcmd = partcmd_invalidate;
+	}
 	/*
 	 * On the other hand, an invalid partition root may be transitioned
 	 * back to a regular one with a non-empty effective xcpus.

-- 
2.43.0


