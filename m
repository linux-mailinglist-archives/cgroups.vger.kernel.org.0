Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FA54EFAF7
	for <lists+cgroups@lfdr.de>; Fri,  1 Apr 2022 22:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351843AbiDAUQj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Apr 2022 16:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351811AbiDAUQi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Apr 2022 16:16:38 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E20625665A
        for <cgroups@vger.kernel.org>; Fri,  1 Apr 2022 13:14:48 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id q11so4482073iod.6
        for <cgroups@vger.kernel.org>; Fri, 01 Apr 2022 13:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2PNyAd+p3CV4NbixBgg+nxPXydMeiKfM73e0dmTb/Q4=;
        b=gYLthgNwbAx3gWG/zbiWdQVV2/XJ/ql9pVrdl4e3iNqbAunwWyab7ShFUh9zJWiv7y
         JpkbM5YpThvi/XXa8CwLL8ZJwOTlxVLzAPHmSpkY9j2iEPbHvQvAeHxfc08FKQ0Xgioo
         faUl9YI2UzzAwMzsrwTJ5/wHCcYSRQLA2hYTPw+ialtwBCFas2egESpL/rJIs1FWd5XO
         WIFORmjoTKEUqdrJLJlzeYaralkPBES/6dYYcwOMZJCghgFLogLvg5b8PHi52mLKWVWf
         gGXgpCKY9c1SUxd51x7NK95FJzPzc595BLAcg2wNGYwRqV1dNTqqGtFT3S46AFR5Esmr
         2mIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2PNyAd+p3CV4NbixBgg+nxPXydMeiKfM73e0dmTb/Q4=;
        b=2NBK4Ph8Pe9HLCl7pqV+3BS21IJdYykGFpUhjpyANXQw7sFa6yfpiessZ2Y4cntlYH
         B10PzPfIxF6nKAjq5xQ8FtAq/vL4cqFuk91z0teqkQBN6ToBXdtNcsSkGxzIsRud8Bhj
         4Wueoc9AJsEbcjlwEUSZw7Q0V3QrpIMI1FT6NqAhE+vkXdSbOCUKGIK2Re8vL0Tk1KN6
         QkH0THH6J7g/MiAnrbAa5nw4FF/MoxVFVwHNPQvthvxh+6W1Ys/62SY54LgksB9WKx8p
         SMQMhMUcTRn02ZqhzkhO68DgwZPEPDHfZmq7Yy9WLQ7hmsQl/sKypSN2MoqG8T5jBdlL
         rjwg==
X-Gm-Message-State: AOAM533j9YWEsL3zd96f0yfUbok/KmwWMabzGBR0TH0dBx66IdzJeI92
        O6Wcy1PTo+Ukp54Joo1EevNH4+5sN2brXP7ll9PdfAfWaXK8bg==
X-Google-Smtp-Source: ABdhPJx6m2+ZPtniA6bdR166gHGH8pyPxjiVe1MAQFSrGxKfRwFuoHES6yAjW0YSc2JM+b/OJoYkLcP24S0If8lQdxg=
X-Received: by 2002:a6b:e40a:0:b0:64c:8ce1:3757 with SMTP id
 u10-20020a6be40a000000b0064c8ce13757mr627949iog.106.1648844086958; Fri, 01
 Apr 2022 13:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <CAAPL-u8g2qkhdTQtFtBS3GNYz0WnyahWEXvR4g_OSaKv+7EozA@mail.gmail.com> <YkcYq8F6MYlMi+yS@cmpxchg.org>
In-Reply-To: <YkcYq8F6MYlMi+yS@cmpxchg.org>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 1 Apr 2022 13:14:35 -0700
Message-ID: <CAAPL-u-za-TTyyC5uMVev9eQyhxZS7q3pVqaUxCFjqk+Sv9+ig@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 1, 2022 at 8:22 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Mar 31, 2022 at 09:05:15PM -0700, Wei Xu wrote:
> > On Thu, Mar 31, 2022 at 1:42 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > From: Shakeel Butt <shakeelb@google.com>
> > >
> > > Introduce an memcg interface to trigger memory reclaim on a memory cgroup.
> > >
> > > Use case: Proactive Reclaim
> > > ---------------------------
> > >
> > > A userspace proactive reclaimer can continuously probe the memcg to
> > > reclaim a small amount of memory. This gives more accurate and
> > > up-to-date workingset estimation as the LRUs are continuously
> > > sorted and can potentially provide more deterministic memory
> > > overcommit behavior. The memory overcommit controller can provide
> > > more proactive response to the changing behavior of the running
> > > applications instead of being reactive.
> > >
> > > A userspace reclaimer's purpose in this case is not a complete replacement
> > > for kswapd or direct reclaim, it is to proactively identify memory savings
> > > opportunities and reclaim some amount of cold pages set by the policy
> > > to free up the memory for more demanding jobs or scheduling new jobs.
> > >
> > > A user space proactive reclaimer is used in Google data centers.
> > > Additionally, Meta's TMO paper recently referenced a very similar
> > > interface used for user space proactive reclaim:
> > > https://dl.acm.org/doi/pdf/10.1145/3503222.3507731
> > >
> > > Benefits of a user space reclaimer:
> > > -----------------------------------
> > >
> > > 1) More flexible on who should be charged for the cpu of the memory
> > > reclaim. For proactive reclaim, it makes more sense to be centralized.
> > >
> > > 2) More flexible on dedicating the resources (like cpu). The memory
> > > overcommit controller can balance the cost between the cpu usage and
> > > the memory reclaimed.
> > >
> > > 3) Provides a way to the applications to keep their LRUs sorted, so,
> > > under memory pressure better reclaim candidates are selected. This also
> > > gives more accurate and uptodate notion of working set for an
> > > application.
> > >
> > > Why memory.high is not enough?
> > > ------------------------------
> > >
> > > - memory.high can be used to trigger reclaim in a memcg and can
> > >   potentially be used for proactive reclaim.
> > >   However there is a big downside in using memory.high. It can potentially
> > >   introduce high reclaim stalls in the target application as the
> > >   allocations from the processes or the threads of the application can hit
> > >   the temporary memory.high limit.
> > >
> > > - Userspace proactive reclaimers usually use feedback loops to decide
> > >   how much memory to proactively reclaim from a workload. The metrics
> > >   used for this are usually either refaults or PSI, and these metrics
> > >   will become messy if the application gets throttled by hitting the
> > >   high limit.
> > >
> > > - memory.high is a stateful interface, if the userspace proactive
> > >   reclaimer crashes for any reason while triggering reclaim it can leave
> > >   the application in a bad state.
> > >
> > > - If a workload is rapidly expanding, setting memory.high to proactively
> > >   reclaim memory can result in actually reclaiming more memory than
> > >   intended.
> > >
> > > The benefits of such interface and shortcomings of existing interface
> > > were further discussed in this RFC thread:
> > > https://lore.kernel.org/linux-mm/5df21376-7dd1-bf81-8414-32a73cea45dd@google.com/
> > >
> > > Interface:
> > > ----------
> > >
> > > Introducing a very simple memcg interface 'echo 10M > memory.reclaim' to
> > > trigger reclaim in the target memory cgroup.
> > >
> > >
> > > Possible Extensions:
> > > --------------------
> > >
> > > - This interface can be extended with an additional parameter or flags
> > >   to allow specifying one or more types of memory to reclaim from (e.g.
> > >   file, anon, ..).
> > >
> > > - The interface can also be extended with a node mask to reclaim from
> > >   specific nodes. This has use cases for reclaim-based demotion in memory
> > >   tiering systens.
> > >
> > > - A similar per-node interface can also be added to support proactive
> > >   reclaim and reclaim-based demotion in systems without memcg.
> > >
> > > For now, let's keep things simple by adding the basic functionality.
> > >
> > > [yosryahmed@google.com: refreshed to current master, updated commit
> > > message based on recent discussions and use cases]
> > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > ---
> > >  Documentation/admin-guide/cgroup-v2.rst |  9 ++++++
> > >  mm/memcontrol.c                         | 37 +++++++++++++++++++++++++
> > >  2 files changed, 46 insertions(+)
> > >
> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > index 69d7a6983f78..925aaabb2247 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -1208,6 +1208,15 @@ PAGE_SIZE multiple when read back.
> > >         high limit is used and monitored properly, this limit's
> > >         utility is limited to providing the final safety net.
> > >
> > > +  memory.reclaim
> > > +       A write-only file which exists on non-root cgroups.
> > > +
> > > +       This is a simple interface to trigger memory reclaim in the
> > > +       target cgroup. Write the number of bytes to reclaim to this
> > > +       file and the kernel will try to reclaim that much memory.
> > > +       Please note that the kernel can over or under reclaim from
> > > +       the target cgroup.
> > > +
> > >    memory.oom.group
> > >         A read-write single value file which exists on non-root
> > >         cgroups.  The default value is "0".
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 725f76723220..994849fab7df 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -6355,6 +6355,38 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
> > >         return nbytes;
> > >  }
> > >
> > > +static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> > > +                             size_t nbytes, loff_t off)
> > > +{
> > > +       struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> > > +       unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> > > +       unsigned long nr_to_reclaim, nr_reclaimed = 0;
> > > +       int err;
> > > +
> > > +       buf = strstrip(buf);
> > > +       err = page_counter_memparse(buf, "", &nr_to_reclaim);
> > > +       if (err)
> > > +               return err;
> > > +
> > > +       while (nr_reclaimed < nr_to_reclaim) {
> > > +               unsigned long reclaimed;
> > > +
> > > +               if (signal_pending(current))
> > > +                       break;
> > > +
> > > +               reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > > +                                               nr_to_reclaim - nr_reclaimed,
> > > +                                               GFP_KERNEL, true);
> > > +
> > > +               if (!reclaimed && !nr_retries--)
> > > +                       break;
> > > +
> > > +               nr_reclaimed += reclaimed;
> > > +       }
> > > +
> > > +       return nbytes;
> >
> > It is better to return an error code (e.g. -EBUSY) when
> > memory_reclaim() fails to reclaim nr_to_reclaim bytes of memory,
> > except if the cgroup memory usage is already 0.  We can also return
> > -EINVAL if nr_to_reclaim is too large (e.g. > limit).
>
> For -EBUSY, are you thinking of a specific usecase where that would
> come in handy? I'm not really opposed to it, but couldn't convince
> myself of the practical benefits of it, either.
>
> Keep in mind that MAX_RECLAIM_RETRIES failed reclaim attempts usually
> constitute an OOM situation: memory.max will issue kills and
> memory.high will begin crippling throttling. In what scenario would
> you want to keep reclaiming a workload that is considered OOM?
>
> Certainly, proactive reclaim that wants to purge only the cold tail of
> the workload wouldn't retry. Meta's version of this patch actually
> does return -EAGAIN on reclaim failure, but the userspace daemon
> doesn't do anything with it, so I didn't bring it up.

-EAGAIN sounds good, too.  Given that the userspace requests to
reclaim a specified number of bytes, I think it is generally better to
tell the userspace whether the request has been successfully
fulfilled. Ideally, it would be even better to return how many bytes
that have been reclaimed, though that is not easy to do through the
cgroup interface. The userspace can choose to ignore the return value
or log a message/update some stats (which Google does) for the
monitoring purpose.

> For -EINVAL, I tend to lean more toward disagreeing. We've been trying
> to avoid arbitrary dependencies between control knobs in cgroup2, just
> because it exposes us to race conditions and adds complications to the
> interface. For example, it *usually* doesn't make sense to set limits
> to 0, or set local limits and protections higher than the parent. But
> we allow it anyway, to avoid creating well-intended linting rules that
> could interfere with somebody's unforeseen, legitimate usecase.

OK, let's then not check against the limit.
