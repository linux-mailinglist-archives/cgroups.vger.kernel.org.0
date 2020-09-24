Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F14227781B
	for <lists+cgroups@lfdr.de>; Thu, 24 Sep 2020 19:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIXR55 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Sep 2020 13:57:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47172 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIXR54 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Sep 2020 13:57:56 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OHdeXw043526;
        Thu, 24 Sep 2020 17:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=sTe/AJzO+UfHAwr5VOeTgdvnXkA/n59xJAOM5IbcEc8=;
 b=kg7d/8XYOQ7CPul1Wwc32fageERVC+VIwQP+pZi5qWbQFXUSSUF2lleQTvyn7DgJZfI6
 yBqGr1eQERXG9LvSXlF5g4rIRTwSoU3bBLCdmkrBfkY8AWdXijg244gzkK+qMpPxKbh0
 wbH6GPIlwtQoXZlbbgfLHMXy2b1KzkhS0dnwAD0x+ythNoBD/uXNxECZIumYt+Mb1CjH
 3ns01kbmFJDfKibP9Th8KCIu/hsKnUwa7urhrdpFJ+zgzkndAi2+QQ92ZVtu35+Y338k
 MIDWFOVvGJCsopYIJ5r7H7pTUKTeuXDeGZFLnkhaq3Kw9MJrSPiJz1qMeImwSZtuWLOo cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 33qcpu6p7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 17:57:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OHfT9X161616;
        Thu, 24 Sep 2020 17:57:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 33nux35yy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 17:57:20 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08OHvGQ8030731;
        Thu, 24 Sep 2020 17:57:17 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 10:57:16 -0700
Date:   Thu, 24 Sep 2020 14:06:21 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com, aaron.lwe@gmail.com
Subject: Re: [PATCH v19 00/20] per memcg lru_lock
Message-ID: <20200924180621.2r62kv4lumnry4zm@ca-dmjordan1.us.oracle.com>
References: <1600918115-22007-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600918115-22007-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=2 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240131
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 24, 2020 at 11:28:15AM +0800, Alex Shi wrote:
> The new version rebased on v5.9-rc6 with line by line review by Hugh Dickins.

These thpscale numbers are from a proto-v19, which now seems to be gone from
Alex Shi's github.  Once again, this is a regression test where memcg is
enabled but not used.  There's a reasonable amount of isolations from
compaction as expected, as well as reclaim to a lesser extent.

I confined the runs to one node of a two-socket broadwell server, the same
machine as my other results.  thpscale's total_size argument is about 80% of
the node's memory, its madvise option was enabled, and the system's thp
settings are enabled=always and defrag=madvise.

Both base and lru kernels show huge variance run to run, which is surprising
because I was expecting a microbenchmark like this to be more stable.  There
seems to be an overall decrease in mean fault latency with the lru changes, but
it's in the noise, so it's hard to say how much of an improvement it really is.

I only ran up to four threads so these would be ready before I left.  I'll be
away for a few days.


thpscale Fault Latencies
                                          thp                    thp                    thp                    thp
                                        base1                  base2                   lru1                   lru2
Min       fault-base-1        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
Min       fault-base-3        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
Min       fault-base-4        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
Min       fault-huge-1      214.00 (   0.00%)      227.00 (  -6.07%)      235.00 (  -9.81%)      240.00 ( -12.15%)
Min       fault-huge-3      321.00 (   0.00%)      366.00 ( -14.02%)      323.00 (  -0.62%)      407.00 ( -26.79%)
Min       fault-huge-4      441.00 (   0.00%)      401.00 (   9.07%)      525.00 ( -19.05%)      434.00 (   1.59%)
Min       fault-both-1      214.00 (   0.00%)      227.00 (  -6.07%)      235.00 (  -9.81%)      240.00 ( -12.15%)
Min       fault-both-3      321.00 (   0.00%)      366.00 ( -14.02%)      323.00 (  -0.62%)      407.00 ( -26.79%)
Min       fault-both-4      441.00 (   0.00%)      401.00 (   9.07%)      525.00 ( -19.05%)      434.00 (   1.59%)
Amean     fault-base-1        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
Amean     fault-base-3        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
Amean     fault-base-4        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
Amean     fault-huge-1     1549.55 (   0.00%)     1667.13 *  -7.59%*     1361.50 *  12.14%*     1458.10 *   5.90%*
Amean     fault-huge-3     2582.29 (   0.00%)     2556.45 (   1.00%)     2756.65 *  -6.75%*     2157.29 *  16.46%*
Amean     fault-huge-4     2352.21 (   0.00%)     2709.37 * -15.18%*     2323.89 (   1.20%)     1888.94 *  19.69%*
Amean     fault-both-1     1549.55 (   0.00%)     1667.13 *  -7.59%*     1361.50 *  12.14%*     1458.10 *   5.90%*
Amean     fault-both-3     2582.29 (   0.00%)     2556.45 (   1.00%)     2756.65 *  -6.75%*     2157.29 *  16.46%*
Amean     fault-both-4     2352.21 (   0.00%)     2709.37 * -15.18%*     2323.89 (   1.20%)     1888.94 *  19.69%*
Stddev    fault-base-1        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
Stddev    fault-base-3        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
Stddev    fault-base-4        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
Stddev    fault-huge-1     2011.48 (   0.00%)     3765.64 ( -87.21%)     3061.45 ( -52.20%)     1758.56 (  12.57%)
Stddev    fault-huge-3    11153.49 (   0.00%)     8339.83 (  25.23%)     7017.28 (  37.08%)     3976.86 (  64.34%)
Stddev    fault-huge-4     8817.67 (   0.00%)    16241.48 ( -84.19%)    11595.28 ( -31.50%)     6631.47 (  24.79%)
Stddev    fault-both-1     2011.48 (   0.00%)     3765.64 ( -87.21%)     3061.45 ( -52.20%)     1758.56 (  12.57%)
Stddev    fault-both-3    11153.49 (   0.00%)     8339.83 (  25.23%)     7017.28 (  37.08%)     3976.86 (  64.34%)
Stddev    fault-both-4     8817.67 (   0.00%)    16241.48 ( -84.19%)    11595.28 ( -31.50%)     6631.47 (  24.79%)
CoeffVar  fault-base-1        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
CoeffVar  fault-base-3        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
CoeffVar  fault-base-4        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
CoeffVar  fault-huge-1      129.81 (   0.00%)      225.88 ( -74.00%)      224.86 ( -73.22%)      120.61 (   7.09%)
CoeffVar  fault-huge-3      431.92 (   0.00%)      326.23 (  24.47%)      254.56 (  41.06%)      184.35 (  57.32%)
CoeffVar  fault-huge-4      374.87 (   0.00%)      599.46 ( -59.91%)      498.96 ( -33.10%)      351.07 (   6.35%)
CoeffVar  fault-both-1      129.81 (   0.00%)      225.88 ( -74.00%)      224.86 ( -73.22%)      120.61 (   7.09%)
CoeffVar  fault-both-3      431.92 (   0.00%)      326.23 (  24.47%)      254.56 (  41.06%)      184.35 (  57.32%)
CoeffVar  fault-both-4      374.87 (   0.00%)      599.46 ( -59.91%)      498.96 ( -33.10%)      351.07 (   6.35%)
Max       fault-base-1        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
Max       fault-base-3        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
Max       fault-base-4        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
Max       fault-huge-1    90549.00 (   0.00%)   166062.00 ( -83.39%)   134242.00 ( -48.25%)    82424.00 (   8.97%)
Max       fault-huge-3  1229237.00 (   0.00%)   392796.00 (  68.05%)   508290.00 (  58.65%)   433992.00 (  64.69%)
Max       fault-huge-4   418414.00 (   0.00%)  1147308.00 (-174.20%)   792153.00 ( -89.32%)   433393.00 (  -3.58%)
Max       fault-both-1    90549.00 (   0.00%)   166062.00 ( -83.39%)   134242.00 ( -48.25%)    82424.00 (   8.97%)
Max       fault-both-3  1229237.00 (   0.00%)   392796.00 (  68.05%)   508290.00 (  58.65%)   433992.00 (  64.69%)
Max       fault-both-4   418414.00 (   0.00%)  1147308.00 (-174.20%)   792153.00 ( -89.32%)   433393.00 (  -3.58%)
BAmean-50 fault-base-1        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
BAmean-50 fault-base-3        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
BAmean-50 fault-base-4        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
BAmean-50 fault-huge-1     1329.84 (   0.00%)     1086.23 (  18.32%)      765.68 (  42.42%)     1238.41 (   6.88%)
BAmean-50 fault-huge-3     1410.46 (   0.00%)     1406.43 (   0.29%)     1749.95 ( -24.07%)     1362.23 (   3.42%)
BAmean-50 fault-huge-4     1453.01 (   0.00%)     1373.01 (   5.51%)     1268.61 (  12.69%)     1157.08 (  20.37%)
BAmean-50 fault-both-1     1329.84 (   0.00%)     1086.23 (  18.32%)      765.68 (  42.42%)     1238.41 (   6.88%)
BAmean-50 fault-both-3     1410.46 (   0.00%)     1406.43 (   0.29%)     1749.95 ( -24.07%)     1362.23 (   3.42%)
BAmean-50 fault-both-4     1453.01 (   0.00%)     1373.01 (   5.51%)     1268.61 (  12.69%)     1157.08 (  20.37%)
BAmean-95 fault-base-1        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
BAmean-95 fault-base-3        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
BAmean-95 fault-base-4        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
BAmean-95 fault-huge-1     1428.93 (   0.00%)     1336.45 (   6.47%)     1125.72 (  21.22%)     1324.67 (   7.30%)
BAmean-95 fault-huge-3     1881.39 (   0.00%)     1868.23 (   0.70%)     2257.90 ( -20.01%)     1794.46 (   4.62%)
BAmean-95 fault-huge-4     1853.49 (   0.00%)     2038.27 (  -9.97%)     1758.37 (   5.13%)     1522.69 (  17.85%)
BAmean-95 fault-both-1     1428.93 (   0.00%)     1336.45 (   6.47%)     1125.72 (  21.22%)     1324.67 (   7.30%)
BAmean-95 fault-both-3     1881.39 (   0.00%)     1868.23 (   0.70%)     2257.90 ( -20.01%)     1794.46 (   4.62%)
BAmean-95 fault-both-4     1853.49 (   0.00%)     2038.27 (  -9.97%)     1758.37 (   5.13%)     1522.69 (  17.85%)
BAmean-99 fault-base-1        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
BAmean-99 fault-base-3        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
BAmean-99 fault-base-4        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
BAmean-99 fault-huge-1     1447.04 (   0.00%)     1394.38 (   3.64%)     1188.40 (  17.87%)     1359.40 (   6.06%)
BAmean-99 fault-huge-3     2139.13 (   0.00%)     2127.28 (   0.55%)     2500.44 ( -16.89%)     2024.05 (   5.38%)
BAmean-99 fault-huge-4     2051.01 (   0.00%)     2141.53 (  -4.41%)     1959.27 (   4.47%)     1705.47 (  16.85%)
BAmean-99 fault-both-1     1447.04 (   0.00%)     1394.38 (   3.64%)     1188.40 (  17.87%)     1359.40 (   6.06%)
BAmean-99 fault-both-3     2139.13 (   0.00%)     2127.28 (   0.55%)     2500.44 ( -16.89%)     2024.05 (   5.38%)
BAmean-99 fault-both-4     2051.01 (   0.00%)     2141.53 (  -4.41%)     1959.27 (   4.47%)     1705.47 (  16.85%)

thpscale Percentage Faults Huge
                                     thp                    thp                    thp                    thp
                                   base1                  base2                   lru1                   lru2
Percentage huge-1      100.00 (   0.00%)      100.00 (   0.00%)      100.00 (   0.00%)      100.00 (   0.00%)
Percentage huge-3      100.00 (   0.00%)      100.00 (   0.00%)      100.00 (   0.00%)      100.00 (   0.00%)
Percentage huge-4      100.00 (   0.00%)      100.00 (   0.00%)      100.00 (   0.00%)      100.00 (   0.00%)

                         thp         thp         thp         thp
                       base1       base2        lru1        lru2
Duration User          93.79       93.26       93.61       97.02
Duration System       592.52      601.32      585.31      575.20
Duration Elapsed     1239.40     1243.79     1232.97     1229.09

                                            thp            thp            thp            thp
                                          base1          base2           lru1           lru2
Ops Minor Faults                     2532126.00     2377121.00     2410222.00     2414384.00
Ops Major Faults                         836.00         722.00         778.00         610.00
Ops Swap Ins                             676.00         644.00         656.00         760.00
Ops Swap Outs                          15887.00       15705.00       11341.00        6812.00
Ops Allocation stalls                  67986.00       44391.00       48791.00       70025.00
Ops Fragmentation stalls                   0.00           0.00           0.00           0.00
Ops DMA allocs                             0.00           0.00           0.00           0.00
Ops DMA32 allocs                           0.00           0.00           0.00           0.00
Ops Normal allocs                  163203689.00   154651154.00   159354937.00   165237378.00
Ops Movable allocs                         0.00           0.00           0.00           0.00
Ops Direct pages scanned              832666.00     1385214.00      652686.00      499004.00
Ops Kswapd pages scanned              808301.00     3517190.00     2310658.00      615450.00
Ops Kswapd pages reclaimed             28737.00      314122.00       13761.00       21149.00
Ops Direct pages reclaimed              1542.00      118664.00         278.00        5002.00
Ops Kswapd efficiency %                    3.56           8.93           0.60           3.44
Ops Kswapd velocity                      652.17        2827.80        1874.06         500.74
Ops Direct efficiency %                    0.19           8.57           0.04           1.00
Ops Direct velocity                      671.83        1113.70         529.36         405.99
Ops Percentage direct scans               50.74          28.26          22.03          44.78
Ops Page writes by reclaim             15887.00       15705.00       11341.00        6812.00
Ops Page writes file                       0.00           0.00           0.00           0.00
Ops Page writes anon                   15887.00       15705.00       11341.00        6812.00
Ops Page reclaim immediate                 0.00           0.00           0.00           0.00
Ops Sector Reads                    79350969.00    79290528.00    79326339.00    79294800.00
Ops Sector Writes                  105724641.00   105722825.00   105705814.00   105687161.00
Ops Page rescued immediate                 0.00           0.00           0.00           0.00
Ops Slabs scanned                      83935.00      113839.00      100286.00       78442.00
Ops Direct inode steals                   56.00          44.00          86.00          31.00
Ops Kswapd inode steals                    0.00           1.00           2.00           2.00
Ops Kswapd skipped wait                    0.00           0.00           0.00           0.00
Ops THP fault alloc                   232051.00      232036.00      232035.00      232035.00
Ops THP fault fallback                     1.00           0.00           0.00           0.00
Ops THP collapse alloc                    13.00          12.00          15.00          11.00
Ops THP collapse fail                      0.00           0.00           0.00           0.00
Ops THP split                          22665.00       52360.00       35592.00       15363.00
Ops THP split failed                       0.00           0.00           0.00           0.00
Ops Compaction stalls                 144127.00      120784.00      125512.00      144578.00
Ops Compaction success                  8039.00       24423.00       15316.00        3672.00
Ops Compaction failures               136088.00       96361.00      110196.00      140906.00
Ops Compaction efficiency                  5.58          20.22          12.20           2.54
Ops Page migrate success             4170185.00    12177428.00     7860810.00     3037053.00
Ops Page migrate failure                9476.00        9987.00        1987.00         623.00
Ops Compaction pages isolated        9551164.00    25547480.00    16290756.00     6222921.00
Ops Compaction migrate scanned       6529450.00    15982527.00     9845328.00     5711509.00
Ops Compaction free scanned         17198448.00    21663579.00     9531167.00    10790527.00
Ops Compact scan efficiency               37.97          73.78         103.30          52.93
Ops Compaction cost                     4555.96       13237.59        8537.99        3310.69
Ops Kcompactd wake                        51.00          88.00          48.00          20.00
Ops Kcompactd migrate scanned         127333.00      325654.00      144656.00      670374.00
Ops Kcompactd free scanned            100028.00       35658.00       12486.00      127376.00
Ops NUMA alloc hit                  48379083.00    48250045.00    48278578.00    48259808.00
Ops NUMA alloc miss                    68141.00       51994.00       61465.00       70881.00
Ops NUMA interleave hit                    0.00           0.00           0.00           0.00
Ops NUMA alloc local                48379030.00    48250007.00    48278535.00    48259769.00
Ops NUMA base-page range updates       19832.00        4340.00       14959.00        5190.00
Ops NUMA PTE updates                    2424.00         756.00        1647.00        1094.00
Ops NUMA PMD updates                      34.00           7.00          26.00           8.00
Ops NUMA hint faults                    2148.00         386.00        1411.00         415.00
Ops NUMA hint local faults %            1814.00         362.00        1401.00         238.00
Ops NUMA hint local percent               84.45          93.78          99.29          57.35
Ops NUMA pages migrated                 5392.00         535.00        1030.00        1710.00
Ops AutoNUMA cost                         10.98           1.97           7.18           2.14
