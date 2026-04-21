Return-Path: <cgroups+bounces-15445-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOHuG5y052lU/wEAu9opvQ
	(envelope-from <cgroups+bounces-15445-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 19:32:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C8C43E00F
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 19:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5E333066441
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 17:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7717635B632;
	Tue, 21 Apr 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6/rxD2g"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36F4309F08
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 17:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792579; cv=none; b=EGYv66CtCHSOovI+JswZO1s2Ev3KuiKiUfNk4luuEPKUx6dlnTTa87BSdH0WcbHrwWFc5v/Q1A0gDLulOGRJefI3MP+2x6z7P/V2q/oN5zheS9AuDP+edZPbPZB3KJ03YPoHNeEOooBUXrnNlWuRQbDtTibn8aAROJsxszBujP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792579; c=relaxed/simple;
	bh=VRbBLkJBl+z3HTRe7tf+8AKkBOA7bNWyE97HPTvWiJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7DHgWO6vXyNNkuf+XWzDpMtHLV3ExxfIvaV8JhighMa362tWuOgx3BdRm9MVuF076OlYCndzSL5YrA/HBwYekBgz5uV9pCUx3DlWOGkSEh3scSmPe+2iyWIvkmDx+IBCG5hZRhko3POdHCPHUJ5VYbMc9hyK0u1DBy1xzzvIJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6/rxD2g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776792576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSzH4UO9mwmNv9V8DVTJXMoHGetE5S75Ur4A6FFRmRI=;
	b=S6/rxD2gIWvdYiL9HDj7hqZ6N1IOfZWeAEE3gQSIzYZTgW2cTy70c8swt9eInieWlz0jCH
	MoPD23FqVqmdPEWEAxJv3Jv6WjLs6MfiwV0gvmUMVsr9hcINSoCZdL8VN6TGE0JkxQ/I/E
	opqMpVYstgsO14BfYgr/OqkjoWPNUP8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-AR04jpNePPu2fuaiQEqIAA-1; Tue,
 21 Apr 2026 13:29:32 -0400
X-MC-Unique: AR04jpNePPu2fuaiQEqIAA-1
X-Mimecast-MFC-AGG-ID: AR04jpNePPu2fuaiQEqIAA_1776792566
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56FD918005B0;
	Tue, 21 Apr 2026 17:29:24 +0000 (UTC)
Received: from [10.22.81.187] (unknown [10.22.81.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D826419560B6;
	Tue, 21 Apr 2026 17:29:13 +0000 (UTC)
Message-ID: <4a0ede3e-6e87-414f-a3a3-dd15c32f25ef@redhat.com>
Date: Tue, 21 Apr 2026 13:29:13 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/23] cpu/hotplug: Add a new cpuhp_offline_cb() API
To: Thomas Gleixner <tglx@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Guenter Roeck <linux@roeck-us.net>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Ingo Molnar
 <mingo@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-hwmon@vger.kernel.org,
 rcu@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Costa Shulyupin <cshulyup@redhat.com>,
 Qiliang Yuan <realwujing@gmail.com>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260421030351.281436-19-longman@redhat.com> <87o6jcb84w.ffs@tglx>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <87o6jcb84w.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-15445-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[52];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5C8C43E00F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/26 12:17 PM, Thomas Gleixner wrote:
> On Mon, Apr 20 2026 at 23:03, Waiman Long wrote:
>> Add a new cpuhp_offline_cb() API that allows us to offline a set of
>> CPUs one-by-one, run the given callback function and then bring those
>> CPUs back online again while inhibiting any concurrent CPU hotplug
>> operations from happening.
> Please provide a properly structured change log which explains the
> context, the problem and the solution in separate paragraphs and this
> order. This is not new. It's documented...
>
>> This new API can be used to enable runtime adjustment of nohz_full and
>> isolcpus boot command line options. A new cpuhp_offline_cb_mode flag
>> is also added to signal that the system is in this offline callback
>> transient state so that some hotplug operations can be optimized out
>> if we choose to.
> We chose nothing.
>
>> +#include <linux/cpumask_types.h>
> What for? This header only needs a 'struct cpumask' forward declaration
> so that the compiler can handle the pointer argument, no?
>
>> +typedef int (*cpuhp_cb_t)(void *arg);
> You couldn't come up with a more generic name for this, right?
>
>>   struct device;
>>   
>>   extern int lockdep_is_cpus_held(void);
>> @@ -29,6 +31,8 @@ void clear_tasks_mm_cpumask(int cpu);
>>   int remove_cpu(unsigned int cpu);
>>   int cpu_device_down(struct device *dev);
>>   void smp_shutdown_nonboot_cpus(unsigned int primary_cpu);
>> +int cpuhp_offline_cb(struct cpumask *mask, cpuhp_cb_t func, void *arg);
> Ditto.
>
>> +extern bool cpuhp_offline_cb_mode;
> Groan. The only users are in the cpusets code which invokes this muck
> and should therefore know what's going on, no?
>
>>   #else /* CONFIG_HOTPLUG_CPU */
>>   
>> @@ -43,6 +47,11 @@ static inline void cpu_hotplug_disable(void) { }
>>   static inline void cpu_hotplug_enable(void) { }
>>   static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
>>   static inline void smp_shutdown_nonboot_cpus(unsigned int primary_cpu) { }
>> +static inline int cpuhp_offline_cb(struct cpumask *mask, cpuhp_cb_t func, void *arg)
>> +{
>> +	return -EPERM;
> -EPERM?
>
>> +/**
>> + * cpuhp_offline_cb - offline CPUs, invoke callback function & online CPUs afterward
>> + * @mask: A mask of CPUs to be taken offline and then online
>> + * @func: A callback function to be invoked while the given CPUs are offline
>> + * @arg:  Argument to be passed back to the callback function
>> + *
>> + * Return: 0 if successful, an error code otherwise
>> + */
>> +int cpuhp_offline_cb(struct cpumask *mask, cpuhp_cb_t func, void *arg)
>> +{
>> +	int off_cpu, on_cpu, ret, ret2 = 0;
>> +
>> +	if (WARN_ON_ONCE(cpumask_empty(mask) ||
>> +	   !cpumask_subset(mask, cpu_online_mask)))
>> +		return -EINVAL;
> No line break required. You have 100 characters.
>
> But what's worse is that the access to cpu_online_mask is not protected
> against a concurrent CPU hotplug operation.
>
>> +
>> +	pr_debug("%s: begin (CPU list = %*pbl)\n", __func__, cpumask_pr_args(mask));
> Tracing?
>
>> +	lock_device_hotplug();
>> +	cpuhp_offline_cb_mode = true;
>> +	/*
>> +	 * If all offline operations succeed, off_cpu should become nr_cpu_ids.
>> +	 */
>> +	for_each_cpu(off_cpu, mask) {
>> +		ret = device_offline(get_cpu_device(off_cpu));
>> +		if (unlikely(ret))
>> +			break;
>> +	}
>> +	if (!ret)
>> +		ret = func(arg);
>> +
>> +	/* Bring previously offline CPUs back online */
>> +	for_each_cpu(on_cpu, mask) {
>> +		int retries = 0;
>> +
>> +		if (on_cpu == off_cpu)
>> +			break;
>> +
>> +retry:
>> +		ret2 = device_online(get_cpu_device(on_cpu));
>> +
>> +		/*
>> +		 * With the unlikely event that CPU hotplug is disabled while
>> +		 * this operation is in progress, we will need to wait a bit
>> +		 * for hotplug to hopefully be re-enabled again. If not, print
>> +		 * a warning and return the error.
>> +		 *
>> +		 * cpu_hotplug_disabled is supposed to be accessed while
>> +		 * holding the cpu_add_remove_lock mutex. So we need to
>> +		 * use the data_race() macro to access it here.
>> +		 */
>> +		while ((ret2 == -EBUSY) && data_race(cpu_hotplug_disabled) &&
>> +		       (++retries <= 5)) {
>> +			msleep(20);
>> +			if (!data_race(cpu_hotplug_disabled))
>> +				goto retry;
>> +		}
>> +		if (ret2) {
>> +			pr_warn("%s: Failed to bring CPU %d back online!\n",
>> +				__func__, on_cpu);
> Provide a proper text and not this silly __func__ thing.
>
>> +			break;
>> +		}
>> +	}
> TBH. This is unreviewable gunk and the whole 'unlikely event that CPU
> hotplug is disabled' is just a lazy hack.
>
> All of this can be avoided including this made up callback function.
>
> It's not rocket science to provide:
>
>       1) A function which serializes against any other CPU hotplug
>          related action.
>
>       2) A function which brings the CPUs in a given CPU mask down
>
>       3) A function which brings the CPUs in a given CPU mask up
>
>       4) A function which undoes #1
>
> Yeah I know, it's more work and not convoluted enough. But see below.
>
> That brings me to that other hack namely cpuhp_offline_cb_mode, which
> you self described as such in patch 21/23:
>
>> +	/*
>> +	 * Hack: In cpuhp_offline_cb_mode, pretend all partitions are empty
>> +	 * to prevent unnecessary partition invalidation.
>> +	 */
>> +	if (cpuhp_offline_cb_mode)
>> +		return false;
>> +
> We are not merging hacks. End of story. But you knew that already, no?
>
> Let's take a step back and see what you really need to achieve:
>
>    1) Update tick_nohz_full_mask
>    2) Update the managed interrupt mask
>    3) Update CPU sets
>
> Independent of the direction of this update you need to ensure that the
> affected functionality keeps working correctly.
>
> You achieve that by bulk offlining the affected CPUs, invoking a magic
> callback and then bulk onlining the affected CPUs again, which requires
> that ill defined cpuhp_offline_cb_mode hackery and probably some more
> hacks all over the place.
>
> You can achieve the same by doing CPU by CPU operations in the right
> order without this mode hack, when you establish proper limitations for
> this:
>
>    At no point in time it's allowed to empty a CPU set or a affected CPU
>    mask, except when you completely undo the isolation of CPUs.
>
>    That can be computed upfront w/o changing anything at all. Once the
>    validity is established, the update can proceed. Or you can leave it
>    to user space which can keep the pieces if it gets it wrong.
>
> That's a reasonable limitation as there is absolutely zero justification
> to support something like:
>
>         housekeeping_cpus = [CPU 0], isolated_cpus = [CPU 1]
>    ---> housekeeping_cpus = [CPU 1], isolated_cpus = [CPU 0]
>
> just because we can with enough horrible hacks.
>
> If you get that out of the way, then a CPU by CPU update becomes the
> obvious and simplest solution. The ordering constraints can be computed
> in user space upfront and there is no reason to do any of this in the
> kernel itself except for an eventual validation step. It might be a tad
> slower, but this is all but a hotpath operation.
>
> Just for the record. I suggested exactly this more than a year ago and
> it's still the right thing to do.
>
> And of course neither your cover letter nor any of the patches give a
> proper rationale why you think that your bulk hackery is better. For the
> very simple reason that there is no rationale at all.
>
> This bulk muck is doomed when your ultimate goal is to avoid the stop
> machine dance. With a per CPU update it is actually doable without more
> ill defined hacks all over the place.
>
>     1) Bring down the CPU to CPUHP_AP_SCHED_WAIT_EMPTY, which is the last
>        state before stop machine is invoked.
>
>        At that point:
>
>           - no user space thread is running on the CPU anymore
>
>           - everything related to this CPU has been shut down or moved
>             elsewhere
>
>           - interrupt managed device queues are quiesced if the CPU was
>             the last online one in the queue affinity mask. If not the
>             interrupt might still be affine to the CPU, but there is at
>             least one other CPU available in the mask.
>
>     2) Update the tick NOHZ handover
>
>        This can be done without going into stop machine by providing a
>        hotplug callback right between CPUHP_AP_SMPBOOT_THREADS and
>        CPUHP_AP_IRQ_AFFINITY_ONLINE.
>
>        That's trivial enough to achieve and can work independently of
>        NOHZ full.
>
>     3) Rework the affinity management, so that interrupt affinities can
>        be reassigned in the CPUHP_AP_IRQ_AFFINITY_ONLINE state.
>
>        That needs a lot of thoughts, but there is no real reason why it
>        can't work.
>
>     4) Flip the housekeeping CPU masks in sched_cpu_wait_empty() after
>        balance_hotplug_wait().
>
>     5) Bring the CPU online again.
>
> For #2 and #3 to work you need a separate CPU mask which avoids touching
> CPU online mask. For #3 this needs some more work to avoid reassigning the
> interrupts once sparse_irq_lock is dropped, but the bulk is achieved
> with the separate CPU mask.
>
> No?

Thanks for the great suggestions. I will certainly look into that.

We actually have a cpu_active_mask that will be cleared early in 
sched_cpu_deactivate(). In the CPUHP_AP_SCHED_WAIT_EMPTY state, the CPU 
will still have online bit set but the active bit will be cleared. Or we 
could add another cpumask that can be used to indicate CPUs that have 
reached CPUHP_AP_SCHED_WAIT_EMPTY or below if necessary.

Cheers,
Longman


