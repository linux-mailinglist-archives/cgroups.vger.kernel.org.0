Return-Path: <cgroups+bounces-14497-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGn9NSqApWl1CgYAu9opvQ
	(envelope-from <cgroups+bounces-14497-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 13:18:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C0F1D8291
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 13:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61AF53067073
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 12:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81793363C47;
	Mon,  2 Mar 2026 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5H5Fjmk"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43774365A1D;
	Mon,  2 Mar 2026 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772453673; cv=none; b=Ymi/j7/QbQrcGWwa+grn48Rqvphe87iWpPcK3aNj5InlfvFoi1JjRrxL8aItDcAJ/xl4z15X+VBTyJ/tDoWOHPMfXIgEd1kubug8jKxSRHbowsWz1T07tcqpwkO/iZrr+2FoLTBrRcvvHhz5zlkrnUA8I3LVy7QjuY9wiy7Tc+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772453673; c=relaxed/simple;
	bh=x0/PwhweiEjdWZKWPKQkIp8NmvV4qYO7erSRIuoGYME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIfn3rsHcoNEHcLUGI7+Gv/9jHqcdcrDMraZP2qC+xrxoT23u01jrFKjx+FNE/z7LcsxB9lFkHgnivafUzePY87Jy0Tj8oZSIiwFExg1Q5XnMdo1+eOa+1yuJnT8JChjyIu48rrOfq1JEo7iCuF2kuOySgQkNjWYcaZuadK/WYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5H5Fjmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76384C19423;
	Mon,  2 Mar 2026 12:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772453672;
	bh=x0/PwhweiEjdWZKWPKQkIp8NmvV4qYO7erSRIuoGYME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y5H5Fjmkynzui/5szoJYz40jDTKCnFsp4vcDOC+cKT3KHqTfM5rzOgICEbyj/zglY
	 7azFeiGo4a2/7l5KCQROhELl9CpE0wKC0Gzy1hD04rq+xyPKqFKO2h4SuS5+Dwfza3
	 J6+qjFIO03P3TLbrlIVe2xtuZ+Xn0iVkSg6cZemkFtAmD4tSqyx4l02cxiSiyMUUWX
	 xsFxpZUCw1aKxFh7iQxEzlkREZKmk/KoVS83UvOlGbDVMXK6rPyiRdhDDlMzo3V0sD
	 XheRPsmgrWqhekor7f0YZVTTLlssUIxP84v7qqide5PS5fWxpItRjrbuS38l0IMgwZ
	 c2/p0BIzLn5fw==
Date: Mon, 2 Mar 2026 13:14:30 +0100
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
Subject: Re: [PATCH v6 8/8] cgroup/cpuset: Call housekeeping_update() without
 holding cpus_read_lock
Message-ID: <aaV/Jme7NAooNxZQ@lothringen>
References: <20260221185418.29319-1-longman@redhat.com>
 <20260221185418.29319-9-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221185418.29319-9-longman@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14497-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85C0F1D8291
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 01:54:18PM -0500, Waiman Long wrote:
> The current cpuset partition code is able to dynamically update
> the sched domains of a running system and the corresponding
> HK_TYPE_DOMAIN housekeeping cpumask to perform what is essentally the
> "isolcpus=domain,..." boot command line feature at run time.
> 
> The housekeeping cpumask update requires flushing a number of different
> workqueues which may not be safe with cpus_read_lock() held as the
> workqueue flushing code may acquire cpus_read_lock() or acquiring locks
> which have locking dependency with cpus_read_lock() down the chain. Below
> is an example of such circular locking problem.
> 
>   ======================================================
>   WARNING: possible circular locking dependency detected
>   6.18.0-test+ #2 Tainted: G S
>   ------------------------------------------------------
>   test_cpuset_prs/10971 is trying to acquire lock:
>   ffff888112ba4958 ((wq_completion)sync_wq){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x7a/0x180
> 
>   but task is already holding lock:
>   ffffffffae47f450 (cpuset_mutex){+.+.}-{4:4}, at: cpuset_partition_write+0x85/0x130
> 
>   which lock already depends on the new lock.
> 
>   the existing dependency chain (in reverse order) is:
>   -> #4 (cpuset_mutex){+.+.}-{4:4}:
>   -> #3 (cpu_hotplug_lock){++++}-{0:0}:
>   -> #2 (rtnl_mutex){+.+.}-{4:4}:
>   -> #1 ((work_completion)(&arg.work)){+.+.}-{0:0}:
>   -> #0 ((wq_completion)sync_wq){+.+.}-{0:0}:
> 
>   Chain exists of:
>     (wq_completion)sync_wq --> cpu_hotplug_lock --> cpuset_mutex

Which workqueue is involved here that holds rtnl_mutex?
Is this an existing problem or added test code?

Thanks.

