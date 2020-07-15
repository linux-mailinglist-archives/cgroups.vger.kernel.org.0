Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39482213E0
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2020 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgGOSCT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Jul 2020 14:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGOSCT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Jul 2020 14:02:19 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CC3C061755
        for <cgroups@vger.kernel.org>; Wed, 15 Jul 2020 11:02:19 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t6so3462194pgq.1
        for <cgroups@vger.kernel.org>; Wed, 15 Jul 2020 11:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=efkhNeEkLOjfJ9I4e0oRt4e4kTv057I//aIthLXwk+4=;
        b=gfYBzPAL5ljuHa5xHEF//P+SpxTqUqYICl87X3M+8snDxzuNN9aNHL2JwlDa8QPeCK
         Ogydr3EugZ+CCERspKV6dYgfysjjwX9w72PQ8VYS2U/Dol+KxYhX1qymB7AcnHDVD8xD
         43eITafEnVz7eN/Ej2/L8OQ74EAAy9X/rfVVJxx/w1iM+l8giQoXC5I4Eg2rS1p+N5Il
         obK4wMmLdQKGMsQuFCbNxh2sdoe1wKBGkJEZbwCZeJ4irgU9ho8kKjOBkMUgnL5mJsvP
         ASilybwNDWe9LASB+l0P6EGaR+7VGo/BslBAs5gMd3mqwlAl2Qm6/55pf8Z/kPUV581L
         TJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=efkhNeEkLOjfJ9I4e0oRt4e4kTv057I//aIthLXwk+4=;
        b=MVJPivBd5Twu/O342lC3EQ4HbjSdKf1p7Ue4XiBMZP6vga9NMCIQDNObkzRoSEb7iR
         xm0qQSmtI8RFNH7N91YTji2sYTyy/5wsbNCnrFLNk34gcSjRrhJx/6fKuDw/EWk3Mhva
         C0PAaLZtSl4DC1hE7CxURCsuGCN7ytGqHZxq0z9zne0ZL6fv4B6xejgu/qb6zm6r5dqL
         WD/UKSPr2PLFJ4k0l9JBCRZgWeWn5bknhh6B+TUd6gre9Yv9nJj6j5wjyGeM3B66EhFz
         aonqOWD/n2XNzHJacPB0naq2DOfJtWx2Rx4UUYcY8bj+9audbh2o+suhZMNxRS2zjT6K
         rp4w==
X-Gm-Message-State: AOAM53337xwXc+OHO5S/XjgKs++7SCnVIiiYgTO7FeImctTOt45qUIn7
        wveR09EChTfmLhgMzqRDq+u3ug==
X-Google-Smtp-Source: ABdhPJytAF8xen60qd4Dv3SqXOOiwLF0dtmhGZRPE0rv+v1xCOSlNw7oB8hMHhluzuRGN6QMKk1tHg==
X-Received: by 2002:a05:6a00:1586:: with SMTP id u6mr366619pfk.147.1594836138429;
        Wed, 15 Jul 2020 11:02:18 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id ci23sm2696236pjb.29.2020.07.15.11.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 11:02:17 -0700 (PDT)
Date:   Wed, 15 Jul 2020 11:02:17 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Chris Down <chris@chrisdown.name>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, memcg: provide a stat to describe reclaimable
 memory
In-Reply-To: <20200715131048.GA176092@chrisdown.name>
Message-ID: <alpine.DEB.2.23.453.2007151046320.2788464@chino.kir.corp.google.com>
References: <alpine.DEB.2.23.453.2007142018150.2667860@chino.kir.corp.google.com> <20200715131048.GA176092@chrisdown.name>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 15 Jul 2020, Chris Down wrote:

> Hi David,
> 
> I'm somewhat against adding more metrics which try to approximate availability
> of memory when we already know it not to generally manifest very well in
> practice, especially since this *is* calculable by userspace (albeit with some
> knowledge of mm internals). Users and applications often vastly overestimate
> the reliability of these metrics, especially since they heavily depend on
> transient page states and whatever reclaim efficacy happens to be achieved at
> the time there is demand.
> 

Hi Chris,

With the proposed anon_reclaimable, do you have any reliability concerns?  
This would be the amount of lazy freeable memory and memory that can be 
uncharged if compound pages from the deferred split queue are split under 
memory pressure.  It seems to be a very precise value (as slab_reclaimable 
already in memory.stat is), so I'm not sure why there is a reliability 
concern.  Maybe you can elaborate?

Today, this information is indeed possible to calculate from userspace.  
The idea is to present this information that will be backwards compatible, 
however, as the kernel implementation changes.  When lazy freeable memory 
was added, for instance, userspace likely would not have preemptively been 
doing an "active_file + inactive_file - file" calculation to factor that 
in as reclaimable anon :)

> What do you intend to do with these metrics and how do you envisage other
> users should use them? Is it not possible to rework the strategy to use
> pressure information and/or workingset pressurisation instead?
> 

Previously, users would interpret their anon usage as non reclaimable if 
swap is disabled and now that value can include a *lot* of easily 
reclaimable memory.  Our users would also carefully monitor their current 
memcg usage and/or anon usage to detect abnormalities without concern for 
what is reclaimable, especially for things like deferred split queues that 
was purely a kernel implementation change.  Memcg usage and anon usag then 
becomes wildly different between kernel versions and our users alert on 
that abnormality.

The example I gave earlier in the thread showed how dramatically different 
memory.current is before and after the introduction of deferred split 
queues.  Userspace sees ballooning memcg usage and alerts on it (suspects 
a memory leak, for example) when in reality this is purely reclaimable 
memory under pressure and is the result of a kernel implementation detail.

We plan on factoring this information in when determining what the actual 
amount of memory that can and cannot be reclaimed from a memcg hierarchy 
at any given time.
