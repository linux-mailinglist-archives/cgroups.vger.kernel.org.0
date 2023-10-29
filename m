Return-Path: <cgroups+bounces-104-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0DD7DAB10
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 07:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E48B20DFC
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 06:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A616107;
	Sun, 29 Oct 2023 06:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4lzu45R"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1A4441F;
	Sun, 29 Oct 2023 06:14:50 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E9CD9;
	Sat, 28 Oct 2023 23:14:48 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b2ec9a79bdso2464553b6e.3;
        Sat, 28 Oct 2023 23:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698560087; x=1699164887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZ8I0hc4htgXjz6UnkXw7mUnO4qqNaJY7OsjOdR55Pc=;
        b=K4lzu45RNJKG90G6AaOMwpWGo5MDuiMFaFDi4fpUGAe79k5NqIPMsT7FdjXZrMgZ2I
         wR0xkt07YO7+nf0ZiouF6RX149M2Cxvt0KqjYUEcGkgov86L1RG07MWBDjT/V2fx1VtU
         BPvUoEq6E7lkbS07/5qyb/ONHSR28fgA2hsIUJJvat+1l+a6ixnTccmeLZ3DUEYLMAtj
         6ZPgX842aSF+iAjpqJ6OZFqcP98ycFeylXmLaeRACChENgsJJxWYfCSHhlx+CG0LRjeq
         4d7yKU6CpL8fDswfkyXDLsbpQMjlXrqvdxNcngIIOiwwP6ZrmYvsbJIwLh/McrR99v47
         Fmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698560087; x=1699164887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZ8I0hc4htgXjz6UnkXw7mUnO4qqNaJY7OsjOdR55Pc=;
        b=Cf7j8CAA3PsggIP+0tetOGGdtVB2dya6uTAJ9b5WppRABCse4YeUpokXMKm7hIAzWW
         GUyR4NksLKFZrk4YST22ukIb/Xozu6YXmY4XbiAqLjafVecm7ty9dwHRqWX9gmKs5rTG
         m81wgQaz/NSaxBkoncTEqeMiBV3R77GDY/jsPn1i62vT+JSAkPzga5Da0pQkGMnyB/v7
         0Tyjttm28WwEGd6jdqUqSv9Es6151u3suLbWSug3SbwGIkNOqKZi76MsOq5wQun/8Onj
         VHB9yPuhUCgnZ8jqpOdw3JWKIPPbs5ZQxbOAbj34YR34AjItOjEA/sPs0TNwtdpiskin
         okUg==
X-Gm-Message-State: AOJu0YyqIa+EFLfvJ+5ii+ZCDVdS9VuBXpKpHl459XvOlt2T0Xcq0Xfq
	WiffI0/dgLK/6+ABHaLV6OU=
X-Google-Smtp-Source: AGHT+IEah1CjvGyiroJr6UiA/GDjGCwuMJvXEEfFL+qEYMkQCElKojth+1devgY9jRtHZJAvDORq0Q==
X-Received: by 2002:a05:6808:a10:b0:3a7:3988:87ee with SMTP id n16-20020a0568080a1000b003a7398887eemr7207263oij.58.1698560087274;
        Sat, 28 Oct 2023 23:14:47 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:2b5:5400:4ff:fea0:d066])
        by smtp.gmail.com with ESMTPSA id m2-20020aa79002000000b006b225011ee5sm3775106pfo.6.2023.10.28.23.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 23:14:46 -0700 (PDT)
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
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	mkoutny@suse.com,
	sinquersw@gmail.com,
	longman@redhat.com
Cc: cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	oliver.sang@intel.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 bpf-next 01/11] cgroup: Remove unnecessary list_empty()
Date: Sun, 29 Oct 2023 06:14:28 +0000
Message-Id: <20231029061438.4215-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231029061438.4215-1-laoar.shao@gmail.com>
References: <20231029061438.4215-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The root hasn't been removed from the root_list, so the list can't be NULL.
However, if it had been removed, attempting to destroy it once more is not
possible. Let's replace this with WARN_ON_ONCE() for clarity.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/cgroup/cgroup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1fb7f56..3053d42 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1345,10 +1345,9 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 
 	spin_unlock_irq(&css_set_lock);
 
-	if (!list_empty(&root->root_list)) {
-		list_del(&root->root_list);
-		cgroup_root_count--;
-	}
+	WARN_ON_ONCE(list_empty(&root->root_list));
+	list_del(&root->root_list);
+	cgroup_root_count--;
 
 	cgroup_favor_dynmods(root, false);
 	cgroup_exit_root_id(root);
-- 
1.8.3.1


