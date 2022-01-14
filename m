Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B307748E8E2
	for <lists+cgroups@lfdr.de>; Fri, 14 Jan 2022 12:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiANLIh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jan 2022 06:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiANLIh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jan 2022 06:08:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F228CC061574;
        Fri, 14 Jan 2022 03:08:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92DF761EF2;
        Fri, 14 Jan 2022 11:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233C3C36AE5;
        Fri, 14 Jan 2022 11:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642158516;
        bh=OF5OUUAm25dp5cp+JT0GiuvYGOwzKMtdyhATZeQWCM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=anWYlmeAreoucUVCTnYlq5eLjpIWYUu97Eer6MAZxeInCL2iyNeuvzdkr4wXTCilh
         ADbkMRQOsbDKfGrQhI/Krb3R7WFGc/QG6nzEmEKa0alTS2JpzXrfMo3TEZhlLl22fu
         O/XvQqtC6HrkjNYMciuW/e+EteHpY6ZAvt5AX88lFtxPpWvzn6Pcd5BkA/Buu0SDru
         e1xE+5quxorgWd+xmEB8LlUeq1b3EJ600qkDwcuSgR9Ly/WxVGoAduHQwChY7NaAx+
         0Dtj5KrkdTYWGk26kAp8EQbFDtPRuo2/rBAFXH4k8BrxHPAgx19pRBUIhVExEPYznV
         2326WkH6r4Fng==
Date:   Fri, 14 Jan 2022 13:08:28 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        vbabka@suse.cz, willy@infradead.org, songmuchun@bytedance.com,
        shy828301@gmail.com, surenb@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/4] mm/memcg: mem_cgroup_per_node is already set to 0 on
 allocation
Message-ID: <YeFZrEAaPw1Y5wwd@kernel.org>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
 <20220111010302.8864-2-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111010302.8864-2-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 01:03:00AM +0000, Wei Yang wrote:
> kzalloc_node() would set data to 0, so it's not necessary to set it
> again.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/memcontrol.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 11715f7323c0..a504616f904a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5067,8 +5067,6 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>  	}
>  
>  	lruvec_init(&pn->lruvec);
> -	pn->usage_in_excess = 0;
> -	pn->on_tree = false;
>  	pn->memcg = memcg;
>  
>  	memcg->nodeinfo[node] = pn;
> -- 
> 2.33.1
> 
> 

-- 
Sincerely yours,
Mike.
