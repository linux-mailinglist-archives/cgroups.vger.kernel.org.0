Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDBB217303
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2020 17:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgGGPvn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Jul 2020 11:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbgGGPvm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Jul 2020 11:51:42 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D7AC08C5DC
        for <cgroups@vger.kernel.org>; Tue,  7 Jul 2020 08:51:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z24so25597729ljn.8
        for <cgroups@vger.kernel.org>; Tue, 07 Jul 2020 08:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/kOBwO7OLhAG5/zoDioEbhDbIra0ifUwtyOcu+taVE=;
        b=L3SIjbQ2aGUMKNVOsgYJSH0RyGv1yqE3EspINaDxV4Qp8l0EecCKFOqwnxga/y+h8Y
         2X0KH3FZOV8/IlyRauMigZhGEIdAaQWWZD+yMxaZDDJrf0UKEJCKQTztAwNoUxcOcoSr
         8MLugsOwfz0qFWdozatId6q9p//k2M4rt6i+b82/4DZD+KliP8EFP5t2gEeqrOJX9hZL
         5U+eSXspaw2k59P+sBud1CuBDW7zu5vUC6+vNCHxtZRxVveGPJaXdmkBhF1NZ9SqydwI
         elgQJT7e7qGxHtzdpoLU8GvAZlD/n7SQevJljznZY23clvyeaem0Qz6xKoorVTHKsPlf
         +xuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/kOBwO7OLhAG5/zoDioEbhDbIra0ifUwtyOcu+taVE=;
        b=cjvGvIX2saR8rI8axTevNVROgbpKaHej6bQ9WWACMUX8Zvq2IuYk3vjwcJ2UGPlnAS
         rBrMvOkvpCeV4/MbWcrM5hDDIYQNhagtVPFHlNwDAKse4w63bsiVriQeTrjXxhxIS//O
         A3ie3ladsP15Y0MX/WtqR8V4Mc5PUmaYbl2FOI6jJplgdPNJjRFuiOMLBo1TI8wePz1x
         UqtAjQ1gFEQdj19C7RZDWXEhZdaj6VX5QkDT9g0LtX6Bb4ubPdUEgz3x5QMGt5xe9jnB
         bA1nRnlveQi8tN3UwHAGzvx7THHxpV/AVNWzJJkuSNA7fte8mLzW7/QBd+GE6a/eOriY
         zZHg==
X-Gm-Message-State: AOAM530IzkISannE9+dKI4phuX85UgJXayt7oWaSHi3V05zSyvKRh58I
        QFmr7lqpA9VuAide8PNdwuL7gZuH83rCYCIRAv+6lw==
X-Google-Smtp-Source: ABdhPJyWaoNm3VNK+Rrjg/sAMM/2RSzMf89FEFqIRJwKBh4jHqzLzK0U/GjrgZx+sjtuR+WLH8QN9UOhGSB/bj4TUFY=
X-Received: by 2002:a2e:8e36:: with SMTP id r22mr31066177ljk.77.1594137100635;
 Tue, 07 Jul 2020 08:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200702152222.2630760-1-shakeelb@google.com> <20200703063548.GM18446@dhcp22.suse.cz>
 <CALvZod5gthVX5m6o50OiYsXa=0_NpXK-tVvjTF42Oj4udr4Nuw@mail.gmail.com>
 <20200703155021.GB114903@carbon.dhcp.thefacebook.com> <CALvZod5Z4=1CijJp0QRnx+pdH=Me6sYPXASCxVATnshU0RW-Qw@mail.gmail.com>
 <20200706213404.GA152560@carbon.lan>
In-Reply-To: <20200706213404.GA152560@carbon.lan>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 7 Jul 2020 08:51:29 -0700
Message-ID: <CALvZod4PukYDdG2tQZvzW+5rNULYjHrJnJxk=a4t_-udiEdaOA@mail.gmail.com>
Subject: Re: [RFC PROPOSAL] memcg: per-memcg user space reclaim interface
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 6, 2020 at 2:38 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Jul 03, 2020 at 09:27:19AM -0700, Shakeel Butt wrote:
> > On Fri, Jul 3, 2020 at 8:50 AM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > On Fri, Jul 03, 2020 at 07:23:14AM -0700, Shakeel Butt wrote:
> > > > On Thu, Jul 2, 2020 at 11:35 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > > >
> > > > > On Thu 02-07-20 08:22:22, Shakeel Butt wrote:
> > > > > [...]
> > > > > > Interface options:
> > > > > > ------------------
> > > > > >
> > > > > > 1) memcg interface e.g. 'echo 10M > memory.reclaim'
> > > > > >
> > > > > > + simple
> > > > > > + can be extended to target specific type of memory (anon, file, kmem).
> > > > > > - most probably restricted to cgroup v2.
> > > > > >
> > > > > > 2) fadvise(PAGEOUT) on cgroup_dir_fd
> > > > > >
> > > > > > + more general and applicable to other FSes (actually we are using
> > > > > > something similar for tmpfs).
> > > > > > + can be extended in future to just age the LRUs instead of reclaim or
> > > > > > some new use cases.
> > > > >
> > > > > Could you explain why memory.high as an interface to trigger pro-active
> > > > > memory reclaim is not sufficient. Also memory.low limit to protect
> > > > > latency sensitve workloads?
> > >
> > > I initially liked the proposal, but after some thoughts I've realized
> > > that I don't know a good use case where memory.high is less useful.
> > > Shakeel, what's the typical use case you thinking of?
> > > Who and how will use the new interface?
> > >
> > > >
> > > > Yes, we can use memory.high to trigger [proactive] reclaim in a memcg
> > > > but note that it can also introduce stalls in the application running
> > > > in that memcg. Let's suppose the memory.current of a memcg is 100MiB
> > > > and we want to reclaim 20MiB from it, we can set the memory.high to
> > > > 80MiB but any allocation attempt from the application running in that
> > > > memcg can get stalled/throttled. I want the functionality of the
> > > > reclaim without potential stalls.
> > >
> > > But reclaiming some pagecache/swapping out anon pages can always
> > > generate some stalls caused by pagefaults, no?
> > >
> >
> > Thanks for looking into the proposal. Let me answer both of your
> > questions together. I have added the two use-cases but let me explain
> > the proactive reclaim a bit more as we actually use that in our
> > production.
> >
> > We have defined tolerable refault rates for the applications based on
> > their type (latency sensitive or not). Proactive reclaim is triggered
> > in the application based on their current refault rates and usage. If
> > the current refault rate exceeds the tolerable refault rate then
> > stop/slowdown the proactive reclaim.
> >
> > For the second question, yes, each individual refault can induce the
> > stall as well but we have more control on that stall as compared to
> > stalls due to reclaim. For us almost all the reclaimable memory is
> > anon and we use compression based swap, so, the cost of each refault
> > is fixed and a couple of microseconds.
> >
> > I think the next question is what about the refaults from disk or
> > source with highly variable cost. Usually the latency sensitive
> > applications remove such uncertainty by mlocking the pages backed by
> > such backends (e.g. mlocking the executable) or at least that is the
> > case for us.
>
> Got it.
>
> It feels like you're suggesting something similar to memory.high with
> something similar to a different gfp flags. In other words, the
> difference is only which pages can be reclaimed and which not. I don't
> have a definitive answer here, but I wonder if we can somehow
> generalize the existing interface? E.g. if the problem is with artificially
> induced delays, we can have a config option/sysctl/sysfs knob/something else
> which would disable it. Otherwise we risk ending up with many different kinds
> of soft memory limits.
>

It is possible to achieve this functionality with memory.high with
some config/sysctls e.t.c as you suggested but it can bloat and
complicate the memory.high interface.

I understand your concern with different kinds of soft memory limits
but I see this as a simple interface (i.e. just trigger reclaim) that
gives users the flexibility to define and (soft) enforce their own
virtual limits on their jobs. More specifically this interface allows
reclaiming from a job to keep the usage below some virtual limit which
can correspond to some user defined metric. In my proactive reclaim
example, the user defined metric is refault rates. Keep the usage of
the job at a level where the refault rates are tolerable.
