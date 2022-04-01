Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D024EF77D
	for <lists+cgroups@lfdr.de>; Fri,  1 Apr 2022 18:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349417AbiDAP5l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Apr 2022 11:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352624AbiDAPtw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Apr 2022 11:49:52 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C60021C041
        for <cgroups@vger.kernel.org>; Fri,  1 Apr 2022 08:22:21 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id jo24so2260949qvb.5
        for <cgroups@vger.kernel.org>; Fri, 01 Apr 2022 08:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C8BmOVTEvyZVSx9ld3GApD3hvsbMzWcJqgmXoodcSGk=;
        b=JH66jwKCvtadoIObEkxAHGLxied0NOaZaqUYj7G9CXskhfqsNZS4yu2ULkKh+v9L/v
         OF/Uu698Bvnw4CdTGVpFV2nGYvympuplG9wNMNe+VjnqKjTn4o+EuaeKa1u9zJ1eS1DI
         43kxRf3Hmu4DGi6fKR7m03Ie7EvLkv6MjwkqkpS5hwlkGzB8jX7+ylAil9ZSmd/8dHV8
         seR47Pjx2FAW2uaNc3PFRLxO+m5kZP0fhf3rmHbtly85FbUmAv1G+F5qwyj5+y+QKfZL
         yQxVLSRmvupwh2lYDdUDB/JKUJaYVDoRPvRdiDOwv7C7JFVQ3M1Cwpn+vf5YQReZ8HI7
         5e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C8BmOVTEvyZVSx9ld3GApD3hvsbMzWcJqgmXoodcSGk=;
        b=UDCIfwGjWreTd6baO+sPEi+Mxq3ejjN7mcOnVPG4Z7BvRP8Fh+DHXGqBFcZEiVaXzT
         uTRK4eHavYoYuKlOez9GGbKRVk4JtOOf6aZVO9m/D+psaMHj9P3kV4Fds2oYp1UEoQIL
         DCBkBNRcoPPtZ66eXuKszemHoa1CF7DWR6GRRAhLAJe0GdfqXf0xoeS1Fw+F0uRF4XF1
         DKDThQMCmqSSO78uXN9EqQVvzX/5Wi9Z6txrJPeiy91ZheI+9NieM883C9zcrqPPFzjg
         suejG8sWFsPHvELyo80aLXX1FEu1XfztBq0LBaF7M3/LBsup3F4ExStLD3g2Uj4nVkjc
         EZSw==
X-Gm-Message-State: AOAM531QqhjDo7drz2PwEIpobSkvAJSCYOuY2GTySZubBmsY6jzaFAEC
        5BVUe2umz8HNJPJCpQ+77Xplzg==
X-Google-Smtp-Source: ABdhPJxEmQQeBCz/t0KOjwhgHs7svXisRYYpc/i6mk+/CYLPRZpJBXDA37aZKdGlx6vyVSbCuetdzQ==
X-Received: by 2002:a05:6214:c48:b0:440:cded:f2ab with SMTP id r8-20020a0562140c4800b00440cdedf2abmr39703282qvj.18.1648826540487;
        Fri, 01 Apr 2022 08:22:20 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id t7-20020a05622a01c700b002e1b3555c2fsm1977394qtw.26.2022.04.01.08.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 08:22:20 -0700 (PDT)
Date:   Fri, 1 Apr 2022 11:22:19 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Wei Xu <weixugc@google.com>
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
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
Message-ID: <YkcYq8F6MYlMi+yS@cmpxchg.org>
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <CAAPL-u8g2qkhdTQtFtBS3GNYz0WnyahWEXvR4g_OSaKv+7EozA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAPL-u8g2qkhdTQtFtBS3GNYz0WnyahWEXvR4g_OSaKv+7EozA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 31, 2022 at 09:05:15PM -0700, Wei Xu wrote:
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

For -EBUSY, are you thinking of a specific usecase where that would
come in handy? I'm not really opposed to it, but couldn't convince
myself of the practical benefits of it, either.

Keep in mind that MAX_RECLAIM_RETRIES failed reclaim attempts usually
constitute an OOM situation: memory.max will issue kills and
memory.high will begin crippling throttling. In what scenario would
you want to keep reclaiming a workload that is considered OOM?

Certainly, proactive reclaim that wants to purge only the cold tail of
the workload wouldn't retry. Meta's version of this patch actually
does return -EAGAIN on reclaim failure, but the userspace daemon
doesn't do anything with it, so I didn't bring it up.

For -EINVAL, I tend to lean more toward disagreeing. We've been trying
to avoid arbitrary dependencies between control knobs in cgroup2, just
because it exposes us to race conditions and adds complications to the
interface. For example, it *usually* doesn't make sense to set limits
to 0, or set local limits and protections higher than the parent. But
we allow it anyway, to avoid creating well-intended linting rules that
could interfere with somebody's unforeseen, legitimate usecase.
