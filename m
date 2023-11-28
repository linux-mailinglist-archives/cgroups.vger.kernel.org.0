Return-Path: <cgroups+bounces-598-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0324F7FB0C9
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 05:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47926B2103E
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 04:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9A9DF4C;
	Tue, 28 Nov 2023 04:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPD9pyei"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CF41AA
	for <cgroups@vger.kernel.org>; Mon, 27 Nov 2023 20:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701144089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+0Z92Qj1ldv3a0RYwGcB/SwkAAl78v4xA0NIgpUKoA=;
	b=gPD9pyei4ngZAJ5mcp1nl5yQoDA7gUcIQKNTRvL8pFscqP9+XVT4AEL6rL2Y5UV4ohkp8W
	+9b4suC0utoOpjlgfPj1pREDSsx3pEuIxQ+rIR1oCZR3wd2ngjRzNhfV0XMRNsVHClbGUA
	w2a2uqw9y/O9ytYvFAVDTxTBNaMOe1M=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-LCLvOOU1PM-PsDJFrO8yMQ-1; Mon,
 27 Nov 2023 23:01:24 -0500
X-MC-Unique: LCLvOOU1PM-PsDJFrO8yMQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC4183806700;
	Tue, 28 Nov 2023 04:01:23 +0000 (UTC)
Received: from [10.22.8.93] (unknown [10.22.8.93])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 238301C060B0;
	Tue, 28 Nov 2023 04:01:23 +0000 (UTC)
Message-ID: <a9aa2809-95f5-4f60-b936-0d857c971fea@redhat.com>
Date: Mon, 27 Nov 2023 23:01:22 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] cgroup/rstat: Optimize cgroup_rstat_updated_list()
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joe Mario <jmario@redhat.com>, Sebastian Jug <sejug@redhat.com>,
 Yosry Ahmed <yosryahmed@google.com>
References: <20231106210543.717486-1-longman@redhat.com>
 <20231106210543.717486-3-longman@redhat.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20231106210543.717486-3-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 11/6/23 16:05, Waiman Long wrote:
> The current design of cgroup_rstat_cpu_pop_updated() is to traverse
> the updated tree in a way to pop out the leaf nodes first before
> their parents. This can cause traversal of multiple nodes before a
> leaf node can be found and popped out. IOW, a given node in the tree
> can be visited multiple times before the whole operation is done. So
> it is not very efficient and the code can be hard to read.
>
> With the introduction of cgroup_rstat_updated_list() to build a list
> of cgroups to be flushed first before any flushing operation is being
> done, we can optimize the way the updated tree nodes are being popped
> by pushing the parents first to the tail end of the list before their
> children. In this way, most updated tree nodes will be visited only
> once with the exception of the subtree root as we still need to go
> back to its parent and popped it out of its updated_children list.
> This also makes the code easier to read.
>
> A parallel kernel build on a 2-socket x86-64 server is used as the
> benchmarking tool for measuring the lock hold time. Below were the lock
> hold time frequency distribution before and after the patch:
>
>       Hold time        Before patch       After patch
>       ---------        ------------       -----------
>         0-01 us        13,738,708         14,594,545
>        01-05 us         1,177,194            439,926
>        05-10 us             4,984              5,960
>        10-15 us             3,562              3,543
>        15-20 us             1,314              1,397
>        20-25 us                18                 25
>        25-30 us                12                 12
>
> It can be seen that the patch pushes the lock hold time towards the
> lower end.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/rstat.c | 134 +++++++++++++++++++++++-------------------
>   1 file changed, 72 insertions(+), 62 deletions(-)
>
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 1f300bf4dc40..701388fa215f 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -74,64 +74,92 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
>   }
>   
>   /**
> - * cgroup_rstat_cpu_pop_updated - iterate and dismantle rstat_cpu updated tree
> - * @pos: current position
> - * @root: root of the tree to traversal
> + * cgroup_rstat_push_children - push children cgroups into the given list
> + * @head: current head of the list (= parent cgroup)
> + * @prstatc: cgroup_rstat_cpu of the parent cgroup
>    * @cpu: target cpu
> + * Return: A new singly linked list of cgroups to be flush
>    *
> - * Walks the updated rstat_cpu tree on @cpu from @root.  %NULL @pos starts
> - * the traversal and %NULL return indicates the end.  During traversal,
> - * each returned cgroup is unlinked from the tree.  Must be called with the
> - * matching cgroup_rstat_cpu_lock held.
> + * Recursively traverse down the cgroup_rstat_cpu updated tree and push
> + * parent first before its children into a singly linked list built from
> + * the tail backward like "pushing" cgroups into a stack. The parent is
> + * pushed by the caller. The recursion depth is the depth of the current
> + * updated subtree.
> + */
> +static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
> +				struct cgroup_rstat_cpu *prstatc, int cpu)
> +{
> +	struct cgroup *child, *parent;
> +	struct cgroup_rstat_cpu *crstatc;
> +
> +	parent = head;
> +	child = prstatc->updated_children;
> +	prstatc->updated_children = parent;
> +
> +	/* updated_next is parent cgroup terminated */
> +	while (child != parent) {
> +		child->rstat_flush_next = head;
> +		head = child;
> +		crstatc = cgroup_rstat_cpu(child, cpu);
> +		if (crstatc->updated_children != child)
> +			head = cgroup_rstat_push_children(head, crstatc, cpu);
> +		child = crstatc->updated_next;
> +		crstatc->updated_next = NULL;
> +	}
> +	return head;
> +}
> +
> +/**
> + * cgroup_rstat_updated_list - return a list of updated cgroups to be flushed
> + * @root: root of the cgroup subtree to traverse
> + * @cpu: target cpu
> + * Return: A singly linked list of cgroups to be flushed
> + *
> + * Walks the updated rstat_cpu tree on @cpu from @root.  During traversal,
> + * each returned cgroup is unlinked from the updated tree.
>    *
>    * The only ordering guarantee is that, for a parent and a child pair
> - * covered by a given traversal, if a child is visited, its parent is
> - * guaranteed to be visited afterwards.
> + * covered by a given traversal, the child is before its parent in
> + * the list.
> + *
> + * Note that updated_children is self terminated and points to a list of
> + * child cgroups if not empty. Whereas updated_next is like a sibling link
> + * within the children list and terminated by the parent cgroup. An exception
> + * here is the cgroup root whose updated_next can be self terminated.
>    */
> -static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
> -						   struct cgroup *root, int cpu)
> +static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
>   {
> -	struct cgroup_rstat_cpu *rstatc;
> -	struct cgroup *parent;
> -
> -	if (pos == root)
> -		return NULL;
> +	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
> +	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(root, cpu);
> +	struct cgroup *head = NULL, *parent;
> +	unsigned long flags;
>   
>   	/*
> -	 * We're gonna walk down to the first leaf and visit/remove it.  We
> -	 * can pick whatever unvisited node as the starting point.
> +	 * The _irqsave() is needed because cgroup_rstat_lock is
> +	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
> +	 * this lock with the _irq() suffix only disables interrupts on
> +	 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
> +	 * interrupts on both configurations. The _irqsave() ensures
> +	 * that interrupts are always disabled and later restored.
>   	 */
> -	if (!pos) {
> -		pos = root;
> -		/* return NULL if this subtree is not on-list */
> -		if (!cgroup_rstat_cpu(pos, cpu)->updated_next)
> -			return NULL;
> -	} else {
> -		pos = cgroup_parent(pos);
> -	}
> +	raw_spin_lock_irqsave(cpu_lock, flags);
>   
> -	/* walk down to the first leaf */
> -	while (true) {
> -		rstatc = cgroup_rstat_cpu(pos, cpu);
> -		if (rstatc->updated_children == pos)
> -			break;
> -		pos = rstatc->updated_children;
> -	}
> +	/* Return NULL if this subtree is not on-list */
> +	if (!rstatc->updated_next)
> +		goto unlock_ret;
>   
>   	/*
> -	 * Unlink @pos from the tree.  As the updated_children list is
> +	 * Unlink @root from its parent. As the updated_children list is
>   	 * singly linked, we have to walk it to find the removal point.
> -	 * However, due to the way we traverse, @pos will be the first
> -	 * child in most cases. The only exception is @root.
>   	 */
> -	parent = cgroup_parent(pos);
> +	parent = cgroup_parent(root);
>   	if (parent) {
>   		struct cgroup_rstat_cpu *prstatc;
>   		struct cgroup **nextp;
>   
>   		prstatc = cgroup_rstat_cpu(parent, cpu);
>   		nextp = &prstatc->updated_children;
> -		while (*nextp != pos) {
> +		while (*nextp != root) {
>   			struct cgroup_rstat_cpu *nrstatc;
>   
>   			nrstatc = cgroup_rstat_cpu(*nextp, cpu);
> @@ -142,31 +170,13 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
>   	}
>   
>   	rstatc->updated_next = NULL;
> -	return pos;
> -}
> -
> -/* Return a list of updated cgroups to be flushed */
> -static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
> -{
> -	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
> -	struct cgroup *head, *tail, *next;
> -	unsigned long flags;
>   
> -	/*
> -	 * The _irqsave() is needed because cgroup_rstat_lock is
> -	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
> -	 * this lock with the _irq() suffix only disables interrupts on
> -	 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
> -	 * interrupts on both configurations. The _irqsave() ensures
> -	 * that interrupts are always disabled and later restored.
> -	 */
> -	raw_spin_lock_irqsave(cpu_lock, flags);
> -	head = tail = cgroup_rstat_cpu_pop_updated(NULL, root, cpu);
> -	while (tail) {
> -		next = cgroup_rstat_cpu_pop_updated(tail, root, cpu);
> -		tail->rstat_flush_next = next;
> -		tail = next;
> -	}
> +	/* Push @root to the list first before pushing the children */
> +	head = root;
> +	root->rstat_flush_next = NULL;
> +	if (rstatc->updated_children != root)
> +		head = cgroup_rstat_push_children(head, rstatc, cpu);
> +unlock_ret:
>   	raw_spin_unlock_irqrestore(cpu_lock, flags);
>   	return head;
>   }

Any further comment or suggestion on this patch?

Thanks,
Longman


