Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1394720CAE9
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2020 00:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgF1WP2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 28 Jun 2020 18:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgF1WP2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 28 Jun 2020 18:15:28 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA790C03E979
        for <cgroups@vger.kernel.org>; Sun, 28 Jun 2020 15:15:27 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j12so7047540pfn.10
        for <cgroups@vger.kernel.org>; Sun, 28 Jun 2020 15:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=bXlGWq9uTXnkYLRzPxcb6hpxU9VpPN38TAS14IL4DXU=;
        b=CPgaqyT1Jx9UOYLiIqMfnX7Tf8eNkL68Qr1/ndCHQChQEw0gyxZi+wZUzq6eBBEYRP
         pc+/CPbBhO3TLXbzOpeL6KkxlJO3CVKJeraSBqfF3sF+qpffnEgV02KXVmzBtv0OmsTp
         tycxMlzZy0EYrAHx7xZ6f6yuD9xnqYzgXjiAto3WSR/jC/tWPL6YMP+AkFYNzaBaUe2h
         iiaGn/d/zTOQrsHPipdPoico8WwIC7LCRefUt6cRYW2jYFVcUa/MCvQc7g+uFidtHVsz
         gRz566TTpsUYf7tNIoceau+1/KmB0K+YMCwhdT3EdozGhMZmhEgzCrwl1FuvPMJqmUpp
         m35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=bXlGWq9uTXnkYLRzPxcb6hpxU9VpPN38TAS14IL4DXU=;
        b=n7797xF/tWvwOBgV7uwZGvzcQ/pzvgKFlbdV9eO05IHlTkacsPlZrIEmPOuc4tHjF6
         pw18W27gNGK7wXlzYgmquw9dMU/cjxBu8abOYD4qJVlJpoHIQPentIm5JGt0yb3aCak7
         CGao1IRvG9cpsEfp8DRqblCJRHsLInsNBKH3MS2M74pTUbRkfi67yaR64YxJ3dH7LBSE
         sVXeSpaDe2FbWbBeOkLaf1WJowyCrnkW3z80wR6XI1SkYv0+BLLoKkaOvIzHk/iJ5/N1
         K0gAdhSYr5QJgNhhGbbc9YiOXdpYM2nC0ikEzBhb/e+XRaUPqo61QFbGKFmG1xlHyUP4
         cEsA==
X-Gm-Message-State: AOAM531vLioCpS9TKmHR+3ljYsrnEQ+5Jsqs7EcB1VUwxDcbDF0DmIs6
        4acBS4U2SsWJPz903OV2QT51AQ==
X-Google-Smtp-Source: ABdhPJw3SWyyPGWA4SeTounVeFBQUs7hNtLlrfRHk9vJ15BE96RxB65x681BZVgnTswZzLCDt28uuA==
X-Received: by 2002:a62:5c02:: with SMTP id q2mr12255403pfb.232.1593382527157;
        Sun, 28 Jun 2020 15:15:27 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id t19sm8464123pgg.19.2020.06.28.15.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 15:15:26 -0700 (PDT)
Date:   Sun, 28 Jun 2020 15:15:25 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Memcg stat for available memory
Message-ID: <alpine.DEB.2.22.394.2006281445210.855265@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi everybody,

I'd like to discuss the feasibility of a stat similar to 
si_mem_available() but at memcg scope which would specify how much memory 
can be charged without I/O.

The si_mem_available() stat is based on heuristics so this does not 
provide an exact quantity that is actually available at any given time, 
but can otherwise provide userspace with some guidance on the amount of 
reclaimable memory.  See the description in 
Documentation/filesystems/proc.rst and its implementation.

 [ Naturally, userspace would need to understand both the amount of memory 
   that is available for allocation and for charging, separately, on an 
   overcommitted system.  I assume this is trivial.  (Why don't we provide 
   MemAvailable in per-node meminfo?) ]

For such a stat at memcg scope, we can ignore totalreserves and 
watermarks.  We already have ~precise (modulo MEMCG_CHARGE_BATCH) data for 
both file pages and slab_reclaimable.

We can infer lazily free memory by doing

	file - (active_file + inactive_file)

(This is necessary because lazy free memory is anon but on the inactive 
 file lru and we can't infer lazy freeable memory through pglazyfree -
 pglazyfreed, they are event counters.)

We can also infer the number of underlying compound pages that are on 
deferred split queues but have yet to be split with active_anon - anon (or
is this a bug? :)

So it *seems* like userspace can make a si_mem_available()-like 
calculation ("avail") by doing

	free = memory.high - memory.current
	lazyfree = file - (active_file + inactive_file)
	deferred = active_anon - anon

	avail = free + lazyfree + deferred +
		(active_file + inactive_file + slab_reclaimable) / 2

For userspace interested in knowing how much memory it can charge without 
incurring I/O (and assuming it has knowledge of available memory on an 
overcommitted system), it seems like:

 (a) it can derive the above avail amount that is at least similar to
     MemAvailable,

 (b) it can assume that all reclaim is considered equal so anything more
     than memory.high - memory.current is disruptive enough that it's a
     better heuristic than the above, or

 (c) the kernel provide an "avail" stat in memory.stat based on the above 
     and can evolve as the kernel implementation changes (how lazy free 
     memory impacts anon vs file lru stats, how deferred split memory is 
     handled, any future extensions for "easily reclaimable memory") that 
     userspace can count on to the same degree it can count on 
     MemAvailable.

Any thoughts?
