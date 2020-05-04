Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA9A1C3EBB
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2020 17:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgEDPkB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 May 2020 11:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728294AbgEDPkA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 May 2020 11:40:00 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B8EC061A0E;
        Mon,  4 May 2020 08:40:00 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id b12so12746913ion.8;
        Mon, 04 May 2020 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GSh55CCbMhlQ6Ehk5ylQlYonoWrHiCRrR3CxkJ5viUw=;
        b=TMVmOxzBKI7LellWJ7F60mt/JpgFh9iwcKncHCdLGVXpAg3hKnj/oHvXTGDDBRBzd1
         wULU6BtCjnNoxLOyvLQNRqdmUdcIBxlQ4fWOA2mQLZhjRGcFHtnDq1vk56r0qqVlG/8a
         zJSV31XxaCFB1B6FlzYpxlvVlD4uzeCrg1R/IEoeZlOXGMHnRUZfjvq+UHzjb7wd9A3a
         i5hnBEKsw03lfNr9KXKkvmZ73tdCHjs0hxcFnzGFl/MeFVfzbtfP/aR+wbujiGhWv4Fi
         6UDReaAPsD5LzC3wPGT7pC2DdnLauFJ9WwZP73mdyBNLLZ5D1uNx9UnBxQJ8m/QDV+EV
         838g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSh55CCbMhlQ6Ehk5ylQlYonoWrHiCRrR3CxkJ5viUw=;
        b=VuVvNeYOnR6hq9JCv82oBMRcAP3Bnk9qAvhiSLavnRBVi3UiEU5rcDO3loJ1SSwTgy
         uipYtNfsx+PjW1E+vCUDwl3njxHAOTPHd5nJm4M/mM1rFNJZhaxkjckOLZicxdR//DNP
         7gpJXvnZXRJScZGnLXO+VaDqU4wFrCOj3LvidkfYb+RcMhVrhR66YprbtWe4+XPzCsJJ
         EGfQPPSmqJBNirJR4655Cs8MI6X1WS+hiZYb6qxx/WOVC7D5eVoW1eDe6lbVjtoAPXgR
         cf6wB7Ez6X+Haa3wq7aKKjSIFGYS0KqzgLtX/ZBxOVpggLx3cqfE8wt2wMRJsuAWsvQS
         I5lg==
X-Gm-Message-State: AGi0PuYNgVz6AL2uJm0nVR9rVcYWsTytu1Ms9inMxHUvtkXol4UwFFF6
        kh2zW6+frYC9RCIA5Ee9FjzYuzHkOW6yGoGOMnxncKPzEdw=
X-Google-Smtp-Source: APiQypL6wbyjFbj5yLrzGcBcVeHFcmQNaNaIDoEiwyxvlC5/IVvgDQmFeu9cpbRCrq64VWTYRaX6UbiJRzgyTH+6Mjs=
X-Received: by 2002:a6b:3c0a:: with SMTP id k10mr16045599iob.10.1588606799979;
 Mon, 04 May 2020 08:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200430182712.237526-1-shakeelb@google.com> <20200504065600.GA22838@dhcp22.suse.cz>
 <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com>
 <20200504141136.GR22838@dhcp22.suse.cz> <CALvZod7Ls7rTDOr5vXwEiPneLqbq3JoxfFBxZZ71YWgvLkNr5A@mail.gmail.com>
 <20200504150052.GT22838@dhcp22.suse.cz> <CALvZod7EeQm-T4dsBddfMY_szYw3m8gRh5R5GfjQiuQAtCocug@mail.gmail.com>
In-Reply-To: <CALvZod7EeQm-T4dsBddfMY_szYw3m8gRh5R5GfjQiuQAtCocug@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 4 May 2020 23:39:24 +0800
Message-ID: <CALOAHbCK4dBmL059Lodr-Z-WDnw_f0YtqD8YmaJ0ajGdHYrqhA@mail.gmail.com>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 4, 2020 at 11:36 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Mon, May 4, 2020 at 8:00 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 04-05-20 07:53:01, Shakeel Butt wrote:
> > > On Mon, May 4, 2020 at 7:11 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > > On Mon 04-05-20 06:54:40, Shakeel Butt wrote:
> > > > > On Sun, May 3, 2020 at 11:56 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > > > >
> > > > > > On Thu 30-04-20 11:27:12, Shakeel Butt wrote:
> > > > > > > Lowering memory.max can trigger an oom-kill if the reclaim does not
> > > > > > > succeed. However if oom-killer does not find a process for killing, it
> > > > > > > dumps a lot of warnings.
> > > > > >
> > > > > > It shouldn't dump much more than the regular OOM report AFAICS. Sure
> > > > > > there is "Out of memory and no killable processes..." message printed as
> > > > > > well but is that a real problem?
> > > > > >
> > > > > > > Deleting a memcg does not reclaim memory from it and the memory can
> > > > > > > linger till there is a memory pressure. One normal way to proactively
> > > > > > > reclaim such memory is to set memory.max to 0 just before deleting the
> > > > > > > memcg. However if some of the memcg's memory is pinned by others, this
> > > > > > > operation can trigger an oom-kill without any process and thus can log a
> > > > > > > lot un-needed warnings. So, ignore all such warnings from memory.max.
> > > > > >
> > > > > > OK, I can see why you might want to use memory.max for that purpose but
> > > > > > I do not really understand why the oom report is a problem here.
> > > > >
> > > > > It may not be a problem for an individual or small scale deployment
> > > > > but when "sweep before tear down" is the part of the workflow for
> > > > > thousands of machines cycling through hundreds of thousands of cgroups
> > > > > then we can potentially flood the logs with not useful dumps and may
> > > > > hide (or overflow) any useful information in the logs.
> > > >
> > > > If you are doing this in a large scale and the oom report is really a
> > > > problem then you shouldn't be resetting hard limit to 0 in the first
> > > > place.
> > > >
> > >
> > > I think I have pretty clearly described why we want to reset the hard
> > > limit to 0, so, unless there is an alternative I don't see why we
> > > should not be doing this.
> >
> > I am not saying you shouldn't be doing that. I am just saying that if
> > you do then you have to live with oom reports.
> >
> > > > > > memory.max can trigger the oom kill and user should be expecting the oom
> > > > > > report under that condition. Why is "no eligible task" so special? Is it
> > > > > > because you know that there won't be any tasks for your particular case?
> > > > > > What about other use cases where memory.max is not used as a "sweep
> > > > > > before tear down"?
> > > > >
> > > > > What other such use-cases would be? The only use-case I can envision
> > > > > of adjusting limits dynamically of a live cgroup are resource
> > > > > managers. However for cgroup v2, memory.high is the recommended way to
> > > > > limit the usage, so, why would resource managers be changing
> > > > > memory.max instead of memory.high? I am not sure. What do you think?
> > > >
> > > > There are different reasons to use the hard limit. Mostly to contain
> > > > potential runaways. While high limit might be a sufficient measure to
> > > > achieve that as well the hard limit is the last resort. And it clearly
> > > > has the oom killer semantic so I am not really sure why you are
> > > > comparing the two.
> > > >
> > >
> > > I am trying to see if "no eligible task" is really an issue and should
> > > be warned for the "other use cases". The only real use-case I can
> > > think of are resource managers adjusting the limit dynamically. I
> > > don't see "no eligible task" a concerning reason for such use-case.
> >
> > It is very much a concerning reason to notify about like any other OOM
> > situation due to hard limit breach. In this case it is worse in some
> > sense because the limit cannot be trimmed down because there is no
> > directly reclaimable memory at all. Such an oom situation is
> > effectivelly conserved.
> > --
>
> Let me make a more precise statement and tell me if you agree. The "no
> eligible task" is concerning for the charging path but not for the
> writer of memory.max. The writer can read the usage and
> cgroup.[procs|events] to figure out the situation if needed.

Agreed.
cgroup.[procs|events] can give all the admin want in this situation.
The oom report is a redundant infomation, really.

> Usually
> such writers (i.e. resource managers) use memory.high in addition to
> memory.max. First set memory.high and once the usage is below the high
> then set max to not induce the oom-kills.
>



-- 
Thanks
Yafang
