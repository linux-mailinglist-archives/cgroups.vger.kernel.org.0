Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41382D0BDE
	for <lists+cgroups@lfdr.de>; Mon,  7 Dec 2020 09:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgLGIj3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Dec 2020 03:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgLGIj3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Dec 2020 03:39:29 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B23FC0613D0;
        Mon,  7 Dec 2020 00:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tt7kYwGZL/f9gqTlt1OKvzsn0qmf++skmQ2P5/DR7To=; b=bV9WbCuibWCCvRZSVNtx4ueWon
        AdM3PcTwc0oGZWl0yGHetGgyPsqdAmMrbvmAM7MjW2ex605SPcrhgyylVOIGxkIj6wJLtEfeHCif9
        /lz3kFjewNZ4yXWBcu58WWaFZPY2biePzkI+VkQAQIASe45vv+V63PEM3MRCtqwfQrqLCcZ36PMwd
        4c4F8IsRynK1Fvs6HXVDP+tavmb4/Aifv4Gw0dcKZYG0ATgNtVNL95UjpX6R/jsMLa8ZnTezY9So9
        jgpcOFTfiZkFsyr7PZibeYGWqbmzz6Id4J7PDaAE7bBtUbcJgMworSUKPTN0CkwSGxVJANF7QA0Do
        g639Bnkg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmC2R-00043e-Cv; Mon, 07 Dec 2020 08:38:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28E6A3006D0;
        Mon,  7 Dec 2020 09:38:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E862D200FABE5; Mon,  7 Dec 2020 09:38:27 +0100 (CET)
Date:   Mon, 7 Dec 2020 09:38:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Klimov <aklimov@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        yury.norov@gmail.com, tglx@linutronix.de, jobaker@redhat.com,
        audralmitchel@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        rafael@kernel.org, tj@kernel.org, lizefan@huawei.com,
        qais.yousef@arm.com, hannes@cmpxchg.org, klimov.linux@gmail.com
Subject: Re: [RFC][PATCH] cpu/hotplug: wait for cpuset_hotplug_work to finish
 on cpu online
Message-ID: <20201207083827.GD3040@hirez.programming.kicks-ass.net>
References: <20201203171431.256675-1-aklimov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203171431.256675-1-aklimov@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Dec 03, 2020 at 05:14:31PM +0000, Alexey Klimov wrote:
> When a CPU offlined and onlined via device_offline() and device_online()
> the userspace gets uevent notification. If, after receiving uevent,
> userspace executes sched_setaffinity() on some task trying to move it
> to a recently onlined CPU, then it will fail with -EINVAL. Userspace needs
> to wait around 5..30 ms before sched_setaffinity() will succeed for
> recently onlined CPU after receiving uevent.

Right.

>  Unfortunately, the execution time of
> echo 1 > /sys/devices/system/cpu/cpuX/online roughly doubled with this
> change (on my test machine).

Nobody cares, it's hotplug, it's supposed to be slow :-) That is,
we fundamentally shift the work _to_ the hotplug path, so as to keep
everybody else fast.

> The nature of this bug is also described here (with different consequences):
> https://lore.kernel.org/lkml/20200211141554.24181-1-qais.yousef@arm.com/

Yeah, pesky deadlocks.. someone was going to try again.


>  kernel/cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6ff2578ecf17..f39a27a7f24b 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -15,6 +15,7 @@
>  #include <linux/sched/smt.h>
>  #include <linux/unistd.h>
>  #include <linux/cpu.h>
> +#include <linux/cpuset.h>
>  #include <linux/oom.h>
>  #include <linux/rcupdate.h>
>  #include <linux/export.h>
> @@ -1275,6 +1276,8 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state target)
>  	}
>  
>  	err = _cpu_up(cpu, 0, target);
> +	if (!err)
> +		cpuset_wait_for_hotplug();
>  out:
>  	cpu_maps_update_done();
>  	return err;

My only consideration is if doing that flush under cpu_add_remove_lock()
is wise.
