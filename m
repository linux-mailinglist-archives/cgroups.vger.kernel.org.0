Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35994F8D9F
	for <lists+cgroups@lfdr.de>; Fri,  8 Apr 2022 08:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiDHEMu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Apr 2022 00:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiDHEMs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Apr 2022 00:12:48 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F22E2042B4
        for <cgroups@vger.kernel.org>; Thu,  7 Apr 2022 21:10:45 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 125so9244712iov.10
        for <cgroups@vger.kernel.org>; Thu, 07 Apr 2022 21:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kLJsh09usQM6KN7slbu+hDyAz10KLaAr5TuAGBF1ET8=;
        b=gBo+/HbruUwOBKndO6LMcDu/iJv+/tOrAmtZhCfGRubv6KuCygoW0XzqGPxgTnIjUE
         YsTDHr2rrSBBP4YfBA072r25eyCoMDp623Z9qh4T2KJ/8B9Rst7np2vKyRSlZ6aWzWJ9
         ZrVqZ0kipXK2bXR/XkFovvZKgn4UZJfIehQfiXfSUyIkHnZs4TO8t80L0fJfGBfxdQ0e
         Ks3hUVwCWQARQLa89WDBX16qmbJeFLC3C+MqOnQu4ghjjxCkOQcnGZUWk62YF7TAP13I
         8FRV6jbqN0tq1xYnyrUCZVi227qm1C7BkKEQywopeprRzWbJ2f0+P4RyC2+AILgu8SD8
         MUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLJsh09usQM6KN7slbu+hDyAz10KLaAr5TuAGBF1ET8=;
        b=0LddBxP3lkJJ2mv+mjJoE6LFGXL22KmefDfCaNbS0qV4hVybF6UyxUkNt/iAnrYVcX
         iMvxxwS+PZfJeLcwJ/PmsFvt5pVhhiQVjmCWUlJZ/6MOVZYuNCrHK26UiDlnfjj7nWO6
         5DYl5bzdK23cK/arNfw2V0+Cb1cSTqJYl5NwSGP5dvcl85/AriOo5kikl6pvnvE9yWB8
         E+HHgmISWToubVJYTpnkAmK0QyijCW0yrABUFxIe4ZuvF9Klcpy3jZbs3WU0NhtB8649
         7poAASZz/FGAn6KlewfFNdGOLh+4P2fOnAfitIXmHjvghbIB1fK7yxzTGDPqpax0r7eq
         ToSg==
X-Gm-Message-State: AOAM533+JHP2i3f9r+2hf1DcVEJcV24Ojz/0lOS0CINJwIw8Nez8Z0VP
        fNzCWYqDN2Z0Ubmk4xcPMDTDr0HOOg+R1W/e2h4ZYQ==
X-Google-Smtp-Source: ABdhPJzsHGDQGCBMIEMjZZ+ZfDHTSSvZY148evFFWftTD2yA+ROjdj/6Mou/Sxg7Iwz3kSErR9RaYM0kkHP9g4gRVLk=
X-Received: by 2002:a5e:dc4c:0:b0:64c:ceff:8916 with SMTP id
 s12-20020a5edc4c000000b0064cceff8916mr7651721iop.117.1649391044303; Thu, 07
 Apr 2022 21:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <YkcEMdsi9G5y8mX4@dhcp22.suse.cz> <CAAPL-u_i-Mp-Bo7LtP_4aJscY=1JHG_y1H_-A7N_HRAgtz+arg@mail.gmail.com>
 <87y20nzyw4.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAAPL-u8wjtBRE7KZyZjoQ0eTJecnW35uEXAE3KU0M+AvL=5-ug@mail.gmail.com>
 <87o81fujdc.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAAPL-u_6XqQYtLAMNFvEo+0XU2VR=XYm0T9btL=g6rVVW2h93w@mail.gmail.com>
 <87bkxfudrk.fsf@yhuang6-desk2.ccr.corp.intel.com> <215bd7332aee0ed1092bad4d826a42854ebfd04a.camel@linux.intel.com>
 <CAAPL-u_aAbDOmATSA8ZvjnfBk_7EoXvLoh0etM0fB0aY1845VQ@mail.gmail.com>
 <df6110a09cacc80ee1cbe905a71273a5f3953e16.camel@linux.intel.com>
 <CAAPL-u-oF5HQ26w1czNCmA5VadXOfC54GbGpSppva86YEkefyA@mail.gmail.com> <87y20gtgpf.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87y20gtgpf.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 7 Apr 2022 21:10:33 -0700
Message-ID: <CAAPL-u9hVKx=tgSK7DWLxcbpjJ6oRLyyS=3gqXV9VfKcFmELUQ@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 7, 2022 at 8:08 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Wei Xu <weixugc@google.com> writes:
>
> > On Thu, Apr 7, 2022 at 4:11 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> >>
> >> On Thu, 2022-04-07 at 15:12 -0700, Wei Xu wrote:
> >>
> >> >
> >> > (resending in plain-text, sorry).
> >> >
> >> > memory.demote can work with any level of memory tiers if a nodemask
> >> > argument (or a tier argument if there is a more-explicitly defined,
> >> > userspace visible tiering representation) is provided.  The semantics
> >> > can be to demote X bytes from these nodes to their next tier.
> >> >
> >>
> >> We do need some kind of userspace visible tiering representation.
> >> Will be nice if I can tell the memory type, nodemask of nodes in tier Y with
> >>
> >> cat memory.tier_Y
> >>
> >>
> >> > memory_dram/memory_pmem assumes the hardware for a particular memory
> >> > tier, which is undesirable.  For example, it is entirely possible that
> >> > a slow memory tier is implemented by a lower-cost/lower-performance
> >> > DDR device connected via CXL.mem, not by PMEM.  It is better for this
> >> > interface to speak in either the NUMA node abstraction or a new tier
> >> > abstraction.
> >>
> >> Just from the perspective of memory.reclaim and memory.demote, I think
> >> they could work with nodemask.  For ease of management,
> >> some kind of abstraction of tier information like nodemask, memory type
> >> and expected performance should be readily accessible by user space.
> >>
> >
> > I agree.  The tier information should be provided at the system level.
> > One suggestion is to have a new directory "/sys/devices/system/tier/"
> > for tiers, e.g.:
> >
> > /sys/devices/system/tier/tier0/memlist: all memory nodes in tier 0.
> > /sys/devices/system/tier/tier1/memlist: all memory nodes in tier 1.
>
> I think that it may be sufficient to make tier an attribute of "node".
> Some thing like,
>
> /sys/devices/system/node/nodeX/memory_tier
>

This works. If we want additional information about each tier, we can
then add a tier-specific subtree.

In addition, it would be good to also expose the demotion target nodes
(node_demotion[]) via sysfs, e.g.:

/sys/devices/system/node/nodeX/demotion_path

which returns node_demotion[X].

> Best Regards,
> Huang, Ying
>
> > We can discuss this tier representation in a new thread.
> >
> >> Tim
> >>
> >> >
> >> > It is also desirable to make this interface stateless, i.e. not to
> >> > require the setting of memory_dram.reclaim_policy.  Any policy can be
> >> > specified as arguments to the request itself and should only affect
> >> > that particular request.
> >> >
> >> > Wei
> >>
>
