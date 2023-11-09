Return-Path: <cgroups+bounces-279-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBE97E6AC9
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 13:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E021C20AFC
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA2D883D;
	Thu,  9 Nov 2023 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="E7t/vPPR"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B507882D;
	Thu,  9 Nov 2023 12:46:00 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6F51B3;
	Thu,  9 Nov 2023 04:45:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B72521977;
	Thu,  9 Nov 2023 12:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1699533958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HXBYSsMM7dNCINQinGuxS5CHJRB8whseQnR30IMhhnw=;
	b=E7t/vPPRub+eIl262tzN7R6DYYa5adyHslyO4SnBBHWCvgs/u4Yv6naj2zbRUDhRpESqpL
	yT554ZVm2uY8YacmJIIxlFIBLCIeiBKJBOkHSQ9k98nHsJ/QrTlgwddzOs3Rn2Nq5ZKr1M
	skoOCwSO7iWgcP1MBa6UCo0xeVjstUY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22CB413524;
	Thu,  9 Nov 2023 12:45:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id o5bfB4bUTGXfOwAAMHmgww
	(envelope-from <mhocko@suse.com>); Thu, 09 Nov 2023 12:45:58 +0000
Date: Thu, 9 Nov 2023 13:45:57 +0100
From: Michal Hocko <mhocko@suse.com>
To: Huan Yang <link@vivo.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Liu Shixin <liushixin2@huawei.com>, Hugh Dickins <hughd@google.com>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	opensource.kernel@vivo.com
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
Message-ID: <ZUzUhWsrzDQwMKQ-@tiehlicka>
References: <20231108065818.19932-1-link@vivo.com>
 <ZUuV9xOZ5k7Ia_V2@tiehlicka>
 <ccc4094a-54de-4ce4-b8f6-76ee46d8d02d@vivo.com>
 <ZUysGhwqo_XZSV-M@tiehlicka>
 <d49acb29-c1e6-429b-8d94-a5a8e1e2f548@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d49acb29-c1e6-429b-8d94-a5a8e1e2f548@vivo.com>

On Thu 09-11-23 18:55:09, Huan Yang wrote:
> 
> 在 2023/11/9 17:53, Michal Hocko 写道:
> > [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Thu 09-11-23 09:56:46, Huan Yang wrote:
> > > 在 2023/11/8 22:06, Michal Hocko 写道:
> > > > [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > 
> > > > On Wed 08-11-23 14:58:11, Huan Yang wrote:
> > > > > In some cases, we need to selectively reclaim file pages or anonymous
> > > > > pages in an unbalanced manner.
> > > > > 
> > > > > For example, when an application is pushed to the background and frozen,
> > > > > it may not be opened for a long time, and we can safely reclaim the
> > > > > application's anonymous pages, but we do not want to touch the file pages.
> > > > Could you explain why? And also why do you need to swap out in that
> > > > case?
> > > When an application is frozen, it usually means that we predict that
> > > it will not be used for a long time. In order to proactively save some
> > > memory, our strategy will choose to compress the application's private
> > > data into zram. And we will also select some of the cold application
> > > data that we think is in zram and swap it out.
> > > 
> > > The above operations assume that anonymous pages are private to the
> > > application.  After the application is frozen, compressing these pages
> > > into zram can save memory to some extent without worrying about
> > > frequent refaults.
> > Why don't you rely on the default reclaim heuristics? In other words do
> As I mentioned earlier, the madvise approach may not be suitable for my
> needs.

I was asking about default reclaim behavior not madvise here.

> > you have any numbers showing that a selective reclaim results in a much
> 
> In the mobile field, we have a core metric called application residency.

As already pointed out in other reply, make sure you explain this so
that we, who are not active in mobile field, can understand the metric,
how it is affected by the tooling relying on this interface.

> This mechanism can help us improve the application residency if we can
> provide a good freeze detection and proactive reclamation policy.
> 
> I can only provide specific data from our internal tests, and it may
> be older data, and it tested using cgroup v1:
> 
> In 12G ram phone, app residency improve from 29 to 38.

cgroup v1 is in maintenance mode and new extension would need to pass
even a higher feasibility test than v2 based interface. Also make sure
that you are testing the current upstream kernel.

Also let me stress out that you are proposing an extension to the user
visible API and we will have to maintain that for ever. So make sure
your justification is solid and understandable. 
-- 
Michal Hocko
SUSE Labs

