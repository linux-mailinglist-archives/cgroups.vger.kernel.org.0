Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A76214323
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2020 05:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgGDDUp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 23:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgGDDUo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 23:20:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7041CC061794;
        Fri,  3 Jul 2020 20:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OX5gHkwRjdsphqPt6oiGYwwyZUjS829HMpxoXk36jV8=; b=FE+o7+ShQZ2AiuFUBYQn85Da1f
        G2Yu2rsWT7l/PufkfBHi6+HVkOGIMo+xzFVFJRTjQAKFgoWNOEQl33q/JRSVGo25f5prdmn1+7ejY
        3d+xxkfejFHE+p2bYujzHfi8DIyAdx1vPt6MHoMN4EetW5KLS1SjqfybqxmbiEeOMYCJY99DvRSDs
        KvbXu8EGt1zxIdSPQh2vhvCB/yo7r1JmqrhZLesdsGDPLkENZnfOWFo1P08y/XCFq5BiPoNYQfqOy
        mXKg510Em8dbR8L2J1ZPqF17fz1qB5Tx7uewRboZ+Bf/6WZOacDFRmhy2YVQ74/WwoJmk1vKDvVtr
        mRTgU5PA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrYjI-0000Ri-CC; Sat, 04 Jul 2020 03:20:41 +0000
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
Subject: [PATCH 03/13] Documentation/admin-guide: dm-integrity: drop doubled words
Date:   Fri,  3 Jul 2020 20:20:10 -0700
Message-Id: <20200704032020.21923-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704032020.21923-1-rdunlap@infradead.org>
References: <20200704032020.21923-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Drop the doubled words "on" and "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: dm-devel@redhat.com
---
 Documentation/admin-guide/device-mapper/dm-integrity.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200701.orig/Documentation/admin-guide/device-mapper/dm-integrity.rst
+++ linux-next-20200701/Documentation/admin-guide/device-mapper/dm-integrity.rst
@@ -45,7 +45,7 @@ To use the target for the first time:
    will format the device
 3. unload the dm-integrity target
 4. read the "provided_data_sectors" value from the superblock
-5. load the dm-integrity target with the the target size
+5. load the dm-integrity target with the target size
    "provided_data_sectors"
 6. if you want to use dm-integrity with dm-crypt, load the dm-crypt target
    with the size "provided_data_sectors"
@@ -99,7 +99,7 @@ interleave_sectors:number
 	the superblock is used.
 
 meta_device:device
-	Don't interleave the data and metadata on on device. Use a
+	Don't interleave the data and metadata on the device. Use a
 	separate device for metadata.
 
 buffer_sectors:number
