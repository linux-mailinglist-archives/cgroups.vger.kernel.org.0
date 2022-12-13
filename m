Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E54D64BD4B
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 20:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbiLMTaA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Dec 2022 14:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbiLMT37 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 14:29:59 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD554248F2
        for <cgroups@vger.kernel.org>; Tue, 13 Dec 2022 11:29:57 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id v4so4340009ual.11
        for <cgroups@vger.kernel.org>; Tue, 13 Dec 2022 11:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=neDu/yrL/JSqlqVsfpnzJOzopkIFlG1Zhb0kcbvbZxE=;
        b=Co3Pb7L35N5xF9xIoLlMGqZks/LFNr4reOf6gCRzOWPQh4D6Vm5kabu8s/xMDPyKTQ
         ErT7zPGS59EnPAPdgJyQICedLFv7aA4I93fBmhAP2ADL50Q9eHAlOZlo25vtmjegw/ry
         HAU2435Dz4h3vUBsm3VLQvKKEmtJOKX/r2zbudg7uWWZR1p0L7HQ6EaBhfUEYyiQowii
         HOgtFY9O2bc1hIO+pd9BTsFuike7L+HqcurRV/1SHITmYxuIlaDBiwdqdX9oEVuyPSVy
         gSxOOgREz2nB1WeQKwxcAlyv2Gup+c5xEjA/7k1NVdA37rZLc/Jyc9dG7iRjCzzmXeEi
         bpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=neDu/yrL/JSqlqVsfpnzJOzopkIFlG1Zhb0kcbvbZxE=;
        b=ib9+KWxZgcDxxIS+PYaDJd11ESoP8EYDs8zm+RlCZFqvHSgxNFFPRXl/dO9bauqN+M
         IWJgF+sEMtfTdvfH++WK86H/Td5YS5LNSOE2KaEn19P9Ux85VPcPD0cRyXGY312SiDmj
         m2FztV+gVPBoIj/hYbYkVjj1Syymr3EyrA17oPqDl0Hh6u9oAPYtjuHvhwAVTCiKN57G
         pr8ye0FrdX4Qje8Xkt6UCecjkNraYK1CsX1Xs5YjGPRN5E9N+VtThEiv+Mp2ReaC3OYe
         MCJpkJFqAU7//vRFQXdDkRyB+sYg1fS+c2yV7j6Ul5ZJDkpELEim+CLNtLskpzS6bwl+
         bFyg==
X-Gm-Message-State: ANoB5pkLxqzhJmiIATWul41cS0OIniSUWHNab4Q4NmXWZ8iDcfVxJJv8
        CxrEqmHe0Oow3yX9jAJzHrPDNGN3uSQ6sQgOOc3FUQ==
X-Google-Smtp-Source: AA0mqf6S0jwUysVhhhnyze8Iay7wzwTiDYa9dfjFaErbonxdVBa5+9U47yOdj4FzqZQT797xfd6gPj6K4vjbuelncLA=
X-Received: by 2002:ab0:6014:0:b0:419:c9d3:a3c6 with SMTP id
 j20-20020ab06014000000b00419c9d3a3c6mr10708006ual.18.1670959796820; Tue, 13
 Dec 2022 11:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20221202223533.1785418-1-almasrymina@google.com>
 <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz> <CAHS8izM-XdLgFrQ1k13X-4YrK=JGayRXV_G3c3Qh4NLKP7cH_g@mail.gmail.com>
 <87k02volwe.fsf@yhuang6-desk2.ccr.corp.intel.com> <Y5h+gHBneexFQcR3@cmpxchg.org>
 <Y5iGJ/9PMmSCwqLj@dhcp22.suse.cz>
In-Reply-To: <Y5iGJ/9PMmSCwqLj@dhcp22.suse.cz>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 13 Dec 2022 11:29:45 -0800
Message-ID: <CAHS8izOuT_-p-N1xPApi+BPJQ+P--2YVSUeiWBROGvGinN0vcg@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Add nodes= arg to memory.reclaim
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        "Huang, Ying" <ying.huang@intel.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, bagasdotme@gmail.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Tue, Dec 13, 2022 at 6:03 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 13-12-22 14:30:40, Johannes Weiner wrote:
> > On Tue, Dec 13, 2022 at 02:30:57PM +0800, Huang, Ying wrote:
> [...]
> > > After these discussion, I think the solution maybe use different
> > > interfaces for "proactive demote" and "proactive reclaim".  That is,
> > > reconsider "memory.demote".  In this way, we will always uncharge the
> > > cgroup for "memory.reclaim".  This avoid the possible confusion there.
> > > And, because demotion is considered aging, we don't need to disable
> > > demotion for "memory.reclaim", just don't count it.
> >
> > Hm, so in summary:
> >
> > 1) memory.reclaim would demote and reclaim like today, but it would
> >    change to only count reclaimed pages against the goal.
> >
> > 2) memory.demote would only demote.
> >

If the above 2 points are agreeable then yes, this sounds good to me
and does address our use case.

> >    a) What if the demotion targets are full? Would it reclaim or fail?
> >

Wei will chime in if he disagrees, but I think we _require_ that it
fails, not falls back to reclaim. The interface is asking for
demotion, and is called memory.demote. For such an interface to fall
back to reclaim would be very confusing to userspace and may trigger
reclaim on a high priority job that we want to shield from proactive
reclaim.

> > 3) Would memory.reclaim and memory.demote still need nodemasks?

memory.demote will need a nodemask, for sure. Today the nodemask would
be useful if there is a specific node in the top tier that is
overloaded and we want to reduce the pressure by demoting. In the
future there will be N tiers and the nodemask says which tier to
demote from.

I don't think memory.reclaim would need a nodemask anymore? At least I
no longer see the use for it for us.

> >    Would
> >    they return -EINVAL if a) memory.reclaim gets passed only toptier
> >    nodes or b) memory.demote gets passed any lasttier nodes?
>

Honestly it would be great if memory.reclaim can force reclaim from a
top tier nodes. It breaks the aginig pipeline, yes, but if the user is
specifically asking for that because they decided in their usecase
it's a good idea then the kernel should comply IMO. Not a strict
requirement for us. Wei will chime in if he disagrees.

memory.demote returning -EINVAL for lasttier nodes makes sense to me.

> I would also add
> 4) Do we want to allow to control the demotion path (e.g. which node to
>    demote from and to) and how to achieve that?

We care deeply about specifying which node to demote _from_. That
would be some node that is approaching pressure and we're looking for
proactive saving from. So far I haven't seen any reason to control
which nodes to demote _to_. The kernel deciding that based on the
aging pipeline and the node distances sounds good to me. Obviously
someone else may find that useful.

> 5) Is the demotion api restricted to multi-tier systems or any numa
>    configuration allowed as well?
>

demotion will of course not work on single tiered systems. The
interface may return some failure on such systems or not be available
at all.

> --
> Michal Hocko
> SUSE Labs
