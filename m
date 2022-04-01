Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A797D4EEA28
	for <lists+cgroups@lfdr.de>; Fri,  1 Apr 2022 11:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344384AbiDAJOT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Apr 2022 05:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344382AbiDAJOS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Apr 2022 05:14:18 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD809265EAF
        for <cgroups@vger.kernel.org>; Fri,  1 Apr 2022 02:12:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d30so1934607pjk.0
        for <cgroups@vger.kernel.org>; Fri, 01 Apr 2022 02:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTgjpbxi+atnp9axNVFkq7OGFubJ8g3qn22nFzknXc0=;
        b=BJ7yd3RqMpeyZP/nXaJIqtS0xR9zz6WFUei6+PbJx29crBeMBoajAHTDBFqT/NP/E9
         oDskgt1nDRh5HaFRpNsKLfCBPspbWgH8cCGdFcCBdjHXQsgZe7KYIL2BHqwf89YC2KqE
         FU1D88az6OaXiSSpAJa0xhtQvr3n9BKcuFwA/YBZ/Jyf7/x9liXJJ0BGx8kvbP4eC8sV
         bnF/eQBu+fZeYpJPE1wiLaT1wHA93zccpcqbztUDXVgRcYURXvHnX+RbafbV1iWb4j5D
         gn0lTg7NhGi/NMUl3PMdZ11PMU3EVUfR9yFC1YuR3rOGIjL/88llWWZvDc4Oi9MsFlpW
         BsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTgjpbxi+atnp9axNVFkq7OGFubJ8g3qn22nFzknXc0=;
        b=ULlQHtMIf+cJXwSJxEakaB1W0nwAFzBzf8G77dX+AzJF2XQQDZBdmCk2z4EaOi3v7M
         tNds6b94GEUeu8H6AoIDMNXqL77/axaP6xbzbjWD8g80Bo0SdAIA01VaZoCpcumfLxxB
         4GLISe0SO6M0Z1gPWuxb9IsXU/A7qlKAHHZ3IUNo/Xe+xNEfKoxqXqtBZ9Tx9uvcl3Nj
         D4UVYWWgQry6NJzVnM0Gf7up6YX4Kr+2Pt5y840yc6Mx283zq8xECZ/9+v1HyJ8woF2s
         4X7o5C1WBw2zPhaLogWCOQGFwbz0HC31Uxf/Byh/X1VkYzIMrTmYVCluWmo+JCOnoqSQ
         tb/A==
X-Gm-Message-State: AOAM5335Ke3v2gx4VVOYft5viN/mHJeyXizIYd+HagTx4Hd+wHMjWpJ4
        mlIsVVqHrzZzeWay2MnAKET38hEJkM0Lo0a4DiXK4A==
X-Google-Smtp-Source: ABdhPJzopBl16/r1LJ0fm04p7JCvGevCb43y19JegZ3PEwne5+cHWxKVLGwBpnfGLKYJXujMrPBfvrr2QbDLUvnpMww=
X-Received: by 2002:a17:902:f24b:b0:154:de5:a24c with SMTP id
 j11-20020a170902f24b00b001540de5a24cmr9507262plc.162.1648804348061; Fri, 01
 Apr 2022 02:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com> <YkXkA+Oh1Bx33PrU@carbon.dhcp.thefacebook.com>
In-Reply-To: <YkXkA+Oh1Bx33PrU@carbon.dhcp.thefacebook.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 1 Apr 2022 02:11:51 -0700
Message-ID: <CAJD7tkYVpnf1+sa9vRAQCw5H0LUH6zE6_yhNAFwKF3sW0BLzEA@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 31, 2022 at 10:25 AM Roman Gushchin
<roman.gushchin@linux.dev> wrote:
>
> On Thu, Mar 31, 2022 at 08:41:51AM +0000, Yosry Ahmed wrote:
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
>
> Hello!
>
> I'm totally up for the proposed feature! It makes total sense and is proved
> to be useful, let's add it.
>
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
>
> Maybe an option to specify a timeout? That might simplify the userspace part.
> Also, please please add a test to selftests/cgroup/memcg tests.
> It will also provide an example on how the userspace can use the feature.
>

Hi Roman, thanks for taking the time to review this!

A timeout can be a good extension, I will add it to the commit message
in the next version in possible extensions.

I will add a test in v2, thanks!

>
> >
> > For now, let's keep things simple by adding the basic functionality.
>
> What I'm worried about is how we gonna extend it? How do you see the interface
> with 2-3 extensions from the list above? All these extensions look very
> reasonable to me, so we'll likely have to implement them soon. So let's think
> about the extensibility now.
>

My idea is to have these extensions as optional positional arguments
(like Wei suggested), so that the interface does not get too
complicated for users who don't care about tuning these options. If
this is the case then I think there is nothing to worry about.
Otherwise, if you think some of these options make sense to be a
required argument instead, we can rethink the initial interface.

> I wonder if it makes more sense to introduce a sys_reclaim() syscall instead?
> In the end, such a feature might make sense on the system level too.
> Yes, there is the drop_caches sysctl, but it's too radical for many cases.
>

I think in the RFC discussion there was consensus to add both a
per-memcg knob, as well as per-node / per-system knobs (through sysfs
or syscalls) later. Wei also points out that it's not common for a
syscall to have a cgroup argument.

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
> >       high limit is used and monitored properly, this limit's
> >       utility is limited to providing the final safety net.
> >
> > +  memory.reclaim
> > +     A write-only file which exists on non-root cgroups.
> > +
> > +     This is a simple interface to trigger memory reclaim in the
> > +     target cgroup. Write the number of bytes to reclaim to this
> > +     file and the kernel will try to reclaim that much memory.
> > +     Please note that the kernel can over or under reclaim from
> > +     the target cgroup.
> > +
> >    memory.oom.group
> >       A read-write single value file which exists on non-root
> >       cgroups.  The default value is "0".
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 725f76723220..994849fab7df 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6355,6 +6355,38 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
> >       return nbytes;
> >  }
> >
> > +static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> > +                           size_t nbytes, loff_t off)
> > +{
> > +     struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> > +     unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> > +     unsigned long nr_to_reclaim, nr_reclaimed = 0;
> > +     int err;
> > +
> > +     buf = strstrip(buf);
> > +     err = page_counter_memparse(buf, "", &nr_to_reclaim);
> > +     if (err)
> > +             return err;
> > +
> > +     while (nr_reclaimed < nr_to_reclaim) {
> > +             unsigned long reclaimed;
> > +
> > +             if (signal_pending(current))
> > +                     break;
> > +
> > +             reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > +                                             nr_to_reclaim - nr_reclaimed,
> > +                                             GFP_KERNEL, true);
> > +
> > +             if (!reclaimed && !nr_retries--)
> > +                     break;
> > +
> > +             nr_reclaimed += reclaimed;
> > +     }
> > +
> > +     return nbytes;
> > +}
> > +
> >  static struct cftype memory_files[] = {
> >       {
> >               .name = "current",
> > @@ -6413,6 +6445,11 @@ static struct cftype memory_files[] = {
> >               .seq_show = memory_oom_group_show,
> >               .write = memory_oom_group_write,
> >       },
> > +     {
> > +             .name = "reclaim",
> > +             .flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
> > +             .write = memory_reclaim,
>
> Btw, why not on root?
