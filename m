Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE512524F1
	for <lists+cgroups@lfdr.de>; Wed, 26 Aug 2020 03:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHZBLa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Aug 2020 21:11:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48068 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgHZBL2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Aug 2020 21:11:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07Q1A691044031;
        Wed, 26 Aug 2020 01:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=VWKaRWmTmrlTrbnIky0PuQ3aZ0bL/HrXLsBsMQQqZo4=;
 b=jQNvNVHYVl0Oq89XEgsmuaLNiJpGZJT9brk12EKPFxStCdsik5I4IBEl6Bg/H3NtYf2Z
 cmzX1sVKVAwMR/9dtkl5+JbbWT934jfcpvNxDywlgqCg51YQs0e0n9qAHlHsLQ5ihWaP
 jfDlzlh4U6ZT4v89eaYGfzPPP/w9t5HO2yAgiNyJ1PgteJXcHlLGZW6e7NrjGNIVpSeB
 lU7mwgsqKocBkjf4K5fjzhl9uxqclIjlOPIoYhiqdyWwa04NYvZW7c+F0nPNNYYZ4/rV
 FMmXYE4rJEyLxS6Vur9iT/YFuDO8s0NbT0Q+rWL/Ni1XlHheonNF35vprX/YllYb3zk6 rA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 333w6tv73f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 01:10:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07Q1AC7X034251;
        Wed, 26 Aug 2020 01:10:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 333ru8x57n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Aug 2020 01:10:54 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07Q1AnBB002426;
        Wed, 26 Aug 2020 01:10:49 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Aug 2020 18:10:48 -0700
Date:   Tue, 25 Aug 2020 21:19:46 -0400
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
Message-ID: <20200826011946.spknwjt44d2szrdo@ca-dmjordan1.us.oracle.com>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
 <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
 <20200825015627.3c3pnwauqznnp3gc@ca-dmjordan1.us.oracle.com>
 <ec62a835-f79d-2b8c-99c7-120834703b42@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec62a835-f79d-2b8c-99c7-120834703b42@linux.alibaba.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260007
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008260006
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 25, 2020 at 11:26:58AM +0800, Alex Shi wrote:
> 在 2020/8/25 上午9:56, Daniel Jordan 写道:
> > Alex, do you have a pointer to the modified readtwice case?
> 
> Sorry, no. my developer machine crashed, so I lost case my container and modified
> case. I am struggling to get my container back from a account problematic repository. 
> 
> But some testing scripts is here, generally, the original readtwice case will
> run each of threads on each of cpus. The new case will run one container on each cpus,
> and just run one readtwice thead in each of containers.

Ok, what you've sent so far gives me an idea of what you did.  My readtwice
changes were similar, except I used the cgroup interface directly instead of
docker and shared a filesystem between all the cgroups whereas it looks like
you had one per memcg.  30 second runs on 5.9-rc2 and v18 gave 11% more data
read with v18.  This was using 16 cgroups (32 dd tasks) on a 40 CPU, 2 socket
machine.

> > Even better would be a description of the problem you're having in production
> > with lru_lock.  We might be able to create at least a simulation of it to show
> > what the expected improvement of your real workload is.
> 
> we are using thousands memcgs in a machine, but as a simulation, I guess above case
> could be helpful to show the problem.

Using thousands of memcgs to do what?  Any particulars about the type of
workload?  Surely it's more complicated than page cache reads :)

> > I ran a few benchmarks on v17 last week (sysbench oltp readonly, kerndevel from
> > mmtests, a memcg-ized version of the readtwice case I cooked up) and then today
> > discovered there's a chance I wasn't running the right kernels, so I'm redoing
> > them on v18.

Neither kernel compile nor git checkout in the root cgroup changed much, just
0.31% slower on elapsed time for the compile, so no significant regressions
there.  Now for sysbench again.
