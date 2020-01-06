Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14C30131081
	for <lists+cgroups@lfdr.de>; Mon,  6 Jan 2020 11:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgAFKXt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Jan 2020 05:23:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36201 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgAFKXt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Jan 2020 05:23:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so49039737wru.3;
        Mon, 06 Jan 2020 02:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tgQqBIy5e4I6Hz0oQb/zzwQhBn/pQ2qSqWeoeZ4EV+A=;
        b=OOTKCqhw1m5BZpT+BniTblllck8ZYoLhXSLPT9z7E529OUnpLbQzgHE61rHwabB5kK
         Is9FnkWQV3JG/h+5vqJpK/pNYarHhF4q8skejgE7f947+HdblrU4Ev6IQmrDEYZ0tikq
         28s+4sUXaYwzzQf8T9LHm0WQVZl8Z886sysfDOiqprlYjZocMsUKYrIg3GZ7dGcaue6s
         3XLVdGmRw7ARtyYlZknUAFdq2WLx2TOaMrkTwfqAyZ/cOjsIiJVJOSbJ/7i/GQdhW8S4
         6UgwcCEdOBjkOOSJzj/4ckAqya7yYxNCf+/nuLL9XGIcTzakHA54HmOmxYiGJ6Gd2OWW
         XGzQ==
X-Gm-Message-State: APjAAAVg378976ZNvO+x+dXtk4qNWSbFAZisPvgXI7kMiDz/hj7u0ESH
        0HFNRv5JGsSPJtMrQxtaVUs=
X-Google-Smtp-Source: APXvYqxIQDabJmEtH66y7KFu1WXendyZo1xIk9Vx2c9iiJQtk3BzNbZz+qSNwvvtCXbBwLWXMkNuPw==
X-Received: by 2002:adf:82f3:: with SMTP id 106mr105334001wrc.69.1578306226841;
        Mon, 06 Jan 2020 02:23:46 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id u1sm22257183wmc.5.2020.01.06.02.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 02:23:46 -0800 (PST)
Date:   Mon, 6 Jan 2020 11:23:45 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [RFC PATCH] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200106102345.GE12699@dhcp22.suse.cz>
References: <20200103143407.1089-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103143407.1089-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 03-01-20 22:34:07, Wei Yang wrote:
> As all the other places, we grab the lock before manipulate the defer list.
> Current implementation may face a race condition.

Please always make sure to describe the effect of the change. Why a racy
list_empty check matters?

> Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware")
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> 
> ---
> I notice the difference during code reading and just confused about the
> difference. No specific test is done since limited knowledge about cgroup.
> 
> Maybe I miss something important?
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

-- 
Michal Hocko
SUSE Labs
