Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CD4254595
	for <lists+cgroups@lfdr.de>; Thu, 27 Aug 2020 15:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgH0NAy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Aug 2020 09:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgH0NAH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Aug 2020 09:00:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ECAC061264;
        Thu, 27 Aug 2020 06:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4Wky95+cp9t6Uc0O4qIN4Z6xGmvHn/NYIHDQjQIG07k=; b=b0qtqXGspyLjHuQD/EC9RMu68r
        R4fF8h5wxyM0dri1npgOSvdmAI/vTKaEGhRhGKIrKQsm7aXqeN9M/UQ2CnRm04AYEzZVa3InvywX7
        5f8OAOsZcoB7dBqYf7rax9NJJ5xzMQmikW+Ac6/+magIzfZJxDzbUjykY06V4w4GJ/Ui4XIEr8TRk
        GU6JX3PMGMkRr2HkVT+SpoitNA3ZB9usoyi4IMxXcUgYV408ZEfevURTjgH8kr/n9GiB3y9XsSVbS
        8zT0raF2qOSRpWk3ZVrteE0+kcDtbDRp+QLBtSHGg6QIfJNfA69Pet3xluPeLDchpOtD1B9/0WEcK
        cZJ/zZiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBHVF-00043a-G7; Thu, 27 Aug 2020 12:59:41 +0000
Date:   Thu, 27 Aug 2020 13:59:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] mm: Use find_get_swap_page in memcontrol
Message-ID: <20200827125941.GG14765@casper.infradead.org>
References: <20200819184850.24779-1-willy@infradead.org>
 <20200819184850.24779-3-willy@infradead.org>
 <20200826142002.GA988805@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826142002.GA988805@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 26, 2020 at 10:20:02AM -0400, Johannes Weiner wrote:
> The refactor makes sense to me, but the name is confusing. We're not
> looking for a swap page, we're primarily looking for a file page in
> the page cache mapping that's handed in. Only in the special case
> where it's a shmem mapping and there is a swap entry do we consult the
> auxiliary swap cache.
> 
> How about find_get_page_or_swapcache()? find_get_page_shmemswap()?
> Maybe you have a better idea. It's a fairly specialized operation that
> isn't widely used, so a longer name isn't a bad thing IMO.

Got it.  find_get_incore_page().  I was going to go with inmem, but that
it matches mincore sold me on it.

/**
 * find_get_incore_page - Find and get a page from the page or swap caches.
 * @mapping: The address_space to search.
 * @index: The page cache index.
 *
 * This differs from find_get_page() in that it will also look for the
 * page in the swap cache.
 *
 * Return: The found page or %NULL.
 */

I was focusing too much on what the function did, not why it was doing it.
