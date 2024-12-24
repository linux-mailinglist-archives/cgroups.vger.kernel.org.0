Return-Path: <cgroups+bounces-5994-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A94669FB827
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 02:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0603E18849EB
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 01:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D3C8BE5;
	Tue, 24 Dec 2024 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daxRv1St"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D375C372
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 01:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735002856; cv=none; b=B+jWA1+e/hVhxPoV/RtU2qyuKaBJ+hm4Uz1caa3JdmJc0tgFcJdj2ChiiHPecKvawTa7g/UQWxATK0l2ashqO9M+54BCbRKMCEDpCHmAwdro+YSwevO48lcBM/aw9MLFKbRBcOll3QEGcc4nPMVoHaArPuDhE1BuAL0jTivDRXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735002856; c=relaxed/simple;
	bh=UHrfprCYcFC+DP46GPOTFZ4pskqcJDJPojF27UOX+eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rqaWP0eTl6QmxHyOf0cXCqTgNGFv2VBTPb/LE7Hw6WgFWUp4LCFeqm9wvPxe9C6r0qB6YXawVI6ndfZZJN6VAN2sDVD2sJcr/NfzPCEAo7l4Aj3B1atBqShucttQoOJPmNeTOca5OCMXJyggBcbqDKghcrWfzoCah8e4z7XkVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daxRv1St; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2164b662090so40612545ad.1
        for <cgroups@vger.kernel.org>; Mon, 23 Dec 2024 17:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735002853; x=1735607653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EMZgjPOKDWbIFdVRAa452Jjp52BzjoU4BJ4SQLn/om4=;
        b=daxRv1SteZVy8ImRdXu1hWa40Ya+44Lrqh0Oof5ph+D/7pG/YXgL3vc5e4/GdpzswO
         JDoeC54z0iGqL8TMu+o1rTWyKGgXMkCq6rEULTAxpbjY1DIbVNerz4SSrp1PVM/6nP5q
         2R6dopizfMlSt0pfB/yE1Ajq5uTO+Z+8xIcuCybswnBp3kOz4mVa9Xp8MmgUXFo3ATvO
         MNSV5kmr2Y2/TWNOg/gPPdwRlpX6vvongz+ktmOU032qOgjy5SbbPsHJUkQ2bphSUVnE
         UCkRvjYk8s0cKQapMNnq2K8gpPqx3qM/TiJabR3Uxr9JIg/7i46A3wYrcEdEHIZpXldH
         ptlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735002853; x=1735607653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMZgjPOKDWbIFdVRAa452Jjp52BzjoU4BJ4SQLn/om4=;
        b=sWFIlB/Q2EedCPsSCtpbr49kPyCQMAaFbZNkNQFuBcqkalmoD8c7yComwH5QagmMay
         Gv6LAD+Z9OX0idCdCgpa7plJH/qX1xyI7ExnxMPfEX8POrlAzhT92wq6NoE/3UK4N5Eo
         j4z9NU9kQh0lm1UeILH26kI5IdFp4/sRwo6Q9K1oBXQo9Z1vfrMlxOLDyBNlPO6x1JyG
         D9gntLQE6CwXf7V5DoLY5zgcQSygHPRWBMDGq+DA1VxEm5KmC4a1rGf2o37fwKW7HwC0
         j6GFWQzkiKCDdc1n9VAFeYjkZrZ0o1MCObzzQRhZeP6KIod9R8cOQJqkfdZyMKcV9FVT
         oGmw==
X-Forwarded-Encrypted: i=1; AJvYcCUCaSElFQ0SZcPpqRlO1EGrEreONInLOdWis4PujgquKUDyYTmDIwqd+SMv2DX42WSt/YPQB5Eb@vger.kernel.org
X-Gm-Message-State: AOJu0YzovF8a23NTjzFokyjy4Sr+Kn0fdrMGsx+4fqH34DywlEH5MhNf
	AatL6L1L/CmPS1rrLvfnpG8gzd57Pd6zo2aUYhkAbsjz7xPEevtm
X-Gm-Gg: ASbGncsbxM9+s4lDwUjEiR/poEQnKEPvD+NhINHVbs4GAJdJ8cjzXgRm2+ufEXiSha0
	J80K3y1nBeGJD7VcQOVraVLoaBaizyrITWGCbZhffmgNgEdCIdr+8q7P6QizG1yi78aa9bipqP1
	gHKkASCMDyKpsVWLpJuLaH2mAk29m9NvFt4K0LQ21GRqiehscKosCEh8iMUmtgB79qL+meBPqo/
	VEBaPFnelrs8xBcLnT07IvEdnLtePy2RTpHV0RXUMTBWfHm1eCLajEvUD1w0k0C4RTALCITS6k2
	fMI6qx0RgNuJuf+FQA==
X-Google-Smtp-Source: AGHT+IGtHv4OrGiGjKLT1wx4ZC9Ze9zsXK63XwMVjaldX2r8rMkvgsNt28FtHFcLAimEPnWDhWEEIg==
X-Received: by 2002:a17:903:2449:b0:216:50fb:5dfc with SMTP id d9443c01a7336-219e6e8c3admr222954205ad.9.1735002853261;
        Mon, 23 Dec 2024 17:14:13 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc970c84sm79541255ad.58.2024.12.23.17.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 17:14:12 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: [PATCH 0/9 RFC] cgroup: separate rstat trees
Date: Mon, 23 Dec 2024 17:13:53 -0800
Message-ID: <20241224011402.134009-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've been experimenting with these changes to allow for separate
updating/flushing of cgroup stats per-subsystem. The idea was instead of having
a single per-cpu rstat tree for managing stats across all subsystems, we could
maybe split up the rstat trees into separate trees for each subsystem. So each
cpu would have individual trees for each subsystem. It would allow subsystems
to update and flush their stats without having any contention with others, i.e.
the io subsystem would not have to wait for an in progress memory subsystem
flush to finish. The core change is moving the rstat entities off of the cgroup
struct and onto the cgroup_subsystem_state struct. Every patch revolves around
that concept.

I reached a point where this started to feel stable in my local testing, so I
wanted to share and get feedback on this approach.

JP Kobryn (8):
  change cgroup to css in rstat updated and flush api
  change cgroup to css in rstat internal flush and lock funcs
  change cgroup to css in rstat init and exit api
  split rstat from cgroup into separate css
  separate locking between base css and others
  isolate base stat flush
  remove unneeded rcu list
  remove bpf rstat flush from css generic flush

 block/blk-cgroup.c              |   4 +-
 include/linux/cgroup-defs.h     |  35 ++---
 include/linux/cgroup.h          |   8 +-
 kernel/cgroup/cgroup-internal.h |   4 +-
 kernel/cgroup/cgroup.c          |  79 ++++++-----
 kernel/cgroup/rstat.c           | 225 +++++++++++++++++++-------------
 mm/memcontrol.c                 |   4 +-
 7 files changed, 203 insertions(+), 156 deletions(-)

-- 
2.47.1


