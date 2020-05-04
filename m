Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50551C33B6
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2020 09:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgEDHgC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 May 2020 03:36:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51984 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgEDHgA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 May 2020 03:36:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id x4so7275257wmj.1;
        Mon, 04 May 2020 00:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4M+FRCJ74peE16t8SYWvqws7mT6RU/FjWmJ/yEmHyz4=;
        b=ctnDc4VdKcgsjnDDEMaTn4UVcqYWIf6mgLgViq//uEi3ez5IZ89J11+fOkj57ZscAp
         sGtK5kvDR02Dmc52cBVZbsWHFieTdzet6VIXC7M5z+wzJeDevf9lJXqiDhG/svUl7mIl
         oUd9vtbq6X2JKi1WzoL4lXu3ezHg/7cmrZ8bkI+8aG7aq3u0wohJkjKCGxbUYiwMWxea
         Je01tIUFNUaJIaTJAxqROB3TJzIxvMx5CZ3h2yUcw9it0UcWTfEJhb+PDnpVdE2vo1eD
         nWWlpog5X9iEqEXQL82wp7kVd+nstP9Ax7PNMtZZwPgqvZJWODidLwpPkZxgXNXo2b0m
         aylQ==
X-Gm-Message-State: AGi0PuZNC2nyExO5m54YTINsDCAE6D5EvziFoOqi1bgpOGEyrxPk/b+b
        a0pT8AYqR6jbTEOJKX/XwG4=
X-Google-Smtp-Source: APiQypKL4l5XzT5d8T4EDUnSiLIA6SEXjEYTfcdL4oM5Poxa+fvYuw8On5zLYw4uwlEgUzCW89McQg==
X-Received: by 2002:a1c:b445:: with SMTP id d66mr13680620wmf.187.1588577757859;
        Mon, 04 May 2020 00:35:57 -0700 (PDT)
Received: from localhost (ip-37-188-183-9.eurotel.cz. [37.188.183.9])
        by smtp.gmail.com with ESMTPSA id w6sm18583454wrm.86.2020.05.04.00.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 00:35:57 -0700 (PDT)
Date:   Mon, 4 May 2020 09:35:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200504073549.GE22838@dhcp22.suse.cz>
References: <20200430182712.237526-1-shakeelb@google.com>
 <CALOAHbC4WY00yQ46b8CFqVQ3S=JSJxE2HR00TtMqXOWLRPRZ8w@mail.gmail.com>
 <20200504070301.GC22838@dhcp22.suse.cz>
 <CALOAHbCJBaa26m2cUkE0evwDnSFvUPrdBg9=WMjC7Yt_33-BJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbCJBaa26m2cUkE0evwDnSFvUPrdBg9=WMjC7Yt_33-BJQ@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 04-05-20 15:26:52, Yafang Shao wrote:
> On Mon, May 4, 2020 at 3:03 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Fri 01-05-20 09:39:24, Yafang Shao wrote:
> > > On Fri, May 1, 2020 at 2:27 AM Shakeel Butt <shakeelb@google.com> wrote:
> > > >
> > > > Lowering memory.max can trigger an oom-kill if the reclaim does not
> > > > succeed. However if oom-killer does not find a process for killing, it
> > > > dumps a lot of warnings.
> > > >
> > >
> > > I have been confused by this behavior for several months and I think
> > > it will confuse more memcg users.
> >
> > Could you be more specific what has caused the confusion?
> >
> 
> No task is different from no eligible task.
> No eligible task means there are some candidates but no one is eligible.
> Whille no task means there is no candidate.

I really fail to see a difference. It is clear the one is subset of the
other but in practical life tasks might come and go at any time and if
you try to reduce the hard limit and there are no tasks that could be
reclaimed then I believe we should complain whether it is only oom
disabled tasks or no tasks at all. It is certainly unexpected situation
in some cases because there are resources which are bound to the memcg
without any task we can act on.

> > > We should keep the memcg oom behavior consistent with system oom - no
> > > oom kill if no process.
> >
> > This is not the global mmemcg behavior. We do complain loud on no
> > eligible tasks and actually panic the system. Memcg cannot simply
> > do the same by default for obvious reasons.
> >
> 
> As explianed above, no eligible task is different from no task.
> If there are some candidates but no one is eligible, the system will panic.
> While if there's no task, it is definitely no OOM, because that's an
> improssible thing for the system.

This is very much possible situation when all eligible tasks have been
already killed but they didn't really help to resolve the oom situation
- e.g. in kernel memory leak or unbounded shmem consumption etc...

-- 
Michal Hocko
SUSE Labs
