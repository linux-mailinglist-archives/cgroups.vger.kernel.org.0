Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40712B077A
	for <lists+cgroups@lfdr.de>; Thu, 12 Nov 2020 15:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgKLOUg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Nov 2020 09:20:36 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:33143 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727803AbgKLOUf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Nov 2020 09:20:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0UF5gzB-_1605190819;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UF5gzB-_1605190819)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Nov 2020 22:20:20 +0800
Subject: Re: [PATCH v21 17/19] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
Cc:     Michal Hocko <mhocko@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
 <1604566549-62481-18-git-send-email-alex.shi@linux.alibaba.com>
 <f9cfab13-fae2-c384-90b2-9e3107273734@suse.cz>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <fe584528-9d9b-ac6d-bc9a-4be2d6b98cf4@linux.alibaba.com>
Date:   Thu, 12 Nov 2020 22:19:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <f9cfab13-fae2-c384-90b2-9e3107273734@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/11/12 下午8:19, Vlastimil Babka 写道:
> On 11/5/20 9:55 AM, Alex Shi wrote:
>> This patch moves per node lru_lock into lruvec, thus bring a lru_lock for
>> each of memcg per node. So on a large machine, each of memcg don't
>> have to suffer from per node pgdat->lru_lock competition. They could go
>> fast with their self lru_lock.
>>
>> After move memcg charge before lru inserting, page isolation could
>> serialize page's memcg, then per memcg lruvec lock is stable and could
>> replace per node lru lock.
>>
>> In func isolate_migratepages_block, compact_unlock_should_abort and
>> lock_page_lruvec_irqsave are open coded to work with compact_control.
>> Also add a debug func in locking which may give some clues if there are
>> sth out of hands.
>>
>> Daniel Jordan's testing show 62% improvement on modified readtwice case
>> on his 2P * 10 core * 2 HT broadwell box.
>> https://lore.kernel.org/lkml/20200915165807.kpp7uhiw7l3loofu@ca-dmjordan1.us.oracle.com/
>>
>> On a large machine with memcg enabled but not used, the page's lruvec
>> seeking pass a few pointers, that may lead to lru_lock holding time
>> increase and a bit regression.
>>
>> Hugh Dickins helped on the patch polish, thanks!
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Acked-by: Hugh Dickins <hughd@google.com>
>> Cc: Rong Chen <rong.a.chen@intel.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>> Cc: Yang Shi <yang.shi@linux.alibaba.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: cgroups@vger.kernel.org
> 
> I think I need some explanation about the rcu_read_lock() usage in lock_page_lruvec*() (and places effectively opencoding it).
> Preferably in form of some code comment, but that can be also added as a additional patch later, I don't want to block the series.
> 

Hi Vlastimil, 

Thanks for comments!

Oh, we did talk about the rcu_read_lock which is used to block memcg destroy during locking.
and the spin_lock actually includes a rcu_read_lock(). Yes, we could add this comments later.

> mem_cgroup_page_lruvec() comment says
> 
>  * This function relies on page->mem_cgroup being stable - see the
>  * access rules in commit_charge().
> 
> commit_charge() comment:
> 
>          * Any of the following ensures page->mem_cgroup stability:
>          *
>          * - the page lock
>          * - LRU isolation
>          * - lock_page_memcg()
>          * - exclusive reference
> 
> "LRU isolation" used to be quite clear, but now is it after TestClearPageLRU(page) or after deleting from the lru list as well?
> Also it doesn't mention rcu_read_lock(), should it?

The lru isolation still is same as old conception, a set actions that take a page from a lru list, and commit_charge do
need a isoltion for the page.

but the condition of page_memcg could be change since we don't rely on lru isolation for it. The comments
could be changed later.

> 
> So what exactly are we protecting by rcu_read_lock() in e.g. lock_page_lruvec()?
> 
>         rcu_read_lock();
>         lruvec = mem_cgroup_page_lruvec(page, pgdat);
>         spin_lock(&lruvec->lru_lock);
>         rcu_read_unlock();
> 
> Looks like we are protecting the lruvec from going away and it can't go away anymore after we take the lru_lock?
> 
> But then e.g. in __munlock_pagevec() we are doing this without an rcu_read_lock():
> 
>     new_lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));

TestClearPageLRU could block the page from memcg migration/destory.

Thanks
Alex

> 
> where new_lruvec is potentionally not the one that we have locked
> 
> And the last thing mem_cgroup_page_lruvec() is doing is:
> 
>         if (unlikely(lruvec->pgdat != pgdat))
>                 lruvec->pgdat = pgdat;
>         return lruvec;
> 
> So without the rcu_read_lock() is this potentionally accessing the pgdat field of lruvec that might have just gone away?
> 
> Thanks,
> Vlastimil
