Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64B11D0161
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2020 23:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgELV6e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 May 2020 17:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728362AbgELV6e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 May 2020 17:58:34 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76F5C061A0E
        for <cgroups@vger.kernel.org>; Tue, 12 May 2020 14:58:33 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id j2so12242819qtr.12
        for <cgroups@vger.kernel.org>; Tue, 12 May 2020 14:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BUXw4M2hrKKLto70sS86x2vpRsYSrXGGkvx6yBoOXGU=;
        b=J7i0tWVrKdNsAqbFJgrcX4F2LRmnhOb5p8uZbJCl613epPJb948twCNi5eKTP7s33F
         o+ykWiTZ6bi0oA2jOKopphddfzhgvVTq6r+AmJQsHgKOxqkyo9BTD1/7K5TiLSrMvKx3
         ks+yOuI09tX3K6d7xao/Wp6lhGaQOWKNb9W4Szmqn5UszApw18rY+G/q9yH/9rWoR7CW
         T1BUYX12TPAODZ61FqPb14HTaO5TGHRU1aTEHLy57UFWKSIL30FYwQNvyBUMh80oKs0q
         nsK6OMzbEcVf0RP+E0grzKwaTMUdz9YCrOvKmQ65HRXV0v7pVvObcHn3HluUVebhwQFf
         79Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BUXw4M2hrKKLto70sS86x2vpRsYSrXGGkvx6yBoOXGU=;
        b=BQ3sL94kRQUPcFlVxrdSNrgG24OhWOuBRB5hXSY4UIBkaNdqHCSNtHqxY2uyY4bNSs
         HVjH8hfmhoIA3r3gaza04NbEmfJrIyh4MBgpTEp+6KDXEo09BFZHA0ciqq6aje2EtVTs
         zpEAy0G8XoaNXkV5VSyLZJsXf7Lont6Ks+5bH1bVC2uZyzneR/9Vy8vLllK9+TWIQCUj
         /6lsc6bXRGSEhUXPYTkS52WF0UiJmAZiz3VpaYQ6u92vlVQ+lhcismusxpvplVDUdPn5
         I/JpuKRlzS0pp2ZazZ8O2ZAcsUi6GsznNxSJqhiuyI6ChzP/iWRDRzQDhSjUPrTGr7Pt
         bqoA==
X-Gm-Message-State: AGi0PuaGXvkxLyQg/XE85YB8xWluv5ZC6EdTfKsBYhzrHHccQS11EKKv
        WIgyULS9+URcJ5N6AliZzw96UA==
X-Google-Smtp-Source: APiQypJZIQGRoahrJO1OYKdMjJZJmITijIFVTA02HWCUKw8r3wra+jbdycYr2pGDA3Ctsgw1p0GtaQ==
X-Received: by 2002:ac8:73c1:: with SMTP id v1mr10049652qtp.320.1589320713006;
        Tue, 12 May 2020 14:58:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id v44sm10409623qtk.79.2020.05.12.14.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 14:58:32 -0700 (PDT)
Date:   Tue, 12 May 2020 17:58:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, Linux-MM <linux-mm@kvack.org>,
        cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Subject: Re: [PATCH 12/19] mm: memcontrol: convert anon and file-thp to new
 mem_cgroup_charge() API
Message-ID: <20200512215813.GA487759@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
 <20200508183105.225460-13-hannes@cmpxchg.org>
 <45AA36A9-0C4D-49C2-BA3C-08753BBC30FB@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45AA36A9-0C4D-49C2-BA3C-08753BBC30FB@lca.pw>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 12, 2020 at 10:38:54AM -0400, Qian Cai wrote:
> > On May 8, 2020, at 2:30 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > 
> > With the page->mapping requirement gone from memcg, we can charge anon
> > and file-thp pages in one single step, right after they're allocated.
> > 
> > This removes two out of three API calls - especially the tricky commit
> > step that needed to happen at just the right time between when the
> > page is "set up" and when it's "published" - somewhat vague and fluid
> > concepts that varied by page type. All we need is a freshly allocated
> > page and a memcg context to charge.
> > 
> > v2: prevent double charges on pre-allocated hugepages in khugepaged
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > ---
> > include/linux/mm.h      |  4 +---
> > kernel/events/uprobes.c | 11 +++--------
> > mm/filemap.c            |  2 +-
> > mm/huge_memory.c        |  9 +++------
> > mm/khugepaged.c         | 35 ++++++++++-------------------------
> > mm/memory.c             | 36 ++++++++++--------------------------
> > mm/migrate.c            |  5 +----
> > mm/swapfile.c           |  6 +-----
> > mm/userfaultfd.c        |  5 +----
> > 9 files changed, 31 insertions(+), 82 deletions(-)
> []
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > 
> > @@ -1198,10 +1193,11 @@ static void collapse_huge_page(struct mm_struct *mm,
> > out_up_write:
> > 	up_write(&mm->mmap_sem);
> > out_nolock:
> > +	if (*hpage)
> > +		mem_cgroup_uncharge(*hpage);
> > 	trace_mm_collapse_huge_page(mm, isolated, result);
> > 	return;
> > out:
> > -	mem_cgroup_cancel_charge(new_page, memcg);
> > 	goto out_up_write;
> > }
> []
> 
> Some memory pressure will crash this new code. It looks like somewhat racy.
> 
> if (!page->mem_cgroup)
> 
> where page == NULL in mem_cgroup_uncharge().

Thanks for the report, sorry about the inconvenience.

Hm, the page is exclusive at this point, nobody else should be
touching it. After all, khugepaged might reuse the preallocated page
for another pmd if this one fails to collapse.

Looking at the code, I think it's page itself that's garbage, not
page->mem_cgroup changing. If you have CONFIG_NUMA and the allocation
fails, *hpage could contain an ERR_PTR instead of being NULL.

I think we need the following fixlet:

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f2e0a5e5cfbb..f6161e17da26 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1193,7 +1193,7 @@ static void collapse_huge_page(struct mm_struct *mm,
 out_up_write:
 	up_write(&mm->mmap_sem);
 out_nolock:
-	if (*hpage)
+	if (!IS_ERR_OR_NULL(*hpage))
 		mem_cgroup_uncharge(*hpage);
 	trace_mm_collapse_huge_page(mm, isolated, result);
 	return;
@@ -1928,7 +1928,7 @@ static void collapse_file(struct mm_struct *mm,
 	unlock_page(new_page);
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
-	if (*hpage)
+	if (!IS_ERR_OR_NULL(*hpage))
 		mem_cgroup_uncharge(*hpage);
 	/* TODO: tracepoints */
 }
