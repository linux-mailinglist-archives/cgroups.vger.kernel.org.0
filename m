Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E28448E8DF
	for <lists+cgroups@lfdr.de>; Fri, 14 Jan 2022 12:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbiANLHP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jan 2022 06:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbiANLHP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jan 2022 06:07:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B80FC061574;
        Fri, 14 Jan 2022 03:07:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D12BC61EF4;
        Fri, 14 Jan 2022 11:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26181C36AE5;
        Fri, 14 Jan 2022 11:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642158434;
        bh=rg04tT8R1FkbVTYI0SCSCtVRaw71c3Km2IEW1JE51T4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QmK6P2ERTNTveN2AIVdc6Lnz3VzhcoPkYWRz3fR9Y0QTcs/iKutdB1GOzjm5pX3CO
         7edBo8SNpYe4DWdGV73ntqSi+gUcrRdeUS5ahZ/R5+z5R2GKqgDimdxk2/vXM0XxKZ
         hDdW+Iiq8p8Jjd8OuWUonO7ylUrE2cl9VXuKNk5GhadV2F7gwcrmUk/CZhBXSWb0+8
         W4j0mKwZHQOLAM3MZGm0BgctEep/5hg1fsr9vPGpVEb3me3N6+e0RAYOpjppChkMM1
         KLjsilIw3SY9lAipeHc/tICBEHJBwvl1pGkKlTefDkI5s7pagKZnsZVNWMPG4Xv73F
         T1UCuSqIlcBRg==
Date:   Fri, 14 Jan 2022 13:07:05 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        vbabka@suse.cz, willy@infradead.org, songmuchun@bytedance.com,
        shy828301@gmail.com, surenb@google.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm/memcg: use NUMA_NO_NODE to indicate allocation
 from unspecified node
Message-ID: <YeFZWQn79xMG6Z3L@kernel.org>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111010302.8864-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 01:02:59AM +0000, Wei Yang wrote:
> Instead of use "-1", let's use NUMA_NO_NODE for consistency.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2ed5f2a0879d..11715f7323c0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5054,7 +5054,7 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>  	 *       function.
>  	 */
>  	if (!node_state(node, N_NORMAL_MEMORY))
> -		tmp = -1;
> +		tmp = NUMA_NO_NODE;
>  	pn = kzalloc_node(sizeof(*pn), GFP_KERNEL, tmp);
>  	if (!pn)
>  		return 1;
> -- 
> 2.33.1
> 
> 

-- 
Sincerely yours,
Mike.
