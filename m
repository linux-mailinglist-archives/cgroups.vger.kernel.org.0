Return-Path: <cgroups+bounces-8968-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F591B176A7
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 21:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C69B3B059B
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 19:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41208246770;
	Thu, 31 Jul 2025 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJslTZLQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9915E5D4;
	Thu, 31 Jul 2025 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753990154; cv=none; b=BLr7dieCsbdtm/Efz8gpcz8qr0wo8UegMWyXbaaplfq/cOf1unBTTh5ObK5psWt6zfT7S0Ay1s4M2EfGHS/Iwh2ydSCkAWcRLaq8/KoV09/wrg4RAbwgE//lcw/0kuC8epIWIsMu6snRf1OWyMXayLGhpwLtv/9spzbrCLOSGFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753990154; c=relaxed/simple;
	bh=VE/tzYdfGZZBuf+skzoZL7cSdNZB/LxRUUJyIwjHbjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L2FIY6VM176kVN2JLVciDpjJgsIbUQVfCh0O+jyCVElKMTu0/C+gk+0YLg20Kha2Ooezw56gZVUDbPaUmxSJ/y5Qq9MafTSvmyKNLh69Teox5f7BVmoMAIDEF7jjllqgR+TB9r3f38mfSc8K2AK0iIQnFazgl3xh6bTxMoBOLVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJslTZLQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2402774851fso6934615ad.1;
        Thu, 31 Jul 2025 12:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753990152; x=1754594952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PXGnA9BpNW3BWEO3s/wGyyi0bHoDNeH/nispaC7BBws=;
        b=cJslTZLQcfSSUVToVRti5l66jxYqpUXM12PiJyMEWu+KX1HRyXQxm6jf7RPLZFsBlT
         t+DHVTcako3FihtGrFIO7p215dlr5oUHRKryHxyWAezywjSHXyue2sKVU1AblsjPc5T6
         uVHdgIa/fjJ7d5EoF5EZTCSqNlnI41Yw73gVMLLkrdRhbG605T2us6LnKZV4LH1VOYYj
         0dDlJN5xnPo7V/3VJKkkJJXzDCu+DMU2JnvkEZZnLC2VQSbjESUKkjVhix5h0bRabtXJ
         iJm7La00t7i826YaIP8eMZgrfPEKap6eiUCO/z3ubLSjq0hLCqEXfiz39uDV5sHvv/hW
         rH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753990152; x=1754594952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXGnA9BpNW3BWEO3s/wGyyi0bHoDNeH/nispaC7BBws=;
        b=R0xJWvDubk2qtGX9wqmtQ8Qa7/8ha3jgQHcl7h0gpNp9g5103wp03bN3Rr73k9XyCI
         GF/nHHitNuAGd6wuKF3SXlI6CjXzJODSKq91G4hRePFMsEEA85GZa2ORAmmbMA1PmaUR
         X3FDlWL1KOXlhZSaZz8FaUS0/0cy/UCjjczxFh/ibG4SlY+t2er7+ADk3aHqMxTkev2W
         O7nfeGKGD0TrSS0blAvKY3evuahWnBytnnxvuUVsYdSzKkBReOtOF7FWjnotN6EpiD7C
         +Q6fghRwfdzcKeZx06fASIrl3ddyfvkzCxDngptKs/wTWpwOI652SXlEfceD7o5mmXwF
         zbbA==
X-Forwarded-Encrypted: i=1; AJvYcCUFzeI5Cc+qpRL1KcIrAaml/Lbhff2DgZKyVwQIOafvhGO0G9QrdWn64fVW03/XlkIQ7liC3QKr@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz0gMQXr4iI/e2Uz3FFXznEhnvuQgKWAu+1zViGdBAGiJifHgc
	X/LNx93cfMJnlpE38FKnnqQxl/jaIK+Rs0XMJroth6zgLQ1fNTVSd2vD
X-Gm-Gg: ASbGnctjKxAK8HpuP1uzXZo1XjZBA4FcDUsXqeFO151NEwWcFSEIdKL5bamT+5Tj7dp
	9NfVaZLsr5uJGOFSWDVltgdxkKO5UPPNNdodkruh7kI14+TKqbd4TFA6U5RJszmyGcPO9bYtoQc
	+JyZbj571OeIjlAEKNxRuiudKo1DlQPb2U6HuGAlad8UEdYrRwZeKGFfh5fDCZAMB7x7/boqp0G
	fg+rHBhDtM8z2QwVbsx3JXxw7AK5tkKnP3RQnOf0pR3QMpeHV0VDZGV5G7gCvyptZi+GRUiw07I
	NhKyIMNaJOigUdfWtHoq6/+BChCmYGXMl88xUXnZ9awHNiN0LYXBmjA34IxcT8335UF6aOBbfHQ
	1cOGXxXNnIcH2pvigy7DyBoYmx9AFHqd5+V+ip8a1Q2kiruJm
X-Google-Smtp-Source: AGHT+IGH5WZqIXIvdWFWC1sk2JEWAguG77tjI85n6QSk+jAFYF5i/J+QSQjQBvp8A0WfARlnuSbyfg==
X-Received: by 2002:a17:902:e885:b0:234:ed31:fca7 with SMTP id d9443c01a7336-24096b810b5mr122182055ad.48.1753990151787;
        Thu, 31 Jul 2025 12:29:11 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f603sm24824735ad.48.2025.07.31.12.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 12:29:11 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	mkoutny@suse.com,
	yosryahmed@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH cgroup/for-6.16-fixes] cgroup: avoid null de-ref in css_rstat_exit()
Date: Thu, 31 Jul 2025 12:27:34 -0700
Message-ID: <20250731192734.106214-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This function may be called asynchronously in scenarios where preceding
calls to css_rstat_init() have not completed. Return early in this case.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Suggested-by: Michal Koutný <mkoutny@suse.com>
Fixes: 5da3bfa029d68 ("cgroup: use separate rstat trees for each subsystem")
Reported-by: syzbot+8d052e8b99e40bc625ed@syzkaller.appspotmail.com
---
 kernel/cgroup/rstat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index cbeaa499a96a..408e52d5f7a4 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -488,6 +488,9 @@ void css_rstat_exit(struct cgroup_subsys_state *css)
 	if (!css_uses_rstat(css))
 		return;
 
+	if (!css->rstat_cpu)
+		return;
+
 	css_rstat_flush(css);
 
 	/* sanity check */
-- 
2.47.3


