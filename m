Return-Path: <cgroups+bounces-12221-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D15C8AFC2
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 17:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274153A3168
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 16:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BC1339B2A;
	Wed, 26 Nov 2025 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ByOkJ+7M"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0512E2C026E
	for <cgroups@vger.kernel.org>; Wed, 26 Nov 2025 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174878; cv=none; b=Ao2pNFsvwZv7g/DnAQnTXvLigzqKzfSRgTzdy9A6/nKZJtpqCaPqYrY8JDZixRMBVIlI4ePq9c2MZeQndKCTi8NSWmLkEGgXcRXKNy63YInAROWUiW00iv3oPLWBdP61kxc9lDpJ17CswF64qcDYLdXh+HOueyVeozHUkaKaOpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174878; c=relaxed/simple;
	bh=AIK8nE3bo+OI34IZoqKLTRYIhuU11c53SCrn/xFYO7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZgLG3XG2rmi6iWM7Vwj24waJZw4CutDiGnX4/r+jPcdMb0Q+n99luNkCvhflkmZFRMYYc5dxaSd0HxJ/uGpMsyqbLvJUI/4/86Xy+K9DNEQ10z8Y08TLuHGUmZkx7qg57zZPfRP28J+ozHUj3gDyvgbbuWkt5LYzqznijKcxn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ByOkJ+7M; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Nov 2025 08:34:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764174873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EW/xRiF2YSo/HMOBazcBmwYiMNhsTF5W2nWfZvBvA9Y=;
	b=ByOkJ+7MNDcPqbv/xifpw0Od8NxzcHsU7Z12zC7zVdzzKnnbcF4qNvZsdSTIl3Y59Vx0ZN
	+tP2SVhJYJbYqv5VulAL8Hnud+Jm47BwfwkRPYHv3yudu7ioxx/+ebm+OUjh+XML1qGqnI
	J8hVYO2PoNErAcwob+RoqdRm4jx+v3E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, david@kernel.org, 
	zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH -next] memcg: Remove inc/dec_lruvec_kmem_state helpers
Message-ID: <rafsjmr5prtreezlzc3373bxsnutasvspmdgbntonhggk7ot4u@xyla47tfae2m>
References: <20251126020435.1511637-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126020435.1511637-1-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 26, 2025 at 02:04:35AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The dec_lruvec_kmem_state helper is unused by any caller and can be safely
> removed. Meanwhile, the inc_lruvec_kmem_state helper is only referenced by
> shadow_lru_isolate, retaining these two helpers is unnecessary. This patch
> removes both helper functions to eliminate redundant code.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

