Return-Path: <cgroups+bounces-5101-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA64799A60B
	for <lists+cgroups@lfdr.de>; Fri, 11 Oct 2024 16:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1413DB24136
	for <lists+cgroups@lfdr.de>; Fri, 11 Oct 2024 14:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5495F2194B0;
	Fri, 11 Oct 2024 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6Sz/ZOc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4778218D68;
	Fri, 11 Oct 2024 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655998; cv=none; b=FFD6eo+J1t89ASUOyrYMlVOi9EtnraLkP57PLkOSjHBYLgk4DIy07dcFOWZ3Wj+C/1f11iQh7H72F4OxaP5dPwemADGYa4Y4UG+Gw+6mbYKNR03FbkuVBuGGPmltiiDKryw6NFMSTJP/g9MaTJHqZ0J1Z44QSfWL0/ORvlYbrsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655998; c=relaxed/simple;
	bh=X4mWEXm/zoqmUR8oF9s0iov+PQUtjSyzuCIByL8Fo9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KM9ifOVxqzM8c13jVB4cb821TZVSi5vIiMwnM5kpmn3VmGzaIvpG+iyKdH970vtPAmpvw/8DzujkJGOvi1xX6Ue1km02egVy/rfMwntfBsVIkvA77QIgi/QkZmJy0IHCeLssFjdZFy9V60mufKL6mFbedV+KYY6ulont1W7H56c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6Sz/ZOc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cb7088cbcso1028525ad.0;
        Fri, 11 Oct 2024 07:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728655996; x=1729260796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66FsMpDzY3n1TA5RKpEPrNYnS6vtTzzjE/gMIB5gRHk=;
        b=a6Sz/ZOcUaU40duDmQ4fNCaHFcchQyb+m4gU8Ax/7RAM8/qwkIXp/ZZh39vUEq/Hvl
         YD+lwrNFAESXRPTSEs01GuOscaqNmA/wLhvSuvPE1iLMG9GKtg/KyxVR/iVF/Arjh11I
         E6sEkv3/iojP2bLYxyox0jFwZdqCTsYBI6hRqNvs4oqyom28BoLSv99tlqcPBhlc8b5t
         wLDM0maUVonuvJkbNTC50NTxRC/oVMvPLsAIoncgYCs5jgDmkf/s0i5beRce1/Cub4Y2
         zbGcQRuLXjFAeiLjE7Zv6emWxV1Ai24Sp+jXI5VilJplKvjXj8mpTNRKGATrYbOwU2II
         2gAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728655996; x=1729260796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66FsMpDzY3n1TA5RKpEPrNYnS6vtTzzjE/gMIB5gRHk=;
        b=u8B4aH3WrxqQosWAnWgmQsW+3wI/kd2GAKLoqEWX93m4D0zulFIBXveVq2lXAXByvX
         S/hVHvVTI1EWDxKC12+2IXk9kr/ildxJP3+nJL0SJWPsDKK/1Mqz00CcNIOwx/t/ahwp
         ewgmX1XY6xMzYg2LlXwjsI/kjvYdaTs/8W20JNqcgeNLLLvvDr/JtOWFjWmltZW6yZg5
         ue4xc7OzBYj46UFCJnh8G3cszpjqgfSyuvAlO9bcEFep8VxRacOS7WNYvYNa+FlP0nmS
         LNIFbpceoeP1SCXdNoYghIwibV/BfXWcLarOiHwqBxCJarJT0mGxDeBX++bVorc69+W1
         xcRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG5ryZyX/2FaEaxtYdBhcyrkMyFCSbe7sx1UIMi5dcx0kypPg96Re/5yyVr8l9xYZT639fxKrG@vger.kernel.org, AJvYcCXXXhW6vdPhqipsBQE5/wNmcd9liH5PdLJ/4hTtffuUpo+n//XgUfbrCLv6/STWVr8MxuQRK50YNTMDZaRl@vger.kernel.org
X-Gm-Message-State: AOJu0YzdBefRCn1TiOIcIBAAnC2IlLkGlwrIzCwCbiNnWhlXRGG3LbF1
	uQvMZlap5aba/1i4Rubi1RRb1gi2djib4muvv3g7XGzjXUJF6QZD
X-Google-Smtp-Source: AGHT+IEWJBDMF7u+zS5p7kW4kY+0yCMo5fNez2Po0ZijRJr28hM28jSK5+GUx75Vj1mw9slGmU3YsQ==
X-Received: by 2002:a17:902:d588:b0:20c:7898:a8f5 with SMTP id d9443c01a7336-20ca148bea0mr38351505ad.28.1728655996028;
        Fri, 11 Oct 2024 07:13:16 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc0546csm23757525ad.79.2024.10.11.07.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:13:15 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	hch@infradead.org
Cc: llong@redhat.com,
	xavier_qy@163.com,
	lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] lib/Makefile: Make union-find compilation conditional on CONFIG_CPUSETS
Date: Fri, 11 Oct 2024 22:12:14 +0800
Message-Id: <20241011141214.87096-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZweggYOQtt5OUgHJ@infradead.org>
References: <ZweggYOQtt5OUgHJ@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, cpuset is the only user of the union-find implementation.
Compiling union-find in all configurations unnecessarily increases the
code size when building the kernel without cgroup support. Modify the
build system to compile union-find only when CONFIG_CPUSETS is enabled.

Link: https://lore.kernel.org/lkml/1ccd6411-5002-4574-bb8e-3e64bba6a757@redhat.com/
Suggested-by: Waiman Long <llong@redhat.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 init/Kconfig | 1 +
 lib/Kconfig  | 3 +++
 lib/Makefile | 3 ++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 530a382ee0fe..323206ff5848 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1153,6 +1153,7 @@ config CGROUP_HUGETLB
 config CPUSETS
 	bool "Cpuset controller"
 	depends on SMP
+	select UNION_FIND
 	help
 	  This option will let you create and manage CPUSETs which
 	  allow dynamically partitioning a system into sets of CPUs and
diff --git a/lib/Kconfig b/lib/Kconfig
index b38849af6f13..cf303bd91dda 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -777,3 +777,6 @@ config POLYNOMIAL
 
 config FIRMWARE_TABLE
 	bool
+
+config UNION_FIND
+	bool
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41..03b88b501b49 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -35,8 +35,9 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o win_minmax.o memcat_p.o \
-	 buildid.o objpool.o union_find.o
+	 buildid.o objpool.o
 
+lib-$(CONFIG_UNION_FIND) += union_find.o
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_SMP) += cpumask.o
 
-- 
2.34.1


