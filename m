Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2022027DB2D
	for <lists+cgroups@lfdr.de>; Tue, 29 Sep 2020 23:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgI2VzU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Sep 2020 17:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgI2VzT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Sep 2020 17:55:19 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAE9C061755
        for <cgroups@vger.kernel.org>; Tue, 29 Sep 2020 14:55:19 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z2so4960287qtv.12
        for <cgroups@vger.kernel.org>; Tue, 29 Sep 2020 14:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FOJfgf8q5Mwbkl+Uuxbz5zw63i2IkJ9zeF69lh8BTRA=;
        b=Cr1SusruU/siOv5odz2uDawXx3M2StkgpuCnAfnW6HeoN6hGhWlHDj0Yuw8UVH1Sw8
         1GksVWMUs9+v3GTJ+CdJFW7c3cyp9UT0YgqAsJVVL0EFAJKzQmQAKEDlrRRseCqcWspc
         tQN6sxfbzuOQHvS72lZipUN50ZmCvCRqvFbqadYvW4fF7O0sOZb56yY7FSTYeK2R+svl
         EuS9bScs+RhmVHwEn5TpHkQkoddIsO9ZvR063nCXbeiJCp5UNoEce3QhpuikWgitu7y3
         rxtpIYYrTAr9jd80q3mlD0gy05vvCC3Kst+DbBLaWhazqWQ6J9IOpCLDpzzRY+clkJMN
         FXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FOJfgf8q5Mwbkl+Uuxbz5zw63i2IkJ9zeF69lh8BTRA=;
        b=hieHCehVHSOkI+PDaUzsx2bv4a+u94HQCl1jT5BePPP8HjfsfVvJLQ904wjzwFywT9
         Kww0Q4Rrposb/49r8Q0Xn6dD/Rti2cTaIIs6W9Bglx1caTYSx0UEzH1DXewf9o/bdIxb
         +sIT63m++cKC5RBnZ3qrj6TiKHJqUjFxehjwdMKzQ4UwV4U4qf17KUfIzidZltXo7j6Q
         Gq056f8HxZKdb6ozgYs7c9gRuWPC3XixkaJhVMfE71/WWP2ao2nKhEC0VJGaF2t29S1S
         uRMp8LnBYD6l2zNVKdMjBK+/AGtOadU7nxnBj8tgrDYvUMTHGH0SXLKsAB4GXjc4zWvV
         /oQA==
X-Gm-Message-State: AOAM532WdlLXPPnB3/SwLvaR9WBP4/FjLAYKqIGAwzbyyPWl1I0jUUZb
        JaYCGyqKBLOjDMbtLXy7a45+eUDS0M0XEg==
X-Google-Smtp-Source: ABdhPJwKGFeVgwB0gbtRklGSlDPFPgsa3kFrhW/iSBjxukmvBrKrS1f46rvLyJlf0T+z98s/QAXaGg==
X-Received: by 2002:ac8:6f0d:: with SMTP id g13mr5777438qtv.236.1601416518820;
        Tue, 29 Sep 2020 14:55:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4e22])
        by smtp.gmail.com with ESMTPSA id p187sm6516443qkd.129.2020.09.29.14.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 14:55:17 -0700 (PDT)
Date:   Tue, 29 Sep 2020 17:53:41 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>, Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: introduce per-memcg reclaim interface
Message-ID: <20200929215341.GA408059@cmpxchg.org>
References: <20200909215752.1725525-1-shakeelb@google.com>
 <20200928210216.GA378894@cmpxchg.org>
 <20200929150444.GG2277@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929150444.GG2277@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 29, 2020 at 05:04:44PM +0200, Michal Hocko wrote:
> On Mon 28-09-20 17:02:16, Johannes Weiner wrote:
> [...]
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
> > 
> > - a delegatable knob that is independent of setting the maximum size
> >   of a container, as that expresses a different type of policy
> > 
> > - if size target, self-limiting (ha) enforcement on a pressure
> >   threshold or stop enforcement when the userspace component dies
> > 
> > Thoughts?
> 
> Agreed with above points. What do you think about
> http://lkml.kernel.org/r/20200922190859.GH12990@dhcp22.suse.cz.

I definitely agree with what you wrote in this email for background
reclaim. Indeed, your description sounds like what I proposed in
https://lore.kernel.org/linux-mm/20200219181219.54356-1-hannes@cmpxchg.org/
- what's missing from that patch is proper work attribution.

> I assume that you do not want to override memory.high to implement
> this because that tends to be tricky from the configuration POV as
> you mentioned above. But a new limit (memory.middle for a lack of a
> better name) to define the background reclaim sounds like a good fit
> with above points.

I can see that with a new memory.middle you could kind of sort of do
both - background reclaim and proactive reclaim.

That said, I do see advantages in keeping them separate:

1. Background reclaim is essentially an allocation optimization that
   we may want to provide per default, just like kswapd.

   Kswapd is tweakable of course, but I think actually few users do,
   and it works pretty well out of the box. It would be nice to
   provide the same thing on a per-cgroup basis per default and not
   ask users to make decisions that we are generally better at making.

2. Proactive reclaim may actually be better configured through a
   pressure threshold rather than a size target.

   As per above, the goal is not to be punitive or containing. The
   goal is to keep the LRUs warm and move the colder pages to disk.

   But how aggressively do you run reclaim for this purpose? What
   target value should a user write to such a memory.middle file?

   For one, it depends on the job. A batch job, or a less important
   background job, may tolerate higher paging overhead than an
   interactive job. That means more of its pages could be trimmed from
   RAM and reloaded on-demand from disk.

   But also, it depends on the storage device. If you move a workload
   from a machine with a slow disk to a machine with a fast disk, you
   can page more data in the same amount of time. That means while
   your workload tolerances stays the same, the faster the disk, the
   more aggressively you can do reclaim and offload memory.

   So again, what should a user write to such a control file?

   Of course, you can approximate an optimal target size for the
   workload. You can run a manual workingset analysis with page_idle,
   damon, or similar, determine a hot/cold cutoff based on what you
   know about the storage characteristics, then echo a number of pages
   or a size target into a cgroup file and let kernel do the reclaim
   accordingly. The drawbacks are that the kernel LRU may do a
   different hot/cold classification than you did and evict the wrong
   pages, the storage device latencies may vary based on overall IO
   pattern, and two equally warm pages may have very different paging
   overhead depending on whether readahead can avert a major fault or
   not. So it's easy to overshoot the tolerance target and disrupt the
   workload, or undershoot and have stale LRU data, waste memory etc.

   You can also do a feedback loop, where you guess an optimal size,
   then adjust based on how much paging overhead the workload is
   experiencing, i.e. memory pressure. The drawbacks are that you have
   to monitor pressure closely and react quickly when the workload is
   expanding, as it can be potentially sensitive to latencies in the
   usec range. This can be tricky to do from userspace.

   So instead of asking users for a target size whose suitability
   heavily depends on the kernel's LRU implementation, the readahead
   code, the IO device's capability and general load, why not directly
   ask the user for a pressure level that the workload is comfortable
   with and which captures all of the above factors implicitly? Then
   let the kernel do this feedback loop from a per-cgroup worker.
