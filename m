Return-Path: <cgroups+bounces-2150-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6915E88A99C
	for <lists+cgroups@lfdr.de>; Mon, 25 Mar 2024 17:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185782C5328
	for <lists+cgroups@lfdr.de>; Mon, 25 Mar 2024 16:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F3E18645;
	Mon, 25 Mar 2024 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QdARsOun"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DF96F08A
	for <cgroups@vger.kernel.org>; Mon, 25 Mar 2024 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377987; cv=none; b=jzRKZdYpnmW+EpBmH6lnAcfSySJ9xyL78psVdhDMAmhflTzAXTAyOEuGblydw85CGVPREtt1dsdDtcCGVhpJamRZzfEUo6klR4sb8Ewl+tLOHqBtVVjoS3HnSFC7vcJ8vmcTuWNTj2yjrnIrKYetyeJsasNQkcnbTB/YcWB6zbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377987; c=relaxed/simple;
	bh=VHY+Ja4s7aWlDYjsYGYjs0GpfHrMNePfAOso+KC/MHw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r/kMw3gW1XfafKnn3NOqIF9GNnL3lo/Z7yd0B0sYuu0pNhlUm/qGjW69v8MgR1nOW/GDnkZNqMZpsxBngaS/KMJy+ckHUDdaX+eAt7FPNPof54vRFObXjOa5NrxrleoS71BVAef30Am1zr66nY6V7ev394Ds6hs8hY5zFnVwbT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QdARsOun; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e0878b76f3so21331045ad.0
        for <cgroups@vger.kernel.org>; Mon, 25 Mar 2024 07:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711377984; x=1711982784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VHY+Ja4s7aWlDYjsYGYjs0GpfHrMNePfAOso+KC/MHw=;
        b=QdARsOun457hHiPBrNYSYukR6N+Vof+Ih5bGKGlIwZIHejiRCRP17/XnXfc2ET8JQK
         y9NntVV4Zqs0QgfcEVOHeMJJ4XGs8lsgk7DnCmOWpuJ2eJP6g7vAEMLQoaREPZBg0zKH
         9HZiIJnw2VtVbP51EhTdREJEb9qff0QOgU0ietn23yH9ISEtEwkOaRZx7Ip4Wc8se11H
         OjpZGGCfsxzNAn/kI3YemM8nDb3coI/VbH/C2ca/KmLkKv7muIctR1Wx0nnG49QkgjXq
         +0oK6eh0izeJlEacyaSSiVta7bf9zRYi+IyZ0wSewrPbaCecqBBJoOT0sqvwgZUhb2nn
         5+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711377984; x=1711982784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHY+Ja4s7aWlDYjsYGYjs0GpfHrMNePfAOso+KC/MHw=;
        b=nz7WJUN7aiSCZK4JyyuOgmRxA0jkEGCS5x4fauhnYisc+B7T9pArsLkn8oA4mVd+Qs
         4Lp/rgMS2qrdJVWs+yYVDNCf7tBVv38zE2wZjBF9lMf8fcuSU2v9Fe0fbrlUC/5Ea4NV
         s1a4f+TuawYb7X5UfQgJ3bQKTFl30T9JVBo9/2AsWnudsTWx3H5XfzFfAeGrPD1dHW9k
         ezsYY+7GcSHRXj1qz1bXeOQTB0K1Z+AUJkhWsXtvoAtbFypC2ofPvh73qqNhXcYxuZTH
         KmzigFs/xh3wnyfVYhalRtUg8kTETE2RBHlbZD4xtcV59cka3gyZR9WsqqWfa0Gy/eDu
         lTkg==
X-Gm-Message-State: AOJu0YzB7wagDon6Ji6uUVGnelh4R9aG2UfrcXXcRfCDoi0Sgb6/F8U1
	/n8fYcZiZc0exM+5twTqfFmFNaL706r8GgKFengi+NdJS3v2r0naWTmAuMnFqdDGJSJpwjSDVAB
	J
X-Google-Smtp-Source: AGHT+IGWfXe+5ZY4S8w58lz1Z5BsP3UaB6Ks/eg0HWNbYPp3rM0T6/8ww0b7HckXn1/CEy1TxIp/Ug==
X-Received: by 2002:a17:902:ecc1:b0:1de:de7d:d3a6 with SMTP id a1-20020a170902ecc100b001dede7dd3a6mr9432854plh.30.1711377983813;
        Mon, 25 Mar 2024 07:46:23 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.103.200])
        by smtp.gmail.com with ESMTPSA id u6-20020a170903124600b001dc30f13e6asm4735411plh.137.2024.03.25.07.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 07:46:23 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: cgroups@vger.kernel.org,
	longman@redhat.com,
	tj@kernel.orgv,
	hughd@google.com
Cc: wuyun.abel@bytedance.com,
	hezhongkun.hzk@bytedance.com,
	chenying.kernel@bytedance.com,
	zhanghaoyu.zhy@bytedance.com,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [problem] Hung task caused by memory migration when cpuset.mems changes
Date: Mon, 25 Mar 2024 22:46:09 +0800
Message-Id: <20240325144609.983333-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In our production environment, we have observed several cases of hung tasks
blocked on the cgroup_mutex. The underlying cause is that when user modify
the cpuset.mems, memory migration operations are performed in the
work_queue. However, the duration of these operations depends on the memory
size of workloads and can consume a significant amount of time.

In the __cgroup_procs_write operation, there is a flush_workqueue operation
that waits for the migration to complete while holding the cgroup_mutex.
As a result, most cgroup-related operations have the potential to
experience blocking.

We have noticed the commit "cgroup/cpuset: Enable memory migration for
cpuset v2"[1]. This commit enforces memory migration when modifying the
cpuset. Furthermore, in cgroup v2, there is no option available for
users to disable CS_MEMORY_MIGRATE.

In our scenario, we do need to perform memory migration when cpuset.mems
changes, while ensuring that other tasks are not blocked on cgroup_mutex
for an extended period of time.

One feasible approach is to revert the commit "cgroup/cpuset: Enable memory
migration for cpuset v2"[1]. This way, modifying cpuset.mems will not
trigger memory migration, and we can manually perform memory migration
using migrate_pages()/move_pages() syscalls.

Another solution is to use a lazy approach for memory migration[2]. In
this way we only walk through all the pages and sets pages to protnone,
and numa faults triggered by later touch will handle the movement. That
would significantly reduce the time spent in cpuset_migrate_mm_workfn.
But MPOL_MF_LAZY was disabled by commit 2cafb582173f ("mempolicy: remove
confusing MPOL_MF_LAZY dead code")

Do you have any better suggestions?

Thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ee9707e8593dfb9a375cf4793c3fd03d4142b463
[2] https://lore.kernel.org/lkml/20210426065946.40491-1-wuyun.abel@bytedance.com/T/



