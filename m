Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6732A9C9C
	for <lists+cgroups@lfdr.de>; Fri,  6 Nov 2020 19:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgKFSp2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Nov 2020 13:45:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:26534 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgKFSp2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 6 Nov 2020 13:45:28 -0500
IronPort-SDR: 5IXlAbHAUTb6pupS2Qc0tQ4+9BJiDYqHdLwlQ9GbWbCDHH26CF6oHvyc97AQnsZuIaQaKQ9Kd3
 lS0ibF7TfkOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="149436831"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="149436831"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 10:45:28 -0800
IronPort-SDR: 2iS/yPM6+M8YUrWI+2wYcNHSBNl4MOQKDC6h4rjeaK92UuqlL/gAeFhuAn6icUOPyiLObxGuw4
 rrwJCJUQU5Gw==
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="472159885"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 10:45:27 -0800
Date:   Fri, 6 Nov 2020 10:45:27 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, akpm@linux-foundation.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: update page struct member in comments
Message-ID: <20201106184527.GD3976735@iweiny-DESK2.sc.intel.com>
References: <1604662413-5734-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604662413-5734-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 06, 2020 at 07:33:33PM +0800, Alex Shi wrote:
> The page->mem_cgroup member is replaced by memcg_data, and add a helper
> page_memcg() for it. Need to update comments to avoid confusing.

I'm not an expert in this code but IMO the pointer manipulation of
page->mem_cgroup could be thought of as local to the code in mm/memcontrol.c.
As such the detail of the member of the page struct that the code depends on is
a valuable part of the comment.  Having to look at page_memcg() to find out
this information is kind of annoying.

Ira

> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org> 
> Cc: Michal Hocko <mhocko@kernel.org> 
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com> 
> Cc: Andrew Morton <akpm@linux-foundation.org> 
> Cc: cgroups@vger.kernel.org 
> Cc: linux-mm@kvack.org 
> Cc: linux-kernel@vger.kernel.org 
> ---
>  mm/memcontrol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b2aa3b73ab82..8a8debea34fc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1310,7 +1310,7 @@ int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>   * @page: the page
>   * @pgdat: pgdat of the page
>   *
> - * This function relies on page->mem_cgroup being stable - see the
> + * This function relies on page_memcg(page) being stable - see the
>   * access rules in commit_charge().
>   */
>  struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgdat)
> @@ -2862,7 +2862,7 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg)
>  {
>  	VM_BUG_ON_PAGE(page_memcg(page), page);
>  	/*
> -	 * Any of the following ensures page->mem_cgroup stability:
> +	 * Any of the following ensures page_memcg(page) stability:
>  	 *
>  	 * - the page lock
>  	 * - LRU isolation
> -- 
> 1.8.3.1
> 
