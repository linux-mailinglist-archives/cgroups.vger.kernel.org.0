Return-Path: <cgroups+bounces-7123-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B63A66D46
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 09:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BA918923EF
	for <lists+cgroups@lfdr.de>; Tue, 18 Mar 2025 08:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574E21DE4C9;
	Tue, 18 Mar 2025 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXhJLyRV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9677D205517;
	Tue, 18 Mar 2025 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284740; cv=none; b=OgwVpN2j+LuIYyo99I5dpqOGe9O/6/hUX46ZKJyt1e0jdYzD87SlHeUlecXp3aBP0RfKsgYIb1XjYJEXE9RPDrsjtK4FpjxuNe5a8C27aBk603xJ0GH7dDPSAPSmdA588ga5O15ZIT8bdFEKDejjaY/Rp7K27FBqbCOvEIsV/WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284740; c=relaxed/simple;
	bh=+KVFcHIwzStrciFn3y12/MmssBKVGWVfcdRpI1Dw/Zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GcsnRW5ycrKidgigqXjdMMYfwoS693SczMXEiOD/6xUQ0/duadcGOMyNzNEFATf+rsU0K9b/HeJjYDO61pnPuR4WQT7tGXGeBucCqUKdyKowHWz2dk155V1bnKrrVrId4xRe+TAtVG1BOJHPj8CyvofkbCHm2Ow745shgJU+lfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eXhJLyRV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2241053582dso467585ad.1;
        Tue, 18 Mar 2025 00:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742284738; x=1742889538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYkie2WFFPh6MLf16Vdfl3mc2wE13ro8k5To4/q+ryc=;
        b=eXhJLyRVpIak7XmBIvbe5TsIvhMZob1pQQgWke9mAzhNlefyZyQmiG12R0Mh3aiYYM
         4qNVUN3oqr8yQ2PnHeGM6VfbtMSFVhYNYak3Zt9kY1XnyePSCyzUjuHRF2Q1TqsU5K06
         pFFV+NKQDDdy2gjrozN+5tWoUyc+wXQxHIpet8/1WvXFoE3UgWIk2z6mOpPN7m0oCEEd
         5fpu92O8ygqcxetezMXlGqBxfr3jaLFiscQ6dPh62QYTBfk82ZoRNzhpfRigrav4Qu1d
         FHxEzHvHb1NjpycmZ1GzHfeQME25HCQNXQ0WK0wSL7pvkIJcQk9wnnkvzt7/rCYKl1GP
         1v2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742284738; x=1742889538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYkie2WFFPh6MLf16Vdfl3mc2wE13ro8k5To4/q+ryc=;
        b=RFREmkVrpdlng3oZjz7wKBi7ktjfxLVe0aIh/i0gaDpzfM4hivx4tbVdHZaUvZc2oS
         ZxWepgz0PSekDgv0AHd3QNp+d1HflprpKozZqV2OmAWF46JZAeC4asRDmRRhyHDgWUA6
         PVTwzKVbpemiewR2p0u+AYWPuSctqOcx0W8WSKyIhU/0Db3KdlBILp8Udcla8Xrq959f
         rXU2rudSpJmaJCQhrVlXJRP22zFCpLpAdUt2iN9pO9I57FHpRsP6dgYlzgl641AYcjro
         yaHvFBF/XvsuXxluD8TVkY1owfY4Y7emnFl38+zMbqBMxiTHYywMIks2JklmHwGXOGkl
         cFmg==
X-Forwarded-Encrypted: i=1; AJvYcCWTYhSyA0Ckdhy0XdarT2zAY+wxELaHCJA7iGlbULb2gychvOPi/Ld0yh7u1SWxGTghDb9Fzev5poWTNT34@vger.kernel.org, AJvYcCWjQo8SjCr/YvTbl+N2qvtHezWhfHUf70fBp3RDWBcBBJizF4+A0ektUiRTBKi4/bSvkYDVyyE6YjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6WLyQEn03I2qdxxM7HRpjNDZF5qRq/QUrbItIQ5j4Fi+yZ4DA
	5K9UICJXRkkUVEGx1fUuY2USGdDELTiKAi6MPjg94NrWx0a4YbtgSCcRZg==
X-Gm-Gg: ASbGncvnM5gIXi7vdj8LfW3YnlKcwwcSOdHrMcGxZW7lOQHRiixzfpk8enji18afDfQ
	TLQ7tKGBOh7lH+ZuMzlrIMlZLioxxWSaqN+Z5ppdNhrMxuPLF3lEq3DSTsnqTnFhwvJZhMhQtm1
	yD1v+eVETX2JQjtuK+sKaaPNiCi9Jhx/iJFydFXGN7LBcLgW0bS7CgyU0teajFVbTGkDDcb3HK9
	10fKtPrGp8peGQfZvRCRBs7vYLF8E60HfjJUGAdO94yvkFUmruiJXDQ1MhgTdMQMcZJIAm2BvbD
	fnsywy26xa8yfRW8mldwwoTaOsqgD8J7JjdmJEvF2o7J4HUGKmzHI+zbYiotxeve+JWBPJDMCw=
	=
X-Google-Smtp-Source: AGHT+IHZPc811NNLRZEIxP4R4zyaMG1jX2U3vYy0bi+ioTPSMd6Mg09k60Le2zemZ1Wb06bX8d7uHQ==
X-Received: by 2002:a17:902:d584:b0:224:1234:5a3b with SMTP id d9443c01a7336-225e0b62e3dmr201449945ad.51.1742284737785;
        Tue, 18 Mar 2025 00:58:57 -0700 (PDT)
Received: from localhost.localdomain ([103.165.80.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbfdfesm88149865ad.203.2025.03.18.00.58.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Mar 2025 00:58:57 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	corbet@lwn.net,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>
Subject: [PATCH 2/2] cgroup: docs: Add pswpin and pswpout items in cgroup v2 doc
Date: Tue, 18 Mar 2025 15:58:33 +0800
Message-Id: <20250318075833.90615-3-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250318075833.90615-1-jiahao.kernel@gmail.com>
References: <20250318075833.90615-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hao Jia <jiahao1@lixiang.com>

The commit 15ff4d409e1a ("mm/memcontrol: add per-memcg pgpgin/pswpin
counter") introduced the pswpin and pswpout items in the memory.stat
of cgroup v2. Therefore, update them accordingly in the cgroup-v2
documentation.

Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index d6692607f80a..c0ae7a76005a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1555,6 +1555,12 @@ The following nested keys are defined.
 	  workingset_nodereclaim
 		Number of times a shadow node has been reclaimed
 
+	  pswpin (npn)
+		Number of pages swapped into memory
+
+	  pswpout (npn)
+		Number of pages swapped out of memory
+
 	  pgscan (npn)
 		Amount of scanned pages (in an inactive LRU list)
 
-- 
2.34.1


