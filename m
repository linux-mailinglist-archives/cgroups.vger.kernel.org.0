Return-Path: <cgroups+bounces-13612-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GGtNNMGgWkCDwMAu9opvQ
	(envelope-from <cgroups+bounces-13612-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 21:19:31 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 410A6D102E
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 21:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C99430080B9
	for <lists+cgroups@lfdr.de>; Mon,  2 Feb 2026 20:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF95C2C11E1;
	Mon,  2 Feb 2026 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nh8vcuVe"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61832BE026;
	Mon,  2 Feb 2026 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770063562; cv=none; b=ONM12Xa6yUD0wav7VWBwBzlR8GPhuJHQvo3PRPrrNexeOy8rxL6Vl+2fwk5PBj74TfwB1AwmdagUr/kqEzl6HWQM4M7hjlgERXPsYkUtXHjOmsvqv1kokWV8CbxkMYXsXt+vIO1cbR2Znfyv3P0tq3RScDdvKNMowpNa9VMB7Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770063562; c=relaxed/simple;
	bh=HruQ9iHUrZFhmAU3MajREnnKNajcyxZ1mlkXHUes/n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARlwzqJfo0SYpddj/UkaylBUoMD2whQlUWFooK3t21tADTRkKQK3jfku3veDbxSs5EVHpezCvp54NilbDiHrwj6KNA3KNsookut72wnRlJ/U82qU7+6c97XmugI8dIAbunzLTZFuUyOCwd9UdCTTc3R0vMf8ckntqp3Pb31YYC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nh8vcuVe; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6cWVyTB/hThURF1xMI0QvVgBrlx2yKbPAc5+No9cH2o=; b=nh8vcuVe9jSQbqSl+yt7XFZ80u
	mx+TG/FEolCP7sGgJlWIK38NgHbeG7kn+FzOBoOUWmJnc06oTs9pij2SL2OlUOFrWPEf7jgpZHT0b
	v08b8dV86p90uBNe9t6g9kOzWnE52I5Red176P5O+3CmFKv+Wmx0BSjBm1HfkH78KRkwKIsNeYBfs
	Hs8CrZwOAl1I4R+Rk8s0hZjDTi68yL/t9ADIJEgi046p7rhK8uwjPvqs4la6ZOX6qcaoA8q8BBDel
	h5cO/tQ8tcLG5I27Yc8GNz7L8sZxdq/rPD/61Z6xcAkq7jzFGFbckvYX6ouUsdBJXT025015LEFuB
	vwhr4lnA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn0Nh-0000000F9bY-1tgB;
	Mon, 02 Feb 2026 20:18:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2F1583008E2; Mon, 02 Feb 2026 21:18:44 +0100 (CET)
Date: Mon, 2 Feb 2026 21:18:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH/for-next v3 2/3] cgroup/cpuset: Defer
 housekeeping_update() calls from CPU hotplug to workqueue
Message-ID: <20260202201844.GJ1395266@noisy.programming.kicks-ass.net>
References: <20260202201144.1669260-1-longman@redhat.com>
 <20260202201144.1669260-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202201144.1669260-3-longman@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13612-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Queue-Id: 410A6D102E
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 03:11:43PM -0500, Waiman Long wrote:

> @@ -1310,14 +1321,34 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>   */
>  static void update_isolation_cpumasks(void)
>  {
> -	int ret;
> +	static DECLARE_WORK(isolcpus_work, isolcpus_workfn);
>  
>  	if (!isolated_cpus_updating)
>  		return;
>  
> -	ret = housekeeping_update(isolated_cpus);
> -	WARN_ON_ONCE(ret < 0);
> +	/*
> +	 * This function can be reached either directly from regular cpuset
> +	 * control file write or via CPU hotplug. In the latter case, it is
> +	 * the per-cpu kthread that calls cpuset_handle_hotplug() on behalf
> +	 * of the task that initiates CPU shutdown or bringup.
> +	 *
> +	 * To have better flexibility and prevent the possibility of deadlock
> +	 * when calling from CPU hotplug, we defer the housekeeping_update()
> +	 * call to after the current cpuset critical section has finished.
> +	 * This is done via workqueue.
> +	 */
> +	if (current->flags & PF_KTHREAD) {

		/* Serializes the static isolcpus_workfn. */
		lockdep_assert_held(&cpuset_mutex);

> +		/*
> +		 * We rely on WORK_STRUCT_PENDING_BIT to not requeue a work
> +		 * item that is still pending.
> +		 */
> +		queue_work(system_unbound_wq, &isolcpus_work);
> +		/* Also defer sched domains regeneration to the work function */
> +		force_sd_rebuild = false;
> +		return;
> +	}
>  
> +	WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
>  	isolated_cpus_updating = false;
>  }

