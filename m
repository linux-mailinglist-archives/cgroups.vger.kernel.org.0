Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F33522E81C
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2019 00:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfE2WZE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 May 2019 18:25:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36681 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfE2WZE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 May 2019 18:25:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id m22so3881210ljc.3
        for <cgroups@vger.kernel.org>; Wed, 29 May 2019 15:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ugedal.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DK/ogr6pZZUphW9lU4h1f+fFgOabCak3KXyja9ZoLt0=;
        b=EtEkBupWZk2J/O72xoPMmoNFOSLqen/od3RSkObixQLiBW0S7B4LBoMgiN1OJs5lTI
         7eQsLP01PJJoMg2Rx3TXT2fHK9oKRyTMsSxuM14Bv/AhGUfZbEp+jOWiJjg08NWOPWIn
         60jXRmoCOn7ULv9kGZ6Qa3BukeR4KLALFfbLjl+hFFUdKHdpARIjb7oq/IA0fCdMe6Jw
         CGumH0h5cYi/VpKQ+Q0RElMr9yUgKn5Qljab6cDKdX0txp1pFfhPYKT+HwcU8Rt1cCYS
         WLSjSr5B2qq/nQyorb4FdVBSJC+ONV8G5I9EocBK2BtkSCoIadihUFJo7fO60LGyljtK
         4pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DK/ogr6pZZUphW9lU4h1f+fFgOabCak3KXyja9ZoLt0=;
        b=UDjTznGmEeRKoqlCyyy9XsO4lRLCA60jnv0yZXkoP0Zt4jWBQ/7llnuN0eAxwqitx9
         JCoQC2SN0nkRfh1/FATgL8da9jI6VnwO3/fpQdIZEQhZ5FzS9syv8sX1o1NOgINO1Nkp
         PM4RqNwfP/MsB6eAzbYyTzOgNL/DG4gFxl/ITzlu8h83DUANBMGWitt4GgNrEWGx/8Cr
         1IlUjGeL7OGu9sOALzIrI13Kie9Bc116g9bxQzO2+BfbSGSV2E/gboRVtulLW41Xfb8S
         lxT03+xLvuWZooiGquAhgrM900Xd7eWmmk0Pj0CPT3aFgraqwDq1mIHGqFcZm4iNJ5ko
         lPCA==
X-Gm-Message-State: APjAAAUYSzo5c80L4VIDLEZ9Sg8e7gq6BjmY33IhJ/ZpNk+S+c+ZZ9AP
        eEXDuyAfm+Qa/SDXbUT/9P/0NYGA5SgaAHsV
X-Google-Smtp-Source: APXvYqy0RN6ic0nj6bgyH0NezC2bwxY/JEYIDLewQ/OEvI+10SkZ2sUZRbFizdUdOEoeHXmIvT/NkA==
X-Received: by 2002:a2e:b0e1:: with SMTP id h1mr118902ljl.171.1559168702343;
        Wed, 29 May 2019 15:25:02 -0700 (PDT)
Received: from xps13.ZyXEL-USG (84-52-230.83.3p.ntebredband.no. [84.52.230.83])
        by smtp.gmail.com with ESMTPSA id s12sm113843lji.34.2019.05.29.15.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 15:25:00 -0700 (PDT)
From:   Odin Ugedal <odin@ugedal.com>
To:     odin@ugedal.com
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        cgroups@vger.kernel.org (open list:CONTROL GROUP (CGROUP)),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] docs cgroups: add another example size for hugetlb
Date:   Thu, 30 May 2019 00:24:25 +0200
Message-Id: <20190529222425.30879-1-odin@ugedal.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add another example to clarify that HugePages smaller than 1MB will
be displayed using "KB", with an uppercased K (eg. 20KB), and not the
normal SI prefix kilo (small k).

Because of a misunderstanding/copy-paste error inside runc
(see https://github.com/opencontainers/runc/pull/2065), it tried
accessing the cgroup control file of a 64kB HugePage using
"hugetlb.64kB._____" instead of the correct "hugetlb.64KB._____".

Adding a new example will make it clear how sizes smaller than 1MB are
handled.

Signed-off-by: Odin Ugedal <odin@ugedal.com>
---
 Documentation/cgroup-v1/hugetlb.txt | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/Documentation/cgroup-v1/hugetlb.txt b/Documentation/cgroup-v1/hugetlb.txt
index 106245c3aecc..1260e5369b9b 100644
--- a/Documentation/cgroup-v1/hugetlb.txt
+++ b/Documentation/cgroup-v1/hugetlb.txt
@@ -32,14 +32,18 @@ Brief summary of control files
  hugetlb.<hugepagesize>.usage_in_bytes     # show current usage for "hugepagesize" hugetlb
  hugetlb.<hugepagesize>.failcnt		   # show the number of allocation failure due to HugeTLB limit
 
-For a system supporting two hugepage size (16M and 16G) the control
+For a system supporting three hugepage sizes (64k, 32M and 1G), the control
 files include:
 
-hugetlb.16GB.limit_in_bytes
-hugetlb.16GB.max_usage_in_bytes
-hugetlb.16GB.usage_in_bytes
-hugetlb.16GB.failcnt
-hugetlb.16MB.limit_in_bytes
-hugetlb.16MB.max_usage_in_bytes
-hugetlb.16MB.usage_in_bytes
-hugetlb.16MB.failcnt
+hugetlb.1GB.limit_in_bytes
+hugetlb.1GB.max_usage_in_bytes
+hugetlb.1GB.usage_in_bytes
+hugetlb.1GB.failcnt
+hugetlb.64KB.limit_in_bytes
+hugetlb.64KB.max_usage_in_bytes
+hugetlb.64KB.usage_in_bytes
+hugetlb.64KB.failcnt
+hugetlb.32MB.limit_in_bytes
+hugetlb.32MB.max_usage_in_bytes
+hugetlb.32MB.usage_in_bytes
+hugetlb.32MB.failcnt
-- 
2.21.0

