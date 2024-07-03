Return-Path: <cgroups+bounces-3530-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7C09269AA
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 22:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045B31F271B1
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 20:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB649190469;
	Wed,  3 Jul 2024 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UJwRVIXd"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A4628379;
	Wed,  3 Jul 2024 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720039086; cv=none; b=bPnt9G3N+4GFWUIEmAradwOKFKB97hm/8iJpcRSnJ0zeC8f3yIx4s5+J/R5Ef3iuMs79iYNBiDTKOR91pRJsJm8h93c+mTJlcquMSxt1rd1LIxCTZJ/TeOxEqgE5cF/a3BZxG+H4bBg4bu4SMZXChVOwloQdliZpPuNdV7VeMF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720039086; c=relaxed/simple;
	bh=+4Ks35xAf/yZ+g6UF74Pf5H+mbGc4Y8ntl+6RsPGyps=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UXilvFGfZRWWlf4Nb+JZ/CCkURxXm9UN3hRZsJCvdzJOGCACkt35CfXd0yiSK+NRaOGdh8g+ucGb3l+FeunDJ218RqwohqUGddmfIQz8y9CY6z/Us8yXoOIJSokcHiu/GaWeKfNdQAyOIzruhg+PHD55rJjV2qdkOjYuZNw7uAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UJwRVIXd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662BDC2BD10;
	Wed,  3 Jul 2024 20:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720039085;
	bh=+4Ks35xAf/yZ+g6UF74Pf5H+mbGc4Y8ntl+6RsPGyps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UJwRVIXdlKeVTnmQs9Qv9fgIH8QA7Cxi3P0TeMwE5JD2MhfR5HEgkmrBN8wJS7zUy
	 DqY6Zz7Epo6y7LFeQw4E8StHutlFYDvqvWOUsz0WRp2LDN7MUzZRlahzHbS7nWM7+u
	 N964EPbT4uJ0ubCmlZK5jS8MAEULJN5UyvkYQAFU=
Date: Wed, 3 Jul 2024 13:38:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: xiujianfeng <xiujianfeng@huawei.com>
Cc: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
 <corbet@lwn.net>, <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>, Miaohe Lin <linmiaohe@huawei.com>, Baolin
 Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH -next] mm/hugetlb_cgroup: introduce peak and rsvd.peak
 to v2
Message-Id: <20240703133804.1d8ddf90f738a7d546399b3b@linux-foundation.org>
In-Reply-To: <6843023e-3e80-0c1c-6aab-b386ffebd668@huawei.com>
References: <20240702125728.2743143-1-xiujianfeng@huawei.com>
	<20240702185851.e85a742f3391857781368f6c@linux-foundation.org>
	<6843023e-3e80-0c1c-6aab-b386ffebd668@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 10:45:56 +0800 xiujianfeng <xiujianfeng@huawei.com> wrote:

> 
> 
> On 2024/7/3 9:58, Andrew Morton wrote:
> > On Tue, 2 Jul 2024 12:57:28 +0000 Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
> > 
> >> Introduce peak and rsvd.peak to v2 to show the historical maximum
> >> usage of resources, as in some scenarios it is necessary to configure
> >> the value of max/rsvd.max based on the peak usage of resources.
> > 
> > "in some scenarios it is necessary" is not a strong statement.  It
> > would be helpful to fully describe these scenarios so that others can
> > better understand the value of this change.
> > 
> 
> Hi Andrew,
> 
> Is the following description acceptable for you?
> 
> 
> Since HugeTLB doesn't support page reclaim, enforcing the limit at
> page fault time implies that, the application will get SIGBUS signal
> if it tries to fault in HugeTLB pages beyond its limit. Therefore the
> application needs to know exactly how many HugeTLB pages it uses before
> hand, and the sysadmin needs to make sure that there are enough
> available on the machine for all the users to avoid processes getting
> SIGBUS.
> 
> When running some open-source software, it may not be possible to know
> the exact amount of hugetlb it consumes, so cannot correctly configure
> the max value. If there is a peak metric, we can run the open-source
> software first and then configure the max based on the peak value.
> In cgroup v1, the hugetlb controller provides the max_usage_in_bytes
> and rsvd.max_usage_in_bytes interface to display the historical maximum
> usage, so introduce peak and rsvd.peak to v2 to address this issue.

Super, thanks for doing this.

It's getting late in the cycle, but the patch is simple so I'll add it
to mm-unstable for additional exposure.  Hopefully some others can
offer their thoughts on the desirability of this.


