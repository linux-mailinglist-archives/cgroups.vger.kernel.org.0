Return-Path: <cgroups+bounces-4362-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89283957B84
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 04:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E70D1F22926
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 02:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3393D3B3;
	Tue, 20 Aug 2024 02:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CMjjkQ5J"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B27EED8
	for <cgroups@vger.kernel.org>; Tue, 20 Aug 2024 02:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724121476; cv=none; b=c86b1wpfHIv1IK9IAiag/0N7b42c+9YqOV4TIyKoOcu2uowxnqsWNXhhQPEQqqquux4uE3xpMnqrRIF1gAg15fwD2qYDDNIhtxS27nHzG0vphDEWuCK20O+xpaX5g+zsfYfrgS9gjm0z9UDmRuQMgSnS1DL+tBQHoE6h7/JkALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724121476; c=relaxed/simple;
	bh=hx04v2eQBOgTZVAZ7KON4hX+YpxEpVLGosF0ZgIZpQg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sc7wbukIfFEeesdQDryamJt3U5lRVCndQ964k52zNEIZExBSLpJf9pYy/6A3Ws/d6bR7qzuASM5Xwu0Lbocxdq5L1o5ANJURK9xFeIIiKM9q50vn6MW1U6sM5hybfvLftOM0yQMEWs8Bx/ADFW9rxBVho7A7ybU3K5penBwx52k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CMjjkQ5J; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724121472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YswQe8pDVgtxcv4I7cGkqok1RAga6VHIduWtMUdKToQ=;
	b=CMjjkQ5Jpn/xysHdkNs8bPNCe+t1ermXgSMEq/Ub0O9ed0ZtFSPJctwnoc0lg3f657VsEr
	WQ32d8QFoo6pm9b8SBy9E0PzY6ShZzjBuFUg9/Ff+NBfAd9wvBZAQBbF9jctE+K8oEau3s
	aIgtL4aNLa06/61f2uNIP/6WOkfsrDQ=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] mm: kmem: fix split_page_memcg()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <wvsagtywkr5rjn3y6fjz4wewmsyymxulim4zabunonmtxe4q4c@i7fd6bnwrbwp>
Date: Tue, 20 Aug 2024 10:37:12 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 cgroups@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 syzbot <syzbot+ef4ecf7b6bdc4157bfa4@syzkaller.appspotmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <D5816457-E0F4-4571-A81F-DE46C27F8C3D@linux.dev>
References: <20240819080415.44964-1-songmuchun@bytedance.com>
 <wvsagtywkr5rjn3y6fjz4wewmsyymxulim4zabunonmtxe4q4c@i7fd6bnwrbwp>
To: Shakeel Butt <shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Aug 19, 2024, at 23:37, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> On Mon, Aug 19, 2024 at 04:04:15PM GMT, Muchun Song wrote:
>> split_page_memcg() does not care about the returned memcg for kmem
>> pages, so folio_memcg_charged() should be used, otherwise obj_cgroup_memcg
>> will complain about this.
> 
> Basically avoid calling folio_memcg() for folio_memcg_kmem(folio),
> correct?

Yes. Unless you hold rcu lock.

> 
>> 
>> Reported-by: syzbot+ef4ecf7b6bdc4157bfa4@syzkaller.appspotmail.com
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> 

Thanks.

