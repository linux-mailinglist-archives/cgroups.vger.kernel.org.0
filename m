Return-Path: <cgroups+bounces-13276-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38396D2EB18
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 10:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F96E301119C
	for <lists+cgroups@lfdr.de>; Fri, 16 Jan 2026 09:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A1D34E743;
	Fri, 16 Jan 2026 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EQvt5dKU"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883AC34DB6F
	for <cgroups@vger.kernel.org>; Fri, 16 Jan 2026 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768555280; cv=none; b=GFeTxoCCLnVDpack8MJHEjLGrPnEj3okcQQh9kcD5MvJCmwCf5iwY2EE+aw/qBsqF9z9L8IVaZLYTRDp88F/IcNUPXnaVXnL8VDBPrCBV11yUf9gBvuYiXmrzaD+21O6sAGFvQrf46b3AvSeRSDllDOIV++IToYyC+C9+Kly9OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768555280; c=relaxed/simple;
	bh=j14bovFJxfplgiusOjALiL9Bw/S3pAZ821NTcxpDbQE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PmCjgXSmrfwwq661GRbo7XpKONFElj6oZDc27492reoVg2UrUO7vNTy84C5CUPhcpr6E3qXclKI66z+mnoEwYFR1tsoqTUgJagHVlsKkMNb5Cr59Lw3oonNGhB2OBJ13QbBUKX94BH/E6bNjZiqQ/f6p/YOs5WeCbxTK/Aj6MYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EQvt5dKU; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768555275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUd3/WmA+J5BNqqwVB9Fpj2XCO58RHNi4/wu2oPQXwE=;
	b=EQvt5dKUNhmjcAClSgNl2oSdYNzQw3bV5H6zQYo4/3MMJncvtIIxUJ30Z7b4DKnHrjlV9d
	chYH/jrA7vpANEpjHgFEb8PvM5NbPFCr8w1xDumij3rF/aninUxbLe+jU1qpvhC6S2BH7m
	n4Iby+e6+RKZ+CGpLeTECxPeN+DbLLM=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v3 23/30] mm: do not open-code lruvec lock
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <33fef62fd821f669fcdc999e54c4035a4e91b47d.1768389889.git.zhengqi.arch@bytedance.com>
Date: Fri, 16 Jan 2026 17:20:14 +0800
Cc: hannes@cmpxchg.org,
 hughd@google.com,
 mhocko@suse.com,
 roman.gushchin@linux.dev,
 shakeel.butt@linux.dev,
 david@kernel.org,
 lorenzo.stoakes@oracle.com,
 ziy@nvidia.com,
 harry.yoo@oracle.com,
 yosry.ahmed@linux.dev,
 imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com,
 axelrasmussen@google.com,
 yuanchu@google.com,
 weixugc@google.com,
 chenridong@huaweicloud.com,
 mkoutny@suse.com,
 akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com,
 lance.yang@linux.dev,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
Content-Transfer-Encoding: 7bit
Message-Id: <038534F8-F695-4660-A18A-875214C3FE8B@linux.dev>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
 <33fef62fd821f669fcdc999e54c4035a4e91b47d.1768389889.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <qi.zheng@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Jan 14, 2026, at 19:32, Qi Zheng <qi.zheng@linux.dev> wrote:
> 
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Now we have lruvec_unlock(), lruvec_unlock_irq() and
> lruvec_unlock_irqrestore(), but not the paired lruvec_lock(),
> lruvec_lock_irq() and lruvec_lock_irqsave().
> 
> There is currently no use case for lruvec_lock_irqsave(), so only
> introduce lruvec_lock() and lruvec_lock_irq(), and change all open-code
> places to use these helper function. This looks cleaner and prepares for
> reparenting LRU pages, preventing user from missing RCU lock calls due to
> open-code lruvec lock.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Muchun Song <muchun.song@linux.dev>



