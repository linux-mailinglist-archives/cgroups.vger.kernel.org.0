Return-Path: <cgroups+bounces-11179-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C761C0A165
	for <lists+cgroups@lfdr.de>; Sun, 26 Oct 2025 02:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7EDC834B606
	for <lists+cgroups@lfdr.de>; Sun, 26 Oct 2025 01:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91931DF75A;
	Sun, 26 Oct 2025 01:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWe5OMOe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F472605
	for <cgroups@vger.kernel.org>; Sun, 26 Oct 2025 01:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761440724; cv=none; b=ayRfHj+HDylDq78lTuMX2EEnfhR1fsPt2J22bEo30ei2s0/bB5vbdfH92OaUc17EMdEEqk+m4pv3oablnw0gSpTWWovhvizu7tt8RoNRuFrdzS3kRoGZUBSqf11rydtUb+8e5a+slB6vJqh1BBEkrDd3DxTpXw2wXE49MBFVd+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761440724; c=relaxed/simple;
	bh=KLqV75PcvEyUm05RQodatiEG/ugFMUNCSjZ4Fbo2bkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGW1N2Za1Wq108oEOdGmejfbb8pcH0J7lrtIzUkG0+9r5Zh37WsympXSdS38YRAc4h9LRe9iXy6Ex/rR1KWr+ryVYQLe5V3x+yLZ3XooC4iQ3aZcpRsJaZ+0iqhwgcyeqvw1t0hiBJVMn2EkMSqR2CfVm6beBSREYmeEEOII+gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWe5OMOe; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781010ff051so2147526b3a.0
        for <cgroups@vger.kernel.org>; Sat, 25 Oct 2025 18:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761440722; x=1762045522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yS34+uhylNdFYNWrvgsPGh1bBy7nTRn8Y42YGAOkzr0=;
        b=MWe5OMOe824Tdw6FcQvWhgeBq0xyEAepk3Q4yOtpcfeHIoNGUzCF1uEh0/FD2ZPudz
         u6luLV2YhOzvd7Sks8zL2aHXJLykn8klOFH5TnXf724gSlLB+QGkJyyTHGLNRpTyBGCX
         L0Qscld6K5t3wYu22El5xRsirPCb0fTf6myS8yr4uqJIyefWFddKxeI2D6BjKamAC0t5
         bOe2yyUqRlX80THK0F6r7+TzO2k/PoKx9rHMkJ7WKPM9oBTVPBb4sgL/Vk3zsE2gdeb5
         CnWqvXnpDN9nWif+3aiBSUy3sZsQBLclDn9w9z+Eweq6mVo3D3iVkUA/++dcreZKwJVV
         VT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761440722; x=1762045522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yS34+uhylNdFYNWrvgsPGh1bBy7nTRn8Y42YGAOkzr0=;
        b=KPFNfA++1fjQ1E9VSONuqOPX62W6k79u353mkZWPQUMbbzG4JSzBuA+GpinLrYa5pm
         1SCvVuroarpx0JZljd1IYF6ZQnuZLjt1VwGBnsiYlvvoxT4LivCSfJwsHArFpyzDXjk6
         THOuF0xG3rOLZFKyp8adVAUqQoCDJwDl9dQcNKSYMmQgqsktVLaEqkCqvoG5r9KXg3Eb
         rYp4PVmVfVjkYSSaWZ3x52Ks+Oqh5Jjfu48D1gphf7INDnB9Q3/d2/nd5vLFotI8QtMx
         z1oOTlEosKc3Zbtc3VwHKX+o2E3lbwCPpTnmzNVUCve1omDRQtyG8TKRnGWPKhTBxUSI
         l6uA==
X-Forwarded-Encrypted: i=1; AJvYcCUrFy9E6B0CT0Lwrmt5Jm0W96RtVlZC43lDDIqPW8GtXVTmrhEz6qRJFRae9p32YBCREt5M+Wcr@vger.kernel.org
X-Gm-Message-State: AOJu0YxocKvEJc0yBZ/Xkcvd+M5V7khLatoWyGbvz7HL2cjWGHdgP1vO
	7GI0JjD3HA9OiUOF0++jXmTLKncjEI/7CUYlVJ6pl5bTRMYsxuCUvHFO
X-Gm-Gg: ASbGncszCvdUfAStMBxsp3/4HUKZzx/fhiPaaMTZDYrl9pzsI6oG4hD+EJR6wPwIqcz
	NkONBv7Mbtq10ZaGLBXTqkKarcsTRzaYIKdFLrVwEw0UCPttka323RLJBb9NEn1K5BL9TUHbrhB
	V1HVbMlx3S3bIy96Qpqpv2C219N6qlNEpWhEQ1hvfM0f8piPCGa5boUqlsWfSsrWI3IdHv7xXFu
	ohtFkuEtBKfvUKDlDAVHHJwapXxmxwXuoCPDBBJyZb6wswY4/rKHVJn5lv8w/oE1mpzjmiKOXYi
	Yjo9xszRFkTDi4s3P2+hMFccZEYbvrrf7Y/e3hAQMiPzmveY+u/O5ZzepI106McLZ5RSCOnRQLb
	W59GSKRDEYEVGwdrH6rNoTyj90nHpYbiHsK/PAUrp/Ye3eEI2QKb40MquybRWvPUnwhh4so8tT5
	OEzJmoF98v123Ltw==
X-Google-Smtp-Source: AGHT+IGqJ3fK980blF3S2OhDDl1kPCFC3PDx3uiV6lRR9MlLGgQ+c3xMg89feF4XpI76Z2y7cP/wYQ==
X-Received: by 2002:a05:6a00:23c2:b0:780:f758:4133 with SMTP id d2e1a72fcca58-7a274ba91d9mr12147230b3a.10.1761440722260;
        Sat, 25 Oct 2025 18:05:22 -0700 (PDT)
Received: from daniel.. ([221.218.137.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41404987esm3371597b3a.36.2025.10.25.18.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 18:05:21 -0700 (PDT)
From: jinji zhong <jinji.z.zhong@gmail.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org,
	philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	corbet@lwn.net,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	axboe@kernel.dk,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	akpm@linux-foundation.org,
	terrelln@fb.com,
	dsterba@suse.com
Cc: muchun.song@linux.dev,
	linux-kernel@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	zhongjinji@honor.com,
	liulu.liu@honor.com,
	feng.han@honor.com,
	jinji zhong <jinji.z.zhong@gmail.com>
Subject: [RFC PATCH 0/3] Introduce per-cgroup compression priority
Date: Sun, 26 Oct 2025 01:05:07 +0000
Message-ID: <cover.1761439133.git.jinji.z.zhong@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

On Android, different applications have varying tolerance for
decompression latency. Applications with higher tolerance for
decompression latency are better suited for algorithms like ZSTD,
which provides high compression ratio but slower decompression
speed. Conversely, applications with lower tolerance for
decompression latency can use algorithms like LZ4 or LZO that
offer faster decompression but lower compression ratios. For example,
lightweight applications (with few anonymous pages) or applications
without foreground UI typically have higher tolerance for decompression
latency.

Similarly, in memory allocation slow paths or under high CPU
pressure, using algorithms with faster compression speeds might
be more appropriate.

This patch introduces a per-cgroup compression priority mechanism,
where different compression priorities map to different algorithms.
This allows administrators to select appropriate compression
algorithms on a per-cgroup basis.

Currently, this patch is experimental and we would greatly
appreciate community feedback. I'm uncertain whether obtaining
compression priority via get_cgroup_comp_priority in zram is the
best approach. While this implementation is convenient, it seems
somewhat unusual. Perhaps the next step should be to pass
compression priority through page->private.

jinji zhong (3):
  mm/memcontrol: Introduce per-cgroup compression priority
  zram: Zram supports per-cgroup compression priority
  Doc: Update documentation for per-cgroup compression priority

 Documentation/admin-guide/blockdev/zram.rst | 18 +++--
 Documentation/admin-guide/cgroup-v2.rst     |  7 ++
 drivers/block/zram/zram_drv.c               | 74 ++++++++++++++++++---
 drivers/block/zram/zram_drv.h               |  2 +
 include/linux/memcontrol.h                  | 19 ++++++
 mm/memcontrol.c                             | 31 +++++++++
 6 files changed, 139 insertions(+), 12 deletions(-)

-- 
2.48.1


