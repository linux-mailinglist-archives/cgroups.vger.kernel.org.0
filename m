Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82EDA176698
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2020 23:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgCBWLq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Mar 2020 17:11:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgCBWLq (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 2 Mar 2020 17:11:46 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46D4921739;
        Mon,  2 Mar 2020 22:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583187105;
        bh=nmmuEpxmCjc0aKsztvjVXQXja7/rg6W/P3XUJuNzzKc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0q18elEUkRaxUtioBVBS0syNq3bikiyHmmqzQeYjY9AB/5R2JiOBn5bl54IyRZzmt
         nLXzchT4MCXx8AoVjhcjC4USN/LyuG9qHeJn15K86f757YVqpUM0rb9wmH5F0hqdSj
         AWBD+bnAAE4uWywcgoAr66YGhiWsV1IXA2regTt8=
Date:   Mon, 2 Mar 2020 14:11:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v9 07/20] mm/lru: introduce TestClearPageLRU
Message-Id: <20200302141144.b30abe0d89306fd387e13a92@linux-foundation.org>
In-Reply-To: <1583146830-169516-8-git-send-email-alex.shi@linux.alibaba.com>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
        <1583146830-169516-8-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon,  2 Mar 2020 19:00:17 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:

> Combined PageLRU check and ClearPageLRU into one function by new
> introduced func TestClearPageLRU. This function will be used as page
> isolation precondition.
> 
> No functional change yet.
> 
> ...
>
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2588,9 +2588,8 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg,
>  		pgdat = page_pgdat(page);
>  		spin_lock_irq(&pgdat->lru_lock);
>  
> -		if (PageLRU(page)) {
> +		if (TestClearPageLRU(page)) {
>  			lruvec = mem_cgroup_page_lruvec(page, pgdat);
> -			ClearPageLRU(page);
>  			del_page_from_lru_list(page, lruvec, page_lru(page));
>  		} else

The code will now get exclusive access of the page->flags cacheline and
will dirty that cacheline, even for !PageLRU() pages.  What is the
performance impact of this?

