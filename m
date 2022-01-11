Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42BC48A61C
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 04:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiAKDMS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jan 2022 22:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiAKDMR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jan 2022 22:12:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C275C06173F;
        Mon, 10 Jan 2022 19:12:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18C6AB817D4;
        Tue, 11 Jan 2022 03:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387AFC36AE9;
        Tue, 11 Jan 2022 03:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641870734;
        bh=yYT1LgS1YCJPnQWbemQOZnqx45HA1VBzrJhciandTU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HUXrUoFP6R3CJx/Ib/3qu47iDvuaaRGJNwYX80sOqloUkmz76LfY+3QHhKWfliSEy
         ZbYEsgeB1EBPfUnDNpYKxUC39wlQT/Ctn+C8XYFgo7WSw8gnn14mtNBTKY62XdFutw
         +uXpipZ5RjJmX1nxwcJoZcEW1K2uSZiGsHBQuiZMNMJDnqYQ5MB63+VNOhxFPU5pzQ
         JJLqGOuplulj0YKl2rlbckrJtFr4O9P200MMT7JeRcf6Pwdh41hBBLwRDuvBMe0iXF
         +mgXujdecHk362sg4YhNad4HBp6miWXc2dSQFFnv6F2Daxky4Lxu/m65x5ZJWafNzO
         9SuIoI2NxOz3g==
Date:   Mon, 10 Jan 2022 19:12:12 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     hannes@cmpxchg.org, torvalds@linux-foundation.org, tj@kernel.org,
        lizefan.x@bytedance.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@android.com,
        syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] psi: Fix uaf issue when psi trigger is destroyed
 while being polled
Message-ID: <Ydz1jAp6RW3t0owj@sol.localdomain>
References: <20220111025138.1071848-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111025138.1071848-1-surenb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 10, 2022 at 06:51:38PM -0800, Suren Baghdasaryan wrote:
> With write operation on psi files replacing old trigger with a new one,
> the lifetime of its waitqueue is totally arbitrary. Overwriting an
> existing trigger causes its waitqueue to be freed and pending poll()
> will stumble on trigger->event_wait which was destroyed.
> Fix this by disallowing to redefine an existing psi trigger. If a write
> operation is used on a file descriptor with an already existing psi
> trigger, the operation will fail with EBUSY error.
> Also bypass a check for psi_disabled in the psi_trigger_destroy as the
> flag can be flipped after the trigger is created, leading to a memory
> leak.
> 
> Reported-by: syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com
> Analyzed-by: Eric Biggers <ebiggers@kernel.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Please include Fixes and Cc stable tags.

> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index cafb8c114a21..e6878238fb19 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3642,6 +3642,12 @@ static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
>  	cgroup_get(cgrp);
>  	cgroup_kn_unlock(of->kn);
>  
> +	/* Allow only one trigger per file descriptor */
> +	if (READ_ONCE(ctx->psi.trigger)) {
> +		cgroup_put(cgrp);
> +		return -EBUSY;
> +	}
> +

Doesn't the task have exclusive access to the file at this point?  READ_ONCE()
is only needed instead of a plain load when the field can be concurrently
changed by another thread.

> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 1652f2bb54b7..882bf62cc247 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -1151,7 +1151,6 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>  	t->event = 0;
>  	t->last_event_time = 0;
>  	init_waitqueue_head(&t->event_wait);
> -	kref_init(&t->refcount);
>  
>  	mutex_lock(&group->trigger_lock);
>  
> @@ -1180,15 +1179,21 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>  	return t;
>  }
>  
> -static void psi_trigger_destroy(struct kref *ref)
> +void psi_trigger_destroy(void **trigger_ptr)
>  {
> -	struct psi_trigger *t = container_of(ref, struct psi_trigger, refcount);
> -	struct psi_group *group = t->group;
> +	struct psi_trigger *t;
> +	struct psi_group *group;
>  	struct task_struct *task_to_destroy = NULL;
>  
> -	if (static_branch_likely(&psi_disabled))
> +	/*
> +	 * We do not check psi_disabled since it might have been disabled after
> +	 * the trigger got created.
> +	 */
> +	t = xchg(trigger_ptr, NULL);
> +	if (!t)
>  		return;

Likewise, doesn't the task have exclusive access to the file at this point?
This is only called during ->release().

And why does this take a pointer to a pointer instead of just the pointer?

> @@ -1305,14 +1289,24 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
>  
>  	buf[buf_size - 1] = '\0';
>  
> -	new = psi_trigger_create(&psi_system, buf, nbytes, res);
> -	if (IS_ERR(new))
> -		return PTR_ERR(new);
> -
>  	seq = file->private_data;
> +
>  	/* Take seq->lock to protect seq->private from concurrent writes */
>  	mutex_lock(&seq->lock);
> -	psi_trigger_replace(&seq->private, new);
> +
> +	/* Allow only one trigger per file descriptor */
> +	if (READ_ONCE(seq->private)) {
> +		mutex_unlock(&seq->lock);
> +		return -EBUSY;
> +	}

Likewise, what does this race against that would require the use of READ_ONCE()?

- Eric
