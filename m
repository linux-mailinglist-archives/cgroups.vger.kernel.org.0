Return-Path: <cgroups+bounces-1318-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 186CD847C17
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 23:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B90283543
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 22:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5110383A15;
	Fri,  2 Feb 2024 22:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MnYxGiLT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A683A10
	for <cgroups@vger.kernel.org>; Fri,  2 Feb 2024 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911847; cv=none; b=ZDhpfo50+aCj/KOCSQ8kTuqMtsYFrRnHA9ialBH+095uMfQPQtNeDkGLrezrg5iSpEY8W9zgPXWCPC0Wxl051jLCPrw0o9Z1UK64PikqApZSBAZ57WL1LSDZa6Z/4nGvw6rW/cCKPIWX/wZ2F/6tssypJzl/P5FdrhnN++oSl8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911847; c=relaxed/simple;
	bh=dNE+7Pmfahq+jtcv7ewyVbuK2eYzjPqtgYoDFx3azy4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=S1TubDkwTtYdlW7eWyrmmRGbhhYkmINTgC2JY7ykNXPyzQR9GE/ITxXZXgMO3l5MF2I5fl+8sdxn/NnOK9yYaVPrE6VGEwpw3cUGFt5jF4Pr0DmPEAMMxYtWIa48WNSnoHsyPSHCTA95SYj+twzQCe+M99d6EaRxL/UonAkQxOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MnYxGiLT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d43d0d6024so2679631a12.3
        for <cgroups@vger.kernel.org>; Fri, 02 Feb 2024 14:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706911845; x=1707516645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHbC9+IlrYehd7NC2Y5ENY9x+M2AXax5bbOnGa1kNgU=;
        b=MnYxGiLTDESex/Mgtwzrsk3BJ++W+wA19KnLbN8A6C5ZBcb6gG6ADTXY20MmUfG6XW
         YFmmJDhUYcy2sGfXRI40ZWWFZj/fO1g4u0W6jWYdoaUpqR4HEq1aUkS7F/o2vjifnrAm
         VmSJEhzMfi57b2YBwnyrQ/OMiruVbb8FI9D+x0F2bf8vhvRJlU4ToBW22SD7gmUrWzIs
         zeVfGq3O1IJwaoaCsz5kRPPoV7CLMyKI/BAoJxhplreVp+GAFzUK8MOn6SncBT1ucvIe
         i6S/K2eZFv2NcsPDZnxyxjgb+6h91/r2TVtrlWdh/X9TT4m4dnApl110f1voyuiiZhmd
         AEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911845; x=1707516645;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHbC9+IlrYehd7NC2Y5ENY9x+M2AXax5bbOnGa1kNgU=;
        b=Zh2ucr0r7O6hwTleri4ztqrpzMpXl+1SuopoDUk3Aaa3lgvhNQxy6DjFVRTE+keTGk
         f6kFbg5nv9qqZCPONc70yKdToskBrlkI9A3ErDDy19f70Fm26ll+51wGe8RIlMC8qUdy
         yUPZAxDhuMVssKTih8kF3BCpWBAHIW08Muq1qoBKNDY7ulpP7pkDRYdicEp/DGsFCtM1
         iDOfuH+pkLZVvagvRPLJZwKiucXIvGY0AIb4GGkbdh/EEUrHyQsYsQ1482X3UqFEZPSm
         BObvwgRKVzzjKLSfa6r+7cjpDawO+zN++2uudzo4uTVfv2HkS7f78tkAL2bar8RwQpuW
         SMBA==
X-Gm-Message-State: AOJu0YybR4DADeQPyGg+lVgYx8K2+PHnRVCBVbuEXGfOFK7Lza9cNEjJ
	PUYklsUDDWY88hS61hsgPODV/3flDvx3mLpJFr6jzHYY6kvS0OD3s3hAVHUDRSp8BKGymWnHl/0
	roww11GvWi+lG0w==
X-Google-Smtp-Source: AGHT+IGVF+lwoe9gVyRO4B2PQUZH6+TCE7BUAMk/NEzPe2/7u2DlnIgUMd3xxewG37f2opj4wMD2PgOdCJcxf1w=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a65:624a:0:b0:5cf:c149:8dc with SMTP id
 q10-20020a65624a000000b005cfc14908dcmr17021pgv.11.1706911844971; Fri, 02 Feb
 2024 14:10:44 -0800 (PST)
Date: Fri,  2 Feb 2024 22:10:25 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202221026.1055122-1-tjmercier@google.com>
Subject: [PATCH v2] mm: memcg: Use larger batches for proactive reclaim
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Efly Young <yangyifei03@kuaishou.com>
Cc: android-mm@google.com, yuzhao@google.com, mkoutny@suse.com, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

---
v2: Simplify the request size calculation per Johannes Weiner and Michal Ko=
utn=C3=BD

 mm/memcontrol.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 46d8d02114cf..e6f921555e07 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6965,6 +6965,9 @@ static ssize_t memory_reclaim(struct kernfs_open_file=
 *of, char *buf,
 	while (nr_reclaimed < nr_to_reclaim) {
 		unsigned long reclaimed;
=20
+		/* Will converge on zero, but reclaim enforces a minimum */
+		unsigned long batch_size =3D (nr_to_reclaim - nr_reclaimed) / 4;
+
 		if (signal_pending(current))
 			return -EINTR;
=20
@@ -6977,7 +6980,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file=
 *of, char *buf,
 			lru_add_drain_all();
=20
 		reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
-					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
+					batch_size,
 					GFP_KERNEL, reclaim_options);
=20
 		if (!reclaimed && !nr_retries--)
--=20
2.43.0.594.gd9cf4e227d-goog


