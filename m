Return-Path: <cgroups+bounces-8204-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA90AB7A7F
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 02:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1621BA523A
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 00:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F173B1AB;
	Thu, 15 May 2025 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWOxDFI5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EFF8F66
	for <cgroups@vger.kernel.org>; Thu, 15 May 2025 00:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747268398; cv=none; b=PwPMFl7PgDb9/CArzDYzn9Rq9EDxnw/DHYiRQ424G3r7Jyj8RKIPbuB+i2r+B6uVUQRsRIwqXXXIayDQCQJpVzlacAPZmm0/RU6+37bUT0zy+9/tMROarVxqpo+lpAzfzh4+tTeXu5kVkm3D3Qzlgh1DHMp0oAyA8wcqCj/F2pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747268398; c=relaxed/simple;
	bh=LkZIpsK3Mi1bphXnDp0o91N0kMilUYXqN8hR7NoMO1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxuztjNOPKvlZFHM849jY3Y6ZhI4utLE68wpzTD/wQVJRbXbonrfMZn+u21qGopVxspToR8Yp1OowLsbw+2DCyvspOSRTQ6vgV+ko5vzWQ/wvBFPOO/BYpZ6OPR5L1S+cK/byizUmYmG/6r2BizjBB8/Pe64mKd0e8ZICXICW7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWOxDFI5; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b268e4bfd0dso258959a12.2
        for <cgroups@vger.kernel.org>; Wed, 14 May 2025 17:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747268396; x=1747873196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WN3i0opWFFgoPhDlqtGA7gSsvOJi1iyTpU2ngkR9euI=;
        b=IWOxDFI5J+b4oOAgBlXxgMjcVYrtdW7vLcqX5ipn3LFUfi/OiDleWnesYvq7j5wWu2
         z3CA+opDMY2Fh5nykO0uHgLS6A4NUS4IUAWu8FTzmB3bytYOS9+KAIw3JyGuzGNGoKD+
         rMCl0IFtU1Gzpdy0Ow/QrX22fIDNv4WcbT9M5fsrbg/F6vuqYh/ETX/UvXg+kc2ni7y/
         CQXuisUWyDEfMCTpSstNlytM5pRMpCfgtbrTelbIyh1ypp6nFU53WVKl2muzMNBYbLbJ
         VwYeLPTeQIX3CbWwIgcvGTLiQbEcjR9BQ2K94MIiE+ZQlbHxr/XQx61gOj1s6F5P385t
         EH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747268396; x=1747873196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WN3i0opWFFgoPhDlqtGA7gSsvOJi1iyTpU2ngkR9euI=;
        b=k2rSYHssXGcoQkQ0IRry8Mt39+18tcZOF+jtjH31ttiM6cBvEew/D3VEnpNMYym3qn
         SF+PQxZZ0K3rTIlzuI+1S0bOJoUbaF9Y4eeR4zUwljWthtB7Ac/T+hnsbB3AsGcLN1pr
         1KQw7LCHM+R68X9FNG1OvqkalcJWz2zKdESFAlmJgZa65zVIStD0Pmv1ZU6nXGiQAHYp
         jb04SJVV/dD9HMSedfDmBkBVwqeTL/Y+SKe6EUHWJYMN8KVRB94BVuZX8ZeN1ZvQDvuD
         g8B8T/t3w9PNfDSuHlUg6ETpdZ5twacBLWpHZWctDF4e0v1LVmAvWFAKJrJSJsfqS3jw
         7DMg==
X-Forwarded-Encrypted: i=1; AJvYcCWWou064jyzGXQg1g4Cxcw9eP188VqIOPzH1WbEAKx+sf/MUhJ57GS0d0VZ+jBx7//cZ6Q3rvCI@vger.kernel.org
X-Gm-Message-State: AOJu0YznZKdbqt0A60vejXt0QSegy3luTx5EhZjFh2+5LkVn4d+3H0Lp
	GwEMD+odpgHxsPuqnokSmR8p5DRI5gmzEv0o9voDCtmRSjUxJXD7
X-Gm-Gg: ASbGncsQZTxluj5isjIdwDZHgEHiRitrYfEj0gzHEhZFeMgZtWRFQLD1vt+qSxtLbl6
	jPcapW4mOWtoNLuM2LY+YSDnO6r650mJVlXiOtFuvEISqQhhIcDFQFtHGw6i7kzdXTEHUw5bGe6
	B7C6PtrGkMWWuctuKaZbyrNkXej4zfvN4qNS82d8ycuVajzGTMDrPn4Zro6dfbPJp/Ur4OlX/fr
	amyJxhOtRRMbPIywjLIP+cLik/wuQ5EqVszeWj0hwdrIupGdZb7cShy9r9tfSbvDi81LtA1jvuR
	t18vk/FxNFinkeAJePrj7CySAKg6gTahgsIZUpW/KayKapaVpUn3nlgjH6TBPa3dNgrECpp4SDK
	vKgkyH2YhuF1zjaOQe80r96OHYJgy8u4AbUS7Xwc=
X-Google-Smtp-Source: AGHT+IHcsGPXI2IJK0DMoByt6I2lVstaLtvv88DSzENHeqwH7ic2GIrYMhvqXJPcaik8ofyHSACSlQ==
X-Received: by 2002:a17:903:2448:b0:224:24d5:f20a with SMTP id d9443c01a7336-231982c6ecdmr84291555ad.48.1747268396344;
        Wed, 14 May 2025 17:19:56 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc754785bsm105939545ad.20.2025.05.14.17.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 17:19:55 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	yosryahmed@google.com,
	mkoutny@suse.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v6 6/6] cgroup: document the rstat per-cpu initialization
Date: Wed, 14 May 2025 17:19:37 -0700
Message-ID: <20250515001937.219505-7-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515001937.219505-1-inwardvessel@gmail.com>
References: <20250515001937.219505-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The calls to css_rstat_init() occur at different places depending on the
context. Document the conditions that determine which point of
initialization is used.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/cgroup-defs.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 5b8127d29dc5..e61687d5e496 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -169,6 +169,21 @@ struct cgroup_subsys_state {
 	/* reference count - access via css_[try]get() and css_put() */
 	struct percpu_ref refcnt;
 
+	/*
+	 * Depending on the context, this field is initialized
+	 * via css_rstat_init() at different places:
+	 *
+	 * when css is associated with cgroup::self
+	 *   when css->cgroup is the root cgroup
+	 *     performed in cgroup_init()
+	 *   when css->cgroup is not the root cgroup
+	 *     performed in cgroup_create()
+	 * when css is associated with a subsystem
+	 *   when css->cgroup is the root cgroup
+	 *     performed in cgroup_init_subsys() in the non-early path
+	 *   when css->cgroup is not the root cgroup
+	 *     performed in css_create()
+	 */
 	struct css_rstat_cpu __percpu *rstat_cpu;
 
 	/*
@@ -530,6 +545,15 @@ struct cgroup {
 	struct cgroup *dom_cgrp;
 	struct cgroup *old_dom_cgrp;		/* used while enabling threaded */
 
+	/*
+	 * Depending on the context, this field is initialized via
+	 * css_rstat_init() at different places:
+	 *
+	 * when cgroup is the root cgroup
+	 *   performed in cgroup_setup_root()
+	 * otherwise
+	 *   performed in cgroup_create()
+	 */
 	struct cgroup_rstat_base_cpu __percpu *rstat_base_cpu;
 
 	/*
-- 
2.47.1


