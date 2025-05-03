Return-Path: <cgroups+bounces-7997-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FA3AA7DAC
	for <lists+cgroups@lfdr.de>; Sat,  3 May 2025 02:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25A44C53FE
	for <lists+cgroups@lfdr.de>; Sat,  3 May 2025 00:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C952CA8;
	Sat,  3 May 2025 00:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbPyeEeV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEBF186A
	for <cgroups@vger.kernel.org>; Sat,  3 May 2025 00:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746231158; cv=none; b=ABAZxwhianmqRDE0s5QGve09xhmRr1+TEsBJpZZhtpbL5TCz9B9mIv076gCKnOTb4dWEoRHGB1JGM3lP4diCNRVarO/Ktf+gXReSlzzi0jX1472DPh6jFpbBEbuWlMS0Ww+suYSHT+leSvsLzopmIeWauU4ENuYSmDKoSD66eUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746231158; c=relaxed/simple;
	bh=L3bcjYujZXy4zvanXVWZ2tkSoMIZCV0Gbzxl0apLMo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGr/7b1br8a5BPihwgigMPxRqyBEt5r94+LgOp4bKhAccASn7Ak3Lc3Riru85ChUXldZ4OrwklJFZ9hB8poS/7UH2F0xnlZMqstQIUGv8O4NS5XeGxME4fCmyOSTz6Oo5SRH6QMr5MUfZKjWVd4zUkKiZyUGDzVhHPIqUrM3wSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbPyeEeV; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224191d92e4so28645825ad.3
        for <cgroups@vger.kernel.org>; Fri, 02 May 2025 17:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746231157; x=1746835957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZYxaPq1B+YdBJsfwMpJaL6pF8SiJE0xoumVl7AtG5A=;
        b=kbPyeEeVPAvn9TqvuJrEjfcM0yaGU1gmAie6NPELjTni0rhZ3G2pHCL4sDhGMZ6F34
         A0n7ISml+DOhvvBPsF8lCvKCneTVI5D9dAYsk7cqQs79PmsaMTOxUdNvbBM7bOeJanvj
         i9j5ZkZBMyNUmdKnb0VeIj7sdecOD8+1heNiYFQgF6emA2HtCxfKj9vfFtAaqeDYqoXG
         SWrRmZu1oNqG+LMJgM9aNV+P+6/8G3+zl4HJsilgkiK7I9W3ipX7KTpRC9VQmD2rfvTW
         KoEBynBlE+VI2mp0xSZZIRKdm7wRwp4EM4M9kyk+QS10OKl8sK8T5gCAQy3Vutwgphk9
         hj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746231157; x=1746835957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZYxaPq1B+YdBJsfwMpJaL6pF8SiJE0xoumVl7AtG5A=;
        b=vgbllfn4xvzk+6l/JFL29UNM0r14XFb1an+++ksQ8RxFpzEppOyY8qRZtRl70g6DH2
         NzuMlD5yoF9z2e9ZZY3Gf4mHLo+MnYwhD/tGts+pNQ5fo/KA3Zf8dS7+X0LbmiIbGJQT
         yH777eMsynZHivghJngFc7fKrb9ppTGaVSAUtmSAqa9RF4eV2uQ9ksnwlqiGRR2p8g8j
         x3F88S1wRHsh9eo+QJ2ng0AXqWSvHALnC7ldiL5d/CIZSKXMVzhhmhqyX5xm1Mejl+G9
         hRWroBc86/L7GxUZ6EXozoqwBp3KXboQWVkq4ZVM6zMLvUOcZeWDgyP0+YLLIRS5W4Y5
         vjsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVICB6X4x7y2EKEPQLjDKni30llydkB8Vy4SnHM8LX289aUfOq/uHi3FA9E0zfu522bITlgmmz/@vger.kernel.org
X-Gm-Message-State: AOJu0YzmLki6OMMxc1HeRJkNfy3CygchPm8b2MtYyXp1C42lSnGZxHLa
	U8LmYxUJE65mlLmRCj9bQylBMzwABOaEImNnMyyxf7YGO7KRw0mg
X-Gm-Gg: ASbGncuVquZMkuikQFnJdGNppOXK0dT7A7LztAZZ9kcRHeq/6jWwupsB0jUhj6TW/Lp
	k4nHZYcNpi7mK6x9A2mvecyOP3eXcwzWd7tPkVRhWpZMSBP41eNxtwqMmrd1fkiBY5vB/on1tEf
	xqU9ZERh58UlKx8hsPVv7lhboN8O7SoJNZCqghcMSUIX4Y5UIxso3GtjEZNr4/KvU2yOsh/cO08
	Z2eK2TRss0tqg/TBOYFPLF/+JfIDiXcfXEysxme/WrPDTWy3UYCFENmukdgXegPFD0pQddRlh5w
	mZI6UMgpS7py0nfDfiGw+9cSCprNzwHQ2tz5qp1svoc9Je6TANSxhWdqWExsGBwfEQic
X-Google-Smtp-Source: AGHT+IHwzKez5tGLPNTzfpruEhBKr3lxVhFniRAI4IDXjCwGi7kvZMo9l78o5Akn9VeUt75tACXihA==
X-Received: by 2002:a17:903:198e:b0:224:10b9:357a with SMTP id d9443c01a7336-22e10382daamr77922615ad.32.1746231156773;
        Fri, 02 May 2025 17:12:36 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::5:6a01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228f9csm13718635ad.178.2025.05.02.17.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 17:12:36 -0700 (PDT)
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
Subject: [PATCH v5 1/5] cgroup: use helper for distingushing css in callbacks
Date: Fri,  2 May 2025 17:12:18 -0700
Message-ID: <20250503001222.146355-2-inwardvessel@gmail.com>
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

The callbacks used for cleaning up css's check whether the css is
associated with a subsystem or not. Instead of just checking the ss
pointer, use the helper functions to better show the intention.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/cgroup/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 7471811a00de..125240f8318c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5406,7 +5406,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 
 	percpu_ref_exit(&css->refcnt);
 
-	if (ss) {
+	if (!css_is_cgroup(css)) {
 		/* css free path */
 		struct cgroup_subsys_state *parent = css->parent;
 		int id = css->id;
@@ -5460,7 +5460,7 @@ static void css_release_work_fn(struct work_struct *work)
 	css->flags |= CSS_RELEASED;
 	list_del_rcu(&css->sibling);
 
-	if (ss) {
+	if (!css_is_cgroup(css)) {
 		struct cgroup *parent_cgrp;
 
 		/* css release path */
-- 
2.47.1


