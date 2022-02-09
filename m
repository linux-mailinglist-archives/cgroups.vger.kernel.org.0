Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFBC4AFE27
	for <lists+cgroups@lfdr.de>; Wed,  9 Feb 2022 21:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiBIUUv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Feb 2022 15:20:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbiBIUUu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Feb 2022 15:20:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5183EE032A9B
        for <cgroups@vger.kernel.org>; Wed,  9 Feb 2022 12:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644438051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NifY2jezbBUetwsmzUwyvhafuJf4MPduuqMq0ll2twA=;
        b=LECQVvBRSXSKJqF2ca0hDy3MtXON62aIOLaJf4AU6uOWtIoVBqM8PZR+jEIp1AW1MC7iHD
        2IAAjKLe/wBIT+AOwDi6t+SusYVXADj8koRdR9mzRq8fGOZUhKRF7o8Ce7ziJ6efHt43Dq
        sPWFPyAfKQcZ38JJBl0HsaReodJgkdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-dG41el83N5qH0Lg7DIHjtQ-1; Wed, 09 Feb 2022 15:20:49 -0500
X-MC-Unique: dG41el83N5qH0Lg7DIHjtQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36769824F96;
        Wed,  9 Feb 2022 20:20:46 +0000 (UTC)
Received: from [10.22.9.207] (unknown [10.22.9.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46E7D49A7;
        Wed,  9 Feb 2022 20:20:43 +0000 (UTC)
Message-ID: <4b58c74d-6ad6-3658-30fb-1957a7b212dc@redhat.com>
Date:   Wed, 9 Feb 2022 15:20:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 02/12] cgroup: rstat: Make cgroup_rstat_cpu_lock name
 readable
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
References: <20220208194324.85333-1-namhyung@kernel.org>
 <20220208194324.85333-3-namhyung@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220208194324.85333-3-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/8/22 14:43, Namhyung Kim wrote:
> The raw_spin_lock_init() uses the argument to name its lockdep map.
> But passing per_cpu_ptr() macro directly makes it a very very long
> name as it expanded like below:
>
>    ({ do { const void *__vpp_verify = (typeof((&cgroup_rstat_cpu_lock) ...
>
> Let's fix it by passing a local variable instead.  With this change,
> the name now looks like:
>
>    cgrp_rstat_cpu_lock
>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: cgroups@vger.kernel.org
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   kernel/cgroup/rstat.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 9d331ba44870..371f54a59c38 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -286,9 +286,17 @@ void cgroup_rstat_exit(struct cgroup *cgrp)
>   void __init cgroup_rstat_boot(void)
>   {
>   	int cpu;
> +	raw_spinlock_t *cgrp_rstat_cpu_lock;
>   
> -	for_each_possible_cpu(cpu)
> -		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
> +	for_each_possible_cpu(cpu) {
> +		/*
> +		 * raw_spin_lock_init() uses the argument to name the lock in
> +		 * lockdep results.  Passing per_cpu_ptr() directly created a
> +		 * cryptic name as the macro was expanded before stringified.
> +		 */
> +		cgrp_rstat_cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
> +		raw_spin_lock_init(cgrp_rstat_cpu_lock);
> +	}
>   }
>   
>   /*

That is a standalone fix. Maybe Tejun can take it directly into the 
cgroup tree.

Acked-by: Waiman Long <longman@redhat.com>

