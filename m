Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1ED27395A
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 05:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgIVDlP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Sep 2020 23:41:15 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:60106 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbgIVDlP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Sep 2020 23:41:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U9k1-kp_1600746071;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U9k1-kp_1600746071)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Sep 2020 11:41:12 +0800
Subject: Re: [PATCH v18 15/32] mm/lru: move lock into lru_note_cost
To:     Hugh Dickins <hughd@google.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <1598273705-69124-16-git-send-email-alex.shi@linux.alibaba.com>
 <alpine.LSU.2.11.2009211434490.5214@eggly.anvils>
 <alpine.LSU.2.11.2009211440570.5214@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <323ae796-a547-3ac3-b4fd-68a4ac180690@linux.alibaba.com>
Date:   Tue, 22 Sep 2020 11:39:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2009211440570.5214@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/9/22 ÉÏÎç6:03, Hugh Dickins Ð´µÀ:
>> Acked-by: Hugh Dickins <hughd@google.com>
>>
>> In your lruv19 github tree, you have merged 14/32 into this one: thanks.
> Grr, I've only just started, and already missed some of my notes.
> 
> I wanted to point out that this patch does introduce an extra unlock+lock
> in shrink_inactive_list(), even in a !CONFIG_MEMCG build.  I think you've
> done the right thing for now, keeping it simple, and maybe nobody will
> notice the extra overhead; but I expect us to replace lru_note_cost()
> by lru_note_cost_unlock_irq() later on, expecting the caller to do the
> initial lock_irq().
> 
> lru_note_cost_page() looks redundant to me, but you're right not to
> delete it here, unless Johannes asks you to add that in: that's his
> business, and it may be dependent on the XXX at its callsite.
> 

Thanks for comments! And got your point. so I will leave this patch alone.

Thanks!
