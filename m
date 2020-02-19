Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A920164EEE
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2020 20:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgBSTbk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Feb 2020 14:31:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgBSTbk (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 19 Feb 2020 14:31:40 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F10F6208E4;
        Wed, 19 Feb 2020 19:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582140700;
        bh=WFvZa8hDniOG8g1qTenV8AtspoE+3eAninCHZes58LU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0/Z2qwVUjvEBK9lueZh7pxv8imBgjnkMO9MVu2fV58D6nh1RWpn7VHc0zxzfzsbVd
         k3NwiEWCzkAAatIu4pcPaBY36s/oaD/qjVZML74u8CLJS+JdScIbOuCsQ9x6tv8p70
         +pBJ6402V2bEIvxO3B1PeMhVv6eRF3KfABKD6MYk=
Date:   Wed, 19 Feb 2020 11:31:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-Id: <20200219113139.ee60838bc7eb35747eb330fa@linux-foundation.org>
In-Reply-To: <20200219183731.GC11847@dhcp22.suse.cz>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
        <20200219183731.GC11847@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 19 Feb 2020 19:37:31 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> On Wed 19-02-20 13:12:19, Johannes Weiner wrote:
> > We have received regression reports from users whose workloads moved
> > into containers and subsequently encountered new latencies. For some
> > users these were a nuisance, but for some it meant missing their SLA
> > response times. We tracked those delays down to cgroup limits, which
> > inject direct reclaim stalls into the workload where previously all
> > reclaim was handled my kswapd.
> 
> I am curious why is this unexpected when the high limit is explicitly
> documented as a throttling mechanism.

Yes, this sounds like a feature-not-a-bug.

But what was the nature of these stalls?  If they were "stuck in D
state waiting for something" then that's throttling.  If they were
"unexpected bursts of in-kernel CPU activity" then I see a better case.

