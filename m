Return-Path: <cgroups+bounces-15299-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIq0HOuv3mlmHQAAu9opvQ
	(envelope-from <cgroups+bounces-15299-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 23:21:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1125D3FE954
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 23:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 284E53023ED3
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 21:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B82224AF7;
	Tue, 14 Apr 2026 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQorEc5E"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C4226A0B9;
	Tue, 14 Apr 2026 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776201701; cv=none; b=VYrqmpi5fUrgE/BBPVBidQ0Ht3igwERoIz9hlE4JDa4cyTLfpZ1hWb8XUK3Dbe9Z/tVlS2r/P9oluM2RBpWWm9L9wSjX5wQPA3TLsi7ZQrgGE2H5p1p1BwOZiq+EiZVDxoarMMrTlLAwSZ7lTbK2wH/wRZ1FeYJ+Dd8Hz3Eg484=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776201701; c=relaxed/simple;
	bh=OIzb9nHz1xFXK9FNEuXArnkzgdjXlnxKKe+O2ZtgjBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aPefGuZaKU+8gl0ire5ubyw0D3zay2HwHoiI/FQso2jhq3YTblmcQngl1LE7Hkliw+L+M9WwBvhG8ex7aZ7WcoIR0Ou1ItRC5aTqicXWhKtobWy3KPwa86V4hLfegPVPUjsKHWiIXGgRM6+Ye2r9xR+7a3JWa75kG/xdOZbFkW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQorEc5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7142CC19425;
	Tue, 14 Apr 2026 21:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776201701;
	bh=OIzb9nHz1xFXK9FNEuXArnkzgdjXlnxKKe+O2ZtgjBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YQorEc5Ep7W6OQlLT8ZrecYbkbyIa/mqJbW2/u4/uEt4ksFOLX7dw0kBgRo0mNnTt
	 qPilrsAf+nRMewxnxzVIi/6Es4/ubmEKGOpgwEz6FS7bBfuidjTrQ5X+nU//MQW0G5
	 C13akshGrRpIcC6dtbJyIVWrIf7rKS/DSyaKkwXpR/Uilv9TFcPM4jpn4PFiDqzNLg
	 5Rs6NFXN21FcghPyfNAnUrNoYd/+cs4g7Oaiaxkqo/1AXsbQB37bPU+QyLddomB5R/
	 DFiBTGuxJpYU64fd60pCaBH4VjKNQemCgj5SrQfOh7HNtiWKhqI38sT2RNnu7XAeiz
	 pmF4Sef0k7F6A==
From: Thomas Gleixner <tglx@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Tejun Heo
 <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil
 Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Waiman Long
 <longman@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>, Michal
 =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
Subject: Re: [PATCH v2 05/12] genirq: Support dynamic migration for managed
 interrupts
In-Reply-To: <20260413-wujing-dhm-v2-5-06df21caba5d@gmail.com>
References: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
 <20260413-wujing-dhm-v2-5-06df21caba5d@gmail.com>
Date: Tue, 14 Apr 2026 23:21:37 +0200
Message-ID: <87zf35dyqm.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15299-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[43];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,efficios.com,linux.dev,linutronix.de,linux-foundation.org,suse.com,cmpxchg.org,huaweicloud.com,lwn.net,linuxfoundation.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1125D3FE954
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13 2026 at 15:43, Qiliang Yuan wrote:
> +	irq_lock_sparse();
> +	for_each_active_irq(irq) {
> +		struct irq_data *irqd;

Please move the declaration into the scope where it is used.

> +		struct irq_desc *desc;
> +
> +		desc = irq_to_desc(irq);
> +		if (!desc)
> +			continue;
> +
> +		scoped_guard(raw_spinlock_irqsave, &desc->lock) {
> +			irqd = irq_desc_get_irq_data(desc);
> +			if (!irqd_affinity_is_managed(irqd) || !desc->action ||
> +			    !irq_data_get_irq_chip(irqd))
> +				continue;

That's a pretty random choice of conditions.

> +			/*
> +			 * Re-apply existing affinity to honor the new
> +			 * housekeeping mask via __irq_set_affinity() logic.
> +			 */
> +			irq_set_affinity_locked(irqd, irq_data_get_affinity_mask(irqd), false);

That's not sufficient. Assume an interrupt was shut down before the
change because there was no online CPU in the affinity mask, but now the
affinity mask changes so there is an online CPU. What starts it up?
Same the other way around.

> +static struct notifier_block irq_housekeeping_nb = {
> +	.notifier_call = irq_housekeeping_reconfigure,
> +};
> +
> +static int __init irq_init_housekeeping_notifier(void)
> +{
> +	housekeeping_register_notifier(&irq_housekeeping_nb);
> +	return 0;
> +}
> +core_initcall(irq_init_housekeeping_notifier);

I fundamentaly despise notifiers especially when they are just invoking
something which is built in.

