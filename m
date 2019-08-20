Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B735961D2
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2019 16:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfHTOAX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Aug 2019 10:00:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50266 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbfHTOAW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Aug 2019 10:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TWRaZEAnHrNRlH8ifo3ZQD1iiyxnRF/NRhravPIs25c=; b=ooeAB8XeFx9mkV2wPTzJifUFx
        pwnZtTMR71QaoAV8FOdoBxW7MNR4Mz1zwoow92gi4p/SdNJR06JiZfl/mjclbj93gBZsxfiAayZHV
        JKTp+WGmnFvobB47nn2zHVTG6mKwGQvTt+GVwvR9fi4sJE01o/IStNzFyiuOfyWafDq7PDwDHSPFB
        XUzKT3HFjvdiIA9IHiCz457fuEkDJRoQZT3gg+Ue3jstT0SAnx2JG1ynaxg/ADd5zYr8+0xJmPe7c
        RO4mgPibT3qwx/z9KDiaY7OG5OVPxGNbWqKoz8pw/RpP6nItpEsVzU412On0kN7wv+pJ69t9aKbGL
        esejxAqyw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i04gN-00068l-V4; Tue, 20 Aug 2019 14:00:19 +0000
Date:   Tue, 20 Aug 2019 07:00:19 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Arun KS <arunks@codeaurora.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH 14/14] mm/lru: fix the comments of lru_lock
Message-ID: <20190820140019.GB24642@bombadil.infradead.org>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
 <1566294517-86418-15-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566294517-86418-15-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 20, 2019 at 05:48:37PM +0800, Alex Shi wrote:
> @@ -159,7 +159,7 @@ static inline bool free_area_empty(struct free_area *area, int migratetype)
>  struct pglist_data;
>  
>  /*
> - * zone->lock and the zone lru_lock are two of the hottest locks in the kernel.
> + * zone->lock and the lru_lock are two of the hottest locks in the kernel.
>   * So add a wild amount of padding here to ensure that they fall into separate
>   * cachelines.  There are very few zone structures in the machine, so space
>   * consumption is not a concern here.

But after this patch series, the lru lock is no longer stored in the zone.
So this comment makes no sense.

> @@ -295,7 +295,7 @@ struct zone_reclaim_stat {
>  
>  struct lruvec {
>  	struct list_head		lists[NR_LRU_LISTS];
> -	/* move lru_lock to per lruvec for memcg */
> +	/* perf lruvec lru_lock for memcg */

What does the word 'perf' mean here?

