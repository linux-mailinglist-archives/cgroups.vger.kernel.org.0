Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D71B2142C3
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2020 05:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgGDDUe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 23:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgGDDUe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 23:20:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1C9C061794;
        Fri,  3 Jul 2020 20:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=v3to2sgHc1QVReX422OXkm9R4yx3s+sZ/QxCA2U3Qmo=; b=taJdNT58TuHsRqiei7ea6NUisP
        EtY14yX4mCeRinnwVry/Uu0nT7qWV//7xInhrXjQe0yaZhcMW771WfVTjm9aUgXaJj9wAaHl3cKJ/
        hL1hqPOtLQzngxrbgXph4OOakmR5SutLNr39V3f8EVT1p+DOClRGKyCASH9x9C1I+T+QjB887zRNz
        oMOygfqs8SRm/7kWu6HB1q/glBTMXBJu7dt7RQHN8cyFf54XA5q2/uhaXbexy4jmxWTzyCBZYpPSY
        oXvGYQtRZwpq+ENmUCkKnZZ6hiE5GVYRw/7kiwA3U18+Pbgu03ksXgppWt1AjiMNBwEa1mL6UrvRU
        5JYJIv3g==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrYj9-0000Ri-46; Sat, 04 Jul 2020 03:20:32 +0000
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
Subject: [PATCH 01/13] Documentation/admin-guide: cgroup-v2: drop doubled word
Date:   Fri,  3 Jul 2020 20:20:08 -0700
Message-Id: <20200704032020.21923-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704032020.21923-1-rdunlap@infradead.org>
References: <20200704032020.21923-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Drop the doubled word "of".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: cgroups@vger.kernel.org
---
 Documentation/admin-guide/cgroup-v2.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/admin-guide/cgroup-v2.rst
+++ linux-next-20200701/Documentation/admin-guide/cgroup-v2.rst
@@ -2047,7 +2047,7 @@ RDMA
 ----
 
 The "rdma" controller regulates the distribution and accounting of
-of RDMA resources.
+RDMA resources.
 
 RDMA Interface Files
 ~~~~~~~~~~~~~~~~~~~~
