Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C291D36B1A2
	for <lists+cgroups@lfdr.de>; Mon, 26 Apr 2021 12:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhDZK3M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Apr 2021 06:29:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:43924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232253AbhDZK3J (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 26 Apr 2021 06:29:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619432906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y+BdTlZQMIKpxwvsmFV+T7kI7pphzQZM6wgqpx86rmI=;
        b=OhQ8d5C9Sv6C+l4RSem6IL0d/GyiutKfHBbMofCXXOgRiJ5YmHZveWiku3dxmmiBV79FCl
        Mac/QHVyTjP8IEv299yylS0oqD+an5CMq8x6GY/luEunnNm1D0L4wPxLavc3QcCVEGq9y9
        E7Lb3BGfaFPtJlaQq0DnFX57k0wJH9E=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F810B206;
        Mon, 26 Apr 2021 10:28:26 +0000 (UTC)
Date:   Mon, 26 Apr 2021 12:28:26 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH 1/2] ipc sem: use kvmalloc for sem_undo allocation
Message-ID: <YIaVym+Cr2Ym/kPn@dhcp22.suse.cz>
References: <e67f2a95-4b01-9db2-fe47-0b2210f0b138@virtuozzo.com>
 <722774d8-d46b-f8a6-a88e-3c56b4968622@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <722774d8-d46b-f8a6-a88e-3c56b4968622@virtuozzo.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 26-04-21 13:18:09, Vasily Averin wrote:
> size of sem_undo can exceed one page and with the maximum possible
> nsems = 32000 it can grow up to 64Kb. Let's switch its allocation
> to kvmalloc to avoid user-triggered disruptive actions like OOM killer
> in case of high-order memory shortage.

User triggerable high order allocations are quite a problem on heavily
fragmented systems. They can be a DoS vector.

> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  ipc/sem.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/ipc/sem.c b/ipc/sem.c
> index 52a6599..93088d6 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -1152,7 +1152,7 @@ static void freeary(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
>  		un->semid = -1;
>  		list_del_rcu(&un->list_proc);
>  		spin_unlock(&un->ulp->lock);
> -		kfree_rcu(un, rcu);
> +		kvfree_rcu(un, rcu);
>  	}
>  
>  	/* Wake up all pending processes and let them fail with EIDRM. */
> @@ -1935,7 +1935,7 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
>  	rcu_read_unlock();
>  
>  	/* step 2: allocate new undo structure */
> -	new = kzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems,
> +	new = kvzalloc(sizeof(struct sem_undo) + sizeof(short)*nsems,
>  		      GFP_KERNEL_ACCOUNT);
>  	if (!new) {
>  		ipc_rcu_putref(&sma->sem_perm, sem_rcu_free);
> @@ -1948,7 +1948,7 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
>  	if (!ipc_valid_object(&sma->sem_perm)) {
>  		sem_unlock(sma, -1);
>  		rcu_read_unlock();
> -		kfree(new);
> +		kvfree(new);
>  		un = ERR_PTR(-EIDRM);
>  		goto out;
>  	}
> @@ -1959,7 +1959,7 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
>  	 */
>  	un = lookup_undo(ulp, semid);
>  	if (un) {
> -		kfree(new);
> +		kvfree(new);
>  		goto success;
>  	}
>  	/* step 5: initialize & link new undo structure */
> @@ -2420,7 +2420,7 @@ void exit_sem(struct task_struct *tsk)
>  		rcu_read_unlock();
>  		wake_up_q(&wake_q);
>  
> -		kfree_rcu(un, rcu);
> +		kvfree_rcu(un, rcu);
>  	}
>  	kfree(ulp);
>  }
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
