Return-Path: <cgroups+bounces-9793-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A449B49A1C
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 21:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B69F189320D
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 19:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3A22BE03C;
	Mon,  8 Sep 2025 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FC3uL0hO"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD142BE02D
	for <cgroups@vger.kernel.org>; Mon,  8 Sep 2025 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757360396; cv=none; b=DGDyH1DpPMObzX8fGOXO8O4PvFPbMaIDGYZVgkzzxH+FJL4OWhhmvCCtnxq6wsRU0FQbJr1jWF9R9vBi4zhbpifmMnCzhrFfRI3IduLobEFtnXz0rV6HfifMW4l5YUG9PTQZ569Coe2es/Ry7z8v40aWoYKtEVuzJJeVRHkyhmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757360396; c=relaxed/simple;
	bh=Z6paFJhNTidT8MKCbxK18b70p4XwvefWAdW0zLyvy/E=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V8L6+hhm2/pDpK8qo4D9faDkpC6eexEjSAh27GdI+/uDYHHpSABJ9Km2B+HVPNUUPsN2RBLTkVA2P76jBlsK1d6tJITJJY17EH+g+N3fRbKZJfs7CeZceFYlXwh295S96/7zLD9sO2vLFaB8Uwrqx62mmawxjPCq4Lyl2D6r3Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FC3uL0hO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757360393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/aX3byPNwjOrefX/Ze0c+Xn6noS1O8s1wAPMr1quzQ=;
	b=FC3uL0hOhHsFjUd7ug8Zwzl3M7okj6h6AhQEIcnhEgeFm4NMWpCMdxSeyTGUlT+fQYwVhJ
	AqpYxXmOVLXvun3rFxRry4QG+2LU0wOJOlrxP+bjokiTVkmwTfO6r8KcTThK5bQWjVICGY
	xlgTcgB0dmgsOZ9jATWI42Bo/Bs1THA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-oBh3VBfkP7mYNpqFHErO7A-1; Mon, 08 Sep 2025 15:39:52 -0400
X-MC-Unique: oBh3VBfkP7mYNpqFHErO7A-1
X-Mimecast-MFC-AGG-ID: oBh3VBfkP7mYNpqFHErO7A_1757360391
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b47b4d296eso121616271cf.1
        for <cgroups@vger.kernel.org>; Mon, 08 Sep 2025 12:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757360391; x=1757965191;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/aX3byPNwjOrefX/Ze0c+Xn6noS1O8s1wAPMr1quzQ=;
        b=shBWcE/ry8qw1i0W+wIM5rhMzvEFekWgAJdwiNsQ6B5KLVszImwVAxy7l3G7IgHZsR
         9X8A0zY69PW4euq+3v7nw6uZeMYQtT/kaVGxS/QdoLVNr915vO1etCDF6d9rEwofT3Hc
         d6RzhWywxiYcOjQWkV9Amor0lktO3Ovu1vlmkITw6Jel8zy4JCNBX6MXKoew20p450P9
         nVqzyRgbwuoXrlcGtLynBfn3TWSEPVgx7X8Q+HHZn8IP7LLEqbru+Um3zhsPKAA4rPcK
         V1lCO7AR4GNgHiMjAGHd4QmvruAfH6UKAbg8Lx1jH7+fqevSKSRhoNOBKopYEs0hXiWr
         /s6g==
X-Gm-Message-State: AOJu0YzubnACcD1kLf2WopMEokEL9IrbkFpeOkrarejnatWD+6B2ghiy
	o8FNaAn7IfvPlKUcik8Kt+CVdIbmMvdTBWukqJ/IIJlwE41H2Q6pmdki/ZGjztHM1Z4SZw/pjYP
	G33Mv8X0TxKeUnVLOLfHv7y5/gSMVHjusq1hSpPft0K7v1mC6rtHxBZcQibRce98/6lg=
X-Gm-Gg: ASbGnct2wes0Ga8P4gvnuQ43THeA+RfLztwSy8Q5GVC7EsePFA37UOouXMHi8FAsHxU
	EnEbdxavqI7noQv/Dtw6EZAhLPqpnzgVpteR898XdPYzZWUPW90nyJdpwRbkN3NuFsKZfaXPYfd
	3n4Wb7Hk/JMz0LGS9mO7p3vNP1zScNRzwG2HLIyJyJMin9+5Q1UExJiBoJR6c1GbEzXtf8GCyF2
	mit//qz6p4I2uWqjjrtrftuoIQWrKUefVI+n/vv5X5lsqtDbnADqGlIt711D3v4veCFVfz/L5V4
	0BsKUHJu83mK5v6GeglsemXTHTBS2bzv2Mb5yfzHy53tLtHuyYMjSfZQhDl0Ki4N/QqLmODpaRa
	ZWhPTbpGrEA==
X-Received: by 2002:a05:620a:45ac:b0:7e6:9730:3d47 with SMTP id af79cd13be357-813c27412admr867400985a.52.1757360390919;
        Mon, 08 Sep 2025 12:39:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfuW6emfxgXmexL3VTWMShtRgSj/i+CkKMVGtoOpG9gLLdeM2VW7H9lnOIPECehI9lWL6qww==
X-Received: by 2002:a05:620a:45ac:b0:7e6:9730:3d47 with SMTP id af79cd13be357-813c27412admr867397085a.52.1757360390229;
        Mon, 08 Sep 2025 12:39:50 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aac142328sm1124207585a.62.2025.09.08.12.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 12:39:49 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d894e74f-6499-4a41-8744-efbcf279a9d9@redhat.com>
Date: Mon, 8 Sep 2025 15:39:48 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cgroup: replace global percpu_rwsem with per
 threadgroup resem when writing to cgroup.procs
To: Yi Tao <escape@linux.alibaba.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <cover.1757326641.git.escape@linux.alibaba.com>
 <c202b463e176ef128c806e0040107ea16a101143.1757326641.git.escape@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <c202b463e176ef128c806e0040107ea16a101143.1757326641.git.escape@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/25 6:20 AM, Yi Tao wrote:
> As computer hardware advances, modern systems are typically equipped
> with many CPU cores and large amounts of memory, enabling the deployment
> of numerous applications. On such systems, container creation and
> deletion become frequent operations, making cgroup process migration no
> longer a cold path. This leads to noticeable contention with common
> process operations such as fork, exec, and exit.
>
> To alleviate the contention between cgroup process migration and
> operations like process fork, this patch modifies lock to take the write
> lock on signal_struct->group_rwsem when writing pid to
> cgroup.procs/threads instead of holding a global write lock.
>
> Cgroup process migration has historically relied on
> signal_struct->group_rwsem to protect thread group integrity. In commit
> <1ed1328792ff> ("sched, cgroup: replace signal_struct->group_rwsem with
> a global percpu_rwsem"), this was changed to a global
> cgroup_threadgroup_rwsem. The advantage of using a global lock was
> simplified handling of process group migrations. This patch retains the
> use of the global lock for protecting process group migration, while
> reducing contention by using per thread group lock during
> cgroup.procs/threads writes.
>
> The locking behavior is as follows:
>
> write cgroup.procs/threads  | process fork,exec,exit | process group migration
> ------------------------------------------------------------------------------
> cgroup_lock()               | down_read(&g_rwsem)    | cgroup_lock()
> down_write(&p_rwsem)        | down_read(&p_rwsem)    | down_write(&g_rwsem)
> critical section            | critical section       | critical section
> up_write(&p_rwsem)          | up_read(&p_rwsem)      | up_write(&g_rwsem)
> cgroup_unlock()             | up_read(&g_rwsem)      | cgroup_unlock()
>
> g_rwsem denotes cgroup_threadgroup_rwsem, p_rwsem denotes
> signal_struct->group_rwsem.
>
> This patch eliminates contention between cgroup migration and fork
> operations for threads that belong to different thread groups, thereby
> reducing the long-tail latency of cgroup migrations and lowering system
> load.
>
> With this patch, under heavy fork and exec interference, the long-tail
> latency of cgroup migration has been reduced from milliseconds to
> microseconds. Under heavy cgroup migration interference, the multi-CPU
> score of the spawn test case in UnixBench increased by 9%.
>
> The static usage pattern of creating a cgroup, enabling controllers,
> and then seeding it with CLONE_INTO_CGROUP doesn't require write
> locking cgroup_threadgroup_rwsem and thus doesn't benefit from this
> patch.
>
> To avoid affecting other users, the per threadgroup rwsem is only used
> when the `favordynmods` flag is enabled.
>
> Signed-off-by: Yi Tao <escape@linux.alibaba.com>
> ---
>   include/linux/cgroup-defs.h     |  12 +++-
>   include/linux/sched/signal.h    |   4 ++
>   init/init_task.c                |   3 +
>   kernel/cgroup/cgroup-internal.h |   4 +-
>   kernel/cgroup/cgroup-v1.c       |   8 +--
>   kernel/cgroup/cgroup.c          | 105 ++++++++++++++++++++++----------
>   kernel/fork.c                   |   4 ++
>   7 files changed, 101 insertions(+), 39 deletions(-)
>
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 6b93a64115fe..5033e3bdac9e 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -88,7 +88,8 @@ enum {
>   	/*
>   	 * Reduce latencies on dynamic cgroup modifications such as task
>   	 * migrations and controller on/offs by disabling percpu operation on
> -	 * cgroup_threadgroup_rwsem. This makes hot path operations such as
> +	 * cgroup_threadgroup_rwsem and taking per threadgroup rwsem when
> +	 * writing to cgroup.procs. This makes hot path operations such as
>   	 * forks and exits into the slow path and more expensive.
>   	 *
>   	 * The static usage pattern of creating a cgroup, enabling controllers,
> @@ -828,16 +829,21 @@ struct cgroup_of_peak {
>   	struct list_head	list;
>   };
>   
> +extern int take_per_threadgroup_rwsem;
> +
>   /**
>    * cgroup_threadgroup_change_begin - threadgroup exclusion for cgroups
>    * @tsk: target task
>    *
>    * Allows cgroup operations to synchronize against threadgroup changes
> - * using a percpu_rw_semaphore.
> + * using a global percpu_rw_semaphore and a per threadgroup rw_semaphore when
> + * favordynmods is on. See the comment above CGRP_ROOT_FAVOR_DYNMODS definition.
>    */
>   static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
>   {
>   	percpu_down_read(&cgroup_threadgroup_rwsem);
> +	if (take_per_threadgroup_rwsem)
> +		down_read(&tsk->signal->cgroup_threadgroup_rwsem);
>   }
>   
>   /**
> @@ -848,6 +854,8 @@ static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
>    */
>   static inline void cgroup_threadgroup_change_end(struct task_struct *tsk)
>   {
> +	if (take_per_threadgroup_rwsem)
> +		up_read(&tsk->signal->cgroup_threadgroup_rwsem);
>   	percpu_up_read(&cgroup_threadgroup_rwsem);
>   }
>   
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 1ef1edbaaf79..7d6449982822 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -226,6 +226,10 @@ struct signal_struct {
>   	struct tty_audit_buf *tty_audit_buf;
>   #endif
>   
> +#ifdef CONFIG_CGROUPS
> +	struct rw_semaphore cgroup_threadgroup_rwsem;
> +#endif
> +
>   	/*
>   	 * Thread is the potential origin of an oom condition; kill first on
>   	 * oom
> diff --git a/init/init_task.c b/init/init_task.c
> index e557f622bd90..a55e2189206f 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -27,6 +27,9 @@ static struct signal_struct init_signals = {
>   	},
>   	.multiprocess	= HLIST_HEAD_INIT,
>   	.rlim		= INIT_RLIMITS,
> +#ifdef CONFIG_CGROUPS
> +	.cgroup_threadgroup_rwsem	= __RWSEM_INITIALIZER(init_signals.cgroup_threadgroup_rwsem),
> +#endif
>   	.cred_guard_mutex = __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
>   	.exec_update_lock = __RWSEM_INITIALIZER(init_signals.exec_update_lock),
>   #ifdef CONFIG_POSIX_TIMERS
> diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
> index b14e61c64a34..318cc7f22e2c 100644
> --- a/kernel/cgroup/cgroup-internal.h
> +++ b/kernel/cgroup/cgroup-internal.h
> @@ -249,8 +249,8 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
>   
>   int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
>   		       bool threadgroup);
> -void cgroup_attach_lock(bool lock_threadgroup);
> -void cgroup_attach_unlock(bool lock_threadgroup);
> +void cgroup_attach_lock(bool lock_threadgroup, struct task_struct *tsk);
> +void cgroup_attach_unlock(bool lock_threadgroup, struct task_struct *tsk);
>   struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
>   					     bool *locked)
>   	__acquires(&cgroup_threadgroup_rwsem);
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index 2a4a387f867a..65e9b454780c 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -68,7 +68,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
>   	int retval = 0;
>   
>   	cgroup_lock();
> -	cgroup_attach_lock(true);
> +	cgroup_attach_lock(true, NULL);
>   	for_each_root(root) {
>   		struct cgroup *from_cgrp;
>   
> @@ -80,7 +80,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
>   		if (retval)
>   			break;
>   	}
> -	cgroup_attach_unlock(true);
> +	cgroup_attach_unlock(true, NULL);
>   	cgroup_unlock();
>   
>   	return retval;
> @@ -117,7 +117,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
>   
>   	cgroup_lock();
>   
> -	cgroup_attach_lock(true);
> +	cgroup_attach_lock(true, NULL);
>   
>   	/* all tasks in @from are being moved, all csets are source */
>   	spin_lock_irq(&css_set_lock);
> @@ -153,7 +153,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
>   	} while (task && !ret);
>   out_err:
>   	cgroup_migrate_finish(&mgctx);
> -	cgroup_attach_unlock(true);
> +	cgroup_attach_unlock(true, NULL);
>   	cgroup_unlock();
>   	return ret;
>   }
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 312c6a8b55bb..8650ec394d0c 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1298,18 +1298,29 @@ struct cgroup_root *cgroup_root_from_kf(struct kernfs_root *kf_root)
>   	return root_cgrp->root;
>   }
>   
> +int take_per_threadgroup_rwsem;
I would suggest adding the "__read_mostly" attribute to avoid the chance 
of false cacheline sharing.
> +
>   void cgroup_favor_dynmods(struct cgroup_root *root, bool favor)
>   {
>   	bool favoring = root->flags & CGRP_ROOT_FAVOR_DYNMODS;
>   
> -	/* see the comment above CGRP_ROOT_FAVOR_DYNMODS definition */
> +	/*
> +	 * see the comment above CGRP_ROOT_FAVOR_DYNMODS definition.
> +	 * favordynmods can flip while task is between
> +	 * cgroup_threadgroup_change_begin and cgroup_threadgroup_change_end,
> +	 * so down_write global cgroup_threadgroup_rwsem to synchronize them.
> +	 */
> +	percpu_down_write(&cgroup_threadgroup_rwsem);
>   	if (favor && !favoring) {
> +		take_per_threadgroup_rwsem++;
>   		rcu_sync_enter(&cgroup_threadgroup_rwsem.rss);
>   		root->flags |= CGRP_ROOT_FAVOR_DYNMODS;
>   	} else if (!favor && favoring) {
> +		take_per_threadgroup_rwsem--;
>   		rcu_sync_exit(&cgroup_threadgroup_rwsem.rss);
>   		root->flags &= ~CGRP_ROOT_FAVOR_DYNMODS;
>   	}
> +	percpu_up_write(&cgroup_threadgroup_rwsem);
>   }
>   

Changing take_per_threadgroup_rwsem inside the cgroup_threadgroup_rwsem 
critical section will ensure that the flag won't change in between 
cgroup_threadgroup_change_begin() and cgroup_threadgroup_change_end(). 
However, it may still change in between cgroup_attach_lock() and 
cgroup_attach_unlock().

Since cgroup_attach_[un]lock() has already taken a threadgroup_locked 
argument, we can extend it to a flag word that holds 2 flag bits - one 
for threadgroup_locked and another one for whether the threadgroup rwsem 
has been taken or not. So take_per_threadgroup_rwsem will only be 
checked in cgroup_attach_lock(). cgroup_attach_lock() can either return 
a value to indicate the state or the argument can be changed into a flag 
pointer with the new flag bit added internally.

It should be a separate patch if you decide to do the extension.

Cheers,
Longman


