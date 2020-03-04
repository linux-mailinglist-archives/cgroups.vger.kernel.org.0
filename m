Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEF61795C0
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 17:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgCDQxp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 11:53:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36738 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgCDQxp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Mar 2020 11:53:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id g83so2599836wme.1;
        Wed, 04 Mar 2020 08:53:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9rthIHoO9WYjIeblpibGccs1Xx6gpCOxnW4ZP2a/gaI=;
        b=FSFB3ksVA2joFhOkeDEPMJLvySl97AX2sQLQKOX3jH94yhgjIleNT/oFzy/CmPu536
         v2E6+sFEYIM5OAQoHFf7HORrKk0mcB9L01YEjXnRwH8Vg0opFbMjGJk8gHsevS3SC/E4
         oXEFYX3T3ItWHMZeYXoHnqS9W3VfbL0dwu93dZwu8megfOtUL5RYRS0QNInjpH+Teld4
         7EM612uUpU4ByW8znpqUXm+yON2cOFlVkk+ipg3xXV8aZJjHm5VyjOV5nf85hS5z9Vm1
         o5Ug59i3gwtB9CFwnMeNhIL1t692arEv3T2TW1JKF7dDhJOxes9FID6kiRm1Czooop4d
         CVqA==
X-Gm-Message-State: ANhLgQ22Bzhh/N1HfhAtsdSH72hqNToJl4ogCcasQZSZ/3gxrtLOmtgf
        KgyGP6mZ88n+qF1ecbtQ4zg=
X-Google-Smtp-Source: ADFU+vvadTAwlgWmHKFUQufY81fr5wffpBTL2DPa8yHmyED8QcKerjwMWDGiTqW5s9WFSaAyOPO1qg==
X-Received: by 2002:a1c:2d4f:: with SMTP id t76mr4412820wmt.60.1583340819177;
        Wed, 04 Mar 2020 08:53:39 -0800 (PST)
Received: from localhost (ip-37-188-250-99.eurotel.cz. [37.188.250.99])
        by smtp.gmail.com with ESMTPSA id n11sm6649329wrw.11.2020.03.04.08.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:53:38 -0800 (PST)
Date:   Wed, 4 Mar 2020 17:53:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: Make mem_cgroup_id_get_many dependent on MMU and
 MEMCG_SWAP
Message-ID: <20200304165336.GO16139@dhcp22.suse.cz>
References: <20200304142348.48167-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200304142348.48167-1-vincenzo.frascino@arm.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 04-03-20 14:23:48, Vincenzo Frascino wrote:
> mem_cgroup_id_get_many() is currently used only when MMU or MEMCG_SWAP
> configuration options are enabled. Having them disabled triggers the
> following warning at compile time:
> 
> linux/mm/memcontrol.c:4797:13: warning: ‘mem_cgroup_id_get_many’ defined
> but not used [-Wunused-function]
>  static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned
>  int n)
> 
> Make mem_cgroup_id_get_many() dependent on MMU and MEMCG_SWAP to address
> the issue.

A similar patch has been proposed recently
http://lkml.kernel.org/r/87fthjh2ib.wl-kuninori.morimoto.gx@renesas.com.
The conclusion was that the warning is not really worth adding code.

> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  mm/memcontrol.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d09776cd6e10..628cebeb4bdd 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4794,10 +4794,12 @@ static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
>  	}
>  }
>  
> +#if defined(CONFIG_MEMCG_SWAP) || defined(CONFIG_MMU)
>  static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
>  {
>  	refcount_add(n, &memcg->id.ref);
>  }
> +#endif
>  
>  static void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
>  {
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
