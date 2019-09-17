Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D92DBB4DFB
	for <lists+cgroups@lfdr.de>; Tue, 17 Sep 2019 14:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfIQMjq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Sep 2019 08:39:46 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34449 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbfIQMjq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Sep 2019 08:39:46 -0400
Received: by mail-qt1-f195.google.com with SMTP id j1so4221386qth.1
        for <cgroups@vger.kernel.org>; Tue, 17 Sep 2019 05:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R/ezrcsOOmYFve9sVvCoAgNAzYrcxI3ZqfDczOwrTQo=;
        b=ASnCSMC08ViV2dV1HpIUvP0F1FE+gu0nrUgys9cLZLkccRSvSqy5yhZxSZMwTryWJf
         2Ma176Jlybq7iGQ871DwaPB1SyLdKcN3ip9sua4WRUqbZE8jovKbkAaAvziUJ3lZVU3r
         /frOpPkUHcCA2cX77jR2IxKRmQTIaw0xKni4Zd+jljixdXKQd7TYwQrcD+CLvIFSElJM
         9dAunBblfH6lgFWcpgMS01BmX+Jl42ZWg0KONfUV5aEcXTBmBMAU9xkFu2fy/75GMGZ2
         9PJpWnHkjB7U1sUGo8/nznAsSz8yiyHCLtH9kP4KFcWIl9EardejBwA4zuijOQVITfNT
         6LFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=R/ezrcsOOmYFve9sVvCoAgNAzYrcxI3ZqfDczOwrTQo=;
        b=dTPv/Qf94DKN0Mx9IRY0qz08jifWft6sOjq1uui2omJSjdxlTswd7i0Hg3aiqm5A9r
         +HIkQYkiS8ArNTTc0MDy3CM96R9i1TbfSr1T2qWTFmNEci18Sho6AQ6R91O4ogbs/xRA
         /xKMnSWcMYCNVrhAyuXXxPDZNnGXQGorJcrpPgfSx1W6k37TcsFaTnJd9S+4f6TU/tGV
         Y1C853E/zt+RJ1/O2CQlUnyiidRb55iAuw9CBoUtKeqeu+BvFRSQzVy4FmSeSEki/zDm
         BAP0Yrkamuc554/A/TNqv1trjYzJ6+t3YnnTpsPQjqhpXi/ZRHsjkS2ncbemcExQ50cE
         USfw==
X-Gm-Message-State: APjAAAWf1TIoM4F/qSwEp3Xc8ACaCQ9xeJ8MjYBcLcC8F2yfUxQlQfuH
        +/+vZzOw0hVUjrz+TzuonSc=
X-Google-Smtp-Source: APXvYqwUWqy1VxoMu0OktHZ2uXbNWDz5t4LADvvcJlve6VdOY96098GvWB0/HHgO2f4aQYoINPas7w==
X-Received: by 2002:a0c:d60b:: with SMTP id c11mr2836509qvj.179.1568723984394;
        Tue, 17 Sep 2019 05:39:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::8d29])
        by smtp.gmail.com with ESMTPSA id w2sm1265656qtc.59.2019.09.17.05.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 05:39:43 -0700 (PDT)
Date:   Tue, 17 Sep 2019 05:39:41 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Honglei Wang <honglei.wang@oracle.com>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] cgroup: freezer: Don't wake up process really blocked on
 signal
Message-ID: <20190917123941.GG3084169@devbig004.ftw2.facebook.com>
References: <20190917064645.14666-1-honglei.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917064645.14666-1-honglei.wang@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

(cc'ing Roman and Oleg and quoting whole body)

On Tue, Sep 17, 2019 at 02:46:45PM +0800, Honglei Wang wrote:
> Process who's waiting for specific sigset shouldn't be woke up
> neither it is moved between different cgroups nor the cgroup it
> belongs to changes the frozen state. We'd better keep it as is
> and let it wait for the desired signals coming.
> 
> Following test case is one scenario which will get "Interrupted
> system call" error if we wake it up in cgroup_freeze_task().
> 
> int main(int argc, char *argv[])
> {
>         sigset_t waitset;
>         int signo;
> 
>         sigemptyset(&waitset);
>         sigaddset(&waitset, SIGINT);
>         sigaddset(&waitset, SIGUSR1);
> 
>         pthread_sigmask(SIG_BLOCK, &waitset, NULL);
> 
>         for (;;) {
>                 signo = sigwaitinfo(&waitset, NULL);
>                 if (signo < 0)
>                         err(1, "sigwaitinfo() failed");
> 
>                 if (signo == SIGUSR1)
>                         printf("Receive SIGUSR1\n");
>                 else
>                         break;
>         }
> 
>         return 0;
> }
> 
> Signed-off-by: Honglei Wang <honglei.wang@oracle.com>
> ---
>  kernel/cgroup/freezer.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
> index 8cf010680678..08f6abacaa75 100644
> --- a/kernel/cgroup/freezer.c
> +++ b/kernel/cgroup/freezer.c
> @@ -162,10 +162,14 @@ static void cgroup_freeze_task(struct task_struct *task, bool freeze)
>  
>  	if (freeze) {
>  		task->jobctl |= JOBCTL_TRAP_FREEZE;
> -		signal_wake_up(task, false);
> +
> +		if (sigisemptyset(&task->real_blocked))
> +			signal_wake_up(task, false);
>  	} else {
>  		task->jobctl &= ~JOBCTL_TRAP_FREEZE;
> -		wake_up_process(task);
> +
> +		if (sigisemptyset(&task->real_blocked))
> +			wake_up_process(task);
>  	}
>  
>  	unlock_task_sighand(task, &flags);
> -- 
> 2.17.0
> 

-- 
tejun
