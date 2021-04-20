Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE903658D6
	for <lists+cgroups@lfdr.de>; Tue, 20 Apr 2021 14:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhDTMZS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Apr 2021 08:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230118AbhDTMZR (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 20 Apr 2021 08:25:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EA59613BF;
        Tue, 20 Apr 2021 12:24:44 +0000 (UTC)
Date:   Tue, 20 Apr 2021 14:24:39 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: Killing cgroups
Message-ID: <20210420122439.xxz2k6wp76266cix@wittgenstein>
References: <20210419155607.gmwu376cj4nyagyj@wittgenstein>
 <CALvZod6haoRmgp++9sqvZaYCo+gaK6t5MSfSZ7XFpm4p6wACwA@mail.gmail.com>
 <CAMp4zn9_hgKOmamdzzBy5nzLr5pAXQBbuR1sjso-Wck0_3rEfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMp4zn9_hgKOmamdzzBy5nzLr5pAXQBbuR1sjso-Wck0_3rEfA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 19, 2021 at 10:17:29AM -0700, Sargun Dhillon wrote:
> On Mon, Apr 19, 2021 at 10:08 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Mon, Apr 19, 2021 at 8:56 AM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >
> > > Hey,
> > >
> > > It's not as dramatic as it sounds but I've been mulling a cgroup feature
> > > for some time now which I would like to get some input on. :)
> > >
> > > So in container-land assuming a conservative layout where we treat a
> > > container as a separate machine we tend to give each container a
> > > delegated cgroup. That has already been the case with cgroup v1 and now
> > > even more so with cgroup v2.
> > >
> > > So usually you will have a 1:1 mapping between container and cgroup. If
> > > the container in addition uses a separate pid namespace then killing a
> > > container becomes a simple kill -9 <container-init-pid> from an ancestor
> > > pid namespace.
> > >
> > > However, there are quite a few scenarios where one or two of those
> > > assumptions aren't true, i.e. there are containers that share the cgroup
> > > with other processes on purpose that are supposed to be bound to the
> > > lifetime of the container but are not in the same pidns of the
> > > container. Containers that are in a delegated cgroup but share the pid
> > > namespace with the host or other containers.
> > >
> > > This is just the container use-case. There are additional use-cases from
> > > systemd services for example.
> > >
> > > For such scenarios it would be helpful to have a way to kill/signal all
> > > processes in a given cgroup.
> > >
> > > It feels to me that conceptually this is somewhat similar to the freezer
> > > feature. Freezer is now nicely implemented in cgroup.freeze. I would
> > > think we could do something similar for the signal feature I'm thinking
> > > about. So we add a file cgroup.signal which can be opened with O_RDWR
> > > and can be used to send a signal to all processes in a given cgroup:
> >
> > and the descendant cgroups as well.
> >
> > >
> > > int fd = open("/sys/fs/cgroup/my/delegated/cgroup", O_RDWR);
> > > write(fd, "SIGKILL", sizeof("SIGKILL") - 1);
> >
> > The userspace oom-killers can also take advantage of this feature.
> 
> This would be nice for the container runtimes that (currently) freeze,
> then kill all the pids, and unfreeze. Do you think that this could also
> be generalized to sigstop?

As long as we name it cgroup.signal we can technically expand to signals
other than SIGKILL and SIGTERM in the future. The SIG{TERM,KILL} signal
are the most relevant candidates for now.

Though I'm not clear yet what use-case would require us to support
SIGSTOP in this interface given that we have cgroup.freeze which seems
to be an improvement over SIGSTOP in many ways a few of which are
mentioned in the (legacy) freezer controller documentation.
