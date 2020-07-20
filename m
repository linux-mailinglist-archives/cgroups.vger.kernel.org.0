Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4CA22560A
	for <lists+cgroups@lfdr.de>; Mon, 20 Jul 2020 05:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgGTDBS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Jul 2020 23:01:18 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:43620 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726312AbgGTDBS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 19 Jul 2020 23:01:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0U3AgGSF_1595214071;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U3AgGSF_1595214071)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Jul 2020 11:01:12 +0800
Subject: Re: [PATCH v16 00/22] per memcg lru_lock
To:     Hugh Dickins <hughd@google.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UcKVyTXQ=tGv_uMV+fSvoH_-cuG9zA_zhE+S8Ou11gt=w@mail.gmail.com>
 <57c619e7-da7e-198e-3de8-530bf19b9450@linux.alibaba.com>
 <alpine.LSU.2.11.2007190801490.3521@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <5f2401d3-dd4f-cbc6-8cb4-4e92fc64998c@linux.alibaba.com>
Date:   Mon, 20 Jul 2020 11:01:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2007190801490.3521@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/7/19 下午11:23, Hugh Dickins 写道:
> I noticed that 5.8-rc5, with lrulock v16 applied, took significantly
> longer to run loads than without it applied, when there should have been
> only slight differences in system time. Comparing /proc/vmstat, something
> that stood out was "pgrotated 0" for the patched kernels, which led here:
> 
> If pagevec_lru_move_fn() is now to TestClearPageLRU (I have still not
> decided whether that's good or not, but assume here that it is good),
> then functions called though it must be changed not to expect PageLRU!
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Good catch!

Thanks a lot, Hugh! 
except 6 changes should apply, looks we add one more in swap.c file to stop
!PageRLU further actions!

Many Thanks!
Alex

@@ -649,7 +647,7 @@ void deactivate_file_page(struct page *page)
         * In a workload with many unevictable page such as mprotect,
         * unevictable page deactivation for accelerating reclaim is pointless.
         */
-       if (PageUnevictable(page))
+       if (PageUnevictable(page) || !PageLRU(page))
                return;

        if (likely(get_page_unless_zero(page))) {
