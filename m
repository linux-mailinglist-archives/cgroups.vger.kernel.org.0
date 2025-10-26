Return-Path: <cgroups+bounces-11182-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B154C0A18C
	for <lists+cgroups@lfdr.de>; Sun, 26 Oct 2025 02:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A236B4E6BFB
	for <lists+cgroups@lfdr.de>; Sun, 26 Oct 2025 01:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3AA248F62;
	Sun, 26 Oct 2025 01:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUeGjq8g"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5BC190685
	for <cgroups@vger.kernel.org>; Sun, 26 Oct 2025 01:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761440749; cv=none; b=n2Ap/b9JWy7cVEIiUabNN4VHsiD+QToJSqz6R2kkUk7WPxGqOtvY3sNOrCicbcbH1t7WIrWD/RdAm/XV8hYnsagKxgqnTtbtzhRHRbF6+rBkxIUkeLTGPTyUwYgguvGYOqUsDw9jy5Wh1+H5wWkE5pXjsMOU+6FYe0vV76T5zfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761440749; c=relaxed/simple;
	bh=NNAlX4cVcjwFtkIEFZH5noazzP942ARBnfSced7dLSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpRf7eakKyyIlXRa/CrAp3n/ep78BpfAVAI2uIcgZXwPNPy+O/x2IqHpTbMkORy4U6EWQmf9X3UlRBzmpDjFAtubrfGmuFHVTbg27g3sB4t46NK87VFbtpNQwxxw2rn0xonNnx/NV4/ZJAO35WJWmsitTrcCQ8URbjOz20WZzDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUeGjq8g; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a1603a098eso1998284b3a.1
        for <cgroups@vger.kernel.org>; Sat, 25 Oct 2025 18:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761440747; x=1762045547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrWku1aIMMMg9GTv7ArefROi2Vd01OtJJzpQozkukKo=;
        b=SUeGjq8g+CsSNP1eKVz04juO8Ib8oE5BaiRLP6zgD9QaoBerJFrTDPmegsFU1qwCqx
         rI+EUclGEVhc4XZN1iZdbRdbWaXra3SFWtdnS2L8sek5ayh018lkXCFnuT+2W3qELn7J
         gy2L1B6icQ9ikse6sa5qj7zflKhbgSEtulWqhDVEt3VSC/DSYsf7R9icZvPdiq7xplEG
         gcCMy+w3Flw7N1v75J8xq/AaFpsohG+1SgpEINH1rw86lt4oWWLq2Zqd/o71B6nzpD5A
         9JopMf4GgNZ2nyX0W/jQXY5nEl3mBvmKlPOR5cKPYabcxYhdlbgA50fZwXAkYgL2nFc6
         nZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761440747; x=1762045547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrWku1aIMMMg9GTv7ArefROi2Vd01OtJJzpQozkukKo=;
        b=tVpj82smj1OFJY2BWRBjfc+2we8meWShkHs67BQ3HTLfPoNB1ip6Ho2FMkUshETp21
         C0cbsuCcbag1A4Q73JIhDJgQJAKpbn7LD+sFru+THyjZNfNe8B67SmUSsHAZTWAMcUk1
         w6inMfWcg/1zaAXblaeLn98HwhWKvz78xuIvBFhqJTBliDMmJ5AuwdMie5AoG79ooLF+
         3mgssX3QZ0LOUtjPqaDUf4TIS6MuH7vIPqj3DL2FDqr27/ukqy5Ke2a6A6tNiWDL/g1O
         Hb+KUEcD1Nc+AWFzU2HwXHVS2a3Q0BOULYbuxsX7IESBIOwfboSfWaD0+jPq+shTnnRi
         gGzg==
X-Forwarded-Encrypted: i=1; AJvYcCVtWFQmXYeoy36tPqZIFzofl4tfM/D+RVshLQToAJQyj3iudByqF66omW0s+E6/VaAxunS8piVD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjtz28s7R8ZO0JtQ4jEaMtp0wrr5mcIHZYBwt14L3MuCwQHoMX
	jsNU/be9e4UFBpYs38QRC3GbytfO5hFkwrUUq/WV2No4f+MOJn9Dww3q
X-Gm-Gg: ASbGncubJhYf6Xm38FM7fFTjFrF4gP7EjPXabh5g7tk9+24aJMkC7ynnsBNYnRYzc8k
	GMqOko/sGCkF7G5k1ZYjSXoKqAWkUoe4zyioJ4Dq76Vtzalk3MZus1MO+gCb2k4plZK850g/Hmq
	Cef15nwTTqO1eZ2NwqRNZoEgZ1rBSz52AQZjGLQzWcsP5X4mAUFLsMbmqEWKowImwkDcpWCPD7c
	Mv4ZyKTnqooxWpS/DT5UOtML2YS5hadLpzFumHEvZYB0uEjnjqAOGOIfWbzxhXA/SDPthOteg1U
	bG06Ebvy6UNtoZdU3IXy/Pfj9zUn+pUtqAOqhVxCaAa5Uhu47kAsvboCHXeV/oDVPVUVkH7cvuo
	Xli6L4lYGWwIv2Y7xrRvaSJ0fF73gn5rPGDrfBz7wrGjS0zVvdopnNtQdExujT1+eLahmWdcMMu
	N2U+E=
X-Google-Smtp-Source: AGHT+IEfMl6RnbpkDRz3xPKw02ZxvVMy5U+m1L9klxFtFN/jBXClYLwUkIitj9v1zCClkhcSl7XzQA==
X-Received: by 2002:a05:6a00:a15:b0:7a2:7893:b17a with SMTP id d2e1a72fcca58-7a27893b21dmr11885518b3a.6.1761440747382;
        Sat, 25 Oct 2025 18:05:47 -0700 (PDT)
Received: from daniel.. ([221.218.137.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41404987esm3371597b3a.36.2025.10.25.18.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 18:05:47 -0700 (PDT)
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
Subject: [RFC PATCH 3/3] Doc: Update documentation for per-cgroup compression priority
Date: Sun, 26 Oct 2025 01:05:10 +0000
Message-ID: <25cab6bc87a6cd69983e2fa0908441bc37015c98.1761439133.git.jinji.z.zhong@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1761439133.git.jinji.z.zhong@gmail.com>
References: <cover.1761439133.git.jinji.z.zhong@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch updates the documentation, describing the newly
introduced per-cgroup compression priority mechanism.
---
 Documentation/admin-guide/blockdev/zram.rst | 18 ++++++++++++++----
 Documentation/admin-guide/cgroup-v2.rst     |  7 +++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 3e273c1bb749..de4ab060f664 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -452,12 +452,12 @@ using more effective algorithm and, hence, reduce zsmalloc memory usage.
 With CONFIG_ZRAM_MULTI_COMP, zram supports up to 4 compression algorithms:
 one primary and up to 3 secondary ones. Primary zram compressor is explained
 in "3) Select compression algorithm", secondary algorithms are configured
-using recomp_algorithm device attribute.
+using multi_comp_algorithm device attribute.
 
 Example:::
 
 	#show supported recompression algorithms
-	cat /sys/block/zramX/recomp_algorithm
+	cat /sys/block/zramX/multi_comp_algorithm
 	#1: lzo lzo-rle lz4 lz4hc [zstd]
 	#2: lzo lzo-rle lz4 [lz4hc] zstd
 
@@ -468,10 +468,10 @@ Alternative compression algorithm's priority is provided during algorithms
 configuration:::
 
 	#select zstd recompression algorithm, priority 1
-	echo "algo=zstd priority=1" > /sys/block/zramX/recomp_algorithm
+	echo "algo=zstd priority=1" > /sys/block/zramX/multi_comp_algorithm
 
 	#select deflate recompression algorithm, priority 2
-	echo "algo=deflate priority=2" > /sys/block/zramX/recomp_algorithm
+	echo "algo=deflate priority=2" > /sys/block/zramX/multi_comp_algorithm
 
 Another device attribute that CONFIG_ZRAM_MULTI_COMP enables is recompress,
 which controls recompression.
@@ -524,6 +524,16 @@ This can be achieved by providing a `algo` or `priority` parameter:::
 	#use zstd algorithm only (if zstd was registered under priority 1)
 	echo "type=huge priority=1" > /sys/block/zramX/recompress
 
+per-cgroup compression algorithms
+-------------
+With CONFIG_ZRAM_MULTI_COMP, zram can compress pages using the compression
+algorithm determined by the cgroup. It will get the compression priority from
+the cgroup and use the corresponding compression algorithm to compress the page.
+
+To use the feature, admin should enable per-cgroup compression via::
+
+	echo 1 > /sys/block/zramX/per_cgroup_comp_enable
+
 memory tracking
 ===============
 
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 0e6c67ac585a..1706d8f0d225 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1871,6 +1871,13 @@ The following nested keys are defined.
 	higher than the limit for an extended period of time.  This
 	reduces the impact on the workload and memory management.
 
+  memory.swap.compress_priority
+	A read-write single value file which exists on non-root
+	cgroups.  The default is "0".
+
+	swap compress priority for the cgroup. Different compression
+	priorities mean different compression algorithms.
+
   memory.zswap.current
 	A read-only single value file which exists on non-root
 	cgroups.
-- 
2.48.1


