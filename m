Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872D5461A94
	for <lists+cgroups@lfdr.de>; Mon, 29 Nov 2021 16:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240897AbhK2PFa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Nov 2021 10:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351244AbhK2PD1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Nov 2021 10:03:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E6BC061397;
        Mon, 29 Nov 2021 05:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XI+jJ4HE08vbr6cxNFwgDtnF+jXYceTPv2Cm+tg2N8U=; b=UoWSBUO0XIjErdM3Fo/kNlF2Of
        uR18Lpy94jYibhxqaRhcSl/ei022kwwzCkJQKD5zzFRQcosn/gIzXX7pC27HyZNcmpaTN2NqfLS+Q
        o26jheWS88Hu60Ibp73mem4N+F+4q3YURYA+xXfTL9j7dS/jzSXux+1JlVfHfGQjbhxbqGunYpKFZ
        x9Z0wUUtrBjfx+nbhFXvA+LKj5vfnxJ3RaSa8Bhg9dhdomEIRi+6d0N/YnFugrOCqdvciS0ETPmjh
        w5KsGNDoCSLzV94HaH5i/eUQoirZrmbPk5u4nGZS6NYMZF+16pIAYD+vx5mOk1vSZPiuTCAKlN07n
        VNem1r3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrgcp-007hAU-DH; Mon, 29 Nov 2021 13:23:19 +0000
Date:   Mon, 29 Nov 2021 13:23:19 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Hao Lee <haolee.swjtu@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>, vdavydov.dev@gmail.com,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: reduce spinlock contention in release_pages()
Message-ID: <YaTUR9WcGoOG4oLo@casper.infradead.org>
References: <CA+PpKPmy-u_BxYMCQOFyz78t2+3uM6nR9mQeX+MPyH6H2tOOHA@mail.gmail.com>
 <YZ8DZHERun6Fej2P@casper.infradead.org>
 <20211125080238.GA7356@haolee.io>
 <YZ9e3pzHKmn5nev0@dhcp22.suse.cz>
 <20211125123133.GA7758@haolee.io>
 <YZ+bI1fNpKar0bSU@dhcp22.suse.cz>
 <CA+PpKP=hsuBmvv09OcD2Nct8B8Cqa03UfKFHAHzKxwE0SXGP4g@mail.gmail.com>
 <YaC7BcTSijFj+bxR@dhcp22.suse.cz>
 <20211126162623.GA10277@haolee.io>
 <YaSRtKwTCOj7JnR6@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaSRtKwTCOj7JnR6@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 29, 2021 at 09:39:16AM +0100, Michal Hocko wrote:
> On Fri 26-11-21 16:26:23, Hao Lee wrote:
> [...]
> > I will try Matthew's idea to use semaphore or mutex to limit the number of BE
> > jobs that are in the exiting path. This sounds like a feasible approach for
> > our scenario...
> 
> I am not really sure this is something that would be acceptable. Your
> problem is resource partitioning. Papering that over by a lock is not
> the right way to go. Besides that you will likely hit a hard question on
> how many tasks to allow to run concurrently. Whatever the value some
> workload will very likely going to suffer. We cannot assume admin to
> chose the right value because there is no clear answer for that. Not to
> mention other potential problems - e.g. even more priority inversions
> etc.

I don't see how we get priority inversions.  These tasks are exiting; at
the point they take the semaphore, they should not be holding any locks.
They're holding a resource (memory) that needs to be released, but a
task wanting to acquire memory must already be prepared to sleep.

I see this as being a thundering herd problem.  We have dozens, maybe
hundreds of tasks all trying to free their memory at once.  If we force
the herd to go through a narrow gap, they arrive at the spinlock in an
orderly manner.
