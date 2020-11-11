Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304672AF140
	for <lists+cgroups@lfdr.de>; Wed, 11 Nov 2020 13:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgKKMwI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Nov 2020 07:52:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:50864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgKKMwI (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 11 Nov 2020 07:52:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B415FABDE;
        Wed, 11 Nov 2020 12:52:05 +0000 (UTC)
Subject: Re: [PATCH v21 07/19] mm: page_idle_get_page() does not need lru_lock
To:     huang ying <huang.ying.caritas@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, Johannes Weiner <hannes@cmpxchg.org>,
        lkp@intel.com, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com,
        kernel test robot <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, shy828301@gmail.com,
        Minchan Kim <minchan@kernel.org>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
 <1604566549-62481-8-git-send-email-alex.shi@linux.alibaba.com>
 <CAC=cRTPYgD4qi=-dj=PY4804Y96k7fU065vLA8mNBmucZTnFSw@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d4ace896-a0d7-0d68-6c17-c86fc2abfb0f@suse.cz>
Date:   Wed, 11 Nov 2020 13:52:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAC=cRTPYgD4qi=-dj=PY4804Y96k7fU065vLA8mNBmucZTnFSw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/11/20 9:17 AM, huang ying wrote:
> On Thu, Nov 5, 2020 at 4:56 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>>
>> From: Hugh Dickins <hughd@google.com>
>>
>> It is necessary for page_idle_get_page() to recheck PageLRU() after
>> get_page_unless_zero(), but holding lru_lock around that serves no
>> useful purpose, and adds to lru_lock contention: delete it.
>>
>> See https://lore.kernel.org/lkml/20150504031722.GA2768@blaptop for the
>> discussion that led to lru_lock there; but __page_set_anon_rmap() now
>> uses WRITE_ONCE(), and I see no other risk in page_idle_clear_pte_refs()
>> using rmap_walk() (beyond the risk of racing PageAnon->PageKsm, mostly
>> but not entirely prevented by page_count() check in ksm.c's
>> write_protect_page(): that risk being shared with page_referenced() and
>> not helped by lru_lock).
>>
>> Signed-off-by: Hugh Dickins <hughd@google.com>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Alex Shi <alex.shi@linux.alibaba.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  mm/page_idle.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/mm/page_idle.c b/mm/page_idle.c
>> index 057c61df12db..64e5344a992c 100644
>> --- a/mm/page_idle.c
>> +++ b/mm/page_idle.c
>> @@ -32,19 +32,15 @@
>>  static struct page *page_idle_get_page(unsigned long pfn)
>>  {
>>         struct page *page = pfn_to_online_page(pfn);
>> -       pg_data_t *pgdat;
>>
>>         if (!page || !PageLRU(page) ||
>>             !get_page_unless_zero(page))
>>                 return NULL;
>>
>> -       pgdat = page_pgdat(page);
>> -       spin_lock_irq(&pgdat->lru_lock);
> 
> get_page_unless_zero() is a full memory barrier.  But do we need a
> compiler barrier here to prevent the compiler to cache PageLRU()
> results here?  Otherwise looks OK to me,

I think the compiler barrier is also implied by the full memory barrier and 
prevents the caching.

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> Acked-by: "Huang, Ying" <ying.huang@intel.com>
> 
> Best Regards,
> Huang, Ying
> 
>>         if (unlikely(!PageLRU(page))) {
>>                 put_page(page);
>>                 page = NULL;
>>         }
>> -       spin_unlock_irq(&pgdat->lru_lock);
>>         return page;
>>  }
>>
>> --
>> 1.8.3.1
>>
>>
> 

