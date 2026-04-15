Return-Path: <cgroups+bounces-15307-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHT6Bhlh32k0SQAAu9opvQ
	(envelope-from <cgroups+bounces-15307-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 11:57:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB85402FC6
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 11:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED7EC3043AE4
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 09:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F2D33F390;
	Wed, 15 Apr 2026 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0BiKNWp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF6217704;
	Wed, 15 Apr 2026 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247057; cv=none; b=hW3uvCRDGXdpUhnY7PuB6xjK4zH1uk7Qar7WrJM4HxU/6NBl636IF//xaDlx/FjnQhcWao8YP4nPFQoJDGwaRcPSRR3wlixV4kdvZhOS1tgvYyww9XrMSgeWe+VLcyc30Pwp12V3BgTG1i4LBFw698KXE91MbyxJcWpXqRgP0yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247057; c=relaxed/simple;
	bh=fPenWH6QfvusBtCg4QCwgZJ+BbZLJ1RStl3A1w+9t4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYkukbKon1x4fXqdSPPmIexySzdSP6sYz2h61+yQv9uWMgMSNDXcSvwkDL2yWmzCoHCzaSr/LUaq9yx+U+InhGc8NNKeGks9IoBvQaA/B3FQ+22pdQRZe5s/i+KfXDrse3rVqgIDxT7jrgwOuMJKCuCmjQOLT7GRsVJgdyOE1B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0BiKNWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44FDC19424;
	Wed, 15 Apr 2026 09:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247057;
	bh=fPenWH6QfvusBtCg4QCwgZJ+BbZLJ1RStl3A1w+9t4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0BiKNWpnWLV2d6FuFaeFx+ttM7qFSFSsv/h2mz0KBBk0rmD/kEGJSxeiK+bs+K+c
	 p2ITQDCzJdU66sqqMRhGRlnKDOOkVW/fiRH7CR/faB9kJMF8eScY0j/hfB05koRTlE
	 NylTzG1gS17InNCBSQ/aurFJZB0NT8WzjqfmAFRkF/RgGFkn4MvK1PAaK7kvRa0koW
	 B5IsIRJrzUw64u5u9nf533r8n1IyMTFBIvTQQSKeuZ77sI9AXuqGN5ytjGgJyh/ILG
	 UD5XuZ0zuf0A/BK20SeIdeW3pEmTPyN3iwrPA1HO8ruVFPqqcnoQTcm6iAAZNCWWlx
	 LMDZo65fxlc9g==
Date: Wed, 15 Apr 2026 11:57:34 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 09/12] cgroup/cpuset: Introduce CPUSet-driven dynamic
 housekeeping (DHM)
Message-ID: <ad9hDvLyswZCokDH@localhost.localdomain>
References: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
 <20260413-wujing-dhm-v2-9-06df21caba5d@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413-wujing-dhm-v2-9-06df21caba5d@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15307-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,linux-foundation.org,suse.com,cmpxchg.org,huaweicloud.com,lwn.net,linuxfoundation.org,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CEB85402FC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le Mon, Apr 13, 2026 at 03:43:15PM +0800, Qiliang Yuan a écrit :
> Currently, subsystem housekeeping masks are generally static and can
> only be configured via boot-time parameters (e.g., isolcpus, nohz_full).
> This inflexible approach forces a system reboot whenever an orchestrator
> needs to change workload isolation boundaries.
> 
> This patch introduces CPUSet-driven Dynamic Housekeeping Management (DHM)
> by exposing the `cpuset.housekeeping.cpus` control file on the root cgroup.
> Writing a new cpumask to this file dynamically updates the housekeeping
> masks of all registered subsystems (scheduler, RCU, timers, tick, workqueues,
> and managed IRQs) simultaneously, without restarting the node.

There is already the "isolated" partition type which does scheduler, timers
and workqueues isolation. Shouldn't we extend that to dynamically apply nohz_full
instead of adding a new unrelated file?

I don't know which form that should take. Perhaps reuse the "isolated" partition
but add some sort of parameter to define if we want only domain isolation or
also full isolation (that is nohz_full). Waiman should have a better idea for an
interface here.

> 
> At the cpuset and isolation core level, this change implements:
> 1. `housekeeping_update_all_types(const struct cpumask *new_mask)` API inside
>    `isolation.c` to safely allocate, update, and replace all enabled hk_type
> masks.

HK_TYPE_DOMAIN is handled by "isolated" partitions. What remains to handle
is HK_TYPE_KERNEL_NOISE.

As for managed IRQs this will require more thinking but we should include that
into "full isolation" in the future.

> +int housekeeping_update_all_types(const struct cpumask *new_mask)

Please reuse housekeeping_update().

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

