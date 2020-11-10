Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A22F2ADF17
	for <lists+cgroups@lfdr.de>; Tue, 10 Nov 2020 20:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbgKJTIZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Nov 2020 14:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731350AbgKJTIY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Nov 2020 14:08:24 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC56C0613D3
        for <cgroups@vger.kernel.org>; Tue, 10 Nov 2020 11:08:24 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id g15so5669113qtq.13
        for <cgroups@vger.kernel.org>; Tue, 10 Nov 2020 11:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o/P6FAAbZyAhrgG09vfP1BCKKHct1LeQm/LdrSl6xbo=;
        b=SEkve2d6VJEm0fVm001sIsH50qhvSC+fkG3XYb4FWVK0N4jo3NezX45gV3V1c2JJxR
         RlB9BUM6fCLmSo3s6Y+Ijb8MGuKJEYSBWECV+upj1zkIkqu9mmBWoc3OHP5rnb7Z8dMI
         XqnnLdzqv17RKQKD79XOWA0pV6et/HWzqgsbx8EIrk+jEXGI7wXbGmDPKkz87HtaKW2k
         ynWMuyHTCvF6/PVzX8n0E5VJp1o/mlS6Z9aZR3UXWdad07hThGZp/CFnMmCPtki3dz9U
         Uhu2qAohDJR7toQ5Ir44j97UxPf8mIj/iyXfszUSca9FeYv2Wgvw3oDYY6qsSTqVH0lq
         B18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o/P6FAAbZyAhrgG09vfP1BCKKHct1LeQm/LdrSl6xbo=;
        b=GExcFF+aw0TE5UlobFYbniohdzgJFhIWKtz2oQ+ltS1nhmBXK7rzcHwLc9hW4uSBmc
         TgpDvaqE/yETx01VBCwhK4DjMEm9/ahm9B0j4Ieb6fTj+tYNABhmdEVYqRBnf019oNPc
         OwChXrtrLykg97ST89yGaIDBiQN8fubIR2nGP8Ozj2EJexq82MQP4xARCsfxCtxvVjEu
         HgLqVzPPxdN0glv9TrGAO09O53jAZnhCqWu3R1ndIUBoHDrQK1sLi3jy1NW2/YsbU3u+
         V5WibLxmAH+VQgcnjcnOpUlc/qTRcXQulhVJ4Otelh5HD22CjcdtK5Oqq85GKgwKUzQ5
         tKIQ==
X-Gm-Message-State: AOAM533mG/9qpcG2CsSbILOa+QBtJFufiQ5vQq4X+hvg7SumQ2DSz+5m
        qIvSQMd1j5deVWsSUizSxVvBSg==
X-Google-Smtp-Source: ABdhPJzfQAT2OcEe14YYdZG0nE07YVG6i4U3vEP7T4ecgGBzSVYiOwyA3Q/DQDNUkOxmRz3uaExLTg==
X-Received: by 2002:ac8:d48:: with SMTP id r8mr19575791qti.69.1605035303894;
        Tue, 10 Nov 2020 11:08:23 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:64f7])
        by smtp.gmail.com with ESMTPSA id y17sm9007791qki.134.2020.11.10.11.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:08:22 -0800 (PST)
Date:   Tue, 10 Nov 2020 14:06:35 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v21 06/19] mm/rmap: stop store reordering issue on
 page->mapping
Message-ID: <20201110190635.GE850433@cmpxchg.org>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
 <1604566549-62481-7-git-send-email-alex.shi@linux.alibaba.com>
 <e66ef2e5-c74c-6498-e8b3-56c37b9d2d15@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e66ef2e5-c74c-6498-e8b3-56c37b9d2d15@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 06, 2020 at 09:20:04AM +0800, Alex Shi wrote:
> From 2fd278b1ca6c3e260ad249808b62f671d8db5a7b Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linux.alibaba.com>
> Date: Thu, 5 Nov 2020 11:38:24 +0800
> Subject: [PATCH v21 06/19] mm/rmap: stop store reordering issue on
>  page->mapping
> 
> Hugh Dickins and Minchan Kim observed a long time issue which
> discussed here, but actully the mentioned fix missed.
> https://lore.kernel.org/lkml/20150504031722.GA2768@blaptop/
> The store reordering may cause problem in the scenario:
> 
> 	CPU 0						CPU1
>    do_anonymous_page
> 	page_add_new_anon_rmap()
> 	  page->mapping = anon_vma + PAGE_MAPPING_ANON
> 	lru_cache_add_inactive_or_unevictable()
> 	  spin_lock(lruvec->lock)
> 	  SetPageLRU()
> 	  spin_unlock(lruvec->lock)
> 						/* idletacking judged it as LRU
> 						 * page so pass the page in
> 						 * page_idle_clear_pte_refs
> 						 */
> 						page_idle_clear_pte_refs
> 						  rmap_walk
> 						    if PageAnon(page)
> 
> Johannes give detailed examples how the store reordering could cause
> a trouble:
> "The concern is the SetPageLRU may get reorder before 'page->mapping'
> setting, That would make CPU 1 will observe at page->mapping after
> observing PageLRU set on the page.
> 
> 1. anon_vma + PAGE_MAPPING_ANON
> 
>    That's the in-order scenario and is fine.
> 
> 2. NULL
> 
>    That's possible if the page->mapping store gets reordered to occur
>    after SetPageLRU. That's fine too because we check for it.
> 
> 3. anon_vma without the PAGE_MAPPING_ANON bit
> 
>    That would be a problem and could lead to all kinds of undesirable
>    behavior including crashes and data corruption.
> 
>    Is it possible? AFAICT the compiler is allowed to tear the store to
>    page->mapping and I don't see anything that would prevent it.
> 
> That said, I also don't see how the reader testing PageLRU under the
> lru_lock would prevent that in the first place. AFAICT we need that
> WRITE_ONCE() around the page->mapping assignment."
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks Alex!
