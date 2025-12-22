Return-Path: <cgroups+bounces-12564-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B106CD49F5
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 04:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2484F3009F8D
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 03:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E048332570D;
	Mon, 22 Dec 2025 03:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sdi7U+P7"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FE12C3252
	for <cgroups@vger.kernel.org>; Mon, 22 Dec 2025 03:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766373915; cv=none; b=LNeBPBR9UXK3Zh9pUpTqBCttJ0Rr9d7siPrJPKfzQiOQQomxe0xW924xDfeyr1nyq8cIy8s4VfSMOaL1Vq11R8R+NFgh1z9LdWglVVkz1YFTSQ5cyQFwk7FH9nqO2+n6b1HdOdrq/K6AO7Q5FFHekp/eNbZcAB0aDfkjFFbz3mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766373915; c=relaxed/simple;
	bh=E14KLDJYnbCvau5ukT1PEURZ3MN9M+hiKhHCXwaiop4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8QcYQ8AFPyR61E2y3sLXIAwoA5YAX1z9ts63aAbEoQhAMaXg1UkLGvldOW5ksqTlx07jFleqVxiMJwhRlFl/UdfPorvkgtTPMNR1W5hOqhaAVEcFRR7T/zphVjryCG2Zuad4S/iaYFlfZTiYHxzS79t82EFa2Fs0rXm3MG8tOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sdi7U+P7; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 21 Dec 2025 19:24:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766373906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b0q4BK1/oVFhcJwzFlC5ht870mAKf8HPK6uMRHcO9Sw=;
	b=Sdi7U+P7Md9MMdxEhS9bY644UrWGJOemPmiAhz09WAvxljkfCRmUjyFOOs4VreUHeK52Vh
	SNBV2yIPsXL/iVv56ShDHATEYCKpkwEUFEgEBkqnfsbl7jpLS0CG/ivFbn9k+eVvqD8lg6
	6xQVyC40N7IsI4mFWm8Mc3/JO7HJKPA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, david@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, corbet@lwn.net, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, zhengqi.arch@bytedance.com, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	lujialin4@huawei.com, zhongjinji@honor.com
Subject: Re: [PATCH -next 2/5] mm/mglru: remove memcg lru
Message-ID: <ytbajfyzgazpgx7qftafyt2ar6xzpxiarkdih4p2xiihovxci4@ugdmji5uboih>
References: <20251209012557.1949239-1-chenridong@huaweicloud.com>
 <20251209012557.1949239-3-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209012557.1949239-3-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 09, 2025 at 01:25:54AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> Now that the previous patch has switched global reclaim to use
> mem_cgroup_iter, the specialized memcg LRU infrastructure is no longer
> needed. This patch removes all related code:
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

