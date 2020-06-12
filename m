Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640981F76D9
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2020 12:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgFLKnt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Jun 2020 06:43:49 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39656 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbgFLKns (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Jun 2020 06:43:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U.M.ky._1591958621;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U.M.ky._1591958621)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jun 2020 18:43:41 +0800
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
 <730c595b-f4bf-b16a-562e-de25b9b7eb97@linux.alibaba.com>
 <alpine.LSU.2.11.2006111409280.10801@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <b6b5b74e-d960-8d2c-3f2f-f4a38eb633c3@linux.alibaba.com>
Date:   Fri, 12 Jun 2020 18:43:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2006111409280.10801@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/6/12 上午6:09, Hugh Dickins 写道:
>> Anyway, I will send out new patchset
>> with the first issue fixed. and then let's discussion base on it.
> Sigh. I wish you had waited for me to send you fixes, or waited for an
> identifiable tag like 5.8-rc1.  Andrew has been very hard at work with
> mm patches to Linus, but it looks like there are still "data_race" mods
> to come before -rc1, which may stop your v12 from applying cleanly.

Sorry, I didn't aware you would had another sending... My fault.
And yes, offical 5.8-rc is better base.

> 
>>> In the second, I was using rcu_read_lock() instead of trylock_page()
>>> (like in my own patchset), but could not quite be sure of the case when
>>> PageSwapCache gets set at the wrong moment. Gave up for the night, and
>>> in the morning abandoned that, instead just shifting the call to
>>> __isolate_lru_page_prepare() after the get_page_unless_zero(),
>>> where that trylock_page() becomes safe (no danger of stomping on page
>>> flags while page is being freed or newly allocated to another owner).
>> Sorry, I don't know the problem of trylock_page here? Could you like to
>> describe it as a race?
> Races, yes. Look, I'll send you now patches 1 and 2: at least with those
> in it should be safe for you and others to test compaction (if 5.8-rc1
> turns out well: I think so much has gone in that it might have unrelated
> problems, and often the -rc2 is much more stable).
> 
> But no point in sending 3 and 4 at this point, since ...
> 

I guess some concern may come from next mm bug?

>>> I thought that a very safe change, but best to do some test runs with
>>> it in before finalizing. And was then unpleasantly surprised to hit a
>>> VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != page->mem_cgroup) from
>>> lock_page_lruvec_irqsave < relock_page_lruvec < pagevec_lru_move_fn <
>>> pagevec_move_tail < lru_add_drain_cpu after 6 hours on one machine.
>>> Then similar but < rotate_reclaimable_page after 8 hours on another.
>>>
>>> Only seen once before: that's what drove me to add patch 4 (with 3 to
>>> revert the locking before it): somehow, when adding the lruvec locking
>>> there, I just took it for granted that your patchset would have the
>>> appropriate locking (or TestClearPageLRU magic) at the other end.
>>>
>>> But apparently not. And I'm beginning to think that TestClearPageLRU
>>> was just to distract the audience from the lack of proper locking.
>>>
>>> I have certainly not concluded that yet, but I'm having to think about
>>> an area of the code which I'd imagined you had under control (and I'm
>>> puzzled why my testing has found it so very hard to hit). If we're
>>> lucky, I'll find that pagevec_move_tail is a special case, and
>>> nothing much else needs changing; but I doubt that will be so.
> ... shows that your locking primitives are not yet good enough
> to handle the case when tasks are moved between memcgs with
> move_charge_at_immigrate set.  "bin/cg m" in the tests I sent,
> but today I'm changing its "seconds=60" to "seconds=1" in hope
> of speeding up the reproduction.

Yes, I am using your great cases with 'm' parameter to do migration testing,
but unlockly, no error found in my box.

> 
> Ah, good, two machines crashed in 1.5 hours: but I don't need to
> examine the crashes, now that it's obvious there's no protection -
> please, think about rotate_reclaimable_page() (there will be more
> cases, but in practice that seems easiest to hit, so focus on that)
> and how it is not protected from mem_cgroup_move_account().
> > I'm thinking too. Maybe judicious use of lock_page_memcg() can fix it
> (8 years ago it was unsuitable, but a lot has changed for the better
> since then); otherwise it's back to what I've been doing all along,
> taking the likely lruvec lock, and checking under that lock whether
> we have the right lock (as your lruvec_memcg_debug() does), retrying
> if not. Which may be more efficient than involving lock_page_memcg().
> 
> But I guess still worth sending my first two patches, since most of us
> use move_charge_at_immigrate only for... testing move_charge_at_immigrate.
> Whereas compaction bugs can hit any of us at any time.
> 
>>> There's one other unexplained and unfixed bug I've seen several times
>>> while exercising mem_cgroup_move_account(): refcount_warn_saturate()
>>> from where __mem_cgroup_clear_mc() calls mem_cgroup_id_get_many().
>>> I'll be glad if that goes away when the lruvec locking is fixed,
>>> but don't understand the connection. And it's quite possible that
>>> this refcounting bug has nothing to do with your changes: I have
>>> not succeeded in reproducing it on 5.7 nor on 5.7-rc7-mm1,
>>> but I didn't really try long enough to be sure.
> I got one of those quite quickly too after setting "cg m"'s seconds=1.
> I think the best thing I can do while thinking and researching, is
> give 5.7-rc7-mm1 a run on that machine with the speeded up moving,
> to see whether or not that refcount bug reproduces.
> 

Millions thanks for help on this patchset!

Alex
