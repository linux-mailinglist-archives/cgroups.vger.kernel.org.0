Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B893714CB68
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2020 14:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgA2N0M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Jan 2020 08:26:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:53448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgA2N0L (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 29 Jan 2020 08:26:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AD428AD07;
        Wed, 29 Jan 2020 13:26:09 +0000 (UTC)
Date:   Wed, 29 Jan 2020 14:26:08 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v5 3/6] cgroup: refactor fork helpers
Message-ID: <20200129132608.GC11384@blackbody.suse.cz>
References: <20200121154844.411-1-christian.brauner@ubuntu.com>
 <20200121154844.411-4-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200121154844.411-4-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 21, 2020 at 04:48:41PM +0100, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 9b3241d67592..ce2d5b8aa19f 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5895,17 +5895,21 @@ static struct cgroup *cgroup_get_from_file(struct file *f)
>  
>  /**
>   * cgroup_can_fork - called on a new task before the process is exposed
> - * @child: the task in question.
> + * @child: the child process
> + * @kargs: the arguments passed to create the child process
This comment should only come with the later commmits.

> - * cgroup_cancel_fork - called if a fork failed after cgroup_can_fork()
> - * @child: the task in question
> - *
> - * This calls the cancel_fork() callbacks if a fork failed *after*
> - * cgroup_can_fork() succeded.
> - */
> +  * cgroup_cancel_fork - called if a fork failed after cgroup_can_fork()
> +  * @child: the child process
> +  * @kargs: the arguments passed to create the child process
Ditto

> - * cgroup_post_fork - called on a new task after adding it to the task list
> - * @child: the task in question
> - *
> - * Adds the task to the list running through its css_set if necessary and
> - * call the subsystem fork() callbacks.  Has to be after the task is
> - * visible on the task list in case we race with the first call to
> - * cgroup_task_iter_start() - to guarantee that the new task ends up on its
> - * list.
> + * cgroup_post_fork - finalize cgroup setup for the child process
> + * @child: the child process
> + * @kargs: the arguments passed to create the child process
One more.

Besides the misrebased comments
Acked-by: Michal Koutný <mkoutny@suse.com>

