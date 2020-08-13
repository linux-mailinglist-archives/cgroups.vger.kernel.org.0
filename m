Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A51243443
	for <lists+cgroups@lfdr.de>; Thu, 13 Aug 2020 08:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHMG5L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Aug 2020 02:57:11 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:41935 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725982AbgHMG5L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Aug 2020 02:57:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0U5dLrE0_1597301826;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U5dLrE0_1597301826)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Aug 2020 14:57:08 +0800
Subject: Re: [RFC PATCH 1/3] mm: Drop locked from isolate_migratepages_block
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     yang.shi@linux.alibaba.com, lkp@intel.com, rong.a.chen@intel.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name, hughd@google.com,
        linux-kernel@vger.kernel.org, daniel.m.jordan@oracle.com,
        linux-mm@kvack.org, shakeelb@google.com, willy@infradead.org,
        hannes@cmpxchg.org, tj@kernel.org, cgroups@vger.kernel.org,
        akpm@linux-foundation.org, richard.weiyang@gmail.com,
        mgorman@techsingularity.net, iamjoonsoo.kim@lge.com
References: <20200813035100.13054.25671.stgit@localhost.localdomain>
 <20200813040224.13054.96724.stgit@localhost.localdomain>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <8ea9e186-b223-fb1b-5c82-2aa43c5e9f10@linux.alibaba.com>
Date:   Thu, 13 Aug 2020 14:56:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200813040224.13054.96724.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/8/13 下午12:02, Alexander Duyck 写道:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> We can drop the need for the locked variable by making use of the
> lruvec_holds_page_lru_lock function. By doing this we can avoid some rcu
> locking ugliness for the case where the lruvec is still holding the LRU
> lock associated with the page. Instead we can just use the lruvec and if it
> is NULL we assume the lock was released.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  mm/compaction.c |   45 ++++++++++++++++++++-------------------------
>  1 file changed, 20 insertions(+), 25 deletions(-)

Thanks a lot!
Don't know if community is ok if we keep the patch following whole patchset alone?

