Return-Path: <cgroups+bounces-662-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C19447FCD65
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 04:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5286B2833F6
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 03:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD08B5662;
	Wed, 29 Nov 2023 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sL5L5PZv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4B81AD
	for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 19:22:01 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d12853cb89so34215357b3.3
        for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 19:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701228121; x=1701832921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ky2REY4MxzMO+RxmPId6O0x4sdb+oIV13EhP53U4pHw=;
        b=sL5L5PZvd4xwqyCkpJqWaIUcaB7q8DD1oraoEiYuNedWYrqGfEGZ6UeQP974N/CUAm
         yJyw2TIyhnmQmeMGcfsFtlbjJqPxU3qkL/xUo7kt+suL2/x8j9RoYQ1rUXcziNJ1iXhL
         i0nNCDtfD2zYTxVveP7mOm3LOhNdmt4/yHGGRA1E8ldLU0MXYlD39cZFiCEl9rLrYen7
         6OnelRY0AUs8z9RuCBcDJtTYkbvNn4lHNor9J/KsEri3kXENxCpoCWr0Nql1p+iFJ2LQ
         Aabk5+55jG0msA/OjQTJ5YQEMLQC87f8Ih2bJiBTlyyrCuppffQRwMQZ61+e/ibyUrEM
         bdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701228121; x=1701832921;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ky2REY4MxzMO+RxmPId6O0x4sdb+oIV13EhP53U4pHw=;
        b=YEQlteuWsdNGzLV/2yeWJiILusZi+EAat2uMYonLH70Fs42V0BPLh1ElxU12Z3Vw5O
         Q80xWXB80KyC6SjmDVrr0xRaFh2zyVCn8pYQyddLN8YpMXNnj79gWnh4YQE9OBSXZsyr
         Ud7/yvxXAD4uHhU0VIuCE/bOkJ1Sdr2Fmf4t9Y583tNV+V+6uT46xMPu5p8LPe27e14D
         SfEH+YVwU5A438lfqMH48M/LNk0yl+k6kiOVG9GfVK35XWA6CLfn/niLegPrPJwwmaz0
         C5QrhLpSb1p8CoOEZ2uB6Fi/ojtEKJKURQdY3uEipmyBDestXosDf7YJLsf19XBr1fE7
         uKCQ==
X-Gm-Message-State: AOJu0YyyhVUYp25hI5NV1WsWjV4iquyVbGpNblCR5a/IUAFtWkR2Uvfq
	3xs3o7boPAUuichv21HHMUN47durUteuFnG7
X-Google-Smtp-Source: AGHT+IGouOmFvlCqrx0oX4pFpmBSxSf6/wqNiY3Cuy+K3AoX5MxSxr91W70yChZlk6piYooZGVVAx0PEPE6lQeE2
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:2e10:b0:5cd:c47d:d89f with
 SMTP id et16-20020a05690c2e1000b005cdc47dd89fmr499535ywb.5.1701228121058;
 Tue, 28 Nov 2023 19:22:01 -0800 (PST)
Date: Wed, 29 Nov 2023 03:21:48 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129032154.3710765-1-yosryahmed@google.com>
Subject: [mm-unstable v4 0/5] mm: memcg: subtree stats flushing and thresholds
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com, 
	Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

This series attempts to address shortages in today's approach for memcg
stats flushing, namely occasionally stale or expensive stat reads. The
series does so by changing the threshold that we use to decide whether
to trigger a flush to be per memcg instead of global (patch 3), and then
changing flushing to be per memcg (i.e. subtree flushes) instead of
global (patch 5).

Patch 3 & 5 are the core of the series, and they include more details
and testing results. The rest are either cleanups or prep work.

This series replaces the "memcg: more sophisticated stats flushing"
series [1], which also replaces another series, in a long list of
attempts to improve memcg stats flushing. It is not a new version of
the same patchset as it is a completely different approach. This is
based on collected feedback from discussions on lkml in all previous
attempts. Hopefully, this is the final attempt.

There was a reported regression in v2 [2] for will-it-scale::fallocate
benchmark. I believe this regression should not affect production
workloads. This specific benchmark is allocating and freeing memory
(using fallocate/ftruncate) at a rate that is much faster to make actual
use of the memory. Testing this series on 100+ machines running
production workloads did not show any practical regressions in page
fault latency or allocation latency, but it showed great improvements in
stats read time. I do not have numbers about the exact improvements for
this series, but combined with another optimization for cgroup v1 [3] we
see 5-10x improvements. A significant chunk of that is coming from the
cgroup v1 optimization, but this series also made an improvement as
reported by Domenico [4].

v3 -> v4:
- Rebased on top of mm-unstable + "workload-specific and memory
  pressure-driven zswap writeback" series to fix conflicts [5].

v3: https://lore.kernel.org/all/20231116022411.2250072-1-yosryahmed@google.com/

[1]https://lore.kernel.org/lkml/20230913073846.1528938-1-yosryahmed@google.com/
[2]https://lore.kernel.org/lkml/202310202303.c68e7639-oliver.sang@intel.com/
[3]https://lore.kernel.org/lkml/20230803185046.1385770-1-yosryahmed@google.com/
[4]https://lore.kernel.org/lkml/CAFYChMv_kv_KXOMRkrmTN-7MrfgBHMcK3YXv0dPYEL7nK77e2A@mail.gmail.com/
[5]https://lore.kernel.org/all/20231127234600.2971029-1-nphamcs@gmail.com/

Yosry Ahmed (5):
  mm: memcg: change flush_next_time to flush_last_time
  mm: memcg: move vmstats structs definition above flushing code
  mm: memcg: make stats flushing threshold per-memcg
  mm: workingset: move the stats flush into workingset_test_recent()
  mm: memcg: restore subtree stats flushing

 include/linux/memcontrol.h |   8 +-
 mm/memcontrol.c            | 272 +++++++++++++++++++++----------------
 mm/vmscan.c                |   2 +-
 mm/workingset.c            |  42 ++++--
 4 files changed, 188 insertions(+), 136 deletions(-)

-- 
2.43.0.rc1.413.gea7ed67945-goog


