Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DED224457
	for <lists+cgroups@lfdr.de>; Fri, 17 Jul 2020 21:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgGQTh7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jul 2020 15:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727999AbgGQTh7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jul 2020 15:37:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBA7C0619D2
        for <cgroups@vger.kernel.org>; Fri, 17 Jul 2020 12:37:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b92so6869036pjc.4
        for <cgroups@vger.kernel.org>; Fri, 17 Jul 2020 12:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=i5w4LeVU5Ef3HXHSWFYKzyIvwNIZHN+Yh+rz6r0uMmY=;
        b=duEtAC7+t+gDLXkZPbHYCT3BTLKqJu7mTT3ioFk2ZD+MEB3lM7+9bNetpIYa7CPYfD
         96OxRjjHkcEh/MOt0HagIqaAhdNz42j9aA3WZvGZjdqK1RJiHEATC6fbBCs8xef+uX2U
         xu6Mw2ITReMWYNcTGExDruskXOLof7vnT+b6jaZhzBSGuLHYATcQ/WSgTdIjfDLoM9Cb
         Vxrl/krLn3ObJ0p3dlhPZjbqrNmFFs5gdk4gUZ4f6+HdpG3OB9qog7iBglnm5DGeSJd0
         IWyMnqREAg+u4di1F0J8guKzQXU4VIzc5AfKlHoHVECH+e2IYItGxaL+HKGqPb0+u9cN
         /kPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=i5w4LeVU5Ef3HXHSWFYKzyIvwNIZHN+Yh+rz6r0uMmY=;
        b=KeW3wpToCtW+iWWrH6yt9Hu6aRutRdmam1KyX+up8JNev4IAQS2ufEXMyxYfI7SwMB
         gWwrxUsqdmxTueE+3Acjxn3lsJsgA8ZHg+JtlS518shSiCihMglt7dck690kqXAWhryR
         EniLeAUL/wKBvyc07QP8wN9YzBoH/u9WVidxslE5qi/lMTs9/fzX9Dgi5nlA4b5NYtvi
         qa1rQCJWgrYl+h0OvP0NLA6iUJXNReaTBF7LMI9iH1XH+qmu0xi90MZf2zzCaUWhttBr
         wJ8L6smkNObHpEeMmepKsZdw5/DNSmEMyiI/WDdnF9suba3BvUOIU7QZ2qjPwCE0AI2N
         gT5w==
X-Gm-Message-State: AOAM530ZfRb9ywyARAx7UsmJLVyJKQtPuHyybn91eitYoiUa1lPGj833
        6GhkfWR4K82jA6o/wqyaJXLblQ==
X-Google-Smtp-Source: ABdhPJz8kGgDsoBytoPjz3NlWfZU+/DAq0lL447bX9flJpreMpFQwHY7bsgHZ7NPxlQ8iTD7IeiOFw==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6mr6323667plb.57.1595014678481;
        Fri, 17 Jul 2020 12:37:58 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id a9sm8661807pfr.103.2020.07.17.12.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 12:37:57 -0700 (PDT)
Date:   Fri, 17 Jul 2020 12:37:57 -0700 (PDT)
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
In-Reply-To: <20200717121750.GA367633@chrisdown.name>
Message-ID: <alpine.DEB.2.23.453.2007171226310.3398972@chino.kir.corp.google.com>
References: <alpine.DEB.2.23.453.2007142018150.2667860@chino.kir.corp.google.com> <20200715131048.GA176092@chrisdown.name> <alpine.DEB.2.23.453.2007151046320.2788464@chino.kir.corp.google.com> <20200717121750.GA367633@chrisdown.name>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 17 Jul 2020, Chris Down wrote:

> > With the proposed anon_reclaimable, do you have any reliability concerns?
> > This would be the amount of lazy freeable memory and memory that can be
> > uncharged if compound pages from the deferred split queue are split under
> > memory pressure.  It seems to be a very precise value (as slab_reclaimable
> > already in memory.stat is), so I'm not sure why there is a reliability
> > concern.  Maybe you can elaborate?
> 
> Ability to reclaim a page is largely about context at the time of reclaim. For
> example, if you are running at the edge of swap, at a metric that truly
> describes "reclaimable memory" will contain vastly different numbers from one
> second to the next as cluster and page availability increases and decreases.
> We may also have to do things like look for youngness at reclaim time, so I'm
> not convinced metrics like this makes sense in the general case.
...
> Again, I'm curious why this can't be solved by artificial workingset
> pressurisation and monitoring. Generally, the most reliable reclaim metrics
> come from operating reclaim itself.
> 

Perhaps this is best discussed in the context I gave in the earlier 
thread: imagine a thp-backed heap of 64MB and then a malloc implementation 
doing MADV_DONTNEED over all but one page in every one of these 
pageblocks.

On a 4.3 kernel, for example, memory.current for the heap segment is now 
(64MB / 2MB) * 4KB = 128KB because we have synchronous splitting and 
uncharging of the underlying hugepage.  On a 4.15 kernel, for example, 
memory.current is still 64MB because the underlying hugepages are still 
charged to the memcg due to deferred split queues.

For any application that monitors this, pressurization is not going to 
help: the memory will be reclaimed under memcg pressure but we aren't 
facing that pressure yet.  Userspace could identify this as a memory leak 
unless we describe what anon memory is actually reclaimable in this 
context (including on systems without swap).  For any entity that uses 
this information to infer if new work can be scheduled in this memcg (the 
reason MemAvailable exists in /proc/meminfo at the system level), this is 
now dramatically skewed.

At worse, on a swapless system, this memory is seen from userspace as 
unreclaimable because it's charged anon.

Do you have other suggestions for how userspace can understand what anon 
is reclaimable in this context before encountering memory pressure?  If 
so, it may be a great alternative to this: I haven't been able to think of 
such a way other than an anon_reclaimable stat.
