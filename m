Return-Path: <cgroups+bounces-7931-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDDEAA3D3C
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363F44E2513
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167DE2E62CC;
	Tue, 29 Apr 2025 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9Y35YvA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59122E62C3;
	Tue, 29 Apr 2025 23:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970643; cv=none; b=pUQe/T6PKuPqODy7VpNFyHK6WZMBcimt9jWmBKHp+u7uHKwTQaYJT3C3I9KU+dJ99u1DIenh6pPA4y89RvctTiZVmeRslKn+lt5ASLiHNFDFwbilsFCr2k6FSZcMqLR9KhccIHH85f/Mgp9DhvQ+m7Rxfg9JqRDPvp3dHnwk41w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970643; c=relaxed/simple;
	bh=RFckZoqr3GbTVCJyvxzPdI/Ff1f3qW26zT5hV+au7tY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A47O/gt0fAGsXizd2YUUQpvqgAU2ZvPlUw1avgvCQcxVyg3SVgK16eDLNf5a4Spwpod1NLkn1w7Q7Lj4ISZtzgVusMbFd6Kutu6gmpRXkEOE/eYOG+HKMf+OzAqwmc0dcC2ZX06eo1NLMn1mGK+jNYiTlotSmwAa6Lai9me5GJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9Y35YvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67306C4CEE3;
	Tue, 29 Apr 2025 23:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970643;
	bh=RFckZoqr3GbTVCJyvxzPdI/Ff1f3qW26zT5hV+au7tY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T9Y35YvA3D+HaIdqZYPlwS0lq9zK/rDf4xXLh3R6N2e6ty9+zdpo/368QdLDd3wv9
	 cWVdf4rsSmBKcnLQLz1PnWzRnzwifux1I/LZNg+JqFvI0C+kWiPUObPWBd3mkzWaSs
	 9rh4Lg43fnuE8VXPZN1yvq6o8WSy/o/DtyPf5Ve3cci4ZQbhBxpHiAiBByTwcDRfOm
	 t9RXzeLXOAiZOHm/JMEAA6rktofWCbtO2mMmjexAGYJ7hgbLAlu3NYGrsfiQmMIi/U
	 XoEzOYvGo5dsEz2rh/cwRaSb+kEoBxRYRK8alkVqJcQIBCUqluOPbUJotLDW/E8alz
	 ZjIEOnGOSmFLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: gaoxu <gaoxu2@honor.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 19/39] cgroup: Fix compilation issue due to cgroup_mutex not being exported
Date: Tue, 29 Apr 2025 19:49:46 -0400
Message-Id: <20250429235006.536648-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: gaoxu <gaoxu2@honor.com>

[ Upstream commit 87c259a7a359e73e6c52c68fcbec79988999b4e6 ]

When adding folio_memcg function call in the zram module for
Android16-6.12, the following error occurs during compilation:
ERROR: modpost: "cgroup_mutex" [../soc-repo/zram.ko] undefined!

This error is caused by the indirect call to lockdep_is_held(&cgroup_mutex)
within folio_memcg. The export setting for cgroup_mutex is controlled by
the CONFIG_PROVE_RCU macro. If CONFIG_LOCKDEP is enabled while
CONFIG_PROVE_RCU is not, this compilation error will occur.

To resolve this issue, add a parallel macro CONFIG_LOCKDEP control to
ensure cgroup_mutex is properly exported when needed.

Signed-off-by: gao xu <gaoxu2@honor.com>
Acked-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 81f078c059e86..d1b4409ed1723 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -90,7 +90,7 @@
 DEFINE_MUTEX(cgroup_mutex);
 DEFINE_SPINLOCK(css_set_lock);
 
-#ifdef CONFIG_PROVE_RCU
+#if (defined CONFIG_PROVE_RCU || defined CONFIG_LOCKDEP)
 EXPORT_SYMBOL_GPL(cgroup_mutex);
 EXPORT_SYMBOL_GPL(css_set_lock);
 #endif
-- 
2.39.5


