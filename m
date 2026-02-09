Return-Path: <cgroups+bounces-13804-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DZUIGGFiWni+QQAu9opvQ
	(envelope-from <cgroups+bounces-13804-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 07:57:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDD810C45F
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 07:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F1A23007ACC
	for <lists+cgroups@lfdr.de>; Mon,  9 Feb 2026 06:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D036431A56B;
	Mon,  9 Feb 2026 06:57:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E3D28A72B;
	Mon,  9 Feb 2026 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770620246; cv=none; b=gjB2kxHpiWH1sn45aEqh6ixFEoAsNZBzryjzL3kArGr/wMm39idSGSK/ZpevTEOLF1ejPukJv7Au2MaLH6SRJEe63Ko+0vOYqpbriJMeT7t6nbuFCj+h+JrsTeb029+rSutQSXMN3D4LvO+9MZRJuZCzGT6hTNiEozpCOea/Hoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770620246; c=relaxed/simple;
	bh=zDE8KaWesmPKlKuoka5mDYDOZVqSroew+Dl6+BDvcEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjXXAnW4lCF7xaEzO2O4COn4yL98hcS/1aUK8/lRgsIESOJPOLI741Cy+Skwb1Atx3PSdjihBobGNSM/20v+8USvxIhv6AmwUBjc5x8/xHzXwmhxLRtft+k8/BTfWAOBdxpjbYeG6+NYIIVCbRZE8IEl8prtVrsFiB1Jwx+OxEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f8b896q0nzYQtyZ;
	Mon,  9 Feb 2026 14:56:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0A6F84056D;
	Mon,  9 Feb 2026 14:57:23 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgCH7XxRhYlp3WbVGg--.5491S2;
	Mon, 09 Feb 2026 14:57:22 +0800 (CST)
Message-ID: <428a36a2-7474-4bb8-ae68-a152ebae70f0@huaweicloud.com>
Date: Mon, 9 Feb 2026 14:57:20 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v4 2/4] cgroup/cpuset: Defer
 housekeeping_update() calls from CPU hotplug to workqueue
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
References: <20260206203712.1989610-1-longman@redhat.com>
 <20260206203712.1989610-3-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260206203712.1989610-3-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCH7XxRhYlp3WbVGg--.5491S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKw4xKw1UCryUAF4fury5twb_yoW7KrWUpF
	yrKrWSyw4rKr13Ga4S93Z2qr4Fgws7A347trsxXr15ZF1akFn29FyvqwnxJrWrur95urW5
	ZF9xG398Wa1jy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.978];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	TAGGED_FROM(0.00)[bounces-13804-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[test_cpuset_prs.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEDD810C45F
X-Rspamd-Action: no action



On 2026/2/7 4:37, Waiman Long wrote:
> The update_isolation_cpumasks() function can be called either directly
> from regular cpuset control file write with cpuset_full_lock() called
> or via the CPU hotplug path with cpus_write_lock and cpuset_mutex held.
> 
> As we are going to enable dynamic update to the nozh_full housekeeping
						    ^
						nohz_full
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
>  kernel/cgroup/cpuset.c                        | 41 +++++++++++++++++--
>  .../selftests/cgroup/test_cpuset_prs.sh       | 13 ++++--
>  2 files changed, 48 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a4c6386a594d..eb0eabd85e8c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1302,6 +1302,17 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>  	return false;
>  }
>  
> +static void isolcpus_workfn(struct work_struct *work)
> +{
> +	cpuset_full_lock();
> +	if (isolated_cpus_updating) {
> +		isolated_cpus_updating = false;
> +		WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
> +		rebuild_sched_domains_locked();
> +	}
> +	cpuset_full_unlock();
> +}
> +
>  /*
>   * update_isolation_cpumasks - Update external isolation related CPU masks
>   *
> @@ -1310,14 +1321,38 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>   */
>  static void update_isolation_cpumasks(void)
>  {
> -	int ret;
> +	static DECLARE_WORK(isolcpus_work, isolcpus_workfn);
>  
> +	lockdep_assert_cpuset_lock_held();
>  	if (!isolated_cpus_updating)
>  		return;
>  
> -	ret = housekeeping_update(isolated_cpus);
> -	WARN_ON_ONCE(ret < 0);
> +	/*
> +	 * This function can be reached either directly from regular cpuset
> +	 * control file write or via CPU hotplug. In the latter case, it is
> +	 * the per-cpu kthread that calls cpuset_handle_hotplug() on behalf
> +	 * of the task that initiates CPU shutdown or bringup.
> +	 *
> +	 * To have better flexibility and prevent the possibility of deadlock
> +	 * when calling from CPU hotplug, we defer the housekeeping_update()
> +	 * call to after the current cpuset critical section has finished.
> +	 * This is done via workqueue.
> +	 */
> +	if (current->flags & PF_KTHREAD) {
> +		/*
> +		 * We rely on WORK_STRUCT_PENDING_BIT to not requeue a work
> +		 * item that is still pending. Before the pending bit is
> +		 * cleared, the work data is copied out and work item dequeued.
> +		 * So it is possible to queue the work again before the
> +		 * isolcpus_workfn() is invoked to process the previously
> +		 * queued work. Since isolcpus_workfn() doesn't use the work
> +		 * item at all, this is not a problem.
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


