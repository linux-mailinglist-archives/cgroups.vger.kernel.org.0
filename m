Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04C12142CD
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2020 05:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGDDUu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 23:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgGDDUs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 23:20:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADA9C061794;
        Fri,  3 Jul 2020 20:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nGMSxQvjBkDqTq1f7jabTVwcwzwy9TqipamfSuuvRvE=; b=v7qgqwTp0o7B2yw+fo8AWsziCa
        QCzGaPg3f+qq+ROY2INYQI8VUTFqoXrT5d6hPs8xHq7Mt/E5SKay93YzKdTdPNfV+eSOJnkZMLERO
        ksSyXgbNjmEVfqdLAy+Pdv8iOR+BVQ3faPXjeme/1Yx6cATtT1zHjPcqTUtb+GP5RO4yvCOSuSII8
        d1gWvhHCJiVxw9vXprLRXkimQGTgFHV+gIZdkYTlwb98yPIZJhPe4fX+Q4PhQo4NO72htHNfsc36p
        SVdueTJezN0ljHdlWqSU3/207/YC+deDIjdlp5ZP+j4ie32tKAuCae10hOg+UcW46n9rxLWe4oCxK
        XolpU1gQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrYjN-0000Ri-Mb; Sat, 04 Jul 2020 03:20:46 +0000
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
Subject: [PATCH 04/13] Documentation/admin-guide: media/building: drop doubled words
Date:   Fri,  3 Jul 2020 20:20:11 -0700
Message-Id: <20200704032020.21923-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704032020.21923-1-rdunlap@infradead.org>
References: <20200704032020.21923-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Drop some doubled words.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 Documentation/admin-guide/media/building.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200701.orig/Documentation/admin-guide/media/building.rst
+++ linux-next-20200701/Documentation/admin-guide/media/building.rst
@@ -90,7 +90,7 @@ built as modules.
        Those GPU-specific drivers are selected via the ``Graphics support``
        menu, under ``Device Drivers``.
 
-       When a GPU driver supports supports HDMI CEC, it will automatically
+       When a GPU driver supports HDMI CEC, it will automatically
        enable the CEC core support at the media subsystem.
 
 Media dependencies
@@ -244,7 +244,7 @@ functionality.
    If you have an hybrid card, you may need to enable both ``Analog TV``
    and ``Digital TV`` at the menu.
 
-When using this option, the defaults for the the media support core
+When using this option, the defaults for the media support core
 functionality are usually good enough to provide the basic functionality
 for the driver. Yet, you could manually enable some desired extra (optional)
 functionality using the settings under each of the following
