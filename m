Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA31374838
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 20:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhEESzD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 14:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33675 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229821AbhEESzB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 14:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620240844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xzcUJiTSMQjqP53U/sK3VcFgjGCdL+Yqx50eNS1EYWE=;
        b=DoI2R8UovkmriXKAHZApMNuFjaaQLCsVAY5Do/ue4nasJdIYhDig01oKYmQUk9Ztm3l+Fr
        VV1HVOQW1Z0oW97CaMSGNtDAL9sr73vgA7TUi5fqCS4OL2KCMKqlEl8d0uMbZ3OrC7OWMY
        zhZKxU8IrwyzpoJ8Jh++c58pACYrTNY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-mtsVVsOQPgeb-Fivstf6Ig-1; Wed, 05 May 2021 14:54:02 -0400
X-MC-Unique: mtsVVsOQPgeb-Fivstf6Ig-1
Received: by mail-qv1-f70.google.com with SMTP id o6-20020a0ccb060000b02901c0933b76e1so2384658qvk.8
        for <cgroups@vger.kernel.org>; Wed, 05 May 2021 11:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xzcUJiTSMQjqP53U/sK3VcFgjGCdL+Yqx50eNS1EYWE=;
        b=an+6TqouB7QOkMreuMGjS60/LJR1AFlywQygXJgCulk889egdzlWFS/IuodJkZhcin
         Ie/nwN3rc5ZBq9hSe2wW20qmWE8DkYoIJP+f7EX61wo8PqhAvAHv6d7QArsSL6gBrj9d
         Ofedp9UqpM4vEyISDjzzDiFtYIIJkn+MZG7E+eZY2b5b+LNxOuXqIUJ59VdR3aWdlsBF
         YWGPG+sx10HxNEBlystTLcNR6gbnsMT3niKbRfYvfzNbLUi/YrC52Yp1TRHmgTBtjTkE
         s7Auo8lwMAb73iK+6Uo//tmDKc/ddQrRZ/w+Ll1p5Axk4RlsZC5cQDmWfhLHJaNH/LPv
         m2QA==
X-Gm-Message-State: AOAM530axhwBTGeBXU35yHM9+HEVLVO4AQuOXkZdei51oA++ToNcDzby
        46UN1QTy9GPjoc1Q5daBGqjfThTi29ttjvtQNfzT4p3KDYaCkrRnijd2+Ucsrul80/UBZucEHYO
        stAu8cf8XsMwzpESIrQ==
X-Received: by 2002:ac8:5913:: with SMTP id 19mr28709916qty.391.1620240842521;
        Wed, 05 May 2021 11:54:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxO9L95zKwtf/j36yscG23peB8+9h3FxtVHS9v2zg95NN6AFM2hHQYZwFdzzRPV5GbCvpEyEQ==
X-Received: by 2002:ac8:5913:: with SMTP id 19mr28709906qty.391.1620240842344;
        Wed, 05 May 2021 11:54:02 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id f7sm93995qtm.41.2021.05.05.11.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 11:54:01 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 2/2] mm: memcg/slab: Create a new set of kmalloc-cg-<n>
 caches
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210505154613.17214-1-longman@redhat.com>
 <20210505154613.17214-3-longman@redhat.com>
 <YJLWN6bNBYyKRPEN@carbon.DHCP.thefacebook.com>
 <f14a263b-10ea-ef2b-eefa-066591a4b637@redhat.com>
Message-ID: <5d1683d2-1023-1d1c-91e7-b68549debe1d@redhat.com>
Date:   Wed, 5 May 2021 14:54:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <f14a263b-10ea-ef2b-eefa-066591a4b637@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/5/21 2:11 PM, Waiman Long wrote:
> On 5/5/21 1:30 PM, Roman Gushchin wrote:
>
>>
>> Btw, I wonder if we also need a change in the slab caches merging 
>> procedure?
>> KMALLOC_NORMAL caches should not be merged with caches which can 
>> potentially
>> include accounted objects.
>
> Thank for catching this omission.
>
> I will take a look and modify the merging procedure in a new patch. 
> Accounting is usually specified at kmem_cache_create() time. Though, I 
> did find one instance of setting ACCOUNT flag in kmem_cache_alloc(), I 
> will ignore this case and merge accounted, but unreclaimable caches to 
> KMALLOC_CGROUP. 

In mm/slab_common.c:

#define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
                          SLAB_CACHE_DMA32 | SLAB_ACCOUNT)

struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
   :
                 if ((flags & SLAB_MERGE_SAME) != (s->flags & 
SLAB_MERGE_SAME))
                         continue;

By making sure kmalloc-cg-* has SLAB_ACCOUNT bit set, a kmemcache 
created with with SLAB_ACCOUNT may merge with kmalloc-cg-* whereas one 
without SLAB_ACCOUNT may merge with kmalloc-* for now. So the current 
code should work fine for most cases. Though, if the ACCOUNT flag is set 
at kmem_cache_alloc() and the cache happens to be merged into kmalloc-*, 
we will have the rare case that an objcg pointer array may have to be 
added to a kmalloc-* cache. However, this is not a common practice, and 
the three cases (not one, sorry) that I found so far is in

arch/x86/kvm/x86.c:     ctxt = kmem_cache_zalloc(x86_emulator_cache, 
GFP_KERNEL_ACCOUNT);
fs/hostfs/hostfs_kern.c:        hi = 
kmem_cache_alloc(hostfs_inode_cache, GFP_KERNEL_ACCOUNT);
virt/kvm/kvm_main.c:    vcpu = kmem_cache_zalloc(kvm_vcpu_cache, 
GFP_KERNEL_ACCOUNT);

We will have to advise against doing that.

Cheers,
Longman


