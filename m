Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691033B8E1B
	for <lists+cgroups@lfdr.de>; Thu,  1 Jul 2021 09:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbhGAHVN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jul 2021 03:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbhGAHVN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Jul 2021 03:21:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661EBC061756
        for <cgroups@vger.kernel.org>; Thu,  1 Jul 2021 00:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AO10H4pBYDXfj/GCG8I7YNtdmQX0P/FBy3uAzevfrYY=; b=YHVMxe4+ZCiCB/P9GLSQuCArCA
        ej7RrWbCiOh8iBi+p5GSYbUhnBrGn6VyP7cFQwsZ/OmwSJsUGpeyJp9Ow+QpkAHtsjZgi8llNPn22
        Tv3Vhnv4ABQ/UR86yx5Ve/ZZPENgDBoHlW1glJQzXXuVriXDl95x6jRyvjUa0QYcjnSNH39k+JsPb
        yBcDaOUY87BKEcGL9XrsFfHTB36viWHYrIQIcdfT59ELinCYH+cR1NMA6YQGYWZcHcijIPkMa3eZ9
        /REH3vSN4d0GcqfnrynhoPB251+k2wpzaOZ1oc4Kt+JCq7Okaouzs9s+9E/hrW9SAnDh2uNiro36r
        FB6Phk7Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyqxI-006Hst-NI; Thu, 01 Jul 2021 07:17:53 +0000
Date:   Thu, 1 Jul 2021 08:17:48 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH v3 10/18] mm/memcg: Convert mem_cgroup_uncharge() to take
 a folio
Message-ID: <YN1sHPnWUysOZiJm@infradead.org>
References: <20210630040034.1155892-1-willy@infradead.org>
 <20210630040034.1155892-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630040034.1155892-11-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 30, 2021 at 05:00:26AM +0100, Matthew Wilcox (Oracle) wrote:
> Convert all the callers to call page_folio().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/memcontrol.h |  4 ++--
>  mm/filemap.c               |  2 +-
>  mm/khugepaged.c            |  4 ++--
>  mm/memcontrol.c            | 14 +++++++-------
>  mm/memory-failure.c        |  2 +-
>  mm/memremap.c              |  2 +-
>  mm/page_alloc.c            |  2 +-
>  mm/swap.c                  |  2 +-
>  8 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 90d48b0e3191..d6386a2b9d7a 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -710,7 +710,7 @@ int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
>  				  gfp_t gfp, swp_entry_t entry);
>  void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
>  
> -void mem_cgroup_uncharge(struct page *page);
> +void mem_cgroup_uncharge(struct folio *);

why do you drop the parameter name?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
