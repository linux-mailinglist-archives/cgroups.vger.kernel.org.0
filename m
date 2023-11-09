Return-Path: <cgroups+bounces-278-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFE67E6ABC
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 13:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C71B1C20B74
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 12:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06E45695;
	Thu,  9 Nov 2023 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UERc19i/"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E421DDD1;
	Thu,  9 Nov 2023 12:40:57 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3D32590;
	Thu,  9 Nov 2023 04:40:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6DC4721977;
	Thu,  9 Nov 2023 12:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1699533655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBDurIQ5uqPNYzPg069Va7iaYE5q2cMCH1L1AF71VnM=;
	b=UERc19i/58CHPOKnAxtzhjGF01dQY0FXYRsKov+eSSNOfzWQe1jdNK5iYYpdsSYM/fcpwE
	ELjxm3MvWOmhxh0/QsGhga74/a/gvcVEA4gfm2pVMLR2UEmZXM+loZLcxmXyirLLXFFRZ9
	zeOAw0f3HvdE5jghAXBM9HsWJaP1iQE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E92513524;
	Thu,  9 Nov 2023 12:40:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id iioKF1fTTGVhOQAAMHmgww
	(envelope-from <mhocko@suse.com>); Thu, 09 Nov 2023 12:40:55 +0000
Date: Thu, 9 Nov 2023 13:40:54 +0100
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
Message-ID: <ZUzTVgK_i05uiHiB@tiehlicka>
References: <20231108065818.19932-1-link@vivo.com>
 <ZUuV9xOZ5k7Ia_V2@tiehlicka>
 <ccc4094a-54de-4ce4-b8f6-76ee46d8d02d@vivo.com>
 <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com>
 <ZUytB5lSwxeKkBW8@tiehlicka>
 <6b539e16-c835-49ff-9fae-a65960567657@vivo.com>
 <ZUy2-vrqDq7URzb6@tiehlicka>
 <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com>

On Thu 09-11-23 18:50:36, Huan Yang wrote:
> 
> 在 2023/11/9 18:39, Michal Hocko 写道:
> > [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Thu 09-11-23 18:29:03, Huan Yang wrote:
> > > HI Michal Hocko,
> > > 
> > > Thanks for your suggestion.
> > > 
> > > 在 2023/11/9 17:57, Michal Hocko 写道:
> > > > [Some people who received this message don't often get email from mhocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > > > 
> > > > On Thu 09-11-23 11:38:56, Huan Yang wrote:
> > > > [...]
> > > > > > If so, is it better only to reclaim private anonymous pages explicitly?
> > > > > Yes, in practice, we only proactively compress anonymous pages and do not
> > > > > want to touch file pages.
> > > > If that is the case and this is mostly application centric (which you
> > > > seem to be suggesting) then why don't you use madvise(MADV_PAGEOUT)
> > > > instead.
> > > Madvise  may not be applicable in this scenario.(IMO)
> > > 
> > > This feature is aimed at a core goal, which is to compress the anonymous
> > > pages
> > > of frozen applications.
> > > 
> > > How to detect that an application is frozen and determine which pages can be
> > > safely reclaimed is the responsibility of the policy part.
> > > 
> > > Setting madvise for an application is an active behavior, while the above
> > > policy
> > > is a passive approach.(If I misunderstood, please let me know if there is a
> > > better
> > > way to set madvise.)
> > You are proposing an extension to the pro-active reclaim interface so
> > this is an active behavior pretty much by definition. So I am really not
> > following you here. Your agent can simply scan the address space of the
> > application it is going to "freeze" and call pidfd_madvise(MADV_PAGEOUT)
> > on the private memory is that is really what you want/need.
>
> There is a key point here. We want to use the grouping policy of memcg
> to perform proactive reclamation with certain tendencies. Your
> suggestion is to reclaim memory by scanning the task process space.
> However, in the mobile field, memory is usually viewed at the
> granularity of an APP.

OK, sthis is likely a terminology gap on my end. By application you do
not really mean a process but rather a whole cgroup. That would have
been really useful to be explicit about.
 
> Therefore, after an APP is frozen, we hope to reclaim memory uniformly
> according to the pre-grouped APP processes.
> 
> Of course, as you suggested, madvise can also achieve this, but
> implementing it in the agent may be more complex.(In terms of
> achieving the same goal, using memcg to group all the processes of an
> APP and perform proactive reclamation is simpler than using madvise
> and scanning multiple processes of an application using an agent?)

It might be more involved but the primary question is whether it is
usable for the specific use case. Madvise interface is not LRU aware but
you are not really talking about that to be a requirement? So it would
really help if you go deeper into details on how is the interface
actually supposed to be used in your case.

Also make sure to exaplain why you cannot use other existing interfaces.
For example, why you simply don't decrease the limit of the frozen
cgroup and rely on the normal reclaim process to evict the most cold
memory? What are you basing your anon vs. file proportion decision on?

In other words more details, ideally with some numbers and make sure to
describe why existing APIs cannot be used. 
-- 
Michal Hocko
SUSE Labs

