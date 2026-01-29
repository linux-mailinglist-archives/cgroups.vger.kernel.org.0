Return-Path: <cgroups+bounces-13502-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJiIL30Je2k6AwIAu9opvQ
	(envelope-from <cgroups+bounces-13502-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 08:17:17 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF3EAC865
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 08:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38D37303FF15
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 07:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C26E379994;
	Thu, 29 Jan 2026 07:16:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0832DC33B;
	Thu, 29 Jan 2026 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670962; cv=none; b=SHXlDwU3v7+4E++QV1G3oK54b5+ZpFq3sBrayq3qEc42/S8+5QlZhW/XhY3kszN0MppVjYxF4Pc0qkKFivkxpxfj76MIHzaUI2RfW/T9MCFhEzNTqoZKGqIre6IpS6TyPIvHxcROHzbXM9PAcYxmvkvxxVO9T11EWLpCnANQ+B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670962; c=relaxed/simple;
	bh=dAu4b3MqO3tHxakMO1HfVZN3I70KBsQg/aYYGAWbKSA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YKHxwLQJRGAc4PnMMs4ya23Hqb2lD1VeG03DYmq2zIsR3/cyVRcbW94f319nSYpb5OsFkjE4uihLYly7eV4s0nI8HAGpQnbELgng+/SHVTMWAjl4LFeGvs/xUnQaoVd9qKIe849axWOQL0zqbPq9BuM67Pgn0tCSvqeXLky38rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f1r5V44qdzKHMLY;
	Thu, 29 Jan 2026 15:15:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3CC5A4056B;
	Thu, 29 Jan 2026 15:15:56 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgD3o_QqCXtpvzgJFg--.29417S2;
	Thu, 29 Jan 2026 15:15:55 +0800 (CST)
Message-ID: <4d192246-d795-4f65-825f-5e4a413cae32@huaweicloud.com>
Date: Thu, 29 Jan 2026 15:15:54 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next 1/2] cgroup/cpuset: Defer housekeeping_update()
 call from CPU hotplug to task_work
From: Chen Ridong <chenridong@huaweicloud.com>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260128044251.1229702-1-longman@redhat.com>
 <20260128044251.1229702-2-longman@redhat.com>
 <ccca8790-2bf9-46db-b355-ce8695ea7093@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <ccca8790-2bf9-46db-b355-ce8695ea7093@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgD3o_QqCXtpvzgJFg--.29417S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKr1ktr1kKFyfWry8tFy8Grg_yoW3WFW5pr
	y5KF4Iyayqqr1a934aqws3Gr1Fgw4kt3W5Kr4aqF1rAFZxuFs7Za48KrnxtFWrGr97GFWr
	ZFWDGw4fWF4DZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13502-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EF3EAC865
X-Rspamd-Action: no action



On 2026/1/29 12:03, Chen Ridong wrote:
> 
> 
> On 2026/1/28 12:42, Waiman Long wrote:
>> The update_isolation_cpumasks() function can be called either directly
>> from regular cpuset control file write with cpuset_full_lock() called
>> or via the CPU hotplug path with cpus_write_lock and cpuset_mutex held.
>>
>> As we are going to enable dynamic update to the nozh_full housekeeping
>> cpumask (HK_TYPE_KERNEL_NOISE) soon with the help of CPU hotplug,
>> allowing the CPU hotplug path to call into housekeeping_update()
>> directly from update_isolation_cpumasks() will cause deadlock. So we
>> have to defer any call to housekeeping_update() after the CPU hotplug
>> operation has finished. This can be done via the task_work_add(...,
>> TWA_RESUME) API where the actual housekeeping_update() call, if needed,
>> will happen right before existing back to userspace.
>>
>> Since the HK_TYPE_DOMAIN housekeeping cpumask should now track the
>> changes in "cpuset.cpus.isolated", add a check in test_cpuset_prs.sh to
>> confirm that the CPU hotplug deferral, if needed, is working as expected.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  kernel/cgroup/cpuset.c                        | 49 ++++++++++++++++++-
>>  .../selftests/cgroup/test_cpuset_prs.sh       |  9 ++++
>>  2 files changed, 56 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 7b7d12ab1006..98c7cb732206 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -84,6 +84,10 @@ static cpumask_var_t	isolated_cpus;
>>   */
>>  static bool isolated_cpus_updating;
>>  
>> +/* Both cpuset_mutex and cpus_read_locked acquired */
>> +static bool cpuset_full_locked;
>> +static bool isolation_task_work_queued;
>> +
>>  /*
>>   * A flag to force sched domain rebuild at the end of an operation.
>>   * It can be set in
>> @@ -285,10 +289,12 @@ void cpuset_full_lock(void)
>>  {
>>  	cpus_read_lock();
>>  	mutex_lock(&cpuset_mutex);
>> +	cpuset_full_locked = true;
>>  }
>>  
>>  void cpuset_full_unlock(void)
>>  {
>> +	cpuset_full_locked = false;
>>  	mutex_unlock(&cpuset_mutex);
>>  	cpus_read_unlock();
>>  }
>> @@ -1285,25 +1291,64 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>>  	return false;
>>  }
>>  
>> +static void __update_isolation_cpumasks(bool twork);
>> +static void isolation_task_work_fn(struct callback_head *cb)
>> +{
>> +	cpuset_full_lock();
>> +	__update_isolation_cpumasks(true);
>> +	cpuset_full_lock();
>> +}
>> +
>>  /*
>> - * update_isolation_cpumasks - Update external isolation related CPU masks
>> + * __update_isolation_cpumasks - Update external isolation related CPU masks
>> + * @twork - set if call from isolation_task_work_fn()
>>   *
>>   * The following external CPU masks will be updated if necessary:
>>   * - workqueue unbound cpumask
>>   */
>> -static void update_isolation_cpumasks(void)
>> +static void __update_isolation_cpumasks(bool twork)
>>  {
>>  	int ret;
>>  
>> +	if (twork)
>> +		isolation_task_work_queued = false;
>> +
>>  	if (!isolated_cpus_updating)
>>  		return;
>>  
>> +	/*
>> +	 * This function can be reached either directly from regular cpuset
>> +	 * control file write (cpuset_full_locked) or via hotplug
>> +	 * (cpus_write_lock && cpuset_mutex held). In the later case, we
>> +	 * defer the housekeeping_update() call to a task_work to avoid
>> +	 * the possibility of deadlock. The task_work will be run right
>> +	 * before exiting back to userspace.
>> +	 */
>> +	if (!cpuset_full_locked) {
>> +		static struct callback_head twork_cb;
>> +
>> +		if (!isolation_task_work_queued) {
>> +			init_task_work(&twork_cb, isolation_task_work_fn);
>> +			if (!task_work_add(current, &twork_cb, TWA_RESUME))
>> +				isolation_task_work_queued = true;
>> +			else
>> +				/* Current task shouldn't be exiting */
>> +				WARN_ON_ONCE(1);
>> +		}
>> +		return;
>> +	}
>> +
>>  	ret = housekeeping_update(isolated_cpus);
>>  	WARN_ON_ONCE(ret < 0);
>>  
>>  	isolated_cpus_updating = false;
>>  }
>>  
> 
> The logic is not straightforward; perhaps we can simplify it as follows,
> maybe I missed something, just correct me.
> 
> static void isolation_task_work_fn(struct callback_head *cb)
> {
> 	guard(mutex)(&isolcpus_update_mutex);
> 	WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
> }
> 
> /*
>  * __update_isolation_cpumasks - Update external isolation related CPU masks
>  * @twork - set if call from isolation_task_work_fn()
>  *
>  * The following external CPU masks will be updated if necessary:
>  * - workqueue unbound cpumask
>  */
> static void __update_isolation_cpumasks(bool twork)
> {
> 	if (!isolated_cpus_updating)
> 		return;
> 
> 	/*
> 	 * This function can be reached either directly from regular cpuset
> 	 * control file write (cpuset_full_locked) or via hotplug
> 	 * (cpus_write_lock && cpuset_mutex held). In the later case, we
> 	 * defer the housekeeping_update() call to a task_work to avoid
> 	 * the possibility of deadlock. The task_work will be run right
> 	 * before exiting back to userspace.
> 	 */
> 	if (twork) {
> 		static struct callback_head twork_cb;
> 
> 		init_task_work(&twork_cb, isolation_task_work_fn);
> 		if (task_work_add(current, &twork_cb, TWA_RESUME))
> 			/* Current task shouldn't be exiting */
> 			WARN_ON_ONCE(1);
> 
> 		return;
> 	}
> 
> 	lockdep_assert_held(&isolcpus_update_mutex);
> 	/*
> 	 * Release cpus_read_lock & cpuset_mutex before calling
> 	 * housekeeping_update() and re-acquiring them afterward if not
> 	 * calling from task_work.
> 	 */
> 
> 	cpuset_full_unlock();
> 	WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
> 	cpuset_full_lock();
> 
> 	isolated_cpus_updating = false;
> }
> 
> static inline void update_isolation_cpumasks(void)
> {
> 	__update_isolation_cpumasks(false);
> }
> 

It can be much clearer:

static void isolation_task_work_fn(struct callback_head *cb)
{
	guard(mutex)(&isolcpus_update_mutex);
	WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
}

/*
 * __update_isolation_cpumasks - Update external isolation related CPU masks
 * @defer
 *
 * The following external CPU masks will be updated if necessary:
 * - workqueue unbound cpumask
 */
static void __update_isolation_cpumasks(bool defer)
{
	if (!isolated_cpus_updating)
		return;

	/*
	 * This function can be reached either directly from regular cpuset
	 * control file write (cpuset_full_locked) or via hotplug
	 * (cpus_write_lock && cpuset_mutex held). In the later case, we
	 * defer the housekeeping_update() call to a task_work to avoid
	 * the possibility of deadlock. The task_work will be run right
	 * before exiting back to userspace.
	 */
	if (defer) {
		static struct callback_head twork_cb;

		init_task_work(&twork_cb, isolation_task_work_fn);
		if (task_work_add(current, &twork_cb, TWA_RESUME))
			/* Current task shouldn't be exiting */
			WARN_ON_ONCE(1);

		return;
	}

	lockdep_assert_held(&isolcpus_update_mutex);
	lockdep_assert_cpus_held();
	lockdep_assert_cpuset_lock_held();

	/*
	 * Release cpus_read_lock & cpuset_mutex before calling
	 * housekeeping_update() and re-acquiring them afterward if not
	 * calling from task_work.
	 */

	cpuset_full_unlock();
	WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
	cpuset_full_lock();

	isolated_cpus_updating = false;
}

static inline void update_isolation_cpumasks(void)
{
	__update_isolation_cpumasks(false);
}

static inline void asyn_update_isolation_cpumasks(void)
{
	__update_isolation_cpumasks(true);
}

The hotplug path just calls asyn_update_isolation_cpumasks(), cpuset_full_locked
and isolation_task_work_queued can be removed.

-- 
Best regards,
Ridong


