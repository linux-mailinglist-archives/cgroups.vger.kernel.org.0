Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A142F26372C
	for <lists+cgroups@lfdr.de>; Wed,  9 Sep 2020 22:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIIUQD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Sep 2020 16:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIUQA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Sep 2020 16:16:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E24C061573;
        Wed,  9 Sep 2020 13:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bw4rIJZLeK5WfU3TO9eMUF05YqQkLW/1cl+vzePNNf8=; b=iG6nBaZ2r0xjMc/5udrwMFgvVe
        zUDTE0FRIJKDA3f55Mj+WKsuMCkMrHGPVAgxs+CjEBF9K8DMTByr2eV/wyFcPvmVaNAeY9xTIqlOZ
        EH3nLSyN/oT93H3UyjXf1yValOLopcbpn3LFJsMi9LuSJgOzAT2F6nzyrkEgzOtPM85Kl/yajl+JY
        TL5tEsH6XBNI8KDUZBqbcFBznLuljUyY+vW9YlFRSz3iHlAQQ4a5F2JcCPtjiX1A+qizt0Ml+g35b
        CTKkt5fMZoPqXZNp7Sd7GqfcOLTiF/ol3aMbBxVvzoWXh/c3yqIjpa+1S7EGo6JxiWVpbEkf/03wb
        ciR5lr9g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kG6V8-0002Y4-CZ; Wed, 09 Sep 2020 20:15:30 +0000
Date:   Wed, 9 Sep 2020 21:15:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, shy828301@gmail.com,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH v18 31/32] mm: Add explicit page decrement in exception
 path for isolate_lru_pages
Message-ID: <20200909201530.GM6583@casper.infradead.org>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <1598273705-69124-32-git-send-email-alex.shi@linux.alibaba.com>
 <20200909010118.GB6583@casper.infradead.org>
 <CAKgT0UcjNx=00OgAQNWezc7UjLmF2NcDH0p7kzZ5D23PaFrFXA@mail.gmail.com>
 <alpine.LSU.2.11.2009091100280.9020@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2009091100280.9020@eggly.anvils>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 09, 2020 at 11:24:14AM -0700, Hugh Dickins wrote:
> After overnight reflection, my own preference would be simply to
> drop this patch.  I think we are making altogether too much of a
> fuss here over what was simply correct as plain put_page()
> (and further from correct if we change it to leak the page in an
> unforeseen circumstance).
> 
> And if Alex's comment was not quite grammatically correct, never mind,
> it said as much as was worth saying.  I got more worried by his
> placement of the "busy:" label, but that does appear to work correctly.
> 
> There's probably a thousand places where put_page() is used, where
> it would be troublesome if it were the final put_page(): this one
> bothered you because you'd been looking at isolate_migratepages_block(),
> and its necessary avoidance of lru_lock recursion on put_page();
> but let's just just leave this put_page() as is.

My problem with put_page() is that it's no longer the simple
decrement-and-branch-to-slow-path-if-zero that it used to be.  It has the
awful devmap excrement in it so it really expands into a lot of code.
I really wish that "feature" could be backed out again.  It clearly
wasn't ready for merge.
