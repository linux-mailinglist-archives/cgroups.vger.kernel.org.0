Return-Path: <cgroups+bounces-15440-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGJNLMCL52lY9wEAu9opvQ
	(envelope-from <cgroups+bounces-15440-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 16:37:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5583843C264
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 16:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35DC3305FC26
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 14:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D173D902E;
	Tue, 21 Apr 2026 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbV/cz7r"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39483D6CC1
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781825; cv=none; b=OZ2wPul73uxZeTNUM0tf3h3GFHUCUSndNk8wE09yaCKZC4jwcKDvCWLanGwtGj3HCdsxOCsHPNBp+5gUqKHRFd0eV7/6fntP/tM9JiFIxKh0XOPhwE1FcXGSXFk8byD37KGhlL9fnPd+Y17KM20oyLKBQ6prf66W8OEvkKRth2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781825; c=relaxed/simple;
	bh=wzm7TkfUtsdkCf+9WRD+mx0ZLEZab+prGzlMMBHO+zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDeRYK9fB74EdFhPQxiFzpNstWMNVoqiv7dhYgLfThskvIl6eDKxWahwwiiUam49zkvpsm7Lq+h+NfE/0AzWMP3uqOJg7W71Sja39AmXp+mSaZo4aml7Af36617oU0W/h4HqpUrmYSXd6NywCSWtxsRbpF81/LqW+LkOC8Wex5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YbV/cz7r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776781823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWylwziUJR6+djO988m8SXRnsaLXz4wU91J/b9HxTcg=;
	b=YbV/cz7r9U1RW85Z52XozpZRqK/cBxpucRO4JzKQREXFMzd9IBUCgb6j86rKahMLFDRstu
	0X9CQzYYIyoNMgCgF2iDb3i4/7iKTo8U1QNP20BK92kjfVOHhwbcD88PNNJmvdRKPccqFq
	DYFBKpjShbqX54H62RsHWu68VndoaNE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-OuySZZZCNne9e9u0fHq2OQ-1; Tue,
 21 Apr 2026 10:30:16 -0400
X-MC-Unique: OuySZZZCNne9e9u0fHq2OQ-1
X-Mimecast-MFC-AGG-ID: OuySZZZCNne9e9u0fHq2OQ_1776781809
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE80619560AB;
	Tue, 21 Apr 2026 14:30:08 +0000 (UTC)
Received: from [10.22.81.187] (unknown [10.22.81.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3068C1800660;
	Tue, 21 Apr 2026 14:30:00 +0000 (UTC)
Message-ID: <46e1989c-d0a3-46c4-9a9f-3476789b9dc1@redhat.com>
Date: Tue, 21 Apr 2026 10:29:59 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/23] genirq/cpuhotplug: Use RCU to protect access of
 HK_TYPE_MANAGED_IRQ cpumask
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
 <20260421030351.281436-17-longman@redhat.com> <87qzo8bs9m.ffs@tglx>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <87qzo8bs9m.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-15440-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[52];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5583843C264
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/26 5:02 AM, Thomas Gleixner wrote:
> On Mon, Apr 20 2026 at 23:03, Waiman Long wrote:
>
>> As HK_TYPE_MANAGED_IRQ cpumask is going to be changeable at run time,
>> use RCU to protect access to the cpumask.
>>
>> To enable the new HK_TYPE_MANAGED_IRQ cpumask to take effect, the
>> following steps can be done.
> Can be done?
>
>>   1) Update the HK_TYPE_MANAGED_IRQ cpumask to take out the newly isolated
>>      CPUs and add back the de-isolated CPUs.
>>   2) Tear down the affected CPUs to cause irq_migrate_all_off_this_cpu()
>>      to be called on the affected CPUs to migrate the irqs to other
>>      HK_TYPE_MANAGED_IRQ housekeeping CPUs.
>>   3) Bring up the previously offline CPUs to invoke
>>      irq_affinity_online_cpu() to allow the newly de-isolated CPUs to
>>      be used for managed irqs.
> Which previously offline CPUs?
This part should go into another patch.
>
>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> index 2e8072437826..8270c4de260b 100644
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -263,6 +263,7 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask, bool
>>   	    housekeeping_enabled(HK_TYPE_MANAGED_IRQ)) {
>>   		const struct cpumask *hk_mask;
>>   
>> +		guard(rcu)();
>>   		hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
>>   
>>   		cpumask_and(tmp_mask, mask, hk_mask);
> How is this hunk related to $Subject?

The subject is actually about using RCU to protect access to 
housekeeping cpumask. There are extra info in the commit  log that 
should go to another patch.

Cheers,
Longman

>


