Return-Path: <cgroups+bounces-5045-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADFF99311E
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2024 17:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0056E2838A5
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2024 15:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1A81D8E01;
	Mon,  7 Oct 2024 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDiXg/zM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F3C1D8A0B;
	Mon,  7 Oct 2024 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314924; cv=none; b=JEkLowxorRk2QP5VcuXE78VruKe+ktIYYjVvE0cYUHQ3tVVB+QD/WKkATCZ3l1Hf0EuPnu52OgFtFwrx55WYzDNEUEaouFA3n0X5RvDRpPghtIutAGIt5ZIgvTvfZ6ov1WDLdGwny/QSAJwRKFvUZLgrnMdJYAvQ7JjJD5RQt98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314924; c=relaxed/simple;
	bh=s32RlqUFiUV2eI1P7gxdnrpO/8RXfRHl8qzEURv0aw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ViOnkV3AT+Aq+ZCJFgcTiyiuW9/pbv223imiDqCYY+3+8weHrfABM4BqyeO+uejSPCo0vf4fR59te7xyh1v3QPVvQ/pzRLj39OoNbBczSo6X4OkRcBG0LgAy+P4WDun9Fq+8YznsrMXDna95/IzZ2fK/P1crcvIVyZmlVXWwJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDiXg/zM; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e042f4636dso2822017b6e.1;
        Mon, 07 Oct 2024 08:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728314922; x=1728919722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2xdo0VzL8mnN7ANpNT7CAPvUYDoW+NFuxV3r999Crgg=;
        b=eDiXg/zMTBmBvRA3pZu2/MQcTGElyDBbDjmGnwgkW67lLd5b4/QkLKboO6qDQQ8M8W
         Wt0kqsBIjQW7VS+ehwMOpn6pduUDaxECC09SmBmnB9NslRrsQmcQmWjluMKpPlTcWjbW
         z10OWiCPdTiaOSJmPKg5eGQ3v/Bojwd3j1f5yjw+ZvA5QN/wypZx8Lb82vvO8u6Hcn7b
         lowlHD0ZTf3sO7OIoouPRLVcldAYUNX3AWdfPA6Lu/j2LZujiOCcdI5fgITS0RH5FN/v
         yV2V4OCWH8OI5oE1bSac2J9Nbs33zIPti+kiyPEM9JiyIX6EqxzZLnXy+wdpIYWeA13V
         4GZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314922; x=1728919722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xdo0VzL8mnN7ANpNT7CAPvUYDoW+NFuxV3r999Crgg=;
        b=a3jwExSdm/EBRietYqj7hd2ATy3ox1nVhpI1GnhGag19GB+YoJuzgTY6OIA4yrKIpz
         lrhZroCYVoC2Cd7GJHj+p37g8RhFt+QZlL57hZsdbbD3f3naYalNomqZoFCHqqo+pHE/
         1CDw7Cl3InL7kBLQU6yiFW8dbSYKUjwInZT1mKLMO3zajWusUj56RGcND2KgQV0bUBKz
         FLirZyRyVeyEglZT8SabhzLm/p4JLggs4K970Em8UaDM5ejv6V0gzA6HCjXKw1zkkyfx
         o1p2lNYTItd6BAa9dEbBNPxNLMkVwFHtBAoFEu5m9XVXBoAefCZ/HIftF0WT5YfzvE0b
         BwRg==
X-Forwarded-Encrypted: i=1; AJvYcCVqN+hy/M+yGeImQ7Rm5Ev63XZwONle5rehedWXAsZ36CIUy+blPr2mFAE3M3t9KHPxJmHL3HAr@vger.kernel.org, AJvYcCWKua0PmJO5hHmFtz0SDHXjRzb2SPUerwBohh1AOcfWhvz0AvXIm6Z0ZOZxVCa0RC+mRBEGLS99zLMNDKGn@vger.kernel.org
X-Gm-Message-State: AOJu0YwYmEAbfm8sh1BNZzbdPSCRGWN2/xZ78LBJVViqssLzwHXoXIOa
	sknHtx2ABXgSifuctXUYxDmg+wj/pD1JYuEJEuBIA1/AvdjE555P
X-Google-Smtp-Source: AGHT+IGQ4EnLEAoChykGL4XZmx1nS+43oFppiGRl9DslLgkiE8HIueUgdTaJM0TymGQJ7KprMTgMIQ==
X-Received: by 2002:a05:6808:10cf:b0:3e0:44ad:1d00 with SMTP id 5614622812f47-3e3c132ae59mr7817532b6e.18.1728314921927;
        Mon, 07 Oct 2024 08:28:41 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4adeasm4360337a12.84.2024.10.07.08.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:28:41 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: xavier_qy@163.com,
	longman@redhat.com,
	lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 0/6] Enhance union-find with KUnit tests and optimization improvements
Date: Mon,  7 Oct 2024 23:28:27 +0800
Message-Id: <20241007152833.2282199-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds KUnit tests for the union-find implementation
and optimizes the path compression in the uf_find() function to achieve
a lower tree height and improved efficiency. Additionally, it modifies
uf_union() to return a boolean value indicating whether a merge
occurred, enhancing the process of calculating the number of groups in
the cgroup cpuset.

Regards,
Kuan-Wei

---

Changes in v2:
- Modify uf_find() to compare with root instead of node in the while loop
- s/Union-Find/union-find/
- Add myself to MAINTAINERS

v1: https://lore.kernel.org/lkml/20241005214938.2147393-1-visitorckw@gmail.com/

Kuan-Wei Chiu (6):
  lib/union_find: Add EXPORT_SYMBOL() for uf_find() and uf_union()
  lib/union_find: Change uf_union() return type to bool
  lib: Add KUnit tests for union-find implementation
  lib/union_find: Optimize uf_find() with enhanced path compression
  cgroup/cpuset: Optimize domain counting using updated uf_union()
  MAINTAINERS: Add Kuan-Wei as co-maintainer for union-find

 MAINTAINERS                |  2 ++
 include/linux/union_find.h |  2 +-
 kernel/cgroup/cpuset.c     | 10 ++----
 lib/Kconfig.debug          | 12 +++++++
 lib/Makefile               |  1 +
 lib/union_find.c           | 22 +++++++++---
 lib/union_find_kunit.c     | 74 ++++++++++++++++++++++++++++++++++++++
 7 files changed, 110 insertions(+), 13 deletions(-)
 create mode 100644 lib/union_find_kunit.c

-- 
2.34.1


