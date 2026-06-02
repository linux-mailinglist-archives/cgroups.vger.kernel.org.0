Return-Path: <cgroups+bounces-16535-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIsSMb0qHmqHhgkAu9opvQ
	(envelope-from <cgroups+bounces-16535-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 02:58:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7E6626C0E
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 02:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ED9330107DF
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 00:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7BF31F997;
	Tue,  2 Jun 2026 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5mnDEdT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210A62459EA;
	Tue,  2 Jun 2026 00:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780361823; cv=none; b=oQN3fVj++vX6oc3+cyWa5tYhETesgH6kibo2O/cEyyOLSg8teeFzLmTxJDT9tZQWbKokrS/GZ/2rlprFDYMHY5Z5+IW1cC6eAqdAtij/oL9qwK07WgEmistbGV3sbmtw5MuIwtoT1OVc3yk2ozel2W9KbgKyQ/s3OF/gca8vSVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780361823; c=relaxed/simple;
	bh=i65H/O9UUlO2s7Dspabff4qR2XkhHYoSHFW1aY5tj/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4AzAdUgpYk/CMGDcDnXIDpucImyBY7xY6fsZfqvEXGQBFPayocoHF6+nJPAiyjVnwL67CQDx/iqI+vMt42FbGCHAYW7Z1pxVADtrpFMeN4ymKYAOvOJuDPWJm/Ra3IeGVknjaqcRKhmQHgA5X5fq9iv2L6YflQSYOniuzpoGw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5mnDEdT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9912B1F00893;
	Tue,  2 Jun 2026 00:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780361820;
	bh=T7bQHGZhX9+sHJpAAQcCgYO66iY6em+ApCTpukgWa3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X5mnDEdTO9Je4v7S3JjNNPmfdm02Dpi0LuieTixZSV4wN86PdhIOr3YP08mWc3tke
	 gKSVsPVhO8HO7tn9+hIKGqBVOAJJikTKoKNDZqf16CSCIIGYm9PRunFT+YZl5gt4+G
	 9tBUr5GTXeG+FTMYbyWYxBtuV4qo59oNuVm50OyNNNf9SGYg6tVwtJ/Uc3pwrU0OWM
	 gotfjaTy6wChz5IKDTFA1kWatUy0HEU16usAuswSyn0gyVWjOda6f5c2+JH2pk2EzN
	 UEVvXzZBOej+B4ZkzbzXcwOJgvgTfsIfPOJO1WZFITnQmSdCsBpaWg8K6K6mWUnC6O
	 93RnkBVsJ98tQ==
Date: Tue, 2 Jun 2026 00:56:57 +0000
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
Subject: Re: [PATCH v6 01/22] mm/swap: decouple swap cache from physical swap
 infrastructure
Message-ID: <ah4qS4uE2CBMOWd1@google.com>
References: <20260505153854.1612033-1-nphamcs@gmail.com>
 <20260505153854.1612033-2-nphamcs@gmail.com>
 <agJcCZuLqWwU_sSR@google.com>
 <CAKEwX=PZnKqfriUsPV2whZyqxfCRNy67z7gyrHObEvztDF0_zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=PZnKqfriUsPV2whZyqxfCRNy67z7gyrHObEvztDF0_zg@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16535-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[tencent.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2D7E6626C0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 02:42:19PM -0700, Nhat Pham wrote:
> On Mon, May 11, 2026 at 3:46 PM Yosry Ahmed <yosry@kernel.org> wrote:
> >
> > On Tue, May 05, 2026 at 08:38:30AM -0700, Nhat Pham wrote:
> > > When we virtualize the swap space, we will manage swap cache at the
> > > virtual swap layer. To prepare for this, decouple swap cache from
> > > physical swap infrastructure.
> > >
> > > We will also remove all the swap cache related helpers of swap table. We
> > > will keep the rest of the swap table infrastructure, which will be
> > > repurposed to serve as the rmap (physical -> virtual swap mapping)
> > > later.
> >
> > I didn't look through the entire series, but let me ask the same
> > high-level question I asked before. Instead of moving things out of the
> > swap table, why not reuse the swap table as the representation of the
> > virtual swap space? Seems like most/all metadata is already moved there
> > in a nice concise format.
> 
> The honest answer is I wasn't sure it would work, so I was hacking
> quietly a prototype on my own time :)
> 
> I finally got something that survives stress-ng and constant
> memory.reclaim thrown at it though. I figured I should send it out to
> get feedback before digging myself deeper into that hole:
> 
> https://lore.kernel.org/all/20260528212955.1912856-1-nphamcs@gmail.com/
> 
> There is still a small problem left (the metadata duplication issue
> that Johannes brought up). It is potentially fixable, but I haven't
> actually tried it out yet, so I don't want to overstate here. But take
> a look at it and let me know how you feel about this alternative
> approach!

Thank you! I will take a look!

