Return-Path: <cgroups+bounces-5484-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D959C2701
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 22:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C26282E49
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 21:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC811E0489;
	Fri,  8 Nov 2024 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tu6CS6UU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67218199E89;
	Fri,  8 Nov 2024 21:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731101389; cv=none; b=bto4rN7J7y8o4WSa30qYFCUIwK5eJMib1xcO9t1cnOrK/qOeN8cuP4lXv+6E5ozIoVGoxEcsmyuCWl++ewoSFdeQNcZgN3srHr9e5xqAqNBNCR7e5nOzdT83+6lFP+Yv5tc84Z0ZlgYKZ9aMlUBF4GTPI3UIoCipQIL/Yaf3xfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731101389; c=relaxed/simple;
	bh=fUGnG+U391rhvKc9ZaaOxUVTkfaVIFyXHg0gcdzzQo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qsN2wFiEaTiw41vCgoHKTP0kgibTZq1hsKfD2Ne1Aq6y9lUxiJUCn1+PFSisuk+XYhWUa5CX423R2GlLc1TPCK7vxZqCsflyNESvUj88Fj+PLQhsz8WTPgNBTmWScDyN0g5/1pl6ueS258vP5ljFvgdzICmsqq4jS4nLZxxf/00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tu6CS6UU; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so2705591276.3;
        Fri, 08 Nov 2024 13:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731101387; x=1731706187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oMoVwyKx9EibI93AzasoaRWiT17pCAJ8KSTbCwA4rwI=;
        b=Tu6CS6UUzK5Kfa4aC9H/oQAm3VsxQASLwg6CePcAa+VLRBD9oSdvgUzhpQnlS3RpPi
         e8n0A17zu0iYIE05PBvR5G+sjvzbLJCIqFFEhleDbzdeF0C9StVWaa/zdSO7Nsz0dJSh
         aTVRvXh0+Avuev8VFarRwUNB2HR1v/1gA4bUJU+BS3fMTtt4l/SAD5H1JeXevD5GF7aV
         ZJy1bf+YcDOOY3Q+wbdHSZq+9uORCk1uU74LgeQ8oslvh22i+RVLvg7xLEU7uAMxD2+c
         cNlKMCY0jKjSxwYcMkixu9fsHvkEE/alKND727ggrmfHW737XvXGYsZxaWaL/p0QVNvX
         FKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731101387; x=1731706187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMoVwyKx9EibI93AzasoaRWiT17pCAJ8KSTbCwA4rwI=;
        b=sft8Fgcg+3Q/kqXCodzkzmNH12Hiy0u/kevEAwDuAEaT8BnPBpMV0M6W1Jt7UIqnZr
         GLmON8tdBEJMlMbZIX5ZsrPPk1RPwX5qsI0E0g2s84siDQBiXLS5kzWWQw0Hb61Zh4aW
         /YIgyG8KudHgKz2IPdlJAXfQi3yOeO+5URHpfuPpjCRizYdOUUBhx1rJEjHRi7bUZLLr
         f3PjtrRh371c4O6ggnO5cEz1Xg+K7KNMLPZoHGRwQJwZxoceQVM5QNKbzLy4NOo1atp1
         msBAzd2ImHVTwNaREy0NnBFIMZyM37CudeOGMEpQEDvtLpnT1gLxA1TjLajsQuwvySKG
         qstQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrUlPxydRYIHqfkcOdac/CKSg1Bqcq3Y4i+jrXFYmk1allKUEbMVccIi6MvtSLm4ETT2+UqTcbCEl2d+fP@vger.kernel.org, AJvYcCXInhhbRsMWQXXXPwuzTU8EJBnTIftcVGklnnJvoYxRzC+dmPtpf1yJpkZ9c8cY6bJhJbViFwdW@vger.kernel.org
X-Gm-Message-State: AOJu0YxOGMVimBzrAZGY+zqpgsCeMKnb1p/OpDz2U38O2u/lIp9AISG3
	+1Zo+08zxE9ypPle9WGgjVGOkqRja1Y4SpFkkErP6z6OBUaGbDKiZGw/QA==
X-Google-Smtp-Source: AGHT+IHwMeuH9AhWabEeGAZIaMw/d1MyU/3YuOvKGu/9O7X4oRAyW6t81YL0CaXeGHwWDLTrTna9RQ==
X-Received: by 2002:a05:690c:7282:b0:6ea:47cb:c870 with SMTP id 00721157ae682-6eadde44dd0mr57163067b3.33.1731101387352;
        Fri, 08 Nov 2024 13:29:47 -0800 (PST)
Received: from localhost (fwdproxy-frc-013.fbsv.net. [2a03:2880:21ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb9025fsm8615747b3.130.2024.11.08.13.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 13:29:46 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: shakeel.butt@linux.dev
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 0/3] memcg/hugetlb: Rework memcg hugetlb charging
Date: Fri,  8 Nov 2024 13:29:43 -0800
Message-ID: <20241108212946.2642085-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up memcg's hugetlb charging logic by deprecating the
current memcg hugetlb try-charge + {commit, cancel} logic present in
alloc_hugetlb_folio. A single function mem_cgroup_charge_hugetlb takes
its place instead. This makes the code more maintainable by simplifying
the error path and reduces memcg's footprint in hugetlb logic.

This patch introduces a few changes in the hugetlb folio allocation
error path:
(a) Instead of having multiple return points, we consolidate them to
    two: one for reaching the memcg limit or running out of memory
    (-ENOMEM) and one for hugetlb allocation fails / limit being
    reached (-ENOSPC).
(b) Previously, the memcg limit was checked before the folio is acquired,
    meaning the hugeTLB folio isn't acquired if the limit is reached.
    This patch performs the charging after the folio is reached, meaning
    if memcg's limit is reached, the acquired folio is freed right away.

This patch builds on two earlier patch series: [2] which adds memcg
hugeTLB counters, and [3] which deprecates charge moving and removes the
last references to mem_cgroup_cancel_charge. The request for this cleanup
can be found in [2].

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

[1] https://lore.kernel.org/all/20231006184629.155543-1-nphamcs@gmail.com/
[2] https://lore.kernel.org/all/20241101204402.1885383-1-joshua.hahnjy@gmail.com/
[3] https://lore.kernel.org/linux-mm/20241025012304.2473312-1-shakeel.butt@linux.dev/

---
Changelog
v2:
  * Removed declaration of memcg_accounts_hugetlb from memcontrol.h
  * Moved second call to memcg_accounts_hugetlb from 2nd patch to 1st
  * Changed error behavior in alloc_hugetlb_folio: v1 included a bug
    that uncharged hugetlb_cgroup twice when memecg's limit was reached
  * mem_cgroup_charge_hugetlb no longer called with hugetlb_lock held
  * Moved mem_cgroup_hugetlb_{try, charge} deprecation to patch 3
  * mem_cgroup_charge_hugetlb always decrements memcg's refcount
  * Fully cleaned up mem_cgroup_{cancel,commit}_charge
  * Fixed typos
Joshua Hahn (3):
  memcg/hugetlb: Introduce memcg_accounts_hugetlb
  memcg/hugetlb: Introduce mem_cgroup_charge_hugetlb
  memcg/hugetlb: Deprecate memcg hugetlb try-commit-cancel protocol

 include/linux/memcontrol.h | 22 +---------
 mm/hugetlb.c               | 34 +++++----------
 mm/memcontrol.c            | 89 +++++++++++++-------------------------
 3 files changed, 43 insertions(+), 102 deletions(-)

-- 
2.43.5


