Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA85370714
	for <lists+cgroups@lfdr.de>; Sat,  1 May 2021 13:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhEAL5G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 1 May 2021 07:57:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231882AbhEAL5G (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 1 May 2021 07:57:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FCCD6140C;
        Sat,  1 May 2021 11:56:14 +0000 (UTC)
Date:   Sat, 1 May 2021 13:56:12 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 2/5] docs/cgroup: add entry for cgroup.kill
Message-ID: <20210501115612.nfm3f3ag6fbmfmzl@wittgenstein>
References: <20210429120113.2238065-1-brauner@kernel.org>
 <20210429120113.2238065-2-brauner@kernel.org>
 <YIt32/aQJfkw53ic@carbon.dhcp.thefacebook.com>
 <20210430065036.uinuugxw6dhdqytc@wittgenstein>
 <YIzBc5IgiaIFykc5@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YIzBc5IgiaIFykc5@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 30, 2021 at 07:48:19PM -0700, Roman Gushchin wrote:
> On Fri, Apr 30, 2021 at 08:50:36AM +0200, Christian Brauner wrote:
> > On Thu, Apr 29, 2021 at 08:22:03PM -0700, Roman Gushchin wrote:
> > > On Thu, Apr 29, 2021 at 02:01:10PM +0200, Christian Brauner wrote:
> > > > From: Christian Brauner <christian.brauner@ubuntu.com>
> > > > 
> > > > Give a brief overview of the cgroup.kill functionality.
> > > > 
> > > > Cc: Roman Gushchin <guro@fb.com>
> > > > Cc: Tejun Heo <tj@kernel.org>
> > > > Cc: cgroups@vger.kernel.org
> > > > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > > ---
> > > >  Documentation/admin-guide/cgroup-v2.rst | 17 +++++++++++++++++
> > > >  1 file changed, 17 insertions(+)
> > > > 
> > > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > > index 64c62b979f2f..c9f656a84590 100644
> > > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > > @@ -949,6 +949,23 @@ All cgroup core files are prefixed with "cgroup."
> > > >  	it's possible to delete a frozen (and empty) cgroup, as well as
> > > >  	create new sub-cgroups.
> > > >  
> > > > +  cgroup.kill
> > > > +	A write-only single value file which exists in non-root cgroups.
> > > > +	The only allowed value is "1".
> > > > +
> > > > +	Writing "1" to the file causes the cgroup and all descendant cgroups to
> > > > +	be killed. This means that all processes located in the affected cgroup
> > > > +	tree will be killed via SIGKILL.
> > > > +
> > > > +	Killing a cgroup tree will deal with concurrent forks appropriately and
> > > > +	is protected against migrations. If callers require strict guarantees
> > > > +	they can issue the cgroup.kill request after a freezing the cgroup via
> > > > +	cgroup.freeze.
> > > 
> > > Hm, is it necessarily? What additional guarantees adds using the freezer?
> > 
> > Every new process that get's added is frozen. So even if the a process
> > ends up escaping the cgroup.kill request somehow it will be frozen in
> > the cgroup and can't itself fork again right away. So you could do:
> 
> Right, but how it can escape? I think one of the main reasons of introducing
> a dedicated cgroup.kill interface is to avoid a necessity to use freezer
> as a synchronization mechanism.
> 
> I'd just drop the sentence about the freezer here.

Thanks, will do.

Christian
