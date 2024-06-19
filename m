Return-Path: <cgroups+bounces-3239-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D083A90F407
	for <lists+cgroups@lfdr.de>; Wed, 19 Jun 2024 18:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96281C20AB0
	for <lists+cgroups@lfdr.de>; Wed, 19 Jun 2024 16:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1CF152792;
	Wed, 19 Jun 2024 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIp3KKhj"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380E537143;
	Wed, 19 Jun 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718814555; cv=none; b=RnCk+DoyDhiSXxNgguUGu0O287w/RVI3Y97duHU/CPzvUo3ciH42igYPTv0bTg8/ScsKExTLF4NeSBY8E5vaHOcc8f2JzSLBfNFGCITTHG9EKKN1bL4y7LCl48Z+AfanRJtIH17ayY3lTxu33ZttB7SqR0oduTuKjwpWiHSTCi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718814555; c=relaxed/simple;
	bh=4x1eomS0LQNDb3AKsFIQZNZT+hgzq9kMPbg3bfdl1LQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W/CEKvo26An9bxvdxrfDR9U+0FdjMCQ+stwZ6h29/5wnuZap3/K0FUMdWov/Ci25OZ+WZRMkPzWXNzjDqEVPdlLF1fMz6FxWJyH3i4OwmsTtwuKvDNFcFXqch9uOO4M8x7icK2+R2nbvKUEZNwhkCglomVHcGMqCcE4aPMttPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIp3KKhj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A77C2BBFC;
	Wed, 19 Jun 2024 16:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718814554;
	bh=4x1eomS0LQNDb3AKsFIQZNZT+hgzq9kMPbg3bfdl1LQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WIp3KKhjO5r3csalUi6fG/bgE9DDSxqJ/PouWAFXyEnWmi5lJwwMo0aB7CM189wYR
	 inF5OgCL1SpgGJK/9Yy2Z8L4lD6qZnuR0y2dxvl1bSOErwEuq62QBCGOMijq9oeVUz
	 wqJx176j0kXgrF8gu2l/w16DQ3MNervLPRY3nk9b2Eh94HpQmyoJR1LOPn1MwjIVqV
	 EZl7GNytgqEYG2aA53CPw3E2wueamrtDiYHyS2XvtG1MlDy/VqA4+kpUK9UzNbVwq7
	 Q3SG6+h/+OtAc8pRUK9qRSYuih4jciHYEyh5PpfjS46CeIS5ACITWFObM4VpISS02D
	 MdzMDen12A/hw==
From: SeongJae Park <sj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	m.szyprowski@samsung.com
Subject: Re: [PATCH v3 -next] mm/hugetlb_cgroup: register lockdep key for cftype
Date: Wed, 19 Jun 2024 09:29:10 -0700
Message-Id: <20240619162910.106034-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240619015527.2212698-1-xiujianfeng@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 19 Jun 2024 01:55:27 +0000 Xiu Jianfeng <xiujianfeng@huawei.com> wrote:

> When CONFIG_DEBUG_LOCK_ALLOC is enabled, the following commands can
> trigger a bug,
> 
> mount -t cgroup2 none /sys/fs/cgroup
> cd /sys/fs/cgroup
> echo "+hugetlb" > cgroup.subtree_control

[...]
> 
> Fixes: e18df2889ff9 ("mm/hugetlb_cgroup: prepare cftypes based on template")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202406181046.8d8b2492-oliver.sang@intel.com
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> ---
> v3: remove #ifdef CONFIG_DEBUG_LOCK_ALLOC in struct cftype

I confirmed the issue is fixed.

Tested-by: SeongJae Park <sj@kernel.org>
Closes: https://lore.kernel.org/20240618233608.400367-1-sj@kernel.org

[...]

Thanks,
SJ

