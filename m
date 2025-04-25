Return-Path: <cgroups+bounces-7814-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DE1A9BBB3
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 02:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC50F9A3EAF
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 00:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446DBA29;
	Fri, 25 Apr 2025 00:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tw7C3dor"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C68314A8B
	for <cgroups@vger.kernel.org>; Fri, 25 Apr 2025 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745540288; cv=none; b=buj6CDboTOY45iK8Qw8Nz6xh6duepKULnkOhAnOETZLpV+e0TnG3PNPN2k2sHGkbyFP7R6L9dSzJmfM2AVHv+0v7KceWCNhhxxUc8nwM+ofOQ7RUgaz9j2WHZmmmsUN7+1kab2kA2uoOy26v2HJ9HhkYPC4hgT22sUJTBA8SoCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745540288; c=relaxed/simple;
	bh=z1+NZGp4HAHzzfGaXnGkJxONrWFWMtBcC1lFR5dWNow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIwRg5SWrU2geA4qY9LsMUL0UC5q7G7dIdHH/1yzNpSz4Eo+oNmtJuxtkgPEm2TxuFty8N9eHH1y+fBj0eWsT1etjwVKQ3INDzKIAZBctx48/fzbND+itHVagv3ESkTlft4iBWZnsrwEtA0jHSUQuFR700pLk9hP4yPwD8KN+1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tw7C3dor; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2264aefc45dso26805865ad.0
        for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 17:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745540284; x=1746145084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HRDr9PeSGcFtwz0oZ2PUUdR/OCyAfw+nh1U48kUyY2E=;
        b=Tw7C3dorVqyKQi0QWd+I5FW0YeUqVW32OvFgvb5y/p9SOopNOyu+aLnHnWtyVBHPW1
         gq+ycldECqPZCjqmqXVQKbAJqeycZbxtNnBiLgaPiuErZkCRWsP18JMdIw/mTimCDFL5
         htn3AF8wi4joEwpS/zR3JBbo9VCZ9qVngJrYpZp/zlugVkmszVaCT7ywo3az1lGH+A+R
         ERIUSbhYkIrESLvpgmfOyMX+RGzLKdYA8Cco900ljC042x6Fm8gCGogvey4cVP4ENMaW
         5fUf8pVmglZVzk0jxIBU0XoxWooCBOkG+JXVqnmw1gugc4LqOcnzDWc56TmZ+/WKbYWI
         VyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745540284; x=1746145084;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRDr9PeSGcFtwz0oZ2PUUdR/OCyAfw+nh1U48kUyY2E=;
        b=e5UiXhADt4hunqnMXat7xcq8FupMltb4tBQBeeU25goCHAX9FV8J6u6nZINaHqeSjz
         pHTLSODJlMEIjE7xdX+76wAI+TnQPbLdycACnw+qPA86bu4/PVTRQ4cXPoNYPRyg6aU7
         Ftcn/nkMzwFsGhumcspcg+lRVaQzXwwn5e6sibx9UQAopVJ0RGznzWixDlgDefpuPdcj
         axdWUFtEho6MZIXWq9WpwBvOzshzEsxGaKIBAwHq0CjoBnHF8MUTIWq7YEDmR1nZcDb4
         6O6Ufhtzje8XSiZWJOZvUO5MGHlGbuTzq6BbbzeTRAf14NynYEgfwE+6x/BzGdKWArVk
         ipCg==
X-Forwarded-Encrypted: i=1; AJvYcCVmNtA1eS+ncFmVobhwr/Vl5BQMHefBtnWtFr9tsazwfJv4Qw1DRiDTzlNYwVYuFhSYK36Mkmhm@vger.kernel.org
X-Gm-Message-State: AOJu0YwAjt9q2fv3NA/G2TmQlYHkkk/dNshymOQavOXGVzE+ANVUsat1
	LRHQNiQowb5yqp6R4xg1YJ0d89f9i2Aqo2Jq+6JruuM0KRCJXJ9D
X-Gm-Gg: ASbGncvCbpofEy96dxC627LsAvG/kmXVJf6owwUEBs173G/y20VNFgnXXxMI4lT/bSz
	5UcyLNT+rgOxo/tDBwI1AZuFxMQRHDMCI6fYM7zoHk5ESfUP1oZ+6IvbZTRoFRWNCBObV9oAB3+
	XwMCczqpDKlpsnAD0qAzSaMwOx2bHeE7YKpb1Qksba90sfadtv3cgtAfLX7s0iX3FaG457ZCz+f
	WoDOUvFmSd9sMKM2LklunNecEtmMx861g3N6HLllhwEqCTglmxXkbqJRGFe5BRMs25MYKP6e855
	PzlNVrMjvMuql/kSgvFG9yeasDj0rpYnMd925zM+54jMe2jEyUpkOtvY+ae0drGsHc8XiKsx
X-Google-Smtp-Source: AGHT+IHRKmQAD3A5aGZ76IlaEDszcu2IoUYRj8gVhbMRFBOPSHJkXzVXq/4Zg5EmL+uBpbtYJtR22g==
X-Received: by 2002:a17:902:ef50:b0:22d:b2c9:7fd7 with SMTP id d9443c01a7336-22dbf5ef7fcmr4819875ad.21.1745540284473;
        Thu, 24 Apr 2025 17:18:04 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:fd6c:bb6:36da:5926? ([2620:10d:c090:500::5:5d68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5216998sm19907915ad.229.2025.04.24.17.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 17:18:03 -0700 (PDT)
Message-ID: <9d261429-a1bc-4ab0-b68b-d18ecdfd0766@gmail.com>
Date: Thu, 24 Apr 2025 17:18:02 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] cgroup: use subsystem-specific rstat locks to
 avoid contention
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
 mkoutny@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-6-inwardvessel@gmail.com>
 <6807a132.df0a0220.28dc80.a1f0SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <6807a132.df0a0220.28dc80.a1f0SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/25 7:01 AM, Yosry Ahmed wrote:
> On Thu, Apr 03, 2025 at 06:10:50PM -0700, JP Kobryn wrote:
>> It is possible to eliminate contention between subsystems when
>> updating/flushing stats by using subsystem-specific locks. Let the existing
>> rstat locks be dedicated to the cgroup base stats and rename them to
>> reflect that. Add similar locks to the cgroup_subsys struct for use with
>> individual subsystems.
>>
>> Lock initialization is done in the new function ss_rstat_init(ss) which
>> replaces cgroup_rstat_boot(void). If NULL is passed to this function, the
>> global base stat locks will be initialized. Otherwise, the subsystem locks
>> will be initialized.
>>
>> Change the existing lock helper functions to accept a reference to a css.
>> Then within these functions, conditionally select the appropriate locks
>> based on the subsystem affiliation of the given css. Add helper functions
>> for this selection routine to avoid repeated code.
>>
>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>> ---
>>   block/blk-cgroup.c              |   2 +-
>>   include/linux/cgroup-defs.h     |  16 +++--
>>   include/trace/events/cgroup.h   |  12 +++-
>>   kernel/cgroup/cgroup-internal.h |   2 +-
>>   kernel/cgroup/cgroup.c          |  10 +++-
>>   kernel/cgroup/rstat.c           | 101 +++++++++++++++++++++++---------
>>   6 files changed, 103 insertions(+), 40 deletions(-)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index 0560ea402856..62d0bf1e1a04 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -1074,7 +1074,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
>>   	/*
>>   	 * For covering concurrent parent blkg update from blkg_release().
>>   	 *
>> -	 * When flushing from cgroup, cgroup_rstat_lock is always held, so
>> +	 * When flushing from cgroup, the subsystem lock is always held, so
>>   	 * this lock won't cause contention most of time.
>>   	 */
>>   	raw_spin_lock_irqsave(&blkg_stat_lock, flags);
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index c58c21c2110a..bb5a355524d6 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -223,7 +223,10 @@ struct cgroup_subsys_state {
>>   	/*
>>   	 * A singly-linked list of css structures to be rstat flushed.
>>   	 * This is a scratch field to be used exclusively by
>> -	 * css_rstat_flush_locked() and protected by cgroup_rstat_lock.
>> +	 * css_rstat_flush_locked().
>> +	 *
>> +	 * Protected by rstat_base_lock when css is cgroup::self.
>> +	 * Protected by css->ss->rstat_ss_lock otherwise.
>>   	 */
>>   	struct cgroup_subsys_state *rstat_flush_next;
>>   };
>> @@ -359,11 +362,11 @@ struct css_rstat_cpu {
>>   	 * are linked on the parent's ->updated_children through
>>   	 * ->updated_next.
>>   	 *
>> -	 * In addition to being more compact, singly-linked list pointing
>> -	 * to the cgroup makes it unnecessary for each per-cpu struct to
>> -	 * point back to the associated cgroup.
>> +	 * In addition to being more compact, singly-linked list pointing to
>> +	 * the css makes it unnecessary for each per-cpu struct to point back
>> +	 * to the associated css.
>>   	 *
>> -	 * Protected by per-cpu cgroup_rstat_cpu_lock.
>> +	 * Protected by per-cpu css->ss->rstat_ss_cpu_lock.
>>   	 */
>>   	struct cgroup_subsys_state *updated_children;	/* terminated by self cgroup */
> 
> This rename belongs in the previous patch, also the comment about
> updated_children should probably say "self css" now.

Thanks, will adjust in next rev.

> 
>>   	struct cgroup_subsys_state *updated_next;	/* NULL iff not on the list */
>> @@ -793,6 +796,9 @@ struct cgroup_subsys {
>>   	 * specifies the mask of subsystems that this one depends on.
>>   	 */
>>   	unsigned int depends_on;
>> +
>> +	spinlock_t rstat_ss_lock;
>> +	raw_spinlock_t __percpu *rstat_ss_cpu_lock;
> 
> Can we use local_lock_t here instead? I guess it would be annoying
> because we won't be able to have common code for locking/unlocking. It's
> annoying because the local lock is a spinlock under the hood for non-RT
> kernels anyway..
> 
>>   };
>>   
>>   extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
> [..]
>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>> index 37d9e5012b2d..bcc253aec774 100644
>> --- a/kernel/cgroup/rstat.c
>> +++ b/kernel/cgroup/rstat.c
>> @@ -9,8 +9,8 @@
>>   
>>   #include <trace/events/cgroup.h>
>>   
>> -static DEFINE_SPINLOCK(cgroup_rstat_lock);
>> -static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
>> +static DEFINE_SPINLOCK(rstat_base_lock);
>> +static DEFINE_PER_CPU(raw_spinlock_t, rstat_base_cpu_lock);
> 
> Can we do something like this (not sure the macro usage is correct):
> 
> static DEFINE_PER_CPU(raw_spinlock_t, rstat_base_cpu_lock) = __SPIN_LOCK_UNLOCKED(rstat_base_cpu_lock);
> 
> This should initialize the per-CPU spinlocks the same way
> DEFINE_SPINLOCK does IIUC.

Yes, this could work. There was some earlier discussion and it was
decided against though [0].

> 
>>   
>>   static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>>   
> [..]
>> @@ -422,12 +443,36 @@ void css_rstat_exit(struct cgroup_subsys_state *css)
>>   	css->rstat_cpu = NULL;
>>   }
>>   
>> -void __init cgroup_rstat_boot(void)
>> +/**
>> + * ss_rstat_init - subsystem-specific rstat initialization
>> + * @ss: target subsystem
>> + *
>> + * If @ss is NULL, the static locks associated with the base stats
>> + * are initialized. If @ss is non-NULL, the subsystem-specific locks
>> + * are initialized.
>> + */
>> +int __init ss_rstat_init(struct cgroup_subsys *ss)
>>   {
>>   	int cpu;
>>   
>> +	if (!ss) {
>> +		spin_lock_init(&rstat_base_lock);
> 
> IIUC locks defined with DEFINE_SPINLOCK() do not need to be initialized,
> and I believe we can achieve the same for the per-CPU locks as I
> described above and eliminate this branch completely.

True. I'll remove in next rev, but will keep the initialization for the
per-cpu locks based on [0].

[0] 
https://lore.kernel.org/all/jtqkpzqv4xqy4vajm6fljin6ospot37qg252dfk3yldzq6aubu@icg3ndtg3k7i/


