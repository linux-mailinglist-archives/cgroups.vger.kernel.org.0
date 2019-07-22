Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4842F6FB26
	for <lists+cgroups@lfdr.de>; Mon, 22 Jul 2019 10:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfGVIVF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Jul 2019 04:21:05 -0400
Received: from foss.arm.com ([217.140.110.172]:33424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbfGVIVF (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 22 Jul 2019 04:21:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7C41344;
        Mon, 22 Jul 2019 01:21:04 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CC003F71F;
        Mon, 22 Jul 2019 01:21:02 -0700 (PDT)
Subject: Re: [PATCH v9 2/8] sched/core: Streamlining calls to task_rq_unlock()
To:     Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        longman@redhat.com, cgroups@vger.kernel.org
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-3-juri.lelli@redhat.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <50f00347-ffb3-285c-5a7d-3a9c5f813950@arm.com>
Date:   Mon, 22 Jul 2019 10:21:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190719140000.31694-3-juri.lelli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/19/19 3:59 PM, Juri Lelli wrote:
> From: Mathieu Poirier <mathieu.poirier@linaro.org>

[...]

> @@ -4269,8 +4269,8 @@ static int __sched_setscheduler(struct task_struct *p,
>  			 */
>  			if (!cpumask_subset(span, &p->cpus_allowed) ||

This doesn't apply cleanly on v5.3-rc1 anymore due to commit
3bd3706251ee ("sched/core: Provide a pointer to the valid CPU mask").

>  			    rq->rd->dl_bw.bw == 0) {
> -				task_rq_unlock(rq, p, &rf);
> -				return -EPERM;
> +				retval = -EPERM;
> +				goto unlock;
>  			}
>  		}
>  #endif

[...]
