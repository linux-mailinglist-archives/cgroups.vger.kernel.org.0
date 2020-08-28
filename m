Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA29A25528C
	for <lists+cgroups@lfdr.de>; Fri, 28 Aug 2020 03:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgH1BcC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Aug 2020 21:32:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38240 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgH1BcB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Aug 2020 21:32:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07S1TNrG195014;
        Fri, 28 Aug 2020 01:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=EE+MmSN3lbKnbvXBOhbYoQLeslJjSSgBP3XNEkQXgRQ=;
 b=KaSLqjJzENC36uaJMTkyhzgDkJ2KfQYLgzCz13xV15ZAZNT3+Y0xu9qgW9r6Uaf/gAhP
 p/lDkVi37vjz1X3j21WaOz3VEhVh+uLP7I5oV7vvRDXfw/0shmbpmn74a0y+4tP4xjqU
 x3aRGOIZW84msVY3kmzWTdP6c+eog5WiX3mRnth7Bd2ounWU/NfOFYXYmevJ5GQm0nWt
 ddMGf7ZSwZU52zu6MbpKxP5wvtfEqQl+OK/U3aaOvsGYwAPWZyczKh+77vwYt67QWAO1
 TObjUYzMQoddfUC8VNxwIAWvWeZzTcpoza+wl4TrPOCUu9X/cC/mcl+RtAUKi2r372IV eA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 333w6u80tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Aug 2020 01:31:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07S1OkL1149469;
        Fri, 28 Aug 2020 01:31:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 333ru26er1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Aug 2020 01:31:30 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07S1VNnd020001;
        Fri, 28 Aug 2020 01:31:25 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Aug 2020 18:31:23 -0700
Date:   Thu, 27 Aug 2020 21:40:22 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, willy@infradead.org, hannes@cmpxchg.org,
        lkp@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
Subject: Re: [PATCH v18 00/32] per memcg lru_lock
Message-ID: <20200828014022.y5xju6weysqpzxd2@ca-dmjordan1.us.oracle.com>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
 <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
 <20200825015627.3c3pnwauqznnp3gc@ca-dmjordan1.us.oracle.com>
 <ec62a835-f79d-2b8c-99c7-120834703b42@linux.alibaba.com>
 <20200826011946.spknwjt44d2szrdo@ca-dmjordan1.us.oracle.com>
 <01ed6e45-3853-dcba-61cb-b429a49a7572@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01ed6e45-3853-dcba-61cb-b429a49a7572@linux.alibaba.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008280011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008280011
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 26, 2020 at 04:59:28PM +0800, Alex Shi wrote:
> I clean up my testing and make it reproducable by a Dockerfile and a case patch which
> attached. 

Ok, I'll give that a shot once I've taken care of sysbench.

> >>> Even better would be a description of the problem you're having in production
> >>> with lru_lock.  We might be able to create at least a simulation of it to show
> >>> what the expected improvement of your real workload is.
> >>
> >> we are using thousands memcgs in a machine, but as a simulation, I guess above case
> >> could be helpful to show the problem.
> > 
> > Using thousands of memcgs to do what?  Any particulars about the type of
> > workload?  Surely it's more complicated than page cache reads :)
> 
> Yes, the workload are quit different on different business, some use cpu a
> lot, some use memory a lot, and some are may mixed.

That's pretty vague, but I don't suppose I could do much better describing what
all runs on our systems  :-/

I went back to your v1 post to see what motivated you originally, and you had
some results from aim9 but nothing about where this reared its head in the
first place.  How did you discover the bottleneck?  I'm just curious about how
lru_lock hurts in practice.

> > Neither kernel compile nor git checkout in the root cgroup changed much, just
> > 0.31% slower on elapsed time for the compile, so no significant regressions
> > there.  Now for sysbench again.

Still working on getting repeatable sysbench runs, no luck so far.  The numbers
have stayed fairly consistent with your series but vary a lot on the base
kernel, not sure why yet.
