Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91B345F24A
	for <lists+cgroups@lfdr.de>; Fri, 26 Nov 2021 17:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353070AbhKZQnO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Nov 2021 11:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352635AbhKZQlL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Nov 2021 11:41:11 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B647EC06139C;
        Fri, 26 Nov 2021 08:26:26 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so8369798pjb.4;
        Fri, 26 Nov 2021 08:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q/HRGw2r5wG7sszT9Fb1vk0NIxwkVXLQR9pjE/nA1Tc=;
        b=hZXEtwgIgWBHlarUnLTfnMEddvX1ZvCgyKfbW91zU5qVw4BWPEk6h2BeN9eKocOl/5
         iG1H9wm6oQQbaTqDQpw1p+zMdg1suCwqLCY/vnG5DYCGq6ZzwyVFZvB2Bs4p61bvyAwE
         Hryp4nPZZV2AKt6xkJYPE0MnXv87asXXdQcdf9Kz/oQwrAgC/gMe4/YUVxiWY7Rd67qf
         g04fTUHIM77oZ4dZa0Z8QqUGqBo/wihmAFXnw0+Hz4Ub/GHawVCN/6vuyEqlZP8rKY9V
         pM9enbAwzLwDrbZyd8qpj7L3ye4okDSJ6kEgPAuyvqe1bDdJJmGxnE8Sv6J2ee4aHrOc
         rzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q/HRGw2r5wG7sszT9Fb1vk0NIxwkVXLQR9pjE/nA1Tc=;
        b=X0Nlfb2SMDhIuM06vCoONnQJTVuYshsjnCV2NIktqWN90ZJViLvMhGeoiYARJaXYga
         0WXlj8F0aQKq9ULw1PELkMjBhZxinyTvux0cf+erc3t7aGPKnrUNuFsUUnxgh11qCSH5
         tJDz76PhFFdS53jWsGnKSV4uef+2W+Y4ZAvaDVPJKsgpUk2tySGpJ5So0RipXcW5qh8W
         mBii+zi8j4v8PK0l2sGVVfINgHyk0x6nNOFYcsyQuxEEdd3N/cNvB2a3CcH6mdC48jAU
         KSeTNXcXu7nm6U+bBQ0W7E72kd+fPVghvsiaZBnS7G5zmmJKffnPVkJnAloOZ0NUYRjG
         0ufg==
X-Gm-Message-State: AOAM532x04Jq+dp12hwtpzApOLbbXYvZP2WcfA54+4NC9S6YX2MUqysc
        HpVjSx3GYj+DNxG/lUxg4lk=
X-Google-Smtp-Source: ABdhPJwKTFwC5iHnm/7QHrutv643MnseHPiTXxhG5z3/B6Sy5xf47ltm167TKmFsuvjEvKgR7sSn3g==
X-Received: by 2002:a17:90b:4a05:: with SMTP id kk5mr16792155pjb.232.1637943986231;
        Fri, 26 Nov 2021 08:26:26 -0800 (PST)
Received: from haolee.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id kk7sm12001805pjb.19.2021.11.26.08.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 08:26:25 -0800 (PST)
Date:   Fri, 26 Nov 2021 16:26:23 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>, vdavydov.dev@gmail.com,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: reduce spinlock contention in release_pages()
Message-ID: <20211126162623.GA10277@haolee.io>
References: <20211124151915.GA6163@haolee.io>
 <YZ5o/VmU59evp65J@dhcp22.suse.cz>
 <CA+PpKPmy-u_BxYMCQOFyz78t2+3uM6nR9mQeX+MPyH6H2tOOHA@mail.gmail.com>
 <YZ8DZHERun6Fej2P@casper.infradead.org>
 <20211125080238.GA7356@haolee.io>
 <YZ9e3pzHKmn5nev0@dhcp22.suse.cz>
 <20211125123133.GA7758@haolee.io>
 <YZ+bI1fNpKar0bSU@dhcp22.suse.cz>
 <CA+PpKP=hsuBmvv09OcD2Nct8B8Cqa03UfKFHAHzKxwE0SXGP4g@mail.gmail.com>
 <YaC7BcTSijFj+bxR@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaC7BcTSijFj+bxR@dhcp22.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 26, 2021 at 11:46:29AM +0100, Michal Hocko wrote:
> On Fri 26-11-21 14:50:44, Hao Lee wrote:
> > On Thu, Nov 25, 2021 at 10:18 PM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > Could you share more about requirements for those? Why is unmapping in
> > > any of their hot paths which really require low latencies? Because as
> > > long as unmapping requires a shared resource - like lru lock - then you
> > > have a bottle necks.
> > 
> > We deploy best-effort (BE) jobs (e.g. bigdata, machine learning) and
> > latency-critical (LC) jobs (e.g. map navigation, payments services) on the
> > same servers to improve resource utilization. The running time of BE jobs are
> > very short, but its memory consumption is large, and these jobs will run
> > periodically. The LC jobs are long-run services and are sensitive to delays
> > because jitters may cause customer churn.
> 
> Have you tried to isolate those workloads by memory cgroups? That could
> help for lru lock at least.

Sure. LC and BE jobs are in different memory cgroups (containers). memcg
indeed avoids lru contentions between LC and BE, although it can't reduce
contentions between jobs in the same cgroup. BE jobs' memory contentions
could cause cpu jitters and then interfere LC jobs.

> You are likely going to hit other locks on
> the way though. E.g. zone lock in the page allocator but that might be
> less problematic in the end.

Yes, but we haven't encountered lock contentions in the allocation path for
now. Maybe this is because the memory allocations of BE jobs are still
gradual and are not clustered into a very short time period.

> If you isolate your long running services
> to a different NUMA node then you can get even less interaction.

Agree.

> 
> > If a batch of BE jobs are finished simultaneously, lots of memory are freed,
> > and spinlock contentions happen. BE jobs don't care about these contentions,
> > but contentions cause them to spend more time in kernel mode, and thus, LC
> > jobs running on the same cpu cores will be delayed and jitters occur. (The
> > kernel preemption is disabled on our servers, and we try not to separate
> > LC/BE using cpuset in order to achieve "complete mixture deployment"). Then
> > LC services people will complain about the poor service stability. This
> > scenario has occurred several times, so we want to find a way to avoid it.
> 
> It will be hard and a constant fight to get reasonably low latencies on
> a non preemptible kernel. It would likely be better to partition CPUs
> between latency sensitive and BE jobs. I can see how that might not be
> really practical but especially with non-preemptible kernels you have a
> large space for priority inversions that is hard to forsee or contain.

Agree. It's really hard. Maybe we will eventually use cpuset to separate LC
and BE if we can't find a better way to mix them on the same set of cpus.

I will try Matthew's idea to use semaphore or mutex to limit the number of BE
jobs that are in the exiting path. This sounds like a feasible approach for
our scenario...

Thanks

> -- 
> Michal Hocko
> SUSE Labs
