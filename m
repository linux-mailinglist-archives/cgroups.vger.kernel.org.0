Return-Path: <cgroups+bounces-1242-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FBB83E36C
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 21:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1431F261E5
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 20:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3491924A0E;
	Fri, 26 Jan 2024 20:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lPuQV1Lt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F512420B
	for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 20:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706301252; cv=none; b=Y29hEo0lIA4UP9qdtNmVjw6DDYe873tLs6gMmJ9P01IWSDLsdwHRrr4/4vISoh6ob4E7IFer6AcdOH0GeUmtbUm+3slF0/48V3RSEKMVWa8/e25oqd+O54SPyjjbEO50/sIEwuzBesPErZUELeNorwnwL/q639eB/9vFZI4dGg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706301252; c=relaxed/simple;
	bh=cFh1Le3i1dCMQawi1ZeXZVMvlDVa69/HNaaxp1jLcdU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tP+OyM2PJz2o2ZxN1RyKiV14a1RAQXlhKykLcdlTMzaSl1iuP0aErcZeKajITFd69t6TGbkqK+A4HDM7xJN5CTPJ0M4V3JMwV/el9yLLKpldkjho3kDjSLwinAYqMV7o4L/tMJbr9EnpXrRtup2C97RMRu9ot8nZW0trSB1CD10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lPuQV1Lt; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ddd005c848so1440660b3a.1
        for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 12:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706301248; x=1706906048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BBt418QgT8toCepZHQBStqxbTN+QCMoMJNdQnaVMPAc=;
        b=lPuQV1LtJzxhn3dsxrCAQFre0wVRTAoEnraqiR+nepOYK0XW4w9eDIexvj46xHerQ3
         WAXlnGyZm9jERG4lVdJcRK48pz4eSquAqxXrmeWsS4k6ZoW2Q2hS+ZIVlAr5atiD6Fam
         XvbpAb2OVJ1F8YVkT2EV8HdU2NNKMoLs3TaQkBaycnmR2QgWwSEt2OcX79EZxPyBPk+L
         wSwV5CgsPL4vkTOEHVxZjyUfp/FdJoWnhipZX0hWmHPz6tknakgyRHIsrQhiBFwpUKup
         8F+t+zobtGcKBxSJzqLP3qaLSV0k4DZRcBLUK0KiPsBy7lqUEpicD/7RviGGG+SiimuB
         2zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706301248; x=1706906048;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBt418QgT8toCepZHQBStqxbTN+QCMoMJNdQnaVMPAc=;
        b=xCNmkmoDn5LuXgYJjkFtPfup6hradxEFtzv60BJmXYbS1wfnd6SusrojlYO+E2IWzm
         h0TlNASdQ+c8gEB/dYp5Bw+RPIQ5vxT0qVB/5WflESNnTaipPDzZqRrbJnLuTKDruj4T
         i8nIO7L6vgt27+kWs1/aQ8aPPaFRLan59kYeA0cPUah8PYl9UujphdHDl3ZDfPwy63Yk
         xF5Weh3/30qQ1OGIyVHXXdYqiElFxvvrY2aEawRFZlPmeks752Vg+DUepS3fQkmnddon
         OdViDPcIWTNRzkb29UIGywTZKEQZyI9BRZkSR+sWDMofp9M/4tKbu8Hw/HPQPAN6QJUm
         QiKQ==
X-Gm-Message-State: AOJu0YxlhIB7qyq6+BFORmMxSKBlg0aaO8/rZ1D9NLvE0un1kPoS5f9G
	OKAsVPyzHowZJ4QxaofCa2jIZPu1v9av3FkGqDgjn+7h3xJQGTLhyxYI7jBrVv0hPorsJSvRV3t
	iLkTY0CA3aN+plw==
X-Google-Smtp-Source: AGHT+IHHP1kWMGZ9Bn+eeuZ85+wyFk88AXN/ijazKS5W01BlOVXP7g+JlvkKSyax8yyiQ2csnKCubTzf9fCCle8=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a05:6a00:1d15:b0:6db:d1de:6e9c with SMTP
 id a21-20020a056a001d1500b006dbd1de6e9cmr40934pfx.3.1706301248701; Fri, 26
 Jan 2024 12:34:08 -0800 (PST)
Date: Fri, 26 Jan 2024 20:33:52 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240126203353.1163059-1-tjmercier@google.com>
Subject: [PATCH] mm: memcg: Don't periodically flush stats when memcg is disabled
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: android-mm@google.com, Minchan Kim <minchan@google.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The root memcg is onlined even when memcg is disabled. When it's onlined
a 2 second periodic stat flush is started, but no stat flushing is
required when memcg is disabled because there can be no child memcgs.
Most calls to flush memcg stats are avoided when memcg is disabled as a
result of the mem_cgroup_disabled check [1] added in [2], but the
periodic flushing started in mem_cgroup_css_online is not. Skip it.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/memcontrol.c?h=v6.8-rc1#n753
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d7ef0a4686abe43cd76a141b340a348f45ecdf2

Fixes: aa48e47e3906 ("memcg: infrastructure to flush memcg stats")
Reported-by: Minchan Kim <minchan@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e4c8735e7c85..bad8f9dfc9ab 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5586,7 +5586,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	if (alloc_shrinker_info(memcg))
 		goto offline_kmem;
 
-	if (unlikely(mem_cgroup_is_root(memcg)))
+	if (unlikely(mem_cgroup_is_root(memcg)) && !mem_cgroup_disabled())
 		queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
 				   FLUSH_TIME);
 	lru_gen_online_memcg(memcg);
-- 
2.43.0.429.g432eaa2c6b-goog


