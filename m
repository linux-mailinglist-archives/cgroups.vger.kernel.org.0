Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C494214329
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2020 05:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgGDDUc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 23:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgGDDUc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 23:20:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D6CC061794;
        Fri,  3 Jul 2020 20:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=7hWx3juXEv+Gb67bYW4aLkckqsyqEnHQMB/wBgBJZwg=; b=IFPdIYUOIuDbKx41Bbn39sEemo
        J2tgjtcrdNIW0uetV+bH1YOSgiLelcgR32aJbRM7GyTz6RIpIBsrZ+2idCAPRwnVWDYTAioDlEF6V
        HyWqXI0qxDlXyL1OknzYjELYpUQ4uG+5EFzFIkVufn6qODHaY5Z8Hs49NDxcXbETCRmY/Lwk+crSk
        1cW9UhhrFkHDRhb6mrjpZhDsdh+NRV/2Z/xOxl2Ix5drPXYKrLFEQzci9SIj10VjmtOIodLGFu4Pz
        CT5wOmcj2M9689ySNJe+jXV1oRDJqgRCxzsCMjGtbpVoMaiaFW0GmVL2/I5CBkpnCa05I8bzfkFr3
        wqrMki8Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrYj4-0000Ri-7p; Sat, 04 Jul 2020 03:20:27 +0000
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
Subject: [PATCH 00/13] Documentation/admin-guide: eliminate duplicated words
Date:   Fri,  3 Jul 2020 20:20:07 -0700
Message-Id: <20200704032020.21923-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Remove duplicated words from Documentation/admin-guide/ files.


Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: dm-devel@redhat.com
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: linux-nfs@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: linux-xfs@vger.kernel.org


 Documentation/admin-guide/cgroup-v1/rdma.rst             |    2 +-
 Documentation/admin-guide/cgroup-v2.rst                  |    2 +-
 Documentation/admin-guide/device-mapper/dm-integrity.rst |    4 ++--
 Documentation/admin-guide/media/building.rst             |    4 ++--
 Documentation/admin-guide/mm/ksm.rst                     |    2 +-
 Documentation/admin-guide/nfs/pnfs-block-server.rst      |    2 +-
 Documentation/admin-guide/nfs/pnfs-scsi-server.rst       |    2 +-
 Documentation/admin-guide/perf/arm-ccn.rst               |    2 +-
 Documentation/admin-guide/pm/intel-speed-select.rst      |    4 ++--
 Documentation/admin-guide/pm/intel_pstate.rst            |    2 +-
 Documentation/admin-guide/sysctl/kernel.rst              |    2 +-
 Documentation/admin-guide/tainted-kernels.rst            |    2 +-
 Documentation/admin-guide/xfs.rst                        |    2 +-
 13 files changed, 16 insertions(+), 16 deletions(-)
