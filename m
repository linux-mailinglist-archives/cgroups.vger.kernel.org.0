Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C78139E91
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2020 01:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgANAsi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jan 2020 19:48:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46202 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgANAsh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jan 2020 19:48:37 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so5522839pgb.13
        for <cgroups@vger.kernel.org>; Mon, 13 Jan 2020 16:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ANoh8uEOm+gmkt+50LunFAVjJew2LvqnFtto+wxCdzA=;
        b=EIJTvGsSDiqJOKnxxqwUUm7ON/pxRF/Iw9epIVmqhs0PtXyaeT1+6YJNK88D1q3wU1
         PGDDHVr/nHr2tKVTneq/1tZK0Lgua6Y3amEdx12flXktjw43k4MPa8GVdezL24+pJuOB
         4FzXZvW4Rokk8BUUx9dGu8wxYJkh/Cscc1wpUn3PAcCRKDQ8ZK7KEmRUEmcq67E6AJW9
         aU4xYMyBwEKfjvnbLzFzzXt0IJWxZ73lAjk6fdL0NUNBLQEVNSzPoob1CxfbPn9uL+e8
         KwDPS/hMnvImDwr5iR+h0E6Q7jyLiG8ZmM9AK3cSlTrvQMnLWltShhFSnRKb4YdORW3S
         gGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ANoh8uEOm+gmkt+50LunFAVjJew2LvqnFtto+wxCdzA=;
        b=P96b01PsLHpoEuG13LAABE9KdIutkT5CFr84K/Bt7EukBXkjhri3PI+AK3aFksPegl
         x9xqZmAb3LFxPgZrBWY2AP3jnMRvhnlMol5ex7gE87gh4OI7vepWz8LN1pPYwNPWDx+u
         KsxIJMUQOlZsVmsGuluvZgDmqQDVFe5mHoALf0Si5S4Gw85h3eyy9XQ+6IV513Ws+YSY
         mSf6qCzCT6L36vz650vLt9hvJEPQ9lTlSsJYytOKeSaeNU89OkDTEv/wJwXKAvbrs1u/
         ifZhsoyWS+gxlRGUGXWoqwknhrEdS6H79p6zV9H13jA0tPdaV2SWOf5wtKD2Vqs/onbg
         be9g==
X-Gm-Message-State: APjAAAVN5n5Xu01Q0CL2hA+KFHrMaMwclgUBbyb1o95YZTbMnNsd1wdQ
        iWQX6CdR1WjMwCOIynp/2Fym1w==
X-Google-Smtp-Source: APXvYqyPYQdmGDDkV8IAUUEG/A+rUbsnIqabZaWz7RE4Jt4GCpQM28LKvdsUgn9QB5r73njTXVY3VA==
X-Received: by 2002:a65:5788:: with SMTP id b8mr23688309pgr.324.1578962916999;
        Mon, 13 Jan 2020 16:48:36 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z11sm16093204pfk.96.2020.01.13.16.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:48:36 -0800 (PST)
Date:   Mon, 13 Jan 2020 16:48:35 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mina Almasry <almasrymina@google.com>
cc:     mike.kravetz@oracle.com, shuah@kernel.org, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, mkoutny@suse.com
Subject: Re: [PATCH v9 6/8] hugetlb_cgroup: support noreserve mappings
In-Reply-To: <20191217231615.164161-6-almasrymina@google.com>
Message-ID: <alpine.DEB.2.21.2001131646490.164268@chino.kir.corp.google.com>
References: <20191217231615.164161-1-almasrymina@google.com> <20191217231615.164161-6-almasrymina@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 17 Dec 2019, Mina Almasry wrote:

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 39eb2fa53a420..3e94f5c2d7cd4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1367,6 +1367,9 @@ void free_huge_page(struct page *page)
>  	clear_page_huge_active(page);
>  	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
>  				     page, false);
> +	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
> +				     page, true);
> +
>  	if (restore_reserve)
>  		h->resv_huge_pages++;
> 
> @@ -2189,10 +2192,19 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  			gbl_chg = 1;
>  	}
> 
> +	/* If this allocation is not consuming a reservation, charge it now.
> +	 */
> +	if (map_chg || avoid_reserve || !vma_resv_map(vma)) {

These conditions are checked three times in this function, maybe better 
set a bool on the stack and use it throughout the function to guarantee it 
remains consistent?

bool deferred_reserve = !vma_resv_map(vma) || map_chg || avoid_reserve;

> +		ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h),
> +						   &h_cg, true);
> +		if (ret)
> +			goto out_subpool_put;
> +	}
> +
>  	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg,
>  					   false);
>  	if (ret)
> -		goto out_subpool_put;
> +		goto out_uncharge_cgroup_reservation;
> 
>  	spin_lock(&hugetlb_lock);
>  	/*
> @@ -2216,6 +2228,14 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  	}
>  	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page,
>  				     false);
> +	/* If allocation is not consuming a reservation, also store the
> +	 * hugetlb_cgroup pointer on the page.
> +	 */
> +	if (!vma_resv_map(vma) || map_chg || avoid_reserve) {
> +		hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg,
> +					     page, true);
> +	}
> +
>  	spin_unlock(&hugetlb_lock);
> 
>  	set_page_private(page, (unsigned long)spool);
> @@ -2241,6 +2261,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  out_uncharge_cgroup:
>  	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg,
>  				       false);
> +out_uncharge_cgroup_reservation:
> +	if (map_chg || avoid_reserve || !vma_resv_map(vma))
> +		hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h),
> +					       h_cg, true);
>  out_subpool_put:
>  	if (map_chg || avoid_reserve)
>  		hugepage_subpool_put_pages(spool, 1);
> --
> 2.24.1.735.g03f4e72817-goog
> 
