Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 734BBE3D55
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2019 22:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfJXU3p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Oct 2019 16:29:45 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:39397 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbfJXU3O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Oct 2019 16:29:14 -0400
Received: by mail-qt1-f202.google.com with SMTP id f15so26254853qth.6
        for <cgroups@vger.kernel.org>; Thu, 24 Oct 2019 13:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OTTgP/4rSMZq1YQryUiCckFA0Or1XPmBCQJjGhG/4Xo=;
        b=k+KQK1yVgr8ftCY21WnHwRy8s7u2DAecuwJppewUUySA6SAvk6D0TqMKRNnRAQIxAe
         koa/CpSG/tMqlcpF0TwQT3hvEfx3jFSpMcNrp8mXRKclZVYizJldrdCOqmRKc5wHnIMY
         WDceg4mifhX2pxAPYV++HQnr/zH4VGfVOaZQNy/dvkawRHLD4jRCpG5aIwT5NBxX5D7F
         SCJxRdQwJdpTwP0ZJUUedSNcOAMRAsRTUO9yko1ejSRBbrwa5zZteMMvixSReRioOhPB
         1B70iyeoARY9KcnjukFGO5frbxtkbCJo0W/vyGeQNZSatoWWipT8f1b6/BTh9PQkxnlF
         LeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OTTgP/4rSMZq1YQryUiCckFA0Or1XPmBCQJjGhG/4Xo=;
        b=BsC4Fgqwk67TDnVHcn8EnZygv7QmAa387Adb7gLWhpYESwlSrE1xUdHHZ1FyeoMEVA
         hK0PGqsZDRnKt3QBpHamR11ADHZnkTUU9dAN74P2ZTd52+7YyxjwQZM2Yptll/neudjN
         JsQV/f9HZ7E6vXp5uT7lmzMUZRRS+khwN5WNCiuVJBfjmwEZkXq4HIp9K0dBaEw7LM6y
         y/FtPz5pnRjY382F6wsL06V1kmkTGgPtdD6VDfCikmb0PYcuU8dXGxV9C5Aayt+IaCdu
         Wh3fM+fANwBQR+GeN8jy3TCgKVQObcGlffmL3d9KubCe3+9PL4ojW4HvhZpaN+LJzhNM
         4Ygw==
X-Gm-Message-State: APjAAAXqXC33XxvhnfR/AfVOyeFN3Hhu+O/DZ7fIbqpFxFSb3uN3RNps
        Avo4s7MbuNriEO2sLuW6thnDcGD/Ap+Cf3xRQg==
X-Google-Smtp-Source: APXvYqykmweDy/QLQPkGWizAYNIBL+BlX3Ygpu2mWSwRIj83jVjwajIZ8NVAcpVzBNG7dhIbfZW7dElSf1O2aNJ7vA==
X-Received: by 2002:a05:6214:1427:: with SMTP id o7mr4095977qvx.83.1571948953537;
 Thu, 24 Oct 2019 13:29:13 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:28:52 -0700
In-Reply-To: <20191024202858.95342-1-almasrymina@google.com>
Message-Id: <20191024202858.95342-3-almasrymina@google.com>
Mime-Version: 1.0
References: <20191024202858.95342-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v7 3/9] hugetlb_cgroup: add cgroup-v2 support
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

---
 mm/hugetlb_cgroup.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 854117513979b..ac1500205faf7 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -503,8 +503,13 @@ static void __init __hugetlb_cgroup_file_init(int idx)
 	cft = &h->cgroup_files[HUGETLB_RES_NULL];
 	memset(cft, 0, sizeof(*cft));

-	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
-					  h->cgroup_files));
+	if (cgroup_subsys_on_dfl(hugetlb_cgrp_subsys)) {
+		WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
+					       h->cgroup_files));
+	} else {
+		WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
+						  h->cgroup_files));
+	}
 }

 void __init hugetlb_cgroup_file_init(void)
@@ -548,8 +553,14 @@ void hugetlb_cgroup_migrate(struct page *oldhpage, struct page *newhpage)
 	return;
 }

+static struct cftype hugetlb_files[] = {
+	{} /* terminate */
+};
+
 struct cgroup_subsys hugetlb_cgrp_subsys = {
 	.css_alloc	= hugetlb_cgroup_css_alloc,
 	.css_offline	= hugetlb_cgroup_css_offline,
 	.css_free	= hugetlb_cgroup_css_free,
+	.dfl_cftypes = hugetlb_files,
+	.legacy_cftypes = hugetlb_files,
 };
--
2.24.0.rc0.303.g954a862665-goog
