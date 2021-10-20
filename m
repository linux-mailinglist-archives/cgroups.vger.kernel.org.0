Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867FB434BC1
	for <lists+cgroups@lfdr.de>; Wed, 20 Oct 2021 15:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhJTNEf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Oct 2021 09:04:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46044 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhJTNEf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Oct 2021 09:04:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E60D121A87;
        Wed, 20 Oct 2021 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634734939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lHtiz45zVS7aEG3jw5dxC6PErBuqUS5lB4tXnXaQ6pg=;
        b=Y/I+Ce5axakhGBIRNKOegdQVHdI4YzYHQEIpdgO0UXNG8VzJ/LYJYwmJOdM6opVpOjv+9L
        FEfoascr1IWjpMCUhwxtd/BXj4wwJxLQ7Usqx/t/XNvQuA+jG11qL34rmbcJrfJoSQZlqL
        aCmzO/x/CQnYKUqQcQQjTuPUiYqW6QY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 96830A3B81;
        Wed, 20 Oct 2021 13:02:19 +0000 (UTC)
Date:   Wed, 20 Oct 2021 15:02:19 +0200
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
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH memcg 3/3] memcg: handle memcg oom failures
Message-ID: <YXATW7KsUZzbbGHy@dhcp22.suse.cz>
References: <YW/WoJDFM3ddHn7Y@dhcp22.suse.cz>
 <cover.1634730787.git.vvs@virtuozzo.com>
 <fb33f4bd-34cd-2187-eff4-7c1c11d5ae94@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb33f4bd-34cd-2187-eff4-7c1c11d5ae94@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 20-10-21 15:14:27, Vasily Averin wrote:
> mem_cgroup_oom() can fail if current task was marked unkillable
> and oom killer cannot find any victim.
> 
> Currently we force memcg charge for such allocations,
> however it allow memcg-limited userspace task in to overuse assigned limits
> and potentially trigger the global memory shortage.

You should really go into more details whether that is a practical
problem to handle. OOM_FAILED means that the memcg oom killer couldn't
find any oom victim so it cannot help with a forward progress. There are
not that many situations when that can happen. Naming that would be
really useful.
 
> Let's fail the memory charge in such cases.
> 
> This failure should be somehow recognised in #PF context,

explain why

> so let's use current->memcg_in_oom == (struct mem_cgroup *)OOM_FAILED
> 
> ToDo: what is the best way to notify pagefault_out_of_memory() about 
>     mem_cgroup_out_of_memory failure ?

why don't you simply remove out_of_memory from pagefault_out_of_memory
and leave it only with the blocking memcg OOM handling? Wouldn't that be a
more generic solution? Your first patch already goes that way partially.

This change is more risky than the first one. If somebody returns
VM_FAULT_OOM without invoking allocator then it can loop for ever but
invoking OOM killer in such a situation is equally wrong as the oom
killer cannot really help, right?
-- 
Michal Hocko
SUSE Labs
