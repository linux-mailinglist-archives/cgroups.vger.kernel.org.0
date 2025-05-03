Return-Path: <cgroups+bounces-8001-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 599BAAA7DB0
	for <lists+cgroups@lfdr.de>; Sat,  3 May 2025 02:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FC71B6661A
	for <lists+cgroups@lfdr.de>; Sat,  3 May 2025 00:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A1223CB;
	Sat,  3 May 2025 00:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUdxEadp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0405A3FF1
	for <cgroups@vger.kernel.org>; Sat,  3 May 2025 00:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746231164; cv=none; b=eDiBgPN62EeOciduSKoHPG34tf/rrqwIqD696h+DwDECVLXf0tUYP8A/hmMJlUGsP9e1aky8KiKBbPu+XWw7bUVWTgcGmra0tpyB9pfcH5su3ATfbZz+1Ox/Z9+jyTNEAV2gumTs1fR3ftYTgVxXtXkHCZVOMm/XInmzNDP6GMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746231164; c=relaxed/simple;
	bh=VV/NscjtmuUrJOpFCTPQtmeeT1ykIG/pkhizsna+SSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENs3LtsgUgYuwJ2+MHs24YW6nsBBIdQ68//eiQ5N6h7MNwnzibOvGl6cWiVwa2LSkWSlXNcJAsyQ1pH/pZ21SuD/49sOMvyZxvgLfyoMkfFkA1vPEG1UX3/1/y2cEK4cYwF6KSestppINVSk+aaAaPUnEsXMzxSL4EntwVX8URg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUdxEadp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2295d78b433so27659905ad.2
        for <cgroups@vger.kernel.org>; Fri, 02 May 2025 17:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746231162; x=1746835962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtdIGPRfvxxZHX2S0Tgq9S8/vB/STU9UOaAMWnJag9s=;
        b=XUdxEadpN87Gxjcxf9YEqV2zjZDj1/WYMkC3UBxry82/cu43dvWqYxVLyr/gWABn5H
         s9zoylt2uTF25eRESZ7kwj0+5MdjMNgIrmDLSc3DvWGNEm3Zfo6IpEu0jntscIeXxLxk
         blY32j6yhXCVX6xLy/UoF+tP3A20yQKDeGJKLlAx8lZbSsrCDluRX8zR8QlFgBGLAIVh
         YmICDWctM4stfY+gyYAen/nTeXwl67WKZl2MRtD2YbjNrl2VP9v5M/nGtLHVzZmvjYSm
         N++MNnUwY2U44qqfQSzcr36uCIvMCap457JByvbbJxIhbROIBX4zELEh+BgzOttjsbSj
         5Ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746231162; x=1746835962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtdIGPRfvxxZHX2S0Tgq9S8/vB/STU9UOaAMWnJag9s=;
        b=FBz0bwjz4g5yQNwCSEMeFMocwcZHvDL+vo0N3TT4qSC2U5btk1iNw92/pOXGbAvTMp
         i83GfUNblWy/F2Lzuopm37MoBjmoxK/G4sk14juKKWN9g32OdgQUP4TJEKDfX/Pmly7t
         dIsFE/jRy44BSckXXyDnoen04NC5IoGZGWbowCA/RvAl1yUVnF0e3gGf5bNzKktLg0+p
         mg6t/R3uFS4WRKpbA0YxYCw7HaKjSH5DCAaGAnAS30E9xxHrEUiC8lPITfArsy5tC/Dw
         DwbaPRJV90p+JFymDTb+PAmZu/UJTwjxvYm2JhmR+Oe8iVtwgzsOeVh9YUrDDr7oHd4d
         qmBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2Q6IQMlUt9OwzIX64agLdwNdIg0fj9ECLKpGkII79smIXWbACAJRnes8zbxZUbx8iaD+0hXzE@vger.kernel.org
X-Gm-Message-State: AOJu0YzZFV/JZ97XWzfm8Qu6DJEx12qMvbQK4mG35ZtzBK238PDTJWCC
	ySpTha9YJL75+8WW8k8xQ8FumMsFsqBkCcle18OTFGl6ePVwMcZB
X-Gm-Gg: ASbGnctpqNwI2nW7o8Q1Y2Nub/Gpvt3gTKcj44wfgPWoOCk5s4lZg14u9iylgdUNRT3
	LuIXasD28BDLzQsZYvQFOGBnp90VfQYa/QqrIeXU8pmOb3GX09/LMrTpSvAvwwBr3qtQCDua2oA
	KCjyWI9dcPMeXx3IwTrW971C3Zu5nwupmxreT7ee9fx7bI0gK2Q8wOZHSYApBH5Z7gXWSM0Ookx
	aqAcaTpbVP4nOt82F6FCR1yp/WnAcbvsSU1F8MccrWqYNzbSmiA0C5hS30hP5We64/I/LERsnQt
	85GiN56iYHmfqh9AgpOY5uK4HANICwCq1ixbJ//GhljBGgnfQs2GQwEW7yoQD8UAklnk
X-Google-Smtp-Source: AGHT+IFFTSTQpDKc23bSKTdbvF46bBHr7KAByqfjr/p3XlpGzBjPFSs4+8B3+z8HR9qFORFAfBOo3w==
X-Received: by 2002:a17:903:3ba6:b0:223:2cae:4a96 with SMTP id d9443c01a7336-22e103908e6mr65170635ad.42.1746231162383;
        Fri, 02 May 2025 17:12:42 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::5:6a01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228f9csm13718635ad.178.2025.05.02.17.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 17:12:41 -0700 (PDT)
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
Subject: [PATCH v5 5/5] cgroup: document the rstat per-cpu initialization
Date: Fri,  2 May 2025 17:12:22 -0700
Message-ID: <20250503001222.146355-6-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503001222.146355-1-inwardvessel@gmail.com>
References: <20250503001222.146355-1-inwardvessel@gmail.com>
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
index 5b8127d29dc5..66aee8087f3a 100644
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
+	 *     cgroup_init()
+	 *   when css->cgroup is not the root cgroup
+	 *     cgroup_create()
+	 * when css is associated with a subsystem
+	 *   when css->cgroup is the root cgroup
+	 *     cgroup_init_subsys() in the non-early path
+	 *   when css->cgroup is not the root cgroup
+	 *     css_create()
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
+	 *   cgroup_setup_root()
+	 * otherwise
+	 *   cgroup_create()
+	 */
 	struct cgroup_rstat_base_cpu __percpu *rstat_base_cpu;
 
 	/*
-- 
2.47.1


