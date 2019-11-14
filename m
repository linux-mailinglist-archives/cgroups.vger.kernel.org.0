Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8E0DFBFF5
	for <lists+cgroups@lfdr.de>; Thu, 14 Nov 2019 07:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbfKNGBP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Nov 2019 01:01:15 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:41196 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbfKNGBP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Nov 2019 01:01:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=29;SR=0;TI=SMTPD_---0Ti1eLE7_1573711266;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Ti1eLE7_1573711266)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Nov 2019 14:01:07 +0800
Subject: Re: [PATCH v2 4/8] mm/lru: only change the lru_lock iff page's lruvec
 is different
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
        Vlastimil Babka <vbabka@suse.cz>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <1573567588-47048-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573567588-47048-5-git-send-email-alex.shi@linux.alibaba.com>
 <20191112143624.GA7934@bombadil.infradead.org>
 <297ad71c-081c-f7e1-d640-8720a0eeeeba@linux.alibaba.com>
 <20191113134502.GD7934@bombadil.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <ba11d04a-def4-10b3-0b4e-4194e0ee2318@linux.alibaba.com>
Date:   Thu, 14 Nov 2019 14:01:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191113134502.GD7934@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2019/11/13 下午9:45, Matthew Wilcox 写道:
>>> Why not simply:
>>>
>>> 	rcu_read_lock();
>>> 	lruvec = mem_cgroup_page_lruvec(page, pgdat);
>>> 	rcu_read_unlock();
>>>
>>> 	if (locked_lruvec == lruvec)
>> The rcu_read_unlock here is for guarding the locked_lruvec/lruvec comparsion.
>> Otherwise memcg/lruvec maybe changed, like, from memcg migration etc. I guess.
> How does holding the RCU lock guard the comparison?  You're comparing two
> pointers for equality.  Nothing any other CPU can do at this point will
> change the results of that comparison.
> 

Hi Matthew, Thanks for reply!

The reason of guarding lruvec compasion here is a bit undistinct, in fact, it guards the page's memcg from free/migrate etc, since the lruvec is kind of binding to each of memcg. The detailed explanation could be found in lock_page_memcg().

Thanks
Alex
