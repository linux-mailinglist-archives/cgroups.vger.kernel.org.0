Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DED901005AD
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2019 13:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfKRMcF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Nov 2019 07:32:05 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:49299 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726506AbfKRMcE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Nov 2019 07:32:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=38;SR=0;TI=SMTPD_---0TiTa-iK_1574080310;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TiTa-iK_1574080310)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 18 Nov 2019 20:31:52 +0800
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
 <0bfa9a03-b095-df83-9cfd-146da9aab89a@linux.alibaba.com>
 <20191118121451.GG20752@bombadil.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <296c7202-930e-4027-2e92-b8c64a908d88@linux.alibaba.com>
Date:   Mon, 18 Nov 2019 20:31:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191118121451.GG20752@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2019/11/18 下午8:14, Matthew Wilcox 写道:
>> Hi Matthew,
>>
>> Thanks for comments!
>>
>> Here, the irqflags is bound, and belong to lruvec, merging them into together helps us to take them as whole, and thus reduce a unnecessary code clues.
> It's not bound to the lruvec, though.  Call chain A uses it and call chain
> B doesn't.  If it was always used by every call chain, I'd see your point,
> but we have call chains which don't use it, and so it adds complexity.

Where is the call chain B, please?

> 
>> As your concern for a 'new' caller, since __split_huge_page is a static helper here, no distub for anyothers.
> Even though it's static, there may be other callers within the same file.
> Or somebody may decide to make it non-static in the future.  I think it's
> actually clearer to keep the irqflags as a separate parameter.
> 

But it's no one else using this function now. and no one get disturb, right? It's non sense to consider a 'possibility' issue.

