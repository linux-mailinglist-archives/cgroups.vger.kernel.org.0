Return-Path: <cgroups+bounces-14873-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAJDJ2/yumkBdQIAu9opvQ
	(envelope-from <cgroups+bounces-14873-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 19:43:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF162C1823
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 19:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18D893026A6C
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 18:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EBD3E51F7;
	Wed, 18 Mar 2026 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHPMrz9C"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06563D34A8;
	Wed, 18 Mar 2026 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773859420; cv=none; b=NFhLFHZ2lLD1stgPZoXTTa7/+C1bBc/MvS81QFovC2opIoBpRjhpH4tOoVIl8Zk7UVYzJ1dzjHPMLfRFbfHipJvzFHB6C9BVkDU2pSNC8SY37wscPQr+cHJ6AAhGrBLOQonWSOn2GawpOJg7RRR8NHy0KNxOw14t6T6ER8i0low=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773859420; c=relaxed/simple;
	bh=/hgMQEWJrrvcpunCFBkdAjJaDIibrLd/Dc0zBHO2Z+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mf+VF52nSqQpsSoAbAGLL7UOM4fAshghT9ZDETNSCyOu7nn+fQDFpAjtsGro2lZLOhwu49KeVG620JDFAmGdRq3GYzoncJcHwJVYsEpWjp1OFkeoSsbe6NAwzR89ikszvf9hSSqg249qxsGbnlZz586BxPDM/RD5u731Y5FFd/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHPMrz9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1164DC19421;
	Wed, 18 Mar 2026 18:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773859420;
	bh=/hgMQEWJrrvcpunCFBkdAjJaDIibrLd/Dc0zBHO2Z+I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=VHPMrz9CK2utkUsEbB0KbvEMrhdvXo7LyBSTJ16y14hauNwqSp6XdN1cWkReoe5ug
	 bWJdcm7KbMYNlzyysr8Xd2fPwkmQ4UZnK4m8sZyxzL8FCymwlnZUrMtDBYcr99vW9n
	 rMlclmLDJoTzlv2r7O1wu3OkPJ4p6InMKu/+TF22YteY/BZ/o+um5Et6sHDbT1dUT/
	 GKyorAhAOeXDfOqXBkdDBHHTCSEtFlf2N22yiidsSVBLQzeYPr3wbm2Yx7O7L5gjn1
	 Kn85QvHiCbHoTI/Gyiath8F892LKLJgjMzp1VtmR60dRfdq4YyR7MIueaga1FWFu2N
	 cUqkKFumpIedA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C538ACE098B; Wed, 18 Mar 2026 11:43:37 -0700 (PDT)
Date: Wed, 18 Mar 2026 11:43:37 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, frederic@kernel.org
Subject: Re: [BUG] cgroups/cpusets: Spurious CPU-hotplug failures
Message-ID: <8295a194-8f35-427a-8c02-97f2f648eb70@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <049415be-0be8-4e01-bba9-530e302bf655@paulmck-laptop>
 <5f142f48-653d-430b-90a6-400f87c88921@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f142f48-653d-430b-90a6-400f87c88921@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	URIBL_MULTI_FAIL(0.00)[kvm-remote.sh:server fail,sto.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-14873-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulmck@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	HAS_REPLYTO(0.00)[paulmck@kernel.org]
X-Rspamd-Queue-Id: 3EF162C1823
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 11:02:16AM -0400, Waiman Long wrote:
> On 3/18/26 8:53 AM, Paul E. McKenney wrote:
> > Hello!
> > 
> > Running rcutorture on v7.0-rc3 results in spurious CPU-hotplug failures,
> > most frequently on the TREE03 scenario, which suffers about ten such
> > failures per hundred hours of test time.  Repeat-by is as follows:
> > 
> > tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 80 --duration 100h --configs "100*TREE03" --trust-make
> > 
> > Though a faster repeat-by instead uses kvm-remote.sh and lots of systems.
> > 
> > Bisection converges here:
> > 
> > 6df415aa46ec ("cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug to workqueue")
> > 
> > Reverting this commit gets rid of the spurious CPU-hotplug failures.
> > Of course, this also gets rid of some ability to do dynamic nohz_full
> > processing.
> > 
> > Now, the problem might be that the workqueue handler might still be
> > in flight by the time that rcutorture fired up the next CPU-hotplug
> > operation, especially given that the TREE03 scenario only waits 200
> > milliseconds between these operations.  This suggests waiting for this
> > handler before ending each CPU-hotplug operation.  And the crude patch
> > below does make the problem go away.
> > 
> > This alleged fix is quite heavy-handed, and also fragile in that if
> > hk_sd_workfn() uses a different workqueue, this breaks.  It might be
> > better to call into the cgroups/cpusets code and to use flush_work()
> > to wait only on hk_sd_workfn() and nothing else.  But it seemed best to
> > keep things trivial to start with.
> > 
> > Either way, please consider the patch below to be part of this bug report
> > rather than a proper fix.
> > 
> > Thoughts?
> > 
> > 							Thanx, Paul
> There is a fix commit ca174c705db5 ("cgroup/cpuset: Call
> rebuild_sched_domains() directly in hotplug") in rc4 that may help. Could
> you try out the rc4 kernel to see if that can resolve the problem that you
> have?

It does, thank you!

Tested-by: Paul E. McKenney <paulmck@kernel.org>

