Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD81372FB5
	for <lists+cgroups@lfdr.de>; Tue,  4 May 2021 20:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhEDSa3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 14:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhEDSa3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 May 2021 14:30:29 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6833C061574
        for <cgroups@vger.kernel.org>; Tue,  4 May 2021 11:29:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t11so13203563lfl.11
        for <cgroups@vger.kernel.org>; Tue, 04 May 2021 11:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXXBzPVYriNU3AZ8+T/Ep3xDDMXplh3X9mxTUQBN+dA=;
        b=hUIk+ejn4mtB5LxTTxxmX1ZYUMPfRW5P8+zTJMe6n5i7h98wmNOBt3kaTME94977CJ
         68D0w2yrHs/GckpeSze/93uWthbAOqoG77DneKmNQznDB9tNH/eAf+q48A+C1hGuv3XS
         Rm+2A59azRpg2dSEuZk8CxcVx96ggecVZOt+K81EQjGcYjjc4ovtg3pfBUWPStMPYHgS
         byiQHzCg7fyjt/Zb+iswScBHIKYAMPvulGqgFsOESr4b80b0OLp9Zkgld+gC78KlaCyp
         2W6mVjuaY8+77uVUp/t9IZXfQB01ZTjMYKGJ2qCPBNhQphXjt6sPcZrLuq96VlK4xleN
         QSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXXBzPVYriNU3AZ8+T/Ep3xDDMXplh3X9mxTUQBN+dA=;
        b=Fs8T599qa7qz3kM0QI5MzBQbiswDckvowC40bpRgIYHXW/9UrtTQg0XoCm2YBhVFxg
         bcM0iO3t4T2XUysZdIL/UNwZfNhq1Y6nVX1Y/R5eCGj/ZdJXhsOUg5sFMcEDcbe2FelT
         +Nm9CmxrxJhIV4Bm8hgnsaNI+Ivv5EKacoXIAX3GgJFMcL6oYGAnqJcqOZ/4l+0I36OX
         rRTn7sG0In/8wObFIx30pYYZl6YtRQ9CAFoYi9GmOuyBwSxz3VyZIAGPzeL/yX0utkow
         yYB4aKveTyB+x7rZ2LtO/ubUzy73OIPdXwqn5TASreyFhXFqyfvNC7+aIj53dzPufUGq
         1xlA==
X-Gm-Message-State: AOAM5309YRp+u/4PRuXNyC996Ldyi5sW5ONXahE/gXEhWqlBSONk/3Jx
        6ZIQ6qiX9Wk2sHz3ZLmQX2YlKl4d4m+wnWHyX5Qi+Q==
X-Google-Smtp-Source: ABdhPJzTFw0ATQzNtH7zRPhI1FS9ArT6LmgJd+cmxH6tIg2VPP6mKUzSJaCoH/lzHoBxhNRCnEZ2Pfb8FX81sFWxseo=
X-Received: by 2002:a05:6512:2344:: with SMTP id p4mr2756781lfu.299.1620152972009;
 Tue, 04 May 2021 11:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210503143922.3093755-1-brauner@kernel.org>
In-Reply-To: <20210503143922.3093755-1-brauner@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 4 May 2021 11:29:21 -0700
Message-ID: <CALvZod4jsb6bFzTOS4ZRAJGAzBru0oWanAhezToprjACfGm+ew@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] cgroup: introduce cgroup.kill
To:     Christian Brauner <brauner@kernel.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>, containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

+Michal Hocko

On Mon, May 3, 2021 at 7:40 AM Christian Brauner <brauner@kernel.org> wrote:
>
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Introduce the cgroup.kill file. It does what it says on the tin and
> allows a caller to kill a cgroup by writing "1" into cgroup.kill.
> The file is available in non-root cgroups.
>
> Killing cgroups is a process directed operation, i.e. the whole
> thread-group is affected. Consequently trying to write to cgroup.kill in
> threaded cgroups will be rejected and EOPNOTSUPP returned. This behavior
> aligns with cgroup.procs where reads in threaded-cgroups are rejected
> with EOPNOTSUPP.
>
> The cgroup.kill file is write-only since killing a cgroup is an event
> not which makes it different from e.g. freezer where a cgroup
> transitions between the two states.
>
> As with all new cgroup features cgroup.kill is recursive by default.
>
> Killing a cgroup is protected against concurrent migrations through the
> cgroup mutex. To protect against forkbombs and to mitigate the effect of
> racing forks a new CGRP_KILL css set lock protected flag is introduced
> that is set prior to killing a cgroup and unset after the cgroup has
> been killed. We can then check in cgroup_post_fork() where we hold the
> css set lock already whether the cgroup is currently being killed. If so
> we send the child a SIGKILL signal immediately taking it down as soon as
> it returns to userspace. To make the killing of the child semantically
> clean it is killed after all cgroup attachment operations have been
> finalized.
>
> There are various use-cases of this interface:
> - Containers usually have a conservative layout where each container
>   usually has a delegated cgroup. For such layouts there is a 1:1
>   mapping between container and cgroup. If the container in addition
>   uses a separate pid namespace then killing a container usually becomes
>   a simple kill -9 <container-init-pid> from an ancestor pid namespace.
>   However, there are quite a few scenarios where that isn't true. For
>   example, there are containers that share the cgroup with other
>   processes on purpose that are supposed to be bound to the lifetime of
>   the container but are not in the same pidns of the container.
>   Containers that are in a delegated cgroup but share the pid namespace
>   with the host or other containers.
> - Service managers such as systemd use cgroups to group and organize
>   processes belonging to a service. They usually rely on a recursive
>   algorithm now to kill a service. With cgroup.kill this becomes a
>   simple write to cgroup.kill.
> - Userspace OOM implementations can make good use of this feature to
>   efficiently take down whole cgroups quickly.

Just to further add the motivation for userspace oom-killers. Instead
of traversing the tree, opening cgroup.procs and manually killing the
processes under memory pressure, the userspace oom-killer can just
keep the list of cgroup.kill files open and just write '1' when it
decides to trigger the oom-kill.

Michal, what do you think of putting the processes killed through this
interface into the oom_reaper_list as well? Will there be any
concerns?

> - The kill program can gain a new
>   kill --cgroup /sys/fs/cgroup/delegated
>   flag to take down cgroups.
>
> A few observations about the semantics:
> - If parent and child are in the same cgroup and CLONE_INTO_CGROUP is
>   not specified we are not taking cgroup mutex meaning the cgroup can be
>   killed while a process in that cgroup is forking.
>   If the kill request happens right before cgroup_can_fork() and before
>   the parent grabs its siglock the parent is guaranteed to see the
>   pending SIGKILL. In addition we perform another check in
>   cgroup_post_fork() whether the cgroup is being killed and is so take
>   down the child (see above). This is robust enough and protects gainst
>   forkbombs. If userspace really really wants to have stricter
>   protection the simple solution would be to grab the write side of the
>   cgroup threadgroup rwsem which will force all ongoing forks to
>   complete before killing starts. We concluded that this is not
>   necessary as the semantics for concurrent forking should simply align
>   with freezer where a similar check as cgroup_post_fork() is performed.
>
>   For all other cases CLONE_INTO_CGROUP is required. In this case we
>   will grab the cgroup mutex so the cgroup can't be killed while we
>   fork. Once we're done with the fork and have dropped cgroup mutex we
>   are visible and will be found by any subsequent kill request.
> - We obviously don't kill kthreads. This means a cgroup that has a
>   kthread will not become empty after killing and consequently no
>   unpopulated event will be generated. The assumption is that kthreads
>   should be in the root cgroup only anyway so this is not an issue.
> - We skip killing tasks that already have pending fatal signals.
> - Freezer doesn't care about tasks in different pid namespaces, i.e. if
>   you have two tasks in different pid namespaces the cgroup would still
>   be frozen. The cgroup.kill mechanism consequently behaves the same
>   way, i.e. we kill all processes and ignore in which pid namespace they
>   exist.
> - If the caller is located in a cgroup that is killed the caller will
>   obviously be killed as well.
>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: cgroups@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
[...]
