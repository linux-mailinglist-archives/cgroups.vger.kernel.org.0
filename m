Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C91BAE3D48
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2019 22:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfJXU31 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Oct 2019 16:29:27 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:42570 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfJXU3Z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Oct 2019 16:29:25 -0400
Received: by mail-pg1-f201.google.com with SMTP id x203so12609874pgx.9
        for <cgroups@vger.kernel.org>; Thu, 24 Oct 2019 13:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CY1SErJX00acWObUhsBSXFRXX6IflpSHZNkrAmXXrxE=;
        b=YjjU9+3kRuzqEnDF0lHEdI+lMEq/b6/LbphlLr8wHsnojuFpkmXbGoNuyndDhuvoIk
         9aPUUZ+8WRZQe9M/d+ab65zEm+xV34DmZN9Yv9896/nb/VxJEAkGfVOVKO+s86d8lbgu
         7ybynVdq/IplG7KBOw/0ViWe9VXKKe5jNTHwew6vbs1Y2AHtC9BEog7MUTekM2xPx+co
         RIW/XGHJ/2+FEEs70mOhYdi35FWPWWDBQnh9Gk5fp3J0GMvujjRgpyTexjB55ijqDqno
         bK5YlRUpsaHVfiGD95mnwxnBjbjYo+tmgbEIoN96SXGU9ETDDhwGkCOUbzn9Z7H+dvOs
         5D4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CY1SErJX00acWObUhsBSXFRXX6IflpSHZNkrAmXXrxE=;
        b=ivUt1ONCVFBJGE3qIaBJSoKLbyrBzYGv6DbIMaOFebYL1foKVMZxGoB5BLZ7OXHnjy
         5hRJqWgXy3YTXjAn2LCbLpipqYJxQ46SJixCI4OJKz+YO8L9aeSx8f3OSzkzpUKj4Api
         RRYRVU8bM7G9OXgSkW+QznT2IpqWFJtotRGI8TeSKIFvRjOjG/P9937RC83jG5dm1f3i
         kWeha/JxX5UHtDX/y6p4Nu06FFt/HyuhBL8H+ZSX3sTcUdoabmRDbyAjJ1AJpKq42WNA
         XDr9YKArl4dRTAx2rufqC2wo2PMswpyDF7/HsIzO1L4Uq35s7EGQMCTO56gizhC/JDFh
         x7pA==
X-Gm-Message-State: APjAAAVzPggiajzanL1/+zKwwkLfHIIzh8D2ZuI3UOWS2WUPns/3lgAO
        NYd1NxnFBXRQnOnX+wd2kJppFKFIQdiEOjF6gQ==
X-Google-Smtp-Source: APXvYqzg6h2xjNbEkJ/s193lqIa08ssOYMh8AgBOCD0SF5L3y22RXE3QioF3xPh850uAcVV8DfeopsmuVLQ0sSb0jQ==
X-Received: by 2002:a63:fb4f:: with SMTP id w15mr11117978pgj.403.1571948964078;
 Thu, 24 Oct 2019 13:29:24 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:28:56 -0700
In-Reply-To: <20191024202858.95342-1-almasrymina@google.com>
Message-Id: <20191024202858.95342-7-almasrymina@google.com>
Mime-Version: 1.0
References: <20191024202858.95342-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v7 7/9] hugetlb_cgroup: support noreserve mappings
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

Support MAP_NORESERVE accounting as part of the new counter.

For each hugepage allocation, at allocation time we check if there is
a reservation for this allocation or not. If there is a reservation for
this allocation, then this allocation was charged at reservation time,
and we don't re-account it. If there is no reserevation for this
allocation, we charge the appropriate hugetlb_cgroup.

The hugetlb_cgroup to uncharge for this allocation is stored in
page[3].private. We use new APIs added in an earlier patch to set this
pointer.

---
 mm/hugetlb.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cef15e68626bd..7715018a0af22 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1253,6 +1253,7 @@ static void update_and_free_page(struct hstate *h, struct page *page)
 				1 << PG_writeback);
 	}
 	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page, false), page);
+	VM_BUG_ON_PAGE(hugetlb_cgroup_from_page(page, true), page);
 	set_compound_page_dtor(page, NULL_COMPOUND_DTOR);
 	set_page_refcounted(page);
 	if (hstate_is_gigantic(h)) {
@@ -1364,6 +1365,9 @@ void free_huge_page(struct page *page)
 	clear_page_huge_active(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
 				     page, false);
+	hugetlb_cgroup_uncharge_page(hstate_index(h), pages_per_huge_page(h),
+				     page, true);
+
 	if (restore_reserve)
 		h->resv_huge_pages++;

@@ -1390,6 +1394,7 @@ static void prep_new_huge_page(struct hstate *h, struct page *page, int nid)
 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
 	spin_lock(&hugetlb_lock);
 	set_hugetlb_cgroup(page, NULL, false);
+	set_hugetlb_cgroup(page, NULL, true);
 	h->nr_huge_pages++;
 	h->nr_huge_pages_node[nid]++;
 	spin_unlock(&hugetlb_lock);
@@ -2195,10 +2200,19 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
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
@@ -2222,6 +2236,11 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	}
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page,
 				     false);
+	if (!vma_resv_map(vma) || map_chg || avoid_reserve) {
+		hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg,
+					     page, true);
+	}
+
 	spin_unlock(&hugetlb_lock);

 	set_page_private(page, (unsigned long)spool);
@@ -2247,6 +2266,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
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
2.24.0.rc0.303.g954a862665-goog
