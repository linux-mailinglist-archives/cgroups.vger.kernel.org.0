Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1138F1D8862
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2020 21:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgERTmO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 May 2020 15:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728315AbgERTmN (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 18 May 2020 15:42:13 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A440920643;
        Mon, 18 May 2020 19:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589830933;
        bh=oF7IhR6sg52j1XJLokffl+JRh2aq7CdtTjmwU6+Sth8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eghQgmRQbj64PWGWC2pjySV1CgaF5LBoo2DwG+QKNJR+6L9j06rjcK8oXnRZ6qiZU
         toNZcgfIkOgrPlK0oZWXub6dm+a/FUHrHCiHaLV1sY9ZEJO3LM5D9CeGpqqojJgyDL
         zeGq1BHOialio2xxosyUgzHzopcxsiRzvQNyxhcs=
Date:   Mon, 18 May 2020 12:42:10 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH mm v3 3/3] mm: automatically penalize tasks with high
 swap use
Message-ID: <20200518124210.37335d0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CALvZod5Dcee8CaNfkhQQbvC1OuOTO7qE9bJw9NAa8nd2Cru6hA@mail.gmail.com>
References: <20200515202027.3217470-1-kuba@kernel.org>
        <20200515202027.3217470-4-kuba@kernel.org>
        <CALvZod5Dcee8CaNfkhQQbvC1OuOTO7qE9bJw9NAa8nd2Cru6hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, 17 May 2020 06:44:52 -0700 Shakeel Butt wrote:
> > Use one counter for number of pages allocated under pressure
> > to save struct task space and avoid two separate hierarchy
> > walks on the hot path.
> 
> The above para seems out of place. It took some time to realize you
> are talking about current->memcg_nr_pages_over_high. IMO instead of
> this para, a comment in code would be much better.

Where would you like to see the comment? In struct task or where
counter is bumped?

> > Take the new high limit into account when determining if swap
> > is "full". Borrowing the explanation from Johannes:
> >
> >   The idea behind "swap full" is that as long as the workload has plenty
> >   of swap space available and it's not changing its memory contents, it
> >   makes sense to generously hold on to copies of data in the swap
> >   device, even after the swapin. A later reclaim cycle can drop the page
> >   without any IO. Trading disk space for IO.
> >
> >   But the only two ways to reclaim a swap slot is when they're faulted
> >   in and the references go away, or by scanning the virtual address space
> >   like swapoff does - which is very expensive (one could argue it's too
> >   expensive even for swapoff, it's often more practical to just reboot).
> >
> >   So at some point in the fill level, we have to start freeing up swap
> >   slots on fault/swapin.  
> 
> swap.high allows the user to force the kernel to start freeing swap
> slots before half-full heuristic, right?

I'd say that the definition of full is extended to include swap.high.
