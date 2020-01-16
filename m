Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF3CE140049
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2020 00:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgAPX5e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jan 2020 18:57:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53959 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgAPX5e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jan 2020 18:57:34 -0500
Received: from ip5f5bd663.dynamic.kabel-deutschland.de ([95.91.214.99] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1isF0t-0008BL-JE; Thu, 16 Jan 2020 23:57:23 +0000
Date:   Fri, 17 Jan 2020 00:57:22 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 2/3] clone3: allow spawning processes into cgroups
Message-ID: <20200116235721.tnadjblifqirg5bo@wittgenstein>
References: <20191223061504.28716-1-christian.brauner@ubuntu.com>
 <20191223061504.28716-3-christian.brauner@ubuntu.com>
 <20200108160102.GA17415@blackbody.suse.cz>
 <20200108181049.ysmo73celrt4bvo2@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200108181049.ysmo73celrt4bvo2@wittgenstein>
User-Agent: NeoMutt/20180716
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 08, 2020 at 07:10:49PM +0100, Christian Brauner wrote:
> On Wed, Jan 08, 2020 at 05:01:02PM +0100, Michal Koutný wrote:
> > On Mon, Dec 23, 2019 at 07:15:03AM +0100, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > > This adds support for creating a process in a different cgroup than its
> > > parent.
> > Binding fork and migration together looks useful.
> > 
> > > --- a/kernel/cgroup/cgroup.c
> > > +++ b/kernel/cgroup/cgroup.c
> > > @@ -5882,21 +5882,176 @@ void cgroup_fork(struct task_struct *child)
> > >  	INIT_LIST_HEAD(&child->cg_list);
> > Just a nitpick, I noticed the comment for cgroup_fork should be updated
> > too (generic migration happens in cgroup_post_fork).
> 
> Thanks.
> 
> > 
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > [...]
> > > @@ -2279,8 +2278,7 @@ static __latent_entropy struct task_struct *copy_process(
> > >  	write_unlock_irq(&tasklist_lock);
> > >  
> > >  	proc_fork_connector(p);
> > > -	cgroup_post_fork(p);
> > > -	cgroup_threadgroup_change_end(current);
> > > +	cgroup_post_fork(current, p, args);
> > I can see that when CLONE_INTO_CGROUP | CLONE_NEWCGROUP is passed, then
> > the child's cgroup NS will be rooted at parent's css set
> > (copy_namespaces precedes cgroup_post_fork).
> > 
> > Wouldn't it make better sense if this flags combination resulted in
> > child's NS rooted in its css set?
> 
> I need to take a closer look but it sounds like we should move the
> copying of the cgroup namespace to a later point; but again I need to
> look into this.

Ok, this is way simpler I think, we just set the root_cset of the new
cgroup namespace to the child's cset in cgroup_post_fork() if
CLONE_NEWCGROUP is requested.

Christian
