Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02F92A8272
	for <lists+cgroups@lfdr.de>; Thu,  5 Nov 2020 16:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgKEPoW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Nov 2020 10:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730660AbgKEPoV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Nov 2020 10:44:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FCDC0613CF;
        Thu,  5 Nov 2020 07:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ak6ESadBcps7kJu00eYxbLPP9OazYAE8zIQ9Ca8IMrU=; b=oUe9xJv58WdNmKxA4k7ReOGJzG
        wNDtZuuG3dlslzXqPfSb5s5TqkLIPrMV9w0DfCQivxQTt7o8dane0CtTTK2oEtGUiSa/p5RIDDPt3
        BMQUONTXOZtSt6N/jl45jAUnJtLCOGJwtI2FHGHimgx1Gb/+gn1vy9+naRt7EQna2f6w3JYQsOxhN
        LGfE+lIdjhnAW9EyHRCnv33KdxFrqD7ZMeP2sBzj/W2PlXOE2O23dXqxwE2s0sYellkWMqnx4vdY8
        7if7PzFgSqNMpqKHbm0pFd5Zegwku1Zy1hgTC3KLrdpy4ss4jbgY7jgtAmYNMyN6KNqRE9/8lySUU
        IlRCVxdw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kahQX-0001mX-Rl; Thu, 05 Nov 2020 15:43:53 +0000
Date:   Thu, 5 Nov 2020 15:43:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
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
Message-ID: <20201105154353.GN17076@casper.infradead.org>
References: <1603968305-8026-9-git-send-email-alex.shi@linux.alibaba.com>
 <20201102144110.GB724984@cmpxchg.org>
 <20201102144927.GN27442@casper.infradead.org>
 <20201102202003.GA740958@cmpxchg.org>
 <b4038b87-cf5a-fcb7-06f4-b98874029615@linux.alibaba.com>
 <20201104174603.GB744831@cmpxchg.org>
 <6eea82d8-e406-06ee-2333-eb6e2f1944e5@linux.alibaba.com>
 <20201105045702.GI17076@casper.infradead.org>
 <1e8f0162-cf2e-03eb-e7e0-ccc9f6a3eaf2@linux.alibaba.com>
 <20201105153649.GC744831@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105153649.GC744831@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 05, 2020 at 10:36:49AM -0500, Johannes Weiner wrote:
> But the code is highly specific - synchronizing one struct page member
> for one particular use case. Let's keep at least a reference to what
> we are synchronizing against. There is a non-zero chance that if the
> comment goes out of date, so does the code. How about this?
> 
> 	/*
> 	 * page_idle does a lockless/optimistic rmap scan on page->mapping.
> 	 * Make sure the compiler doesn't split the stores of anon_vma and
> 	 * the PAGE_MAPPING_ANON type identifier, otherwise the rmap code
> 	 * could mistake the mapping for a struct address_space and crash.
> 	 */

Fine by me!  There may be other cases where seeing a split store would
be bad, so I didn't want to call out page_idle explicitly.  But if you
want to, I'm happy with this comment.
