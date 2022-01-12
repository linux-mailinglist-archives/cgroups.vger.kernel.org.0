Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC7048C3EC
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 13:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbiALM2L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jan 2022 07:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239509AbiALM2J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jan 2022 07:28:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50050C06173F;
        Wed, 12 Jan 2022 04:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aJdQ3WfBr8szpr2DYItlqsfb9rRoIL3kxZXhJL3L8aU=; b=bjjePTTHviZfIwg1tJnjLcwgzq
        xwRs1BQRnIuvC9fEfyAbETRcppiCmDzGfV4S3UpUf5YKhDqZeEdbflYzTx9efKxCuDuf1xVvfV3KZ
        IMT6nxP55MioxAOHwZ68Ie1+TQRP68nc2jy9Ur9RoDlAX5IxBJPhipI2cUpaSMzrq75VVik6YEY0c
        3ltXPVRvJ8JSYw2XTljbUt26BDi0gZFGns1P+tGSSfyAVjGKVpe+lhoH/YzNUdRwsnGHhDRZBeiC+
        xxTMbLUmKAu6NSftSa+T8zGRAUA3xmyAm3GXAHCx72setLknaxvqasqnV6MlGn0cXFlnJpNmZafjh
        HeWKFCxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7cjA-0045sZ-JE; Wed, 12 Jan 2022 12:27:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B25D2300079;
        Wed, 12 Jan 2022 13:27:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7CEB82B34539D; Wed, 12 Jan 2022 13:27:39 +0100 (CET)
Date:   Wed, 12 Jan 2022 13:27:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, joshdon@google.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] sched/core: Forced idle accounting per-cpu
Message-ID: <Yd7JO1UYlRXR0dWE@hirez.programming.kicks-ass.net>
References: <1641894961-9241-1-git-send-email-CruzZhao@linux.alibaba.com>
 <1641894961-9241-3-git-send-email-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641894961-9241-3-git-send-email-CruzZhao@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 05:56:00PM +0800, Cruz Zhao wrote:

> @@ -1115,6 +1118,7 @@ struct rq {
>  	unsigned int		core_forceidle_seq;
>  	unsigned int		core_forceidle_occupation;
>  	u64			core_forceidle_start;
> +	bool			in_forcedidle;

naming is wrong

>  #endif
>  };
>  
> diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
> index 07dde29..ea22a8c 100644
> --- a/kernel/sched/stats.c
> +++ b/kernel/sched/stats.c
> @@ -108,6 +108,16 @@ void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
>  	}
>  }
>  
> +#ifdef CONFIG_SCHED_CORE
> +static inline u64 get_rq_forceidle_time(struct rq *rq) {
> +	return rq->rq_forceidle_time;
> +}
> +#else
> +static inline u64 get_rq_forceidle_time(struct rq *rq) {
> +	return 0;
> +}
> +#endif

indent is wrong, and if you put the #ifdef inside the function it'll be
smaller.
