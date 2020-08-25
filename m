Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5611F250E5A
	for <lists+cgroups@lfdr.de>; Tue, 25 Aug 2020 03:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgHYBsJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 21:48:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46950 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgHYBsI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Aug 2020 21:48:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07P1j56S075916;
        Tue, 25 Aug 2020 01:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=LY6QXv+QQJLtDU1fswIE+NA2N2Om8CrOP23/sePbiW8=;
 b=OwaW/7vjdlu4dZ2+5+N3MgPoSuzJUxwXHWtbSOxWsbYuaWRd8Ln2Ody6DRZV6e2Ni31r
 2UMtKxyKirqtXL3TooNaAIVz4wgGcIXNcutvALRVEoFq0RQ6maIyOzvGdvM4O4PR2Nk8
 4qNHXEGT/qhmZajoaUOQ+bXYpUjTGuxmnmHyg6x1zFrV5xYCqpRm8oD+A8rWfCft7CAQ
 ucipuE5IUKM+vFQSC320Adm9gKKm8E6G/DT+61vRnGp5qG6LOsMJKl1WdDn5wGKtRUKN
 SMNf23y35k8D4MP3PeERkJ/B9qZoZSMuvdGs3jQPAqDehH+gzFH2yFH9rVXtQAGq8ZaR Gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 333cshys3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 01:47:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07P1jGBD104605;
        Tue, 25 Aug 2020 01:47:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 333r9hxvdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 01:47:35 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07P1lTl7006007;
        Tue, 25 Aug 2020 01:47:29 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Aug 2020 18:47:28 -0700
Date:   Mon, 24 Aug 2020 21:56:27 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
Subject: Re: [PATCH v18 00/32] per memcg lru_lock
Message-ID: <20200825015627.3c3pnwauqznnp3gc@ca-dmjordan1.us.oracle.com>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
 <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250013
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 24, 2020 at 01:24:20PM -0700, Hugh Dickins wrote:
> On Mon, 24 Aug 2020, Andrew Morton wrote:
> > On Mon, 24 Aug 2020 20:54:33 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:
> Andrew demurred on version 17 for lack of review.  Alexander Duyck has
> been doing a lot on that front since then.  I have intended to do so,
> but it's a mirage that moves away from me as I move towards it: I have

Same, I haven't been able to keep up with the versions or the recent review
feedback.  I got through about half of v17 last week and hope to have more time
for the rest this week and beyond.

> > > Following Daniel Jordan's suggestion, I have run 208 'dd' with on 104
> > > containers on a 2s * 26cores * HT box with a modefied case:

Alex, do you have a pointer to the modified readtwice case?

Even better would be a description of the problem you're having in production
with lru_lock.  We might be able to create at least a simulation of it to show
what the expected improvement of your real workload is.

> > > https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice
> > > With this patchset, the readtwice performance increased about 80%
> > > in concurrent containers.
> > 
> > That's rather a slight amount of performance testing for a huge
> > performance patchset!
> 
> Indeed.  And I see that clause about readtwice performance increased 80%
> going back eight months to v6: a lot of fundamental bugs have been fixed
> in it since then, so I do think it needs refreshing.  It could be faster
> now: v16 or v17 fixed the last bug I knew of, which had been slowing
> down reclaim considerably.
> 
> When I last timed my repetitive swapping loads (not loads anyone sensible
> would be running with), across only two memcgs, Alex's patchset was
> slightly faster than without: it really did make a difference.  But
> I tend to think that for all patchsets, there exists at least one
> test that shows it faster, and another that shows it slower.
> 
> > Is more detailed testing planned?
> 
> Not by me, performance testing is not something I trust myself with,
> just get lost in the numbers: Alex, this is what we hoped for months
> ago, please make a more convincing case, I hope Daniel and others
> can make more suggestions.  But my own evidence suggests it's good.

I ran a few benchmarks on v17 last week (sysbench oltp readonly, kerndevel from
mmtests, a memcg-ized version of the readtwice case I cooked up) and then today
discovered there's a chance I wasn't running the right kernels, so I'm redoing
them on v18.  Plan to look into what other, more "macro" tests would be
sensitive to these changes.
