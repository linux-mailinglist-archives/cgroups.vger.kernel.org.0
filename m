Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA2F4EE805
	for <lists+cgroups@lfdr.de>; Fri,  1 Apr 2022 08:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245277AbiDAGD6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Apr 2022 02:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245267AbiDAGD4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Apr 2022 02:03:56 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E2A25ECAC
        for <cgroups@vger.kernel.org>; Thu, 31 Mar 2022 23:02:04 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id g21so2030727iom.13
        for <cgroups@vger.kernel.org>; Thu, 31 Mar 2022 23:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XCQogSO+OfQ1sQZIBbyR5sB6BN62JapXBysf7xbNdFM=;
        b=WcxfXkHfqkWMH8NzwYnDbFDQrtiIfVncrQpugkatih0ZARHjEPk/pVgfdYyyDSuUc8
         jlVE9so5wHjQWLT0wLMm2SBrDyZ+l5PIJVEuXib7s5u8ptOQIg+va8Nk0ft3tDnoqXmQ
         MXqQePXWd9RpKiA7z0hwsOBfNI+0nwp1DLARFdes99kzzYB9rhD4gDZvRcS2XOvuf5M/
         yPnOc0yzFcgWklX/bBb8bLhteFwhYa1DybzBufe+DWdL3JSDCAewpKbdupqcbwjwOtov
         Wffpti1yfLI/665TXuMlDmlom1mhR6eZOjZyzhMi5F3NzDtO+o1rwtJLdFRHcTLg1Vj2
         aCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XCQogSO+OfQ1sQZIBbyR5sB6BN62JapXBysf7xbNdFM=;
        b=AnbAwfFZCsInJrrOmuDHwmrUhg9si+1tcLtQhBk66P5UCYvT4Kcdj0Dyg7dlnzzf46
         k2OIXUfGiaztLo7xfNJmPJJH7vCGCc+tKPuldU1NVNDEgzWL1w2WKnrFWW8TOHwXnOD3
         GpCJbT3XDq7gnEP/SK7GkJU8JXErI2IFsf+GCsGOp/SWyAEDah/wzYrdChL15erNzGq7
         4ZV9Y2OAu5Wqt0VH3EZKkzE38C0XM/KKKVYBghr5CY/2O5vV+N7yx0z1ct2uCAywfTpZ
         Ivc6wP1iAsFuiHUN2s25VAe8v1QSWzKXiV+n0CZfcvDNGz9VdZBIPUjQGOf21Rb1dAex
         eM9Q==
X-Gm-Message-State: AOAM53372OO7H0rtyFJJTTWZOMfvdbFdindW4t3LT0md0Zleb9z/jhen
        PBUwoEajRN18oy8wF9vWn+K5q+dJsETE7vo70FjI+Q==
X-Google-Smtp-Source: ABdhPJzAZ/ctRixshNJdHUX7zMhj/+sTHujTxaBzoh7kxj0fYJGbxkYxtlCEzWrcuflLOm1P7Qr/tPlMC0UmD6HhlSc=
X-Received: by 2002:a05:6638:4128:b0:323:62b4:30c3 with SMTP id
 ay40-20020a056638412800b0032362b430c3mr5175719jab.318.1648792923372; Thu, 31
 Mar 2022 23:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com> <YkXkA+Oh1Bx33PrU@carbon.dhcp.thefacebook.com>
In-Reply-To: <YkXkA+Oh1Bx33PrU@carbon.dhcp.thefacebook.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 31 Mar 2022 23:01:52 -0700
Message-ID: <CAAPL-u82EZaxty3qdSYO=xrjBYSejNcvafQKyn1xKF=_UwXBbg@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
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

A timeout is a good idea.  I think it can be added as an extension,
similar to other extensions.

> Also, please please add a test to selftests/cgroup/memcg tests.
> It will also provide an example on how the userspace can use the feature.

+1

> >
> > For now, let's keep things simple by adding the basic functionality.
>
> What I'm worried about is how we gonna extend it? How do you see the interface
> with 2-3 extensions from the list above? All these extensions look very
> reasonable to me, so we'll likely have to implement them soon. So let's think
> about the extensibility now.

For the first two extensions (flags and nodemask), they can be
implemented as additional positional arguments of memory.reclaim.

The non-memcg use cases will need a different interface, which can be
either a sysfs file or a syscall.

> I wonder if it makes more sense to introduce a sys_reclaim() syscall instead?
> In the end, such a feature might make sense on the system level too.
> Yes, there is the drop_caches sysctl, but it's too radical for many cases.

sys_reclaim() syscall is a good proposal for non-memcg use cases.  But
for memcg-based proactive reclaim,  memory.reclaim should be more
natural. It is not common to have cgroup as a syscall argument.

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
