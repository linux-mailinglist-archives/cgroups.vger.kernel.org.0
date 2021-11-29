Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEA44616CD
	for <lists+cgroups@lfdr.de>; Mon, 29 Nov 2021 14:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhK2NpC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Nov 2021 08:45:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41304 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhK2NnC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Nov 2021 08:43:02 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 004E11FD39;
        Mon, 29 Nov 2021 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638193184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MCR2AjsamUOBWBaNMd3hj2AgMrYiQAsklcYI7+6tUNc=;
        b=BF5tF/zTTzcePDATMm5ORv0aj2GjCP5cOtzN4OFHtX5kugS+UYnnvq8iIVlAj5+YX67rPU
        N1SgE1s+MKgLvYeBKJBG8FmbAW4++jm4NgeKnbZN6iYGUrq+j+PdCSs94+YaVrVmeD8r6p
        9pOiWBR86RlkVMXhKlBclXTwMIayApg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C3F67A3B84;
        Mon, 29 Nov 2021 13:39:43 +0000 (UTC)
Date:   Mon, 29 Nov 2021 14:39:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hao Lee <haolee.swjtu@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>, vdavydov.dev@gmail.com,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: reduce spinlock contention in release_pages()
Message-ID: <YaTYH67jSNWqYySF@dhcp22.suse.cz>
References: <YZ8DZHERun6Fej2P@casper.infradead.org>
 <20211125080238.GA7356@haolee.io>
 <YZ9e3pzHKmn5nev0@dhcp22.suse.cz>
 <20211125123133.GA7758@haolee.io>
 <YZ+bI1fNpKar0bSU@dhcp22.suse.cz>
 <CA+PpKP=hsuBmvv09OcD2Nct8B8Cqa03UfKFHAHzKxwE0SXGP4g@mail.gmail.com>
 <YaC7BcTSijFj+bxR@dhcp22.suse.cz>
 <20211126162623.GA10277@haolee.io>
 <YaSRtKwTCOj7JnR6@dhcp22.suse.cz>
 <YaTUR9WcGoOG4oLo@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaTUR9WcGoOG4oLo@casper.infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 29-11-21 13:23:19, Matthew Wilcox wrote:
> On Mon, Nov 29, 2021 at 09:39:16AM +0100, Michal Hocko wrote:
> > On Fri 26-11-21 16:26:23, Hao Lee wrote:
> > [...]
> > > I will try Matthew's idea to use semaphore or mutex to limit the number of BE
> > > jobs that are in the exiting path. This sounds like a feasible approach for
> > > our scenario...
> > 
> > I am not really sure this is something that would be acceptable. Your
> > problem is resource partitioning. Papering that over by a lock is not
> > the right way to go. Besides that you will likely hit a hard question on
> > how many tasks to allow to run concurrently. Whatever the value some
> > workload will very likely going to suffer. We cannot assume admin to
> > chose the right value because there is no clear answer for that. Not to
> > mention other potential problems - e.g. even more priority inversions
> > etc.
> 
> I don't see how we get priority inversions.  These tasks are exiting; at
> the point they take the semaphore, they should not be holding any locks.
> They're holding a resource (memory) that needs to be released, but a
> task wanting to acquire memory must already be prepared to sleep.

At least these scenarios come to mind
- a task being blocked by other lower priority tasks slowly tearing down
  their address space - essentially a different incarnation of the same
  problem this is trying to handle
- a huge memory backed task waiting many for smaller ones to finish
- waste of resources on properly partitioned systems. Why should
  somebody block tasks when they are acting on different lruvecs and
  cpus?

-- 
Michal Hocko
SUSE Labs
