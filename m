Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E69F2142D4
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2020 05:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGDDU7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 23:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgGDDU6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 23:20:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0179C061794;
        Fri,  3 Jul 2020 20:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DZ5AR4lNMU/5KPyS2pBM92vJ3D1lWMXawLdaIpgxnII=; b=T9P+15PzEh3VlB3gzOuXmnUnCV
        V4qPHljrbso2PJprvotn9IiQOSk3aAovV4xIIDSNZjspA23YErZraTFJR/cTUved8EXKhZAFLISg5
        418qFrKMlAxt+kAazbl47//dnKjxAJyQFJ1im8untNP6cSyhOgrMep2PRHQV+NXUEkFHgCD24bc4t
        wtWyA2IsTiMl/0al0BC8D5c7msS793b9ZmAs01+xKjpwB6Qrp1jgIns98O+WIV4uCaiGrPqFRO/bO
        w36rPGg1vydz8vsnZ7tO21QN2a2SJ79+YiMy26Y/LsVqOaxEUrla7UPAPBywSC7g6AvFqBVj+TmNe
        mIY/o2qA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrYjX-0000Ri-5m; Sat, 04 Jul 2020 03:20:55 +0000
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
Subject: [PATCH 06/13] Documentation/admin-guide: pnfs-block-server: drop doubled word
Date:   Fri,  3 Jul 2020 20:20:13 -0700
Message-Id: <20200704032020.21923-7-rdunlap@infradead.org>
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
 Documentation/admin-guide/nfs/pnfs-block-server.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/admin-guide/nfs/pnfs-block-server.rst
+++ linux-next-20200701/Documentation/admin-guide/nfs/pnfs-block-server.rst
@@ -8,7 +8,7 @@ to handling all the metadata access to t
 to the clients to directly access the underlying block devices that are
 shared with the client.
 
-To use pNFS block layouts with with the Linux NFS server the exported file
+To use pNFS block layouts with the Linux NFS server the exported file
 system needs to support the pNFS block layouts (currently just XFS), and the
 file system must sit on shared storage (typically iSCSI) that is accessible
 to the clients in addition to the MDS.  As of now the file system needs to
