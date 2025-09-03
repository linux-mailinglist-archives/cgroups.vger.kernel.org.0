Return-Path: <cgroups+bounces-9643-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FD2B420BA
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B26685F69
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 13:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7654C301029;
	Wed,  3 Sep 2025 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOv7o2EO"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869FB301036
	for <cgroups@vger.kernel.org>; Wed,  3 Sep 2025 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905268; cv=none; b=bNuW5WIgyhKDLfr7Zo6KNu8NDFkopR8j4RknzMD/TCBcI3iwNFsluwqK17hedLoVkHmK2bFmTXN6eE3BO+FYtWwvucW/oiT//aleeEp0TKqLqOV7yNTbo93sshayAuyPkhDtErSrccxI23d4dEVPU1/j528LKLLqskGUDNpRCok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905268; c=relaxed/simple;
	bh=nOZ20j6dyfdE36BbaY3Vtku7Dh99kVZzqltHpVgMtio=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kPbmzmpdPP1cZDIJ4WkAbqZrfmf8UX9bGm/vEOOK+52nErCf9Cpq2VAaFV2QMgNJEO2wahapB0LlC5UUGXIqm5qp/2rkUBbPQYvV+wRHT2u3FOkeybC4R25Hon84IB7+s/pNQ4IJoCn6W/HBVg6fbZBIb9qz2ZUR8o4ZBOwY+0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOv7o2EO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756905265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ThZHO2/wPZHkKnjhedIK+z7T56fOfTctRgrK5+WqyYM=;
	b=gOv7o2EOUvxURQ8oSkoiytjlY4MepiZzBxuZ17dLgVaNJ3AwZ7RS2lAwZcqn7aCQJ1tySb
	ynwHEO3gmgbTZUQaQrOwkHcrlUjfQndL7gOF/0RHW501/vZl8LAmvNEfV+2bYdpLFus7Ns
	LwjrK2Ix6WS9ExqSf1FKG/rdauwJgB0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-cHdGl_eyO1mbwz7aczqIhA-1; Wed, 03 Sep 2025 09:14:24 -0400
X-MC-Unique: cHdGl_eyO1mbwz7aczqIhA-1
X-Mimecast-MFC-AGG-ID: cHdGl_eyO1mbwz7aczqIhA_1756905264
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b548745115so2129561cf.0
        for <cgroups@vger.kernel.org>; Wed, 03 Sep 2025 06:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756905264; x=1757510064;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ThZHO2/wPZHkKnjhedIK+z7T56fOfTctRgrK5+WqyYM=;
        b=QB+zPpqJy5FqOGpYetbKc/FLECWekNEo/sHz/pogZ1Nlrla910zhfiU8GfTKMjch43
         4ddbtvJVvPOl5gx28+1Slu2M074VLKTsiJFvkKekC9IKdkwcQim6Ryq834YKEMuPFiwS
         vim6Mj7HgQbQ25EhO84HKusVT9eU050LFIRnkJP9VXvYIj8RU+gkiDN5zc1xuFzy22z5
         kGH1gs+K3NDdP8XWzmxAKMQmlMrwvVlG2988xfQOYGq7eP/42U/p7faxaqRI32FC2ofV
         zv7TFT5nUjNAgEnZPg5ZxpcAEBOQuTijkXFJAaiWE6I9Y5Oxh1CgZNUFmw8+wFMBPqGz
         bKpQ==
X-Gm-Message-State: AOJu0YwXnAymwPhiQ2t/z8edat+1dwFXiKsqS0Jx4PNMWFawz0gLQSYR
	/fuKfj0wQoGXkLGqThuvJbAh3f1Wfa0/+AkzvsFFMtfEY850iSfw3QvJZxSh5TCsxnQI3m1+D4/
	dQz+u9jwdSKlPvjvdxB7bItiuUtwmgfF3b4SI6AJBwqUzOg1LaiMZ47pCfjo=
X-Gm-Gg: ASbGncvnb+mTlwcgQL8EdNJKYcByUIGWD3MqgBqQ9Du+GCOWc9+5X+1lm9dre1cbuU1
	CLPHVA2h0F/MPpjhGOZn1YtqrMCAIMO/4mhnqIYz6PrpjeRBQ74w9j47kmDjb6IdRz4Bz2Mm+SU
	UuNaxmKQTssStAEN3F/C4f3JJmcPhy8AvKvxi+LG2IeGbYmmFBRRccnsIE4SgBW9raPjhBh3s3k
	SXPD+vNgYMw7JwQRlTbOoyapmwfNytGdIEbAcH5W83of1qCn8LcalERBueWwWACjqTN5a2i7Hfd
	ZtMvp60cz3duzuedvscg0fWEnofFJVSoe7aRLnWRz4HlahAwhOM1qMOD9BuBf7YBFOd0yownis+
	rqpBrM+H9Fw==
X-Received: by 2002:ac8:5d14:0:b0:4b3:d90:d1d7 with SMTP id d75a77b69052e-4b31b85d06cmr191005091cf.3.1756905263821;
        Wed, 03 Sep 2025 06:14:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG41Buk/fJ0/oEjk1HoGV1wT44u0bHIJ/wx2JQek3eVCsBndIL2at9Eg9R/oOQKyAWoZQosMw==
X-Received: by 2002:ac8:5d14:0:b0:4b3:d90:d1d7 with SMTP id d75a77b69052e-4b31b85d06cmr191004451cf.3.1756905263215;
        Wed, 03 Sep 2025 06:14:23 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-80aabb8288dsm102752585a.58.2025.09.03.06.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 06:14:22 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9a085dcd-be41-4244-a35e-014e0a1d0fd6@redhat.com>
Date: Wed, 3 Sep 2025 09:14:21 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
To: Yi Tao <escape@linux.alibaba.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/3/25 7:11 AM, Yi Tao wrote:
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
Do you have any performance numbers to showcase how much performance 
benefit does this change provide?
> Signed-off-by: Yi Tao <escape@linux.alibaba.com>
> ---
>   include/linux/cgroup-defs.h     |  2 ++
>   include/linux/sched/signal.h    |  4 +++
>   init/init_task.c                |  3 ++
>   kernel/cgroup/cgroup-internal.h |  6 ++--
>   kernel/cgroup/cgroup-v1.c       |  8 ++---
>   kernel/cgroup/cgroup.c          | 56 ++++++++++++++++++++-------------
>   kernel/fork.c                   |  4 +++
>   7 files changed, 55 insertions(+), 28 deletions(-)
>
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 6b93a64115fe..8e0fdad8a440 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -838,6 +838,7 @@ struct cgroup_of_peak {
>   static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
>   {
>   	percpu_down_read(&cgroup_threadgroup_rwsem);
> +	down_read(&tsk->signal->group_rwsem);
>   }
>   
>   /**
> @@ -848,6 +849,7 @@ static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
>    */
>   static inline void cgroup_threadgroup_change_end(struct task_struct *tsk)
>   {
> +	up_read(&tsk->signal->group_rwsem);
>   	percpu_up_read(&cgroup_threadgroup_rwsem);
>   }
>   
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 1ef1edbaaf79..86fbc99a9174 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -226,6 +226,10 @@ struct signal_struct {
>   	struct tty_audit_buf *tty_audit_buf;
>   #endif
>   
> +#ifdef CONFIG_CGROUPS
> +	struct rw_semaphore group_rwsem;
> +#endif
> +
>   	/*
>   	 * Thread is the potential origin of an oom condition; kill first on
>   	 * oom
> diff --git a/init/init_task.c b/init/init_task.c
> index e557f622bd90..0450093924a7 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -27,6 +27,9 @@ static struct signal_struct init_signals = {
>   	},
>   	.multiprocess	= HLIST_HEAD_INIT,
>   	.rlim		= INIT_RLIMITS,
> +#ifdef CONFIG_CGROUPS
> +	.group_rwsem	= __RWSEM_INITIALIZER(init_signals.group_rwsem),
> +#endif
>   	.cred_guard_mutex = __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
>   	.exec_update_lock = __RWSEM_INITIALIZER(init_signals.exec_update_lock),
>   #ifdef CONFIG_POSIX_TIMERS
> diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
> index b14e61c64a34..572c24b7e947 100644
> --- a/kernel/cgroup/cgroup-internal.h
> +++ b/kernel/cgroup/cgroup-internal.h
> @@ -249,8 +249,10 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
>   
>   int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
>   		       bool threadgroup);
> -void cgroup_attach_lock(bool lock_threadgroup);
> -void cgroup_attach_unlock(bool lock_threadgroup);
> +void cgroup_attach_lock(struct task_struct *tsk, bool lock_threadgroup,
> +			bool global);
> +void cgroup_attach_unlock(struct task_struct *tsk, bool lock_threadgroup,
> +			  bool global);
>   struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
>   					     bool *locked)
>   	__acquires(&cgroup_threadgroup_rwsem);
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index 2a4a387f867a..3e5ead8c5bc5 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -68,7 +68,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
>   	int retval = 0;
>   
>   	cgroup_lock();
> -	cgroup_attach_lock(true);
> +	cgroup_attach_lock(NULL, true, true);
>   	for_each_root(root) {
>   		struct cgroup *from_cgrp;
>   
> @@ -80,7 +80,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
>   		if (retval)
>   			break;
>   	}
> -	cgroup_attach_unlock(true);
> +	cgroup_attach_unlock(NULL, true, true);
>   	cgroup_unlock();
>   
>   	return retval;
> @@ -117,7 +117,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
>   
>   	cgroup_lock();
>   
> -	cgroup_attach_lock(true);
> +	cgroup_attach_lock(NULL, true, true);
>   
>   	/* all tasks in @from are being moved, all csets are source */
>   	spin_lock_irq(&css_set_lock);
> @@ -153,7 +153,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
>   	} while (task && !ret);
>   out_err:
>   	cgroup_migrate_finish(&mgctx);
> -	cgroup_attach_unlock(true);
> +	cgroup_attach_unlock(NULL, true, true);
>   	cgroup_unlock();
>   	return ret;
>   }
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 312c6a8b55bb..4e1d80a2741f 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2480,21 +2480,31 @@ EXPORT_SYMBOL_GPL(cgroup_path_ns);
>    * write-locking cgroup_threadgroup_rwsem. This allows ->attach() to assume that
>    * CPU hotplug is disabled on entry.
>    */
> -void cgroup_attach_lock(bool lock_threadgroup)
> +void cgroup_attach_lock(struct task_struct *tsk,
> +			       bool lock_threadgroup, bool global)
>   {
>   	cpus_read_lock();
> -	if (lock_threadgroup)
> -		percpu_down_write(&cgroup_threadgroup_rwsem);
> +	if (lock_threadgroup) {
> +		if (global)
> +			percpu_down_write(&cgroup_threadgroup_rwsem);
> +		else
> +			down_write(&tsk->signal->group_rwsem);
> +	}
>   }

tsk is only used when global is false. So you can eliminate the 
redundant global argument and use the presence of tsk to indicate which 
lock to take.

Cheers,
Longman


