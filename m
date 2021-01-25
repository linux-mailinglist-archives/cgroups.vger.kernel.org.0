Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708B73025FE
	for <lists+cgroups@lfdr.de>; Mon, 25 Jan 2021 15:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbhAYOD0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Jan 2021 09:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbhAYOBO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Jan 2021 09:01:14 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7023AC061574
        for <cgroups@vger.kernel.org>; Mon, 25 Jan 2021 06:00:16 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id by1so18170954ejc.0
        for <cgroups@vger.kernel.org>; Mon, 25 Jan 2021 06:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yqpENXleq5E1oCuiN5/o6zE4Va7QALVP2kUA8G3qGGs=;
        b=dq0PShZkY/NDrKnXPhmakBasO0lwF5zkAQmQUHQHZngpAlpDaW0QCKaMHWfS1x2MRX
         H6yEigZl3XM4wEp3GiUUHQsHG25OgCInjSJ92R+u637SREnILArI5W65YQxMgA2cuR0z
         ngGRnz7cdegpqGNe7XrbaPCunkM70lrkv4NKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yqpENXleq5E1oCuiN5/o6zE4Va7QALVP2kUA8G3qGGs=;
        b=Y5AnfwzTNVvABsiA5vxQ3AHyNde1A4eWu5ylElTUsOUBYG8DzNEejKIay9ocy7uh1Q
         HtIMSyDZ9vwxB8uA4pmO4Kb4Rgeu5XNxNEr6DHqgB/sA3FbXbQB3NZMX9Xha8swTq+hg
         3f3yWmcrYNcuwy/xlZf5AJdw8f4EPNFaNwaAxRycjT6wHB1lQNnL5wHfcgSPLVqTPIex
         y/UfzcWcEuNUEzeRuNuqfnQDlPjIelR5jgIcJozKvtQdFEjv5TSfBf06OkTg/ssueTXI
         9IITGFd/+HFZNHZLlfHsmjHJMt9LllQSj4zV/m3rD6WL+yT/verUb/hpECsVWju65XrJ
         bPAg==
X-Gm-Message-State: AOAM533r5AsvYhox+fP9vYaqHSBmM5vaCDsjIh4zL0tuO5cPm8agJjzb
        cHOEyj9h/1Z1pNj/jI5eDoosTw==
X-Google-Smtp-Source: ABdhPJzZES+L+Kd3IwNeDiMVM0jatuI5AjktdSrGuf4mIqLTdLqC8vouza1440lnY8wsSOCuaxVo1Q==
X-Received: by 2002:a17:906:af41:: with SMTP id ly1mr411223ejb.491.1611583215092;
        Mon, 25 Jan 2021 06:00:15 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:36f8])
        by smtp.gmail.com with ESMTPSA id m5sm8346994eja.11.2021.01.25.06.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 06:00:14 -0800 (PST)
Date:   Mon, 25 Jan 2021 14:00:14 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] Revert "mm: memcontrol: avoid workload stalls when
 lowering memory.high"
Message-ID: <YA7O7k5LpzgmqWKo@chrisdown.name>
References: <20210122184341.292461-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210122184341.292461-1-hannes@cmpxchg.org>
User-Agent: Mutt/2.0.4 (26f41dd1) (2020-12-30)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Johannes Weiner writes:
>This reverts commit 536d3bf261a2fc3b05b3e91e7eef7383443015cf, as it
>can cause writers to memory.high to get stuck in the kernel forever,
>performing page reclaim and consuming excessive amounts of CPU cycles.
>
>Before the patch, a write to memory.high would first put the new limit
>in place for the workload, and then reclaim the requested delta. After
>the patch, the kernel tries to reclaim the delta before putting the
>new limit into place, in order to not overwhelm the workload with a
>sudden, large excess over the limit. However, if reclaim is actively
>racing with new allocations from the uncurbed workload, it can keep
>the write() working inside the kernel indefinitely.
>
>This is causing problems in Facebook production. A privileged
>system-level daemon that adjusts memory.high for various workloads
>running on a host can get unexpectedly stuck in the kernel and
>essentially turn into a sort of involuntary kswapd for one of the
>workloads. We've observed that daemon busy-spin in a write() for
>minutes at a time, neglecting its other duties on the system, and
>expending privileged system resources on behalf of a workload.
>
>To remedy this, we have first considered changing the reclaim logic to
>break out after a couple of loops - whether the workload has converged
>to the new limit or not - and bound the write() call this way.
>However, the root cause that inspired the sequence change in the first
>place has been fixed through other means, and so a revert back to the
>proven limit-setting sequence, also used by memory.max, is preferable.
>
>The sequence was changed to avoid extreme latencies in the workload
>when the limit was lowered: the sudden, large excess created by the
>limit lowering would erroneously trigger the penalty sleeping code
>that is meant to throttle excessive growth from below. Allocating
>threads could end up sleeping long after the write() had already
>reclaimed the delta for which they were being punished.
>
>However, erroneous throttling also caused problems in other scenarios
>at around the same time. This resulted in commit b3ff92916af3 ("mm,
>memcg: reclaim more aggressively before high allocator throttling"),
>included in the same release as the offending commit. When allocating
>threads now encounter large excess caused by a racing write() to
>memory.high, instead of entering punitive sleeps, they will simply be
>tasked with helping reclaim down the excess, and will be held no
>longer than it takes to accomplish that. This is in line with regular
>limit enforcement - i.e. if the workload allocates up against or over
>an otherwise unchanged limit from below.
>
>With the patch breaking userspace, and the root cause addressed by
>other means already, revert it again.
>
>Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
>Cc: <stable@vger.kernel.org> # 5.8+
>Reported-by: Tejun Heo <tj@kernel.org>
>Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Chris Down <chris@chrisdown.name>
