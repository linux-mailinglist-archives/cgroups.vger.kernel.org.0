Return-Path: <cgroups+bounces-10665-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F57BD577A
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 19:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16E6D4F8246
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 17:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9082C11D6;
	Mon, 13 Oct 2025 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlpwsaby"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47B5298991;
	Mon, 13 Oct 2025 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760376010; cv=none; b=teq8WUTWJvo9KxuDvIqzFFFJ8FvA9Bl6uvFzyAHoMzfjB76HeF5SHI2/Mfz/X/u4nqYbn/cxrWDr5/tFzMISYxFbk7dmy3FQJJuTsZ6BlG1KVBvR9IN3itTFRnORYsR7Nn2Auk5/8PQI3SzPZs7ZwYRinUmeYB+tnSDvC+/0LTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760376010; c=relaxed/simple;
	bh=zavMlTcbgZfky2yOOnYd0KpinLJb3+M4w6IdqSl67Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tecaUAFm2AqIfqE8Sa6AZRJkXyOwDj+AyiRwQmcDZTbV6YKRS8TywVRIGbuueWCHS05rSlIOkxu+vJCF5e2nOhwAZr+drNKkUTse9t+hbcJB6+Pxj4BK+l2npfjL+pcL5LQGy0IIxETfJ2Ef9VkOIk+j/a6D/v+fjfA3pSCFeUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlpwsaby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE9DC4CEE7;
	Mon, 13 Oct 2025 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760376009;
	bh=zavMlTcbgZfky2yOOnYd0KpinLJb3+M4w6IdqSl67Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dlpwsaby5AyGWjzYnk4+43yGdMmkN7TdUiUdD3ZkHDDpsyo/ggdGjrrsVs80Nww5B
	 LD6m8K42jLnN6ycPAMWB5SDLE+O80MWp+iadbhx8eR0/Baw8LLclu1N+NblmtQ6uVQ
	 E8eoI1lv3kE/rO6582XG+9OjQc+/LGegQz7R177/XZeRscL3VBmdu1/h16qnNTzvp8
	 74LcfdAbVvjxWFw+oQFDENXLGSn2+yU/6BnlBkRITHHE8xzlcQ42UPwiBBYEG4i5ln
	 YIBC45FiSRRctIJ3K3/+vGe4VitEDkQ6BLrAE7xf99rFxwwxJWf6G0Tag9mGzgpOki
	 apStSwOQg6XvQ==
Date: Mon, 13 Oct 2025 07:20:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	mingo@kernel.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [RFC][PATCH 2/3] sched: Add support to pick functions to take rf
Message-ID: <aO00yNQozDw6N6jS@slm.duckdns.org>
References: <20251006104652.630431579@infradead.org>
 <20251006105453.648473106@infradead.org>
 <CAKfTPtCC3QF5DBn0u2zpYgaCWcoP2nXcvyKMf-aGomoH08NPbA@mail.gmail.com>
 <20251008135830.GW4067720@noisy.programming.kicks-ass.net>
 <CAKfTPtDG9Fz8o1TVPe3w2eNA+Smhmq2utSA_c6X4GJJgt_dAJA@mail.gmail.com>
 <aObK2MfxPyFcovwr@slm.duckdns.org>
 <CAKfTPtApJuw=Ad8aX=p3VLvMojyoxVBVRbMG80ADXR-NVL0PTw@mail.gmail.com>
 <20251013110449.GJ4067720@noisy.programming.kicks-ass.net>
 <20251013110911.GF4068168@noisy.programming.kicks-ass.net>
 <CAKfTPtDGsS-+DZEemg6vqbQVV5Xds9TNVnOAOvyeNsw0Kn3Mzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDGsS-+DZEemg6vqbQVV5Xds9TNVnOAOvyeNsw0Kn3Mzw@mail.gmail.com>

On Mon, Oct 13, 2025 at 03:06:33PM +0200, Vincent Guittot wrote:
...
> > And then we have next_active_class() skip fair_sched_class entirely when
> > scx_switch_all().
> 
> Ah yes you're right. fair is not called in case of scx_switched_all()

Yeah, when siwtch_all this isn't an issue at all. In partial mode, the extra
new idle may be noticeable but I don't think many people are using partial
mode, so we can worry about it when it becomes a problem.

Thanks.

-- 
tejun

