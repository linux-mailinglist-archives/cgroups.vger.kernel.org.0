Return-Path: <cgroups+bounces-15082-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGncITXpxmloQAUAu9opvQ
	(envelope-from <cgroups+bounces-15082-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 21:31:49 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0730234B019
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 21:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9FE830488AC
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 20:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F25329E5C;
	Fri, 27 Mar 2026 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9zoVrsX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F81AAE28;
	Fri, 27 Mar 2026 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642731; cv=none; b=nEO6jWTtJOZBZYcv/hT4ZQe5nLRxg2EpJvgo5KUZxZi1oX4omFff/c7iDMidG5UAolqXNzdOjgFWMARJVSiu1zCkJeHHv9usMO3xyDbiw9oVgnzYVrYg0paQtI7tVgsVyJEQl18k21ByOppOhJ/OvazXuide+qdyca/bH9d1xtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642731; c=relaxed/simple;
	bh=vsPicMVGwJpZlUZ/3JuLlIKPSPjaRx6GOGmg3pQqq2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip63V7pl7MANjh5awj9Xx+Hc+k6UQUVpZiBUttpGVvyAq5LFUxybpAT38jZ/NtHEBA9co7lr3604m04G6sOC/XrUU3ClgjVqL8PBafR1iVYehPuP+7D8bpAhPObeEViuqmWkSP7w8HJ0k8yPCqBsMKgJXfz/fEa5pyD8zG1REEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9zoVrsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762E3C19423;
	Fri, 27 Mar 2026 20:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774642730;
	bh=vsPicMVGwJpZlUZ/3JuLlIKPSPjaRx6GOGmg3pQqq2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9zoVrsXFxtRjl6W91slM8qdYVkxwXFj41kbwUa4CbcE5L0x9/7uWXNI9XWC36PRj
	 e8vSEseIfEwfXDb22LBL2vCF0SYkCe/iHmY5MEr5ZKodILKFPMDQMkPhf0Y5htwSW0
	 8HE/Lb9BxVPINiajNSPxIxj4NSdSQpsHSrCxH0BiREYtyhIR3PPEh0aeZAb0DZFJ1l
	 KppZ8xsG3s0G7J1tWt85ntOg4+6imv4dzVglZY0okpEc+WFuTNS05t6Kknlwhgk+tF
	 gj5jYMU5bdBb9qjg4gh3YeeltmlXPP8Q6OpEzyvkxQzHm4QoCX1jHAYMqIClX31IG+
	 66jJquh5hD3ng==
Date: Fri, 27 Mar 2026 10:18:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bert Karwatzki <spasswolf@web.de>, Michal Koutny <mkoutny@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v3 cgroup/for-7.0-fixes] cgroup: Fix cgroup_drain_dying()
 testing the wrong condition
Message-ID: <acbmKQR9hSGhLBmh@slm.duckdns.org>
References: <68d8881fd985a410c0f619f009334c28@kernel.org>
 <20260325180623.EcyNsp2L@linutronix.de>
 <acR3fYVD_blwD93_@slm.duckdns.org>
 <20260326073511.0rcA5AGb@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326073511.0rcA5AGb@linutronix.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15082-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,web.de,suse.com,cmpxchg.org,intel.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Queue-Id: 0730234B019
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 08:35:11AM +0100, Sebastian Andrzej Siewior wrote:
> @@ -7141,7 +7143,7 @@ void cgroup_task_dead(struct task_struct *task)
>  {
>  	get_task_struct(task);
>  	llist_add(&task->cg_dead_lnode, this_cpu_ptr(&cgrp_dead_tasks));
> -	irq_work_queue(this_cpu_ptr(&cgrp_dead_tasks_iwork));
> +	schedule_delayed_work(this_cpu_ptr(&cgrp_delayed_tasks_iwork), HZ);

Can you try schedule_delayed_work_on(smp_processor_id(), ...)?
schedule_delayed_work() is using a percpu workqueue but the delay timer can
still migrate.

Thanks.

-- 
tejun

