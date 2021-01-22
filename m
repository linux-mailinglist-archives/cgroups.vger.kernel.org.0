Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7592FFDED
	for <lists+cgroups@lfdr.de>; Fri, 22 Jan 2021 09:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbhAVILN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Jan 2021 03:11:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726902AbhAVIKY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Jan 2021 03:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611302937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1r1C6b8Yt+X+h4kUeUrmzS4UC5HaV/EkqiwbM/xr4OU=;
        b=NtZzJ9KD84xarm0pWCQ7v+CDNl8scVldVnC6hqfVri6m7kjg9ers2NmH73VEcloGMgTtaG
        38+Sbl3OspUwbuvZ8YMN9VDQ5t/5Ntrx0Nfmmk0VSRiJP5CbnS/fsZos5E+vNyY5d28puM
        BdEcwoymDiZaSZaAG5a4MHB2hKLHnhQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-02yeH70IM5aVN6BQlsnwMg-1; Fri, 22 Jan 2021 03:08:55 -0500
X-MC-Unique: 02yeH70IM5aVN6BQlsnwMg-1
Received: by mail-ed1-f71.google.com with SMTP id n8so2536763edo.19
        for <cgroups@vger.kernel.org>; Fri, 22 Jan 2021 00:08:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1r1C6b8Yt+X+h4kUeUrmzS4UC5HaV/EkqiwbM/xr4OU=;
        b=SaVDFifH0SmdcIDhCC//vtGuBH4pyzkoMzGFWmvfrrX+yCxoAlpnON8Q9z9/+MCsAl
         fxspyoZAps/ZXFh6z6lIqMX1GMqDvzQArD4vUM5Bi/brcQdVw2Y2OhVjgD/tuCFkiG4H
         WZ6QPmNlx5qmaKEHRnXaNsCdtnaRDOmfE4cMOcWHFKp1Wxeum4aa1VFGk5EWUPQShTT/
         zDtMan9oGWeuBLegtGjSfHiIPv1gHcNuWGEkZYDe85HIeK4beeFT8LEFoXxoSKeHD4i/
         MzcaFPeVsa3DM31jt2nCFoMkiYatOSUmF9cJ1UZflvdpH6AHGkN0hbLumAR9N82+0PXU
         5ktA==
X-Gm-Message-State: AOAM530flvVldqqxgbw0Ip8vkd0ckoToG9/mHrjIXma7F5hJI8c57r1j
        FPyEoYoEwYSqIAuYFBwnc6D5dfYrXUxHOct3ZwY6FNMVn7qjkaC7oUf7lfvf9ov2XYcwzn2C9IX
        bJyJLC45hw1K03S4K/g==
X-Received: by 2002:a05:6402:490:: with SMTP id k16mr2229217edv.71.1611302934540;
        Fri, 22 Jan 2021 00:08:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4iPl8/f+eb+Pr1AYLOy/jbyis1Gtj5kxSaoayd7OeDLN/a+loD+oNA0ELuCO2YPT68pB8SQ==
X-Received: by 2002:a05:6402:490:: with SMTP id k16mr2229200edv.71.1611302934288;
        Fri, 22 Jan 2021 00:08:54 -0800 (PST)
Received: from localhost.localdomain ([151.29.110.43])
        by smtp.gmail.com with ESMTPSA id x17sm4706846edq.77.2021.01.22.00.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 00:08:53 -0800 (PST)
Date:   Fri, 22 Jan 2021 09:08:51 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Marco Perronet <perronet@mpi-sws.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 3/6] sched/deadline: Allow DL tasks on empty (cgroup v2)
 cpusets
Message-ID: <20210122080851.GK10569@localhost.localdomain>
References: <cover.1610463999.git.bristot@redhat.com>
 <8380113688bd64a6deb3241ff6a0fff62b157f47.1610463999.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8380113688bd64a6deb3241ff6a0fff62b157f47.1610463999.git.bristot@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 12/01/21 16:53, Daniel Bristot de Oliveira wrote:
> cgroups v2 allows the cpuset controller to be enabled/disabled on
> demand. On Fedora 32, cpuset is disabled by default. To enable it,
> a user needs to:
> 
>   # cd /sys/fs/cgroup/
>   # echo +cpuset > cgroup.subtree_control
> 
> Existing cgroups will expose the cpuset interface (e.g., cpuset.cpus
> file). By default, cpuset.cpus has no CPU assigned, which means that
> existing tasks will move to a cpuset without cpus.

This is kind of confusing, though. Isn't it?

> Initially, I thought about returning an error and blocking the
> operation. However, that is indeed not needed. The cpuset without
> CPUs assigned will be a non-root cpuset, hence its cpu mask will
> be the same as the root one. So, the bandwidth was already accounted,
> and the task can proceed.
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> ---
>  kernel/sched/deadline.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 943aa32cc1bc..788a391657a5 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2871,6 +2871,13 @@ int dl_task_can_attach(struct task_struct *p,
>  	bool overflow;
>  	int ret;
>  
> +	/*
> +	 * The cpuset has no cpus assigned, so the thread will not
> +	 * change its affinity.

Is this always the case also in the presence of deeper hierarchies?

Thanks,
Juri

