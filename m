Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38545214F20
	for <lists+cgroups@lfdr.de>; Sun,  5 Jul 2020 22:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgGEUCT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 5 Jul 2020 16:02:19 -0400
Received: from ms.lwn.net ([45.79.88.28]:51468 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727892AbgGEUCS (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 5 Jul 2020 16:02:18 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C57E82E2;
        Sun,  5 Jul 2020 20:02:17 +0000 (UTC)
Date:   Sun, 5 Jul 2020 14:02:16 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
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
Subject: Re: [PATCH 00/13] Documentation/admin-guide: eliminate duplicated
 words
Message-ID: <20200705140216.33a0d8f5@lwn.net>
In-Reply-To: <20200704032020.21923-1-rdunlap@infradead.org>
References: <20200704032020.21923-1-rdunlap@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri,  3 Jul 2020 20:20:07 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Remove duplicated words from Documentation/admin-guide/ files.
> 
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: dm-devel@redhat.com
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Anna Schumaker <anna.schumaker@netapp.com>
> Cc: linux-nfs@vger.kernel.org
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: platform-driver-x86@vger.kernel.org
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: linux-xfs@vger.kernel.org
> 
> 
>  Documentation/admin-guide/cgroup-v1/rdma.rst             |    2 +-
>  Documentation/admin-guide/cgroup-v2.rst                  |    2 +-
>  Documentation/admin-guide/device-mapper/dm-integrity.rst |    4 ++--
>  Documentation/admin-guide/media/building.rst             |    4 ++--
>  Documentation/admin-guide/mm/ksm.rst                     |    2 +-
>  Documentation/admin-guide/nfs/pnfs-block-server.rst      |    2 +-
>  Documentation/admin-guide/nfs/pnfs-scsi-server.rst       |    2 +-
>  Documentation/admin-guide/perf/arm-ccn.rst               |    2 +-
>  Documentation/admin-guide/pm/intel-speed-select.rst      |    4 ++--
>  Documentation/admin-guide/pm/intel_pstate.rst            |    2 +-
>  Documentation/admin-guide/sysctl/kernel.rst              |    2 +-
>  Documentation/admin-guide/tainted-kernels.rst            |    2 +-
>  Documentation/admin-guide/xfs.rst                        |    2 +-
>  13 files changed, 16 insertions(+), 16 deletions(-)
> 
I've applied this set, thanks.

jon
