Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EE7268991
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 12:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgINKqq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 06:46:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:41010 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgINKqo (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 14 Sep 2020 06:46:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 492D7AC23;
        Mon, 14 Sep 2020 10:46:58 +0000 (UTC)
Date:   Mon, 14 Sep 2020 12:46:42 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: Correct the comment of mem_cgroup_iter()
Message-ID: <20200914104642.GJ16999@dhcp22.suse.cz>
References: <20200913094129.44558-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913094129.44558-1-linmiaohe@huawei.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun 13-09-20 05:41:29, Miaohe Lin wrote:
> Since commit bbec2e15170a ("mm: rename page_counter's count/limit into
> usage/max"), the arg @reclaim has no priority field anymore.

The priority field has been removed by 9da83f3fc74b ("mm, memcg: clean
up reclaim iter array")
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Other than that
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 75cd1a1e66c8..a57aa0f42d40 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1138,9 +1138,9 @@ static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(void)
>   * invocations for reference counting, or use mem_cgroup_iter_break()
>   * to cancel a hierarchy walk before the round-trip is complete.
>   *
> - * Reclaimers can specify a node and a priority level in @reclaim to
> - * divide up the memcgs in the hierarchy among all concurrent
> - * reclaimers operating on the same node and priority.
> + * Reclaimers can specify a node in @reclaim to divide up the memcgs
> + * in the hierarchy among all concurrent reclaimers operating on the
> + * same node.
>   */
>  struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>  				   struct mem_cgroup *prev,
> -- 
> 2.19.1

-- 
Michal Hocko
SUSE Labs
