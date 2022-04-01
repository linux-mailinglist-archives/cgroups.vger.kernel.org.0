Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FC74EE704
	for <lists+cgroups@lfdr.de>; Fri,  1 Apr 2022 06:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiDAEHR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Apr 2022 00:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiDAEHQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Apr 2022 00:07:16 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD31A3DA65
        for <cgroups@vger.kernel.org>; Thu, 31 Mar 2022 21:05:27 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id p22so1910342iod.2
        for <cgroups@vger.kernel.org>; Thu, 31 Mar 2022 21:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+CLss0WbItuifu72dHflWYaudPs9OpOIrtnBZ+LuaU=;
        b=W4lP36K+Sb0fsBGicZNNHA2PdXSFLxGLOGu+QIo0Pr+K09Bfb/JQ9y7h29SJTwHCkL
         qo9Meye8l/bh5ZdCafGJlboKfyAh3OTCZiwV615CLHt7foV27/crahdWIZpXP9o5zyDT
         f4B0knRfleCmNsT7S/1gVtK/jnuLe8dMnvgnkEw7P3BsrmJSWJR0z6u8myMWpvrwhycC
         K0MJjUxswzx2hsClKurU0lxBklqJnt5jCMfdXO/WkmQApUMQX+vefGDz6SReFNqKkDvo
         OLqXgs1GpET++yDSsieKbkumlNIePUfHJvkrEdI24CUoKeH4Ge+57mvK0e8QEpJiPpQ6
         0WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+CLss0WbItuifu72dHflWYaudPs9OpOIrtnBZ+LuaU=;
        b=3NHnwVy2Du5eOz8NXnsIdqW/F8kLuFNcUB5EJurGli2Hj9HbCkET8SIdLEGpoEgXjQ
         DDTn3XWEC7oRWkCXX+2JKGRHPnn6v4xqVTsOGeGhcPaEY8axgvMZrIpuTxOOHp2ICQ0h
         3Bapum6FXsMYEQJ0f1Ztrksa3g46EABMXamicSp8tULeS2YtSc2ARKGemVn30y+CKTeJ
         J62s5s30RZdIa8PPwffXV5EUqdE/NKD7lOCYOQd10KQlod2frDX4OAAnbd+cHaM2qLOX
         E6lsUyLBa2bxbgRy9N8YNVzyPhEbZJksomWfdRqSRL4YNACS5fjg8Nuu7vaISvImZktW
         Faxw==
X-Gm-Message-State: AOAM531JIwdL1Wymw4a4UeOpjTRu1Gp21Jpbeo5RI1x6lAfm+PSagnoh
        /AeDr/KqzQWTMdnBlkikqfPnTytCd0LdAzJClx7Iww==
X-Google-Smtp-Source: ABdhPJxTpgpr2IYgcO6o0NsQkkbran/YiQB177+6APQAT+EOzydrNcz9ySUynHUNFST25lY4tTlWweAtwwYoDAybsGU=
X-Received: by 2002:a05:6638:4128:b0:323:62b4:30c3 with SMTP id
 ay40-20020a056638412800b0032362b430c3mr4994319jab.318.1648785926987; Thu, 31
 Mar 2022 21:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com>
In-Reply-To: <20220331084151.2600229-1-yosryahmed@google.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 31 Mar 2022 21:05:15 -0700
Message-ID: <CAAPL-u8g2qkhdTQtFtBS3GNYz0WnyahWEXvR4g_OSaKv+7EozA@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Yosry Ahmed <yosryahmed@google.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 31, 2022 at 1:42 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> From: Shakeel Butt <shakeelb@google.com>
>
> Introduce an memcg interface to trigger memory reclaim on a memory cgroup.
>
> Use case: Proactive Reclaim
> ---------------------------
>
> A userspace proactive reclaimer can continuously probe the memcg to
> reclaim a small amount of memory. This gives more accurate and
> up-to-date workingset estimation as the LRUs are continuously
> sorted and can potentially provide more deterministic memory
> overcommit behavior. The memory overcommit controller can provide
> more proactive response to the changing behavior of the running
> applications instead of being reactive.
>
> A userspace reclaimer's purpose in this case is not a complete replacement
> for kswapd or direct reclaim, it is to proactively identify memory savings
> opportunities and reclaim some amount of cold pages set by the policy
> to free up the memory for more demanding jobs or scheduling new jobs.
>
> A user space proactive reclaimer is used in Google data centers.
> Additionally, Meta's TMO paper recently referenced a very similar
> interface used for user space proactive reclaim:
> https://dl.acm.org/doi/pdf/10.1145/3503222.3507731
>
> Benefits of a user space reclaimer:
> -----------------------------------
>
> 1) More flexible on who should be charged for the cpu of the memory
> reclaim. For proactive reclaim, it makes more sense to be centralized.
>
> 2) More flexible on dedicating the resources (like cpu). The memory
> overcommit controller can balance the cost between the cpu usage and
> the memory reclaimed.
>
> 3) Provides a way to the applications to keep their LRUs sorted, so,
> under memory pressure better reclaim candidates are selected. This also
> gives more accurate and uptodate notion of working set for an
> application.
>
> Why memory.high is not enough?
> ------------------------------
>
> - memory.high can be used to trigger reclaim in a memcg and can
>   potentially be used for proactive reclaim.
>   However there is a big downside in using memory.high. It can potentially
>   introduce high reclaim stalls in the target application as the
>   allocations from the processes or the threads of the application can hit
>   the temporary memory.high limit.
>
> - Userspace proactive reclaimers usually use feedback loops to decide
>   how much memory to proactively reclaim from a workload. The metrics
>   used for this are usually either refaults or PSI, and these metrics
>   will become messy if the application gets throttled by hitting the
>   high limit.
>
> - memory.high is a stateful interface, if the userspace proactive
>   reclaimer crashes for any reason while triggering reclaim it can leave
>   the application in a bad state.
>
> - If a workload is rapidly expanding, setting memory.high to proactively
>   reclaim memory can result in actually reclaiming more memory than
>   intended.
>
> The benefits of such interface and shortcomings of existing interface
> were further discussed in this RFC thread:
> https://lore.kernel.org/linux-mm/5df21376-7dd1-bf81-8414-32a73cea45dd@google.com/
>
> Interface:
> ----------
>
> Introducing a very simple memcg interface 'echo 10M > memory.reclaim' to
> trigger reclaim in the target memory cgroup.
>
>
> Possible Extensions:
> --------------------
>
> - This interface can be extended with an additional parameter or flags
>   to allow specifying one or more types of memory to reclaim from (e.g.
>   file, anon, ..).
>
> - The interface can also be extended with a node mask to reclaim from
>   specific nodes. This has use cases for reclaim-based demotion in memory
>   tiering systens.
>
> - A similar per-node interface can also be added to support proactive
>   reclaim and reclaim-based demotion in systems without memcg.
>
> For now, let's keep things simple by adding the basic functionality.
>
> [yosryahmed@google.com: refreshed to current master, updated commit
> message based on recent discussions and use cases]
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  9 ++++++
>  mm/memcontrol.c                         | 37 +++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 69d7a6983f78..925aaabb2247 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1208,6 +1208,15 @@ PAGE_SIZE multiple when read back.
>         high limit is used and monitored properly, this limit's
>         utility is limited to providing the final safety net.
>
> +  memory.reclaim
> +       A write-only file which exists on non-root cgroups.
> +
> +       This is a simple interface to trigger memory reclaim in the
> +       target cgroup. Write the number of bytes to reclaim to this
> +       file and the kernel will try to reclaim that much memory.
> +       Please note that the kernel can over or under reclaim from
> +       the target cgroup.
> +
>    memory.oom.group
>         A read-write single value file which exists on non-root
>         cgroups.  The default value is "0".
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 725f76723220..994849fab7df 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6355,6 +6355,38 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
>         return nbytes;
>  }
>
> +static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> +                             size_t nbytes, loff_t off)
> +{
> +       struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +       unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> +       unsigned long nr_to_reclaim, nr_reclaimed = 0;
> +       int err;
> +
> +       buf = strstrip(buf);
> +       err = page_counter_memparse(buf, "", &nr_to_reclaim);
> +       if (err)
> +               return err;
> +
> +       while (nr_reclaimed < nr_to_reclaim) {
> +               unsigned long reclaimed;
> +
> +               if (signal_pending(current))
> +                       break;
> +
> +               reclaimed = try_to_free_mem_cgroup_pages(memcg,
> +                                               nr_to_reclaim - nr_reclaimed,
> +                                               GFP_KERNEL, true);
> +
> +               if (!reclaimed && !nr_retries--)
> +                       break;
> +
> +               nr_reclaimed += reclaimed;
> +       }
> +
> +       return nbytes;

It is better to return an error code (e.g. -EBUSY) when
memory_reclaim() fails to reclaim nr_to_reclaim bytes of memory,
except if the cgroup memory usage is already 0.  We can also return
-EINVAL if nr_to_reclaim is too large (e.g. > limit).

> +}
> +
>  static struct cftype memory_files[] = {
>         {
>                 .name = "current",
> @@ -6413,6 +6445,11 @@ static struct cftype memory_files[] = {
>                 .seq_show = memory_oom_group_show,
>                 .write = memory_oom_group_write,
>         },
> +       {
> +               .name = "reclaim",
> +               .flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
> +               .write = memory_reclaim,
> +       },
>         { }     /* terminate */
>  };
>
> --
> 2.35.1.1021.g381101b075-goog
>
