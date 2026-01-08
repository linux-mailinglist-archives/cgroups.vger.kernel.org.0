Return-Path: <cgroups+bounces-12953-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 440A5D008A3
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 02:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B98D300C2BF
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 01:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C481F30C3;
	Thu,  8 Jan 2026 01:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thzsBwxw"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE4C1A9FAF;
	Thu,  8 Jan 2026 01:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767834846; cv=none; b=GPlTrGp61isBo3HCe4L/V8bMrryBXTJwDB2dftTz07b8VFWiuUltliaruPn3+yQwGu7XvoeRFW4o1alnSyuKb4Tm8gcHkuj86gR2x4BHXQgLMpv3fhZGqPJDw5vonMy74O1UYF9ZI0s8PV004la9ZUHCQlzfHzWSczVPf3eVamE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767834846; c=relaxed/simple;
	bh=KF2UrLW7G3OTeR58wF359dV9iCsu8txsl4QyOYJ22OQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=VIxhwLrViHMyUCInhegZwOtxNFENznuut9m058K7eTHoY2TDjbf8weBgXX5wVChMDOPWCV+Kb+9aa7VQ+mwd4SrZ60JORPj6GvmQxMg900Br1XgVbVcIT1TeYYleNu3BEftbLFNBqiZSdyH3ixS7ckxrEkTe3UyRXuNWiJ0p/0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thzsBwxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC70C4CEF1;
	Thu,  8 Jan 2026 01:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767834845;
	bh=KF2UrLW7G3OTeR58wF359dV9iCsu8txsl4QyOYJ22OQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=thzsBwxwB73atw3xz6pwmlOq46JnxPT22rLj+U5nv38k6csnruuqML3fmFaVcHhWX
	 B8E8r19X4SfU2fdShg7PyB9QDZZoMp5KRVfBGwV0omOkgRkEQWWz7fiNcNviah+waY
	 lq4wSlRRwGjS6iOpCzMZ7P5BYymC+K5ClzYrkDhJoigMyVc/JYo5F+KoyWx7hfvEGc
	 MMlWWVgJe3Aqo3XAsvInxVAMND6/PZ8pcySxJXBTjMqpEC8EYUo+3mhvGVx4t2kOZh
	 fwuvWkq9Ortm8z9oHKUDsKVPBoD6Vtatr+dXLOqnekJeOJiGk/FNuLwcJMtWvLXe9L
	 cPtf+Iqtt4RAQ==
Date: Wed, 07 Jan 2026 15:14:04 -1000
Message-ID: <54df5bae11fdb5a9c92ea2cdd7a45e9e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Michal Koutný <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 David Laight <david.laight.linux@gmail.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2] cgroup: Eliminate cgrp_ancestor_storage in cgroup_root
In-Reply-To: <20260107165942.95340-1-mkoutny@suse.com>
References: <20260107165942.95340-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Applied to cgroup/for-6.19-fixes.

Thanks.

--
tejun

