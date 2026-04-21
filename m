Return-Path: <cgroups+bounces-15437-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAUCMS+I52kU9wEAu9opvQ
	(envelope-from <cgroups+bounces-15437-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 16:22:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD76243BF20
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 16:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A05C7300AB3C
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 14:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112453D88EA;
	Tue, 21 Apr 2026 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUwRnkBD"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ADB3A2546
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781341; cv=none; b=mQV0c1bTxALWNa6MMj7iJeZny0gXVZadm76C0nV+VcPw+rkZDSk+xd95lLQfsfARQkPUVakHGWuxactaDI80SdCRECTVISPiPF/1QLcpqrehZFA+L594XXKzqmfMuYkZDe+yFU3k9LRLVmYZ/RDMS3j00mJ5s9eCnmMqbpnzuYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781341; c=relaxed/simple;
	bh=r+fOxns+jmr0M0EyFWMcq/R4Njx5zASRZz9Y1X+qpvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCogdi9FjfRuOI0OPjDmcTk2sXVfsWmcB3k7nS5w2bb5hdXXN3z2AcCjIRukVhQdQiejWdlOT1PXj+NzrCkLoQFG3b4YlW/zGfkl81mCxxW75Up96sa8VjfSSoGzQOb4YzpSTBkWpQDLSMLob/JMWZNSGmJilE8cawEjoGqx7us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUwRnkBD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776781339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWjWRROifEq97+No/LV67J9L8ZDl4T0+6eN/kJ0ejKE=;
	b=SUwRnkBDtdsc8xJhoQilMUrpIrnMmZ3AbCYtUcQQ7PI4fzZtr0viVWwolLF6UeBSa9Rp2y
	QhhDViqxmGv0hqUzUJrDHo72xZOYs7T/lYASDbQUdZ3nSLj2XxqYNY95wy4gf755qvIfg9
	FIXK7Ds9YnZ8AtY9V5QMZR+LM+W5EFc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-t9Gcpr49M6KwwY5DsipUnQ-1; Tue,
 21 Apr 2026 10:22:18 -0400
X-MC-Unique: t9Gcpr49M6KwwY5DsipUnQ-1
X-Mimecast-MFC-AGG-ID: t9Gcpr49M6KwwY5DsipUnQ_1776781333
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98BA819560B9;
	Tue, 21 Apr 2026 14:22:11 +0000 (UTC)
Received: from [10.22.81.187] (unknown [10.22.81.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 187903000C26;
	Tue, 21 Apr 2026 14:22:02 +0000 (UTC)
Message-ID: <149748c4-7fbd-47a5-acc9-c480033e1907@redhat.com>
Date: Tue, 21 Apr 2026 10:22:02 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/23] tick: Pass timer tick job to an online HK CPU in
 tick_cpu_dying()
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
 <20260421030351.281436-6-longman@redhat.com> <87zf2wbsli.ffs@tglx>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <87zf2wbsli.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-15437-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[52];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AD76243BF20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/26 4:55 AM, Thomas Gleixner wrote:
> On Mon, Apr 20 2026 at 23:03, Waiman Long wrote:
>> In tick_cpu_dying(), if the dying CPU is the current timekeeper,
>> it has to pass the job over to another CPU. The current code passes
>> it to another online CPU. However, that CPU may not be a timer tick
>> housekeeping CPU.  If that happens, another CPU will have to manually
>> take it over again later. Avoid this unnecessary work by directly
>> assigning an online housekeeping CPU.
>>
>> Use READ_ONCE/WRITE_ONCE() to access tick_do_timer_cpu in case the
>> non-HK CPUs may not be in stop machine in the future.
> 'may not be in the future' is yet more handwaving without
> content. Please write your change logs in a way so that people who have
> not spent months on this can follow.
>
>> @@ -394,12 +395,19 @@ int tick_cpu_dying(unsigned int dying_cpu)
>>   {
>>   	/*
>>   	 * If the current CPU is the timekeeper, it's the only one that can
>> -	 * safely hand over its duty. Also all online CPUs are in stop
>> -	 * machine, guaranteed not to be idle, therefore there is no
>> +	 * safely hand over its duty. Also all online housekeeping CPUs are
>> +	 * in stop machine, guaranteed not to be idle, therefore there is no
>>   	 * concurrency and it's safe to pick any online successor.
>>   	 */
>> -	if (tick_do_timer_cpu == dying_cpu)
>> -		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
>> +	if (READ_ONCE(tick_do_timer_cpu) == dying_cpu) {
>> +		unsigned int new_cpu;
>> +
>> +		guard(rcu)();
> What's this guard for?
>
>> +		new_cpu = cpumask_first_and(cpu_online_mask, housekeeping_cpumask(HK_TYPE_TICK));
> Why has this to use housekeeping_cpumask() and does not use
> tick_nohz_full_mask?

The RCU guard is for accessing the HK_TYPE_TICK(HK_TYPE_KERNEL_NOISE) 
cpumask. tick_nohz_full_mask cpumask is actually the inverse of 
HK_TYPE_TICK cpumask. Yes, I could use cpumask_first_andnot() with 
tick_nohz_full_mask. If we make tick_nohz_full_mask an RCU protected 
pointer, we still need the guard.

Cheers,
Longman


