Return-Path: <cgroups+bounces-10169-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B0AB597EC
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 15:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8A41B2797F
	for <lists+cgroups@lfdr.de>; Tue, 16 Sep 2025 13:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BA3311C1B;
	Tue, 16 Sep 2025 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxqCfa0r"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57601FBEB9;
	Tue, 16 Sep 2025 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030081; cv=none; b=gYBcDQ54B2QtxXPK2nIQ3hiNbA/bO/r8ZmVzp5HMTBfTfWRu6uBIHlDx00Tw1Sk7m2smxL/K8OdXREWECTQhgMXekYLhd6H6g1BEh8Cv0LR6qNGg4lNyzRNeUCQzFO7cxMXxLRSQTcls56YeETVkk6IduUou4jik6Bckcettrh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030081; c=relaxed/simple;
	bh=aiyMzqzBWGGU8cyeVwz3oJkAAY95LgOEzy5eDZj2Buk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMj02cx38w36ivNFVz8oW0KljB4feBp1JtSMgM5H7MlcJ7SgSyonlALo0q01cLBRfMy+5Pz6Yb/p7l+nbz+Taw8bGSqA8pmc5TY6K2uwK08Y7nDGYpD+JsZAD0qCE054sb59gqh2hJ/gR7VgxwIxwRindid3W5sgXm6d7i3E+6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxqCfa0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30D2C4CEEB;
	Tue, 16 Sep 2025 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758030079;
	bh=aiyMzqzBWGGU8cyeVwz3oJkAAY95LgOEzy5eDZj2Buk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxqCfa0r1lPsZkdFXdXts6x/iqTRy8eixiE+k2tCa3dPTHo8JfUO66FQTYzB7gmRw
	 AvxpqSXe5G21dPcn7ujemAev2r79F8c/9cWuFQNgi+ULzFU+FeWP/aNYuiiOjzqRYV
	 xjBOZQzDLYUJ4470xyIZn6dOk+4qHvVnp/X6EBJsJMIreJ/mpWqEKJx1711NjE+3oD
	 1m5dmtHzEXB8hkA6mKC1Px4REbM82wRBtWQ0uJxBoKDO2sQ4WW+A5SKo4bzSBFrg+G
	 w4RGXUgB/vjSr/Wn+wJGhzN804SpzN9cz/5vIjFygCtcDTs2duRSEYiUhTbrpKLbB0
	 jm+7LkNeOxLBw==
Date: Tue, 16 Sep 2025 15:41:16 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, "John B. Wyatt IV" <jwyatt@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH v12 9/9] timers: Exclude isolated cpus from timer
 migration
Message-ID: <aMlo_K8koZ6HH2kh@localhost.localdomain>
References: <20250915145920.140180-11-gmonaco@redhat.com>
 <20250915145920.140180-20-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250915145920.140180-20-gmonaco@redhat.com>

Le Mon, Sep 15, 2025 at 04:59:30PM +0200, Gabriele Monaco a écrit :
> Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
> Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>

Two people, one tester? :-)

> +/**
> + * tmigr_isolated_exclude_cpumask - Exclude given CPUs from hierarchy
> + * @exclude_cpumask: the cpumask to be excluded from timer migration hierarchy
> + *
> + * This function can be called from cpuset code to provide the new set of
> + * isolated CPUs that should be excluded from the hierarchy.
> + * Online CPUs not present in exclude_cpumask but already excluded are brought
> + * back to the hierarchy.
> + * Functions to isolate/unisolate need to be called locally and can sleep.
> + */
> +int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
> +{
> +	struct work_struct __percpu *works __free(free_percpu) =
> +		alloc_percpu(struct work_struct);
> +	cpumask_var_t cpumask_unisol __free(free_cpumask_var) = CPUMASK_NULL;
> +	cpumask_var_t cpumask_isol __free(free_cpumask_var) = CPUMASK_NULL;
> +	int cpu;
> +
> +	lockdep_assert_cpus_held();
> +
> +	if (!alloc_cpumask_var(&cpumask_isol, GFP_KERNEL))
> +		return -ENOMEM;
> +	if (!alloc_cpumask_var(&cpumask_unisol, GFP_KERNEL))
> +		return -ENOMEM;
> +	if (!works)
> +		return -ENOMEM;
> +
> +	cpumask_andnot(cpumask_unisol, cpu_online_mask, exclude_cpumask);
> +	cpumask_andnot(cpumask_unisol, cpumask_unisol, tmigr_available_cpumask);
> +	/* Set up the mask earlier to avoid races with the migrator CPU */
> +	cpumask_or(tmigr_available_cpumask, tmigr_available_cpumask, cpumask_unisol);
> +	for_each_cpu(cpu, cpumask_unisol) {
> +		struct work_struct *work = per_cpu_ptr(works, cpu);
> +
> +		INIT_WORK(work, tmigr_cpu_unisolate);
> +		schedule_work_on(cpu, work);
> +	}
> +
> +	cpumask_and(cpumask_isol, exclude_cpumask, tmigr_available_cpumask);
> +	cpumask_and(cpumask_isol, cpumask_isol, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
> +	/*
> +	 * Handle this here and not in the cpuset code because exclude_cpumask
> +	 * might include also the tick CPU if included in isolcpus.
> +	 */
> +	for_each_cpu(cpu, cpumask_isol) {
> +		if (!tick_nohz_cpu_hotpluggable(cpu)) {
> +			cpumask_clear_cpu(cpu, cpumask_isol);
> +			break;
> +		}
> +	}
> +	/* Set up the mask earlier to avoid races with the migrator CPU */
> +	cpumask_andnot(tmigr_available_cpumask, tmigr_available_cpumask, cpumask_isol);
> +	for_each_cpu(cpu, cpumask_isol) {
> +		struct work_struct *work = per_cpu_ptr(works, cpu);
> +
> +		INIT_WORK(work, tmigr_cpu_isolate);
> +		schedule_work_on(cpu, work);
> +	}

This is racy at various levels:

* The tmigr_available_cpumask clear can race with the cpumask_set_cpu() in
  tmigr_cpu_unisolate(), risking overwrites when CPUs are on the same bitmap
  chunk (bitmap operations aren't atomic).

* tmigr_cpu_isolate() and tmigr_cpu_unisolate() can now run concurrently and
  then cpumask_set_cpu() can race with cpumask_clear_cpu() on
  tmigr_available_cpumask, risking overwrites, though the real problem is
  on the precedent point.
  
* tmigr_cpu_isolate() can race with tmigr_cpu_isolate() on other CPUs so
  the calls to cpumask_clear_cpu() can race. That's fine because
  tmigr_available_cpumask is already set to those CPUs but that still
  leaves un uncomfortable taste. That would leave an excuse for KSCAN to warn
  for example.

* Similar with tmigr_cpu_unisolate() racing together.

So, something like that should be added?

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 08e29fc01479..6615e56c8b0d 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1473,7 +1473,6 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
 	int migrator;
 	u64 firstexp;
 
-	cpumask_clear_cpu(cpu, tmigr_available_cpumask);
 	scoped_guard(raw_spinlock_irq, &tmc->lock) {
 		if (!tmc->available)
 			return 0;
@@ -1489,11 +1488,11 @@ static int tmigr_clear_cpu_available(unsigned int cpu)
 	}
 
 	if (firstexp != KTIME_MAX) {
-		migrator = cpumask_any(tmigr_available_cpumask);
+		migrator = cpumask_any_but(tmigr_available_cpumask, cpu);
 		work_on_cpu(migrator, tmigr_trigger_active, NULL);
 	}
 
-	return 0;
+	return 1;
 }
 
 static int tmigr_set_cpu_available(unsigned int cpu)
@@ -1506,7 +1505,7 @@ static int tmigr_set_cpu_available(unsigned int cpu)
 
 	if (tmigr_is_isolated(cpu))
 		return 0;
-	cpumask_set_cpu(cpu, tmigr_available_cpumask);
+
 	scoped_guard(raw_spinlock_irq, &tmc->lock) {
 		if (tmc->available)
 			return 0;
@@ -1516,7 +1515,19 @@ static int tmigr_set_cpu_available(unsigned int cpu)
 			__tmigr_cpu_activate(tmc);
 		tmc->available = true;
 	}
-	return 0;
+	return 1;
+}
+
+static int tmigr_online_cpu(unsigned int cpu)
+{
+	if (tmigr_set_cpu_available(cpu) > 0)
+		cpumask_set_cpu(cpu, tmigr_available_cpumask);
+}
+
+static int tmigr_offline_cpu(unsigned int cpu)
+{
+	if (tmigr_clear_cpu_available(cpu) > 0)
+		cpumask_clear_cpu(cpu, tmigr_available_cpumask);
 }
 
 static void tmigr_cpu_isolate(struct work_struct *ignored)
@@ -1601,8 +1612,7 @@ int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
 static int __init tmigr_late_init(void)
 {
 	return cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
-				 tmigr_set_cpu_available,
-				 tmigr_clear_cpu_available);
+				 tmigr_online_cpu, tmigr_offline_cpu);
 }
 
 static void tmigr_init_group(struct tmigr_group *group, unsigned int lvl,

-- 
Frederic Weisbecker
SUSE Labs

