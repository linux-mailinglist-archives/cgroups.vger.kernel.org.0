Return-Path: <cgroups+bounces-1288-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C33844409
	for <lists+cgroups@lfdr.de>; Wed, 31 Jan 2024 17:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7B81F27CD7
	for <lists+cgroups@lfdr.de>; Wed, 31 Jan 2024 16:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B686012BEA7;
	Wed, 31 Jan 2024 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5YDKrMB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF26412AAFF
	for <cgroups@vger.kernel.org>; Wed, 31 Jan 2024 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718289; cv=none; b=dYHpa4XrspKqPFZTcKH/10HhXFTVV7ng/PF7ZLbYDFxZRtADBAJ2D1EaoVgcU4a6SuxQk/0z6f2jQZKKo+aDsetjtWNgz43KmnlmZ4NHnkOpA4As2TwcbIcf2GL9UdCxo9aluILwuk2bLdkt311xdM9cyWk3Pi2Z/VrNZzrOLTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718289; c=relaxed/simple;
	bh=AzmL5zx4xNDrc3cpdMYDJLBd7o+fVpmomAYHf1eecDg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b8A60Ykrn6Hnl+9PdxN49aj6ik5CWzkwfEMU0aU/GsPxX8OhYrYNyy9X2lcZs353w7kPCx/v1vbXqmhToQBd1gjWjjsP6VGWpr+4rt5HkYdj78ku+9EIbboP8DF4y8VMtVJTYzw4adNdGQfIuVpL4qsRE2dOFl5gxNB12MMX/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k5YDKrMB; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d396a57ea5so3257262a12.2
        for <cgroups@vger.kernel.org>; Wed, 31 Jan 2024 08:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706718286; x=1707323086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZNYUkxA0xvwNNh2j9fPRfqO+hGg4aS2w3UwOndzd+pg=;
        b=k5YDKrMBVqn6l3wucgoSKyXQLDtI6WapQOQoqx4sV25vQSuhytqnm4wwEPGRky3P8n
         AJW5X6WAZTInuker2KN+tTcUWpcaXcNq1Vgr+ETKjTAS47bpmJvEN3p/OO0/t23cZZoj
         fDqSLAb+0og/w9+4upVwpgk8L776axU0dlIJ5uUoHL8iFGe2WclkZaPfsVj47owVnE6y
         2mU533D5lsRYhkgW8Pz5mjACZob7UDLGBrIj7+R57On7eF8+Ml5VuUUTLDLgfRsVPABh
         DHtk3Wgt+0EffREL0cHkz34LmkrHTWZnI36Y1UGRqIMIbezRPFj4FLQwPBQlRFRgxfM2
         J2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706718286; x=1707323086;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZNYUkxA0xvwNNh2j9fPRfqO+hGg4aS2w3UwOndzd+pg=;
        b=CBvJlBDUSzy2qKF5lNTA9aXxT06YgiwpX8FjHi9UM+aT24vtKkseRrRfGW8xZMpCqD
         QEDWASsr9ltwKLqK4am07FTaU5hA+IlXJ+pT9KPllmn51+V+HkohfJIWfE7wFtQyvK7f
         f5wJJwYL55A4MEWUYdAQY10Wn9Cf5w9eQiMQV3mbSIpSeaO+K0Dm/nWm8bNSw3KY0jwL
         azHXGZhu582SePU+ykbh6HIKrGFeNBXGbCcFjEgfCNrNtvmx1/du5z093tFrdmfdPrPl
         MGC795JJ9pAMTsl0nwh6R4lHgi+Z8Es6pzwttHrW01yEhfpaoBX2i4K60wojj//h02sq
         2tYQ==
X-Gm-Message-State: AOJu0Yy2YNdwotLfQiYYLbPwZvNjjYSfPKIWC9onF8HvdIwOeIC83WX6
	pe0L/0u8wYfGWp/VgykFwH5GZQai0WFqtCOcb0eUwyvdp5BsE5a3v3GJ5faOltYnQiNrFU7DiPD
	NLfHrxmBFD4OC2g==
X-Google-Smtp-Source: AGHT+IFAiE0hs4hBtbmrUFuOHHRtqtWeAwPHHaLD9alreUAspDLbfRsx7fyhMX1VookkwtSt38ubBnCQrBhBvBE=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a65:614f:0:b0:5ca:459f:d4ba with SMTP id
 o15-20020a65614f000000b005ca459fd4bamr20923pgv.9.1706718286053; Wed, 31 Jan
 2024 08:24:46 -0800 (PST)
Date: Wed, 31 Jan 2024 16:24:41 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240131162442.3487473-1-tjmercier@google.com>
Subject: [PATCH] mm: memcg: Use larger chunks for proactive reclaim
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Efly Young <yangyifei03@kuaishou.com>
Cc: android-mm@google.com, yuzhao@google.com, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Before 388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive
reclaim") we passed the number of pages for the reclaim request directly
to try_to_free_mem_cgroup_pages, which could lead to significant
overreclaim in order to achieve fairness. After 0388536ac291 the number
of pages was limited to a maxmimum of 32 (SWAP_CLUSTER_MAX) to reduce
the amount of overreclaim. However such a small chunk size caused a
regression in reclaim performance due to many more reclaim start/stop
cycles inside memory_reclaim.

Instead of limiting reclaim chunk size to the SWAP_CLUSTER_MAX constant,
adjust the chunk size proportionally with number of pages left to
reclaim. This allows for higher reclaim efficiency with large chunk
sizes during the beginning of memory_reclaim, and reduces the amount of
potential overreclaim by using small chunk sizes as the total reclaim
amount is approached. Using 1/4 of the amount left to reclaim as the
chunk size gives a good compromise between reclaim performance and
overreclaim:

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

Fixes: 0388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive reclaim")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 46d8d02114cf..d68fb89eadd2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6977,7 +6977,8 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			lru_add_drain_all();
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg,
-					min(nr_to_reclaim - nr_reclaimed, SWAP_CLUSTER_MAX),
+					max((nr_to_reclaim - nr_reclaimed) / 4,
+					    (nr_to_reclaim - nr_reclaimed) % 4),
 					GFP_KERNEL, reclaim_options);
 
 		if (!reclaimed && !nr_retries--)
-- 
2.43.0.594.gd9cf4e227d-goog


