Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6005F2142D9
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2020 05:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgGDDVD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 23:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgGDDVC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 23:21:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495AEC061794;
        Fri,  3 Jul 2020 20:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NxLHP+9cFhtU3n1OYnw9N90/6GroG0s0rwbqmFTSb6o=; b=kdlQ3P5n9vkkqj1ly+uWdiMMtM
        Exf5dBIyd7H1wc5cxeAxqlwv/2Un9/BIrbYJXUcVKUmrMpYU4knuAT5//TN8Pn3KGBUQEmWescrtC
        T4EP5rVfc+p30Jwt9ueo27TcoRyQiJL2HPkBychrVGwgev8EXNraang584WgoG8ypw+ApdA21wkhu
        tVxlVkCIeTP5Ca8+MxuXO2aTo9+kfdWW+TXsgdOF3p98hImfRBkh1PUYwBQqE7b3MJcqE1Z8dqj1w
        200gdii7HIynKZmL6xQX6rwATVSlCTYK7zVM7nvmTgz0OCoVIsKEQ9NAjwiebLFgDlWU7lbYHMklg
        l4/rBZUw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrYjb-0000Ri-Sy; Sat, 04 Jul 2020 03:21:00 +0000
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
Subject: [PATCH 07/13] Documentation/admin-guide: pnfs-scsi-server: drop doubled word
Date:   Fri,  3 Jul 2020 20:20:14 -0700
Message-Id: <20200704032020.21923-8-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704032020.21923-1-rdunlap@infradead.org>
References: <20200704032020.21923-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Drop the doubled word "with".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: linux-nfs@vger.kernel.org
---
 Documentation/admin-guide/nfs/pnfs-scsi-server.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/admin-guide/nfs/pnfs-scsi-server.rst
+++ linux-next-20200701/Documentation/admin-guide/nfs/pnfs-scsi-server.rst
@@ -9,7 +9,7 @@ which in addition to handling all the me
 also hands out layouts to the clients so that they can directly access the
 underlying SCSI LUNs that are shared with the client.
 
-To use pNFS SCSI layouts with with the Linux NFS server, the exported file
+To use pNFS SCSI layouts with the Linux NFS server, the exported file
 system needs to support the pNFS SCSI layouts (currently just XFS), and the
 file system must sit on a SCSI LUN that is accessible to the clients in
 addition to the MDS.  As of now the file system needs to sit directly on the
