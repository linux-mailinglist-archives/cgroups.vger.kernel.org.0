Return-Path: <cgroups+bounces-14391-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLXyKaJ3n2nScAQAu9opvQ
	(envelope-from <cgroups+bounces-14391-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 23:28:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4796F19E466
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 23:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B58330C4F45
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 22:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6D6330D5E;
	Wed, 25 Feb 2026 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZJ4SOhZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466F22D3A86
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772058445; cv=none; b=ML2Z1J7nDWkmUlSM3wQ3WVqYDj893+gK9rzW+/A9vrO6OcemTX43yM1H+DpdyDIgfFD654UVcZeeAUjlrVZBBkghY9+RdE0JuCLjuBGMC1brHDst9nOVWexJ9dNVkVL1/jNOknyJzHDw79M9Gm7fJHuvvM4t2BxQKFqd+6HJgzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772058445; c=relaxed/simple;
	bh=5NxL+lsmNkAmuod7M/UL2N/jLtE5LxxmzTX+fk4im1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVzWjFBAF//NwUqLwTFNNwH1n9HWtwQEzu7SWwY2Q9+5OaPcdinhTiSk9d6WaijvXBVC+q8tFByNtYKe7+HTiOYIeXaLcc3XtefwagDWFjZkF7qSaR2F4JN+QPnm0xxidDMql7DfFapvreFwiqhBJiHNDG1NZGmd+J81CXgWrCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZJ4SOhZ; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2bdcb30fe8aso334809eec.0
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 14:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772058443; x=1772663243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHyAmbqk7HhQ2rW+koNARPwcM5Pex8BM81YALg0B5qs=;
        b=eZJ4SOhZM9ZcpjR4pxAXLrsQTLJratRCLz9YmTt6on2uKSnUOCI7FzvmO9S/33iwLF
         J4Zk0myZOBZ+SYRwXzVhDdOEiiTheaZrQo/AYjIkLSrAGIqo3ZgR5gLneR6AXb4IgNgy
         PYnmDX/W2FiaBSbUBK0uQJnrLYqEBbWPhEpynZMUopKDg2bNnjAFy8EjDriq8U6qSVbZ
         teoQaLm5elFT9aY0BdOFkn9+F317XFlo93EUuvn90cKzPEqoSmtbmJlHCGQdrXn4VO7Y
         GLNPoMSWudqIz0FFJHuphr9rcBy62Cn3zOj4apbz+nsZF3OUUL4SlEIlWwdUe7liePp6
         bPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772058443; x=1772663243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hHyAmbqk7HhQ2rW+koNARPwcM5Pex8BM81YALg0B5qs=;
        b=ERtEIoiTLey5e5sVyiMkQ5N6p2LDzw677RE0S6qGv0ElOZzAK1d2jFlWnflii5+YMY
         tlmgn6imxOizXhSRTJA1Tl5qEweK8LtF4HOj4VjNSZIcMZimyXh+4CMwQfyNG7qPUnp1
         FIF/J4dZuUTTnqjKnayGyXJ24V3VK2Ap68I3ckqpXRT7NY2zSV7JHxKcJSrRE2YA+k64
         jTsSbvw9FwnQhXDHwYVVuqZ0CE+qZkWAIULWr3mEv+sbHiVD0D1ygBXlPkcEgYGY9u6Z
         fjjALBBsNLmycRJkeTbT5BxP+111PhLFiBn/VHHudoLVC9+gIPhFBLucVXBWcBGujZ1y
         OPTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcYntrzcN97InL/5g7X31ZFxMn4VV4LpjwFQCXtLTHfr8OqmN6x5+ZzRvRZ4LBfnYaM1IptX4i@vger.kernel.org
X-Gm-Message-State: AOJu0YzCrbUWyuP8BU7ii3K7RAZcIr2eYexL/UwGSnmm7cZVQ6JQB9qL
	nlznC1lDfg7e3Lqx4GdrzgUMMUCxXhpyWjBWquhgVeS1+iJHltTpjiL48CXi2g==
X-Gm-Gg: ATEYQzyILtR8H6KGRXp7MRVCqhXT3cXF/6NyokoGhObpclWB3LLjuxIfoad3ZlBBVmy
	wj4DjIsBck0+kltQAiql+MwOBdnfzGx2sOlxV5kRJaVUK/hABSRXQr424b9zh7yUdO5wgejjgf4
	Q/q3j2hifEFOvcWA/4EVDEJDyE1rLx04KjdTad3qYHSMtt2aPIQgvgF/5bCn1jMvTdZDf6eG0LX
	DF5bgXRTFWJovMkpoXFvlCV0wKAaPMe58b1Lu90cQwsie3IRFn6dGXx+SMr9IdPeufTIDAVm4hO
	+NwSl+jp50zaAheMIEArAYnm3SuycWLDiVByhLMP6orK9jcaK9PlejZvEmr8zHqE+uZWjos5fu5
	HZFnc76Y7hsc0wjH7kEbQHL2dozLZuMMP5XFKAyH/wPEpxk1e/cSiqNcQFd/Y8KJ9xM71wpuGQb
	hPSjfs5+R+x2l4KKxt+QRH
X-Received: by 2002:a05:6808:168b:b0:463:cf6b:982a with SMTP id 5614622812f47-4644622ce34mr8146359b6e.22.1772051111331;
        Wed, 25 Feb 2026 12:25:11 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157cfa6624sm16078679fac.8.2026.02.25.12.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:25:10 -0800 (PST)
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
Date: Wed, 25 Feb 2026 12:24:37 -0800
Message-ID: <20260225202437.4077364-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770854662.git.ackerleytng@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14391-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4796F19E466
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 16:37:11 -0800 Ackerley Tng <ackerleytng@google.com> wrote:

Hi Ackerly, I hope you're donig well!

[...snip...]

> I would like to get feedback on:
> 
> 1. Opening up HugeTLB's allocation for more generic use

I'm not entirely familiar with guest_memfd, so pleae excuse my ignorance
if I'm missing anything obvious. But I'm wondering what hugeTLB offers
that other hugepage solutions cannot offer for guest_memfd, if the
goal of this series is to decouple it from hugeTLBfs.

> 2. Reverting and re-adopting the try-commit-cancel protocol for memory
>    charging

On the second point, I am wondering if reintroducing the try-commit-cancel
protocol is tied to factoring out hugetlb_alloc_folio. When I removed
the protocol a while back, the justification was that for the most part,
grabbing a hugetlb folio was a relatively cheap & fast operation, since
hugetlb mostly operates out of a preallocated pool.

So the cost of being wrong, going above the limit, and having to return
the hugetlb folio was also relatively low.

It seems like this patch series introduces some new paths for hugetlb
pages to be consumed (specifically, without a reservation or vma).
I imagine that these new paths make the slowpath for hugetlb more frequent,
which makes the cost of assuming that the memcg limit is OK higher?
I think explicitly spelling this out in the justification for reintroducing
the charging protocol could be helpful. 

Thank you for the series, again. I hope you have a great day!
Joshua

> To see how hugetlb_alloc_folio() is used by guest_memfd, the most
> recent patch series that uses this more generic HugeTLB allocation
> routine is at [1], and a newer revision of that patch series is at
> [2].
> 
> Independently of guest_memfd, I believe this change is useful in
> simplifying alloc_hugetlb_folio(). alloc_hugetlb_folio() was so
> coupled to a VMA that even HugeTLBfs allocates HugeTLB folios using a
> pseudo-VMA.
> 
> [1] https://lore.kernel.org/all/cover.1747264138.git.ackerleytng@google.com/T/
> [2] https://github.com/googleprodkernel/linux-cc/tree/wip-gmem-conversions-hugetlb-restructuring-12-08-25
> 
> Ackerley Tng (7):
>   mm: hugetlb: Consolidate interpretation of gbl_chg within
>     alloc_hugetlb_folio()
>   mm: hugetlb: Move mpol interpretation out of
>     alloc_buddy_hugetlb_folio_with_mpol()
>   mm: hugetlb: Move mpol interpretation out of
>     dequeue_hugetlb_folio_vma()
>   Revert "memcg/hugetlb: remove memcg hugetlb try-commit-cancel
>     protocol"
>   mm: hugetlb: Adopt memcg try-commit-cancel protocol
>   mm: memcontrol: Remove now-unused function mem_cgroup_charge_hugetlb
>   mm: hugetlb: Refactor out hugetlb_alloc_folio()
> 
>  include/linux/hugetlb.h    |  11 ++
>  include/linux/memcontrol.h |  21 +++-
>  mm/hugetlb.c               | 228 +++++++++++++++++++++----------------
>  mm/memcontrol.c            |  77 ++++++++-----
>  4 files changed, 212 insertions(+), 125 deletions(-)
> 
> 
> base-commit: db9571a66156bfbc0273e66e5c77923869bda547
> --
> 2.53.0.310.g728cabbaf7-goog
> 

