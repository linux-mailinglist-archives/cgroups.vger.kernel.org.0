Return-Path: <cgroups+bounces-6995-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0212DA5D36B
	for <lists+cgroups@lfdr.de>; Wed, 12 Mar 2025 00:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2C53AEEEC
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 23:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC629235368;
	Tue, 11 Mar 2025 23:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smGdKmSF"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A12B225764;
	Tue, 11 Mar 2025 23:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741737593; cv=none; b=E1YO6SRJ8oBIZTQjpKgnpW4umgDibtb21qMmPRrvr99psQPsCgNbpe2ThZOslm2ZW8cBlKQzY+0GdyAmMZKP1pSAG/fnRdWT746gqf4aUKVpkc7j3gUrVlEwpk2YYMGint3IVDX2bmPvmaJJHoHNp0OA6BgGLZpx0F0EeGwPH8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741737593; c=relaxed/simple;
	bh=S/xTYReOYh4NPz6mC18vsMNnkJPaisPIMIw02e2v9eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGdftChvcrsgEcY0Z9Lv1lAeoSg5U4munTFTuIZayxTgamqFTv7Azoztx5xWeFU5yQt2Dk7iVCepwUiDRIa/1mBSGgqutF+YcLE1alfaa9vH+IHL8ksljoeJuI9yQV5PfIkMW+OpIv65BaqoJCNMBT+3UGjIrJdIUNCkyeinDKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smGdKmSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EF2C4CEE9;
	Tue, 11 Mar 2025 23:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741737592;
	bh=S/xTYReOYh4NPz6mC18vsMNnkJPaisPIMIw02e2v9eQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=smGdKmSFRSd/gf6rgcBA1N5JimFPdyni7ra6QuDRfxCu52SwmgCTt8qHjb/lbvnUb
	 0NdyR0Mr/nEE6133b9k/+zxCBIkeo3HhB7UxdnvoVJEzdgEobrcdChQ9TbuVHsDRps
	 dLMMNPzGP+ceJrFz6XsDl2BYDgfSjSA1d0jPV3y6z/ZQ9oSsyK2/5sXTcekXA7Yu6Z
	 dDAwijNnsEovi1PR0rXYTuF7Urzs3WyL5uukZ1pfj8lZH7IkFQzpH4lbZ4hsjX+R0/
	 nIU+kwoD1grC+tjz3rUMsLkgNXwFvvMdFQiQfveD4fKji6LtGuXOx9RZPOxN0yDzNR
	 tvPxL4/7+syZA==
Date: Tue, 11 Mar 2025 13:59:51 -1000
From: Tejun Heo <tj@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH cgroup/for-6.15] mm: Fix a build breakage in memcontrol-v1.c
Message-ID: <Z9DOd8Iwz1iGw8_r@slm.duckdns.org>
References: <202503120710.guZkJx0h-lkp@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202503120710.guZkJx0h-lkp@intel.com>

From b0543d50c4cbc34ca612ab17c3cc9f2d174be8e0 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 11 Mar 2025 13:56:11 -1000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While adding a deprecation message, fd4fd0a869e9 ("mm: Add transformation
message for per-memcg swappiness") missed the semicolon after the new
pr_info_once() statement causing build breakage when CONFIG_MEMCG_V1 is
enabled. Fix it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Michal Koutný <mkoutny@suse.com>
Fixes: fd4fd0a869e9 ("mm: Add transformation message for per-memcg swappiness")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503120710.guZkJx0h-lkp@intel.com/
---
Applied to cgroup/for-6.15.

Thanks.

 mm/memcontrol-v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 93291c0e6eac..67e786d3b17c 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1857,7 +1857,7 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
 
 	if (!mem_cgroup_is_root(memcg)) {
 		pr_info_once("Per memcg swappiness does not exist in cgroup v2. "
-			     "See memory.reclaim or memory.swap.max there\n ")
+			     "See memory.reclaim or memory.swap.max there\n ");
 		WRITE_ONCE(memcg->swappiness, val);
 	} else
 		WRITE_ONCE(vm_swappiness, val);
-- 
2.48.1


