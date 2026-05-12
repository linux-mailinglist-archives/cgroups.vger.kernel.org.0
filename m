Return-Path: <cgroups+bounces-15862-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uISVCkh1A2oV6AEAu9opvQ
	(envelope-from <cgroups+bounces-15862-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 20:45:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0212528121
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 20:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C3CD8302D64D
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 18:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9FB274B3B;
	Tue, 12 May 2026 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bL6HBp3x"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E70225B0AB;
	Tue, 12 May 2026 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611522; cv=none; b=n8je8TRy33hInWqzMvxXtCDd9iyW45PiaBIQWbchUr3aBZjoORFl3Qv3c8IwyQvVxIoKW+nreZWw3rkKciOI7++5IWYgEVByHpGMXCUYOfwj2HCFpbxOQktr0YCcMwxdyLbOI1rfpGcV3C5gNXXoaw7WfHYzUBAicGd+5Yzg1+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611522; c=relaxed/simple;
	bh=U5DaUvoLw4VybrMvXDXJrOB1u5VoFuN14ddq/TSaSA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3JsCqHyPF2cP08CkccfueEu1NwkQEy5tdWWwsFL0Xj6MOjZ5jgPPnfEbcjRXq7446LQiejh+ZK/Ay7BICxgLEwVYC6nnWii2UwgNKMGmti/jYgtIr+kFe2GleQSSchV44VbnlGg0neVbyMOx8J0ut7uVkNdAUOMyDXtEk7nYto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bL6HBp3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E44C2BCB0;
	Tue, 12 May 2026 18:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778611522;
	bh=U5DaUvoLw4VybrMvXDXJrOB1u5VoFuN14ddq/TSaSA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bL6HBp3xx1X2PTRImaiQ7dU8MHXCHoWoBn/2OhCtL44isdH7DYpwEj8OMKxqX90aq
	 rkY0JeG1fPqUvrMpHeh4wsvPwGchIltxtGkNP9rDskQHBCfRXodaRe0TWYN+od8qjD
	 l1J3PKKQC2JjeUVBnOrI/NW0+qcdpWXCU19WiNlW/3CSlbjDThGjv7XVfmrDRYCgQ9
	 2iMoNOXTYkO60sSDigeLM7wX5XglpCo19Ff6ktwP+Txre4M9qhcr01sLvr1ffsTHVv
	 FcmEmWHsHlaKQSEDDPEthmCKOwbFggWk6FMDsMqa22pAVeeXcGwBHYi1J+cuNYUy5/
	 hJlKzfV2JZtVQ==
Date: Tue, 12 May 2026 08:45:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com,
	kprateek.nayak@amd.com, qyousef@layalina.io
Subject: Re: [PATCH v2 00/10] sched: Flatten the pick
Message-ID: <agN1QbsjFv2aXFhK@slm.duckdns.org>
References: <20260511113104.563854162@infradead.org>
 <agIswZpCxlsQ2Xdk@slm.duckdns.org>
 <20260512081000.GL3102624@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512081000.GL3102624@noisy.programming.kicks-ass.net>
X-Rspamd-Queue-Id: E0212528121
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15862-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Action: no action

Hello, Peter.

On Tue, May 12, 2026 at 10:10:00AM +0200, Peter Zijlstra wrote:
...
> Anyway, this is why I've been looking at these alternative weight
> schemes, to get the nominal fraction near 1 and make these problems go
> away. It is both the numerical issues and the disparity between levels
> (with root being at level 0 being the most obvious).

I see. I think what bothers me is that I'm unsure what the weight config
would mean when the shares are scaled by the number of active cpus in that
cgroup. Here's a simple example:

- There are 256 cpus.
- /cgroup-A has weight 100 and 128 active threads. No pinning.
- /cgroup-B has weight 100 and 256 active thredas. No pinning.

In the current code, assuming math holds up, cgroup-A and B would get about
the same shares - ~128 CPUs each. However, if we scale the share by active
CPUs in each cgroup, B's tasks would end up with the same weight as A's on
CPUs that they end up competing on, which would lead to ~ 1:3 distribution.
Is that the right reading of the code?

Thanks.

-- 
tejun

