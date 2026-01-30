Return-Path: <cgroups+bounces-13542-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAi8Cl1cfGkYMAIAu9opvQ
	(envelope-from <cgroups+bounces-13542-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 08:23:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A1FB7E19
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 08:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEDC2300603E
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 07:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE5130C373;
	Fri, 30 Jan 2026 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ktmqdqo8"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A69309F08
	for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769757767; cv=none; b=UHVDlmlzgpYqQ6s43qzFP1Lw5xDE/gRrA7IEYzQBD7v5KkNrUkxjaUU85pXvhFZ1EBIs6Cco6v7wGNnB6CYOyKqiyif7lsksd0Qdi6vNsjN8gIesnEPYJHcXgbqHJc+RTDZf+I3ops8bkyXtK1Wr+eLCUpepvZCwBYeEC+ouY0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769757767; c=relaxed/simple;
	bh=IdO5Ic3HMWIxTFWF8FWK5Joh8ZBNw0ajx0cCeF2DaHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OsrkdW5vyn7rds3Zwj3Y1uRtIV9gC141w4RrKKknnmlQ+lDxgeok0h/06CSlyPl7F4qg/Eg+2fK9TxORN6qbCxN8VBcx0OInXi0v6wlrPTdjnvHScAh0v7eCoWwdrwHbVbgzSkSHuiufT2lNPNi2EkcU6kpDMEcUHuRzlPC928o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ktmqdqo8; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4535d53c-68aa-4c3d-b95e-6fbafdb83881@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769757753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DMcRu4QwA2GjVjU5hQW3p3XdUu94fizF7UvrxMPIJbU=;
	b=ktmqdqo8hEUIvmBaLB5kEAOvoWyJMBhFHdYM1Niq9JxZhSbD4k8N9it1RiFmkRH4pg8tme
	WBV6lOxiVdEE4gKY79ZHnJE8JbmRG8lJ7b6x6ffnoo0YlP/LAIo6RJLQ5VrWn3bBQ3mT1S
	39DregSZ+wfBsxMMJldJMaI/oqsQ050=
Date: Fri, 30 Jan 2026 15:22:20 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 28/30] mm: memcontrol: prepare for reparenting
 state_local
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com, lance.yang@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <b11a0bde9fe18673a61a79398f226ad7cb04a894.1768389889.git.zhengqi.arch@bytedance.com>
 <iu27pt5nqs6myshw57e7dotld33v6lwuyouvquoqc2zmc5loi6@f23auf7hqbdp>
 <9b9057f8-4c4c-4067-b6ba-0791888c25e8@linux.dev> <aXrBiPlpEOOC3cMZ@hyeyoo>
 <6860146b-be12-4d5f-bec1-bbcec1dffbc6@linux.dev> <aXtRWdwwmi7G-Hlg@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aXtRWdwwmi7G-Hlg@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13542-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bytedance.com:email]
X-Rspamd-Queue-Id: 60A1FB7E19
X-Rspamd-Action: no action



On 1/29/26 8:23 PM, Harry Yoo wrote:
> On Thu, Jan 29, 2026 at 04:50:39PM +0800, Qi Zheng wrote:
>>
>>
>> On 1/29/26 10:10 AM, Harry Yoo wrote:
>>> On Mon, Jan 19, 2026 at 11:34:53AM +0800, Qi Zheng wrote:
>>>>
>>>>
>>>> On 1/18/26 11:20 AM, Shakeel Butt wrote:
>>>>> On Wed, Jan 14, 2026 at 07:32:55PM +0800, Qi Zheng wrote:
>>>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>>
>>>>>> To resolve the dying memcg issue, we need to reparent LRU folios of child
>>>>>> memcg to its parent memcg. The following counts are all non-hierarchical
>>>>>> and need to be reparented to prevent the counts of parent memcg overflow.
>>>>>>
>>>>>> 1. memcg->vmstats->state_local[i]
>>>>>> 2. pn->lruvec_stats->state_local[i]
>>>>>>
>>>>>> This commit implements the specific function, which will be used during
>>>>>> the reparenting process.
>>>>>
>>>>> Please add more explanation which was discussed in the email chain at
>>>>> https://lore.kernel.org/all/5dsb6q2r4xsi24kk5gcnckljuvgvvp6nwifwvc4wuho5hsifeg@5ukg2dq6ini5/
>>>>
>>>> OK, will do.
>>>>
>>>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>>>> index 70583394f421f..7aa32b97c9f17 100644
>>>>>> --- a/mm/memcontrol.c
>>>>>> +++ b/mm/memcontrol.c
>>>>>> @@ -225,6 +225,28 @@ static inline struct obj_cgroup *__memcg_reparent_objcgs(struct mem_cgroup *memc
>>>>>>     	return objcg;
>>>>>>     }
>>>>>> +#ifdef CONFIG_MEMCG_V1
>>>>>> +static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force);
>>>>>> +
>>>>>> +static inline void reparent_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
>>>>>> +{
>>>>>> +	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
>>>>>> +		return;
>>>>>> +
>>>>>> +	synchronize_rcu();
>>>>>
>>>>> Hmm synchrinuze_rcu() is a heavy hammer here. Also you would need rcu
>>>>> read lock in mod_memcg_state() & mod_memcg_lruvec_state() for this
>>>>> synchronize_rcu().
>>>>
>>>> Since these two functions require memcg or lruvec, they are already
>>>> within the critical section of the RCU lock.
>>>
>>> What happens if someone grabbed a refcount and then release the rcu read
>>> lock before percpu refkill and then call mod_memcg[_lruvec]_state()?
>>>
>>> In this case, can we end up reparenting in the middle of non-hierarchical
>>> stat update because they don't have RCU grace period?
>>>
>>> Something like
>>>
>>> T1				T2
>>>
>>> 				- rcu_read_lock()
>>> 				- get memcg refcnt
>>> 				- rcu_read_unlock()
>>>
>>> 				- call mod_memcg_state()
>>> 				- CSS_IS_DYING is not set
>>> - Set CSS_IS_DYING
>>> - Trigger percpu refkill
>>> 				
>>> - Trigger offline_css()
>>>     -> reparent non-hierarchical	- update non-hierarchical stats
>>>        stats
>>> 				- put memcg refcount
>>
>> Good catch, I think you are right.
>>
>> The rcu lock should be added to mod_memcg_state() and
>> mod_memcg_lruvec_state().
> 
> Thanks for confirming!
> 
> Because it's quite confusing, let me ask few more questions...
> 
> Q1. Yosry mentioned [1] [2] that stat updates should be done in the same
> RCU section that is used to grab a refcount of the cgroup.
> 
> But I don't think your work is relying on that. Instead, I guess, it's
> relying on the CSS_DYING check from reader side to determine whether it

Only relying the CSS_DYING check is insufficient. Otherwise, the
following race may occur:

T1				T2

				memcg_is_dying is false
Set CSS_IS_DYING
reparent non-hierarchical	update non-hierarchical stats for child

So IIUC we should add rcu lock, then:

T1				T2

				rcu_read_lock
				memcg_is_dying is false

Set CSS_IS_DYING
				update non-hierarchical stats for child
				rcu_read_unlock

synchronize_rcu or rcu work
--> reparent non-hierarchical


> should update stats of the child or parent memcg, right?
> 
> -> That being said, when rcu_read_lock() is called _after_ stats are
>     reparented, the reader must observe that the CSS_DYING flag is set.
> 
> [1] https://lore.kernel.org/all/utl6esq7jz5e4f7kwgrpwdjc2rm3yi33ljb6xkm5nxzufa4o7s@hblq2piu3vnz
> [2] https://lore.kernel.org/all/ebdhvcwygvnfejai5azhg3sjudsjorwmlcvmzadpkhexoeq3tb@5gj5y2exdhpn
> 
> Q2. When a reader checks CSS_DYING flag, how is the flag change
> guaranteed to be visible to the reader without any lock, memory barrier,
> or atomic ops involved?

The main situation requiring CSS_DYING check is as follow:

T1				T2

Set CSS_IS_DYING

synchronize_rcu or rcu work
--> reparent non-hierarchical
				rcu_read_lock()
				memcg_is_dying is true
				update non-hierarchical stats for parent

Referring to the "Memory-Barrier Guarantees" section in [1], 
synchronize_rcu() can guarantee that T2 can see CSS_IS_DYING. Right?


[1]. 
https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.rst

Thanks,
Qi

> 
> As Shakeel mentioned elsewhere, I hope some explanations for correctness
> to be included in the commit message :)
> 
>> I will update to v4 as soon as possible.
> 
> Thanks a lot!
> 
> I'll wait for that and will review carefully to make sure it's correct ;)
> 
>> Thanks,
>> Qi
>>
>>>>> Hmm instead of synchronize_rcu() here, we can use queue_rcu_work() in
>>>>> css_killed_ref_fn(). It would be as simple as the following:
>>>>
>>>> It does look much simpler, will do.
>>>>
>>>> Thanks,
>>>> Qi
> 


