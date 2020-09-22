Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25513273DE0
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 11:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIVJBD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Sep 2020 05:01:03 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:40338 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgIVJBD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Sep 2020 05:01:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0U9lgfBQ_1600765256;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U9lgfBQ_1600765256)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Sep 2020 17:00:57 +0800
Subject: Re: [PATCH v18 20/32] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Hugh Dickins <hughd@google.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <1598273705-69124-21-git-send-email-alex.shi@linux.alibaba.com>
 <alpine.LSU.2.11.2009211908080.6434@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <0ae8709b-b82a-0956-9934-cbbd1f2e50ce@linux.alibaba.com>
Date:   Tue, 22 Sep 2020 16:58:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2009211908080.6434@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/9/22 ÏÂÎç1:27, Hugh Dickins Ð´µÀ:
> On Mon, 24 Aug 2020, Alex Shi wrote:
> 
>> This patch moves per node lru_lock into lruvec, thus bring a lru_lock for
>> each of memcg per node. So on a large machine, each of memcg don't
>> have to suffer from per node pgdat->lru_lock competition. They could go
>> fast with their self lru_lock.
>>
>> After move memcg charge before lru inserting, page isolation could
>> serialize page's memcg, then per memcg lruvec lock is stable and could
>> replace per node lru lock.
>>
>> In func isolate_migratepages_block, compact_unlock_should_abort is
>> opend, and lock_page_lruvec logical is embedded for tight process.
> 
> Hard to understand: perhaps:
> 
> In func isolate_migratepages_block, compact_unlock_should_abort and
> lock_page_lruvec_irqsave are open coded to work with compact_control.

will update with your suggestion. Thanks!

> 
>> Also add a debug func in locking which may give some clues if there are
>> sth out of hands.
>>
>> According to Daniel Jordan's suggestion, I run 208 'dd' with on 104
>> containers on a 2s * 26cores * HT box with a modefied case:
>> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice
> 
> s/modeified/modified/
> lruv19 has an lkml.org link there, please substitut
> https://lore.kernel.org/lkml/01ed6e45-3853-dcba-61cb-b429a49a7572@linux.alibaba.com/
> 

Thanks!

>>
>> With this and later patches, the readtwice performance increases
>> about 80% within concurrent containers.
>>
>> On a large machine with memcg enabled but not used, the page's lruvec
>> seeking pass a few pointers, that may lead to lru_lock holding time
>> increase and a bit regression.
>>
>> Hugh Dickins helped on patch polish, thanks!
>>
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> Eh? It may have reported some locking bugs somewhere, but this
> is the main patch of your per-memcg lru_lock: I don't think the
> kernel test robot inspired your whole design, did it?  Delete that.
> 
> 
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> 
> I can't quite Ack this one yet, because there are several functions
> (mainly __munlock_pagevec and check_move_unevictable_pages) which are
> not right in this v18 version, and a bit tricky to correct: I already
> suggested what to do in other mail, but this patch comes before
> relock_page_lruvec, so must look different from the final result;
> I need to look at a later version, perhaps already there in your
> github tree, before I can Ack: but it's not far off.
> Comments below.

All suggestions are taken! Many thanks for so detailed review!
A new branch with all comments is updated as 
    https://github.com/alexshi/linux.git lruv19.5

A quick summary for the branch,
Add a new patch for move_pages_to_lru:
	mm/vmscan: remove lruvec reget in move_pages_to_lru
Add another patch for split part from 'Introduce TestClearPageLRU':
 	mm/swap.c: reorder __ClearPageLRU and lruvec

the mlock changes moved earlier:
	mm/mlock: remove __munlock_isolate_lru_page
	mm/mlock: remove __munlock_isolate_lru_page

I am wondering if it's good to send out v19 here or maybe better to wait
for your confirm if all suggestion/comments are settled?

Thanks
Alex
