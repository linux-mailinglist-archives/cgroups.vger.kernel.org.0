Return-Path: <cgroups+bounces-12751-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFA6CDEE12
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 19:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6947B3007251
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 18:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152201B0439;
	Fri, 26 Dec 2025 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsbjGumL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BC08462;
	Fri, 26 Dec 2025 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766773059; cv=none; b=Wm8eq7jygxyvzTyCqhXhxfAR5DamvS5lJj7TlU+hheWsQ28lweEP6JrME8wWyRm8BiCoB0wRcrMbVDxRf4bvwz13N6GXnB3yProY1TnKjAeuAf4Un4mIj3+Myr9gecmn6Bcd3gKMWpXQyW51vi2Q7dqWjVIi9XAQJJ5smmdeCtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766773059; c=relaxed/simple;
	bh=I4DtpAEe9pLppwYfVT/mO+qel169pwrd/tfT2MBTRxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhoyRL7vs4SElpLNWAQm0lcz4NLAVFLijg+4v3vTuYJSgFuAtREfgrxH6pM8YZQajzDRXmh+4LAGNAKGNoTEu/mepVy2xVpnm5M1BS+PDNzHxo870YWm5KLMCRmeO6/p6T+718d+03dDNjjUUaG0tG2pGdLzEU+bTsV6WeKk+N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsbjGumL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B29DC4CEF7;
	Fri, 26 Dec 2025 18:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766773059;
	bh=I4DtpAEe9pLppwYfVT/mO+qel169pwrd/tfT2MBTRxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dsbjGumLVwJc/4y9+ZeaZREUs6T3ZyxF0vAA9oRakEDJrE1taq9E2XyZYoxCNiYN6
	 8aguJVVAYLswk80lVNBnQ1KDLKR6uaYRFXDS+XqZP0zaS4O1iv6h8JLShxL3e+3bMi
	 psMF2SkEGAo0WWYvRoR/oX96tG0j7GQjK/HpnaUaaGyjn3gMpCRBhWhUjgfxdPTEAn
	 USQKrxjnTJLSBad6O/ch22wjErppSbJJUwn4K5m8N+MuZlkhDNdW1TUfwRGgO/2/7h
	 +uWJt72gBTZS92uyZC52AMfllMur92wE3WbeGn+PdYlp/xWSYOYOPs0yhV6TO4oxK3
	 lVa7lxXUXUSDg==
From: SeongJae Park <sj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] memcg: separate private and public ID namespaces
Date: Fri, 26 Dec 2025 10:17:36 -0800
Message-ID: <20251226181737.254305-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251225232116.294540-1-shakeel.butt@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Dec 2025 15:21:08 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> The memory cgroup subsystem maintains a private ID infrastructure that
> is decoupled from the cgroup IDs. This private ID system exists because
> some kernel objects (like swap entries and shadow entries in the
> workingset code) can outlive the cgroup they were associated with.
> The motivation is best described in commit 73f576c04b941 ("mm:
> memcontrol: fix cgroup creation failure after many small jobs").
> 
> Unfortunately, some in-kernel users (DAMON, LRU gen debugfs interface,
> shrinker debugfs) started exposing these private IDs to userspace.

Technically speaking, DAMON is not exposing the private IDs to userspace.  It
does use the ids to specify the memory cgroups in kernel space.  But, when it
communicates with the user space, it uses the paths of the cgroups, not the
ids.

> This is problematic because:
> 
> 1. The private IDs are internal implementation details that could change
> 2. Userspace already has access to cgroup IDs through the cgroup
>    filesystem
> 3. Using different ID namespaces in different interfaces is confusing

Though DAMON is not exposing the IDs to the userspace, I agree it is better to
use public id, mainly because DAMON doesn't really care about the
cgroup-outlive objects.  Also, it would allow easier change of the
implementation details and make more consistent kernel-space API usages.


Thanks,
SJ

[...]

