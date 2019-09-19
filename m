Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D60CB85CF
	for <lists+cgroups@lfdr.de>; Fri, 20 Sep 2019 00:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389629AbfISWY4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 Sep 2019 18:24:56 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:40569 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436514AbfISWYp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 Sep 2019 18:24:45 -0400
Received: by mail-pl1-f201.google.com with SMTP id f4so3085534plo.7
        for <cgroups@vger.kernel.org>; Thu, 19 Sep 2019 15:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1fNH/t1YSSHvbg8a3MxctDUNrINVVwuSB3u0kWY+VvE=;
        b=okXtjjMugI2zY2ntgsy9f5ADQvXd32G/3xinqf6Q6DtZsN1MbYoRsonm/03yjd0/P+
         MiIUVJ/TIT5XH2YKjfw0FvrBtAZwd5DM78evZ6y1x0tflJV48NyGtbgy/MY/hxd5k/Zc
         3V9HjeyAmSr1BHpbXPnNTRrEmOoGHsqAiX3Ck/V8YaFH2UmsyObqtnMlM/LEM2sh6P3q
         W0JqVYCmFHAWrwSTvjAAudRcEl5fiiFK2qODUwZWWBFv1tb1baNfEY5piUNaqnQJoX4r
         sYGU1nFjv3MHx7pUHQxtV3lOoSFYliguYZydg0YOWMR0IC9U4uIEB4rXq6tv6XXwZu+0
         5zNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1fNH/t1YSSHvbg8a3MxctDUNrINVVwuSB3u0kWY+VvE=;
        b=LWfHjFdFKzb0CmXb4l08fg4fdlNwYvVLdLhicCV0Spsg+jcrSPbPDk3jS/8y5TNVfM
         sq10GSheJXTXFbyhWmnXwVUxxv9fuJwl8O2E6Q5oy+0m9JVOr7dxIPG8NgE5s+D13lpU
         GWMpnlKWO4J7CqiI8P33dQaLLmXPVz41YO31ytpcxIDW3gVG1pH6o7V4H/4zerj6PffF
         b2QLLdclPyikiVpskwyZbD+XQhwFdjErA2CMSKM1qiD6x3eILeN3jfTJCJiwrNVRXjQu
         1Jo6EgNiTNKnlpMmUy/uUD3sgZhCquMEToTv7KBwXjhnviH4ZCVGm/ZbcE1+sMZV4Z0b
         nNxw==
X-Gm-Message-State: APjAAAVZTqyomnmFddqaefCnI6fOqBD6Y9xI+QVk+YVikxE/XdKf7e4j
        jbljs9ELk675RI4z2zJPRPHROHKBv++ybARzTQ==
X-Google-Smtp-Source: APXvYqwVYmVYaJLBh2SrSRXW2EoYl9OM1kTw7+CtcNY8OPiNC3aAKR0Me26xzMapXcS6QkknLzni5XaRDPsqCd2NcA==
X-Received: by 2002:a63:4451:: with SMTP id t17mr11796300pgk.128.1568931883911;
 Thu, 19 Sep 2019 15:24:43 -0700 (PDT)
Date:   Thu, 19 Sep 2019 15:24:21 -0700
In-Reply-To: <20190919222421.27408-1-almasrymina@google.com>
Message-Id: <20190919222421.27408-8-almasrymina@google.com>
Mime-Version: 1.0
References: <20190919222421.27408-1-almasrymina@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v5 7/7] hugetlb_cgroup: Add hugetlb_cgroup reservation docs
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
 .../admin-guide/cgroup-v1/hugetlb.rst         | 85 ++++++++++++++++---
 1 file changed, 74 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/hugetlb.rst b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
index a3902aa253a9..70c10bd9a0b7 100644
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
+ hugetlb.<hugepagesize>.reservation_max_usage_in_bytes # show max "hugepagesize" hugetlb reservations recorded
+ hugetlb.<hugepagesize>.reservation_usage_in_bytes     # show current reservations for "hugepagesize" hugetlb
+ hugetlb.<hugepagesize>.reservation_failcnt            # show the number of allocation failure due to HugeTLB reservation limit
+ hugetlb.<hugepagesize>.limit_in_bytes                 # set/show limit of "hugepagesize" hugetlb faults
+ hugetlb.<hugepagesize>.max_usage_in_bytes             # show max "hugepagesize" hugetlb  usage recorded
+ hugetlb.<hugepagesize>.usage_in_bytes                 # show current usage for "hugepagesize" hugetlb
+ hugetlb.<hugepagesize>.failcnt                        # show the number of allocation failure due to HugeTLB usage limit

 For a system supporting three hugepage sizes (64k, 32M and 1G), the control
 files include::
@@ -40,11 +37,77 @@ files include::
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
+group and enforces the controller limit at reservation time. Reservation limits
+are superior to Page fault limits (see section 2), since Reservation limits are
+enforced at reservation time, and never causes the application to get SIGBUS
+signal. Instead, if the application is violating its limits, then it gets an
+error on reservation time, i.e. the mmap or shmget return an error.
+
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
+a. Charging and uncharging:
+
+For shared hugetlb memory, both hugetlb reservation and usage (page faults) are
+charged to the first task that causes the memory to be reserved or faulted,
+and all subsequent uses of this reserved or faulted memory is done without
+charging.
+
+Shared hugetlb memory is only uncharged when it is unreserved or deallocated.
+This is usually when the hugetlbfs file is deleted, and not when the task that
+caused the reservation or fault has exited.
+
+b. Interaction between reservation limit and fault limit.
+
+Generally, it's not recommended to set both of the reservation limit and fault
+limit in a cgroup. For private memory, the fault usage cannot exceed the
+reservation usage, so if you set both, one of those limits will be useless.
+Still, there is no kernel enforcement on setting both at the same time.
+
+For shared memory, a cgroup's fault usage may be greater than its reservation
+usage, so some care needs to be taken. Consider this example:
+
+- Task A reserves 4 pages in a shared hugetlbfs file. Cgroup A will get
+  4 reservations charged to it and no faults charged to it.
+- Task B reserves and faults the same 4 pages as Task A. Cgroup B will get no
+  reservation charge, but will get charged 4 faulted pages. If Cgroup B's limit
+  is less than 4, then Task B will get a SIGBUS.
+
+For the above scenario, it's not recommended for the userspace to set both
+reservation limits and fault limits, but it is still allowed to in case it sees
+some use for it, such as safe gradual transitioning from one to the other.
--
2.23.0.351.gc4317032e6-goog
