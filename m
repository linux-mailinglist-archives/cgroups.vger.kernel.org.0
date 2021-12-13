Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA29C4734EA
	for <lists+cgroups@lfdr.de>; Mon, 13 Dec 2021 20:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242360AbhLMTXw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Dec 2021 14:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242358AbhLMTXv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Dec 2021 14:23:51 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F083C061574;
        Mon, 13 Dec 2021 11:23:51 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x131so15776188pfc.12;
        Mon, 13 Dec 2021 11:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OYwOYi+vHNjHufw03EAiBDrxI3hclHuJAr4CB/iB7rw=;
        b=R7Xj2R5KQ4GN+oqiU5wpFKhFFh6TRybzWFHY50ahw05kOWtmuBqrTJ9vXIFLImgbg0
         cEXuWQZ5p4N0v/FOuszokHpKwbqWKdR6qoGoLH/SthoMJzo2grwIsAe20tedR+JYfImt
         z+R/3pfF2T9mW53rFpYAMbeyzSWvSqJKKcSaqLX+2DIoBgyKBLr7BZPys0rHY+WsfDn4
         sRKw5hLgOraRGVsqBQy5UCBssMw4XpUTsJe9bX00XAQFXX7HdUoS5xmtt9KmiouMC8de
         XRugChP5mR6tp2QioW9QnbuHghFsrl5MjL3V/DQA47QzsFl8FBBkNb8EOlevXpAkC+du
         P2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OYwOYi+vHNjHufw03EAiBDrxI3hclHuJAr4CB/iB7rw=;
        b=kvMi45KCZ+4YG58OJgaIo008Hcx5EwZYuBxW4h81uT2V7YSZLf08wqCBJy0kHAtYtV
         VbKGzBkdWT/foWijsrfYQFN/KJuVDX/0GWT6YZc+z782SCB5wqn1AOO0V5aY9xv9X1wU
         IhQlpZYvEtGx9r2KrICe/pLRYokCdXFYJ/P+nl38mQ/AfMnMdGTTzE8nYZ3wl6vJATkT
         Kakvb+Bv3/L32HmVeOtBIpOXgfCrCFj2q3jeCIImVkzDiuOmtRsOn9rX1AhNTQ1eFrgv
         nKKwaX1dpNIlnCKrLZsxIVD1ZTQw6T11JNVlXupCJORWa2+K1OYbXe2OoDBGJX2LDgzp
         R1TQ==
X-Gm-Message-State: AOAM530ye6g66qf02TQ3IcQeXilPq+jL+sVIxyd2cLxwOOTqZ1GtnI1V
        bLqISIUo1BDXA51ohrnwG5s=
X-Google-Smtp-Source: ABdhPJzKyUFuwckpbYxiWHdfnP2xGNL8xm15Z0/tkwlt9CozNwQvjVe0qzfBLDqhusTEVVTXWT+/Ug==
X-Received: by 2002:a05:6a00:882:b0:4a8:342:659c with SMTP id q2-20020a056a00088200b004a80342659cmr69411pfj.79.1639423431110;
        Mon, 13 Dec 2021 11:23:51 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id v12sm4803866pga.51.2021.12.13.11.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 11:23:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Dec 2021 09:23:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Honglei Wang <wanghonglei@didichuxing.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jameshongleiwang@126.com
Subject: Re: [RESEND PATCH RFC] cgroup: support numabalancing disable in
 cgroup level
Message-ID: <YbedxU6tBfEiOWkC@slm.duckdns.org>
References: <20211213150506.61780-1-wanghonglei@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213150506.61780-1-wanghonglei@didichuxing.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Dec 13, 2021 at 11:05:06PM +0800, Honglei Wang wrote:
> +#ifdef CONFIG_NUMA_BALANCING
> +static void __cgroup_numabalancing_disable_set(struct cgroup *cgrp, bool nb_disable)
> +{
> +	struct css_task_iter it;
> +	struct task_struct *task;
> +
> +	lockdep_assert_held(&cgroup_mutex);
> +
> +	spin_lock_irq(&css_set_lock);
> +	if (nb_disable)
> +		set_bit(CGRP_NUMABALANCING_DISABLE, &cgrp->flags);
> +	else
> +		clear_bit(CGRP_NUMABALANCING_DISABLE, &cgrp->flags);
> +	spin_unlock_irq(&css_set_lock);
> +
> +	css_task_iter_start(&cgrp->self, 0, &it);
> +	while ((task = css_task_iter_next(&it))) {
> +		/*
> +		 * We don't care about NUMA placement if the task is exiting.
> +		 * And we don't NUMA balance for kthreads.
> +		 */
> +		if (task->flags & (PF_EXITING | PF_KTHREAD))
> +			continue;
> +		task->numa_cgrp_disable = nb_disable;
> +	}
> +	css_task_iter_end(&it);
> +}

All it's doing is setting some property recursively and I don't think it
makes sense to keep expanding cgroup interface for this sort of usage. It's
not distributing any resource in hierarchical way and the whole feature can
be replaced by inheritable per-process interface with some scripting. Unless
there are some other compelling reasons, this is gonna be a strong nack from
cgroup side.

Thanks.

-- 
tejun
