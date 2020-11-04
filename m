Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD522A6342
	for <lists+cgroups@lfdr.de>; Wed,  4 Nov 2020 12:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgKDL1h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Nov 2020 06:27:37 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:34260 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728287AbgKDL1h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Nov 2020 06:27:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0UECBM9f_1604489241;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UECBM9f_1604489241)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Nov 2020 19:27:22 +0800
Subject: Re: [PATCH v20 08/20] mm: page_idle_get_page() does not need lru_lock
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-9-git-send-email-alex.shi@linux.alibaba.com>
 <20201102144110.GB724984@cmpxchg.org>
 <20201102144927.GN27442@casper.infradead.org>
 <20201102202003.GA740958@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <b4038b87-cf5a-fcb7-06f4-b98874029615@linux.alibaba.com>
Date:   Wed, 4 Nov 2020 19:27:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201102202003.GA740958@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/11/3 ÉÏÎç4:20, Johannes Weiner Ð´µÀ:
> On Mon, Nov 02, 2020 at 02:49:27PM +0000, Matthew Wilcox wrote:
>> On Mon, Nov 02, 2020 at 09:41:10AM -0500, Johannes Weiner wrote:
>>> On Thu, Oct 29, 2020 at 06:44:53PM +0800, Alex Shi wrote:
>>>> From: Hugh Dickins <hughd@google.com>
>>>>
>>>> It is necessary for page_idle_get_page() to recheck PageLRU() after
>>>> get_page_unless_zero(), but holding lru_lock around that serves no
>>>> useful purpose, and adds to lru_lock contention: delete it.
>>>>
>>>> See https://lore.kernel.org/lkml/20150504031722.GA2768@blaptop for the
>>>> discussion that led to lru_lock there; but __page_set_anon_rmap() now
>>>> uses WRITE_ONCE(),
>>>
>>> That doesn't seem to be the case in Linus's or Andrew's tree. Am I
>>> missing a dependent patch series?
>>>
>>>> and I see no other risk in page_idle_clear_pte_refs() using
>>>> rmap_walk() (beyond the risk of racing PageAnon->PageKsm, mostly but
>>>> not entirely prevented by page_count() check in ksm.c's
>>>> write_protect_page(): that risk being shared with page_referenced()
>>>> and not helped by lru_lock).
>>>
>>> Isn't it possible, as per Minchan's description, for page->mapping to
>>> point to a struct anon_vma without PAGE_MAPPING_ANON set, and rmap
>>> thinking it's looking at a struct address_space?
>>
>> I don't think it can point to an anon_vma without the ANON bit set.
>> Minchan's concern in that email was that it might still be NULL.
> 
> Hm, no, the thread is a lengthy discussion about whether the store
> could be split such that page->mapping is actually pointing to
> something invalid (anon_vma without the PageAnon bit).
> 
> From his email:
> 
>         CPU 0                                                                           CPU 1
> 
> do_anonymous_page
>   __page_set_anon_rmap
>   /* out of order happened so SetPageLRU is done ahead */
>   SetPageLRU(page)

This SetPageLRU done in __pagevec_lru_add_fn() which under the lru_lock
protection, so the original memory barrier or lock concern isn't
correct. that means, the SetPageLRU isn't possible to be here.
And then no warry on right side 'CPU 1' problem.

>   /* Compilr changed store operation like below */
>   page->mapping = (struct address_space *) anon_vma;
>   /* Big stall happens */
>                                                                 /* idletacking judged it as LRU page so pass the page
>                                                                    in page_reference */
>                                                                 page_refernced
								  page_referenced should be page_idle_clear_pte_refs_one here?	
>                                                                         page_rmapping return true because
>                                                                         page->mapping has some vaule but not complete
>                                                                         so it calls rmap_walk_file.
>                                                                         it's okay to pass non-completed anon page in rmap_walk_file?
> 


For this patch, According to comments of page_idle_get_page() 
PageLRU just used to judge if the page is in user using. for this
purpose, a unguard PageLRU check is good enough. So this patch
should be fine.

Thanks
Alex
