Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B84C373967
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 13:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhEELdL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 07:33:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:33976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232909AbhEELdK (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 5 May 2021 07:33:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7EB6B2BE;
        Wed,  5 May 2021 11:32:13 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] mm: memcg/slab: Properly set up gfp flags for
 objcg pointer array
To:     Shakeel Butt <shakeelb@google.com>, Waiman Long <llong@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
References: <20210504132350.4693-1-longman@redhat.com>
 <20210504132350.4693-2-longman@redhat.com>
 <CALvZod438=YKZtV0qckoaMkdL1seu5PiLnvPPQyRzA0S60-TpQ@mail.gmail.com>
 <267501a0-f416-4058-70d3-e32eeec3d6da@redhat.com>
 <CALvZod5gakHaAZfU2gH6QVNJRcX90MVSmqBpBSgCmF-Zhpz_vw@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b85f5b2b-cd5c-74ba-918b-f61ec0e540b0@suse.cz>
Date:   Wed, 5 May 2021 13:32:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CALvZod5gakHaAZfU2gH6QVNJRcX90MVSmqBpBSgCmF-Zhpz_vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/4/21 10:06 PM, Shakeel Butt wrote:
> On Tue, May 4, 2021 at 1:02 PM Waiman Long <llong@redhat.com> wrote:
>>
>> On 5/4/21 3:37 PM, Shakeel Butt wrote:
>> > On Tue, May 4, 2021 at 6:24 AM Waiman Long <longman@redhat.com> wrote:
>> >> Since the merging of the new slab memory controller in v5.9, the page
>> >> structure may store a pointer to obj_cgroup pointer array for slab pages.
>> >> Currently, only the __GFP_ACCOUNT bit is masked off. However, the array
>> >> is not readily reclaimable and doesn't need to come from the DMA buffer.
>> >> So those GFP bits should be masked off as well.
>> >>
>> >> Do the flag bit clearing at memcg_alloc_page_obj_cgroups() to make sure
>> >> that it is consistently applied no matter where it is called.
>> >>
>> >> Fixes: 286e04b8ed7a ("mm: memcg/slab: allocate obj_cgroups for non-root slab pages")
>> >> Signed-off-by: Waiman Long <longman@redhat.com>
>> >> ---
>> >>   mm/memcontrol.c | 8 ++++++++
>> >>   mm/slab.h       | 1 -
>> >>   2 files changed, 8 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> >> index c100265dc393..5e3b4f23b830 100644
>> >> --- a/mm/memcontrol.c
>> >> +++ b/mm/memcontrol.c
>> >> @@ -2863,6 +2863,13 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
>> >>   }
>> >>
>> >>   #ifdef CONFIG_MEMCG_KMEM
>> >> +/*
>> >> + * The allocated objcg pointers array is not accounted directly.
>> >> + * Moreover, it should not come from DMA buffer and is not readily
>> >> + * reclaimable. So those GFP bits should be masked off.
>> >> + */
>> >> +#define OBJCGS_CLEAR_MASK      (__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
>> > What about __GFP_DMA32? Does it matter? It seems like DMA32 requests
>> > go to normal caches.
>>
>> I included __GFP_DMA32 in my first draft patch. However, __GFP_DMA32 is
>> not considered in determining the right kmalloc_type() (patch 2), so I
>> took it out to make it consistent. I can certainly add it back.
>>
> 
> No this is fine and DMA32 question is unrelated to this patch series.

We never supported them in kmalloc(), only explicit caches with SLAB_CACHE_DMA32
flag.
