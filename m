Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43E5E1651D4
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2020 22:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgBSVlM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Feb 2020 16:41:12 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39526 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgBSVlM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Feb 2020 16:41:12 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JLd8nA160959;
        Wed, 19 Feb 2020 21:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=CQ02yU9L3CkVYagd27UoMk+0f7/E/ZNIr/nEAq4qgrw=;
 b=sxDHcG/yZ7tARteJZLWRhuw/VLnSv4leEPcXRJi3NZ+rCWIjaQvL9MA7Pqx5SAJgDXYf
 JYr+sc9bDHvQurCSebh7BiToCjjNSk2x/iBUElo6gEHtg12l1rMC4anPIQk8cKFjS5n5
 lNMbkVKIkoo9b8mCoDT3KGJaABUq2SFJ3rhdr9zLU5kckXRdAw1E+rlCvmLT+j3fe+v5
 be10TpttHzkVZWrrzO+n0arB/B2uHEMqu0b3IJFPcxlACUCRCxpIK1/pF3md66xyVuhf
 NWU+mptwvt9mBA1cIAOcFjYW4CXe1BwCEf6jXOTPmOLrdvXtncoRaLRu0VWQaiXjS0R3 mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2y8udd61ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 21:41:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01JLbrdH055467;
        Wed, 19 Feb 2020 21:41:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2y8ud49sjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 21:41:02 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01JLf0LX012739;
        Wed, 19 Feb 2020 21:41:01 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 13:40:59 -0800
Date:   Wed, 19 Feb 2020 16:41:12 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200219214112.4kt573kyzbvmbvn3@ca-dmjordan1.us.oracle.com>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <20200219183731.GC11847@dhcp22.suse.cz>
 <20200219191618.GB54486@cmpxchg.org>
 <20200219195332.GE11847@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219195332.GE11847@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9536 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190160
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 19, 2020 at 08:53:32PM +0100, Michal Hocko wrote:
> On Wed 19-02-20 14:16:18, Johannes Weiner wrote:
> > On Wed, Feb 19, 2020 at 07:37:31PM +0100, Michal Hocko wrote:
> > > On Wed 19-02-20 13:12:19, Johannes Weiner wrote:
> > > > This patch adds asynchronous reclaim to the memory.high cgroup limit
> > > > while keeping direct reclaim as a fallback. In our testing, this
> > > > eliminated all direct reclaim from the affected workload.
> > > 
> > > Who is accounted for all the work? Unless I am missing something this
> > > just gets hidden in the system activity and that might hurt the
> > > isolation. I do see how moving the work to a different context is
> > > desirable but this work has to be accounted properly when it is going to
> > > become a normal mode of operation (rather than a rare exception like the
> > > existing irq context handling).
> > 
> > Yes, the plan is to account it to the cgroup on whose behalf we're
> > doing the work.

How are you planning to do that?

I've been thinking about how to account a kernel thread's CPU usage to a cgroup
on and off while working on the parallelizing Michal mentions below.  A few
approaches are described here:

https://lore.kernel.org/linux-mm/20200212224731.kmss6o6agekkg3mw@ca-dmjordan1.us.oracle.com/

> shows that the amount of the work required for the high limit reclaim
> can be non-trivial. Somebody has to do that work and we cannot simply
> allow everybody else to pay for that.
> 
> > The problem is that we have a general lack of usable CPU control right
> > now - see Rik's work on this: https://lkml.org/lkml/2019/8/21/1208.
> > For workloads that are contended on CPU, we cannot enable the CPU
> > controller because the scheduling latencies are too high. And for
> > workloads that aren't CPU contended, well, it doesn't really matter
> > where the reclaim cycles are accounted to.
> > 
> > Once we have the CPU controller up to speed, we can add annotations
> > like these to account stretches of execution to specific
> > cgroups. There just isn't much point to do it before we can actually
> > enable CPU control on the real workloads where it would matter.

Which annotations do you mean?  I didn't see them when skimming through Rik's
work or in this patch.
