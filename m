Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02F823D799
	for <lists+cgroups@lfdr.de>; Thu,  6 Aug 2020 09:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgHFHmK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Aug 2020 03:42:10 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:48155 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727998AbgHFHmF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Aug 2020 03:42:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U4uOac3_1596699708;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4uOac3_1596699708)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 Aug 2020 15:41:49 +0800
Subject: Re: [PATCH v17 17/21] mm/lru: replace pgdat lru_lock with lruvec lock
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-18-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <bf2e2e9d-ce1c-f0d5-3ccc-9499c09831cb@linux.alibaba.com>
Date:   Thu, 6 Aug 2020 15:41:28 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1595681998-19193-18-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Johannes, Michal,

From page to its lruvec, a few memory access under lock cause extra cost.
Would you like to save the per memcg lruvec pointer to page->private?

Thanks
Alex



ÔÚ 2020/7/25 ÏÂÎç8:59, Alex Shi Ð´µÀ:
>  /**
>   * mem_cgroup_page_lruvec - return lruvec for isolating/putting an LRU page
>   * @page: the page
> @@ -1215,7 +1228,8 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
>  		goto out;
>  	}
>  
> -	memcg = page->mem_cgroup;
> +	VM_BUG_ON_PAGE(PageTail(page), page);
> +	memcg = READ_ONCE(page->mem_cgroup);
>  	/*
>  	 * Swapcache readahead pages are added to the LRU - and
>  	 * possibly migrated - before they are charged.
> @@ -1236,6 +1250,51 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
>  	return lruvec;
>  }
>  
> +struct lruvec *lock_page_lruvec(struct page *page)
> +{
> +	struct lruvec *lruvec;
> +	struct pglist_data *pgdat = page_pgdat(page);
> +
> +	rcu_read_lock();
> +	lruvec = mem_cgroup_page_lruvec(page, pgdat);
> +	spin_lock(&lruvec->lru_lock);
> +	rcu_read_unlock();
> +
> +	lruvec_memcg_debug(lruvec, page);
> +
> +	return lruvec;
> +}
> +
