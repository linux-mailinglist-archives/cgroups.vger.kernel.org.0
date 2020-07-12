Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CE321CBB2
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2020 00:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgGLWCS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 12 Jul 2020 18:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgGLWCR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 12 Jul 2020 18:02:17 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF62BC061794
        for <cgroups@vger.kernel.org>; Sun, 12 Jul 2020 15:02:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id p1so4598270pls.4
        for <cgroups@vger.kernel.org>; Sun, 12 Jul 2020 15:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=bBfbvYhGqWPO4SrfwfAtUFdviPVIm20NE8Tufoq+ci0=;
        b=KklSfLfBEgYckd9ORj/DxbM7nO2yrCo1gEAdcvhciOsqwhHV+CJ9ptFbuQqLn+JM/U
         2UywsIsQylSgYerRt8uXPkPzr3eiwORXWcs9aqgxZPjDhjVo5GQkAS9pe3+65c21OXNY
         Cdic43oTDD5fp8f7fq7mv1E84s0yDk0kYd+qYVClT5TdSbl4+AxPcn1RXV/xPrgto4WZ
         Vgu88DDBdNFcBL+hiqxJEVJxg7CX8fRPHBBXvX2vBFJw3NcwSnWaW9gKiz9THMvai8FW
         bcvakMwsLBHw/je7JZWq+86UPG7kq9d/sEG4wHadKXKUW9mhCPl2uFQDWV6adSSFtfin
         rNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=bBfbvYhGqWPO4SrfwfAtUFdviPVIm20NE8Tufoq+ci0=;
        b=MzU93cYxDBXkDv1fk7c+BLFUGaE6Thf6EI92X6pJVCfAmavRqDi7w3Ql1r5IGMqPNn
         8yFvoIEP3RLjG/UQMXP/O9b4o9KweGiGhOLCDdj939TcUWYUTszMmCS7Wc83l8azHzmB
         v4n0U+6E1RQkgpeXbqrkcO5Zbik7hhNYqfJvBWqEJO+90aUlhDEF4f751hI9I9HQzUCY
         j2dg4n19gTzUH2q8KMyIvjodBBWTyBUDd6ZSdyJw9C4X/31emcY3gFrOhHGC0NsOAdZy
         J86EFDjE4LmDzqvWHNlTQ5CjyvvIea7Gt7rm1yihJChsy/trKA7uRmUEqmkeKQJXy+UB
         qx+w==
X-Gm-Message-State: AOAM530f9njyu7ic6iHVPdJDr8jCOtYpL5jZwzl4Wbk9J+rPEk8H+uUL
        wFgm0zVEvL6Kq5G+7lS7z4lwiQ==
X-Google-Smtp-Source: ABdhPJwy/AY73yUTA/rmM+X22LDdlV1knjysk1ET6hXLNnepIf9mVx1A3IIbiRePKT32WC7uBax4kw==
X-Received: by 2002:a17:902:c24a:: with SMTP id 10mr63658370plg.82.1594591336888;
        Sun, 12 Jul 2020 15:02:16 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id o129sm12054802pfg.14.2020.07.12.15.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 15:02:16 -0700 (PDT)
Date:   Sun, 12 Jul 2020 15:02:15 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yang Shi <shy828301@gmail.com>
cc:     Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Subject: Re: Memcg stat for available memory
In-Reply-To: <CAHbLzkoCNt7GPrwN1uPEvd==-Lz9-j6-2RS0CCL0s2e-M_omiw@mail.gmail.com>
Message-ID: <alpine.DEB.2.23.453.2007121448020.1725102@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2006281445210.855265@chino.kir.corp.google.com> <CALvZod5Zv33oNLxS_8TyGV_QT4CsBjiEuocxpt2+U-XDMaFDPw@mail.gmail.com> <20200703081538.GO18446@dhcp22.suse.cz> <alpine.DEB.2.23.453.2007071210410.396729@chino.kir.corp.google.com>
 <alpine.DEB.2.23.453.2007101223470.1178541@chino.kir.corp.google.com> <CAHbLzkoCNt7GPrwN1uPEvd==-Lz9-j6-2RS0CCL0s2e-M_omiw@mail.gmail.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 10 Jul 2020, Yang Shi wrote:

> > To try to get more discussion on the subject, consider a malloc
> > implementation, like tcmalloc, that does MADV_DONTNEED to free memory back
> > to the system and how this freed memory is then described to userspace
> > depending on the kernel implementation.
> >
> >  [ For the sake of this discussion, consider we have precise memcg stats
> >    available to us although the actual implementation allows for some
> >    variance (MEMCG_CHARGE_BATCH). ]
> >
> > With a 64MB heap backed by thp on x86, for example, the vma starts with an
> > rss of 64MB, all of which is anon and backed by hugepages.  Imagine some
> > aggressive MADV_DONTNEED freeing that ends up with only a single 4KB page
> > mapped in each 2MB aligned range.  The rss is now 32 * 4KB = 128KB.
> >
> > Before freeing, anon, anon_thp, and active_anon in memory.stat would all
> > be the same for this vma (64MB).  64MB would also be charged to
> > memory.current.  That's all working as intended and to the expectation of
> > userspace.
> >
> > After freeing, however, we have the kernel implementation specific detail
> > of how huge pmd splitting is handled (rss) in comparison to the underlying
> > split of the compound page (deferred split queue).  The huge pmd is always
> > split synchronously after MADV_DONTNEED so, as mentioned, the rss is 128KB
> > for this vma and none of it is backed by thp.
> >
> > What is charged to the memcg (memory.current) and what is on active_anon
> > is unchanged, however, because the underlying compound pages are still
> > charged to the memcg.  The amount of anon and anon_thp are decreased
> > in compliance with the splitting of the page tables, however.
> >
> > So after freeing, for this vma: anon = 128KB, anon_thp = 0,
> > active_anon = 64MB, memory.current = 64MB.
> >
> > In this case, because of the deferred split queue, which is a kernel
> > implementation detail, userspace may be unclear on what is actually
> > reclaimable -- and this memory is reclaimable under memory pressure.  For
> > the motivation of MemAvailable (what amount of memory is available for
> > starting new work), userspace *could* determine this through the
> > aforementioned active_anon - anon (or some combination of
> > memory.current - anon - file - slab), but I think it's a fair point that
> > userspace's view of reclaimable memory as the kernel implementation
> > changes is something that can and should remain consistent between
> > versions.
> >
> > Otherwise, an earlier implementation before deferred split queues could
> > have safely assumed that active_anon was unreclaimable unless swap were
> > enabled.  It doesn't have the foresight based on future kernel
> > implementation detail to reconcile what the amount of reclaimable memory
> > actually is.
> >
> > Same discussion could happen for lazy free memory which is anon but now
> > appears on the file lru stats and not the anon lru stats: it's easily
> > reclaimable under memory pressure but you need to reconcile the difference
> > between the anon metric and what is revealed in the anon lru stats.
> >
> > That gave way to my original thought of a si_mem_available()-like
> > calculation ("avail") by doing
> >
> >         free = memory.high - memory.current
> 
> I'm wondering what if high or max is set to max limit. Don't you end
> up seeing a super large memavail?
> 

Hi Yang,

Yes, this would be the same as seeing a super large limit :)

I'm indifferent to whether this is described as an available amount of 
memory (almost identical to MemAvailable) or a best guess of the 
reclaimable amount of memory from the memory that is currently charged.  
Concept is to provide userspace with this best guess like we do for system 
memory through MemAvailable because it (a) depends on implementation 
details in the kernel and (b) is the only way to maintain consistency from 
version to version.

> >         lazyfree = file - (active_file + inactive_file)
> 
> Isn't it (active_file + inactive_file) - file ? It looks MADV_FREE
> just updates inactive lru size.
> 

Yes, you're right, this would be

	lazyfree = (active_file + inactive_file) - file

from memory.stat.  Lazy free memory are clean anon pages on the 
inactive file lru, but we must consider active_file + inactive_file in 
comparison to "file" for the total amount of lazy free.

Another side effect of this is that we'd need anon - lazyfree swap space 
available for this workload to be swapped.

The overall point I'm trying to highlight is that the amount of memory 
that can be freed under memory pressure, either lazy free or on the 
deferred split queues, can be substantial.  I'd like to discuss the 
feasibility of adding this as a kernel maintained stat to memory.stat 
rather than userspace attempting to derive this on its own.

> >         deferred = active_anon - anon
> >
> >         avail = free + lazyfree + deferred +
> >                 (active_file + inactive_file + slab_reclaimable) / 2
> >
> > And we have the ability to change this formula based on kernel
> > implementation details as they evolve.  Idea is to provide a consistent
> > field that userspace can use to determine the rough amount of reclaimable
> > memory in a MemAvailable-like way.
