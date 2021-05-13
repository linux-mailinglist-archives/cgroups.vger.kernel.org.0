Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BCF37F447
	for <lists+cgroups@lfdr.de>; Thu, 13 May 2021 10:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhEMIlZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 May 2021 04:41:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:41568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231926AbhEMIlU (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 13 May 2021 04:41:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AC22DAD1B;
        Thu, 13 May 2021 08:40:09 +0000 (UTC)
Subject: Re: [PATCH v5 2/3] mm: memcg/slab: Create a new set of kmalloc-cg-<n>
 caches
To:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <llong@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210505200610.13943-1-longman@redhat.com>
 <20210512145107.6208-1-longman@redhat.com>
 <0919aaab-cc08-f86d-1f9a-8ddfeed7bb31@redhat.com>
 <20210512173212.738f592c36bf0e4c205f628e@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <40fd10f4-b011-605a-9c0b-6d7ce17837f9@suse.cz>
Date:   Thu, 13 May 2021 10:40:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210512173212.738f592c36bf0e4c205f628e@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/13/21 2:32 AM, Andrew Morton wrote:
> On Wed, 12 May 2021 10:54:19 -0400 Waiman Long <llong@redhat.com> wrote:
> 
>> >   include/linux/slab.h | 42 +++++++++++++++++++++++++++++++++---------
>> >   mm/slab_common.c     | 25 +++++++++++++++++--------
>> >   2 files changed, 50 insertions(+), 17 deletions(-)
>> 
>> The following are the diff's from previous version. It turns out that 
>> the previous patch doesn't work if CONFIG_ZONE_DMA isn't defined.
>> 
>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>> index a51cad5f561c..aa7f6c222a60 100644
>> --- a/include/linux/slab.h
>> +++ b/include/linux/slab.h
>> @@ -312,16 +312,17 @@ static inline void __check_heap_object(const void 
>> *ptr, un
>> signed long n,
>>    */
>>   enum kmalloc_cache_type {
>>       KMALLOC_NORMAL = 0,
>> -#ifdef CONFIG_MEMCG_KMEM
>> -    KMALLOC_CGROUP,
>> -#else
>> +#ifndef CONFIG_ZONE_DMA
>> +    KMALLOC_DMA = KMALLOC_NORMAL,
>> +#endif
>> +#ifndef CONFIG_MEMCG_KMEM
>>       KMALLOC_CGROUP = KMALLOC_NORMAL,
>> +#else
>> +    KMALLOC_CGROUP,
>>   #endif
>>       KMALLOC_RECLAIM,
>>   #ifdef CONFIG_ZONE_DMA
>>       KMALLOC_DMA,
>> -#else
>> -    KMALLOC_DMA = KMALLOC_NORMAL,
>>   #endif
>>       NR_KMALLOC_TYPES
>>   };
> 
> I assume this fixes
> https://lkml.kernel.org/r/20210512152806.2492ca42@canb.auug.org.au?

Yeah it should.
