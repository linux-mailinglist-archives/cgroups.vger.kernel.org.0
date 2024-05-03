Return-Path: <cgroups+bounces-2772-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 573D08BB200
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 19:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1214D281A91
	for <lists+cgroups@lfdr.de>; Fri,  3 May 2024 17:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD3A158212;
	Fri,  3 May 2024 17:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UjeLcRNx"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CC9155309
	for <cgroups@vger.kernel.org>; Fri,  3 May 2024 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714758998; cv=none; b=jFcVR+oea85jD3m7+J8Z9WNOk+f3Pu+pVQOXHIE3m18GtADlm5JRY11r7iH2pLrWeMpwhvepp7R8axM/WSF7fr6UQGRdmCKoT5b3pV0kcQcuwvXY9g3O9Y+lhnm1c/WSuaAkBLA21/vYRW2L7FqYVSoGdkNkzHPlUsXjJZ3VoQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714758998; c=relaxed/simple;
	bh=iF+tuzYxBnhZHA40zu1dubng7ObuiWba8XuUcB+UZ4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/JsRoa/iox7cUuQ38aeznvKPq9ojr8+QAFjBWd6zQrm0Nwb2amfp1PlFzZdfVgZnAMv0W0ZlTxz772uwE7Cql4WCGlgc4eVqmKhrRMY580wCxGbS047/0AhYZD8Fui/erxAVDAqwt2HG2HkBDM9GErPKMLc9nPRPqVntBV7yDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UjeLcRNx; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 3 May 2024 10:56:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714758995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mVau4SQ9OnY1TYFgZ3SnItVxVCQLPzoWn/o0fmjLMis=;
	b=UjeLcRNxuulhmedCPn015/NI2hPsSRRWm9SkBR8NsrUbJJep2nZk0ypPnff7j28Pwq31T1
	l7DOR0OSaitDdyeOqXYfZRj7+6rJra3ymR7TBRZaW+jH8vi8lh6BL7lYJPHJhqcnYvPpiJ
	PXaKoHsVGJ4Hw9ZWBAhkiIngoDIrR9E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
	llvm@lists.linux.dev
Subject: Re: [PATCH 4/4] selftests/cgroup: fix uninitialized variables in
 test_zswap.c
Message-ID: <ZjUlTeLGqyJubyKr@P9FQF9L96D>
References: <20240503035105.93280-1-jhubbard@nvidia.com>
 <20240503035105.93280-5-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503035105.93280-5-jhubbard@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Thu, May 02, 2024 at 08:51:05PM -0700, John Hubbard wrote:
> First of all, in order to build with clang at all, one must first apply
> Valentin Obst's build fix for LLVM [1]. Once that is done, then when
> building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftests
> 
> ...clang finds and warning about some uninitialized variables. Fix these
> by initializing them.
> 
> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

