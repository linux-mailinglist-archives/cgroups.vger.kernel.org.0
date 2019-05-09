Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC3618B07
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2019 15:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfEINyy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 May 2019 09:54:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbfEINyy (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 9 May 2019 09:54:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D3E8C057F3B;
        Thu,  9 May 2019 13:54:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id BE9E31001E7C;
        Thu,  9 May 2019 13:54:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  9 May 2019 15:54:53 +0200 (CEST)
Date:   Thu, 9 May 2019 15:54:51 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH] cgroup: never call do_group_exit() with task->frozen bit
 set
Message-ID: <20190509135450.GA24526@redhat.com>
References: <20190508203420.580163-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508203420.580163-1-guro@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 09 May 2019 13:54:54 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 05/08, Roman Gushchin wrote:
>
> To resolve this problem, let's move cgroup_leave_frozen(true) call to
> just after the fatal label. If the task is going to die, the frozen
> bit must be cleared no matter how we get into this point.

OK, agreed, better than nothing.

but please see my previous email. enter_frozen() in ptrace_stop() is not safe
anyway. In fact somehow I thought it does leave_frozen(), iirc this was true
in the earlier versions...

> 
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Reported-by: Qian Cai <cai@lca.pw>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  kernel/signal.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 16b72f4f14df..8607b11ff936 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2483,10 +2483,6 @@ bool get_signal(struct ksignal *ksig)
>  		ksig->info.si_signo = signr = SIGKILL;
>  		sigdelset(&current->pending.signal, SIGKILL);
>  		recalc_sigpending();
> -		current->jobctl &= ~JOBCTL_TRAP_FREEZE;
> -		spin_unlock_irq(&sighand->siglock);
> -		if (unlikely(cgroup_task_frozen(current)))
> -			cgroup_leave_frozen(true);
>  		goto fatal;
>  	}
>  
> @@ -2608,8 +2604,10 @@ bool get_signal(struct ksignal *ksig)
>  			continue;
>  		}
>  
> -		spin_unlock_irq(&sighand->siglock);
>  	fatal:
> +		spin_unlock_irq(&sighand->siglock);
> +		if (unlikely(cgroup_task_frozen(current)))
> +			cgroup_leave_frozen(true);
>  
>  		/*
>  		 * Anything else is fatal, maybe with a core dump.
> -- 
> 2.20.1
> 

