Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF69613D9F9
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2020 13:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgAPM3u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jan 2020 07:29:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36819 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgAPM3u (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jan 2020 07:29:50 -0500
Received: from ip5f5bd663.dynamic.kabel-deutschland.de ([95.91.214.99] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1is4HR-0007Gn-Gh; Thu, 16 Jan 2020 12:29:45 +0000
Date:   Thu, 16 Jan 2020 13:29:44 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 2/3] clone3: allow spawning processes into cgroups
Message-ID: <20200116122944.nj3e66eusxu6sb44@wittgenstein>
References: <20191223061504.28716-1-christian.brauner@ubuntu.com>
 <20191223061504.28716-3-christian.brauner@ubuntu.com>
 <20200107163204.GB2677547@devbig004.ftw2.facebook.com>
 <20200108180906.l4mvtdmh7nm2z7sc@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200108180906.l4mvtdmh7nm2z7sc@wittgenstein>
User-Agent: NeoMutt/20180716
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 08, 2020 at 07:09:07PM +0100, Christian Brauner wrote:
> On Tue, Jan 07, 2020 at 08:32:04AM -0800, Tejun Heo wrote:
> > On Mon, Dec 23, 2019 at 07:15:03AM +0100, Christian Brauner wrote:
> > > +static struct cgroup *cgroup_get_from_file(struct file *f)
> > > +{
> > > +	struct cgroup_subsys_state *css;
> > > +	struct cgroup *cgrp;
> > > +
> > > +	css = css_tryget_online_from_dir(f->f_path.dentry, NULL);
> > > +	if (IS_ERR(css))
> > > +		return ERR_CAST(css);
> > > +
> > > +	cgrp = css->cgroup;
> > > +	if (!cgroup_on_dfl(cgrp)) {
> > > +		cgroup_put(cgrp);
> > > +		return ERR_PTR(-EBADF);
> > > +	}
> > > +
> > > +	return cgrp;
> > > +}
> > 
> > It's minor but can you put this refactoring into a separate patch?
> 
> Yep, will do.
> 
> > 
> > ...
> > > +static int cgroup_css_set_fork(struct task_struct *parent,
> > > +			       struct kernel_clone_args *kargs)
> > > +	__acquires(&cgroup_mutex) __acquires(&cgroup_threadgroup_rwsem)
> > > +{
> > > +	int ret;
> > > +	struct cgroup *dst_cgrp = NULL, *src_cgrp;
> > > +	struct css_set *cset;
> > > +	struct super_block *sb;
> > > +	struct file *f;
> > > +
> > > +	if (kargs->flags & CLONE_INTO_CGROUP) {
> > > +		ret = mutex_lock_killable(&cgroup_mutex);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > 
> > I don't think this is necessary.  cgroup_mutex should always only be
> > held for a finite enough time; otherwise, processes would get stuck on
> > random cgroupfs accesses or even /proc/self/cgroup.
> 
> Ok, so a simple mutex_lock() should suffice then.
> 
> > 
> > ...
> > > +	spin_lock_irq(&css_set_lock);
> > > +	src_cgrp = task_cgroup_from_root(parent, &cgrp_dfl_root);
> > > +	spin_unlock_irq(&css_set_lock);
> > 
> > You can simply do cset->dfl_root here, which is consistent with other
> > code paths which know that they want the dfl cgroup.
> 
> Ah, great!
> 
> > 
> > > +	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp, sb,
> > > +					!!(kargs->flags & CLONE_THREAD));
> > > +	if (ret)
> > > +		goto err;
> > 
> > So, the existing perm check depends on the fact that for the write
> > operation to have started, it already should have passed write perm
> > check on the destination cgroup.procs file.  We're missing that here,
> > so we prolly need to check that explicitly.
> 
> I need to look into this before I can say yay or nay. :)

Could it be that you misread cgroup_attach_permissions()? Because it
does check for write permissions on the destination cgroup.procs file.
That's why I've added the cgroup_get_from_file() helper. :) See:

static int cgroup_attach_permissions(struct cgroup *src_cgrp,
				     struct cgroup *dst_cgrp,
				     struct super_block *sb, bool thread)
{
	int ret = 0;

	ret = cgroup_procs_write_permission(src_cgrp, dst_cgrp, sb);
	if (ret)
		return ret;

	ret = cgroup_migrate_vet_dst(dst_cgrp);
	if (ret)
		return ret;

	if (thread &&
	    !cgroup_same_domain(src_cgrp->dom_cgrp, dst_cgrp->dom_cgrp))
		ret = -EOPNOTSUPP;

	return ret;
}

Maybe I'm misunderstanding though. :)

Thanks!
Christian
