Return-Path: <cgroups+bounces-16589-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L3xTIb+DH2ramgAAu9opvQ
	(envelope-from <cgroups+bounces-16589-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 03:30:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85308633706
	for <lists+cgroups@lfdr.de>; Wed, 03 Jun 2026 03:30:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MYJindhJ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16589-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16589-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0F293021385
	for <lists+cgroups@lfdr.de>; Wed,  3 Jun 2026 01:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34E334846E;
	Wed,  3 Jun 2026 01:29:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FED347BDB;
	Wed,  3 Jun 2026 01:29:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450183; cv=none; b=AM+VAP6W2EB4laoZWsSLFGL56sv2lcdoXQvGgdUglGAke6u1hRzpGAKNP7EuJ5smN3SHK5z2pUZQZbUZ9PUbgtBEh5VV0uCT1MdXH90Lk2Xx5H1U+hxr5i0yOClU7ly8rkO6rC0zhjW+2y3w7Ft+5SxrUSI/7NoYkxN9zyq4YtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450183; c=relaxed/simple;
	bh=rY0fHSMir1YYVWevTpTKeopnJwFcYmQhiMY2RtcQimY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sX8oWH0oZ4uqbgm3Frl0bKGb323pcyZusBy4mkKXmvVI8o4KvbAYTe3wUVnjS4rFxH6JhxhAEE2UL+9Kl/Zf79HRM80HkzJiDz8Y9O0RNSfAMJb/M1NoBOd5vqzASurPuwhIOQd5MIbc+k1KTim4Azvh9qofCQUbWDmFOH2QiFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYJindhJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2672E1F00893;
	Wed,  3 Jun 2026 01:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780450182;
	bh=mZAzYbDB7KwJFZUH3vb8G02tWQdnEGJhvMuTYhptPfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MYJindhJEOgi3egpo83m3LLIjCZkbjHljb1eimGJLVd2HYZEssloRJdsZjHNStpYg
	 Y81g27zHb6dOtsvZIf3UR/rJJxa2sAvqWWYDXmXsALjsh3Wno1queunjXOvTCz3oFH
	 FlCgwRmpHCNWM7Ql8sPDhiYr4PZwIhEuHiqWT6muRp65CpV241uEGPVaesnG8gzQcn
	 4Xx7iARzxHR3xwlfy1D+IsrtYqI5Niqx3bllX97pFE65V53CuA+L6P7L9Xz/M+QNv7
	 rIe4/b4oycBj7Z1TjAXPsdP3w9lAK0ffZolxG7+qHdYMH3bZNDrjc4byNIry7gzmz0
	 rGSNgEddqn5mw==
Date: Wed, 3 Jun 2026 01:29:38 +0000
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
Message-ID: <ah-A2gQ0GPgerXop@google.com>
References: <20260528212955.1912856-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260528212955.1912856-1-nphamcs@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16589-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nphamcs@gmail.com,m:kasong@tencent.com,m:Liam.Howlett@oracle.com,m:akpm@linux-foundation.org,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:baohua@kernel.org,m:baolin.wang@linux.alibaba.com,m:bhe@redhat.com,m:byungchul@sk.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:chrisl@kernel.org,m:corbet@lwn.net,m:david@kernel.org,m:dev.jain@arm.com,m:gourry@gourry.net,m:hannes@cmpxchg.org,m:hughd@google.com,m:jannh@google.com,m:joshua.hahnjy@gmail.com,m:lance.yang@linux.dev,m:lenb@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-pm@vger.kernel.org,m:lorenzo.stoakes@oracle.com,m:matthew.brost@intel.com,m:mhocko@suse.com,m:muchun.song@linux.dev,m:npache@redhat.com,m:pavel@kernel.org,m:peterx@redhat.com,m:peterz@infradead.org,m:pfalcato@suse.de,m:rafael@kernel.org,m:rakie.kim@sk.com,m:roman.gushchin@linux.dev,m:rppt@kernel.org,m:ryan.roberts@arm.com,m:shakeel.butt@linux.dev,m:shikemeng@huaweicloud.com,m:s
 urenb@google.com,m:tglx@kernel.org,m:vbabka@suse.cz,m:weixugc@google.com,m:ying.huang@linux.alibaba.com,m:yosry.ahmed@linux.dev,m:yuanchu@google.com,m:zhengqi.arch@bytedance.com,m:ziy@nvidia.com,m:kernel-team@meta.com,m:riel@surriel.com,m:haowenchao22@gmail.com,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[tencent.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85308633706

> II. Design
> 
> With vswap, pages are assigned virtual swap entries on a ghost device
> with no backing storage. These entries are backed by zswap, zero pages,
> or (lazily) physical swap slots. Physical backing is allocated only
> when needed — on zswap writeback or reclaim writeout, after the rmap
> step.
> 
> Compared to the standalone v6 implementation [1], which introduces a
> 24-byte per-entry swap descriptor and its own cluster allocator, this
> edition uses swap_table infrastructure, and share a lot of the allocator
> logic. Per-slot metadata is stored in a tag-encoded virtual_table
> (atomic_long_t, 8 bytes per slot), and physical clusters store
> Pointer-tagged rmap entries in the swap_table for reverse lookup back to
> the virtual cluster.
> 
> Here are some data layout diagrams:
> 
>   Case 1: vswap entry (virtualized)
> 
>   PTE                  swap_cluster_info_dynamic
>   vswap_entry          +-------------------------+
>   (swp_entry_t) ------>| swap_cluster_info (ci)  |
>                        | +--------------------+  |
>                        | | swap_table         |  |
>                        | |   PFN / Shadow     |  |
>                        | | memcg_table        |  |
>                        | | count,flags,order  |  |
>                        | | lock, list         |  |
>                        | +--------------------+  |
>                        |                         |
>                        | virtual_table           |
>                        | +--------------------+  |
>                        | | NONE               |  |
>                        | | PHYS               |  |
>                        | | ZERO               |  |
>                        | | ZSWAP(entry*)      |  |
>                        | | FOLIO(folio*)      |  |
>                        | +--------------------+  |
>                        +-------------------------+
>                               |
>                               | PHYS resolves to
>                               v
>                        PHYSICAL CLUSTER (swap_cluster_info)
>                        +--------------------------+
>                        | swap_table per-slot:     |
>                        |   NULL   - free          |
>                        |   PFN    - cached folio  |
>                        |   Shadow - swapped out   |
>                        |   Pointer- vswap rmap    |
>                        |   Bad    - unusable      |
>                        |                          |
>                        | Vswap-backing slot:      |
>                        |   Pointer(C|swp_entry_t) |
>                        |     rmap back to vswap   |
>                        +--------------------------+
> 
>   Case 2: direct-mapped physical entry (no vswap)
> 
>   PTE                  PHYSICAL CLUSTER (swap_cluster_info)
>   phys_entry           +--------------------------+
>   (swp_entry_t) ------>| swap_table per-slot:     |
>                        |   NULL   - free          |
>                        |   PFN    - cached folio  |
>                        |   Shadow - swapped out   |
>                        |   Bad    - unusable      |
>                        +--------------------------+
> 
> struct swap_cluster_info_dynamic {
>     struct swap_cluster_info ci;       /* swap_table, lock, etc. */
>     unsigned int index;                /* position in xarray */
>     struct rcu_head rcu;               /* kfree_rcu deferred free */
>     atomic_long_t *virtual_table;      /* backend info, 8 B/slot */
> };
> 
> Each vswap cluster (swap_cluster_info_dynamic) extends the classic
> swap_cluster_info struct with a virtual_table array that stores the
> backend information for each virtual swap entry in the cluster. Each
> entry is tag-encoded in the low 3 bits to indicate backend types:
> 
>   NONE:   |----- 0000 ------|000|  free / unbacked
>   PHYS:   |-- (type:5,off:N)|001|  on a physical swapfile (shifted)
>   ZERO:   |----- 0000 ------|010|  zero-filled page
>   ZSWAP:  |--- zswap_entry* |011|  compressed in zswap
>   FOLIO:  |--- folio* ------|100|  in-memory folio
> 
> We still have room for 3 more future backend types, for e.g. CRAM, i.e
> compressed-CXL-as-swap, which is laid out in [10] and [11]. Worst
> case scenario, we can add more fields to this extended struct.
> 
> Other design points:
> - Both vswap entries (Case 1) and directly-mapped physical entries
>   (Case 2) coexist as first-class citizens. All the common swap
>   code paths — swapout, swapin, swap freeing, swapoff, zswap
>   writeback, THP swapin, etc. work for both. When CONFIG_VSWAP=n,
>   the vswap branches compile out and behavior should be identical to
>   today's swap-table P4 (at least that is my intention).
> - Pointer-tagged swap_table on physical clusters for rmap (physical
>   -> virtual) lookup.
> - Virtual swap slots not backed by physical swap are not charged to
>   memcg swap counters — only physical backing is charged (I made the
>   case for this in [7]).
> - Careful separation of vswap and physical swap allocation paths and
>   structures adds a lot of complexity, but is crucial to make sure
>   both paths are efficient and do not conflict with each other (for
>   correctness and performance). I do re-use a lot of the allocation
>   logic wherever possible though.

Thanks for working on this! I mostly looked at the high-level design and
the zswap parts, as the swap code has changed a lot since I was familiar
with it :)

It seems like the direction being taken here is that we have one
(massive) vswap swap device, and we keep normal physical swap devices
around as well.

A vswap entry can point at a physical swap entry, or zswap, or zeromap.
If a vswap entry points at a physical swap entry, then the physical swap
entry points back at the vswap entry (a reverse mapping).

I assume the main reason here is to avoid the extra overhead if
everything uses vswap, which would mainly be the reverse mapping
overhead? I guess there's also some simplicity that comes from reusing
the swap info infra as a whole, including the swap table.

I don't like that the code bifurcates for vswap vs. normal swap entries
though. Not sure if this is an issue that can be fixed with proper
abstractions to hide it, or if the design needs modifications. I was
honestly really hoping we don't end up with this. I was hoping that the
physical swap device no longer uses a full swap table and all, and
everything goes through vswap.

I hoping that if redirection isn't needed (e.g. zswap is disabled),
vswap can directly encode the physical swap slot so that the reverse
mapping isn't needed -- so we avoid the overhead without keeping the
physical swap device using a fully-fledged swap table.

All that being said, perhaps I am too out of touch with the code to
realize it's simply not possible.

Honestly, if the main reason we can't have a single swap table for vswap
is saving 8 bytes on the reverse mapping, it sounds like a weak-ish
argument, even if we can't optimize the reverse mapping away. But maybe
I am also out of touch with RAM prices :)

I at least hope that, the current design is not painting us into a
corner (e.g. through userspace interfaces), and we can still achieve a
vswap-for-all implementation in the future (maybe that's what you have
in mind already?).

Aside from the swap code, the only sticking point for me is the logic
bifurcation in zswap. Why does zswap need to handle vswap vs. not vswap?
I thought the point of the design is to use vswap when zswap is used,
and otherwise use a normal swap table. In a way, one of the goals is to
make zswap a first class swap citizen, but it doesn't seem like we are
achieving that?

