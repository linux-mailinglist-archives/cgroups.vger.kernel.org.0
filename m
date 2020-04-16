Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93851ABABF
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2020 10:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439809AbgDPIC7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Apr 2020 04:02:59 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:32793 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439971AbgDPICR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Apr 2020 04:02:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=39;SR=0;TI=SMTPD_---0TvgXXNk_1587024122;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TvgXXNk_1587024122)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Apr 2020 16:02:03 +0800
Subject: Re: [PATCH v8 03/10] mm/lru: replace pgdat lru_lock with lruvec lock
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@techsingularity.net, tj@kernel.org,
        hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, shakeelb@google.com,
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
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>
References: <1579143909-156105-1-git-send-email-alex.shi@linux.alibaba.com>
 <1579143909-156105-4-git-send-email-alex.shi@linux.alibaba.com>
 <20200116215222.GA64230@cmpxchg.org>
 <cdcdb710-1d78-6fac-48d7-35519ddcdc6a@linux.alibaba.com>
 <20200413180725.GA99267@cmpxchg.org>
 <8e7bf170-2bb5-f862-c12b-809f7f7d96cb@linux.alibaba.com>
 <20200414163114.GA136578@cmpxchg.org>
 <54af0662-cbb4-88c7-7eae-f969684025dd@linux.alibaba.com>
Message-ID: <0bed9f1a-400d-d9a9-aeb4-de1dd9ccbb45@linux.alibaba.com>
Date:   Thu, 16 Apr 2020 16:01:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <54af0662-cbb4-88c7-7eae-f969684025dd@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/4/15 下午9:42, Alex Shi 写道:
> Hi Johannes,
> 
> Thanks a lot for point out!
> 
> Charging in __read_swap_cache_async would ask for 3 layers function arguments
> pass, that would be a bit ugly. Compare to this, could we move out the
> lru_cache add after commit_charge, like ksm copied pages?
> 
> That give a bit extra non lru list time, but the page just only be used only
> after add_anon_rmap setting. Could it cause troubles?

Hi Johannes & Andrew,

Doing lru_cache_add_anon during swapin_readahead can give a very short timing 
for possible page reclaiming for these few pages.

If we delay these few pages lru adding till after the vm_fault target page 
get memcg charging(mem_cgroup_commit_charge) and activate, we could skip the 
mem_cgroup_try_charge/commit_charge/cancel_charge process in __read_swap_cache_async().
But the cost is maximum SWAP_RA_ORDER_CEILING number pages on each cpu miss
page reclaiming in a short time. On the other hand, save the target vm_fault
page from reclaiming before activate it during that time.

Judging the lose and gain, and the example of shmem/ksm copied pages, I believe 
it's fine to delay lru list adding till activate the target swapin page.

Any comments are appreciated! 

Thanks
Alex


> 
> I tried to track down the reason of lru_cache_add here, but no explanation
> till first git kernel commit.
> 
> Thanks
> Alex 
> 
