Return-Path: <cgroups+bounces-13555-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBDLJXFWfWn9RQIAu9opvQ
	(envelope-from <cgroups+bounces-13555-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 02:10:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F129BFE34
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 02:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79C393032E56
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 01:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0C331A7F1;
	Sat, 31 Jan 2026 00:58:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01D2318BB0;
	Sat, 31 Jan 2026 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769821128; cv=none; b=QzPECfYomo7+PHpwEMC9qkOBJKfqu572WyJJf5mWoMhHHhmdJPw8ojsePaqCGpAceHERko9nyelQzJwnTP0mJFZbQ0F2Kr+TZt06JVDv2/u5PQAju8TJGgS8EDmXoXwyZJRnGs4SJ1HdF4dPUxDkxJWvZ56HxI1R6MnDmfYlbMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769821128; c=relaxed/simple;
	bh=KIaJ76b8uDt6IJi0UM2JpM2Zs7VG90NWm+XK4uCAy4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UouCsgyqwe+/NVM+9aV5vbaGj7ens4biGgGh++oOjhCb2dqm6jrcgb807e+CXOITVzGK1wXgEOfQDu4ChnNWaKTUkRNoVr1360/oUHD3Kbc/idwLZO1pKlxUQ7pNlSDf9ykcgyfKQe+96/a2li2JZjQ+uSvA9qedzY+2CcCiGBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f2vcm5jVczYQtfQ;
	Sat, 31 Jan 2026 08:58:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4C0434058F;
	Sat, 31 Jan 2026 08:58:42 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgC3Y_TAU31pHobZFg--.26482S2;
	Sat, 31 Jan 2026 08:58:42 +0800 (CST)
Message-ID: <7c7fddf5-9d32-415b-a1c4-3b9402e78d72@huaweicloud.com>
Date: Sat, 31 Jan 2026 08:58:40 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v2 1/2] cgroup/cpuset: Defer
 housekeeping_update() call from CPU hotplug to workqueue
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
References: <20260130154254.1422113-1-longman@redhat.com>
 <20260130154254.1422113-2-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260130154254.1422113-2-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgC3Y_TAU31pHobZFg--.26482S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKw43XryDZrW5Zw1fKryDWrg_yoWxXF4rpF
	y0grWSyrsIgr13ua4Sv3ZrXr4Fgws7J3WUtan3Jr1UZF13tFn2vryvgwnxJrWrCr98CrZ8
	ZF9rGw4DWa1jy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	bAw3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	TAGGED_FROM(0.00)[bounces-13555-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huaweicloud.com:mid,test_cpuset_prs.sh:url]
X-Rspamd-Queue-Id: 0F129BFE34
X-Rspamd-Action: no action



On 2026/1/30 23:42, Waiman Long wrote:
> The update_isolation_cpumasks() function can be called either directly
> from regular cpuset control file write with cpuset_full_lock() called
> or via the CPU hotplug path with cpus_write_lock and cpuset_mutex held.
> 
> As we are going to enable dynamic update to the nozh_full housekeeping
> cpumask (HK_TYPE_KERNEL_NOISE) soon with the help of CPU hotplug,
> allowing the CPU hotplug path to call into housekeeping_update() directly
> from update_isolation_cpumasks() will likely cause deadlock. So we
> have to defer any call to housekeeping_update() after the CPU hotplug
> operation has finished. This is now done via the workqueue where
> the actual housekeeping_update() call, if needed, will happen after
> cpus_write_lock is released.
> 
> We can't use the synchronous task_work API as call from CPU hotplug
> path happen in the per-cpu kthread of the CPU that is being shut down
> or brought up. Because of the asynchronous nature of workqueue, the
> HK_TYPE_DOMAIN housekeeping cpumask will be updated a bit later than the
> "cpuset.cpus.isolated" control file in this case.
> 
> Also add a check in test_cpuset_prs.sh and modify some existing
> test cases to confirm that "cpuset.cpus.isolated" and HK_TYPE_DOMAIN
> housekeeping cpumask will both be updated.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c                        | 37 +++++++++++++++++--
>  .../selftests/cgroup/test_cpuset_prs.sh       | 13 +++++--
>  2 files changed, 44 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 7b7d12ab1006..0b0eb1df09d5 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -84,6 +84,9 @@ static cpumask_var_t	isolated_cpus;
>   */
>  static bool isolated_cpus_updating;
>  
> +/* Both cpuset_mutex and cpus_read_locked acquired */
> +static bool cpuset_locked;
> +
>  /*
>   * A flag to force sched domain rebuild at the end of an operation.
>   * It can be set in
> @@ -285,10 +288,12 @@ void cpuset_full_lock(void)
>  {
>  	cpus_read_lock();
>  	mutex_lock(&cpuset_mutex);
> +	cpuset_locked = true;
>  }
>  
>  void cpuset_full_unlock(void)
>  {
> +	cpuset_locked = false;
>  	mutex_unlock(&cpuset_mutex);
>  	cpus_read_unlock();
>  }
> @@ -1285,6 +1290,16 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>  	return false;
>  }
>  
> +static void isolcpus_workfn(struct work_struct *work)
> +{
> +	cpuset_full_lock();
> +	if (isolated_cpus_updating) {
> +		WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
> +		isolated_cpus_updating = false;
> +	}
> +	cpuset_full_unlock();
> +}
> +
>  /*
>   * update_isolation_cpumasks - Update external isolation related CPU masks
>   *
> @@ -1293,14 +1308,30 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>   */
>  static void update_isolation_cpumasks(void)
>  {
> -	int ret;
> +	static DECLARE_WORK(isolcpus_work, isolcpus_workfn);
>  
>  	if (!isolated_cpus_updating)
>  		return;
>  
> -	ret = housekeeping_update(isolated_cpus);
> -	WARN_ON_ONCE(ret < 0);
> +	/*
> +	 * This function can be reached either directly from regular cpuset
> +	 * control file write (cpuset_locked) or via hotplug (cpus_write_lock
> +	 * && cpuset_mutex held). In the later case, we defer the
> +	 * housekeeping_update() call to the system_unbound_wq to avoid the
> +	 * possibility of deadlock. This also means that there will be a short
> +	 * period of time where HK_TYPE_DOMAIN housekeeping cpumask will lag
> +	 * behind isolated_cpus.
> +	 */
> +	if (!cpuset_locked) {

Adding a global variable makes this difficult to handle, especially in
concurrent scenarios, since we could read it outside of a critical region.

I suggest removing cpuset_locked and adding async_update_isolation_cpumasks
instead, which can indicate to the caller it should call without holding the
full lock.

> +		/*
> +		 * We rely on WORK_STRUCT_PENDING_BIT to not requeue a work
> +		 * item that is still pending.
> +		 */
> +		queue_work(system_unbound_wq, &isolcpus_work);
> +		return;
> +	}
>  
> +	WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
>  	isolated_cpus_updating = false;
>  }
>  
> diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> index 5dff3ad53867..0502b156582b 100755
> --- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> +++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> @@ -245,8 +245,9 @@ TEST_MATRIX=(
>  	"C2-3:P1:S+  C3:P2  .      .     O2=0   O2=1    .      .     0 A1:2|A2:3 A1:P1|A2:P2"
>  	"C2-3:P1:S+  C3:P1  .      .     O2=0    .      .      .     0 A1:|A2:3 A1:P1|A2:P1"
>  	"C2-3:P1:S+  C3:P1  .      .     O3=0    .      .      .     0 A1:2|A2: A1:P1|A2:P1"
> -	"C2-3:P1:S+  C3:P1  .      .    T:O2=0   .      .      .     0 A1:3|A2:3 A1:P1|A2:P-1"
> -	"C2-3:P1:S+  C3:P1  .      .      .    T:O3=0   .      .     0 A1:2|A2:2 A1:P1|A2:P-1"
> +	"C2-3:P1:S+  C3:P2  .      .    T:O2=0   .      .      .     0 A1:3|A2:3 A1:P1|A2:P-2"
> +	"C1-3:P1:S+  C3:P2  .      .      .    T:O3=0   .      .     0 A1:1-2|A2:1-2 A1:P1|A2:P-2 3|"
> +	"C1-3:P1:S+  C3:P2  .      .      .    T:O3=0  O3=1    .     0 A1:1-2|A2:3 A1:P1|A2:P2  3"
>  	"$SETUP_A123_PARTITIONS    .     O1=0    .      .      .     0 A1:|A2:2|A3:3 A1:P1|A2:P1|A3:P1"
>  	"$SETUP_A123_PARTITIONS    .     O2=0    .      .      .     0 A1:1|A2:|A3:3 A1:P1|A2:P1|A3:P1"
>  	"$SETUP_A123_PARTITIONS    .     O3=0    .      .      .     0 A1:1|A2:2|A3: A1:P1|A2:P1|A3:P1"
> @@ -764,7 +765,7 @@ check_cgroup_states()
>  # only CPUs in isolated partitions as well as those that are isolated at
>  # boot time.
>  #
> -# $1 - expected isolated cpu list(s) <isolcpus1>{,<isolcpus2>}
> +# $1 - expected isolated cpu list(s) <isolcpus1>{|<isolcpus2>}
>  # <isolcpus1> - expected sched/domains value
>  # <isolcpus2> - cpuset.cpus.isolated value = <isolcpus1> if not defined
>  #
> @@ -773,6 +774,7 @@ check_isolcpus()
>  	EXPECTED_ISOLCPUS=$1
>  	ISCPUS=${CGROUP2}/cpuset.cpus.isolated
>  	ISOLCPUS=$(cat $ISCPUS)
> +	HKICPUS=$(cat /sys/devices/system/cpu/isolated)
>  	LASTISOLCPU=
>  	SCHED_DOMAINS=/sys/kernel/debug/sched/domains
>  	if [[ $EXPECTED_ISOLCPUS = . ]]
> @@ -810,6 +812,11 @@ check_isolcpus()
>  	ISOLCPUS=
>  	EXPECTED_ISOLCPUS=$EXPECTED_SDOMAIN
>  
> +	#
> +	# The inverse of HK_TYPE_DOMAIN cpumask in $HKICPUS should match $ISOLCPUS
> +	#
> +	[[ "$ISOLCPUS" != "$HKICPUS" ]] && return 1
> +
>  	#
>  	# Use the sched domain in debugfs to check isolated CPUs, if available
>  	#

-- 
Best regards,
Ridong


