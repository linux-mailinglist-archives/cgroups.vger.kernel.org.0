Return-Path: <cgroups+bounces-16044-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CwoBVBkC2rwGwUAu9opvQ
	(envelope-from <cgroups+bounces-16044-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 21:11:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD9F572B05
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 21:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C69FD3018AEA
	for <lists+cgroups@lfdr.de>; Mon, 18 May 2026 19:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59D138F253;
	Mon, 18 May 2026 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeyBBxko"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AD128751B;
	Mon, 18 May 2026 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131464; cv=none; b=r+U/KvguKvkSpnkOJ867dXg0Bdl69WEB5jOlcgDOckIEN93v+khfDwozW21/g/OycfU0Toyv86Mb/EY/PzRG7Ig+s3QAQAqize72tXRB3HCyXkw9Xu4E0Ik2OcPlYNvPCiK16m3u5WKYVz1SozAmT4ALe695WIfzpXxdcuxJT/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131464; c=relaxed/simple;
	bh=DaKpvv4NBKdq16pkfBkFthIIG6wPkFD0dksvuZOQ768=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlznL/m6XfgM07yWwOxXse24/KckvayYcdaZuH1EUCsWLe+0/yUmKX0bQrB4q8t0N4C9gm3LzKXzMCpI0v/kQsXjQzRaA/rr+LK+EQ1kppXq9x01sscGk73Sw8To1ipi+rgi+mutBHkC7LYRBvOcayMGHSLKrqGVkmP+YoI2rZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeyBBxko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68153C2BCB7;
	Mon, 18 May 2026 19:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779131464;
	bh=DaKpvv4NBKdq16pkfBkFthIIG6wPkFD0dksvuZOQ768=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qeyBBxkodj4YmVchLe261kAslO7U6L5Z0O3MXVGJz2VdG2I0GJAAm+BAeKqV/kC3x
	 wb/ODXnk9gtfsMz3qX51CAFFZe+e36ztSCl145SjbvcJPtM6KWyWf20PwWZEz7+70P
	 Ghr5mJPlhY+m9NRbFTTdNhaH9DMuO+4XRJF8HxzNZlPMT+Ww6hHbZnKSrlK8H6kXP9
	 z3T5ujYzZGcZ1aEqlHwpEMhq2tucL/4KAHmcdmgf6pFw54hWgk2+2XZdxz1NMd1ZMs
	 8+v2ttq9SzWACruDq6+gm6J3B/1NdreLHs79+kxueCt2SEI0o4g/wKurHV1xfIojRH
	 D3ilnc9sOwOuA==
Date: Mon, 18 May 2026 09:11:03 -1000
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
Message-ID: <agtkR_kTkMW4Gc5d@slm.duckdns.org>
References: <20260511113104.563854162@infradead.org>
 <agIswZpCxlsQ2Xdk@slm.duckdns.org>
 <20260512081000.GL3102624@noisy.programming.kicks-ass.net>
 <agN1QbsjFv2aXFhK@slm.duckdns.org>
 <20260518071456.GO3102624@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518071456.GO3102624@noisy.programming.kicks-ass.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16044-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 6AD9F572B05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello, Peter.

On Mon, May 18, 2026 at 09:14:56AM +0200, Peter Zijlstra wrote:
...
> So the current scheme will inflate the part of A to be double the weight
> (of B), giving them 2 out of 3 parts on the contended CPUs, but then B
> will still get complete / uncontested access to those extra 128 CPUs,
> resulting in a 2:4 weight distribution.
> 
> Which also isn't as straight forward as one might think.

Right, the current behavior isn't quite what people would expect intuitively
either.

...
> So for the one contended CPU A gets 256 out of 257 parts, while B gets
> the full CPU for the remaining 255 CPUs, for a:
> 
>   256    1        257
>   --- : --- + 255*--- = 256:65535 ~ 1:256
>   257   257       257
> 
> distribution. While with the new scheme it would be:
> 
>  1   1       2
>  - : - + 255*- = 1:511
>  2   2       2
> 
> Which, realistically isn't all that different, except the old scheme has
> this really large weight to deal with.
> 
> So from where I'm sitting, yes different, but it behaves better.

I see. Thread cardinality and affinity problems make weight based
distribution such a pain. I wonder whether this can be better solved by
turning it into a two-layer allocation problem - groups to CPUs and then
timeshare on CPUs as necessary. That comes with a lot of its own problems
but it can, aspirationally at least, approximate global weight distribution
and would have better locality properties.

Thanks.

-- 
tejun

