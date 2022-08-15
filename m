Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3422C5931B0
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 17:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiHOPUR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 11:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiHOPUQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 11:20:16 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE51115E
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 08:20:14 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id l8so5552898qvr.5
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=lyZgYwibx9tzRtJlNLbCd26XMkmBuOumcQ8OAPPucbg=;
        b=YNpjJEf/4VMEm5B9xVp7Zc/3JUCCu7KwjTesSoI4+6XzsgemIUvKR0QSyGpBvFShug
         3agDi7/sx0KMMGRwjNIUSg2RSHBVg9M/i246c5cNS8UZgbePBR1PVixVNZ9VdhLHXF8h
         pyIaajA/ZcivyGZKVcZsEOtvVxrkGfQDqv6Rqu8Bmri/u13C/72Zx4cYMjfpH9Jk8fgE
         Zr9AhY0jNdu+0jVXAk0F428lR6eLJ7NqwHEB8yA1Xi4G3hlMU9z+tUvmMTtVosnQSR2m
         0jBcy2ZKGUUXdP06l6Z0IpCY0Vo5R37acO2WSr6dWshFN6xZGc3eq+af27clNABV4Cth
         acDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=lyZgYwibx9tzRtJlNLbCd26XMkmBuOumcQ8OAPPucbg=;
        b=qWm1C1MwEmyvOBj8duIlJH5awPjHbIgX5lNoIH95AQCP+jguoZCf9B0pzd+vohLE4v
         36/fCmj5ka8XzQYoYqjt9s5du7nofcrxOURDRurDYL5V6cnEgTMe6wuZ4N5rJkjY7BI8
         A3WimWIra5qgZQFvIGgfcDLXgJem8Qe2UfoWkUt965Dih1WSxVPIw4/PGXvYtR21b0ts
         nmqeRxJFIJETfWDOD0MSOYp9774H7+zb5GcHaYkn1TxekQ818U0W6vufEDSBiZ2qFKo7
         s9rOcisK+cQcpZyuM1wJzQrjijhLnkufRDqQLejZgHJz+U6As+onjoR/kaL2TeoFHkQb
         0UTQ==
X-Gm-Message-State: ACgBeo1db3H4sxi3Ft6FHLG0OJvodxGfhNi08adP4tZ0qxugtNNm+CzH
        JpVCfC4iv4Z+C2077e+YjIrOqA==
X-Google-Smtp-Source: AA6agR4iIkJUTdnhfz/gdhu62lhmJFbdVp2FI8qCpT8ci83w3y14YkEorWdUMmQuNh3bUesYIOYOhA==
X-Received: by 2002:ad4:5f0a:0:b0:474:8978:9a9f with SMTP id fo10-20020ad45f0a000000b0047489789a9fmr14442429qvb.71.1660576813268;
        Mon, 15 Aug 2022 08:20:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a23e])
        by smtp.gmail.com with ESMTPSA id o2-20020ac86982000000b0033a5048464fsm8186182qtq.11.2022.08.15.08.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 08:20:12 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:20:11 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     liliguang <liliguang@baidu.com>
Cc:     cgroups@vger.kernel.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: correctly charge compressed memory to its memcg
Message-ID: <YvpkK8fwCEPGmif+@cmpxchg.org>
References: <20220811081913.102770-1-liliguang@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811081913.102770-1-liliguang@baidu.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 11, 2022 at 04:19:13PM +0800, liliguang wrote:
> From: Li Liguang <liliguang@baidu.com>
> 
> Kswapd will reclaim memory when memory pressure is high, the
> annonymous memory will be compressed and stored in the zpool
> if zswap is enabled. The memcg_kmem_bypass() in
> get_obj_cgroup_from_page() will bypass the kernel thread and
> cause the compressed memory not charged to its memory cgroup.
> 
> Remove the memcg_kmem_bypass() and properly charge compressed
> memory to its corresponding memory cgroup.
> 
> Signed-off-by: Li Liguang <liliguang@baidu.com>

Great catch. I think this qualifies for stable.

Cc: stable@vger.kernel.org # 5.19
Fixes: f4840ccfca25 ("zswap: memcg accounting")
Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Andrew, can you please take this through the MM tree?

> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b69979c9ced5..6a95ea7c5ee7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2971,7 +2971,7 @@ struct obj_cgroup *get_obj_cgroup_from_page(struct page *page)
>  {
>  	struct obj_cgroup *objcg;
>  
> -	if (!memcg_kmem_enabled() || memcg_kmem_bypass())
> +	if (!memcg_kmem_enabled())
>  		return NULL;
>  
>  	if (PageMemcgKmem(page)) {
> -- 
> 2.32.0 (Apple Git-132)
> 
