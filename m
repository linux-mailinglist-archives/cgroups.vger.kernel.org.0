Return-Path: <cgroups+bounces-6745-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B267A4A095
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 18:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B3E176D6A
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 17:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E241F0991;
	Fri, 28 Feb 2025 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHpNJbW3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A723E1F4CAF
	for <cgroups@vger.kernel.org>; Fri, 28 Feb 2025 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764234; cv=none; b=beyH4FggnWIjH++kjvr8tloKs2iNvXXkR6rfBmYZEwYwKOylBSXSAM76lHe6pZRZdUEDGjaddjG82shfrXVeuqqVXMAlZZVaNF0GNlQiNp2a4JKnDRUclWuLWvfLn66wQ6D1Cqzvb6Z7OW0VzMu/WTCeVneTCynl0cFNS0PX7VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764234; c=relaxed/simple;
	bh=qUHfiFlLgek4YkV1FOkBZiGXYoUwYy1lYGBHqg4Qgb0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eapndTMtx8p1DcEjdvZ67xk1VTzP0GFRphTsWK3K1XmE1hKRed/FE08+h4WQixBZtzEMY1dHYGw1uRi4JZ6q8dxjGHzslZ4rrXwYUOR02MPOjIrPiyOqELvy6lpGgmt6ihPqZ+YuGpw9HJrk6AJYVu+LXAuAk35hmAa1I5FbfDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHpNJbW3; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso4081830a91.1
        for <cgroups@vger.kernel.org>; Fri, 28 Feb 2025 09:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740764232; x=1741369032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NdMrZTu+JrCHgIRKXV4NO2YpO5ndQ1lOEadMR4OgnYw=;
        b=DHpNJbW3qEoWmnFyvZ8JwJShHUmfpU+7KKgS/hYHmM8kSTqREU3OiopXxDfLiKfFkt
         RTnRyzvkYnFRChfZiCF7RMibt+brZhoO7dJZMu6VtNZ3W0JdN5T+IPFLNrk4G6VQiP3s
         qvdhBbcsmpc0AZH+Olsmb8EibOzBY5MCUP+XSf9KClPLLzZx6DlIqLsxYc9qOx7T0nk8
         G3LpHHGNgfI3hLdO2OLL6AVTjJKZC1+BaIQU07UQr0DKygaQUDAeoENjV6Fxj8ztNqQr
         EWeIf1Vw0IzX0rEJrQiW1PZphX2IcbS+CUWwVwjGe7AhIsg1i9wEhD2R0PbCVdt4Z9bV
         hMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740764232; x=1741369032;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdMrZTu+JrCHgIRKXV4NO2YpO5ndQ1lOEadMR4OgnYw=;
        b=QNGmR0/Hhwysh1c4GLc0CflAyFLD+illddFljEoz+NiiLR6rKf7lofPMvt/7oXMXsX
         H9ExmT6KrwayXCJS0JCt7q3k6Itm4PJNYlAwuuD5zVwz97H72oAsBCgTTMcv585aAJUr
         wYfgfg0lKt/M/eFeRgwnCHtCTeUfIRZahX+yAJ5D5au3ydmbpcVYZjxsPHuO9kiEE15q
         ck8SQ++zuT+xg4jibxih9STq4JtWqF+yfRB1oc/GoBFDIXEhy3YW9SqhFacnn5/j27dw
         sH9oe8GqjQeHTItgNT/ZTbLIGKT4/Lgdc/3zSHuVkUS1d2pepYXWhdS7OGyuEwN4hXRh
         sTYA==
X-Forwarded-Encrypted: i=1; AJvYcCWnfHkfUY/LmxuflntjPG682gUKoujOvlOfiBViSSFmt5onvYdoJWvCjunUPlXsI92D1TARpvKm@vger.kernel.org
X-Gm-Message-State: AOJu0YzFaGqIJn4HnaW+Npwt179seNLf/WrOP+RWxAdxIO0j5SQnR3dL
	ppkr8uTmaQHcKNtuVoVc4MM6W6sVKeyfDEscQDUHwi9SSYGCpJY7
X-Gm-Gg: ASbGncv5CHtWH7QO0Yd3ie7MGhqJzt/QGmkT8+njid8AsSS51cTYCJ7aL6+kkd17No6
	AgjQ4mIAN6QGnVAoS4lbUKV7rkyNslU3M/kL/1KbLjvynAXo/7Mufs3Yx4A8gcg/5wh7iDd0imW
	FTayT7xdd1T06Iy21PQg8tNOA5/vOj7MqllyW+Jux1OsKYQs+IXsumJpRuwCvR+uC1rUgPOQLRv
	ElR+Olk2b3+wPIpLswz5XacmqMY1/mpPx8P0U03ZkIA+ESMDSGsrZKKIFFAgdUvqkVdGn/t7DWu
	GjjGDuS8UfPdtBr3XLh+FZAEtuqPUQsSIexyQpcP/QGXXQAoj1ndZWgOsloIddjUzgu+eCPm
X-Google-Smtp-Source: AGHT+IF8c/xBz9EwykaYLYCvdYKWfCWhuBb+uHTXMxEGYLh/lB4lJDw6IVU4KDMDM+ZawePIRoEaJg==
X-Received: by 2002:a17:90b:4a47:b0:2ee:c2b5:97a0 with SMTP id 98e67ed59e1d1-2febabf41a4mr6436141a91.25.1740764231848;
        Fri, 28 Feb 2025 09:37:11 -0800 (PST)
Received: from [192.168.2.117] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea67530d0sm4077625a91.10.2025.02.28.09.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 09:37:11 -0800 (PST)
Message-ID: <084e5bc1-d2cd-4b3d-82ee-7cd83d2462e0@gmail.com>
Date: Fri, 28 Feb 2025 09:37:09 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
 mhocko@kernel.org, hannes@cmpxchg.org, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-4-inwardvessel@gmail.com>
Content-Language: en-US
In-Reply-To: <20250227215543.49928-4-inwardvessel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/25 1:55 PM, inwardvessel wrote:
> From: JP Kobryn <inwardvessel@gmail.com>
> 
> Let the existing locks be dedicated to the base stats and rename them as
> such. Also add new rstat locks for each enabled subsystem. When handling
> cgroup subsystem states, distinguish between formal subsystems (memory,
> io, etc) and the base stats subsystem state (represented by
> cgroup::self) to decide on which locks to take. This change is made to
> prevent contention between subsystems when updating/flushing stats.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>   kernel/cgroup/rstat.c | 93 +++++++++++++++++++++++++++++++++----------
>   1 file changed, 72 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 88908ef9212d..b3eaefc1fd07 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -9,8 +9,12 @@
>   
>   #include <trace/events/cgroup.h>
>   
> -static DEFINE_SPINLOCK(cgroup_rstat_lock);
> -static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
> +static DEFINE_SPINLOCK(cgroup_rstat_base_lock);
> +static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_base_cpu_lock);
> +
> +static spinlock_t cgroup_rstat_subsys_lock[CGROUP_SUBSYS_COUNT];
> +static DEFINE_PER_CPU(raw_spinlock_t,
> +		cgroup_rstat_subsys_cpu_lock[CGROUP_SUBSYS_COUNT]);
>   
>   static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>   
> @@ -20,8 +24,13 @@ static struct cgroup_rstat_cpu *cgroup_rstat_cpu(
>   	return per_cpu_ptr(css->rstat_cpu, cpu);
>   }
>   
> +static inline bool is_base_css(struct cgroup_subsys_state *css)
> +{
> +	return css->ss == NULL;
> +}
> +
>   /*
> - * Helper functions for rstat per CPU lock (cgroup_rstat_cpu_lock).
> + * Helper functions for rstat per CPU locks.
>    *
>    * This makes it easier to diagnose locking issues and contention in
>    * production environments. The parameter @fast_path determine the
> @@ -36,12 +45,12 @@ unsigned long _cgroup_rstat_cpu_lock(raw_spinlock_t *cpu_lock, int cpu,
>   	bool contended;
>   
>   	/*
> -	 * The _irqsave() is needed because cgroup_rstat_lock is
> -	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
> -	 * this lock with the _irq() suffix only disables interrupts on
> -	 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
> -	 * interrupts on both configurations. The _irqsave() ensures
> -	 * that interrupts are always disabled and later restored.
> +	 * The _irqsave() is needed because the locks used for flushing are
> +	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring this lock
> +	 * with the _irq() suffix only disables interrupts on a non-PREEMPT_RT
> +	 * kernel. The raw_spinlock_t below disables interrupts on both
> +	 * configurations. The _irqsave() ensures that interrupts are always
> +	 * disabled and later restored.
>   	 */
>   	contended = !raw_spin_trylock_irqsave(cpu_lock, flags);
>   	if (contended) {
> @@ -87,7 +96,7 @@ __bpf_kfunc void cgroup_rstat_updated(
>   		struct cgroup_subsys_state *css, int cpu)
>   {
>   	struct cgroup *cgrp = css->cgroup;
> -	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
> +	raw_spinlock_t *cpu_lock;
>   	unsigned long flags;
>   
>   	/*
> @@ -101,6 +110,12 @@ __bpf_kfunc void cgroup_rstat_updated(
>   	if (data_race(cgroup_rstat_cpu(css, cpu)->updated_next))
>   		return;
>   
> +	if (is_base_css(css))
> +		cpu_lock = per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu);
> +	else
> +		cpu_lock = per_cpu_ptr(cgroup_rstat_subsys_cpu_lock, cpu) +
> +			css->ss->id;
> +
>   	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, true);
>   
>   	/* put @css and all ancestors on the corresponding updated lists */
> @@ -208,11 +223,17 @@ static struct cgroup_subsys_state *cgroup_rstat_updated_list(
>   		struct cgroup_subsys_state *root, int cpu)
>   {
>   	struct cgroup *cgrp = root->cgroup;
> -	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
>   	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(root, cpu);
>   	struct cgroup_subsys_state *head = NULL, *parent, *child;
> +	raw_spinlock_t *cpu_lock;
>   	unsigned long flags;
>   
> +	if (is_base_css(root))
> +		cpu_lock = per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu);
> +	else
> +		cpu_lock = per_cpu_ptr(cgroup_rstat_subsys_cpu_lock, cpu) +
> +			root->ss->id;
> +
>   	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, false);
>   
>   	/* Return NULL if this subtree is not on-list */
> @@ -315,7 +336,7 @@ static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css,
>   	struct cgroup *cgrp = css->cgroup;
>   	int cpu;
>   
> -	lockdep_assert_held(&cgroup_rstat_lock);
> +	lockdep_assert_held(&lock);

I need to remove the ampersand since the variable is already a pointer.

>   
>   	for_each_possible_cpu(cpu) {
>   		struct cgroup_subsys_state *pos;
> @@ -356,12 +377,18 @@ static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css,
>   __bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
>   {
>   	struct cgroup *cgrp = css->cgroup;
> +	spinlock_t *lock;
> +
> +	if (is_base_css(css))
> +		lock = &cgroup_rstat_base_lock;
> +	else
> +		lock = &cgroup_rstat_subsys_lock[css->ss->id];
>   
>   	might_sleep();
>   
> -	__cgroup_rstat_lock(&cgroup_rstat_lock, cgrp, -1);
> -	cgroup_rstat_flush_locked(css, &cgroup_rstat_lock);
> -	__cgroup_rstat_unlock(&cgroup_rstat_lock, cgrp, -1);
> +	__cgroup_rstat_lock(lock, cgrp, -1);
> +	cgroup_rstat_flush_locked(css, lock);
> +	__cgroup_rstat_unlock(lock, cgrp, -1);
>   }
>   
>   /**
> @@ -376,10 +403,16 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
>   void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
>   {
>   	struct cgroup *cgrp = css->cgroup;
> +	spinlock_t *lock;
> +
> +	if (is_base_css(css))
> +		lock = &cgroup_rstat_base_lock;
> +	else
> +		lock = &cgroup_rstat_subsys_lock[css->ss->id];
>   
>   	might_sleep();
> -	__cgroup_rstat_lock(&cgroup_rstat_lock, cgrp, -1);
> -	cgroup_rstat_flush_locked(css, &cgroup_rstat_lock);
> +	__cgroup_rstat_lock(lock, cgrp, -1);
> +	cgroup_rstat_flush_locked(css, lock);
>   }
>   
>   /**
> @@ -389,7 +422,14 @@ void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
>   void cgroup_rstat_flush_release(struct cgroup_subsys_state *css)
>   {
>   	struct cgroup *cgrp = css->cgroup;
> -	__cgroup_rstat_unlock(&cgroup_rstat_lock, cgrp, -1);
> +	spinlock_t *lock;
> +
> +	if (is_base_css(css))
> +		lock = &cgroup_rstat_base_lock;
> +	else
> +		lock = &cgroup_rstat_subsys_lock[css->ss->id];
> +
> +	__cgroup_rstat_unlock(lock, cgrp, -1);
>   }
>   
>   int cgroup_rstat_init(struct cgroup_subsys_state *css)
> @@ -435,10 +475,21 @@ void cgroup_rstat_exit(struct cgroup_subsys_state *css)
>   
>   void __init cgroup_rstat_boot(void)
>   {
> -	int cpu;
> +	struct cgroup_subsys *ss;
> +	int cpu, ssid;
>   
> -	for_each_possible_cpu(cpu)
> -		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
> +	for_each_subsys(ss, ssid) {
> +		spin_lock_init(&cgroup_rstat_subsys_lock[ssid]);
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu));
> +
> +		for_each_subsys(ss, ssid) {
> +			raw_spin_lock_init(
> +					per_cpu_ptr(cgroup_rstat_subsys_cpu_lock, cpu) + ssid);
> +		}
> +	}
>   }
>   
>   /*


