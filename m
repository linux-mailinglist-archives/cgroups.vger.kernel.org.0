Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47D76ACB4A
	for <lists+cgroups@lfdr.de>; Mon,  6 Mar 2023 18:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjCFRvp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Mar 2023 12:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjCFRvh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Mar 2023 12:51:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270DC3D0B6;
        Mon,  6 Mar 2023 09:51:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 381B01FDE4;
        Mon,  6 Mar 2023 17:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678125016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w38yPDPoNW7meWXht3zLss0FQ6ef9zy/ciQDyUVGN8Q=;
        b=bvUIaVCPQdKJVm5AsdMuBwe3iqky2mqSyazjiFZKsfUjRKx3lcIfadlu/zbSPmqq25EUXQ
        rEOgyXUrfZPMgNfc5n+XOlJnyT5TUnZDngf0I6qEiec/hMnlgm8vpOBzTkTH3I3jncpx9q
        wlXWHFKSDWz9XoyG9bxJqkkRC9LjseE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BCD713513;
        Mon,  6 Mar 2023 17:50:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y99SBNgnBmRHfgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 06 Mar 2023 17:50:16 +0000
Date:   Mon, 6 Mar 2023 18:50:15 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yue Zhao <findns94@gmail.com>
Cc:     akpm@linux-foundation.org, roman.gushchin@linux.dev,
        hannes@cmpxchg.org, shakeelb@google.com, muchun.song@linux.dev,
        willy@infradead.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com
Subject: Re: [PATCH v2, 2/4] mm, memcg: Prevent memory.swappiness load/store
 tearing
Message-ID: <ZAYn19jFPO9KR2Si@dhcp22.suse.cz>
References: <20230306154138.3775-1-findns94@gmail.com>
 <20230306154138.3775-3-findns94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306154138.3775-3-findns94@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 06-03-23 23:41:36, Yue Zhao wrote:
> The knob for cgroup v1 memory controller: memory.swappiness
> is not protected by any locking so it can be modified while it is used.
> This is not an actual problem because races are unlikely.
> But it is better to use READ_ONCE/WRITE_ONCE to prevent compiler from
> doing anything funky.
> 
> The access of memcg->swappiness and vm_swappiness is lockless,
> so both of them can be concurrently set at the same time
> as we are trying to read them. 
> 
> Signed-off-by: Yue Zhao <findns94@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  include/linux/swap.h | 8 ++++----
>  mm/memcontrol.c      | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 209a425739a9..3f3fe43d1766 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -620,18 +620,18 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
>  {
>  	/* Cgroup2 doesn't have per-cgroup swappiness */
>  	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> -		return vm_swappiness;
> +		return READ_ONCE(vm_swappiness);
>  
>  	/* root ? */
>  	if (mem_cgroup_disabled() || mem_cgroup_is_root(memcg))
> -		return vm_swappiness;
> +		return READ_ONCE(vm_swappiness);
>  
> -	return memcg->swappiness;
> +	return READ_ONCE(memcg->swappiness);
>  }
>  #else
>  static inline int mem_cgroup_swappiness(struct mem_cgroup *mem)
>  {
> -	return vm_swappiness;
> +	return READ_ONCE(vm_swappiness);
>  }
>  #endif
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 06821e5f7604..dca895c66a9b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4179,9 +4179,9 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
>  		return -EINVAL;
>  
>  	if (!mem_cgroup_is_root(memcg))
> -		memcg->swappiness = val;
> +		WRITE_ONCE(memcg->swappiness, val);
>  	else
> -		vm_swappiness = val;
> +		WRITE_ONCE(vm_swappiness, val);
>  
>  	return 0;
>  }
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
