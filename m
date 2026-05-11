Return-Path: <cgroups+bounces-15775-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LXdAFEfAmocoAEAu9opvQ
	(envelope-from <cgroups+bounces-15775-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:26:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC1051462B
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2E783038A54
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 18:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF8647AF6E;
	Mon, 11 May 2026 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2uLs3iJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C347AF57;
	Mon, 11 May 2026 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523318; cv=none; b=cocbvvWFQKQyLjzbtM5WoMeSGSSb+EHGPQY9GiWz3uJEKeNKXBHO3GidwKP7XUDXvdmoEtd9dmfVCNg28UxxP4ikLBi5BYdogMwq8kfZ2kGZC7WdEPtvrJc86bOvqxtJd3yk/5NNMFtMD6jUjB29/7WgJVxP+bnfJtTDxPZ3oA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523318; c=relaxed/simple;
	bh=alef+4cDl9DUVytr7Ik0sUxOdVcXNDM2M978SNtXdaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aA8X198dVlkx21a10ttIhNgUR7YPSJU9sUQX+b0UDdB3Hmf7Sfl7N6oV3yM6xuDZx9+GZF29oMrQvr/Kgi8xOKHR8zbpZofWmquEl3E77JXora04xitTA+jThOT1+OAe4jtIzdqs/HVAvMZ7eQpZ9+JuBPymg7NOgVpo2EFXMT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2uLs3iJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56522C2BCB0;
	Mon, 11 May 2026 18:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778523318;
	bh=alef+4cDl9DUVytr7Ik0sUxOdVcXNDM2M978SNtXdaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2uLs3iJih9nf3IJxqQvR2BXhg+GLm2e89Z4D0JYyFa7K2cHFHjriI9J054H88nvE
	 KvZtg7R+krTXWhe+mIAjPWfmB1k89OTGvf3ebjHxbj9/Bg/isbd54rxxtBe5Z+CNf3
	 Jf+LcCegfXypsKiZk+N4M8E6s2/UYQPpop4QwO5Bh3dvYAuAGLIh4GZnVi//1DKsfs
	 0MjMM0kQ/uk8nOz8+yW4C1bNoBXr9ciO45NwbcsTI55QMBVZkKECgoCak3LTpwyuIH
	 aEItcdrx/Vos+m1yZiObSD1RZLctwvAXGvy5HGLfAMNg9MU+5p2R97P7s3wUpdY5jj
	 ZyWyTEVRzmSYA==
Date: Mon, 11 May 2026 08:15:17 -1000
From: Tejun Heo <tj@kernel.org>
To: luca abeni <luca.abeni@santannapisa.it>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Yuri Andriaccio <yurand2000@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v5 20/29] sched/deadline: Allow deeper hierarchies of
 RT cgroups
Message-ID: <agIctRy2OmSMlzyO@slm.duckdns.org>
References: <20260430213835.62217-1-yurand2000@gmail.com>
 <20260430213835.62217-21-yurand2000@gmail.com>
 <20260505151523.GF3102624@noisy.programming.kicks-ass.net>
 <afpLir8tD0Ycb3D8@slm.duckdns.org>
 <20260507105331.GQ1026330@noisy.programming.kicks-ass.net>
 <20260511114004.0fd8d54c@luca64>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511114004.0fd8d54c@luca64>
X-Rspamd-Queue-Id: 5CC1051462B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15775-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,redhat.com,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,santannapisa.it,cmpxchg.org,suse.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 11:40:04AM +0200, luca abeni wrote:
> We are discussing this issue with Yuri, and we have a doubt: if we
> disable the RT-CPU controller for a cgroup, would it be possible to
> enable it for its children?
> (In other words: if we want the RT-CPU controller to be enabled for
> some "leaf" cgroups, we need to enable it for their parents, right?)

Yeah, a cgroup has a controller available to it iff its parent enables that
controller, so all ancestors would have to enable it.

Thanks.

-- 
tejun

