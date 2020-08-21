Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE42424DEB0
	for <lists+cgroups@lfdr.de>; Fri, 21 Aug 2020 19:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgHURk3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Aug 2020 13:40:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57002 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgHURk1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Aug 2020 13:40:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LHaowd144287;
        Fri, 21 Aug 2020 17:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=JUslshiDaN2dhP+XGrtZjY0EQXD83w9PlaWLQ1ae6vI=;
 b=v1eeqSoFZHVgpxgBCn7rPBUUsxTUxa4ls50fuAPwe9ZXg1ke5BYPwqZntCNgqvG3F55k
 OCUTr+/mXf3F6gdjCbHtO05iTUAAHid/DTL4UdDcVZcHw87g3AM0X/yrhKr2zSQnlGBL
 YpCwFOMY23P9LcP84/hCOoSqG1Xcy0j5d7NoppYcsVerTPajz2PR1V0FedP8sT03ZOdG
 oJYqKuRpeTP3TX/vRHcypi9Bo1ISI5tAbKK1hyBN7DgPjq9Pa15PrwJ1n/G1YMSz1Srx
 oB91CuqryjpyaITXDlUnTEZlsFeI66zSGMi0UWa9SerzCdbwrMgnuppWdeTBTlPArg0f aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32x74rq8rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Aug 2020 17:39:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LHbtpn178487;
        Fri, 21 Aug 2020 17:37:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 330pvs96qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 17:37:57 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07LHbpkQ015754;
        Fri, 21 Aug 2020 17:37:51 GMT
Received: from localhost.localdomain (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Aug 2020 17:37:50 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.0.3\))
Subject: Re: [PATCH 0/8] Return head pages from find_get_entry and
 find_lock_entry
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200819184850.24779-1-willy@infradead.org>
Date:   Fri, 21 Aug 2020 11:37:49 -0600
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4AEE52BC-76F0-4DB4-BBB1-7E367C12338B@oracle.com>
References: <20200819184850.24779-1-willy@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Mailer: Apple Mail (2.3654.0.3)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9720 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210166
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9720 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210166
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Aug 19, 2020, at 12:48 PM, Matthew Wilcox (Oracle) =
<willy@infradead.org> wrote:
>=20
> This patch seris started out as part of the THP patch set, but it has
> some nice effects along the way and it seems worth splitting it out =
and
> submitting separately.
>=20
> Currently find_get_entry() and find_lock_entry() return the page
> corresponding to the requested index, but the first thing most callers =
do
> is find the head page, which we just threw away.  As part of auditing
> all the callers, I found some misuses of the APIs and some plain
> inefficiencies that I've fixed.
>=20
> The diffstat is unflattering, but I added more kernel-doc.
>=20
> Matthew Wilcox (Oracle) (8):
>  mm: Factor find_get_swap_page out of mincore_page
>  mm: Use find_get_swap_page in memcontrol
>  mm: Optimise madvise WILLNEED
>  proc: Optimise smaps for shmem entries
>  i915: Use find_lock_page instead of find_lock_entry
>  mm: Convert find_get_entry to return the head page
>  mm: Return head page from find_lock_entry
>  mm: Hoist find_subpage call further up in pagecache_get_page
>=20
> drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  4 +--
> fs/proc/task_mmu.c                        |  8 +----
> include/linux/pagemap.h                   | 16 +++++++--
> include/linux/swap.h                      |  7 ++++
> mm/filemap.c                              | 41 +++++++++++------------
> mm/madvise.c                              | 21 +++++++-----
> mm/memcontrol.c                           | 25 ++------------
> mm/mincore.c                              | 28 ++--------------
> mm/shmem.c                                | 15 +++++----
> mm/swap_state.c                           | 31 +++++++++++++++++
> 10 files changed, 98 insertions(+), 98 deletions(-)

For the series:

Reviewed-by: William Kucharski <william.kucharski@oracle.com>=
