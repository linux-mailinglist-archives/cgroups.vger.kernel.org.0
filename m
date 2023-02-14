Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C12C696DF5
	for <lists+cgroups@lfdr.de>; Tue, 14 Feb 2023 20:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjBNTcP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Feb 2023 14:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjBNTcO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Feb 2023 14:32:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF492CFF9;
        Tue, 14 Feb 2023 11:32:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CB379CE2209;
        Tue, 14 Feb 2023 19:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80D9C433EF;
        Tue, 14 Feb 2023 19:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676403127;
        bh=Fcfd+XUY443lS17mBcRjKXrbkxgWMqAwxcoIbwYGHKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9qpkspERTRIi+Leb8IhtQMgifKx4zfEwJxHOVJyt0mvyeXuGqF5zEaCuALu2Sm/s
         6PdXI5r0SCDKJvgD75s0aquFCymiUnbsITRT49SqpDKcQnGibnGrbGKo80N3Sl+wCo
         sYy1fYk8PjHZueGkaf5ZcOZWdsNxaQNfj1dTlueCAHXFRsEE4/KMF7cfRZHOiCeZvJ
         sAXLvzwg20UnL2ghQeeOJ1WFX6hfcNZVGtA7XL8GetYTT7Z5UXs+MLRBALbMFAkX7O
         YdnuV3q3KDAsNBLIH4B/hD/NhiZXbp4rf5IqRTmvJPcgPEo+DHB1Sl+BJWzBMYF/hm
         t4YH+RsjZnhtA==
From:   SeongJae Park <sj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        sj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
        mike.kravetz@oracle.com, willy@infradead.org,
        damon@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mm: change to return bool for isolate_lru_page()
Date:   Tue, 14 Feb 2023 19:32:04 +0000
Message-Id: <20230214193204.72057-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3635a17b9a0cf4be011a886415bf620b1c682ff6.1676382188.git.baolin.wang@linux.alibaba.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 14 Feb 2023 21:59:30 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> The isolate_lru_page() can only return 0 or -EBUSY, and most users did
> not care about the negative error of isolate_lru_page(), except one user
> in add_page_for_migration(). So we can convert the isolate_lru_page() to
> return a boolean value, which can help to make the code more clear when
> checking the return value of isolate_lru_page().
> 
> Also convert all users' logic of checking the isolation state.
> 
> No functional changes intended.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/folio-compat.c   | 12 +++---------
>  mm/internal.h       |  2 +-
>  mm/khugepaged.c     |  2 +-
>  mm/memcontrol.c     |  4 ++--
>  mm/memory-failure.c |  4 ++--
>  mm/memory_hotplug.c |  2 +-
>  mm/migrate.c        |  9 ++++++---
>  mm/migrate_device.c |  2 +-
>  8 files changed, 17 insertions(+), 20 deletions(-)
> 
[...]
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index a1e8c3e9ab08..17ed80707518 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1668,7 +1668,7 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  		 * LRU and non-lru movable pages.
>  		 */
>  		if (PageLRU(page))
> -			ret = isolate_lru_page(page);
> +			ret = !isolate_lru_page(page);

This may change return value of this function.  That is, this function will
return 1 instead of -EBUSY after this change.  It's not a real issue as no
caller of this function takes care of the return value, though.


Thanks,
SJ

>  		else
>  			ret = isolate_movable_page(page, ISOLATE_UNEVICTABLE);
>  		if (!ret) { /* Success */
[...]
