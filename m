Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE772EBFE1
	for <lists+cgroups@lfdr.de>; Wed,  6 Jan 2021 15:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbhAFOyi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Jan 2021 09:54:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:47766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbhAFOyh (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 6 Jan 2021 09:54:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609944830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=56aSTfmSA+spfUL4tlM8C1HuU4wDxeDMZKVuz0ExlJs=;
        b=rChqb3nnYyFTkjdLoJj6UCubjOGNjlXPq/sjyGZCn+pxXCN6AhYlepfsW7oVghGBNypjL9
        GMrwKriJc2T1WF1AnIqnzLpgv4u+vpzUcIz58ugyMbYhrdfszF3AzNBHt4fQChqA0Ngt1S
        Thn/hj37EUxJjYaig+hOahL/OHluoX0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B9E1FADC4;
        Wed,  6 Jan 2021 14:53:50 +0000 (UTC)
Date:   Wed, 6 Jan 2021 15:53:49 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: add swapcache stat for memcg v2
Message-ID: <20210106145349.GN13207@dhcp22.suse.cz>
References: <20210101023955.250965-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210101023955.250965-1-shakeelb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 31-12-20 18:39:55, Shakeel Butt wrote:
> This patch adds swapcache stat for the cgroup v2. The swapcache
> represents the memory that is accounted against both the memory and the
> swap limit of the cgroup. The main motivation behind exposing the
> swapcache stat is for enabling users to gracefully migrate from cgroup
> v1's memsw counter to cgroup v2's memory and swap counters.
> 
> Cgroup v1's memsw limit allows users to limit the memory+swap usage of a
> workload but without control on the exact proportion of memory and swap.
> Cgroup v2 provides separate limits for memory and swap which enables
> more control on the exact usage of memory and swap individually for the
> workload.
> 
> With some little subtleties, the v1's memsw limit can be switched with
> the sum of the v2's memory and swap limits. However the alternative for
> memsw usage is not yet available in cgroup v2. Exposing per-cgroup
> swapcache stat enables that alternative. Adding the memory usage and
> swap usage and subtracting the swapcache will approximate the memsw
> usage. This will help in the transparent migration of the workloads
> depending on memsw usage and limit to v2' memory and swap counters.

Could you expand a bit more on why memsw usage is important even in
cgroup v2 land? How are you going to use the approximated value?

I am not really objecting to adding this counter. We do export it for
the global case and having a memcg view sounds useful for analysis.
-- 
Michal Hocko
SUSE Labs
