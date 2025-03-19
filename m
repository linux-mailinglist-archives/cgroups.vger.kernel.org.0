Return-Path: <cgroups+bounces-7142-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DD7A68537
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 07:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67EDA42442F
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 06:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6E724EAAB;
	Wed, 19 Mar 2025 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoJ8X2Gn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02323212D96;
	Wed, 19 Mar 2025 06:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742366538; cv=none; b=YI2dGBecnwCcBGIiFQqXIbZpZarfc8HSCfxQuna3wXPsG5eXSIWgav4vWqCDDANZHWLY8s/sePf/c073an1X0/c6iIPW5ZWfHG6YFf/1zMghNo628dspolUtG6N8cIczUfNZmhhlZ7wqMQr22HUyWMmtEKfjicVIdwzovmQYcSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742366538; c=relaxed/simple;
	bh=C48LCA0HEiMUWJYeligQIASJjtm3iqfLDOJl4K5/1pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzYNf7ck16yyKdUjYB4xYM5XQhVBSjtRscJdhfDZCOsTyQZcIo3XocCd+0EfZ2gclie7kqGhcsSed2BRZwXkoA3Kfqeej+ScOSMSlrnWDOYPYee94/GUi/VpTaBHtRskbI4flSsl+2nvIZ9eeUF/G8yeFIEte0QuK4pH1yZZ6Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoJ8X2Gn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2264aefc45dso8639015ad.0;
        Tue, 18 Mar 2025 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742366535; x=1742971335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pXItn2D3Vis84qRdx9jbeX/+b7biQMSa8SO4XBFLs9U=;
        b=JoJ8X2Gntk8TiTte2/3NB/NbxO9awYYqc6SQ3Y947U8Ayz8mx+Vm4XY002oFli3VHH
         kXw6y67/xs7ZMYy3s57eux4UGWLMPf6U3u5lqR9JTkkrSMk22A0GdZGSvQHOzjKftScg
         K6FzrJPimo3Yfb5lrH2MAVs5GrKMaj3YJsdsibeNJX0t2xGZH9/au1Hyt2kyb3CUHz/j
         ehmwVMHS9OTIK83ol62kYb8oNjw91H/wh9xWLG67lVPhzHPseX+sZjtMY5VsagfpXJ7H
         2rnVPO0/ncre1fEfjaVHCxONtj9+JY9kMZmogg901f9EnlpX3O/Ju3712LsPbNtOALs+
         JYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742366535; x=1742971335;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pXItn2D3Vis84qRdx9jbeX/+b7biQMSa8SO4XBFLs9U=;
        b=uJPpUvKr5vBwexpjdEngoJ/VpTRi9e0fE6WwoyeSVgIHLVioKpSBvKNqPlTTnVmDNS
         Lr+uPatew23n0pjrYDb0+jIfFaOhlKhnkm03TfWzxd3xJWxOXlt5d3pnktFyMAuR5PIq
         XyrU5+VEhOmVsE8jv5YX6c9JEx9OrGHg2bBgwL4xd7mwucjCdSQyTJ9djkDkySJqRcPl
         Akbs5lp3FcBo3Lb7vqVIdu4C+dmcZv1spMqXcX5y6LeLghlOx+R8XEcVfG/ridB24IE8
         eeirtSGYDMJFd9rLzNKFyBHIEdsq/LjMo5xC/0uQTfVZOdWpdMygJHgRopZksFpetR0c
         s2mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSlZPAeS3zeD3pWpVepyUCGdF/FHxjACcQpOX2zOyK/0kdX6mC0gklsoEBOP/KCiS0iLZTlL/ajPH2i/Zw@vger.kernel.org, AJvYcCXQNVFwbBR3zpMU+k8LCLIhg7Ezkyt8L3U3cvdDCwZd5ODLBlUiF0PB77bR4O3JGi3Ph48wp86x@vger.kernel.org
X-Gm-Message-State: AOJu0YzRa/aeVIk182G1G3sJ8okhkSEIEVqul/MKMVITYarY1stvqULH
	EgE8YlqbF6q3Tq4by1SoHPrrWCburlizmc9UPRbYt0O1kcOqQbz1
X-Gm-Gg: ASbGnctmFk8ByBC4TfS6fLGxPYqNSUPKgIosgfWmCPmDhthod1BTlSsIq82iMCMW26K
	MJOmtjS5T9MJU1w0ptCUUC4sgVLO2iw/FyZVYs+rrp8D4Wz7qWIZDyTSo8SKAnSBC5Emuj84WUG
	CdAHwJSKHb3kI+LXsLXPkrkdusHv2k/wHOLGfqx3dDbJ8boG/58nGCnW+e/0ndd95osEwpVxpsz
	mp7BOZmFAFwoZCcsYC4Sjrdzx6AC0aHotaf9fXr/jrRaZrlknAQFWIrCNLgdicA51t43jaj9vvp
	sq8CoIOa3KqHE/YJRHWpAMcfREPw4AQB5bfI5h3bzFrRPsDMBeeXDwgqN1IovOQiYI4BX8yHZLy
	4i3ftcGDlAclFOQ==
X-Google-Smtp-Source: AGHT+IHAiybYnuUAbS1337n8MIKxXlM5d3eEixwdqICuE8kaYDo9G1K0ymmFrvbR4m08KEEHu5+UJA==
X-Received: by 2002:a17:902:ce0f:b0:224:584:6f05 with SMTP id d9443c01a7336-22649c89560mr28245025ad.41.1742366535093;
        Tue, 18 Mar 2025 23:42:15 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm106191835ad.70.2025.03.18.23.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 23:42:14 -0700 (PDT)
From: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	kasong@tencent.com,
	Zeng Jingxiang <linuszeng@tencent.com>
Subject: [RFC 1/5] Kconfig: add SWAP_CHARGE_V1_MODE config
Date: Wed, 19 Mar 2025 14:41:44 +0800
Message-ID: <20250319064148.774406-2-jingxiangzeng.cas@gmail.com>
X-Mailer: git-send-email 2.41.1
In-Reply-To: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
Reply-To: Jingxiang Zeng <linuszeng@tencent.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zeng Jingxiang <linuszeng@tencent.com>

Added SWAP_CHARGE_V1_MODE config, which is disabled by default.
When enabled in cgroupv2 mode, the memory accounting method of
swap will be restored to cgroupv1 mode.

Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
---
 include/linux/memcontrol.h |  6 ++++++
 init/Kconfig               | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 53364526d877..dcb087ee6e8d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -62,6 +62,12 @@ struct mem_cgroup_reclaim_cookie {
 
 #ifdef CONFIG_MEMCG
 
+/* Whether enable memory+swap account in cgroupv2 */
+static inline bool do_memsw_account_on_dfl(void)
+{
+	return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL);
+}
+
 #define MEM_CGROUP_ID_SHIFT	16
 
 struct mem_cgroup_id {
diff --git a/init/Kconfig b/init/Kconfig
index 7f67d8942a09..669e39214244 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1012,6 +1012,22 @@ config MEMCG_V1
 
 	  Say N if unsure.
 
+config MEMSW_ACCOUNT_ON_DFL
+	bool "Whether enable memory+swap account in cgroup v2"
+	depends on MEMCG && MEMCG_V1
+	default n
+	help
+	  Say Y here to enable memory+swap account in cgroup v2. Enabling this
+	  option means that the semantics of memory.swap.max will align with
+	  memory.memsw.limit_in_bytes, and memory.swap.current will align with
+	  memory.memsw.usage_in_bytes.
+	  This is particularly useful for workloads that require strict memory
+	  and swap limits.
+
+	  If you are unsure whether to enable this option, it is recommended
+	  to leave it disabled (N) unless you specifically need memory and swap
+	  accounting features in your cgroup v2 setup.
+
 config BLK_CGROUP
 	bool "IO controller"
 	depends on BLOCK
-- 
2.41.1


