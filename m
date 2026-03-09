Return-Path: <cgroups+bounces-14710-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPOOOklwrmlPEQIAu9opvQ
	(envelope-from <cgroups+bounces-14710-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Mar 2026 08:01:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 715722349F5
	for <lists+cgroups@lfdr.de>; Mon, 09 Mar 2026 08:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E63E730466AD
	for <lists+cgroups@lfdr.de>; Mon,  9 Mar 2026 06:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4136134D392;
	Mon,  9 Mar 2026 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AcYPm2Te"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC01362151
	for <cgroups@vger.kernel.org>; Mon,  9 Mar 2026 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773039541; cv=pass; b=R0LZ+NSHWBpfCLN5nxHZGtCF3GQCQn8nyMKvlwn15Ac1ek1lqsE/bxBsigoiFPjMXrsxukOExExLG2IbBdZh9Nq2OiChc/bOd7KLh9kmrkHklLqfGHiQH+FUFavuym98bPZylB/By0zZEmH8tNqXxyW0BZbfFlP/WrgHieBoeMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773039541; c=relaxed/simple;
	bh=1/kPwViiPWB/rLLslnyO1Xv9W8d07mE3sRcTjTuKplE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbtRVnDqaLaawnF9laIA7yh5fSBmG/r39h7f6QA2fdVbG4+fuBrBzt0HozhGyBDwLPmLTMJngbEkL4jkWvvIoCppBv3pXrvycqZPYJrnPOv0r6lP2b5+sAplyTqVI1WCrH/SNM/42D4lF+sv1OVS08Q4D6htoAKDq53qLfRut+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AcYPm2Te; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5ffd797184fso2225144137.0
        for <cgroups@vger.kernel.org>; Sun, 08 Mar 2026 23:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773039538; cv=none;
        d=google.com; s=arc-20240605;
        b=B6z3Ri15cMypxO2YEKMEkHTLTTgJGXzP5/C9OaU+JmYg6EI+uizrnr4EN//TEWszN0
         AP9mqqzFFSY01EtbOkWBknm8nUOrCypdh837RfDdGNgAAdbQx5HA2C66heK3I+884FPG
         vAqrex5MIZWtek5P7I+afSlNoWS++WzqSUl2KtqlIIvM/CyaQ6vcS/J/LLvThi2+6CuK
         NtQ6FuOLHHQ4kZnv6BanUQFCxcLwwGInaC8DrEGGT4gt3eomfJiwWXkhfV05tFvC3wfQ
         W7I01JKBekmed8M5MZ13KujsDl/exxxPRs+QNn3ZnI9A/tmwcUYJh4p/CiCsbLMGWjMu
         eO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Xm+uz1scAwUZE28AuDXf2j1vo8g+3wU8dKlPy71SF1k=;
        fh=1pSubNj+HJSGvb3kzoPEwpsOp+r1gnrouxc5tPvUWEI=;
        b=cY8GPg/EPv+p3wZgbhw30em28eXX99jpd0oB+dbz4REZHIMwsrARPxT/j3q6PrDfIN
         hEDpH8sb6ai4b5FKHnODwJizk/P2BIkN1zMJXEg14xOd+V1WkETgEYOUCHv4uuhJjkhR
         F1FpqAg5+EpMppalJXHaBcDHdww1i5h9aFW0mVPq3HTczsyI9TnwTf+xWFI/kCRMoSV4
         d9aJr3xwQm8UOJsG7pkz5pmSJY9X7S/ezic0DZuzkSHbvPsRvYd6qWSmgt2WoatA3pHH
         FVyAi6egUOk3C4D/lXC7EAe6YCbGNwBVE9ViF3gIpdC7eDNUwa8j9deddCe/+Be91wuy
         2ItA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773039538; x=1773644338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xm+uz1scAwUZE28AuDXf2j1vo8g+3wU8dKlPy71SF1k=;
        b=AcYPm2TehUelka4F9FIDraRQ9hDVBtFvkpd8SCJxZHGkJ712i89GPJroaL1tDK9cTg
         B/KAsP51IBcHvUJHdFDuDBZ0ys8ZHjX3ySZZZybx53dBa9u/9H46F6j0uTVMuIrEHw7i
         fKPrPbRyYq3mI3RKsxyG+2eSBVqNehrGxCbeuGF94NeozyZZlYSLui0p9TcZhwG1YED/
         A09tgnoTj40KJFzXzD00lPuO9FI2YHJD+UfUM9BvtUM39GvasDch8UD1C6fLgwZVb5s6
         GcLq32B+N7FZUKx4p/qhyxrzqf8JtwlH95T/dImhA3QfMDrgST18gp6gV1ZbADv2nWW8
         NQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773039538; x=1773644338;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xm+uz1scAwUZE28AuDXf2j1vo8g+3wU8dKlPy71SF1k=;
        b=dO9Iwkq28r85TyGC0zVjIs4TyYvIeKaGK12oEk6wiMVnZz8GWz32lpyxEBuwHwiQJ2
         8p6qxmUlRv2HGKWi57GRGg7u0M54nheIynDhQx8SUI6UVf0mPWF1laG3yF11bp11h8Ss
         VvXi9xC06XUTJPzncxZXZwmGWRB5zQkWb/ck4tjVTn5o97fJMnRdG+H0mJ4nFp+Zx6LS
         YDurpQxt/4APwrcstfZIO/nu28ME26GDJrndU+pLe0DT/eQxkDqNrlvgjCzJhvcSNvBI
         sfwYsPtyNVPeWOfHtl+XOkrkAUsT58xdirDui1M4q98UeH/ejLE8t4MfUsZWVvfPaURh
         ESXw==
X-Forwarded-Encrypted: i=1; AJvYcCXTtNnyu91hSnydWYu1BF241hTdYrZNlwE7Hw0jQhpBs4T2yisjQpZ2h8yvJUkq2YK7y54oax6h@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQ129U5qfRTwhkqEjyahPwL8ftKogYUcSx33sKDj/NkMw+ksw
	QnLGZk0QosWqltt9dbmTGaRPZHrCssqn4s8HO2KbIZ6exr+WleWYPVeGMTLC4fpgSgilIyT3Irk
	nHgFckjjcCM5/u7WIKpnRzamtRnDb2V2XLr5aJgc6
X-Gm-Gg: ATEYQzxZi/j1Jkn4FdLu65LOZz7GMUsISUbkL4qlOyXscftw9c0ooUcf70i6aFR1gsI
	Hab92kbW1PGeKoL39rqPhThHiXYT2a1jQ7rJxE8vfeOtaofcYQyWqZNSzCyDaBm/hdhZWtvhB3p
	squ/l9EQHtups4nHygNnJA4c1GO/WqnDgL1LOr8KZn54q2DemfCFFf1xIX6O9sSQjsMI6RtQ1pv
	6YRD+dL/+vcSutfwAh/HKxD5DDmPDv4Yb7/xpzf+C+vj1n1cHpW8oxoPLeOO0Hu9EeHjcwBxjuB
	Q7hniX0f61sQkaekyoYnkW1x616NVoz1VQZaiK+l6JqxzXXRN8/ooG3UxfuMYbPTkFru06nh86x
	u6J2a
X-Received: by 2002:a05:6102:e13:b0:600:1547:967c with SMTP id
 ada2fe7eead31-60015479e34mr1563846137.16.1773039538125; Sun, 08 Mar 2026
 23:58:58 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 8 Mar 2026 23:58:57 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 8 Mar 2026 23:58:57 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260226180821.2218448-1-joshua.hahnjy@gmail.com>
References: <20260226180821.2218448-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 8 Mar 2026 23:58:57 -0700
X-Gm-Features: AaiRm52DFXwwe30HaILLP1hzK0v0FaeZdOZHX4R5IM7HVR_30U8T8Nloh1wxEVg
Message-ID: <CAEvNRgFpD0jD8QdmBPz-T=jhGn+Rb8MjTq4aycAUkAx54fMhWg@mail.gmail.com>
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
X-Rspamd-Queue-Id: 715722349F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14710-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.977];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On Wed, 25 Feb 2026 19:37:04 -0800 Ackerley Tng <ackerleytng@google.com> wrote:
>
>> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
>>
>> > On Wed, 11 Feb 2026 16:37:11 -0800 Ackerley Tng <ackerleytng@google.com> wrote:
>> >
>> > Hi Ackerly, I hope you're donig well!
>> >
>> > [...snip...]
>> >
>> >> I would like to get feedback on:
>> >>
>> >> 1. Opening up HugeTLB's allocation for more generic use
>> >
>> > I'm not entirely familiar with guest_memfd, so pleae excuse my ignorance
>> > if I'm missing anything obvious.
>>
>> Happy to take questions! Thank you for your thoughts and reviews!
>
> Of course, thank you for your work, Ackerley!
>
>> > But I'm wondering what hugeTLB offers
>> > that other hugepage solutions cannot offer for guest_memfd, if the
>> > goal of this series is to decouple it from hugeTLBfs.
>> >
>>
>> The one other huge page source that we've explored is THP pages from the
>> buddy allocator. Compared to HugeTLB, huge pages from the buddy
>> allocator
>>
>> + Has a maximum size of 2M
>> + Does not guarantee huge pages the way HugeTLB does - HugeTLB pages are
>>   allocated at boot, and guest_memfd can reserve pages at guest_memfd
>>   creation time.
>> + Allocation of HugeTLB pages is also really fast, it's just dequeuing
>>   from a preallocated pool
>
> All of these make sense. Just wanted to know if guest_memfd had any
> unique usecases for hugeTLB that normal hugetlbfs didn't have.
>

IIUC HugeTLB was meant to make huge pages available to userspace for
performance reasons, guest_memfd wants HugeTLB for the same reason, but
just for virtualization use cases. So nope, I don't think there's any
specifically unique usecases.

These are the differences I can think of between guest_memfd and
HugeTLBfs's usage of HugeTLB:

+ guest_memfd may split HugeTLB pages to individual struct pages during
  guest_memfd's ownership of the HugeTLB page. (The pages will be merged
  before returning them to HugeTLB)

+ guest_memfd will provide an option to remove memory in guest_memfd
  ownership from the kernel direct map - I think HugeTLB pages are
  always in the direct map (?)

+ guest_memfd doesn't want to use HugeTLB surplus pages, for now

+ guest_memfd will reserve pages at fd creation time instead of at mmap
  time. Reservation is done by creating a subpool, so guest_memfd
  doesn't use resv_map.

>> The last reason to use HugeTLB is not because of any inherent advantage
>> of using HugeTLB over other sources of huge pages, but for
>> administrative/scheduling purposes:
>>
>>   Given that existing non-guest_memfd workloads are already using
>>   HugeTLB, for optimal scheduling, machine memory is already carved up
>>   in HugeTLB pages for these workloads. Workloads that require using
>>   guest_memfd (like Confidential VMs) must also use HugeTLB to
>>   participate in optimial workload scheduling across machines.
>>
>>
>> [...snip...]
>>
>> On the other hand, reintroducing the charging protocol has the benefit
>> of avoiding allocations (not just dequeuing, if surplus HugeTLB pages
>> are required) if the memcg limit is hit. Also, if the original reason
>> for removing the protocol was to simplify the code, refactoring out
>> hugetlb_alloc_folio() also simplifies the code, and I think it's
>> actually nice that memcg charging is done the same way as the other two
>> (h_cg and h_cg_rsvd charging). After hugetlb_alloc_folio() is refactored
>> out, the gotos make all three charging systems consistent and symmetric,
>> which I think is nice to have :)
>>
>> I hope the consistent/symmetric charging among all 3 systems is welcome,
>> what do you think?
>
> For the hugetlbfs case, the path to allocate a hugeTLB page on demand
> makes sense, so I definitely see the argument for avoiding allocations.
> Does guest_memfd also have a path to allocate a hugeTLB page outside of
> the boottime reservations? In that case I think it would be nice to
> clarify that the allocation failure case optimization is also for
> guest_memfd, not only for hugetlbfs.
>

For now, guest_memfd actually doesn't want to use surplus pages, so
guest_memfd won't be allocating pages outside of boottime
reservations.

> Symmetric charging is definitely welcome : -) All of your reasons make
> sense to me, I just wanted to ask and make sure.
>

This change is mostly for (an alternate form of) simplicity :)

> Thanks for your thoughts! I hope you have a great day!!
> Joshua

