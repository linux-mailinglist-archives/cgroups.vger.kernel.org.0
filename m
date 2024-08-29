Return-Path: <cgroups+bounces-4553-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 337B296384A
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 04:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BF1285760
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 02:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0126938DE4;
	Thu, 29 Aug 2024 02:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TC4GUpuw"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34814C70
	for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 02:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724899416; cv=none; b=ECeRnweFe5r/OGKvZfVy1W71yO0wkNPne0egKIKFDCUTz+spCm96b/Bz5Vcfq80c1ozuRanjBs/gLibLE3rjvTO6RZYF5XKWKdACPzHQr8kfA2b1r7RYEKiClYiuAIvFRfP0ABW/sj7I/JDSJDqdcYe+RWFEA8XSxgb+BlSWyII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724899416; c=relaxed/simple;
	bh=iMlNIyAp9xbd1MXJTwBtMlnKA8Uydo3I+gaSZj5PAso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkdrRDdAsRba0Sumttiwx/rxJu8vheHTeajCytTYdVE2j9THuqvNEpOJ1Zwp41x96APDtQJut38R5L/xrAeYhEUvSd93vtbC3MBHWQQmeCRpVH332BXU3IY7Ye3uEWErAVDLG4AN6qUyOtj13qCrK7zF9Ljm8SHtwUoZViyfr4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TC4GUpuw; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Aug 2024 02:43:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724899413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SdgR6bWMr023JzNGS1NP/3oB6n68ffTOSfVCi43HP6U=;
	b=TC4GUpuwL7+acgtopotjpyY45Oqr70/JSBnotB1mA7zb8AdLvuy4nncR21cChRVk4rQ/W1
	uPEXADipNt7H2ENfrV7E2XIoaAx50EYCwXVIl++ADLtatVkcmQjURIoRc1riGeQlloizQd
	/QuVwB5XVycDgXwqao1P9E1Sb9b8N2s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Xingyu Li <xli399@ucr.edu>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev,
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>
Subject: Re: BUG: general protection fault in get_mem_cgroup_from_objcg
Message-ID: <Zs_gT7g9Dv-QAxfj@google.com>
References: <CALAgD-6Uy-2kVrj05SeCiN4wZu75Vq5-TCEsiUGzYwzjO4+Ahg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAgD-6Uy-2kVrj05SeCiN4wZu75Vq5-TCEsiUGzYwzjO4+Ahg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 28, 2024 at 04:09:49PM -0700, Xingyu Li wrote:
> Hi,
> 
> We found a bug in Linux 6.10 using syzkaller. It is possibly a  null
> pointer dereference bug.
> The reprodcuer is
> https://gist.github.com/freexxxyyy/315733cb1dc3bc8cbe055b457c1918c0

Hello,

thank you for the report. Can you, please, share the kernel config file?
Also, how long does it take to reproduce?

Thanks!

