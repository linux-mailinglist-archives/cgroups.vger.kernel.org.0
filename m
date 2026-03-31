Return-Path: <cgroups+bounces-15127-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uC18G7aSy2nMJAYAu9opvQ
	(envelope-from <cgroups+bounces-15127-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 11:24:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B776366FE8
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 11:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC126302AB58
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 09:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5563ED5CC;
	Tue, 31 Mar 2026 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWXHPvWT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EE93ED5A2;
	Tue, 31 Mar 2026 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774949013; cv=none; b=EgywzwxfqBrUVN8njvL6ZCKK469yZPfPyA7KdQv0DzOw6jbhzOn9h7MvHO8oTaf2vckgS/NuwuzE8iJq4WvLIjzTdL5ZWf4TRo0bL345P6oniQpOjRTcWgiAOrMdVj3i7YoYeo7EwzujkJ7b7bDpPisoJO8AsuTU07/qCceMhTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774949013; c=relaxed/simple;
	bh=DZoalaXDsEVeM0Ax8G7Y4p1iyVXciubggMHPstxJdjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E53QGCyCQzBNM4HbO3+XgRKQN/HY0Rjy1xSLug4EyFoa/+fdfb17Lt5o3B/m1FEwpAz/sq2h/c/W8CqO81rS5F+XLZpNOIjad8otYrZVn1M98QbsMpOFw1qwpfF3XAh+LH4snNTwibe9cztUlHqISl6Vp8dE+IJSXDIuWnUs3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWXHPvWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B8EC2BCB0;
	Tue, 31 Mar 2026 09:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774949013;
	bh=DZoalaXDsEVeM0Ax8G7Y4p1iyVXciubggMHPstxJdjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VWXHPvWTOsXVqPgKgqy/3aAuIYHbb34PxPrQWaDkov23mCpqJs6NlSRh+dph649hd
	 e+8MWiREWOuaVmDH4IiVTzViJCfMWPn0vRaCHcVLhNyd71rWE+oGzmtHxpndEjfaGJ
	 ib94XthMSGL/K9/f45oGTA0BJ+CZilG4W+CMBVhmEqpWYD7iyt+Z8znthOg9rQQtBi
	 PwBkYAMs0fKRCgPUiACMThrOPBUCtLx+NLZhBExu8TG+DLqi3NZKaTLn2wJN+rsQJ0
	 /oeXzSpdaZsbKUZSOX7GNIEkw6ZnazXlfbZ/+YIHyb+weE4txyZ4HZ6DOrzJi5x33I
	 g1n84rD80/QTA==
Date: Tue, 31 Mar 2026 11:23:30 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: peterz@infradead.org, longman@redhat.com, cgroups@vger.kernel.org,
	akpm@linux-foundation.org, anna-maria@linutronix.de,
	boqun.feng@gmail.com, bsegall@google.com, dietmar.eggemann@arm.com,
	hannes@cmpxchg.org, jackmanb@google.com, jiangshanlai@gmail.com,
	joelagnelf@nvidia.com, josh@joshtriplett.org, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, mathieu.desnoyers@efficios.com, mgorman@suse.de,
	mhocko@suse.com, mingo@kernel.org, mingo@redhat.com,
	neeraj.upadhyay@kernel.org, paulmck@kernel.org,
	qiang.zhang@linux.dev, rcu@vger.kernel.org, rostedt@goodmis.org,
	shuah@kernel.org, surenb@google.com, tglx@kernel.org, tj@kernel.org,
	urezki@gmail.com, vbabka@suse.cz, vincent.guittot@linaro.org,
	vschneid@redhat.com, ziy@nvidia.com
Subject: Re: [PATCH 01/15] sched/isolation: Support dynamic allocation for
 housekeeping masks
Message-ID: <acuSklmoiS6veo-i@pavilion.home>
References: <20260325135707.GZ3738786@noisy.programming.kicks-ass.net>
 <20260330114348.102265-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330114348.102265-1-realwujing@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15127-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,vger.kernel.org,linux-foundation.org,linutronix.de,gmail.com,google.com,arm.com,cmpxchg.org,nvidia.com,joshtriplett.org,kvack.org,efficios.com,suse.de,suse.com,kernel.org,linux.dev,goodmis.org,suse.cz,linaro.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B776366FE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le Mon, Mar 30, 2026 at 07:43:21PM +0800, Qiliang Yuan a écrit :
11;rgb:2e2e/3434/3636> Hi Peter,
> 
> On Wed, Mar 25, 2026 at 02:57:07PM +0100, Peter Zijlstra wrote:
> > I think I asked this a while ago; why do we have more than one mask? 
> > What is the actual purpose of being able to separate RCU from Timers?
> 
> That's a fair point. For the vast majority of use cases (like NOHZ_FULL), 
> these masks are indeed identical and should be updated as a single unit. 
> 
> The original motivation for separation was to allow extreme fine-tuning in 
> HFT environments—for example, offloading RCU callbacks to keep a core 
> mostly clean but allowing pinned timers for specific localized 
> telemetry/monitoring. 
> 
> However, I acknowledge this adds significant complexity. In V13, I will 
> unify these into a single "Global Housekeeping Mask" by default to 
> simplify the configuration space, while keeping the underlying notifier 
> infrastructure flexible enough for future specialized needs.

More precisely we only need four flags:

HK_TYPE_DOMAIN_BOOT (isolcpus=)
HK_TYPE_DOMAIN (cgroup v2 isolated partition + isolcpus=)
HK_TYPE_KERNEL_NOISE (nohz_full=)
HK_TYPE_MANAGED_IRQ (isolcpus=managed_irq)

All the aliases of HK_TYPE_KERNEL_NOISE need to be renamed to
HK_TYPE_KERNEL_NOISE.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

