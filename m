Return-Path: <cgroups+bounces-15357-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iE6XJ7nP5GnLaAEAu9opvQ
	(envelope-from <cgroups+bounces-15357-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 19 Apr 2026 14:51:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 042A8423FE0
	for <lists+cgroups@lfdr.de>; Sun, 19 Apr 2026 14:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD86230058F2
	for <lists+cgroups@lfdr.de>; Sun, 19 Apr 2026 12:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1A9369990;
	Sun, 19 Apr 2026 12:50:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B299366DB9
	for <cgroups@vger.kernel.org>; Sun, 19 Apr 2026 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776603059; cv=none; b=mNzqx1BZ2fnkd/CjH5fZ5mBN42g7YZqr+aMBWPsYCzvCwZCdGBUn5m441pa6kxSUSmYVPiGeSeg1K9+7z75uqCGIdQWeaERjtIEY5kPM0mIy13FJoWTK+JvLef2hADfLcie2FfweOh5foRuoeL/AicX68OEIMRwD2TepY3jbaMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776603059; c=relaxed/simple;
	bh=N538DKm8q5qlKojOArT9ZiOv/tIuMvxZTFYXigy2L08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HludSWeo0AusmTpJ7LRcwJaQv9M4fdyfXoAK2ARM+/CDKFedWOWRTmUJL/jptRGp+0OTMHVUflRSk1NyZ8lcIVE5K35cjY2xnPjofqaJC18ckyyHl3JJDBM9ly1gjKiZ6Dtk+o2k403MQ8dYe8xRzQmDUA/ic9jxiv9PyipJ5RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 19 Apr 2026 21:50:47 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sun, 19 Apr 2026 21:50:47 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>,
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH v2 11/11] mm, swap: merge zeromap into swap table
Message-ID: <aeTPpwblIa6LoLk0@yjaykim-PowerEdge-T330>
References: <20260417-swap-table-p4-v2-0-17f5d1015428@tencent.com>
 <20260417-swap-table-p4-v2-11-17f5d1015428@tencent.com>
 <aeN4qzqfyFpWJXYZ@yjaykim-PowerEdge-T330>
 <CAMgjq7CwaKWP_2yxorK88ZLZ-hRRpaLVm76jJE5mLNcX5eCg=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7CwaKWP_2yxorK88ZLZ-hRRpaLVm76jJE5mLNcX5eCg=w@mail.gmail.com>
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15357-lists,cgroups=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 042A8423FE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 18, 2026 at 09:34:35PM +0800, Kairui Song wrote:
> On Sat, Apr 18, 2026 at 8:28 PM YoungJun Park <youngjun.park@lge.com> wrote:
> >
> > On Fri, Apr 17, 2026 at 02:34:41AM +0800, Kairui Song via B4 Relay wrote:
> >
> > >   *
> > >   * Usages:
> > >   *
> > > @@ -74,17 +76,22 @@ struct swap_memcg_table {
> > >  #define SWP_TB_PFN_MARK_BITS 2
> > >  #define SWP_TB_PFN_MARK_MASK (BIT(SWP_TB_PFN_MARK_BITS) - 1)
> > >
> > > -/* SWAP_COUNT part for PFN or shadow, the width can be shrunk or extended */
> > > -#define SWP_TB_COUNT_BITS      min(4, BITS_PER_LONG - SWP_TB_PFN_BITS)
> > > +/* SWAP_COUNT and flags for PFN or shadow, width can be shrunk or extended */
> > > +#define SWP_TB_FLAGS_BITS    min(5, BITS_PER_LONG - SWP_TB_PFN_BITS)
> > > +#define SWP_TB_COUNT_BITS    (SWP_TB_FLAGS_BITS - 1)
> >
> > Hi Kairui :)
> >
> > Would this break the build on 32-bit arches with 40-bit phys
> > addrs (MAX_POSSIBLE_PHYSMEM_BITS = 40)?
> >
> > Architectures I checked.
> >   - ARM LPAE   (CONFIG_ARM_LPAE=y)
> >   - ARC PAE40  (CONFIG_ARC_HAS_PAE40=y)
> >   - MIPS XPA   (CONFIG_XPA=y)
> >
> > Calculations.
> >
> >   SWP_TB_PFN_BITS   = 28 + 2 = 30
> >   SWP_TB_FLAGS_BITS = min(5, 32 - 30) = 2
> >   SWP_TB_COUNT_BITS = 2 - 1 = 1
> >
> > The BUILD_BUG_ON looks like the real problem. it needs at
> > least 3 count values (free/used/overflow).
> >
> >   BUILD_BUG_ON(SWP_TB_COUNT_MAX < 2 || SWP_TB_COUNT_BITS < 2);
> >
> > Confirmed with a cross build (multi_v7_defconfig + lpae.config).
> >
> >   error: BUILD_BUG_ON failed: SWP_TB_COUNT_MAX < 2 || SWP_TB_COUNT_BITS < 2
> >     at __count_to_swp_tb (mm/swap_table.h:227)
> 
> Hi YoungJun
> 
> Nice catch! Thanks a lot :)
> 
> > I think the right fix is widening swap_tb to 64 bits
> > unconditionally (atomic64_t).
> 
> I'm a bit concerned that memory usage on 32 bits will bloat up...
> 
> >
> > (Or, uglier, these arches could always route counts through the
> > extend table.)
> >
> 
> Seems not ugly with a ci->zero_bitmap, looks clean to me, the
> definition will be:
> 
> SWP_TABLE_USE_INLINE_ZEROMAP is true when BITS_PER_LONG is not enough
> for SWP_TB_FLAGS_BITS, then:
> 
> struct swap_cluster_info {
> ...
> #ifndef SWP_TABLE_USE_INLINE_ZEROMAP
>         unsigned long *zero_bitmap;
> #endif
>         ...
> };
> 
> And helpers will be:
> static inline void __swap_table_set_zero(struct swap_cluster_info *ci,
>           unsigned int ci_off)
> {
>         unsigned long swp_tb;
> 
> #ifdef SWP_TABLE_USE_INLINE_ZEROMAP
>         return bitmap_set(&ci->zeromap);
> #else
> 
>         swp_tb = __swap_table_get(ci, ci_off);
>         VM_WARN_ON(!swp_tb_is_countable(swp_tb));
>         swp_tb |= SWP_TB_ZERO_MARK;
>         __swap_table_set(ci, ci_off, swp_tb);
> }
> 
> There are only three helpers in total, looks fine. Allocation part is
> just like the memcg_table. Compared to this version only it seems
> onlys needs a few dozen lines change (A few #ifdef
> SWP_TABLE_USE_INLINE_ZEROMAP) and not hard to understand. How do you
> think?

Hi Kairui,

Sounds good. easy to understand and not many changes.

Another option could be using a 64-bit entry only on LPAE-like arches, 
(not including every 32-bit arch)
though that would mean adding a separate set of atomic64 ops. 

The direction you proposed seems cleaner, so I'm on board. 

Thanks,
YoungJun Park

