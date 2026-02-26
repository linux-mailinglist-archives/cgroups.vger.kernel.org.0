Return-Path: <cgroups+bounces-14439-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA8gAMONoGkokwQAu9opvQ
	(envelope-from <cgroups+bounces-14439-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 19:15:31 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCC71AD6E4
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 19:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37C87300089F
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 18:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A977361674;
	Thu, 26 Feb 2026 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/dllCtX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ED935A3A1
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772129306; cv=none; b=eT0sMp2Jp9VrNBMh/5arTZIarFtJc1A/iRShfK88LiP2w1nYl2+7BZn032J9awmczdw37hTMKIceGymgVocdhy0JfU2g+Zdh29VAV8nJeCcZr/GKrFOxyjYMc0htki2J/aBw9wb8gSVpZWbazxwo51e4wwzTVSHvs2UxVtvs24o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772129306; c=relaxed/simple;
	bh=XrT6+F4L/RdfSwyg3Ac65ntxz3H2SsHPU5uO2O7bnKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7lyiaAuhkiG08ZTIpZ06xYu1H3E0UBTLCIvogJ4XL8Mt0eB28MkwfyHokIdZAYOGxtEx5ReErCCvkVi5sSoMdk3icnwOZlKTCU6c3zJvJk7EwBa3oqbyVAKqInCEM+wZ9mXedSQIRcXD9ubv4o66QpkuFu1/xQcO/OTrOSwErE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/dllCtX; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d18a9d2b1aso1259548a34.2
        for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 10:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772129303; x=1772734103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcq9MDR3n757j4ORZwFr28h6INReHt+LZDRBVW4SzF0=;
        b=J/dllCtXpL1DPs0TPWfxlx9LUW6VL0zoQx54nbCMchOg3/T83WmHxF9u/v2X+NOYFQ
         n5pn50xOxhOPAtLIdLwHPqBUPsfnrEMTj7MJLteJgmEE2Rn0uTiGuIf/vjRHxB+deW2S
         qK8IuOxznSsB+ZSffjU03JuEAuibwsr6NTPKp4FDVjtTlrdBAKcmDhGYD7et25m6FWZR
         Ne91mt8D415tHsqsa5Bv9Jl9P38G0z/z0jA16SoevmSp3tyuHT2iAsCB1/SBCW4WDLki
         Kzdq0rl7F1lEtHAJw9H0Buqxw432wpvRAs0PcnhBS4hKtpXLouLRF9x55W2ItRiNYu4+
         oUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772129303; x=1772734103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wcq9MDR3n757j4ORZwFr28h6INReHt+LZDRBVW4SzF0=;
        b=qxmfxkQKsTJOxOL+PlwTDQN2qhFMXL683LobCMD2i+wMfoQW4l6eOah91z4iwlhK3a
         2DaSOBt+5zBtrUPK2vHW57s8Ga+jeM9/vaRpGv3rmehLmsT1vH0cHZSs5dI951sxm1k5
         Sxr9shbXEiuuo5nWM+OrAgZrhLvbxaOtNQlyxJ0Um8gbVg8yt0t6oyLurOrygGlMRfoz
         o4wddhDUBJ6n5jUo9ZAWFK3IHcsk1BkQKweRqlvvGC+GDWJszdyOuX4M+D7TMfLAgH4Q
         BXFCdOmGTq4x3KKmTwNnEWaWbWKsQoDNDPW8PFK3azM9u4t2+SNijmzQaAHojvvSC7Ji
         ReUA==
X-Forwarded-Encrypted: i=1; AJvYcCXOoNOthbzbsmbXo9z2dfEV+tmuzDy18gS0U4UYJdCbe1h7LY9EXXW6ikSQ/fpJGzHoGXYC+SR2@vger.kernel.org
X-Gm-Message-State: AOJu0YwDEaGxhHGe+N+XgZKMXjrURsCBLRBuj70MXgoUvK6dDH4EpcH7
	6EVxrwniCVPZaqRlLh20Nq/AtBlvXlsWzKzyLFU0J2kz9UVcw7WCCunE
X-Gm-Gg: ATEYQzyC3i2syrOmuTcit+SA9mpDoxgvdv7rmr3c8jm7GpxyD1SpHWPkt4im09vgzIx
	0nx5kBIw/fw6dVeCrtiJH2/7RbX0fiqpLYM8knEP35qDdRx3/a/cpAJNqaw7mln7quX2AUCsy6/
	gDLa+Tr9m6y7guHFkVRVj4bxJu8V/PCI441j5mnQ2UUC1Gl9ZlPL27XODG4xOw/Jlh9lEXLSiWG
	O0X4pTLEg9lh8e4gI9L8nWyVxVPAiT+1XBoEJO0dta8kGx5d+h/k9U4PupPUnJX5uKikiyk15/C
	fslH1sS9qb4wpaQLGM14rJVaa6XDlS8SOFf96fWCQ1Vdnk6zcTG/1A1bG1CMYJoqQgVFDc8LLgM
	7bVZLa/3IPxwmtwEO6cEo3+BLox+22j3LRdQOJDFQdArOKb4X23DX25F9gIFweV/oNP50hfsGSy
	2bq5OZKImrPNT4rVIXhgAA1+fGD7jtBnyg
X-Received: by 2002:a05:6830:6201:b0:7d4:96c3:3f97 with SMTP id 46e09a7af769-7d591b0f5acmr73197a34.2.1772129303538;
        Thu, 26 Feb 2026 10:08:23 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58666ed17sm2433431a34.27.2026.02.26.10.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:08:23 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	david@kernel.org,
	fvdl@google.com,
	hannes@cmpxchg.org,
	jgg@nvidia.com,
	jiaqiyan@google.com,
	jthoughton@google.com,
	kalyazin@amazon.com,
	mhocko@kernel.org,
	michael.roth@amd.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	pasha.tatashin@soleen.com,
	pbonzini@redhat.com,
	peterx@redhat.com,
	pratyush@kernel.org,
	rick.p.edgecombe@intel.com,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	seanjc@google.com,
	shakeel.butt@linux.dev,
	shivankg@amd.com,
	vannapurve@google.com,
	yan.y.zhao@intel.com,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 0/7] Open HugeTLB allocation routine for more generic use
Date: Thu, 26 Feb 2026 10:08:21 -0800
Message-ID: <20260226180821.2218448-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAEvNRgGaJXbOGPQSgvo3rVDfis22DC4hYy=2Rczas0Vm3o66kQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14439-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BCC71AD6E4
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 19:37:04 -0800 Ackerley Tng <ackerleytng@google.com> wrote:

> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> 
> > On Wed, 11 Feb 2026 16:37:11 -0800 Ackerley Tng <ackerleytng@google.com> wrote:
> >
> > Hi Ackerly, I hope you're donig well!
> >
> > [...snip...]
> >
> >> I would like to get feedback on:
> >>
> >> 1. Opening up HugeTLB's allocation for more generic use
> >
> > I'm not entirely familiar with guest_memfd, so pleae excuse my ignorance
> > if I'm missing anything obvious.
> 
> Happy to take questions! Thank you for your thoughts and reviews!

Of course, thank you for your work, Ackerley!

> > But I'm wondering what hugeTLB offers
> > that other hugepage solutions cannot offer for guest_memfd, if the
> > goal of this series is to decouple it from hugeTLBfs.
> >
> 
> The one other huge page source that we've explored is THP pages from the
> buddy allocator. Compared to HugeTLB, huge pages from the buddy
> allocator
> 
> + Has a maximum size of 2M
> + Does not guarantee huge pages the way HugeTLB does - HugeTLB pages are
>   allocated at boot, and guest_memfd can reserve pages at guest_memfd
>   creation time.
> + Allocation of HugeTLB pages is also really fast, it's just dequeuing
>   from a preallocated pool

All of these make sense. Just wanted to know if guest_memfd had any
unique usecases for hugeTLB that normal hugetlbfs didn't have.

> The last reason to use HugeTLB is not because of any inherent advantage
> of using HugeTLB over other sources of huge pages, but for
> administrative/scheduling purposes:
> 
>   Given that existing non-guest_memfd workloads are already using
>   HugeTLB, for optimal scheduling, machine memory is already carved up
>   in HugeTLB pages for these workloads. Workloads that require using
>   guest_memfd (like Confidential VMs) must also use HugeTLB to
>   participate in optimial workload scheduling across machines.
> 
> >> 2. Reverting and re-adopting the try-commit-cancel protocol for memory
> >>    charging
> >
> > On the second point, I am wondering if reintroducing the try-commit-cancel
> > protocol is tied to factoring out hugetlb_alloc_folio. When I removed
> > the protocol a while back, the justification was that for the most part,
> > grabbing a hugetlb folio was a relatively cheap & fast operation, since
> > hugetlb mostly operates out of a preallocated pool.
> >
> > So the cost of being wrong, going above the limit, and having to return
> > the hugetlb folio was also relatively low.
> >
> 
> Thanks for this! I saw your patch to just optimistically grab a HugeTLB
> page :) For that patch, the primary reason was to simplify the logic,
> and the simplification was justifiable because grabbing a folio is
> cheap, right? (And so grabbing a folio being cheap wasn't a reason in
> itself?)

Yes, exactly!

> > It seems like this patch series introduces some new paths for hugetlb
> > pages to be consumed (specifically, without a reservation or vma).
> > I imagine that these new paths make the slowpath for hugetlb more frequent,
> > which makes the cost of assuming that the memcg limit is OK higher?
> > I think explicitly spelling this out in the justification for reintroducing
> > the charging protocol could be helpful.
> >
> 
> Yes, I should have done that. Will copy the following to the next
> revision.

Thank you for considering!

> The main reason is that reintroducing the charging protocol is the
> clearest way (for me) to cleanly refactor out hugetlb_alloc_folio()
> without worrying about the edge cases around HugeTLB reservations and
> charging.
> 
> If I didn't reintroduce the charging protocol, I would have to depend on
> freeing the new hugetlb folio on memcg charging failure, and the freeing
> in turn depends on the subpool correctly being set in the folio, and the
> presence of the subpool influences (in free_huge_folio()) whether the
> reservation was returned to the global hstate. Aaannnd... there's also a
> hugetlb_restore_reserve flag that controls whether to return the folio
> to the subpool (and the hstate). I find folio_clear_hugetlb_restore_reserve()
> on certain code paths kind of magical/unexplained too.

I see, if it makes the code simpler to introduce the protocol again, I see
no reason why we shouldn't revert the patch : -)

> I would rather iron out those charging and reservation details
> separately from this series (with more testing support).
> 
> On the other hand, reintroducing the charging protocol has the benefit
> of avoiding allocations (not just dequeuing, if surplus HugeTLB pages
> are required) if the memcg limit is hit. Also, if the original reason
> for removing the protocol was to simplify the code, refactoring out
> hugetlb_alloc_folio() also simplifies the code, and I think it's
> actually nice that memcg charging is done the same way as the other two
> (h_cg and h_cg_rsvd charging). After hugetlb_alloc_folio() is refactored
> out, the gotos make all three charging systems consistent and symmetric,
> which I think is nice to have :)
> 
> I hope the consistent/symmetric charging among all 3 systems is welcome,
> what do you think?

For the hugetlbfs case, the path to allocate a hugeTLB page on demand
makes sense, so I definitely see the argument for avoiding allocations.
Does guest_memfd also have a path to allocate a hugeTLB page outside of
the boottime reservations? In that case I think it would be nice to
clarify that the allocation failure case optimization is also for
guest_memfd, not only for hugetlbfs.

Symmetric charging is definitely welcome : -) All of your reasons make
sense to me, I just wanted to ask and make sure.

Thanks for your thoughts! I hope you have a great day!!
Joshua

