Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C6535D114
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 21:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbhDLTa2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 15:30:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20320 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237081AbhDLTa2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 15:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618255809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g6Ynsmxxkwh+nxh0otIklQ6uU+PBKwuJrjfFSi5KMSM=;
        b=KWilL3yWeCvBqOmbXTFGWiSRgDFbDp+ebJPDQoZZPWhQLikyYlFwhnfN+G7BuFar5fltqk
        QsozqEKqNCL6Gl12JlwJxN7Y/G72CyHWAAaP1NCqf3lEdtpBlqDvpg3zcGgeyHsZV6+S+t
        Qn4YG0se5mDtnppw1/xfG9BZKstvpYQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-NKImdEepNiaFJkgAU6CeHg-1; Mon, 12 Apr 2021 15:30:07 -0400
X-MC-Unique: NKImdEepNiaFJkgAU6CeHg-1
Received: by mail-qv1-f70.google.com with SMTP id m10so3032375qvo.13
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 12:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=g6Ynsmxxkwh+nxh0otIklQ6uU+PBKwuJrjfFSi5KMSM=;
        b=ecideA7w40AsVgJyV8uPtRn3SeXQg1wBKl7jfSYCoyVMFrwJmqXRpsHDSTYjzzGMzD
         lfA+Hb13gxF0Wek88fQ4L8LoZntimCeLMvj7s5aqhiyQJEMpdhqUX7VAh+T4TdTL5Js+
         F2DUq811grOrzrrkg90VnOeibd87KUIOyhb6UHvf9Ou98Q+YBdR89/dhW2zFJyCri7fM
         wOqLPYVIgeResgJBchd3kFpSTccjQ0yW7yprFFokaF1lPhSfTXvSudhXNJeJ1voOtoOj
         RFjJh69l7anldc8Ov3TBUPgcyOSq/WaewqSOvWAxvaRulaMf/xc8psD7mcNUd6UjeJDE
         N7MQ==
X-Gm-Message-State: AOAM533Y3hICseb9CmySvlx23PXKxmCF56TGrO4YEqNy08raKepcOQof
        /HKEBEX4yH6A8U63ay8gDS8cKIuixsVCGhbY+lEGINNp17RplgwwUzQqm/4VE1bIXqn576dvlzN
        FEh1B2Td2RLlSAJZ/iw==
X-Received: by 2002:a05:620a:133b:: with SMTP id p27mr30028346qkj.382.1618255806689;
        Mon, 12 Apr 2021 12:30:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/0ZhcohubWOy2Odk9W0Je22ttvn2Xb+0qT9mcE7do92RYBiLJoRTivziK/j0RC5FuoUOAEw==
X-Received: by 2002:a05:620a:133b:: with SMTP id p27mr30028309qkj.382.1618255806482;
        Mon, 12 Apr 2021 12:30:06 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id i22sm2868262qko.135.2021.04.12.12.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 12:30:06 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 3/5] mm/memcg: Cache vmstat data in percpu memcg_stock_pcp
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
References: <20210409231842.8840-1-longman@redhat.com>
 <20210409231842.8840-4-longman@redhat.com>
 <YHSP+U/I52zx/JWZ@carbon.dhcp.thefacebook.com>
Message-ID: <16af80a2-30a0-06da-9fd1-8d5101398fb9@redhat.com>
Date:   Mon, 12 Apr 2021 15:30:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YHSP+U/I52zx/JWZ@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/12/21 2:22 PM, Roman Gushchin wrote:
> On Fri, Apr 09, 2021 at 07:18:40PM -0400, Waiman Long wrote:
>> Before the new slab memory controller with per object byte charging,
>> charging and vmstat data update happen only when new slab pages are
>> allocated or freed. Now they are done with every kmem_cache_alloc()
>> and kmem_cache_free(). This causes additional overhead for workloads
>> that generate a lot of alloc and free calls.
>>
>> The memcg_stock_pcp is used to cache byte charge for a specific
>> obj_cgroup to reduce that overhead. To further reducing it, this patch
>> makes the vmstat data cached in the memcg_stock_pcp structure as well
>> until it accumulates a page size worth of update or when other cached
>> data change.
> The idea makes total sense to me and also gives a hope to remove
> byte-sized vmstats in the long-term.
>
>> On a 2-socket Cascade Lake server with instrumentation enabled and this
>> patch applied, it was found that about 17% (946796 out of 5515184) of the
>> time when __mod_obj_stock_state() is called leads to an actual call to
>> mod_objcg_state() after initial boot. When doing parallel kernel build,
>> the figure was about 16% (21894614 out of 139780628). So caching the
>> vmstat data reduces the number of calls to mod_objcg_state() by more
>> than 80%.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/memcontrol.c | 78 +++++++++++++++++++++++++++++++++++++++++++------
>>   mm/slab.h       | 26 +++++++----------
>>   2 files changed, 79 insertions(+), 25 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index b19100c68aa0..539c3b632e47 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2220,7 +2220,10 @@ struct memcg_stock_pcp {
>>   
>>   #ifdef CONFIG_MEMCG_KMEM
>>   	struct obj_cgroup *cached_objcg;
>> +	struct pglist_data *cached_pgdat;
>>   	unsigned int nr_bytes;
>> +	int vmstat_idx;
>> +	int vmstat_bytes;
>>   #endif
> Because vmstat_idx can realistically take only 3 values (slab_reclaimable,
> slab_unreclaimable and percpu), I wonder if it's better to have
> vmstat_bytes[3] and save a bit more on the reduced number of flushes?
> It must be an often case when a complex (reclaimable) kernel object has
> non-reclaimable parts (e.g. kmallocs) or percpu counters.
> If the difference will be too small, maybe the current form is better.

I have thought about that too. However, that will make the code more 
complex. So I decided to cache just one for now. We can certainly play 
around with caching more in a later patch.

Cheers,
Longman


