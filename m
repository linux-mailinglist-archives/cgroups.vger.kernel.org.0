Return-Path: <cgroups+bounces-424-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ABB7EC864
	for <lists+cgroups@lfdr.de>; Wed, 15 Nov 2023 17:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85AE8B20B3D
	for <lists+cgroups@lfdr.de>; Wed, 15 Nov 2023 16:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6EC381C4;
	Wed, 15 Nov 2023 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E3OXM9Is"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85933381C1
	for <cgroups@vger.kernel.org>; Wed, 15 Nov 2023 16:21:03 +0000 (UTC)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D5A196
	for <cgroups@vger.kernel.org>; Wed, 15 Nov 2023 08:21:00 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-359974f4c7eso26794965ab.1
        for <cgroups@vger.kernel.org>; Wed, 15 Nov 2023 08:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700065260; x=1700670060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VTFJnUE02Fl/erP4woMg7FCRUhqR44wUotjmE1ijPSg=;
        b=E3OXM9IscpCbdG0whh1LM+tDmt9fJlxiGMSJXfrGUPZk//C0vc/o7Noe+uY6NHW40q
         ltxQ0ZJBfuOCLWeZs3cs1YCfFvnI/FApGQoyXT6YvonCKuZ5Y8386X1CzDawAApBbLGn
         dMYsemcdeO63NIcKS83GXHvreEys9e9fTUMgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700065260; x=1700670060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTFJnUE02Fl/erP4woMg7FCRUhqR44wUotjmE1ijPSg=;
        b=J5edRRpwJ56qcgrX9mIaaLbWfsqVzwpXYThH3ee/pHHCaxRjb6ZODsd7vS/4LnTUZC
         UzkThb4t+ko6oUfgNfamPDjRcqZgGodrpLh7i6cERZn2ll7Jf/YX21O72G0oKjo5hskx
         pEtUrT1cVv+ltX/18SWpobIBuXrKzWm2/vOKhhLJBMMnato8vj2NupLzZ3dAMyIbPMOP
         hugOygXLUEUAfCG8Mxecr8CbT6SIYaEatXKEAfXFo9oSs98c9YQurWit1AO74dTS3gk+
         QdQ9j2NsH2wGy/hTfa5eKY3McQXrBEJh+Px4mZXogcScT+B/LfkthjDly8xsYGNikWve
         Q2Og==
X-Gm-Message-State: AOJu0Yw3ieHxAVg2jswA8BMBpYdwGTTWxKCXs/Vw6BMbcrrgEbRpaz8S
	BrJleI4Zyeg3Zb43ol7NOgaAow==
X-Google-Smtp-Source: AGHT+IEQfGCSbzgsXlVEtw+4pIN/s1f2VziN8iZBz3Kt/hFHx8nWNO7LKYqHriHT3La4Y7GhbMaaPw==
X-Received: by 2002:a92:c24a:0:b0:35a:b0a5:23ab with SMTP id k10-20020a92c24a000000b0035ab0a523abmr13217526ilo.21.1700065260120;
        Wed, 15 Nov 2023 08:21:00 -0800 (PST)
Received: from timvp-p620-9115096.bld.corp.google.com ([2620:15c:183:200:31f9:945d:f7f2:bd55])
        by smtp.gmail.com with ESMTPSA id r1-20020a92c501000000b003574cad1598sm1215050ilg.33.2023.11.15.08.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:20:59 -0800 (PST)
From: Tim Van Patten <timvp@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: markhas@google.com,
	Tim Van Patten <timvp@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org
Subject: [PATCH] cgroup_freezer: cgroup_freezing: Check if not frozen
Date: Wed, 15 Nov 2023 09:20:43 -0700
Message-ID: <20231115162054.2896748-1-timvp@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tim Van Patten <timvp@google.com>

__thaw_task() was recently updated to warn if the task being thawed was
part of a freezer cgroup that is still currently freezing:

	void __thaw_task(struct task_struct *p)
	{
	...
		if (WARN_ON_ONCE(freezing(p)))
			goto unlock;

This has exposed a bug in cgroup1 freezing where when CGROUP_FROZEN is
asserted, the CGROUP_FREEZING bits are not also cleared at the same
time. Meaning, when a cgroup is marked FROZEN it continues to be marked
FREEZING as well. This causes the WARNING to trigger, because
cgroup_freezing() thinks the cgroup is still freezing.

There are two ways to fix this:

1. Whenever FROZEN is set, clear FREEZING for the cgroup and all
children cgroups.
2. Update cgroup_freezing() to also verify that FROZEN is not set.

This patch implements option (2), since it's smaller and more
straightforward.

Signed-off-by: Tim Van Patten <timvp@google.com>
---

 kernel/cgroup/legacy_freezer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index 122dacb3a443..66d1708042a7 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -66,9 +66,15 @@ static struct freezer *parent_freezer(struct freezer *freezer)
 bool cgroup_freezing(struct task_struct *task)
 {
 	bool ret;
+	unsigned int state;
 
 	rcu_read_lock();
-	ret = task_freezer(task)->state & CGROUP_FREEZING;
+	/* Check if the cgroup is still FREEZING, but not FROZEN. The extra
+	 * !FROZEN check is required, because the FREEZING bit is not cleared
+	 * when the state FROZEN is reached.
+	 */
+	state = task_freezer(task)->state;
+	ret = (state & CGROUP_FREEZING) && !(state & CGROUP_FROZEN);
 	rcu_read_unlock();
 
 	return ret;
-- 
2.43.0.rc0.421.g78406f8d94-goog


