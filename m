Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A645A1227F4
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2019 10:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfLQJxc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Dec 2019 04:53:32 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51717 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfLQJxc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Dec 2019 04:53:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id d73so2251805wmd.1;
        Tue, 17 Dec 2019 01:53:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o5H78lmOFlfOdJKIlFL+etqdkLu7Sq64ZBZTXREj8QE=;
        b=LvaAsyGHnNjgHx+z4CH0aMa55ZK0d2BedRvwRcH8wmoUmxFvllvjFZnYHODqaqah9e
         e27UsaAm1hXsNTFbUI73HSmpQ0U2i191BSru7VL92y6YR0NEzdswAESiBvPuNfIeB4cD
         Y+/824OlajYfkk6/qgtd4tqTXVjES2l9o/jvJxpgHGDzvEb+zcayk+GqxFPAZHesFNZJ
         N2wM8sv3mR/YVHyVHeZ19iH+vqDD/HvospB9aNN9Fka+2wCnR0Zurfaz5AU+gmrOm7Nm
         VhJ2sxrDAM6TBN2FGVytcipcdgDMHIQllgAtgs5uNrc5g8c0YstIr/NCxBgbxlB/HIR8
         EZEA==
X-Gm-Message-State: APjAAAV3Rrt/YVb2W1bLU+1hR7JD2EKb1OarLICsFR4YGUeaQc0KiZ/Q
        b9CsvrQecbtXuVC33VFyX+A=
X-Google-Smtp-Source: APXvYqwR57vUhgJ1DahqMNJVmeW0KAEB6xrA7+hS53GMuCH7lnSLkqx0ooT/uxz+bl1I2z2k1Lzhbg==
X-Received: by 2002:a1c:9a52:: with SMTP id c79mr4337529wme.127.1576576410868;
        Tue, 17 Dec 2019 01:53:30 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id i5sm2359682wml.31.2019.12.17.01.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 01:53:30 -0800 (PST)
Date:   Tue, 17 Dec 2019 10:53:29 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under
 CONFIG_MMU
Message-ID: <20191217095329.GD31063@dhcp22.suse.cz>
References: <87fthjh2ib.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fthjh2ib.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 17-12-19 15:47:40, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> mem_cgroup_id_get_many() is used under CONFIG_MMU.

Not really. It is used when SWAP is enabled currently. But it is not
really bound to the swap functionality by any means. It just happens
that we do not have other users currently. We might put it under
CONFIG_SWAP but I do not really think it is a big improvement.

> This patch moves it to under CONFIG_MMU.
> We will get below warning without this patch
> if .config doesn't have CONFIG_MMU.
> 
> 	LINUX/mm/memcontrol.c:4814:13: warning: 'mem_cgroup_id_get_many'\
> 		defined but not used [-Wunused-function]
> 	static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
> 	^~~~~~~~~~~~~~~~~~~~~~

Is this warning really a big deal? The function is not used, alright,
and the compiler will likely just drop it.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  mm/memcontrol.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c5b5f74..8a157ef 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4811,11 +4811,6 @@ static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
>  	}
>  }
>  
> -static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
> -{
> -	refcount_add(n, &memcg->id.ref);
> -}
> -
>  static void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
>  {
>  	if (refcount_sub_and_test(n, &memcg->id.ref)) {
> @@ -5153,6 +5148,11 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
>  }
>  
>  #ifdef CONFIG_MMU
> +static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
> +{
> +	refcount_add(n, &memcg->id.ref);
> +}
> +
>  /* Handlers for move charge at task migration. */
>  static int mem_cgroup_do_precharge(unsigned long count)
>  {
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
