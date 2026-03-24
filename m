Return-Path: <cgroups+bounces-15020-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +O+wNOxdwml5cAQAu9opvQ
	(envelope-from <cgroups+bounces-15020-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 10:48:28 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5A9305DF3
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 10:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE4333232BA1
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 09:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385783DDDA9;
	Tue, 24 Mar 2026 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNqao/AF"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6643DBD4E;
	Tue, 24 Mar 2026 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345279; cv=none; b=DgL4gSnaljl+/n76Ynd4No5jvF0Utedak5u2FWm95he9tHuqyBJBIakEJsLtPoft0Dl2MQwA1dJQA1EsczX52KjeuB1biTGpEVTmVtZum9LXjHfHCu10gAoSMoMLbHBRPUipqPP5VLE1pNdAviWo7fp5Z12cNfld6OukCrZSELI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345279; c=relaxed/simple;
	bh=pE+yURAtYL8FKradvHGP3SYkosGtSPNw4ZPus6+qwg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gW99mLIBo1eEdgkNJu+dm5x4DTBjB1My7KEHIYQGjRzpaWs/kHLJpmDoVdwJQdr1+FcVdOMCuTQS5vi57faylcnyLTdj7rvosIu8FzN3wGy1ZCxfqOwOgHqEXecwBdCZRNHcr/CpL73mVDZCDOXA29ctBIniKxqRYXog05rxlG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNqao/AF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620FCC19424;
	Tue, 24 Mar 2026 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774345278;
	bh=pE+yURAtYL8FKradvHGP3SYkosGtSPNw4ZPus6+qwg4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rNqao/AF09eK3lY/6K4iIeOwBBeQspWp/PVhq10gbn++lU5vpQ8tcKdPkT7ji90/z
	 evZL1TMPkYLPT6VDkU13CzMdOaKsIBGFdSM1bGePbYMWemMsuqlbJJvcESy7aoHJX6
	 JcrI9V6Q7mYrBxTsjztAIL5j3tCvFbHHnaqwyLCCsTwNA7i+u7mqKb+sV5vo4D4xfV
	 LdAXl41It1kwTwf8pykhJi5n67CnG//4CEcU+nz5eRxwt6HE6zvGgmpRwLIJeI+MmP
	 WDTx4EZaqD0mHdQvbqHLk0ZIm14srIJyZ6WUOz+lWCuSpJ9wwNIams7Iv+pIISPFSo
	 qP40skC59qAXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3AD5CCE0DD1; Tue, 24 Mar 2026 02:41:16 -0700 (PDT)
Date: Tue, 24 Mar 2026 02:41:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, frederic@kernel.org
Subject: Re: [BUG] cgroups/cpusets: Spurious CPU-hotplug failures
Message-ID: <3e48811a-c768-4c7e-a1af-b7091e75bb48@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <049415be-0be8-4e01-bba9-530e302bf655@paulmck-laptop>
 <5f142f48-653d-430b-90a6-400f87c88921@redhat.com>
 <8295a194-8f35-427a-8c02-97f2f648eb70@paulmck-laptop>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8295a194-8f35-427a-8c02-97f2f648eb70@paulmck-laptop>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-15020-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kvm-remote.sh:url]
X-Rspamd-Queue-Id: 3D5A9305DF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 11:43:37AM -0700, Paul E. McKenney wrote:
> On Wed, Mar 18, 2026 at 11:02:16AM -0400, Waiman Long wrote:
> > On 3/18/26 8:53 AM, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > Running rcutorture on v7.0-rc3 results in spurious CPU-hotplug failures,
> > > most frequently on the TREE03 scenario, which suffers about ten such
> > > failures per hundred hours of test time.  Repeat-by is as follows:
> > > 
> > > tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 80 --duration 100h --configs "100*TREE03" --trust-make
> > > 
> > > Though a faster repeat-by instead uses kvm-remote.sh and lots of systems.
> > > 
> > > Bisection converges here:
> > > 
> > > 6df415aa46ec ("cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug to workqueue")
> > > 
> > > Reverting this commit gets rid of the spurious CPU-hotplug failures.
> > > Of course, this also gets rid of some ability to do dynamic nohz_full
> > > processing.
> > > 
> > > Now, the problem might be that the workqueue handler might still be
> > > in flight by the time that rcutorture fired up the next CPU-hotplug
> > > operation, especially given that the TREE03 scenario only waits 200
> > > milliseconds between these operations.  This suggests waiting for this
> > > handler before ending each CPU-hotplug operation.  And the crude patch
> > > below does make the problem go away.
> > > 
> > > This alleged fix is quite heavy-handed, and also fragile in that if
> > > hk_sd_workfn() uses a different workqueue, this breaks.  It might be
> > > better to call into the cgroups/cpusets code and to use flush_work()
> > > to wait only on hk_sd_workfn() and nothing else.  But it seemed best to
> > > keep things trivial to start with.
> > > 
> > > Either way, please consider the patch below to be part of this bug report
> > > rather than a proper fix.
> > > 
> > > Thoughts?
> > > 
> > > 							Thanx, Paul
> > There is a fix commit ca174c705db5 ("cgroup/cpuset: Call
> > rebuild_sched_domains() directly in hotplug") in rc4 that may help. Could
> > you try out the rc4 kernel to see if that can resolve the problem that you
> > have?
> 
> It does, thank you!
> 
> Tested-by: Paul E. McKenney <paulmck@kernel.org>

This did fix the problem, except for PREEMPT_RT kernels (which I have
not yet bisected).  If there is another patch for that configuration,
could you please let me know?

						Thanx, Paul

