Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1974E36F5CD
	for <lists+cgroups@lfdr.de>; Fri, 30 Apr 2021 08:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhD3Gm7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Apr 2021 02:42:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhD3Gm7 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 30 Apr 2021 02:42:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97A0F6135B;
        Fri, 30 Apr 2021 06:42:09 +0000 (UTC)
Date:   Fri, 30 Apr 2021 08:42:06 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 3/5] tests/cgroup: use cgroup.kill in cg_killall()
Message-ID: <20210430064206.um6fm5sr2vuyoak3@wittgenstein>
References: <20210429120113.2238065-1-brauner@kernel.org>
 <20210429120113.2238065-3-brauner@kernel.org>
 <YIt4NhikbQKc0Vku@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YIt4NhikbQKc0Vku@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 29, 2021 at 08:23:34PM -0700, Roman Gushchin wrote:
> On Thu, Apr 29, 2021 at 02:01:11PM +0200, Christian Brauner wrote:
> > From: Christian Brauner <christian.brauner@ubuntu.com>
> > 
> > If cgroup.kill file is supported make use of it.
> > 
> > Cc: Roman Gushchin <guro@fb.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: cgroups@vger.kernel.org
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> >  tools/testing/selftests/cgroup/cgroup_util.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> > index 027014662fb2..3e27cd9bda75 100644
> > --- a/tools/testing/selftests/cgroup/cgroup_util.c
> > +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> > @@ -252,6 +252,10 @@ int cg_killall(const char *cgroup)
> >  	char buf[PAGE_SIZE];
> >  	char *ptr = buf;
> >  
> > +	/* If cgroup.kill exists use it. */
> > +        if (!cg_write(cgroup, "cgroup.kill", "1"))
>    ^^^^^^^^
>    spaces?

Huh, sorry about that weird how that got in there...
Will fix.
