Return-Path: <cgroups+bounces-10591-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4ABBC2AF5
	for <lists+cgroups@lfdr.de>; Tue, 07 Oct 2025 22:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A70C4E4816
	for <lists+cgroups@lfdr.de>; Tue,  7 Oct 2025 20:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7511E5711;
	Tue,  7 Oct 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lz6Zrtqk"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29042A80;
	Tue,  7 Oct 2025 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759869848; cv=none; b=qqLcJXxPU4lI8sjr1JItT52JP6T0OFUhbw4UWONouyI99QTOtT2B3lykhD/9tA2LtUandvPUetqW3PC1QsjvZcuYDNFuA9AF1W9clzYJM5n9nK+zXrCmbMvU5p/gtCK1LJhLEEn6FAc0319JcU/HZ+gs1xjYIBP+zmaex93yIj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759869848; c=relaxed/simple;
	bh=zTa4e6WH7DBvW/Pu4qXQlmyCPUVs15E3RIqGPwcCq3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVK4u0/gbT//dnecQ/Hwh+U7xmTZlbOXzF5DEXEMPgrY9ZUTBHglKVjbC6ZJIbRKjXLtqJnlTKD7/1qAF/WvSen/9WA2e+/BRIqOfMdTz2FKHRppt4xUG7qLNo6PPripGfGQMEQV3tLzylYSFYwKy1R5QrI5WCjG+HzKskrJJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lz6Zrtqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0DDC4CEF1;
	Tue,  7 Oct 2025 20:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759869845;
	bh=zTa4e6WH7DBvW/Pu4qXQlmyCPUVs15E3RIqGPwcCq3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lz6ZrtqkwAZKmO2fxsKgLuTRc2rbEsGRiyTibZZvkQT6KXrT3gEQIakzn/Hn4ZDGr
	 pp7veliee33E3TpSPaM5D/lu4gry9E1OMPRm8V0Hsq3AnF6LSq+S5wLI3BhLKlvIl6
	 jq7MY/pIz2UX1ON75mVTH/TM2nXYUTb2Dsg+CAQgi/R5NkR/AfUFRcdkKHZnDoCXa5
	 J5wVGZxk/man3U6XnnEM2ABu7A+scJdjleuW2Xqyz+am7gW2yXL3sCBe+Mo2mx0Jti
	 GvLbN6zAsLU+vmcd+QBigCWRY+mDHBLu2KhM8jws/lx+2X+gKGW5ZOVC/Zk3Wiwb26
	 OOw/bUnyC7yeQ==
Date: Tue, 7 Oct 2025 10:44:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 11/12] sched: Match __task_rq_{,un}lock()
Message-ID: <aOV7lHUhn3BnViKT@slm.duckdns.org>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.813272361@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006104527.813272361@infradead.org>

On Mon, Oct 06, 2025 at 12:44:13PM +0200, Peter Zijlstra wrote:
> In preparation to adding more rules to __task_rq_lock(), such that
> __task_rq_unlock() will no longer be requivalent to rq_unlock(),
                                       ^
                                       typo

Thanks.

-- 
tejun

