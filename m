Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5528640086
	for <lists+cgroups@lfdr.de>; Fri,  2 Dec 2022 07:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiLBGZI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Dec 2022 01:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiLBGYu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Dec 2022 01:24:50 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7C598023
        for <cgroups@vger.kernel.org>; Thu,  1 Dec 2022 22:24:26 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id i2so3782811vsc.1
        for <cgroups@vger.kernel.org>; Thu, 01 Dec 2022 22:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Te7nlf3tgyUNylw2aLfROy5KSdSnYYCg2lheu+/mNdA=;
        b=Art8F8H5odERe6K4OJ3za/Tpr9HcQMtpyUw+7q20j9n80APvjUKLAAlCGf1PtUSU2X
         Nc6j/6jRvymlfAU/yUZQbQCrW/qVUZa6Wfl8kaPO2RHQe5gbo7mi5RM7qWIZuFUVop/U
         g86j/y5PvFCJz08peZHJF2OKYM8EGbJrv7R0Ah8CW8xACEEFrLXA18RhzmSGzhijdNr0
         JZCPDK8PyDAMZOWOrbKygSFcoALwbQzlQu4LgBXoNVfdgnEY8zgoDKsexwFDTrw8Aff2
         X6n0ewZAndF6JrFPEh/du/7DLAQ0hqZb+9wk4dCFJbWMcIXW5LA9PmPbkMTSKQBIpNbh
         M5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Te7nlf3tgyUNylw2aLfROy5KSdSnYYCg2lheu+/mNdA=;
        b=Gzs9hwCJlT7I+gOz/doTdLw0o3j2U/SdaYpgdLILJMCH5iyE0v4Vw3dy40lxlEOP3E
         qAabuKV/F9dPKAaaSLecIW0XbiCTzOhmcYmjMIgl1OmhCCYUIblP7PeJHU9KYWqH2zOd
         TKitD6Kol5BGJHxmhyu+x4xOQnWQEnjAoyDbzIijoIuwo72lGf72hDFYPq7vwmFAMz4I
         I5YZ64iIcb1ZqU0iEHna+ofzfgkrGcTSfbYVyNuFjctGSxx6K2GXUYdhfD5HDVjllkUs
         WF6GAbh1SEcRExEFMD08RWwe5r6CCiruhHZbfFBzPqzydQduNpCnGe/jY1a9yvfX4ZOV
         y6cw==
X-Gm-Message-State: ANoB5plzbqXNZeuhlc5AO05JHAFrwcE7m23pE8vNVhv0hR6Iq3R1arJb
        ppsmBYuLGv/vDc1g6Po5I1DXX/1MZSoKZfXdUKoyOw==
X-Google-Smtp-Source: AA0mqf4QmtwCZcn/5VHIZ90zxKTawK5ldU4SExw0nN7WHa3pUkMBczRcbMZ/oXhGLeITwGJsSc4e+QbOEqc18xJW9QQ=
X-Received: by 2002:a05:6102:2758:b0:3b1:1962:24f9 with SMTP id
 p24-20020a056102275800b003b1196224f9mr395682vsu.72.1669962265514; Thu, 01 Dec
 2022 22:24:25 -0800 (PST)
MIME-Version: 1.0
References: <20221130020328.1009347-1-almasrymina@google.com>
 <20221201213202.ycdaymwojd5plyrk@google.com> <CAHS8izOn3Kr8vqxHYxEoGVoCXKmysRKNsvXpJ2EumxDU6JfSDQ@mail.gmail.com>
 <F2917C72-A6F4-4969-B044-211F0D3856F1@linux.dev>
In-Reply-To: <F2917C72-A6F4-4969-B044-211F0D3856F1@linux.dev>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 1 Dec 2022 22:24:14 -0800
Message-ID: <CAHS8izPCh+=iUMVP4Xa7FLXc=xtWc7VkLSpk2gugL=f0koBb=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm: Add nodes= arg to memory.reclaim
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        gthelen@google.com, fvdl@google.com, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 1, 2022 at 10:05 PM Muchun Song <muchun.song@linux.dev> wrote:
>
>
>
> > On Dec 2, 2022, at 06:10, Mina Almasry <almasrymina@google.com> wrote:
> >
> > On Thu, Dec 1, 2022 at 1:32 PM Shakeel Butt <shakeelb@google.com> wrote:
> >>
> >> On Tue, Nov 29, 2022 at 06:03:27PM -0800, Mina Almasry wrote:
> >> [...]
> >>> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >>> index 7b8e8e43806b..23fc5b523764 100644
> >>> --- a/mm/vmscan.c
> >>> +++ b/mm/vmscan.c
> >>> @@ -6735,7 +6735,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
> >>> unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
> >>>                                         unsigned long nr_pages,
> >>>                                         gfp_t gfp_mask,
> >>> -                                        unsigned int reclaim_options)
> >>> +                                        unsigned int reclaim_options,
> >>> +                                        nodemask_t nodemask)
> >>
> >> Can you please make this parameter a nodemask_t* and pass NULL instead
> >> of NODE_MASK_ALL?
> >
> > Thank you very much for the review. I sure can in the next version. To
> > be honest I thought about that and made the parameter nodemask_t
> > because I thought the call sites would be more readable. I.e. this:
> >
> >    try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> > MEMCG_RECLAIM_MAY_SWAP,  NODE_MASK_ALL);
>
> nodemask_t is an array, which can be large depending on CONFIG_NODES_SHIFT.
> I don't think passing a big array is an efficient way. So I agree with Shakeel.
>

Ah, yes, I think the nodemask_t ends up compiling to something like:

typedef struct {
    unsigned long name[BITS_TO_LONGS(MAX_NUMNODES)]
 } nodemask_t;

If it was an array it would be passed by reference anway, but I think
if it is a struct containing an array the array will get copied
indeed. Sure, I will fix in the next version.

> Thanks.
>
> >
> > Would be more readable than this:
> >
> >    try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> > MEMCG_RECLAIM_MAY_SWAP,  NULL);
> >
> > But the tradeoff is that the callers need include/linux/nodemask.h.
> > But yes I can fix in the next version.
> >
>
