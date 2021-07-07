Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547BF3BE79B
	for <lists+cgroups@lfdr.de>; Wed,  7 Jul 2021 14:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhGGMMH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Jul 2021 08:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhGGMME (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Jul 2021 08:12:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7505AC061574
        for <cgroups@vger.kernel.org>; Wed,  7 Jul 2021 05:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RXoWcuIuDvfEGN36dlaWaQFgjdyKKyiHEIwv1084Sds=; b=dOeQ1dmEFArkaUwQG0GlkB/Y9C
        bDVBYDR1vEAJslZf/p4DKECDxKXSGnbscuT9ClyULCkJ2Rof48rCeXy1uSNem1vVUJvcv7E2nLenF
        mHcqmGHR9eKBEr/xTP+AP5UwpJXg+F0gQXCP16t2mL8kzKlXvhqCjfTv7FhxqxE5tD5fX0mwXQST2
        5tlVl62OZunHsjopsZIKCqD16RmPYahjVUp0Q0WYsvD8HYq0t2FZl75ji3mfzl7o/54P0B/7+vHot
        KAGJcsUvbdap0kQ/RYVZqMTAXE5x5CobSi6YidZGE77tj2o094yBmFmr4HgbFhqltTD4tQspCmKQH
        ZYk/LzLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m16MT-00CNOB-G0; Wed, 07 Jul 2021 12:09:08 +0000
Date:   Wed, 7 Jul 2021 13:09:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 10/18] mm/memcg: Convert mem_cgroup_uncharge() to take
 a folio
Message-ID: <YOWZYWWQvGSVeCs9@casper.infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-11-willy@infradead.org>
 <YN1sHPnWUysOZiJm@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN1sHPnWUysOZiJm@infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 01, 2021 at 08:17:48AM +0100, Christoph Hellwig wrote:
> On Wed, Jun 30, 2021 at 05:00:26AM +0100, Matthew Wilcox (Oracle) wrote:
> > -void mem_cgroup_uncharge(struct page *page);
> > +void mem_cgroup_uncharge(struct folio *);
> 
> why do you drop the parameter name?

I usually do where it's 'struct foo *foo' or 'foo_t foo'.  If the best
you can do is say "it's a page", well, yes, I knew that from the type.
But since you've complained, I've added the pointless 'folio' to it.

> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
