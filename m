Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFED83691D9
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 14:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242302AbhDWMRf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Apr 2021 08:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhDWMRe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Apr 2021 08:17:34 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519BEC061574
        for <cgroups@vger.kernel.org>; Fri, 23 Apr 2021 05:16:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id sd23so64935926ejb.12
        for <cgroups@vger.kernel.org>; Fri, 23 Apr 2021 05:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PP0ysUhYjdRjB3qzEj6pxo2eA4EOFmjxvGzVl7hdO64=;
        b=uK+jkwPaElZVorVWXDD4sC43dZn846Dl9yzOnsSJyfBmB9jPPX0t0pb16/OqyIws/i
         TBXB6rOc+TrBtKvb2pjUsuN0YKiE6l1SCnLKoUuT3nc+NgodmwpE2mTjXTrazdV4q735
         JZ2q44hvcYgrE344g5ziRSL3LVPwQa2aVS2iE90BDeZ587q9cIwFTYtAb5+El8m54V4b
         xstBXGETIAunVVZEjfR52xXcucQaZvnh/uF5OBHoU1pobiGmBZIhl3tLb7oEWyLWqVxl
         gcwlGqXo1AGs94EPpobKGApNOkSbKG9RRB1kPZf8ZgCrA0m3bytJMjKAzCBiqQYxVKcg
         W/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PP0ysUhYjdRjB3qzEj6pxo2eA4EOFmjxvGzVl7hdO64=;
        b=ZguvlwVneX2rYhcAk1GBRRLFE7W3RDzgi99lRnMfnMmklKtZP0C6wpdKd0Pyn/bc+Z
         wy+qRXMX7lP6FAwbT8eIlahTvBv12oNCD9YiXLwfIxCFXgx9xDi7pTMIoOqWD1WtQN9R
         /ZmTNwVmkwilPiCN9/NmpZauWD8L77pZnFaXhuxnkbzYoa8rJDjt8SfW+jGYFXtVUbzT
         NE1bxPN5Ysz4+cP2OiAe4RnPuOVMl4uHGgY1vt2K3xaerIG0fd/jElN3XEFvlda9Ng/Z
         wc2HjpkOoMv8AITbpC1/yVdLJUv6qMo89PAI8UqKn7b6KMyvpxTAgWKO83Ju4d590jbU
         5tJg==
X-Gm-Message-State: AOAM530r51lWy6mhRxJ1YC4pt5rwFJr1G/OYvi8qsHRjRwyjUJ0c3b1Q
        k6fnEDHqO4kY6CD6J2qVcQ==
X-Google-Smtp-Source: ABdhPJzyoRovQnAqEoynuC5zkiB5Woejp4Ox0YGMSh9hOaLpT3hgnJtlRAv4APixKLRiqjOHsN23GQ==
X-Received: by 2002:a17:906:4407:: with SMTP id x7mr3889823ejo.546.1619180217123;
        Fri, 23 Apr 2021 05:16:57 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.145])
        by smtp.gmail.com with ESMTPSA id p7sm3853374eja.103.2021.04.23.05.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 05:16:56 -0700 (PDT)
Date:   Fri, 23 Apr 2021 15:16:54 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH v3 08/16] memcg: enable accounting of ipc resources
Message-ID: <YIK6ttdnfjOo6XCN@localhost.localdomain>
References: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
 <4ed65beb-bda3-1c93-fadf-296b760a32b2@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ed65beb-bda3-1c93-fadf-296b760a32b2@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 22, 2021 at 01:37:02PM +0300, Vasily Averin wrote:
> When user creates IPC objects it forces kernel to allocate memory for
> these long-living objects.
> 
> It makes sense to account them to restrict the host's memory consumption
> from inside the memcg-limited container.
> 
> This patch enables accounting for IPC shared memory segments, messages
> semaphores and semaphore's undo lists.

> --- a/ipc/msg.c
> +++ b/ipc/msg.c
> @@ -147,7 +147,7 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
>  	key_t key = params->key;
>  	int msgflg = params->flg;
>  
> -	msq = kvmalloc(sizeof(*msq), GFP_KERNEL);
> +	msq = kvmalloc(sizeof(*msq), GFP_KERNEL_ACCOUNT);

Why this requires vmalloc? struct msg_queue is not big at all.

> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -619,7 +619,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>  			ns->shm_tot + numpages > ns->shm_ctlall)
>  		return -ENOSPC;
>  
> -	shp = kvmalloc(sizeof(*shp), GFP_KERNEL);
> +	shp = kvmalloc(sizeof(*shp), GFP_KERNEL_ACCOUNT);

Same question.
Kmem caches can be GFP_ACCOUNT by default.
