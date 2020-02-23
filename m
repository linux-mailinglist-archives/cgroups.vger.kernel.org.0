Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 080E516998C
	for <lists+cgroups@lfdr.de>; Sun, 23 Feb 2020 20:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgBWTJS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 23 Feb 2020 14:09:18 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43552 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBWTJS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 23 Feb 2020 14:09:18 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so6756498oth.10
        for <cgroups@vger.kernel.org>; Sun, 23 Feb 2020 11:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=htLN1mwGdJtRnyqYUCPJp+OPGglRrhjiWXYVtDt/NKM=;
        b=JSZ7Tv7F6nQ3YH2jP3HFLdPAhZhy2Y/RM9Au69XuF7TR0GzciTC0aj+0Tv4uRV+9XJ
         S4Wu6jcRiaRdgV38hOL3giTmwn97IzhRnjQRKVCoYK+wbKxwIa24ektK26DJ43CkLtwN
         ZT9IiL8y9//RQ99zTTNcqBJXNSogX2r+AwY/uH8cqaruxnp5gzlWpx+9El5byimG0jnA
         gwXKIGTFa3/cNEDFtAyjXJOHNCZOiszkR89nBIjCVQRfXSF+Sr/HRB0GuxP8BmqtZijN
         wiRvUQvVfqVjVfedH3LtBOG9DpYU+DUoB1Db0YG0GDCRe4xQFuaaRpiYbX5PICYUsE9L
         PPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=htLN1mwGdJtRnyqYUCPJp+OPGglRrhjiWXYVtDt/NKM=;
        b=YRGWmD0/J+UnDB0f/wnA1u1gk+Eja+GKg5gh6zWr5HWmi4ws5J8oKegjjIWPQ1M+Jq
         dBlY/56Xs05xI562QGMVZ2vVTdWzMtbbtIciTlPaFvtsuEQbdk1Kt6C6Eya48rRBbhoN
         zFHFj85IxC5PCNVyHsvDqqyBo604TlWK2HB5ioKXLAUdqQvwlazzx8zjUyJ1npLmJKDR
         YNiMXbdZgisQjshFg8JeKopLZuhFO7TNCykUkw23FEz1c74r7AfQcqmYz4XbdsMHhljU
         FY5tJFX29Ope0DNfzXzUh8wC7R+v9ysN2C5NHvUPH7XClPJnat4v42D+WiEsKECF+gZM
         IN6w==
X-Gm-Message-State: APjAAAVf2C1V2vPtuWVhvgksvbQAtDyJqujQzkheStxxqFugjokTAKCM
        TTjTg75qa9VjDWD4yiWznDr4fQ==
X-Google-Smtp-Source: APXvYqy/p/O4TAQu54lEWny6r9jlQDTbURDNigwuqgFSiLk69KhcFalHKOOJrks6IaVeMj9w1BHaEg==
X-Received: by 2002:a9d:5786:: with SMTP id q6mr36062007oth.164.1582484957514;
        Sun, 23 Feb 2020 11:09:17 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i6sm3575702oto.62.2020.02.23.11.09.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Feb 2020 11:09:16 -0800 (PST)
Date:   Sun, 23 Feb 2020 11:08:56 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v3 2/3] mm: Charge active memcg when no mm is set
In-Reply-To: <0a27b6fcbd1f7af104d7f4cf0adc6a31e0e7dd19.1582216294.git.schatzberg.dan@gmail.com>
Message-ID: <alpine.LSU.2.11.2002231058520.5735@eggly.anvils>
References: <cover.1582216294.git.schatzberg.dan@gmail.com> <0a27b6fcbd1f7af104d7f4cf0adc6a31e0e7dd19.1582216294.git.schatzberg.dan@gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 20 Feb 2020, Dan Schatzberg wrote:

> memalloc_use_memcg() worked for kernel allocations but was silently
> ignored for user pages.
> 
> This patch establishes a precedence order for who gets charged:
> 
> 1. If there is a memcg associated with the page already, that memcg is
>    charged. This happens during swapin.
> 
> 2. If an explicit mm is passed, mm->memcg is charged. This happens
>    during page faults, which can be triggered in remote VMs (eg gup).
> 
> 3. Otherwise consult the current process context. If it has configured
>    a current->active_memcg, use that. Otherwise, current->mm->memcg.
> 
> Previously, if a NULL mm was passed to mem_cgroup_try_charge (case 3) it
> would always charge the root cgroup. Now it looks up the current
> active_memcg first (falling back to charging the root cgroup if not
> set).
> 
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Tejun Heo <tj@kernel.org>

Acked-by: Hugh Dickins <hughd@google.com>

Yes, internally we have some further not-yet-upstreamed complications
here (mainly, the "memcg=" mount option for all charges on a tmpfs to
be charged to that memcg); but what you're doing here does not obstruct
adding that later, they fit in well with the hierarchy that you (and
Johannes) mapped out above, and it's really an improvement for shmem
not to be referring to current there - thanks.

> ---
>  mm/memcontrol.c | 11 ++++++++---
>  mm/shmem.c      |  2 +-
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6f6dc8712e39..b174aff4f069 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6317,7 +6317,8 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>   * @compound: charge the page as compound or small page
>   *
>   * Try to charge @page to the memcg that @mm belongs to, reclaiming
> - * pages according to @gfp_mask if necessary.
> + * pages according to @gfp_mask if necessary. If @mm is NULL, try to
> + * charge to the active memcg.
>   *
>   * Returns 0 on success, with *@memcgp pointing to the charged memcg.
>   * Otherwise, an error code is returned.
> @@ -6361,8 +6362,12 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
>  		}
>  	}
>  
> -	if (!memcg)
> -		memcg = get_mem_cgroup_from_mm(mm);
> +	if (!memcg) {
> +		if (!mm)
> +			memcg = get_mem_cgroup_from_current();
> +		else
> +			memcg = get_mem_cgroup_from_mm(mm);
> +	}
>  
>  	ret = try_charge(memcg, gfp_mask, nr_pages);
>  
> diff --git a/mm/shmem.c b/mm/shmem.c
> index c8f7540ef048..7c7f5acf89d6 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1766,7 +1766,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  	}
>  
>  	sbinfo = SHMEM_SB(inode->i_sb);
> -	charge_mm = vma ? vma->vm_mm : current->mm;
> +	charge_mm = vma ? vma->vm_mm : NULL;
>  
>  	page = find_lock_entry(mapping, index);
>  	if (xa_is_value(page)) {
> -- 
> 2.17.1
