Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0A8202B75
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2020 17:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbgFUPpt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 21 Jun 2020 11:45:49 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:54361 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730359AbgFUPpt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 21 Jun 2020 11:45:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U0FRv8j_1592754341;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U0FRv8j_1592754341)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 21 Jun 2020 23:45:42 +0800
Subject: Re: [PATCH v13 00/18] per memcg lru lock
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com
References: <1592555636-115095-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200620160807.0e0997c3e0e3ca1b18e68a53@linux-foundation.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <5561f72b-8f9a-f84e-94a4-600c66084f29@linux.alibaba.com>
Date:   Sun, 21 Jun 2020 23:44:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200620160807.0e0997c3e0e3ca1b18e68a53@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/6/21 ÉÏÎç7:08, Andrew Morton Ð´µÀ:
> On Fri, 19 Jun 2020 16:33:38 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:
> 
>> This is a new version which bases on linux-next, merged much suggestion
>> from Hugh Dickins, from compaction fix to less TestClearPageLRU and
>> comments reverse etc. Thank a lot, Hugh!
>>
>> Johannes Weiner has suggested:
>> "So here is a crazy idea that may be worth exploring:
>>
>> Right now, pgdat->lru_lock protects both PageLRU *and* the lruvec's
>> linked list.
>>
>> Can we make PageLRU atomic and use it to stabilize the lru_lock
>> instead, and then use the lru_lock only serialize list operations?
> 
> I don't understand this sentence.  How can a per-page flag stabilize a
> per-pgdat spinlock?  Perhaps some additional description will help.

Hi Andrew,

Well, above comments miss a context, which lru_lock means new lru_lock on each
of memcg not the current per node lru_lock. Sorry!

Currently the lru bit changed under lru_lock, so isolate a page from lru just
need take lru_lock. New patch will change it with a atomic action alone from 
lru_lock, so isolate a page need both actions: TestClearPageLRU and take the
lru_lock. like followings in isolate_lru_page():

The main reason for this comes from isolate_migratepages_block() in compaction.c
we have to take lru bit before lru lock, that serialized the page isolation in 
memcg page charge/migration which will change page's lruvec and new lru_lock
in it. The current isolation just take lru lock directly which fails on guard 
page's lruvec change(memcg change).

changes in isolate_lru_page():-	if (PageLRU(page)) {
+	if (TestClearPageLRU(page)) {
 		pg_data_t *pgdat = page_pgdat(page);
 		struct lruvec *lruvec;
+		int lru = page_lru(page);
 
-		spin_lock_irq(&pgdat->lru_lock);
+		get_page(page);
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
-		if (PageLRU(page)) {
-			int lru = page_lru(page);
-			get_page(page);
-			ClearPageLRU(page);
-			del_page_from_lru_list(page, lruvec, lru);
-			ret = 0;
-		}
+		spin_lock_irq(&pgdat->lru_lock);
+		del_page_from_lru_list(page, lruvec, lru);
 		spin_unlock_irq(&pgdat->lru_lock);
+		ret = 0;
 	}

> 

>>
>> Following Daniel Jordan's suggestion, I have run 208 'dd' with on 104
>> containers on a 2s * 26cores * HT box with a modefied case:
>> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice
>>
>> With this patchset, the readtwice performance increased about 80%
>> in concurrent containers.
>>
>> Thanks Hugh Dickins and Konstantin Khlebnikov, they both brought this
>> idea 8 years ago, and others who give comments as well: Daniel Jordan, 
>> Mel Gorman, Shakeel Butt, Matthew Wilcox etc.
>>
>> Thanks for Testing support from Intel 0day and Rong Chen, Fengguang Wu,
>> and Yun Wang. Hugh Dickins also shared his kbuild-swap case. Thanks!
>>
>> ...
>>
>>  24 files changed, 500 insertions(+), 357 deletions(-)
> 
> It's a large patchset and afaict the whole point is performance gain. 
> 80% in one specialized test sounds nice, but is there a plan for more
> extensive quantification?

Once I got 5% aim7 performance gain on 16 cores machine, and about 20+%
readtwice performance gain. the performance gain is increased a lot following
larger cores.

Is there some suggestion for this?

> 
> There isn't much sign of completed review activity here, so I'll go
> into hiding for a while.
> 

Yes, it's relatively big. also much of change from comments part. :)
Anyway, thanks for look into!

Thanks
Alex
