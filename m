Return-Path: <cgroups+bounces-7342-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7258CA7B55B
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 03:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AFED175996
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 01:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282B910957;
	Fri,  4 Apr 2025 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2/slQuo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C70A2E62DA
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 01:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743729066; cv=none; b=SV1qRw2iTg2tqhZQ+KEuu1aqEk/XVeNqe1NBgjehbkklWwQH18AbtA3Gx/+NsaInQsCl/RVXJS/yoa/CJH0NiKg3yOwvr5uA/M+Zt0OdOm4RG4CgltRF5QHT+jhXVXXr4FKlIfDVfYeloIdo4N+RdVmFyRmM0n1V+ZswrBTH4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743729066; c=relaxed/simple;
	bh=ujpnM4y5zsV/mxjgG8PahAq32X25ID6Lnl1ZW+QV/Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/HTkEgiyuZNEhEiXRIiCjV5CjSknZ1YOdMJa29cJQET+nDuPyoIqfwWliORwUaCoPGFs5g5hFWb7kgH7bb4EH9T4B8AdtE7Xsi4APmCIA0XcYdQOZ3wRN9DLOXZoigxMifKnrGe8AmNV74B1rQ2NN+J2SK//K4PrStP7Tidr5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2/slQuo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2255003f4c6so14869315ad.0
        for <cgroups@vger.kernel.org>; Thu, 03 Apr 2025 18:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743729065; x=1744333865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyiV7O0dNdMY8vgOXnK3Ve+6OewztvuN1tfM94bph58=;
        b=T2/slQuo9ZiMuVMj3IksKdOGpVBY9Qwm5ja83tnn1LolmMR/H3yp2WcgTVG9Em2jE7
         NlK96jntpx/tu/WHqKLMzBrin8xOsUvn7YiQmsfgiFlbkeJLeeijG1n5RBDwxXLWG3rc
         CCQiteUDpO8ePLzvLJwe5MOpiXWUubuh/6QrTByAr4dlFB7uwxx2Ipbi40MO3HEnvVEX
         gizGJ1BzKD9pVCgaQz42R73tSGoTKEm4h0tA71B2SSckG/5bD2HgKS+D+8ho1YzE3mmU
         DNOfFDZGjhLP+jP/PmX823m6+Zkf5gnSdWQjX1zeXQ/ljlyRyD+hiUHkE2Xhl9ZInYOd
         Fr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743729065; x=1744333865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyiV7O0dNdMY8vgOXnK3Ve+6OewztvuN1tfM94bph58=;
        b=bpQltITW8TiXHkTkT2+fzllx4/tSzn30oxnrBDTaNEYy+JOpdGp0TghYSUUH8ida3x
         baLBCLFiBilX6ofFg83zTO/3rBVAsSpA4HItjRmq7b/knBPLweWJqQOR4LeLbzon0yHJ
         NpUt2NK3b4pjxGOh/B8eTg1x/ttezZfqxhWY76LCLizLos/P/9v62yo3+OEI+1BLHX9C
         kg4ejC6FALzg1tI4VJlnHV3EELN3blISl7jt29e4LwrBL6fQ7WrMMmRsVuv98uJAI7dl
         sVnKYYy6n7sbwqtN2/t62U1EUZFi3oD90jq8CKQjbuj2X30yHX86XeDR5PTedqS3Y9R1
         hPYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeSWr3AOAAdzPvnvmu0sCYldplyTukuspFcGOpEen3NA5DZDbdhZiiGEdYhMiAD3dygkwusAUz@vger.kernel.org
X-Gm-Message-State: AOJu0YzS3tDZ5MO7Q3TdHpPL0IEDRqVyxezE8i+x6OqlRD1RThcX6osA
	MSlEofEix9AoEsb8hWlFa3hrn/mYnDIp8+N1w6wEkEBh9Qtuwp5Z
X-Gm-Gg: ASbGncunrD7olH56tfIjCgziIXuRzbdC1aa0hKXkbjs27XGgAD9/z1ZO+ssE6XjRC0Z
	3ljdgKqO92TMp8Q6YC7kHt9gHFdSk0P342OrswzBV3VlSWE8yN2Eq5smn7jx7QJHJKP3LOKP5gi
	EHAcaAdTRf5nPtpKfCIC6YH1TAxF/1ag2nfGQ20d/uV30LvlGg25C9opl6NTQds0FZXB2W7h1G/
	7Fm1ZgaKmAHBMLUzM0ImWZYcMQKxBlm0hOoDaQ84Ihzo/cvbs+SWBNma6aJQSzc0GwCQNqo0OJE
	yBHQOq5Tc9EgdMqVwA6dIqsFZN7MIPtHLAFuzXqURNYGDolVcxldyeyGkRvQO9hncY7cMIlx
X-Google-Smtp-Source: AGHT+IEsnhjiqZvK32w8B2KDYISHE9qbYkcOiXt+WlUo2/SYfwttWGmA9UkC1XbE95jC7l8EqhiqxA==
X-Received: by 2002:a17:902:c40e:b0:224:2717:798d with SMTP id d9443c01a7336-22a8a0b4990mr17306385ad.50.1743729064765;
        Thu, 03 Apr 2025 18:11:04 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::7:9b28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad9a0sm21268675ad.39.2025.04.03.18.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 18:11:04 -0700 (PDT)
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
Subject: [PATCH v4 2/5] cgroup: add helper for checking when css is cgroup::self
Date: Thu,  3 Apr 2025 18:10:47 -0700
Message-ID: <20250404011050.121777-3-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404011050.121777-1-inwardvessel@gmail.com>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cgroup struct has a css field called "self". The main difference
between this css and the others found in the cgroup::subsys array is that
cgroup::self has a NULL subsystem pointer. There are several places where
checks are performed to determine whether the css in question is
cgroup::self or not. Instead of accessing css->ss directly, introduce a
helper function that shows the intent and use where applicable.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/cgroup.h | 5 +++++
 kernel/cgroup/cgroup.c | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 28e999f2c642..7c120efd5e49 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -347,6 +347,11 @@ static inline bool css_is_dying(struct cgroup_subsys_state *css)
 	return !(css->flags & CSS_NO_REF) && percpu_ref_is_dying(&css->refcnt);
 }
 
+static inline bool css_is_cgroup(struct cgroup_subsys_state *css)
+{
+	return css->ss == NULL;
+}
+
 static inline void cgroup_get(struct cgroup *cgrp)
 {
 	css_get(&cgrp->self);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 77349d07b117..00eb882dc6e7 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1719,7 +1719,7 @@ static void css_clear_dir(struct cgroup_subsys_state *css)
 
 	css->flags &= ~CSS_VISIBLE;
 
-	if (!css->ss) {
+	if (css_is_cgroup(css)) {
 		if (cgroup_on_dfl(cgrp)) {
 			cgroup_addrm_files(css, cgrp,
 					   cgroup_base_files, false);
@@ -1751,7 +1751,7 @@ static int css_populate_dir(struct cgroup_subsys_state *css)
 	if (css->flags & CSS_VISIBLE)
 		return 0;
 
-	if (!css->ss) {
+	if (css_is_cgroup(css)) {
 		if (cgroup_on_dfl(cgrp)) {
 			ret = cgroup_addrm_files(css, cgrp,
 						 cgroup_base_files, true);
-- 
2.47.1


