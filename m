Return-Path: <cgroups+bounces-2790-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D02B8BCF7E
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 15:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B7A1F226D8
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 13:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CA77FBC4;
	Mon,  6 May 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BgbMRQ2W"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53F27F7C2;
	Mon,  6 May 2024 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715003636; cv=none; b=GA+7hK9KYq9+1QsFBsF/fQhbAd55JFVwsH5Vu0VUptXaekC+xLbPkZMnal5P1SZ7KVoADbbtVw2K8hD39jS9j6UkgC+PZdhCpJD6uuOCuo6AkvlxsXAXTEvAs/evVfm9C6Lm7gSvnSZ1I7Go+Ix7afFh/NddYyYI1s/94uoifWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715003636; c=relaxed/simple;
	bh=4wGZZWr50vBbs3Q757bfPI+FzVZjlv4CH/7/r+l/niA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APA7t5eVniSlG9GinBHk3gsmr29ewvxN+qWVtA3Bj+Vqve0y+lypneI1jqtB07w+KbaVT4FNTwgccuoLYOsgpp+qFpLDbh40oeQAgBGVtgyIGFegD8qRoSYAtxAjqqLVg91SE52eiO7A8jTCE2UfNdbBuks8vELNtwH/3pm6iRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BgbMRQ2W; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4wGZZWr50vBbs3Q757bfPI+FzVZjlv4CH/7/r+l/niA=; b=BgbMRQ2WdJfHA20fF1oQAn25cc
	jk87a5yBwfhlKEqjjW7Y6pqP7s+X2z+DuZHBnN2S7F/XmSK6495gokjSa+o3OpSveFSYZinIULhEX
	ObCJ6LLabA9MUHJM0obz5AoKxkLDASvN1Ynn1M+O/MRerqv/+CVKvpb81pPuCaKgLb+xGM5KXNGCx
	9CClxA6t01knOSFEImNBBIV3O90uZj4XdjPR3MCmmDjkLr0OvOp59MZZ0Ew8PFixxUN8tbnnSvrf9
	F6yMyja3qhr2eBstJDud8D/7jxA6R8Nfy7lJGa5potIiUsudHdsRJWVNOWpG9qblitFgKT8NxUqUd
	UT/95xkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3ymp-0000000B3XI-3waU;
	Mon, 06 May 2024 13:53:47 +0000
Date: Mon, 6 May 2024 14:53:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	akpm@linux-foundation.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm: memcg: use meaningful error code for return
 value
Message-ID: <Zjjg60ZW-d7r-DS9@casper.infradead.org>
References: <20240506133643.1124102-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506133643.1124102-1-xiujianfeng@huawei.com>

On Mon, May 06, 2024 at 01:36:43PM +0000, Xiu Jianfeng wrote:
> alloc_mem_cgroup_per_node_info() returns 1 if failed, use -ENOMEM
> instead, which is more meaningful.

This should probably be changed to return true/false instead of
an int.

