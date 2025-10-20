Return-Path: <cgroups+bounces-10898-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D48B0BF2940
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 19:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01DC64608F5
	for <lists+cgroups@lfdr.de>; Mon, 20 Oct 2025 17:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74F3330312;
	Mon, 20 Oct 2025 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFxrdVgV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCD532F75E;
	Mon, 20 Oct 2025 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979604; cv=none; b=pGx7JwBNw00Q2OczdLe+xceI/2z4OxzUmjn/fW5oG4d9uyVlNLtC01rMlnQTTqQeBP8wIENZGYenOa9QbrGKdEMHXGA2a0ev1U5CtEdB2TMIEgauM/BcXmgAezu/0bg1pjIfHRudLcAajTjx9RLWfN6SdlpesuZ2vMoMmY27hAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979604; c=relaxed/simple;
	bh=g9I0U02/cUqENuDToUCyNj2Rm3pn6hIWjCEcA13CqVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Es/TgemCm8fqzXSoCzf/535DIMnfACrcHG++9bvda9zl2VJBe7BJ1EcUTYBYElnLRt5uGuhZeMuChPZ4mmrfnPYDMox1CtTNPVeJZ7mDTpXHClq+ERrAYQTWfzu5kN3KJRHnt0rw/afMfISmAvw7i7ArL7YfW6ZIi0k4QnFCG40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFxrdVgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502C2C4CEF9;
	Mon, 20 Oct 2025 17:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760979604;
	bh=g9I0U02/cUqENuDToUCyNj2Rm3pn6hIWjCEcA13CqVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nFxrdVgV1OsUGGgz+RBNH/ULZ4O4F8o8C2BPnuYcTmMHfntNko2ojmLiWnsYkLfKS
	 tE+rtIRVtq5iRmDUft0siOw4bCBqn0FCzKOJV73chnDKRlmObMAaalMmZJxBldrwth
	 SZSSFL0AnsiSldjcy0rqA/lYUr6KlrGRTAJohYKX7Ed/X3TfU2391jgSMC4IvVBNmt
	 LEmV/cXQNW1L8Un5uNmAvSSs+Az79ry3LQEQqTR7ET7XnqV8gDXyvgiOAS3dt5aHya
	 6j2QPn+loM5LRBVrB+cwsErkebDaZcH8HcJhpe6Zzizk0bQjxl135KKn/Z7oMqpTDL
	 b6Cxm8cDKdy7w==
Date: Mon, 20 Oct 2025 07:00:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH 2/2] cgroup/cpuset: Change callback_lock to raw_spinlock_t
Message-ID: <aPZqk4h0ek_QM9o5@slm.duckdns.org>
References: <20251020023207.177809-1-longman@redhat.com>
 <20251020023207.177809-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020023207.177809-3-longman@redhat.com>

On Sun, Oct 19, 2025 at 10:32:07PM -0400, Waiman Long wrote:
> The callback_lock is acquired either to read a stable set of cpu
> or node masks or to modify those masks when cpuset_mutex is also
> acquired. Sometime, it may need to go up the cgroup hierarchy while
> holding the lock to find the right set of masks to use. Assuming that
> the depth of the cgroup hierarch is finite and typically small, the
> lock hold time should be limited.
> 
> As a result, it can be converted to raw_spinlock_t to reduce overhead
> in a PREEMPT_RT setting without introducing excessive latency.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Is this something that RT people would like? Why does the overhead of the
lock matter? I think this patch requires more justifications.

Thanks.

-- 
tejun

