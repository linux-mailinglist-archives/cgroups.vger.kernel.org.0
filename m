Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CF6214306
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2020 05:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgGDDVZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 23:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgGDDVW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 23:21:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F73C061794;
        Fri,  3 Jul 2020 20:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8pKvrcNaFuZeOjcq9eNrFm90IIli99w7VYLzSvP2y/o=; b=Vr5yaAj1Ow2hOWq/9C2zxsJ/Ih
        O0OJdZk0igUSwbBN6Coig/XIlsc6duH3uegpjCHLNSAew5qXmj8JWos7K97HeWesePg2chNgXnnmX
        Fm0rn3ALzxs6znAgYSoRLrp2oaO5NKphqg+xKe0qr8V2ZHhJt1ekEjax+61rghNovm7npGJNuAIBv
        5TQa/YURh8seaHlSM2wgsBGNGWSnMiM0p48qQPEITU0X59w8FryqV1X9ohHmEmeEjIbgsb/mZwRk3
        SJNzh68EBoS/b4DUnSJ9cazhy1UXJE5lbmBzU0jAOOW3astTOcTCgr6SMZd1wDPvAa5iP/Sc/o/YG
        7lyRnaew==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrYjv-0000Ri-Jh; Sat, 04 Jul 2020 03:21:20 +0000
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
Subject: [PATCH 11/13] Documentation/admin-guide: sysctl/kernel: drop doubled word
Date:   Fri,  3 Jul 2020 20:20:18 -0700
Message-Id: <20200704032020.21923-12-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704032020.21923-1-rdunlap@infradead.org>
References: <20200704032020.21923-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Drop the doubled word "set".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/sysctl/kernel.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/admin-guide/sysctl/kernel.rst
+++ linux-next-20200701/Documentation/admin-guide/sysctl/kernel.rst
@@ -235,7 +235,7 @@ This toggle indicates whether unprivileg
 from using ``dmesg(8)`` to view messages from the kernel's log
 buffer.
 When ``dmesg_restrict`` is set to 0 there are no restrictions.
-When ``dmesg_restrict`` is set set to 1, users must have
+When ``dmesg_restrict`` is set to 1, users must have
 ``CAP_SYSLOG`` to use ``dmesg(8)``.
 
 The kernel config option ``CONFIG_SECURITY_DMESG_RESTRICT`` sets the
