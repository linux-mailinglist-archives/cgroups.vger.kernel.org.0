Return-Path: <cgroups+bounces-11540-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD36C2E047
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 21:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45C104E3224
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 20:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CF42BD5B3;
	Mon,  3 Nov 2025 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZymlxjlQ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0770929B8FE;
	Mon,  3 Nov 2025 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762201580; cv=none; b=pVb1uWz/Ob59y5SKOPeafLWp9PNaXiq6cE4MJkarbrA7hvMoA1mNY+Q7TBmHG9zGO9ASRtnWAYFyPbdbTsIRD1ue+cWUcBfKid5gtY1HsTcVTOUX/JWR2pGFN9kvNAXrH/9TPvwZaZ22Qp9ytc/3Kay2FBm6jIqaV8MCX8HtApc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762201580; c=relaxed/simple;
	bh=9rNLLxB6ohBair1L7Kjo08PiKCSslDuNdG2JKUd4MZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVkgO9ikHHrAkyYnY/jWI3mZOm6nK5n57ke7kaoqlSPA4D2r2yiFueKRleLvfJ1SaFTjW2IleyqmLBFlqWrSiJpZXP2Gxfjsfh0NBQsOKFYxwO1Ax6kQyJD7jswbxIsLD4Topo3gh8AKC9svxf6//wcgr6TxmYnaHZI9QPVWQwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZymlxjlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0FDC4CEE7;
	Mon,  3 Nov 2025 20:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762201579;
	bh=9rNLLxB6ohBair1L7Kjo08PiKCSslDuNdG2JKUd4MZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZymlxjlQ57/I3F0vXoSCp0tx/HibV+mFjL2zguENOjrwew5BhUx8qZIu2uFj1KDgp
	 o8B69C+N3lb6SaaIN4Dk3QiwC+ffLFz7/5JlKFu146oY9/S2UX3wnuqfyKX5JQGLev
	 m7HbYftXQEwWAKAybU0Q/kuea5clbleRaVB1v5U8K9m/U3PnRKtLWJc/g3sMk7eMI0
	 jn4aadEKjAaJxMlZvz35quiNez4cadwgWD+DdaLBgEXtbdh6vcAUK13mRJ9ZpROw52
	 kjA99V7Bk+cZHRzVxd7obfLwE666Gsq6fDk7QgIEcP3I9aKp7kpUu/PxrpdQDclZSn
	 3Kzlx3y0eCrjA==
Date: Mon, 3 Nov 2025 10:26:18 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCHSET cgroup/for-6.19] cgroup: Fix task exit ordering
Message-ID: <aQkP6kmxde9ahJQS@slm.duckdns.org>
References: <20251029061918.4179554-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029061918.4179554-1-tj@kernel.org>

On Tue, Oct 28, 2025 at 08:19:14PM -1000, Tejun Heo wrote:
> This series fixes a cgroup task exit ordering issue that is generally
> suboptimal for all cgroup controllers and has caused real breakage for
> sched_ext schedulers.

Peter, I'm planning to apply these patches soon. Please holler if you have
any objections.

Thanks.

-- 
tejun

