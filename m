Return-Path: <cgroups+bounces-5068-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C75DD9948C0
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 14:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3671F28CE0
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 12:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397EB1DED4E;
	Tue,  8 Oct 2024 12:16:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A5F17B4EC
	for <cgroups@vger.kernel.org>; Tue,  8 Oct 2024 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389772; cv=none; b=lvfNd646eI7kgodpWDEo40SjTVYVOhpaPKRKASCJsObDJ7444Ho4RpzxJVsvpstg2tEdG3FvLnWLIz0T40vovzt99eaoejxTa8ebHjgAT6aj0s+b4xNEyrjsLyMBTHG8b18l69OWajshehZVfyNPFnwmV2E0iMuhbb2L0Vp69Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389772; c=relaxed/simple;
	bh=0soBQhlX1ibkeLI9lHOOZtkrQRgS5RcPsK9+y3D/9r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VH7tpI0XdR1k0GdwGCfrTuQpBjM0CebOvNlTENAOe2fm8e154VNsE3gJq3QWxHhyl/sBcEbfIrhbe2NhIXb7fGwzopbmpgZ7yazPqJU4xnks6Fv6eHsa2ajLhvEaUWtqYQmzK8WGP4nJtx27OU1rOpMWKZ1tmei8rG4n/WXAEO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XNFNM03jKz4f3jsT
	for <cgroups@vger.kernel.org>; Tue,  8 Oct 2024 20:15:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CCD271A0568
	for <cgroups@vger.kernel.org>; Tue,  8 Oct 2024 20:16:03 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgCn2saCIgVnR78UDg--.44361S2;
	Tue, 08 Oct 2024 20:16:03 +0800 (CST)
Message-ID: <e9d520d7-562f-40c6-9a2b-ffa7e58815b8@huaweicloud.com>
Date: Tue, 8 Oct 2024 20:16:02 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATHC v3 -next 3/3] cgroup/freezer: Reduce redundant propagation
 for cgroup_propagate_frozen
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Chen Ridong <chenridong@huawei.com>
Cc: tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
 longman@redhat.com, adityakali@google.com, sergeh@kernel.org, guro@fb.com,
 cgroups@vger.kernel.org
References: <20240915071307.1976026-1-chenridong@huawei.com>
 <20240915071307.1976026-4-chenridong@huawei.com>
 <7j6zywvbd2lavlj5wc3yevc4s7ofrusjlpwcmuchhknlhp2mxo@77rwal3h2x65>
 <1bf886ad-10f4-435d-8fb1-ddd639cb3992@huaweicloud.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <1bf886ad-10f4-435d-8fb1-ddd639cb3992@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn2saCIgVnR78UDg--.44361S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WFykKr13WF18Kr4rCw1kuFg_yoW7ZF13pr
	4kJF4UJrZ8Jr1ktr1Dt34jqrykJr4UJw1kGryUJFy8Jr47XryIqr1UZr90gr1UAr4xJr1U
	Jr15Ar1UZr17JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/9/27 17:46, Chen Ridong wrote:
> 
> 
> On 2024/9/26 1:46, Michal Koutný wrote:
>> On Sun, Sep 15, 2024 at 07:13:07AM GMT, Chen Ridong 
>> <chenridong@huawei.com> wrote:
>>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>>> index dd1ecab99eeb..41e4e5a7ae55 100644
>>> --- a/include/linux/cgroup-defs.h
>>> +++ b/include/linux/cgroup-defs.h
>>> @@ -401,7 +401,9 @@ struct cgroup_freezer_state {
>>>       /* Fields below are protected by css_set_lock */
>>> -    /* Number of frozen descendant cgroups */
>>> +    /* Aggregating frozen descendant cgroups, only when all
>>> +     * descendants of a child are frozen will the count increase.
>>> +     */
>>>       int nr_frozen_descendants;
>>>       /*
>>> diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
>>> index bf1690a167dd..4ee33198d6fb 100644
>>> --- a/kernel/cgroup/freezer.c
>>> +++ b/kernel/cgroup/freezer.c
>>> @@ -35,27 +35,34 @@ static bool cgroup_update_frozen_flag(struct 
>>> cgroup *cgrp, bool frozen)
>>>    */
>>>   static void cgroup_propagate_frozen(struct cgroup *cgrp, bool frozen)
>>>   {
>>> -    int desc = 1;
>>> -
>>> +    int deta;
>>              delta
>>
>>> +    struct cgroup *parent;
>>
>> I'd suggest here something like
>>
>>     /* root cgroup never changes freeze state */
>>     if (WARN_ON(cgroup_parent(cgrp))
>>         return;
>>
>> so that the parent-> dereference below is explicitly safe.
>>
>>>       /*
>>>        * If the new state is frozen, some freezing ancestor cgroups 
>>> may change
>>>        * their state too, depending on if all their descendants are 
>>> frozen.
>>>        *
>>>        * Otherwise, all ancestor cgroups are forced into the 
>>> non-frozen state.
>>>        */
>>> -    while ((cgrp = cgroup_parent(cgrp))) {
>>> +    for (; cgrp; cgrp = cgroup_parent(cgrp)) {
>>>           if (frozen) {
>>> -            cgrp->freezer.nr_frozen_descendants += desc;
>>> +            /* If freezer is not set, or cgrp has descendants
>>> +             * that are not frozen, cgrp can't be frozen
>>> +             */
>>>               if (!test_bit(CGRP_FREEZE, &cgrp->flags) ||
>>>                   (cgrp->freezer.nr_frozen_descendants !=
>>> -                cgrp->nr_descendants))
>>> -                continue;
>>> +                 cgrp->nr_descendants))
>>> +                break;
>>> +            deta = cgrp->freezer.nr_frozen_descendants + 1;
>>>           } else {
>>> -            cgrp->freezer.nr_frozen_descendants -= desc;
>>> +            deta = -(cgrp->freezer.nr_frozen_descendants + 1);
>>
>> In this branch, if cgrp is unfrozen, delta = -1 is cgrp itself,
>> however is delta = -cgrp->freezer.nr_frozen_descendants warranted?
>> What if they are frozen empty children (of cgrp)? They likely shouldn't
>> be subtracted from ancestors nf_frozen_descendants.
>>
>> (This refers to a situation when
>>
>>     C    CGRP_FREEZE is set
>>     |\
>>     D E    both CGRP_FREEZE is set
>>
>> and an unfrozen task is migrated into C which would make C (temporarily)
>> unfrozen but not D nor E.)
>>
> Thank you, Michal.
> 
> I sorry I missed this situation.
> If unfreezing a cgroup, it seems it has to propagate to the top.
> 
> After consideration, I modify this function.
> the following is acceptable?
> 
> /*
>   * Propagate the cgroup frozen state upwards by the cgroup tree.
>   */
> static void cgroup_propagate_frozen(struct cgroup *cgrp, bool frozen)
> {
>      int deta = 0;
>      struct cgroup *parent;
>      /*
>       * case1: If the new state is frozen, some freezing ancestor 
> cgroups may change
>       * their state too, depending on if all their descendants are frozen.
>       *
>       * case2: unfrozen, all ancestor cgroups are forced into the 
> non-frozen state.
>       */
>      for (; cgrp; cgrp = cgroup_parent(cgrp)) {
>          if (frozen) {
>              /* If freezer is not set, or cgrp has descendants
>               * that are not frozen, cgrp can't be frozen
>               */
>              if (!test_bit(CGRP_FREEZE, &cgrp->flags) ||
>                  (cgrp->freezer.nr_frozen_descendants !=
>                   cgrp->nr_descendants))
>                  break;
>              /* No change, stop propagate */
>              if (!cgroup_update_frozen_flag(cgrp, frozen))
>                  break;
>              deta = cgrp->freezer.nr_frozen_descendants + 1;
>          } else {
>              /* case2: have to propagate all ancestor */
>              if (cgroup_update_frozen_flag(cgrp, frozen))
>                  deta++;
>          }
> 
>          parent = cgroup_parent(cgrp);
>          parent->freezer.nr_frozen_descendants += deta;
>      }
> }
> 
> Best regards,
> Ridong
> 
Hi, Michal, Do you think this can be acceptable?
I don't have a better idea, If you have a better a idea, please let me know.

Best regards,
Ridong


