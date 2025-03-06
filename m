Return-Path: <cgroups+bounces-6871-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C36A55910
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 22:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0DF17479A
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 21:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2568A20764E;
	Thu,  6 Mar 2025 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0sJp75Z"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E1317B50B
	for <cgroups@vger.kernel.org>; Thu,  6 Mar 2025 21:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297670; cv=none; b=DGINijffm06xtKPGMmjQ4A0B175eB5VNBXToGrWoAKdcaQ4vocmCfN6NRryEhJkm3bwpUVEmXW/mk3w1MXWP/eAGdcIDO12NZMe0+F3BKkh1R7cFBAjhSQMWVgBivjxOYH2erp+CTh2Ken+ef7z9j0MxGkHZFwF/4dL7eDVDKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297670; c=relaxed/simple;
	bh=cH9Hq7WQ5/zsdr0tUWmk3KoiT3Q/pLhW6KUfARagBdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qa8TeylKWfg4DnEARCfEq6VkJJ/Vsnr1J2rMVk4HreJx4uDVDFB8kyQ2Hkx6bAyin2qSZ/rUaz6y5UeJ+QLzzKwD2N/PQif106OH+qSlXW+B9UuEX0H7RaHPLhdqfhcXty/Z5SYHDp9Mdb8gDhmRoACNTwRusRYPg9MkVuSen3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0sJp75Z; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2235189adaeso19986945ad.0
        for <cgroups@vger.kernel.org>; Thu, 06 Mar 2025 13:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741297668; x=1741902468; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t9a0dAVL/AZWOUQR/lGFl+t00mrO/OYf4dYWFlvsLAw=;
        b=Q0sJp75Z+slO/DkO+04Lw1UkL1FXcXnBY5iqeDCmOHk1n1R9aeeVrC4OD7La2Kd9rc
         c4tUuYdiD2gKzaaldCfuh1eUy370l9LaWjlmf7pvXr2nq7MWGk9UYOIfHEoeTJjKzq2H
         XSi0Oq8Qr0+kHZM4eI97Nm2VymKQo+13dOak9rvrJ3QVPQkvZLa/zfiDSZmySMYqqASn
         v9YypYwJ5In3m4iHM/wvvhM40HEAQQpdHtJ/62ddjbE2jNQe1ZgTJZpOWDcF5qB6Y9rJ
         VSZHCj2f7g2I8DEAljmIKkhsIfCu0MxFD9ccOBF6t7bfk/IeahOsHyZlEuK7//Jp4psy
         go9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741297668; x=1741902468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t9a0dAVL/AZWOUQR/lGFl+t00mrO/OYf4dYWFlvsLAw=;
        b=rcyI7w57qKk4zR1Oug5CHH67Y+yFgH1a6hTRPGYKaXnauJ6lBabswcJkVZDE0aXE3q
         RpG0ncfpJf/HD0MMsktKIX7HR5QQ43+SFRz7pdQ3iJKWPrrAVNaX7eBLYM6nJIASk0M4
         oUBF4b79GdRnZsJZzu2prnZJgqrFxPoRXf/Qzoa5PHK+xvPBn4NbB+JNa1IO7qoNX8hU
         TAhQKGdgOwAccGTK2D2NcCEk+VePy38Zq/u534jKAxK6pOU2UFbn4ek3j0LynOK8B2fQ
         TFeWohuiLl3OpiUqVIQSNNlmGTq5II7s7a1xPsTKM8mSaKEoohcnx1FUMoolJFuzP2z1
         t/MQ==
X-Forwarded-Encrypted: i=1; AJvYcCViLK20uTTkHQ3pd25mZmmzbnxiVEfjDJUHasGHQ0//mQ/zm2ObVIep88h5jk3bNIzDHqr3cFEu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4WquJWaLJ9qdmqzr5vVzdHQQQ0HSVEqYX0THBIshsCCqVtqDp
	U/MK7nb+wyx4KCxlSJJFSIjJ0mzete/oQDExhDmBllbxE7zS2oCGBV/3OQ==
X-Gm-Gg: ASbGnct//3bqLjuUpD/SEQ+0VGbbVnPNu+0fkUefMhr+7BsqPVMLHe/A0Ttm53ir+lc
	frMIoB3GMSily1VzKvT5SnXcoEttBcm8ll6ALTsYMw2hJMREaRynGJHDDx9zIwkFCtwh6mRxaBv
	IrMZ1aI+mqXZ/IWh+rZsdq3M9S3wnEuxHyD022AujwVlOssEdHFlpUTO3kOj+ZJaABEUlYIYBVS
	6pZQYOX5lQHPbogXNG1nC1JsaUOCCWQEvaS0cv7Kk3P+qufJ6ek856E2WPy39q1sfUBYq9QeqGB
	K2WxDgjH8Z4Gtuky5yfXSi1dEg3HRZImegA8FMRRS/d6N9MzAW6Ty2idrRH9StIbgWX2rS96Kaj
	/
X-Google-Smtp-Source: AGHT+IGVGsKex96vDISYzZdtD1CF7FPmnf5XXQSJH1a6blsHvrz5J51CDUj3DDOuLRqv9alKaayf2A==
X-Received: by 2002:a17:903:11d0:b0:21f:53a5:19e0 with SMTP id d9443c01a7336-22409404e15mr79186615ad.12.1741297668292;
        Thu, 06 Mar 2025 13:47:48 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:d431:c86b:892f:8e30? ([2620:10d:c090:500::6:d8b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddcaesm17349635ad.28.2025.03.06.13.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 13:47:47 -0800 (PST)
Message-ID: <d572621a-731b-4fa8-9781-a904c3ef01e7@gmail.com>
Date: Thu, 6 Mar 2025 13:47:46 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: tj@kernel.org, shakeel.butt@linux.dev, mhocko@kernel.org,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-4-inwardvessel@gmail.com> <Z8IMenLfg4zXd78S@google.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <Z8IMenLfg4zXd78S@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 11:20 AM, Yosry Ahmed wrote:
> On Thu, Feb 27, 2025 at 01:55:42PM -0800, inwardvessel wrote:
>> From: JP Kobryn <inwardvessel@gmail.com>
>>
>> Let the existing locks be dedicated to the base stats and rename them as
>> such. Also add new rstat locks for each enabled subsystem. When handling
>> cgroup subsystem states, distinguish between formal subsystems (memory,
>> io, etc) and the base stats subsystem state (represented by
>> cgroup::self) to decide on which locks to take. This change is made to
>> prevent contention between subsystems when updating/flushing stats.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>> ---
>>   kernel/cgroup/rstat.c | 93 +++++++++++++++++++++++++++++++++----------
>>   1 file changed, 72 insertions(+), 21 deletions(-)
>>
>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>> index 88908ef9212d..b3eaefc1fd07 100644
>> --- a/kernel/cgroup/rstat.c
>> +++ b/kernel/cgroup/rstat.c
>> @@ -9,8 +9,12 @@
>>   
>>   #include <trace/events/cgroup.h>
>>   
>> -static DEFINE_SPINLOCK(cgroup_rstat_lock);
>> -static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
>> +static DEFINE_SPINLOCK(cgroup_rstat_base_lock);
>> +static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_base_cpu_lock);
>> +
>> +static spinlock_t cgroup_rstat_subsys_lock[CGROUP_SUBSYS_COUNT];
>> +static DEFINE_PER_CPU(raw_spinlock_t,
>> +		cgroup_rstat_subsys_cpu_lock[CGROUP_SUBSYS_COUNT]);
>>   
>>   static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>>   
>> @@ -20,8 +24,13 @@ static struct cgroup_rstat_cpu *cgroup_rstat_cpu(
>>   	return per_cpu_ptr(css->rstat_cpu, cpu);
>>   }
>>   
>> +static inline bool is_base_css(struct cgroup_subsys_state *css)
>> +{
>> +	return css->ss == NULL;
>> +}
>> +
>>   /*
>> - * Helper functions for rstat per CPU lock (cgroup_rstat_cpu_lock).
>> + * Helper functions for rstat per CPU locks.
>>    *
>>    * This makes it easier to diagnose locking issues and contention in
>>    * production environments. The parameter @fast_path determine the
>> @@ -36,12 +45,12 @@ unsigned long _cgroup_rstat_cpu_lock(raw_spinlock_t *cpu_lock, int cpu,
>>   	bool contended;
>>   
>>   	/*
>> -	 * The _irqsave() is needed because cgroup_rstat_lock is
>> -	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
>> -	 * this lock with the _irq() suffix only disables interrupts on
>> -	 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
>> -	 * interrupts on both configurations. The _irqsave() ensures
>> -	 * that interrupts are always disabled and later restored.
>> +	 * The _irqsave() is needed because the locks used for flushing are
>> +	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring this lock
>> +	 * with the _irq() suffix only disables interrupts on a non-PREEMPT_RT
>> +	 * kernel. The raw_spinlock_t below disables interrupts on both
>> +	 * configurations. The _irqsave() ensures that interrupts are always
>> +	 * disabled and later restored.
>>   	 */
>>   	contended = !raw_spin_trylock_irqsave(cpu_lock, flags);
>>   	if (contended) {
>> @@ -87,7 +96,7 @@ __bpf_kfunc void cgroup_rstat_updated(
>>   		struct cgroup_subsys_state *css, int cpu)
>>   {
>>   	struct cgroup *cgrp = css->cgroup;
>> -	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
>> +	raw_spinlock_t *cpu_lock;
>>   	unsigned long flags;
>>   
>>   	/*
>> @@ -101,6 +110,12 @@ __bpf_kfunc void cgroup_rstat_updated(
>>   	if (data_race(cgroup_rstat_cpu(css, cpu)->updated_next))
>>   		return;
>>   
>> +	if (is_base_css(css))
>> +		cpu_lock = per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu);
>> +	else
>> +		cpu_lock = per_cpu_ptr(cgroup_rstat_subsys_cpu_lock, cpu) +
>> +			css->ss->id;
>> +
> 
> Maybe wrap this in a macro or function since it's used more than once.
> 
>>   	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, true);
>>   
>>   	/* put @css and all ancestors on the corresponding updated lists */
>> @@ -208,11 +223,17 @@ static struct cgroup_subsys_state *cgroup_rstat_updated_list(
>>   		struct cgroup_subsys_state *root, int cpu)
>>   {
>>   	struct cgroup *cgrp = root->cgroup;
>> -	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
>>   	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(root, cpu);
>>   	struct cgroup_subsys_state *head = NULL, *parent, *child;
>> +	raw_spinlock_t *cpu_lock;
>>   	unsigned long flags;
>>   
>> +	if (is_base_css(root))
>> +		cpu_lock = per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu);
>> +	else
>> +		cpu_lock = per_cpu_ptr(cgroup_rstat_subsys_cpu_lock, cpu) +
>> +			root->ss->id;
>> +
>>   	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, false);
>>   
>>   	/* Return NULL if this subtree is not on-list */
>> @@ -315,7 +336,7 @@ static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css,
>>   	struct cgroup *cgrp = css->cgroup;
>>   	int cpu;
>>   
>> -	lockdep_assert_held(&cgroup_rstat_lock);
>> +	lockdep_assert_held(&lock);
>>   
>>   	for_each_possible_cpu(cpu) {
>>   		struct cgroup_subsys_state *pos;
>> @@ -356,12 +377,18 @@ static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css,
>>   __bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
>>   {
>>   	struct cgroup *cgrp = css->cgroup;
>> +	spinlock_t *lock;
>> +
>> +	if (is_base_css(css))
>> +		lock = &cgroup_rstat_base_lock;
>> +	else
>> +		lock = &cgroup_rstat_subsys_lock[css->ss->id];
> 
> Same here. Also, instead of passing locks around, can we just pass
> the css to __cgroup_rstat_lock/unlock() and have them find the correct
> lock and use it directly?

I like this and will take that approach in v3. It will allow the lock
selection code you previously commented on to exist in just one place.

> 
>>   
>>   	might_sleep();
>>   
>> -	__cgroup_rstat_lock(&cgroup_rstat_lock, cgrp, -1);
>> -	cgroup_rstat_flush_locked(css, &cgroup_rstat_lock);
>> -	__cgroup_rstat_unlock(&cgroup_rstat_lock, cgrp, -1);
>> +	__cgroup_rstat_lock(lock, cgrp, -1);
>> +	cgroup_rstat_flush_locked(css, lock);
>> +	__cgroup_rstat_unlock(lock, cgrp, -1);
>>   }
>>   
>>   /**
>> @@ -376,10 +403,16 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
>>   void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
>>   {
>>   	struct cgroup *cgrp = css->cgroup;
>> +	spinlock_t *lock;
>> +
>> +	if (is_base_css(css))
>> +		lock = &cgroup_rstat_base_lock;
>> +	else
>> +		lock = &cgroup_rstat_subsys_lock[css->ss->id];
>>   
>>   	might_sleep();
>> -	__cgroup_rstat_lock(&cgroup_rstat_lock, cgrp, -1);
>> -	cgroup_rstat_flush_locked(css, &cgroup_rstat_lock);
>> +	__cgroup_rstat_lock(lock, cgrp, -1);
>> +	cgroup_rstat_flush_locked(css, lock);
>>   }
>>   
>>   /**
>> @@ -389,7 +422,14 @@ void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
>>   void cgroup_rstat_flush_release(struct cgroup_subsys_state *css)
>>   {
>>   	struct cgroup *cgrp = css->cgroup;
>> -	__cgroup_rstat_unlock(&cgroup_rstat_lock, cgrp, -1);
>> +	spinlock_t *lock;
>> +
>> +	if (is_base_css(css))
>> +		lock = &cgroup_rstat_base_lock;
>> +	else
>> +		lock = &cgroup_rstat_subsys_lock[css->ss->id];
>> +
>> +	__cgroup_rstat_unlock(lock, cgrp, -1);
>>   }
>>   
>>   int cgroup_rstat_init(struct cgroup_subsys_state *css)
>> @@ -435,10 +475,21 @@ void cgroup_rstat_exit(struct cgroup_subsys_state *css)
>>   
>>   void __init cgroup_rstat_boot(void)
>>   {
>> -	int cpu;
>> +	struct cgroup_subsys *ss;
>> +	int cpu, ssid;
>>   
>> -	for_each_possible_cpu(cpu)
>> -		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
>> +	for_each_subsys(ss, ssid) {
>> +		spin_lock_init(&cgroup_rstat_subsys_lock[ssid]);
>> +	}
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu));
>> +
>> +		for_each_subsys(ss, ssid) {
>> +			raw_spin_lock_init(
>> +					per_cpu_ptr(cgroup_rstat_subsys_cpu_lock, cpu) + ssid);
>> +		}
>> +	}
>>   }
>>   
>>   /*
>> -- 
>> 2.43.5
>>
>>


