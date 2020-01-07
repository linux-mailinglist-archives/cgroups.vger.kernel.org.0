Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A2A132B1D
	for <lists+cgroups@lfdr.de>; Tue,  7 Jan 2020 17:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgAGQcJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Jan 2020 11:32:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39471 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgAGQcJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Jan 2020 11:32:09 -0500
Received: by mail-qk1-f194.google.com with SMTP id c16so43166931qko.6;
        Tue, 07 Jan 2020 08:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EXsf8J2QF1KRZGOWtWEWKs3DqNsHO+r1D8ycqowGQlM=;
        b=bpRgbibs09Jn+oJ4pkmpZxvOzcsIbPknZDJvb/ZdoOwcbUl9jZGlIt0DfiIaEjT6QW
         coEf6/E77CcxXC0xbC5PJ9s8eHtuBzuJbpxgQsoSHTc8rM+L+nrZrWeNcln8h4wFFx7S
         F4a8YQE+xax5Y0q9xJYPR86MejdYk2Zy/hUn4t9Ile5YLCPWnpWI87S1iyvUflERv8nt
         RSGna/fvRYXretBqqkt2E/XeQj5hWAkmx50e05o3/Ub/lC/1VePZ5YZDLnzx6Hy8ogzl
         nKXDeEDrCYfqM3MEU7bINrBeoab7FcgNIrE6VNqZF7MfYIQNuSrlyziWX2lNyXRJhZT+
         wavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EXsf8J2QF1KRZGOWtWEWKs3DqNsHO+r1D8ycqowGQlM=;
        b=fgY9PTJ1ViMpW79JU3Zl+k9YVx+UmXhtGzwo6AcD90gIpFHrFdIIzHwlvmuPeHmAbu
         VC6gjxMwcfEer0wovAqtPrdOk+UwH1eOrl+CTgy32y4Ek69nwI8S8jLe1L1IGLKqixoR
         OW5tmRSTQSL1Wk2wXpiGIv3d/Dcijob1VQlmu/B/u2FuWFNZkDz0uJgiP91TS6ATEYfu
         kXXYH4c1geJe3V6+LWtj5WvelX1bArgIA4dITIqKy5v10lMnBRVmKppWvHjF6TnLVWQ3
         se+E+LA3C/xFPE+IRXtbSPrd8aAXTxe6zowILuY/3NcR+RtCNx8n5uUCq4FB559aCLI6
         B4Qw==
X-Gm-Message-State: APjAAAUIEmYpBZmyVLZ4PvQcqo0B9+WsPlhCaNhegAS9nNXXBwsS4HL9
        Kq81YwH60P6XKCf5lrXRc2E=
X-Google-Smtp-Source: APXvYqwybjAi8YN4FFFB7QbiJ2hGqTqTi6cQVSEkO05FxJafjonWgsWKkRoLAyBRFjP2z0/ZU110Qw==
X-Received: by 2002:a05:620a:1592:: with SMTP id d18mr174878qkk.80.1578414727473;
        Tue, 07 Jan 2020 08:32:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:4305])
        by smtp.gmail.com with ESMTPSA id l35sm121588qtl.12.2020.01.07.08.32.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2020 08:32:06 -0800 (PST)
Date:   Tue, 7 Jan 2020 08:32:04 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 2/3] clone3: allow spawning processes into cgroups
Message-ID: <20200107163204.GB2677547@devbig004.ftw2.facebook.com>
References: <20191223061504.28716-1-christian.brauner@ubuntu.com>
 <20191223061504.28716-3-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223061504.28716-3-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Dec 23, 2019 at 07:15:03AM +0100, Christian Brauner wrote:
> +static struct cgroup *cgroup_get_from_file(struct file *f)
> +{
> +	struct cgroup_subsys_state *css;
> +	struct cgroup *cgrp;
> +
> +	css = css_tryget_online_from_dir(f->f_path.dentry, NULL);
> +	if (IS_ERR(css))
> +		return ERR_CAST(css);
> +
> +	cgrp = css->cgroup;
> +	if (!cgroup_on_dfl(cgrp)) {
> +		cgroup_put(cgrp);
> +		return ERR_PTR(-EBADF);
> +	}
> +
> +	return cgrp;
> +}

It's minor but can you put this refactoring into a separate patch?

...
> +static int cgroup_css_set_fork(struct task_struct *parent,
> +			       struct kernel_clone_args *kargs)
> +	__acquires(&cgroup_mutex) __acquires(&cgroup_threadgroup_rwsem)
> +{
> +	int ret;
> +	struct cgroup *dst_cgrp = NULL, *src_cgrp;
> +	struct css_set *cset;
> +	struct super_block *sb;
> +	struct file *f;
> +
> +	if (kargs->flags & CLONE_INTO_CGROUP) {
> +		ret = mutex_lock_killable(&cgroup_mutex);
> +		if (ret)
> +			return ret;
> +	}

I don't think this is necessary.  cgroup_mutex should always only be
held for a finite enough time; otherwise, processes would get stuck on
random cgroupfs accesses or even /proc/self/cgroup.

...
> +	spin_lock_irq(&css_set_lock);
> +	src_cgrp = task_cgroup_from_root(parent, &cgrp_dfl_root);
> +	spin_unlock_irq(&css_set_lock);

You can simply do cset->dfl_root here, which is consistent with other
code paths which know that they want the dfl cgroup.

> +	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp, sb,
> +					!!(kargs->flags & CLONE_THREAD));
> +	if (ret)
> +		goto err;

So, the existing perm check depends on the fact that for the write
operation to have started, it already should have passed write perm
check on the destination cgroup.procs file.  We're missing that here,
so we prolly need to check that explicitly.

> @@ -214,13 +215,21 @@ static void pids_cancel_attach(struct cgroup_taskset *tset)
> +static int pids_can_fork(struct task_struct *parent, struct task_struct *child,
> +			 struct kernel_clone_args *args)
>  {
> +	struct css_set *new_cset = NULL;
>  	struct cgroup_subsys_state *css;
>  	struct pids_cgroup *pids;
>  	int err;
>  
> -	css = task_css_check(current, pids_cgrp_id, true);
> +	if (args)
> +		new_cset = args->cset;
> +
> +	if (!new_cset)
> +		css = task_css_check(current, pids_cgrp_id, true);
> +	else
> +		css = new_cset->subsys[pids_cgrp_id];

Heh, this kinda sucks.  Would it be better to pass in the new css into
the callbacks rather than clone args?

> diff --git a/kernel/fork.c b/kernel/fork.c
> index 2508a4f238a3..1604552f7cd3 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2165,16 +2165,15 @@ static __latent_entropy struct task_struct *copy_process(
>  	INIT_LIST_HEAD(&p->thread_group);
>  	p->task_works = NULL;
>  
> -	cgroup_threadgroup_change_begin(current);
>  	/*
>  	 * Ensure that the cgroup subsystem policies allow the new process to be
>  	 * forked. It should be noted the the new process's css_set can be changed
>  	 * between here and cgroup_post_fork() if an organisation operation is in
>  	 * progress.
>  	 */
> -	retval = cgroup_can_fork(p);
> +	retval = cgroup_can_fork(current, p, args);
>  	if (retval)
> -		goto bad_fork_cgroup_threadgroup_change_end;
> +		goto bad_fork_put_pidfd;
>  
>  	/*
>  	 * From this point on we must avoid any synchronous user-space

Maybe we can move these changes into a prep patch together with the
get_from_file change so that this patch only contains the actual
feature implementation?

Other than that, looks good to me.  Once the above review points are
addressed and Oleg is okay with it, I'll be happy to route this
through the cgroup tree.

Thanks so much for working on this.  This is really cool.

-- 
tejun
