Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288D01C33CA
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2020 09:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgEDHkz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 May 2020 03:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727088AbgEDHkz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 May 2020 03:40:55 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0970EC061A0E;
        Mon,  4 May 2020 00:40:55 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id m5so10332468ilj.10;
        Mon, 04 May 2020 00:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+OO9udw59FljC0Juy5HE0xNXWZK83D2kTv8ScoSvNNE=;
        b=RXefm4KBKTPlPnFlni95cg+CtOH9b765c48sU8nUlEhEB6EumsSO7LjzkJt8NUn65G
         vOOWU6bFdm2gvvMx6RlE8PrzCR8Ew8KJhXvf4za6A6ZT1DYzSx3ikRwQ2Yi2Bwhbvg1W
         HM5RxZ0vvltitG3kmuTKlIFvOfHLWsXcJak3TyNHBAJrQmnVbqbEnWRFYl/w61Gh6hb+
         8kwdkbqDZR1AW9HYi0FGI4Ck2gp1rw8FmIobCNYj1gmwoqD3rqkxaC/Wu/8y+/B4L7Sq
         40pV1onyrHfUiU7qiqBrE1gN3DCUKq+l7gVCJRJKNNAshlTKbKzkc4NC7j9wSM52zncH
         7PJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+OO9udw59FljC0Juy5HE0xNXWZK83D2kTv8ScoSvNNE=;
        b=QFVOu8sZDjgSEkG4idQnDPWE1AVh19pmetIQeuOniUf0cONhBUWw8O3HxlJTg6kAJs
         noI9SbANxPql2Ryapq05+iN2zt4eRAlb1ZvxATT8/4/bVJmWfV83iro3S0Nq245GSD8K
         1XPD8uPtv9DCapA6GJTsheJ+TYeKz5Ln490aodMcwOcIIfkuNZ7v1QNc5KMIk/F/DiBs
         ffJjk92YrcT8YByNGz/KG6r2ugL+XuFWJbGMYcumfk4dAKC8ENJ6Gd4Laj2Xi/sS6Lhd
         BBnAKYQVKAskwIiCQp4t06zEOBXupGRp2QnLXCpafOHVnQ3UHOqLTl4STqnzqtyalFMN
         vI5w==
X-Gm-Message-State: AGi0PuYMPR500hhIZEEH+FHjStT+h7ILSZ6KWSfN5NqUJ6Sy46Dyvxl1
        /6ydLJjTfFPg651jRWnV8nfAam9WILBtYydY7DE=
X-Google-Smtp-Source: APiQypLkT9cMtwT1HsSioOHVgclm/SOt/d4uNZIorINV9eqsalSMTUGi0eKY9Fr2ra2wl5fGbE7rzM15bN7WkKlbLss=
X-Received: by 2002:a92:1b91:: with SMTP id f17mr14838063ill.142.1588578054398;
 Mon, 04 May 2020 00:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200430182712.237526-1-shakeelb@google.com> <CALOAHbC4WY00yQ46b8CFqVQ3S=JSJxE2HR00TtMqXOWLRPRZ8w@mail.gmail.com>
 <20200504070301.GC22838@dhcp22.suse.cz> <CALOAHbCJBaa26m2cUkE0evwDnSFvUPrdBg9=WMjC7Yt_33-BJQ@mail.gmail.com>
 <20200504073549.GE22838@dhcp22.suse.cz>
In-Reply-To: <20200504073549.GE22838@dhcp22.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 4 May 2020 15:40:18 +0800
Message-ID: <CALOAHbDd8hjURSi9jAdjQTbSLDvu9vkOkjS1hZNn04G8Yj7WdQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
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

On Mon, May 4, 2020 at 3:35 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 04-05-20 15:26:52, Yafang Shao wrote:
> > On Mon, May 4, 2020 at 3:03 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Fri 01-05-20 09:39:24, Yafang Shao wrote:
> > > > On Fri, May 1, 2020 at 2:27 AM Shakeel Butt <shakeelb@google.com> wrote:
> > > > >
> > > > > Lowering memory.max can trigger an oom-kill if the reclaim does not
> > > > > succeed. However if oom-killer does not find a process for killing, it
> > > > > dumps a lot of warnings.
> > > > >
> > > >
> > > > I have been confused by this behavior for several months and I think
> > > > it will confuse more memcg users.
> > >
> > > Could you be more specific what has caused the confusion?
> > >
> >
> > No task is different from no eligible task.
> > No eligible task means there are some candidates but no one is eligible.
> > Whille no task means there is no candidate.
>
> I really fail to see a difference. It is clear the one is subset of the
> other but in practical life tasks might come and go at any time and if
> you try to reduce the hard limit and there are no tasks that could be
> reclaimed then I believe we should complain whether it is only oom
> disabled tasks or no tasks at all. It is certainly unexpected situation
> in some cases because there are resources which are bound to the memcg
> without any task we can act on.
>
> > > > We should keep the memcg oom behavior consistent with system oom - no
> > > > oom kill if no process.
> > >
> > > This is not the global mmemcg behavior. We do complain loud on no
> > > eligible tasks and actually panic the system. Memcg cannot simply
> > > do the same by default for obvious reasons.
> > >
> >
> > As explianed above, no eligible task is different from no task.
> > If there are some candidates but no one is eligible, the system will panic.
> > While if there's no task, it is definitely no OOM, because that's an
> > improssible thing for the system.
>
> This is very much possible situation when all eligible tasks have been
> already killed but they didn't really help to resolve the oom situation
> - e.g. in kernel memory leak or unbounded shmem consumption etc...
>

That's still an impossible thing, because many tasks are invisible to
the oom killer.
See oom_unkillable_task().



-- 
Thanks
Yafang
