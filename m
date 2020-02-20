Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8019166626
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 19:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgBTSZr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 13:25:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53868 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTSZr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 13:25:47 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KIDOiU057489;
        Thu, 20 Feb 2020 18:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=MfkDo7F3aCv5MhbXyV3vcG34vepcUBqfArK40IWMSPM=;
 b=ehED6/brb3OLIlpBCDLQ8RVkzqfWWwGBQzMe5/iZiWEPtp6S/SrP2QtpAUOhXBD/nJW3
 nK+7VZyUtcJpus9B9TOiUgyunJ5eXfP/yip64KVp6ApVzTmHzqKgdXZS93qN3uGRAvaE
 SPIeqGF9hwL5t2z8o2Gnnh4mPl8Yjiaf2TwOo1/zAoPGPiyksfy4sa/+WnA8Du/btm7f
 /G/QxgOuRGFcxgg7HTZq4owWLjVCQjGSw0SJ7aXzhyAH8moJodX+KFz7LRuMtQeRUmNT
 3d3czrmcD0EUdXWaDeqPVdLP0JstG5l9g3O2A1i+re25xPZkGfbLuYrmbIVzxxrd79Wb fA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2y8udkkm3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 18:25:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KIBhYf089964;
        Thu, 20 Feb 2020 18:23:13 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2y8ud4dwew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 18:23:13 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01KIN9fb032081;
        Thu, 20 Feb 2020 18:23:10 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 10:23:09 -0800
Date:   Thu, 20 Feb 2020 13:23:26 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200220182326.ubcjycaubgykiy6e@ca-dmjordan1.us.oracle.com>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <20200219183731.GC11847@dhcp22.suse.cz>
 <20200219191618.GB54486@cmpxchg.org>
 <20200219195332.GE11847@dhcp22.suse.cz>
 <20200219214112.4kt573kyzbvmbvn3@ca-dmjordan1.us.oracle.com>
 <20200219220859.GF54486@cmpxchg.org>
 <20200220154524.dql3i5brnjjwecft@ca-dmjordan1.us.oracle.com>
 <20200220155651.GG698990@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220155651.GG698990@mtj.thefacebook.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200135
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 20, 2020 at 10:56:51AM -0500, Tejun Heo wrote:
> On Thu, Feb 20, 2020 at 10:45:24AM -0500, Daniel Jordan wrote:
> > Ok, consistency with io and memory is one advantage to doing it that way.
> > Creating kthreads in cgroups also seems viable so far, and it's unclear whether
> > either approach is significantly simpler or more maintainable than the other,
> > at least to me.
> 
> The problem with separate kthread approach is that many of these work
> units are tiny, and cgroup membership might not be known or doesn't
> agree with the processing context from the beginning

The amount of work wouldn't seem to matter as long as the kernel thread stays
in the cgroup and lives long enough.  There's only the one-time cost of
attaching it when it's forked.  That seems doable for unbound workqueues (the
async reclaim), but may not be for the network packets.

The membership and context issues are pretty compelling though.  Good to know,
I'll keep it in mind as I think this through.

> For example, the ownership of network packets can't be determined till
> processing has progressed quite a bit in shared contexts and each item
> too small to bounce around. The only viable way I can think of
> splitting aggregate overhead according to the number of packets (or
> some other trivially measureable quntity) processed.
> 
> Anything sitting in reclaim layer is the same. Reclaim should be
> charged to the cgroup whose memory is reclaimed *but* shouldn't block
> other cgroups which are waiting for that memory. It has to happen in
> the context of the highest priority entity waiting for memory but the
> costs incurred must be charged to the memory owners.
> 
> So, one way or the other, I think we'll need back charging and once
> back charging is needed for big ticket items like network and reclaim,
> it's kinda silly to use separate mechanisms for other stuff.

Yes, having both would appear to be redundant.

> > Is someone on your side working on remote charging right now?  I was planning
> > to post an RFD comparing these soon and it would make sense to include them.
> 
> It's been on the to do list but nobody is working on it yet.

Ok, thanks.
