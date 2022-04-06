Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0114F566C
	for <lists+cgroups@lfdr.de>; Wed,  6 Apr 2022 08:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiDFGR3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Apr 2022 02:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1841034AbiDFFgo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Apr 2022 01:36:44 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CD823213B
        for <cgroups@vger.kernel.org>; Tue,  5 Apr 2022 18:08:01 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id d3so842960ilr.10
        for <cgroups@vger.kernel.org>; Tue, 05 Apr 2022 18:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RgvBhB60r34bKOm2tCGx0FLu0SdJzIYZfN+oE6mYW4Y=;
        b=UCNyZ54P2mgXYG0SUsGZv0scK1xaO99fPJQNVGaOcBBfVEqjvQWJbhpUIt9gU/3XWy
         i1AIqrFuz6OljshjkJ4io2XcByq5P5phDtENYPHWUiAXdmExOJbEGf4bnIsPloqvrSVp
         gfVTsJ6ugbeqHqj8t+OgchC3cON2X9yJ4tb8TPAbmr5MyrtpuZFB8QOzD9zlxC7nWjRd
         0djc5eUqkeqQREev7dlWuZK7CObjNQPhXfsRPHPVaMTGnFug9sCPmEJQgAMVooK/KPYU
         auxh5Czx04A5jkdZ/uXqiokinos3NqmfNX1n5/a/CgMMMmh4nQvDTOvQxE4YeRMHkAaZ
         uFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RgvBhB60r34bKOm2tCGx0FLu0SdJzIYZfN+oE6mYW4Y=;
        b=gCkIUm58BVu1WBxoUFAVx4TjV7IpsWQkdUi1ey4g0duLwszvFxXXFDsUH6FBPPOHII
         239ndBW9RayTYTGywPD/BaK+AYhT0P2ffVZgmckYcYGcVT5+JhNUBQENelFgB2BvuwVW
         kJU8C9W2mCFNkJN/SOzXas1euGzItUzKt1kK1YPiHgr/b4db/gKlXGknaX7rW+O6RjbW
         NxoKc+g6X6oyaxq5Kc/aPTXWgSu9OYw08FjUUrzDxKeXz39uxWILaYiL2EuBhf7v36xu
         wHuoTy7NQDkbGv7GCHgJ2ve2uTe25YuY2GAw4uegKG5ZXYOuQ+344cdP4WHn21EvYDlW
         +tHg==
X-Gm-Message-State: AOAM532Ha6X92HE5Expv0QaBxY/R7zX/uD4siaV2q6HEsaYf6uiSNiXh
        T2uAytES8A65hRulPS0WBG4IOSUIDH5tupEVgtGEDA==
X-Google-Smtp-Source: ABdhPJxq3KHZ1VgC8H6k/nkG/PU0tBmZKSI4Zq/E9uh0ebH59q9hVWU4W+VT5mcgO2wHoffP8694DLo9F8gK5lolIXQ=
X-Received: by 2002:a92:cd8b:0:b0:2c9:ded9:f20d with SMTP id
 r11-20020a92cd8b000000b002c9ded9f20dmr2825689ilb.300.1649207280627; Tue, 05
 Apr 2022 18:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <YkcEMdsi9G5y8mX4@dhcp22.suse.cz> <CAAPL-u_i-Mp-Bo7LtP_4aJscY=1JHG_y1H_-A7N_HRAgtz+arg@mail.gmail.com>
 <87y20nzyw4.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAAPL-u8wjtBRE7KZyZjoQ0eTJecnW35uEXAE3KU0M+AvL=5-ug@mail.gmail.com>
 <87o81fujdc.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87o81fujdc.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Tue, 5 Apr 2022 18:07:49 -0700
Message-ID: <CAAPL-u_6XqQYtLAMNFvEo+0XU2VR=XYm0T9btL=g6rVVW2h93w@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Cgroups <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
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

On Tue, Apr 5, 2022 at 5:49 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Wei Xu <weixugc@google.com> writes:
>
> > On Sat, Apr 2, 2022 at 1:13 AM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> Wei Xu <weixugc@google.com> writes:
> >>
> >> > On Fri, Apr 1, 2022 at 6:54 AM Michal Hocko <mhocko@suse.com> wrote:
> >> >>
> >> >> On Thu 31-03-22 08:41:51, Yosry Ahmed wrote:
> >> >> > From: Shakeel Butt <shakeelb@google.com>
> >> >> >
> >>
> >> [snip]
> >>
> >> >> > Possible Extensions:
> >> >> > --------------------
> >> >> >
> >> >> > - This interface can be extended with an additional parameter or flags
> >> >> >   to allow specifying one or more types of memory to reclaim from (e.g.
> >> >> >   file, anon, ..).
> >> >> >
> >> >> > - The interface can also be extended with a node mask to reclaim from
> >> >> >   specific nodes. This has use cases for reclaim-based demotion in memory
> >> >> >   tiering systens.
> >> >> >
> >> >> > - A similar per-node interface can also be added to support proactive
> >> >> >   reclaim and reclaim-based demotion in systems without memcg.
> >> >> >
> >> >> > For now, let's keep things simple by adding the basic functionality.
> >> >>
> >> >> Yes, I am for the simplicity and this really looks like a bare minumum
> >> >> interface. But it is not really clear who do you want to add flags on
> >> >> top of it?
> >> >>
> >> >> I am not really sure we really need a node aware interface for memcg.
> >> >> The global reclaim interface will likely need a different node because
> >> >> we do not want to make this CONFIG_MEMCG constrained.
> >> >
> >> > A nodemask argument for memory.reclaim can be useful for memory
> >> > tiering between NUMA nodes with different performance.  Similar to
> >> > proactive reclaim, it can allow a userspace daemon to drive
> >> > memcg-based proactive demotion via the reclaim-based demotion
> >> > mechanism in the kernel.
> >>
> >> I am not sure whether nodemask is a good way for demoting pages between
> >> different types of memory.  For example, for a system with DRAM and
> >> PMEM, if specifying DRAM node in nodemask means demoting to PMEM, what
> >> is the meaning of specifying PMEM node? reclaiming to disk?
> >>
> >> In general, I have no objection to the idea in general.  But we should
> >> have a clear and consistent interface.  Per my understanding the default
> >> memcg interface is for memory, regardless of memory types.  The memory
> >> reclaiming means reduce the memory usage, regardless of memory types.
> >> We need to either extending the semantics of memory reclaiming (to
> >> include memory demoting too), or add another interface for memory
> >> demoting.
> >
> > Good point.  With the "demote pages during reclaim" patch series,
> > reclaim is already extended to demote pages as well.  For example,
> > can_reclaim_anon_pages() returns true if demotion is allowed and
> > shrink_page_list() can demote pages instead of reclaiming pages.
>
> These are in-kernel implementation, not the ABI.  So we still have
> the opportunity to define the ABI now.
>
> > Currently, demotion is disabled for memcg reclaim, which I think can
> > be relaxed and also necessary for memcg-based proactive demotion.  I'd
> > like to suggest that we extend the semantics of memory.reclaim to
> > cover memory demotion as well.  A flag can be used to enable/disable
> > the demotion behavior.
>
> If so,
>
> # echo A > memory.reclaim
>
> means
>
> a) "A" bytes memory are freed from the memcg, regardless demoting is
>    used or not.
>
> or
>
> b) "A" bytes memory are reclaimed from the memcg, some of them may be
>    freed, some of them may be just demoted from DRAM to PMEM.  The total
>    number is "A".
>
> For me, a) looks more reasonable.
>

We can use a DEMOTE flag to control the demotion behavior for
memory.reclaim.  If the flag is not set (the default), then
no_demotion of scan_control can be set to 1, similar to
reclaim_pages().

The question is then whether we want to rename memory.reclaim to
something more general.  I think this name is fine if reclaim-based
demotion is an accepted concept.
