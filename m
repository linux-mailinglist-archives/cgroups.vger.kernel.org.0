Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05DD21D928
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2020 16:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgGMOvJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jul 2020 10:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730350AbgGMOvF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jul 2020 10:51:05 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8214DC061755
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2020 07:51:05 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id s16so9194839lfp.12
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2020 07:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUKZlCYinai0Luu2hOdm2qnhIZ2lqYBnLnpnyrbTn3I=;
        b=qu2t9/SUqzkLaYFEwlQpODBK/nnlgLwz7l2VJYTrR/DC+v3zsZaCKn56tElzWPtcHn
         /Q0rjazMjk+yHC1rwE1i8nQL9hhJXzlcyXtEAtlmk9i3HxETJsnHiDlivYKSIbc56wK/
         8vm0kqjPm0gBZH2MdJQMaQ5byy/UHj4ypCn6Iu2V1CFGE83BYFlgkmJS557gdfQUsRz3
         YCMy6tBmB+wtWOtLsa5DPlxcueem/ZeE7vP6YDeQQ//bYUkOA57A027j5wKUEAQ6LZem
         gCLVAA+bEN8QBxtkQksQwh1Z7ionO2BfUakJra1klkKve+16G5WCJ3i2xVXyCdXj5tKF
         OcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUKZlCYinai0Luu2hOdm2qnhIZ2lqYBnLnpnyrbTn3I=;
        b=RXf8f6Fyskz0QY+CxadSgnA6p6hTdWKxCgvSGi1wu+Pmm3xKmMd9bf1Esh/GxPJgzB
         sZpXqsQQQpR0sfSTVTxgcs5yNdyjPRj505NWMQIhPI/BJggudvkQ4/1UlqPO8yqINR0s
         pTbHpejDlknJ7nyTN0D/DD+oTa9SE6g3aYePZgdcBUinQ2XuYy/vwkhAjb7yQ49IRkF1
         SSo9WuxnLZVPzslAVgKwTi8VFPFMRoeFp13G/ySOIsf7a4Ai5ER2HU2nxkuZHnEkNk7A
         zsAwl+b/kNvL3+eLTALW8EL4wIx00/zvokX/+fp32/JAdaQtIs/7o8wbdDdGQ/NHg/Nu
         /+4g==
X-Gm-Message-State: AOAM531xC7sWO0UdOT8/tsMTNKK2+OiLOwrSGgOjqjEy8uGuxKf59K2v
        Izkj5GlLxYDxZvjmfFORUe9021uqThIcFOPCtJ2CnQ==
X-Google-Smtp-Source: ABdhPJwNsAK/CvIXssjQkfKmEI8SIz4CvARlnMPg9iz3ip4AYuZHOz+ZuUOX/MXzLaMOcYrwbWlCf5fUMZQ0vnAJXFI=
X-Received: by 2002:a19:e61a:: with SMTP id d26mr47379303lfh.96.1594651862566;
 Mon, 13 Jul 2020 07:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594640214.git.chris@chrisdown.name> <a4e23b59e9ef499b575ae73a8120ee089b7d3373.1594640214.git.chris@chrisdown.name>
In-Reply-To: <a4e23b59e9ef499b575ae73a8120ee089b7d3373.1594640214.git.chris@chrisdown.name>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 13 Jul 2020 07:50:51 -0700
Message-ID: <CALvZod5BKXs52A2R-d=aOsjB7idBejsMDgQUKc1H_6y=PuBsew@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm, memcg: reclaim more aggressively before high
 allocator throttling
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 13, 2020 at 4:42 AM Chris Down <chris@chrisdown.name> wrote:
>
> In Facebook production, we've seen cases where cgroups have been put
> into allocator throttling even when they appear to have a lot of slack
> file caches which should be trivially reclaimable.
>
> Looking more closely, the problem is that we only try a single cgroup
> reclaim walk for each return to usermode before calculating whether or
> not we should throttle. This single attempt doesn't produce enough
> pressure to shrink for cgroups with a rapidly growing amount of file
> caches prior to entering allocator throttling.
>
> As an example, we see that threads in an affected cgroup are stuck in
> allocator throttling:
>
>     # for i in $(cat cgroup.threads); do
>     >     grep over_high "/proc/$i/stack"
>     > done
>     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
>     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
>     [<0>] mem_cgroup_handle_over_high+0x10b/0x150
>
> ...however, there is no I/O pressure reported by PSI, despite a lot of
> slack file pages:
>
>     # cat memory.pressure
>     some avg10=78.50 avg60=84.99 avg300=84.53 total=5702440903
>     full avg10=78.50 avg60=84.99 avg300=84.53 total=5702116959
>     # cat io.pressure
>     some avg10=0.00 avg60=0.00 avg300=0.00 total=78051391
>     full avg10=0.00 avg60=0.00 avg300=0.00 total=78049640
>     # grep _file memory.stat
>     inactive_file 1370939392
>     active_file 661635072
>
> This patch changes the behaviour to retry reclaim either until the
> current task goes below the 10ms grace period, or we are making no
> reclaim progress at all. In the latter case, we enter reclaim throttling
> as before.
>
> To a user, there's no intuitive reason for the reclaim behaviour to
> differ from hitting memory.high as part of a new allocation, as opposed
> to hitting memory.high because someone lowered its value. As such this
> also brings an added benefit: it unifies the reclaim behaviour between
> the two.
>
> There's precedent for this behaviour: we already do reclaim retries when
> writing to memory.{high,max}, in max reclaim, and in the page allocator
> itself.
>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Michal Hocko <mhocko@kernel.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
