Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1843B8231
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 14:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbhF3MfY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 08:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbhF3MfY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Jun 2021 08:35:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8624BC061756
        for <cgroups@vger.kernel.org>; Wed, 30 Jun 2021 05:32:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a13so3404360wrf.10
        for <cgroups@vger.kernel.org>; Wed, 30 Jun 2021 05:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HUJtWNPJiBHCYwporvv4J+zIbXCE4pbnBbFi48C+38E=;
        b=jZMFEqHO9CNCmPa5FW5Q7xZIzLc/Zqmscfzxwqe5+MUEpfZYPNcp74CfU+fZHg5Bvp
         CjkLVdh9YEVGWaZViQCNJDQqFRuu0dFr0zFINCOtbwOwQYM7Ka6t/hH2mC7D+xc/IgOF
         6ErkqnvmDe6COuHc5HmXmmM9PgUQXqf7UcWyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HUJtWNPJiBHCYwporvv4J+zIbXCE4pbnBbFi48C+38E=;
        b=SpAzfdtmOc26siKjSqgd79FA7dqsdxTTEmr/zz8JJv/OFmzocKFnfc4/C1R0qsY8Gc
         NwbOGQ6zjcpkerUxZTZAXhJDjJGwg0EaWyTFMu2GaqU9CN5w5M51M1e9B0zO80Pr2LJs
         fpoVSegPpHyB5HBtBTEiJejA0FLCs6OrA+XWVQ7P4Elw3W6trIe7gilIGiYiC8p/iDgT
         91NJ0trh+hOiYlSWGkZ3wDVf8uuRpIiWA7BgOlO+uA0ifgUJu5h5ytazqww3oYE1adpC
         BToH8iFcGcK58RggelBz8LZuAbENteJlsVV7AgH9X3qCOXVpSJYKecsU5awBK1X5keij
         aHGw==
X-Gm-Message-State: AOAM530MkZebt2F3bA1+XZusnkat+mdH1RiflQsnCcrk/n9F+cbKXJ1O
        osI5c8rTt7WtYKK3IkFM/K8HVw==
X-Google-Smtp-Source: ABdhPJzubKpTl3fcp+LJcNdajbAh2dVoRapE0348qQ2NU3BYZBxvZ4uk95AgWX5+1MTJB0hBYdIWMQ==
X-Received: by 2002:a5d:6a0d:: with SMTP id m13mr38405453wru.318.1625056374034;
        Wed, 30 Jun 2021 05:32:54 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:8572])
        by smtp.gmail.com with ESMTPSA id q5sm7997791wrx.57.2021.06.30.05.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 05:32:53 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:32:52 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Hui Su <suhui@zeku.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/vmpressure: replace vmpressure_to_css() with
 vmpressure_to_memcg()
Message-ID: <YNxkdGeFu4C5T6MZ@chrisdown.name>
References: <20210630112146.455103-1-suhui@zeku.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210630112146.455103-1-suhui@zeku.com>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thanks! This looks like a reasonable cleanup.

Hui Su writes:
>We can get memcg directly form vmpr instead of vmpr->memcg->css->memcg,
>so add a new func helper vmpressure_to_memcg().
>And no code will use vmpressure_to_css(), so delete it.
>
>Signed-off-by: Hui Su <suhui@zeku.com>

Acked-by: Chris Down <chris@chrisdown.name>

>---
> include/linux/vmpressure.h | 2 +-
> mm/memcontrol.c            | 4 ++--
> mm/vmpressure.c            | 3 +--
> 3 files changed, 4 insertions(+), 5 deletions(-)
>
>diff --git a/include/linux/vmpressure.h b/include/linux/vmpressure.h
>index 6d28bc433c1c..6a2f51ebbfd3 100644
>--- a/include/linux/vmpressure.h
>+++ b/include/linux/vmpressure.h
>@@ -37,7 +37,7 @@ extern void vmpressure_prio(gfp_t gfp, struct mem_cgroup *memcg, int prio);
> extern void vmpressure_init(struct vmpressure *vmpr);
> extern void vmpressure_cleanup(struct vmpressure *vmpr);
> extern struct vmpressure *memcg_to_vmpressure(struct mem_cgroup *memcg);
>-extern struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr);
>+extern struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr);
> extern int vmpressure_register_event(struct mem_cgroup *memcg,
> 				     struct eventfd_ctx *eventfd,
> 				     const char *args);
>diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>index 64ada9e650a5..62163a9cee63 100644
>--- a/mm/memcontrol.c
>+++ b/mm/memcontrol.c
>@@ -247,9 +247,9 @@ struct vmpressure *memcg_to_vmpressure(struct mem_cgroup *memcg)
> 	return &memcg->vmpressure;
> }
>
>-struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
>+struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
> {
>-	return &container_of(vmpr, struct mem_cgroup, vmpressure)->css;
>+	return container_of(vmpr, struct mem_cgroup, vmpressure);
> }
>
> #ifdef CONFIG_MEMCG_KMEM
>diff --git a/mm/vmpressure.c b/mm/vmpressure.c
>index d69019fc3789..04e81ac6d5d8 100644
>--- a/mm/vmpressure.c
>+++ b/mm/vmpressure.c
>@@ -74,8 +74,7 @@ static struct vmpressure *work_to_vmpressure(struct work_struct *work)
>
> static struct vmpressure *vmpressure_parent(struct vmpressure *vmpr)
> {
>-	struct cgroup_subsys_state *css = vmpressure_to_css(vmpr);
>-	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>+	struct mem_cgroup *memcg = vmpressure_to_memcg(vmpr);
>
> 	memcg = parent_mem_cgroup(memcg);
> 	if (!memcg)
>-- 
>2.25.1
>
>
