Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64FE5E1277
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2019 08:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfJWGvA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Oct 2019 02:51:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:41002 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727194AbfJWGvA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 23 Oct 2019 02:51:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B113B549;
        Wed, 23 Oct 2019 06:50:58 +0000 (UTC)
Date:   Wed, 23 Oct 2019 08:50:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2] mm: memcontrol: remove dead code from
 memory_max_write()
Message-ID: <20191023065057.GC754@dhcp22.suse.cz>
References: <20191022201518.341216-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022201518.341216-1-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 22-10-19 16:15:17, Johannes Weiner wrote:
> When the reclaim loop in memory_max_write() is ^C'd or similar, we set
> err to -EINTR. But we don't return err. Once the limit is set, we
> always return success (nbytes). Delete the dead code.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 055975b0b3a3..ff90d4e7df37 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6122,10 +6122,8 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>  		if (nr_pages <= max)
>  			break;
>  
> -		if (signal_pending(current)) {
> -			err = -EINTR;
> +		if (signal_pending(current))
>  			break;
> -		}
>  
>  		if (!drained) {
>  			drain_all_stock(memcg);
> -- 
> 2.23.0
> 

-- 
Michal Hocko
SUSE Labs
