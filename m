Return-Path: <cgroups+bounces-10387-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F86AB95324
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 11:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C99A2A2078
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 09:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67DF2F0694;
	Tue, 23 Sep 2025 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="InAwZqWU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918E931A06F
	for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619010; cv=none; b=m6Ey+HB4yjZBSgFTnj5/CimNo8mhNySQDg4gluXnV+OD+C7rGxnN6JHQu2jYPRVpsj2vYQMSqK8sNNgRX8diRbhKAHNmR9jwbiOGqKsiO9U7hgZK74DXNTf9LAuBA04n9jAnk4jHiU9gTUQ48OLKjqolR5Rvma7pHYRvmhmcqXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619010; c=relaxed/simple;
	bh=BqV7fnshOuZOLvnQTQDzPqM3jHRWFgEzs7aBVAUhzrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ko8JIl//eyrxT3YIiyQga3zFue8XojEiowCs0HQgV2sv3WKYitgWeuEtNG1yNBbLmTMgB7CP4p7ifYyEM7rEqncTpWqB1NhjvwPzrESXUWfVelbCoP4PsF/s3ZJOV156woBGPbxD/fuKbQNrR0VXerUfLr7DjW/csL3y5cGkOJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=InAwZqWU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-25669596955so47909015ad.0
        for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758619007; x=1759223807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4mMHBSR6iVN6xpeCcQzalGxMENnFCjeMLhkVbx6JQl4=;
        b=InAwZqWUOV4DkuiebfzFy3YvX3aQIXJCjq5zLEZ8rHuQtg0H6evzj/e1ShkZ3sPMdF
         qRdg4OiUrJzmbV27uBFZGk/ELQQfFI9J5I679TeTwYg6aMAsnLvpCc+7SXLGA4YOItYW
         04sbQbShSfZ/BMcqvGPM94A958muMpUOXR1Dt/D+rYt+x2Iu45Rd39X8uHoszkZYfcqm
         Cu7NLgthrpOiHYgOatWyyPhohuzdrkpnWWBvGwrvu0aWKffwot/8vOm8VxJSTySSaJxO
         gJwfAj2qVjTt2lZmn2dINESgiClWMSzbwR59mZICr+y2xDGXsXsMhrtwIi2xahclwgBJ
         M0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619007; x=1759223807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mMHBSR6iVN6xpeCcQzalGxMENnFCjeMLhkVbx6JQl4=;
        b=C5C9ddU8NgtR+0CR+0/bU0iY0onjIkySKHAfrUerNyYctXNXxp0n9t+rkb3J/TAUh+
         XBcA15KpcbItntRFJhyw1xPInNJ9XMK21XNyf9FsWJs50Hctuj0JQ3im/yTTE/6Py4O0
         6z9GLPuwh3x/vF4tZg2DYm4WFvTiXTrQXhDzL4Af87ZUvU+KDbDUn6iZi52bf17XBlzj
         Y+7jrGojPi12QRa28TgEpiWEx3P0xRTpSLIrWdQz/wnc+xfqZ1tDbn2pWasEqW2+HfMC
         7NxHmlFfOQOB33l8ghI7nx2e5H8iyj4ujItE17GOFQpro0FSjSxonlgCfxdX6EOTmnsU
         tBHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGpGDcESIqIHKwsqTaeDxkTvqb7xRD0xwrEr5kXcgEJlLhZlilwoZlCcRN7EzZMluQ1FyfJjXf@vger.kernel.org
X-Gm-Message-State: AOJu0YytpoXon4z0aXd0E8M0kW6d1ijJjE6CEayNntxL3rXqDEnWf+sw
	2rP2qTNZ/wZRm5aYOLK015TEj0wOCTwKjk5JBv7zHKAEC1wLYDkBaLW8ETg6GMPZJVU=
X-Gm-Gg: ASbGnctsJeb16NvThi8rJdbQlZuTx2QhW3vD0j8rc12X+lDJwiCVTVpshdOibTeB7ZN
	Ge0ySfGnJdrdJAvFNUIPvWSQRi6My60eDvRR9vQqVw86K7na5foTPNJwxEuLxHECmVfeIB2NLcm
	a//7yq4wUVxaQsrKbAfl/RHux3PigGUPTWmv++y2h74n8SbQAHXIXMFhOROA7mSRarEQxb/+E0M
	I+f67hdU1IabNTFJtxZIe0QAmm8kneBzMU7asIqoBlUvcTw/QHnKS7evCqtcKaw+nbawt9E5/U0
	YGOObZbpCJ8vE+ta2/6RD4zLlD8Mb49JMn1PVyeHCqvLX4RLg3wsJD32BRj794dJQ/PgwwrLljd
	EmX/AgrqxcQ/gVJYy3BjMBc4N7L/ZXKFNx5a/YFxNjnYZ1g3mK08VO5q3a8pBk3tEDZ1rKKsHQo
	LRrnE33g==
X-Google-Smtp-Source: AGHT+IE+pTyYnuUeKNBnXn7u5n9qqZquO3ZZc8vyWV1I57TGD6s8tCb5Ogkdy4UaIq5TtfdFMCYfeg==
X-Received: by 2002:a17:903:1983:b0:24c:da3b:7376 with SMTP id d9443c01a7336-27cc2d8ef77mr24868675ad.26.1758619006912;
        Tue, 23 Sep 2025 02:16:46 -0700 (PDT)
Received: from G7HT0H2MK4.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed26a9993sm18724713a91.11.2025.09.23.02.16.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Sep 2025 02:16:46 -0700 (PDT)
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
	harry.yoo@oracle.com,
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
Subject: [PATCH v2 0/4] reparent the THP split queue
Date: Tue, 23 Sep 2025 17:16:21 +0800
Message-ID: <cover.1758618527.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
 - fix build errors in [PATCH 2/4] and [PATCH 4/4]
 - some cleanups for [PATCH 3/4] (suggested by David Hildenbrand)
 - collect Acked-bys and Reviewed-bys
 - rebase onto the next-20250922

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
work.

The last patch reparents the THP split queue to its parent memcg during memcg
offline.

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

 include/linux/huge_mm.h    |   2 +
 include/linux/memcontrol.h |  10 ++
 include/linux/mmzone.h     |   1 +
 mm/huge_memory.c           | 229 +++++++++++++++++++++++++------------
 mm/memcontrol.c            |   1 +
 mm/mm_init.c               |   1 +
 6 files changed, 172 insertions(+), 72 deletions(-)

-- 
2.20.1


