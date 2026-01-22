Return-Path: <cgroups+bounces-13360-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMMNJRT3cWmvZwAAu9opvQ
	(envelope-from <cgroups+bounces-13360-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 11:08:20 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4665D65021
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 11:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B61262C189
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 09:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A31364EB9;
	Thu, 22 Jan 2026 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyxzfZGL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF7A318EE3;
	Thu, 22 Jan 2026 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769075800; cv=none; b=N8VBB/9Fx7LyAvlLNzlL0+YlgozB715tlvvtMzy5T3CvKIhIGTLIgItYz/RDBlJi/BJAzq6nmQntYed+bQsB3RSk+s8hYzgGaQ6QzoIp+8y3F6aygIvJxVS6XliSnApwvbeEwKLQonVzyMmL/C1gVWhWXE89bVvro4toIlagaM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769075800; c=relaxed/simple;
	bh=dcxoVFz6LVoWrvVHVZ3y55Q4k5TKYzriByuTAgV3hWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/SKv0cOMFAWBxvHiZuzzu6R4F9fi0hpvihkDZLlEsudkWNcRcoSNibRIqjU6Zb6YeoiU6iqwbo3bR0XYhGV+833SeD43w6eXMSlw0goyfpwChQH47oH/CyPKHzZXliPFpwpb2NiSTx7Tc/k7VlUtYdVOK+nNKGH2jMbUBNS32w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyxzfZGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C295C116C6;
	Thu, 22 Jan 2026 09:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769075799;
	bh=dcxoVFz6LVoWrvVHVZ3y55Q4k5TKYzriByuTAgV3hWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyxzfZGLcbvHXsYMNZmY0TclxVsCDges/uNr7rTIWjU7dEvvZWpe3y8gLjHiYPb4P
	 gQ8LoHdGdjymvWkmBREjtD/TG+AEf+cNOi5i4o70izpt1KJpjylatpowbVYkbk7pcP
	 CYG9UP7rOsgwnKAYwORRJM/imqq2YlfQqXjjGRf+llG3fqyyNKe9qA6NTgQgEwPWK+
	 4+DoR3K0+SIxnm4RP+gCIp20fsGJqFTdW3y9d/2ZeCn3W21XRuLsQe7Cps94/KFLsY
	 n7FdKC9l8vf+Jalgv6nJj7/fkB0Dp2sCnCpXPIvgQZsI0TX7LhQzCf/hGB0UgxDjcv
	 PJXfg+UrhfKbw==
Date: Thu, 22 Jan 2026 09:56:29 +0000
From: Will Deacon <will@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 29/33] sched/arm64: Move fallback task cpumask to
 HK_TYPE_DOMAIN
Message-ID: <aXH0TZU7UNowTmwc@willie-the-truck>
References: <20260101221359.22298-1-frederic@kernel.org>
 <20260101221359.22298-30-frederic@kernel.org>
 <aW-cAlJCtI5Qtify@willie-the-truck>
 <aXEHf5nbZMI8LT4b@localhost.localdomain>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXEHf5nbZMI8LT4b@localhost.localdomain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13360-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,linux-foundation.org,google.com,arm.com,huawei.com,kernel.org,davemloft.net,redhat.com,linuxfoundation.org,kernel.dk,cmpxchg.org,gmail.com,linux.dev,infradead.org,linutronix.de,suse.cz,lists.infradead.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[will@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 4665D65021
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 06:06:07PM +0100, Frederic Weisbecker wrote:
> Le Tue, Jan 20, 2026 at 03:15:14PM +0000, Will Deacon a écrit :
> > Hi Frederic,
> > 
> > On Thu, Jan 01, 2026 at 11:13:54PM +0100, Frederic Weisbecker wrote:
> > > When none of the allowed CPUs of a task are online, it gets migrated
> > > to the fallback cpumask which is all the non nohz_full CPUs.
> > > 
> > > However just like nohz_full CPUs, domain isolated CPUs don't want to be
> > > disturbed by tasks that have lost their CPU affinities.
> > > 
> > > And since nohz_full rely on domain isolation to work correctly, the
> > > housekeeping mask of domain isolated CPUs should always be a superset of
> > > the housekeeping mask of nohz_full CPUs (there can be CPUs that are
> > > domain isolated but not nohz_full, OTOH there shouldn't be nohz_full
> > > CPUs that are not domain isolated):
> > > 
> > > 	HK_TYPE_DOMAIN | HK_TYPE_KERNEL_NOISE == HK_TYPE_DOMAIN
> > > 
> > > Therefore use HK_TYPE_DOMAIN as the appropriate fallback target for
> > > tasks and since this cpumask can be modified at runtime, make sure
> > > that 32 bits support CPUs on ARM64 mismatched systems are not isolated
> > > by cpusets.
> > > 
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > Reviewed-by: Waiman Long <longman@redhat.com>
> > > ---
> > >  arch/arm64/kernel/cpufeature.c | 18 +++++++++++++++---
> > >  include/linux/cpu.h            |  4 ++++
> > >  kernel/cgroup/cpuset.c         | 17 ++++++++++++++---
> > >  3 files changed, 33 insertions(+), 6 deletions(-)
> > 
> > tbh, I'd also be fine just saying that isolation isn't reliable on these
> > systems and then you don't need to add the extra arch hook.
> 
> Hmm, I think I heard about nohz_full usage on arm64 but I'm not sure.
> And I usually expect isolcpus or cpuset isolated partitions to be even
> more broadly used, it's lighter isolation with less constraints.
> 
> Anyway you're probably right that we could remove isolation support here
> but I don't want to break any existing user.

fwiw, I think it's only some Android markets using the mismatched 32-bit
support and we're definitely not using nohz_full there.

Will

