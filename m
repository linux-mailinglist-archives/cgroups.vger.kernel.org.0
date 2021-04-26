Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088C836B6B8
	for <lists+cgroups@lfdr.de>; Mon, 26 Apr 2021 18:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhDZQZI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Apr 2021 12:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234174AbhDZQZI (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 26 Apr 2021 12:25:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 004B461158;
        Mon, 26 Apr 2021 16:24:23 +0000 (UTC)
Date:   Mon, 26 Apr 2021 18:24:21 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [RFC PATCH] cgroup: add cgroup.signal
Message-ID: <20210426162421.6okhu5ng3xj3azoo@wittgenstein>
References: <20210423171351.3614430-1-brauner@kernel.org>
 <YIbRZeWIl8i6soSN@blackbook>
 <20210426152932.ekay5rfyqeojzihc@wittgenstein>
 <CALvZod5=eLQMdVXxuhj9ia=PkoRvT5oBxeqZAVtQpSukZ=tCxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALvZod5=eLQMdVXxuhj9ia=PkoRvT5oBxeqZAVtQpSukZ=tCxA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 26, 2021 at 09:08:32AM -0700, Shakeel Butt wrote:
> On Mon, Apr 26, 2021 at 8:29 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> [...]
> > > Have you considered accepting a cgroup fd to pidfd_send_signal and
> > > realize this operation through this syscall? (Just asking as it may
> > > prevent some of these consequences whereas bring other unclarities.)
> >
> > That's semantically quite wrong on several fronts, I think.
> > pidfd_send_signal() operates on pidfds (and for a quirky historical
> > reason /proc/<pid> though that should die at some point). Making this
> > operate on cgroup fds is essentially implicit multiplexing which is
> > pretty nasty imho. In addition, this is a cgroup concept not a pidfd
> > concept.
> 
> What's your take on a new syscall cgroupfd_send_signal()? One
> complexity would be potentially different semantics for v1 and v2.

I would think that this will be labeled overkill and has - imho - almost
zero chance of being accepted.
You'd essentially need to argue that it's sensible for a (virtual)
filesystem to have a separate syscall or syscalls (a signal sending one
at that).
In addition you'd break the filesystem api model that cgroups are
designed around which seems unpleasant.
(And fwiw, an ioctl() would have the same issues though it has
precedence if you look at nsfs. But nsfs doesn't have any real
filesystem interaction model apart from being open()able and is
basically a broken out part from procfs.)
