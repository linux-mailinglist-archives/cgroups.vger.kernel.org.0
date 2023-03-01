Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A1E6A7440
	for <lists+cgroups@lfdr.de>; Wed,  1 Mar 2023 20:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCAT3c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Mar 2023 14:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCAT3a (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Mar 2023 14:29:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9407AAA;
        Wed,  1 Mar 2023 11:29:26 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321JLL6m029491;
        Wed, 1 Mar 2023 19:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=S3WeAgbjtIHJrp8ydb8xgorGnDPTtt3Yu06dfTH/Byg=;
 b=gvlfJ2h1AGWo5fmK0dXVYpAWCe4/0Ganb7YA4KLnev7KKgkPoIogIIvnVsiqKvofs1nw
 WKRlxJyD694g8W4XCIMBEBmsmrWSy0tClR9VHzGlk7UWPHa1oswDo2FFI3mJRBHvC+h+
 rrLKu6SXjDbvqVQhtwQoCQOnGNPoXaMQlfPDmELtNXJ3gcZHbe/sVmmDSEZfrt6ctpkv
 i0zXYZOX2SCjM3VGt8rl7jvzy4IvMB+Vy0DGrk3Pgiuur7aaPFT5j8AIZXRv3ghVeNBJ
 zyOfxU0LOHQ+WFrN8ymqXhNYtX+5fI9vzs9tRJsbsG4tlsg2UE/kIY6/UV3P1zUxRfVE Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p2csu851a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 19:28:40 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 321JSd8q025666;
        Wed, 1 Mar 2023 19:28:39 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p2csu850r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 19:28:39 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 321GIqii005832;
        Wed, 1 Mar 2023 19:28:37 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3nybcg8n0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 19:28:37 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 321JSaT062063056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Mar 2023 19:28:36 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43F3058043;
        Wed,  1 Mar 2023 19:28:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF0A958055;
        Wed,  1 Mar 2023 19:28:25 +0000 (GMT)
Received: from [9.43.118.249] (unknown [9.43.118.249])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  1 Mar 2023 19:28:25 +0000 (GMT)
Message-ID: <cf16613d-b5e1-bdcf-ef3f-6763ba939f42@linux.vnet.ibm.com>
Date:   Thu, 2 Mar 2023 00:58:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v12 5/8] sched/fair: Take into account latency priority at
 wakeup
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
References: <20230224093454.956298-1-vincent.guittot@linaro.org>
 <20230224093454.956298-6-vincent.guittot@linaro.org>
From:   shrikanth hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <20230224093454.956298-6-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sbahlocaxUaWbBG6Fw1_q6R7ErNwJZyn
X-Proofpoint-ORIG-GUID: I7Dkmurqe50j5iCznmtclNp9rQrkHFhp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_15,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010154
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,BITCOIN_SPAM_02,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,PDS_BTC_ID,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 2/24/23 3:04 PM, Vincent Guittot wrote:
> Take into account the latency priority of a thread when deciding to
> preempt the current running thread. We don't want to provide more CPU
> bandwidth to a thread but reorder the scheduling to run latency sensitive
> task first whenever possible.
>
> As long as a thread didn't use its bandwidth, it will be able to preempt
> the current thread.
>
> At the opposite, a thread with a low latency priority will preempt current
> thread at wakeup only to keep fair CPU bandwidth sharing. Otherwise it will
> wait for the tick to get its sched slice.
>
>                                    curr vruntime
>                                        |
>                       sysctl_sched_wakeup_granularity
>                                    <-->
> ----------------------------------|----|-----------------------|---------------
>                                   |    |<--------------------->
>                                   |    .  sysctl_sched_latency
>                                   |    .
> default/current latency entity    |    .
>                                   |    .
> 1111111111111111111111111111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-
> se preempts curr at wakeup ------>|<- se doesn't preempt curr -----------------
>                                   |    .
>                                   |    .
>                                   |    .
> low latency entity                |    .
>                                    ---------------------->|
>                                % of sysctl_sched_latency  |
> 1111111111111111111111111111111111111111111111111111111111|0000|-1-1-1-1-1-1-1-
> preempt ------------------------------------------------->|<- do not preempt --
>                                   |    .
>                                   |    .
>                                   |    .
> high latency entity               |    .
>          |<-----------------------|----.
>          | % of sysctl_sched_latency   .
> 111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1
> preempt->|<- se doesn't preempt curr ------------------------------------------
>
> Tests results of nice latency impact on heavy load like hackbench:
>
> hackbench -l (2560 / group) -g group
> group        latency 0             latency 19
> 1            1.378(+/-  1%)      1.337(+/- 1%) + 3%
> 4            1.393(+/-  3%)      1.312(+/- 3%) + 6%
> 8            1.308(+/-  2%)      1.279(+/- 1%) + 2%
> 16           1.347(+/-  1%)      1.317(+/- 1%) + 2%
>
> hackbench -p -l (2560 / group) -g group
> group
> 1            1.836(+/- 17%)      1.148(+/- 5%) +37%
> 4            1.586(+/-  6%)      1.109(+/- 8%) +30%
> 8            1.209(+/-  4%)      0.780(+/- 4%) +35%
> 16           0.805(+/-  5%)      0.728(+/- 4%) +10%
>
> By deacreasing the latency prio, we reduce the number of preemption at
> wakeup and help hackbench making progress.
>
> Test results of nice latency impact on short live load like cyclictest
> while competing with heavy load like hackbench:
>
> hackbench -l 10000 -g $group &
> cyclictest --policy other -D 5 -q -n
>         latency 0           latency -20
> group   min  avg    max     min  avg    max
> 0       16    19     29      17   18     29
> 1       43   299   7359      63   84   3422
> 4       56   449  14806      45   83    284
> 8       63   820  51123      63   83    283
> 16      64  1326  70684      41  157  26852
>
> group = 0 means that hackbench is not running.
>
> The avg is significantly improved with nice latency -20 especially with
> large number of groups but min and max remain quite similar. If we add the
> histogram parameter to get details of latency, we have :
>
> hackbench -l 10000 -g 16 &
> cyclictest --policy other -D 5 -q -n  -H 20000 --histfile data.txt
>               latency 0    latency -20
> Min Latencies:    64           62
> Avg Latencies:  1170          107
> Max Latencies: 88069        10417
> 50% latencies:   122           86
> 75% latencies:   614           91
> 85% latencies:   961           94
> 90% latencies:  1225           97
> 95% latencies:  6120          102
> 99% latencies: 18328          159
>
> With percentile details, we see the benefit of nice latency -20 as
> only 1% of the latencies are above 159us whereas the default latency
> has got 15% around ~1ms or above and 5% over the 6ms.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  include/linux/sched.h      |  4 +++-
>  include/linux/sched/prio.h |  9 +++++++++
>  init/init_task.c           |  2 +-
>  kernel/sched/core.c        | 19 ++++++++++++++-----
>  kernel/sched/debug.c       |  2 +-
>  kernel/sched/fair.c        | 32 +++++++++++++++++++++++++++-----
>  kernel/sched/sched.h       | 11 +++++++++++
>  7 files changed, 66 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 6c61bde49152..38decae3e156 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -568,6 +568,8 @@ struct sched_entity {
>  	/* cached value of my_q->h_nr_running */
>  	unsigned long			runnable_weight;
>  #endif
> +	/* preemption offset in ns */
> +	long				latency_offset;
>  
>  #ifdef CONFIG_SMP
>  	/*
> @@ -784,7 +786,7 @@ struct task_struct {
>  	int				static_prio;
>  	int				normal_prio;
>  	unsigned int			rt_priority;
> -	int				latency_nice;
> +	int				latency_prio;
>  
>  	struct sched_entity		se;
>  	struct sched_rt_entity		rt;
> diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
> index bfcd7f1d1e11..be79503d86af 100644
> --- a/include/linux/sched/prio.h
> +++ b/include/linux/sched/prio.h
> @@ -59,5 +59,14 @@ static inline long rlimit_to_nice(long prio)
>   * Default tasks should be treated as a task with latency_nice = 0.
>   */
>  #define DEFAULT_LATENCY_NICE	0
> +#define DEFAULT_LATENCY_PRIO	(DEFAULT_LATENCY_NICE + LATENCY_NICE_WIDTH/2)
> +
> +/*
> + * Convert user-nice values [ -20 ... 0 ... 19 ]
> + * to static latency [ 0..39 ],
> + * and back.
> + */
> +#define NICE_TO_LATENCY(nice)	((nice) + DEFAULT_LATENCY_PRIO)
> +#define LATENCY_TO_NICE(prio)	((prio) - DEFAULT_LATENCY_PRIO)
>  
>  #endif /* _LINUX_SCHED_PRIO_H */
> diff --git a/init/init_task.c b/init/init_task.c
> index 7dd71dd2d261..071deff8dbd1 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -78,7 +78,7 @@ struct task_struct init_task
>  	.prio		= MAX_PRIO - 20,
>  	.static_prio	= MAX_PRIO - 20,
>  	.normal_prio	= MAX_PRIO - 20,
> -	.latency_nice	= DEFAULT_LATENCY_NICE,
> +	.latency_prio	= DEFAULT_LATENCY_PRIO,
>  	.policy		= SCHED_NORMAL,
>  	.cpus_ptr	= &init_task.cpus_mask,
>  	.user_cpus_ptr	= NULL,
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d327614c70b0..d5b7e237d79b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1285,6 +1285,11 @@ static void set_load_weight(struct task_struct *p, bool update_load)
>  	}
>  }
>  
> +static void set_latency_offset(struct task_struct *p)
> +{
> +	p->se.latency_offset = calc_latency_offset(p->latency_prio);
> +}
> +
>  #ifdef CONFIG_UCLAMP_TASK
>  /*
>   * Serializes updates of utilization clamp values
> @@ -4681,7 +4686,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
>  		p->prio = p->normal_prio = p->static_prio;
>  		set_load_weight(p, false);
>  
> -		p->latency_nice = DEFAULT_LATENCY_NICE;
> +		p->latency_prio = NICE_TO_LATENCY(0);
> +		set_latency_offset(p);
> +
>  		/*
>  		 * We don't need the reset flag anymore after the fork. It has
>  		 * fulfilled its duty:
> @@ -7449,8 +7456,10 @@ static void __setscheduler_params(struct task_struct *p,
>  static void __setscheduler_latency(struct task_struct *p,
>  		const struct sched_attr *attr)
>  {
> -	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
> -		p->latency_nice = attr->sched_latency_nice;
> +	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
> +		p->latency_prio = NICE_TO_LATENCY(attr->sched_latency_nice);
> +		set_latency_offset(p);
> +	}
>  }
>  
>  /*
> @@ -7635,7 +7644,7 @@ static int __sched_setscheduler(struct task_struct *p,
>  		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
>  			goto change;
>  		if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
> -		    attr->sched_latency_nice != p->latency_nice)
> +		    attr->sched_latency_nice != LATENCY_TO_NICE(p->latency_prio))
>  			goto change;
>  
>  		p->sched_reset_on_fork = reset_on_fork;
> @@ -8176,7 +8185,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
>  	get_params(p, &kattr);
>  	kattr.sched_flags &= SCHED_FLAG_ALL;
>  
> -	kattr.sched_latency_nice = p->latency_nice;
> +	kattr.sched_latency_nice = LATENCY_TO_NICE(p->latency_prio);
>  
>  #ifdef CONFIG_UCLAMP_TASK
>  	/*
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 68be7a3e42a3..b3922184af91 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -1043,7 +1043,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
>  #endif
>  	P(policy);
>  	P(prio);
> -	P(latency_nice);
> +	P(latency_prio);

/proc/<pid>/sched  should update if the latency values are updated
for the cgroup right? That doesn't seem to happen.

#cd /sys/fs/cgroup/cpu
# echo -20 >  task1/cpu.latency.nice 
# cat task1/cgroup.procs 
1897
1998
1999
# cat /proc/1999/sched | grep latency
latency_prio                                 :                   20
# echo 0 >  task1/cpu.latency.nice 
# cat /proc/1999/sched | grep latency
latency_prio                                 :                   20
# echo 19 >  task1/cpu.latency.nice 
# cat /proc/1999/sched | grep latency
latency_prio                                 :                   20


>  	if (task_has_dl_policy(p)) {
>  		P(dl.runtime);
>  		P(dl.deadline);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 81bef11eb660..414b6243208b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4877,6 +4877,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  		update_idle_cfs_rq_clock_pelt(cfs_rq);
>  }
>  
> +static long wakeup_latency_gran(struct sched_entity *curr, struct sched_entity *se);
> +
>  /*
>   * Preempt the current task with a newly woken task if needed:
>   */
> @@ -4885,7 +4887,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  {
>  	unsigned long ideal_runtime, delta_exec;
>  	struct sched_entity *se;
> -	s64 delta;
> +	s64 delta, offset;
>  
>  	/*
>  	 * When many tasks blow up the sched_period; it is possible that
> @@ -4916,10 +4918,12 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  	se = __pick_first_entity(cfs_rq);
>  	delta = curr->vruntime - se->vruntime;
>  
> -	if (delta < 0)
> +	offset = wakeup_latency_gran(curr, se);
> +	if (delta < offset)
>  		return;
>  
> -	if (delta > ideal_runtime)
> +	if ((delta > ideal_runtime) ||
> +	    (delta > get_latency_max()))
>  		resched_curr(rq_of(cfs_rq));
>  }
>  
> @@ -7662,6 +7666,23 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  }
>  #endif /* CONFIG_SMP */
>  
> +static long wakeup_latency_gran(struct sched_entity *curr, struct sched_entity *se)
> +{
> +	long latency_offset = se->latency_offset;
> +
> +	/*
> +	 * A negative latency offset means that the sched_entity has latency
> +	 * requirement that needs to be evaluated versus other entity.
> +	 * Otherwise, use the latency weight to evaluate how much scheduling
> +	 * delay is acceptable by se.
> +	 */
> +	if ((latency_offset < 0) || (curr->latency_offset < 0))
> +		latency_offset -= curr->latency_offset;
> +	latency_offset = min_t(long, latency_offset, get_latency_max());
> +
> +	return latency_offset;
> +}
> +
>  static unsigned long wakeup_gran(struct sched_entity *se)
>  {
>  	unsigned long gran = sysctl_sched_wakeup_granularity;
> @@ -7700,11 +7721,12 @@ static int
>  wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
>  {
>  	s64 gran, vdiff = curr->vruntime - se->vruntime;
> +	s64 offset = wakeup_latency_gran(curr, se);
>  
> -	if (vdiff <= 0)
> +	if (vdiff < offset)
>  		return -1;
>  
> -	gran = wakeup_gran(se);
> +	gran = offset + wakeup_gran(se);
>  
>  	/*
>  	 * At wake up, the vruntime of a task is capped to not be older than
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 51ba0af7fb27..3f42f86105d4 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2494,6 +2494,17 @@ static inline unsigned long get_sleep_latency(bool idle)
>  	return thresh;
>  }
>  
> +/*
> + * Calculate the latency offset for a priority level.
> + * We use a linear mapping of the priority in the range:
> + *     [-sysctl_sched_latency:sysctl_sched_latency]
> + */
> +static inline long calc_latency_offset(int prio)
> +{
> +	return (long)get_sleep_latency(false) * LATENCY_TO_NICE(prio) /
> +			(LATENCY_NICE_WIDTH/2);
> +}
> +
>  static inline unsigned long get_latency_max(void)
>  {
>  	unsigned long thresh = get_sleep_latency(false);

