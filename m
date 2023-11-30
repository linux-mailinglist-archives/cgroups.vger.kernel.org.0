Return-Path: <cgroups+bounces-709-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4597FFA75
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 19:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289B41C211FC
	for <lists+cgroups@lfdr.de>; Thu, 30 Nov 2023 18:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA55852F74;
	Thu, 30 Nov 2023 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ukYJ7ZXL"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0DB10DE;
	Thu, 30 Nov 2023 10:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s/rDmWF02NwdqFljTBq3ivE1VLtPxbvFoYCxoKr5tkk=; b=ukYJ7ZXLRLKnuiGqLgilzy+W6R
	J6os9aQXTRF0Vkv+edCTTWm5PJiCesLMbij3enDPOgowYgu3oPrBD6U+/BLR+yL7cQNSBjcie3CYp
	t1nohxPqBpGF56aJHV0k+1PIS4cPo3zwgHt/a8yr0cw7ZuewHhRsktSubwqdvEn/stnQ0caSzyz8J
	q1YGmTctbZKEQckicOZJcgdcQRei25Nw2pP9HIzhvC9HKR5WQ7tF1r/j00lbYg1EahALVx7MI4gDv
	BcHtZ4b4flc+pDgCn66Ct+AvMbBIBxuKg1453al9BhaG8b68IfQJe66H7c+WrwbL+dl8rNBEOe62N
	/gmlHOVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r8mBJ-00Ekuv-Db; Thu, 30 Nov 2023 18:54:37 +0000
Date: Thu, 30 Nov 2023 18:54:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Shakeel Butt <shakeelb@google.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Huang Ying <ying.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
Message-ID: <ZWjabcWQm/GUoGTf@casper.infradead.org>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <20231130184424.7sbez2ukaylerhy6@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130184424.7sbez2ukaylerhy6@google.com>

On Thu, Nov 30, 2023 at 06:44:24PM +0000, Shakeel Butt wrote:
> On Thu, Nov 30, 2023 at 07:36:53AM -0800, Dan Schatzberg wrote:
> > * Swapout should be limited to manage SSD write endurance. In near-OOM
> 
> Is this about swapout to SSD only?

If you're using spinning rust with its limit of, what, 200 seeks per
second, I'd suggest that swapout should also be limited but for
different reasons.  We can set you up with a laptop with insufficient
RAM and a 5400rpm drive if you'd like to be convinced ...


