Return-Path: <cgroups+bounces-1326-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE07847D3A
	for <lists+cgroups@lfdr.de>; Sat,  3 Feb 2024 00:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629BE1C216E5
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 23:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5128712D74B;
	Fri,  2 Feb 2024 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MA6NxgHm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3F812D742
	for <cgroups@vger.kernel.org>; Fri,  2 Feb 2024 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917155; cv=none; b=sZAkoOMadjIED9yg/fLlNCeHfzRZ2VO6fDgMWoEwaufcVy84DqKtkITWGhvcLYzl8thAVVB3v9FE2xrZLbvpNUEHINDtZVp6CYSKT/2Ej5dsUFnFwPLZInXoAuyomeJ1foFYV5pLcEie1jhWH9NLKOFWvHBk7o6QTvweQyR6pi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917155; c=relaxed/simple;
	bh=b/a8qvwV9kIhW3YeFIwfOR6mUCUXJlmI3P0+Ee2g9P0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qYPRGow6IrKQZ76eAG174cdJHYdTeICh69RuJ0QF6HfK3GJgxlj/TnmE04i+j96Xri19QZi8bjS6WaS0KM2E0+uRHOII2anbq/vX2UqbVZUzsrO78U1sEaR0JeovmESBQjm+0ctuW+Nf9hESFRvf+O0aXYeA5zf6doAeA5kykIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MA6NxgHm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5fc6463b0edso44588777b3.0
        for <cgroups@vger.kernel.org>; Fri, 02 Feb 2024 15:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706917152; x=1707521952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=veXaKfSzJPhWO3q5P8DCJsJwSlDKBS//G1+RUPv9jb0=;
        b=MA6NxgHm95/FnMoo6tnArTU6LMsVmBrFv5m2lfJrsCKoq8pjMwcdwHeaLDNRMGw7fy
         SrYVMO2v8SCIfvl7OTz2+TUCJu5qUyS5/ZSE5mYALe7mUN0ahLrvVhGcmm7z+r8ENPwQ
         G5TEtajy8+pTlX0NIvyn3dqfpslI37FRNtRiIaXjG9R7Q1xGepKBKAW3PfHcn5fa1OCm
         bxVQUPata8/ZxWCRFSQ4h/+xwgoqW3vpIGxSkxAANNvbBYmTrk1Yk5BJUeMkMmdmVuwt
         VxW99H6ZWl+BWtCePQBZ/6mHoMmsbHHdzv6deO/Tk9K5xm1dsHxm2kkfP0HEKnvryLcy
         UXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706917152; x=1707521952;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veXaKfSzJPhWO3q5P8DCJsJwSlDKBS//G1+RUPv9jb0=;
        b=Y3BBnRcuH8mVhWBBWXr4i5nFxPCTrVPLBJr5Dnh7OAqReHYLQIZFlKlJAGSzQVgbYw
         8inedVwilLVmC20hLUSPsKaRceD3kh/RaEUdKR+wVfWVhy533Y4b6HtPLe3MCvPrOUYd
         h/7Zyuf2Lel0eh7vu2tofvDTcATCyjcovl/LrL6HGpk71+rnDB6EbTO180E7qogbdBlv
         2jESP2ETZohEyqrMMtZ2WK9nUCuHC5rILHWNfFKUj5q5YueX1nfaR/07DNFkLOdvSFI1
         9+ZbvXqBtn82j+XHAQ5Wnoic1/VRl26RZr6puBdc4twFhWMjsy5bcYT1z0eTifgThOjq
         jdUg==
X-Gm-Message-State: AOJu0YzW/mstnu3DOwHmrYLnTQSPDB82oZJG6A4T5sxMwY11Bhcvn5oZ
	A9QQrui/C+3YwSifUPE4RiVc5AiBVDSyGym7TNZjdtsg8Z2t3rrEPSIKMmPBNfz8H0GjZd++i5H
	8DdEwwR0aXi0hjA==
X-Google-Smtp-Source: AGHT+IFAHDWilRDUNp18USGdlO197DzaUkAANlq86p66ok+T+jL1OSQ36fvym0+hihK8eIJ6qbraq0B31Ub1h+M=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a05:6902:2306:b0:dc2:5130:198f with SMTP
 id do6-20020a056902230600b00dc25130198fmr197728ybb.5.1706917152524; Fri, 02
 Feb 2024 15:39:12 -0800 (PST)
Date: Fri,  2 Feb 2024 23:38:54 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202233855.1236422-1-tjmercier@google.com>
Subject: [PATCH v3] mm: memcg: Use larger batches for proactive reclaim
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Efly Young <yangyifei03@kuaishou.com>
Cc: android-mm@google.com, yuzhao@google.com, mkoutny@suse.com, 
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Before 388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive
reclaim") we passed the number of pages for the reclaim request directly
to try_to_free_mem_cgroup_pages, which could lead to significant
overreclaim. After 0388536ac291 the number of pages was limited to a
maximum 32 (SWAP_CLUSTER_MAX) to reduce the amount of overreclaim.
However such a small batch size caused a regression in reclaim
performance due to many more reclaim start/stop cycles inside
memory_reclaim.

Reclaim tries to balance nr_to_reclaim fidelity with fairness across
nodes and cgroups over which the pages are spread. As such, the bigger
the request, the bigger the absolute overreclaim error. Historic
in-kernel users of reclaim have used fixed, small sized requests to
approach an appropriate reclaim rate over time. When we reclaim a user
request of arbitrary size, use decaying batch sizes to manage error while
maintaining reasonable throughput.

root - full reclaim       pages/sec   time (sec)
pre-0388536ac291      :    68047        10.46
post-0388536ac291     :    13742        inf
(reclaim-reclaimed)/4 :    67352        10.51

/uid_0 - 1G reclaim       pages/sec   time (sec)  overreclaim (MiB)
pre-0388536ac291      :    258822       1.12            107.8
post-0388536ac291     :    105174       2.49            3.5
(reclaim-reclaimed)/4 :    233396       1.12            -7.4

/uid_0 - full reclaim     pages/sec   time (sec)
pre-0388536ac291      :    72334        7.09
post-0388536ac291     :    38105        14.45
(reclaim-reclaimed)/4 :    72914        6.96

Fixes: 0388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive re=
claim")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>

---
v3: Formatting fixes per Yosry Ahmed and Johannes Weiner. No functional
changes.
v2: Simplify the request size calculation per Johannes Weiner and Michal Ko=
utn=C3=BD

 mm/memcontrol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 46d8d02114cf..f6ab61128869 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6976,9 +6976,11 @@ static ssize_t memory_reclaim(struct kernfs_open_fil=
e *of, char *buf,
 		if (!nr_retries)
 			lru_add_drain_all();
=20
+		/* Will converge on zero, but reclaim enforces a minimum */
+		unsigned long batch_size =3D (nr_to_reclaim - nr_reclaimed) / 4;
+
 		reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
-					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
-					GFP_KERNEL, reclaim_options);
+					batch_size, GFP_KERNEL, reclaim_options);
=20
 		if (!reclaimed && !nr_retries--)
 			return -EAGAIN;
--=20
2.43.0.594.gd9cf4e227d-goog


