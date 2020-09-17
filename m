Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316AC26DEA1
	for <lists+cgroups@lfdr.de>; Thu, 17 Sep 2020 16:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgIQOpo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 10:45:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33746 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbgIQO1M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 10:27:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HEOcRI054131;
        Thu, 17 Sep 2020 14:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=kWMuOkBEzKmqnR4JA7GRFSVM89Mf8rcx6R9OK0t1o8o=;
 b=UxnoQld7c9iVJG+UWxCx8mzgw5093d2eAhT6slS9zZ9BOBcdTxqSrKXeSN7AZWpWxSSI
 DwuIP3mCnlVBi3NLzV57fDZiE/05TvYbuGWj4t9mcHd2PQfZLY3JrdnvthH2jirfby0T
 vipAmmtEyRoPQw1PoVrfdIKAJhrrBAFk/9/MSMpw0emMIjRWVZWre4042wPaDqW4u+wR
 uumXy8iVLJUra4z91dyam5tS7SvAQMycWLp1BZ4iq4NePorhpH7plhEtvEYAOQx1OHuG
 3QWQKherkVgBYwt3vreL9JdQGE1sR/EchO86PjffxRP7+tSNfz1pKQjpQijBKEXWBGu9 Gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 33j91du9v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 14:26:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HEOnfX140495;
        Thu, 17 Sep 2020 14:26:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 33h893vgpr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 14:26:25 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08HEQHlg020112;
        Thu, 17 Sep 2020 14:26:17 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Sep 2020 14:26:17 +0000
Date:   Thu, 17 Sep 2020 10:35:19 -0400
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
        shy828301@gmail.com, vbabka@suse.cz, minchan@kernel.org, cai@lca.pw
Subject: Re: [PATCH v18 00/32] per memcg lru_lock: reviews
Message-ID: <20200917143519.lhdfnoc47qrmbhaz@ca-dmjordan1.us.oracle.com>
References: <alpine.LSU.2.11.2008262301240.4405@eggly.anvils>
 <alpine.LSU.2.11.2009081640070.7256@eggly.anvils>
 <61a42a87-eec9-e300-f710-992756f70de6@linux.alibaba.com>
 <alpine.LSU.2.11.2009091524260.10087@eggly.anvils>
 <855ad6ee-dba4-9729-78bd-23e392905cf6@linux.alibaba.com>
 <alpine.LSU.2.11.2009111634020.22739@eggly.anvils>
 <5cfc6142-752d-26e6-0108-38d13009268b@linux.alibaba.com>
 <alpine.LSU.2.11.2009150112130.1550@eggly.anvils>
 <20200915165807.kpp7uhiw7l3loofu@ca-dmjordan1.us.oracle.com>
 <c3362c0a-3707-3a3d-9955-960d95f3ad8c@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3362c0a-3707-3a3d-9955-960d95f3ad8c@linux.alibaba.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009170113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170113
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 17, 2020 at 10:37:45AM +0800, Alex Shi wrote:
> 在 2020/9/16 上午12:58, Daniel Jordan 写道:
> > On Tue, Sep 15, 2020 at 01:21:56AM -0700, Hugh Dickins wrote:
> >> On Sun, 13 Sep 2020, Alex Shi wrote:
> >>> Uh, I updated the testing with some new results here:
> >>> https://lkml.org/lkml/2020/8/26/212
> >> Right, I missed that, that's better, thanks.  Any other test results?
> > Alex, you were doing some will-it-scale runs earlier.  Are you planning to do
> > more of those?  Otherwise I can add them in.
> 
> Hi Daniel,
> 
> Does compaction perf scalable, like thpscale, I except they could get some benefit.

Yep, I plan to stress compaction.  Reclaim as well.

I should have said which Alex I meant.  I was asking Alex Duyck since he'd done
some will-it-scale runs.
