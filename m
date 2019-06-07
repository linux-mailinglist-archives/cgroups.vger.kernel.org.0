Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFC9392D2
	for <lists+cgroups@lfdr.de>; Fri,  7 Jun 2019 19:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbfFGRJ4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+cgroups@lfdr.de>); Fri, 7 Jun 2019 13:09:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:40286 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731239AbfFGRJ4 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 7 Jun 2019 13:09:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4139FACC4;
        Fri,  7 Jun 2019 17:09:55 +0000 (UTC)
Date:   Fri, 7 Jun 2019 19:09:53 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Topi Miettinen <toiwoton@gmail.com>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        security@debian.org, security@kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 3/3 cgroup/for-5.2-fixes] cgroup: Include dying leaders
 with live threads in PROCS iterations
Message-ID: <20190607170952.GE30727@blackbody.suse.cz>
References: <20190527151806.GC8961@redhat.com>
 <87blznagrl.fsf@xmission.com>
 <1956727d-1ee8-92af-1e00-66ae4921b075@gmail.com>
 <87zhn6923n.fsf@xmission.com>
 <e407a8e7-7780-f08f-320a-a0f2c954d253@gmail.com>
 <20190529003601.GN374014@devbig004.ftw2.facebook.com>
 <e45d974b-5eff-f781-291f-ddf5e9679e4c@gmail.com>
 <20190530183556.GR374014@devbig004.ftw2.facebook.com>
 <20190530183637.GS374014@devbig004.ftw2.facebook.com>
 <20190530183700.GT374014@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190530183700.GT374014@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi.

This case of dead group leaders and running siblings -- SIGCHILD is
delivered to the parent only when the last thread of the threadgroup
terminates.

On Thu, May 30, 2019 at 11:37:00AM -0700, Tejun Heo <tj@kernel.org> wrote:
> @@ -6009,6 +6031,7 @@ void cgroup_exit(struct task_struct *tsk
>  	if (!list_empty(&tsk->cg_list)) {
>  		spin_lock_irq(&css_set_lock);
>  		css_set_move_task(tsk, cset, NULL, false);
> +		list_add_tail(&tsk->cg_list, &cset->dying_tasks);
>  		cset->nr_tasks--;
>  
>  		WARN_ON_ONCE(cgroup_task_frozen(tsk));
> @@ -6034,6 +6057,13 @@ void cgroup_release(struct task_struct *
>  	do_each_subsys_mask(ss, ssid, have_release_callback) {
>  		ss->release(task);
>  	} while_each_subsys_mask();
> +
> +	if (use_task_css_set_links) {
> +		spin_lock_irq(&css_set_lock);
> +		css_set_skip_task_iters(task_css_set(task), task);
> +		list_del_init(&task->cg_list);
> +		spin_unlock_irq(&css_set_lock);
> +	}
>  }

Wouldn't it make more sense to call
	css_set_move_task(tsk, cset, NULL, false);
in cgroup_release instead of cgroup_exit then?

css_set_move_task triggers the cgroup emptiness notification so if we
list group leaders with running siblings as members of the cgroup (IMO
correct), is it consistent to deliver the (un)populated event
that early?
By moving to cgroup_release we would also make this notification
analogous to SIGCHLD delivery.

Michal
