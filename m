Return-Path: <cgroups+bounces-6743-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD365A49E4F
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 17:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B6A3AF03B
	for <lists+cgroups@lfdr.de>; Fri, 28 Feb 2025 16:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D9E18CC1D;
	Fri, 28 Feb 2025 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZUkL+Y6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC0C16F265
	for <cgroups@vger.kernel.org>; Fri, 28 Feb 2025 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758875; cv=none; b=tkmEYqHQkdng8Sfc2Be22fXeL1QJrDl4v/dy/F7rYSorhYM5vUcfUeZQz4ZpcHyNwt98EuZvmnAPE0GQRAttx0UtizNHnY9P1hQSkLi8b3iotPH3IA3+u47TajtS/7+C/90NE1SGrjwu4Ijzws9L7SFrj+n1C1jCsw1fwRzLp4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758875; c=relaxed/simple;
	bh=WRNougrcBWl2365/08/0TSgbN7RuVdWmLjanpUWuphY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTGgsK18HwAiFjwDM/LsisiWa83z/WTt3Tliixll/aOk7dqOM4VUWKNvDRIyHGUAdJmoR7TL5ROkDnUMvtmXQrZk7udOiy3ljAwdn4Vs4j9jq7kXNcNpkSD9yPYdV8jbZq3rp5JnY9X3MKoW4/FKMe1j4k6QvMB5B5DngwYl+uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZUkL+Y6; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2232b12cd36so33380325ad.0
        for <cgroups@vger.kernel.org>; Fri, 28 Feb 2025 08:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740758873; x=1741363673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RbNq4X7wcuSfUBCqJJ3Aotkg4KH2vHbVeL4DNaPJDPE=;
        b=bZUkL+Y6cyhc12L+q+Rd2kep78cbuOqFmZr+pSfc65hK6YZ4yura8k4RpcsSWZoE6N
         FcYGNZqKxS3m908IUgtYGUT6CyaXmqmw8QE6zxZwsnOPCtwxyI2HOig5+Xo7rwfveVbM
         U9Q4XDwsBShLbnuWRkHKDDB7aLhJ+6fZQn9acsTWg4L7Kef5fH38XHmHMUp7pVKSS9n5
         Cc61bhUu24+bYAzoMkjFSo1uEJJpljQAEPTjQIhaTWRGAxU75BwifKFhh3R/f81eT2jG
         ZP5lK+cNICR39pfcUrPxLAgzj26EirqXj+dMF5WX76aHwzGF6yk8kvMuPmF0YzUu7DkG
         0Q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740758873; x=1741363673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RbNq4X7wcuSfUBCqJJ3Aotkg4KH2vHbVeL4DNaPJDPE=;
        b=kAKapwgSUyf/6ZNDcTxNFC2W6sBfP7qPJw4LhGW0qIYh+mygnlX2yakvV6Lh+/Urn1
         uA6j4B3Bvz2OCTxIgf80ZnmsQ3XGg/J9Qa94x/6Xp/HBp02mxMZnyaqupD2pjeaebhLZ
         UMOXmACTP0zVmTebcytYgIHkvSMuOLioyLvF05d+HBFwACmeINk+91vdx5P+lnXJRIIy
         0XiFnUijGwu6Cr9dB3BqMLxzMtoM71xaTc3bB73ZvOPpdIfuMSaYSuFk9vagGT24sQlH
         MFlboHflqKuFH6Fl1itjhgvhndtm26npNCNM2fvqEb170dtaXBo48IJGb5B/mdRGaBPk
         LCTw==
X-Forwarded-Encrypted: i=1; AJvYcCVKkilxCQtXTPxT4uOl2PiLHxKTvigH+I1McYiGNyWeq3jf20/5HeQFyrsYeVDiLxcZpwBf6unx@vger.kernel.org
X-Gm-Message-State: AOJu0YzjjCde5qPJk9JTJJbkPPZ7SApFRoQd4EYT8r4Cr+kO5n1sk6VJ
	XRuVfj6HTOb32RH4wO5UUV6wbVamXq7n3MIc/gjcDGiT0NJq04yL
X-Gm-Gg: ASbGncvmLo8diYiXBx0lc8/H9q5Gv+EHFTcS08vMM2DgjcpP50HL57gJ74izI5e4g9J
	fwRDih/+mXfwusl1rTGISvzd0Z1H+86A85ijLkbEZaE4qadvsEZBBzaCZA6p0eKLs3f3YCZdRkk
	h/vXmUkGWOUruOqbxzJv3qYxlc2DFZrgqdfhd7T79V6lpqemPz4SGopRkMlf9XfKoQoZwy3iZRJ
	vQFd3eibjZAuN3TFVrNV8zP/hIBgDbxcZ14NusHB+kqJBjUbLFvie4/F+sc4d2VRGCKwutPUHr7
	YkEb1hhGg95HFElS1NoGY3/CUVPYjaPqpQY709AwypgQSRBCJd+BEXCnYCb8X+iFrQfjwNJp
X-Google-Smtp-Source: AGHT+IEc/LpjyJNyc94QD2v1vBhS/25v1h4rkPWRkrce2r8rUx8g1O7eBeS9N2xW3uDvn0nqBf1Epw==
X-Received: by 2002:a05:6a21:1796:b0:1ee:89ba:d9e6 with SMTP id adf61e73a8af0-1f2f4c94844mr7680017637.7.1740758873270;
        Fri, 28 Feb 2025 08:07:53 -0800 (PST)
Received: from [192.168.2.117] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe48873sm3906691b3a.49.2025.02.28.08.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 08:07:52 -0800 (PST)
Message-ID: <066a7505-a4fe-4b76-b7a6-ae97f786dac7@gmail.com>
Date: Fri, 28 Feb 2025 08:07:50 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: tj@kernel.org, yosryahmed@google.com, mhocko@kernel.org,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-4-inwardvessel@gmail.com>
 <wr4gupwwb3dinb6wanadgbitpowa4ffvmsei4r7riq6ialpp3k@kebmsx62a4op>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <wr4gupwwb3dinb6wanadgbitpowa4ffvmsei4r7riq6ialpp3k@kebmsx62a4op>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/25 2:52 PM, Shakeel Butt wrote:
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
> 
> Couple of nits below otherwise:
> 
> Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
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
> 
> The name of these locks are too long and you had to go multi-line.
> Please just reduce the size of the names. These are local to this file,
> so maybe you can drop cgroup_rstat_ from them or keep the rstat.

Agreed. Will do in next rev.

> 
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
> 
> Use the array index here like cgroup_rstat_subsys_cpu_lock[css->ss->id].

Good call. I see the arithmetic may be more appropriate in cases where
the per-cpu array/buffer is dynamic. I'll use the index notation in v3.

> 
>> +
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
> 
> Same here.
> 
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
> 
> Same here.
> 
>> +		}
>> +	}
>>   }
>>   
>>   /*
>> -- 
>> 2.43.5
>>


