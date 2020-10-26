Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C74298567
	for <lists+cgroups@lfdr.de>; Mon, 26 Oct 2020 02:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421205AbgJZBnU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 25 Oct 2020 21:43:20 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:54832 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1421204AbgJZBnT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 25 Oct 2020 21:43:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0UD7TiN9_1603676592;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UD7TiN9_1603676592)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 26 Oct 2020 09:43:13 +0800
Subject: Re: [PATCH v19 18/20] mm/lru: replace pgdat lru_lock with lruvec lock
To:     Hugh Dickins <hughd@google.com>, Rong Chen <rong.a.chen@intel.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yu Zhao <yuzhao@google.com>, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com, aaron.lwe@gmail.com,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        "lkp@linux.intel.com" <lkp@linux.intel.com>
References: <1600918115-22007-1-git-send-email-alex.shi@linux.alibaba.com>
 <1600918115-22007-19-git-send-email-alex.shi@linux.alibaba.com>
 <ef27dcbd-37fe-c16a-71ee-61709cc135f3@linux.alibaba.com>
 <alpine.LSU.2.11.2010251240030.2287@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <c1f1d964-7a55-8126-36b8-617c546bb536@linux.alibaba.com>
Date:   Mon, 26 Oct 2020 09:41:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2010251240030.2287@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/10/26 上午5:51, Hugh Dickins 写道:
> [PATCH] mm/lru: minimize workingset_age_nonresident() interference
> 
> 1. move_pages_to_lru() batch workingset_age_nonresident() (from Yu Zhao)
> 2. workingset_age_nonresident() after unlock of lru_lock (from Yu Zhao)
> 3. lru_note_cost_unlock_irq() to remove an unlock+lock of lru_lock
> 4. lru_note_cost_unlock_irq() include updates of nonresident_age
> 5. workingset_refault() use that OR workingset_age_nonresident()
> 
> Of those, I expect 1 & 2 (from Yu Zhao) to be the most significant,
> increasingly so with more cpus, increasingly so with more levels in
> the memcg hierarchy.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>

Hi Hugh,

Thanks a lot for checking and patch. I am in traveling today. So
just can pick and put it as lruv21 branch on my github tree:
https://github.com/alexshi/linux.git

Hi Rong,

We will very appreciate if you could launch testing on the branch
and it'd better, if you have time to change the test case time as 1k
second as Hugh wanted. Many thanks!

Thanks
Alex
