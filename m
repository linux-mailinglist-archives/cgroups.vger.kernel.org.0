Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F5F1C0BBA
	for <lists+cgroups@lfdr.de>; Fri,  1 May 2020 03:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgEABj7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Apr 2020 21:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726384AbgEABj6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Apr 2020 21:39:58 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC758C035494;
        Thu, 30 Apr 2020 18:39:58 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id e9so3620010iok.9;
        Thu, 30 Apr 2020 18:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9kEjlo9klnfQZPRmxb764xpSlEiJoEeAxtPwpEWsyW8=;
        b=aeTR70bQPdhn7Tq42eH9wJCqPBsI8z+1fnVg9Sp1WiL/y90sV5ktBNmBHZI4N8MO4B
         xrgA5Gnrqf57Shq4bgUrhgVjbUUcLmd3kckR0w89uFJtMZ2OKBZr9zM1EXSqaQK6mhOy
         A5Fe63ZfurRQ8pVW1kE9UwEZEvF+c4iLHutlCqcshY+L2RPb3sR9Ei0HGePE1c/SkbZV
         WO/oF8lUVItDI18HzZvm/RWyLyufmnxXW941m0b9CDslbASKKECozA4yZJZFQbMCgE7S
         5aEkNxO+2XseuXmRdXYIgasPV26hZcZNY6Gn6jf0Eiu5hbGNf9ar+yhp67lgVqm7kzmq
         tR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kEjlo9klnfQZPRmxb764xpSlEiJoEeAxtPwpEWsyW8=;
        b=VjBLLkUyaynx6vH3ngaCVpGLUNezF04chBT9FbDPfDSsPMT7ik7uHXxC4hnkFTxueJ
         PioFVuC8Iw5jc9L3zIOC6ieI6SfUdMwA65kb+rsxxKFPxi9G5We7pvGWgVmvamNdltdJ
         5ZaA6zj6W89Fln0ekoKOl7b2KBMRuT5bfiGbE4upFWwo/eLvUGbHPMicDEnIn1WCBRum
         F0Y0ay2Mqmn0zFtWPVdeCd2XPit4k2gOgMR9MH60Czxpl6lr6JPIvlRm9tbPY1MGwGwD
         vrilehszXVgW8MdKhNbOsP+Sf/CE1EGu8ogKYK8Cz6bEHOqco1uFJoUqa6A4SjCXvEla
         IFbA==
X-Gm-Message-State: AGi0PuZfmrOd/EiKL1f5xOE5Niq2I14ljjruDJmardcLUAMDFvbPOHU2
        autF0o8MHnYyHxV44cBBB4qF2xN3JG0ec+n5L2o=
X-Google-Smtp-Source: APiQypLamne0OBmpP4DO5r8KXtbkzJtEpn4HPlEEm5ULy1L+FjtwRO4uwqFP29YjTbX2rUq4btja/JKPuyFbykgrUMw=
X-Received: by 2002:a6b:3c0a:: with SMTP id k10mr1789356iob.10.1588297197906;
 Thu, 30 Apr 2020 18:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200430182712.237526-1-shakeelb@google.com>
In-Reply-To: <20200430182712.237526-1-shakeelb@google.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 1 May 2020 09:39:24 +0800
Message-ID: <CALOAHbC4WY00yQ46b8CFqVQ3S=JSJxE2HR00TtMqXOWLRPRZ8w@mail.gmail.com>
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

On Fri, May 1, 2020 at 2:27 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> Lowering memory.max can trigger an oom-kill if the reclaim does not
> succeed. However if oom-killer does not find a process for killing, it
> dumps a lot of warnings.
>

I have been confused by this behavior for several months and I think
it will confuse more memcg users.
We should keep the memcg oom behavior consistent with system oom - no
oom kill if no process.

What about bellow change ?

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e28098e13f1c..25fbc37a747f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6086,6 +6086,9 @@ static ssize_t memory_max_write(struct
kernfs_open_file *of,
                        continue;
                }

+               if (!cgroup_is_populated(memcg->css.cgroup))
+                       break;
+
                memcg_memory_event(memcg, MEMCG_OOM);
                if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0))
                        break;

> Deleting a memcg does not reclaim memory from it and the memory can
> linger till there is a memory pressure. One normal way to proactively
> reclaim such memory is to set memory.max to 0 just before deleting the
> memcg. However if some of the memcg's memory is pinned by others, this
> operation can trigger an oom-kill without any process and thus can log a
> lot un-needed warnings. So, ignore all such warnings from memory.max.
>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  include/linux/oom.h | 3 +++
>  mm/memcontrol.c     | 9 +++++----
>  mm/oom_kill.c       | 2 +-
>  3 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index c696c265f019..6345dc55df64 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -52,6 +52,9 @@ struct oom_control {
>
>         /* Used to print the constraint info. */
>         enum oom_constraint constraint;
> +
> +       /* Do not warn even if there is no process to be killed. */
> +       bool no_warn;
>  };
>
>  extern struct mutex oom_lock;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 317dbbaac603..a1f00d9b9bb0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1571,7 +1571,7 @@ unsigned long mem_cgroup_size(struct mem_cgroup *memcg)
>  }
>
>  static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> -                                    int order)
> +                                    int order, bool no_warn)
>  {
>         struct oom_control oc = {
>                 .zonelist = NULL,
> @@ -1579,6 +1579,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>                 .memcg = memcg,
>                 .gfp_mask = gfp_mask,
>                 .order = order,
> +               .no_warn = no_warn,
>         };
>         bool ret;
>
> @@ -1821,7 +1822,7 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
>                 mem_cgroup_oom_notify(memcg);
>
>         mem_cgroup_unmark_under_oom(memcg);
> -       if (mem_cgroup_out_of_memory(memcg, mask, order))
> +       if (mem_cgroup_out_of_memory(memcg, mask, order, false))
>                 ret = OOM_SUCCESS;
>         else
>                 ret = OOM_FAILED;
> @@ -1880,7 +1881,7 @@ bool mem_cgroup_oom_synchronize(bool handle)
>                 mem_cgroup_unmark_under_oom(memcg);
>                 finish_wait(&memcg_oom_waitq, &owait.wait);
>                 mem_cgroup_out_of_memory(memcg, current->memcg_oom_gfp_mask,
> -                                        current->memcg_oom_order);
> +                                        current->memcg_oom_order, false);
>         } else {
>                 schedule();
>                 mem_cgroup_unmark_under_oom(memcg);
> @@ -6106,7 +6107,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>                 }
>
>                 memcg_memory_event(memcg, MEMCG_OOM);
> -               if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0))
> +               if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0, true))
>                         break;
>         }
>
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 463b3d74a64a..5ace39f6fe1e 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1098,7 +1098,7 @@ bool out_of_memory(struct oom_control *oc)
>
>         select_bad_process(oc);
>         /* Found nothing?!?! */
> -       if (!oc->chosen) {
> +       if (!oc->chosen && !oc->no_warn) {
>                 dump_header(oc, NULL);
>                 pr_warn("Out of memory and no killable processes...\n");
>                 /*
> --
> 2.26.2.526.g744177e7f7-goog
>
>


-- 
Thanks
Yafang
