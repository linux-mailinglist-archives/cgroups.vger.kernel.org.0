Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50199E3D4B
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2019 22:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfJXU3b (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Oct 2019 16:29:31 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:40450 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfJXU3b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Oct 2019 16:29:31 -0400
Received: by mail-qk1-f201.google.com with SMTP id m189so34669qkc.7
        for <cgroups@vger.kernel.org>; Thu, 24 Oct 2019 13:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=crbVUKdb6+CmoQ+3cFtG2k0oh3fF8DozMebl0jMBYx4=;
        b=wWEpw+8DEEwTZRVN5PFHqCucuAvbZ2zTtNVo4evT8T6Jzdi2O3Iviat0njmkWkstTi
         YKR+9iHY0hVfnQ2HXYEKyUwYKxkP4L20JNOq68oKuhQmne1tHw18+7kdvorsjnDjYPyE
         ZH3SP0K1dqks5Qmeol/U37G0JHxznZbfQgSVuStRsZKlqVO3H2wCh7FjFiE7DgWd7vcC
         5YSCzv8D/+a3I2A3Su2zZjyJ80r/i1CPRc3bESsAfKJt7p6PdWC+A73mTy1KbO8fWsXa
         ct4hbt/WhtskW2FK4Beno2jZf8Nt/gViBU47Ho0AxiYGmn8Nb7YBe92oP0pI3vL4qr2t
         EYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=crbVUKdb6+CmoQ+3cFtG2k0oh3fF8DozMebl0jMBYx4=;
        b=n+cGxxJKWb3wo7P7uaOo2BOTwU5Bp9XSCVMxiYii/0SbIBF1VL6hevxdmZ4SHbDVq9
         ES2yiJHH/mObcLn358mSqd/6spJTU2NSLrsemsQB/MHdPnV18xBw+FKlRHwZhx5QWrbG
         j441jo7v9h6vVAbSlBYeItf6KFNVYejIGGfZb/ZgKq/e1elB/KeR8O9TS25cOvWFdI+j
         dEVtViMr9Koj9F0ZiwK564H1/rQFMSm0iGzVFFZOpS/8q5WI+aXbeat3qCPv5ZmGqctc
         BPQEjPxMZsszL0ii3+BEbPM20ZQr+BuAGW7uOvbRDK7/v+GGlDfnXsVL4p3si8fXmlz5
         2KVQ==
X-Gm-Message-State: APjAAAX7GCu7dQ/nEdUYfkp+9wzFwg63FBpheRniNFScKoss/lYIVect
        j+U2LTHRYI5j/pVfnMsufDYJcXVnG2E2vAi9CA==
X-Google-Smtp-Source: APXvYqzGvs+JbS24C651jnNyN5/bp3XVxFTkpVbNRBZSUdxyZWVjEEMhfHBznWe9hPQc7sM2a9+fC0LXZ5ukQehqTw==
X-Received: by 2002:a05:620a:20d2:: with SMTP id f18mr16114129qka.474.1571948969627;
 Thu, 24 Oct 2019 13:29:29 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:28:58 -0700
In-Reply-To: <20191024202858.95342-1-almasrymina@google.com>
Message-Id: <20191024202858.95342-9-almasrymina@google.com>
Mime-Version: 1.0
References: <20191024202858.95342-1-almasrymina@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v7 9/9] hugetlb_cgroup: Add hugetlb_cgroup reservation docs
From:   Mina Almasry <almasrymina@google.com>
To:     mike.kravetz@oracle.com
Cc:     shuah@kernel.org, almasrymina@google.com, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com, Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add docs for how to use hugetlb_cgroup reservations, and their behavior.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Hillf Danton <hdanton@sina.com>

---

Changes in v6:
- Updated docs to reflect the new design based on a new counter that
tracks both reservations and faults.

---
 .../admin-guide/cgroup-v1/hugetlb.rst         | 64 +++++++++++++++----
 1 file changed, 53 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/hugetlb.rst b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
index a3902aa253a96..efb94e4db9d5a 100644
--- a/Documentation/admin-guide/cgroup-v1/hugetlb.rst
+++ b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
@@ -2,13 +2,6 @@
 HugeTLB Controller
 ==================

-The HugeTLB controller allows to limit the HugeTLB usage per control group and
-enforces the controller limit during page fault. Since HugeTLB doesn't
-support page reclaim, enforcing the limit at page fault time implies that,
-the application will get SIGBUS signal if it tries to access HugeTLB pages
-beyond its limit. This requires the application to know beforehand how much
-HugeTLB pages it would require for its use.
-
 HugeTLB controller can be created by first mounting the cgroup filesystem.

 # mount -t cgroup -o hugetlb none /sys/fs/cgroup
@@ -28,10 +21,14 @@ process (bash) into it.

 Brief summary of control files::

- hugetlb.<hugepagesize>.limit_in_bytes     # set/show limit of "hugepagesize" hugetlb usage
- hugetlb.<hugepagesize>.max_usage_in_bytes # show max "hugepagesize" hugetlb  usage recorded
- hugetlb.<hugepagesize>.usage_in_bytes     # show current usage for "hugepagesize" hugetlb
- hugetlb.<hugepagesize>.failcnt		   # show the number of allocation failure due to HugeTLB limit
+ hugetlb.<hugepagesize>.reservation_limit_in_bytes     # set/show limit of "hugepagesize" hugetlb reservations
+ hugetlb.<hugepagesize>.reservation_max_usage_in_bytes # show max "hugepagesize" hugetlb reservations and no-reserve faults.
+ hugetlb.<hugepagesize>.reservation_usage_in_bytes     # show current reservations and no-reserve faults for "hugepagesize" hugetlb
+ hugetlb.<hugepagesize>.reservation_failcnt            # show the number of allocation failure due to HugeTLB reservation limit
+ hugetlb.<hugepagesize>.limit_in_bytes                 # set/show limit of "hugepagesize" hugetlb faults
+ hugetlb.<hugepagesize>.max_usage_in_bytes             # show max "hugepagesize" hugetlb  usage recorded
+ hugetlb.<hugepagesize>.usage_in_bytes                 # show current usage for "hugepagesize" hugetlb
+ hugetlb.<hugepagesize>.failcnt                        # show the number of allocation failure due to HugeTLB usage limit

 For a system supporting three hugepage sizes (64k, 32M and 1G), the control
 files include::
@@ -40,11 +37,56 @@ files include::
   hugetlb.1GB.max_usage_in_bytes
   hugetlb.1GB.usage_in_bytes
   hugetlb.1GB.failcnt
+  hugetlb.1GB.reservation_limit_in_bytes
+  hugetlb.1GB.reservation_max_usage_in_bytes
+  hugetlb.1GB.reservation_usage_in_bytes
+  hugetlb.1GB.reservation_failcnt
   hugetlb.64KB.limit_in_bytes
   hugetlb.64KB.max_usage_in_bytes
   hugetlb.64KB.usage_in_bytes
   hugetlb.64KB.failcnt
+  hugetlb.64KB.reservation_limit_in_bytes
+  hugetlb.64KB.reservation_max_usage_in_bytes
+  hugetlb.64KB.reservation_usage_in_bytes
+  hugetlb.64KB.reservation_failcnt
   hugetlb.32MB.limit_in_bytes
   hugetlb.32MB.max_usage_in_bytes
   hugetlb.32MB.usage_in_bytes
   hugetlb.32MB.failcnt
+  hugetlb.32MB.reservation_limit_in_bytes
+  hugetlb.32MB.reservation_max_usage_in_bytes
+  hugetlb.32MB.reservation_usage_in_bytes
+  hugetlb.32MB.reservation_failcnt
+
+
+1. Reservation limits
+
+The HugeTLB controller allows to limit the HugeTLB reservations per control
+group and enforces the controller limit at reservation time and at the fault of
+hugetlb memory for which no reservation exists. Reservation limits
+are superior to Page fault limits (see section 2), since Reservation limits are
+enforced at reservation time (on mmap or shget), and never causes the
+application to get SIGBUS signal if the memory was reserved before hand. For
+MAP_NORESERVE allocations, the reservation limit behaves the same as the fault
+limit, enforcing memory usage at fault time and causing the application to
+receive a SIGBUS if it's crossing its limit.
+
+2. Page fault limits
+
+The HugeTLB controller allows to limit the HugeTLB usage (page fault) per
+control group and enforces the controller limit during page fault. Since HugeTLB
+doesn't support page reclaim, enforcing the limit at page fault time implies
+that, the application will get SIGBUS signal if it tries to access HugeTLB
+pages beyond its limit. This requires the application to know beforehand how
+much HugeTLB pages it would require for its use.
+
+
+3. Caveats with shared memory
+
+For shared hugetlb memory, both hugetlb reservation and page faults are charged
+to the first task that causes the memory to be reserved or faulted, and all
+subsequent uses of this reserved or faulted memory is done without charging.
+
+Shared hugetlb memory is only uncharged when it is unreserved or deallocated.
+This is usually when the hugetlbfs file is deleted, and not when the task that
+caused the reservation or fault has exited.
--
2.24.0.rc0.303.g954a862665-goog
