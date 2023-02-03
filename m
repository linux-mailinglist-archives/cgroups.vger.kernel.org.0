Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F1968A263
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 20:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjBCTAK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 14:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjBCTAJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 14:00:09 -0500
Received: from out-230.mta1.migadu.com (out-230.mta1.migadu.com [IPv6:2001:41d0:203:375::e6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8844C2A
        for <cgroups@vger.kernel.org>; Fri,  3 Feb 2023 11:00:07 -0800 (PST)
Date:   Fri, 3 Feb 2023 11:00:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675450805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bDlRD3fwCPL14p6e6ddJjSrpAo4LDvSi2XC5vgn8kU0=;
        b=BS2eVBXFzFjNVBl+LWymBljXHRNVObqwCrs6RSCuaozAoNgSBBHI+URK67rTHSm37kcZnB
        xuu7iZbEKt34nkdtPU1rIcyM+rsn4lX0QtnZ4Dx0YQ1iiKeeUZIFXwH106L0PWu3sXHBWo
        CcnuqqZpr6oOUA9uxQraLv13i7vqCi8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH] mm: memcontrol: don't account swap failures not due
 to cgroup limits
Message-ID: <Y91ZsDSIr2oFHu3E@P9FQF9L96D.corp.robot.car>
References: <20230202155626.1829121-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202155626.1829121-1-hannes@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 02, 2023 at 10:56:26AM -0500, Johannes Weiner wrote:
> Christian reports the following situation in a cgroup that doesn't
> have memory.swap.max configured:
> 
>   $ cat memory.swap.events
>   high 0
>   max 0
>   fail 6218
> 
> Upon closer examination, this is an ARM64 machine that doesn't support
> swapping out THPs.

Do we expect it to be added any time soon or it's caused by some system
limitations?

> In that case, the first get_swap_page() fails, and
> the kernel falls back to splitting the THP and swapping the 4k
> constituents one by one. /proc/vmstat confirms this with a high rate
> of thp_swpout_fallback events.
> 
> While the behavior can ultimately be explained, it's unexpected and
> confusing. I see three choices how to address this:
> 
> a) Specifically exlude THP fallbacks from being counted, as the
>    failure is transient and the memory is ultimately swapped.
> 
>    Arguably, though, the user would like to know if their cgroup's
>    swap limit is causing high rates of THP splitting during swapout.

I agree, but it's probably better to reflect it in a form of a per-memcg
thp split failure counter (e.g. in memory.stat), not as swap out failures.
Overall option a) looks preferable to me. Especially if in the long run
the arm64 limitation will be fixed.

> 
> b) Only count cgroup swap events when they are actually due to a
>    cgroup's own limit. Exclude failures that are due to physical swap
>    shortage or other system-level conditions (like !THP_SWAP). Also
>    count them at the level where the limit is configured, which may be
>    above the local cgroup that holds the page-to-be-swapped.
> 
>    This is in line with how memory.swap.high, memory.high and
>    memory.max events are counted.
> 
>    However, it's a change in documented behavior.

I'm not sure about this option: I can easily imagine a setup with a
memcg-specific swap space, which would require setting an artificial
memory.swap.max to get the fail counter working. On the other side not a deal
breaker.

Thanks!
