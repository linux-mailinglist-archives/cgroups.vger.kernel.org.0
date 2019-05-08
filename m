Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6B317D46
	for <lists+cgroups@lfdr.de>; Wed,  8 May 2019 17:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfEHPZn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 May 2019 11:25:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbfEHPZm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 8 May 2019 11:25:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0DA21308795F;
        Wed,  8 May 2019 15:25:41 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id F0BF0277DB;
        Wed,  8 May 2019 15:25:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  8 May 2019 17:25:40 +0200 (CEST)
Date:   Wed, 8 May 2019 17:25:36 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Qian Cai <cai@lca.pw>, "tj@kernel.org" <tj@kernel.org>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ptrace warning due to "cgroup: get rid of
 cgroup_freezer_frozen_exit()"
Message-ID: <20190508152536.GA17058@redhat.com>
References: <1557259462.6132.20.camel@lca.pw>
 <20190507213752.GA24308@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507213752.GA24308@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 08 May 2019 15:25:42 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 05/07, Roman Gushchin wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2484,9 +2484,6 @@ bool get_signal(struct ksignal *ksig)
>                 sigdelset(&current->pending.signal, SIGKILL);
>                 recalc_sigpending();
>                 current->jobctl &= ~JOBCTL_TRAP_FREEZE;

just noticed... perhaps it makes more sense to clear JOBCTL_TRAP_FREEZE
before recalc_sigpending(). Or simply not clear it at all, see below.

> -               spin_unlock_irq(&sighand->siglock);
> -               if (unlikely(cgroup_task_frozen(current)))
> -                       cgroup_leave_frozen(true);
>                 goto fatal;
>         }
>  
> @@ -2608,8 +2605,10 @@ bool get_signal(struct ksignal *ksig)
>                         continue;
>                 }
>  
> -               spin_unlock_irq(&sighand->siglock);
>         fatal:
> +               spin_unlock_irq(&sighand->siglock);
> +               if (unlikely(cgroup_task_frozen(current)))
> +                       cgroup_leave_frozen(true);

Yes, ptrace_signal() can return a fatal signal... and in this case we do not
clear JOBCTL_TRAP_FREEZE. This doesn't look consistent with the code above.



I can only repeat that somehow we need to cleanup/improve the whole logic.

Say, a traced task reports syscall-enter. ptrace_stop() does enter_frozen().
The cgroup can become CGRP_FROZEN after that. Now the debugger does PTRACE_CONT,
the frozen task actually starts the syscall. Obviously not good.

Heh, and if this syscall is sys_exit or sys_exit_group we can hit the same
warning.

Oleg.

