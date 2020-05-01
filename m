Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCDA1C0BFF
	for <lists+cgroups@lfdr.de>; Fri,  1 May 2020 04:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgEACNi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Apr 2020 22:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727889AbgEACNi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Apr 2020 22:13:38 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DD7C035494;
        Thu, 30 Apr 2020 19:13:36 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id c2so3687042iow.7;
        Thu, 30 Apr 2020 19:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYDJWeCLlhw8lr2MHLhmVsV4j9mOvkGGvmRilWGWRrg=;
        b=Xog+ZZ3lCM/XaSVs+gBhESPLwp4WAlt3K7H146kG7Z6OxZj41VMjwJnXT9s0237dpB
         76vjiueRHg/SNAru0/gtuf3l91l4oxhxmb5/7eL/SDC4k/AFQg+5u8uUXvtlQe0pYsp1
         kmV2qpDLJxmzAS57vYTIDZPyMZ/L/Vh538ALb35lYy2T9/Jf4IzLli2P/PV9VC5czGcG
         QXImWSoImGoev+0CYE7RKP6UKUoKP12x6/KC0ActMx6SzeN/o8EEAntBDBAYQ4aKFAKG
         b4MT7QU1JXNPMA6mQFNCPs+5bsFUcN3KbIioAHnyazIpPH91oFDb3sLkoT+/I56sw3nM
         dm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYDJWeCLlhw8lr2MHLhmVsV4j9mOvkGGvmRilWGWRrg=;
        b=Q6/L0fGpStxD7CR1Yn9LEg+bQfQX/5Gj95gSgTC9cQMIeayjAz88gYn2G7LfgHix1R
         Fe51om95+FeeMDmnd5HmduSQ7JtE0jF/XGQ7b4acj4M2mLGOcwILFhLsx+lkywzT0RiG
         OfxzoGULnbSiU34QukIBcJqhEXS4GgUsXOmqs+1+a2GffYwjz2DdpY8GR+A50VAfJv39
         YkwN1EsFXUWFFyFZ6LAeBpdxgxiwJqZ/O97HrPyNsHgOOqpbW+OUiqrlmVznppwG1J+J
         OsY3N9Kk/T3auqo7JHe2MVHERezm/v74oqOAi2S/+zitrgcRMsWoLdcsoNJ7CIWG31AH
         RDvw==
X-Gm-Message-State: AGi0PuarO+2qHnUIUIAnwrZ84FGmshEVF2y02QLQtCI1lV0IYg1N4slT
        FkshT6W3D8vm0xuLy+7ok2y5F8y8UsfiwcCfZmE=
X-Google-Smtp-Source: APiQypKGz0Gne2nX+o+Qe1qKhOhnsWZuQcjrp1Y5mU4C2lDwzd9brFql0s85v6OJ6EpdeCnNPCbyDLk7pi82FXc9Vvc=
X-Received: by 2002:a02:ccad:: with SMTP id t13mr1381837jap.64.1588299215975;
 Thu, 30 Apr 2020 19:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200430182712.237526-1-shakeelb@google.com> <CALOAHbC4WY00yQ46b8CFqVQ3S=JSJxE2HR00TtMqXOWLRPRZ8w@mail.gmail.com>
 <CALvZod4gZ_Q=Kuh-Fx-EsKzxmtPKy5xu+gpPpjV6MYW4Ku=JbA@mail.gmail.com>
In-Reply-To: <CALvZod4gZ_Q=Kuh-Fx-EsKzxmtPKy5xu+gpPpjV6MYW4Ku=JbA@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 1 May 2020 10:12:59 +0800
Message-ID: <CALOAHbC03gBh6d61yy0T6Vcy5jwNUS3EN7wE_Udx-zLyxT0COw@mail.gmail.com>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 1, 2020 at 10:04 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Apr 30, 2020 at 6:39 PM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Fri, May 1, 2020 at 2:27 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > Lowering memory.max can trigger an oom-kill if the reclaim does not
> > > succeed. However if oom-killer does not find a process for killing, it
> > > dumps a lot of warnings.
> > >
> >
> > I have been confused by this behavior for several months and I think
> > it will confuse more memcg users.
> > We should keep the memcg oom behavior consistent with system oom - no
> > oom kill if no process.
> >
> > What about bellow change ?
> >
>
> Seems fine to me. If others are ok with this, please do send a signed-off patch.
>

Sure, I will.

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
> >
> > > Deleting a memcg does not reclaim memory from it and the memory can
> > > linger till there is a memory pressure. One normal way to proactively
> > > reclaim such memory is to set memory.max to 0 just before deleting the
> > > memcg. However if some of the memcg's memory is pinned by others, this
> > > operation can trigger an oom-kill without any process and thus can log a
> > > lot un-needed warnings. So, ignore all such warnings from memory.max.
> > >
> > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > > ---
> > >  include/linux/oom.h | 3 +++
> > >  mm/memcontrol.c     | 9 +++++----
> > >  mm/oom_kill.c       | 2 +-
> > >  3 files changed, 9 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/oom.h b/include/linux/oom.h
> > > index c696c265f019..6345dc55df64 100644
> > > --- a/include/linux/oom.h
> > > +++ b/include/linux/oom.h
> > > @@ -52,6 +52,9 @@ struct oom_control {
> > >
> > >         /* Used to print the constraint info. */
> > >         enum oom_constraint constraint;
> > > +
> > > +       /* Do not warn even if there is no process to be killed. */
> > > +       bool no_warn;
> > >  };
> > >
> > >  extern struct mutex oom_lock;
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 317dbbaac603..a1f00d9b9bb0 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -1571,7 +1571,7 @@ unsigned long mem_cgroup_size(struct mem_cgroup *memcg)
> > >  }
> > >
> > >  static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > > -                                    int order)
> > > +                                    int order, bool no_warn)
> > >  {
> > >         struct oom_control oc = {
> > >                 .zonelist = NULL,
> > > @@ -1579,6 +1579,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > >                 .memcg = memcg,
> > >                 .gfp_mask = gfp_mask,
> > >                 .order = order,
> > > +               .no_warn = no_warn,
> > >         };
> > >         bool ret;
> > >
> > > @@ -1821,7 +1822,7 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
> > >                 mem_cgroup_oom_notify(memcg);
> > >
> > >         mem_cgroup_unmark_under_oom(memcg);
> > > -       if (mem_cgroup_out_of_memory(memcg, mask, order))
> > > +       if (mem_cgroup_out_of_memory(memcg, mask, order, false))
> > >                 ret = OOM_SUCCESS;
> > >         else
> > >                 ret = OOM_FAILED;
> > > @@ -1880,7 +1881,7 @@ bool mem_cgroup_oom_synchronize(bool handle)
> > >                 mem_cgroup_unmark_under_oom(memcg);
> > >                 finish_wait(&memcg_oom_waitq, &owait.wait);
> > >                 mem_cgroup_out_of_memory(memcg, current->memcg_oom_gfp_mask,
> > > -                                        current->memcg_oom_order);
> > > +                                        current->memcg_oom_order, false);
> > >         } else {
> > >                 schedule();
> > >                 mem_cgroup_unmark_under_oom(memcg);
> > > @@ -6106,7 +6107,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
> > >                 }
> > >
> > >                 memcg_memory_event(memcg, MEMCG_OOM);
> > > -               if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0))
> > > +               if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0, true))
> > >                         break;
> > >         }
> > >
> > > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > > index 463b3d74a64a..5ace39f6fe1e 100644
> > > --- a/mm/oom_kill.c
> > > +++ b/mm/oom_kill.c
> > > @@ -1098,7 +1098,7 @@ bool out_of_memory(struct oom_control *oc)
> > >
> > >         select_bad_process(oc);
> > >         /* Found nothing?!?! */
> > > -       if (!oc->chosen) {
> > > +       if (!oc->chosen && !oc->no_warn) {
> > >                 dump_header(oc, NULL);
> > >                 pr_warn("Out of memory and no killable processes...\n");
> > >                 /*
> > > --
> > > 2.26.2.526.g744177e7f7-goog
> > >
> > >
> >
> >
> > --
> > Thanks
> > Yafang



-- 
Thanks
Yafang
