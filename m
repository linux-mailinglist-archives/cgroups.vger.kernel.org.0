Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B75EC107597
	for <lists+cgroups@lfdr.de>; Fri, 22 Nov 2019 17:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKVQQ6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Nov 2019 11:16:58 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40343 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfKVQQ5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Nov 2019 11:16:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id f9so3289859plr.7
        for <cgroups@vger.kernel.org>; Fri, 22 Nov 2019 08:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wfrcrjX2H8D8RSvVc5LOIPsNb3WQnwmD64TJNBPNLUA=;
        b=2CxFAF9vQ8BbOhqPOkf+HBDvDUxib+UWq9hNW0Tg4l/6YvGcIgULwb7zDfm9mbuP/9
         3/EKpUXrSdv8B03hy14QpNLhWat83HNQyn1GgIfaBTMQMmmanUe+btbssVaH8haWbOpr
         QqRPK10O9tUUfndkbGrdfQe1z6ITlCczduG7UJhZ6JNU7ZoQRSrIbazx85Z8h4rz26Xb
         6EJVTX6A/tEz9L4CMMWPjveLs+QHDUyDxvybrIHm+D9wpJ2bnJSnESNPWmTfEoXJTO6d
         RHERX6f1D2fDaO/gYzRlAdEHF6PJxDPr/jbgCMQMh3Z2Fj6YG7Q5lbEYKwW7Ol6/bl7e
         sgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wfrcrjX2H8D8RSvVc5LOIPsNb3WQnwmD64TJNBPNLUA=;
        b=FyYi9F3Q6y2Cd5IUR58rChZhV294owDpG0j7BYMmsKaTldZOJ40x7GZeCmGTC5r2A9
         eHoiPBypKNFtM2dc/5j5RbXR2IGF2dUU0+7T8B1lBa8M2ccQ/Ur+BwRykVSm5nSKvgmh
         eQ9Ury1Z6FsfwFrXOj1uISTwz44eoAl7ZFh/Ysxi7R0YaeYaOPe4nkesROPPYMfBOICv
         F8wllNwr1igrqs+qGD/JVZAaEWQ0a52nN5GY8rWN6UeQXxjmtRwYBMrFZtwYjIrYfOpT
         jRbfdVbkLCT3BqKQkyC2/4qLIclGJ30wc4A7llnJZnWwW48oWEQUr3NBlPokhLc0kl6g
         YKPA==
X-Gm-Message-State: APjAAAX1hhoyICBmbLq7mE8pJpCYE4Cu6EsGXVYTqU3YJXKZx2GzBGGp
        D+IXYNaB7e43Nl9X1GNgGbIk0Q==
X-Google-Smtp-Source: APXvYqzTddBvl2Cxl4hWR79OGc6LvFSc0Lpv9HH5Ptn1zud7XEHq5ZxyxP4/MuJ4W/R1kultrt//VA==
X-Received: by 2002:a17:90a:b28c:: with SMTP id c12mr19445564pjr.22.1574439415868;
        Fri, 22 Nov 2019 08:16:55 -0800 (PST)
Received: from localhost ([2620:10d:c090:180::9f2b])
        by smtp.gmail.com with ESMTPSA id q3sm7349049pgl.15.2019.11.22.08.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 08:16:54 -0800 (PST)
Date:   Fri, 22 Nov 2019 11:16:52 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v4 3/9] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20191122161652.GA489821@cmpxchg.org>
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
 <1574166203-151975-4-git-send-email-alex.shi@linux.alibaba.com>
 <20191119160456.GD382712@cmpxchg.org>
 <bcf6a952-5b92-50ad-cfc1-f4d9f8f63172@linux.alibaba.com>
 <20191121220613.GB487872@cmpxchg.org>
 <d3bbbbf5-52c5-374c-0897-899e787cecb4@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3bbbbf5-52c5-374c-0897-899e787cecb4@linux.alibaba.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 22, 2019 at 10:36:32AM +0800, Alex Shi wrote:
> 在 2019/11/22 上午6:06, Johannes Weiner 写道:
> > If we could restrict lock_page_lruvec() to working only on PageLRU
> > pages, we could fix the problem with memory barriers. But this won't
> > work for split_huge_page(), which is AFAICT the only user that needs
> > to freeze the lru state of a page that could be isolated elsewhere.
> > 
> > So AFAICS the only option is to lock out mem_cgroup_move_account()
> > entirely when the lru_lock is held. Which I guess should be fine.
> 
> I guess we can try from lock_page_memcg, is that a good start?

Yes.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7e6387ad01f0..f4bbbf72c5b8 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1224,7 +1224,7 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
>                 goto out;
>         }
> 
> -       memcg = page->mem_cgroup;
> +       memcg = lock_page_memcg(page);
>         /*
>          * Swapcache readahead pages are added to the LRU - and
>          * possibly migrated - before they are charged.

test_clear_page_writeback() calls this function with that lock already
held so that would deadlock. Let's keep locking in lock_page_lruvec().

lock_page_lruvec():

	memcg = lock_page_memcg(page);
	lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);

	spin_lock_irqsave(&lruvec->lru_lock, *flags);
	return lruvec;

unlock_lruvec();

	spin_unlock_irqrestore(&lruvec->lru_lock);
	__unlock_page_memcg(lruvec_memcg(lruvec));

The lock ordering should be fine as well. But it might be a good idea
to stick a might_lock(&memcg->move_lock) in lock_page_memcg() before
that atomic_read() and test with lockdep enabled.


But that leaves me with one more worry: compaction. We locked out
charge moving now, so between that and knowing that the page is alive,
we have page->mem_cgroup stable. But compaction doesn't know whether
the page is alive - it comes from a pfn and finds out using PageLRU.

In the current code, pgdat->lru_lock remains the same before and after
the page is charged to a cgroup, so once compaction has that locked
and it observes PageLRU, it can go ahead and isolate the page.

But lruvec->lru_lock changes during charging, and then compaction may
hold the wrong lock during isolation:

compaction:				generic_file_buffered_read:

					page_cache_alloc()

!PageBuddy()

lock_page_lruvec(page)
  lruvec = mem_cgroup_page_lruvec()
  spin_lock(&lruvec->lru_lock)
  if lruvec != mem_cgroup_page_lruvec()
    goto again

					add_to_page_cache_lru()
					  mem_cgroup_commit_charge()
					    page->mem_cgroup = foo
					  lru_cache_add()
					    __pagevec_lru_add()
					      SetPageLRU()

if PageLRU(page):
  __isolate_lru_page()

I don't see what prevents the lruvec from changing under compaction,
neither in your patches nor in Hugh's. Maybe I'm missing something?
