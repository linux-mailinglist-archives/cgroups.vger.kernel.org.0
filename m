Return-Path: <cgroups+bounces-8122-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B244AB2106
	for <lists+cgroups@lfdr.de>; Sat, 10 May 2025 05:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937454E8061
	for <lists+cgroups@lfdr.de>; Sat, 10 May 2025 03:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDC118BBBB;
	Sat, 10 May 2025 03:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iJ9Dn2q6"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CAF1459F6
	for <cgroups@vger.kernel.org>; Sat, 10 May 2025 03:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746846768; cv=none; b=Ble1+pn5Fy8wHXbl3pSbwixZJSZIxmkKQiOtrMHD/yS7sycMy9v3Nc7w5UfXfzZinMxAl1bJIJBbFeXWhEefDB5xHw2EEffCk6GB+z5tJuaxFdY1Y1fhJtl3VzfxJie8vtB/lc/ofRz9e+G9KaluhcMUZBGyAb1QffPeYZ+cqt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746846768; c=relaxed/simple;
	bh=sJX7Wm1L2WnQLt74u0pXKyPEk6kzoPni3XC5cT6ciOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nfObo1/l7IkeNfE2PkQhgnXDylWfIdvvDOoaHJEMgRF2CjqMkjAQI7AElXQETUW+FVOZ0uWDr5Iv7UVY7S/mUkN3z6oO1ipJkG0l1au6cFHE1pslJ7/1S3uHYQVNPWdkUWE6ZVbs93CwOUQ/ajd32zXuv18QuWG0vD1DRkB5lgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iJ9Dn2q6; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 9 May 2025 20:11:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746846754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JiEb5YARkO2I8m9A66UGcmQ4V3Z4sE94ND81dqX+dO8=;
	b=iJ9Dn2q67WMEAPWD03Wr+NCVGG1K0ctFpYfjkOrA7o9w2bUsBo6t4dz3iBQgZBUFlFlOyD
	gNFtM5MoreKTji25JnyAaUyofLbxs8dlRmUNIqXMM2EA74KDxsQxeqw43SZwQ3mUrSl0zc
	Sno7ZsJBmrBzBEgdLddC25+2UZ4bqlw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/4] memcg: nmi-safe kmem charging
Message-ID: <xe443fcnpjf4nozjuzx2lzwjqkhzhkualcwxk4f5y6e5v7d7vl@h47t3oz3ippf>
References: <20250509232859.657525-1-shakeel.butt@linux.dev>
 <20250509182632.8ab2ba932ca5e0f867d21fc2@linux-foundation.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509182632.8ab2ba932ca5e0f867d21fc2@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

Hi Andrew,

On Fri, May 09, 2025 at 06:26:32PM -0700, Andrew Morton wrote:
> On Fri,  9 May 2025 16:28:55 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > BPF programs can trigger memcg charged kernel allocations in nmi
> > context. However memcg charging infra for kernel memory is not equipped
> > to handle nmi context. This series adds support for kernel memory
> > charging for nmi context.
> 
> The patchset adds quite a bit of material to core MM on behalf of a
> single caller.  So can we please take a close look at why BPF is doing
> this?
> 
> What would be involved in changing BPF to avoid doing this, or of
> changing BPF to handle things locally?  What would be the end-user
> impact of such an alteration?  IOW, what is the value to our users of
> the present BPF behavior?
> 

Before answering the questions, let me clarify that this series is
continuation of the work which added similar support for page allocator
and related memcg charging and now the work is happening for
kmalloc/slab allocations. Alexei has a proposal on reentrant kmalloc and
here I am providing how memcg charging for that (reentrant kmalloc)
should work.

Next let me take a stab in answering the questions and BPF folks can
correct me if I am wrong. From what I understand, users can attach BPF
programs at almost any place in kernel and those BPF programs can do
memory allocations. This line of work is to make those allocations work
if the any such BPF attach point is triggered in mni context.

Before this line of work (reentrant page and slab allocators), I think
BPF had its internal cache but it was very limited and can easily fail
allocation requests (please BPF folks correct me if I am wrong). This
was discussed in LSFMM this year as well.

Now regarding the impact to the users. First there will not be any
negative impact on the non-users of this feature. For the value this
feature will provide to users, I think this line of work will make BPF
programs of the users more reliable with better allocation behavior.
BPF folks, please add more comments for the value of these features.

thanks,
Shakeel

