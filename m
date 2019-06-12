Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1153448B7
	for <lists+cgroups@lfdr.de>; Thu, 13 Jun 2019 19:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfFMRKy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jun 2019 13:10:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38324 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbfFLWdJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jun 2019 18:33:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CMTs85064050;
        Wed, 12 Jun 2019 22:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=SOIVm550t2juiTj4vnRQ5BaJ/KWVoCF7DZnOrZI0vno=;
 b=lhk5qU4z4GwfZqTKR5mbk79cDQzaoJ563ewToos4HaKC4mOW42ZuJj4rIKQuuXEL39VM
 tp4ZtszcjEpWB2WzalUsZvkf7EoQ4QcnxIQ2Qft1s6ZYSRtjhbym4uydGIVYMvhQvAHw
 fRHwYoG8GoVcSmHkzJ6QvWx2AS/Jpc3PwZV8EssJZG84yCzFBaQYH11ADbuo9e/H9WzV
 gBEoPFk2imAOKNWZH8Ol5/pQ2PTjvdP/f1tgifVJKX2HZGYVJYPuqPyaHLVwju+kvqVN
 3IYSt5eHrO4z++6UFpnrsjBUDs0k5Ev4rGF32Mx66rhmqD9/GhvxdpAvARzyeKXqVnkG 1A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t04etx9bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 22:31:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5CMSCmx113818;
        Wed, 12 Jun 2019 22:29:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t0p9s3x41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 22:29:47 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5CMTW3r019311;
        Wed, 12 Jun 2019 22:29:39 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Jun 2019 15:29:32 -0700
Date:   Wed, 12 Jun 2019 18:29:34 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, hannes@cmpxchg.org,
        jiangshanlai@gmail.com, lizefan@huawei.com, bsd@redhat.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        juri.lelli@redhat.com, mhocko@kernel.org, peterz@infradead.org,
        steven.sistare@oracle.com, tglx@linutronix.de,
        tom.hromatka@oracle.com, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, shakeelb@google.com
Subject: Re: [RFC v2 0/5] cgroup-aware unbound workqueues
Message-ID: <20190612222934.y74wxy3aju6eqs4r@ca-dmjordan1.us.oracle.com>
References: <20190605133650.28545-1-daniel.m.jordan@oracle.com>
 <20190605135319.GK374014@devbig004.ftw2.facebook.com>
 <20190605153229.nvxr6j7tdzffwkgj@ca-dmjordan1.us.oracle.com>
 <20190611195549.GL3341036@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611195549.GL3341036@devbig004.ftw2.facebook.com>
User-Agent: NeoMutt/20180323-268-5a959c
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906120157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9286 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120157
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jun 11, 2019 at 12:55:49PM -0700, Tejun Heo wrote:
> > > CPU doesn't have a backcharging mechanism yet and depending on the use
> > > case, we *might* need to put kthreads in different cgroups.  However,
> > > such use cases might not be that abundant and there may be gotaches
> > > which require them to be force-executed and back-charged (e.g. fs
> > > compression from global reclaim).
> > 
> > The CPU-intensiveness of these works is one of the reasons for actually putting
> > the workers through the migration path.  I don't know of a way to get the
> > workers to respect the cpu controller (and even cpuset for that matter) without
> > doing that.
> 
> So, I still think it'd likely be better to go back-charging route than
> actually putting kworkers in non-root cgroups.  That's gonna be way
> cheaper, simpler and makes avoiding inadvertent priority inversions
> trivial.

Ok, I'll experiment with backcharging in the cpu controller.  Initial plan is
to smooth out resource usage by backcharging after each chunk of work that each
helper thread does rather than do one giant backcharge after the multithreaded
job is over.  May turn out better performance-wise to do it less often than
this.

I'll also experiment with getting workqueue workers to respect cpuset without
migrating.  Seems to make sense to use the intersection of an unbound worker's
cpumask and the cpuset's cpumask, and make some compromises if the result is
empty.

Daniel
