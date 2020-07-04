Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18A8214319
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2020 05:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgGDDUy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 23:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgGDDUx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 23:20:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B632C061794;
        Fri,  3 Jul 2020 20:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Xc5Y/7gMRvZrKEJDCwrF418TtFkFpBUwIh8SQqJf/ZU=; b=VrTfAv1RGQ4hkjvCiNUDlr43un
        jMOXcMt42Nbx8oDU/ZCH3amqP9Ci4p6Jj0bs5YM+KpSNQ4IvQkmwfsmststlLaxkb/Bu8FDK9T1gf
        U8W3n96qwP7as2mouie5Il16I0kLXpdDwMJN9RWnaVSNFbtxn/nLTVq2JT7omAyncYHfEYPGIPWxp
        KsBbm72o1Rg+YHOANxA2hEIOkaxm1TcaR4HMozh5pGtMWNsYS+bQxx179Va8AUDruSOe1f9QDwVp0
        p4mFxuXbBxcu69O91lkt+sC40Rn54VfvH4i4E1SEtOKR9fz53N8PoD7JO7oTtDS1SEOHDoFEe/Ixu
        TIR9XeJA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrYjS-0000Ri-7y; Sat, 04 Jul 2020 03:20:51 +0000
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
Subject: [PATCH 05/13] Documentation/admin-guide: mm/ksm: drop doubled word
Date:   Fri,  3 Jul 2020 20:20:12 -0700
Message-Id: <20200704032020.21923-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704032020.21923-1-rdunlap@infradead.org>
References: <20200704032020.21923-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Drop the doubled word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 Documentation/admin-guide/mm/ksm.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/admin-guide/mm/ksm.rst
+++ linux-next-20200701/Documentation/admin-guide/mm/ksm.rst
@@ -52,7 +52,7 @@ with EAGAIN, but more probably arousing
 If KSM is not configured into the running kernel, madvise MADV_MERGEABLE
 and MADV_UNMERGEABLE simply fail with EINVAL.  If the running kernel was
 built with CONFIG_KSM=y, those calls will normally succeed: even if the
-the KSM daemon is not currently running, MADV_MERGEABLE still registers
+KSM daemon is not currently running, MADV_MERGEABLE still registers
 the range for whenever the KSM daemon is started; even if the range
 cannot contain any pages which KSM could actually merge; even if
 MADV_UNMERGEABLE is applied to a range which was never MADV_MERGEABLE.
