Return-Path: <cgroups+bounces-13834-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KI+BdFSi2kMUAAAu9opvQ
	(envelope-from <cgroups+bounces-13834-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 16:46:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F089011CB41
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 16:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BC88300612D
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 15:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A743859C8;
	Tue, 10 Feb 2026 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FueB//zt"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB3C385520;
	Tue, 10 Feb 2026 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770738380; cv=none; b=oQNgVsPXbE0b5qzEBHjH3XG0S5cR20kV3VqDwQx4q9X5VjtgthbMS5w6cr1a/nElwS+2FPC2oOB65AnVgdxYe9GgLgKpZMT3bZkUWCNMlxaDZbUBIiF4rhpgGd8hRWjh2K1SlOJR6KKE4ZuZbPTqmdddwtUGoQxOswl0KneFEe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770738380; c=relaxed/simple;
	bh=NiTiGMQnq8FxIMlvWN+dKaXduiyB3rVOetsunhvFK/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0kUUObWHR1d9vVpw8M2zFqORlRpcf98V3x0WsXwUkp0CwkcmdOgCjsQgqkjETN9zGwSAGlnpvJPTpMiKdAEHJyUEHDUntrTW7QIgccEkKai2QsBmvrubaK4eF3gd5meIr4cLVXFsQEKUFp6tIYbwtehjF8MC6K16pQKg5b6K1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FueB//zt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681C9C116C6;
	Tue, 10 Feb 2026 15:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770738379;
	bh=NiTiGMQnq8FxIMlvWN+dKaXduiyB3rVOetsunhvFK/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FueB//ztk96+NTuD9KFYDldT+TRhd4knS+CYy0h/gX8M51yDrFYuDBHjVD0MT+4EU
	 vw+jyw2G7pA5WQpwcsioRV49l4HFGyUsNE/LttraVFuzAyFiXQ2m/sAXBk4LXJUFay
	 v43uEVIRzJQ0xtoHI/7tFo5iKFsW7czgYPBveo6oyETg6gXfq8UUoMFIW+kTVs8Mp4
	 cR5mo99x2FHzFXhSOROUNOcWHykofvcIIfkkCz2MOrNTonM5fQidQ8tdvOnnkH9y2+
	 fjYMBCLz2z1THYK2uH/Tbv4NgRa9ibbPQdX48yc2nd3yBa/PSC4fiqiFxy94JDo3v/
	 afg0SfEH813qw==
Date: Tue, 10 Feb 2026 16:46:16 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH/for-next v4 2/4] cgroup/cpuset: Defer
 housekeeping_update() calls from CPU hotplug to workqueue
Message-ID: <aYtSyCb1EioSuDep@localhost.localdomain>
References: <20260206203712.1989610-1-longman@redhat.com>
 <20260206203712.1989610-3-longman@redhat.com>
 <aYZrJaIIbTX4E-nO@pavilion.home>
 <d1e4b070-9438-4152-847e-ef6ff6aa7820@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1e4b070-9438-4152-847e-ef6ff6aa7820@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13834-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,localhost.localdomain:mid]
X-Rspamd-Queue-Id: F089011CB41
X-Rspamd-Action: no action

Le Sat, Feb 07, 2026 at 09:00:45PM -0500, Waiman Long a écrit :
> On 2/6/26 5:28 PM, Frederic Weisbecker wrote:
> > Le Fri, Feb 06, 2026 at 03:37:10PM -0500, Waiman Long a écrit :
> > > The update_isolation_cpumasks() function can be called either directly
> > > from regular cpuset control file write with cpuset_full_lock() called
> > > or via the CPU hotplug path with cpus_write_lock and cpuset_mutex held.
> > > 
> > > As we are going to enable dynamic update to the nozh_full housekeeping
> > > cpumask (HK_TYPE_KERNEL_NOISE) soon with the help of CPU hotplug,
> > > allowing the CPU hotplug path to call into housekeeping_update() directly
> > > from update_isolation_cpumasks() will likely cause deadlock. So we
> > Why do we need to call housekeeping_update() from hotplug? I would
> > expect it to be called only when cpuset control file are written since
> > housekeeping cpumask don't deal with online CPUs but with possible
> > CPUs.
> 
> It needs to call housekeeping_update() only in the special case where there
> is only one active CPU in an isolated partition and that CPU goes offline.
> In this case, the partition becomes disabled that causes change in the
> isolated CPUs. I know this special case shouldn't happen in real world, but
> I do have test case to test that.

But why is that needed? This isn't changing the mask of domain isolated CPUs.
Only their onlineness. I mean timers, workqueue, kthreads all have their
hotplug callbacks able to deal with that already.

> Theoretically, we can add code to handle this special case to keep this
> offline isolated CPU in a special pool without changing isolated_cpus and
> hence  HK_TYPE_DOMAIN cpumask. In this way, we shouldn't need to call
> housekeeping_update() from CPU hotplug. I will probably do that as CPU
> hotplug will be used when we make HK_TYPE_KERNEL_NOISE cpumask dynamic in
> the near future.

That doesn't look necessary.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

