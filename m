Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEEC1B5432
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2020 07:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgDWF1J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Apr 2020 01:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726122AbgDWF1I (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Apr 2020 01:27:08 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E24AC03C1AB;
        Wed, 22 Apr 2020 22:27:07 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f8so1910672plt.2;
        Wed, 22 Apr 2020 22:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5dRfGuiAmG9ezbEhwEm/4CtR44lsDucqUbK7PXbEl8Y=;
        b=F5M1LLmsBpNN0fDAzQu31LTtIIQODx3f7aCxVlXmDLvGsnGmub9LLb8Jh86o59C0II
         1P/8Jeuqhoov7oo0U654aVLXuP28nJ6gPHuf3fMG6chzvgRs5/yMdLNEs3Q1nRU0vhEt
         1XPDILZXi9XIBnRazyV+VsjItkUFsIMht/cfD+/SDZV/g6ZfmHj5tYmtPtcwLVu/IQqU
         2l6NZRxutaxvloiKPPxGTgOCPUnuioixocy10pqC4bZJxSPswExXdrlibTXIPM/ugqPq
         i7OoSRwdf9eeBkXujPpqR4Qz9HIOcFTM94ncbDh3tDNUFSTVs6ytMzZ3M36vVdOXndv9
         ww+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5dRfGuiAmG9ezbEhwEm/4CtR44lsDucqUbK7PXbEl8Y=;
        b=AmFdId67i8VZ3bZRXDeDvz96da8qFnzJAC0iLo97Iw6ONXtfyq4a/H0GlleJlLOQBt
         TN5uMmywMtf/Iqkif/SdWaybkQOyEZpi0UaulxDoMy0yBMuwXa2IC/tBkwHlousglDQn
         vBWp/EGDzgS9UBFua54kO/m/8KfwYPgXDpOxC42WR+p81f4jYJQxVPghq8utg3IfG4Ym
         jJKLrZ71mHzyhKIquxf+YBKaFjcUnBG8rBk213a5Ot4holHscQEjfmtGmLSd1O0udZuP
         CgBet/lcD0pNCg73KpmH4J/3GHDdtulyQChC1gG0Dj2lytHkoC+SCuzkP6WTSAWdbdUt
         5nXw==
X-Gm-Message-State: AGi0PuZgHE8plJSxag6xb101g91xCHUCqEPloWPJ9cnaGm2Xt4Le9C6N
        lQbusrunbKVuuOIk96fj204=
X-Google-Smtp-Source: APiQypKZ1vg3B7CBVKCjT6RRrpVuaJ6pmpVjHiUxcDrwGFDDC+LfEX+3iekDoy33KuMefBsyLY965Q==
X-Received: by 2002:a17:90a:9a89:: with SMTP id e9mr2548628pjp.108.1587619627027;
        Wed, 22 Apr 2020 22:27:07 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id r4sm953199pgi.6.2020.04.22.22.27.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 22:27:06 -0700 (PDT)
Date:   Thu, 23 Apr 2020 14:27:01 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 10/18] mm: memcontrol: switch to native NR_ANON_MAPPED
 counter
Message-ID: <20200423052700.GB12538@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-11-hannes@cmpxchg.org>
 <20200422065151.GJ6780@js1304-desktop>
 <20200422122818.GB358439@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422122818.GB358439@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 22, 2020 at 08:28:18AM -0400, Johannes Weiner wrote:
> Hello Joonsoo,
> 
> On Wed, Apr 22, 2020 at 03:51:52PM +0900, Joonsoo Kim wrote:
> > On Mon, Apr 20, 2020 at 06:11:18PM -0400, Johannes Weiner wrote:
> > > @@ -3768,7 +3761,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
> > >  
> > >  static const unsigned int memcg1_stats[] = {
> > >  	NR_FILE_PAGES,
> > > -	MEMCG_RSS,
> > > +	NR_ANON_MAPPED,
> > >  	MEMCG_RSS_HUGE,
> > >  	NR_SHMEM,
> > >  	NR_FILE_MAPPED,
> > > @@ -5395,7 +5388,12 @@ static int mem_cgroup_move_account(struct page *page,
> > >  
> > >  	lock_page_memcg(page);
> > >  
> > > -	if (!PageAnon(page)) {
> > > +	if (PageAnon(page)) {
> > > +		if (page_mapped(page)) {
> > 
> > This page_mapped() check is newly inserted. Could you elaborate more
> > on why mem_cgroup_charge_statistics() doesn't need this check?
> 
> MEMCG_RSS extended from when the page was charged until it was
> uncharged, but NR_ANON_MAPPED is only counted while the page is really
> mapped into page tables. That starts shortly after we charge and ends
> shortly before we uncharge, so pages could move between cgroups before
> or after they are mapped, while they aren't counted in NR_ANON_MAPPED.
> 
> So to know that the page is counted, charge_statistics() only needed
> to know that the page is charged and Anon; move_account() also needs
> to know that the page is mapped.

Got it!

> 
> > > @@ -1181,7 +1187,7 @@ void page_add_new_anon_rmap(struct page *page,
> > >  		/* increment count (starts at -1) */
> > >  		atomic_set(&page->_mapcount, 0);
> > >  	}
> > > -	__mod_node_page_state(page_pgdat(page), NR_ANON_MAPPED, nr);
> > > +	__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
> > >  	__page_set_anon_rmap(page, vma, address, 1);
> > >  }
> > 
> > memcg isn't setup yet and accounting isn't applied to proper memcg.
> > Maybe, it would be applied to root memcg. With this change, we don't
> > need the mapping to commit the charge so switching the order of
> > page_add_new_anon_rmap() and mem_cgroup_commit_charge() will solve the
> > issue.
> 
> Good catch, it's that dreaded circular dependency. It's fixed two
> patches down when I charge anon pages earlier as well. But I'll change
> the rmap<->commit order in this patch to avoid the temporary bug.

Okay.

> Thanks for your thorough review!

Thanks.
