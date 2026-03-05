Return-Path: <cgroups+bounces-14672-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLpiFiSLqWl3/AAAu9opvQ
	(envelope-from <cgroups+bounces-14672-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 14:54:44 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2B6212D65
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 14:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E31A30314C1
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 13:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6537F3A5E73;
	Thu,  5 Mar 2026 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxzSw4Qz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291DD3793AF;
	Thu,  5 Mar 2026 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772718867; cv=none; b=Lcg3LJ+5lCSdiF8w+03Z2e1l01idKe/9nyd4VOVTpaJKC0GzAZii6tuslQdYa8BE6UNoDGbDZBAXdVODYwg9MvU0CAly8cimuYnSXIEssL+P/2mEg4iOpi64bT4ydp37wjmm+dpUaNMYGPmu+AHDAt/sWheoQkGch7dbEXCaLKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772718867; c=relaxed/simple;
	bh=Fx7+iHNtLQjDbqKjz59eFIh4No8kY4RANvdg2ZZSJXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzkA4tZKx+Ho2uHfQ8vHYYOEznczV9qRJv4+1zMYRTZqslacqndRBswF3ePmAxDt6b6fBNq+upFKyupdN7rq/8ct+hoc9Rtmw56pwehkbiBHkCKG0LmqQbDHSJ9V5KXjybfgF9wrPJ6Tp22ylKwDFmnSb0UoAxmSzzuYfjWfIm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxzSw4Qz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EEDC19423;
	Thu,  5 Mar 2026 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772718866;
	bh=Fx7+iHNtLQjDbqKjz59eFIh4No8kY4RANvdg2ZZSJXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SxzSw4QzrVDLRtERJx2EAO/mrjnK6Ymp/AFDvabXz5Q1G9y48jfQq1N8l732ck5y+
	 7/CncmtUtLQ6zsRpINu/7mQPrxcZGu9nA/GmGfChz8KTZk6xBSzIM5o0t7Y5HoZWeQ
	 +07LatnSf0hqWLJab7gUWdihrKHw/pqmkKzT0HPQ2fomf61HqMwapuO/7q2rvdw/XY
	 oZOjMhrW+FXyeYim2+tR0elXRbyRitzUJ76mHZNiZ3yh8b0nRfnxYrITfQuzIsYfVd
	 OCZkkA5t/KEyGxmAOkYpQ1V3wI9f89ccY44yVhVpsMn1BehWybyiOPaB8ZtmUmj+kN
	 xzeM+q0xP7f9w==
Date: Thu, 5 Mar 2026 14:54:23 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huawei.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] cgroup/cpuset: Call rebuild_sched_domains() directly in
 hotplug
Message-ID: <aamLD3MizuWIs8_x@localhost.localdomain>
References: <20260304184100.71015-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260304184100.71015-1-longman@redhat.com>
X-Rspamd-Queue-Id: 6A2B6212D65
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14672-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Le Wed, Mar 04, 2026 at 01:41:00PM -0500, Waiman Long a écrit :
> Besides deferring the call to housekeeping_update(), commit 6df415aa46ec
> ("cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug
> to workqueue") also defers the rebuild_sched_domains() call to
> the workqueue. So a new offline CPU may still be in a sched domain
> or new online CPU not showing up in the sched domains for a short
> transition period. That could be a problem in some corner cases and
> can be the cause of a reported test failure[1]. Fix it by calling
> rebuild_sched_domains_cpuslocked() directly in hotplug as before. If
> isolated partition invalidation or recreation is being done, the
> housekeeping_update() call to update the housekeeping cpumasks will
> still be deferred to a workqueue.
> 
> In commit 3bfe47967191 ("cgroup/cpuset: Move
> housekeeping_update()/rebuild_sched_domains() together"),
> housekeeping_update() is called before rebuild_sched_domains() because
> it needs to access the HK_TYPE_DOMAIN housekeeping cpumask. That is now
> changed to use the static HK_TYPE_DOMAIN_BOOT cpumask as HK_TYPE_DOMAIN
> cpumask is now changeable at run time.  As a result, we can move the

But rebuild_sched_domains() will still handle the cpuset isolated partitions
somehow right? Sorry for the question, I'm a bit lost in the
partition_sched_domains() maze...

-- 
Frederic Weisbecker
SUSE Labs

