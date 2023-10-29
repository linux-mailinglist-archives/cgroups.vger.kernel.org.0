Return-Path: <cgroups+bounces-107-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E477DAB16
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 07:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695702816E0
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 06:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9B16AAB;
	Sun, 29 Oct 2023 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL+yn1Qu"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E2A6AA0;
	Sun, 29 Oct 2023 06:14:54 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E2BD3;
	Sat, 28 Oct 2023 23:14:53 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b89ab5ddb7so3459692b3a.0;
        Sat, 28 Oct 2023 23:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698560093; x=1699164893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67CBbtnv19SbltoBUAc4Ce8xxrA/4bdASUdtuBTZWyI=;
        b=CL+yn1QuuZnJPUQwP301GY1rnwJr95ptw4OToYGfgKtNDWkyrToGH7a68Yt5aWx7UV
         Aez0f49xEcdYKj6S2rEtb0U/CvcAZXn1g4dfdcjCLVyvKeH2xmV2k19/k6yHKwr8yqQQ
         QVwGqIQkACaSEIQN4MBI4sC4Jk2sW6Sq5Zdz/QrczFYO7B1K02BVWyMpgoewEdSfK3w+
         mO2H77MsnDWA+FpT5fdo3ebXbue1vGV4u20NtMxcJpxIoF3CltyBWzf6QAeUnHNn+Ekx
         MOiXaI7Jg2YAyXCaGf8Aab9NVdFhhOczYevibnNsu2MuxUOHT42bu5Ekgoyml281p2i+
         fKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698560093; x=1699164893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67CBbtnv19SbltoBUAc4Ce8xxrA/4bdASUdtuBTZWyI=;
        b=sY6FH7r6uI+rc1EVgFnrAWyGRj0zhwKApxKzfZIvpGc0IIuf5hDJYHAjHpfslqw1/t
         mj+gDzHst6Vi6oXSZM9t8YM5h34OjYPpESZqp1cOuM1GeuVX7wmJg12rlcnO61dsRsyf
         sV6T7u/C5TPH4m48SDlXZdD1PMSOzeJmcm1QQgomG18lya+O1y7obSlyLnXql70r2iZR
         mFVvrOOSXX75LAGE8ko0Hzjo01p06HwPbUghGzLXZFPJG3WP7srCsBs5VPDGq6fTVz1x
         GsUZQzDzSu3lWD03MkvKi5caOt8D5YdjNkdOBGw9/ksWd4QdsVqpl+SDaFbG83HprmNL
         FN6g==
X-Gm-Message-State: AOJu0YwMr9Ks2eXt0jhat/AC4jpTpBLGWV0P/b/5dGZsR26PnhfRSjjG
	dnR/nvv60KY0nc4K0i10rEw=
X-Google-Smtp-Source: AGHT+IFra60Chv7uZYrOX/X1RyhBNyyBW8pmQw6YT0y8Hbn4ygPnrOkdLNGyIXQHWLnhOOAx+12cJw==
X-Received: by 2002:a05:6a00:1143:b0:6b2:69c:346a with SMTP id b3-20020a056a00114300b006b2069c346amr7632922pfm.19.1698560092632;
        Sat, 28 Oct 2023 23:14:52 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:2b5:5400:4ff:fea0:d066])
        by smtp.gmail.com with ESMTPSA id m2-20020aa79002000000b006b225011ee5sm3775106pfo.6.2023.10.28.23.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 23:14:52 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 04/11] cgroup: Add annotation for holding namespace_sem in current_cgns_cgroup_from_root()
Date: Sun, 29 Oct 2023 06:14:31 +0000
Message-Id: <20231029061438.4215-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231029061438.4215-1-laoar.shao@gmail.com>
References: <20231029061438.4215-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When I initially examined the function current_cgns_cgroup_from_root(), I
was perplexed by its lack of holding cgroup_mutex. However, after Michal
explained the reason[0] to me, I realized that it already holds the
namespace_sem. I believe this intricacy could also confuse others, so it
would be advisable to include an annotation for clarification.

After we replace the cgroup_mutex with RCU read lock, if current doesn't
hold the namespace_sem, the root cgroup will be NULL. So let's add a
WARN_ON_ONCE() for it.

[0]. https://lore.kernel.org/bpf/afdnpo3jz2ic2ampud7swd6so5carkilts2mkygcaw67vbw6yh@5b5mncf7qyet

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index cc6a6d9..baba4b1 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1416,6 +1416,11 @@ static inline struct cgroup *__cset_cgroup_from_root(struct css_set *cset,
 
 	rcu_read_unlock();
 
+	/*
+	 * The namespace_sem is held by current, so the root cgroup can't
+	 * be umounted. Therefore, we can ensure that the res is non-NULL.
+	 */
+	WARN_ON_ONCE(!res);
 	return res;
 }
 
-- 
1.8.3.1


