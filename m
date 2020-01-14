Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA6D13A10B
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2020 07:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgANGfi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Jan 2020 01:35:38 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:56638 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbgANGfi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Jan 2020 01:35:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0TnhU9aL_1578983727;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TnhU9aL_1578983727)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Jan 2020 14:35:28 +0800
Subject: Re: [PATCH v7 03/10] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, yang.shi@linux.alibaba.com,
        willy@infradead.org, shakeelb@google.com, hannes@cmpxchg.org,
        Michal Hocko <mhocko@kernel.org>,
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
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
 <1577264666-246071-4-git-send-email-alex.shi@linux.alibaba.com>
 <20200113154116.mwly5hl5yfvjkzl2@ca-dmjordan1.us.oracle.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <677cb490-35a4-4186-0935-6d71305a3a3e@linux.alibaba.com>
Date:   Tue, 14 Jan 2020 14:33:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200113154116.mwly5hl5yfvjkzl2@ca-dmjordan1.us.oracle.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/1/13 ÏÂÎç11:41, Daniel Jordan Ð´µÀ:
> Hi Alex,
> 
> On Wed, Dec 25, 2019 at 05:04:19PM +0800, Alex Shi wrote:
>> @@ -900,6 +904,29 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
>>  {
>>  	return &pgdat->__lruvec;
>>  }
>> +#define lock_page_lruvec_irq(page)			\
>> +({							\
>> +	struct pglist_data *pgdat = page_pgdat(page);	\
>> +	spin_lock_irq(&pgdat->__lruvec.lru_lock);	\
>> +	&pgdat->__lruvec;				\
>> +})
>> +
>> +#define lock_page_lruvec_irqsave(page, flagsp)			\
>> +({								\
>> +	struct pglist_data *pgdat = page_pgdat(page);		\
>> +	spin_lock_irqsave(&pgdat->__lruvec.lru_lock, *flagsp);	\
>> +	&pgdat->__lruvec;					\
>> +})
>> +
>> +#define unlock_page_lruvec_irq(lruvec)			\
>> +({							\
>> +	spin_unlock_irq(&lruvec->lru_lock);		\
>> +})
>> +
>> +#define unlock_page_lruvec_irqrestore(lruvec, flags)		\
>> +({								\
>> +	spin_unlock_irqrestore(&lruvec->lru_lock, flags);	\
>> +})
> 
> Noticed this while testing your series.  These are safe as inline functions, so
> I think you may have gotten the wrong impression when Johannes made this point:
> 
> https://lore.kernel.org/linux-mm/20191119164448.GA396644@cmpxchg.org/
> 

Thanks for reminder! Daniel!

I write them to macro, since I guess it's more favorite for some guys. It's do a bit more neat than function although cost a bit readablity. 

Thanks a lot! :)
Alex
