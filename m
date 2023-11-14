Return-Path: <cgroups+bounces-401-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0C67EAD8A
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 11:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C53281017
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352CF18637;
	Tue, 14 Nov 2023 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Euj6Kvtz"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39425182CB;
	Tue, 14 Nov 2023 10:04:37 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76175197;
	Tue, 14 Nov 2023 02:04:36 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F4852189A;
	Tue, 14 Nov 2023 10:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1699956275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HikEMLbWxEVzvyuBuhlgY1v61UUO53h7x3i8QbDBxPA=;
	b=Euj6KvtzEFXW41rjtYwsll8g5sMbKlmsGymplUNyLRBZpuR27W1ZceHjpTXOQ1UdSepabS
	T4dvs6dnt0gQOvgDjtusoAqjz6hnK9Lj5Y8C8y0QWuwt9s8Zsm4WLzyJIQdFSdqSNyjAEL
	7lFNShTf6XgGpx3WCRg3UMLmgqrBS+Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7CBE13416;
	Tue, 14 Nov 2023 10:04:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id YqE3MjJGU2WnIwAAMHmgww
	(envelope-from <mhocko@suse.com>); Tue, 14 Nov 2023 10:04:34 +0000
Date: Tue, 14 Nov 2023 11:04:34 +0100
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
Message-ID: <ZVNGMmvCmQWSqEyF@tiehlicka>
References: <ZUytB5lSwxeKkBW8@tiehlicka>
 <6b539e16-c835-49ff-9fae-a65960567657@vivo.com>
 <ZUy2-vrqDq7URzb6@tiehlicka>
 <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com>
 <87a5rmiewp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ab108b82-87a9-4927-9d29-f60713281e8a@vivo.com>
 <878r76gsvz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <78128117-ce70-47ef-b7fd-10c772b1c933@vivo.com>
 <ZU4i36tKnyXZ8lZD@tiehlicka>
 <dcd2eff8-400b-4ade-a5b2-becfe26b437b@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcd2eff8-400b-4ade-a5b2-becfe26b437b@vivo.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 BAYES_HAM(-0.00)[25.95%];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[intel.com,kernel.org,bytedance.com,cmpxchg.org,lwn.net,linux.dev,google.com,linux-foundation.org,redhat.com,infradead.org,huawei.com,gmail.com,vger.kernel.org,kvack.org,vivo.com];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[]

On Mon 13-11-23 09:54:55, Huan Yang wrote:
> 
> 在 2023/11/10 20:32, Michal Hocko 写道:
> > On Fri 10-11-23 14:21:17, Huan Yang wrote:
> > [...]
> > > > BTW: how do you know the number of pages to be reclaimed proactively in
> > > > memcg proactive reclaiming based solution?
> > > One point here is that we are not sure how long the frozen application
> > > will be opened, it could be 10 minutes, an hour, or even days.  So we
> > > need to predict and try, gradually reclaim anonymous pages in
> > > proportion, preferably based on the LRU algorithm.  For example, if
> > > the application has been frozen for 10 minutes, reclaim 5% of
> > > anonymous pages; 30min:25%anon, 1hour:75%, 1day:100%.  It is even more
> > > complicated as it requires adding a mechanism for predicting failure
> > > penalties.
> > Why would make your reclaiming decisions based on time rather than the
> > actual memory demand? I can see how a pro-active reclaim could make a
> > head room for an unexpected memory pressure but applying more pressure
> > just because of inactivity sound rather dubious to me TBH. Why cannot
> > you simply wait for the external memory pressure (e.g. from kswapd) to
> > deal with that based on the demand?
> Because the current kswapd and direct memory reclamation are a passive
> memory reclamation based on the watermark, and in the event of triggering
> these reclamation scenarios, the smoothness of the phone application cannot
> be guaranteed.

OK, so you are worried about latencies on spike memory usage. 

> (We often observe that when the above reclamation is triggered, there
> is a delay in the application startup, usually accompanied by block
> I/O, and some concurrency issues caused by lock design.)

Does that mean you do not have enough head room for kswapd to keep with
the memory demand? It is really hard to discuss this without some actual
numbers or more specifics.
 
> To ensure the smoothness of application startup, we have a module in
> Android called LMKD (formerly known as lowmemorykiller). Based on a
> certain algorithm, LMKD detects if application startup may be delayed
> and proactively kills inactive applications.  (For example, based on
> factors such as refault IO and swap usage.)
> 
> However, this behavior may cause the applications we want to protect
> to be killed, which will result in users having to wait for them to
> restart when they are reopened, which may affect the user
> experience.(For example, if the user wants to reopen the application
> interface they are working on, or re-enter the order interface they
> were viewing.)

This suggests that your LMKD doesn't pick up the right victim to kill.
And I suspect this is a fundamental problem of those pro-active oom
killer solutions.

> Therefore, the above proactive reclamation interface is designed to
> compress memory types with minimal cost for upper-layer applications
> based on reasonable strategies, in order to avoid triggering LMKD or
> memory reclamation as much as possible, even if it is not balanced.

This would suggest that MADV_PAGEOUT is really what you are looking for.
If you really aim at compressing a specific type of memory then tweking
reclaim to achieve that sounds like a shortcut because madvise based
solution is more involved. But that is not a solid justification for
adding a new interface.
-- 
Michal Hocko
SUSE Labs

