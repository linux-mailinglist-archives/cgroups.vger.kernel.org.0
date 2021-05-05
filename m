Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDAE374803
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 20:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbhEESce (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 14:32:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23959 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234658AbhEEScd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 14:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620239495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iZZoApOePTacyMEHxFVuuuLNE5NT9++VAw5gEmX09no=;
        b=ilnuFycs6bStZQjDdmkK5zXPburUYFAfaVme3f/odPCOx7e3xrOCCs/7lee8XNxX4kEo3w
        8+TT9XxkekzgdlPi4irQjvsxY6gz1h61OF3sZlmKItvSqHRt3ZvXW5l358PnTO2IC51aJF
        zCozo36+ULii6eNpOdmi2t8b1aFlUUs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-mzIulYwJN2ORNUV4Oenn3g-1; Wed, 05 May 2021 14:31:31 -0400
X-MC-Unique: mzIulYwJN2ORNUV4Oenn3g-1
Received: by mail-qv1-f70.google.com with SMTP id b1-20020a0c9b010000b02901c4bcfbaa53so2303987qve.19
        for <cgroups@vger.kernel.org>; Wed, 05 May 2021 11:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iZZoApOePTacyMEHxFVuuuLNE5NT9++VAw5gEmX09no=;
        b=E1uanoCgaWS0SLE4wknZCa/xQS2xTqtbJNRy0DVPsuqZaqdDkhVhc0iJKlCnBe+WJY
         3IWBU6WBq4w9fSADz4SN1zGD0ZbNnmj/hn8ToQocEYXI6AiSQK7TTLgmIGTVIZXAD0BJ
         v9CpDALPxTqfkW6WUezJUySIFTOZg9HLekbdyxu7gtuhRRMagdAJ+JBXw1kZ0KkIpwtV
         QExb6ZE2HKMdbICv2S4ReVD4VWruUZ6t1lsUNkp0xgcsDzHEwEYvNPH3B7xIcP4QjOOg
         8aRtIfvtEAqzriYETZNpoyPB5ugYLiBuJay38zAoBm2JQkR11vbOhI9vhfpehT9+XB+f
         S5dw==
X-Gm-Message-State: AOAM531YJrz0cVBp/c1+dMkDJ/uyUi7NY3MfEcUfJ3ruyqAUyOnPi3yJ
        EgNpsgiGfIjHItSj2VweEpGMQnC5QsN8zL9aMYohYSg1+DlhUJFRLJH4QQs7faC+b2MS+ZUQ2Ft
        okrc+ni5TVdPJXHJBrQ==
X-Received: by 2002:ac8:7b4b:: with SMTP id m11mr25472613qtu.354.1620239491473;
        Wed, 05 May 2021 11:31:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3Vgrw+Obvg37H8gXeV4VtntcL6XTn6AldJFseCTJC3EWm+0xAcC/5uqwBEOES5ueZAeNNDQ==
X-Received: by 2002:ac8:7b4b:: with SMTP id m11mr25472588qtu.354.1620239491305;
        Wed, 05 May 2021 11:31:31 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id h7sm25955qtr.50.2021.05.05.11.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 11:31:30 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 2/2] mm: memcg/slab: Create a new set of kmalloc-cg-<n>
 caches
To:     Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210505154613.17214-1-longman@redhat.com>
 <20210505154613.17214-3-longman@redhat.com>
 <YJLWN6bNBYyKRPEN@carbon.DHCP.thefacebook.com>
 <235f45b4-2d99-f32d-ac2b-18b59fea5a25@suse.cz>
Message-ID: <4e4b6903-2444-f4ed-f589-26d5beae3120@redhat.com>
Date:   Wed, 5 May 2021 14:31:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <235f45b4-2d99-f32d-ac2b-18b59fea5a25@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/5/21 2:02 PM, Vlastimil Babka wrote:
> On 5/5/21 7:30 PM, Roman Gushchin wrote:
>> On Wed, May 05, 2021 at 11:46:13AM -0400, Waiman Long wrote:
>>> With this change, all the objcg pointer array objects will come from
>>> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
>>> both the recursive kfree() problem and non-freeable slab problem are
>>> gone. Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer
>>> have mixed accounted and unaccounted objects, this will slightly reduce
>>> the number of objcg pointer arrays that need to be allocated and save
>>> a bit of memory.
>> Unfortunately the positive effect of this change will be likely
>> reversed by a lower utilization due to a larger number of caches.
>>
>> Btw, I wonder if we also need a change in the slab caches merging procedure?
>> KMALLOC_NORMAL caches should not be merged with caches which can potentially
>> include accounted objects.
> Good point. But looks like kmalloc* caches are extempt from all merging in
> create_boot_cache() via
>
> 	s->refcount = -1;       /* Exempt from merging for now */
>
> It wouldn't hurt though to create the kmalloc-cg-* caches with SLAB_ACCOUNT flag
> to prevent accidental merging in case the above is ever removed. It would also
> better reflect reality, and ensure that the array is allocated immediately with
> the page, AFAICS.
>
I am not sure if this is really true.

struct kmem_cache *__init create_kmalloc_cache(const char *name,
                 unsigned int size, slab_flags_t flags,
                 unsigned int useroffset, unsigned int usersize)
{
         struct kmem_cache *s = kmem_cache_zalloc(kmem_cache, GFP_NOWAIT);

         if (!s)
                 panic("Out of memory when creating slab %s\n", name);

         create_boot_cache(s, name, size, flags, useroffset, usersize);
         kasan_cache_create_kmalloc(s);
         list_add(&s->list, &slab_caches);
         s->refcount = 1;
         return s;
}

Even though refcount is set to -1 initially, it is set back to 1 
afterward. So merging can still happen AFAICS.

Cheers,
Longman

