Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2044115AF9A
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2020 19:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgBLSSi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Feb 2020 13:18:38 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45159 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLSSi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Feb 2020 13:18:38 -0500
Received: by mail-qt1-f195.google.com with SMTP id d9so2291163qte.12
        for <cgroups@vger.kernel.org>; Wed, 12 Feb 2020 10:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OWGcBq+RmtovTTracPqR5yMhReLnPEQNRqBqlsGYoqQ=;
        b=y2gv+7sTsHniWkrRXHbMycwPBOZkSVEUBxS0FbQa9VB6OPJaYJ1Ny9M6xr/G2DVX+A
         2y3zu+4t8K+YEOEZiGZ16SmwaFBkHE7wfdPJ73oAGMEcRLyA7SdYtUq2rlqAIOJ7AlQ+
         UybJYIDz3qsZGxZfUM1AtJQB0pELtShzFC9k3aLs7g4W9U5IbFUlcjQfKEHGvhzfclm+
         JveHX0RcnHpMZXSqGvlbSX7VBuxQcKiVaV6YvUnzx7SOAGPdgFUsRDnB4h3byEIPdOR4
         Deg6SO3d+i3NoTjYxf140EY5fK1CDhyhjBV3mFZrOFF2taWoChENIoAjBrb9azCLuXXz
         mScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OWGcBq+RmtovTTracPqR5yMhReLnPEQNRqBqlsGYoqQ=;
        b=nkMW/khrukcS1uNcbKhyfktZtQhVOFgDVQV/dV1j+j+rWYqiXviZJsViR3rCyTs3SP
         9iR9P8oZm0xLNmMSFZsg0poo0rKcuYuBqzvRCehxbeMHoxVWxDrBglsd0jXzZ3I+ly3o
         cnQShZizNEwTmI1mW6OP1AXkKu+Dcm/Y0NTP+jwV5RsqMq0vLwzAdgo87vSPDVfW5Ytn
         G0aoVTcks/WRJK/Y0XCubD/LKQR3XhE6XRWfoMHRaLBVmACMeljz7ovS+EWd9xS+zCCX
         Wm5uNhfAke8bHzNpiAh3GrjudsBuaN7JBJlSM/mFFQqEH5ARxadRVKLpny5n9Fzheax6
         OpaQ==
X-Gm-Message-State: APjAAAV6pFhhZOslN6oNhXtAKUuurlrBY7JQMVjfd3T9fesl9aLlANz0
        iB32oOWRwCW836CU8PrJ/IMFNQ==
X-Google-Smtp-Source: APXvYqwp6yb7UZLL9gr229Rnz2uuFRz38SvQqwJmNe7+ZVm7dUDCROR1mDfi5DonZ9jY0+5tL1WvCA==
X-Received: by 2002:ac8:6f27:: with SMTP id i7mr8195494qtv.253.1581531516578;
        Wed, 12 Feb 2020 10:18:36 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::5a94])
        by smtp.gmail.com with ESMTPSA id b84sm619400qkc.73.2020.02.12.10.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 10:18:35 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:18:34 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/3] mm: vmscan: detect file thrashing at the reclaim root
Message-ID: <20200212181834.GD180867@cmpxchg.org>
References: <20191107205334.158354-1-hannes@cmpxchg.org>
 <20191107205334.158354-3-hannes@cmpxchg.org>
 <20200212102817.GA18107@js1304-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212102817.GA18107@js1304-desktop>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 12, 2020 at 07:28:19PM +0900, Joonsoo Kim wrote:
> Hello, Johannes.
> 
> When I tested my patchset on v5.5, I found that my patchset doesn't
> work as intended. I tracked down the issue and this patch would be the
> reason of unintended work. I don't fully understand the patchset so I
> could be wrong. Please let me ask some questions.
> 
> On Thu, Nov 07, 2019 at 12:53:33PM -0800, Johannes Weiner wrote:
> ...snip...
> > -static void snapshot_refaults(struct mem_cgroup *root_memcg, pg_data_t *pgdat)
> > +static void snapshot_refaults(struct mem_cgroup *target_memcg, pg_data_t *pgdat)
> >  {
> > -	struct mem_cgroup *memcg;
> > -
> > -	memcg = mem_cgroup_iter(root_memcg, NULL, NULL);
> > -	do {
> > -		unsigned long refaults;
> > -		struct lruvec *lruvec;
> > +	struct lruvec *target_lruvec;
> > +	unsigned long refaults;
> >  
> > -		lruvec = mem_cgroup_lruvec(memcg, pgdat);
> > -		refaults = lruvec_page_state_local(lruvec, WORKINGSET_ACTIVATE);
> > -		lruvec->refaults = refaults;
> > -	} while ((memcg = mem_cgroup_iter(root_memcg, memcg, NULL)));
> > +	target_lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
> > +	refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE);
> > +	target_lruvec->refaults = refaults;
> 
> Is it correct to just snapshot the refault for the target memcg? I
> think that we need to snapshot the refault for all the child memcgs
> since we have traversed all the child memcgs with the refault count
> that is aggregration of all the child memcgs. If next reclaim happens
> from the child memcg, workingset transition that is already considered
> could be considered again.

Good catch, you're right! We have to update all cgroups in the tree,
like we used to. However, we need to use lruvec_page_state() instead
of _local, because we do recursive comparisons in shrink_node()! So
it's not a clean revert of that hunk.

Does this patch here fix the problem you are seeing?

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c82e9831003f..e7431518db13 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2993,12 +2993,17 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 
 static void snapshot_refaults(struct mem_cgroup *target_memcg, pg_data_t *pgdat)
 {
-	struct lruvec *target_lruvec;
-	unsigned long refaults;
+	struct mem_cgroup *memcg;
 
-	target_lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
-	refaults = lruvec_page_state(target_lruvec, WORKINGSET_ACTIVATE);
-	target_lruvec->refaults = refaults;
+	memcg = mem_cgroup_iter(target_memcg, NULL, NULL);
+	do {
+		unsigned long refaults;
+		struct lruvec *lruvec;
+
+		lruvec = mem_cgroup_lruvec(memcg, pgdat);
+		refaults = lruvec_page_state(lruvec, WORKINGSET_ACTIVATE);
+		lruvec->refaults = refaults;
+	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, NULL)));
 }
 
 /*

> > @@ -277,12 +305,12 @@ void workingset_refault(struct page *page, void *shadow)
> >  	 * would be better if the root_mem_cgroup existed in all
> >  	 * configurations instead.
> >  	 */
> > -	memcg = mem_cgroup_from_id(memcgid);
> > -	if (!mem_cgroup_disabled() && !memcg)
> > +	eviction_memcg = mem_cgroup_from_id(memcgid);
> > +	if (!mem_cgroup_disabled() && !eviction_memcg)
> >  		goto out;
> > -	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> > -	refault = atomic_long_read(&lruvec->inactive_age);
> > -	active_file = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES);
> > +	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
> > +	refault = atomic_long_read(&eviction_lruvec->inactive_age);
> > +	active_file = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
> 
> Do we need to use the aggregation LRU count of all the child memcgs?
> AFAIU, refault here is the aggregation counter of all the related
> memcgs. Without using the aggregation count for LRU, active_file could
> be so small than the refault distance and refault cannot happen
> correctly.

lruvec_page_state() *is* aggregated for all child memcgs (as opposed
to lruvec_page_state_local()), so that comparison looks correct to me.
