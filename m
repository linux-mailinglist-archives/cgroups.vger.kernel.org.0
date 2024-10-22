Return-Path: <cgroups+bounces-5177-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB2B9A9B0F
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2024 09:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 345BBB24A88
	for <lists+cgroups@lfdr.de>; Tue, 22 Oct 2024 07:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A9714EC73;
	Tue, 22 Oct 2024 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j9FxgkJG"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4493314D2BD
	for <cgroups@vger.kernel.org>; Tue, 22 Oct 2024 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582261; cv=none; b=Q1wn0RvsnxyKAG1lqBUJ7QO1bc5n4ZZhyAfja2Q+0TZksKMWTLbr/s3hsWlEVKUZrHCwl1D69fgDNHDDhluHxvagvXD3SjoxgNU9TszPtevzCPgKsWb6bTKFfXb64wfNKxf3FPDfmzWKbP3x2lxCLRlfP8oCGpXgpurdz3ACU5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582261; c=relaxed/simple;
	bh=2Xx6/DUfUjwIUEo6DlYONJOsCqi0nWQlnwt/N08NSzQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gB9RvUH1/CV/Ais68ZJQzoa6Mm1Qw32HSWGcY/+g7HXPAV3ssilKnNeTrF/4ny/8xnxita3Yeim5IYtJmIHB54dbn5erZGlTOyDlA1TbpckuxVwHXMrAzdaGdQQ4AN9raXRWI0QeZycWyXd+uzAfWKGepiPsUfpNJM5WhMElVSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j9FxgkJG; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729582256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwAyDyVKA/SOfuimo1rAiUn62XNNlwrTRrrwVlZsQwc=;
	b=j9FxgkJGvCbzrhPbm9O6+LEBgxwozxYBsqijgU3wETTzsY9s5rVoaY/nYX/UnOxD1VCuqU
	c5xJFBYYmPnpaucos/hjLjDDd+VdXDo9QXCcoKxaFFykjndC6sNPK110vfMash8gKvDfTA
	8Bsyyxdjbp5md2pskvk8kVOKztvv/fI=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v2] mm/memcontrol: Fix seq_buf size to save memory when
 PAGE_SIZE is large
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20241021130027.3615969-1-ryan.roberts@arm.com>
Date: Tue, 22 Oct 2024 15:30:11 +0800
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 cgroups@vger.kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Michal Hocko <mhocko@suse.com>
Content-Transfer-Encoding: 7bit
Message-Id: <4BEA4D18-A71B-40EB-82C0-6450B78C4627@linux.dev>
References: <20241021130027.3615969-1-ryan.roberts@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
X-Migadu-Flow: FLOW_OUT



> On Oct 21, 2024, at 21:00, Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
> Previously the seq_buf used for accumulating the memory.stat output was
> sized at PAGE_SIZE. But the amount of output is invariant to PAGE_SIZE;
> If 4K is enough on a 4K page system, then it should also be enough on a
> 64K page system, so we can save 60K on the static buffer used in
> mem_cgroup_print_oom_meminfo(). Let's make it so.
> 
> This also has the beneficial side effect of removing a place in the code
> that assumed PAGE_SIZE is a compile-time constant. So this helps our
> quest towards supporting boot-time page size selection.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.


