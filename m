Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1E1376A23
	for <lists+cgroups@lfdr.de>; Fri,  7 May 2021 20:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhEGSq4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 May 2021 14:46:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39711 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229476AbhEGSq4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 May 2021 14:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620413155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aPyyKeBrRkA4WE3QwL0dVJXd+S/rMEeW0hm96iAtu2c=;
        b=gFun/DhjEmkdhc/B1Dg2kgagl0hbv3uEO4xI/MDTNvH3fAyWbYr4+HoIGVujfQt8HUtn6m
        SX4ZEmSOatPQLjEcd+mVQctHs4wYn0Py9n1PbveM+FAAw+CH4CAN3c1za0WfaQVp4E5VFE
        9Q5Mt1oFXoGGq4FF/T2ZRjmoElmssik=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-hRkCPv8vPNSLq0hQF8FfeA-1; Fri, 07 May 2021 14:45:54 -0400
X-MC-Unique: hRkCPv8vPNSLq0hQF8FfeA-1
Received: by mail-qv1-f69.google.com with SMTP id 99-20020a0c80ec0000b029017de514d56fso7262590qvb.17
        for <cgroups@vger.kernel.org>; Fri, 07 May 2021 11:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aPyyKeBrRkA4WE3QwL0dVJXd+S/rMEeW0hm96iAtu2c=;
        b=F1CYa82/fa6UrdHPuAfPvuXMVZhEpYKjbjAub833yPArb4yN3ZgFyO8f+R0/kMmgM6
         x+8m5pZ9gxkzQxJISSTO16hXcKxNNY3iISItQJPioFrv1SZm/niP3i0XuIe12TSQwi8N
         OkzGkdBcX+YdtR0yg12G/cZFwlCr5Rj8p5mkrD1QSwi/EyinKC8vqB65jNe/6AtjC3vD
         P1agaDQw6XgicDdPL9hMCWaZcERAa7SRQvgmrW/vS7LC+13d/MBiUqUu4DEMQhN3pEfP
         WTkuCnweef6CbvMm6FR6eSKNletuSR9vGsdxjmVMLb+WHRevQ+QUbQdX+Db5w6SetQwm
         9Bbg==
X-Gm-Message-State: AOAM532pWdlN2hSfmh3+tOcRJ61G2PeLHEBg82Kf2mPqsW6Wc6ucDUaz
        0RLFr52jxhw4lXq8WMFc3lsWB8G3S7yVHtY93PjC15grdgHtsBeIctSXyAgb0FcTXWose57ZHAn
        YuNMD1mJrhnsJgO2ECg==
X-Received: by 2002:a37:ae02:: with SMTP id x2mr10946077qke.335.1620413151342;
        Fri, 07 May 2021 11:45:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQ49EhrBr2VleaOQs5O+9EB+F+312dF6kA9HU6bvLJ0TwDuEEYlFpnBnivl0VUz4k5rpNUrA==
X-Received: by 2002:a37:ae02:: with SMTP id x2mr10946050qke.335.1620413151104;
        Fri, 07 May 2021 11:45:51 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id x13sm5553045qtf.32.2021.05.07.11.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 11:45:50 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 2/3] mm: memcg/slab: Create a new set of kmalloc-cg-<n>
 caches
To:     Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210505200610.13943-1-longman@redhat.com>
 <20210505200610.13943-3-longman@redhat.com>
 <3344a04c-0cff-b997-f357-2ffc8e3de242@suse.cz>
Message-ID: <d1fb7f38-1a4e-5819-6ccb-691346c7b2a1@redhat.com>
Date:   Fri, 7 May 2021 14:45:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <3344a04c-0cff-b997-f357-2ffc8e3de242@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/6/21 12:00 PM, Vlastimil Babka wrote:
> On 5/5/21 10:06 PM, Waiman Long wrote:
>> There are currently two problems in the way the objcg pointer array
>> (memcg_data) in the page structure is being allocated and freed.
>>
>> On its allocation, it is possible that the allocated objcg pointer
>> array comes from the same slab that requires memory accounting. If this
>> happens, the slab will never become empty again as there is at least
>> one object left (the obj_cgroup array) in the slab.
>>
>> When it is freed, the objcg pointer array object may be the last one
>> in its slab and hence causes kfree() to be called again. With the
>> right workload, the slab cache may be set up in a way that allows the
>> recursive kfree() calling loop to nest deep enough to cause a kernel
>> stack overflow and panic the system.
>>
>> One way to solve this problem is to split the kmalloc-<n> caches
>> (KMALLOC_NORMAL) into two separate sets - a new set of kmalloc-<n>
>> (KMALLOC_NORMAL) caches for unaccounted objects only and a new set of
>> kmalloc-cg-<n> (KMALLOC_CGROUP) caches for accounted objects only. All
>> the other caches can still allow a mix of accounted and unaccounted
>> objects.
>>
>> With this change, all the objcg pointer array objects will come from
>> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
>> both the recursive kfree() problem and non-freeable slab problem are
>> gone.
>>
>> Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer have
>> mixed accounted and unaccounted objects, this will slightly reduce the
>> number of objcg pointer arrays that need to be allocated and save a bit
>> of memory. On the other hand, creating a new set of kmalloc caches does
>> have the effect of reducing cache utilization. So it is properly a wash.
>>
>> The new KMALLOC_CGROUP is added between KMALLOC_NORMAL and
>> KMALLOC_RECLAIM so that the first for loop in create_kmalloc_caches()
>> will include the newly added caches without change.
>>
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> I still believe the cgroup.memory=nokmem parameter should be respected,
> otherwise the caches are not only created, but also used. I offer this followup
> for squashing into your patch if you and Andrew agree:
>
> ----8<----
>  From c87378d437d9a59b8757033485431b4721c74173 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Thu, 6 May 2021 17:53:21 +0200
> Subject: [PATCH] mm: memcg/slab: don't create kmalloc-cg caches with
>   cgroup.memory=nokmem
>
> The caches should not be created when kmemcg is disabled on boot, otherwise
> they are also filled by kmalloc(__GFP_ACCOUNT) allocations. When booted with
> cgroup.memory=nokmem, link the kmalloc_caches[KMALLOC_CGROUP] entries to
> KMALLOC_NORMAL entries instead.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>   mm/internal.h    | 5 +++++
>   mm/memcontrol.c  | 2 +-
>   mm/slab_common.c | 9 +++++++--
>   3 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index ef5f336f59bd..b2d60b3403c7 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -135,6 +135,11 @@ extern void putback_lru_page(struct page *page);
>    */
>   extern pmd_t *mm_find_pmd(struct mm_struct *mm, unsigned long address);
>   
> +/*
> + * in mm/memcontrol.c:
> + */
> +extern bool cgroup_memory_nokmem;
> +
>   /*
>    * in mm/page_alloc.c
>    */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5e3b4f23b830..b9ec01f2b4f6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -83,7 +83,7 @@ DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
>   static bool cgroup_memory_nosocket;
>   
>   /* Kernel memory accounting disabled? */
> -static bool cgroup_memory_nokmem;
> +bool cgroup_memory_nokmem;
>   
>   /* Whether the swap controller is active */
>   #ifdef CONFIG_MEMCG_SWAP
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index bbaf41a7c77e..363f90215401 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -832,10 +832,15 @@ void __init setup_kmalloc_cache_index_table(void)
>   static void __init
>   new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>   {
> -	if (type == KMALLOC_RECLAIM)
> +	if (type == KMALLOC_RECLAIM) {
>   		flags |= SLAB_RECLAIM_ACCOUNT;
> -	else if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_CGROUP))
> +	} else if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_CGROUP)) {
> +		if (cgroup_memory_nokmem) {
> +			kmalloc_caches[type][idx] = kmalloc_caches[KMALLOC_NORMAL][idx];
> +			return;
> +		}
>   		flags |= SLAB_ACCOUNT;
> +	}
>   
>   	kmalloc_caches[type][idx] = create_kmalloc_cache(
>   					kmalloc_info[idx].name[type],

Thanks, the patch looks good to me.

Acked-by: Waiman Long <longman@redhat.com>

Cheers,
Longman

