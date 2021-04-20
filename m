Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E0F3658B5
	for <lists+cgroups@lfdr.de>; Tue, 20 Apr 2021 14:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhDTMMf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Apr 2021 08:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232445AbhDTMM2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 20 Apr 2021 08:12:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF9AF6113C;
        Tue, 20 Apr 2021 12:11:55 +0000 (UTC)
Date:   Tue, 20 Apr 2021 14:11:52 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: Killing cgroups
Message-ID: <20210420121152.kplnuuujuplmcs6m@wittgenstein>
References: <20210419155607.gmwu376cj4nyagyj@wittgenstein>
 <CALvZod6haoRmgp++9sqvZaYCo+gaK6t5MSfSZ7XFpm4p6wACwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALvZod6haoRmgp++9sqvZaYCo+gaK6t5MSfSZ7XFpm4p6wACwA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 19, 2021 at 10:08:19AM -0700, Shakeel Butt wrote:
> On Mon, Apr 19, 2021 at 8:56 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
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
> 
> and the descendant cgroups as well.

Yes, I think in line with the current design it would need to be
recursive by default. Which I think is fine. The case where we only want
to wipe all processes in a single cgroup might be ok to do manually.

> 
> >
> > int fd = open("/sys/fs/cgroup/my/delegated/cgroup", O_RDWR);
> > write(fd, "SIGKILL", sizeof("SIGKILL") - 1);
> 
> The userspace oom-killers can also take advantage of this feature.

Good to hear that there are more use-cases.
