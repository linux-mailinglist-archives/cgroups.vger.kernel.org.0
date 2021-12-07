Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D1E46C024
	for <lists+cgroups@lfdr.de>; Tue,  7 Dec 2021 17:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbhLGQDy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Dec 2021 11:03:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43146 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238825AbhLGQDx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Dec 2021 11:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638892823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J6jwf6epYrICYcmePyRn09ib6008dY63VibUD3hoHT0=;
        b=Hlv2gxBSGvI5YUmPvs+90Iv8HP6knQQ2IPI3l9ZJspytft7TBqa/PRXp6HQBWfk5uVdZ3O
        VDMSkIy/Xn1GufwYJdg1PCrqSyq1NJS5RlL5DmS3KI9piD/r6GU+SlJ/g++NKEV3Mqkna6
        gjv0JNC7Hm3pnbM0kZXWw6Sh8xkuL8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-v4PrHyZpOoC4UoSocSWQZQ-1; Tue, 07 Dec 2021 11:00:17 -0500
X-MC-Unique: v4PrHyZpOoC4UoSocSWQZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A03AC1019995;
        Tue,  7 Dec 2021 16:00:15 +0000 (UTC)
Received: from [10.22.34.28] (unknown [10.22.34.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98330794DA;
        Tue,  7 Dec 2021 16:00:14 +0000 (UTC)
Message-ID: <281a5c45-388f-203e-3c5e-146a85328c78@redhat.com>
Date:   Tue, 7 Dec 2021 11:00:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] mm/memcontrol: Disable on PREEMPT_RT
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <20211207155208.eyre5svucpg7krxe@linutronix.de>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211207155208.eyre5svucpg7krxe@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/7/21 10:52, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> MEMCG has a few constructs which are not compatible with PREEMPT_RT's
> requirements. This includes:
> - relying on disabled interrupts from spin_lock_irqsave() locking for
>    something not related to lock itself (like the per-CPU counter).
>
> - explicitly disabling interrupts and acquiring a spinlock_t based lock
>    like in memcg_check_events() -> eventfd_signal().
>
> - explicitly disabling interrupts and freeing memory like in
>    drain_obj_stock() -> obj_cgroup_put() -> obj_cgroup_release() ->
>    percpu_ref_exit().
>
> Commit 559271146efc ("mm/memcg: optimize user context object stock
> access") continued to optimize for the CPU local access which
> complicates the PREEMPT_RT locking requirements further.
>
> Disable MEMCG on PREEMPT_RT until the whole situation can be evaluated
> again.

Disabling MEMCG for PREEMPT_RT may be too drastic a step to take. For 
commit 559271146efc ("mm/memcg: optimize user context object stock 
access"), I can modify it to disable the optimization for PREEMPT_RT.

Cheers,
Longman


> [ bigeasy: commit description. ]
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   init/Kconfig |    1 +
>   1 file changed, 1 insertion(+)
>
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -943,6 +943,7 @@ config PAGE_COUNTER
>   
>   config MEMCG
>   	bool "Memory controller"
> +	depends on !PREEMPT_RT
>   	select PAGE_COUNTER
>   	select EVENTFD
>   	help
>

