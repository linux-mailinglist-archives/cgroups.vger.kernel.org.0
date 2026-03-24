Return-Path: <cgroups+bounces-15030-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBygN3vxwmkdnQQAu9opvQ
	(envelope-from <cgroups+bounces-15030-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 21:18:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F8D31C3A0
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 21:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B34A302A682
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 20:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8172348860;
	Tue, 24 Mar 2026 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkQgVL/U"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1D2285CBA;
	Tue, 24 Mar 2026 20:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774383457; cv=none; b=TCKFM7wWNFl6wbN3t4G6kCquPY7lz2btH+2sA8V6lYZTHMDLIkS/nF8/2XEVlBhjXPducel7HMeXLMznHGY1rDmDcOekF4OcOcUOeNHMhEoOS3mlHBiETTNXr2Xgbzp7EnNmAFEosBwQRNn0+LaH7GlRr8zhV8UUErsvvHzGdT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774383457; c=relaxed/simple;
	bh=o31bWbKEeCaT1eN1qlixs1fhz5GfhknepDwwNIKXDIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGNdvcUxV1VvFCVZVCYXbcmcz6mFhBbauN/I2hY8bjgzqBtBg+20desMeBgdI1AYVbqYav9hkNagWXgnYaiLK+z3UiTQXiFMpDJFgnodGjY5mwcJJ6FQ0bjF8LH9vi6IcsNw+SSXyV6ZUygvwh3/7faznqL/xoDghBGp4xMghts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkQgVL/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173C9C19424;
	Tue, 24 Mar 2026 20:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774383457;
	bh=o31bWbKEeCaT1eN1qlixs1fhz5GfhknepDwwNIKXDIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LkQgVL/UfOqvJf3Il1H/cSdJaIh/O7HDk9QnPLALtJLWcLA4yX3RNoWamFd8LvawT
	 UN2D833hjgwxwFQwX8utU4swZdGEDoHT7DSatF42+vOSAYz5roOBL71I0PrrAOMz7p
	 9FyvwAktCCevd7+skDvkvasZkGGk3B0bTMWDnOGjdL3iQeoYwjAPlwwZcnYXxLYEz2
	 TleZ+L1UtVciFltluusSNqm8TtnJqOkTeUFcbz0NUzEtFOq/0ivhYlxpaJwicA/Q5L
	 pge2k8+GuO2OKJlzqFaAM9RcDjrn7gUBJYUph/H3et3ODEw8Nj34YJw0Omc835rNc9
	 Q9JnrE9NGt7iw==
Date: Tue, 24 Mar 2026 10:17:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bert Karwatzki <spasswolf@web.de>, Michal Koutny <mkoutny@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] cgroup: Wait for dying tasks to leave on rmdir
Message-ID: <acLxYGxkgPYRP94e@slm.duckdns.org>
References: <20260323200205.1063629-1-tj@kernel.org>
 <20260324090402.k7NkNcEp@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324090402.k7NkNcEp@linutronix.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,web.de,suse.com,cmpxchg.org,intel.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-15030-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 47F8D31C3A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On Tue, Mar 24, 2026 at 10:04:02AM +0100, Sebastian Andrzej Siewior wrote:
...
> As mentioned in the other email, if I 
> -       irq_work_queue(this_cpu_ptr(&cgrp_dead_tasks_iwork));
> +       schedule_delayed_work(this_cpu_ptr(&cgrp_delayed_tasks_iwork), 1 * HZ);
> 
> then I hung at boot because it rmdir() a cgroup with a task in Z. It
> might suggest a race because systemd might missed a task.
> But this fixes the other issue so.

Just did 100 boot test w/ 1s delay added as above but the problem didn't
reproduce. Can't reproduce with cgroup create / populate / depopulate /
rmdir stress tests either. I did hit 1s delay propagating through but that
wasn't a dead lock. The code is not great. It'd be better to just keep
css_set_lock held while iterating too.

I'll apply this for now. Can you please try to reproduce the problem with
the patches applied? How reliably does it reproduce? How is it stuck? Are
tasks waiting on the waitq indefinitely with populated stuck at 1?

Thanks.

-- 
tejun

