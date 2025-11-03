Return-Path: <cgroups+bounces-11542-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9873C2E0A4
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 21:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53A454F2C5D
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 20:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3F72BF01D;
	Mon,  3 Nov 2025 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8ly+aru"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071F628507E;
	Mon,  3 Nov 2025 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762201898; cv=none; b=akMb92dFFTKzcd767IRz3ShQ6pMaNUZfTj+CZccxiVgLEADCDdusmYXznLXvknmlFzMzpD5pSvaZ7KFBx25WwO67vzWtpEqZs9Jxm4Cw3HZSb4JhpCqaIldUeof16oZkJ1t3Mi0ZkfRB31soLqLKwwk5EixdBBF7aDIgaTpFSf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762201898; c=relaxed/simple;
	bh=5aEqEcZ153hEl3uWyfh7V5Myj8LqfrTm//8STxM7j54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA3iegw+Blefj6iR95PJD/Ljf2EHeUqVIyQeDN7QjeeiNQ1PJ4hDgKyYgjFoxpR74PGTgX1nqkOrgBgp0/MirUiF4/dJ4zENJ5bpxO7xGXU53+KyKA1kuqZCRFOTkgQopaamkondBUzcp3oiAJy0YQ06aD8T7Q4BlGY0HzwdPLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8ly+aru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D31C4CEF8;
	Mon,  3 Nov 2025 20:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762201897;
	bh=5aEqEcZ153hEl3uWyfh7V5Myj8LqfrTm//8STxM7j54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H8ly+aruXDn8ZFpnD3Wx63f+3o+m4ckGrybuticgT9YMnA8uBXntWwBBFDqjPK4zG
	 kvFika7yCdG1VP9UmYw6ScL4ZSCT1sodrEZtcz/qok1YjhhE82MMpUaYKQS43thrB8
	 vBcbT7zro1flf7W73Q1klfFXsRaSTYJg+a9RGnyJ+PBEDdPew0amq13OncfYEVvV7l
	 yxr1a0k2Yg164fUd1FbPO8keGiQmf+8VStJU9jSoconx5V3L0yteZU334pTwQ9t5j4
	 cES7jkcAWGJri5/f5JBR5RF9O44QtLq4E9coYojKIpuuZsEMd9wbuo6OXXsyMxouCk
	 m/VXN8Kb68xMg==
Date: Mon, 3 Nov 2025 10:31:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <dschatzberg@meta.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 4/4] sched_ext: Fix cgroup exit ordering by moving
 sched_ext_free() to finish_task_switch()
Message-ID: <aQkRKC15ta5Wo-lU@slm.duckdns.org>
References: <20251029061918.4179554-1-tj@kernel.org>
 <20251029061918.4179554-5-tj@kernel.org>
 <aQkPqUSMr5L0spd8@slm.duckdns.org>
 <20251103202843.GF3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103202843.GF3245006@noisy.programming.kicks-ass.net>

Hello,

On Mon, Nov 03, 2025 at 09:28:43PM +0100, Peter Zijlstra wrote:
> > @@ -5222,6 +5222,12 @@ static struct rq *finish_task_switch(str
> >  		if (prev->sched_class->task_dead)
> >  			prev->sched_class->task_dead(prev);
> 
> ^^^ can you not use task_dead_scx() ?

Unfortunately not. Because sched class switches are atomic infallible
operations, all tasks in the system must be prepped on scheduler attach &
fork regardless of their current sched class and thus have to be cleaned up
in the same way on detach & exit.

Thanks.

-- 
tejun

