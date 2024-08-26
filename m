Return-Path: <cgroups+bounces-4478-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8A895FD92
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 00:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E80E1C21EB8
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 22:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4631E19D88B;
	Mon, 26 Aug 2024 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgSsKvjZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2410146A71;
	Mon, 26 Aug 2024 22:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724713109; cv=none; b=iaOxCBM12QRIbje595DrYzcb3rjRM/mBirTvQfSxKb5zxP6p2tRP5Bv+MZFonyBaMb25tLKDAPbCZIVhPxRv0QwAOs/BL5vF+NhhUZ0jSkWbhs0mNpANyNFGizQNECsnIEV4DyjcGuDQ5sKD3vrnFd0DxDu7qwHB06n9Ort3Wn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724713109; c=relaxed/simple;
	bh=V7eWotD3RvBzT00ThTcvcIyr7zj/8YFMKCmeFlAb3Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPvSAazRH1aVBVZdoyyNiS66id//kGTfwdvTX8sYzKIDsO0HL45xehkKH/la1v5uC0zqgpMmYBPSb4vFka583DURgPubbhwcOYo4inPnDn1CVt1TFJ8hsekfJDBjRSoct5T0dEbfmizswpXZvRRMuJ5cPEWM5cfBcOmkZ86Fe5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgSsKvjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4A1C8B7A9;
	Mon, 26 Aug 2024 22:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724713108;
	bh=V7eWotD3RvBzT00ThTcvcIyr7zj/8YFMKCmeFlAb3Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mgSsKvjZ8R/BEvYhM5kS1OJe3YaSZQ/35krtGJpdlwRqloNuO3EudL4qKGVN/ay3t
	 D27MRZEAHyTVlD3V4AXJ6hcdhYX3zptrdUJWJSQ35qzVR5KWLQUydgded1RSFkM6lE
	 1r/wpCUI0UZpA5MRDKigumhrysgX+iavcb7hh/W4uiC4gJ/nUS/CkupgNBD2Hs/BpN
	 LUVe4KEr6tHoYMdBRkoqR7wxLqlN4JQ+w5v8ELnz8AJxmXxu13u8rRBq1hWsOWUDiL
	 g3vIzTZX8yq1Zf848QNQZ+wcFQ0bcKiE08Uor9PnSPuIcMOR/0yf2FmQrWzSi6Rj0p
	 GWvTULkjBhFWg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org,
	mingo@redhat.com
Cc: cgroups@vger.kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>,
	Josh Don <joshdon@google.com>,
	Hao Luo <haoluo@google.com>,
	Barret Rhoden <brho@google.com>
Subject: [PATCH 1/5] sched: Expose css_tg()
Date: Mon, 26 Aug 2024 12:57:39 -1000
Message-ID: <20240826225822.791578-2-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826225822.791578-1-tj@kernel.org>
References: <20240826225822.791578-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new BPF extensible sched_class will use css_tg() in the init and exit
paths to visit all task_groups by walking cgroups.

v4: __setscheduler_prio() is already exposed. Dropped from this patch.

v3: Dropped SCHED_CHANGE_BLOCK() as upstream is adding more generic cleanup
    mechanism.

v2: Expose SCHED_CHANGE_BLOCK() too and update the description.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c  | 5 -----
 kernel/sched/sched.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b0cec06bb1fa..a59ac9b11e3b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8957,11 +8957,6 @@ void sched_move_task(struct task_struct *tsk)
 	}
 }
 
-static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
-{
-	return css ? container_of(css, struct task_group, css) : NULL;
-}
-
 static struct cgroup_subsys_state *
 cpu_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2416b3866256..07333c545ddc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -515,6 +515,11 @@ static inline int walk_tg_tree(tg_visitor down, tg_visitor up, void *data)
 	return walk_tg_tree_from(&root_task_group, down, up, data);
 }
 
+static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct task_group, css) : NULL;
+}
+
 extern int tg_nop(struct task_group *tg, void *data);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.46.0


