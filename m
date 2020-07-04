Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF9F2142F8
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2020 05:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgGDDVd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 23:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbgGDDVc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 23:21:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4956AC061794;
        Fri,  3 Jul 2020 20:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0aHjQ55hFxq6STzE8jcPc++LJg3Ht8D7yJwufSR30/I=; b=crtyVFUUrVpKua+McHYUoIje7r
        u9Z4eU/Yh+Lf+I6E8teepx4m84OpgMhb3cSfbkkeCJNmNQJAwLLP9WL67m0hdI/rW/63LUPbt1qkf
        RRyVxT2iL8djwXVmOJf92BhmdplTayXrRVe2MOjTL/CrqZ2whCkgD9ZEJ84QB3O7bBqZIhNAeESH1
        QQ4BZubJwj5hj8SDMoO/ulG0wC4LSNxXfW58XwQfnCwPPXqG1AcXSb8ceMPuq063UWFE1QQ6V0QGu
        ZaHlK10StFUDZ8gPV1qSto9E643B/WRyGF/mNlWQBa5ymyFfB1IbMKYyG7gxHuFjfvcFovndXHrOR
        d8hk8i6A==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrYk5-0000Ri-Io; Sat, 04 Jul 2020 03:21:30 +0000
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
Subject: [PATCH 13/13] Documentation/admin-guide: xfs: drop doubled word
Date:   Fri,  3 Jul 2020 20:20:20 -0700
Message-Id: <20200704032020.21923-14-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704032020.21923-1-rdunlap@infradead.org>
References: <20200704032020.21923-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Drop the doubled word "for".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: linux-xfs@vger.kernel.org
---
 Documentation/admin-guide/xfs.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/admin-guide/xfs.rst
+++ linux-next-20200701/Documentation/admin-guide/xfs.rst
@@ -133,7 +133,7 @@ When mounting an XFS filesystem, the fol
 	logbsize must be an integer multiple of the log
 	stripe unit configured at **mkfs(8)** time.
 
-	The default value for for version 1 logs is 32768, while the
+	The default value for version 1 logs is 32768, while the
 	default value for version 2 logs is MAX(32768, log_sunit).
 
   logdev=device and rtdev=device
