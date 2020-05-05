Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E151C5C7B
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2020 17:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgEEPts (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 May 2020 11:49:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38232 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbgEEPts (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 May 2020 11:49:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id g12so2885820wmh.3;
        Tue, 05 May 2020 08:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xduNJNk72lfTzo2Qmvpc5OFvX5tJ6mFglpcx46T2q98=;
        b=MeOG/1vgoXo2FyResWWECqKPJ3KLdcOAx7OwwgEr+Ysf/n7eYH1hwx+XVPsJwpbhk4
         xrbXiAZcS52EU1ZapTBhsb+kHnf3sIVs+C1i/dnmxdMTdZsZ10W+D0C9FJgEgi3loTi/
         ckvGR0yLtGGSciC+eHAsjCxbwObJmZ23405FZTL2qVfklVHDih3ZWvIobkRgkCWbTVqX
         9czH1q+Ba4FpHvyIod7JrW6vCvbF8WTIkHU7/iVlowxoy5zq/1iJZB6GHrmj6eJf3J8s
         9juSEBhOEKedGMbJze5faU5B84wqo0Iil+TP1teWoxxw/QfJH1ihp4t7t5zPHgx8p2im
         OzUg==
X-Gm-Message-State: AGi0PuY3YxTmSDv3CTbO5vZz1QQy57DPunBT/uR5w2BhnobPT8QN/LzL
        7n/X1+sK3i59LayqbGkUP5pNS0mW
X-Google-Smtp-Source: APiQypJjEcrRcBT3LAv7V6UcyX48IsZBqT8tBP0izJb0ESRiEEAZy28VRx0LO7yBVK/IWaJoVVZDeg==
X-Received: by 2002:a1c:1dc3:: with SMTP id d186mr3955032wmd.90.1588693785850;
        Tue, 05 May 2020 08:49:45 -0700 (PDT)
Received: from localhost (ip-37-188-183-9.eurotel.cz. [37.188.183.9])
        by smtp.gmail.com with ESMTPSA id h10sm3891154wrv.29.2020.05.05.08.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 08:49:44 -0700 (PDT)
Date:   Tue, 5 May 2020 17:49:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200505154943.GR16322@dhcp22.suse.cz>
References: <20200504065600.GA22838@dhcp22.suse.cz>
 <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com>
 <20200504141136.GR22838@dhcp22.suse.cz>
 <CALvZod7Ls7rTDOr5vXwEiPneLqbq3JoxfFBxZZ71YWgvLkNr5A@mail.gmail.com>
 <20200504150052.GT22838@dhcp22.suse.cz>
 <CALvZod7EeQm-T4dsBddfMY_szYw3m8gRh5R5GfjQiuQAtCocug@mail.gmail.com>
 <20200504160613.GU22838@dhcp22.suse.cz>
 <CALvZod79hWns9366B+8ZK2Roz8c+vkdA80HqFNMep56_pumdRQ@mail.gmail.com>
 <20200505152712.GB58018@cmpxchg.org>
 <CALvZod48mu1w=fjpD=GXqCMdNq_8rExQ177_EP+Lx+TvR6fw+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod48mu1w=fjpD=GXqCMdNq_8rExQ177_EP+Lx+TvR6fw+w@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 05-05-20 08:35:45, Shakeel Butt wrote:
> On Tue, May 5, 2020 at 8:27 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Mon, May 04, 2020 at 12:23:51PM -0700, Shakeel Butt wrote:
> > > On Mon, May 4, 2020 at 9:06 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > > I really hate to repeat myself but this is no different from a regular
> > > > oom situation.
> > >
> > > Conceptually yes there is no difference but there is no *divine
> > > restriction* to not make a difference if there is a real world
> > > use-case which would benefit from it.
> >
> > I would wholeheartedly agree with this in general.
> >
> > However, we're talking about the very semantics that set memory.max
> > apart from memory.high: triggering OOM kills to enforce the limit.
> >
> > > > when the kernel cannot act and mentions that along with the
> > > > oom report so that whoever consumes that information can debug or act on
> > > > that fact.
> > > >
> > > > Silencing the oom report is simply removing a potentially useful
> > > > aid to debug further a potential problem.
> > >
> > > *Potentially* useful for debugging versus actually beneficial for
> > > "sweep before tear down" use-case. Also I am not saying to make "no
> > > dumps for memory.max when no eligible tasks" a set in stone rule. We
> > > can always reevaluate when such information will actually be useful.
> > >
> > > Johannes/Andrew, what's your opinion?
> >
> > I still think that if you want to sweep without triggering OOMs,
> > memory.high has the matching semantics.
> >
> > As you pointed out, it doesn't work well for foreign charges, but that
> > is more of a limitation in the implementation than in the semantics:
> >
> >         /*
> >          * If the hierarchy is above the normal consumption range, schedule
> >          * reclaim on returning to userland.  We can perform reclaim here
> >          * if __GFP_RECLAIM but let's always punt for simplicity and so that
> >          * GFP_KERNEL can consistently be used during reclaim.  @memcg is
> >          * not recorded as it most likely matches current's and won't
> >          * change in the meantime.  As high limit is checked again before
> >          * reclaim, the cost of mismatch is negligible.
> >          */
> >
> > Wouldn't it be more useful to fix that instead? It shouldn't be much
> > of a code change to do sync reclaim in try_charge().
> 
> Sync reclaim would really simplify the remote charging case. Though
> should sync reclaim only be done for remote charging or for all?

The simplest way around that would be to always do sync reclaim for
unpopulated memcgs because those do not have any user context to reclaim
from and for restricted allocation contexts like atomic allocations
maybe also for GFP_NO{IO,FS}.
-- 
Michal Hocko
SUSE Labs
