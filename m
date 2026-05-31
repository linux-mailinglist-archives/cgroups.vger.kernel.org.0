Return-Path: <cgroups+bounces-16494-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qINXNhI8HGrsLgkAu9opvQ
	(envelope-from <cgroups+bounces-16494-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 15:48:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB02F6166D5
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 15:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4053C3002B31
	for <lists+cgroups@lfdr.de>; Sun, 31 May 2026 13:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D5F23392D;
	Sun, 31 May 2026 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Lh9e10BA"
X-Original-To: cgroups@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3659919CC0C;
	Sun, 31 May 2026 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780235277; cv=none; b=FnuDEpFyKu3FyKWHjWQY8GRmWZyEo3s4xEaQAzONs2JuvCysPIZfM1Mva+Yl4G99e722fatA5sdyFMg0fhfTCnPM0Z8KY7TfuRHwOM9F6CYUFha9p7QxsjrOl7SNtqr+G/EZRF3UIPdMt+duhYpYHdEAqzCMsqaQIT4D9sTr0Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780235277; c=relaxed/simple;
	bh=UaBAMYOMgg8GvKYK28GSwVJoW93kRdQvdtQzWBw7QpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIKOe0zGRAaPyQSRLiyTIQ+wmQQHRt/61JYcPcSGbwFNh4pwkABoKMLuNF9kgUnn5HOuYIU+REuq91pTzm8qbnWhLr711cqKmf9RL+VPr608iCDCywBsRDPoy3QVfgoVYn0B7sf1eNqtqVSYvrWUcgkqXfFsIRA+u0T6P40t0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Lh9e10BA; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780235269; bh=dMgCALuI33oMq+NTpqWsYWT4BttSOIXYqL2dwKqfEiI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Lh9e10BAJ4VMtZOWUmPCoDX2fSZP9rFQEmqrZnaMMRsw2LK4BEGFiwVYGcbS7dK/p
	 cyX0Nbd7Qxe/OLXLtkrThD0rImN3hPDxBPWIGoYSVp9cXZPqA29nqORv4+FSX0mKZP
	 9X7H7PawVbC1bIf2qVXkOacDl9Fq83KNxri1vQmI=
Received: from [10.24.9.42] ([123.112.11.230])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id BEEADE90; Sun, 31 May 2026 21:47:46 +0800
X-QQ-mid: xmsmtpt1780235266tvu621kwx
Message-ID: <tencent_DAA37C24E8A6C1828BABF3B941517B3EC705@qq.com>
X-QQ-XMAILINFO: OOO9dHjlsLs75FAwwwY44DNcKKFwqpomfDQP8q14PQzqqsJzOVCnt5Tp2JaruF
	 MbHAtQZDHeT/fcqyFlm287Hzo8h+BPS0NgG+fuJ7SvJHKDl6L1FWRE9TO208w7IIBd/tjy526wk5
	 LHha8xpiX2poiESu2l2zm0SU9fkkz4++DnNFXvt4UirbGgppKWZe8q/5H0WI2oYkFbrvD87p1YyB
	 FKbqisQQO0pLpUjn/miviAxR5sXo58e+KhHOlGvFbQTL/gnOpinJPtBu6CT/4TUyhrMbndQNad+D
	 cux3V9Js/zVy66JxunhjPqDVAeSjhFljMNiRNXlIR3tAVfMtFS7SrXojqVBhTcf/HADXu7nDx51U
	 vLkY5fpR5kNnh+uEien1vCdIAE3TjHRZP8NxAZZMfO4fSVqgJOINnWlu1lkOxcl4fLB3BlBb9tYB
	 SMSaVRS1JduawaUVHUh1gIh3YS4riMC3FndEfHI2K6YskBy4I/r9iJxsytouVs59wykewx6skWuo
	 50/IN4lVWAreR6KXFrHuc1WqgrTwgcBC3pCFwW1qtzhhtG0z96KE1QTZtjctT4AdRdVoO9IyJ5AG
	 OuxRGkZ9pRzlJVtxEsjTUuD8bU7OzBaQQSQQAcgIVKCm0iZslUvap/GMDDtBk14lMx2yUpzTEm81
	 b4+LU+msuPDcSbNryY292W9z7Rn8JBvUqh35wdu6gIgsUc/nS/tHVIjaeViWNrLKvoganDMss832
	 kfVoMJaAzY2YVg+7vbCMsyuxrKzXLv1FuR2R/b22BdAh/ktL1Zkg0PmkWhOkTsDpodTlfhJZXRtt
	 +MoZl6wjems0prdQAA8wQw9Sc7A5L4WYQ6dN6HJrQCpGZ+huZ9QNqaU++UE6hwqDUSxQz/1rGuPd
	 NF1dpYVB3eU1oiek39tOwC7uSvUNIPrYULaGqnJKAoTyLbYTwcs0pxhefGg5zE/tKMpYoa2eMU1Z
	 S5nr/IXzZuVf6bQA215CO+FdafRvo700U51n54Qim8esxQYkD2QCiaQmXNbQ08sFnLhI8DoYF8kW
	 44g+pOVl2MDkPXmHWqdXVEp/c0D+D6a8qRcgnWcbS/jVHDZwbTQZG22JmDr5WaBbBzAt3BVW9qFH
	 kkfjB3Df9L9FEWP1AJJyC1dsdIig==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-OQ-MSGID: <daad26e0-50c8-40ec-9142-a6c6fad3378a@qq.com>
Date: Sun, 31 May 2026 21:47:46 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/9] mm/zswap: expose range state for swapin policy
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
 <tencent_C78A02F3C41E15233C371816825C7DCF8708@qq.com>
 <CAKEwX=NUQb5b4T49dbRV0_41QYRRuLkQNUg+FVDpJiobCCCh7g@mail.gmail.com>
From: Fujunjie <fujunjie1@qq.com>
In-Reply-To: <CAKEwX=NUQb5b4T49dbRV0_41QYRRuLkQNUg+FVDpJiobCCCh7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16494-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,qq.com:mid,qq.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CB02F6166D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/30/2026 2:35 AM, Nhat Pham wrote:
> On Fri, May 29, 2026 at 5:19 AM fujunjie <fujunjie1@qq.com> wrote:
>>
>> Large folio swapin needs to know whether a candidate swap range is fully
>> backed by zswap before it can choose an order. That decision should stay
>> in common swapin code, not inside zswap.
>>
>> Export two zswap facts for that caller: a lockless range occupancy snapshot
>> and the current zswap reclaim-pressure state. The range state is
>> advisory only. Writeback or invalidation can change the backend after the
>> snapshot, so users must recheck before issuing large-folio IO.
>>
>> Signed-off-by: fujunjie <fujunjie1@qq.com>
>> ---
>>  include/linux/zswap.h | 26 +++++++++++++++++++++++++
>>  mm/zswap.c            | 44 +++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 70 insertions(+)
>>
>> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
>> index 30c193a1207e..8f9aee97517c 100644
>> --- a/include/linux/zswap.h
>> +++ b/include/linux/zswap.h
>> @@ -9,6 +9,18 @@ struct lruvec;
>>
>>  extern atomic_long_t zswap_stored_pages;
>>
>> +/*
>> + * Advisory zswap occupancy snapshot for a swap range. This is not a complete
>> + * backend classifier; callers must recheck before depending on ALL_ZSWAP for
>> + * large-folio IO.
>> + */
>> +enum zswap_range_state {
>> +       ZSWAP_RANGE_NEVER_ENABLED,
>> +       ZSWAP_RANGE_NO_ZSWAP,
>> +       ZSWAP_RANGE_ALL_ZSWAP,
>> +       ZSWAP_RANGE_MIXED,
>> +};
>> +
>>  #ifdef CONFIG_ZSWAP
>>
>>  struct zswap_lruvec_state {
>> @@ -27,6 +39,9 @@ struct zswap_lruvec_state {
>>  unsigned long zswap_total_pages(void);
>>  bool zswap_store(struct folio *folio);
>>  int zswap_load(struct folio *folio);
>> +enum zswap_range_state zswap_probe_range(swp_entry_t swp,
>> +                                        unsigned int nr_pages);
>> +bool zswap_pool_reclaim_pressure(void);
>>  void zswap_invalidate(swp_entry_t swp);
>>  int zswap_swapon(int type, unsigned long nr_pages);
>>  void zswap_swapoff(int type);
>> @@ -49,6 +64,17 @@ static inline int zswap_load(struct folio *folio)
>>         return -ENOENT;
>>  }
>>
>> +static inline enum zswap_range_state zswap_probe_range(swp_entry_t swp,
>> +                                                      unsigned int nr_pages)
>> +{
>> +       return ZSWAP_RANGE_NEVER_ENABLED;
>> +}
>> +
>> +static inline bool zswap_pool_reclaim_pressure(void)
>> +{
>> +       return false;
>> +}
>> +
>>  static inline void zswap_invalidate(swp_entry_t swp) {}
>>  static inline int zswap_swapon(int type, unsigned long nr_pages)
>>  {
>> diff --git a/mm/zswap.c b/mm/zswap.c
>> index 761cd699e0a3..da5297f7bd69 100644
>> --- a/mm/zswap.c
>> +++ b/mm/zswap.c
>> @@ -506,6 +506,19 @@ unsigned long zswap_total_pages(void)
>>         return total;
>>  }
>>
>> +/*
>> + * Expose whether zswap reclaim pressure is active. This is a backend fact:
>> + * zswap_check_limits() sets the state once the pool reaches the hard limit and
>> + * keeps it set until the pool falls below the accept threshold.
>> + */
>> +bool zswap_pool_reclaim_pressure(void)
>> +{
>> +       if (zswap_never_enabled())
>> +               return false;
>> +
>> +       return READ_ONCE(zswap_pool_reached_full);
>> +}
>> +
>>  static bool zswap_check_limits(void)
>>  {
>>         unsigned long cur_pages = zswap_total_pages();
>> @@ -1559,6 +1572,37 @@ bool zswap_store(struct folio *folio)
>>         return ret;
>>  }
>>
>> +enum zswap_range_state zswap_probe_range(swp_entry_t swp,
>> +                                        unsigned int nr_pages)
>> +{
>> +       unsigned int type = swp_type(swp);
>> +       pgoff_t offset = swp_offset(swp);
>> +       bool present = false, missing = false;
>> +       unsigned int i;
>> +
>> +       /*
>> +        * This is an advisory, lockless snapshot for common swapin admission.
>> +        * Callers must recheck before depending on an all-zswap range for IO:
>> +        * concurrent writeback or invalidation can change the backend state.
>> +        */
>> +       if (zswap_never_enabled())
>> +               return ZSWAP_RANGE_NEVER_ENABLED;
>> +
>> +       for (i = 0; i < nr_pages; i++) {
>> +               struct xarray *tree = swap_zswap_tree(swp_entry(type, offset + i));
>> +
>> +               if (xa_load(tree, offset + i))
>> +                       present = true;
>> +               else
>> +                       missing = true;
>> +
>> +               if (present && missing)
>> +                       return ZSWAP_RANGE_MIXED;
>> +       }
> 
> Can we use xas_load() to make this check more efficient? IIUC,
> xa_load() walks the tree every time.
> 
> (We used to use a bitmap here back in frontswap days. Good times....)

Thanks for your review.

I'll switch this to xas_load() in the v3 version.


