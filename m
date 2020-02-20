Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA241667B3
	for <lists+cgroups@lfdr.de>; Thu, 20 Feb 2020 20:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgBTTzh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 14:55:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49684 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgBTTzh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 14:55:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KJms1Z022382;
        Thu, 20 Feb 2020 19:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=Oeqn/msELu44gc9TzxVpdR7IAGtxbC8EWYVF6nQT3jA=;
 b=k3zCKzyqek3pblqv98woSoLvFhc6jomamI50XiH6WcMl8o/NKBWg5FP45OC9wyyrA8DZ
 ewFwmrXB+/8Y/yEIhisarEHRnQCQ+Ugt/IOlO3UjjyzBotUQYa6Ih8LpO+fW45LQGa3h
 PHPNVxuiiUTWkbYIFAgC45rzzcmR3+1pqy4kfOevEf5bAxFt41h/4rAI53vYFRVikvpG
 M+C0OyuOz2qtmZkavplVeLA9HFE9h4AsybtU8FmZCOqN2ZGwoD4vg4dzehCeYnUH75I2
 wPiJuEOFoOAwFaH5ry2l8yosH4bV1KBA8GxHwjjrqJJ12nR6424UoBgU0LYqbtR/f09o 4Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2y8uddc447-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 19:55:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01KJm6Bb100952;
        Thu, 20 Feb 2020 19:55:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2y8ud6v9fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 19:55:25 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01KJtIre029033;
        Thu, 20 Feb 2020 19:55:21 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Feb 2020 11:55:18 -0800
Date:   Thu, 20 Feb 2020 14:55:35 -0500
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
Message-ID: <20200220195535.7xblt45akld6eftj@ca-dmjordan1.us.oracle.com>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <20200219183731.GC11847@dhcp22.suse.cz>
 <20200219191618.GB54486@cmpxchg.org>
 <20200219195332.GE11847@dhcp22.suse.cz>
 <20200219214112.4kt573kyzbvmbvn3@ca-dmjordan1.us.oracle.com>
 <20200219220859.GF54486@cmpxchg.org>
 <20200220154524.dql3i5brnjjwecft@ca-dmjordan1.us.oracle.com>
 <20200220155651.GG698990@mtj.thefacebook.com>
 <20200220182326.ubcjycaubgykiy6e@ca-dmjordan1.us.oracle.com>
 <20200220184545.GH698990@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220184545.GH698990@mtj.thefacebook.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=694 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9537 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=757 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200143
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 20, 2020 at 01:45:45PM -0500, Tejun Heo wrote:
> The setup cost can be lazy optimized but it'd still have to bounce the
> tiny pieces of work to different threads instead of processing them in
> one fell swoop from the same context, which most likely is gonna be
> untenably expensive.

I see, your last mail is clearer now.  If it's easy to do, a pointer to where
this happens would help so we're on the same page.

thanks,
Daniel
