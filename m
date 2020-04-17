Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAB41AE893
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2020 01:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgDQXWv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Apr 2020 19:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgDQXWv (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 17 Apr 2020 19:22:51 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B659C221EA;
        Fri, 17 Apr 2020 23:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587165771;
        bh=ftdKWGgpIDLZDqr/mtlNo4/49vEIAWuOveNytV1igpc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cZ0BvbedqipSYOEP06wf+4Wk0rHhX3n7O/h+J7aROxs03yXlcfHFdrb7woubqPx6g
         0trl37tPnerWYr7m3ao1JycRQI7QFYAeRQFOFlawPRqSRobYUm8wbD/0A44lY3u+s9
         c69OVXWHRvSQhao25faEPxiEbtuZJ/hNKYij0L3M=
Date:   Fri, 17 Apr 2020 16:22:48 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, kernel-team@fb.com,
        tj@kernel.org, hannes@cmpxchg.org, chris@chrisdown.name,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: automatically penalize tasks with high swap use
Message-ID: <20200417162248.415ff51e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200417073716.GG26707@dhcp22.suse.cz>
References: <20200417010617.927266-1-kuba@kernel.org>
        <20200417010617.927266-4-kuba@kernel.org>
        <20200417073716.GG26707@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 17 Apr 2020 09:37:16 +0200 Michal Hocko wrote:
> On Thu 16-04-20 18:06:17, Jakub Kicinski wrote:
> > Add a memory.swap.high knob, which functions in a similar way
> > to memory.high, but with a less steep slope.  
> 
> This really begs for more details. What does "similar way to
> memory.high" mean? Because my first thought would be that the swap usage
> will be throttled and kept at the swap.high level. From a quick look at
> the patch you only do throttling. There is no swap space reclaim to keep
> the usage at the level. So unless I am missing something this is very
> confusing and it doesn't really fit into high limit semantic.

The new knob does influence mem_cgroup_swap_full(), but you're right,
the analogy is not strong enough, I'll rephrase.

> This changelog also doesn't describe any usecase.

Will do.
