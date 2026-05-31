Return-Path: <cgroups+bounces-16492-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CoqLHo0HGoeLgkAu9opvQ
	(envelope-from <cgroups+bounces-16492-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 15:15:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FE86164A3
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 15:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A12A230041FB
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 13:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B4A2DCF6C;
	Sun, 31 May 2026 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mMV0wgQO"
X-Original-To: cgroups@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FC22566E9;
	Sun, 31 May 2026 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780233336; cv=none; b=hlJmwNYB746M++VaqGbF/a5pHHik8w5wPmAzWcVXyDmCiHb8NVl5lBHn4lnKb6zaTKXBGLM0KHRHWXtYfmPdWjgO679lqb8lnaNfnWb02yqj1VNNLIYAcJ1S0ZUsMN/4iAzV4Qkre9CuSb3cyaVZFj6eVvcQaI36JxLQUkXmD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780233336; c=relaxed/simple;
	bh=Orxp+Lt6Nhr0NrCmakEc+PhLI0qnlQXllSlhjpbPgxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhEOws0zkHNH2n1ZhJv0+8lY/iPyuMii9EnVJR/cWcUvGJVCF9wESDGx/kUcE0JQtQQ9DekaBEHTwkw4aRhRJ3u5APvc0Qbva/Fx/NTxDbTlZ3WjLbF0unRe55+OExkGDFstF7fc12FBzLCYcyN/hUFY8qJ/ujkoQQalJR1DUdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mMV0wgQO; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780233328; bh=wzh1azNsGu4agZ9079ldQ7Nxhotm0Zj210pDXZgxM9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mMV0wgQOesMnasBPnt+uZMf4oUjW7eO5gRSNtUzK3lopFZT8B32d+iSVdJCzuYYv0
	 4/DO+nbHPZ54EfR/aT5YzuOKujl9uvRgvEKWdc81mavg54smu08zeDr58yjmt724bK
	 faJ6bU+VG+Yt/nLgZMm2R34aLNsOnu+7hSS7aD1A=
Received: from [10.24.9.42] ([123.112.11.230])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 3D88C802; Sun, 31 May 2026 21:15:24 +0800
X-QQ-mid: xmsmtpt1780233324tbr5249au
Message-ID: <tencent_543DFB2916CF1B7AB08ED8DC9059F4715D0A@qq.com>
X-QQ-XMAILINFO: M5WvXNp9ZPrQKmBSC/8k8smxg5o8DbiMky7pj1Ik1NbFeUs9+q5nRwBwAZLJN6
	 Ue9tOqFnCCxXk2STMfbnNBMCtuBWturYoeNfbOV8FHHoF2hFrnFEZ5sJzA8lYLuYDq4XAes+0Dj2
	 L/mBbWDqKdO6GzxPevTVeDDfiQoVswO1D14i0bFl4/Kfm4S5Ko5sq0Q8rlKCI3xWxB/jPt6cmJka
	 X7w3NdDE5YCw+UIKhUqpNkRPXe3f/diM+4OoNTQeQyALXPzPMU/rfEHzp0j08BJzNfsUsz5/UFw2
	 FwQMABCYdpGzdxwFMOImPhIkhczLDDTg3hoXBjfi4OK60rI3NUKhDfer9Xl8DDuRWum9n/z7Incb
	 KpI8mDDmarNIHZK7c1hcS9n4K7slFHIVInBHs2pK2GB8iet7/ZYLMIMU41AEqJsK08MwV2qsUajI
	 UhoycmKER3egsGWBE7hJARYCMpp2bUeVCcPrwdtaJIr2Xgm38KYC6WeGb1UfCeoWWuM53Utmzm57
	 ca3a8YPIZlb4/woGZhgH0OABDdDj8r97AgnWW0rSuKwYQOvG9wPXiTXbxbDYjvUh6O7Csldyt/ES
	 OaMNapes56lBnpJ++Qd/tnYNopodF9WqEFpMNnI9pgpnu9hee2HGTScxZiwuq+8WI9SksEjRuLNC
	 bDexqbW1vwYfuvUxkpfRH4tn9XCZcoYpBrW025MMCoRU0ZzQnt4dPy12wKdVgLsUz1tLLoYVlgrv
	 GMCEpLZ/A3NefPiB7YffG5VcHBuUACRqli8aiEIuubSYlLC2BU6RPrKrQhQtz3CWP1sGaJMi6p80
	 ObLgUpCzmzjCPQHxjcxai/vfysP9IP0U/8MHg96ID6ByUVOdKBWgH/2ILXHrL/FM+gZS4QjC5cSe
	 WAYa/M8PnSgQlukTaWbQNHqNC7WCGtciN/Ceobu4Zk6NouyS/UcNteYRLM5jDH7L/vHYzuKMXTK/
	 op/NI+aQKevAqczGvch/EUSmNZ0hpCN0M89OuuGNdYQBwyqxBACurMxDI3pTxrkeGe55Sft/oBtF
	 zI+DdfbjX+Xk/Djcm0x0go/97nQoEfSkIvSSRqd40djvPn1SgK80T53j2hoSGSFOBdPZN1iM5Ctf
	 MOVYgz
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-OQ-MSGID: <3f60cdfc-04fa-41d5-8a81-cc74d9225664@qq.com>
Date: Sun, 31 May 2026 21:15:24 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/9] mm: admit large swapin by backend range in
 swapin_sync()
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 Alexandre Ghiti <alexghiti@meta.com>, Kairui Song <kasong@tencent.com>,
 Usama Arif <usamaarif642@gmail.com>, Chris Li <chrisl@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>,
 David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
References: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com>
 <tencent_EB78848E34DC7858C873193D67286ECD4B0A@qq.com>
 <CAKEwX=PvcM1u1n8TTikCAaqJN=GtgfwvnXtU2wCf=Qjp6E_Zew@mail.gmail.com>
From: Fujunjie <fujunjie1@qq.com>
In-Reply-To: <CAKEwX=PvcM1u1n8TTikCAaqJN=GtgfwvnXtU2wCf=Qjp6E_Zew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16492-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[qq.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_MUA_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kvack.org,meta.com,tencent.com,gmail.com,kernel.org,cmpxchg.org,google.com,linux.dev,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fujunjie1@qq.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,qq.com:mid,qq.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 54FE86164A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/30/2026 2:34 AM, Nhat Pham wrote:
> On Fri, May 29, 2026 at 5:19 AM fujunjie <fujunjie1@qq.com> wrote:
>>
>> A large swapin can only read one folio when the whole range has compatible
>> backing. Mixed zswap/disk ranges must not reach large-folio IO, and zswap
>> range probes are only snapshots.
>>
>> Filter the orders passed to swap_cache_alloc_folio() in swapin_sync().
>> Uniform zeromap ranges and all-disk ranges keep the existing large swapin
>> path. Fully zswap-backed ranges may be tried. Mixed zswap/disk ranges fall
>> back before allocation.
>>
>> After a large swapcache folio is installed, recheck the zswap range and
>> drop the fresh folio if it became mixed. Also consume -EAGAIN from
>> swap_read_folio() the same way. Both cases retry order-0, where each slot
>> can resolve its current backend independently.
>>
>> Signed-off-by: fujunjie <fujunjie1@qq.com>
>> ---
>>  mm/memcontrol-v1.c |   8 ++-
>>  mm/memory.c        |  31 ++++++++-
>>  mm/swap_state.c    | 169 ++++++++++++++++++++++++++++++++++++++++++---
>>  3 files changed, 194 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
>> index 765069211567..5b11b8055c66 100644
>> --- a/mm/memcontrol-v1.c
>> +++ b/mm/memcontrol-v1.c
>> @@ -682,8 +682,8 @@ void __memcg1_swapout(struct folio *folio, struct swap_cluster_info *ci)
>>   * memcg1_swapin - uncharge swap slot on swapin
>>   * @folio: folio being swapped in
>>   *
>> - * Call this function after successfully adding the charged
>> - * folio to swapcache.
>> + * Call this after the charged folio has been added to swapcache and the caller
>> + * is no longer going to drop it back to swapped-out state.
>>   *
>>   * Context: The folio has to be in swap cache and locked.
>>   */
>> @@ -721,7 +721,9 @@ void memcg1_swapin(struct folio *folio)
>>         id = __swap_cgroup_clear(ci, swp_cluster_offset(folio->swap),
>>                                  nr_pages);
>>         swap_cluster_unlock(ci);
>> -       mem_cgroup_uncharge_swap(id, nr_pages);
>> +
>> +       if (id)
>> +               mem_cgroup_uncharge_swap(id, nr_pages);
>>  }
>>  #endif
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 5a365492a9a2..d73a19692dea 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4538,6 +4538,24 @@ static inline bool should_try_to_free_swap(struct swap_info_struct *si,
>>                 folio_ref_count(folio) == (extra_refs + folio_nr_pages(folio));
>>  }
>>
>> +static void memcg1_swapin_retry_folio(struct folio *folio,
>> +                                     struct vm_fault *vmf)
>> +{
>> +       if (!folio_test_large(folio) || !folio_test_swapcache(folio))
>> +               return;
>> +
>> +       if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT) {
>> +               if (!folio_trylock(folio))
>> +                       return;
>> +       } else {
>> +               folio_lock(folio);
>> +       }
>> +
>> +       if (folio_test_large(folio) && folio_test_swapcache(folio))
>> +               memcg1_swapin(folio);
>> +       folio_unlock(folio);
>> +}
>> +
>>  static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
>>  {
>>         vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
>> @@ -4857,8 +4875,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>
>>         swapcache = folio;
>>         ret |= folio_lock_or_retry(folio, vmf);
>> -       if (ret & VM_FAULT_RETRY)
>> +       if (ret & VM_FAULT_RETRY) {
>> +               memcg1_swapin_retry_folio(folio, vmf);
>>                 goto out_release;
>> +       }
>>
>>         page = folio_file_page(folio, swp_offset(entry));
>>         /*
>> @@ -5067,6 +5087,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>         if (unlikely(folio != swapcache)) {
>>                 folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE);
>>                 folio_add_lru_vma(folio, vma);
>> +               if (folio_test_large(swapcache))
>> +                       memcg1_swapin(swapcache);
>>                 folio_put_swap(swapcache, NULL);
>>         } else if (!folio_test_anon(folio)) {
>>                 /*
>> @@ -5076,6 +5098,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>                 VM_WARN_ON_ONCE_FOLIO(folio_nr_pages(folio) != nr_pages, folio);
>>                 VM_WARN_ON_ONCE_FOLIO(folio_mapped(folio), folio);
>>                 folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
>> +               if (folio_test_large(folio))
>> +                       memcg1_swapin(folio);
>>                 folio_put_swap(folio, NULL);
>>         } else {
>>                 VM_WARN_ON_ONCE(nr_pages != 1 && nr_pages != folio_nr_pages(folio));
>> @@ -5132,8 +5156,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>         if (vmf->pte)
>>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>>  out_page:
>> -       if (folio_test_swapcache(folio))
>> +       if (folio_test_swapcache(folio)) {
>> +               if (folio_test_large(folio))
>> +                       memcg1_swapin(folio);
>>                 folio_free_swap(folio);
>> +       }
>>         folio_unlock(folio);
>>  out_release:
>>         folio_put(folio);
>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>> index d37097913b30..f03ad4832f16 100644
>> --- a/mm/swap_state.c
>> +++ b/mm/swap_state.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/migrate.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/huge_mm.h>
>> +#include <linux/zswap.h>
>>  #include <linux/shmem_fs.h>
>>  #include "internal.h"
>>  #include "swap_table.h"
>> @@ -403,7 +404,8 @@ void __swap_cache_replace_folio(struct swap_cluster_info *ci,
>>  static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
>>                                         swp_entry_t targ_entry, gfp_t gfp,
>>                                         unsigned int order, struct vm_fault *vmf,
>> -                                       struct mempolicy *mpol, pgoff_t ilx)
>> +                                       struct mempolicy *mpol, pgoff_t ilx,
>> +                                       bool defer_memcg1_swapin)
>>  {
>>         int err;
>>         swp_entry_t entry;
>> @@ -466,7 +468,8 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
>>         }
>>
>>         /* memsw uncharges swap when folio is added to swap cache */
>> -       memcg1_swapin(folio);
>> +       if (!defer_memcg1_swapin || !order)
>> +               memcg1_swapin(folio);
>>         if (shadow)
>>                 workingset_refault(folio, shadow);
>>
>> @@ -495,9 +498,12 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
>>   * Return: Returns the folio if allocation succeeded and folio is in the swap
>>   * cache. Returns error code if failed due to race, OOM or invalid arguments.
>>   */
>> -struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
>> -                                    unsigned long orders, struct vm_fault *vmf,
>> -                                    struct mempolicy *mpol, pgoff_t ilx)
>> +static struct folio *__swap_cache_alloc_folio(swp_entry_t targ_entry,
>> +                                             gfp_t gfp, unsigned long orders,
>> +                                             struct vm_fault *vmf,
>> +                                             struct mempolicy *mpol,
>> +                                             pgoff_t ilx,
>> +                                             bool defer_memcg1_swapin)
>>  {
>>         int order, err;
>>         struct folio *ret;
>> @@ -512,7 +518,8 @@ struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
>>
>>         do {
>>                 ret = __swap_cache_alloc(ci, targ_entry, gfp, order,
>> -                                        vmf, mpol, ilx);
>> +                                        vmf, mpol, ilx,
>> +                                        defer_memcg1_swapin);
>>                 if (!IS_ERR(ret))
>>                         break;
>>                 err = PTR_ERR(ret);
>> @@ -525,6 +532,124 @@ struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
>>         return ret;
>>  }
>>
>> +struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
>> +                                    unsigned long orders, struct vm_fault *vmf,
>> +                                    struct mempolicy *mpol, pgoff_t ilx)
>> +{
>> +       return __swap_cache_alloc_folio(targ_entry, gfp, orders, vmf,
>> +                                       mpol, ilx, false);
>> +}
>> +
>> +static struct folio *swap_cache_alloc_speculative_folio(swp_entry_t targ_entry,
>> +                                                       gfp_t gfp,
>> +                                                       unsigned long orders,
>> +                                                       struct vm_fault *vmf,
>> +                                                       struct mempolicy *mpol,
>> +                                                       pgoff_t ilx)
>> +{
>> +       /*
>> +        * Speculative large swapin may drop this fresh swapcache folio and
>> +        * retry order-0 after backend or page-table revalidation. Keep the
>> +        * cgroup v1 memsw swap owner until the caller commits the folio.
>> +        */
>> +       return __swap_cache_alloc_folio(targ_entry, gfp, orders, vmf,
>> +                                       mpol, ilx, true);
>> +}
>> +
>> +static bool swapin_zeromap_same(swp_entry_t entry, unsigned int nr_pages)
>> +{
>> +       unsigned int ci_start = swp_cluster_offset(entry);
>> +       struct swap_cluster_info *ci = __swap_entry_to_cluster(entry);
>> +       bool is_zero;
>> +       unsigned int i;
>> +
>> +       if (ci_start + nr_pages > SWAPFILE_CLUSTER) {
>> +               VM_WARN_ON_ONCE(1);
>> +               return false;
>> +       }
>> +
>> +       rcu_read_lock();
>> +       if (!rcu_dereference(ci->table)) {
>> +               rcu_read_unlock();
>> +               return true;
>> +       }
>> +
>> +       is_zero = __swap_table_test_zero(ci, ci_start);
>> +       for (i = 1; i < nr_pages; i++) {
>> +               if (is_zero != __swap_table_test_zero(ci, ci_start + i)) {
>> +                       rcu_read_unlock();
>> +                       return false;
>> +               }
>> +       }
>> +       rcu_read_unlock();
>> +
>> +       return true;
>> +}
>> +
>> +static unsigned long swapin_admit_orders(swp_entry_t entry,
>> +                                        unsigned long orders)
>> +{
>> +       unsigned long candidates = orders & ~BIT(0);
>> +       unsigned long admitted = orders & BIT(0);
>> +       int order;
>> +
>> +       if (!candidates)
>> +               return orders;
>> +
>> +       while (candidates) {
>> +               enum zswap_range_state state;
>> +               unsigned int nr_pages;
>> +               swp_entry_t range_entry;
>> +               bool admit = false;
>> +
>> +               order = fls_long(candidates) - 1;
>> +               if (order > MAX_PAGE_ORDER) {
>> +                       candidates &= ~BIT(order);
>> +                       continue;
>> +               }
>> +
>> +               nr_pages = 1U << order;
>> +               range_entry = swp_entry(swp_type(entry),
>> +                                       round_down(swp_offset(entry), nr_pages));
>> +               if (!swapin_zeromap_same(range_entry, nr_pages))
>> +                       goto next;
>> +
>> +               state = zswap_probe_range(range_entry, nr_pages);
>> +               switch (state) {
>> +               case ZSWAP_RANGE_MIXED:
>> +                       break;
>> +               case ZSWAP_RANGE_ALL_ZSWAP:
>> +               case ZSWAP_RANGE_NEVER_ENABLED:
>> +               case ZSWAP_RANGE_NO_ZSWAP:
>> +                       admit = true;
>> +                       break;
>> +               }
>> +
>> +next:
>> +               if (admit)
>> +                       admitted |= BIT(order);
>> +               else
>> +                       count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
>> +               candidates &= ~BIT(order);
>> +       }
>> +
>> +       return admitted ? admitted : BIT(0);
>> +}
>> +
>> +static bool zswap_needs_order0_retry(struct folio *folio)
>> +{
>> +       if (!folio_test_large(folio))
>> +               return false;
>> +
>> +       /*
>> +        * Admission sees only an advisory zswap snapshot. Recheck after the
>> +        * large swapcache folio is installed; if the range became mixed, drop
>> +        * the fresh folio before IO and let order-0 handle each slot.
>> +        */
>> +       return zswap_probe_range(folio->swap, folio_nr_pages(folio)) ==
>> +              ZSWAP_RANGE_MIXED;
>> +}
>> +
>>  /*
>>   * If we are the only user, then try to free up the swap cache.
>>   *
>> @@ -634,7 +759,8 @@ static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
>>                 folio = swap_cache_get_folio(entry);
>>                 if (folio)
>>                         return folio;
>> -               folio = swap_cache_alloc_folio(entry, gfp, BIT(0), NULL, mpol, ilx);
>> +               folio = swap_cache_alloc_folio(entry, gfp, BIT(0), NULL,
>> +                                              mpol, ilx);
>>         } while (PTR_ERR(folio) == -EEXIST);
>>
>>         if (IS_ERR_OR_NULL(folio))
>> @@ -677,18 +803,43 @@ struct folio *swapin_sync(swp_entry_t entry, gfp_t gfp, unsigned long orders,
>>         struct folio *folio;
>>         int ret;
>>
>> +       orders = swapin_admit_orders(entry, orders);
>> +again:
>>         do {
>>                 folio = swap_cache_get_folio(entry);
>>                 if (folio)
>>                         return folio;
>> -               folio = swap_cache_alloc_folio(entry, gfp, orders, vmf, mpol, ilx);
>> +               folio = swap_cache_alloc_speculative_folio(entry, gfp, orders,
>> +                                                          vmf, mpol, ilx);
>>         } while (PTR_ERR(folio) == -EEXIST);
>>
>>         if (IS_ERR(folio))
>>                 return folio;
>>
>> +       if (zswap_needs_order0_retry(folio)) {
>> +               count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN_FALLBACK);
>> +               /*
>> +                * The folio is newly allocated, locked, clean and not uptodate;
>> +                * no data has been read into it. Removing it only restores the
>> +                * swap table entries so order-0 swapin can resolve a backend
>> +                * race without attempting speculative large-folio zswapin.
>> +                */
>> +               swap_cache_del_folio(folio);
>> +               folio_unlock(folio);
>> +               folio_put(folio);
>> +               orders = BIT(0);
>> +               goto again;
>> +       }
>> +
>>         ret = swap_read_folio(folio, NULL);
>> -       VM_WARN_ON_ONCE(ret == -EAGAIN);
>> +       if (ret == -EAGAIN) {
> 
> Can this happen? After you add the entire swap range to swap cache,
> backend is locked. Zswap writeback bails out if it fails to add the
> page to swap cache.
> 
> I think you can just check (zswap_probe_range or wev) before
> swap_read_folio(). If the range is still fully backed by zswap, you
> are good to go. Otherwise, bail here immediately.
> 
> Then you don't need all the complexity with extending swap_read_folio
> to handle mixed range errors (for now at least).

Yes, I think you are right.

I missed that property of zswap writeback. Once the whole range is covered by
the large swapcache folio, writeback should not be able to move a subslot to
disk because it has to allocate an order-0 swapcache folio first, and that
should fail.

Sorry for adding this extra complexity. I will rework this in a more unified way for the
next version. 


