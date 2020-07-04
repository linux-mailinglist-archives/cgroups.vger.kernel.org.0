Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FAA214551
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2020 13:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgGDLf3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 4 Jul 2020 07:35:29 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:35164 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbgGDLf3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 4 Jul 2020 07:35:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U1eyb8d_1593862524;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U1eyb8d_1593862524)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 04 Jul 2020 19:35:24 +0800
Subject: Re: [PATCH v14 15/20] mm/swap: serialize memcg changes during
 pagevec_lru_move_fn
To:     Konstantin Khlebnikov <koct9i@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0g0KXQu9C10LHQvdC40LrQvtCy?= 
        <khlebnikov@yandex-team.ru>, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, lkp@intel.com,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, shakeelb@google.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, richard.weiyang@gmail.com
References: <1593752873-4493-1-git-send-email-alex.shi@linux.alibaba.com>
 <1593752873-4493-16-git-send-email-alex.shi@linux.alibaba.com>
 <CALYGNiOkA_ZsycF_hqm3XLk55Ek1Mo9w1gO=6EeE35fUtA0i_w@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <56e395c6-81e7-7163-0d4f-42b91573289f@linux.alibaba.com>
Date:   Sat, 4 Jul 2020 19:34:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CALYGNiOkA_ZsycF_hqm3XLk55Ek1Mo9w1gO=6EeE35fUtA0i_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2020/7/3 下午5:13, Konstantin Khlebnikov 写道:
>> @@ -976,7 +983,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
>>   */
>>  void __pagevec_lru_add(struct pagevec *pvec)
>>  {
>> -       pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn);
>> +       pagevec_lru_move_fn(pvec, __pagevec_lru_add_fn, true);
>>  }
> It seems better to open code version in lru_add than adding a bool
> argument which is true just for one user.

Right, I will rewrite this part as your suggestion. Thanks!

> 
> Also with this new lru protection logic lru_add could be optimized:
> It could prepare a list of pages and under lru_lock do only list
> splice and bumping counter.
> Since PageLRU isn't set yet nobody could touch these pages in lru.
> After that lru_add could iterate pages from first to last without
> lru_lock to set PageLRU and drop reference.
> 
> So, lru_add will do O(1) operations under lru_lock regardless of the
> count of pages it added.
> 
> Actually per-cpu vector for adding could be replaced with per-cpu
> lists and\or per-lruvec atomic slist.
> Thus incommig pages will be already in list structure rather than page vector.
> This allows to accumulate more pages and offload adding to kswapd or
> direct reclaim.
> 

That's a great idea! Guess what the new struct we need would be like this?
I like to try this. :)


diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 081d934eda64..d62778c8c184 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -20,7 +20,7 @@
 struct pagevec {
        unsigned char nr;
        bool percpu_pvec_drained;
-       struct page *pages[PAGEVEC_SIZE];
+       struct list_head veclist;
 };
