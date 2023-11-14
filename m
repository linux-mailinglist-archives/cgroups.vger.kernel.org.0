Return-Path: <cgroups+bounces-407-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 696237EB075
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 14:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9C31C20A66
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 13:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44B23FE2F;
	Tue, 14 Nov 2023 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LUtOFdea"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79C82420C;
	Tue, 14 Nov 2023 13:03:21 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA32131;
	Tue, 14 Nov 2023 05:03:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C7CA01F88C;
	Tue, 14 Nov 2023 13:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1699966998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ffWXtPlsys/5rEUexpHY9hcrypa+3MN4PLEKd6bO20=;
	b=LUtOFdea4AMkCnD714ZHVgskk1uoJAQncBJ8Z4XS7weR++NsgHZyGeqB+t3Nh1+hK3AgBi
	NyM851PGgHCq+G8u6r+Pjl+1HDFyJx80v1d9W13WyQ4z70kjOcPSTO1F1eaJmTibPiPd3V
	91BYS8yU7t34CiVQDvzLEaQ5gPVa0Uo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F4F013460;
	Tue, 14 Nov 2023 13:03:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id XNFPJhZwU2WwfgAAMHmgww
	(envelope-from <mhocko@suse.com>); Tue, 14 Nov 2023 13:03:18 +0000
Date: Tue, 14 Nov 2023 14:03:17 +0100
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
Message-ID: <ZVNwFV7Fid34pU-M@tiehlicka>
References: <ZUy2-vrqDq7URzb6@tiehlicka>
 <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com>
 <87a5rmiewp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ab108b82-87a9-4927-9d29-f60713281e8a@vivo.com>
 <878r76gsvz.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <78128117-ce70-47ef-b7fd-10c772b1c933@vivo.com>
 <ZU4i36tKnyXZ8lZD@tiehlicka>
 <dcd2eff8-400b-4ade-a5b2-becfe26b437b@vivo.com>
 <ZVNGMmvCmQWSqEyF@tiehlicka>
 <e5099669-3d99-4a9d-b56e-15ce4fc3f366@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5099669-3d99-4a9d-b56e-15ce4fc3f366@vivo.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -9.10
X-Spamd-Result: default: False [-9.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[intel.com,kernel.org,bytedance.com,cmpxchg.org,lwn.net,linux.dev,google.com,linux-foundation.org,redhat.com,infradead.org,huawei.com,gmail.com,vger.kernel.org,kvack.org,vivo.com];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[]

On Tue 14-11-23 20:37:07, Huan Yang wrote:
> 
> 在 2023/11/14 18:04, Michal Hocko 写道:
> > On Mon 13-11-23 09:54:55, Huan Yang wrote:
> > > 在 2023/11/10 20:32, Michal Hocko 写道:
> > > > On Fri 10-11-23 14:21:17, Huan Yang wrote:
> > > > [...]
> > > > > > BTW: how do you know the number of pages to be reclaimed proactively in
> > > > > > memcg proactive reclaiming based solution?
> > > > > One point here is that we are not sure how long the frozen application
> > > > > will be opened, it could be 10 minutes, an hour, or even days.  So we
> > > > > need to predict and try, gradually reclaim anonymous pages in
> > > > > proportion, preferably based on the LRU algorithm.  For example, if
> > > > > the application has been frozen for 10 minutes, reclaim 5% of
> > > > > anonymous pages; 30min:25%anon, 1hour:75%, 1day:100%.  It is even more
> > > > > complicated as it requires adding a mechanism for predicting failure
> > > > > penalties.
> > > > Why would make your reclaiming decisions based on time rather than the
> > > > actual memory demand? I can see how a pro-active reclaim could make a
> > > > head room for an unexpected memory pressure but applying more pressure
> > > > just because of inactivity sound rather dubious to me TBH. Why cannot
> > > > you simply wait for the external memory pressure (e.g. from kswapd) to
> > > > deal with that based on the demand?
> > > Because the current kswapd and direct memory reclamation are a passive
> > > memory reclamation based on the watermark, and in the event of triggering
> > > these reclamation scenarios, the smoothness of the phone application cannot
> > > be guaranteed.
> > OK, so you are worried about latencies on spike memory usage.
> > 
> > > (We often observe that when the above reclamation is triggered, there
> > > is a delay in the application startup, usually accompanied by block
> > > I/O, and some concurrency issues caused by lock design.)
> > Does that mean you do not have enough head room for kswapd to keep with
>
> Yes, but if set high watermark a little high, the power consumption
> will be very high.  We usually observe that kswapd will run
> frequently.  Even if we have set a low kswapd water level, kswapd CPU
> usage can still be high in some extreme scenarios.(For example, when
> starting a large application that needs to acquire a large amount of
> memory in a short period of time.)However, we will not discuss it in
> detail here, the reasons are quite complex, and we have not yet sorted
> out a complete understanding of them.

This is definitely worth investigating further before resorting to
proposing a new interface. If the kswapd consumes CPU cycles
unproductively then we should look into why.

If there is a big peak memory demand then that surely requires CPU
capacity for the memory reclaim. The work has to be done, whether that
is in kswapd or the pro-active reclaimer context. I can imagine the
latter one could be invoked with a better timing in mind but that is not
a trivial thing to do. There are examples where this could be driven by
PSI feedback loop but from what you have mention earlier you are doing a
idle time based reclaim. Anyway, this is mostly a tuning related
discussion. I wanted to learn more about what you are trying to achieve
and so far it seems to me you are trying to workaround some issues and
a) we would like to learn about those issues and b) a new interface is
unlikely a good fit to paper over a suboptimal behavior.

> > This would suggest that MADV_PAGEOUT is really what you are looking
> > for.
> 
> Yes, I agree, especially to avoid reclaiming shared anonymous pages.
> 
> However, I did some shallow research and found that MADV_PAGEOUT does
> not reclaim pages with mapcount != 1. Our applications are usually
> composed of multiple processes, and some anonymous pages are shared
> among them. When the application is frozen, the memory that is only
> shared among the processes within the application should be released,
> but MADV_PAGEOUT seems not to be suitable for this scenario?(If I
> misunderstood anything, please correct me.)

Hmm, OK it seems that we are hitting some terminology problems. The
discussion was about private memory so far (essentially MAP_PRIVATE)
now you are talking about a shared anonymous memory. That would imply
shmem and that is indeed not supported by MADV_PAGEOUT. The reason for
that is that this poses a security risk for time based attacks. I can
imagine, though, that we could extend the behavior to support shared
mappings if they do not cross a security boundary (e.g. mapped by the
same user). This would require some analysis though.
 
> In addition, I still have doubts that this approach will consume a lot
> of strategy resources, but it is worth studying.

> > If you really aim at compressing a specific type of memory then
> > tweking reclaim to achieve that sounds like a shortcut because
> > madvise based solution is more involved. But that is not a solid
> > justification for adding a new interface.
> Yes, but this RFC is just adding an additional configuration option to
> the proactive reclaim interface. And in the reclaim path, prioritize
> processing these requests with reclaim tendencies. However, using
> `unlikely` judgment should not have much impact.

Just adding an adding configuration option means user interface contract
that needs to be maintained for ever. Our future reclaim algorithm migh
change (and in fact it has already changed quite a bit with MGLRU) and
explicit request for LRU type specific reclaim might not even have any
sense. See that point?

-- 
Michal Hocko
SUSE Labs

