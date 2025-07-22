Return-Path: <cgroups+bounces-8815-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30236B0CF36
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 03:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0413C6C6FA1
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 01:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219F21E3DFE;
	Tue, 22 Jul 2025 01:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKxXjnGc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817551AC44D;
	Tue, 22 Jul 2025 01:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148456; cv=none; b=YgmJeZziyWD++M9qTvBw78OK1o9qTO8rPbCLdD0kzY1d1DpbsZasqyLYndlcFiws7CuMZbbqtQWaOiC5YO+gh18j/ltL//WfrNr39mJbNyvSZZRe/1HptvUqSl7XvCHFtQKp8WNjFpPlfmOdbbPXdFOMC2fYv3fdedZmtyc53/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148456; c=relaxed/simple;
	bh=y5qrT1QbqSjri6W+4AWzLCs1sxAfsQM0FEqrd2Sfo4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZ3BS2XgnfIKSK5su7Uk3Hi9CQSBvQW+c4LZqFLM7mioTEPVmXl2UgzxltiepCQYaMFpU6U5o7S6dxWzvkhrh/J8CiA4ArDemq8a2Ro3xDL32cvfIQLy5+5AV4+XABH5Q20j1W6OlzsRJ7BA9fUdhjkuDvTR0Xv5BAWQ8eCxjeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKxXjnGc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso4224994b3a.0;
        Mon, 21 Jul 2025 18:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753148454; x=1753753254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P29Ie3p2JSXd0sbOP8FF4LrIvKgvkS65h14Qi4nDLfA=;
        b=YKxXjnGc+ED+FveCkusfnQh/D4HOCkQ+yl41mw+5zhzXdO5TQPdT8Puf5rzSSVz43K
         EcHwpXQsN6uQ06V1q+cuuvc8Vic6EPM8cfLu7f5Ypqy1tWAlD3scCuJyBP2aK+6ROGwL
         QBE0+vWjHGCQFHrqfergmxOsAz1cDhBv39uNY8+WybEah0UaD9Mp1+K1Pcy9KGyO8fzs
         Kl4lIy/Sx8DnIQqPiZokchN9JNmTfp/6G52UKFAQFYp8m9HONUmq6jORfNfojqpp8k/l
         zbytal5m9rI66sU3SPSkMiokLPJzPjC4AP1Np2sgJlh+C5ul8Kh1PvAIxYieBWUvqQfv
         FkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753148454; x=1753753254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P29Ie3p2JSXd0sbOP8FF4LrIvKgvkS65h14Qi4nDLfA=;
        b=hqGjhrCPmiPagSscsIGVAWCfG02hpmBb1CQrXN0+yu6Ixtr4wuaCU0PwpDTxDD7+m8
         eDeaHKjzeN8Sii4ZM2zfhzmh3kcelsljyswJRV2gIyv8GbOftWVklzvi7YaKS9ro1JFC
         mjPprAuc8Ura/Z/jJpy4WqGmzV7219VBkVzS28IQfN/c1ReseisxsW83M/ldkvI3IOd7
         MuBxm1o2sigya5lZK9Zq/02AQHfZnKEgueuAsqwiFtSc6ew/Vec0BMut4zS4FWwxn3CG
         yyz+pk4A3BH6B+ZkwqrOQiYE0Lu6+fyqey+zJmM4oIS4dPux+qhm/zwQdGVdnf2qcqXY
         peYw==
X-Forwarded-Encrypted: i=1; AJvYcCU7zz36YwfZLkiO2d9fI4Ro0Xw0rSTx+laIfKXXA8iCc0EbkPA1AOLTacJMnh8YTz2XhWUv9Xum@vger.kernel.org
X-Gm-Message-State: AOJu0YzTgVF8EDNWweS9SBH82XEF5uteisGKwDtA3DFVoaPvhH+pRQ8P
	U2xBSYExXlBdmEg567PG6zTpj8rcco1X3QtjbEO/5LrEVI/cznq2h9uT
X-Gm-Gg: ASbGncvsT3oSSZoMEn7DFWDbc0CBNlQ39ysatonPBOLi5oauEDNtJWVZi5od+Od3acw
	/4KJbJ4ynMuOlr0qq05i/4PbW04yyDVP7IYzJv+fmUO8Uyn+9u9M+9NbVe/VJQB6G+FB1bUjZCS
	zgf70bhY7xqDhmf3Sqhyor4NQkv54ZvQkaqq/E1UbtNEXIHo2hyTaGyUDgj4IDgevKRp05jmxJC
	JIxcK6GRmZFP7AbXo7DDYrbWmfmfJcfe061nQZydxoGQqOk/OIrfFNL679LW41gXRhixDXe70AR
	RvUsgmV5I5S/RcH/oUIzClL51jpL+v6bL7hdgxrd2XAOdOo+3/PycMrVkO2MwTFiBW1U6f4omds
	5FGfwr4Ylzf7x5zw3HB6X0CNnBKDX6lOjSuV+EaAYe37KQsnk
X-Google-Smtp-Source: AGHT+IFHHUEI9V2PzmITHq6Dn8/pHIGtkfzzuFLjolTgZaHesMWGTRlig91CXbkIwWYUeR3yK07uBA==
X-Received: by 2002:a05:6a00:3392:b0:73e:10ea:b1e9 with SMTP id d2e1a72fcca58-75722869545mr28153829b3a.6.1753148453743;
        Mon, 21 Jul 2025 18:40:53 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb15699esm6584089b3a.82.2025.07.21.18.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 18:40:53 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: tj@kernel.org,
	shakeel.butt@linux.dev,
	mkoutny@suse.com,
	yosryahmed@google.com,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 4/5 cgroup/for-6.16-fixes] cgroup: initialize css rstat before linking to cgroups in css_create()
Date: Mon, 21 Jul 2025 18:40:29 -0700
Message-ID: <20250722014030.297537-5-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722014030.297537-1-inwardvessel@gmail.com>
References: <20250722014030.297537-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling css_rstat_init() after linking the css with its cgroup (and parent
cgroup) leaves the code vulnerable to async cleanup where css_rstat_exit()
is invoked on a fully initialized css. Avoid this by calling
css_rstat_init() before linking. The error can then be handled inline with
no async cleanup requirement.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/cgroup.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1990c6113c7f..0f8c6ce21634 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5675,6 +5675,15 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 		return css;
 
 	init_css(css);
+
+	if (ss->css_rstat_flush) {
+		err = css_rstat_init(css);
+		if (err) {
+			ss->css_free(css);
+			goto err_out;
+		}
+	}
+
 	link_css(css, ss, cgrp);
 
 	err = percpu_ref_init(&css->refcnt, css_release, 0, GFP_KERNEL);
@@ -5686,12 +5695,6 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 		goto err_free_css;
 	css->id = err;
 
-	if (ss->css_rstat_flush) {
-		err = css_rstat_init(css);
-		if (err)
-			goto err_free_css;
-	}
-
 	/* @css is ready to be brought online now, make it visible */
 	list_add_tail_rcu(&css->sibling, &parent_css->children);
 	cgroup_idr_replace(&ss->css_idr, css, css->id);
@@ -5707,6 +5710,7 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 err_free_css:
 	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
 	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
+err_out:
 	return ERR_PTR(err);
 }
 
-- 
2.47.1


