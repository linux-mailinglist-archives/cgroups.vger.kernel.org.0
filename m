Return-Path: <cgroups+bounces-16499-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGU4HB6UHGrEPQkAu9opvQ
	(envelope-from <cgroups+bounces-16499-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 22:03:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75907617D49
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 22:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 382A3300B743
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 20:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F92833F589;
	Sun, 31 May 2026 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VZuHnRA4"
X-Original-To: cgroups@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA4E3161BE;
	Sun, 31 May 2026 20:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780257818; cv=none; b=hYWfrMUMnRUUVW5+ORjNq0bdIVSkzQqognIss9ehlYAbuL62g2R8AfaGdJbjaje2oQoz4NAYUae8VPADUrRsa/0Quvlu74785tfu811EnT3w96PSNuU7V1xFCxz8MK/dcHLVcJ1jVPwnyhKK+c35KAT1jxjale1yrlSfgZ2tYKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780257818; c=relaxed/simple;
	bh=iUwxnc26IK7ptgzqQS/XlouU+NMf6yiwxBnqPczMMVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsxBFDlFsQ1+9etE0Efz4xPItC/HWjmqXWfLE0GyW5V+4GDTIkTCXrsEuqAI9Ty4kV2xG9QM/0VYzzxTFZw2SjEWapHOZ6R+ak6FeyWpov4kLB0vQrRUkdr/Bkbh0tzRbZCAqacL0XvSpUyLlQ/FsEK7RCrOYfNEstZ1hOvT9EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VZuHnRA4; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780257809; bh=9g3uaYpg1TSuNg9AhDCV0iqi6U11btrBtIN4VsIvj84=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VZuHnRA47ulSqc9U5bIOD/xxabhuYDnph/0MUqDjPTK0Mp98mii/yPdtSu8e0fYZ+
	 SQ7uxZ0xrU/z9z2+oAhWZrUJiy0WAUX5CE7NowKDrb3FhtT7aArWgPu3fEn/weOoT7
	 RPMQ65cSuhDNA5un3omkcJNPFxnpUsukvIrrSX2I=
Received: from [IPV6:240e:604:311:3e64:f182:9fe0:c6fb:ae7e] ([240e:604:311:3e64:f182:9fe0:c6fb:ae7e])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id D9B265B; Mon, 01 Jun 2026 04:03:25 +0800
X-QQ-mid: xmsmtpt1780257805tnrsrj7km
Message-ID: <tencent_A78A28F31A1ECA231A375216585C77CFF308@qq.com>
X-QQ-XMAILINFO: MGazITcecnPNZ1vmRk02NFeqPE59pJ3RaLQZt0Nh5WFg4fN3JagoyRGvBiD0t8
	 tc/ArXJQSTBPkFSrrXK9C7InA1xsmo+cgGc2axQQWSi0E7vxCVC7RC1dDr+9yj6Du14sqMT1jMOB
	 88NbCCU7UGZDv7lZBjYBXG1TfnZ8XXNoD7KNspEBPjJWKC1+TFfKv03dPKkOiGBXD+H3Dasmimgc
	 KcX4qFgTPO8xm1OYIXOhUMtEmzcVZ3wWUhhFniCnvRo8WLQxy/eHhY+R3ozyShE3d4gA5JlMKINO
	 nqJ4PAzUFbrzzWXnEwWiu18FwOnwHD4umgrkX8F/Jmn4rkYkMfxl8Wof3LjYo0SKa754h+nm573f
	 j9NzlHmt6GkEQpNHyGmzvEAZp3jleN+L6eKC2S/cyxYB1lgXZQv6fiFPTGzxhnJwiJY41lwtqSiC
	 9U7QnTbthXCBFHBsKGMuGUU3LS4XCegSulWn7LtWUvI22XxvAs1dGo9haBwzqpyA5d+RgCPOSy8r
	 x4Z1EmD7a7WJdvR9bCR98ysax4viHY83btc9Q8/szJySytCfAhNHE+3NCpSz0dfJjgcNzmImCUxL
	 PQPds3N3w3IWfdeasiJ+DSZby9KG6g/q7BmLr5UKZrskEm+/ZmSJ2Oac0m5OhOiV5pUNU2HnUnby
	 ClkB8yzWKRx8r2NQAaYfkEWZvukKdZFpus94kjKDkSSjVvhPxntGZ9G6vM4qVXeQpLS7jvF5omRG
	 HKS9HnLWzm8iyNx4dnJoxjI5Hll6JJQAM514M9i1lGQz18wjpbnnQP5+vhegZyhJq+5NO8xIxseo
	 QC/1lmTmo2vrfiYlv8a/3Pqj9grgUZL/rDm3uxccmGvT7mMhNVFxvgeN2U5oP54bhoWW4nCA1KBT
	 tDLKrGZdcihQqzSmfofxpdpfp8lnxFTov8GY1z+DQkVVmYsqlwVTZjtnCt4hzW/FsqeV1suX5m0f
	 L5XRTcSFNQhMyhuJb11Wfhl1G7YpBV45UN/UoZPJEzvpXqUlq1Mu9uqbrf2aBr1bs5ndkmxnWcau
	 LJk4GvP3YgZUWUUCDDGR9OkO4xmo3hoiXSZKS2SnXJ9DFL2CvoHS/eHgkLpBs=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-OQ-MSGID: <fc695421-1944-42e3-8470-d29cea1d5caa@qq.com>
Date: Mon, 1 Jun 2026 04:03:24 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/9] mm/zswap: support fully zswap-backed large
 folio loads
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
 <tencent_7D186EDC2C9AB9009F9915C1E68F3CF44609@qq.com>
 <CAKEwX=Or6forBoArv1b=MZuhOuF+MTuLLZWPKgUmkBVaoBoYSQ@mail.gmail.com>
From: Fujunjie <fujunjie1@qq.com>
In-Reply-To: <CAKEwX=Or6forBoArv1b=MZuhOuF+MTuLLZWPKgUmkBVaoBoYSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16499-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qq.com:email,qq.com:mid,qq.com:dkim]
X-Rspamd-Queue-Id: 75907617D49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/30/2026 2:25 AM, Nhat Pham wrote:
> On Fri, May 29, 2026 at 5:19 AM fujunjie <fujunjie1@qq.com> wrote:
>>
>> zswap currently refuses large swapcache folios. That is correct for mixed
>> backend ranges, but it also prevents the common swapin path from loading a
>> range that is still fully backed by zswap.
>>
>> Teach zswap_load() to fill a locked large swapcache folio by decompressing
>> each base-page entry into the matching folio offset, then flushing the
>> folio once. A missing entry after zswap data has been seen is reported as
>> -EAGAIN so the caller can drop the speculative large folio and retry
>> order-0.
>>
>> The large load keeps the zswap entries in place. It is a clean speculative
>> fill: until the swap slots are freed, zswap remains the backing copy if
>> reclaim drops the large folio before PTEs are installed.
>>
>> Signed-off-by: fujunjie <fujunjie1@qq.com>
>> ---
>>  mm/zswap.c | 105 ++++++++++++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 87 insertions(+), 18 deletions(-)
>>
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index da5297f7bd69..94ba112a2982 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -15,6 +15,8 @@
>>
>>  #include <linux/module.h>
>>  #include <linux/cpu.h>
>> +#include <linux/mm.h>
>> +#include <linux/huge_mm.h>
>>  #include <linux/highmem.h>
>>  #include <linux/slab.h>
>>  #include <linux/spinlock.h>
>> @@ -934,7 +936,8 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
>>         return comp_ret == 0 && alloc_ret == 0;
>>  }
>>
>> -static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
>> +static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio,
>> +                            unsigned int page_idx, bool flush_dcache)
>>  {
>>         struct zswap_pool *pool = entry->pool;
>>         struct scatterlist input[2]; /* zsmalloc returns an SG list 1-2 entries */
>> @@ -952,14 +955,15 @@ static bool zswap_decompress(struct zswap_entry *entry, struct folio *folio)
>>
>>                 WARN_ON_ONCE(input->length != PAGE_SIZE);
>>
>> -               dst = kmap_local_folio(folio, 0);
>> +               dst = kmap_local_folio(folio, page_idx * PAGE_SIZE);
>>                 memcpy_from_sglist(dst, input, 0, PAGE_SIZE);
>>                 dlen = PAGE_SIZE;
>>                 kunmap_local(dst);
>> -               flush_dcache_folio(folio);
>> +               if (flush_dcache)
>> +                       flush_dcache_folio(folio);
>>         } else {
>>                 sg_init_table(&output, 1);
>> -               sg_set_folio(&output, folio, PAGE_SIZE, 0);
>> +               sg_set_folio(&output, folio, PAGE_SIZE, page_idx * PAGE_SIZE);
>>                 acomp_request_set_params(acomp_ctx->req, input, &output,
>>                                          entry->length, PAGE_SIZE);
>>                 ret = crypto_acomp_decompress(acomp_ctx->req);
>> @@ -1042,7 +1046,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
>>                 goto out;
>>         }
>>
>> -       if (!zswap_decompress(entry, folio)) {
>> +       if (!zswap_decompress(entry, folio, 0, true)) {
>>                 ret = -EIO;
>>                 goto out;
>>         }
>> @@ -1615,10 +1619,9 @@ enum zswap_range_state zswap_probe_range(swp_entry_t swp,
>>   *  NOT marked up-to-date, so that an IO error is emitted (e.g. do_swap_page()
>>   *  will SIGBUS).
>>   *
>> - *  -EINVAL: if the swapped out content was in zswap, but the page belongs
>> - *  to a large folio, which is not supported by zswap. The folio is unlocked,
>> - *  but NOT marked up-to-date, so that an IO error is emitted (e.g.
>> - *  do_swap_page() will SIGBUS).
>> + *  -EAGAIN: if the swapped out content belongs to a large folio, but the
>> + *  range is mixed or raced with writeback. The folio remains locked so the
>> + *  caller can drop the large swapcache folio and retry order-0.
>>   *
>>   *  -ENOENT: if the swapped out content was not in zswap. The folio remains
>>   *  locked on return.
>> @@ -1626,9 +1629,12 @@ enum zswap_range_state zswap_probe_range(swp_entry_t swp,
>>  int zswap_load(struct folio *folio)
>>  {
>>         swp_entry_t swp = folio->swap;
>> +       unsigned int nr_pages = folio_nr_pages(folio);
>> +       unsigned int type = swp_type(swp);
>>         pgoff_t offset = swp_offset(swp);
>> -       struct xarray *tree = swap_zswap_tree(swp);
>> +       struct xarray *tree;
>>         struct zswap_entry *entry;
>> +       unsigned int i;
>>
>>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>>         VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
>> @@ -1636,21 +1642,84 @@ int zswap_load(struct folio *folio)
>>         if (zswap_never_enabled())
>>                 return -ENOENT;
>>
>> -       /*
>> -        * Large folios should not be swapped in while zswap is being used, as
>> -        * they are not properly handled. Zswap does not properly load large
>> -        * folios, and a large folio may only be partially in zswap.
>> -        */
>> -       if (WARN_ON_ONCE(folio_test_large(folio))) {
>> +       if (folio_test_large(folio)) {
>> +               struct obj_cgroup *first_objcg = NULL;
>> +               bool same_objcg = true;
>> +               bool saw_zswap = false;
>> +               bool saw_non_zswap = false;
>> +
>> +               /*
>> +                * The locked large swapcache folio now covers the range and
>> +                * conflicts with zswap writeback's order-0 swapcache allocation.
>> +                * If the range is mixed or an entry disappears, retry order-0.
>> +                */
>> +               for (i = 0; i < nr_pages; i++) {
>> +                       tree = swap_zswap_tree(swp_entry(type, offset + i));
>> +                       entry = xa_load(tree, offset + i);
>> +                       if (!entry) {
>> +                               if (saw_zswap)
>> +                                       return -EAGAIN;
>> +                               saw_non_zswap = true;
>> +                               continue;
>> +                       }
> 
> Can we use xas_load API here instead of traversing down the tree again
> and again?

I'll rework it to use xas_load(), while handling zswap tree boundaries correctly.

> 
>> +                       if (saw_non_zswap)
>> +                               return -EAGAIN;
>> +
>> +                       if (!saw_zswap)
>> +                               first_objcg = entry->objcg;
>> +                       else if (entry->objcg != first_objcg)
>> +                               same_objcg = false;
> 
> Can we get different objcg at this point?

The objcg pointers can be different in principle, for example if
the range is assembled from entries that came from different per-node objcgs
of the same memcg.

But for this accounting path, count_objcg_events() ultimately charges the
event to obj_cgroup_memcg(entry->objcg). Since the large swapcache allocation
has already checked compatible swap ownership for the range, the final memcg
accounting target should be the same even if the objcg pointers differ.

I will simplify this in v3 and avoid the extra objcg equality pass.

> 
>> +                       saw_zswap = true;
>> +               }
>> +               if (!saw_zswap)
>> +                       return -ENOENT;
>> +
>> +               for (i = 0; i < nr_pages; i++) {
>> +                       tree = swap_zswap_tree(swp_entry(type, offset + i));
>> +                       entry = xa_load(tree, offset + i);
>> +                       if (!entry)
>> +                               return -EAGAIN;
>> +
>> +                       if (!zswap_decompress(entry, folio, i, false)) {
>> +                               folio_unlock(folio);
>> +                               return -EIO;
>> +                       }
>> +               }
>> +
>> +               flush_dcache_folio(folio);
>> +               /*
>> +                * Keep zswap entries until swap slots are freed. This is a clean
>> +                * speculative fill; zswap remains the backing copy if reclaim
>> +                * drops the large folio before PTEs are installed.
>> +                */
>> +               folio_mark_uptodate(folio);
>> +               count_vm_events(ZSWPIN, nr_pages);
>> +               count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
>> +
>> +               if (same_objcg) {
>> +                       if (first_objcg)
>> +                               count_objcg_events(first_objcg, ZSWPIN, nr_pages);
>> +               } else {
>> +                       for (i = 0; i < nr_pages; i++) {
>> +                               tree = swap_zswap_tree(swp_entry(type, offset + i));
>> +                               entry = xa_load(tree, offset + i);
>> +                               if (WARN_ON_ONCE(!entry))
>> +                                       continue;
>> +                               if (entry->objcg)
>> +                                       count_objcg_events(entry->objcg, ZSWPIN, 1);
> 
> xas_load() here too?

Yes, same issue here. 

> 
> 
>> +                       }
>> +               }
>> +
>>                 folio_unlock(folio);
>> -               return -EINVAL;
>> +               return 0;
>>         }
> 
>>
>> +       tree = swap_zswap_tree(swp);
>>         entry = xa_load(tree, offset);
>>         if (!entry)
>>                 return -ENOENT;
>>
>> -       if (!zswap_decompress(entry, folio)) {
>> +       if (!zswap_decompress(entry, folio, 0, true)) {
>>                 folio_unlock(folio);
>>                 return -EIO;
>>         }
> 
> I wonder how much of these two paths (order 0 and larger order) can be
> unified...

I think more of this can be unified than this version does.

I split the paths this way because I treated the large-folio load as a
speculative fill and kept the zswap entries as the backing copy. But with
your point that an installed large swapcache folio should block zswap
writeback from turning the range mixed, I should revisit that completion rule
instead of baking it into a separate path.

For the v3 version I will try to collapse the common load path. If the large-folio
case still needs different entry lifetime rules, I will make that distinction
explicit.

> 
>> --
>> 2.34.1
>>



