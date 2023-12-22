Return-Path: <cgroups+bounces-1000-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E3881C926
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 12:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6372A285A37
	for <lists+cgroups@lfdr.de>; Fri, 22 Dec 2023 11:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3AA17985;
	Fri, 22 Dec 2023 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzwOf5hI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77E171A3;
	Fri, 22 Dec 2023 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c699b44dddso808808a12.1;
        Fri, 22 Dec 2023 03:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703244687; x=1703849487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnm5yO1z5BFnI6R9o5kpMT7t7bvrBhTAmcH7fCWCN04=;
        b=AzwOf5hI4HSExYlvhqLuW2pntGg1dqDj2L52WH5WKwKwzgKEU7YzI9VT7CaZAdXHP4
         A1J16bYFwRYbLFyPHWYWQi76azYStou8FVeHWB9r09LdriLmqh46EA3jCq//mmk7j0V9
         AcNXb5jQqDaZhMmTxcZUCJu6TegsFZSUEyw1B/ajyiNtYYN9LaoWhVI0k0QTyJQfyFrr
         Ncfo3cVwUCNhp8JYT8uG+S4ddo0PymtasG0DObQqU1a15aLO7atVTE1uoBvOhGmI2hB2
         ky1ULWtX0MfWyeg6HIGwOc+ITkxNbR6JQXaFWcojPuUyqpj55+UQVWyNKQAlEX1yPlkQ
         03jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703244687; x=1703849487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnm5yO1z5BFnI6R9o5kpMT7t7bvrBhTAmcH7fCWCN04=;
        b=xC+rhqxdnroOHwi/w4jtEH4W6xor4NP30Da0RsGHIcyopLd1ga3TR3FQiYof3cOjsp
         6Bc1Fy8gS3Swq/W3AbRbWblWPMhcfgyzKv6YmOLW3R0ufC9Gbj06YSe9vlcvrbz08OmO
         3be+20Nhp0sCG4yCpHU3GtFD9IfPAcvczpQDSqdOJfbV66Ol0W4gBiegdXE9YIWgwpkm
         T+Wc4qcfoPKkoNLsCI8e2z4kqTy1q7mJeLUtASfzqKENikmq7OfL2voRd73X/wRnBHhf
         FVVL1J4EVDPVt3cjK9F/f7bV3y7d8Mu9eoiEPE7G2BBkNfZO/5oqgGsgiSVs9C5tI4T7
         eSdw==
X-Gm-Message-State: AOJu0Yx/4SGpdIAGNoj+j6Sr7bJRYwzSL52MCRXa5yUjdxXyUHNaZ4Ly
	8uVypEC7kYUvHR6IbLxGHdM=
X-Google-Smtp-Source: AGHT+IGBBNtA07ePkC0CQpoITX9jwIPm0BU2ImDLQyO55XkGMjW3zDphySIWhtGjxOTlRfV1Q0E15A==
X-Received: by 2002:a05:6a21:3284:b0:18f:97c:4f49 with SMTP id yt4-20020a056a21328400b0018f097c4f49mr785664pzb.85.1703244686861;
        Fri, 22 Dec 2023 03:31:26 -0800 (PST)
Received: from vultr.guest ([149.28.194.201])
        by smtp.gmail.com with ESMTPSA id l2-20020a170903244200b001d0cd9e4248sm3232881pls.196.2023.12.22.03.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:31:26 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org
Cc: bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 1/4] cgroup, psi: Init PSI of root cgroup to psi_system
Date: Fri, 22 Dec 2023 11:30:59 +0000
Message-Id: <20231222113102.4148-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231222113102.4148-1-laoar.shao@gmail.com>
References: <20231222113102.4148-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By initializing the root cgroup's psi field to psi_system, we can
consistently obtain the psi information for all cgroups from the struct
cgroup.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/psi.h    | 2 +-
 kernel/cgroup/cgroup.c | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index e074587..8f2db51 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -34,7 +34,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
 #ifdef CONFIG_CGROUPS
 static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
 {
-	return cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
+	return cgrp->psi;
 }
 
 int psi_cgroup_alloc(struct cgroup *cgrp);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8f3cef1..07c7747 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -164,7 +164,10 @@ struct cgroup_subsys *cgroup_subsys[] = {
 static DEFINE_PER_CPU(struct cgroup_rstat_cpu, cgrp_dfl_root_rstat_cpu);
 
 /* the default hierarchy */
-struct cgroup_root cgrp_dfl_root = { .cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu };
+struct cgroup_root cgrp_dfl_root = {
+	.cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu,
+	.cgrp.psi = &psi_system,
+};
 EXPORT_SYMBOL_GPL(cgrp_dfl_root);
 
 /*
-- 
1.8.3.1


