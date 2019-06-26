Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E967A5741D
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 00:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFZWKb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 18:10:31 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:35417 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFZWKa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 18:10:30 -0400
Received: by mail-io1-f49.google.com with SMTP id m24so295786ioo.2
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 15:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rH2Dez6ibqeQegsSHJwCDNyF4HevqK6rJDhBC1vQRG4=;
        b=yyWseDrs1tj8p1o6MQ872kjOA3UQ9CVqeYBmzwveWs+QXL8fcZ+guUO9UdPac/xfHj
         gFVMKie1TtQFHdC4tm2WBM2cjHHHn08h2zlPssRFotp/FOHhzpueAl4s1jKCYs2O0yvO
         cSItEv0JI4r+/FqqfoDEb9j8YIQSIZTgpAleo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rH2Dez6ibqeQegsSHJwCDNyF4HevqK6rJDhBC1vQRG4=;
        b=HXyVUn9ZSaPNqCz74xxcFwbVG28izv+vBIG1Q09UVuowFVLrU3ndrNl3SPQ/kQGuAg
         fVDA8CUSPZeD/pmldBod/YV08XgjGuV6iTXACBtNx6yA9U4SKwRNUxUIU/7n95Ymub6U
         1zu20Z+lJttz+01SuaUhlNWwW/I2UoM2auyxZNRkbP2GYGJv8KV7AF2PvcIqYPO+WMNz
         B3DhYUGqCsk9O9LowEnn2cH4+ekMiTS/ByfODMlCHgkN/gASMZfvAkWjGi/TR/ffkAki
         sWj6gXwkjvJLFhul9ESRMdp+9RLJ5CaXcFgWP//GuAC8/n0VKMzs8qDRBY1+fcodznUn
         sRBw==
X-Gm-Message-State: APjAAAUSTyXUVtT8KK32RHCdM+Fpnb3qNfe/QfaJuexLRIK7GRCEYKoE
        5Se1Gzx37kSG+uVxRimW7I5HpyuyPVe9Y3GWaDvqjA==
X-Google-Smtp-Source: APXvYqyVRtUZY5KCSRc4HzJsiZQqcfxNVTUbuzMgIOhL99PiWQ4QhxidNwMHFyN508po+8Dlvcc9k4YWfRA5t8uxDNM=
X-Received: by 2002:a6b:2bcd:: with SMTP id r196mr567888ior.73.1561587029777;
 Wed, 26 Jun 2019 15:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
 <1561391404-14450-1-git-send-email-chiluk+linux@indeed.com>
 <1561391404-14450-2-git-send-email-chiluk+linux@indeed.com> <xm26tvcex50s.fsf@bsegall-linux.svl.corp.google.com>
In-Reply-To: <xm26tvcex50s.fsf@bsegall-linux.svl.corp.google.com>
From:   Dave Chiluk <chiluk+linux@indeed.com>
Date:   Wed, 26 Jun 2019 17:10:04 -0500
Message-ID: <CAC=E7cUxcNkc7T7AXCr3PO6rqqxrk269JW3SDnXG-LtO-6-BVQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] sched/fair: Return all runtime when cfs_b has very
 little remaining.
To:     Ben Segall <bsegall@google.com>
Cc:     Phil Auld <pauld@redhat.com>, Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jun 24, 2019 at 10:33:07AM -0700, bsegall@google.com wrote:
> This still has a similar cost as reducing min_cfs_rq_runtime to 0 - we
> now take a tg-global lock on every group se dequeue. Setting min=0 means
> that we have to take it on both enqueue and dequeue, while baseline
> means we take it once per min_cfs_rq_runtime in the worst case.
Yep, it's only slightly better than simply setting min_cfs_rq_runtime=0.
There's definitely a tradeoff of having to grab the lock every time.

The other non-obvious benefit to this is that when the application
starts hitting throttling the entire application starts hitting
throttling closer to simultaneously.  Previously, threads that don't do
much could continue sipping on their 1ms of min_cfs_rq_runtime, while
main threads were throttled.  With this the application would more or
less halt within 5ms of full quota usage.

> In addition how much this helps is very dependent on the exact pattern
> of sleep/wake - you can still strand all but 15ms of runtime with a
> pretty reasonable pattern.

I thought this change would have an upper bound stranded time of:
NUMCPUs * min_cfs_rq_runtime - 3 * sched_cfs_bandwidth_slice().
From the stranding of 1ms on each queue minues the amount that we'd
return when we forcibly hit the 3 x bandwidth slice Am I missing
something here? Additionally that's worst case, and would require that
threads be scheduled on distinct cpus mostly sequentially, and then
never run again.

> If the cost of taking this global lock across all cpus without a
> ratelimit was somehow not a problem, I'd much prefer to just set
> min_cfs_rq_runtime = 0. (Assuming it is, I definitely prefer the "lie
> and sorta have 2x period 2x runtime" solution of removing expiration)

Can I take this as an technical ack of the v3 patchset?  Do you have any
other comments for that patchset you'd like to see corrected before it
gets integrated?  If you are indeed good with that patchset, I'll clean
up the comment and Documentation text and re-submit as a v5 patchset. I

actually like that patchset best as well, for all the reasons already
discussed.  Especially the one where it's been running like this for 5
years prior to 512ac999.

Also given my new-found understanding of min_cfs_rq_runtime, doesn't
this mean that if we don't expire runtime we could potentially have a
worst case of 1ms * NUMCPUs of extra runtime instead of 2x runtime?
This is because min_cfs_rq_runtime could theoretically live on a per-cpu
indefinitely?  Still this is actually much smaller than I previously had
feared.  Also it still holds that average runtime is still bounded by
runtime/period on average.

Thanks
