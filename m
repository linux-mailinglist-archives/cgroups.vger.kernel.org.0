Return-Path: <cgroups+bounces-274-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DB07E6878
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 11:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A4B281278
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 10:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4967F2903;
	Thu,  9 Nov 2023 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g76LmZZa"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910ED11198;
	Thu,  9 Nov 2023 10:39:56 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA268211B;
	Thu,  9 Nov 2023 02:39:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 932FB21984;
	Thu,  9 Nov 2023 10:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1699526394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bAjTyM9LFw47Trcwx9e2QuYQewdjj60T+GRkl+OrN1k=;
	b=g76LmZZaCVFV74XvHWubphH/jOwnX36d8EfMeL8WgzfDc95tnFrddhcLnYN4+4FUY7FuIx
	iSdgdSoqMHV8LjE+ThOpJ/QEJWKi/Wt4OxF4tDd54EmKD0gj732XWfMXP16rCxE7EzTRYn
	a/rk/n+W9TPZYIX7OvV1DPp3qf3YoaY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82D5713524;
	Thu,  9 Nov 2023 10:39:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id fG3mH/q2TGUEegAAMHmgww
	(envelope-from <mhocko@suse.com>); Thu, 09 Nov 2023 10:39:54 +0000
Date: Thu, 9 Nov 2023 11:39:54 +0100
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
Message-ID: <ZUy2-vrqDq7URzb6@tiehlicka>
References: <20231108065818.19932-1-link@vivo.com>
 <ZUuV9xOZ5k7Ia_V2@tiehlicka>
 <ccc4094a-54de-4ce4-b8f6-76ee46d8d02d@vivo.com>
 <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com>
 <ZUytB5lSwxeKkBW8@tiehlicka>
 <6b539e16-c835-49ff-9fae-a65960567657@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b539e16-c835-49ff-9fae-a65960567657@vivo.com>

On Thu 09-11-23 18:29:03, Huan Yang wrote:
> HI Michal Hocko,
> 
> Thanks for your suggestion.
> 
> 在 2023/11/9 17:57, Michal Hocko 写道:
> > [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Thu 09-11-23 11:38:56, Huan Yang wrote:
> > [...]
> > > > If so, is it better only to reclaim private anonymous pages explicitly?
> > > Yes, in practice, we only proactively compress anonymous pages and do not
> > > want to touch file pages.
> > If that is the case and this is mostly application centric (which you
> > seem to be suggesting) then why don't you use madvise(MADV_PAGEOUT)
> > instead.
> Madvise  may not be applicable in this scenario.(IMO)
>
> This feature is aimed at a core goal, which is to compress the anonymous
> pages
> of frozen applications.
> 
> How to detect that an application is frozen and determine which pages can be
> safely reclaimed is the responsibility of the policy part.
> 
> Setting madvise for an application is an active behavior, while the above
> policy
> is a passive approach.(If I misunderstood, please let me know if there is a
> better
> way to set madvise.)

You are proposing an extension to the pro-active reclaim interface so
this is an active behavior pretty much by definition. So I am really not
following you here. Your agent can simply scan the address space of the
application it is going to "freeze" and call pidfd_madvise(MADV_PAGEOUT)
on the private memory is that is really what you want/need.

-- 
Michal Hocko
SUSE Labs

