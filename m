Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC8C4A0297
	for <lists+cgroups@lfdr.de>; Fri, 28 Jan 2022 22:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbiA1VTB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jan 2022 16:19:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:33674 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235133AbiA1VTB (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 28 Jan 2022 16:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643404741; x=1674940741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JuYGt4SS9apu8yRIPO2cO3Qb/Yp2GBDdA0yZrl2jfbQ=;
  b=DBm3GbI7tHMnd8ixyFX4a2tm413KvLKYa6bX4u7r67PAwSDAFSDtaq03
   J4agsvToZEwTml+OWwDe6ZddFdkNg5HVc1ThnhhhwOFIbUGwYrS6awuVV
   QweT2yR5PFXxNkVw3xtgQzyhRtpoJHttZae2voKpersh7SLUIOKyzi2TA
   TCqA+qyOU2dpTuWGiUg5/3N+q73MoNIWC5wvn1W7IM/nWiJ0frmRSxTGy
   a8FEMA11V7WE3ppZ6JH3+FoFWyBYickSMXNAG85JC8cU7JDatM5/IflEh
   PVtPZbVw74GV9m02x8FllPQKIAD35MuDjUVWmsRIGY/rvkfTfhxwV0tfg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="307928890"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="307928890"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 13:18:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="480867661"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 13:18:48 -0800
Date:   Fri, 28 Jan 2022 13:18:48 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH 1/2] mm/page_owner: Introduce SNPRINTF() macro that
 includes length error check
Message-ID: <20220128211848.GH785175@iweiny-DESK2.sc.intel.com>
References: <20220128195642.416743-1-longman@redhat.com>
 <20220128195642.416743-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128195642.416743-2-longman@redhat.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 28, 2022 at 02:56:41PM -0500, Waiman Long wrote:
> In print_page_owner(), there is a repetitive check after each snprintf()
> to make sure that the final length is less than the buffer size. Simplify
> the code and make it easier to read by embedding the buffer length
> check and increment inside the macro.

This does not follow the kernel coding style of not putting control flow
statements in macros.[1]

> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/page_owner.c | 50 +++++++++++++++++++++++--------------------------
>  1 file changed, 23 insertions(+), 27 deletions(-)

And in the end you only saved 4 lines of code to read...  Not worth it IMO.

Ira

[1] https://www.kernel.org/doc/html/v4.17/process/coding-style.html

> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 99e360df9465..c52ce9d6bc3b 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -325,12 +325,20 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>  	seq_putc(m, '\n');
>  }
>  
> +#define SNPRINTF(_buf, _size, _len, _err, _fmt, ...)			\
> +	do {								\
> +		_len += snprintf(_buf + _len, _size - _len, _fmt,	\
> +				 ##__VA_ARGS__);			\
> +		if (_len >= _size)					\
> +			goto _err;					\
> +	} while (0)
> +
>  static ssize_t
>  print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  		struct page *page, struct page_owner *page_owner,
>  		depot_stack_handle_t handle)
>  {
> -	int ret, pageblock_mt, page_mt;
> +	int ret = 0, pageblock_mt, page_mt;
>  	char *kbuf;
>  
>  	count = min_t(size_t, count, PAGE_SIZE);
> @@ -338,44 +346,32 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>  	if (!kbuf)
>  		return -ENOMEM;
>  
> -	ret = snprintf(kbuf, count,
> -			"Page allocated via order %u, mask %#x(%pGg), pid %d, ts %llu ns, free_ts %llu ns\n",
> -			page_owner->order, page_owner->gfp_mask,
> -			&page_owner->gfp_mask, page_owner->pid,
> -			page_owner->ts_nsec, page_owner->free_ts_nsec);
> -
> -	if (ret >= count)
> -		goto err;
> +	SNPRINTF(kbuf, count, ret, err,
> +		"Page allocated via order %u, mask %#x(%pGg), pid %d, ts %llu ns, free_ts %llu ns\n",
> +		page_owner->order, page_owner->gfp_mask,
> +		&page_owner->gfp_mask, page_owner->pid,
> +		page_owner->ts_nsec, page_owner->free_ts_nsec);
>  
>  	/* Print information relevant to grouping pages by mobility */
>  	pageblock_mt = get_pageblock_migratetype(page);
>  	page_mt  = gfp_migratetype(page_owner->gfp_mask);
> -	ret += snprintf(kbuf + ret, count - ret,
> -			"PFN %lu type %s Block %lu type %s Flags %pGp\n",
> -			pfn,
> -			migratetype_names[page_mt],
> -			pfn >> pageblock_order,
> -			migratetype_names[pageblock_mt],
> -			&page->flags);
> -
> -	if (ret >= count)
> -		goto err;
> +	SNPRINTF(kbuf, count, ret, err,
> +		"PFN %lu type %s Block %lu type %s Flags %pGp\n",
> +		pfn, migratetype_names[page_mt],
> +		pfn >> pageblock_order,
> +		migratetype_names[pageblock_mt],
> +		&page->flags);
>  
>  	ret += stack_depot_snprint(handle, kbuf + ret, count - ret, 0);
>  	if (ret >= count)
>  		goto err;
>  
> -	if (page_owner->last_migrate_reason != -1) {
> -		ret += snprintf(kbuf + ret, count - ret,
> +	if (page_owner->last_migrate_reason != -1)
> +		SNPRINTF(kbuf, count, ret, err,
>  			"Page has been migrated, last migrate reason: %s\n",
>  			migrate_reason_names[page_owner->last_migrate_reason]);
> -		if (ret >= count)
> -			goto err;
> -	}
>  
> -	ret += snprintf(kbuf + ret, count - ret, "\n");
> -	if (ret >= count)
> -		goto err;
> +	SNPRINTF(kbuf, count, ret, err, "\n");
>  
>  	if (copy_to_user(buf, kbuf, ret))
>  		ret = -EFAULT;
> -- 
> 2.27.0
> 
> 
