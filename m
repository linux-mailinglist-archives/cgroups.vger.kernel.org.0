Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6851D4F33
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 15:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgEONYo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 09:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgEONYn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 May 2020 09:24:43 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EB1C05BD09
        for <cgroups@vger.kernel.org>; Fri, 15 May 2020 06:24:43 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id i5so2413832qkl.12
        for <cgroups@vger.kernel.org>; Fri, 15 May 2020 06:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QaWgWrHuxPFWiLAhp4MGw0Ee13FyqS0FhmE2+InAr5c=;
        b=Y0Zf8seELSKB++cOysfnNke0Q1k76yTJbnwd9rRfJFzYLkxIfL9/nlC1CVvTkXY1r9
         X237RzZx508nP1DQhXxUfM8ufYAA/sDlD7aXCy1RECkqi3B88KBqXqAgLfXdeea+JOKP
         sr2HNKzwKT7a/5CHP+mQyk4HPqmfnePuexg9SGO+XsHXBaYAmhb3LohQz8G652U4JNdY
         435kJdjSIfXUjHSpqzxa2p+WSHdqN33IjL7oO0ZM4yziSaY7z58qoJOvFZhf5gANOz29
         cJF7y8i/lutV2jpKNQPdSLpWfP9YWiF7zl3araZDTay9TmA9VA9SJMWWSaxODkYdbBr5
         t/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QaWgWrHuxPFWiLAhp4MGw0Ee13FyqS0FhmE2+InAr5c=;
        b=mioZZqphRA3gbX/x7u0OpRmjoOCF57R6x0GovySs1cqxdZnTyPzSVNlFKnOLQL2buz
         tijpI130CNEx7D+F6G6N10AoaclvXXMwEnxmR/HsYJg7F+Qy0Hiwc8B4Z7fIxshl7xpM
         qyQi0Cm4U5Daz3ASaU8xM1ZAM/6g6tak1aC5mb5oeZ6H41kRiEx8HmUQ1Mg6OH1o4vVD
         Jud8uWm2QbO8vH35fVpzhGF/wsNnsL0pwhHOBydwYwdc359UrHhJVxCdqnVvMqM20wiJ
         fEriT5VsF27YeIJ95Kpkfr2Cme3Gu+kkUMQ7KT/8NabM/xS3/iGt9B/n9U0Mwwtomm8n
         /ITg==
X-Gm-Message-State: AOAM5313iIbnONKHW/ao2jiFi3RL+AryMa31Cn/o26iomDx/DaCRMJCL
        e6hZ+VtaMx40hwk77Zm3EwRuoA==
X-Google-Smtp-Source: ABdhPJyglpfBWXibDDxv4gJRiM6bCFQxrloF93IYOhe1B1YqX0LapZGO/P4tWM2dZqB+l9qK9jPRRQ==
X-Received: by 2002:a37:9e06:: with SMTP id h6mr3248738qke.400.1589549082491;
        Fri, 15 May 2020 06:24:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:90a4])
        by smtp.gmail.com with ESMTPSA id t67sm1516787qka.17.2020.05.15.06.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 06:24:41 -0700 (PDT)
Date:   Fri, 15 May 2020 09:24:21 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>, Mel Gorman <mgorman@suse.de>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: expose root cgroup's memory.stat
Message-ID: <20200515132421.GC591266@cmpxchg.org>
References: <20200508170630.94406-1-shakeelb@google.com>
 <20200508214405.GA226164@cmpxchg.org>
 <CALvZod5VHHUV+_AXs4+5sLOPGyxm709kQ1q=uHMPVxW8pwXZ=g@mail.gmail.com>
 <20200515082955.GJ29153@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515082955.GJ29153@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 15, 2020 at 10:29:55AM +0200, Michal Hocko wrote:
> On Sat 09-05-20 07:06:38, Shakeel Butt wrote:
> > On Fri, May 8, 2020 at 2:44 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Fri, May 08, 2020 at 10:06:30AM -0700, Shakeel Butt wrote:
> > > > One way to measure the efficiency of memory reclaim is to look at the
> > > > ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
> > > > not updated consistently at the system level and the ratio of these are
> > > > not very meaningful. The pgsteal and pgscan are updated for only global
> > > > reclaim while pgrefill gets updated for global as well as cgroup
> > > > reclaim.
> > > >
> > > > Please note that this difference is only for system level vmstats. The
> > > > cgroup stats returned by memory.stat are actually consistent. The
> > > > cgroup's pgsteal contains number of reclaimed pages for global as well
> > > > as cgroup reclaim. So, one way to get the system level stats is to get
> > > > these stats from root's memory.stat, so, expose memory.stat for the root
> > > > cgroup.
> > > >
> > > >       from Johannes Weiner:
> > > >       There are subtle differences between /proc/vmstat and
> > > >       memory.stat, and cgroup-aware code that wants to watch the full
> > > >       hierarchy currently has to know about these intricacies and
> > > >       translate semantics back and forth.
> 
> Can we have those subtle differences documented please?
> 
> > > >
> > > >       Generally having the fully recursive memory.stat at the root
> > > >       level could help a broader range of usecases.
> > >
> > > The changelog begs the question why we don't just "fix" the
> > > system-level stats. It may be useful to include the conclusions from
> > > that discussion, and why there is value in keeping the stats this way.
> > >
> > 
> > Right. Andrew, can you please add the following para to the changelog?
> > 
> > Why not fix the stats by including both the global and cgroup reclaim
> > activity instead of exposing root cgroup's memory.stat? The reason is
> > the benefit of having metrics exposing the activity that happens
> > purely due to machine capacity rather than localized activity that
> > happens due to the limits throughout the cgroup tree. Additionally
> > there are userspace tools like sysstat(sar) which reads these stats to
> > inform about the system level reclaim activity. So, we should not
> > break such use-cases.
> > 
> > > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > >
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > Thanks a lot.
> 
> I was quite surprised that the patch is so simple TBH. For some reason
> I've still had memories that we do not account for root memcg (likely
> because mem_cgroup_is_root(memcg) bail out in the try_charge. But stats
> are slightly different here.

Yep, we skip the page_counter for root, but keep in mind that cgroup1
*does* have a root-level memory.stat, so (for the most part) we've
been keeping consumer stats for the root level the whole time.

> counters because they are not really all the same. E.g.
> - mem_cgroup_charge_statistics accounts for each memcg

Yep, that's heritage from cgroup1.

> - memcg_charge_kernel_stack relies on pages being associated with a
>   memcg and that in turn relies on __memcg_kmem_charge_page which bails
>   out on root memcg

You're right. It should only bypass the page_counter, but still set
page->mem_cgroup = root_mem_cgroup, just like user pages.

This counter also doesn't get exported on cgroup1, so it would indeed
be a new bug. It needs to be fixed before this patch here.

> - memcg_charge_slab (NR_SLAB*) skips over root memcg as well

Same thing with these two.
