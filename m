Return-Path: <cgroups+bounces-13754-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCPoOodrhmnwMwQAu9opvQ
	(envelope-from <cgroups+bounces-13754-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 23:30:31 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4DD103CFE
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 23:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 215BE3019D0B
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 22:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2CE30C371;
	Fri,  6 Feb 2026 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+fawaGG"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6882FE592;
	Fri,  6 Feb 2026 22:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770416936; cv=none; b=ordO3lJWaWAQ2TG863IgNVHDcLqMik+kWb+4lAaOOR9sWX0bS/sniM2wbZfy8RuPiytUZirbyh71kvMrvfB6lV0Fq/VKEnl2vUIQldOflfM9BfAccharTUAaygEMFLopjxQcIOYmA1DkP57uQtq9wY6tMejNrZWcseE6mhOM8o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770416936; c=relaxed/simple;
	bh=rdLqwh1d0Cjcb0ou2UWhCKOuEt9xEUXrTNcdzePa7ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip719gQQQ0N76yY8nVdUPZGjqMECqgGK3qDjyRFhq+yYMbm0A+QZfz4nibL+dCogpJcCXWgyhhvae8+9+Hv7VPTevGm1nN2cBal0UOzd2BJs9j+GFMtPGxhhiJNbkSru/IRyv2W1W3DYPnlkaVMFtYcC2NkL1fEJScF1oUa3Z2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+fawaGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53B5C116C6;
	Fri,  6 Feb 2026 22:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770416936;
	bh=rdLqwh1d0Cjcb0ou2UWhCKOuEt9xEUXrTNcdzePa7ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+fawaGGwC+iH4a6HZt60i/wY3XrZ9RQeoNfcJFbsCgyXfJf+Oua+0sj2hVijifxa
	 vaCCM4MeAKeTIo8fopvJEADSUvjeaUcoA3irW7m/OelMR+idvYkrXYrxoFCZgm79LF
	 eLXp3fHZZybK88GJsKD7gwTX8H59rPCNIYB2SzlTOlCFJ+e55jfzfTWH5DHWZMifrf
	 PhaEekHirs6u+whJQwcfanuu65IuqCD1eaqqT24apcwM9cRSFb3L6BRU8v+dhyZ1e+
	 cPs5g9Db/idnWmrVi6Hq9i7NS1duoJ2JVxOBtOoXffKhCz7OxlB+OvpCE9ssdrQvrA
	 647266cwyxoQg==
Date: Fri, 6 Feb 2026 23:28:53 +0100
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
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH/for-next v4 2/4] cgroup/cpuset: Defer
 housekeeping_update() calls from CPU hotplug to workqueue
Message-ID: <aYZrJaIIbTX4E-nO@pavilion.home>
References: <20260206203712.1989610-1-longman@redhat.com>
 <20260206203712.1989610-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206203712.1989610-3-longman@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13754-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	SURBL_MULTI_FAIL(0.00)[pavilion.home:query timed out];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pavilion.home:mid]
X-Rspamd-Queue-Id: 4C4DD103CFE
X-Rspamd-Action: no action

Le Fri, Feb 06, 2026 at 03:37:10PM -0500, Waiman Long a écrit :
> The update_isolation_cpumasks() function can be called either directly
> from regular cpuset control file write with cpuset_full_lock() called
> or via the CPU hotplug path with cpus_write_lock and cpuset_mutex held.
> 
> As we are going to enable dynamic update to the nozh_full housekeeping
> cpumask (HK_TYPE_KERNEL_NOISE) soon with the help of CPU hotplug,
> allowing the CPU hotplug path to call into housekeeping_update() directly
> from update_isolation_cpumasks() will likely cause deadlock. So we

Why do we need to call housekeeping_update() from hotplug? I would
expect it to be called only when cpuset control file are written since
housekeeping cpumask don't deal with online CPUs but with possible
CPUs.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

