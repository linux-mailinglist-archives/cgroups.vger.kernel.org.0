Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D785105294
	for <lists+cgroups@lfdr.de>; Thu, 21 Nov 2019 14:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfKUNDo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Nov 2019 08:03:44 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:39098 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbfKUNDo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Nov 2019 08:03:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Tij7W01_1574341419;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Tij7W01_1574341419)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Nov 2019 21:03:39 +0800
Subject: Re: [PATCH] mm: fix unsafe page -> lruvec lookups with cgroup charge
 migration
To:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20191120165847.423540-1-hannes@cmpxchg.org>
 <alpine.LSU.2.11.1911201836220.1090@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <14b15e52-9fff-5497-d30c-2c7c4b99c35a@linux.alibaba.com>
Date:   Thu, 21 Nov 2019 21:03:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1911201836220.1090@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


> It like the way you've rearranged isolate_lru_page() there, but I
> don't think it amounts to more than a cleanup.  Very good thinking
> about the odd "lruvec->pgdat = pgdat" case tucked away inside
> mem_cgroup_page_lruvec(), but actually, what harm does it do, if
> mem_cgroup_move_account() changes page->mem_cgroup concurrently?

Maybe the page could be added to root_mem_cgroup?

> 
> You say use-after-free, but we have spin_lock_irq here, and the
> struct mem_cgroup (and its lruvecs) cannot be freed until an RCU
> grace period expires, which we rely upon in many places, and which
> cannot happen until after the spin_unlock_irq.
> 
> And the same applies in the pagevec_lru_move functions, doesn't it?
> 
> I think now is not the time for such cleanups. If this fits well
> with Alex's per-lruvec locking (or represents an initial direction
> that you think he should follow), fine, but better to let him take it
> into his patchset in that case, than change the base unnecessarily
> underneath him.
> 
> (It happens to go against my own direction, since it separates the
> locking from the determination of lruvec, which I insist must be
> kept together; but perhaps that won't be quite the same for Alex.)
> 

It looks like we share the same base.

Before this patch, root memcg's lruvc lock could guards !PageLRU and it followings, But now, there are much holes in the wall. :)

Thanks
Alex
