Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99850122C93
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2019 14:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfLQNL2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Dec 2019 08:11:28 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:36181 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726962AbfLQNL2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Dec 2019 08:11:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0TlCXr4r_1576588278;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TlCXr4r_1576588278)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Dec 2019 21:11:19 +0800
Subject: Re: [PATCH v6 02/10] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Matthew Wilcox <willy@infradead.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, shakeelb@google.com,
        hannes@cmpxchg.org, Michal Hocko <mhocko@kernel.org>,
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
References: <1576488386-32544-1-git-send-email-alex.shi@linux.alibaba.com>
 <1576488386-32544-3-git-send-email-alex.shi@linux.alibaba.com>
 <20191216121427.GZ32169@bombadil.infradead.org>
 <286c11c2-480f-37d6-e9fe-91822f862cd6@linux.alibaba.com>
 <20191217021613.GB32169@bombadil.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <a7b5c7bb-022f-60de-2d61-696915df002a@linux.alibaba.com>
Date:   Tue, 17 Dec 2019 21:11:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191217021613.GB32169@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2019/12/17 上午10:16, Matthew Wilcox 写道:
>>> You still didn't fix this function.  Go back and look at my comment from
>>> the last time you sent this patch set.
>>>
>> Sorry for the misunderstanding. I guess what your want is fold the patch 9th into this, is that right?
>> Any comments for the 9th patch?
> I didn't get as far as looking at the ninth patch because I saw this
> one was wrong and stopped looking.  This is not the first time *with
> this patch set* that you've been told to *fix the patch*, not submit
> something that's broken and fix it in a later patch.
> 
> I'll look at patch 9 later.


Thanks a lot for the nice cocaching and quick response!

What the problem for me here is I didn't find a bug here. From the commit_charge's explanations and mem_cgroup_commit_charge comments, as well as call path when lrucare is ture, The lock is just to guard the task migration(which would be lead to move_account) So, It's just a clean up to give up locking when !PageLRU in patch 9. And even w/o patch 9, the page just locked root_mem_cgroup's lru_lock, same as old function does, while the page isn't on any LRU. Useless, but it's still safe.

Do you mind to point out anything else I missed?

Thanks a lot!
Alex

