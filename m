Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6C6D537A
	for <lists+cgroups@lfdr.de>; Sun, 13 Oct 2019 02:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbfJMAaf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Oct 2019 20:30:35 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:42102 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbfJMAaf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Oct 2019 20:30:35 -0400
Received: by mail-pf1-f201.google.com with SMTP id w16so10668279pfj.9
        for <cgroups@vger.kernel.org>; Sat, 12 Oct 2019 17:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bBrSpk5/lkb8AYsfeF62BNq9VWemrH+WCBAgVGWPGII=;
        b=hJsydjotiPKAHadLUhsMYb1DIvUHI/kTS4eMu9je11cjpNhoSeutvUQtrx/wKtlpnw
         KQ9qbPdjYSO8qTEwOaAYp1y+a9mT3vEPpNW/symkNk0FLP6a2K4IcbLuP/QgYmh8BbEr
         sJoWnep9Jx+LO8ugGxfDMv/HuEqGs785Fuc5e9crs1hhJPomjPhsIe2Dazo2zleIiBvT
         jUP+k489gBqIWZi1aR8iLR4OBNa0WGPAAWPJkMr7llHnVGZNphvewvTDllm3rB0rsRWp
         YLAq6vZwAdjwh8zxFMfiIL6O1Sh/wIOpnsMNoOHXEePop0Tqm3EoHuhpP+n1rH1sHCGk
         IwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bBrSpk5/lkb8AYsfeF62BNq9VWemrH+WCBAgVGWPGII=;
        b=D44Y2+BFlgS65HAvM4TnBJTWHoEWiuKVCennhwXKiYZKrFNJ8Q0Pr9EoTlgSvCaBUM
         fR3StzVeCvuclNXluyM6482Y6igAYNGLfHqOD4KVbREtnRHWNwcxu7vZxkJxsG9g9dlj
         0Hb1mWTVf0xhhkT0SiR5tLoS+e0G8JVSPoJUvBnxTScgePB8O8riYxKASBW3ejR85KSW
         44I2BuOkGn0esuxsQN2JTfOF1iG/d5drJ90xz16FH3gyB5eQsWLH80gTa/s8WrsgKYuu
         r4j6VfFRD9zKklWN7oYs3ak1kCIVeKs5gGy7227xjvnlMoxD3RBMVEpe4bx7j5uaQcMv
         l4Hg==
X-Gm-Message-State: APjAAAWdwup467UZNe1on8T/VvdMgbN4xNlYN6uvetAHG/BmmR3g3iOc
        l9Wnl7udyCOcKPiPe4hNJsmBLFSLRu4b1lLoZQ==
X-Google-Smtp-Source: APXvYqyIcSJcfujhRC7eYCwvl3F0kP+Cp+S3qVcoEFG/cktxKwguPX459Efupz3ruaGszXcEJTI3C/3AIufOhsvM5g==
X-Received: by 2002:a63:f247:: with SMTP id d7mr23278319pgk.300.1570926634315;
 Sat, 12 Oct 2019 17:30:34 -0700 (PDT)
Date:   Sat, 12 Oct 2019 17:30:18 -0700
In-Reply-To: <20191013003024.215429-1-almasrymina@google.com>
Message-Id: <20191013003024.215429-3-almasrymina@google.com>
Mime-Version: 1.0
References: <20191013003024.215429-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v6 3/9] hugetlb_cgroup: add cgroup-v2 support
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
2.23.0.700.g56cf767bdb-goog
