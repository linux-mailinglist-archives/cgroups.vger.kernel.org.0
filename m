Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6179D159B2D
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2020 22:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgBKVcA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Feb 2020 16:32:00 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:51265 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgBKVb7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Feb 2020 16:31:59 -0500
Received: by mail-pf1-f201.google.com with SMTP id z19so12734pfn.18
        for <cgroups@vger.kernel.org>; Tue, 11 Feb 2020 13:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bX7NhEua2ERlz39Th9iBgSOUAYmxb/RK4PMlnkgxhw4=;
        b=BtgkPLXMThgu/syUKS8v1hUUBJzr5rr4sugkb9U9SmG8EucdUE3NmJbmN7UD6vglUU
         qDnC1J5nk/4LnxTOic1kCFOOGFJJRZ9V/O/kuWTyaiwnYfI3oObcxuAI04Fv/jq+WuEf
         Y6jvrEVvln+iEZM9lw3JUOpeFGyc+vVRpXSXva72q5J5WDe2JF3XPDxM+U6mXMReiu1D
         3n3fys+4aVKQKjoxjbpRbekY39o1sq+Gpb4CeLpVUdJHbfLd9CbY76o22Dpp3UGfd7aY
         CasIqzzCJj3ozmFDqINalnmQdPE1mexaVaklhVzoGmJA5x1NJsd0K69Sck/ut/8djAFQ
         MHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bX7NhEua2ERlz39Th9iBgSOUAYmxb/RK4PMlnkgxhw4=;
        b=BcaDLIZiw34YLtqh8f/4sRbOf9H4ZK03iopJywDJ03/GSvYp3Be5HXb3BUOsIYLvim
         HhhAY7bQLFp0lkbMfR0LBAirvxPW4CadRRLerCcyYuVl2FXvxdOQ6IE9GQjUA/qX0qBm
         EXw6x55JQXVdgCRXktWydwGUXkhcW/O4gPnvgLXAcgeID5hZq6K4YWsyhz9GaBg4Actr
         Nep487n+kYPW9P5lqadkwUE0qBvWRfnT37vV98Q9lKRyQHAmvDtgE+B3JmeWg65QY/CZ
         YMQ1f6DCLW/ICMveNSyzhAGRCvPY+jav/XsuvG4kkPyksEYZ4lOaVg2+8hLHM+rkUDnv
         K2Hg==
X-Gm-Message-State: APjAAAU1X0+DbbCljxL0B3UudZb8ecP8N2/QIASOttl+xEsXjDZyuTrZ
        OnkPScUSdFlEMm7HPVdyWfFvsFOOC7o02sZWrQ==
X-Google-Smtp-Source: APXvYqx0QPMNZu65+W4/JoT3ENr3G6zoSw5leGNsERt3DujmNIf57u3bpNm6BKn3IwAszRlwDO81dHDN9qXxBtx6IQ==
X-Received: by 2002:a63:ed49:: with SMTP id m9mr8752932pgk.304.1581456718652;
 Tue, 11 Feb 2020 13:31:58 -0800 (PST)
Date:   Tue, 11 Feb 2020 13:31:25 -0800
In-Reply-To: <20200211213128.73302-1-almasrymina@google.com>
Message-Id: <20200211213128.73302-6-almasrymina@google.com>
Mime-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v12 6/9] hugetlb_cgroup: support noreserve mappings
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
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

Changes in v12:
- Minor rebase to new interface for readability.

Changes in v10:
- Refactored deferred_reserve check.

---
 mm/hugetlb.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a9171c3cbed6b..2d62dd35399db 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1342,6 +1342,8 @@ static void __free_huge_page(struct page *page)
 	clear_page_huge_active(page);
 	hugetlb_cgroup_uncharge_page(hstate_index(h),
 				     pages_per_huge_page(h), page);
+	hugetlb_cgroup_uncharge_page_rsvd(hstate_index(h),
+					  pages_per_huge_page(h), page);
 	if (restore_reserve)
 		h->resv_huge_pages++;

@@ -2175,6 +2177,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 	long gbl_chg;
 	int ret, idx;
 	struct hugetlb_cgroup *h_cg;
+	bool deferred_reserve;

 	idx = hstate_index(h);
 	/*
@@ -2212,9 +2215,19 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 			gbl_chg = 1;
 	}

+	/* If this allocation is not consuming a reservation, charge it now.
+	 */
+	deferred_reserve = map_chg || avoid_reserve || !vma_resv_map(vma);
+	if (deferred_reserve) {
+		ret = hugetlb_cgroup_charge_cgroup_rsvd(
+			idx, pages_per_huge_page(h), &h_cg);
+		if (ret)
+			goto out_subpool_put;
+	}
+
 	ret = hugetlb_cgroup_charge_cgroup(idx, pages_per_huge_page(h), &h_cg);
 	if (ret)
-		goto out_subpool_put;
+		goto out_uncharge_cgroup_reservation;

 	spin_lock(&hugetlb_lock);
 	/*
@@ -2237,6 +2250,14 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
 		/* Fall through */
 	}
 	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
+	/* If allocation is not consuming a reservation, also store the
+	 * hugetlb_cgroup pointer on the page.
+	 */
+	if (deferred_reserve) {
+		hugetlb_cgroup_commit_charge_rsvd(idx, pages_per_huge_page(h),
+						  h_cg, page);
+	}
+
 	spin_unlock(&hugetlb_lock);

 	set_page_private(page, (unsigned long)spool);
@@ -2261,6 +2282,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,

 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup(idx, pages_per_huge_page(h), h_cg);
+out_uncharge_cgroup_reservation:
+	if (deferred_reserve)
+		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
+						    h_cg);
 out_subpool_put:
 	if (map_chg || avoid_reserve)
 		hugepage_subpool_put_pages(spool, 1);
--
2.25.0.225.g125e21ebc7-goog
