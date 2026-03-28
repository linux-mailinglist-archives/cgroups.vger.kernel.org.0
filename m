Return-Path: <cgroups+bounces-15088-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKU1OaVFyGk9jQUAu9opvQ
	(envelope-from <cgroups+bounces-15088-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 28 Mar 2026 22:18:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 734FB34FFA8
	for <lists+cgroups@lfdr.de>; Sat, 28 Mar 2026 22:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E43B8302444B
	for <lists+cgroups@lfdr.de>; Sat, 28 Mar 2026 21:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949AC345CBC;
	Sat, 28 Mar 2026 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZzzVQBH"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569F832720D;
	Sat, 28 Mar 2026 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774732706; cv=none; b=dpACFh37jqVDKQWeHxFMjjV5VTrMCCtrscCXAH+HiYGPyVDPxL8kq/7N+mULJjAEmZv3Du1prl09cPxYr+iAAmdfhQc43aDHqVkXpHkGJCApXzcUF0e3wmvZe7Qngxg4xs8bGvD5MBE8XBHrHiN8eQCv88VMxmf31LNz0jCVBVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774732706; c=relaxed/simple;
	bh=ngqvyF5QkpfB5rHZje8SSDxOqyZkSuWtDyVLR9Ju37A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSpUD7Bt7Xriikcfj4MxdIvH2vZK7GqyL2gbPTL+Ybx7Y8JbFr2YNlP0MdmVPcsmhU5+k4HmWRfR5zTKvi3ZxjnCQovXMVTBSgX5ovdYXP+aKgIF3GaGyqJJR47yE9rWJP/LLGBbnNYHB4UjA/epPC+sn/XG8qIalxLn3Gz8Zec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZzzVQBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7647C4CEF7;
	Sat, 28 Mar 2026 21:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774732706;
	bh=ngqvyF5QkpfB5rHZje8SSDxOqyZkSuWtDyVLR9Ju37A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=uZzzVQBHFLHqK0tpFPSZPH75MRs5xfT8P5ZKYJM7HApcdr6jXIzVdE3VoBFtc9tks
	 6PuuW4TvlKhcgf0KGdpNxAjwCsnfZcTmMeSqWUV6/vs8FI+jbZczAe/YJs7wbr0UB1
	 cRTttCTnozPAsXUFThO5B33TQv54juhf8jfKnO8QxPvQtftduoi1R5sIaZ40chMPiE
	 K5E+WqNpIdtl1czNCJJ3mIBTEQvf7iNweawQ6XgorS3NXQrPXFzr2MsI86/uBrP7av
	 b2WQumEjLeeCM67MLO1xVmy0uKWUVD1DA8HcR931JQ5TD1uHMY6LC4SHP3eb4i+omi
	 u+XFQsSQU2FdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C2BFBCE08B9; Sat, 28 Mar 2026 14:18:23 -0700 (PDT)
Date: Sat, 28 Mar 2026 14:18:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, frederic@kernel.org
Subject: Re: [BUG] cgroups/cpusets: Spurious CPU-hotplug failures
Message-ID: <976b10cc-47a4-4b6f-af8e-3f5af6378c07@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <049415be-0be8-4e01-bba9-530e302bf655@paulmck-laptop>
 <5f142f48-653d-430b-90a6-400f87c88921@redhat.com>
 <8295a194-8f35-427a-8c02-97f2f648eb70@paulmck-laptop>
 <3e48811a-c768-4c7e-a1af-b7091e75bb48@paulmck-laptop>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e48811a-c768-4c7e-a1af-b7091e75bb48@paulmck-laptop>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-15088-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[paulmck@kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulmck@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kvm-remote.sh:url]
X-Rspamd-Queue-Id: 734FB34FFA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 02:41:16AM -0700, Paul E. McKenney wrote:
> On Wed, Mar 18, 2026 at 11:43:37AM -0700, Paul E. McKenney wrote:
> > On Wed, Mar 18, 2026 at 11:02:16AM -0400, Waiman Long wrote:
> > > On 3/18/26 8:53 AM, Paul E. McKenney wrote:
> > > > Hello!
> > > > 
> > > > Running rcutorture on v7.0-rc3 results in spurious CPU-hotplug failures,
> > > > most frequently on the TREE03 scenario, which suffers about ten such
> > > > failures per hundred hours of test time.  Repeat-by is as follows:
> > > > 
> > > > tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 80 --duration 100h --configs "100*TREE03" --trust-make
> > > > 
> > > > Though a faster repeat-by instead uses kvm-remote.sh and lots of systems.
> > > > 
> > > > Bisection converges here:
> > > > 
> > > > 6df415aa46ec ("cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug to workqueue")
> > > > 
> > > > Reverting this commit gets rid of the spurious CPU-hotplug failures.
> > > > Of course, this also gets rid of some ability to do dynamic nohz_full
> > > > processing.
> > > > 
> > > > Now, the problem might be that the workqueue handler might still be
> > > > in flight by the time that rcutorture fired up the next CPU-hotplug
> > > > operation, especially given that the TREE03 scenario only waits 200
> > > > milliseconds between these operations.  This suggests waiting for this
> > > > handler before ending each CPU-hotplug operation.  And the crude patch
> > > > below does make the problem go away.
> > > > 
> > > > This alleged fix is quite heavy-handed, and also fragile in that if
> > > > hk_sd_workfn() uses a different workqueue, this breaks.  It might be
> > > > better to call into the cgroups/cpusets code and to use flush_work()
> > > > to wait only on hk_sd_workfn() and nothing else.  But it seemed best to
> > > > keep things trivial to start with.
> > > > 
> > > > Either way, please consider the patch below to be part of this bug report
> > > > rather than a proper fix.
> > > > 
> > > > Thoughts?
> > > > 
> > > > 							Thanx, Paul
> > > There is a fix commit ca174c705db5 ("cgroup/cpuset: Call
> > > rebuild_sched_domains() directly in hotplug") in rc4 that may help. Could
> > > you try out the rc4 kernel to see if that can resolve the problem that you
> > > have?
> > 
> > It does, thank you!
> > 
> > Tested-by: Paul E. McKenney <paulmck@kernel.org>
> 
> This did fix the problem, except for PREEMPT_RT kernels (which I have
> not yet bisected).  If there is another patch for that configuration,
> could you please let me know?

And which I am having a hard time reproducing.  :-(

						Thanx, Paul

