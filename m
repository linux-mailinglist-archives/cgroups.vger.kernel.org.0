Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC17228023D
	for <lists+cgroups@lfdr.de>; Thu,  1 Oct 2020 17:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbgJAPMn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Oct 2020 11:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732449AbgJAPMm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Oct 2020 11:12:42 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD21C0613D0
        for <cgroups@vger.kernel.org>; Thu,  1 Oct 2020 08:12:42 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cv8so3117790qvb.12
        for <cgroups@vger.kernel.org>; Thu, 01 Oct 2020 08:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OmZIxJBtx1NXXlnYK2+JLM28lEpk+Yfzhaq84vx6//8=;
        b=Vj+V9qtl+81/Vm8czipooCdTsZG1TfHRMTHRHlCJ7amFumfHSRkbnTWrfov3dMDsfh
         RXnAz+L7IhzewaiQ7iw2v8tuqbtuLnyt85yRcn19yc9eo5kh/MLbYLXSvbHMkULt2g2p
         nuj1Lepdlz0GpJAFmMuMGFfId9X4Y37T3rnX711ANm/Gn1s+5r9SFISanfZn0V7gW1Ua
         TyNNCg2TxtxqgXXOUmAnlBuKiiE+15lSgVsFdvV5Ki/vKcttzWFH+vsDkVjkZLHO+BuF
         jVgYygCuSQKRO3B9S6nCTZ9sX4US25qd8ogXHNnWGfzdLefhkPryYxyHH8AerZil7HW1
         xaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OmZIxJBtx1NXXlnYK2+JLM28lEpk+Yfzhaq84vx6//8=;
        b=r2/amciTvIFJfrnlzMWaua2dYrVZBR6EimTw0Wpu7+yU9Oa6JXYJOjkzCCq0dXQ80u
         WLfk3wXFTuR//eV2lhftg2A4mDzsZcRGIro23P9AFPx/LDwBbVTBgDompNhzBBtFbZnv
         e/2CVANvkUCjUQkTOJbrb68b+boSPHu/zAx6iB1ApmvqHCEoeBygF1zpBXBJ1ZOlGp+9
         FEAH9JzDHLhvSOs6Iy7cEpeC9mIwDuky7Ml+x+1R8JEqhlD1EMQwIrDMNBsbpegTChDw
         rwHCQL2psEYLgIB0X7wfXkdpE9XcZMDW48W2dN79oNYIbwt8SEWwus/MvEC1pwHYnxQk
         KWDw==
X-Gm-Message-State: AOAM532YnNgDixIOoPIFVdxjs6/6Oc5UqLny3x7212fVa1Q04lRguoBI
        yIgpyqwn9kU5GfoE1+kN3JSBqg==
X-Google-Smtp-Source: ABdhPJxK5hGBfMwYhMoKSsAt9SveYTZd9IEYhGGZ3l45Ewb8hQDlF8SXdIgvLEAasF703tcWdrkPrA==
X-Received: by 2002:a05:6214:222:: with SMTP id j2mr8475271qvt.32.1601565161486;
        Thu, 01 Oct 2020 08:12:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4e22])
        by smtp.gmail.com with ESMTPSA id v8sm6939889qkb.23.2020.10.01.08.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 08:12:38 -0700 (PDT)
Date:   Thu, 1 Oct 2020 11:10:58 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: introduce per-memcg reclaim interface
Message-ID: <20201001151058.GB493631@cmpxchg.org>
References: <20200909215752.1725525-1-shakeelb@google.com>
 <20200928210216.GA378894@cmpxchg.org>
 <CALvZod7afgoAL7KyfjpP-LoSFGSHv7XtfbbnVhEEhsiZLqZu9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7afgoAL7KyfjpP-LoSFGSHv7XtfbbnVhEEhsiZLqZu9A@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Shakeel,

On Wed, Sep 30, 2020 at 08:26:26AM -0700, Shakeel Butt wrote:
> On Mon, Sep 28, 2020 at 2:03 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > Workloads may not
> > allocate anything for hours, and then suddenly allocate gigabytes
> > within seconds. A sudden onset of streaming reads through the
> > filesystem could destroy the workingset measurements, whereas a limit
> > would catch it and do drop-behind (and thus workingset sampling) at
> > the exact rate of allocations.
> >
> > Again I believe something that may be doable as a hyperscale operator,
> > but likely too fragile to get wider applications beyond that.
> >
> > My take is that a proactive reclaim feature, whose goal is never to
> > thrash or punish but to keep the LRUs warm and the workingset trimmed,
> > would ideally have:
> >
> > - a pressure or size target specified by userspace but with
> >   enforcement driven inside the kernel from the allocation path
> >
> > - the enforcement work NOT be done synchronously by the workload
> >   (something I'd argue we want for *all* memory limits)
> >
> > - the enforcement work ACCOUNTED to the cgroup, though, since it's the
> >   cgroup's memory allocations causing the work (again something I'd
> >   argue we want in general)
> 
> For this point I think we want more flexibility to control the
> resources we want to dedicate for proactive reclaim. One particular
> example from our production is the batch jobs with high memory
> footprint. These jobs don't have enough CPU quota but we do want to
> proactively reclaim from them. We would prefer to dedicate some amount
> of CPU to proactively reclaim from them independent of their own CPU
> quota.

Would it not work to add headroom for this reclaim overhead to the CPU
quota of the job?

The reason I'm asking is because reclaim is only one side of the
proactive reclaim medal. The other side is taking faults and having to
do IO and/or decompression (zswap, compressed btrfs) on the workload
side. And that part is unavoidably consuming CPU and IO quota of the
workload. So I wonder how much this can generally be separated out.

It's certainly something we've been thinking about as well. Currently,
because we use memory.high, we have all the reclaim work being done by
a privileged daemon outside the cgroup, and the workload pressure only
stems from the refault side.

But that means a workload is consuming privileged CPU cycles, and the
amount varies depending on the memory access patterns - how many
rotations the reclaim scanner is doing etc.

So I do wonder whether this "cost of business" of running a workload
with a certain memory footprint should be accounted to the workload
itself. Because at the end of the day, the CPU you have available will
dictate how much memory you need, and both of these axes affect how
you can schedule this job in a shared compute pool. Do neighboring
jobs on the same host leave you either the memory for your colder
pages, or the CPU (and IO) to trim them off?

For illustration, compare extreme examples of this.

	A) A workload that has its executable/libraries and a fixed
	   set of hot heap pages. Proactive reclaim will be relatively
	   slow and cheap - a couple of deactivations/rotations.

	B) A workload that does high-speed streaming IO and generates
	   a lot of drop-behind cache; or a workload that has a huge
	   virtual anon set with lots of allocations and MADV_FREEing
	   going on. Proactive reclaim will be fast and expensive.

Even at the same memory target size, these two types of jobs have very
different requirements toward the host environment they can run on.

It seems to me that this is cost that should be captured in the job's
overall resource footprint.
