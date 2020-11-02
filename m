Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B872A3508
	for <lists+cgroups@lfdr.de>; Mon,  2 Nov 2020 21:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgKBUVu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Nov 2020 15:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKBUVu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Nov 2020 15:21:50 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323C6C0617A6
        for <cgroups@vger.kernel.org>; Mon,  2 Nov 2020 12:21:50 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id m14so10091577qtc.12
        for <cgroups@vger.kernel.org>; Mon, 02 Nov 2020 12:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KGaTJmrQfb84Zu/sOJ7IzGE95V5QBTb6nK7txU9KSJQ=;
        b=bBEKVnMgjoWujuv68Y0rl6eDm5sl+RLsRxWldpJosx8V8ORC5f5WNURvzRPF1NBv6v
         Hw8SkPEFiVazRpc8HtbAFv6rySvi+dOgYcijpf6DGivgxo6rHAxTkqYtg7KMW/nWj0FK
         jNVL3+jbG7w71qugmLw3Xz4ncKPZ2iWxLBTPPCt8BD1uQREeERQz3EX3KuToBY6VIz+L
         zWgI8CrMO0KLAeTkRYk8aUfxLK5LxOxKT8l/+pOHEe6cjDYpW8aCCLwlS41l8QROI6B/
         mwQYZlJ8/jHFIKB9IuKFrZteCWMQ5raxOMQKUfKXvcqF/2zfCoNEJ2DCqrzBN7oVKQ3f
         3fMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KGaTJmrQfb84Zu/sOJ7IzGE95V5QBTb6nK7txU9KSJQ=;
        b=Ai+1Mtr50ud7wXrFFktX3+33VyuqCRdw5XuzQqdXsNTP9XA0evrfoER5X5kvsBUdIz
         In/7fifR/2d//h1fEY9pTZrntCqR81RoV4CroZHrWhyE4UPGT/nX5mCxcrq8bd9y9Nsg
         hOWvT4kaCaScxO8nmbIQDaZdtO3811amlUXq6uu2Ll4f/ex7pKn5tzhBHoxJUKJXljk2
         tf6cEgGP/srdSYc1J5wkDzy/rdbWtaBNefWCpPUmj/qmXapTQVBQHCkd81w8Rxdn2B4f
         Cjg/V1Wz7sAoSswOaM60d3Ad+88KZybcm2uU4Fd7BWdbgrxx/TukPFkTXF40uzgUwuw3
         7upg==
X-Gm-Message-State: AOAM530RQgZh7+6Xp0iQgIoGINmWk74ZpkawAEL4pH16vck+wJLVS63t
        i37rkMp7IrRwFtUXUXYjmlA1XA==
X-Google-Smtp-Source: ABdhPJwJQ2pszo1xApCrT+kXkRvTKT2LgFbWrFGxrHm118eNGOEBxjD4Dibd0ztWDPiArgTklCLYGg==
X-Received: by 2002:ac8:76d9:: with SMTP id q25mr16151275qtr.125.1604348509453;
        Mon, 02 Nov 2020 12:21:49 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2f6e])
        by smtp.gmail.com with ESMTPSA id 6sm8812740qks.51.2020.11.02.12.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:21:48 -0800 (PST)
Date:   Mon, 2 Nov 2020 15:20:03 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        lkp@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v20 08/20] mm: page_idle_get_page() does not need lru_lock
Message-ID: <20201102202003.GA740958@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-9-git-send-email-alex.shi@linux.alibaba.com>
 <20201102144110.GB724984@cmpxchg.org>
 <20201102144927.GN27442@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102144927.GN27442@casper.infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 02, 2020 at 02:49:27PM +0000, Matthew Wilcox wrote:
> On Mon, Nov 02, 2020 at 09:41:10AM -0500, Johannes Weiner wrote:
> > On Thu, Oct 29, 2020 at 06:44:53PM +0800, Alex Shi wrote:
> > > From: Hugh Dickins <hughd@google.com>
> > > 
> > > It is necessary for page_idle_get_page() to recheck PageLRU() after
> > > get_page_unless_zero(), but holding lru_lock around that serves no
> > > useful purpose, and adds to lru_lock contention: delete it.
> > > 
> > > See https://lore.kernel.org/lkml/20150504031722.GA2768@blaptop for the
> > > discussion that led to lru_lock there; but __page_set_anon_rmap() now
> > > uses WRITE_ONCE(),
> > 
> > That doesn't seem to be the case in Linus's or Andrew's tree. Am I
> > missing a dependent patch series?
> > 
> > > and I see no other risk in page_idle_clear_pte_refs() using
> > > rmap_walk() (beyond the risk of racing PageAnon->PageKsm, mostly but
> > > not entirely prevented by page_count() check in ksm.c's
> > > write_protect_page(): that risk being shared with page_referenced()
> > > and not helped by lru_lock).
> > 
> > Isn't it possible, as per Minchan's description, for page->mapping to
> > point to a struct anon_vma without PAGE_MAPPING_ANON set, and rmap
> > thinking it's looking at a struct address_space?
> 
> I don't think it can point to an anon_vma without the ANON bit set.
> Minchan's concern in that email was that it might still be NULL.

Hm, no, the thread is a lengthy discussion about whether the store
could be split such that page->mapping is actually pointing to
something invalid (anon_vma without the PageAnon bit).

From his email:

        CPU 0                                                                           CPU 1

do_anonymous_page
  __page_set_anon_rmap
  /* out of order happened so SetPageLRU is done ahead */
  SetPageLRU(page)
  /* Compilr changed store operation like below */
  page->mapping = (struct address_space *) anon_vma;
  /* Big stall happens */
                                                                /* idletacking judged it as LRU page so pass the page
                                                                   in page_reference */
                                                                page_refernced
                                                                        page_rmapping return true because
                                                                        page->mapping has some vaule but not complete
                                                                        so it calls rmap_walk_file.
                                                                        it's okay to pass non-completed anon page in rmap_walk_file?
