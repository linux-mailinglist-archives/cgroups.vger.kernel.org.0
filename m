Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B00211004C9
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2019 12:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfKRLzy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Nov 2019 06:55:54 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:57089 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726506AbfKRLzy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Nov 2019 06:55:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0TiTpj16_1574078144;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TiTpj16_1574078144)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 18 Nov 2019 19:55:45 +0800
Subject: Re: [PATCH v3 3/7] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Matthew Wilcox <willy@infradead.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
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
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573874106-23802-4-git-send-email-alex.shi@linux.alibaba.com>
 <20191116043806.GD20752@bombadil.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <0bfa9a03-b095-df83-9cfd-146da9aab89a@linux.alibaba.com>
Date:   Mon, 18 Nov 2019 19:55:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191116043806.GD20752@bombadil.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2019/11/16 ÏÂÎç12:38, Matthew Wilcox Ð´µÀ:
> On Sat, Nov 16, 2019 at 11:15:02AM +0800, Alex Shi wrote:
>> This is the main patch to replace per node lru_lock with per memcg
>> lruvec lock. It also fold the irqsave flags into lruvec.
> 
> I have to say, I don't love the part where we fold the irqsave flags
> into the lruvec.  I know it saves us an argument, but it opens up the
> possibility of mismatched expectations.  eg we currently have:
> 
> static void __split_huge_page(struct page *page, struct list_head *list,
> 			struct lruvec *lruvec, pgoff_t end)
> {
> ...
> 	spin_unlock_irqrestore(&lruvec->lru_lock, lruvec->irqflags);
> 
> so if we introduce a new caller, we have to be certain that this caller
> is also using lock_page_lruvec_irqsave() and not lock_page_lruvec_irq().
> I can't think of a way to make the compiler enforce that, and if we don't,
> then we can get some odd crashes with interrupts being unexpectedly
> enabled or disabled, depending on how ->irqflags was used last.
> 
> So it makes the code more subtle.  And that's not a good thing.

Hi Matthew,

Thanks for comments!

Here, the irqflags is bound, and belong to lruvec, merging them into together helps us to take them as whole, and thus reduce a unnecessary code clues.
The only thing maybe bad that it may take move place in pg_data_t.lruvec, but there are PADDINGs to remove this concern.

As your concern for a 'new' caller, since __split_huge_page is a static helper here, no distub for anyothers.

Do you agree on that?

> 
>> +static inline struct lruvec *lock_page_lruvec_irq(struct page *page,
>> +						struct pglist_data *pgdat)
>> +{
>> +	struct lruvec *lruvec = mem_cgroup_page_lruvec(page, pgdat);
>> +
>> +	spin_lock_irq(&lruvec->lru_lock);
>> +
>> +	return lruvec;
>> +}
> 
> ...
> 
>> +static struct lruvec *lock_page_lru(struct page *page, int *isolated)
>>  {
>>  	pg_data_t *pgdat = page_pgdat(page);
>> +	struct lruvec *lruvec = lock_page_lruvec_irq(page, pgdat);
>>  
>> -	spin_lock_irq(&pgdat->lru_lock);
>>  	if (PageLRU(page)) {
>> -		struct lruvec *lruvec;
>>  
>> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>>  		ClearPageLRU(page);
>>  		del_page_from_lru_list(page, lruvec, page_lru(page));
>>  		*isolated = 1;
>>  	} else
>>  		*isolated = 0;
>> +
>> +	return lruvec;
>>  }
> 
> But what if the page is !PageLRU?  What lruvec did we just lock?

like original pgdat->lru_lock, we need the lock from PageLRU racing. And it the lruvec which the page should be.


> According to the comments on mem_cgroup_page_lruvec(),
> 
>  * This function is only safe when following the LRU page isolation
>  * and putback protocol: the LRU lock must be held, and the page must
>  * either be PageLRU() or the caller must have isolated/allocated it.
> 
> and now it's being called in order to find out which LRU lock to take.
> So this comment needs to be updated, if it's wrong, or this patch has
> a race.


Yes, the function reminder is a bit misunderstanding with new patch, How about the following changes:

- * This function is only safe when following the LRU page isolation
- * and putback protocol: the LRU lock must be held, and the page must
- * either be PageLRU() or the caller must have isolated/allocated it.
+ * The caller needs to grantee the page's mem_cgroup is undisturbed during
+ * using. That could be done by lock_page_memcg or lock_page_lruvec.

Thanks
Alex
