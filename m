Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284F41C3398
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2020 09:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgEDH13 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 May 2020 03:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726411AbgEDH12 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 May 2020 03:27:28 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BCAC061A0E;
        Mon,  4 May 2020 00:27:28 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id k18so11278896ion.0;
        Mon, 04 May 2020 00:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMJTVwSpQyn/xhp6u+6GN4IMzd//JO41IoEamQ3Zdks=;
        b=csXHDouWQKCAwTYKTsY1cASrw5qLOU/SQ44aHH4e81YyhyyL+8s1fWSxJpJ5ffI8KV
         d+KwWvWpX5ERgqxViOJh805MGZR8BCZnslt3tne6AIXodMd4WEsBUwG/M0VOBAwFNoq/
         oU3xk4oQzjzT+CaztpFeZHTqXMnSHlilEoXJMCxGQyN7vyPZXKZWhmzlAVnb3WwAJnb5
         NLeog00FIK2RkmW7v4PBWkntAt2GFu5annHvVtE74Z0EiDD/M+632aOqt9WkfcJ4gf9m
         N0OKc0cld4iN3Iu3cQzZ979BtN1/FrwwapSxzY+BmT1CEdehAZkHwqcOs6OzMas34b+0
         CZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMJTVwSpQyn/xhp6u+6GN4IMzd//JO41IoEamQ3Zdks=;
        b=DUPD4S/NdfoWucpqK20WeYHpB2nc/qUfnnDvVGAzzQyWLWH3fyNTxbKBomrFF0r+Uu
         gnVLd85WntqTvM9zfGGz4A7ZNHgvFVJkLksX++N63WYHgQX8L2/gfv83E0M1Yi2gA9aH
         dHQILMz2z2BVUJ5/CWD3hZ9ZJZAQdukstLk0WgjWzphev9vXEejZCy6xSIcwAjB8N8Wq
         I9HwQTNE9HMGChgRC8b5SbmgXuqp8KXoJRSK6+7OsaCmhGR9oJo0qS4tyI716bJHx+JU
         6hno1hZLRx1DKLURyT8KQGUwuOy5EmrcMvoHWypnfGpNRT2BUvCdkUcTfCQKFeamuvNN
         9udw==
X-Gm-Message-State: AGi0PuYAvx5qRqpWwL/CRJkPRRnjtYRyYU68earkIYpzaM54RQiC54Fb
        EtNnO7eNyxajPfahY0Kzp9QRRhl9q67H8guJBSc=
X-Google-Smtp-Source: APiQypKauny7pNm2r6ST+LyFVdIuSErhtJktThj5aZhJs1/fSoYNc1LcW+dhgsaA1u1qJZSgyljGoJvTH49r+fAsBPA=
X-Received: by 2002:a6b:d219:: with SMTP id q25mr14278247iob.202.1588577247883;
 Mon, 04 May 2020 00:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200430182712.237526-1-shakeelb@google.com> <CALOAHbC4WY00yQ46b8CFqVQ3S=JSJxE2HR00TtMqXOWLRPRZ8w@mail.gmail.com>
 <20200504070301.GC22838@dhcp22.suse.cz>
In-Reply-To: <20200504070301.GC22838@dhcp22.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 4 May 2020 15:26:52 +0800
Message-ID: <CALOAHbCJBaa26m2cUkE0evwDnSFvUPrdBg9=WMjC7Yt_33-BJQ@mail.gmail.com>
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

On Mon, May 4, 2020 at 3:03 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 01-05-20 09:39:24, Yafang Shao wrote:
> > On Fri, May 1, 2020 at 2:27 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > Lowering memory.max can trigger an oom-kill if the reclaim does not
> > > succeed. However if oom-killer does not find a process for killing, it
> > > dumps a lot of warnings.
> > >
> >
> > I have been confused by this behavior for several months and I think
> > it will confuse more memcg users.
>
> Could you be more specific what has caused the confusion?
>

No task is different from no eligible task.
No eligible task means there are some candidates but no one is eligible.
Whille no task means there is no candidate.

> > We should keep the memcg oom behavior consistent with system oom - no
> > oom kill if no process.
>
> This is not the global mmemcg behavior. We do complain loud on no
> eligible tasks and actually panic the system. Memcg cannot simply
> do the same by default for obvious reasons.
>

As explianed above, no eligible task is different from no task.
If there are some candidates but no one is eligible, the system will panic.
While if there's no task, it is definitely no OOM, because that's an
improssible thing for the system.

> > What about bellow change ?
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e28098e13f1c..25fbc37a747f 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6086,6 +6086,9 @@ static ssize_t memory_max_write(struct
> > kernfs_open_file *of,
> >                         continue;
> >                 }
> >
> > +               if (!cgroup_is_populated(memcg->css.cgroup))
> > +                       break;
> > +
> >                 memcg_memory_event(memcg, MEMCG_OOM);
> >                 if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0))
> >                         break;
>
> I am not a great fan to be honest. The warning might be useful for other
> usecases when it is not clear that the memcg is empty.
>

The other usecase can still get the oom status fomr the MEMCG_OOM
event, see bellow,

                 memcg_memory_event(memcg, MEMCG_OOM);
+               if (!cgroup_is_populated(memcg->css.cgroup))
+                       break;

See also https://lore.kernel.org/linux-mm/20200504042621.10334-3-laoar.shao@gmail.com/T/#u


-- 
Thanks
Yafang
