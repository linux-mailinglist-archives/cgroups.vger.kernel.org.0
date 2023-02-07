Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5748568E10B
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 20:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjBGTVz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Feb 2023 14:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjBGTVy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Feb 2023 14:21:54 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E13EC6B
        for <cgroups@vger.kernel.org>; Tue,  7 Feb 2023 11:21:53 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m8so17446131edd.10
        for <cgroups@vger.kernel.org>; Tue, 07 Feb 2023 11:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VDILy+PNgcqxcF4yOSkG05rYNGvInPFxYKoFxYbI9dw=;
        b=c24d5UBmzra/K5gTnmg2fAOQqtZAHh41pSuHu3OFxwKNWhulmtBuVr/MIxjG37RNDZ
         WfqAeBdCKw+ws8nmsqOZEblvRLbWueG/t2wQ8B1X+5vTr9dXjXThkzpyhIY9FeNl9ozd
         /KfbBwCajTzHBmfMuxiadNxb31PpZ4vee8+utToEDfH3whzIvj9MLBtFdwdQkep2fRcC
         t2FIJAGN5BttGo/22D1jJADqUmIKdrbkuT2EoWGH6RBthO89cHX+fGjYY2jLiU9hJaiZ
         +G4WHpwm4z0uXRS+7KgUrSPfUCaiyB0PQeZVKcXC4+D4IqIYqRw+VuL8EI+Im5ew2cik
         Uedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDILy+PNgcqxcF4yOSkG05rYNGvInPFxYKoFxYbI9dw=;
        b=Y/5if/t+EVOtc2O4qDOa5KUCS3BMH0I/4O7Rzg6Z1vyeV6LTS1M3x7HeugOpXIqpwO
         iUiPnphdgohBU9JjYtSSdH86wQp45m1E55t8m1DCE1Z73zd/qbDWeu5kuVje2CXjCE19
         pQ4j5pQ48Jyxut7xjCSsk83bm/bRrA0bsnHB0ZzX5Fk5XX2OCTGRPbW1irkN39noPcrM
         cMiT59BXqDeH6ZzC4HpFpQ0qTe1TIGo9FBIR2uSSKBMV8KTEERuM2nKPsG1hl97J1OoN
         hF+8/jrv/Mkhpjb/HJyBW1Es/VU4VXS7iiBjQg0XPbGfignshs1sOgz0aRzG63+Dlhwi
         x+Hg==
X-Gm-Message-State: AO0yUKWec0Nyv3GpgOHws0JFhWuxYs7KH9nt6NHjHxrxBTdrwZRC8heR
        Hg09+GXE8JZ7WyquVJwLfoMMS1ZuCTmgzTQ5CilX5Q==
X-Google-Smtp-Source: AK7set8XFOOUqqLWdCLhum9e/4ptokb0Bh2nheX44PWhOhBR8bKAVyyg9Z0TSHeFDFe2fjyvkpl1wm03TGlRN6U45JE=
X-Received: by 2002:a50:875d:0:b0:49e:1638:1071 with SMTP id
 29-20020a50875d000000b0049e16381071mr939175edv.5.1675797711931; Tue, 07 Feb
 2023 11:21:51 -0800 (PST)
MIME-Version: 1.0
References: <20230202155626.1829121-1-hannes@cmpxchg.org> <CAJD7tkaCpD0LpzdA+NsZj2WK=iQCLn7RS9qc7K53Qonxhp4TgA@mail.gmail.com>
 <Y+Kh5atM0TQmkR+R@cmpxchg.org>
In-Reply-To: <Y+Kh5atM0TQmkR+R@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 7 Feb 2023 11:21:15 -0800
Message-ID: <CAJD7tkZ_vBTh6Nj_8AViJbQ1dFf3zxS3cEjHu0CsuGq+pKH+Jw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: memcontrol: don't account swap failures not due
 to cgroup limits
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
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

On Tue, Feb 7, 2023 at 11:09 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Feb 02, 2023 at 10:30:40AM -0800, Yosry Ahmed wrote:
> > On Thu, Feb 2, 2023 at 7:56 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > Christian reports the following situation in a cgroup that doesn't
> > > have memory.swap.max configured:
> > >
> > >   $ cat memory.swap.events
> > >   high 0
> > >   max 0
> > >   fail 6218
> > >
> > > Upon closer examination, this is an ARM64 machine that doesn't support
> > > swapping out THPs. In that case, the first get_swap_page() fails, and
> > > the kernel falls back to splitting the THP and swapping the 4k
> > > constituents one by one. /proc/vmstat confirms this with a high rate
> > > of thp_swpout_fallback events.
> > >
> > > While the behavior can ultimately be explained, it's unexpected and
> > > confusing. I see three choices how to address this:
> > >
> > > a) Specifically exlude THP fallbacks from being counted, as the
> > >    failure is transient and the memory is ultimately swapped.
> > >
> > >    Arguably, though, the user would like to know if their cgroup's
> > >    swap limit is causing high rates of THP splitting during swapout.
> >
> > We have the option to add THP_SWPOUT_FALLBACK (and THP_SWPOUT for
> > completeness) to memcg events for this if/when a use case arises,
> > right?
>
> Yes, we can add that to memory.stat.
>
> > > b) Only count cgroup swap events when they are actually due to a
> > >    cgroup's own limit. Exclude failures that are due to physical swap
> > >    shortage or other system-level conditions (like !THP_SWAP). Also
> > >    count them at the level where the limit is configured, which may be
> > >    above the local cgroup that holds the page-to-be-swapped.
> > >
> > >    This is in line with how memory.swap.high, memory.high and
> > >    memory.max events are counted.
> > >
> > >    However, it's a change in documented behavior.
> >
> > This option makes sense to me, but I can't speak to the change of
> > documented behavior. However, looking at the code, it seems like if we do this
> > the "max" & "fail" counters become effectively the same. "fail" would
> > not provide much value then.
>
> Right.
>
> > I wonder if it makes sense to have both, and clarify that "fail" -
> > "max" would be non-limit based failures (e.g. ran out of swap space),
> > or would this cause confusion as to whether those non-limit failures
> > were transient (THP fallback) or eventual?
>
> If we add the fallback events, the user can calculate it. I wouldn't
> split the fail counter itself. There are too many reasons why swap can
> fail, half of them implementation-defined (as in the ARM example).
>
> So I think I'll send patches either way to:
>
> 1. Fix the hierarchical accounting of the events to make it consistent
>    with other counters.
>
> 2. Add THP swap/fallback counts to memory.stat

Sounds good, thanks!

>
> We could consider excluding THP fallbacks from the fail count. But it
> seems really wrong for the cgroup controller to start classifying
> individual types of failures in the swap layer and make decisions on
> how to report them to the user. Cgroups really shouldn't be in the
> business of making up its own MM events. I should provide per-cgroup
> accounting of native MM events. And nobody has felt the need to add
> native swap failure counts yet.
>
> So I'd argue we should either remove the swap fail count altogether
> for all the reasons mentioned, or just leave it as is and as a
> documented interface that is unfortunately out the door.
>
> Thoughts?

Agreed. We should either report all failures or failures specific to
cgroup limits (which the max count already tracks).

About removing the fail count completely as-is or completely removing
it, I don't feel strongly either way. If we add THP swap fallbacks to
memory.stat, then the fail counter becomes more understandable as you
can break it down into (max, THP swap fallback, others), with others
being *probably* swap is full. Arguably, it seems like the interesting
components (or the cgroup-relevant) components are already there
regardless. The counter might be useful from a monitoring perspective,
if a memcg OOMs for example a high fail count can show us that it
tried to swap multiple times but failed, we can then look at the max
count and THP fallbacks to understand where the failure is coming
from.

I would say we can leave it as-is, but whatever you prefer.
