Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493AB1B4515
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 14:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgDVM2X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 08:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725839AbgDVM2X (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 08:28:23 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D76C03C1A8
        for <cgroups@vger.kernel.org>; Wed, 22 Apr 2020 05:28:21 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id t3so2132147qkg.1
        for <cgroups@vger.kernel.org>; Wed, 22 Apr 2020 05:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f0jbQ8lqR59CMuevuoKxB5R1TbGTdEWUgK8b7QwWaig=;
        b=Y9jYQrTD+KBkq/Ivls3qIPwJpmM6ww7CJ2CqQanRl1MnnhVRBjIC8FJ9elhRHjgaAi
         WtmVdh8KfHvs79NF9myzgKF3YDZQa+Kv8hbQ1f0XynyfQj818YgCxZe6+8zI0tDFDBNA
         roHEPrdPPArwYVRbpIyKS14DdWpNtXoIySwVZMyzDaghAT7+l+UFo8jBdGkcVPgJmNK1
         Ax88OWfXdaPqDS8yCuOPxz5U+/l5yJQY7Kk5uHPF34cinwO+6pSMWgPjLxzO6Hy1mSN2
         GGyZFtH27zc+d6gpMknc6PTpEE65vwc0nQSxz8MYH4htOoqzKxDJB+0noiDXVVFZw7Q+
         CcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f0jbQ8lqR59CMuevuoKxB5R1TbGTdEWUgK8b7QwWaig=;
        b=qm30gmlMgPkZ1lMRlyBauqDlzIYQWEPCt3z8z0dEiFNF6qN0idyKmE98WwCxcZl/9a
         hIaljkFF66xDtY1dbLuzxKSa5EJZSp4f8hp39sDGdPrhE//e18YNyytjPgbvwqUjdIHR
         AQH89Q1Eym2Hh/5e/u4fDw516V3h3u5OsdwA6e0IkHb0kpr6Eyce38nPuQNOyAlJl6Kl
         PkyfoO6LYquE+p9Lym3UK/NN4xOvxPiiNy+er/aWmMCcmJokduB0cib1lyKOkuHZVK1T
         jAUydwk5vLhvHZnFKrktTpYcNFxAmx+wUdvRR+DuEUu0w82OMRAZhFgo1b+ixCkRgdrB
         8t0Q==
X-Gm-Message-State: AGi0PuaeKptFc1UYyR8Pa33CkwxUM0+V87CsYBXUTojQ7/D73kLX6O9q
        9MkqPQPLVk+4RH7TMrp/3QQo6w==
X-Google-Smtp-Source: APiQypK0yZ624EmqPtADqI8HwZ3PCh6fLl7kwzINQkJkM5bvPq4ticXu2xFDQMmITKIA5k9hjWwx/g==
X-Received: by 2002:a05:620a:8da:: with SMTP id z26mr19355762qkz.182.1587558500498;
        Wed, 22 Apr 2020 05:28:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::921])
        by smtp.gmail.com with ESMTPSA id 28sm3853059qkp.10.2020.04.22.05.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 05:28:19 -0700 (PDT)
Date:   Wed, 22 Apr 2020 08:28:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>
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
Message-ID: <20200422122818.GB358439@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-11-hannes@cmpxchg.org>
 <20200422065151.GJ6780@js1304-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422065151.GJ6780@js1304-desktop>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Joonsoo,

On Wed, Apr 22, 2020 at 03:51:52PM +0900, Joonsoo Kim wrote:
> On Mon, Apr 20, 2020 at 06:11:18PM -0400, Johannes Weiner wrote:
> > @@ -3768,7 +3761,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
> >  
> >  static const unsigned int memcg1_stats[] = {
> >  	NR_FILE_PAGES,
> > -	MEMCG_RSS,
> > +	NR_ANON_MAPPED,
> >  	MEMCG_RSS_HUGE,
> >  	NR_SHMEM,
> >  	NR_FILE_MAPPED,
> > @@ -5395,7 +5388,12 @@ static int mem_cgroup_move_account(struct page *page,
> >  
> >  	lock_page_memcg(page);
> >  
> > -	if (!PageAnon(page)) {
> > +	if (PageAnon(page)) {
> > +		if (page_mapped(page)) {
> 
> This page_mapped() check is newly inserted. Could you elaborate more
> on why mem_cgroup_charge_statistics() doesn't need this check?

MEMCG_RSS extended from when the page was charged until it was
uncharged, but NR_ANON_MAPPED is only counted while the page is really
mapped into page tables. That starts shortly after we charge and ends
shortly before we uncharge, so pages could move between cgroups before
or after they are mapped, while they aren't counted in NR_ANON_MAPPED.

So to know that the page is counted, charge_statistics() only needed
to know that the page is charged and Anon; move_account() also needs
to know that the page is mapped.

> > @@ -1181,7 +1187,7 @@ void page_add_new_anon_rmap(struct page *page,
> >  		/* increment count (starts at -1) */
> >  		atomic_set(&page->_mapcount, 0);
> >  	}
> > -	__mod_node_page_state(page_pgdat(page), NR_ANON_MAPPED, nr);
> > +	__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
> >  	__page_set_anon_rmap(page, vma, address, 1);
> >  }
> 
> memcg isn't setup yet and accounting isn't applied to proper memcg.
> Maybe, it would be applied to root memcg. With this change, we don't
> need the mapping to commit the charge so switching the order of
> page_add_new_anon_rmap() and mem_cgroup_commit_charge() will solve the
> issue.

Good catch, it's that dreaded circular dependency. It's fixed two
patches down when I charge anon pages earlier as well. But I'll change
the rmap<->commit order in this patch to avoid the temporary bug.

Thanks for your thorough review!
