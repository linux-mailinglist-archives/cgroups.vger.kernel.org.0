Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BD41C066F
	for <lists+cgroups@lfdr.de>; Thu, 30 Apr 2020 21:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgD3Tbs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Apr 2020 15:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgD3Tbr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Apr 2020 15:31:47 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D9EC035495
        for <cgroups@vger.kernel.org>; Thu, 30 Apr 2020 12:31:47 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w14so2238154lfk.3
        for <cgroups@vger.kernel.org>; Thu, 30 Apr 2020 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cpNuhLG27M2LY+OOiLxKTk8CvH0axJBvq+gwTXFPBUw=;
        b=H7PU8veVNF+gc5hrBF2gDUfDMOVuiQ465ISM3u5O9VOlsXrR95GB0x08wFhDWOEG8d
         LMhX3dmPirJkEZf6LCI8kLisP5w0SesJa7YUTb2Jy4oizvDR/2f+kwoa1UGQ+tgllXv5
         rpRXjfhU5HUxOBwREgWybDRSXv3MDbdYnILoNZ7InA5Gwy7NMCiw0yUQvTcCzpwhdVgq
         S6GXQKKzziEhSL3ltV/MksxJBz2Dvyak7tZTx+s3Tolw5HqsgAoseH2NVGDTibNmEZ5w
         +UquDn6daGjrVzFocqQSgiQ8+dDTf4FKgYOOWmd5oszy6er0CJ3vQaow6En/aaXYbEcJ
         pusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cpNuhLG27M2LY+OOiLxKTk8CvH0axJBvq+gwTXFPBUw=;
        b=tpjOqQyaMJ++XBvMjYcPv+O8fEFReJZ/Wogd7rWm+o0EQmYWmE8RGwO2v05AhtWoES
         qFegIXugBG+jjJNhERw0nNeZI0AszgceBW0LLlNf/IsI6E19/9Lqbn8g9izS/U89O/jw
         J3ZCN/3OEazBO2yH8bQd0BHC/4IEQHd8wWW06LXznSDl2a7UVbHlVHTwyJca3awr4sCK
         q9wPBlkvj/YZuwV30K3zgMmTKiN2wUFanMv4Ip4kyUpLM36rperpUgtkEjbFJ7obHag6
         zXqghAIGRz7r6u4D1zq9w1NLv3/KqQUhmhcL+4eCUa9QsPNnLZKxMt9+5tmxhizfLzro
         XuuA==
X-Gm-Message-State: AGi0Pua7z4GSm7tCh/AqZCssEuRd5g0SHShnYiEuVR0YRMUfbGETEkuQ
        u9w18igG3SyN7u40i5Dypn5ucXWwBgDiiTxvsJ/f4w==
X-Google-Smtp-Source: APiQypJ/2ALFHyQQbXJQTtf9kYNFCkkm+177kv0LkXgl8aL1VWKHvEh5rbHJmHJlkQIJTUSmxKnzQi37hH2FPRkWI3w=
X-Received: by 2002:ac2:5e65:: with SMTP id a5mr110232lfr.189.1588275105505;
 Thu, 30 Apr 2020 12:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200430182712.237526-1-shakeelb@google.com> <20200430190610.GD339283@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200430190610.GD339283@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 30 Apr 2020 12:31:32 -0700
Message-ID: <CALvZod7yvqx8X8XFu7YtE5a1DmtSU-6FcQULiCeCi_fd9Axs4w@mail.gmail.com>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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

On Thu, Apr 30, 2020 at 12:06 PM Roman Gushchin <guro@fb.com> wrote:
>
> Hello, Shakeel!
>
> On Thu, Apr 30, 2020 at 11:27:12AM -0700, Shakeel Butt wrote:
> > Lowering memory.max can trigger an oom-kill if the reclaim does not
> > succeed. However if oom-killer does not find a process for killing, it
> > dumps a lot of warnings.
>
> Makes total sense to me.
>
> >
> > Deleting a memcg does not reclaim memory from it and the memory can
> > linger till there is a memory pressure. One normal way to proactively
> > reclaim such memory is to set memory.max to 0 just before deleting the
> > memcg. However if some of the memcg's memory is pinned by others, this
> > operation can trigger an oom-kill without any process and thus can log a
> > lot un-needed warnings. So, ignore all such warnings from memory.max.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > ---
> >  include/linux/oom.h | 3 +++
> >  mm/memcontrol.c     | 9 +++++----
> >  mm/oom_kill.c       | 2 +-
> >  3 files changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/oom.h b/include/linux/oom.h
> > index c696c265f019..6345dc55df64 100644
> > --- a/include/linux/oom.h
> > +++ b/include/linux/oom.h
> > @@ -52,6 +52,9 @@ struct oom_control {
> >
> >       /* Used to print the constraint info. */
> >       enum oom_constraint constraint;
> > +
> > +     /* Do not warn even if there is no process to be killed. */
> > +     bool no_warn;
>
> I'd invert it to warn. Or maybe even warn_on_no_proc?
>

Sure.

> >  };
> >
> >  extern struct mutex oom_lock;
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 317dbbaac603..a1f00d9b9bb0 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1571,7 +1571,7 @@ unsigned long mem_cgroup_size(struct mem_cgroup *memcg)
> >  }
> >
> >  static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > -                                  int order)
> > +                                  int order, bool no_warn)
> >  {
> >       struct oom_control oc = {
> >               .zonelist = NULL,
> > @@ -1579,6 +1579,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >               .memcg = memcg,
> >               .gfp_mask = gfp_mask,
> >               .order = order,
> > +             .no_warn = no_warn,
> >       };
> >       bool ret;
> >
> > @@ -1821,7 +1822,7 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
> >               mem_cgroup_oom_notify(memcg);
> >
> >       mem_cgroup_unmark_under_oom(memcg);
> > -     if (mem_cgroup_out_of_memory(memcg, mask, order))
> > +     if (mem_cgroup_out_of_memory(memcg, mask, order, false))
> >               ret = OOM_SUCCESS;
> >       else
> >               ret = OOM_FAILED;
> > @@ -1880,7 +1881,7 @@ bool mem_cgroup_oom_synchronize(bool handle)
> >               mem_cgroup_unmark_under_oom(memcg);
> >               finish_wait(&memcg_oom_waitq, &owait.wait);
> >               mem_cgroup_out_of_memory(memcg, current->memcg_oom_gfp_mask,
> > -                                      current->memcg_oom_order);
> > +                                      current->memcg_oom_order, false);
> >       } else {
> >               schedule();
> >               mem_cgroup_unmark_under_oom(memcg);
> > @@ -6106,7 +6107,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
> >               }
> >
> >               memcg_memory_event(memcg, MEMCG_OOM);
> > -             if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0))
> > +             if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0, true))
>
> I wonder if we can handle it automatically from the oom_killer side?
> We can suppress warnings if oc->memcg is set and the cgroup scanning
> showed that there are no belonging processes?
>

What about the charging path? Do we not want such warnings from
charging paths? It might be due to some misconfiguration.
