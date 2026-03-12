Return-Path: <cgroups+bounces-14781-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BIvF5AKsml7IAAAu9opvQ
	(envelope-from <cgroups+bounces-14781-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 01:36:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BDC26BB74
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 01:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40011303C52B
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 00:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C8132D45C;
	Thu, 12 Mar 2026 00:36:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA9D3264DA
	for <cgroups@vger.kernel.org>; Thu, 12 Mar 2026 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773275787; cv=none; b=LWgobX9nw16oLbM1xnelRqtAmQnEG+wF5sJeL6Lq11P6uQsZkktZ89MAtbPaHFj6O+wLV+BGsqWzjchCqS2yO4fMMxnoLUattDLV7JRrA1+7pKMXQMJl1jn9jhIs0R+JkH7rr5bpoIX+MH91aTWukKyT/cBjYVVvXt/YxKcEUBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773275787; c=relaxed/simple;
	bh=VB1tmU+ezTEA2WQqC/Gezmd80khmnORRZ0v+65FmpVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5TBSAhUDvQkxa6bB+5m+kP2uaLi2Cb7VzH2eLusWiMPSNXG/jkIPvpYLoCkgIVjRpoU8LO6NjJCskowxkFoWY0b9zUABfh26FoA/sZhMNoUx7rMPdVzYPsUDPhLJ+ooXgP32nWVCWby2b2e9w+WtNU6sk+NqCx4F4nqjDk0ZGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fWTDt3GvqzKHMXm
	for <cgroups@vger.kernel.org>; Thu, 12 Mar 2026 08:35:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 149114056E
	for <cgroups@vger.kernel.org>; Thu, 12 Mar 2026 08:36:16 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgBXN1R8CrJpwfBMAg--.53761S2;
	Thu, 12 Mar 2026 08:36:13 +0800 (CST)
Message-ID: <45f4ec59-7d7b-4f68-a43b-e89a8bb717e4@huaweicloud.com>
Date: Thu, 12 Mar 2026 08:36:12 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] cgroup/dmem: Add queries for protection values
To: Natalie Vock <natalie.vock@gmx.de>, Maarten Lankhorst <dev@lankhorst.se>,
 Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260302-dmemcg-aggressive-protect-v5-0-ffd3a2602309@gmx.de>
 <20260302-dmemcg-aggressive-protect-v5-1-ffd3a2602309@gmx.de>
 <47edbd3d-e681-4999-b1ad-ba7c987e3430@huaweicloud.com>
 <be9b9446-c835-4ab9-8f19-906f842414dd@gmx.de>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <be9b9446-c835-4ab9-8f19-906f842414dd@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBXN1R8CrJpwfBMAg--.53761S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF43Gr1UGw45XF48Ar15XFb_yoW3Kr4DpF
	1kGFy3K3y5Cr1xJr1Iy34jvFyrAw40qw1UJryxGF18JrnrJr1aqr17Zr1jgF1UCFs7Jr17
	A3WYvrnru3yayrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14781-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[gmx.de,lankhorst.se,kernel.org,cmpxchg.org,suse.com,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.594];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,huaweicloud.com:mid]
X-Rspamd-Queue-Id: B7BDC26BB74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/11 16:33, Natalie Vock wrote:
> On 3/11/26 02:12, Chen Ridong wrote:
>>
>>
>> On 2026/3/2 20:37, Natalie Vock wrote:
>>> Callers can use this feedback to be more aggressive in making space for
>>> allocations of a cgroup if they know it is protected.
>>>
>>> These are counterparts to memcg's mem_cgroup_below_{min,low}.
>>>
>>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>>> ---
>>>   include/linux/cgroup_dmem.h | 16 ++++++++++++
>>>   kernel/cgroup/dmem.c        | 62 +++++++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 78 insertions(+)
>>>
>>> diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
>>> index dd4869f1d736e..1a88cd0c9eb00 100644
>>> --- a/include/linux/cgroup_dmem.h
>>> +++ b/include/linux/cgroup_dmem.h
>>> @@ -24,6 +24,10 @@ void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state
>>> *pool, u64 size);
>>>   bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state
>>> *limit_pool,
>>>                         struct dmem_cgroup_pool_state *test_pool,
>>>                         bool ignore_low, bool *ret_hit_low);
>>> +bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state *root,
>>> +               struct dmem_cgroup_pool_state *test);
>>> +bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
>>> +               struct dmem_cgroup_pool_state *test);
>>>     void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool);
>>>   #else
>>> @@ -59,6 +63,18 @@ bool dmem_cgroup_state_evict_valuable(struct
>>> dmem_cgroup_pool_state *limit_pool,
>>>       return true;
>>>   }
>>>   +static inline bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state *root,
>>> +                     struct dmem_cgroup_pool_state *test)
>>> +{
>>> +    return false;
>>> +}
>>> +
>>> +static inline bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
>>> +                     struct dmem_cgroup_pool_state *test)
>>> +{
>>> +    return false;
>>> +}
>>> +
>>>   static inline void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state
>>> *pool)
>>>   { }
>>>   diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
>>> index 9d95824dc6fa0..28227405f7cfe 100644
>>> --- a/kernel/cgroup/dmem.c
>>> +++ b/kernel/cgroup/dmem.c
>>> @@ -694,6 +694,68 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region
>>> *region, u64 size,
>>>   }
>>>   EXPORT_SYMBOL_GPL(dmem_cgroup_try_charge);
>>>   +/**
>>> + * dmem_cgroup_below_min() - Tests whether current usage is within min limit.
>>> + *
>>> + * @root: Root of the subtree to calculate protection for, or NULL to
>>> calculate global protection.
>>> + * @test: The pool to test the usage/min limit of.
>>> + *
>>> + * Return: true if usage is below min and the cgroup is protected, false
>>> otherwise.
>>> + */
>>> +bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state *root,
>>> +               struct dmem_cgroup_pool_state *test)
>>> +{
>>> +    if (root == test || !pool_parent(test))
>>> +        return false;
>>> +
>>> +    if (!root) {
>>> +        for (root = test; pool_parent(root); root = pool_parent(root))
>>> +            {}
>>> +    }
>>
>> It seems we don't have find the global protection(root), since the root's
>> protection can not be set. If !root, we can return false directly, right?
>>
>> Or do I miss anything?
>>
>> ```
>>     {
>>         .name = "min",
>>         .write = dmem_cgroup_region_min_write,
>>         .seq_show = dmem_cgroup_region_min_show,
>>         .flags = CFTYPE_NOT_ON_ROOT,
>>     },
>>     {
>>         .name = "low",
>>         .write = dmem_cgroup_region_low_write,
>>         .seq_show = dmem_cgroup_region_low_show,
>>         .flags = CFTYPE_NOT_ON_ROOT,
>>     },
>> ```
> 
> That's not quite how it works. You're correct that the min/low properties don't
> exist on the root cgroup, but we don't use the root for that.
> 
> The reason we have a root here in the first place has to do with how recursive
> memory protection works in cgroups. Note that for the test cgroup, we don't read
> the literal min/low protection setting, but the "emin"/"elow" value, referring
> to effective protection. The effective protection value depends not just on the
> settings of the "test" cgroup, but also its ancestors (and potentially, their
> sibling groups). See [1] for some documentation on how effective protection
> varies with different cgroup relationships.
> 
> The "root" parameter here refers to the root of the common subtree between the
> test cgroup and what the documentation refers to as the "reclaim target". For
> device memory there usually isn't really any reclaim happening in the
> traditional sense, but e.g. TTM evictions follow the same principle (the reclaim
> target is simply the cgroup owning the buffer that is to be evicted).
> 
> Sometimes, precise reclaim targets may not really be known yet (or we want to
> try evicting different buffers originating from different cgroups). In that
> case, the "root" parameter here is NULL. However, we obviously know that all
> cgroups must be descendants of the root cgroup, so the root cgroup is a
> guaranteed safe value for the shared subtree between the test cgroup and any
> potential reclaim target.
> 
> In practice, this means that the effective min/low protection will be capped by
> the protection value specified in all ancestors, which is the most conservative
> estimate.
> 
> Regards,
> Natalie
> 
> [1] https://docs.kernel.org/admin-guide/cgroup-v2.html#reclaim-protection
> 

Thank you for your explanation. I made a mistake.
Sorry for the noisy.

>>
>>> +
>>> +    /*
>>> +     * In mem_cgroup_below_min(), the memcg pendant, this call is missing.
>>> +     * mem_cgroup_below_min() gets called during traversal of the cgroup
>>> tree, where
>>> +     * protection is already calculated as part of the traversal. dmem
>>> cgroup eviction
>>> +     * does not traverse the cgroup tree, so we need to recalculate
>>> effective protection
>>> +     * here.
>>> +     */
>>> +    dmem_cgroup_calculate_protection(root, test);
>>> +    return page_counter_read(&test->cnt) <= READ_ONCE(test->cnt.emin);
>>> +}
>>> +EXPORT_SYMBOL_GPL(dmem_cgroup_below_min);
>>> +
>>> +/**
>>> + * dmem_cgroup_below_low() - Tests whether current usage is within low limit.
>>> + *
>>> + * @root: Root of the subtree to calculate protection for, or NULL to
>>> calculate global protection.
>>> + * @test: The pool to test the usage/low limit of.
>>> + *
>>> + * Return: true if usage is below low and the cgroup is protected, false
>>> otherwise.
>>> + */
>>> +bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
>>> +               struct dmem_cgroup_pool_state *test)
>>> +{
>>> +    if (root == test || !pool_parent(test))
>>> +        return false;
>>> +
>>> +    if (!root) {
>>> +        for (root = test; pool_parent(root); root = pool_parent(root))
>>> +            {}
>>> +    }
>>> +
>>> +    /*
>>> +     * In mem_cgroup_below_low(), the memcg pendant, this call is missing.
>>> +     * mem_cgroup_below_low() gets called during traversal of the cgroup
>>> tree, where
>>> +     * protection is already calculated as part of the traversal. dmem
>>> cgroup eviction
>>> +     * does not traverse the cgroup tree, so we need to recalculate
>>> effective protection
>>> +     * here.
>>> +     */
>>> +    dmem_cgroup_calculate_protection(root, test);
>>> +    return page_counter_read(&test->cnt) <= READ_ONCE(test->cnt.elow);
>>> +}
>>> +EXPORT_SYMBOL_GPL(dmem_cgroup_below_low);
>>> +
>>>   static int dmem_cgroup_region_capacity_show(struct seq_file *sf, void *v)
>>>   {
>>>       struct dmem_cgroup_region *region;
>>>
>>

-- 
Best regards,
Ridong


