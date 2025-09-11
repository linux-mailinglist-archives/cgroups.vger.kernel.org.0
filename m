Return-Path: <cgroups+bounces-9974-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 335F4B525E6
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 03:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0645C7A74A7
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 01:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9B7202F93;
	Thu, 11 Sep 2025 01:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K91NgVYh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCCB134AC;
	Thu, 11 Sep 2025 01:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555073; cv=none; b=CNXuCzMimcGnL5A8wf9Xp1B2aEc9pfP0HBhs8pzuv8xC1LrQOFyAkBLLEoJdzprHep36PLOHGvvOPAHxF5JRUGUCfiiA7z/1uv+uauC2a/wkPxo9Q0YXeWRUHJiUPiamWRJqzKWT7Dom84BCS5dxxbql+KKrmOsna36RfucA/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555073; c=relaxed/simple;
	bh=7bK8rD4BqHT2+PFrVqYC9jBycy2TYXC0jZgqhWt8nSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Am5F2AAPB+gZ1a3UqH5UO7i26VdPS2IpAY8Y/H610Ann7bDS8qxmy0x16hLlMUkyuVWzU8ZGySM4xmQe7ZWfu5duyoErFroIwGAMiWh9gZvYq7nJ9GwUVs/cv32LZagGwxifPIQoN15UBEn0zkuq964Y31Ex1ZZIopKlpFi+W6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K91NgVYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06692C4CEEB;
	Thu, 11 Sep 2025 01:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757555073;
	bh=7bK8rD4BqHT2+PFrVqYC9jBycy2TYXC0jZgqhWt8nSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K91NgVYhwxXzdoq4MGZYOsE+Pm6HtjTHQ33iJpXKsxFfKPe4iKPajGKSJaIfgKAU/
	 gdIVixWqDIczPy2LI/3+qJHHVU9/vcCQPRgVRkhRCDjzaLBRdPmOj7RRUo+OejzADA
	 SbEAZ+jdq93vvQYt4pBJ7Ra6AolIq+BIE8HkdOUBCfQ3/hEUoKjeoCcviBaalbAiWU
	 WMGyxgzXuwpZzgYe76Oh6akQaw0QVhi3n3azCLsghs5nQAEgc3HhKBmDyeJhktENAv
	 QVuXNAdRBv6tgLvQtTbrZQcZmjImld2eZwBvQsod5UsQ7a/qFKf2MVCriXem7FdTGr
	 +eQhImtS+AZgA==
Date: Wed, 10 Sep 2025 15:44:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 05/14] sched: Move sched_class::prio_changed() into the
 change pattern
Message-ID: <aMIpgLF-V7t2fLbo@slm.duckdns.org>
References: <20250910154409.446470175@infradead.org>
 <20250910155808.876041318@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910155808.876041318@infradead.org>

On Wed, Sep 10, 2025 at 05:44:14PM +0200, Peter Zijlstra wrote:
> Move sched_class::prio_changed() into the change pattern.
> 
> And while there, extend it with sched_class::get_prio() in order to
> fix the deadline sitation.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

For 1-5 from sched_ext POV:

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

