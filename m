Return-Path: <cgroups+bounces-12162-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD433C7B9DB
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 21:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96EE33A531F
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 20:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E43D305068;
	Fri, 21 Nov 2025 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GxIpXZIl"
X-Original-To: cgroups@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5714C97
	for <cgroups@vger.kernel.org>; Fri, 21 Nov 2025 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763755519; cv=none; b=OKEkeiyQux3RXLjHC7iyJVMfUv1j42R6MdGdnWZNxC+xKJROBB26BIgr35f9ZAnVFTye15oy5EdhcBSaErugeY8s6Tribn4T5cvr+H0MPleSB4Q+jIt9EOzSL/k+ZvsP6ydXj+EED7Z6FOOkUSZD9KcWNHLeg2S3mooOJr+cJLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763755519; c=relaxed/simple;
	bh=rJ6w0Eto3ZXBMQPblq+9l7H0IhawqLduFKkjWHxhL1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Puo/Aar706Bf8xAEXiXzYDyFv0/zFaGA7/KEcBWi8Lf+ADMPkGm/Y8U/gmXfVJnnONtOY+2JIbBLkVTA5Q7a9ax/GnrVw/gqZbDW8s4AWRZFXypNxCNeF3A8E1JS0h1Pq5Dxj02DoKltAtLOoLtcuHw6qpXv05PLczGXVn2vVOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GxIpXZIl; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251121200508euoutp01e4be7d6d88ee2a2487a985efa2785bd1~6Hkpedm8L1772017720euoutp01J
	for <cgroups@vger.kernel.org>; Fri, 21 Nov 2025 20:05:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251121200508euoutp01e4be7d6d88ee2a2487a985efa2785bd1~6Hkpedm8L1772017720euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763755508;
	bh=TWcNwR8s7i9hJQBqzLWPt82xO1sFZQeOz3mN4JITxW0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=GxIpXZIlParQi/nq7xDUmG+ederpXcHVl4dqDb/5PAK9hIiu5G3cVc5XMZGREJ3Fv
	 ejmq5x+tyWQem469evnbdZe6u2/4qIJzm3LZgCjSLLl9HJ7ULfo//2PQ7n9sGVnEK7
	 2UdXSr3ztrIYkk/aPOLGALcqC5tNWg18E5upVMcQ=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251121200508eucas1p188300879fffc7fb86f8e95e0a9a00c6b~6HkpHHWfA2715727157eucas1p1H;
	Fri, 21 Nov 2025 20:05:08 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251121200508eusmtip12c44934ba72285b8a90bcc7671a1d797~6Hkoxblr80965609656eusmtip12;
	Fri, 21 Nov 2025 20:05:08 +0000 (GMT)
Message-ID: <8e5ff133-9af9-4718-9e94-ca2102e26ff6@samsung.com>
Date: Fri, 21 Nov 2025 21:05:07 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 0/3 v3] genirq: Fix IRQ threads VS cpuset
To: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Marco Crivellari
	<marco.crivellari@suse.com>, Waiman Long <llong@redhat.com>,
	cgroups@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251121143500.42111-1-frederic@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251121200508eucas1p188300879fffc7fb86f8e95e0a9a00c6b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251121143513eucas1p15c03a2c15aa5a0a15cc46d8f0a4e534e
X-EPHeader: CA
X-CMS-RootMailID: 20251121143513eucas1p15c03a2c15aa5a0a15cc46d8f0a4e534e
References: <CGME20251121143513eucas1p15c03a2c15aa5a0a15cc46d8f0a4e534e@eucas1p1.samsung.com>
	<20251121143500.42111-1-frederic@kernel.org>

On 21.11.2025 15:34, Frederic Weisbecker wrote:
> Here is another take after some last minutes issues reported by
> Marek Szyprowski <m.szyprowski@samsung.com>:
>
> https://lore.kernel.org/all/73356b5f-ab5c-4e9e-b57f-b80981c35998@samsung.com/

Works fine on my test systems.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> Changes since v2:
>
> * Fix early spurious IRQ thread wake-up (to be SOB'ed by Thomas)
>
> * Instead of applying the affinity remotely, set PF_NO_SETAFFINITY
>    early, right after kthread creation, and wait for the thread to
>    apply the affinity by itself. This is to prevent from early wake-up
>    to mess up with kthread_bind_mask(), as reported by
>    Marek Szyprowski <m.szyprowski@samsung.com>
>
> Frederic Weisbecker (2):
>    genirq: Fix interrupt threads affinity vs. cpuset isolated partitions
>    genirq: Remove cpumask availability check on kthread affinity setting
>
> Thomas Gleixner (1):
>    genirq: Prevent from early irq thread spurious wake-ups
>
>   kernel/irq/handle.c | 10 +++++++++-
>   kernel/irq/manage.c | 40 +++++++++++++++++++---------------------
>   2 files changed, 28 insertions(+), 22 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


