Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EC81F6175
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2020 08:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgFKGGz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Jun 2020 02:06:55 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:35261 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgFKGGz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Jun 2020 02:06:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U.Eg.NV_1591855608;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U.Eg.NV_1591855608)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Jun 2020 14:06:48 +0800
Subject: Re: [PATCH v11 00/16] per memcg lru lock
To:     Hugh Dickins <hughd@google.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
References: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com>
 <alpine.LSU.2.11.2006072100390.2001@eggly.anvils>
 <31943f08-a8e8-be38-24fb-ab9d25fd96ff@linux.alibaba.com>
 <alpine.LSU.2.11.2006091904530.2779@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <730c595b-f4bf-b16a-562e-de25b9b7eb97@linux.alibaba.com>
Date:   Thu, 11 Jun 2020 14:06:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2006091904530.2779@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/6/10 上午11:22, Hugh Dickins 写道:
> On Mon, 8 Jun 2020, Alex Shi wrote:
>> 在 2020/6/8 下午12:15, Hugh Dickins 写道:
>>>>  24 files changed, 487 insertions(+), 312 deletions(-)
>>> Hi Alex,
>>>
>>> I didn't get to try v10 at all, waited until Johannes's preparatory
>>> memcg swap cleanup was in mmotm; but I have spent a while thrashing
>>> this v11, and can happily report that it is much better than v9 etc:
>>> I believe this memcg lru_lock work will soon be ready for v5.9.
>>>
>>> I've not yet found any flaw at the swapping end, but fixes are needed
>>> for isolate_migratepages_block() and mem_cgroup_move_account(): I've
>>> got a series of 4 fix patches to send you (I guess two to fold into
>>> existing patches of yours, and two to keep as separate from me).
>>>
>>> I haven't yet written the patch descriptions, will return to that
>>> tomorrow.  I expect you will be preparing a v12 rebased on v5.8-rc1
>>> or v5.8-rc2, and will be able to include these fixes in that.
>>
>> I am very glad to get your help on this feature! 
>>
>> and looking forward for your fixes tomorrow. :)
>>
>> Thanks a lot!
>> Alex
> 
> Sorry, Alex, the news is not so good today.
> 
> You'll have noticed I sent nothing yesterday. That's because I got
> stuck on my second patch: could not quite convince myself that it
> was safe.

Hi Hugh,

Thanks a lot for your help and effort! I very appreciate for this.

> 
> I keep hinting at these patches, and I can't complete their writeups
> until I'm convinced; but to give you a better idea of what they do:
> 
> 1. Fixes isolate_fail and isolate_abort in isolate_migratepages_block().

I guess I know this after mm-compaction-avoid-vm_bug_onpageslab-in-page_mapcount.patch
was removed.

> 2. Fixes unsafe use of trylock_page() in __isolate_lru_page_prepare().
> 3. Reverts 07/16 inversion of lock ordering in split_huge_page_to_list().
> 4. Adds lruvec lock protection in mem_cgroup_move_account().

Sorry for can't follow you for above issues. Anyway, I will send out new patchset
with the first issue fixed. and then let's discussion base on it.

> 
> In the second, I was using rcu_read_lock() instead of trylock_page()
> (like in my own patchset), but could not quite be sure of the case when
> PageSwapCache gets set at the wrong moment. Gave up for the night, and
> in the morning abandoned that, instead just shifting the call to
> __isolate_lru_page_prepare() after the get_page_unless_zero(),
> where that trylock_page() becomes safe (no danger of stomping on page
> flags while page is being freed or newly allocated to another owner).

Sorry, I don't know the problem of trylock_page here? Could you like to
describe it as a race?

> 
> I thought that a very safe change, but best to do some test runs with
> it in before finalizing. And was then unpleasantly surprised to hit a
> VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != page->mem_cgroup) from
> lock_page_lruvec_irqsave < relock_page_lruvec < pagevec_lru_move_fn <
> pagevec_move_tail < lru_add_drain_cpu after 6 hours on one machine.
> Then similar but < rotate_reclaimable_page after 8 hours on another.
> 
> Only seen once before: that's what drove me to add patch 4 (with 3 to
> revert the locking before it): somehow, when adding the lruvec locking
> there, I just took it for granted that your patchset would have the
> appropriate locking (or TestClearPageLRU magic) at the other end.
> 
> But apparently not. And I'm beginning to think that TestClearPageLRU
> was just to distract the audience from the lack of proper locking.
> 
> I have certainly not concluded that yet, but I'm having to think about
> an area of the code which I'd imagined you had under control (and I'm
> puzzled why my testing has found it so very hard to hit). If we're
> lucky, I'll find that pagevec_move_tail is a special case, and
> nothing much else needs changing; but I doubt that will be so.
> 
> There's one other unexplained and unfixed bug I've seen several times
> while exercising mem_cgroup_move_account(): refcount_warn_saturate()
> from where __mem_cgroup_clear_mc() calls mem_cgroup_id_get_many().
> I'll be glad if that goes away when the lruvec locking is fixed,
> but don't understand the connection. And it's quite possible that
> this refcounting bug has nothing to do with your changes: I have
> not succeeded in reproducing it on 5.7 nor on 5.7-rc7-mm1,
> but I didn't really try long enough to be sure.
> 
> (I should also warn, that I'm surprised by the amount of change
> 11/16 makes to mm/mlock.c: I've not been exercising mlock at all.)

yes, that is a bit complex. I have tried the mlock cases in selftest with
your swap&build case. They are all fine with 300 times run.

> 
> Taking a break for the evening,
> Hugh
> 
