Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501523658F0
	for <lists+cgroups@lfdr.de>; Tue, 20 Apr 2021 14:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhDTM32 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Apr 2021 08:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231393AbhDTM3Z (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 20 Apr 2021 08:29:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E78B611F2;
        Tue, 20 Apr 2021 12:28:51 +0000 (UTC)
Date:   Tue, 20 Apr 2021 14:28:48 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: Killing cgroups
Message-ID: <20210420122848.wwbioclewqeolucf@wittgenstein>
References: <20210419155607.gmwu376cj4nyagyj@wittgenstein>
 <YH2slGErZ7s4t6DC@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YH2slGErZ7s4t6DC@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 19, 2021 at 09:15:16AM -0700, Roman Gushchin wrote:
> On Mon, Apr 19, 2021 at 05:56:07PM +0200, Christian Brauner wrote:
> > Hey,
> > 
> > It's not as dramatic as it sounds but I've been mulling a cgroup feature
> > for some time now which I would like to get some input on. :)
> > 
> > So in container-land assuming a conservative layout where we treat a
> > container as a separate machine we tend to give each container a
> > delegated cgroup. That has already been the case with cgroup v1 and now
> > even more so with cgroup v2.
> > 
> > So usually you will have a 1:1 mapping between container and cgroup. If
> > the container in addition uses a separate pid namespace then killing a
> > container becomes a simple kill -9 <container-init-pid> from an ancestor
> > pid namespace.
> > 
> > However, there are quite a few scenarios where one or two of those
> > assumptions aren't true, i.e. there are containers that share the cgroup
> > with other processes on purpose that are supposed to be bound to the
> > lifetime of the container but are not in the same pidns of the
> > container. Containers that are in a delegated cgroup but share the pid
> > namespace with the host or other containers.
> > 
> > This is just the container use-case. There are additional use-cases from
> > systemd services for example.
> > 
> > For such scenarios it would be helpful to have a way to kill/signal all
> > processes in a given cgroup.
> > 
> > It feels to me that conceptually this is somewhat similar to the freezer
> > feature. Freezer is now nicely implemented in cgroup.freeze. I would
> > think we could do something similar for the signal feature I'm thinking
> > about. So we add a file cgroup.signal which can be opened with O_RDWR
> > and can be used to send a signal to all processes in a given cgroup:
> > 
> > int fd = open("/sys/fs/cgroup/my/delegated/cgroup", O_RDWR);
> > write(fd, "SIGKILL", sizeof("SIGKILL") - 1);
> > 
> > with SIGKILL being the only signal supported for a start and we can in
> > the future extend this to more signals.
> > 
> > I'd like to hear your general thoughts about a feature like this or
> > similar to this before prototyping it.
> 
> Hello Christian!

Hey Roman,

Thanks for your quick reply!

> 
> Tejun and me discussed a feature like this during my work on the freezer
> controller, and we both thought it might be useful. But because there is
> a relatively simple userspace way to do it (which is implemented many times),
> and systemd and other similar control daemons will need to keep it in a
> working state for a quite some time anyway (to work on older kernels),
> it was considered a low-prio feature, and it was somewhere on my to-do list
> since then.

Totally understandable. I take it though we agree that this interface
should exist as it seems really useful (especially for the recursive
case) and we had a few others point out that they could make use of it.

> I'm not sure we need anything beyond SIGKILL and _maybe_ SIGTERM.

Yeah, my feeling is SIGKILL and SIGTERM might be sufficient with SIGKILL
being the first target. I would think that having more generic name for
the file like cgroup.signal is better than cgroup.kill as I wouldn't be
so sure that we don't end up with a few more signals due to unforseen
use-cases in the future.

> Indeed it can be implemented re-using a lot from the freezer code.

Yeah, that was my feeling too.

> Please, let me know if I can help.

Yes, will do. I'll take a look at the implementation soon and start
working on a patch. I'm sure I'll have questions sooner or later. :)

Christian
