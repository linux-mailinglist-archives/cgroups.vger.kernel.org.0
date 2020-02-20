Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 060C316613B
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 16:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgBTPp2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 10:45:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:46632 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgBTPp2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 10:45:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KFiIcd099708;
        Thu, 20 Feb 2020 15:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Y/mFiU18EBtEaH5OMEwxs9bxgqWYfXtQzQK0tFNuMzw=;
 b=XprjFRSGHt9YYCnNDTczDtIfli1Y+O0kphL/RPJ7I/vvYbyoTdaA1k7XDRwMMwTP/Ep1
 hbkicNFvU3h3mL1nxqwsStgwBHHm7xKuv8BRKCjsKk+/shspPr7QLuFwEga05GMILil/
 lpmK0g3v68WyUD6IVAGWlNImDuBofRSqpfwWBSRGnKDCDKSIpZPmC0qftkTCdsqfLEAo
 TTpib+H965bQ77e7+qK1sTetoeqCydFYn9Azer0fHM66/tQASZ+b18g7ApOtSYIhbNWx
 mD1DK+7ka2X3aQXR0sRZBnAEtPzBjuEAkon+WWWtdBYiTr7m9rxkevDzDEHyreVlaHn6 lQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2y8ud1ahwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 15:45:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KFfeTV191382;
        Thu, 20 Feb 2020 15:45:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2y8ud435jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 15:45:12 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01KFj7WR029782;
        Thu, 20 Feb 2020 15:45:07 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 07:45:07 -0800
Date:   Thu, 20 Feb 2020 10:45:24 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200220154524.dql3i5brnjjwecft@ca-dmjordan1.us.oracle.com>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <20200219183731.GC11847@dhcp22.suse.cz>
 <20200219191618.GB54486@cmpxchg.org>
 <20200219195332.GE11847@dhcp22.suse.cz>
 <20200219214112.4kt573kyzbvmbvn3@ca-dmjordan1.us.oracle.com>
 <20200219220859.GF54486@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219220859.GF54486@cmpxchg.org>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200115
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

+Peter

On Wed, Feb 19, 2020 at 05:08:59PM -0500, Johannes Weiner wrote:
> On Wed, Feb 19, 2020 at 04:41:12PM -0500, Daniel Jordan wrote:
> > On Wed, Feb 19, 2020 at 08:53:32PM +0100, Michal Hocko wrote:
> > > On Wed 19-02-20 14:16:18, Johannes Weiner wrote:
> > > > On Wed, Feb 19, 2020 at 07:37:31PM +0100, Michal Hocko wrote:
> > > > > On Wed 19-02-20 13:12:19, Johannes Weiner wrote:
> > > > > > This patch adds asynchronous reclaim to the memory.high cgroup limit
> > > > > > while keeping direct reclaim as a fallback. In our testing, this
> > > > > > eliminated all direct reclaim from the affected workload.
> > > > > 
> > > > > Who is accounted for all the work? Unless I am missing something this
> > > > > just gets hidden in the system activity and that might hurt the
> > > > > isolation. I do see how moving the work to a different context is
> > > > > desirable but this work has to be accounted properly when it is going to
> > > > > become a normal mode of operation (rather than a rare exception like the
> > > > > existing irq context handling).
> > > > 
> > > > Yes, the plan is to account it to the cgroup on whose behalf we're
> > > > doing the work.
> > 
> > How are you planning to do that?
> > 
> > I've been thinking about how to account a kernel thread's CPU usage to a cgroup
> > on and off while working on the parallelizing Michal mentions below.  A few
> > approaches are described here:
> > 
> > https://lore.kernel.org/linux-mm/20200212224731.kmss6o6agekkg3mw@ca-dmjordan1.us.oracle.com/
> 
> What we do for the IO controller is execute the work unthrottled but
> charge the cgroup on whose behalf we are executing with whatever cost
> or time or bandwith that was incurred. The cgroup will pay off this
> debt when it requests more of that resource.
>
[snip code pointers]

Thanks!  Figuring out how the io controllers dealt with remote charging was on
my list, this makes it easier.

> The plan for the CPU controller is similar. When a remote execution
> begins, flush the current runtime accumulated (update_curr) and
> associate the current thread with another cgroup (similar to
> current->active_memcg); when remote execution is done, flush the
> runtime delta to that cgroup and unset the remote context.

Ok, consistency with io and memory is one advantage to doing it that way.
Creating kthreads in cgroups also seems viable so far, and it's unclear whether
either approach is significantly simpler or more maintainable than the other,
at least to me.

Is someone on your side working on remote charging right now?  I was planning
to post an RFD comparing these soon and it would make sense to include them.
