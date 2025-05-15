Return-Path: <cgroups+bounces-8200-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFF2AB7A78
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 02:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89CE2179AB8
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 00:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC97DDC5;
	Thu, 15 May 2025 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0dMS6wU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6DB33E1
	for <cgroups@vger.kernel.org>; Thu, 15 May 2025 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747268392; cv=none; b=juSbLHZsdpKQ9KlXWhfDI+Y097JRthK35CXabx0lagYp8sID8bsgdL7Tm3uhmJf+hTJTGCXvLPqOJacbzid7jW95XbN1FEelTIhpxFR2Sa1eVG676OJH8gfufs7b4T4ddGogFCG4tbxpf4QoUNFPTlTTYyslrOChwa6BgjlSgSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747268392; c=relaxed/simple;
	bh=BcalKN28jJRnmx0F0meBBLUgbI4BIeW9Lp5W1Pi+Cg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ew8VC2yyUIsSCR2NPP49kvrIu+hfUyhjkwYCXT/nu3kxA2MBcXbp213KANXa5/O/eOF0pSAiXUrwak8t2uxD0eagO62TqiJ5To9RPYqgx3jlIJ3uyn0zTBWpkXpGMTtfozrIDQi/lq+nubg8AIwUHPFCVdhU0fZq8OBASGED0kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0dMS6wU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22e70a9c6bdso5191035ad.3
        for <cgroups@vger.kernel.org>; Wed, 14 May 2025 17:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747268390; x=1747873190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUTWdwmMcIzb1e7juyJwpTlqnFpMaz9poabQke7cTwg=;
        b=f0dMS6wUnjQWxiBpkUrk3AZmwTqpEPSLKUwrLdtzBkGJDAT7xsJrGFakr1zvsu9g38
         0BpYdT96J9wYIiPrMNj0V1sAOSMlqMsJmXTEiQduX3CM3kp+dC0akjchiPPlJxlsSqy0
         1Os0ZO8ZAt2JfTfVRqC72htDIeqkWKDEDR1+4AqgqI99K9SRXp2BEti+VanBZ9m+XffQ
         qi7m0B4tAu68jwZszmSsvcYNcrEKtdiJPdQdVXiasS55fYJj5KFJXsdeX/t13IWJ2rcj
         pmKv3muB/rU+Xf/+j1bLdxwMpm6yjk0rlXgtc8WgAmjFJZQFqkPoCodh6g3boc6/zsBN
         3U/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747268390; x=1747873190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUTWdwmMcIzb1e7juyJwpTlqnFpMaz9poabQke7cTwg=;
        b=VMz75LwbqIayfjNzna2nKTpkwSotC7KYeWX+Hry5NA8YELJoGuY07bQ+v4wsbkTZTu
         NeW+l4RThZivOAZLQvVkCBa5NO0Y/84DFPuds7/zQm4/Ry0iruMRqYYNUFpUCNOMad9c
         fauLGLrTHi1X55D8XPm+BrLj9F3C9DOY82tnyi3vMI0n3KhgBeVAUtKJIX0nuSdKnkVM
         /38OOwRcaLLqQNcZiQzKj/QfpR0ArSgswuWOTzthn7ucneed7NhY4RqW6czSCy+o7VPw
         FaAj40Lbh10WGAT9BbtfeCffVzkjKvOYjOgHsTuq+QCE3bGOCmWYQikJbzj+sZCOpchT
         JBjw==
X-Forwarded-Encrypted: i=1; AJvYcCUEIZ7AMRgsCiT+1dB2Bafvir5uczamMJOAkElEDt+eLzATjfgnVaO6go3DHHJUt/9QZP/CHE1o@vger.kernel.org
X-Gm-Message-State: AOJu0YwFs/wV9HYTWyxTu6BsbOuWzB0s7u/UReeqD8Hqv5RCjPZWiHqD
	f2MmxO8vbZQ1RVkFpbYkPzrRnriHM/DTULvouGkxpCzD0LsTv1eK
X-Gm-Gg: ASbGncsIz6ftH/MlVNjgIMReA8y1Q2AhKDqSz55TC7L71NO8cIGyx+kZa1OOEaNpVWK
	I+vRCIOWWp/O3Km2SCHsfMJP1imTNLwDv6ucSoigza2FEFV5MPcuoc2RIauyVAE8QfDsfPvVrzs
	d3l/0HfbCA8ts2QSttTVlLMYyWccgvSEWpfWKtocDw99UzNEXG7guCEIFwZNlu2/8A0UYlMeh6D
	K9aJ6eJeVm7w3XUB7E3HsQz7f4GyZ/OiMkZ6r3MgzUwiegaBV2HHjZYtS3PyF0G3lGLJedXXaF+
	nf+V0luVkeigxThpjorpXm/da4vMi6FFWqe1gCfvIPOzCDGHHv2KUCbT93MMsyoG1Ui298xrbRi
	BG7btbjEZqzxjqxP4pcrq/57Oris/UkvJVKlKll4=
X-Google-Smtp-Source: AGHT+IH6uTdU6PiA2BNAeuQ7hrjykpNopHGrNFc8VEmTTp1ZOjgAgAyGwrsnsjAwHjU842B3xDZsAA==
X-Received: by 2002:a17:902:ca0d:b0:231:99a4:8321 with SMTP id d9443c01a7336-23199a48374mr48019085ad.51.1747268390316;
        Wed, 14 May 2025 17:19:50 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc754785bsm105939545ad.20.2025.05.14.17.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 17:19:49 -0700 (PDT)
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
Subject: [PATCH v6 2/6] cgroup: compare css to cgroup::self in helper for distingushing css
Date: Wed, 14 May 2025 17:19:33 -0700
Message-ID: <20250515001937.219505-3-inwardvessel@gmail.com>
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

Adjust the implementation of css_is_cgroup() so that it compares the given
css to cgroup::self. Rename the function to css_is_self() in order to
reflect that. Change the existing css->ss NULL check to a warning in the
true branch. Finally, adjust call sites to use the new function name.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/cgroup.h | 10 ++++++++--
 kernel/cgroup/cgroup.c |  8 ++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 04d4ccc7b1c5..00cb37b6fdab 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -347,9 +347,15 @@ static inline bool css_is_dying(struct cgroup_subsys_state *css)
 	return css->flags & CSS_DYING;
 }
 
-static inline bool css_is_cgroup(struct cgroup_subsys_state *css)
+static inline bool css_is_self(struct cgroup_subsys_state *css)
 {
-	return css->ss == NULL;
+	if (css == &css->cgroup->self) {
+		/* cgroup::self should not have subsystem association */
+		WARN_ON(css->ss != NULL);
+		return true;
+	}
+
+	return false;
 }
 
 static inline void cgroup_get(struct cgroup *cgrp)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 83b35c22da95..ce6a60b9b585 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1706,7 +1706,7 @@ static void css_clear_dir(struct cgroup_subsys_state *css)
 
 	css->flags &= ~CSS_VISIBLE;
 
-	if (css_is_cgroup(css)) {
+	if (css_is_self(css)) {
 		if (cgroup_on_dfl(cgrp)) {
 			cgroup_addrm_files(css, cgrp,
 					   cgroup_base_files, false);
@@ -1738,7 +1738,7 @@ static int css_populate_dir(struct cgroup_subsys_state *css)
 	if (css->flags & CSS_VISIBLE)
 		return 0;
 
-	if (css_is_cgroup(css)) {
+	if (css_is_self(css)) {
 		if (cgroup_on_dfl(cgrp)) {
 			ret = cgroup_addrm_files(css, cgrp,
 						 cgroup_base_files, true);
@@ -5406,7 +5406,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 
 	percpu_ref_exit(&css->refcnt);
 
-	if (ss) {
+	if (!css_is_self(css)) {
 		/* css free path */
 		struct cgroup_subsys_state *parent = css->parent;
 		int id = css->id;
@@ -5460,7 +5460,7 @@ static void css_release_work_fn(struct work_struct *work)
 	css->flags |= CSS_RELEASED;
 	list_del_rcu(&css->sibling);
 
-	if (ss) {
+	if (!css_is_self(css)) {
 		struct cgroup *parent_cgrp;
 
 		/* css release path */
-- 
2.47.1


