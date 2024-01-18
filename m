Return-Path: <cgroups+bounces-1174-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F147831F35
	for <lists+cgroups@lfdr.de>; Thu, 18 Jan 2024 19:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C041F236B1
	for <lists+cgroups@lfdr.de>; Thu, 18 Jan 2024 18:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4772A2DF7D;
	Thu, 18 Jan 2024 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PMdtktRq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915FF2E3EF
	for <cgroups@vger.kernel.org>; Thu, 18 Jan 2024 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705603362; cv=none; b=gJOhQb9O34wlsfCUS7+Lyx3qR5++oeniiYwXEyOQUo5fpBrU/wasg8+ClX4LzDVM5wpf1KCYvrFyTaKPz6YFD6vz8JVcFP4wcJmbjQBlB5RgsfA/pNZTKBQoLssl4tDylo5u1zC3gtXxH9DQjyReRrswTHubQjJTFyZCcHBoJHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705603362; c=relaxed/simple;
	bh=W6yWw85H3wm9jzeUaOrfwrwakFw21eVoOvO+YQYOBos=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uAZJnzt3XfRCKgbjrw5Di87JuA45XneZA5pRUVovkFU+9WAbzMgJwXHVbNOSJESVOXdSGt3r1Y3y/iwdJEztiqKkMzJLbkjthPjsFmDDGkP8PjbEV4rhtXGqPbNXuIchDe81hRs1WWe6R624fyleSxauKzY+di6Gjtf4CMAM8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shakeelb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PMdtktRq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shakeelb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e8d2c6903dso232268127b3.0
        for <cgroups@vger.kernel.org>; Thu, 18 Jan 2024 10:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705603358; x=1706208158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8yx3MHixu6Yr8K4Tg1W1xt8jDb7qQNzMKngP58qnPGU=;
        b=PMdtktRqJ1Gnc8lPV2zXVo/ZhS+ldr3zp03yaAjH95umJCjbXJP8xiiWsDSXhKy0ZP
         moC4TnRUmtPnPz3nGJs32FW2Yx0Un/pP4HEYTHx24Ci2cC6irlQGCt94Ax9QGW/Ac+4x
         fiti05UZMmvwMEiSt4qv6OCggexdS2l1x98+wUxrR0g233ettGE6uI2uPXBQWBrwHiQx
         qsslHc2B9Q4uNtiivXI8RbMzsmZ8NGeChW9LdrPzEn7j6bpLLDoqWIXggweyv54383wb
         PmkHshRd7RkbU4xMrJY7tpZsd04fJ9H1NmIsYI+QSMJu498MA+sKBy3p2/ZU+E5rW7Ai
         z6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705603358; x=1706208158;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8yx3MHixu6Yr8K4Tg1W1xt8jDb7qQNzMKngP58qnPGU=;
        b=Rr4gdoeotmsnyn1tJmBFKX9YmLi6T8RRU4KaT83n1LBHw5mAnNM+sZTih+ELuNrQMf
         h07m1110Wdyn3ByjgvOp6FbxwdbsTgLb2NEqt+s9GMGUyZADjIFwsjll9X7486Vnl0nT
         tG1mNrNTqLMKiBCFQWsA9UOTilZi6rCp8Ug+qzgNW8hNXhHlN3Blz7yKqNihsW6YihXc
         Yh0zCgCRHDXq4RwnJsj8CO9Yq1klSpPTVsk7oWpzlRU7qrKKSac0xpK2D6J7ZSpANKch
         Fy9qyj3pL3FFKUInaueTvwk+3oAmY+eStuQX2J2g+hnngohQr78ulKiaM5TcoLpnB4Ph
         iWZA==
X-Gm-Message-State: AOJu0Yy/lp4D2K9/z7eYADsgEjgbV8P+6BCy9OV6PAJ1XJ5fUlmfQPIA
	Bo9puXrpthjh8+6v6w/zCt2fGGqB+R5tqTnYYwl3hxnMnwgCEv5yMGoK+ykV/24u+OM+H6hYzc8
	vUViJEyb6ew==
X-Google-Smtp-Source: AGHT+IEiDX57atHRS7CWMR0FbSJ0cy4u58/JtLsH5ArVXLFG4dxXZERL658Remh0yZ2IAtpTFDXOqk/HVtek6w==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a81:98d4:0:b0:5e3:fb36:ccb3 with SMTP id
 p203-20020a8198d4000000b005e3fb36ccb3mr584697ywg.3.1705603358687; Thu, 18 Jan
 2024 10:42:38 -0800 (PST)
Date: Thu, 18 Jan 2024 18:42:35 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240118184235.618164-1-shakeelb@google.com>
Subject: [PATCH] mm: writeback: ratelimit stat flush from mem_cgroup_wb_stats
From: Shakeel Butt <shakeelb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"

One of our workloads (Postgres 14) has regressed when migrated from 5.10
to 6.1 upstream kernel. The regression can be reproduced by sysbench's
oltp_write_only benchmark. It seems like the always on rstat flush in
mem_cgroup_wb_stats() is causing the regression. So, rate limit that
specific rstat flush. One potential consequence would be the dirty
throttling might be decided on stale memcg stats. However from our
benchmarks and production traffic we have not observed any change in the
dirty throttling behavior of the application.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 935f48c4d399..2474c8382e6f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4776,7 +4776,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
 
-	mem_cgroup_flush_stats(memcg);
+	mem_cgroup_flush_stats_ratelimited(memcg);
 
 	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
 	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
-- 
2.43.0.429.g432eaa2c6b-goog


