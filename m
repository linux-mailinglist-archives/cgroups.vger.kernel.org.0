Return-Path: <cgroups+bounces-321-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1236C7E7C2D
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 13:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C2E28140E
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32149134BA;
	Fri, 10 Nov 2023 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Clxy+TbX"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC01B268;
	Fri, 10 Nov 2023 12:32:35 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A54833FB2;
	Fri, 10 Nov 2023 04:32:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CDA7E2198F;
	Fri, 10 Nov 2023 12:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1699619552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CjDgsL3wVenpcsZH5g+MB4etd9XiD3ofoHzynlFpI3Q=;
	b=Clxy+TbXjYlMgo44U30LFajMdpGxRz2QVANTOELTG2L39Sn+lZ+bmCRSSWt9YVmCgN8NW7
	j6kHba8FKOOq550b4qXfxkB992H4gB1BC+YZt4YmL/swXh7VAOj3r9Mzj+eVzpxJLTLAjZ
	cYDF0kQFr/7OO3pLjgzGEio4TdkBbmo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9164138FC;
	Fri, 10 Nov 2023 12:32:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 24VMJuAiTmX/HwAAMHmgww
	(envelope-from <mhocko@suse.com>); Fri, 10 Nov 2023 12:32:32 +0000
Date: Fri, 10 Nov 2023 13:32:31 +0100
From: Michal Hocko <mhocko@suse.com>
To: Huan Yang <link@vivo.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Liu Shixin <liushixin2@huawei.com>, Hugh Dickins <hughd@google.com>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	opensource.kernel@vivo.com
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
Message-ID: <ZU4i36tKnyXZ8lZD@tiehlicka>
References: <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com>
 <ZUytB5lSwxeKkBW8@tiehlicka>
 <6b539e16-c835-49ff-9fae-a65960567657@vivo.com>
 <ZUy2-vrqDq7URzb6@tiehlicka>
 <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com>
 <87a5rmiewp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ab108b82-87a9-4927-9d29-f60713281e8a@vivo.com>
 <878r76gsvz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <78128117-ce70-47ef-b7fd-10c772b1c933@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78128117-ce70-47ef-b7fd-10c772b1c933@vivo.com>

On Fri 10-11-23 14:21:17, Huan Yang wrote:
[...]
> > BTW: how do you know the number of pages to be reclaimed proactively in
> > memcg proactive reclaiming based solution?
>
> One point here is that we are not sure how long the frozen application
> will be opened, it could be 10 minutes, an hour, or even days.  So we
> need to predict and try, gradually reclaim anonymous pages in
> proportion, preferably based on the LRU algorithm.  For example, if
> the application has been frozen for 10 minutes, reclaim 5% of
> anonymous pages; 30min:25%anon, 1hour:75%, 1day:100%.  It is even more
> complicated as it requires adding a mechanism for predicting failure
> penalties.

Why would make your reclaiming decisions based on time rather than the
actual memory demand? I can see how a pro-active reclaim could make a
head room for an unexpected memory pressure but applying more pressure
just because of inactivity sound rather dubious to me TBH. Why cannot
you simply wait for the external memory pressure (e.g. from kswapd) to
deal with that based on the demand?
-- 
Michal Hocko
SUSE Labs

