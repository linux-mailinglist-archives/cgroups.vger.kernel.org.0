Return-Path: <cgroups+bounces-14435-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJyBLRl5oGmMkAQAu9opvQ
	(envelope-from <cgroups+bounces-14435-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 17:47:21 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 326FC1AB07C
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 17:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 434B2322439F
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 16:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0864F332EDD;
	Thu, 26 Feb 2026 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtlIQYQg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148E24C6F09;
	Thu, 26 Feb 2026 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121975; cv=none; b=IU/BR1eMXb+tOGETKWXSAhUXmLhMsxHMTLWsvJJww9Gan4yseUMGfbxkTYytWRmwreUVhyvzm8rOiJbIFOeweszCVh74giWHi/iosdFT/ExMKgoS01ASFFyp9Zgv7P1SJw2pn54arpVedX/BsxtPs5R/EpFfQSRllMF39sbsmNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121975; c=relaxed/simple;
	bh=1oZw4wkdp6K0ajcOcaigBCEKMUzdIuIz8YQeDploA8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EE1KxW9/0lH6Ae7gdqLbWCFwA6clPkPAPJ3c1UkzxTBZl6iNPZ0fbiheoTDI1+l4hSmxEyt+1+bfew955WWwPRh8k4qZ2FiJFICqrPi2lhlC8R/4Q8w7ZZ1pyjQH/y+fLIPpCdbHaQIrJ1PKfvbHyyARrNGodePcCAbpBtH85+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtlIQYQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E09C2BC87;
	Thu, 26 Feb 2026 16:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772121974;
	bh=1oZw4wkdp6K0ajcOcaigBCEKMUzdIuIz8YQeDploA8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtlIQYQgGUNnMW2z6GTuyVLqBQZnhD8QY+NNSSkPqYoghXlbvFwOhaDIKtq+OBbam
	 m35J7f7GPvHGbtNNodBtPEQVPiAp03/2owMzxLz7EwDxPV26OIYlOYDzMqHYRWmXez
	 fqirHJebQKJyHK00oLFmKGlSrd6cqefjM9QC+bFqWREgXGnJ5mD6TedsUy/uXFwBNs
	 Bo5fFFYn5Z1OD+tsvoaNTkR2wAqfrX5MdwE46FbUPKC5XwijTDaHsS0z1a7Hyj90fP
	 rIoMN1UDm6xrYX8ZyE5FpQqeIRnbGxly+n+2osB0U/5u9ibenh+aBBDAIie4f6/QdM
	 B4m5T/7+wJTpw==
Date: Thu, 26 Feb 2026 17:06:11 +0100
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
Message-ID: <aaBvc4ikB1H-WQDd@localhost.localdomain>
References: <20260221185418.29319-1-longman@redhat.com>
 <20260221185418.29319-8-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260221185418.29319-8-longman@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-14435-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,localhost.localdomain:mid]
X-Rspamd-Queue-Id: 326FC1AB07C
X-Rspamd-Action: no action

Le Sat, Feb 21, 2026 at 01:54:17PM -0500, Waiman Long a écrit :
> The cpuset_handle_hotplug() may need to invoke housekeeping_update(),
> for instance, when an isolated partition is invalidated because its
> last active CPU has been put offline.
> 
> As we are going to enable dynamic update to the nozh_full housekeeping
> cpumask (HK_TYPE_KERNEL_NOISE) soon with the help of CPU hotplug,
> allowing the CPU hotplug path to call into housekeeping_update() directly
> from update_isolation_cpumasks() will likely cause deadlock.

I am a bit confused here. Why would CPU hotplug path need to call
update_isolation_cpumasks() -> housekeeping_update() for
HK_TYPE_KERNEL_NOISE?

> So we
> have to defer any call to housekeeping_update() after the CPU hotplug
> operation has finished. This is now done via the workqueue where
> the update_hk_sched_domains() function will be invoked via the
> hk_sd_workfn().
> 
> An concurrent cpuset control file write may have executed the required
> update_hk_sched_domains() function before the work function is called. So
> the work function call may become a no-op when it is invoked.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c                        | 31 ++++++++++++++++---
>  .../selftests/cgroup/test_cpuset_prs.sh       | 11 ++++++-
>  2 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 3d0d18bf182f..2c80bfc30bbc 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1323,6 +1323,16 @@ static void update_hk_sched_domains(void)
>  		rebuild_sched_domains_locked();
>  }
>  
> +/*
> + * Work function to invoke update_hk_sched_domains()
> + */
> +static void hk_sd_workfn(struct work_struct *work)
> +{
> +	cpuset_full_lock();
> +	update_hk_sched_domains();
> +	cpuset_full_unlock();
> +}
> +
>  /**
>   * rm_siblings_excl_cpus - Remove exclusive CPUs that are used by sibling cpusets
>   * @parent: Parent cpuset containing all siblings
> @@ -3795,6 +3805,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>   */
>  static void cpuset_handle_hotplug(void)
>  {
> +	static DECLARE_WORK(hk_sd_work, hk_sd_workfn);
>  	static cpumask_t new_cpus;
>  	static nodemask_t new_mems;
>  	bool cpus_updated, mems_updated;
> @@ -3877,11 +3888,21 @@ static void cpuset_handle_hotplug(void)
>  	}
>  
>  
> -	if (update_housekeeping || force_sd_rebuild) {
> -		mutex_lock(&cpuset_mutex);
> -		update_hk_sched_domains();
> -		mutex_unlock(&cpuset_mutex);
> -	}
> +	/*
> +	 * Queue a work to call housekeeping_update() & rebuild_sched_domains()
> +	 * There will be a slight delay before the HK_TYPE_DOMAIN housekeeping
> +	 * cpumask can correctly reflect what is in isolated_cpus.
> +	 *
> +	 * We rely on WORK_STRUCT_PENDING_BIT to not requeue a work item that
> +	 * is still pending. Before the pending bit is cleared, the work data
> +	 * is copied out and work item dequeued. So it is possible to queue
> +	 * the work again before the hk_sd_workfn() is invoked to process the
> +	 * previously queued work. Since hk_sd_workfn() doesn't use the work
> +	 * item at all, this is not a problem.
> +	 */
> +	if (update_housekeeping || force_sd_rebuild)
> +		queue_work(system_unbound_wq, &hk_sd_work);

Nit about recent wq renames:

s/system_unbound_wq/system_dfl_wq

But what makes sure this work is executed by the end of the hotplug operations?
Is there a risk for a stale hierarchy to be observed when it shouldn't? Or a
stale housekeeping cpumask?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

