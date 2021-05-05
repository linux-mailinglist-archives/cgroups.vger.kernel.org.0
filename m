Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1BC374B43
	for <lists+cgroups@lfdr.de>; Thu,  6 May 2021 00:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhEEWbp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 18:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhEEWbo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 18:31:44 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515DCC061761
        for <cgroups@vger.kernel.org>; Wed,  5 May 2021 15:30:47 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id q127so3243842qkb.1
        for <cgroups@vger.kernel.org>; Wed, 05 May 2021 15:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SPq92WwUkkbUZi8i20jXBtq5YFPc01M81BIgdGcCXik=;
        b=1XsoNbpEqhTeEDcH7JxyK1q4zEs5Rwp9aoUuhagED0iCyc41POI1c/VVIoc67o9OjE
         a3Jb3Siz5tq48y7cWLCSTOm33rfApdoNOrKkwEdQt0YnzYm9fi3qMnjHZ3BYKCT02QiX
         0VphxMM7zC+tWpB5PSY6bUR2xGMZqvPoif6p5qHIecAcllv23Hk710cDnh+RoL9WJ6eP
         t+IXCXBHlMZdWEcUZsCJCGvilm+OZYcCTYYD44m6NbH0DXuOHl+1cMO9wrTg+OW7f3cW
         hIjacaScsm+ZUwPQ70PCCQD2ycyzWsb2o1ZH9gcOP0dFIhTmI7U4y3yVboLv2Dnp+c23
         16ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SPq92WwUkkbUZi8i20jXBtq5YFPc01M81BIgdGcCXik=;
        b=g6aRN6dugwQYOLh0qM1VDMh4oi+s5D7QuT8bGJC6HeyXeagpUOgRBfzl2brf7GnfGE
         4/TZrHrKtsC7/LTf7oa32qFYzUE6AGXdGJfmP8w+Ul2RsyNK5F31suBlDrbdZ5nvB8/l
         a3wx7rXCulxTevfy9xA5Qb+m4alj9lnPhKNyUV9OqAarZ1gz243AK8h4hho0q0BoGbsO
         P000NQaQAe8g4C0neZhI36IOeS+UCTGX1OBmm78ilIoklJCnboxYK9I87edImuybkJJh
         QoGxWvHAjm68atsvJuKaObbE4fGKgrnJUk4TYNTX2KEEHj67hUCE1nZ9Z5ZSlji0e0K0
         Ivmg==
X-Gm-Message-State: AOAM53367Z8RlYFWJin9xfzJblHDN9oqtpDxsiWwFSo4tUDT9W019y3n
        PsTp5pnrHwsdPFFaHENvXgmsMg==
X-Google-Smtp-Source: ABdhPJw0WA4KlmeJNSng9tMnOiLQgmBjymemgeDCJXg5r1D/Nvlzw9wZF5IVlF2lDIYsU+9hXHXTlA==
X-Received: by 2002:a05:620a:4043:: with SMTP id i3mr1024866qko.380.1620253846537;
        Wed, 05 May 2021 15:30:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:ab71])
        by smtp.gmail.com with ESMTPSA id w7sm515484qtn.91.2021.05.05.15.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 15:30:45 -0700 (PDT)
Date:   Wed, 5 May 2021 18:30:44 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Abel Wu <wuyun.abel@bytedance.com>, akpm@linux-foundation.org,
        lizefan.x@bytedance.com, corbet@lwn.net, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cgroup/cpuset: introduce cpuset.mems.migration
Message-ID: <YJMclPw7OVYxboEE@cmpxchg.org>
References: <20210426065946.40491-1-wuyun.abel@bytedance.com>
 <20210426065946.40491-3-wuyun.abel@bytedance.com>
 <YIgjE6CgU4nDsJiR@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YIgjE6CgU4nDsJiR@slm.duckdns.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 27, 2021 at 10:43:31AM -0400, Tejun Heo wrote:
> Hello,
> 
> On Mon, Apr 26, 2021 at 02:59:45PM +0800, Abel Wu wrote:
> > When a NUMA node is assigned to numa-service, the workload
> > on that node needs to be moved away fast and complete. The
> > main aspects we cared about on the eviction are as follows:
> > 
> > a) it should complete soon enough so that numa-services
> >    won’t wait too long to hurt user experience
> > b) the workloads to be evicted could have massive usage on
> >    memory, and migrating such amount of memory may lead to
> >    a sudden severe performance drop lasting tens of seconds
> >    that some certain workloads may not afford
> > c) the impact of the eviction should be limited within the
> >    source and destination nodes
> > d) cgroup interface is preferred
> > 
> > So we come to a thought that:
> > 
> > 1) fire up numa-services without waiting for memory migration
> > 2) memory migration can be done asynchronously by using spare
> >    memory bandwidth
> > 
> > AutoNUMA seems to be a solution, but its scope is global which
> > violates c&d. And cpuset.memory_migrate performs in a synchronous
> 
> I don't think d) in itself is a valid requirement. How does it violate c)?
> 
> > fashion which breaks a&b. So a mixture of them, the new cgroup2
> > interface cpuset.mems.migration, is introduced.
> > 
> > The new cpuset.mems.migration supports three modes:
> > 
> >  - "none" mode, meaning migration disabled
> >  - "sync" mode, which is exactly the same as the cgroup v1
> >    interface cpuset.memory_migrate
> >  - "lazy" mode, when walking through all the pages, unlike
> >    cpuset.memory_migrate, it only sets pages to protnone,
> >    and numa faults triggered by later touch will handle the
> >    movement.
> 
> cpuset is already involved in NUMA allocation but it always felt like
> something bolted on - it's weird to have cpu to NUMA node settings at global
> level and then to have possibly conflicting direct NUMA configuration via
> cpuset. My preference would be putting as much configuration as possible on
> the mm / autonuma side and let cpuset's node confinements further restrict
> their operations rather than cpuset having its own set of policy
> configurations.
> 
> Johannes, what are your thoughts?

This is basically a cgroup interface for the existing MPOL_MF_LAZY /
MPOL_F_MOF flags, which are per task (set_mempolicy()) and per-vma
(mbind()) scope respectively. They're not per-node, so cannot be
cgroupified through cpuset's node restrictions alone, and I understand
why a cgroup interface could be convenient.

On the other hand, this is not really about configuring a shared
resource. Rather it's using cgroups to set an arbitrary task parameter
on a bunch of tasks simultaneously. It's the SIMD type usecase of
cgroup1 that we tried to get away from in cgroup2, simply because it's
so unbounded in scope. There are *a lot* of possible task parameters,
and we could add a lot of kernel interfaces that boil down to
css_task_iter and setting or clearing a task flag.

So I'm also thinking this cgroup interface isn't desirable.

If you want to control numa policies of tasks from the outside, it's
probably best to extend the numa syscall interface to work on pids.
And then use cgroup.procs to cgroupify the operation from userspace.

Or extend the NUMA interface to make the system-wide default behavior
configurable, so that you can set MPOL_F_MOF in there (without having
to enable autonuma).

But yeah, cgroups doesn't seem like the right place to do this.

Thanks
