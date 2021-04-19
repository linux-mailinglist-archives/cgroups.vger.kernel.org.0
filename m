Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6564936478E
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbhDSP4m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Apr 2021 11:56:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240196AbhDSP4l (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 19 Apr 2021 11:56:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61F5C6127C;
        Mon, 19 Apr 2021 15:56:10 +0000 (UTC)
Date:   Mon, 19 Apr 2021 17:56:07 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Killing cgroups
Message-ID: <20210419155607.gmwu376cj4nyagyj@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hey,

It's not as dramatic as it sounds but I've been mulling a cgroup feature
for some time now which I would like to get some input on. :)

So in container-land assuming a conservative layout where we treat a
container as a separate machine we tend to give each container a
delegated cgroup. That has already been the case with cgroup v1 and now
even more so with cgroup v2.

So usually you will have a 1:1 mapping between container and cgroup. If
the container in addition uses a separate pid namespace then killing a
container becomes a simple kill -9 <container-init-pid> from an ancestor
pid namespace.

However, there are quite a few scenarios where one or two of those
assumptions aren't true, i.e. there are containers that share the cgroup
with other processes on purpose that are supposed to be bound to the
lifetime of the container but are not in the same pidns of the
container. Containers that are in a delegated cgroup but share the pid
namespace with the host or other containers.

This is just the container use-case. There are additional use-cases from
systemd services for example.

For such scenarios it would be helpful to have a way to kill/signal all
processes in a given cgroup.

It feels to me that conceptually this is somewhat similar to the freezer
feature. Freezer is now nicely implemented in cgroup.freeze. I would
think we could do something similar for the signal feature I'm thinking
about. So we add a file cgroup.signal which can be opened with O_RDWR
and can be used to send a signal to all processes in a given cgroup:

int fd = open("/sys/fs/cgroup/my/delegated/cgroup", O_RDWR);
write(fd, "SIGKILL", sizeof("SIGKILL") - 1);

with SIGKILL being the only signal supported for a start and we can in
the future extend this to more signals.

I'd like to hear your general thoughts about a feature like this or
similar to this before prototyping it.

Thanks!
Christian
