Return-Path: <cgroups+bounces-248-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC137E5AE8
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 17:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34792815DA
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 16:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D708A30D08;
	Wed,  8 Nov 2023 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Whrwu6GI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A53064B;
	Wed,  8 Nov 2023 16:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7C6C433C7;
	Wed,  8 Nov 2023 16:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1699460061;
	bh=qYaMUn5duRraHp6jr8ZuuZE1fl2gs0KU/LKQTez8o9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Whrwu6GIg7SpMw2mJOf96NBOwMy7GL3oSYCWku834BMQQcIPlQ10b2+HTcu9rEVyJ
	 defOtH86G8m6qmQ3/CBDHcfF23pf8xJ0+euljpncO6exp+kIJxzHvn3tV7j+fy/E4k
	 460UFKjuVzm+Wz3jaa1LWlb9kfB6vzZ9URKq41tI=
Date: Wed, 8 Nov 2023 08:14:19 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Huan Yang <link@vivo.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, Michal Hocko
 <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel
 Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, David
 Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, Huang
 Ying <ying.huang@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Peter Xu <peterx@redhat.com>, "Vishal Moola (Oracle)"
 <vishal.moola@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Liu Shixin
 <liushixin2@huawei.com>, Hugh Dickins <hughd@google.com>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 opensource.kernel@vivo.com
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
Message-Id: <20231108081419.1c31f74de8e7fce24f85c967@linux-foundation.org>
In-Reply-To: <20231108065818.19932-1-link@vivo.com>
References: <20231108065818.19932-1-link@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Nov 2023 14:58:11 +0800 Huan Yang <link@vivo.com> wrote:

> For example, when an application is pushed to the background and frozen,
> it may not be opened for a long time, and we can safely reclaim the
> application's anonymous pages, but we do not want to touch the file pages.

This paragraph is key to the entire patchset and it would benefit from
some expanding upon.

If the application is dormant, why on earth would we want to evict its
text but keep its data around?

