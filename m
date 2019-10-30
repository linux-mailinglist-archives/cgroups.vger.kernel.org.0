Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31827E94AA
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2019 02:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfJ3BhM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Oct 2019 21:37:12 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:33220 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfJ3BhL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Oct 2019 21:37:11 -0400
Received: by mail-pg1-f202.google.com with SMTP id b71so435826pga.0
        for <cgroups@vger.kernel.org>; Tue, 29 Oct 2019 18:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1GwmRjPs7u0T+r1yllJwr/PMM5pTo/W+dyBkrzs0XUw=;
        b=jd1r6Jia7s590891AgR3YYy9CElt7HWAUKHltf6wi81ngafwOYcF4N8Uwe/4zvW4MC
         IMk4k0LW1lf0/UGSclUObeuq/p3apoMtj4dOo8LZ3krCjiaET5tiZ+YTnO+UGNjAvSOU
         3uPmacYgwbx/u60ZQlS4vRPN7KP3sK5/3zhAaRK4S6ZiIGEaO386M6CIjj7hD/z+xln8
         HF2EafhhgD6PSHLKNb79leD5RoJeH0xD4HAkHOC0Jqf/o5pz89syAuvF2WHT8Rl719BR
         FB8AjMvuGbVf+5f9/Il7sZ4FoNHE4N3M8imjilODvpfBX+iUx1KthnL6nANbputXXdpz
         jDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1GwmRjPs7u0T+r1yllJwr/PMM5pTo/W+dyBkrzs0XUw=;
        b=m2PAQXo+bzo2p/RRvBhZypEXPQ83+Xrg+Bpx5kkBugjjkL0kkgqnHbwHWsQKxHedeg
         WUajxEnHgzwsDFCNcadUEJYqV5hWaFS9igkbxmnqatswmHv9GLulKmpinjSVwYxz6UT8
         9OQfBwhT0v08wvDnCzSNoTUblVSZ9N2qDre9HtdtFdcvOxcZS/cYvG+CZIcG8iZ8A4t2
         HeZvUWkppmGtFAL0pX4fZtnwUfIwVN6PwNOxjJh732fKCbOf9j535gRzhT4TVDufw7aa
         JCFOE6WZ1im2+GYShz3aIJ4jhXmCrQlNO3MxBFuVGTlY1S5J++jkMGoW/lmzu/nFzkVH
         T9Ew==
X-Gm-Message-State: APjAAAWWbCF/+VrxRZE79qHTLOMM5Lr77CX73TT19IdPNiyEWIcbcSE/
        FoPcfZZXFB3aSgHe2j3u0tTDnSV+OvqViRfxwA==
X-Google-Smtp-Source: APXvYqy5iRRg5lqLW+5p9To2eAmeb2Xf7UHuM6BnVVpJsLYBnHW/AKwKhjiHnjRbKz471jGpAgMaW5gqHyyKSSazNQ==
X-Received: by 2002:a63:f48:: with SMTP id 8mr8383246pgp.329.1572399430538;
 Tue, 29 Oct 2019 18:37:10 -0700 (PDT)
Date:   Tue, 29 Oct 2019 18:36:55 -0700
In-Reply-To: <20191030013701.39647-1-almasrymina@google.com>
Message-Id: <20191030013701.39647-3-almasrymina@google.com>
Mime-Version: 1.0
References: <20191030013701.39647-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v8 3/9] hugetlb_cgroup: add cgroup-v2 support
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Signed-off-by: Mina Almasry <almasrymina@google.com>

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
2.24.0.rc1.363.gb1bccd3e3d-goog
