Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB0C98C2D
	for <lists+cgroups@lfdr.de>; Thu, 22 Aug 2019 09:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfHVHFx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Aug 2019 03:05:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:58868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726857AbfHVHFw (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Aug 2019 03:05:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A338EAE00;
        Thu, 22 Aug 2019 07:05:51 +0000 (UTC)
Date:   Thu, 22 Aug 2019 09:05:50 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: return value of the function
 mem_cgroup_from_css() is not checked
Message-ID: <20190822070550.GA12785@dhcp22.suse.cz>
References: <20190822062210.18649-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822062210.18649-1-yzhai003@ucr.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 21-08-19 23:22:09, Yizhuo wrote:
> Inside function mem_cgroup_wb_domain(), the pointer memcg
> could be NULL via mem_cgroup_from_css(). However, this pointer is
> not checked and directly dereferenced in the if statement,
> which is potentially unsafe.

Could you describe circumstances when this would happen? The code is
this way for 5 years without any issues. Are we just lucky or something
has changed recently to make this happen?
 
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 661f046ad318..bd84bdaed3b0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3665,7 +3665,7 @@ struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
>  
> -	if (!memcg->css.parent)
> +	if (!memcg || !memcg->css.parent)
>  		return NULL;
>  
>  	return &memcg->cgwb_domain;
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
