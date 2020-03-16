Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76F75186DFE
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2020 15:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbgCPO71 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Mar 2020 10:59:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50341 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731629AbgCPO71 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Mar 2020 10:59:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id z13so1971913wml.0;
        Mon, 16 Mar 2020 07:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4FvxAgszQ++g/zBJBmYryRtulzv92eq2k64hW2XTxyI=;
        b=KJ8dn3BzFIyRA9SGk+20C70HQStvMy0R6edJhIefx0BKO6p40F9Odbb6/uK3VZGdWi
         gMXr5hFNeJ9gFLQIFMaI5DI1X8eskmWZ4q5ySvDKSB/dp+mZQ8ezXTU3qDC/Agq64pFJ
         MEBT4pIJo4ebRc4lLVKSV5AATOR19zBpQdHcgYFsVFZS0eE5SYuM1yZnEgWy9Yj7Rb3O
         j/2JbOz0s6Mnyuj6+K0C+DDptrSZmQuTlBQeiH5dAJ/Nh7xXZvVVa7/x0pwjCJFgfpyW
         TC+sdTNkRQ1azPgzVcasNShQnW3BZNtOu2pjMtLhq+eQuVSTklUNhSaCCkQTj6iljOY+
         1ClA==
X-Gm-Message-State: ANhLgQ1mAU7FCjSvuAWuxkvOCMAEDvkj+IzexIveITSPjXbJdT7DGV4q
        pETQgri0MYMN2CpXmXE67+M=
X-Google-Smtp-Source: ADFU+vsmj1xkbZ9kxBp+/4xkXEym15gDWpWFuxQ0MIWoC15PvOzXSMYHNNI+AHLL8TfC9S/gjtvdjg==
X-Received: by 2002:a7b:c75a:: with SMTP id w26mr10572063wmk.2.1584370765264;
        Mon, 16 Mar 2020 07:59:25 -0700 (PDT)
Received: from localhost ([37.188.132.163])
        by smtp.gmail.com with ESMTPSA id i67sm256021wri.50.2020.03.16.07.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:59:24 -0700 (PDT)
Date:   Mon, 16 Mar 2020 15:59:23 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 6/6] mm, memcg: Prevent mem_cgroup_protected store tearing
Message-ID: <20200316145923.GR11482@dhcp22.suse.cz>
References: <cover.1584034301.git.chris@chrisdown.name>
 <d1e9fbc0379fe8db475d82c8b6fbe048876e12ae.1584034301.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1e9fbc0379fe8db475d82c8b6fbe048876e12ae.1584034301.git.chris@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 12-03-20 17:33:16, Chris Down wrote:
> The read side of this is all protected, but we can still tear if
> multiple iterations of mem_cgroup_protected are going at the same time.
> 
> There's some intentional racing in mem_cgroup_protected which is ok, but
> load/store tearing should be avoided.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@fb.com

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 57048a38c75d..e9af606238ab 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6301,8 +6301,8 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>  	}
>  
>  exit:
> -	memcg->memory.emin = emin;
> -	memcg->memory.elow = elow;
> +	WRITE_ONCE(memcg->memory.emin, emin);
> +	WRITE_ONCE(memcg->memory.elow, elow);
>  
>  	if (usage <= emin)
>  		return MEMCG_PROT_MIN;
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
