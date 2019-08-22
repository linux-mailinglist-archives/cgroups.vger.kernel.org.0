Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 046329981B
	for <lists+cgroups@lfdr.de>; Thu, 22 Aug 2019 17:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbfHVP0F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Aug 2019 11:26:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56738 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbfHVP0F (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Aug 2019 11:26:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7MF4Mx0087310;
        Thu, 22 Aug 2019 15:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=1L5ER/qHk23OYtUxN07nDgRdnfnZxx2DF63Rw066TEU=;
 b=TUTU2NnUGOh4xD4o+ekU6weirf9jpHf+pLiY1Q/982QWFCZeo0muWZqUzEIst9mmeX2G
 tvc1KCLIMJv2FqopEsyv9HxiinVifeIFZCOgOXpieTlIyE8BeQT5DXBbUeH9BA0GC9f6
 SkWbP7KPLFpzj68lv1OfKaMVHRSLAvsoHzQarkWQyeeglWf6MzaDzBMcVo8CHqrA0PWn
 gC9SiP1VTgkabkM2NZBe6va8+EacRo3aq8PzjlZ90Q57mH9CIy9gYUV1DMDBTWHFVliT
 W7QWqT+hSJMIQ8GpYi/X7nlE+ViJU+0yCyasx6cEh9hTVifRdlge73HeEEwcgwfEymcU sA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ue90txm3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 15:20:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7MF3xeU179464;
        Thu, 22 Aug 2019 15:20:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2uhusembk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 15:20:55 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7MFKrjU013736;
        Thu, 22 Aug 2019 15:20:54 GMT
Received: from [192.168.1.219] (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Aug 2019 15:20:53 +0000
Subject: Re: [PATCH 00/14] per memcg lru_lock
To:     Alex Shi <alex.shi@linux.alibaba.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>
References: <1566294517-86418-1-git-send-email-alex.shi@linux.alibaba.com>
 <6ba1ffb0-fce0-c590-c373-7cbc516dbebd@oracle.com>
 <348495d2-b558-fdfd-a411-89c75d4a9c78@linux.alibaba.com>
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
Message-ID: <b776032e-eabb-64ff-8aee-acc2b3711717@oracle.com>
Date:   Thu, 22 Aug 2019 11:20:52 -0400
MIME-Version: 1.0
In-Reply-To: <348495d2-b558-fdfd-a411-89c75d4a9c78@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9356 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908220150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9356 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908220150
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/22/19 7:56 AM, Alex Shi wrote:
> 在 2019/8/22 上午2:00, Daniel Jordan 写道:
>>    https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice>
>> It's also synthetic but it stresses lru_lock more than just anon alloc/free.  It hits the page activate path, which is where we see this lock in our database, and if enough memory is configured lru_lock also gets stressed during reclaim, similar to [1].
> 
> Thanks for the sharing, this patchset can not help the [1] case, since it's just relief the per container lock contention now.

I should've been clearer.  [1] is meant as an example of someone suffering from lru_lock during reclaim.  Wouldn't your series help per-memcg reclaim?

> Yes, readtwice case could be more sensitive for this lru_lock changes in containers. I may try to use it in container with some tuning. But anyway, aim9 is also pretty good to show the problem and solutions. :)
>>
>> It'd be better though, as Michal suggests, to use the real workload that's causing problems.  Where are you seeing contention?
> 
> We repeatly create or delete a lot of different containers according to servers load/usage, so normal workload could cause lots of pages alloc/remove. 

I think numbers from that scenario would help your case.

> aim9 could reflect part of scenarios. I don't know the DB scenario yet.

We see it during DB shutdown when each DB process frees its memory (zap_pte_range -> mark_page_accessed).  But that's a different thing, clearly Not This Series.

>>> With this patch series, lruvec->lru_lock show no contentions
>>>           &(&lruvec->lru_l...          8          0               0       0               0               0
>>>
>>> and aim9 page_test/brk_test performance increased 5%~50%.
>>
>> Where does the 50% number come in?  The numbers below seem to only show ~4% boost.
> 
> the Setddev/CoeffVar case has about 50% performance increase. one of container's mmtests result as following:
> 
> Stddev    page_test      245.15 (   0.00%)      189.29 (  22.79%)
> Stddev    brk_test      1258.60 (   0.00%)      629.16 (  50.01%)
> CoeffVar  page_test        0.71 (   0.00%)        0.53 (  26.05%)
> CoeffVar  brk_test         1.32 (   0.00%)        0.64 (  51.14%)

Aha.  50% decrease in stdev.
