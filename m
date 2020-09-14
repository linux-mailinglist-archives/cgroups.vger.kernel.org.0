Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182CE2697C2
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 23:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgINVdb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 17:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgINVdZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 17:33:25 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167A1C06178A
        for <cgroups@vger.kernel.org>; Mon, 14 Sep 2020 14:33:24 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n18so1471618qtw.0
        for <cgroups@vger.kernel.org>; Mon, 14 Sep 2020 14:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=M6GRxBpT2cC25wV82DuNi9J3pqiD8OWCE31gUld/UhE=;
        b=rwyLUxhptQJc4HOqwpHP2HBqm700/ViMyS+157/Rz8Xv6Kt/qW1SS8hfob3t+geEaN
         jgum4YbUdr9Z/zipYDu1H+ZK7te0x5IIz2kR1YJOnnYec34roru9spTQuD3GhyqhJY7E
         wn6kotmIL/HBuARMoYXTBU3L5Is9LfKgxWv9elRtM1XilCShSVzx3Ee6PqpwV6evdyUI
         5R0Pbsb0l9+ce6wHYdnl+Rg3xvN1fh/T6OtQePz+hvQMJgIBut1tgGPjsxnwwtaxvPnl
         5v3i2B/3e9WAQVVQIaAWihJ0Sv6vxWISBtn5UOkRsG58l7XOP20RC+5xHSPvcaET7Uoe
         hfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=M6GRxBpT2cC25wV82DuNi9J3pqiD8OWCE31gUld/UhE=;
        b=qM8Z5+u/X5IGoaachrYUfizk+nXGNU60oXfIvBOF6c3NM2+ZeyRx4s8K3H0TdQ+a5h
         ylnf2YfcHdjIrauLSk6XSobax/gRLgsNWE/ZzxXiC9hoRzLNBfUpkupnY8VD3rgSxEH9
         oFM1dFeMsUz2FMpdXcykIaxKBM84JRONvAjdg8SXQcb6gwrwQ5CH9wcBeDuCri/kiS4e
         sYu6QMfjWNPiepS/CRx/1hZD/6oIsmUiu+EBqUO5mON9HQFi3K4GZVM4yMI5QHHwTGbI
         PgCnO00iyZDZtE4pDj3MxJ/CqkvtX7HJkgfYtuJNKRjfII5eVKi+texWnJ1RsYB1bhff
         eZsg==
X-Gm-Message-State: AOAM532ydzO2KtrGgn1vNcojErIID5LE1OsI3o1YOXA1qg8wSyVY9H92
        NYb7T//mWCD0Nyrn2M+8RDet6A==
X-Google-Smtp-Source: ABdhPJxl25SSqbEom8UNjHbcdzIzm36yZ81zxV71gBF1hYZVcVt4BpQ808OQZYcMcR2vsN2uySCkVA==
X-Received: by 2002:ac8:76c7:: with SMTP id q7mr15059779qtr.293.1600119203260;
        Mon, 14 Sep 2020 14:33:23 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:3700])
        by smtp.gmail.com with ESMTPSA id f3sm14633329qtg.71.2020.09.14.14.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 14:33:22 -0700 (PDT)
Date:   Mon, 14 Sep 2020 17:32:00 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 2/3] mm/memcg: Simplify mem_cgroup_get_max()
Message-ID: <20200914213200.GC175618@cmpxchg.org>
References: <20200914024452.19167-1-longman@redhat.com>
 <20200914024452.19167-3-longman@redhat.com>
 <20200914114825.GM16999@dhcp22.suse.cz>
 <e8ddc443-b56a-1dd6-6d41-ad217e9aea80@redhat.com>
 <20200914212904.GB175618@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200914212904.GB175618@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 14, 2020 at 05:29:06PM -0400, Johannes Weiner wrote:
> On Mon, Sep 14, 2020 at 09:51:26AM -0400, Waiman Long wrote:
> > On 9/14/20 7:48 AM, Michal Hocko wrote:
> > > On Sun 13-09-20 22:44:51, Waiman Long wrote:
> > > > The mem_cgroup_get_max() function used to get memory+swap max from
> > > > both the v1 memsw and v2 memory+swap page counters & return the maximum
> > > > of these 2 values. This is redundant and it is more efficient to just
> > > > get either the v1 or the v2 values depending on which one is currently
> > > > in use.
> > > > 
> > > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > > ---
> > > >   mm/memcontrol.c | 20 +++++++++-----------
> > > >   1 file changed, 9 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index 8c74f1200261..ca36bed588d1 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -1633,17 +1633,15 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
> > > >    */
> > > >   unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
> > > >   {
> > > > -	unsigned long max;
> > > > -
> > > > -	max = READ_ONCE(memcg->memory.max);
> > > > -	if (mem_cgroup_swappiness(memcg)) {
> > > > -		unsigned long memsw_max;
> > > > -		unsigned long swap_max;
> > > > -
> > > > -		memsw_max = memcg->memsw.max;
> > > > -		swap_max = READ_ONCE(memcg->swap.max);
> > > > -		swap_max = min(swap_max, (unsigned long)total_swap_pages);
> > > > -		max = min(max + swap_max, memsw_max);
> > > > +	unsigned long max = READ_ONCE(memcg->memory.max);
> > > > +
> > > > +	if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
> > > > +		if (mem_cgroup_swappiness(memcg))
> > > > +			max += min(READ_ONCE(memcg->swap.max),
> > > > +				   (unsigned long)total_swap_pages);
> > > > +	} else { /* v1 */
> > > > +		if (mem_cgroup_swappiness(memcg))
> > > > +			max = memcg->memsw.max;
> > > I agree that making v1 vs. v2 distinction here makes the code more
> > > obvious. But I do not think your code is correct for v1. In a default
> > > state it would lead to max = PAGE_COUNTER_MAX which is not something
> > > we want, right?
> > > 
> > > instead you want
> > > 		max += min(READ_ONCE(memcg->memsw.max), total_swap_pages);
> > > 
> > You are right, it is a bit tricky for v1.
> > 
> > I will change it to
> > 
> >     max += min(READ_ONCE(memcg->memsw.max) - max, total_swap_pages):
> 
> memsw.max can be smaller than max.
> 
> max = min3(max, READ_ONCE(memcg->memsw.max), total_swap_pages)?

Nevermind, I saw the follow-up below, and it's indeed not allowed to
configure it like that.
