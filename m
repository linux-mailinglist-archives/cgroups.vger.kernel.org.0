Return-Path: <cgroups+bounces-13267-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E7ED2D9FF
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 09:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B54F930E37F0
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 07:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81912D322E;
	Fri, 16 Jan 2026 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPjoBUKm"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5F42C11F3;
	Fri, 16 Jan 2026 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550272; cv=none; b=dXy+sntdfuqNMMf87Dkn+5X/hmn+HfoLsfk/umGJl2VYRrHb0p3SSjfSA7fHYeWb8OAiZwoQkR4cchDzYooqKtB60YRw/Y/m04C07yTp8xwVEX34VBjwDMNjvBjP+QH1LECZNd3gnOp59EwzEm0L7bbmbVUoRBAm77EY1J9ufD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550272; c=relaxed/simple;
	bh=KF2UrLW7G3OTeR58wF359dV9iCsu8txsl4QyOYJ22OQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=OKxPqx0va2qcsbp0VaynILOtkoU+MMvAaSAl+Cq0jtDIMVvxcX69RIklPykkEV14iLujKjB68IobrLxq+o2PgpkHyZfrXYOLGP8UD0/dc0tSOMToVmdEKRcrp5XcfwnQGm2ioReDNuzCaTXQkQLGMmrPdRaYdmqCeU0RxH1tGOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPjoBUKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015EDC116C6;
	Fri, 16 Jan 2026 07:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768550272;
	bh=KF2UrLW7G3OTeR58wF359dV9iCsu8txsl4QyOYJ22OQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BPjoBUKmdBy1ywmxm0WbUjdo0WNlkYwb/I/dtvo9M6Q8Gl+CJcm4NBDJJvn+11mdg
	 IRMm5ItlhicUEHoGa1uz81KgTaWIXayDraAuK7PD1E1dCvchCPi6HhNx/4GEOQVZwf
	 finPSNqrRY7H1cCPwKb81/iprMn76kLz1UtIzggCiy7JxuGGCq0H6XkWN3NLHBk5dj
	 wY0LhlkuBkCivYdFIpVa29u91AvSkzTjQMCwOpeUAh2TThShxTNl1alXZbfa2mMagc
	 Lmex93Gp+IvjbQHzX0ab0Ad8xMpXsQmoqBecYwE/keq0ub1Tj6aj0GgSECncsLOQRP
	 cua+9P4vTKOdQ==
Date: Thu, 15 Jan 2026 21:57:50 -1000
Message-ID: <9dd0122e7ee2621db05ffe61890a43f5@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>,
 linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Chen Ridong as cpuset reviewer
In-Reply-To: <20260114045435.655951-1-longman@redhat.com>
References: <20260114045435.655951-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Applied to cgroup/for-6.19-fixes.

Thanks.

--
tejun

