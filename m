Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0DE5118A6D
	for <lists+cgroups@lfdr.de>; Tue, 10 Dec 2019 15:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfLJOID (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Dec 2019 09:08:03 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54723 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfLJOIC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Dec 2019 09:08:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so3370758wmj.4;
        Tue, 10 Dec 2019 06:08:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JOrvgpzri55cuZvf0g5PJCe5RKiv3DNl9WA35jfmGNA=;
        b=DSej2cweNQWw6uTscZM7qcb25ALpLf/tDJRAYj8JtC/wTfvacTpba+CjexejWWLsUO
         fkHcNqY+mCOh7t6E5b+t4kMnpj3eyu9YILOJDn6/t6IE//G2B3oIzPCgeSD2dArfZQ5a
         Ie0x1Bg7o2ci+rI2W0dM7f4OusB0TmeCe8kDA7879zadlFDbudXlmorZ2go5VVM3pn8H
         zVDp0K9Ds6O5GJA8Pr9UYvJfjoHTtP8RVRo/Q+0MxNZONotithdZ+An5EQ2m5bAWeHxl
         Q9aZlO0qtFjrS0LMHFaPsffDHMYGH0ImLeSYr7Cn+9l8TCmjUqTII1uSjc1yK7WvEwYu
         Gpxg==
X-Gm-Message-State: APjAAAUqG2xJjbLV2TD5mkHEwl3C3Zf8Oscn4r9mlgPAKb2nq0iAfeW6
        K65X47ktUlRZclxoNCKBxb+slMXv
X-Google-Smtp-Source: APXvYqwJtpMeRV9/dPQzUGGfgWCOqNHmCdtyqiAq1hNDJDJIwLpsBTZ3tqq0TEvFOmuvp5V761VrHw==
X-Received: by 2002:a1c:7e13:: with SMTP id z19mr5424339wmc.67.1575986880429;
        Tue, 10 Dec 2019 06:08:00 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id b17sm3383425wrp.49.2019.12.10.06.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 06:07:59 -0800 (PST)
Date:   Tue, 10 Dec 2019 15:07:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     chengkaitao <pilgrimtao@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, smuchun@gmail.com
Subject: Re: [PATCH] mm: cleanup some useless code
Message-ID: <20191210140758.GK10404@dhcp22.suse.cz>
References: <20191210134911.2570-1-pilgrimtao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210134911.2570-1-pilgrimtao@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 10-12-19 05:49:10, chengkaitao wrote:
> From: Kaitao Cheng <pilgrimtao@gmail.com>
> 
> There is a duplicate PageTransHuge, because hpage_nr_pages have
> the same one.

I am not a great fan of changes like these - a minor code churn without
a clear benefit - but in this particular case I do agree that there is
an improvement because we have two states to represent the same thing.
I have hard time believing this makes a more optimal code as
PageTransHuge is a trivial check so it doesn't make much sense to
replicate the state locally.

That being said the changelog could be improved a bit. What about
something like the following?
"
Compound pages handling in mem_cgroup_migrate is more convoluted than
necessary. The state is duplicated in compound variable and the same
could be achieved by PageTransHuge check which is trivial and
hpage_nr_pages is already PageTransHuge aware.

It is much simpler to just use hpage_nr_pages for nr_pages and replace
the local variable by PageTransHuge check directly
"

> Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>

To the change
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> ---
>  mm/memcontrol.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index bc01423277c5..870284d3ee9d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6678,7 +6678,6 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
>  {
>  	struct mem_cgroup *memcg;
>  	unsigned int nr_pages;
> -	bool compound;
>  	unsigned long flags;
>  
>  	VM_BUG_ON_PAGE(!PageLocked(oldpage), oldpage);
> @@ -6700,8 +6699,7 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
>  		return;
>  
>  	/* Force-charge the new page. The old one will be freed soon */
> -	compound = PageTransHuge(newpage);
> -	nr_pages = compound ? hpage_nr_pages(newpage) : 1;
> +	nr_pages = hpage_nr_pages(newpage);
>  
>  	page_counter_charge(&memcg->memory, nr_pages);
>  	if (do_memsw_account())
> @@ -6711,7 +6709,8 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
>  	commit_charge(newpage, memcg, false);
>  
>  	local_irq_save(flags);
> -	mem_cgroup_charge_statistics(memcg, newpage, compound, nr_pages);
> +	mem_cgroup_charge_statistics(memcg, newpage, PageTransHuge(newpage),
> +			nr_pages);
>  	memcg_check_events(memcg, newpage);
>  	local_irq_restore(flags);
>  }
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
