Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07CE212FD08
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2020 20:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgACT3K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jan 2020 14:29:10 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44902 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbgACT3I (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jan 2020 14:29:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id az3so19357265plb.11
        for <cgroups@vger.kernel.org>; Fri, 03 Jan 2020 11:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xiCyHmcnUXsbcQ7aHolyREhLRtQlcm0tNcQpv0xj54g=;
        b=otHt/I+pw8YEKdneORJaQbqVOMxTvFzuxsTLLo7ZOfnkm7+sA/s/x+b5ZiwnwdyNsM
         mfRl/YbfDdxHzR2Rfe0dAizN3JrCsQ76Os4SjYyo9S1ECVmqUOML8K8S/YBi5lHfUumH
         I5sRO4W4LYYWzpp+g2tfXYM8x+1i2fRx+TVLGkGcDO7rAoq4BzN5giqoCdnq10C+hw+o
         NVmD4trJFm7qSbm58YTvtBPmdSOVfFH9OlPvaUYGTkLBuR4W1QJa14C5GlU267SLGDIk
         nJvj1z52hjwCB/qZkkakQbkJqE7ovBP/lPjUGrjm7HuF9J8UTNwBPO9jMGL9+KBvpBx7
         97Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xiCyHmcnUXsbcQ7aHolyREhLRtQlcm0tNcQpv0xj54g=;
        b=LlZjN7IW6K+g1dhH66BA8oFtM223opCtecP4ucn2oalA6OR8G8zzX2fvFu7fLMQQ0j
         gPJAAtj7hAwPobzHuz9mH+CR6LgCBTIoLDcFw85kF0U8z4cHAvojRVuVvGSiY+6ysgOS
         YicS6fjby504c7PLMS5rDzI7woHWVWAfYYnKegd95iMyC6eO/LhzY3ZYlGjNoNSwxoPk
         vBbQzDnETx9XeDiqqPC/UDOvtIOU+ItCvVNZAqtG2vOpHKreqxdeLmiS/zfNG7SdFhtG
         o3fbrptqbiGEkdao95vS8C6L14vXqkXuecvNrBowyuvr8bMWaHCE3TJMtzIwyVTW/s4A
         FG5Q==
X-Gm-Message-State: APjAAAVU5ZZlSNloJV2rkld40dvwgVM1KZrMQpcWuvw7b5zCsokS9sxi
        MnuOqVnpKOcgbu4Fftf4Hqd8lA==
X-Google-Smtp-Source: APXvYqwNpsVSpllqMOsBw0KVEfj6ixi9vpK94YoxKUCK8BvVN+K2rt+0zmH9iLuSgofxUQodtrJbFA==
X-Received: by 2002:a17:902:9a42:: with SMTP id x2mr15707448plv.194.1578079747357;
        Fri, 03 Jan 2020 11:29:07 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id u23sm68353574pfm.29.2020.01.03.11.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 11:29:06 -0800 (PST)
Date:   Fri, 3 Jan 2020 11:29:06 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [RFC PATCH] mm: thp: grab the lock before manipulation defer
 list
In-Reply-To: <20200103143407.1089-1-richardw.yang@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2001031128200.160920@chino.kir.corp.google.com>
References: <20200103143407.1089-1-richardw.yang@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 3 Jan 2020, Wei Yang wrote:

> As all the other places, we grab the lock before manipulate the defer list.
> Current implementation may face a race condition.
> 
> Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware")
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> 
> ---
> I notice the difference during code reading and just confused about the
> difference. No specific test is done since limited knowledge about cgroup.
> 
> Maybe I miss something important?

The check for !list_empty(page_deferred_list(page)) must certainly be 
serialized with doing list_del_init(page_deferred_list(page)).

> ---
>  mm/memcontrol.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index bc01423277c5..62b7ec34ef1a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5368,12 +5368,12 @@ static int mem_cgroup_move_account(struct page *page,
>  	}
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	spin_lock(&from->deferred_split_queue.split_queue_lock);
>  	if (compound && !list_empty(page_deferred_list(page))) {
> -		spin_lock(&from->deferred_split_queue.split_queue_lock);
>  		list_del_init(page_deferred_list(page));
>  		from->deferred_split_queue.split_queue_len--;
> -		spin_unlock(&from->deferred_split_queue.split_queue_lock);
>  	}
> +	spin_unlock(&from->deferred_split_queue.split_queue_lock);
>  #endif
>  	/*
>  	 * It is safe to change page->mem_cgroup here because the page
> @@ -5385,13 +5385,13 @@ static int mem_cgroup_move_account(struct page *page,
>  	page->mem_cgroup = to;
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	spin_lock(&to->deferred_split_queue.split_queue_lock);
>  	if (compound && list_empty(page_deferred_list(page))) {
> -		spin_lock(&to->deferred_split_queue.split_queue_lock);
>  		list_add_tail(page_deferred_list(page),
>  			      &to->deferred_split_queue.split_queue);
>  		to->deferred_split_queue.split_queue_len++;
> -		spin_unlock(&to->deferred_split_queue.split_queue_lock);
>  	}
> +	spin_unlock(&to->deferred_split_queue.split_queue_lock);
>  #endif
>  
>  	spin_unlock_irqrestore(&from->move_lock, flags);
> -- 
> 2.17.1
> 
> 
> 
