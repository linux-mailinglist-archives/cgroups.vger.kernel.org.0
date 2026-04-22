Return-Path: <cgroups+bounces-15463-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLqtDJ8v6WkFVgIAu9opvQ
	(envelope-from <cgroups+bounces-15463-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 22:29:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CDA44A9BF
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 22:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 682B1302C5D7
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 20:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9711C374185;
	Wed, 22 Apr 2026 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uumehj9Y"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5825936C5A1;
	Wed, 22 Apr 2026 20:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776889630; cv=none; b=ddIpr2IfXECHTTBEfcw66E+VII7Rc9kVUjv7ghLCL/ldw+8KanehWKQ2xfrY8HkUzbDAuyKIvTKYhaI7BhjVjR0CDryEUcYyHOhwuz/y+4DVqdpH1UJbU7svvXEJ/KC9WsBfmmf4jylD9mHZybsududYd/R+EEOQVUTv7bkeT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776889630; c=relaxed/simple;
	bh=iAUPsm1LDedItMRxQEDcJahVt/xXTKZHOJ4OvRDP31A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gt380cGVWdoCXj+0wCHEmP5PgymhNXO/OOfz9gF/MePJI8HUNkMXtOJHFPYyIFLIUFeMTwJKsyKdOGeRhnaApxMExxDnZ0mypN3ISN+Hnk3v2LWZ+kvxJT8hghtt54T1KFWw/Ce/L6ZSOkQ8Wmg+Wutf3gRkySdWY5oK9qkDqUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uumehj9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1693BC19425;
	Wed, 22 Apr 2026 20:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776889629;
	bh=iAUPsm1LDedItMRxQEDcJahVt/xXTKZHOJ4OvRDP31A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uumehj9Yhkcy08Kf8dZ5rOV9nlZTiDXyKcpJXqDHKVVoiLk0k4R/Iy6e4t19WkMGG
	 K79QlrrLYLsB3ybo4i+jp5gpal9jxBdG0SseGXmwpqJeEQBj/meOaPH+R8eO4m9C6B
	 04Qpi6ue/mTejuseYYk2F2F0wMb/Pq3coHzcHWBAredtZrQR1mOBynQKXVaK7ySeAh
	 rGK823XHnPX8G1WtvZ6+m/ROAsxVAqC7fH1XwK6oiJM316apDUAUs7oP0hkRXMRG0a
	 6jzoEnGRKMnv0OjAZBjz53YtNgPl9drRCxuEGaxZnOzzeSGNKO8hJqRkjU3FhVfBG7
	 VDOt1f/R7p/BA==
Date: Wed, 22 Apr 2026 20:27:06 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Liam.Howlett@oracle.com, 
	akpm@linux-foundation.org, apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org, 
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
	kernel-team@meta.com, riel@surriel.com
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
Message-ID: <aektdlD4npMVThu3@google.com>
References: <20260320192735.748051-1-nphamcs@gmail.com>
 <aegUoOiUbjUAH5aT@google.com>
 <CAMgjq7C53WRS5oYxO157mX7JxhfoPoi34k+taiKLrMah-b-iRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7C53WRS5oYxO157mX7JxhfoPoi34k+taiKLrMah-b-iRg@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15463-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0CDA44A9BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 10:18:35AM +0800, Kairui Song wrote:
> On Wed, Apr 22, 2026 at 8:26 AM Yosry Ahmed <yosry@kernel.org> wrote:
> >
> > On Fri, Mar 20, 2026 at 12:27:14PM -0700, Nhat Pham wrote:
> > >
> > > This patch series implements the virtual swap space idea, based on Yosry's
> > > proposals at LSFMMBPF 2023 (see [1], [2], [3]), as well as valuable
> > > inputs from Johannes Weiner. The same idea (with different
> > > implementation details) has been floated by Rik van Riel since at least
> > > 2011 (see [8]).
> >
> > Unfortuantely, I haven't been able to keep up with virtual swap and swap
> > table development, as my time is mostly being spent elsewhere these
> > days. I do have a question tho, which might have already been answered
> > or is too naive/stupid -- so apologies in advance.
> 
> Hi Yosry,
> 
> Not a stupid question at all—it's actually spot on. :)
> 
> >
> > Given the recent advancements in the swap table and that most metadata
> > and the swap cache are already being pulled into it, is it possible to
> > use the swap table in the virtual swap layer instead of the xarray?
> >
> > Basically pull the swap table one layer higher, and have it point to
> > either a zswap entry or a physical swap slot (or others in the future)?
> > If my understanding is correct, we kinda get the best of both worlds and
> > reuse the integration already done by the swap table with the swap
> > cache, as well as the lock paritioning.
> >
> > In this world, the clusters would be in the virtual swap space, and we'd
> > create the clusters on-demand as needed.
> >
> > Does this even work or make the least amount of sense (I guess the
> > question is for both Nhat and Kairui)?
> >
> 
> Yes, this absolutely works. In fact, I previously posted a working RFC
> based on this idea. In that series, clusters are dynamically
> allocated, allowing the swap space to be dynamically sized
> (essentially infinite) while reusing all the existing infrastructure:
> https://lore.kernel.org/all/20260220-swap-table-p4-v1-0-104795d19815@tencent.com/

There are a few aspects that I don't agree with in this RFC, and I think
Nhat and Johannes raised most of them. Mostly that I don't want to
expose ghost swapfiles or similar to userspace.

I think userspace's view of swapfiles should remain the same and reflect
the physical swap slots. The virtual swap layer should be completely
transparent in this case. Userspace shouldn't need to configure it in
any way.

In an ideal world, the only noticeable change from userspace is that
with zswap, compressed pages would stop using slots in the swapfile and
charging the memcg for them -- and that zswap would work even without a
swapfile, by just enabling it. This is admittedly a user-visible
behavioral change, but I am hoping that's a good one that we can live
with.

If there are real concerns about this, we can discuss things like a knob
or config option to keep charging zswap pages as swap slots (ew..) or
only allow zswap with a real swapfile (double ew..). But I am really
hoping we can get away with changing the semantics without doing this.

We can add extra interfaces for virtual swap as needed, e.g. virtual
swapoff that you mentioned to clear the swap cache, or stats about the
virtual swap space (which translates to memory overhead).

There are also a few missing pieces like different memcg charging, but
these were already pointed out, and we can figure them out as we go.

Nhat/Johannes, WDYT? Am I missing somthing?

> 
> The only missing pieces are a few helpers like folio_realloc_swap()
> and folio_migrate_swap() for lower layer allocation and migration. I
> prototyped this locally and it wasn't difficult to implement.
> Furthermore, this approach works perfectly with YoungJun's tiering
> work with zero conflicts, the dynamic layer can be runtime or
> per-memcg optional.
> 
> To move this forward, I've stripped out the RFC features and memcg
> behavior changes, and recently sent a V3 that focuses purely on the
> infrastructure. It introduces no behavior changes or new features,
> just optimizations.
> 
> It cleans up a lot of allocation and ordering, as well as memcg
> swap lookups. Since some of these problems were also observed in the
> vss discussion, I think this will make things easier for all of us:
> https://lore.kernel.org/all/20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com/

Yeah I saw that (but didn't really have time to do anything else about
it). Splitting this out is definitely the right thing to do, and the
series looks great from a very high level. Awesome work, as usual :)

