Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237532AA204
	for <lists+cgroups@lfdr.de>; Sat,  7 Nov 2020 02:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgKGBaQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Nov 2020 20:30:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:47326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbgKGBaQ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 6 Nov 2020 20:30:16 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E9F320720;
        Sat,  7 Nov 2020 01:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604712615;
        bh=5ja+hHDhLaw834klWxEIsEobJjKzEYlU1fK3r77mU5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jZrN5F7/+Zu3GmPA5iLrAhldT/HnmmgsyZF2eKJZ9aZUKndfgBlXBzDVBKRlKB20J
         gnoQgoeBoM9JlKv5BRD526px7a20WshtiPv/94Md18VkK2B5uF32W2PcQAXlnjhxJP
         wyfF6u9yfTq52lPBu14DkQlLqPNi719Z1w4wjAJ4=
Date:   Fri, 6 Nov 2020 17:30:14 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hui Su <sh_def@163.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        shakeelb@google.com, guro@fb.com, laoar.shao@gmail.com,
        chris@chrisdown.name, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/memcontrol:rewrite mem_cgroup_page_lruvec()
Message-Id: <20201106173014.e13b5fe5edec41d1f7fdf072@linux-foundation.org>
In-Reply-To: <20201104142516.GA106571@rlk>
References: <20201104142516.GA106571@rlk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 4 Nov 2020 22:25:16 +0800 Hui Su <sh_def@163.com> wrote:

> mem_cgroup_page_lruvec() in memcontrol.c and
> mem_cgroup_lruvec() in memcontrol.h is very similar
> except for the param(page and memcg) which also can be
> convert to each other.
> 
> So rewrite mem_cgroup_page_lruvec() with mem_cgroup_lruvec().

Alex Shi's "mm/memcg: warning on !memcg after readahead page charged"
(https://lkml.kernel.org/r/1604283436-18880-3-git-send-email-alex.shi@linux.alibaba.com)
changes mem_cgroup_page_lruvec() thusly:

--- a/mm/memcontrol.c~mm-memcg-warning-on-memcg-after-readahead-page-charged
+++ a/mm/memcontrol.c
@@ -1325,10 +1325,7 @@ struct lruvec *mem_cgroup_page_lruvec(st
 	}
 
 	memcg = page_memcg(page);
-	/*
-	 * Swapcache readahead pages are added to the LRU - and
-	 * possibly migrated - before they are charged.
-	 */
+	VM_WARN_ON_ONCE_PAGE(!memcg, page);
 	if (!memcg)
 		memcg = root_mem_cgroup;
 
So the patch didn't apply.

That's easily fixed, but it does make one wonder whether this:

> -struct lruvec *mem_cgroup_page_lruvec(struct page *, struct pglist_data *);
> +/**
> + * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
> + * @page: the page
> + * @pgdat: pgdat of the page
> + *
> + * This function relies on page->mem_cgroup being stable.
> + */
> +static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
> +						struct pglist_data *pgdat)
> +{
> +	struct mem_cgroup *memcg = page->mem_cgroup;
> +
> +	return mem_cgroup_lruvec(memcg, pgdat);
> +}

Should be using page_memcg()?

