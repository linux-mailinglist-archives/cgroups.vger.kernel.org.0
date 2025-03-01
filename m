Return-Path: <cgroups+bounces-6753-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B7CA4A747
	for <lists+cgroups@lfdr.de>; Sat,  1 Mar 2025 02:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140713BB8C8
	for <lists+cgroups@lfdr.de>; Sat,  1 Mar 2025 01:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD93F17580;
	Sat,  1 Mar 2025 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxcoIWhO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C91923F378
	for <cgroups@vger.kernel.org>; Sat,  1 Mar 2025 01:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740791188; cv=none; b=qT4uR2OmU1MTythUr7a1AoLuDYltRwHYckgGCQsmZT4Zb29VtEWLkJlhY02+5EzV3kc/8DL9FqgHDD6qQj229sQjWXmyYRSqKiprPgkGh1SUsyS2Mwf/dobIP/g1b5S9yjyrtS0a01zkyWVJaC6WykFNwLUzRpN/gYQpJHYau6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740791188; c=relaxed/simple;
	bh=SYUE0papbyoYiSwoiHSmj1ZeLYp7FC80+ZGYqFmF7Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGZj2dCP8rM4WS/6jGLpyi6Cv3mUqDgwW4TOUFb4AiMmSjE79pFO/ocgD6guT10Ybzot1rRNWdpcdGFE9UcPXPQ74+/QJSTcPFRsTVoj+BnYMa+0EvhkzZYgajhY9wrh5AZfPdUrL2JJoYmviZprebSBipF/gV6Paz53kK38pqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxcoIWhO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22334203781so59737585ad.0
        for <cgroups@vger.kernel.org>; Fri, 28 Feb 2025 17:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740791186; x=1741395986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7/zWsHsPc6a2faj25H4e7UGV7b8b3EYJTuixl3SmsU=;
        b=gxcoIWhOQFkETDSMDzhUCFf00dMI3MiWk/IH/T8FbBhWmeRVKpWeh1R9oLphjhMjtx
         e3E/c14Oo500uxAJGsow8W1Sk6vCoyI7Gft8lpVujKzssZrDFmtUPluQpar2UEyyrIx/
         vvEh7dEMJWi/OKy9LqdFrQZWpXaHGsPGLLvY/78mgI1t6t8+bLQJXDarWawL9CF9NmDo
         NFy71TWwi4cougDXIkavqBOgtBmG26CCfitMX6NAcNs7Py+C9HAfK6np6mCYZ9DPKKhV
         ZVE0apSBOtiHcL/vVxK3He6fvjQXPry62EPGk5qAdIKkrby0mxwN6DOlCQ9R6BoRz11M
         BYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740791186; x=1741395986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/7/zWsHsPc6a2faj25H4e7UGV7b8b3EYJTuixl3SmsU=;
        b=qI/G5Jo2GlgqH7BwCp/3znV3s8TN5X4D9quoW9TnmAALNdbESKn3S+ReNlITBhjyjr
         ARCe2blFeYZgjPI9D/TAoiYLzRzxw6x2FACozdrd2Hc+8fFs1vCbofdRDRaxw5/6grfT
         nJgC1HBIEJo6z0F29x8JDl0D6rgWhhLuXSUs/ih7AUzo9B8496bzV+7a4JkC3AI66KJJ
         y2GoLU0xulW7fLiwy/n1f+Sv8KxvoMWHJMg9prCZqSYCZwVTum3N9gv2cqGEP/zLOOSe
         aBlmL1qOui9rtm83UtKCKAz1osrMEUQ8HbAjEq9VvSnm3fNeLSAfgtVcszGk+FJYAZD9
         RSug==
X-Forwarded-Encrypted: i=1; AJvYcCWAw5EnWAqftB236GUdjktuwx34z4tyb3G8vKsjrp3vntlUVva9919VNl28Ufgfr1kWwXrbTp3A@vger.kernel.org
X-Gm-Message-State: AOJu0YwNjfMDtzLyncrZgUZW7t6JTnRbZmTH8h9tCr3JYpKkaSrR1za2
	8AwIuaL9fWvCTzMZ2htALZ+EiL+yDVH4JfuaTdXPkUUHiyhH8fZb
X-Gm-Gg: ASbGncuObBNTO223KAQhe2X490szmSxwaKa+4g9tgZJt7ZPRZ0VvX7XfSTWMF7vChjp
	Mvx4ToSVXX1iSnc7WYKz3rvTss165j2gGj67N89K0I6+Lokwk4fwUXvzWnH21A0erYnkhNYUc4T
	YrEKgDGMThrr+BHOGrNTeHhsSTFs8WhOYjNNKn2/HmnTYo4pVVK5yKBIa+yZv2Jzg4ag5Wm6oZu
	JbvYqahCE+S/7egERHZTXas0lrvziYTBCyO/JM/SfGLR5hq8ZDMUQL7aWvR+4p3VNLdFLSq4jx0
	F0beflXqPKgbDlsUe+oObRPQLXjhNWLyzePg93DqeyeWkkVOjox3HWahNfr6itYAZu3XvUAoiYV
	ZFPGUn62q+ymvC0E=
X-Google-Smtp-Source: AGHT+IEVk4MG7sbkHKT+/NayVjJ0aygZ6h8HenfCxUF1dzvAvFILnPFqw9uc3f3IcVcQpbpvcleQpQ==
X-Received: by 2002:a05:6a00:ad0:b0:732:1ce5:4a4c with SMTP id d2e1a72fcca58-734ac36b279mr8905910b3a.1.1740791186057;
        Fri, 28 Feb 2025 17:06:26 -0800 (PST)
Received: from [192.168.2.117] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0024c81sm4392299b3a.118.2025.02.28.17.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 17:06:25 -0800 (PST)
Message-ID: <bd45e4df-266e-4b67-abd5-680808a40d4f@gmail.com>
Date: Fri, 28 Feb 2025 17:06:23 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4 v2] cgroup: move cgroup_rstat from cgroup to
 cgroup_subsys_state
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: tj@kernel.org, shakeel.butt@linux.dev, mhocko@kernel.org,
 hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-2-inwardvessel@gmail.com> <Z8IIxUdRpqxZyIHO@google.com>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <Z8IIxUdRpqxZyIHO@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 11:04 AM, Yosry Ahmed wrote:
> On Thu, Feb 27, 2025 at 01:55:40PM -0800, inwardvessel wrote:
>> From: JP Kobryn <inwardvessel@gmail.com>
>>
>> Each cgroup owns rstat pointers. This means that a tree of pending rstat
>> updates can contain changes from different subsystems. Because of this
>> arrangement, when one subsystem is flushed via the public api
>> cgroup_rstat_flushed(), all other subsystems with pending updates will
>> also be flushed. Remove the rstat pointers from the cgroup and instead
>> give them to each cgroup_subsys_state. Separate rstat trees will now
>> exist for each unique subsystem. This separation allows for subsystems
>> to make updates and flushes without the side effects of other
>> subsystems. i.e. flushing the cpu stats does not cause the memory stats
>> to be flushed and vice versa. The change in pointer ownership from
>> cgroup to cgroup_subsys_state allows for direct flushing of the css, so
>> the rcu list management entities and operations previously tied to the
>> cgroup which were used for managing a list of subsystem states with
>> pending flushes are removed. In terms of client code, public api calls
>> were changed to now accept a reference to the cgroup_subsys_state so
>> that when flushing or updating, a specific subsystem is associated with
>> the call.
> 
> I think the subject is misleading. It makes it seem like this is a
> refactoring patch that is only moving a member from one struct to
> another, but this is actually the core of the series.
> 
> Maybe something lik "cgroup: use separate rstat trees for diffrent
> subsystems"?
> 
> Also, breaking down the commit message into paragraphs helps with
> readability.

Makes sense. Will adjust in next rev.
> 
> [..]
>> @@ -386,8 +394,8 @@ struct cgroup_rstat_cpu {
>>   	 *
>>   	 * Protected by per-cpu cgroup_rstat_cpu_lock.
>>   	 */
>> -	struct cgroup *updated_children;	/* terminated by self cgroup */
>> -	struct cgroup *updated_next;		/* NULL iff not on the list */
>> +	struct cgroup_subsys_state *updated_children;	/* terminated by self */
>> +	struct cgroup_subsys_state *updated_next;		/* NULL if not on list */
> 
> nit: comment indentation needs fixing here
> 
>>   };
>>   
>>   struct cgroup_freezer_state {
> [..]
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index afc665b7b1fe..31b3bfebf7ba 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -164,7 +164,9 @@ static struct static_key_true *cgroup_subsys_on_dfl_key[] = {
>>   static DEFINE_PER_CPU(struct cgroup_rstat_cpu, cgrp_dfl_root_rstat_cpu);
> 
> Should we rename cgrp_dfl_root_rstat_cpu to indicate that it's specific
> to self css?

Sure.

> 
>>   
>>   /* the default hierarchy */
>> -struct cgroup_root cgrp_dfl_root = { .cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu };
>> +struct cgroup_root cgrp_dfl_root = {
>> +	.cgrp.self.rstat_cpu = &cgrp_dfl_root_rstat_cpu
>> +};
>>   EXPORT_SYMBOL_GPL(cgrp_dfl_root);
>>   
>>   /*
> [..]
>> @@ -5407,7 +5401,11 @@ static void css_free_rwork_fn(struct work_struct *work)
>>   		struct cgroup_subsys_state *parent = css->parent;
>>   		int id = css->id;
>>   
>> +		if (css->ss->css_rstat_flush)
>> +			cgroup_rstat_exit(css);
>> +
>>   		ss->css_free(css);
>> +
> 
> nit: extra blank line here
> 
>>   		cgroup_idr_remove(&ss->css_idr, id);
>>   		cgroup_put(cgrp);
>>   
>> @@ -5431,7 +5429,7 @@ static void css_free_rwork_fn(struct work_struct *work)
>>   			cgroup_put(cgroup_parent(cgrp));
>>   			kernfs_put(cgrp->kn);
>>   			psi_cgroup_free(cgrp);
>> -			cgroup_rstat_exit(cgrp);
>> +			cgroup_rstat_exit(&cgrp->self);
>>   			kfree(cgrp);
>>   		} else {
>>   			/*
>> @@ -5459,11 +5457,7 @@ static void css_release_work_fn(struct work_struct *work)
>>   	if (ss) {
>>   		struct cgroup *parent_cgrp;
>>   
>> -		/* css release path */
>> -		if (!list_empty(&css->rstat_css_node)) {
>> -			cgroup_rstat_flush(cgrp);
>> -			list_del_rcu(&css->rstat_css_node);
>> -		}
>> +		cgroup_rstat_flush(css);
> 
> Here we used to call cgroup_rstat_flush() only if there was a
> css_rstat_flush() callback registered, now we call it unconditionally.
> 
> Could this cause a NULL dereference when we try to call
> css->ss->css_rstat_flush() for controllers that did not register a
> callback?

Good point. Misuse here can lead to a bad access. Will cover in v3.

> 
>>   
>>   		cgroup_idr_replace(&ss->css_idr, NULL, css->id);
>>   		if (ss->css_released)
> [..]
>> @@ -6188,6 +6186,9 @@ int __init cgroup_init(void)
>>   			css->id = cgroup_idr_alloc(&ss->css_idr, css, 1, 2,
>>   						   GFP_KERNEL);
>>   			BUG_ON(css->id < 0);
>> +
>> +			if (css->ss && css->ss->css_rstat_flush)
>> +				BUG_ON(cgroup_rstat_init(css));
> 
> Why do we need this call here? We already call cgroup_rstat_init() in
> cgroup_init_subsys(). IIUC for subsystems with ss->early_init, we will
> have already called cgroup_init_subsys() in cgroup_init_early().
> 
> Did I miss something?

Hmmm it's a good question. cgroup_rstat_init() is deferred in the same
way that cgroup_idr_alloc() is. So for ss with early_init == true,
cgroup_rstat_init() is not called during cgroup_early_init().

Is it safe to call alloc_percpu() during early boot? If so, the
deferral can be removed and cgroup_rstat_init() can be called in one
place.

> 
>>   		} else {
>>   			cgroup_init_subsys(ss, false);
>>   		}
> [..]
>> @@ -300,27 +306,25 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
>>   }
>>   
>>   /* see cgroup_rstat_flush() */
>> -static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>> +static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css)
>>   	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
>>   {
>> +	struct cgroup *cgrp = css->cgroup;
>>   	int cpu;
>>   
>>   	lockdep_assert_held(&cgroup_rstat_lock);
>>   
>>   	for_each_possible_cpu(cpu) {
>> -		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
>> +		struct cgroup_subsys_state *pos;
>>   
>> +		pos = cgroup_rstat_updated_list(css, cpu);
>>   		for (; pos; pos = pos->rstat_flush_next) {
>> -			struct cgroup_subsys_state *css;
>> +			if (!pos->ss)
>> +				cgroup_base_stat_flush(pos->cgroup, cpu);
>> +			else
>> +				pos->ss->css_rstat_flush(pos, cpu);
>>   
>> -			cgroup_base_stat_flush(pos, cpu);
>> -			bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
>> -
>> -			rcu_read_lock();
>> -			list_for_each_entry_rcu(css, &pos->rstat_css_list,
>> -						rstat_css_node)
>> -				css->ss->css_rstat_flush(css, cpu);
>> -			rcu_read_unlock();
>> +			bpf_rstat_flush(pos->cgroup, cgroup_parent(pos->cgroup), cpu);
> 
> We should call bpf_rstat_flush() only if (!pos->ss) as well, right?
> Otherwise we will call BPF rstat flush whenever any subsystem is
> flushed.
> 
> I guess it's because BPF can now pass any subsystem to
> cgroup_rstat_flush(), and we don't keep track. I think it would be
> better if we do not allow BPF programs to select a css and always make
> them flush the self css.
> 
> We can perhaps introduce a bpf_cgroup_rstat_flush() wrapper that takes
> in a cgroup and passes cgroup->self internally to cgroup_rstat_flush().

I'm fine with this if others are in agreement. A similar concept was
done in v1.

> 
> But if the plan is to remove the bpf_rstat_flush() call here soon then
> it's probably not worth the hassle.
> 
> Shakeel (and others), WDYT?


