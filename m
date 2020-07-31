Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BCC234102
	for <lists+cgroups@lfdr.de>; Fri, 31 Jul 2020 10:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbgGaISH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 Jul 2020 04:18:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:59090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731823AbgGaISH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 31 Jul 2020 04:18:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0DC49AEC4;
        Fri, 31 Jul 2020 08:18:18 +0000 (UTC)
Date:   Fri, 31 Jul 2020 10:18:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: restore proper dirty throttling when
 memory.high changes
Message-ID: <20200731081804.GK18727@dhcp22.suse.cz>
References: <20200728135210.379885-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728135210.379885-1-hannes@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 28-07-20 09:52:09, Johannes Weiner wrote:
> Commit 8c8c383c04f6 ("mm: memcontrol: try harder to set a new
> memory.high") inadvertently removed a callback to recalculate the
> writeback cache size in light of a newly configured memory.high limit.
> 
> Without letting the writeback cache know about a potentially heavily
> reduced limit, it may permit too many dirty pages, which can cause
> unnecessary reclaim latencies or even avoidable OOM situations.
> 
> This was spotted while reading the code, it hasn't knowingly caused
> any problems in practice so far.
> 
> Fixes: 8c8c383c04f6 ("mm: memcontrol: try harder to set a new memory.high")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 13f559af1ab6..805a44bf948c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6071,6 +6071,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  			break;
>  	}
>  
> +	memcg_wb_domain_size_changed(memcg);
>  	return nbytes;
>  }
>  
> -- 
> 2.27.0

-- 
Michal Hocko
SUSE Labs
