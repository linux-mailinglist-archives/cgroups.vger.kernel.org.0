Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AC72432F7
	for <lists+cgroups@lfdr.de>; Thu, 13 Aug 2020 05:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHMDxQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Aug 2020 23:53:16 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:37965 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726334AbgHMDxQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Aug 2020 23:53:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U5c8daw_1597290787;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U5c8daw_1597290787)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Aug 2020 11:53:08 +0800
Subject: Re: [PATCH v17 14/21] mm/compaction: do page isolation first in
 compaction
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-15-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UcbBv=QBK9ErqLKXoNLYxFz52L4fiiHy4h6zKdBs=YPOg@mail.gmail.com>
 <241ca157-104f-4f0d-7d5b-de394443788d@linux.alibaba.com>
 <CAKgT0UdSrarC8j+G=LYRSadcaG6yNCoCfeVpFjEiHRJb4A77-g@mail.gmail.com>
 <8dbd004e-8eba-f1ec-a5eb-5dc551978936@linux.alibaba.com>
 <CAKgT0UdK-fy+yYGLFK=YgE+maa_0_uecq0_8S_0kM8BiVgRO7g@mail.gmail.com>
 <d9818e06-95f1-9f21-05c0-98f29ea96d89@linux.alibaba.com>
 <CAKgT0Ues0ShkSbb1XtA7z7EYB8NCPgLGq8zZUjrXK_jcWn8mDQ@mail.gmail.com>
 <9581db48-cef3-788a-7f5a-8548fee56c13@linux.alibaba.com>
 <CAKgT0UeuuQqpYRXXAs_YurWyDOtqx4y3sx7e4Xi2TE6s_7++Fg@mail.gmail.com>
 <3828d045-17e4-16aa-f0e6-d5dda7ad6b1b@linux.alibaba.com>
 <CAKgT0Ud6ZQ4ZTm1cAUKCdb8FMu0fk9vXgf-bnmb0aY5ndDHwyA@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <3d224c35-a53d-3daa-4c76-026d1f2b2656@linux.alibaba.com>
Date:   Thu, 13 Aug 2020 11:52:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0Ud6ZQ4ZTm1cAUKCdb8FMu0fk9vXgf-bnmb0aY5ndDHwyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/13 上午10:17, Alexander Duyck 写道:
>> zone lock is probability better. you can try and test.
> So I spent a good chunk of today looking the code over and what I
> realized is that we probably don't even really need to have this code
> protected by the zone lock since the LRU bit in the pageblock should
> do most of the work for us. In addition we can get rid of the test
> portion of this and just make it a set only operation if I am not
> mistaken.
> 
>>>>> the LRU flag is cleared then you are creating a situation where
>>>>> multiple processes will be stomping all over each other as you can
>>>>> have each thread essentially take a page via the LRU flag, but only
>>>>> one thread will process a page and it could skip over all other pages
>>>>> that preemptively had their LRU flag cleared.
>>>> It increase a bit crowd here, but lru_lock do reduce some them, and skip_bit
>>>> could stop each other in a array check(bitmap). So compare to whole node
>>>> lru_lock, the net profit is clear in patch 17.
>>> My concern is that what you can end up with is multiple threads all
>>> working over the same pageblock for isolation. With the old code the
>>> LRU lock was used to make certain that test_and_set_skip was being
>>> synchronized on the first page in the pageblock so you would only have
>>> one thread going through and working a single pageblock. However after
>>> your changes it doesn't seem like the test_and_set_skip has that
>>> protection since only one thread will ever be able to successfully
>>> call it for the first page in the pageblock assuming that the LRU flag
>>> is set on the first page in the pageblock block.
>>>
>>>>> If you take a look at the test_and_set_skip the function only acts on
>>>>> the pageblock aligned PFN for a given range. WIth the changes you have
>>>>> in place now that would mean that only one thread would ever actually
>>>>> call this function anyway since the first PFN would take the LRU flag
>>>>> so no other thread could follow through and test or set the bit as
>>>> Is this good for only one process could do test_and_set_skip? is that
>>>> the 'skip' meaning to be?
>>> So only one thread really getting to fully use test_and_set_skip is
>>> good, however the issue is that there is nothing to synchronize the
>>> testing from the other threads. As a result the other threads could
>>> have isolated other pages within the pageblock before the thread that
>>> is calling test_and_set_skip will get to complete the setting of the
>>> skip bit. This will result in isolation failures for the thread that
>>> set the skip bit which may be undesirable behavior.
>>>
>>> With the old code the threads were all synchronized on testing the
>>> first PFN in the pageblock while holding the LRU lock and that is what
>>> we lost. My concern is the cases where skip_on_failure == true are
>>> going to fail much more often now as the threads can easily interfere
>>> with each other.
>> I have a patch to fix this, which is on
>>         https://github.com/alexshi/linux.git lrunext
> I don't think that patch helps to address anything. You are now
> failing to set the bit in the case that something modifies the
> pageblock flags while you are attempting to do so. I think it would be
> better to just leave the cmpxchg loop as it is.

It do increae the case-lru-file-mmap-read in vm-scalibity about 3% performance.
Yes, I am glad to see it can be make better.


> 
>>>>> well. The expectation before was that all threads would encounter this
>>>>> test and either proceed after setting the bit for the first PFN or
>>>>> abort after testing the first PFN. With you changes only the first
>>>>> thread actually runs this test and then it and the others will likely
>>>>> encounter multiple failures as they are all clearing LRU bits
>>>>> simultaneously and tripping each other up. That is why the skip bit
>>>>> must have a test and set done before you even get to the point of
>>>>> clearing the LRU flag.
>>>> It make the things warse in my machine, would you like to have a try by yourself?
>>> I plan to do that. I have already been working on a few things to
>>> clean up and optimize your patch set further. I will try to submit an
>>> RFC this evening so we can discuss.
>>>
>> Glad to see your new code soon. Would you like do it base on
>>                 https://github.com/alexshi/linux.git lrunext
> I can rebase off of that tree. It may add another half hour or so. I
> have barely had any time to test my code. When I enabled some of the
> debugging features in the kernel related to using the vm-scalability
> tests the boot time became incredibly slow so I may just make certain
> I can boot and not mess the system up before submitting my patches as
> an RFC. I can probably try testing them more tomorrow.
> 
>>>>>>> The point I was getting at with the PageCompound check is that instead
>>>>>>> of needing the LRU lock you should be able to look at PageCompound as
>>>>>>> soon as you call get_page_unless_zero() and preempt the need to set
>>>>>>> the LRU bit again. Instead of trying to rely on the LRU lock to
>>>>>>> guarantee that the page hasn't been merged you could just rely on the
>>>>>>> fact that you are holding a reference to it so it isn't going to
>>>>>>> switch between being compound or order 0 since it cannot be freed. It
>>>>>>> spoils the idea I originally had of combining the logic for
>>>>>>> get_page_unless_zero and TestClearPageLRU into a single function, but
>>>>>>> the advantage is you aren't clearing the LRU flag unless you are
>>>>>>> actually going to pull the page from the LRU list.
>>>>>> Sorry, I still can not follow you here. Compound code part is unchanged
>>>>>> and follow the original logical. So would you like to pose a new code to
>>>>>> see if its works?
>>>>> No there are significant changes as you reordered all of the
>>>>> operations. Prior to your change the LRU bit was checked, but not
>>>>> cleared before testing for PageCompound. Now you are clearing it
>>>>> before you are testing if it is a compound page. So if compaction is
>>>>> running we will be seeing the pages in the LRU stay put, but the
>>>>> compound bit flickering off and on if the compound page is encountered
>>>>> with the wrong or NULL lruvec. What I was suggesting is that the
>>>> The lruvec could be wrong or NULL here, that is the base stone of whole
>>>> patchset.
>>> Sorry I had a typo in my comment as well as it is the LRU bit that
>>> will be flickering, not the compound. The goal here is to avoid
>>> clearing the LRU bit unless we are sure we are going to take the
>>> lruvec lock and pull the page from the list.
>>>
>>>>> PageCompound test probably doesn't need to be concerned with the lock
>>>>> after your changes. You could test it after you call
>>>>> get_page_unless_zero() and before you call
>>>>> __isolate_lru_page_prepare(). Instead of relying on the LRU lock to
>>>>> protect us from the page switching between compound and not we would
>>>>> be relying on the fact that we are holding a reference to the page so
>>>>> it should not be freed and transition between compound or not.
>>>>>
>>>> I have tried the patch as your suggested, it has no clear help on performance
>>>> on above vm-scaliblity case. Maybe it's due to we checked the same thing
>>>> before lock already.
>>>>
>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>> index b99c96c4862d..cf2ac5148001 100644
>>>> --- a/mm/compaction.c
>>>> +++ b/mm/compaction.c
>>>> @@ -985,6 +985,16 @@ static bool too_many_isolated(pg_data_t *pgdat)
>>>>                 if (unlikely(!get_page_unless_zero(page)))
>>>>                         goto isolate_fail;
>>>>
>>>> +                       /*
>>>> +                        * Page become compound since the non-locked check,
>>>> +                        * and it's on LRU. It can only be a THP so the order
>>>> +                        * is safe to read and it's 0 for tail pages.
>>>> +                        */
>>>> +                       if (unlikely(PageCompound(page) && !cc->alloc_contig)) {
>>>> +                               low_pfn += compound_nr(page) - 1;
>>>> +                               goto isolate_fail_put;
>>>> +                       }
>>>> +
>>>>                 if (__isolate_lru_page_prepare(page, isolate_mode) != 0)
>>>>                         goto isolate_fail_put;
>>>>
>>>> @@ -1013,16 +1023,6 @@ static bool too_many_isolated(pg_data_t *pgdat)
>>>>                                         goto isolate_abort;
>>>>                         }
>>>>
>>>> -                       /*
>>>> -                        * Page become compound since the non-locked check,
>>>> -                        * and it's on LRU. It can only be a THP so the order
>>>> -                        * is safe to read and it's 0 for tail pages.
>>>> -                        */
>>>> -                       if (unlikely(PageCompound(page) && !cc->alloc_contig)) {
>>>> -                               low_pfn += compound_nr(page) - 1;
>>>> -                               SetPageLRU(page);
>>>> -                               goto isolate_fail_put;
>>>> -                       }
>>>>                 } else
>>>>                         rcu_read_unlock();
>>>>
>>> So actually there is more we could do than just this. Specifically a
>>> few lines below the rcu_read_lock there is yet another PageCompound
>>> check that sets low_pfn yet again. So in theory we could combine both
>>> of those and modify the code so you end up with something more like:
>>> @@ -968,6 +974,16 @@ isolate_migratepages_block(struct compact_control
>>> *cc, unsigned long low_pfn,
>>>                 if (unlikely(!get_page_unless_zero(page)))
>>>                         goto isolate_fail;
>>>
>>> +               if (PageCompound(page)) {
>>> +                       const unsigned int order = compound_order(page);
>>> +
>>> +                       if (likely(order < MAX_ORDER))
>>> +                               low_pfn += (1UL << order) - 1;
>>> +
>>> +                       if (unlikely(!cc->alloc_contig))
>>> +                               goto isolate_fail_put;
>>>
>> The current don't check this unless locked changed. But anyway check it
>> every page may have no performance impact.
> Yes and no. The same code is also ran outside the lock and that is why
> I suggested merging the two and creating this block of logic. It will
> be clearer once I have done some initial smoke testing and submitted
> my patch.
> 
>> +               }
>>> +
>>>                 if (__isolate_lru_page_prepare(page, isolate_mode) != 0)
>>>                         goto isolate_fail_put;
>>>
>>> Doing this you would be more likely to skip over the entire compound
>>> page in a single jump should you not be able to either take the LRU
>>> bit or encounter a busy page in __isolate_Lru_page_prepare. I had
>>> copied this bit from an earlier check and modified it as I was not
>>> sure I can guarantee that this is a THP since we haven't taken the LRU
>>> lock yet. However I believe the page cannot be split up while we are
>>> holding the extra reference so the PageCompound flag and order should
>>> not change until we call put_page.
>>>
>> It looks like the lock_page protect this instead of get_page that just works
>> after split func called.
> So I thought that the call to page_ref_freeze that is used in
> functions like split_huge_page_to_list is meant to address this case.
> What it is essentially doing is setting the reference count to zero if
> the count is at the expected value. So with the get_page_unless_zero
> it would either fail because the value is already zero, or the
> page_ref_freeze would fail because the count would be one higher than
> the expected value. Either that or I am still missing another piece in
> the understanding of this.

Uh, the front xa_lock or anon_vma lock guard the -refcount, so long locking path...

Thanks
Alex
