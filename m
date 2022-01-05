Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED78C484C98
	for <lists+cgroups@lfdr.de>; Wed,  5 Jan 2022 03:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiAECzj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Jan 2022 21:55:39 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33790 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229584AbiAECzj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Jan 2022 21:55:39 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 204KIHJs013408;
        Tue, 4 Jan 2022 18:55:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=maK8sIYCrJV1weWYvOBPXD6pF0RnAd+Y0RAPQ6xmjiQ=;
 b=ol2Mnc0vKYX+tylIfHRtrT4wOcDrBtqLhfdlWgXIxMDZstu3UgSKnKjHnd42j2lrEei7
 qR111S3DYxdAKa3USBeP4OqjZGa/Q7AOXo9+sCdG7aWilJE0GxoYjRpBTTHSz2gdSury
 VQJyDpY+iuiIiC43duYWyFbLMBc4ujhl5B4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dccqry8ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 04 Jan 2022 18:55:23 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 18:55:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4MoEfgSl165VRP5HqZW24d8zbbDAMUn+UNxRiVM5Fc6WDBULLrnhpG0FDnxu4g2V1uC1Qip5XuZ5E/5cPUOctbPx3pXcR2SG7KdFxDfpDbCjeW9ONt+4DGPKHahO4xoLt5xzZP3lzQUJZfTTJhqoETyKYewQPxbSlWwadnIUxg8eiwy3TUTdOG4bksCctOnvRzltpwOGlNh5TML3cUcwNfsklR6zNEhyy3MIwYkj9ryghqbkIQN2oeIvxyHV42E3Pe7HDH6mTg9N/oj97p05mlt8X6Q5u2B5r7kRJ3yDvxqULf1YXNPvqEC8oLe0Bcq83eaB6r236BtwEY8dHzTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maK8sIYCrJV1weWYvOBPXD6pF0RnAd+Y0RAPQ6xmjiQ=;
 b=bhQezwOb/A02JhiqBykZdjceldfgSNKa1CkGJOwY2RKWY5ernJYbJZpsUwWK02r+6miUTW6IR/GhVjwXPFcGhW3mh25MoQSVdpPJnAWBBhpkIsgxiBj3eVWERCFO3GJQ5OrGxESRkJrdT1xhm9vPOCngCmT+2qusNTN9GaVG8xIieySZPB0Rhi9HLp47dMcPHPOg5arNP6hJFRx3NR+yAhO6/EorBNUSFau8ECsmomFomG2xh7ift66qrCUYSKC4d29mJ7doWZjsHZZvEOn1rgdKwweIbgsXABj2c7EPq5UvgrCIHJtI2CGj1eCqYeNvOanyWEiovm/c5OhiYytfZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4357.namprd15.prod.outlook.com (2603:10b6:a03:380::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Wed, 5 Jan
 2022 02:55:16 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 02:55:16 +0000
Date:   Tue, 4 Jan 2022 18:55:11 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, <patches@lists.linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <cgroups@vger.kernel.org>
Subject: Re: [PATCH v4 23/32] mm/memcg: Convert slab objcgs from struct page
 to struct slab
Message-ID: <YdUIj9chzbeOFpIJ@carbon.dhcp.thefacebook.com>
References: <20220104001046.12263-1-vbabka@suse.cz>
 <20220104001046.12263-24-vbabka@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220104001046.12263-24-vbabka@suse.cz>
X-ClientProxiedBy: MW4PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:303:8f::7) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5398e9da-bfa0-477c-a1de-08d9cff6cd38
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4357:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB43574592A41325D9AACE98DABE4B9@SJ0PR15MB4357.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+UM3KcZ3qzcidN0jr3ex4ZQADu42v1DXjr4NaUsKNXMunMwPmgnt1BMc0eTPGU3Qosx1+gIuq9RvfBYUxXryzCxEgda1oehvxBwARdnx9qzPnbp4Hdtm+Zr9MnY8+B/p+v100yD+0RphlnAuyIjDGbBXHW5o2Ep3AWqgmRJQnJ6jq4KLI2cWhkJad5vJiQhH+MDLagaIW0s9mN2/GpuIjhvTvcwNswFuLr6LKkE7b3slhGgp42pUXj6O6JfaGXgVH6kk1FZzTDe3LnCCXE4dF4XofLSyWbpEwOFcYip0E9DvJ8DFKnAtxAIJyA9oZij1p/U+24IfBrm1kJgi5g18RmA4VHk9pNqDHJTXBFQM6fhH5Sv2ccUcW0fZ2yW66TEUWUTuYLVi43Lg0SZS3m9EeXhEyhfaUHv8SAL7ANl2DxkjwmelJQ8U75hP6w/086zCnU8txjKmN4499wLdicWlUYhbCLK42CrqdoioUFyp3eJ/yIIyu2Hy+b2pQCGwCuUa8SRuakHgkMcys+mFeJluMISW1e3+fnS338EdKwEqn5496Sdxm0ivIxH9wqZ2DEW74RH5X3iY6+AHcCMD/NDBb4OV2mnBR+LSEucO3jXzoXI2rBtdQ55gvj9CiJJafdfqCYADTPxMhywoGG5pWXXoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(86362001)(66556008)(316002)(8676002)(2906002)(5660300002)(4326008)(6916009)(66946007)(66476007)(8936002)(54906003)(52116002)(6506007)(38100700002)(6666004)(9686003)(6486002)(186003)(6512007)(4744005)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0X0VR0mdO2Gmqqid6THpZZxQeV4svXADiGJB/kUugqOam1FiJ50mb56zPQwU?=
 =?us-ascii?Q?erlko0nRI2Na1mbFes5bRhwk7Wisf8OG8B3XvIK5/laTfKbWY3R4BhV1/LDx?=
 =?us-ascii?Q?4Ldl9zETJ2OHVayA9Ai4+WvPFZy3pBM6nH1QHFGk+8en4UaNfheflxcNyrvj?=
 =?us-ascii?Q?aRnn6KnkqIlsfrQL+9vbcYOqfx+Qo+J+I80GvoW7pxNu2o+wCAuxr8W3MtH4?=
 =?us-ascii?Q?hiLSHtw/bgJdvIJu1LWfTccJ2y5VtlAZr0QUi/uV/xGLbZ243QZJMXCKQlxn?=
 =?us-ascii?Q?mfA5r54LVpJCSljPTpITwvDMsVBuioF8pD2VfN4wENqW67j90Agr6WFOWOBg?=
 =?us-ascii?Q?B0O366ixKQDTKTDc7+KkG7CdCvXKENEgCKIx/VXlwPRDe7QuKsNzrmhvBtQ6?=
 =?us-ascii?Q?P/49ihYs74+p7TslUkcfLj9qZtiMHXd/tkgdHmhUqlflKxyVy252KjAuqgRE?=
 =?us-ascii?Q?ZfR+YDk1bGguj2vtOffO66Cou/F4PABS3rJKTIEViFdr+1KZaq9gADmJbljA?=
 =?us-ascii?Q?XhGmDMFPlok/CzUhPhAsn1wbHo85drspBzF1BcKC284Ht3T+bYMtDuqfo7jy?=
 =?us-ascii?Q?ujamYpxylkczFw345jTAU/mW9i/JKzibUNys/wtCkAhK3SrXX2kV/akps3FG?=
 =?us-ascii?Q?hw12g8QAfPycg79rYAvzHWrntAjG3YZozDXYodatVbkorzBPWs/hj5US0g8u?=
 =?us-ascii?Q?M8hWM1R5zHUjz570zsQN8WzdC7ZeDrSKRF5B8rycQ3q9BYsWTu6FiFnfWKDc?=
 =?us-ascii?Q?wXRp1Aqsr3un98Lqn0OEar0yiW9Hbf4ETkjF/MdwdgDD5ZdGgO8LFaXUEJO/?=
 =?us-ascii?Q?o1FI09Ijc6NaLtqWrgAzh/rqJ8SCd8kLNkoc8PicLUp4+JalsdLNubHU/pRg?=
 =?us-ascii?Q?RmqzLdg0jXdaTUx1krK7M//ShPAKsrZIq2R1e3xFyq2643nXxnGC4V8cY2Y2?=
 =?us-ascii?Q?7SheJ7EKBXpOMfVO2uOVH2BlojPHBIJJU0peSBWzdriNgaY2Tg6QBmUPvVbe?=
 =?us-ascii?Q?70hi041z6Lpd+TMcURRiMv6hq429ffAoFv9KkezA9L0gp8eoG1E3ZeZlb/0a?=
 =?us-ascii?Q?zL65AsAGEP9jGPMqES7I6OP92HZ+K8eHU+MYE9+hT2Xx27P/dOxhMjs3S/ay?=
 =?us-ascii?Q?krVoH0OMJs2diA3okwTg+ZqvN14LbzofDp8/iCCROUdJHsRzgemfubFSbB6z?=
 =?us-ascii?Q?O25rvGkq2UyiyaJph3X0hPhjdeGHI+jhXmejk39a/I+5/VEX9YXhxAG12wTQ?=
 =?us-ascii?Q?UO2zBKXLwc4zicismkgJfm0Nmlct/1j11HfosHnUsuuaKvSoYKS76UVSW6H9?=
 =?us-ascii?Q?xgc34mUfmKrWYDjT+j1w3S/tvfzN1HyjvRs58tDYdAzIjJKyl5GheAS9X3TV?=
 =?us-ascii?Q?PiGl2C7X95UVtw6qTcBML/X+b4n9AML/Its0Gz44NgWrvASo5XmoK81VLAwg?=
 =?us-ascii?Q?sinCB+cLUFnwwqzIR5i5M/BhWJWF1lxuAHmCdlh/fzly/q4bKV6XC5eTITHd?=
 =?us-ascii?Q?qzFDLBd9IVP6+IgdX/A32REeC3vit0tPHXeWKMHTyRYgZYXuRCbpnkCdEq9X?=
 =?us-ascii?Q?AcOnV8ne8sJoGRNs11mh2eebNUFJXMzRgzUtezJV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5398e9da-bfa0-477c-a1de-08d9cff6cd38
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 02:55:16.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQIQUyXeKdssaxmahQ5lrO4/kGL5zgMDMeK239pdL648Qy+clk1DWLhha3lNb9Xt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4357
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: _Wb3DBMlOd8pinV5a0GVG3YqBcHAlsIq
X-Proofpoint-ORIG-GUID: _Wb3DBMlOd8pinV5a0GVG3YqBcHAlsIq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_01,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=526 impostorscore=0 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201050017
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 04, 2022 at 01:10:37AM +0100, Vlastimil Babka wrote:
> page->memcg_data is used with MEMCG_DATA_OBJCGS flag only for slab pages
> so convert all the related infrastructure to struct slab. Also use
> struct folio instead of struct page when resolving object pointers.
> 
> This is not just mechanistic changing of types and names. Now in
> mem_cgroup_from_obj() we use folio_test_slab() to decide if we interpret
> the folio as a real slab instead of a large kmalloc, instead of relying
> on MEMCG_DATA_OBJCGS bit that used to be checked in page_objcgs_check().
> Similarly in memcg_slab_free_hook() where we can encounter
> kmalloc_large() pages (here the folio slab flag check is implied by
> virt_to_slab()). As a result, page_objcgs_check() can be dropped instead
> of converted.

Btw, it seems that with some minimal changes we can drop the whole thing
with the changing of the lower bit and rely on the slab page flag.
I'll prepare a patch on top of your series.

Thanks!
