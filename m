Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8311C3DF0
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2020 17:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgEDPA7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 May 2020 11:00:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56126 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbgEDPA6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 May 2020 11:00:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id e26so8852628wmk.5;
        Mon, 04 May 2020 08:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tJ5etNEXsxt7E9ZceP21z7vkGhvbdJvXpUDXj5OxOH0=;
        b=TUfk0G1174QGxz8rsA9PkEPAcJXdD7AaqH9gp5I0Njykl9quRzmDrpfnJhujZ+DDos
         Qe9B+gch3jguuB24ZdoFPyuPmpu4dzDOwUB2JeRHhTztz8iuW/UMZ5HONaxSSKOp/heL
         nkLtrdMLSJsV75xNl3kcMsMEl572w65iV7ZzL2HBZibJ6cY1sIUh/WwNTZ2ahvbev0rs
         skS68sGYKCl0NgQuQNgPQZzy/oYYfuFE50EC8o0opiKVxhY52M6YsHXOmXqd3qqlcYWD
         92YUP8SLf/8ubbFr6v33Tb7XPm9V3HQxz8Wwn/HSzkEx4mhesUQwTsa7zf0y/nPKfXiG
         SEIA==
X-Gm-Message-State: AGi0Pualc07v4TkInnEodta/K9KYnOCvTnwWTCN3+O6GqOq5VMbAMd5Q
        DIK/w/kLukCQJJ9q/gdsZIg=
X-Google-Smtp-Source: APiQypJQHKMQIRZdJ8nNLXQjOA202ammJbzJLV5W2BPzSNYKXJ7sgyYhV0l8zzxSdFgng1kNGOagoA==
X-Received: by 2002:a05:600c:220c:: with SMTP id z12mr14797153wml.84.1588604455378;
        Mon, 04 May 2020 08:00:55 -0700 (PDT)
Received: from localhost (ip-37-188-183-9.eurotel.cz. [37.188.183.9])
        by smtp.gmail.com with ESMTPSA id 138sm14956344wmb.14.2020.05.04.08.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 08:00:54 -0700 (PDT)
Date:   Mon, 4 May 2020 17:00:52 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200504150052.GT22838@dhcp22.suse.cz>
References: <20200430182712.237526-1-shakeelb@google.com>
 <20200504065600.GA22838@dhcp22.suse.cz>
 <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com>
 <20200504141136.GR22838@dhcp22.suse.cz>
 <CALvZod7Ls7rTDOr5vXwEiPneLqbq3JoxfFBxZZ71YWgvLkNr5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7Ls7rTDOr5vXwEiPneLqbq3JoxfFBxZZ71YWgvLkNr5A@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 04-05-20 07:53:01, Shakeel Butt wrote:
> On Mon, May 4, 2020 at 7:11 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 04-05-20 06:54:40, Shakeel Butt wrote:
> > > On Sun, May 3, 2020 at 11:56 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Thu 30-04-20 11:27:12, Shakeel Butt wrote:
> > > > > Lowering memory.max can trigger an oom-kill if the reclaim does not
> > > > > succeed. However if oom-killer does not find a process for killing, it
> > > > > dumps a lot of warnings.
> > > >
> > > > It shouldn't dump much more than the regular OOM report AFAICS. Sure
> > > > there is "Out of memory and no killable processes..." message printed as
> > > > well but is that a real problem?
> > > >
> > > > > Deleting a memcg does not reclaim memory from it and the memory can
> > > > > linger till there is a memory pressure. One normal way to proactively
> > > > > reclaim such memory is to set memory.max to 0 just before deleting the
> > > > > memcg. However if some of the memcg's memory is pinned by others, this
> > > > > operation can trigger an oom-kill without any process and thus can log a
> > > > > lot un-needed warnings. So, ignore all such warnings from memory.max.
> > > >
> > > > OK, I can see why you might want to use memory.max for that purpose but
> > > > I do not really understand why the oom report is a problem here.
> > >
> > > It may not be a problem for an individual or small scale deployment
> > > but when "sweep before tear down" is the part of the workflow for
> > > thousands of machines cycling through hundreds of thousands of cgroups
> > > then we can potentially flood the logs with not useful dumps and may
> > > hide (or overflow) any useful information in the logs.
> >
> > If you are doing this in a large scale and the oom report is really a
> > problem then you shouldn't be resetting hard limit to 0 in the first
> > place.
> >
> 
> I think I have pretty clearly described why we want to reset the hard
> limit to 0, so, unless there is an alternative I don't see why we
> should not be doing this.

I am not saying you shouldn't be doing that. I am just saying that if
you do then you have to live with oom reports.

> > > > memory.max can trigger the oom kill and user should be expecting the oom
> > > > report under that condition. Why is "no eligible task" so special? Is it
> > > > because you know that there won't be any tasks for your particular case?
> > > > What about other use cases where memory.max is not used as a "sweep
> > > > before tear down"?
> > >
> > > What other such use-cases would be? The only use-case I can envision
> > > of adjusting limits dynamically of a live cgroup are resource
> > > managers. However for cgroup v2, memory.high is the recommended way to
> > > limit the usage, so, why would resource managers be changing
> > > memory.max instead of memory.high? I am not sure. What do you think?
> >
> > There are different reasons to use the hard limit. Mostly to contain
> > potential runaways. While high limit might be a sufficient measure to
> > achieve that as well the hard limit is the last resort. And it clearly
> > has the oom killer semantic so I am not really sure why you are
> > comparing the two.
> >
> 
> I am trying to see if "no eligible task" is really an issue and should
> be warned for the "other use cases". The only real use-case I can
> think of are resource managers adjusting the limit dynamically. I
> don't see "no eligible task" a concerning reason for such use-case.

It is very much a concerning reason to notify about like any other OOM
situation due to hard limit breach. In this case it is worse in some
sense because the limit cannot be trimmed down because there is no
directly reclaimable memory at all. Such an oom situation is
effectivelly conserved.
-- 
Michal Hocko
SUSE Labs
