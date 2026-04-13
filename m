Return-Path: <cgroups+bounces-15265-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eChOG9if3GkEUgkAu9opvQ
	(envelope-from <cgroups+bounces-15265-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:48:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A85D33E880D
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 09:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9A043003817
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2026 07:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2124139D6E8;
	Mon, 13 Apr 2026 07:48:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD36399372
	for <cgroups@vger.kernel.org>; Mon, 13 Apr 2026 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066514; cv=none; b=PG0bAh2mHY7AuC36j7yv2Y+8DnK5ZAoaOB4RAq4G/Xmi0a6MMD/b63iH4zXdUbTswPWNUWc+RlUt5dcZZiQ58oo8PqafsoqGZNVcU/AxnYmBnu9bdDo48AhVzIU0xEnixHkiTFPFCjYU8VaW9ukIdHScZ7xYApNFoeXu5V6/drs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066514; c=relaxed/simple;
	bh=vB1WPZlxvSm0vTxUoHQZU9/23V/P8iyrYxxYTfv6oMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OM73LGFj/7LeQPgPyS3/boRbCRNTh7p48CTkvNY1+/NaXzPO1lIqW6/rZAVMOqASjN9IZX04J+zrjedv2OBKiTujhev3mUGvunXlJQ8UbLr6guL08l69SeYXEHaI9Hjlq0GxD/rK9P+w5UoANKeL6vaEIn+T6TSI4UTBtw1n48c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 13 Apr 2026 16:33:25 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Mon, 13 Apr 2026 16:33:25 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chuanhua Han <hanchuanhua@oppo.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] mm, swap: fix swapin race that causes inaccurate
 memcg accounting
Message-ID: <adycRemx6QmSOX8n@yjaykim-PowerEdge-T330>
References: <20260407-swap-memcg-fix-v1-0-a473ce2e5bb8@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-swap-memcg-fix-v1-0-a473ce2e5bb8@tencent.com>
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15265-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kvack.org,kernel.org,linux.dev,linux-foundation.org,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,ghiti.fr,oracle.com,google.com,suse.com,linux.alibaba.com,oppo.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A85D33E880D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 10:55:41PM +0800, Kairui Song via B4 Relay wrote:
> While doing code inspection, I noticed there is a long-existing issue
> THP swapin may got charged into the wrong memcg since commit
> 242d12c981745 ("mm: support large folios swap-in for sync io devices").
> And a recent fix made it a bit worse.
> 
> The error seem not serious. The worst that could happen is slightly
> inaccurate memcg accounting as the charge will go to an unexpected but
> somehow still relevant memcg. The chance is seems extremely low.
> This issue will be fixed (and found during the rebase of) swap table P4
> but may worth a separate fix. Sending as RFC first in case I'm missing
> anything, or I'm overlooking the result, or overthinking about it.
> 
> And recent commit 9acbe135588e ("mm/swap: fix swap cache memcg
> accounting") extended this issue for ordinary swap too (see patch 1 in
> this series). The chance is still extremely low and doesn't seem to have
> a significant negative result.
> 
> The problem occurs when swapin tries to allocate and charge a swapin
> folio without holding any lock or pinning the swap slot first. It's
> possible that the page table or mapping may change. Another thread may
> swap in and free these memory, the swap slots are also freed. Then if
> another mem cgroup faulted these memory again, thing get messy.
> 
> Usually, this is still fine since the user of the charged folio -
> swapin, anon or shmem, will double check if the page table or mapping
> is still the same and abort if not. But the PTE or mapping entry could
> got swapped out again using the same swap entry. Now the page table or
> mapping does look the same. But the swapout is done after the resource
> is owned by another cgroup (e.g. by MADV & realloc), then, back to the
> initial caller the start the swapin and charged the folio, it can keep
> using the old charged folio, which means we chaged into a wrong cgroup.
> 
> The problem is similar to what we fixed with commit 13ddaf26be324
> ("mm/swap: fix race when skipping swapcache"). There is no data
> corruption since IO is guarded by swap cache or the old HAS_CACHE
> bit in commit 242d12c981745 ("mm: support large folios swap-in for sync
> io devices").
> 
> The chance should be extremely low, it requires multiple cgroups to hit
> a set of rare time windows in a row together, so far I haven't found a
> good way to reproduce it, but in theory it is possible, and at least
> looks risky:
> 
> CPU0 (memcg0 runnig)                | CPU1 (also memcg0 running)
>                                     |
> do_swap_page() of entry X           |
> <direct swapin path>                |
> <alloc folio A, charge into memcg0> |
> ... interrupted ...                 |
>                                     | do_swap_page() of same entry X
>                                     | <finish swapin>
>                                     | set_pte_at() - a folio installed
>                                     | <frees the folio with MADV_FREE>
>                                     | <migrate to another *memcg1*>
>                                     | <fault and install another folio>
>                                     |   the folio belong to *memcg 1*
>                                     | <swapout the using same entry X>
> ... continue ...                    |   now entry X belongs to *memcg 1*
> pte_same() <- Check pass, PTE seems |
>               unchanged, but now    |
>               belong to memcg1.     |
> set_pte_at() <- folio A installed,  |
>                 memcg0 is charged.  |
> 
> The folio got charged to memcg0, but it really should be charged to
> memcg1 as the PTE / folio is owned by memcg1 before the last swapout.
> Fortunately there is no leak, swap accounting will still be uncharging
> memcg1. memcg0 is not completely irrelevant as it's true that it is now
> memcg1 faulting this folio. Shmem may have similar issue.
> 
> Patch 1 fixes this issue for order 0 / non-SYNCHRONOUS_IO swapin, Patch
> 2 fixes this issue for SYNCHRONOUS_IO swapin.
> 
> If we consider this problem trivial, I suggest we fix it for order 0
> swapin first since that's a more common and recent issue since a recent
> commit.
> 
> SYNCHRONOUS_IO fix seems also good, but it changes the current fallback
> logic. Instead of fallback to next order it will fallback to order 0
> directly. That should be fine though. This issue can be fixed / cleaned
> up in a better way with swap table P4 as demostrated previously by
> allocating the folio in swap cache directly with proper fallback and a
> more compat loop for error handling:
> 
> https://lore.kernel.org/linux-mm/20260220-swap-table-p4-v1-4-104795d19815@tencent.com/

Hello Kairui,

Nice catch!

I have reviewed the proposed patches, and LGTM :D
(For 1/2, flattening the if-statement depth slightly could help readability.
However, since this is planned to be refactored as part of the P4 swap table work,
I think it is fine as is.)

I mostly agree with your rationale.

> memcg0 is not completely irrelevant as it's true that it is now
> memcg1 faulting this folio. Shmem may have similar issue.

That said, I would like to leave one small comment.

My understanding is that if we account based on the folio that was
allocated while running in memcg0 (on CPU 0), then having
set_pte_at() install it with memcg0 already charged may still be
considered acceptable from a acceptable coarse-grained synchronization perspective.
(cuz folio is alloced at the time of "memcg 1 epoch")

Let's think of the situation below

  CPU 0 (memcg0)                 CPU 1
  ---------------------------    -----------------------------
  charge folio to memcg0
  allocate / prepare folio
                                   task migrates to memcg1
  ...
  set_pte_at() installs PTE
  (folio is already charged to memcg0)

In this flow, the charge follows the allocation context (memcg0),
even though the actual PTE installation happens after migration
to memcg1.

I understand that we cannot strictly guarantee correctness without
fully synchronized migration, so this region inherently has some
ambiguity. In that sense, the patch is addressing a corner of that
problem space.

But, I largely agree with your argument (the rationale is sound,
and the change is not intrusive).

I would have no further concerns if the following hold:

- There is a tangible benefit to modifying this patch.
- There is no meaningful behavioral difference between charging
  earlier (current behavior) and charging later (proposed change),
  (e.g especially when memcg limits are hit.)

If those assumptions are correct, I am fully on board.

Best Regards,
Youngjun Park

