Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF565AF65B
	for <lists+cgroups@lfdr.de>; Tue,  6 Sep 2022 22:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiIFUvH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Sep 2022 16:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiIFUvG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Sep 2022 16:51:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC17779A5A;
        Tue,  6 Sep 2022 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=GzCE/imuOcJ+g/sNBTROhEBFbz+670zTIBkR3Ox5lik=; b=Wq8JJC2I8k9ghAF1rh90IxH1g1
        6B5eeRWNA2ClA+/QuqBjIVPG+vOa3naUYz8tkXZegSrBEdZEUeeyQPxJ0M4MXqQrI5I68PDnyDsIb
        QUgqk3THblmxaJlRawNJTfv6AOvl5GQkHL++vjZRa4qhEObP5x3vbkUhKXKqmK2zhil4k31p4BUsu
        1w86Xyg88pCB74zI6M76HtjoaEcEEo5ZB6xGGgIozCgqSwYMb5IuzzkpupWExTX+bjHBZJlz3wYfp
        hvEBL908KQXs42Ckacb877wbojdN45KH60/PEhO7xReXrO6e8NWPxkfmSW/OXKYC3P2CnbKHaRWyi
        a9Ozu7dQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVfWf-00AGIo-Vn; Tue, 06 Sep 2022 20:50:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1F3AD3006A4;
        Tue,  6 Sep 2022 22:50:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CEECF203C095B; Tue,  6 Sep 2022 22:50:28 +0200 (CEST)
Date:   Tue, 6 Sep 2022 22:50:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jing-Ting Wu <jing-ting.wu@mediatek.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Valentin Schneider <vschneid@redhat.com>,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Jonathan.JMChen@mediatek.com,
        "chris.redpath@arm.com" <chris.redpath@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vdonnefort@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        cgroups@vger.kernel.org, lixiong.liu@mediatek.com,
        wenju.xu@mediatek.com
Subject: Re: BUG: HANG_DETECT waiting for migration_cpu_stop() complete
Message-ID: <YxeylMvgc/wKcJqk@hirez.programming.kicks-ass.net>
References: <88b2910181bda955ac46011b695c53f7da39ac47.camel@mediatek.com>
 <b605c3ec-94ab-a55f-5825-9b370d77ecf3@quicinc.com>
 <203d4614c1b2a498a240ace287156e9f401d5395.camel@mediatek.com>
 <YxeR0RoiTdm8sWCJ@slm.duckdns.org>
 <02b8e7b3-941d-8bb9-cd0e-992738893ba3@redhat.com>
 <36a73401-7011-834a-7949-c65a2f66246c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36a73401-7011-834a-7949-c65a2f66246c@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 06, 2022 at 04:40:03PM -0400, Waiman Long wrote:

I've not followed the earlier stuff due to being unreadable; just
reacting to this..

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 838623b68031..5d9ea1553ec0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2794,9 +2794,9 @@ static int __set_cpus_allowed_ptr_locked(struct
> task_struct *p,
>                 if (cpumask_equal(&p->cpus_mask, new_mask))
>                         goto out;
> 
> -               if (WARN_ON_ONCE(p == current &&
> -                                is_migration_disabled(p) &&
> -                                !cpumask_test_cpu(task_cpu(p), new_mask)))
> {
> +               if (is_migration_disabled(p) &&
> +                   !cpumask_test_cpu(task_cpu(p), new_mask)) {
> +                       WARN_ON_ONCE(p == current);
>                         ret = -EBUSY;
>                         goto out;
>                 }
> @@ -2818,7 +2818,11 @@ static int __set_cpus_allowed_ptr_locked(struct
> task_struct *p,
>         if (flags & SCA_USER)
>                 user_mask = clear_user_cpus_ptr(p);
> 
> -       ret = affine_move_task(rq, p, rf, dest_cpu, flags);
> +       if (!is_migration_disabled(p) || (flags & SCA_MIGRATE_ENABLE)) {
> +               ret = affine_move_task(rq, p, rf, dest_cpu, flags);
> +       } else {
> +               task_rq_unlock(rq, p, rf);
> +       }

This cannot be right. There might be previous set_cpus_allowed_ptr()
callers that are blocked and waiting for the task to land on a valid
CPU.

