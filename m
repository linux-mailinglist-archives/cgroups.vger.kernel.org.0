Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933344EEAE4
	for <lists+cgroups@lfdr.de>; Fri,  1 Apr 2022 12:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242124AbiDAKEg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Apr 2022 06:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237915AbiDAKEf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Apr 2022 06:04:35 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1919D26D120
        for <cgroups@vger.kernel.org>; Fri,  1 Apr 2022 03:02:46 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a16so2033785plh.13
        for <cgroups@vger.kernel.org>; Fri, 01 Apr 2022 03:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qxRwtOAESxeyz5WVUXRD0tS/GqKWWNmEkjZmJLerbDY=;
        b=jXM6XCXbGTW+340l5PT/qmsNmQAzjIlDKLRYi3fjrwdgvAE4JxyY9bPj4Je60Xc0DZ
         Ki/AuOfjLSzh4n4a1EXqNXEXRlk3uuWRMZVZTu/7vqM7kCedYF/9fcDz29UHnkoLMcsK
         rbz5HQ7JZLNAh03zo1jNtFV43U6VclXtsqCEoIoN+a21+LKtk+gr187R5ll0nWaMTB7Z
         JraAJt/VAFjl/WMST1MN8xIRObcxpA6PPQ0CIOwdZZxH8BQUCy7AVE4vidwka30BBurx
         S0q3YvWBKlQQMCmRtOCM1Nx1CgPwlvIVQbnbxiEetRcYiENhbdWKYeMOT0H6KHgfYiV7
         tHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qxRwtOAESxeyz5WVUXRD0tS/GqKWWNmEkjZmJLerbDY=;
        b=aUoc2n/4LktgCunwXtJ1UMvr4Z4PYixw5t2+vlZa41HONrSG50b6yn5Tg6u/UAk5O1
         YZ/N66m81I7LRRiNjNhm/4o12gE/Mh35iJj4qgVaYE3MCyk2kEENcVxBr8fSej/wE8OA
         cnfIqiQFui6fVzvgH851oRpBjmXn7U8NS+cI/mw7KjIcvDfWoSyF/JWzFyXIZgnrIcG2
         LpHYU0LKxum/t1DwSQ9LoFAzDQnuoPkYMWPLyxYUMXJYfDWn0FZ/Mcz9KOcs9QLeY6iZ
         tBUhOz/rFRFKuGVXSDLeax2ga8719Tl3vtyXMItwqS9v2X2NrVRbxJH/VBuuxd4BSP/K
         8BJg==
X-Gm-Message-State: AOAM530PAMSvv7ejNKUxMHnZN6fTe8zmsBEOacPXY0tt7OETxyjDcPqf
        N7CqWVvMoJNwr7yaIWCrD6XRLho6Z6L0mRdzvn/51A==
X-Google-Smtp-Source: ABdhPJwtL7Qh3sI9nN/AEwuEQz3FhFuzBIwd156mZBBK3y+g1FSSIQ06sOcoy9fvFn0Wc2klt1gykhnkvPfMI3olp5c=
X-Received: by 2002:a17:902:f24b:b0:154:de5:a24c with SMTP id
 j11-20020a170902f24b00b001540de5a24cmr9687863plc.162.1648807365285; Fri, 01
 Apr 2022 03:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <2025405d-c32b-338a-b668-48b07a34e4ef@huawei.com> <CAJD7tkZHxRY0GEhcRoa8PqLM7pnsu44_U9XKV-9u==iGqwf3=g@mail.gmail.com>
 <bd926b17-45c2-53bc-3c61-cda3ae442312@huawei.com>
In-Reply-To: <bd926b17-45c2-53bc-3c61-cda3ae442312@huawei.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 1 Apr 2022 03:02:09 -0700
Message-ID: <CAJD7tkbo6Hu7gMYSiB4q-tXvGwVG+jR1hkVwpOhvd_WVPmsjCA@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>,
        Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Apr 1, 2022 at 2:49 AM Chen Wandun <chenwandun@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2022/4/1 17:20, Yosry Ahmed =E5=86=99=E9=81=93:
> > On Thu, Mar 31, 2022 at 8:05 PM Chen Wandun <chenwandun@huawei.com> wro=
te:
> >>
> >>
> >> =E5=9C=A8 2022/3/31 16:41, Yosry Ahmed =E5=86=99=E9=81=93:
> >>> From: Shakeel Butt <shakeelb@google.com>
> >>>
> >>> Introduce an memcg interface to trigger memory reclaim on a memory cg=
roup.
> >>>
> >>> Use case: Proactive Reclaim
> >>> ---------------------------
> >>>
> >>> A userspace proactive reclaimer can continuously probe the memcg to
> >>> reclaim a small amount of memory. This gives more accurate and
> >>> up-to-date workingset estimation as the LRUs are continuously
> >>> sorted and can potentially provide more deterministic memory
> >>> overcommit behavior. The memory overcommit controller can provide
> >>> more proactive response to the changing behavior of the running
> >>> applications instead of being reactive.
> >>>
> >>> A userspace reclaimer's purpose in this case is not a complete replac=
ement
> >>> for kswapd or direct reclaim, it is to proactively identify memory sa=
vings
> >>> opportunities and reclaim some amount of cold pages set by the policy
> >>> to free up the memory for more demanding jobs or scheduling new jobs.
> >>>
> >>> A user space proactive reclaimer is used in Google data centers.
> >>> Additionally, Meta's TMO paper recently referenced a very similar
> >>> interface used for user space proactive reclaim:
> >>> https://dl.acm.org/doi/pdf/10.1145/3503222.3507731
> >>>
> >>> Benefits of a user space reclaimer:
> >>> -----------------------------------
> >>>
> >>> 1) More flexible on who should be charged for the cpu of the memory
> >>> reclaim. For proactive reclaim, it makes more sense to be centralized=
.
> >>>
> >>> 2) More flexible on dedicating the resources (like cpu). The memory
> >>> overcommit controller can balance the cost between the cpu usage and
> >>> the memory reclaimed.
> >>>
> >>> 3) Provides a way to the applications to keep their LRUs sorted, so,
> >>> under memory pressure better reclaim candidates are selected. This al=
so
> >>> gives more accurate and uptodate notion of working set for an
> >>> application.
> >>>
> >>> Why memory.high is not enough?
> >>> ------------------------------
> >>>
> >>> - memory.high can be used to trigger reclaim in a memcg and can
> >>>     potentially be used for proactive reclaim.
> >>>     However there is a big downside in using memory.high. It can pote=
ntially
> >>>     introduce high reclaim stalls in the target application as the
> >>>     allocations from the processes or the threads of the application =
can hit
> >>>     the temporary memory.high limit.
> >>>
> >>> - Userspace proactive reclaimers usually use feedback loops to decide
> >>>     how much memory to proactively reclaim from a workload. The metri=
cs
> >>>     used for this are usually either refaults or PSI, and these metri=
cs
> >>>     will become messy if the application gets throttled by hitting th=
e
> >>>     high limit.
> >>>
> >>> - memory.high is a stateful interface, if the userspace proactive
> >>>     reclaimer crashes for any reason while triggering reclaim it can =
leave
> >>>     the application in a bad state.
> >>>
> >>> - If a workload is rapidly expanding, setting memory.high to proactiv=
ely
> >>>     reclaim memory can result in actually reclaiming more memory than
> >>>     intended.
> >>>
> >>> The benefits of such interface and shortcomings of existing interface
> >>> were further discussed in this RFC thread:
> >>> https://lore.kernel.org/linux-mm/5df21376-7dd1-bf81-8414-32a73cea45dd=
@google.com/
> >>>
> >>> Interface:
> >>> ----------
> >>>
> >>> Introducing a very simple memcg interface 'echo 10M > memory.reclaim'=
 to
> >>> trigger reclaim in the target memory cgroup.
> >>>
> >>>
> >>> Possible Extensions:
> >>> --------------------
> >>>
> >>> - This interface can be extended with an additional parameter or flag=
s
> >>>     to allow specifying one or more types of memory to reclaim from (=
e.g.
> >>>     file, anon, ..).
> >>>
> >>> - The interface can also be extended with a node mask to reclaim from
> >>>     specific nodes. This has use cases for reclaim-based demotion in =
memory
> >>>     tiering systens.
> >>>
> >>> - A similar per-node interface can also be added to support proactive
> >>>     reclaim and reclaim-based demotion in systems without memcg.
> >>>
> >>> For now, let's keep things simple by adding the basic functionality.
> >>>
> >>> [yosryahmed@google.com: refreshed to current master, updated commit
> >>> message based on recent discussions and use cases]
> >>> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> >>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >>> ---
> >>>    Documentation/admin-guide/cgroup-v2.rst |  9 ++++++
> >>>    mm/memcontrol.c                         | 37 +++++++++++++++++++++=
++++
> >>>    2 files changed, 46 insertions(+)
> >>>
> >>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/=
admin-guide/cgroup-v2.rst
> >>> index 69d7a6983f78..925aaabb2247 100644
> >>> --- a/Documentation/admin-guide/cgroup-v2.rst
> >>> +++ b/Documentation/admin-guide/cgroup-v2.rst
> >>> @@ -1208,6 +1208,15 @@ PAGE_SIZE multiple when read back.
> >>>        high limit is used and monitored properly, this limit's
> >>>        utility is limited to providing the final safety net.
> >>>
> >>> +  memory.reclaim
> >>> +     A write-only file which exists on non-root cgroups.
> >>> +
> >>> +     This is a simple interface to trigger memory reclaim in the
> >>> +     target cgroup. Write the number of bytes to reclaim to this
> >>> +     file and the kernel will try to reclaim that much memory.
> >>> +     Please note that the kernel can over or under reclaim from
> >>> +     the target cgroup.
> >>> +
> >>>      memory.oom.group
> >>>        A read-write single value file which exists on non-root
> >>>        cgroups.  The default value is "0".
> >>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >>> index 725f76723220..994849fab7df 100644
> >>> --- a/mm/memcontrol.c
> >>> +++ b/mm/memcontrol.c
> >>> @@ -6355,6 +6355,38 @@ static ssize_t memory_oom_group_write(struct k=
ernfs_open_file *of,
> >>>        return nbytes;
> >>>    }
> >>>
> >>> +static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf=
,
> >>> +                           size_t nbytes, loff_t off)
> >>> +{
> >>> +     struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of));
> >>> +     unsigned int nr_retries =3D MAX_RECLAIM_RETRIES;
> >>> +     unsigned long nr_to_reclaim, nr_reclaimed =3D 0;
> >>> +     int err;
> >>> +
> >>> +     buf =3D strstrip(buf);
> >>> +     err =3D page_counter_memparse(buf, "", &nr_to_reclaim);
> >>> +     if (err)
> >>> +             return err;
> >>> +
> >>> +     while (nr_reclaimed < nr_to_reclaim) {
> >>> +             unsigned long reclaimed;
> >>> +
> >>> +             if (signal_pending(current))
> >>> +                     break;
> >>> +
> >>> +             reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
> >>> +                                             nr_to_reclaim - nr_recl=
aimed,
> >>> +                                             GFP_KERNEL, true);
> >> In some scenario there are lots of page cache,  and we only want to
> >> reclaim page cache,
> >> how about add may_swap option?
> > Thanks for taking a look at this!
> >
> > The first listed extension is an argument/flags to specify the type of
> do you mean nbytes in  memory_reclaim? it decide the amount of memory
> to reclaim.
>
> one more argument such as may_swap can be add into memory_reclaim, and
> pass this argument to try_to_free_mem_cgroup_pages in order to replace th=
e
> default "true"
>
> Thanks.

I agree about the need for a may_swap or similar argument. In the
commit message I list some possible extensions to this interface, and
the first one is to add an argument to specify the type of memory we
want to reclaim using the interface (anon, file, ..), which I think
covers this use case. I just think we should add this in a separate
patch as an extension.

>
> > memory that we want to reclaim, I think this covers this use case, or
> > am I missing something?
> >
> >>> +
> >>> +             if (!reclaimed && !nr_retries--)
> >>> +                     break;
> >>> +
> >>> +             nr_reclaimed +=3D reclaimed;
> >>> +     }
> >>> +
> >>> +     return nbytes;
> >>> +}
> >>> +
> >>>    static struct cftype memory_files[] =3D {
> >>>        {
> >>>                .name =3D "current",
> >>> @@ -6413,6 +6445,11 @@ static struct cftype memory_files[] =3D {
> >>>                .seq_show =3D memory_oom_group_show,
> >>>                .write =3D memory_oom_group_write,
> >>>        },
> >>> +     {
> >>> +             .name =3D "reclaim",
> >>> +             .flags =3D CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
> >>> +             .write =3D memory_reclaim,
> >>> +     },
> >>>        { }     /* terminate */
> >>>    };
> >>>
> > .
>
