Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEC468A282
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 20:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjBCTHo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 14:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjBCTHn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 14:07:43 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5581F3432A;
        Fri,  3 Feb 2023 11:07:42 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id bd15so4413359pfb.8;
        Fri, 03 Feb 2023 11:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nDCfdH5PhWAgC7H11VM8lY+JRkqHaXUeMCOTn+hxrSI=;
        b=qSODSDxdm0nViYzSarSacBlWfSm+myWU+qIIOQRW2ixEsHcB4Ir4iLBUXrvoAIsiv/
         5R3gg/DH4h/vyp+RmgeqaYtriP/PRcXUcCizSIlbNELxTnYQHxm3QweHIRNZIgS63UR0
         6HooxWaBJviQ6rinLCJraKMhrf9tl/BBGIcO2FajJSZ/I07j4LLi6ckhLhQXZHRZf5XD
         Y/+N7xHv2ZR5/Kin0kfsmYWk+Koooa/xedW5wAM1cVRAfsCLLYaA1ugod6The65JU4B+
         BcvfG655rbQzlOSFA+d4YLQcdXn/pWJAL+jW3vaCvo/CIqaVbeDEELFx+RnvaU1qXxdT
         Sdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nDCfdH5PhWAgC7H11VM8lY+JRkqHaXUeMCOTn+hxrSI=;
        b=InAlDym6wXUpSvWn0XBJB68xM2bwzDukUWlkj0r0sQbbQ6IrcqKbmLpUD0PMZJib6j
         /CUYxqkttliv8Q5z5Ytg+tscp26MRWkMCfmAwAPjFZKWjuhzpGsjYBSbYopJxnUZK1LW
         mQNnhId0LYH9lR9ZGnArTbNs/2ib5loVTByW8/5Jm4zxejI6JQ1pi2JhRBrKyaDaMNOm
         z0MLLYHhL+08bPdyImH4LRP+eIHXNhpRKPIoJ1FhsKAmQNOSxj7wby23vYG39b9bXQdS
         ES3ztDSDQcVAtyBLYLN6SzX8XQeSwlPAdnP0aXa5dYbKE6jK6TJDTKL1dgWHDcxxETMX
         qMQQ==
X-Gm-Message-State: AO0yUKXxYIKJ7nXwv4GdQr5/YsoppX0iVfYX/N4cM1JflkILjuYjUv6M
        8JlzUyReJStmroQ/SHCfDyuEWROVs10Y/mzHMNs=
X-Google-Smtp-Source: AK7set+0Qos5sJ1BXqFBHaoguK79AGcVOHMbGkwS7uC6lwawsIbWcJP4GVqmTJOMcHXe5hM5II8Uxu8CP7R/HVcmU3Y=
X-Received: by 2002:a05:6a00:1589:b0:592:7c9a:1236 with SMTP id
 u9-20020a056a00158900b005927c9a1236mr2374540pfk.26.1675451261726; Fri, 03 Feb
 2023 11:07:41 -0800 (PST)
MIME-Version: 1.0
References: <20230202155626.1829121-1-hannes@cmpxchg.org> <Y91ZsDSIr2oFHu3E@P9FQF9L96D.corp.robot.car>
In-Reply-To: <Y91ZsDSIr2oFHu3E@P9FQF9L96D.corp.robot.car>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 3 Feb 2023 11:07:30 -0800
Message-ID: <CAHbLzkpk+6+kzsxmJ_MK+708rpCEjB2njnarLkzfzXX-MUyG7g@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: memcontrol: don't account swap failures not due
 to cgroup limits
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 3, 2023 at 11:00 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Thu, Feb 02, 2023 at 10:56:26AM -0500, Johannes Weiner wrote:
> > Christian reports the following situation in a cgroup that doesn't
> > have memory.swap.max configured:
> >
> >   $ cat memory.swap.events
> >   high 0
> >   max 0
> >   fail 6218
> >
> > Upon closer examination, this is an ARM64 machine that doesn't support
> > swapping out THPs.
>
> Do we expect it to be added any time soon or it's caused by some system
> limitations?

AFAIK, it has been supported since 6.0. See commit d0637c505f8a1

>
> > In that case, the first get_swap_page() fails, and
> > the kernel falls back to splitting the THP and swapping the 4k
> > constituents one by one. /proc/vmstat confirms this with a high rate
> > of thp_swpout_fallback events.
> >
> > While the behavior can ultimately be explained, it's unexpected and
> > confusing. I see three choices how to address this:
> >
> > a) Specifically exlude THP fallbacks from being counted, as the
> >    failure is transient and the memory is ultimately swapped.
> >
> >    Arguably, though, the user would like to know if their cgroup's
> >    swap limit is causing high rates of THP splitting during swapout.
>
> I agree, but it's probably better to reflect it in a form of a per-memcg
> thp split failure counter (e.g. in memory.stat), not as swap out failures.
> Overall option a) looks preferable to me. Especially if in the long run
> the arm64 limitation will be fixed.
>
> >
> > b) Only count cgroup swap events when they are actually due to a
> >    cgroup's own limit. Exclude failures that are due to physical swap
> >    shortage or other system-level conditions (like !THP_SWAP). Also
> >    count them at the level where the limit is configured, which may be
> >    above the local cgroup that holds the page-to-be-swapped.
> >
> >    This is in line with how memory.swap.high, memory.high and
> >    memory.max events are counted.
> >
> >    However, it's a change in documented behavior.
>
> I'm not sure about this option: I can easily imagine a setup with a
> memcg-specific swap space, which would require setting an artificial
> memory.swap.max to get the fail counter working. On the other side not a deal
> breaker.
>
> Thanks!
>
