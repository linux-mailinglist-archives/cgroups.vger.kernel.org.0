Return-Path: <cgroups+bounces-16627-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oFoBNth5IGpI4AAAu9opvQ
	(envelope-from <cgroups+bounces-16627-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 21:00:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DCECC63AB83
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 21:00:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nraqdA1d;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16627-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-16627-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C54D53014A2E
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 19:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9591031B838;
	Wed,  3 Jun 2026 19:00:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F78672603;
	Wed,  3 Jun 2026 19:00:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513228; cv=none; b=qZAh8h3BTuNdY77Mw3kt7I11jBP35Ixxz48YRl2UtFOpWjYzfSkhLyyBPy73rFrwMBXww8+bF1iDJBghIAIrQyMmXFSbLMd0EuWswGAfnEStWMqYFM0A5lQ63e8FkvduC8G93VEIehKuUBBAjjM4kDlijdf6qERizvAV/MunzBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513228; c=relaxed/simple;
	bh=UoXJF4gpcHzZ2PNwYCKqHvbz0z/j1jaCt5hUjQjCPsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qia+g5n2H1n4nmKLtPZgjbFiwClQyFAl+4gRs/vHTzGE9OFPwSKQUeGEX8sq6/hKI/VspZ5EGV9OwH8F6e3/bKKj8t9AUVMYiqraVT/qpCRxW8JFZT8VyBhra74wBEEs5sSSekhkaBgfrwhS4rWk73sxvJCJny0QCKdvqTOS6Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nraqdA1d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CBC1F00893;
	Wed,  3 Jun 2026 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780513227;
	bh=5zbCaKse9V66SE5IfNpASYQVYOGSQeR/Rad19zWfoBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nraqdA1d0f2oiroPaK7Q5IGM8vdNnyflEpyhphrkbAArWnLZ5ZH5Pwg4UH+AZ3KK/
	 nG0e/TxEfVJq4BeAXswX8D0sBuBTHMBsUQPHlwLbvjGyZx06CtIyBjf9Kp8ZHX779d
	 /r/mB51xzJ6sHWmIpysxNuL+fj8ggAhYGIncqYOz7M1NKx/0sCHJPi9KxcYkEA1dJM
	 JaBBQrrd4PmwTA3UAFAdoVMcW1k4bPO/h4G9PyjPUOUTUGMqghDg+60goT0+DIS4Le
	 DnW8d8T/Yc/KvsqmFuwQY2DdwmCx1w3ERg7mnvuo6EAuOC1KccSmvdQE2eLfIwyaTD
	 FvjbTQFbS8H2w==
Date: Wed, 3 Jun 2026 19:00:23 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: kasong@tencent.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, lenb@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org, 
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, tglx@kernel.org, 
	vbabka@suse.cz, weixugc@google.com, ying.huang@linux.alibaba.com, 
	yosry.ahmed@linux.dev, yuanchu@google.com, zhengqi.arch@bytedance.com, ziy@nvidia.com, 
	kernel-team@meta.com, riel@surriel.com, haowenchao22@gmail.com
Subject: Re: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
Message-ID: <aiB5lEMSH97R_aiP@google.com>
References: <20260528212955.1912856-1-nphamcs@gmail.com>
 <ah-A2gQ0GPgerXop@google.com>
 <CAKEwX=MWX9KkSFAoN4xEMg3b+gZUN9=yd7rirAWG5NOBf26eAg@mail.gmail.com>
 <CAKEwX=MZQJLHNNU0tUqnihdhdPdVd19KhC-HtJxfbQ_d8OezzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=MZQJLHNNU0tUqnihdhdPdVd19KhC-HtJxfbQ_d8OezzQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16627-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:kasong@tencent.com,m:Liam.Howlett@oracle.com,m:akpm@linux-foundation.org,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:baohua@kernel.org,m:baolin.wang@linux.alibaba.com,m:bhe@redhat.com,m:byungchul@sk.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:chrisl@kernel.org,m:corbet@lwn.net,m:david@kernel.org,m:dev.jain@arm.com,m:gourry@gourry.net,m:hannes@cmpxchg.org,m:hughd@google.com,m:jannh@google.com,m:joshua.hahnjy@gmail.com,m:lance.yang@linux.dev,m:lenb@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-pm@vger.kernel.org,m:lorenzo.stoakes@oracle.com,m:matthew.brost@intel.com,m:mhocko@suse.com,m:muchun.song@linux.dev,m:npache@redhat.com,m:pavel@kernel.org,m:peterx@redhat.com,m:peterz@infradead.org,m:pfalcato@suse.de,m:rafael@kernel.org,m:rakie.kim@sk.com,m:roman.gushchin@linux.dev,m:rppt@kernel.org,m:ryan.roberts@arm.com,m:shakeel.butt@linux.dev,m:shikemeng@huaweicloud.com,m:s
 urenb@google.com,m:tglx@kernel.org,m:vbabka@suse.cz,m:weixugc@google.com,m:ying.huang@linux.alibaba.com,m:yosry.ahmed@linux.dev,m:yuanchu@google.com,m:zhengqi.arch@bytedance.com,m:ziy@nvidia.com,m:kernel-team@meta.com,m:riel@surriel.com,m:haowenchao22@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[tencent.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCECC63AB83

> > > I don't like that the code bifurcates for vswap vs. normal swap entries
> > > though. Not sure if this is an issue that can be fixed with proper
> > > abstractions to hide it, or if the design needs modifications. I was
> > > honestly really hoping we don't end up with this. I was hoping that the
> > > physical swap device no longer uses a full swap table and all, and
> > > everything goes through vswap.
> > >
> > > I hoping that if redirection isn't needed (e.g. zswap is disabled),
> > > vswap can directly encode the physical swap slot so that the reverse
> > > mapping isn't needed -- so we avoid the overhead without keeping the
> > > physical swap device using a fully-fledged swap table.
> >
> > Can you expand on "vswap can directly encode the physical swap slot"?
> > I'm not sure I follow here.
> >
> > >
> > > All that being said, perhaps I am too out of touch with the code to
> > > realize it's simply not possible.
> > >
> > > Honestly, if the main reason we can't have a single swap table for vswap
> > > is saving 8 bytes on the reverse mapping, it sounds like a weak-ish
> > > argument, even if we can't optimize the reverse mapping away. But maybe
> > > I am also out of touch with RAM prices :)
> >
> > In terms of the space overhead I do agree, FWIW :)
> >
> > I think the other concern is the indirection overhead with going
> > through the xarray for every swap operation, hence the per-CPU vswap
> > cluster lookup caching idea:
> >
> > https://lore.kernel.org/all/20260505153854.1612033-23-nphamcs@gmail.com/
> >
> > >
> > > I at least hope that, the current design is not painting us into a
> > > corner (e.g. through userspace interfaces), and we can still achieve a
> > > vswap-for-all implementation in the future (maybe that's what you have
> > > in mind already?).
> >
> > That's still my plan. Operationally speaking, I want to make this
> > completely transparent to users, with minimal to no performance
> > overhead.
> 
> I do want to add that, even without achieving this, the current design
> already enables a lot of use cases. I think it is a good compromise to
> maintain both virtual and directly mapped physical swap entries for
> now, and revisit the conversation of whether we can afford a mandatory
> vswap layer once all the optimizations have been done :)
> 
> We should strive to simplify the codebase, and it will naturally
> happen when the original overhead concern is no longer there. A
> swap-related example: a few years ago, everyone thought swap slot
> cache was needed. But then, Kairui optimized the swap allocator's lock
> contention issue away, and that swap slot cache is suddenly redundant.
> That finally allowed us to get rid of it. Similar thing happened (or
> is happening?) with the SWP_SYNCHRONOUS_IO swapcache-skipping
> heuristics.

I agree, I just want to make sure we have a line of sight (or at least
no blockers) to having a unified vswap layer in the future.

