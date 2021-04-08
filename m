Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DB4358EC7
	for <lists+cgroups@lfdr.de>; Thu,  8 Apr 2021 22:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhDHUyr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Apr 2021 16:54:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2332 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231862AbhDHUyq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Apr 2021 16:54:46 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 138Knpck002661;
        Thu, 8 Apr 2021 13:54:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=7ChLymD/Rx15uAsFPHgBsDg9sElJvaFBelRs9fpbN8U=;
 b=Q2yvZd+teypOYJAZRlO4YFUJIhfihJV9XqvN0uoM3bnfZca7Iy1InWIWGb10Febdhppk
 F+F1gp3acdeWKR1yorOcXG7aMQ0LLosi/Ll/MEQq2A9tvqZgizLpTXiXDD+zu9mKKu+1
 VyUyQm3Jde34VFS+mHi3Lfdab0GQyi1YTh8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37t81f0jba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 08 Apr 2021 13:54:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 8 Apr 2021 13:53:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGt0elqA2dR+oh2458oHM1bw+6OoTEan4C5L+urqC35LOVpbz50AcOjN9Sy77P+ChEhTkk+H0O1cRQmADL/eWL/XXOdOKIX0ereEk/IqcKKBpffCVPobq22SW7fWPP/usLjW0iJ5gdETZNkbPLJbMeF1i8s4b9ugX247zUolBI1wHQHSbYaRR6dzJaUUHio6Eoed1bN4YGm6bJNktR4LFFDPRXeGve6X0bChDI1BAwt2ATnbQZHLi6ywuBpZ5oWqAbkyiLjYgXW+cgHFGnhFX1Z56QPKG7rGbPmd0EUa66pjuvmZjEce2KIxEkNo2IRKWb7oENoDIWMyL0pFv1sIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzN74j/Z0euFsMCLvPHmSRAfWisVQeR7/5GS+GQm1G0=;
 b=IWGp5orXdu0FD/OXcQYTm6St2Nn7gk6+ydZGfmmrWZIhiI2Urv9HdtZpavmeDTiKEGikEOkjwVRWup6lHuxu868t95N3FF6brpkFGGBnyctcpe+lQUuAX6pmv3fC/y24n8Q6FQLPH5JPGHOuFr8gmdJR2h7Aef21IivMn5B/e7BGy5CZEQkeq9/iRSM3F9Dvv8lVfOy8gE0sMZh7lPl1r4wIi8RZ2VcbKRMhdyOeIKEqQNOu8wxHqwgtPJ1H/8Ohfs0NMbESlEF+Eq3NS/zmMv8XJ1WM+Yaxmd1dcsb4+sygdMLznwV2ADZGUffUfH+P7/4JiurqFpWKdJU9WV6K3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BY5PR15MB3523.namprd15.prod.outlook.com (2603:10b6:a03:1ff::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 8 Apr
 2021 20:53:51 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 20:53:51 +0000
Date:   Thu, 8 Apr 2021 13:53:47 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: memcg: performance degradation since v5.9
Message-ID: <YG9tW1h9VSJcir+Y@carbon.dhcp.thefacebook.com>
References: <20210408193948.vfktg3azh2wrt56t@gabell>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210408193948.vfktg3azh2wrt56t@gabell>
X-Originating-IP: [2620:10d:c090:400::5:eca2]
X-ClientProxiedBy: MWHPR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:300:c0::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:eca2) by MWHPR08CA0053.namprd08.prod.outlook.com (2603:10b6:300:c0::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 20:53:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56d9f863-af9b-46e9-5916-08d8fad06a1f
X-MS-TrafficTypeDiagnostic: BY5PR15MB3523:
X-Microsoft-Antispam-PRVS: <BY5PR15MB35237087560A969F0E096E8DBE749@BY5PR15MB3523.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7MILVgTrajE2PmMY8qdG18zCSsI6B0ohRf58XspCOcY/nA1T8V7AW7ZQgNMQl3gPz4XcqBtEprSXAsgQbxN3ghxEjOQ1JY2aplZc24/7EKsUTZNlasZTNANb8DkOZbB/B/bK6QyTOlSza1QZtefmRRo7MoI+vhFtJzXMIf9jGX2xXFdXO8I7yilUA8S8HJxgTWethCdQ84kwa+Llgl16Lb+ZwazUJbhtlx/pG8xO0vi26668Ff0+WshrF3O/KDn3DJH+j4rOPQUHuzcMhUsx33bOO2/8uXTHXuc1+DfaCRGB3hopUaDgSrzpyeBhx5tjKTkrjzQ1lyX3hzqs44kD5GJbQdwPG9XGevlYjaUt1TRFdPyXbyxGr6QF1GSHZv9Gy5MBPDpaM+9UNkQ9P9oDpEVwf9XuxxhW4agf0yzS4PWoxq2rIzaCQ97thxuGalUTk9qQbIHL4loF7b1gejwUM+gqnaSTc13aK4OfUs74illpddczBbonx7s2jCM86kiOe7kGcdIiufFKyvAH/FHUUn8ZdAmPPKogMXbr42uOUKbj0grV86ULJfqJfHGEW1PcV2OTmdgR3l+0IjViW6OacR2aZyVyWIVqVSgbBmLJn5paiYVHXQPoD5koBVTZIVlNqggJtHkgFmZQ/hSz+2A4gRKukTs8zfdolrUvTMnBOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(396003)(136003)(376002)(54906003)(8676002)(2906002)(186003)(9686003)(83380400001)(16526019)(5660300002)(8936002)(66556008)(66476007)(6666004)(66946007)(4326008)(6916009)(478600001)(316002)(38100700001)(86362001)(55016002)(6506007)(7696005)(52116002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?9H8CcaQgYTKpbq6QkocVmRDKU/GeEihQKr6b7nG+mfWsi/9Eac+aPzA/FE?=
 =?iso-8859-1?Q?xyw2BGNQljFpnIur/jPsvG4phkuLfN8Csytel/d94zLvNOdTtALr/68r4K?=
 =?iso-8859-1?Q?rd3e1r2lkdK9c5s5trk70XpC/OD30UFmXDyuX3e6/qCljB5NnMr++WESvv?=
 =?iso-8859-1?Q?eh2WQxnR5UmKvIRSLOGZFCYUoUBCsY9QK9XXB5Ktq6GbX27rPT6DVlPvfs?=
 =?iso-8859-1?Q?FftOKIBf9xlV8nqakoFNsiUQh5W4JImuUfFDVQcyzmHLYcd7d/5sCk2g1c?=
 =?iso-8859-1?Q?Pwl27tQeebfj40uMScbMhdegs4Eal8rOSi5YI6bbSxzHqmmMHAwZhps0FF?=
 =?iso-8859-1?Q?Vnpp7awruhJDmZCX71PgvwJjAE9AXkHTzg0fxwaBxPxvL72TdHwsLRVtRu?=
 =?iso-8859-1?Q?j7KGUfluIW09Z99t+C2/cf6yloLTpJCsiLd+poAJQsd5naXo2wetuu158i?=
 =?iso-8859-1?Q?2GOG066asjp39J68VXp0pJU7lh5fDDbIYeLilFrkXk6aGXkcsHaSd3R/DI?=
 =?iso-8859-1?Q?ctWZDsUx1Zq/Jv0CQiU+RlKxuUsxmvumGfdlqDYhQ58S926Wq0VJM0VJl1?=
 =?iso-8859-1?Q?tI6PcCG7NBUHecgcU3a5+KECb99M+KD6B7Pfpi0cEe44HNMbTSjyfIEOLu?=
 =?iso-8859-1?Q?Dk8Ep5M+eRgiIQWL6bmEaHRMZx+jrmm9j55Flp84pIzKIv/Kg5GHGimR/Y?=
 =?iso-8859-1?Q?vQxeSVxT9Y+0klOGTiYHTnCozz+RLshN2lAOmGE5kLhFBim+ahDYyTZVG+?=
 =?iso-8859-1?Q?yiScvR0WjN6T0Ng57R/75nRn4di1rpdhRXVtUWtkMeyygGX54mXKqRIMY8?=
 =?iso-8859-1?Q?EFom4V6p59hb1NBlF+Yq3oL8y5n2OLqd1orPWDO8DqP1thRwTSPAIZbU+7?=
 =?iso-8859-1?Q?FonoYXpzlnNWdQXqnPKyGEffdtMcFBKhYIaLj9ieGXTWBhOrjtP5qqSQZk?=
 =?iso-8859-1?Q?Z8hO/y30xBqvvm6yLQC95/bnPv/oa15GMB3K1ImWOJgWh4MK06ZQulJmAB?=
 =?iso-8859-1?Q?A8q9jSSncsm/3R/yfOr3cvptQNSX5gnc7u3o3dCBGVCC/QwW6S53DDsiyS?=
 =?iso-8859-1?Q?qiUuZ2VLky+og3YOF/At1pdO4OVPQcKeSV9zspxyI22RG9clX4ZYj5JxjO?=
 =?iso-8859-1?Q?7j+C9jT9Jw0DQsqCF9G+JVLzRsw6gxheAZH2adBhOWwCZShc1xmU5w+1cq?=
 =?iso-8859-1?Q?6FTs1n8chswODwcyM7TcdXDSo90XpLMtUQkJJ00BKzINn7WRxJuyZZW4wh?=
 =?iso-8859-1?Q?30CMvg+MzFGb1BVQEXwfuDG08NAhdHf/drhuznSxRq2JSgNj9D5eIkmdYs?=
 =?iso-8859-1?Q?46JWzPc9ehfkEw86A3twSxU1pk3fz6CXHOGN/Jx3st5JC2UvBA/41AszMU?=
 =?iso-8859-1?Q?ydQ8G7O3C/DCnhOrNvV+yKks9eXMVKyQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56d9f863-af9b-46e9-5916-08d8fad06a1f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 20:53:51.5115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /49XdALOzWVNLUvWwLQTyCgkRT6LsHTJWSqx9RQZ2XkQJeyGSge+JSiLAr0sFJgi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3523
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: pDj1BH0JeNClAsKfrvtHs99-sCP_Ioas
X-Proofpoint-ORIG-GUID: pDj1BH0JeNClAsKfrvtHs99-sCP_Ioas
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-08_07:2021-04-08,2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 mlxlogscore=940 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 08, 2021 at 03:39:48PM -0400, Masayoshi Mizuma wrote:
> Hello,
> 
> I detected a performance degradation issue for a benchmark of PostgresSQL [1],
> and the issue seems to be related to object level memory cgroup [2].
> I would appreciate it if you could give me some ideas to solve it.
> 
> The benchmark shows the transaction per second (tps) and the tps for v5.9
> and later kernel get about 10%-20% smaller than v5.8.
> 
> The benchmark does sendto() and recvfrom() system calls repeatedly,
> and the duration of the system calls get longer than v5.8.
> The result of perf trace of the benchmark is as follows:
> 
>   - v5.8
> 
>    syscall            calls  errors  total       min       avg       max       stddev
>                                      (msec)    (msec)    (msec)    (msec)        (%)
>    --------------- --------  ------ -------- --------- --------- ---------     ------
>    sendto            699574      0  2595.220     0.001     0.004     0.462      0.03%
>    recvfrom         1391089 694427  2163.458     0.001     0.002     0.442      0.04%
> 
>   - v5.9
> 
>    syscall            calls  errors  total       min       avg       max       stddev
>                                      (msec)    (msec)    (msec)    (msec)        (%)
>    --------------- --------  ------ -------- --------- --------- ---------     ------
>    sendto            699187      0  3316.948     0.002     0.005     0.044      0.02%
>    recvfrom         1397042 698828  2464.995     0.001     0.002     0.025      0.04%
> 
>   - v5.12-rc6
> 
>    syscall            calls  errors  total       min       avg       max       stddev
>                                      (msec)    (msec)    (msec)    (msec)        (%)
>    --------------- --------  ------ -------- --------- --------- ---------     ------
>    sendto            699445      0  3015.642     0.002     0.004     0.027      0.02%
>    recvfrom         1395929 697909  2338.783     0.001     0.002     0.024      0.03%
> 
> I bisected the kernel patches, then I found the patch series, which add
> object level memory cgroup support, causes the degradation.
> 
> I confirmed the delay with a kernel module which just runs
> kmem_cache_alloc/kmem_cache_free as follows. The duration is about
> 2-3 times than v5.8.
> 
>    dummy_cache = KMEM_CACHE(dummy, SLAB_ACCOUNT);
>    for (i = 0; i < 100000000; i++)
>    {
>            p = kmem_cache_alloc(dummy_cache, GFP_KERNEL);
>            kmem_cache_free(dummy_cache, p);
>    }
> 
> It seems that the object accounting work in slab_pre_alloc_hook() and
> slab_post_alloc_hook() is the overhead.
> 
> cgroup.nokmem kernel parameter doesn't work for my case because it disables
> all of kmem accounting.
> 
> The degradation is gone when I apply a patch (at the bottom of this email)
> that adds a kernel parameter that expects to fallback to the page level
> accounting, however, I'm not sure it's a good approach though...

Hello Masayoshi!

Thank you for the report!

It's not a secret that per-object accounting is more expensive than a per-page
allocation. I had micro-benchmark results similar to yours: accounted
allocations are about 2x slower. But in general it tends to not affect real
workloads, because the cost of allocations is still low and tends to be only
a small fraction of the whole cpu load. And because it brings up significant
benefits: 40%+ slab memory savings, less fragmentation, more stable workingset,
etc, real workloads tend to perform on pair or better.

So my first question is if you see the regression in any real workload
or it's only about the benchmark?

Second, I'll try to take a look into the benchmark to figure out why it's
affected so badly, but I'm not sure we can easily fix it. If you have any
ideas what kind of objects the benchmark is allocating in big numbers,
please let me know.

Thanks!
