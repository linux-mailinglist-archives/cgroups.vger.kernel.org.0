Return-Path: <cgroups+bounces-6407-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9160A24806
	for <lists+cgroups@lfdr.de>; Sat,  1 Feb 2025 10:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E91B164DE2
	for <lists+cgroups@lfdr.de>; Sat,  1 Feb 2025 09:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990981494A5;
	Sat,  1 Feb 2025 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh9bUMs/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31593F9C5;
	Sat,  1 Feb 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738403514; cv=none; b=bfka6NSvgF1pz2twZlddzTI1TjLmZDBh33osmISdUWH/7g0kO3rIB9/Fl2KmUwMCd7HaQKzfvJkQ7cIBRaKBZN3MhBDTExH3NpYzGL6svo9R7/lzNUHEZTBdt5q+FJkl8EpffmiKJaP2iwHUtRdbPslzutM5SCRlrpsl37v6RUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738403514; c=relaxed/simple;
	bh=XNPLmTu7g4O7Xoii4IS+RkrJZtMGwJWVOcITAXYVbRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ajxqf/Uym7SYrv9FOgnvbVruhOi5W4061VeDXku+8C6E9bhfBfha/fABHf96J4ww9pBfD0q4EvFN2HvPF3yeGEyCejiSJpJFmB/2Fd3kiP/M4iuh84qjFXOeziLV95NKj1Q1qMgIw53I0trRp9hEkRuZsEM9g0Niox4vFaUngVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rh9bUMs/; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2161eb95317so49147415ad.1;
        Sat, 01 Feb 2025 01:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738403512; x=1739008312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eEKIgvJzCHrLU/eHOSQhidalsv93ZokbwHbTteKHLMg=;
        b=Rh9bUMs/nROR06NWIus4Kuu324PobPEiDmvyLsNLjkA9gcpZClrhYcOT00nLy3MQER
         o3XAoqaUNgJiYuhCCreqoT6xwDAom/TVdQ5Ovy5JzJuNkorpKeYf88nYLJUoK8qptfeg
         G+UkxkQ8p0zEFuvd/I1quiHUq4lb0V0NtB+DJQdy3fLbXeAwVIgphMYME4SLthVgjSeZ
         3NendCkdCgOuE5ChmiasV53yG7Jc4zDzKGFTSrNv1ofcchUW0pD7iGv7QtFwzEzMYHaT
         jEoJLnx+V3JarQ64YYjDlk6NrcQJBqd87+AIs9cyNnxJv9GGNyxeE1jBXlRSCwnJ3EwK
         Ri5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738403512; x=1739008312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEKIgvJzCHrLU/eHOSQhidalsv93ZokbwHbTteKHLMg=;
        b=Z5YyVXrribhGDc9a3hSCES2LvSYjku8VgI4gkf/FoyQW6Tvx4Cwveux5h65294uLgk
         5d8oQ/dLhg1qF2Ut2bpV9G2YyMVd7uJCvcXNFKD6uTiSnQL+1gbCvgZ0AsxDLDTGYVEe
         HwO4zdcKHNv+XyluW5v6xXH8AwkyvrQfTDLtuuXtTeB6FB0m3DMm02VKp/xTc/ewXRHs
         y62XMvRcnfk04+255nAxE/bD9DWyXfKAy2089f9Cvv+T9nfRdwUgHBzCwdxlgmEc6cfy
         toDNgOBolnG3+881jS7yikEoaqT4rBIq+rFaIWJhG72IBEoUH9YGwatwwfl7MXNm4CHp
         09oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOPMI5VSkhuW4Z+rT1kQ/szfIXeNUMhbKKS11qa2DSj0QZ77J7Ei3ooch88Xu7ZyoYQWwp2gv6@vger.kernel.org, AJvYcCWggyiLvm2owB4OyPEHQdTVZM300tgc3WZcso/3NzjDrq8XivIfvJzFmNI+K6bNBCZ5HeCCCYoaSkxZMk2d@vger.kernel.org
X-Gm-Message-State: AOJu0YyVDisB0aL0AmI0ONO7TkQM7JeqOS5Q3zouVi17FhWZhKETbhOh
	ud6/4MtfvtxLzDBHwnytGa+OImU/tiUDirR9wFwluhHF1wUbMBOT
X-Gm-Gg: ASbGnctllOQ+xa39CUNXSwzTkO9EV63tf0B4grE7BZBESQLDTLxwX+JeptMH0toQxUd
	V2jfd6fJ8A6f4r1rtszytHz0W58BWza8lyKfgMHLtilIMFUqTIS68IfpUEhEb1peP1Hwj1qjleI
	+d9c147jkQe+BXV3MQTCmE8YO8jeEB1JNsBa2VrIkPHTcYmeVcO+YQT/mGa6XmooUwqHgCvyVSR
	rF+FTXw+toCynSoL/am2LSz6jmnN76fsj2+klPrNQZVCE572SO7Plzu6m8FYHuH9+2AmPg2tXmE
	P8S1DeesTldPO1w10pNMHRlUkIAVHYySKIRY89vy348XPtS8fRMpgECJmlo5xEi8USk0sbU79qj
	03NGUSrRrdJcY
X-Google-Smtp-Source: AGHT+IFyrGJ/ADpSmNfnEEsU7Da1mkjiYBmUMieib7j1Ywzt5OocKc3/8aEY8su8diHKTdby5N41oA==
X-Received: by 2002:a05:6a21:68e:b0:1e0:c3bf:7909 with SMTP id adf61e73a8af0-1ed7a61d02cmr26205417637.41.1738403512055;
        Sat, 01 Feb 2025 01:51:52 -0800 (PST)
Received: from codespaces-4a2804.mimvmn1ww3huhhjmzljqefhnig.rx.internal.cloudapp.net ([4.240.39.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6424facsm4702635b3a.39.2025.02.01.01.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 01:51:51 -0800 (PST)
From: Umar Pathan <cynexium@gmail.com>
X-Google-Original-From: Umar Pathan <cynexium@proton.me>
To: tj@kernel.org
Cc: lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Umar Pathan <cynexium@proton.me>
Subject: [PATCH cgroup] https://github.com/raspberrypi/linux/issues/6631
Date: Sat,  1 Feb 2025 09:51:45 +0000
Message-ID: <20250201095145.32300-1-cynexium@proton.me>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing freezer propagation logic improperly reduces
nr_frozen_descendants by an increasing 'desc' counter during unfreeze,
leading to:
- Premature parent cgroup unfreezing
- Negative descendant counts
- Broken hierarchy state consistency

Scenario demonstrating the bug:
1. Create hierarchy A->B->C
2. Freeze C (A/B freeze via propagation)
3. Freeze A->D (separate branch)
4. Unfreeze C -> A incorrectly unfreezes despite frozen D

Fixes: 711f763 ("freezer,cgroup: add freezer.stats subsystem")
Signed-off-by: Umar cynexium@gmail.com
---
 kernel/cgroup/freezer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index e9c15fbe5d9b..d384df2f53c2 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -304,6 +304,7 @@ void cgroup_freeze(struct cgroup *cgrp, bool freeze)
 			 */
 			if (dsct->freezer.e_freeze > 0)
 				continue;
+			
 			WARN_ON_ONCE(dsct->freezer.e_freeze < 0);
 		}
 
-- 
2.47.1


