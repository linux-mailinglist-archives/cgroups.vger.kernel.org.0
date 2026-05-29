Return-Path: <cgroups+bounces-16446-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H4zCmbVGWpmzQgAu9opvQ
	(envelope-from <cgroups+bounces-16446-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:05:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B724160705E
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D876309D409
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 17:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C2E3803FA;
	Fri, 29 May 2026 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxnJEs9W"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D07537DEAB;
	Fri, 29 May 2026 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075531; cv=none; b=PLEbGent0l9OxOnJxZUQGGR/BB0ttk1xjKLd6sLxGBzg2FbVqT2G/jpGDJEx5gZell+c7YyOQbeLA9tqyEU4sTxj+ZuDqYtOCDQdNrukn2XJ6DkqCoYqTLQDK7JoGmCXELyUFV2sKmF83qxVf20myT9x/3fophNsNVhV4fV8xFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075531; c=relaxed/simple;
	bh=lxLoD8PeNTvnBhpRB7y46dO1tyOpwhWtOHw63Hb02EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5xvjAFK2rATFhOOgepIuTVI2cJbJDEldbooOWvvHdD/amM2PcQviYYerprwx43UaL1V+XnNdLx1Ik9il+RzB7JVhl2tgMXwa/V6wKEXz9Ql86zawsQa4hgSNIk/x/vZG0B9yR3dG67Ny1kiND19iP+oakVvKHWle7ZfTeYJzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxnJEs9W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589641F00893;
	Fri, 29 May 2026 17:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780075530;
	bh=cVm7RmdQNRLC3GuTh65VDeCq7neLkdKfw4soiUeBi1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dxnJEs9WVOU/0oWwGSBfbef5WwApKWcDsETFJihYBCXBTVR3RFpIlFKVGilh4wbLy
	 kiFYLV+Q2bjEiL3nE/0fLSJlz12n1PDy1D8TbIBaOVn5cTLaXtyOZcPHAR+onFx8tV
	 pdLmgEQjpXdZVKXKdj5/J0eIfV+kYGzZmO32kP8NUw+hOyZBvFo/PQninFtt5Uajk0
	 vdZInIzNYysKxq8JrywL4U2MWBYjmm6Kt8ITpyGHe9XATDhwBdWlC1WHzbL2wcFLW0
	 XG76lWCnI3R++lh5pdX8UzlwKXPTVxXKOd94K139iAr1XvgGsISYium782FdTk4c+c
	 2HMYx4xAePpuw==
Date: Fri, 29 May 2026 07:25:29 -1000
From: Tejun Heo <tj@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Petr Malat <oss@malat.biz>, Bert Karwatzki <spasswolf@web.de>,
	kernel test robot <oliver.sang@intel.com>,
	Martin Pitt <martin@piware.de>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH 5/5] cgroup: Defer kill_css_finish() in
 cgroup_apply_control_disable()
Message-ID: <ahnMCQuw2K6zA3Hs@slm.duckdns.org>
References: <20260505005121.1230198-1-tj@kernel.org>
 <20260505005121.1230198-6-tj@kernel.org>
 <41cd159c-54e5-45e0-81df-eaf36a6c028e@sirena.org.uk>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41cd159c-54e5-45e0-81df-eaf36a6c028e@sirena.org.uk>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16446-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[cmpxchg.org,suse.com,linutronix.de,malat.biz,web.de,intel.com,piware.de,vger.kernel.org,arm.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B724160705E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello, Mark.

On Wed, May 27, 2026 at 11:45:54AM +0100, Mark Brown wrote:
> On Mon, May 04, 2026 at 02:51:21PM -1000, Tejun Heo wrote:
> 
> > Same race shape as the rmdir path that 93618edf7538 ("cgroup: Defer css
> > percpu_ref kill on rmdir until cgroup is depopulated") fixed: a task past
> > exit_signals() whose cset subsys[ssid] still pins the disabled controller's
> > css can be touching subsys state while ->css_offline() runs. The earlier
> > patches in this series built up the per-subsys-css deferral machinery and
> > routed cgroup_destroy_locked() through it. Apply the same shape to
> > cgroup_apply_control_disable():
> 
> We've been seeing hangs during testing in our testing of -next on
> multiple arm64 platforms when running LTP test jobs which bisect to this
> patch, which is 1dffd95575eb05bc7e in -next.  It looks like we hit a
> deadlock running stress tests, the end of a typical log looks like this:
> 
> <12>[  181.849144] /opt/ltp/kirk[558]: cgroup_fj_stress_blkio_3_3_none: end (returncode: 0)
> <12>[  181.860375] /opt/ltp/kirk[558]: cgroup_fj_stress_blkio_3_3_one: start (command: cgroup_fj_stress.sh blkio 3 3 one)
> cgroup_fj_stress_blkio_3_3_one: pass  (1.166s)
> <12>[  183.053379] /opt/ltp/kirk[558]: cgroup_fj_stress_blkio_3_3_one: end (returncode: 0)
> <12>[  183.064884] /opt/ltp/kirk[558]: cgroup_fj_stress_blkio_4_4_each: start (command: cgroup_fj_stress.sh blkio 4 4 each)
> cgroup_fj_stress_blkio_4_4_each: pass  (8.183s)
> <12>[  191.275815] /opt/ltp/kirk[558]: cgroup_fj_stress_blkio_4_4_each: end (returncode: 0)
> <12>[  191.287614] /opt/ltp/kirk[558]: cgroup_fj_stress_blkio_4_4_none: start (command: cgroup_fj_stress.sh blkio 4 4 none)
> cgroup_fj_stress_blkio_4_4_none: pass  (3.570s)
> <12>[  194.884173] /opt/ltp/kirk[558]: cgroup_fj_stress_blkio_4_4_none: end (returncode: 0)
> <12>[  194.895255] /opt/ltp/kirk[558]: cgroup_fj_stress_cpu_1_200_each: start (command: cgroup_fj_stress.sh cpu 1 200 each)
> 
> with no further output and given that this is a cgroup locking change
> this does seem like a plausible commmit, though I didn't look into it in
> detail.  Bisect log and the list of LTP tests we're running in our test
> job below.  We are running multuple tests in parallel.

Unfortunately, I can't reproduce this in my environment. Any chance you can
try testing on x86 tooa nd see whether it produces there?

Thanks.

-- 
tejun

