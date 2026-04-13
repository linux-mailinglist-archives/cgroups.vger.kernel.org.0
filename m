Return-Path: <cgroups+bounces-15276-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPfgA6tE3WkubQkAu9opvQ
	(envelope-from <cgroups+bounces-15276-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 21:31:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCFD3F2C0C
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 21:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C78743077E1C
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 19:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971AF3CF031;
	Mon, 13 Apr 2026 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUG4tW4E"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3803469F6
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776108369; cv=none; b=eFQR3fbJfknlTXNVpEU92OkMRUkmTF8NE+DGuY7jeUBkKe1Pc9IInd01uFDb9TH1dCVBxrsrqTfmFH+T3KDcfpau1GAXVK3cnWjR6TNQLHKfd7uIcOuPO87jTPf+GfdWBCbShaI+r1kvi/AMtBZgYKp38Tq0kNgitZ0Swci2OiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776108369; c=relaxed/simple;
	bh=JhhiDtpgCIbIcPcjurEF+BYrFwWWHfvbfmV0YHXq4o0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLJjiHo6FWrZLmYmCTZQi7PVr7L7rTcLzw6MCrnPgByEgHQfVNb26qp3PEcQ7TtuqZ9KhQeyf82frnAloINDYGBjNwjEwE44FyLkoqFWawgLX143a1O3nFKtUO8JcMVl/tdTJFxCzHmiAuLi8xAWqHqyvrktCUEjEIhx4PglugI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUG4tW4E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776108366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4BWr/5AY8ZAqufMs3TADs0Xu7j+z3NdjM/f4VibM9b8=;
	b=WUG4tW4EpKrRDOvfphj1tdkAlNV8DHdsIZFeqT6HkI0oBJ25LIWq9KyL2//iSA5cWVgG9S
	uRMigISWTpzvBWin8rjt9JL1YGPxpq3gtPgpGA2D4dqEQ6b1/FI0rSeMHNEqHvMGj6Nez1
	37zFXxGo+7lCk4lP4ytjqnXK6fdZVsc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-Uxe0wUrkPlijpBHtUceyPQ-1; Mon,
 13 Apr 2026 15:26:02 -0400
X-MC-Unique: Uxe0wUrkPlijpBHtUceyPQ-1
X-Mimecast-MFC-AGG-ID: Uxe0wUrkPlijpBHtUceyPQ_1776108358
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 546391800372;
	Mon, 13 Apr 2026 19:25:57 +0000 (UTC)
Received: from [10.22.65.13] (unknown [10.22.65.13])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 53FA31800357;
	Mon, 13 Apr 2026 19:25:47 +0000 (UTC)
Message-ID: <fd77bca8-bee8-4997-a11a-932a1693edf7@redhat.com>
Date: Mon, 13 Apr 2026 15:25:46 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] sched/isolation: Separate housekeeping types in
 enum hk_type
To: Qiliang Yuan <realwujing@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Ingo Molnar
 <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Chen Ridong <chenridong@huaweicloud.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
 <20260413-wujing-dhm-v2-1-06df21caba5d@gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260413-wujing-dhm-v2-1-06df21caba5d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15276-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,efficios.com,linux.dev,linutronix.de,linux-foundation.org,suse.com,cmpxchg.org,huaweicloud.com,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CCFD3F2C0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 3:43 AM, Qiliang Yuan wrote:
> Most kernel noise types (TICK, TIMER, RCU, etc.) are currently aliased
> to a single HK_TYPE_KERNEL_NOISE enum value. This prevents fine-grained
> runtime isolation control as all masks are forced to be identical.
>
> Un-alias service-specific housekeeping types in enum hk_type. This
> separation provides the necessary granularity for DHM subsystems to
> subscribe to and maintain independent affinity masks.

Usually, if we want to run a latency sensitive workload like DPDK, we 
try to minimize all sorts of kernel noises or interference as much as 
possible. Do you have a good use case where it is advantageous to remove 
some types of kernel noises from a given set of CPUs but not the others?

Cheers,
Longman

> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> ---
>   include/linux/sched/isolation.h | 20 ++++++++------------
>   kernel/sched/isolation.c        | 10 +++++++++-
>   2 files changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index dc3975ff1b2e1..b9a041247565c 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -17,21 +17,17 @@ enum hk_type {
>   	/* Inverse of boot-time isolcpus=managed_irq argument */
>   	HK_TYPE_MANAGED_IRQ,
>   	/* Inverse of boot-time nohz_full= or isolcpus=nohz arguments */
> -	HK_TYPE_KERNEL_NOISE,
> +	HK_TYPE_TICK,
> +	HK_TYPE_TIMER,
> +	HK_TYPE_RCU,
> +	HK_TYPE_MISC,
> +	HK_TYPE_WQ,
> +	HK_TYPE_KTHREAD,
>   	HK_TYPE_MAX,
> -
> -	/*
> -	 * The following housekeeping types are only set by the nohz_full
> -	 * boot commandline option. So they can share the same value.
> -	 */
> -	HK_TYPE_TICK    = HK_TYPE_KERNEL_NOISE,
> -	HK_TYPE_TIMER   = HK_TYPE_KERNEL_NOISE,
> -	HK_TYPE_RCU     = HK_TYPE_KERNEL_NOISE,
> -	HK_TYPE_MISC    = HK_TYPE_KERNEL_NOISE,
> -	HK_TYPE_WQ      = HK_TYPE_KERNEL_NOISE,
> -	HK_TYPE_KTHREAD = HK_TYPE_KERNEL_NOISE
>   };
>   
> +#define HK_TYPE_KERNEL_NOISE HK_TYPE_TICK
> +
>   #ifdef CONFIG_CPU_ISOLATION
>   DECLARE_STATIC_KEY_FALSE(housekeeping_overridden);
>   extern int housekeeping_any_cpu(enum hk_type type);
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index ef152d401fe20..e05ed5118e651 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -15,9 +15,17 @@ enum hk_flags {
>   	HK_FLAG_DOMAIN_BOOT	= BIT(HK_TYPE_DOMAIN_BOOT),
>   	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
>   	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
> -	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
> +	HK_FLAG_TICK		= BIT(HK_TYPE_TICK),
> +	HK_FLAG_TIMER		= BIT(HK_TYPE_TIMER),
> +	HK_FLAG_RCU		= BIT(HK_TYPE_RCU),
> +	HK_FLAG_MISC		= BIT(HK_TYPE_MISC),
> +	HK_FLAG_WQ		= BIT(HK_TYPE_WQ),
> +	HK_FLAG_KTHREAD		= BIT(HK_TYPE_KTHREAD),
>   };
>   
> +#define HK_FLAG_KERNEL_NOISE (HK_FLAG_TICK | HK_FLAG_TIMER | HK_FLAG_RCU | \
> +			      HK_FLAG_MISC | HK_FLAG_WQ | HK_FLAG_KTHREAD)
> +
>   DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
>   EXPORT_SYMBOL_GPL(housekeeping_overridden);
>   
>


