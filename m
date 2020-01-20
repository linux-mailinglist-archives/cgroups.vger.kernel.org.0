Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1F614336F
	for <lists+cgroups@lfdr.de>; Mon, 20 Jan 2020 22:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgATVjK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Jan 2020 16:39:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44702 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgATVjK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Jan 2020 16:39:10 -0500
Received: from [154.119.55.246] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1itelG-0001cJ-AZ; Mon, 20 Jan 2020 21:39:06 +0000
Date:   Mon, 20 Jan 2020 22:38:56 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4 5/6] clone3: allow spawning processes into cgroups
Message-ID: <20200120213854.32mzzo6ifh76fs5q@wittgenstein>
References: <20200117181219.14542-1-christian.brauner@ubuntu.com>
 <20200117181219.14542-6-christian.brauner@ubuntu.com>
 <20200120153930.GE30403@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200120153930.GE30403@redhat.com>
User-Agent: NeoMutt/20180716
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 20, 2020 at 04:39:30PM +0100, Oleg Nesterov wrote:
> On 01/17, Christian Brauner wrote:
> >
> > +static int cgroup_css_set_fork(struct task_struct *parent,
> > +			       struct kernel_clone_args *kargs)
> ...
> > +	kargs->cset = find_css_set(cset, dst_cgrp);
> > +	if (!kargs->cset) {
> > +		ret = -ENOMEM;
> > +		goto err;
> > +	}
> > +
> > +	if (cgroup_is_dead(dst_cgrp)) {
> > +		ret = -ENODEV;
> > +		goto err;
>                 ^^^^^^^^
> 
> this looks wrong... don't we need put_css_set(kargs->cset) before "goto err" ?

Yeah, but we should rather do:

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 4d36255ef25f..482055d1e64a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5994,6 +5994,8 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
        if (dst_cgrp)
                cgroup_put(dst_cgrp);
        put_css_set(cset);
+       if (kargs->cset)
+               put_css_set(kargs->cset);
        return ret;
 }

Christian
