Return-Path: <cgroups+bounces-14410-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ6MNfu/n2lOdgQAu9opvQ
	(envelope-from <cgroups+bounces-14410-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 04:37:31 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E601A09CA
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 04:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4D1333019FDC
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 03:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95F738759E;
	Thu, 26 Feb 2026 03:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ak8kXywN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA89A3876AB
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 03:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772077037; cv=pass; b=iFH2WgUjORDRCH3fODz7PQvcB5HoAktyZocNp+UdutCLdFp6TyNfbdCTMQg3IMuSTnpGQZGx6RdumAusoRUwLTtyY5GJZ0AKZ6L6tfF0QInx7t7EpPuH3sLOTTZ6FHI1MK61glJg0XILRTuye67+9xECtMugPrmEn6U80rVAh6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772077037; c=relaxed/simple;
	bh=eDmbVisUP6UCBopfpI9nCzwz9k0gnAH406FQwQQZzbI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o95Yuk6Mya95ehoGOgf9J1PDJb7t3icsWXB0x1mn0sW7+9UhpXHKd/e0YvO+s9ZBHXL3ngFhZYsR4HpXXxQZ8NJy8TEjnC7PmhGJRj3U5/ya4B1WBXNEAm5iVCuMsk7bcptcxjORiFO5LZhD0lEVYTgm+tMSnv9ws05zGyro5H4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ak8kXywN; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-387090ae5b1so3504191fa.0
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 19:37:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772077034; cv=none;
        d=google.com; s=arc-20240605;
        b=PbHU6fiZmR7b3veFxoVEqvN5cICblt7r2aruKzuHIkpF5dJQCd+aDyhd2Pn9AY8YrX
         8uXDaZCimJyf0b/gtMOPrd1odIoVCVQ3pqSQnWLYtvqj5okbF5n4XeWarecJlSpCepgE
         b0NX/IiS23TtELT6kalvaE9MetfIL/uMSlEyQ7FLzocAuMfz29+gcTTbNLp0F7YjVzsW
         +R7RQcjTVsu8HG2sj67/1N/5yNCwhdTZWXYa1SSvO4C3fys8KEqn7WQdID/2GKjeCEq9
         NcqNCXr1z3rOQtgMor4l1EAhQv3AU4vc6sGsE9cLqHkSlAS81vsyEGAzj5ESSJxCYQ5l
         4OOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=jg3R22OOVfrafHOHSh0bSMLnUJD5uZeRUb4Z2gkWz+8=;
        fh=fqfSKoW/AFtvUsq8cvxqNZnp1PFTONJzTLCFyfflCGQ=;
        b=eS/zHqjNVgKspxhHGgTcK3PETQxLRR3S1490tCe1kbyq5soD5MJzZ6ozTXvMFRHsC7
         zFH7WSVjy4Kc5BXM6pDvOlnBrL6nUv/docnssYiWTR9RHy2QlE2oIUUIs0MwEox89HQ4
         t1TnHlFzuQVShgZjuDwZeADwCl2jNxKIyyPo+WseuLRqOnuvGSVKLhcXl80KLRX/WllI
         vEXBkieVHzm6/8UJtwzhHxao1r6LNMDjmT+y8MTrz/mGNZr7iwRWxqp5jUWOI4KnR/zU
         weSXGU3rc14/v6xBTMOlYpQXSDV9cwQQTUNEpMW3pzOA3eHlc11zTYn/bH3yatkV6MEF
         890A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772077034; x=1772681834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jg3R22OOVfrafHOHSh0bSMLnUJD5uZeRUb4Z2gkWz+8=;
        b=Ak8kXywN/x/OiHV9EGthIusApdumKsUcsQTCUTfqmK2JYDjoCb6paETfZbUs7L6y+p
         25CMEqWduuaH79yfQdlpa2G5JPGFyeXFzcd6rzTMW6hlX2twwaPFy+q+zwWLs16mYG/2
         KdHcj3Q0OVKJ9y/VcKKpj/9xpYhTjs3LCj6m1+5CjaZB9aCabkwdA9qVTHA7IlONWVcJ
         qQohdpWgif8xfQ5jXYZfC8ThSVhii9CM8ylvqcI5MpYtNzritcmI6SACsJhqeG+1mhO7
         m5/fINVklZKPmNunclgB57kqylMOvPIIWH6NtzHvt62pHDWY9rZXEUzcQQFIXXldLFPg
         TPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772077034; x=1772681834;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jg3R22OOVfrafHOHSh0bSMLnUJD5uZeRUb4Z2gkWz+8=;
        b=wj9OFTwxwF+FZeJ2K5EaFYzJCqJDuqNXJZUqD0Moy2OePRTuVSLLjGeoK9wt1nH6+N
         t9w/Wh0fddl5PE1mNaMrP5My+NBFOf/e8sHLQpZg/6zCB2u/RKJhAEhWion1fPkCGVlD
         WWUwFXK8Ul7yFd02mHyMC2AvRZp9E8BuDfhXcTFJ8TnshYzF3TK5pUSRdQKR1cz0gz5K
         1ewJtZLMzRXbwCkiR7YInc80zbLHxOBX3GbDu0wkOdl9tBY7QGkuO2W/K1B0F+AZp0BC
         7pbEUbBLPv1M3Lf762fanb3/hJLV1Vy7G9x3M1gFvSKN8cUUheGK2zJS7tXO9suiOQP9
         CkBA==
X-Forwarded-Encrypted: i=1; AJvYcCX2mY98xSPmukwOEv5S/wlRzJ2BSi7UsglYeo41teX0L1pX44O1GaboUCNbLvVaHiGMJ82NtG/S@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu1Y70gBUsKSM0Jjirz+I0ZaK2QC1ZQ59CvgNHhhqgECgwiVjI
	DE85ngLzo/Fgfef7fsimvV4B7yKrBMWtBOxQXa7AhjiIq1mrUorXe1sP84JXWerGTBeE8QwHW1N
	jR/AEPu2rPeUnIKwrPo90C5ZbuGxxr77q3UHOpVKX
X-Gm-Gg: ATEYQzwx3a6lWJfqgIf7VX4RrIjtT+dZsG5KQHHEvLG0HUx29TQ+glG0PvHsIGxbhlC
	NXz47Yw3WHIRyQA7ghwKN9oKnlNWn9kqNG7pQ8yAMCybDw7PTfIH0fEGOUnx76OvxdXwVy/9G0D
	GxGojObRNx5X8zXUbPkdqw0u3GnDDGpabrm6j6Ln4PLwKikzp8j7uEN0fMKE1h/+MF0gUh10xnB
	58rL2yoxAxnfhUUAs2LwNgoEDX0ha3PPmZeAwPTH6jPetEDQ8/fk9spQdP5IhUCZcED2VEOIdUR
	NpaQ5BlOKARJ7az4UuErI6Hnaz41pXGycfxlOK34JMLGh8W9lJSqLy+zva3s/FtNsZZjzg==
X-Received: by 2002:a05:6512:3d8b:b0:59e:5c8f:75ff with SMTP id
 2adb3069b0e04-5a105eacea6mr921238e87.35.1772077033614; Wed, 25 Feb 2026
 19:37:13 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Feb 2026 19:37:04 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Feb 2026 19:37:04 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260225202437.4077364-1-joshua.hahnjy@gmail.com>
References: <20260225202437.4077364-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Feb 2026 19:37:04 -0800
X-Gm-Features: AaiRm50_sTs9jAEWMqZ835Cj7pEpp2iIBtsZ9twJbpGr-Sc3zM2ecvbh25350Y4
Message-ID: <CAEvNRgGaJXbOGPQSgvo3rVDfis22DC4hYy=2Rczas0Vm3o66kQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/7] Open HugeTLB allocation routine for more
 generic use
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, david@kernel.org, 
	fvdl@google.com, hannes@cmpxchg.org, jgg@nvidia.com, jiaqiyan@google.com, 
	jthoughton@google.com, kalyazin@amazon.com, mhocko@kernel.org, 
	michael.roth@amd.com, muchun.song@linux.dev, osalvador@suse.de, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterx@redhat.com, 
	pratyush@kernel.org, rick.p.edgecombe@intel.com, rientjes@google.com, 
	roman.gushchin@linux.dev, seanjc@google.com, shakeel.butt@linux.dev, 
	shivankg@amd.com, vannapurve@google.com, yan.y.zhao@intel.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14410-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21E601A09CA
X-Rspamd-Action: no action

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On Wed, 11 Feb 2026 16:37:11 -0800 Ackerley Tng <ackerleytng@google.com> wrote:
>
> Hi Ackerly, I hope you're donig well!
>
> [...snip...]
>
>> I would like to get feedback on:
>>
>> 1. Opening up HugeTLB's allocation for more generic use
>
> I'm not entirely familiar with guest_memfd, so pleae excuse my ignorance
> if I'm missing anything obvious.

Happy to take questions! Thank you for your thoughts and reviews!

> But I'm wondering what hugeTLB offers
> that other hugepage solutions cannot offer for guest_memfd, if the
> goal of this series is to decouple it from hugeTLBfs.
>

The one other huge page source that we've explored is THP pages from the
buddy allocator. Compared to HugeTLB, huge pages from the buddy
allocator

+ Has a maximum size of 2M
+ Does not guarantee huge pages the way HugeTLB does - HugeTLB pages are
  allocated at boot, and guest_memfd can reserve pages at guest_memfd
  creation time.
+ Allocation of HugeTLB pages is also really fast, it's just dequeuing
  from a preallocated pool

The last reason to use HugeTLB is not because of any inherent advantage
of using HugeTLB over other sources of huge pages, but for
administrative/scheduling purposes:

  Given that existing non-guest_memfd workloads are already using
  HugeTLB, for optimal scheduling, machine memory is already carved up
  in HugeTLB pages for these workloads. Workloads that require using
  guest_memfd (like Confidential VMs) must also use HugeTLB to
  participate in optimial workload scheduling across machines.

>> 2. Reverting and re-adopting the try-commit-cancel protocol for memory
>>    charging
>
> On the second point, I am wondering if reintroducing the try-commit-cancel
> protocol is tied to factoring out hugetlb_alloc_folio. When I removed
> the protocol a while back, the justification was that for the most part,
> grabbing a hugetlb folio was a relatively cheap & fast operation, since
> hugetlb mostly operates out of a preallocated pool.
>
> So the cost of being wrong, going above the limit, and having to return
> the hugetlb folio was also relatively low.
>

Thanks for this! I saw your patch to just optimistically grab a HugeTLB
page :) For that patch, the primary reason was to simplify the logic,
and the simplification was justifiable because grabbing a folio is
cheap, right? (And so grabbing a folio being cheap wasn't a reason in
itself?)

> It seems like this patch series introduces some new paths for hugetlb
> pages to be consumed (specifically, without a reservation or vma).
> I imagine that these new paths make the slowpath for hugetlb more frequent,
> which makes the cost of assuming that the memcg limit is OK higher?
> I think explicitly spelling this out in the justification for reintroducing
> the charging protocol could be helpful.
>

Yes, I should have done that. Will copy the following to the next
revision.

The main reason is that reintroducing the charging protocol is the
clearest way (for me) to cleanly refactor out hugetlb_alloc_folio()
without worrying about the edge cases around HugeTLB reservations and
charging.

If I didn't reintroduce the charging protocol, I would have to depend on
freeing the new hugetlb folio on memcg charging failure, and the freeing
in turn depends on the subpool correctly being set in the folio, and the
presence of the subpool influences (in free_huge_folio()) whether the
reservation was returned to the global hstate. Aaannnd... there's also a
hugetlb_restore_reserve flag that controls whether to return the folio
to the subpool (and the hstate). I find folio_clear_hugetlb_restore_reserve()
on certain code paths kind of magical/unexplained too.

I would rather iron out those charging and reservation details
separately from this series (with more testing support).


On the other hand, reintroducing the charging protocol has the benefit
of avoiding allocations (not just dequeuing, if surplus HugeTLB pages
are required) if the memcg limit is hit. Also, if the original reason
for removing the protocol was to simplify the code, refactoring out
hugetlb_alloc_folio() also simplifies the code, and I think it's
actually nice that memcg charging is done the same way as the other two
(h_cg and h_cg_rsvd charging). After hugetlb_alloc_folio() is refactored
out, the gotos make all three charging systems consistent and symmetric,
which I think is nice to have :)

I hope the consistent/symmetric charging among all 3 systems is welcome,
what do you think?

> Thank you for the series, again. I hope you have a great day!
> Joshua
>
>> To see how hugetlb_alloc_folio() is used by guest_memfd, the most
>> recent patch series that uses this more generic HugeTLB allocation
>> routine is at [1], and a newer revision of that patch series is at
>> [2].
>>
>> Independently of guest_memfd, I believe this change is useful in
>> simplifying alloc_hugetlb_folio(). alloc_hugetlb_folio() was so
>> coupled to a VMA that even HugeTLBfs allocates HugeTLB folios using a
>> pseudo-VMA.
>>
>> [1] https://lore.kernel.org/all/cover.1747264138.git.ackerleytng@google.com/T/
>> [2] https://github.com/googleprodkernel/linux-cc/tree/wip-gmem-conversions-hugetlb-restructuring-12-08-25
>>
>> Ackerley Tng (7):
>>   mm: hugetlb: Consolidate interpretation of gbl_chg within
>>     alloc_hugetlb_folio()
>>   mm: hugetlb: Move mpol interpretation out of
>>     alloc_buddy_hugetlb_folio_with_mpol()
>>   mm: hugetlb: Move mpol interpretation out of
>>     dequeue_hugetlb_folio_vma()
>>   Revert "memcg/hugetlb: remove memcg hugetlb try-commit-cancel
>>     protocol"
>>   mm: hugetlb: Adopt memcg try-commit-cancel protocol
>>   mm: memcontrol: Remove now-unused function mem_cgroup_charge_hugetlb
>>   mm: hugetlb: Refactor out hugetlb_alloc_folio()
>>
>>  include/linux/hugetlb.h    |  11 ++
>>  include/linux/memcontrol.h |  21 +++-
>>  mm/hugetlb.c               | 228 +++++++++++++++++++++----------------
>>  mm/memcontrol.c            |  77 ++++++++-----
>>  4 files changed, 212 insertions(+), 125 deletions(-)
>>
>>
>> base-commit: db9571a66156bfbc0273e66e5c77923869bda547
>> --
>> 2.53.0.310.g728cabbaf7-goog
>>

