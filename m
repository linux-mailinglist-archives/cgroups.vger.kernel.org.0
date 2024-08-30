Return-Path: <cgroups+bounces-4621-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E6396621A
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 14:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC35B1F24C69
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 12:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5D4199951;
	Fri, 30 Aug 2024 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1oQccz+x"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6216DC3D;
	Fri, 30 Aug 2024 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022603; cv=none; b=qSO7xdE5oFKrIpX4xfcbcRbkKlIyvaTX7GZd/sWhxY9zD8orkDUa1pQEo0kGrxa/rzFsSxLzJn6iQEG9JmHRra0XtO0VyGNvBekEq2OWsuUB7vuz38AzvtMdgHN2BENnR54jawr/sT8Ynm/rr6R7rEpoVLNDaLBXJSBwF6uLf+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022603; c=relaxed/simple;
	bh=HDdh0qw8j46tMuVtpmR8HaScjp3wTf6OwP0fyiqI3T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9tipzIam84yrWSXpBUzTF/tcSdi9ZA0gpVW0j+ZVXriCP6WJnmJTMvLPSWRhtseTbigLA+9ORGl9foT+1oVkR/J5yQmcmFUvB+2+QfvereOqqprJJIXgWmhbKgaKkcM8r2XIcZ0KGwpRK+R4lHbSoFbyaAnTwc8N1ElIP0ykxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1oQccz+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD60C4CEC2;
	Fri, 30 Aug 2024 12:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725022603;
	bh=HDdh0qw8j46tMuVtpmR8HaScjp3wTf6OwP0fyiqI3T0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1oQccz+xZwRmnQq64cq6k543woWMPa1J5UAJWOf/gFnfXB5DpzIyJgLpoGTPP6emF
	 cz+BUl9UGjQ6w2Cd59SLhsknxnqEzAE3OySGGiAwTZZyVPBStQnZbqfBqKq2jnSqs0
	 wI5myt960HRb7AssjmwM2SIbh253J+EfYmY0Pjcg=
Date: Fri, 30 Aug 2024 14:56:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shivani Agarwal <shivani.agarwal@broadcom.com>
Cc: stable@vger.kernel.org, longman@redhat.com, lizefan.x@bytedance.com,
	tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
	adityakali@google.com, sergeh@kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	Chen Ridong <chenridong@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10-v5.15] cgroup/cpuset: Prevent UAF in
 proc_cpuset_show()
Message-ID: <2024083031-jinx-erupt-6780@gregkh>
References: <20240830050453.692795-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830050453.692795-1-shivani.agarwal@broadcom.com>

On Thu, Aug 29, 2024 at 10:04:53PM -0700, Shivani Agarwal wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> [ Upstream commit 1be59c97c83ccd67a519d8a49486b3a8a73ca28a ]
> 
> An UAF can happen when /proc/cpuset is read as reported in [1].
> 
> This can be reproduced by the following methods:
> 1.add an mdelay(1000) before acquiring the cgroup_lock In the
>  cgroup_path_ns function.
> 2.$cat /proc/<pid>/cpuset   repeatly.
> 3.$mount -t cgroup -o cpuset cpuset /sys/fs/cgroup/cpuset/
> $umount /sys/fs/cgroup/cpuset/   repeatly.
> 
> The race that cause this bug can be shown as below:
> 
> (umount)		|	(cat /proc/<pid>/cpuset)
> css_release		|	proc_cpuset_show
> css_release_work_fn	|	css = task_get_css(tsk, cpuset_cgrp_id);
> css_free_rwork_fn	|	cgroup_path_ns(css->cgroup, ...);
> cgroup_destroy_root	|	mutex_lock(&cgroup_mutex);
> rebind_subsystems	|
> cgroup_free_root	|
> 			|	// cgrp was freed, UAF
> 			|	cgroup_path_ns_locked(cgrp,..);
> 
> When the cpuset is initialized, the root node top_cpuset.css.cgrp
> will point to &cgrp_dfl_root.cgrp. In cgroup v1, the mount operation will
> allocate cgroup_root, and top_cpuset.css.cgrp will point to the allocated
> &cgroup_root.cgrp. When the umount operation is executed,
> top_cpuset.css.cgrp will be rebound to &cgrp_dfl_root.cgrp.
> 
> The problem is that when rebinding to cgrp_dfl_root, there are cases
> where the cgroup_root allocated by setting up the root for cgroup v1
> is cached. This could lead to a Use-After-Free (UAF) if it is
> subsequently freed. The descendant cgroups of cgroup v1 can only be
> freed after the css is released. However, the css of the root will never
> be released, yet the cgroup_root should be freed when it is unmounted.
> This means that obtaining a reference to the css of the root does
> not guarantee that css.cgrp->root will not be freed.
> 
> Fix this problem by using rcu_read_lock in proc_cpuset_show().
> As cgroup_root is kfree_rcu after commit d23b5c577715
> ("cgroup: Make operations on the cgroup root_list RCU safe"),
> css->cgroup won't be freed during the critical section.
> To call cgroup_path_ns_locked, css_set_lock is needed, so it is safe to
> replace task_get_css with task_css.
> 
> [1] https://syzkaller.appspot.com/bug?extid=9b1ff7be974a403aa4cd
> 
> Fixes: a79a908fd2b0 ("cgroup: introduce cgroup namespaces")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
> ---
>  kernel/cgroup/cpuset.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Now queued up, thanks.

greg k-h

