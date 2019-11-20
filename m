Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B37B1038F0
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2019 12:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfKTLlz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Nov 2019 06:41:55 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:41038 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728495AbfKTLlz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Nov 2019 06:41:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0TidwO.r_1574250104;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TidwO.r_1574250104)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Nov 2019 19:41:45 +0800
Subject: Re: [PATCH v4 3/9] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
 <1574166203-151975-4-git-send-email-alex.shi@linux.alibaba.com>
 <20191119160456.GD382712@cmpxchg.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <bcf6a952-5b92-50ad-cfc1-f4d9f8f63172@linux.alibaba.com>
Date:   Wed, 20 Nov 2019 19:41:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191119160456.GD382712@cmpxchg.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2019/11/20 ÉÏÎç12:04, Johannes Weiner Ð´µÀ:
>> +
>> +	return lruvec;
> While this works in practice, it looks wrong because it doesn't follow
> the mem_cgroup_page_lruvec() rules.
> 
> Please open-code spin_lock_irq(&pgdat->__lruvec->lru_lock) instead.
> 

That's right. Thanks for suggestion!

>> @@ -1246,6 +1245,46 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
>>  	return lruvec;
>>  }
>>  
>> +struct lruvec *lock_page_lruvec_irq(struct page *page,
>> +					struct pglist_data *pgdat)
>> +{
>> +	struct lruvec *lruvec;
>> +
>> +again:
>> +	rcu_read_lock();
>> +	lruvec = mem_cgroup_page_lruvec(page, pgdat);
>> +	spin_lock_irq(&lruvec->lru_lock);
>> +	rcu_read_unlock();
> The spinlock doesn't prevent the lruvec from being freed
> 
> You deleted the rules from the mem_cgroup_page_lruvec() documentation,
> but they still apply: if the page is already !PageLRU() by the time
> you get here, it could get reclaimed or migrated to another cgroup,
> and that can free the memcg/lruvec. Merely having the lru_lock held
> does not prevent this.


Forgive my idiot, I still don't know the details of unsafe lruvec here.
From my shortsight, the spin_lock_irq(embedded a preempt_disable) could block all rcu syncing thus, keep all memcg alive until the preempt_enabled in unspinlock, is this right?
If so even the page->mem_cgroup is migrated to others cgroups, the new and old cgroup should still be alive here. 

> 
> Either the page needs to be locked, or the page needs to be PageLRU
> with the lru_lock held to prevent somebody else from isolating
> it. Otherwise, the lruvec is not safe to use.

Do you mean that we may get the wrong lruvec->lru_lock if !PageLRU, so, the page may got freed by others? Sorry I got last there.

Thanks
Alex
