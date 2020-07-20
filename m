Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE20225877
	for <lists+cgroups@lfdr.de>; Mon, 20 Jul 2020 09:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgGTHaV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Jul 2020 03:30:21 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:60734 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbgGTHaV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Jul 2020 03:30:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0U3DnCGw_1595230215;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U3DnCGw_1595230215)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Jul 2020 15:30:16 +0800
Subject: Re: [PATCH v16 00/22] per memcg lru_lock
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <04a2ad99-5d88-a300-6430-7a8da0946f04@linux.alibaba.com>
Date:   Mon, 20 Jul 2020 15:30:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


I am preparing/testing the patch v17 according comments from Hugh Dickins
and Alexander Duyck. 
Many thanks for line by line review and patient suggestion!

Please drop me any more comments or concern of any patches!

Thanks a lot!
Alex

在 2020/7/11 上午8:58, Alex Shi 写道:
> The new version which bases on v5.8-rc4. Add 2 more patchs:
> 'mm/thp: remove code path which never got into'
> 'mm/thp: add tail pages into lru anyway in split_huge_page()'
> and modified 'mm/mlock: reorder isolation sequence during munlock'
> 
> Current lru_lock is one for each of node, pgdat->lru_lock, that guard for
> lru lists, but now we had moved the lru lists into memcg for long time. Still
> using per node lru_lock is clearly unscalable, pages on each of memcgs have
> to compete each others for a whole lru_lock. This patchset try to use per
> lruvec/memcg lru_lock to repleace per node lru lock to guard lru lists, make
> it scalable for memcgs and get performance gain.
> 
> Currently lru_lock still guards both lru list and page's lru bit, that's ok.
> but if we want to use specific lruvec lock on the page, we need to pin down
> the page's lruvec/memcg during locking. Just taking lruvec lock first may be
> undermined by the page's memcg charge/migration. To fix this problem, we could
> take out the page's lru bit clear and use it as pin down action to block the
> memcg changes. That's the reason for new atomic func TestClearPageLRU.
> So now isolating a page need both actions: TestClearPageLRU and hold the
> lru_lock.
> 
> The typical usage of this is isolate_migratepages_block() in compaction.c
> we have to take lru bit before lru lock, that serialized the page isolation
> in memcg page charge/migration which will change page's lruvec and new 
> lru_lock in it.
> 
> The above solution suggested by Johannes Weiner, and based on his new memcg 
> charge path, then have this patchset. (Hugh Dickins tested and contributed much
> code from compaction fix to general code polish, thanks a lot!).
> 
> The patchset includes 3 parts:
> 1, some code cleanup and minimum optimization as a preparation.
> 2, use TestCleanPageLRU as page isolation's precondition
> 3, replace per node lru_lock with per memcg per node lru_lock
> 
> Following Daniel Jordan's suggestion, I have run 208 'dd' with on 104
> containers on a 2s * 26cores * HT box with a modefied case:
> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice
> With this patchset, the readtwice performance increased about 80%
> in concurrent containers.
> 
> Thanks Hugh Dickins and Konstantin Khlebnikov, they both brought this
> idea 8 years ago, and others who give comments as well: Daniel Jordan, 
> Mel Gorman, Shakeel Butt, Matthew Wilcox etc.
> 
> Thanks for Testing support from Intel 0day and Rong Chen, Fengguang Wu,
> and Yun Wang. Hugh Dickins also shared his kbuild-swap case. Thanks!
