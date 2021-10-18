Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA3E4312B2
	for <lists+cgroups@lfdr.de>; Mon, 18 Oct 2021 11:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhJRJGe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 05:06:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42732 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhJRJGb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Oct 2021 05:06:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BE378219B5;
        Mon, 18 Oct 2021 09:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634547853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z/vHFPDVM8hZbz3viTK/C8vH4oGvJ8bN8OaWpPhCHZA=;
        b=mlAFk61d8h+oSQO3dORG+kD0uapYz7LR8uzHrxUR/4h6gZrn6tBqFtGaJdXynpE3yHSMNK
        YL/qsLMTyZgoJD3G7YFKI5VAm27szaLmBj00FcNqg+eOlKtgZ08zzUOrgj0iNDSRFxZ6tc
        8kq79DeG+dWHL856++NmRKI+2yWvH40=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7424AA3B83;
        Mon, 18 Oct 2021 09:04:13 +0000 (UTC)
Date:   Mon, 18 Oct 2021 11:04:13 +0200
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
Message-ID: <YW04jWSv6pQb2Goe@dhcp22.suse.cz>
References: <9d10df01-0127-fb40-81c3-cc53c9733c3e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d10df01-0127-fb40-81c3-cc53c9733c3e@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 18-10-21 11:13:52, Vasily Averin wrote:
[...]
> How could this happen?
> 
> User-space task inside the memcg-limited container generated a page fault,
> its handler do_user_addr_fault() called handle_mm_fault which could not
> allocate the page due to exceeding the memcg limit and returned VM_FAULT_OOM.
> Then do_user_addr_fault() called pagefault_out_of_memory() which executed
> out_of_memory() without set of memcg.
> 
> Partially this problem depends on one of my recent patches, disabled unlimited
> memory allocation for dying tasks. However I think the problem can happen
> on non-killed tasks too, for example because of kmem limit.

Could you be more specific on how this can happen without your patch? I
have to say I haven't realized this side effect when discussing it.

I will be honest that I am not really happy about pagefault_out_of_memory.
I have tried to remove it in the past. Without much success back then,
unfortunately[1]. 
Maybe we should get rid of it finally. The OOM is always triggered from
inside the allocator where we have much more infromation about the
allocation context. A first step would be to skip pagefault_out_of_memory
for killed or exiting processes.

[1] I do not have msg-id so I cannot provide a lore link but google
pointed me to https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1400402.html
-- 
Michal Hocko
SUSE Labs
