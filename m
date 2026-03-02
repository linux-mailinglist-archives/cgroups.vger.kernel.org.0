Return-Path: <cgroups+bounces-14495-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFo7Jot6pWm6CAYAu9opvQ
	(envelope-from <cgroups+bounces-14495-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 12:54:51 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C0C1D7EAE
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 12:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8AF0306FCE8
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 11:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299D63630B3;
	Mon,  2 Mar 2026 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBrDGFKc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF514332916;
	Mon,  2 Mar 2026 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452165; cv=none; b=Sxp20ArSpbBn4hJK7+10QXOZqR+j74DrJ0WLLzeBFIrJwRQ5M4S4HiwtJljWGoorChOfVKK7IS61JRLq+ZcnY0DM4s71MtEROLk3VN0AENnR8kB6MU2X4GKtM82x3DGAV4dz49ghykVVHGZ6mEdU9JaL4EKh7aSqh43ittzuzAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452165; c=relaxed/simple;
	bh=xcb5BTnCTMCmZL1jucKyAANEnR5vxCCMkbX1NRaJmGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5CbspyRHJE93xTqOVB9RMhcSUfWnXtyx5dh2U7+jTELeFRlIJRHq363WoYS/AE9MPQBvvSpB5+H7hxKgbkbD20AnXiRH3g1EdAaYtrnaJx+SBBnNB8ufpkSi/UvMaKRsUwt4O9F8e9mNbJJSPODOXfxkH1UPoJU0EIFSZEfpx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBrDGFKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34474C2BCB0;
	Mon,  2 Mar 2026 11:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772452164;
	bh=xcb5BTnCTMCmZL1jucKyAANEnR5vxCCMkbX1NRaJmGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBrDGFKcvyNLDn/+kqHiOiXMXdEFoeBWzAGpLarQ79tpNMRDoYrqm7y67nOo3WwMo
	 ebIcv0+g9gOPikIV5pIOWJaNk0TpRjq9zwzyvezHaRSBpuM0zdYVbKF65qZY+x53gE
	 qUhjSqE7m8pddoE7Zy0SYOrSmkzVOwJEn7vmTTWHBYjQIhVyqwEy/ENCzG+2FitE4K
	 4QnS5aV9iOWLFQoo0/EpNRWNldMKzEPmlZLudVLrCKdTve5EwFpbypVJi3EPNmLkaT
	 1RQNV2s193UgF6KZqwdL0V9xe/qOth/6vlERlcPS0OjNjLYOkHn+yqtlUy8+lWW8qP
	 wbRMndWgg+Q6Q==
Date: Mon, 2 Mar 2026 12:49:22 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
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
	Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 7/8] cgroup/cpuset: Defer housekeeping_update() calls
 from CPU hotplug to workqueue
Message-ID: <aaV5Qvl4HDFEtFj4@lothringen>
References: <20260221185418.29319-1-longman@redhat.com>
 <20260221185418.29319-8-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221185418.29319-8-longman@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14495-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1C0C1D7EAE
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 01:54:17PM -0500, Waiman Long wrote:
> The cpuset_handle_hotplug() may need to invoke housekeeping_update(),
> for instance, when an isolated partition is invalidated because its
> last active CPU has been put offline.
> 
> As we are going to enable dynamic update to the nozh_full housekeeping
> cpumask (HK_TYPE_KERNEL_NOISE) soon with the help of CPU hotplug,
> allowing the CPU hotplug path to call into housekeeping_update() directly
> from update_isolation_cpumasks() will likely cause deadlock.

It would be nice to describe the deadlock scenario here.

Thanks.

