Return-Path: <cgroups+bounces-11813-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4392C4E370
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 14:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE38134AF18
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 13:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B395B34250D;
	Tue, 11 Nov 2025 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Uw7BhU3M"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB7433BBB4
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868682; cv=none; b=U6TIyi6kvGdEZwgUc5WEWEoWBOSbJhIEI+aQBd6hkXqavLOwfKvQI6D+rSmtevZIkcVxBUk9y0yDmFJMgYGdVKSihCdew+wtWrbdEZrhiVL/90XlV9DxOwo0xe6a5/BpYYEQwhlOeajAcu+fDYGC4Xt0jof5V7pfHZlgkYJhq4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868682; c=relaxed/simple;
	bh=35g9I8Yb/hg4maMftzejHy/BrNK6ZvWVhKBVl/xDwn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=niJ0kYdQRZwO24pACbNLj+yq5x2ORxbPJn6Qzm8pSEOCwJQmSoiwtHVAQbQ7AVYF66F4vuSICRh6Hnjh5Lr8B77p580Tihd3V6nQ0xO8RPgc0RoCBlA8MDONJw+hUaUggwK88G3PbIF09Q/kitY//m1qGquhK/RVVtD3ks4I1AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Uw7BhU3M; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so2111491b3a.1
        for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 05:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762868680; x=1763473480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jNls6INMU6jsxyZMe3CgvVJTOv7NvVA2mbafVbFewXM=;
        b=Uw7BhU3MU0j/xbfAgNlTaLhCiwKe71Hye0wAIFI3zXQIA7dw9s8oYVf52hqtKU/e/w
         SRu16jkWJDwtBaqaa6PCCrNa0Pb7zKt09a8QwuOEycwU48Q484WvxU508O/wRsGVNvLC
         F6uwNgUc9lWdrZcqDmhVDaYismgwyOI0+2BxYOgijhrckneQB+UzqmPvsHFERxUHBN1F
         s8PRHn0g0Wnealf9zkOgua64NlWCpBPS6dzm19MVOophrSBenZfIs+WMvWbdx+KsVVXb
         Ka8Z7Unc4RYeifh76YIFCrlSauvzqm7QxBACQLR92WmfZjICE4POiyFtweP07080gy/z
         11Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868680; x=1763473480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNls6INMU6jsxyZMe3CgvVJTOv7NvVA2mbafVbFewXM=;
        b=Lef4GYoG6ZyyC2gNethrnGxl0ExyOMAkaLiLswSKZBCuTh1TxRecZD3HPV7YA18gEX
         j3dra4Ri2iBvSnfzh0CUFb3w8NWB4ikgOFHNS347StE67MLIEt5K2PdHXNcmAN0RIB/H
         WJqwddd0LvjnWejE2xLRUX+K1E+Fwv7oBzpDKBmEnJv4xE3T2OB492HOxPv66RPZ0zYR
         ycNL7MGJqdoMA+05BZu7AlGyiUxtTeHpZqdcH/gJ2VyV1o1aDuJZp3nvuw4MCusnW1MB
         Ymda0c0UfCVaYrqCzCjGQc/wlAlvLgO7gxNmV7AZFv5/hW3ekIi1S6VMeX2DhnQ4f+/8
         +0RA==
X-Gm-Message-State: AOJu0Yx2gRUMNmDBBY8cfT2quo6Dc4mR8hMuTj+bTgQq1iWMLQXxXS8U
	677qjhpuULQbu1ur3BtazhFoX75AsEXi/UAx6pGhwuR6xBLrp3DS8AdlE0Zvq9QiP1HdaOWEcGr
	CMMhXqAM=
X-Gm-Gg: ASbGncsANpkWKLN09vw+x16uASL1H9CHfMjDbABdNMpQE5xky1ccuKjKcOOrlrbklLw
	Pgt4G9xNDK5HcCvhOwnyx/16v9xHy32oTVAeKUy2WI6CDBGoWCl5TGirDsOlmqTwkR/oGUNp+dy
	Mv73Nsd1ozI+eOSa96BZPATsL2U2nCrJw7IBk+dPh3ymLQef0nY4XCArnEgQzADPRSYDfsYgmnf
	WHUgaaHadAMfRe/rN2wjFAveWsyqLN3lRLcMjMqEzCJ1/8H5z3H5ljcMEsrXD6GB83UuvCKWxOJ
	eUNusfQBv+khbI+8DTZeD7D4y4/02sDlYzojcpvzFzhJK0hxJe/Fd7wpFpI1sErV+B6qAUZBLK4
	QWBcIgeHn9pHy6gdYIj3vePJW31nQILs3zj1kTIRuW3qs32IlSnOKUXYWUEjkYLoM1Vmizazawc
	3sfVEAUitRTcYMQ/mtwZZmhhZbnUF57Q2vKBCwE6afiBDeZZJ5IQ==
X-Google-Smtp-Source: AGHT+IHVprBtd3SLMYC24KqamhEauYMeVGyVRUgYiCi6o4kUbc1FsyNW+cFWnBqsD+7zVZokvRrhLQ==
X-Received: by 2002:a05:6a21:4ccc:b0:340:db9b:cffa with SMTP id adf61e73a8af0-353a11b1731mr12268324637.9.1762868679966;
        Tue, 11 Nov 2025 05:44:39 -0800 (PST)
Received: from K4L2F221J6.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953e2a4sm15772351b3a.6.2025.11.11.05.44.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Nov 2025 05:44:39 -0800 (PST)
From: Wenyu Liu <liuwenyu.0311@bytedance.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wenyu Liu <liuwenyu.0311@bytedance.com>
Subject: [PATCH] cgroup: Improve cgroup_addrm_files remove files handling
Date: Tue, 11 Nov 2025 21:44:27 +0800
Message-Id: <20251111134427.96430-1-liuwenyu.0311@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now cgroup_apply_cftypes(cfts, is_add) with `is_add` false
will remove all the cftype files in `cfts` array, this can lead
to some unexpected behaviors in some abnormal situation.

Consider this situation: if we have two cftype arrays A and B
which contain the exact same files, and we add this two cftypes
with cgroup_add_cftypes().

We can correctly add files from A, but adding B will delete all
files previously added from A.

When adding cftype files of B:
cgroup_add_cftypes
  ->cgroup_apply_cftypes
      ->cgroup_addrm_files (failed with -EEXIST)
  ->cgroup_rm_cftypes_locked (this will delete all files added from A)

Even worse thing is that if we add B again at this point,
we can successfully create these files, but there will be two cftys
nodes (A and B) on the ss->cftys list at the same time.

    ss        A|0|1|2|3|...|   B|0|1|2|3|...|
 +------+       |                |
 |      |       +          +-----+
 +------+       |          |
 | cfts |<-->|node|<--->|node|<--->|...|
 +------+

This will lead to all hierarchies that apply this ss controller
to be unable to create any directory:
cgroup_mkdir
  ->cgroup_apply_control_enable
    ->css_populate_dir
      ->cgroup_addrm_files (will return -EEXIST when handling node of B)

Add a new flag __CFTYPE_ADDRM_END to track the end cft if something
wrong with cgroup_addrm_files() add files, make sure we only remove
the cftype files that were successfully added.

Signed-off-by: Wenyu Liu <liuwenyu.0311@bytedance.com>
---
 include/linux/cgroup-defs.h | 1 +
 kernel/cgroup/cgroup.c      | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 93318fce31f3..7ad98048ca23 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -144,6 +144,7 @@ enum {
 	__CFTYPE_ONLY_ON_DFL	= (1 << 16),	/* only on default hierarchy */
 	__CFTYPE_NOT_ON_DFL	= (1 << 17),	/* not on default hierarchy */
 	__CFTYPE_ADDED		= (1 << 18),
+	__CFTYPE_ADDRM_END  = (1 << 19),
 };
 
 enum cgroup_attach_lock_mode {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6ae5f48cf64e..0d7d3079e635 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4453,13 +4453,13 @@ static int cgroup_addrm_files(struct cgroup_subsys_state *css,
 			      struct cgroup *cgrp, struct cftype cfts[],
 			      bool is_add)
 {
-	struct cftype *cft, *cft_end = NULL;
+	struct cftype *cft;
 	int ret = 0;
 
 	lockdep_assert_held(&cgroup_mutex);
 
 restart:
-	for (cft = cfts; cft != cft_end && cft->name[0] != '\0'; cft++) {
+	for (cft = cfts; !(cft->flags & __CFTYPE_ADDRM_END) && cft->name[0] != '\0'; cft++) {
 		/* does cft->flags tell us to skip this file on @cgrp? */
 		if ((cft->flags & __CFTYPE_ONLY_ON_DFL) && !cgroup_on_dfl(cgrp))
 			continue;
@@ -4476,7 +4476,7 @@ static int cgroup_addrm_files(struct cgroup_subsys_state *css,
 			if (ret) {
 				pr_warn("%s: failed to add %s, err=%d\n",
 					__func__, cft->name, ret);
-				cft_end = cft;
+				cft->flags |= __CFTYPE_ADDRM_END;
 				is_add = false;
 				goto restart;
 			}
@@ -4526,7 +4526,7 @@ static void cgroup_exit_cftypes(struct cftype *cfts)
 
 		/* revert flags set by cgroup core while adding @cfts */
 		cft->flags &= ~(__CFTYPE_ONLY_ON_DFL | __CFTYPE_NOT_ON_DFL |
-				__CFTYPE_ADDED);
+				__CFTYPE_ADDED | __CFTYPE_ADDRM_END);
 	}
 }
 
-- 
2.39.3 (Apple Git-146)


