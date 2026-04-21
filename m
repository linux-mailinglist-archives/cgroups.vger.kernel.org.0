Return-Path: <cgroups+bounces-15439-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JzwAceK52lY9wEAu9opvQ
	(envelope-from <cgroups+bounces-15439-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 16:33:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6265A43C17B
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 16:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B681308FD5E
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 14:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E773D890E;
	Tue, 21 Apr 2026 14:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6im2576"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10413D8106
	for <cgroups@vger.kernel.org>; Tue, 21 Apr 2026 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781567; cv=none; b=h8lEI3fTmEmBymkbMSnTmoo/qEBN5MSSQEOjNW2lxZCQKCE01NL7NWVJpli9WjmyUxdT25YRTM6Q9g67xrAl3ayHvnNAILzHVevRBKhpYdWjSHBLbzDbSt33H+Gau1ugFrprOHPgrDxoUHHguzUTRFM0H1u8oj3Vvb5Q8SrmZbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781567; c=relaxed/simple;
	bh=SG9TyVz2FKGn4It97z8qxSOz48ceXBCGCNeEx9UkI/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJJ+PxX6bvD2O9+kzEu3O0WBloAHFO+odls10aLPyaYqYcRo0r+mTlvH/wCBsAv1F4aju6vdbeC/gILS0AscLDLkJcG1QIics4OGS7zrAlpvv8VB43RFPeoQcs4wyQMeA6/JAWKZP6TiEmwd7/s2z0PdR0pw0fBQwSn9OpyH44E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6im2576; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776781564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpQv2nmOkTVoNtTsiQ2DrTic771j3rKCjuGbBpejCvU=;
	b=P6im2576ANcjDXKJWlJp3M3kBiZYebL7KBF0/eZKNZ/qfm7spSGFXi4n50GSgmjbco+Cci
	5fqmr4t7rB21gx1w3c0nNq7lOLKXuMOUUaXgJ5qNLbZamSZ040TpWtI5i3zo14Up1Y9I9c
	gxZf3+hahWZjl2FGT5n66JB1B7c1V2g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-xs3N2oRYOFOjpa-3JwwkQg-1; Tue,
 21 Apr 2026 10:25:58 -0400
X-MC-Unique: xs3N2oRYOFOjpa-3JwwkQg-1
X-Mimecast-MFC-AGG-ID: xs3N2oRYOFOjpa-3JwwkQg_1776781553
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 248D51956054;
	Tue, 21 Apr 2026 14:25:52 +0000 (UTC)
Received: from [10.22.81.187] (unknown [10.22.81.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2506C180047F;
	Tue, 21 Apr 2026 14:25:44 +0000 (UTC)
Message-ID: <0281dde0-e00f-4f38-a15a-3ade02ecbb59@redhat.com>
Date: Tue, 21 Apr 2026 10:25:43 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/23] cpu: Use RCU to protect access of HK_TYPE_TIMER
 cpumask
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
 <20260421030351.281436-11-longman@redhat.com> <87wly0bsh5.ffs@tglx>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <87wly0bsh5.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-15439-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[52];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6265A43C17B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/26 4:57 AM, Thomas Gleixner wrote:
> On Mon, Apr 20 2026 at 23:03, Waiman Long wrote:
>> As HK_TYPE_TIMER cpumask is going to be changeable at run time, use
>> RCU to protect access to the cpumask.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cpu.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/cpu.c b/kernel/cpu.c
>> index bc4f7a9ba64e..0d02b5d7a7ba 100644
>> --- a/kernel/cpu.c
>> +++ b/kernel/cpu.c
>> @@ -1890,6 +1890,8 @@ int freeze_secondary_cpus(int primary)
>>   	cpu_maps_update_begin();
>>   	if (primary == -1) {
>>   		primary = cpumask_first(cpu_online_mask);
>> +
>> +		guard(rcu)();
>>   		if (!housekeeping_cpu(primary, HK_TYPE_TIMER))
>>   			primary = housekeeping_any_cpu(HK_TYPE_TIMER);
> housekeeping_cpu() and housekeeping_any_cpu() can operate on two
> different CPU masks once the runtime update is enabled.
>
> Seriously?

Good point, will fix that in the next version.

Cheers,
Longman


