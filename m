Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85CE3DB3BD
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 08:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbhG3GjU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Jul 2021 02:39:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40942 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbhG3GjU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Jul 2021 02:39:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 21E291FDB1;
        Fri, 30 Jul 2021 06:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627627155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=agHfFzHW+xeGrdhw4hG5J5joqngPV2b0VMzApVyqQ8E=;
        b=PeRG1lTled8ApH7cHx8hsRdcE5UrL2oXTe256ZUWp/ZadsVhirozoTQeLdTqZoHnVZ0faD
        uzg08Gto5i2+eAUb8udHkBWFpdFHPw5lWAYyUYEwgW3/zu4yE0Jf5/+nDpOxtpNzrDQgRF
        NscVVZDtu9NtvzMgXo4UGqtbkegUass=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E2190A3B87;
        Fri, 30 Jul 2021 06:39:14 +0000 (UTC)
Date:   Fri, 30 Jul 2021 08:39:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: Set the correct memcg swappiness
 restriction
Message-ID: <YQOekWWgtZUfim4M@dhcp22.suse.cz>
References: <d77469b90c45c49953ccbc51e54a1d465bc18f70.1627626255.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d77469b90c45c49953ccbc51e54a1d465bc18f70.1627626255.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 30-07-21 14:26:35, Baolin Wang wrote:
> Since commit c843966c556d ("mm: allow swappiness that prefers reclaiming
> anon over the file workingset") has expended the swappiness value to
> make swap to be preferred in some systems. We should also change the
> memcg swappiness restriction to allow memcg swap-preferred.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Yes, this looks like an omission. It doesn't really make sense to have
two different constrains on the value.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6580c23..988fc94 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4046,7 +4046,7 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>  
> -	if (val > 100)
> +	if (val > 200)
>  		return -EINVAL;
>  
>  	if (!mem_cgroup_is_root(memcg))
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
