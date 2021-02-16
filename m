Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6AA31D038
	for <lists+cgroups@lfdr.de>; Tue, 16 Feb 2021 19:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBPSaW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Feb 2021 13:30:22 -0500
Received: from foss.arm.com ([217.140.110.172]:40928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhBPSaV (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 16 Feb 2021 13:30:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03282101E;
        Tue, 16 Feb 2021 10:29:35 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 206963F73B;
        Tue, 16 Feb 2021 10:29:28 -0800 (PST)
Date:   Tue, 16 Feb 2021 18:29:25 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Alexey Klimov <aklimov@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        peterz@infradead.org, yury.norov@gmail.com,
        daniel.m.jordan@oracle.com, tglx@linutronix.de, jobaker@redhat.com,
        audralmitchel@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, tj@kernel.org, hannes@cmpxchg.org,
        klimov.linux@gmail.com
Subject: Re: [PATCH v2] cpu/hotplug: wait for cpuset_hotplug_work to finish
 on cpu onlining
Message-ID: <20210216182925.v2fe3foe6dgmiaj6@e107158-lin.cambridge.arm.com>
References: <20210212003032.2037750-1-aklimov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210212003032.2037750-1-aklimov@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 02/12/21 00:30, Alexey Klimov wrote:
> When a CPU offlined and onlined via device_offline() and device_online()
> the userspace gets uevent notification. If, after receiving "online" uevent,
> userspace executes sched_setaffinity() on some task trying to move it
> to a recently onlined CPU, then it often fails with -EINVAL. Userspace needs
> to wait around 5..30 ms before sched_setaffinity() will succeed for recently
> onlined CPU after receiving uevent.
> 
> If in_mask argument for sched_setaffinity() has only recently onlined CPU,
> it often fails with such flow:
> 
>   sched_setaffinity()
>     cpuset_cpus_allowed()
>       guarantee_online_cpus()   <-- cs->effective_cpus mask does not
>                                         contain recently onlined cpu
>     cpumask_and()               <-- final new_mask is empty
>     __set_cpus_allowed_ptr()
>       cpumask_any_and_distribute() <-- returns dest_cpu equal to nr_cpu_ids
>       returns -EINVAL
> 
> Cpusets used in guarantee_online_cpus() are updated using workqueue from
> cpuset_update_active_cpus() which in its turn is called from cpu hotplug callback
> sched_cpu_activate() hence it may not be observable by sched_setaffinity() if
> it is called immediately after uevent.

nit: newline

> Out of line uevent can be avoided if we will ensure that cpuset_hotplug_work
> has run to completion using cpuset_wait_for_hotplug() after onlining the
> cpu in cpu_device_up() and in cpuhp_smt_enable().
> 
> Co-analyzed-by: Joshua Baker <jobaker@redhat.com>
> Signed-off-by: Alexey Klimov <aklimov@redhat.com>
> ---

This looks good to me.

Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Thanks

--
Qais Yousef
