Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872792B3BE9
	for <lists+cgroups@lfdr.de>; Mon, 16 Nov 2020 04:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgKPDrE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 15 Nov 2020 22:47:04 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:46418 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726732AbgKPDrE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 15 Nov 2020 22:47:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0UFSqqZF_1605498418;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFSqqZF_1605498418)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 Nov 2020 11:46:59 +0800
Subject: Re: [PATCH v21 00/19] per memcg lru lock
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <c24610dd-a1f1-529d-5fdf-acdd1cc5060a@linux.alibaba.com>
Date:   Mon, 16 Nov 2020 11:45:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Andrew,

With all patches are acked-by Hugh and Johannes, and full testing from LKP,
is this patchset ready for more testing on linux-next? or anything still need
be improved?

Thanks
Alex


在 2020/11/5 下午4:55, Alex Shi 写道:
> This version rebase on next/master 20201104, with much of Johannes's
> Acks and some changes according to Johannes comments. And add a new patch
> v21-0006-mm-rmap-stop-store-reordering-issue-on-page-mapp.patch to support
> v21-0007.
> 
> This patchset followed 2 memcg VM_WARN_ON_ONCE_PAGE patches which were
> added to -mm tree yesterday.
>  
> Many thanks for line by line review by Hugh Dickins, Alexander Duyck and
> Johannes Weiner.
> 
> So now this patchset includes 3 parts:
> 1, some code cleanup and minimum optimization as a preparation. 
> 2, use TestCleanPageLRU as page isolation's precondition.
> 3, replace per node lru_lock with per memcg per node lru_lock.
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
> Daniel Jordan's testing show 62% improvement on modified readtwice case
> on his 2P * 10 core * 2 HT broadwell box on v18, which has no much different
> with this v20.
> https://lore.kernel.org/lkml/20200915165807.kpp7uhiw7l3loofu@ca-dmjordan1.us.oracle.com/
> 
> Thanks Hugh Dickins and Konstantin Khlebnikov, they both brought this
> idea 8 years ago, and others who give comments as well: Daniel Jordan, 
> Mel Gorman, Shakeel Butt, Matthew Wilcox, Alexander Duyck etc.
> 
> Thanks for Testing support from Intel 0day and Rong Chen, Fengguang Wu,
> and Yun Wang. Hugh Dickins also shared his kbuild-swap case. Thanks!
