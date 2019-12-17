Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 253BF123AAB
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2019 00:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfLQXQq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Dec 2019 18:16:46 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:46604 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfLQXQc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Dec 2019 18:16:32 -0500
Received: by mail-pf1-f201.google.com with SMTP id w127so20141pfb.13
        for <cgroups@vger.kernel.org>; Tue, 17 Dec 2019 15:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LHDNmvrc03db/XEfSOqoyXXNGP5IsSpxrj4BzR3DnFo=;
        b=P7ONF3bSi1FcEgzi06X5WCLKiiqJSe8dB1TLNvBuQJUGgAxF/cTHl3USj8SWYkK7CU
         RiIULrsrZzRQocm+xiOsv+X+B350gtTIq6mHJXIAu2pu2yV3cC7lM7t0ngoOfhrX2odq
         vWzPlPPWzONXKqSbb5wAFSrWehqaQtf9ElhAzgNItRhaqkPSRoXARql+KU4mQxqUjAYH
         9flccmhgzpS613FCmu2ORYmtPsopWY13qVTTdlB5eItp8bQP9nfWoTEkstg0SEa+QqVT
         uRsku5nKBqGAbBT17asr8gYJDMAQhFvIIwA1p5Kjm77M4EqP/2TNYvxEsvMVpNjg1w/m
         trXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LHDNmvrc03db/XEfSOqoyXXNGP5IsSpxrj4BzR3DnFo=;
        b=K3QE0FPMPiUdJVM5/gyVaCrdOirpRsaVjg3bWFnC9RkJ3Ju+EhqBmhWRkEeIi3iQIs
         b9VoMA2GohPAjTCWyCbm13uwXq05tv+EBzW4fmL65+ei1c086uOJ1V1a7kkIeTYBfWQa
         IDu2Azgteqdh2ETDL/g/QQ4rq0BtvtrilYcAZMPo8Jwd3LDt0SzXivmaYlEH27WeMqR6
         tUvvwfYqThvzHlXx0EK/mencg731FeaYBztN77hjJi0Y4uqhg0cjQBoqUiM089lXTCdc
         hnpfWB3jgzuS5i13uU4jxvdN6cEW9UzviirGbA8ez1rquyI2zX3YG6OXO3paUxv5AZU6
         btmg==
X-Gm-Message-State: APjAAAWNbHNEieF11Zi4cfBXWOxF7b0jPMHzxsxXBWTZMAON2LRkqqXb
        KDsGDvNd9a7pXR154SD5G5syYluUiJFyrXjVjA==
X-Google-Smtp-Source: APXvYqzQi/hTceVwH7B1vYFKo1hz5bRcGyNSFOmySOjm1oxr360S5O4JugN1EbS/KgVOxO0UVcreeR63ykX4ksyJag==
X-Received: by 2002:a63:646:: with SMTP id 67mr435341pgg.150.1576624591531;
 Tue, 17 Dec 2019 15:16:31 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:16:13 -0800
In-Reply-To: <20191217231615.164161-1-almasrymina@google.com>
Message-Id: <20191217231615.164161-6-almasrymina@google.com>
Mime-Version: 1.0
References: <20191217231615.164161-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v9 6/8] hugetlb_cgroup: support noreserve mappings
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Support MAP_NORESERVE accounting as part of the new counter.

For each hugepage allocation, at allocation time we check if there is
a reservation for this allocation or not. If there is a reservation for
this allocation, then this allocation was charged at reservation time,
and we don't re-account it. If there is no reserevation for this
allocation, we charge the appropriate hugetlb_cgroup.

The hugetlb_cgroup to uncharge for this allocation is stored in
page[3].private. We use new APIs added in an earlier patch to set this
pointer.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 mm/hugetlb.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 39eb2fa53a420..3e94f5c2d7cd4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1367,6 +1367,9 @@ void free_huge_page(struct page *page)
 	clear_page_huge_active(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
 				     page, false);
+	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
+				     page, true);
+
 	if (restore_reserve)
 		h->resv_huge_pages++;

@@ -2189,10 +2192,19 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			gbl_chg = 1;
 	}

+	/* If this allocation is not consuming a reservation, charge it now.
+	 */
+	if (map_chg || avoid_reserve || !vma_resv_map(vma)) {
+		ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h),
+						   &h_cg, true);
+		if (ret)
+			goto out_subpool_put;
+	}
+
 	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg,
 					   false);
 	if (ret)
-		goto out_subpool_put;
+		goto out_uncharge_cgroup_reservation;

 	spin_lock(&hugetlb_lock);
 	/*
@@ -2216,6 +2228,14 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	}
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page,
 				     false);
+	/* If allocation is not consuming a reservation, also store the
+	 * hugetlb_cgroup pointer on the page.
+	 */
+	if (!vma_resv_map(vma) || map_chg || avoid_reserve) {
+		hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg,
+					     page, true);
+	}
+
 	spin_unlock(&hugetlb_lock);

 	set_page_private(page, (unsigned long)spool);
@@ -2241,6 +2261,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg,
 				       false);
+out_uncharge_cgroup_reservation:
+	if (map_chg || avoid_reserve || !vma_resv_map(vma))
+		hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h),
+					       h_cg, true);
 out_subpool_put:
 	if (map_chg || avoid_reserve)
 		hugepage_subpool_put_pages(spool, 1);
--
2.24.1.735.g03f4e72817-goog
