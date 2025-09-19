Return-Path: <cgroups+bounces-10279-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90136B87D4A
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 05:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567EC1CC0403
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 03:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF5823C4F3;
	Fri, 19 Sep 2025 03:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Vc4H/SRT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A92222CB
	for <cgroups@vger.kernel.org>; Fri, 19 Sep 2025 03:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758253778; cv=none; b=ZSUshQU7DloxFRHWJNrCXwfyE1WlmT8CbCXVf6XwX0VR7jUGojQm3mH81LwucPdIIv7WtiG1jiRfQVNU04lyckoqx818YN4vx3FDnp9FYlSaONjgX9ZQBxoYW3bqPZsymnuk2CuPjW4Es5qg8kcbPlXuE8QU9aoXJAtJYkwX6fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758253778; c=relaxed/simple;
	bh=I1OqoknoaRYAHqr6n1xj5l5q0FydzsunZssbWz6KX4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XM0Y8UKSw2VvusN7Ip0yB6qs71RgswuxnTuJmI/tCBJug6Gh0Suhm7rwNezvb1koIafCfSuP7eBFl+NCkKmbwQ2DbY+i7l4GwB6jwgRvuqV4T5xlErOIk/5/A8HnJa/X0f4+Tbt340/NpgY1ITYAhOGs9wsALNJ0AUrkY/dZbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Vc4H/SRT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24c8ef94e5dso13660585ad.1
        for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 20:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758253776; x=1758858576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PGM0+isxbI6kMyFpnlWoNKQkP4z9jauAjmwEBTcg+6o=;
        b=Vc4H/SRTEK8mvxY8a0oLTnUYzPqfW7W1IIqG2h3j/YcmC0R45lV5DW5QsPi+UxwFks
         WbIFKRm3RQ82pAZuyVTIXgXS8evW1S4TGIyRJoAGeRygJip9GCeifdOmvk5DRDLSApJC
         dmNGfSgYWZO19TppcXCTKMfgjmKArAZZXP1RsMEE35f9D/YmzDSqCXHwytZLxpIoWBWd
         ET2d8Hnw4opBLtRGyBU7M4El9SXR0+rHW6Vd8LClyeG5AvcyFBGekoP3B4IULzehgiu2
         x1/8ztrsTaUGyxLd9dvjAb0YGfEG1LdYOKqrGaS/KEJAXyrml6NSHLDde9XZC9HCtX9P
         +k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758253776; x=1758858576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGM0+isxbI6kMyFpnlWoNKQkP4z9jauAjmwEBTcg+6o=;
        b=OAOtGWonamIy5kc8qv35y2Y/7kNwvHJJQGqe3JnGya7khoQfdzeYV0woyv0FMyBLFE
         blXDJZ3ltVq0GeiKsly8M1tXTEax1KEv/kGakYaPu8QXV6isfXsFcJ4bx4iA3LdoiLwl
         ifojIwHv0KM9Qc4eDPy1C3E0vFNEfQyNkKPD3bszbMqES6oXcwmCowZ6NE2yuoF0C44g
         OOAvtNB/rbcwZ/3Kn1NhTF0o4fEHm0YnVOjfBz1yBSKqOL99KqeMftaww+X2wjjBMD/O
         0+txkzUvS3+JQxLKxAFHlSNZbSE/TD/o0aizDjPjRL937CmmCWrZSPjFzgo+dHBM2cMY
         JAhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd/jPdK0hl3Sn1v5HiIixlsk0jAIi1/SZZm9gK4TEKJK3XUD/yIN+WuRNyL5YQz17CAv4dSs0Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6hekc6UKko00PmlcBVfh0xVP3QVWFuzCJM3vScKjkwZQ5XDhc
	E2IGTkkI95pzb8DmcCdXPO//4XzklSUlv6F5ye8r3BB9eweg1DmGkRnYpOSfq7ljkhg=
X-Gm-Gg: ASbGncvQjxmuTd+99mf1JMizqV0IfmLW3q8NvfFvBQ4HjsQEbGScDKswo6Ss7acAB/E
	ndJ4LwlqmNFf9ODnnJ1gjS8wIbFoYQxJcSaORuWnzfWfUxsfTZV0tLS4gxUXpGzpN0rVmrL1DsM
	nMkPyx/h2tVEAuNHD6Qsxqcp5x2PhdVko6Zbrj31BBIajBaCtYVt5Xy//eO/UTukKOEKbrNSr9e
	ybWzBAvMWNP6AtbbnKWl7B1njLDdUNMwnmvmioi/ArfLZA+ADaCzO83+fxuhj5XpUtlopET2BJs
	U7RqMsk+PqU2DetA6RZwz5xTDY64h+IsqeZLP2I0AQkXGduEnlAP0wRNT0cE6ggA9Rj4pGs6mSW
	ltc13m7NoKilMT4/rJbJrFw6jaj8g5aM2qePiSAxZArkPLSkQ74q45o9Jgd81WJPbvdlRHNw=
X-Google-Smtp-Source: AGHT+IGuwTI3Ff3KyrTQt6yBvN/VUnCQGF+jEJoWLIuvf5BD8t6+lT04UMxsOFQpcGmAFNec/IUGuA==
X-Received: by 2002:a17:902:e543:b0:269:8eba:e9b2 with SMTP id d9443c01a7336-269b9fd1020mr24752775ad.29.1758253775679;
        Thu, 18 Sep 2025 20:49:35 -0700 (PDT)
Received: from G7HT0H2MK4.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de5e9sm39629235ad.72.2025.09.18.20.49.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Sep 2025 20:49:34 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 0/4] reparent the THP split queue
Date: Fri, 19 Sep 2025 11:46:31 +0800
Message-ID: <cover.1758253018.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

In the future, we will reparent LRU folios during memcg offline to eliminate
dying memory cgroups, which requires reparenting the THP split queue to its
parent memcg.

Similar to list_lru, the split queue is relatively independent and does not need
to be reparented along with objcg and LRU folios (holding objcg lock and lru
lock). Therefore, we can apply the same mechanism as list_lru to reparent the
split queue first when memcg is offine.

The first three patches in this series are separated from the series
"Eliminate Dying Memory Cgroup" [1], mainly to do some cleanup and preparatory
work. The changes to them are as follows:
 - fix bad unlock balance in [PATCH RFC 06/28]
 - fix the missing cleanup of partially_mapped state and counter in
   [PATCH RFC 07/28]
 - collect Acked-bys

The last patch reparents the THP split queue to its parent memcg during memcg
offline.

This series is based on the next-20250917.

Comments and suggestions are welcome!

Thanks,
Qi

[1]. https://lore.kernel.org/all/20250415024532.26632-1-songmuchun@bytedance.com/

Muchun Song (3):
  mm: thp: replace folio_memcg() with folio_memcg_charged()
  mm: thp: introduce folio_split_queue_lock and its variants
  mm: thp: use folio_batch to handle THP splitting in
    deferred_split_scan()

Qi Zheng (1):
  mm: thp: reparent the split queue during memcg offline

 include/linux/huge_mm.h    |   1 +
 include/linux/memcontrol.h |  10 ++
 include/linux/mmzone.h     |   1 +
 mm/huge_memory.c           | 218 ++++++++++++++++++++++++-------------
 mm/memcontrol.c            |   1 +
 mm/mm_init.c               |   1 +
 6 files changed, 157 insertions(+), 75 deletions(-)

-- 
2.20.1


