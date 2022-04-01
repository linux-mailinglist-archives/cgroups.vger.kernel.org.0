Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A244EEA4E
	for <lists+cgroups@lfdr.de>; Fri,  1 Apr 2022 11:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344488AbiDAJY3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Apr 2022 05:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237354AbiDAJY3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Apr 2022 05:24:29 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2B0269A45
        for <cgroups@vger.kernel.org>; Fri,  1 Apr 2022 02:22:38 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c11so1954799pgu.11
        for <cgroups@vger.kernel.org>; Fri, 01 Apr 2022 02:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EyRExLAQW3m/1gMlz2hctnqaSl+H0AAJm330r3O/ZwY=;
        b=JEtAlBR0JyfJM25DDuiGeSo9iIQUhiRgfxKW6UMpgaCmRtDZmRf7mrFS2Jljti8Lot
         b3lw9HymXOrt7JC8DZRPFC0nCkdmRNMQosI3Wqb+kFk0fwjxT5Pc77yEHtjchA2bK/wH
         14rXfmGFBZ8b5lvOB9Hq+gJJo2RZUJLt7iWD+aMxkZhjD6xSa/1JQgtXgMVTotg7DpiX
         LEzB9jdJRxLen+/a8Df00++pQe8TmjoS9qG8zBXYU+J1KRhvQTVhpqbv2Op+/Y9StY2K
         2SPRieOpDwK+yK5c66n49IL1TB4UUIgbeUZHBHNlhDAbGxLKOQaWrbKLaNmk5KNzSmrT
         EpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EyRExLAQW3m/1gMlz2hctnqaSl+H0AAJm330r3O/ZwY=;
        b=dUsGWwg7lgScceekxx4jJSE9LKZk7mU0w4tJWvvY5ltK9Xhbe0yuUTJpOUf9pG/9gP
         x1BpfCMrB7K0wCUL8mSYw9q2GayrMF9JrDB38T7nm018WnXlERwh1+lIf91L/B2lcvBW
         8cDOU+QwMTjvbyrJHURgtoZJpkq11ky+8kGZScmBa0cYQXKx+OGOA5Re3H29RkAPlND9
         pWwEDL0bWXFUjKpLuLcM5wHnq9o8VYf8txlfrXtJ+JSxh6+vlVEQ1vZSKykcv1583kdG
         E0B1vyUjGun6t7aNrkaG3UOqRl/4lB15tv+C17D7N774D84SQS+juJvmEKLanaG4sWDf
         bI4A==
X-Gm-Message-State: AOAM533lJ69gK1LRE+nGpidy1SOnZryQ5lOWST1v75iAIdlcYixT1HD/
        kfiYjN+g+F21ZpAFDp7vWttX4oX7alRpoJ3PHnOxpA==
X-Google-Smtp-Source: ABdhPJzPGK4Wj1VbuaKgyrD4+BY+Qz1wmT91honIjqxq6dAiJYfDQEjCcolwiIjZtcqpipZcLmNYSGbhlVu79xmax40=
X-Received: by 2002:a05:6a00:a0f:b0:4e1:309:83c0 with SMTP id
 p15-20020a056a000a0f00b004e1030983c0mr9865708pfh.68.1648804957383; Fri, 01
 Apr 2022 02:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com> <CAAPL-u8g2qkhdTQtFtBS3GNYz0WnyahWEXvR4g_OSaKv+7EozA@mail.gmail.com>
In-Reply-To: <CAAPL-u8g2qkhdTQtFtBS3GNYz0WnyahWEXvR4g_OSaKv+7EozA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 1 Apr 2022 02:22:01 -0700
Message-ID: <CAJD7tkYDLKNpx6uAsB4vFR1O3_UpftXFH9U-f31cSZJ7OuPXmQ@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Wei Xu <weixugc@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 31, 2022 at 9:05 PM Wei Xu <weixugc@google.com> wrote:
>
> On Thu, Mar 31, 2022 at 1:42 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > From: Shakeel Butt <shakeelb@google.com>
> >
> > Introduce an memcg interface to trigger memory reclaim on a memory cgroup.
> >
> > Use case: Proactive Reclaim
> > ---------------------------
> >
> > A userspace proactive reclaimer can continuously probe the memcg to
> > reclaim a small amount of memory. This gives more accurate and
> > up-to-date workingset estimation as the LRUs are continuously
> > sorted and can potentially provide more deterministic memory
> > overcommit behavior. The memory overcommit controller can provide
> > more proactive response to the changing behavior of the running
> > applications instead of being reactive.
> >
> > A userspace reclaimer's purpose in this case is not a complete replacement
> > for kswapd or direct reclaim, it is to proactively identify memory savings
> > opportunities and reclaim some amount of cold pages set by the policy
> > to free up the memory for more demanding jobs or scheduling new jobs.
> >
> > A user space proactive reclaimer is used in Google data centers.
> > Additionally, Meta's TMO paper recently referenced a very similar
> > interface used for user space proactive reclaim:
> > https://dl.acm.org/doi/pdf/10.1145/3503222.3507731
> >
> > Benefits of a user space reclaimer:
> > -----------------------------------
> >
> > 1) More flexible on who should be charged for the cpu of the memory
> > reclaim. For proactive reclaim, it makes more sense to be centralized.
> >
> > 2) More flexible on dedicating the resources (like cpu). The memory
> > overcommit controller can balance the cost between the cpu usage and
> > the memory reclaimed.
> >
> > 3) Provides a way to the applications to keep their LRUs sorted, so,
> > under memory pressure better reclaim candidates are selected. This also
> > gives more accurate and uptodate notion of working set for an
> > application.
> >
> > Why memory.high is not enough?
> > ------------------------------
> >
> > - memory.high can be used to trigger reclaim in a memcg and can
> >   potentially be used for proactive reclaim.
> >   However there is a big downside in using memory.high. It can potentially
> >   introduce high reclaim stalls in the target application as the
> >   allocations from the processes or the threads of the application can hit
> >   the temporary memory.high limit.
> >
> > - Userspace proactive reclaimers usually use feedback loops to decide
> >   how much memory to proactively reclaim from a workload. The metrics
> >   used for this are usually either refaults or PSI, and these metrics
> >   will become messy if the application gets throttled by hitting the
> >   high limit.
> >
> > - memory.high is a stateful interface, if the userspace proactive
> >   reclaimer crashes for any reason while triggering reclaim it can leave
> >   the application in a bad state.
> >
> > - If a workload is rapidly expanding, setting memory.high to proactively
> >   reclaim memory can result in actually reclaiming more memory than
> >   intended.
> >
> > The benefits of such interface and shortcomings of existing interface
> > were further discussed in this RFC thread:
> > https://lore.kernel.org/linux-mm/5df21376-7dd1-bf81-8414-32a73cea45dd@google.com/
> >
> > Interface:
> > ----------
> >
> > Introducing a very simple memcg interface 'echo 10M > memory.reclaim' to
> > trigger reclaim in the target memory cgroup.
> >
> >
> > Possible Extensions:
> > --------------------
> >
> > - This interface can be extended with an additional parameter or flags
> >   to allow specifying one or more types of memory to reclaim from (e.g.
> >   file, anon, ..).
> >
> > - The interface can also be extended with a node mask to reclaim from
> >   specific nodes. This has use cases for reclaim-based demotion in memory
> >   tiering systens.
> >
> > - A similar per-node interface can also be added to support proactive
> >   reclaim and reclaim-based demotion in systems without memcg.
> >
> > For now, let's keep things simple by adding the basic functionality.
> >
> > [yosryahmed@google.com: refreshed to current master, updated commit
> > message based on recent discussions and use cases]
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  9 ++++++
> >  mm/memcontrol.c                         | 37 +++++++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index 69d7a6983f78..925aaabb2247 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1208,6 +1208,15 @@ PAGE_SIZE multiple when read back.
> >         high limit is used and monitored properly, this limit's
> >         utility is limited to providing the final safety net.
> >
> > +  memory.reclaim
> > +       A write-only file which exists on non-root cgroups.
> > +
> > +       This is a simple interface to trigger memory reclaim in the
> > +       target cgroup. Write the number of bytes to reclaim to this
> > +       file and the kernel will try to reclaim that much memory.
> > +       Please note that the kernel can over or under reclaim from
> > +       the target cgroup.
> > +
> >    memory.oom.group
> >         A read-write single value file which exists on non-root
> >         cgroups.  The default value is "0".
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 725f76723220..994849fab7df 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6355,6 +6355,38 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
> >         return nbytes;
> >  }
> >
> > +static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> > +                             size_t nbytes, loff_t off)
> > +{
> > +       struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> > +       unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> > +       unsigned long nr_to_reclaim, nr_reclaimed = 0;
> > +       int err;
> > +
> > +       buf = strstrip(buf);
> > +       err = page_counter_memparse(buf, "", &nr_to_reclaim);
> > +       if (err)
> > +               return err;
> > +
> > +       while (nr_reclaimed < nr_to_reclaim) {
> > +               unsigned long reclaimed;
> > +
> > +               if (signal_pending(current))
> > +                       break;
> > +
> > +               reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > +                                               nr_to_reclaim - nr_reclaimed,
> > +                                               GFP_KERNEL, true);
> > +
> > +               if (!reclaimed && !nr_retries--)
> > +                       break;
> > +
> > +               nr_reclaimed += reclaimed;
> > +       }
> > +
> > +       return nbytes;
>
> It is better to return an error code (e.g. -EBUSY) when
> memory_reclaim() fails to reclaim nr_to_reclaim bytes of memory,
> except if the cgroup memory usage is already 0.  We can also return
> -EINVAL if nr_to_reclaim is too large (e.g. > limit).

IIUC this interface is modeled after memory.high, which returns nbytes
as well. If you think it's better here to do this instead of
maintaining consistency with memory.high we can certainly do this for
v2.

>
> > +}
> > +
> >  static struct cftype memory_files[] = {
> >         {
> >                 .name = "current",
> > @@ -6413,6 +6445,11 @@ static struct cftype memory_files[] = {
> >                 .seq_show = memory_oom_group_show,
> >                 .write = memory_oom_group_write,
> >         },
> > +       {
> > +               .name = "reclaim",
> > +               .flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
> > +               .write = memory_reclaim,
> > +       },
> >         { }     /* terminate */
> >  };
> >
> > --
> > 2.35.1.1021.g381101b075-goog
> >
