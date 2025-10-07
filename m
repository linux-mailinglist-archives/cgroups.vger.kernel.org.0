Return-Path: <cgroups+bounces-10592-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0BEBC2AFE
	for <lists+cgroups@lfdr.de>; Tue, 07 Oct 2025 22:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A97B13C81B6
	for <lists+cgroups@lfdr.de>; Tue,  7 Oct 2025 20:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311FE23C50C;
	Tue,  7 Oct 2025 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaYbf/sC"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5512264AA;
	Tue,  7 Oct 2025 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869987; cv=none; b=mXXm87p9hwwcrjmX9IsUNv3kS9omBpwWeS+ytsvKUZ+PK+bAryMkdwPvzG5si8GzG0WEsfvGVlA16DhAqhztZCf8H88H/+Woz4gTAiDg1klh+k/ZABIzeM2ePvir82Hp4sL3U22AIL0jy2cfkTr6i5b2lyOegmxk90HNROz2RpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869987; c=relaxed/simple;
	bh=vFia84u1wYBVt9Kn/TScJ/+9AA7lGsqtODeAh6QZQj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sg3xaRC3U1/r42Bh97r+NzGKenlTRTlbc2Kbqr4FhRZZh0gg0A6AbOOEm+KdnvdFCPsKYj8aKsPpb0729z5hGJlj/72mWp9I2ko21SAcZqvUi+bXdF0oWaQew6ugNjuLjLuDQAg2m6GAyN0gfiaoOsKJlwtIQM31oBLUMJ4uVPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaYbf/sC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E12DC19423;
	Tue,  7 Oct 2025 20:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759869986;
	bh=vFia84u1wYBVt9Kn/TScJ/+9AA7lGsqtODeAh6QZQj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BaYbf/sCHbYh7h00lEe9jQaT8XqBL965jNAtOJ8T4Q5w1K8+A0WkbBufoJ9ufDc19
	 Av+3HhpfFEhpXlOcMf3qprwJbS6YRTRsIK/ti5lpx14OP8xRpkyDyEI3cD/PiqFk+C
	 s7VGfQbiIAKk83gqRjPklGt4yF3Nn0IWVEOViud5fxZuyTRhHWhD5PFrl5bVaRUYzK
	 odCHI+rpUaJGQCL8+3MGOEXuQX1JvtaCI+RyuLAv2ETGhQMykG3EUDOBd1C3mxjMcE
	 IRSmvVYmUYlTC2SEGva9y6ec0af5wJEGcOJE/5VoXUJafZiwg/aVmcn0nLrEK6slPC
	 U9+Dq7DwdYgQg==
Date: Tue, 7 Oct 2025 10:46:25 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 00/12] sched: Cleanup the change-pattern and related
 locking
Message-ID: <aOV8IQ2mHlso53Fh@slm.duckdns.org>
References: <20251006104402.946760805@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006104402.946760805@infradead.org>

On Mon, Oct 06, 2025 at 12:44:02PM +0200, Peter Zijlstra wrote:
> 
> Hi,
> 
> There here patches clean up the scheduler 'change' pattern and related locking
> some. They are the less controversial bit of some proposed sched_ext changes
> and stand on their own.
> 
> I would like to queue them into sched/core after the merge window.

FWIW, all look good to me.

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

