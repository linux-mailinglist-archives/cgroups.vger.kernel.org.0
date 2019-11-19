Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D031021C5
	for <lists+cgroups@lfdr.de>; Tue, 19 Nov 2019 11:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfKSKKZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Nov 2019 05:10:25 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:40894 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbfKSKKZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Nov 2019 05:10:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0TiYLMZT_1574158209;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TiYLMZT_1574158209)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Nov 2019 18:10:10 +0800
Subject: Re: [PATCH v3 3/7] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, yang.shi@linux.alibaba.com,
        willy@infradead.org, Johannes Weiner <hannes@cmpxchg.org>,
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
 <20191119021058.auxc6g7vmgf7d5gg@ca-dmjordan1.us.oracle.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <1199177d-6f34-3aae-3eb6-8fac42f070a1@linux.alibaba.com>
Date:   Tue, 19 Nov 2019 18:10:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191119021058.auxc6g7vmgf7d5gg@ca-dmjordan1.us.oracle.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2019/11/19 ÉÏÎç10:10, Daniel Jordan Ð´µÀ:
>> -	if (pgdat)
>> -		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
>> +
>>  	release_pages(pvec->pages, pvec->nr);
>>  	pagevec_reinit(pvec);
>>  }
> Why can't you keep the locking pattern where we only drop and reacquire if the
> lruvec changes?  It'd save a lot of locks and unlocks if most pages were from
> the same memcg and node, or the memory controller were unused.
> 

Good catching! This issue will be fixed in the next patch which introduce relock_ function.

Thanks!
