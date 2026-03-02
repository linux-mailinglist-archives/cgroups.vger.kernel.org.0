Return-Path: <cgroups+bounces-14498-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAAzHsmApWl1CgYAu9opvQ
	(envelope-from <cgroups+bounces-14498-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 13:21:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEEF1D8337
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 13:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 803A7301A9EF
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 12:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EDD364E8D;
	Mon,  2 Mar 2026 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXycg0zC"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629A2175A68;
	Mon,  2 Mar 2026 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454084; cv=none; b=dwxT24JR2rrV+6CdThMbkjvjk7fb8l3AyZ31G5yW+0738dyYcWvnhfQz0bCrEW/r1i9vg/gIAwFkpixYn+O1SihPEaLAVwEu94A0D1H1l2FwdB5RyTQdEUiF4PBx/QrAH/rb/IyD21Lh0D/fjih4DpLqo2MT0sPXO0n/MF4lT8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454084; c=relaxed/simple;
	bh=6OHryd9aMmtqt85R5t3r4HkSb91gK91j29WTF/588S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIf87Zu6MR/E4oYvLkiKprN5BqRY8w4h4EEqpP+8Na0kriWryRCh56S4UH/kNiYrMSyeGQO6FpkuiNtcSSZ1AqnBZoP93ej105Aw4hDbzJh40fHi2toftrYB59sseSXCo5LrkVW244wWyPCwzttJndVGfXGX57R6rAz02JpCjYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXycg0zC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0553C2BC87;
	Mon,  2 Mar 2026 12:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772454084;
	bh=6OHryd9aMmtqt85R5t3r4HkSb91gK91j29WTF/588S4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UXycg0zCWjtBDSRGwhdJDl/pf/0tkLTlvLd/YU8lQk3cSvdYFy7LMdKe68rA5m2s7
	 mYTz+Zx+tY0iJ+hR844FHONJJhejkftPASUpO/4SLZ8TyRttEfOGHvWrCtBKnOPs4n
	 gnCH5EsGayg2bY2oT5E5hUiJDsr29qqF/zAdrSTTSnBhk09+cumN+S0EPdL83z0XFZ
	 jqSSQO5Tggw4M0rAarDiRibgboIfbuENylZiNBiEsBrNrVB0H0tDQmhuCiIcNLLA5c
	 6NmUaQJy+a3m57Htt9mN6sUjjw4fTVXD6GsV+UHLuXh7gM5TvL9AVBS4pdZWJ6gTHL
	 g3Qc7LtrVrh+g==
Date: Mon, 2 Mar 2026 13:21:21 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 0/8] cgroup/cpuset: Fix partition related locking
 issues
Message-ID: <aaWAwYbuJHoG6ItW@lothringen>
References: <20260221185418.29319-1-longman@redhat.com>
 <9cc7401e7137e27cd2f02625aab23330@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cc7401e7137e27cd2f02625aab23330@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14498-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5BEEF1D8337
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 10:57:24AM -1000, Tejun Heo wrote:
> Hello,
> 
> > Waiman Long (8):
> >   cgroup/cpuset: Fix incorrect change to effective_xcpus in partition_xcpus_del()
> >   cgroup/cpuset: Fix incorrect use of cpuset_update_tasks_cpumask() in update_cpumasks_hier()
> >   cgroup/cpuset: Clarify exclusion rules for cpuset internal variables
> >   cgroup/cpuset: Set isolated_cpus_updating only if isolated_cpus is changed
> >   kselftest/cgroup: Simplify test_cpuset_prs.sh by removing "S+" command
> >   cgroup/cpuset: Move housekeeping_update()/rebuild_sched_domains() together
> >   cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug to workqueue
> >   cgroup/cpuset: Call housekeeping_update() without holding cpus_read_lock
> 
> Applied 1-8 to cgroup/for-7.0-fixes with the following minor fixups:
> 
> - 5/8: Removed a duplicate test entry that resulted from the "S+"
>   removal (two previously-different lines becoming identical).
> 
> - 8/8: Fixed typos in commit message ("essentally" -> "essentially",
>   "beforce" -> "before") and code comment ("top_cpuset_mutex" ->
>   "cpuset_top_mutex").
> 
> This has gone through more than enough iterations. We can resolve further
> issues if there's any incrementally.

We really need to check the fact that the workqueue is not flushed at any
relevant point in hotplug such that:

- offline CPU might now appear in the live topology, quite dangerous.

- CPUs might not be timely (un)isolated when they are expected to.

Thanks.

> 
> Thanks.
> 
> --
> tejun

