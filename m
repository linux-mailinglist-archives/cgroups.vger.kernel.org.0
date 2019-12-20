Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F94128351
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2019 21:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfLTUhB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Dec 2019 15:37:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34626 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727413AbfLTUhB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Dec 2019 15:37:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576874220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4jjRnLYjGrqgF7WL+aNzr4dW0tQZdCM9Qqr1PxQyLYQ=;
        b=CPOUv+luqofKZe6ideEHXXcBsW3L4JPJKOxZSWOLEzNIqorxihmH7DX20/QiFvEZbw/oXY
        OgeIexMwwdPL7Ar5aOK9UdWOWoTzXsiVY82r9FG3pokzhelvGsYqgUssOYcpmM2i0t7DnD
        GX2/D6kcUnlioYNtT4iC4Q0Fdivl1jU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-eyXY7Fg4MeWQIpg8Nlm4TQ-1; Fri, 20 Dec 2019 15:36:57 -0500
X-MC-Unique: eyXY7Fg4MeWQIpg8Nlm4TQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 676271005513;
        Fri, 20 Dec 2019 20:36:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (ovpn-204-70.brq.redhat.com [10.40.204.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id 899A17C839;
        Fri, 20 Dec 2019 20:36:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 20 Dec 2019 21:36:54 +0100 (CET)
Date:   Fri, 20 Dec 2019 21:36:50 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/3] clone3: allow spawning processes into cgroups
Message-ID: <20191220203650.GA15133@redhat.com>
References: <20191218173516.7875-1-christian.brauner@ubuntu.com>
 <20191218173516.7875-3-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218173516.7875-3-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/18, Christian Brauner wrote:
>
> This adds support for creating a process in a different cgroup than its
> parent.

Cough... I will not comment the intent ;) I can't review the cgroup patches
anyway.

However,

> +int cgroup_lock_fork(struct kernel_clone_args *kargs)
> +	__acquires(&cgroup_mutex)
> +{
> +	struct cgroup *cgrp;
> +
> +	if (!(kargs->flags & CLONE_INTO_CGROUP))
> +		return 0;
> +
> +	cgrp = kargs->cgrp;
> +	if (!cgrp)
> +		return 0;
> +
> +	mutex_lock(&cgroup_mutex);
> +
> +	if (!cgroup_is_dead(cgrp))
> +		return 0;
> +
> +	mutex_unlock(&cgroup_mutex);
> +	return -ENODEV;

...

> @@ -2172,7 +2172,7 @@ static __latent_entropy struct task_struct *copy_process(
>  	 * between here and cgroup_post_fork() if an organisation operation is in
>  	 * progress.
>  	 */
> -	retval = cgroup_can_fork(p);
> +	retval = cgroup_can_fork(current, p, args);
>  	if (retval)
>  		goto bad_fork_cgroup_threadgroup_change_end;
>  
> @@ -2226,6 +2226,10 @@ static __latent_entropy struct task_struct *copy_process(
>  		goto bad_fork_cancel_cgroup;
>  	}
>  
> +	retval = cgroup_lock_fork(args);

mutex_lock() under spin_lock() ??


just in case, note that mutex_lock(&cgroup_mutex) is not safe even under
cgroup_threadgroup_change_begin(), this can deadlock.

Oleg.

