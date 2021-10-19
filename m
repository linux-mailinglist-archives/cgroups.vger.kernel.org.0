Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDF943318D
	for <lists+cgroups@lfdr.de>; Tue, 19 Oct 2021 10:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbhJSIvx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Oct 2021 04:51:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51238 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJSIvx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Oct 2021 04:51:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 337A11FCA3;
        Tue, 19 Oct 2021 08:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634633380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XPwmj/o6n9ykv9XbtNvWH5jIFBBxobggF5mrBJrzaOI=;
        b=CziZ8O745mlkeu314jrm3XHnf3nMStZFP21MvFp8qAH3CeVI8ZEssk6h4spttaOLGBn+V4
        GY4QKYFX8SBEAuigRErLE1YypTQh0h4wf6PGqCMFRKXhiAuj+syDyugIiT4DGDhvGfHz2r
        zVXG7CncMJv59I36BTIdl91S37t0zCY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 05932A3B84;
        Tue, 19 Oct 2021 08:49:39 +0000 (UTC)
Date:   Tue, 19 Oct 2021 10:49:37 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH memcg 0/1] false global OOM triggered by memcg-limited
 task
Message-ID: <YW6GoZhFUJc1uLYr@dhcp22.suse.cz>
References: <9d10df01-0127-fb40-81c3-cc53c9733c3e@virtuozzo.com>
 <YW04jWSv6pQb2Goe@dhcp22.suse.cz>
 <6b751abe-aa52-d1d8-2631-ec471975cc3a@virtuozzo.com>
 <YW1gRz0rTkJrvc4L@dhcp22.suse.cz>
 <339ae4b5-6efd-8fc2-33f1-2eb3aee71cb2@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <339ae4b5-6efd-8fc2-33f1-2eb3aee71cb2@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 19-10-21 09:30:18, Vasily Averin wrote:
[...]
> With my patch ("memcg: prohibit unconditional exceeding the limit of dying tasks") try_charge_memcg() can fail:
> a) due to fatal signal
> b) when mem_cgroup_oom -> mem_cgroup_out_of_memory -> out_of_memory() returns false (when select_bad_process() found nothing)
> 
> To handle a) we can follow to your suggestion and skip excution of out_of_memory() in pagefault_out_of memory()
> To handle b) we can go to retry: if mem_cgroup_oom() return OOM_FAILED.

How is b) possible without current being killed? Do we allow remote
charging?

> However all these cases can be successfully handled by my new patch
> "memcg: prevent false global OOM triggered by memcg limited task"
> and I think it is better solution.

I have already replied to your approach in other email. Sorry our
replies have crossed.
-- 
Michal Hocko
SUSE Labs
