Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E8220274B
	for <lists+cgroups@lfdr.de>; Sun, 21 Jun 2020 01:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgFTXIJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 20 Jun 2020 19:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728625AbgFTXIJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 20 Jun 2020 19:08:09 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BF722474A;
        Sat, 20 Jun 2020 23:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592694488;
        bh=2IEhfBYyQCSyZpnt+8yfDe7vxNgCoT7PUvnS8+aWFus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p2z32yzBQhfcyRgHHNzs+5IIrjXsczCwFLqNTLfNQZAgGw2PskunGFm17A39sq7F7
         h5teGa9mbxApkzTetkvnhBrzC0Q/6z12nDNoEFjq+RsTefTJN/7BmVbrlNyygUWIN+
         YZXHA6FESindISNeo/FJ3Fbf/7UT2GK19N71Vke0=
Date:   Sat, 20 Jun 2020 16:08:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v13 00/18] per memcg lru lock
Message-Id: <20200620160807.0e0997c3e0e3ca1b18e68a53@linux-foundation.org>
In-Reply-To: <1592555636-115095-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1592555636-115095-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 19 Jun 2020 16:33:38 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:

> This is a new version which bases on linux-next, merged much suggestion
> from Hugh Dickins, from compaction fix to less TestClearPageLRU and
> comments reverse etc. Thank a lot, Hugh!
> 
> Johannes Weiner has suggested:
> "So here is a crazy idea that may be worth exploring:
> 
> Right now, pgdat->lru_lock protects both PageLRU *and* the lruvec's
> linked list.
> 
> Can we make PageLRU atomic and use it to stabilize the lru_lock
> instead, and then use the lru_lock only serialize list operations?

I don't understand this sentence.  How can a per-page flag stabilize a
per-pgdat spinlock?  Perhaps some additional description will help.

> ..."
> 
> With new memcg charge path and this solution, we could isolate
> LRU pages to exclusive visit them in compaction, page migration, reclaim,
> memcg move_accunt, huge page split etc scenarios while keeping pages' 
> memcg stable. Then possible to change per node lru locking to per memcg
> lru locking. As to pagevec_lru_move_fn funcs, it would be safe to let
> pages remain on lru list, lru lock could guard them for list integrity.
> 
> The patchset includes 3 parts:
> 1, some code cleanup and minimum optimization as a preparation.
> 2, use TestCleanPageLRU as page isolation's precondition
> 3, replace per node lru_lock with per memcg per node lru_lock
> 
> The 3rd part moves per node lru_lock into lruvec, thus bring a lru_lock for
> each of memcg per node. So on a large machine, each of memcg don't
> have to suffer from per node pgdat->lru_lock competition. They could go
> fast with their self lru_lock
> 
> Following Daniel Jordan's suggestion, I have run 208 'dd' with on 104
> containers on a 2s * 26cores * HT box with a modefied case:
> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice
> 
> With this patchset, the readtwice performance increased about 80%
> in concurrent containers.
> 
> Thanks Hugh Dickins and Konstantin Khlebnikov, they both brought this
> idea 8 years ago, and others who give comments as well: Daniel Jordan, 
> Mel Gorman, Shakeel Butt, Matthew Wilcox etc.
> 
> Thanks for Testing support from Intel 0day and Rong Chen, Fengguang Wu,
> and Yun Wang. Hugh Dickins also shared his kbuild-swap case. Thanks!
> 
> ...
>
>  24 files changed, 500 insertions(+), 357 deletions(-)

It's a large patchset and afaict the whole point is performance gain. 
80% in one specialized test sounds nice, but is there a plan for more
extensive quantification?

There isn't much sign of completed review activity here, so I'll go
into hiding for a while.
