Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170BD21430D
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2020 05:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGDDVI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 23:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgGDDVH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 23:21:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0695EC061794;
        Fri,  3 Jul 2020 20:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0XLS9Rcvj09LtgGfVKUIZyZrmGOYd4UjCrzrWHy1+1s=; b=TXiZaQormlTtVEDg7USvjAjN9M
        AEc4Ojj1xm3khtsjz/TxDwH9GGiE1M3eLN8329NG74Pv80aEnoZyvEgOTANv4HIouoqhGrHI118gO
        f8BVLC+gr0TUOKK2AcxYELqfTOJO3bWUpFSedyZUzdxg73jSnzVxqbbGUqUZRYfIgIOeXUuxvwCA8
        Mc6zkXL/92sYXS2UgknQ+IOy+6GVEHCNrzTqbnD+Qj8fKKUmISEA/Apj1W4u+h9FfWM3FhDz2xX8n
        PH1V/yr5/uzV5WEbesL/RIWE5nyCh1BTH0TzTxlcnsfNWVh10TOg9iMvdwNF26dw/xP0a0L9hvpy3
        TuUBb6Dg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrYjg-0000Ri-Dx; Sat, 04 Jul 2020 03:21:05 +0000
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
Subject: [PATCH 08/13] Documentation/admin-guide: arm-ccn: drop doubled word
Date:   Fri,  3 Jul 2020 20:20:15 -0700
Message-Id: <20200704032020.21923-9-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704032020.21923-1-rdunlap@infradead.org>
References: <20200704032020.21923-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Drop the doubled word "as".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/perf/arm-ccn.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/admin-guide/perf/arm-ccn.rst
+++ linux-next-20200701/Documentation/admin-guide/perf/arm-ccn.rst
@@ -27,7 +27,7 @@ Crosspoint PMU events require "xp" (inde
 and "vc" (virtual channel ID).
 
 Crosspoint watchpoint-based events (special "event" value 0xfe)
-require "xp" and "vc" as as above plus "port" (device port index),
+require "xp" and "vc" as above plus "port" (device port index),
 "dir" (transmit/receive direction), comparator values ("cmp_l"
 and "cmp_h") and "mask", being index of the comparator mask.
 
