Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D84C30EFE8
	for <lists+cgroups@lfdr.de>; Thu,  4 Feb 2021 10:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbhBDJrT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 04:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbhBDJrS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Feb 2021 04:47:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EFCC061573;
        Thu,  4 Feb 2021 01:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QF37dPCi57HEpfqUEK+5VUOa3KKAQXFiBdpPks8yG20=; b=NlCodaOYD+cypLcm3DpzdiK5SG
        enboRJqS7Gco2hpMe/1qaYVqdyNlxcLRp4nvUZJEg2FjEMadpp2grRgO50XSeWSi+2pvzxTpJt2xU
        L80uLyOvmhiADkKp93jPjS1slDGSoMJCY36LVm3Px1jF/9iCRd5EIyUa/PS1ohZEmlctc7vnci27C
        Og2Cd3illgZyC3Ie6gF4QqEFVonx/tmvnXfvKBVXVzFFUGvoBVGvTRvwzMod/u2JSP25tj1q44UkO
        qApjLYLA7hTMClH89C37qIuoIugDL2WAOM+hK8EE/upbpZTd1D4mj5i/ekzPehAFe5E6GgA9EoRon
        usv3VBgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l7bDI-000g7b-9V; Thu, 04 Feb 2021 09:46:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 47F07303A02;
        Thu,  4 Feb 2021 10:46:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 090352138F7C5; Thu,  4 Feb 2021 10:46:10 +0100 (CET)
Date:   Thu, 4 Feb 2021 10:46:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Klimov <aklimov@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        yury.norov@gmail.com, daniel.m.jordan@oracle.com,
        tglx@linutronix.de, jobaker@redhat.com, audralmitchel@gmail.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, rafael@kernel.org,
        tj@kernel.org, lizefan@huawei.com, qais.yousef@arm.com,
        hannes@cmpxchg.org, klimov.linux@gmail.com
Subject: Re: [PATCH] cpu/hotplug: wait for cpuset_hotplug_work to finish on
 cpu onlining
Message-ID: <YBvCYhdPai+pb8u2@hirez.programming.kicks-ass.net>
References: <20210204010157.1823669-1-aklimov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204010157.1823669-1-aklimov@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 04, 2021 at 01:01:57AM +0000, Alexey Klimov wrote:
> @@ -1281,6 +1282,11 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state target)
>  	err = _cpu_up(cpu, 0, target);
>  out:
>  	cpu_maps_update_done();
> +
> +	/* To avoid out of line uevent */
> +	if (!err)
> +		cpuset_wait_for_hotplug();
> +
>  	return err;
>  }
>  

> @@ -2071,14 +2075,18 @@ static void cpuhp_online_cpu_device(unsigned int cpu)
>  	struct device *dev = get_cpu_device(cpu);
>  
>  	dev->offline = false;
> -	/* Tell user space about the state change */
> -	kobject_uevent(&dev->kobj, KOBJ_ONLINE);
>  }
>  

One concequence of this is that you'll now get a bunch of notifications
across things like suspend/hybernate.
