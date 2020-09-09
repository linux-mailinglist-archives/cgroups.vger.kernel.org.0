Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E18E262527
	for <lists+cgroups@lfdr.de>; Wed,  9 Sep 2020 04:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIICYY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Sep 2020 22:24:24 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:42086 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbgIICYY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Sep 2020 22:24:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0U8MLMVV_1599618258;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U8MLMVV_1599618258)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Sep 2020 10:24:19 +0800
Date:   Wed, 9 Sep 2020 10:24:18 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, vbabka@suse.cz, minchan@kernel.org, cai@lca.pw
Subject: Re: [PATCH v18 00/32] per memcg lru_lock: reviews
Message-ID: <20200909022418.GA14584@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
 <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
 <alpine.LSU.2.11.2008262301240.4405@eggly.anvils>
 <alpine.LSU.2.11.2009081640070.7256@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2009081640070.7256@eggly.anvils>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 08, 2020 at 04:41:00PM -0700, Hugh Dickins wrote:
[...]
>[PATCH v18 06/32] mm/thp: narrow lru locking
>Why? What part does this play in the series? "narrow lru locking" can
>also be described as "widen page cache locking": you are changing the
>lock ordering, and not giving any reason to do so. This may be an
>excellent change, or it may be a terrible change: I find that usually
>lock ordering is forced upon us, and it's rare to meet an instance like
>this that could go either way, and I don't know myself how to judge it.
>
>I do want this commit to go in, partly because it has been present in
>all the testing we have done, and partly because I *can at last* see a
>logical advantage to it - it also nests lru_lock inside memcg->move_lock,
>allowing lock_page_memcg() to be used to stabilize page->mem_cgroup when
>getting per-memcg lru_lock - though only in one place, starting in v17,
>do you actually use that (and, warning: it's not used correctly there).
>
>I'm not very bothered by how the local_irq_disable() looks to RT: THP
>seems a very bad idea in an RT kernel.  Earlier I asked you to run this
>past Kirill and Matthew and Johannes: you did so, thank you, and Kirill
>has blessed it, and no one has nacked it, and I have not noticed any
>disadvantage from this change in lock ordering (documented in 23/32),
>so I'm now going to say
>
>Acked-by: Hugh Dickins <hughd@google.com>
>
>But I wish you could give some reason for it in the commit message!
>
>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>Is that correct? Or Wei Yang suggested some part of it perhaps?
>

If my memory is correct, we had some offline discussion about this change.

-- 
Wei Yang
Help you, Help me
