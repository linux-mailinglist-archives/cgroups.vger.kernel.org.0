Return-Path: <cgroups+bounces-16491-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBLvOHo1HGoeLgkAu9opvQ
	(envelope-from <cgroups+bounces-16491-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 15:19:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 868A9616536
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 15:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CF56306A9B5
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E28038C400;
	Sun, 31 May 2026 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="keCWFvQw"
X-Original-To: cgroups@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD99B2FFF89;
	Sun, 31 May 2026 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780233119; cv=none; b=BqC0MiBvmG0Zq8DOlgp8ebncn085xUkcvXeHt+E315Gkji1FQKgt/dd6aVp+6MBrcXE4tc3q5Qkw+TpK6snQBAVzsrpaOqzRcTXtfqqe4J2n7nfari+iHKEd/aF+MwJxlVu5F3T9ZxCnAeLrTQoUgCsRF8p7ZMR3gQ7I39sTYI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780233119; c=relaxed/simple;
	bh=FRWwejMWqhLABYkpaQQVKPfwdZrWFD17LI9zpDF1+AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOAhX/3CC3gn5xVhA+Nry83bjkuWrG5HaaBzyz73NVtpzLDt15dQ2fyulbRenC0v/yIL+EnVIKpGxnqB2nKSPd2QadPLveVg33zM9WrRBxb8Ze1Syvc8A9y2P+7YBAhF0wRBmU+RvVjrXSdr+PvLsOW9MezxCd0G0/fFTpcCA3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=keCWFvQw; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780233112; bh=Mr1TwSKmatj/2m2QnGIAam1qjSB1zq1uNQfenesrHOE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=keCWFvQwrAooLA9hIyt99vINxLQZLoZBOcV1sqt5G71DFIDj2JLopfTysjukeYTnG
	 mVqeObGg9eS7jUhK6IHczHXKB2qUGeREwwxNUp+OrkquzHjT3JtJ1TSCGW8grwYROF
	 qus3pWp05iNrWTXVBdX6JyIcN78m3Vz74f+D4nyg=
Received: from [10.24.9.42] ([123.112.11.230])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 2F0AF885; Sun, 31 May 2026 21:11:48 +0800
X-QQ-mid: xmsmtpt1780233108tekoiylja
Message-ID: <tencent_7577C581F93B0F8D11889B0B8B2A2E876707@qq.com>
X-QQ-XMAILINFO: Nx5J06Esz7r7P/dOXETCc3qUJRi+RIHfWK/c5+SKK3I3LCwYUZz58fbE8ki/C/
	 TGRlcZxk2GIJU4WDlSxdwm0+OgU8L/rxF+8MzxlvBIs4a1OQ8pHXHv6ILp+svRN4Rdk9m7mz1bFQ
	 IGzVxne7Jkm1gkqvJF9S8VZX4lJGnsVkzGjrFn8yAVu6OrFIwdi9XyHJFR3G0ewJ20ec/aeQpYA5
	 LOEmG7eTUcT2nIuP6uzmQN0mOK2q3z01VCbmTq0FZ5PzroscoOhrEyZO6IC4T9EIl+K+4ex7m78V
	 mS06WoNAhACLunlj0i/CdqP/yQYUKTzi5M/mq2XiSAbj45A7QCgllDLG72JYXUW9gQ0Q2hyEOmD9
	 NGmmvIK9YZpCSOJPojO0FksiATbJDRMvdGp1vV0LnR9Q4/Umn16fYlwbhEo/lpVLfnNXnvz36wrC
	 jgpw24zEAO4dyE+64Y9kU1QFyvb4hkKJtTlc6V5QL5QfT3Y/ENAKrRXcCYcQiY8n83f/ajO8h0bv
	 Scs3coLI8iltq05xBsT3p1GwW4IwPFAo3ntQE776lBfP+jZG1IWY3oRX6gyJKLlm17ct98vIHUwW
	 FqA2uSnml+Ahn7W2geghkdQo5XGChHZhS+1/68PQue6D8wq/9cP40OSfYzrAekGftiiG28Ne4uJv
	 iGRhVkNHbSUyN7HeghXVBDoD+NpiNoP38HgzWt2QWpGgXAkz4Y0kMVrD3zYPsA8bGx1olgHO1sjM
	 LizvBv/ElMywemUejBGnRkxYvhGg8uqFQN4X+iMzwPmUW94pN5XBSbEjngXTVDJD5bzLPQNDnI8/
	 33ISNLrfsV0MoUuggQRfTu7GpyM5ClNEENVA6ZiuCV2JSB8zplwLM9rOHkTJbRATFZ01VP5p2V/8
	 o8u23JaR/46P63O4NwDpfcXZbniSwFAPPvRiGXmSJh7HqLG7fYYmQpd0j7rTYBkpFgmCpM9TumSu
	 5/OWob19ztuYnlQMkgW5Sh8zGYduv/r3SzJeMbrLBzloXOw8fXSzWUNDPLluO9Dx7buerPYEEo16
	 yFtPMKldPSH0DPiEc12uv8NmtxqvOUuaoqHmt4ZAC965shOfXOev52CMF46VG89AJIS2mZofhbFn
	 ubvG35dSBTBVJstOmNB8vewEDoyQ==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-OQ-MSGID: <e0d41c89-877f-41fa-9b50-f26275c86475@qq.com>
Date: Sun, 31 May 2026 21:11:48 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 6/9] mm: provide anon locality evidence for zswap
 large swapin
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
 <tencent_913470853E9B289ECF0379248E24DFB4590A@qq.com>
 <CAKEwX=MDSwMoU-=h3NOG==-ru+qT3LeTi2_PADLWFXBB9aZZ+w@mail.gmail.com>
From: Fujunjie <fujunjie1@qq.com>
In-Reply-To: <CAKEwX=MDSwMoU-=h3NOG==-ru+qT3LeTi2_PADLWFXBB9aZZ+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16491-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qq.com:email,qq.com:mid,qq.com:dkim]
X-Rspamd-Queue-Id: 868A9616536
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/30/2026 3:22 AM, Nhat Pham wrote:
> On Fri, May 29, 2026 at 5:19 AM fujunjie <fujunjie1@qq.com> wrote:
>>
>> The common zswap large-swapin policy needs locality evidence from
>> callers before it can admit a large folio. For anonymous faults, provide
>> that evidence from existing VMA hints and from the PTE young state left
>> by earlier zswap-backed large swapins.
>>
>> Keep non-faulting PTEs old when mapping a speculative all-zswap large
>> folio. A later fault can then require a dense young previous range before
>> admitting another large swapin without adding VMA state.
> 
> Makes sense to me.
> 
>>
>> This also removes the old zswap-enabled guard from the THP swapin
>> candidate scan. The common swapin path now classifies the backend range
>> and falls back to order-0 for mixed zswap/disk ranges or races.
>>
>> Signed-off-by: fujunjie <fujunjie1@qq.com>
>> ---
>>  mm/memory.c     | 234 +++++++++++++++++++++++++++++++++++++++++++-----
>>  mm/swap.h       |   6 ++
>>  mm/swap_state.c |  15 ++++
>>  3 files changed, 235 insertions(+), 20 deletions(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 92a82008d583..7bbb89632000 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4556,6 +4556,35 @@ static void memcg1_swapin_retry_folio(struct folio *folio,
>>         folio_unlock(folio);
>>  }
>>
>> +static void set_swapin_ptes(struct vm_area_struct *vma,
>> +                           unsigned long address, pte_t *ptep, pte_t pte,
>> +                           unsigned int nr_pages, unsigned int fault_pte_idx,
>> +                           bool fault_only_young)
>> +{
>> +       struct mm_struct *mm = vma->vm_mm;
>> +       pte_t old_pte;
>> +
>> +       if (!fault_only_young || nr_pages == 1) {
>> +               set_ptes(mm, address, ptep, pte, nr_pages);
>> +               return;
>> +       }
>> +
>> +       old_pte = pte_mkold(pte);
>> +       if (fault_pte_idx)
>> +               set_ptes(mm, address, ptep, old_pte, fault_pte_idx);
>> +
>> +       set_pte_at(mm, address + fault_pte_idx * PAGE_SIZE,
>> +                  ptep + fault_pte_idx,
>> +                  pte_mkyoung(pte_advance_pfn(pte, fault_pte_idx)));
> 
> Hmm, does this mean that without THP swapin, the faulting PTE is not
> marked young, but it is marked young if there is a THP swapin. That's
> a behavioral change right? Would this throw off other heuristics
> relying on this bit, or any justification that this is fine?

Thanks.

The intent was not to make the faulting PTE behave differently from the
normal swapin path. In do_swap_page() we first build the PTE with:

		pte = mk_pte(page, vma->vm_page_prot);

and on the common architectures I checked, the normal user pgprot already
contains the accessed/young bit. For example arm64 PAGE_SHARED/PAGE_READONLY
are based on _PAGE_DEFAULT, which includes PTE_AF, and x86 user page
protections also include the accessed bit. So in practice the faulting PTE is
already young after mk_pte() there.Therefore, the default path is originally marked as young.

What I really wanted here is only to keep the speculative neighbouring PTEs
old. A large zswapin may install PTEs for pages that did not fault, and those
should not all look accessed just because mk_pte() produced a young PTE.

But, the explicit pte_mkyoung() on the faulting PTE makes this look
like THP swapin is adding a new behavior.I will try to improve it 
in a way that is less ambiguous.



