Return-Path: <cgroups+bounces-10593-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF825BC2C9D
	for <lists+cgroups@lfdr.de>; Tue, 07 Oct 2025 23:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4CCD19A1B0A
	for <lists+cgroups@lfdr.de>; Tue,  7 Oct 2025 21:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64F8257829;
	Tue,  7 Oct 2025 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HO+GjigU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410F11C27;
	Tue,  7 Oct 2025 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873697; cv=none; b=gAlVYwJWe7yD5wuWNnTlF++pWXhQW/kCL7juT9QMNDVhkBqPCM7Hp9NzsGUsbW/2hzN/swZ5tBqKGWxKTd20wQlq2yvyVvx1BMB2K4YmGpHEsVJoeDUdA/EDxXe+qTpwOexdHurgQDZyXXi0+OdfdCzcQKbQGEUhtqVT4d2oEb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873697; c=relaxed/simple;
	bh=5Ig+av4i4SKHSui0i5lVRlHtwzs39uFpEM4GQ8HVxDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0iV/fuLODAmKzSi9qqcAK3mhjyldRcuISCoP59w1xIhucM9H3nC2zHAg9p0u94sbcY0UZew3zLOWAv5qY5A6hpebjLLiblWZHZql7KICKTdbPG7l+PjP6OAQPqQNCmCjwpnERw4jpxiyYklZ90sXFkc3xKoHABZtnqUSwqQW7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HO+GjigU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EBCC4CEF1;
	Tue,  7 Oct 2025 21:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759873696;
	bh=5Ig+av4i4SKHSui0i5lVRlHtwzs39uFpEM4GQ8HVxDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HO+GjigUTr6Sx2ixGx7Gp819k1SjA0hVt1j2AembZIhonpfLEeBkeUGdQ/fJbwKYr
	 s/zBdmV97xxrQi3S4nsi3TZBmhC1T+dzwaNQ5ccJCOJ3e4SyIGeASOir5s9PcgBggt
	 ufOhuCvRT0/oF67NamvJ+5cNDf64Mej35qhYprVh2w2Xy1KrfuNFHXYCp3+q43N+Va
	 OTG78C1oXt9qGBYlWygsarVaqxEDhvM+z0xqV/plCEFFoO2H/WV8E1MjT0G/k0Rgx6
	 l+wMhIAa/S8ML1TOuL0f+ZLsoAB6PFwsyMNgELUJy3PmNqmcGso9a8e0GQBMHn+giO
	 6YY1XqOEn37Vg==
Date: Tue, 7 Oct 2025 11:48:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 0/3] sched/ext: Cleanup pick_task_scx()
Message-ID: <aOWKn6f0OtegV1q0@slm.duckdns.org>
References: <20251006104652.630431579@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006104652.630431579@infradead.org>

On Mon, Oct 06, 2025 at 12:46:52PM +0200, Peter Zijlstra wrote:
> Hi,
> 
> So I had a poke at 'give @rf to pick_task() and fold balance_scx() into
> pick_task_scx()' option to see how terrible it was. Turns out, not terrible at
> all.
> 
> I've ran the sched_ext selftest and stress-ng --race-sched 0 thing with various
> scx_* thingies on.

This is great. I was thinking that I needed to call pick_task() of other
classes to detect the retry conditions but yeah enqueue() must be the
triggering event and this is way neater. Does this mean that balance() can
be dropped from other classes too?

For the whole series:

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

