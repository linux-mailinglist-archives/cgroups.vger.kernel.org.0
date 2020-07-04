Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E0C2142CA
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2020 05:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgGDDUj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 23:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgGDDUi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 23:20:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF33C061794;
        Fri,  3 Jul 2020 20:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aRVEN4YU/BFDPd6cVTCzZUpu/CCVzRwNOQDbPEBZys4=; b=tJY95Xa0IAWCrSFHJ8hTCqVmCb
        PXAAOu78uVM3UWrMJkge+fpEUOzsWN6i1uIxsyLnmkkuQkJJKI8Wx/TOSwiCRs3GoeUv+ef/Odg/4
        DScwsH1ayFutkvn+JXl/8SAVMLiPQGYB0MUXTsWHuuWqq5ph52ziQX1HKD76p6hA9U7asFqXqBZeE
        9rhtY/avec+Vt38MW41IjTZHQyftEBAk/dryc/xxN2emvHd+r8wIzhVGs4AVI9JlrkZ3Em9tgS+5V
        Fz+a9iVry0UFDQ259p5zqFaxpP59X6EW0kDPHUScNKFFxI8sioWVwnTmsuLAIn7yc+3yPmOcbAc9k
        lOiOUrzQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrYjE-0000Ri-15; Sat, 04 Jul 2020 03:20:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        cgroups@vger.kernel.org, dm-devel@redhat.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Subject: [PATCH 02/13] Documentation/admin-guide: cgroup-v1/rdma: drop doubled word
Date:   Fri,  3 Jul 2020 20:20:09 -0700
Message-Id: <20200704032020.21923-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704032020.21923-1-rdunlap@infradead.org>
References: <20200704032020.21923-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Drop the doubled word "echo".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: cgroups@vger.kernel.org
---
 Documentation/admin-guide/cgroup-v1/rdma.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/admin-guide/cgroup-v1/rdma.rst
+++ linux-next-20200701/Documentation/admin-guide/cgroup-v1/rdma.rst
@@ -114,4 +114,4 @@ Following resources can be accounted by
 
 (d) Delete resource limit::
 
-	echo echo mlx4_0 hca_handle=max hca_object=max > /sys/fs/cgroup/rdma/1/rdma.max
+	echo mlx4_0 hca_handle=max hca_object=max > /sys/fs/cgroup/rdma/1/rdma.max
