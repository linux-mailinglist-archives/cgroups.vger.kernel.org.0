Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AE5260D88
	for <lists+cgroups@lfdr.de>; Tue,  8 Sep 2020 10:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgIHI1X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Sep 2020 04:27:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:47978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729564AbgIHI1W (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 8 Sep 2020 04:27:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BFC95ACF2;
        Tue,  8 Sep 2020 08:27:21 +0000 (UTC)
Date:   Tue, 8 Sep 2020 10:27:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: no one use charge_type
Message-ID: <20200908082719.GB26850@dhcp22.suse.cz>
References: <1599552727-60003-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599552727-60003-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 08-09-20 16:12:07, Alex Shi wrote:
> After commit 0a31bc97c80c3f mm: memcontrol: rewrite uncharge API, no one
> using MEM_CGROUP_CHARGE_TYPE_xxx, let's remove them.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org> 
> Cc: Michal Hocko <mhocko@kernel.org> 
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com> 
> Cc: Andrew Morton <akpm@linux-foundation.org> 
> Cc: cgroups@vger.kernel.org 
> Cc: linux-mm@kvack.org 
> Cc: linux-kernel@vger.kernel.org 

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5d52b8a88bea..d925905920bf 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -199,14 +199,6 @@ struct mem_cgroup_event {
>  #define	MEM_CGROUP_MAX_RECLAIM_LOOPS		100
>  #define	MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS	2
>  
> -enum charge_type {
> -	MEM_CGROUP_CHARGE_TYPE_CACHE = 0,
> -	MEM_CGROUP_CHARGE_TYPE_ANON,
> -	MEM_CGROUP_CHARGE_TYPE_SWAPOUT,	/* for accounting swapcache */
> -	MEM_CGROUP_CHARGE_TYPE_DROP,	/* a page was unused swap cache */
> -	NR_CHARGE_TYPE,
> -};
> -
>  /* for encoding cft->private value on file */
>  enum res_type {
>  	_MEM,
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
