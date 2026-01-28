Return-Path: <cgroups+bounces-13488-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPnvIWRLemkp5AEAu9opvQ
	(envelope-from <cgroups+bounces-13488-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 28 Jan 2026 18:46:12 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CF7A71BB
	for <lists+cgroups@lfdr.de>; Wed, 28 Jan 2026 18:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D271D300514B
	for <lists+cgroups@lfdr.de>; Wed, 28 Jan 2026 17:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CF436C590;
	Wed, 28 Jan 2026 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCypkrkN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3E236EA9A;
	Wed, 28 Jan 2026 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622291; cv=none; b=dMuSnSoNkEqgLlGcinuS7IiFCdm9Nmh76Ps+sDQyjiCCYH7AaQhRSYvZ12dKK/g1h13RvEDq70XmEQPOvxejHecLaRyapy9oaquyPs1hXoXD6H4hgPYAQVikOTYDVHW9At0LetW6hh3bBAHalSTrCpo/2KmnmFVUDxqxWDuMZ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622291; c=relaxed/simple;
	bh=XAEjsCGwtolbdxg/r2xllMAPogUhFIwqwIHLHticWCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAhWpxk/6nfTFnRtnvmhEhO2RoJfe2g5nFwzPC7ZdZasOeaCnUpi6rVDq62QmAtZgD7nu19qGW9BMvoP26LrJFb2e2Aw3nos6JeywAX2iO5NB9VLbNaIApseDcK3XAd+4CmXi6RWbP6JKP0y7W/MYSi6jWhgJAlsDyHTLmYioDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCypkrkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602E7C4CEF1;
	Wed, 28 Jan 2026 17:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769622290;
	bh=XAEjsCGwtolbdxg/r2xllMAPogUhFIwqwIHLHticWCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCypkrkNtKKRpFIUWzpxn8ey6pxmqkgMrP0VAcSEdlF9Y5n3AY6W2c8onHq/+ILH0
	 SLBiSdXb+vMkM55rRnZoqqoJNc2mwh+WLmQ40d3vxx14l1Ngq9e7opCxWJ4Bya+p5l
	 6AaMBqAGL90ofu1/BUnH4+uCd98p4lDNE26nyh1XPvy6dNHHPaysvyCcYg+WvvXmEq
	 xDteOmkC5m0X56vCjcN7kpIDcpAovvdD6LVgXSK7rlDb2NIgl5yhbJKhXIc+hOh+Ts
	 6IL9WhaBOTq40gnhrm1xNKD0tGkXhug5LpyST+7jRdEEp7YdRRp578kEjhptH8+wC3
	 BP8b0N5bYVX8Q==
Date: Wed, 28 Jan 2026 07:44:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>,
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
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH/for-next 1/2] cgroup/cpuset: Defer housekeeping_update()
 call from CPU hotplug to task_work
Message-ID: <aXpLEcOFhuGYGPY-@slm.duckdns.org>
References: <20260128044251.1229702-1-longman@redhat.com>
 <20260128044251.1229702-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128044251.1229702-2-longman@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13488-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4CF7A71BB
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 11:42:50PM -0500, Waiman Long wrote:
> +static void isolation_task_work_fn(struct callback_head *cb)
> +{
> +	cpuset_full_lock();
> +	__update_isolation_cpumasks(true);
> +	cpuset_full_lock();
                    ^
                    unlock?

Thanks.

-- 
tejun

