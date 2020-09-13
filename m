Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A72267FC1
	for <lists+cgroups@lfdr.de>; Sun, 13 Sep 2020 16:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgIMOXM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 13 Sep 2020 10:23:12 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:37163 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbgIMOXK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 13 Sep 2020 10:23:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0U8mvfri_1600006975;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U8mvfri_1600006975)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 13 Sep 2020 22:22:57 +0800
Subject: Re: [PATCH v18 00/32] per memcg lru_lock: reviews
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, vbabka@suse.cz, minchan@kernel.org, cai@lca.pw
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
 <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
 <alpine.LSU.2.11.2008262301240.4405@eggly.anvils>
 <alpine.LSU.2.11.2009081640070.7256@eggly.anvils>
 <61a42a87-eec9-e300-f710-992756f70de6@linux.alibaba.com>
 <alpine.LSU.2.11.2009091524260.10087@eggly.anvils>
 <855ad6ee-dba4-9729-78bd-23e392905cf6@linux.alibaba.com>
 <alpine.LSU.2.11.2009111634020.22739@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <5cfc6142-752d-26e6-0108-38d13009268b@linux.alibaba.com>
Date:   Sun, 13 Sep 2020 22:21:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2009111634020.22739@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/9/12 上午10:13, Hugh Dickins 写道:
> On Fri, 11 Sep 2020, Alex Shi wrote:
>> 在 2020/9/10 上午7:16, Hugh Dickins 写道:
>>> On Wed, 9 Sep 2020, Alex Shi wrote:
>>>> 在 2020/9/9 上午7:41, Hugh Dickins 写道:
>>>>>
>>>>> [PATCH v18 05/32] mm/thp: remove code path which never got into
>>>>> This is a good simplification, but I see no sign that you understand
>>>>> why it's valid: it relies on lru_add_page_tail() being called while
>>>>> head refcount is frozen to 0: we would not get this far if someone
>>>>> else holds a reference to the THP - which they must hold if they have
>>>>> isolated the page from its lru (and that's true before or after your
>>>>> per-memcg changes - but even truer after those changes, since PageLRU
>>>>> can then be flipped without lru_lock at any instant): please explain
>>>>> something of this in the commit message.
>>>>
>>>> Is the following commit log better?
>>>>
>>>>     split_huge_page() will never call on a page which isn't on lru list, so
>>>>     this code never got a chance to run, and should not be run, to add tail
>>>>     pages on a lru list which head page isn't there.
>>>>
>>>>     Hugh Dickins' mentioned:
>>>>     The path should never be called since lru_add_page_tail() being called
>>>>     while head refcount is frozen to 0: we would not get this far if someone
>>>>     else holds a reference to the THP - which they must hold if they have
>>>>     isolated the page from its lru.
>>>>
>>>>     Although the bug was never triggered, it'better be removed for code
>>>>     correctness, and add a warn for unexpected calling.
>>>
>>> Not much better, no.  split_huge_page() can easily be called for a page
>>> which is not on the lru list at the time, 
>>
>> Hi Hugh,
>>
>> Thanks for comments!
>>
>> There are some discussion on this point a couple of weeks ago,
>> https://lkml.org/lkml/2020/7/9/760
>>
>> Matthew Wilcox and Kirill have the following comments,
>>> I don't understand how we get to split_huge_page() with a page that's
>>> not on an LRU list.  Both anonymous and page cache pages should be on
>>> an LRU list.  What am I missing?
>>
>> Right, and it's never got removed from LRU during the split. The tail
>> pages have to be added to LRU because they now separate from the tail
>> page.
>>
>> -- 
>>  Kirill A. Shutemov
> 
> Yes, those were among the mails that I read through before getting
> down to review.  I was surprised by their not understanding, but
> it was a bit late to reply to that thread.
> 
> Perhaps everybody had been focused on pages which have been and
> naturally belong on an LRU list, rather than pages which are on
> the LRU list at the instant that split_huge_page() is called.
> 
> There are a number of places where PageLRU gets cleared, and a
> number of places where we del_page_from_lru_list(), I think you'll
> agree: your patches touch all or most of them.  Let's think of a
> common one, isolate_lru_pages() used by page reclaim, but the same
> would apply to most of the others.
> 
> Then there a number of places where split_huge_page() is called:
> I am having difficulty finding any of those which cannot race with
> page reclaim, but shall we choose anon THP's deferred_split_scan(),
> or shmem THP's shmem_punch_compound()?
> 
> What prevents either of those from calling split_huge_page() at
> a time when isolate_lru_pages() has removed the page from LRU?
> 
> But there's no problem in this race, because anyone isolating the
> page from LRU must hold their own reference to the page (to prevent
> it from being freed independently), and the can_split_huge_page() or
> page_ref_freeze() in split_huge_page_to_list() will detect that and
> fail the split with -EBUSY (or else succeed and prevent new references
> from being acquired).  So this case never reaches lru_add_page_tail().

Hi Hugh,

Thanks for comments!

We are the same page here, we all know split_huge_page_to_list could block
them go futher and the code is functionality right.
If the comments 'Split start from PageLRU(head), and ...' doesn't make 
things clear as it's should be, I am glad to see you rewrite and improve
them.

> 
>>
>>> and I don't know what was the
>>> bug which was never triggered.  
>>
>> So the only path to the removed part should be a bug, like  sth here,
>> https://lkml.org/lkml/2020/7/10/118
>> or
>> https://lkml.org/lkml/2020/7/10/972
> 
> Oh, the use of split_huge_page() in __iommu_dma_alloc_pages() is just
> nonsense, I thought it had already been removed - perhaps some debate
> over __GFP_COMP held it up.  Not something you need worry about in
> this patchset.
> 
>>
>>> Stick with whatever text you end up with
>>> for the combination of 05/32 and 18/32, and I'll rewrite it after.
>>
>> I am not object to merge them into one, I just don't know how to say
>> clear about 2 patches in commit log. As patch 18, TestClearPageLRU
>> add the incorrect posibility of remove lru bit during split, that's
>> the reason of code path rewrite and a WARN there.
> 
> I did not know that was why you were putting 18/32 in at that
> point, it does not mention TestClearPageLRU at all.  But the fact
> remains that it's a nice cleanup, contains a reassuring WARN if we
> got it wrong (and I've suggested a WARN on the other branch too),
> it was valid before your changes, and it's valid after your changes.
> Please merge it back into the uglier 05/32, and again I'll rewrite
> whatever comment you come up with if necessary.

I merge them together on the following git branch, and let the commit log
to you. :)

https://github.com/alexshi/linux.git lruv19
> 
>>>
>>>>> [PATCH v18 06/32] mm/thp: narrow lru locking
>>>>> Why? What part does this play in the series? "narrow lru locking" can
>>>>> also be described as "widen page cache locking": 
>>>>
>>>> Uh, the page cache locking isn't widen, it's still on the old place.
>>>
>>> I'm not sure if you're joking there. Perhaps just a misunderstanding.
>>>
>>> Yes, patch 06/32 does not touch the xa_lock(&mapping->i_pages) and
>>> xa_lock(&swap_cache->i_pages) lines (odd how we've arrived at two of
>>> those, but please do not get into cleaning it up now); but it removes
>>> the spin_lock_irqsave(&pgdata->lru_lock, flags) which used to come
>>> before them, and inserts a spin_lock(&pgdat->lru_lock) after them.
>>>
>>> You call that narrowing the lru locking, okay, but I see it as also
>>> pushing the page cache locking outwards: before this patch, page cache
>>> lock was taken inside lru_lock; after this patch, page cache lock is
>>> taken outside lru_lock.  If you cannot see that, then I think you
>>> should not have touched this code at all; but it's what we have
>>> been testing, and I think we should go forward with it.
>>>
>>>>> But I wish you could give some reason for it in the commit message!
>>>>
>>>> It's a head scratch task. Would you like to tell me what's detailed info 
>>>> should be there? Thanks!
>>>
>>> So, you don't know why you did it either: then it will be hard to
>>> justify.  I guess I'll have to write something for it later.  I'm
>>> strongly tempted just to drop the patch, but expect it will become
>>> useful later, for using lock_page_memcg() before getting lru_lock.
>>>
>>
>> I thought the xa_lock and lru_lock relationship was described clear
>> in the commit log,
> 
> You say "lru_lock and page cache xa_lock have no reason with current
> sequence", but you give no reason for inverting their sequence:
> "let's" is not a reason.
> 
>> and still no idea of the move_lock in the chain.
> 
> memcg->move_lock is what's at the heart of lock_page_memcg(), but
> as much as possible that tries to avoid the overhead of actually
> taking it, since moving memcg is a rare operation.  For lock ordering,
> see the diagram in mm/rmap.c, which 23/32 updates to match this change.

I see. thanks!

> 
> Before this commit: lru_lock > move_lock > i_pages lock was the
> expected lock ordering (but it looks as if the lru_lock > move_lock
> requirement came from my per-memcg lru_lock patches).
> 
> After this commit:  move_lock > i_pages lock > lru_lock is the
> required lock ordering, since there are strong reasons (in dirty
> writeback) for move_lock > i_pages lock.
> 
>> Please refill them for what I overlooked.
> 
> Will do, but not before reviewing your remaining patches.

IIRC, all of comments are accepted and push to 
https://github.com/alexshi/linux.git lruv19
If you don't minder, could you change everything and send out a new version
for further review?

> 
>> Thanks!
>>
>>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>>> Is that correct? Or Wei Yang suggested some part of it perhaps?
>>>>
>>>> Yes, we talked a lot to confirm the locking change is safe.
>>>
>>> Okay, but the patch was written by you, and sent by you to Andrew:
>>> that is not a case for "Signed-off-by: Someone Else".
>>>
>>
>> Ok. let's remove his signed-off.
>>
>>>>> [PATCH v18 27/32] mm/swap.c: optimizing __pagevec_lru_add lru_lock
>>>>> Could we please drop this one for the moment? And come back to it later
>>>>> when the basic series is safely in.  It's a good idea to try sorting
>>>>> together those pages which come under the same lock (though my guess is
>>>>> that they naturally gather themselves together quite well already); but
>>>>> I'm not happy adding 360 bytes to the kernel stack here (and that in
>>>>> addition to 192 bytes of horrid pseudo-vma in the shmem swapin case),
>>>>> though that could be avoided by making it per-cpu. But I hope there's
>>>>> a simpler way of doing it, as efficient, but also useful for the other
>>>>> pagevec operations here: perhaps scanning the pagevec for same page->
>>>>> mem_cgroup (and flags node bits), NULLing entries as they are done.
>>>>> Another, easily fixed, minor defect in this patch: if I'm reading it
>>>>> right, it reverses the order in which the pages are put on the lru?
>>>>
>>>> this patch could give about 10+% performance gain on my multiple memcg
>>>> readtwice testing. fairness locking cost the performance much.
>>>
>>> Good to know, should have been mentioned.  s/fairness/Repeated/
>>>
>>> But what was the gain or loss on your multiple memcg readtwice
>>> testing without this patch, compared against node-only lru_lock?
>>> The 80% gain mentioned before, I presume.  So this further
>>> optimization can wait until the rest is solid.
>>
>> the gain based on the patch 26.
> 
> If I understand your brief comment there, you're saying that
> in a fixed interval of time, the baseline 5.9-rc did 100 runs,
> the patches up to and including 26/32 did 180 runs, then with
> 27/32 on top, did 198 runs?

Uh, I updated the testing with some new results here:
https://lkml.org/lkml/2020/8/26/212

> 
> That's a good improvement by 27/32, but not essential for getting
> the patchset in: I don't think 27/32 is the right way to do it,
> so I'd still prefer to hold it back from the "initial offering".

I am ok to hold it back.
> 
>>
>>>
>>>>
>>>> I also tried per cpu solution but that cause much trouble of per cpu func
>>>> things, and looks no benefit except a bit struct size of stack, so if 
>>>> stack size still fine. May we could use the solution and improve it better.
>>>> like, functionlize, fix the reverse issue etc.
>>>
>>> I don't know how important the stack depth consideration is nowadays:
>>> I still care, maybe others don't, since VMAP_STACK became an option.
>>>
>>> Yes, please fix the reversal (if I was right on that); and I expect
>>> you could use a singly linked list instead of the double.
>>
>> single linked list is more saving, but do we have to reverse walking to seek
>> the head or tail for correct sequence?
> 
> I imagine all you need is to start off with a
> 	for (i = pagevec_count(pvec) - 1; i >= 0; i--)

a nice simple solution, thanks!

Thanks
alex

> loop.
> 
>>
>>>
>>> But I'll look for an alternative - later, once the urgent stuff
>>> is completed - and leave the acks on this patch to others.
>>
>> Ok, looking forward for your new solution!
>>
>> Thanks
>> Alex
