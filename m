Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E360713B6CF
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2020 02:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgAOB1H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Jan 2020 20:27:07 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:41536 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgAOB1H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Jan 2020 20:27:07 -0500
Received: by mail-pg1-f201.google.com with SMTP id r30so9436155pgm.8
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2020 17:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+hDgtcJ/OAWe9zIJj2uUM/Qj+y1M7vqqOqi2MY740cw=;
        b=SbEo5zBpBq30EMJ5WGTJdUleiraqh7pRa2Nw0a4bsfHNDUmiBRMRcceqj5vgsp+yZD
         zA15qcUMkkqs0G0mlULqVgoPx8f6lINvEm/HUSYSvsASmziRYje1qMrSXwmErtDz2Bon
         ryd41KYz/6mj3AI2ESiO0S1m7FKOKJ0uP1mWiSBLxILSDpqupMzcecid/pl+I/2FMEBV
         BGJRAG0xlusuZ66v01XbYj+nn1YuYpw7QeNfBjSRZTV6hRnBYGFnFZzyXFp/XCy7SrX1
         n+QZNB7SfXv9qStndFXqL7ojGlE9+1hkKxpS9zTRIp7b3i4VOp5qe8J+VekK5NT3ycMn
         16RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+hDgtcJ/OAWe9zIJj2uUM/Qj+y1M7vqqOqi2MY740cw=;
        b=ngXOrWspA7T9xsD/aSfrpnrZz2tQNRr9yJh1id2Xx77fQ85lW2Z4vsuBNONTXAi0Cq
         Wsrv5OCtE6tcSNXALcOwVMRA3PI2B3EYj4US480C5Wy0pjmH9NhkDhJZsTz/g6dk43TE
         ubUlIh0kIihMv+xtQ7JLK4E+cuvqhpYrCXaK+DcnN+xlS3WxY82k2pe83ZMdgURfhAFZ
         S5Q0+g9q4dAw8t0iVt/RL3dtDyLTYJZCV1ao4t/IWI/hH2alzIJUPd8HyBvLBynq7oqh
         xxblzbqrRPDC6RTRIVKe4tyCxaP41GfqVPalebxLUkZpeNNFUUSTf0JidoRb307zEWx4
         VPug==
X-Gm-Message-State: APjAAAU1mmx6HvGh6ep4kNm/3Anyo9+euwrxu+gXc6zcoPql+RWGQVQS
        v9pwBaH19uzMmDptNIixi4pjo4U9GdGMHncdZQ==
X-Google-Smtp-Source: APXvYqyyjl2zNq7/Fihix9iuEtq3Q06GE1o8i8KAInm5+9bDeWN7QRw6hAI7tkCO4X/1w9M2HxbiSoxA5H5cI3IpCQ==
X-Received: by 2002:a65:4142:: with SMTP id x2mr29535809pgp.393.1579051626821;
 Tue, 14 Jan 2020 17:27:06 -0800 (PST)
Date:   Tue, 14 Jan 2020 17:26:49 -0800
In-Reply-To: <20200115012651.228058-1-almasrymina@google.com>
Message-Id: <20200115012651.228058-6-almasrymina@google.com>
Mime-Version: 1.0
References: <20200115012651.228058-1-almasrymina@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v10 6/8] hugetlb_cgroup: support noreserve mappings
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com, rientjes@google.com, shakeelb@google.com
Cc:     shuah@kernel.org, almasrymina@google.com, gthelen@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com
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

Changes in v10:
- Refactored deferred_reserve check.

---
 mm/hugetlb.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9bcfc12c5d214..d3f107626f927 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1374,6 +1374,9 @@ static void __free_huge_page(struct page *page)
 	clear_page_huge_active(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
 				     page, false);
+	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
+				     page, true);
+
 	if (restore_reserve)
 		h->resv_huge_pages++;

@@ -2207,6 +2210,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	long gbl_chg;
 	int ret, idx;
 	struct hugetlb_cgroup *h_cg;
+	bool deferred_reserve;

 	idx = hstate_index(h);
 	/*
@@ -2244,10 +2248,20 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			gbl_chg = 1;
 	}

+	/* If this allocation is not consuming a reservation, charge it now.
+	 */
+	deferred_reserve = map_chg || avoid_reserve || !vma_resv_map(vma);
+	if (deferred_reserve) {
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
@@ -2271,6 +2285,14 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	}
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page,
 				     false);
+	/* If allocation is not consuming a reservation, also store the
+	 * hugetlb_cgroup pointer on the page.
+	 */
+	if (deferred_reserve) {
+		hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg,
+					     page, true);
+	}
+
 	spin_unlock(&hugetlb_lock);

 	set_page_private(page, (unsigned long)spool);
@@ -2296,6 +2318,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg,
 				       false);
+out_uncharge_cgroup_reservation:
+	if (deferred_reserve)
+		hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h),
+					       h_cg, true);
 out_subpool_put:
 	if (map_chg || avoid_reserve)
 		hugepage_subpool_put_pages(spool, 1);
--
2.25.0.rc1.283.g88dfdc4193-goog
