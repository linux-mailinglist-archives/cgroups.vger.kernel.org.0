Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56296374983
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 22:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhEEUiq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 16:38:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50328 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233965AbhEEUip (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 16:38:45 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 145KZlsF008581;
        Wed, 5 May 2021 13:37:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=v4HyhTw3kOjEOWG+Aw2IiVPkSLyT0I9UxIaA9q26JTM=;
 b=hVnQM25+DkFLSperfoPzBm5IbfUWxgY+j3QmY32cQskiyHWNQYF+eH/4WGCUPylCD4dI
 zV5wN1XFAW6/rxB8RHhX5JpI4EVltyCXWFiCPQvO9LpOu9Xexg0vqQPEnjg7mmZhe6P0
 FXthoXqRsGTj4YD8ovkllEJxywBPRmlPvJM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38bebpnur9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 May 2021 13:37:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 13:37:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EORR+HewHuHC3bs9+R1C8arOQspEFCrg9OBKN2bbBAKF9q8MskmFbGrqKmL2hxHAO+ZuFR4jCAjFJ0370RZ7I9ZwdAxORbnrmxVYO/gFivBD27gE34PP941KIrrzELkpAaKJW4ybgJCEGXVfWgJj4fXN6EScy2CqT//ZqQFplcmxMqjiuMQmvH15y/RUhXUwr7BUcDk/Q1O83+kEkXcAFy4gMw7S92yoOZAJ9t8RpsXVnJFpGOsfphO31EE7xpf0B3PvRaTnAXk7gYEabF8ZiQXjVaF7LHmlMPGkBAnyqa1oUC2kjWjEg/gPgoXN8k8nlgbHR+SHyA8ff/kb05sfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4HyhTw3kOjEOWG+Aw2IiVPkSLyT0I9UxIaA9q26JTM=;
 b=jI7Vmdij8e11gytI4RrjmmAZLOoQuQW3WUFKbSBlRC+x7Lb3a9Nls6z+Y0ocFH1A/eEl9BM7xYQLFXK4Kn5cjWovnGWPP/FvM5VwmeVK0C6L0BX3JLGZOFHSQcRFB0cTeGqUsqJ1ciNI+bqbgGQEr4V98oMo3p2dmJKzPxUroke/AzZlgzS/regEPOi7xHvQ7E2kvaH8ZztIuXm7HjysgAQ9BQJVz+4bAr7WJsOWD9gEZ674TedPoEQwOwhpsy8PwR8Dx6gcDtZ+C4ptAzx1Da7FJmUEFlrZ3JecOMk25tanRo/ECkPJpVqmDYPYQ1DsU7pg1XegvqRIbGWH52SGlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3080.namprd15.prod.outlook.com (2603:10b6:a03:ff::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 20:37:32 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 20:37:32 +0000
Date:   Wed, 5 May 2021 13:37:27 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v4 2/3] mm: memcg/slab: Create a new set of
 kmalloc-cg-<n> caches
Message-ID: <YJMCB/g8YctqQmlE@carbon.dhcp.thefacebook.com>
References: <20210505200610.13943-1-longman@redhat.com>
 <20210505200610.13943-3-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210505200610.13943-3-longman@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:c814]
X-ClientProxiedBy: CO2PR04CA0180.namprd04.prod.outlook.com
 (2603:10b6:104:4::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:c814) by CO2PR04CA0180.namprd04.prod.outlook.com (2603:10b6:104:4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 20:37:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 016a59c9-6718-42b4-02e4-08d910059bc8
X-MS-TrafficTypeDiagnostic: BYAPR15MB3080:
X-Microsoft-Antispam-PRVS: <BYAPR15MB30806F3539B4F2F2F08C1AEBBE599@BYAPR15MB3080.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nBGsKVpDjBgN0NPijT8V1D4HnDKMoudF94sv1cclNSwpR2mI7zeCR5BvcKgsAguCLPUAz0Mw/9YnDRJfrXQM5f0VhPsNpfODn333XnV2PnqvHc1sl0wbL/yqPezpOy/XkF0Yt/wmx7eXUu9w5sg9CgAp16sp/iohdDHLTgb7pZq9KfBnqZ4NYI7gEch6XNRgUjTL8N7NAmZ5zo6KpcyKLTd7/TfQxNILGW/ESq3KapBHMvviLrnhe3yhIA2DE89luX6+nG8dS2E8x/eJvyVI0qyEMjHyrGDma9No8QEwDp4JI+doKJgWSFcSJPLcTC69WsH0UdbHwjaXAv3cf3KMTwG63RYaCf0A0kh3AUhrP2JwR3XT0gDFA3xT4WMCRcjOfl6IZfgzBeJdm/aswIH/zoGIx9APMDOtLpwVVAInnxjQY90GRkEYEUINQSPG/QvUeW7gQx/BqnV+Vpciy8E4CAnrxNFsWfLlkDIrMv3J7ZkC8+osfoCWMO6BfSERyHJnZss2nIebesJL4FLPXFWbR9dF5IlZmqTZIOWDfuClYt447MYiFVkq1na3zPBLfrfsTi/EerJ3Cl7n4enWsYqSfJPLXHr1YqVuZENfYx6Vq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(2906002)(186003)(66946007)(4326008)(6916009)(66476007)(83380400001)(7696005)(52116002)(8936002)(86362001)(5660300002)(55016002)(6506007)(8676002)(66556008)(54906003)(38100700002)(6666004)(16526019)(478600001)(316002)(7416002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?n1ukVGWZNuhBEFWnkxl32FzuGP8LZ3iXdmpQxeN5cp9JOKNM6kzcXkiJcAZ0?=
 =?us-ascii?Q?X6VubMsbczWWOFguXaIkHi6Ue1uQJDWClvqWu3srGEDcT4R4m4QN95WfNRA9?=
 =?us-ascii?Q?beqxWJ8VZHTNM9cNPlo4Ch1vFXbZonuqzeGYEVFQbHaosXZqEtvht2QXlG4d?=
 =?us-ascii?Q?az7TXubLKxzS/Ubrcb6RspfXBF7JY58g3BidemzGpkKldSmsB5BLQwqBklMe?=
 =?us-ascii?Q?Dg+HJyS3e+WpsiPSgKQcI/GWzhF03z/SlBQmie+tZpP7ESE6Ky5O4ZILcyMV?=
 =?us-ascii?Q?MhkyJrbxAfpX5RCQlh+0chSa/JA+CKU/WI8pvhWYemPNLSG1SGKJ4l98zIp6?=
 =?us-ascii?Q?1WlDh46r5iOI/uANU4N0ReBiprzhFvFaRHEbTexMoGzEPGKEuhhB1oeyjAuF?=
 =?us-ascii?Q?tLVgkUubbeAwixHyWWpr4VDHxfVAFGT3g1Q4oiwPYAIxPbQAH1T4bguMvy1Q?=
 =?us-ascii?Q?540H0gEKO6dcTU8dN0eh9higIETKQj86EJhspVMsLKNMmBIbYhXIKs8Xnsaw?=
 =?us-ascii?Q?Jz1F/dayIH2m7gew0hb6l6H7YmIbFmi5Eu+1HPuVC65ZjSXFDE7LhznsHBUG?=
 =?us-ascii?Q?wwMq2zzmeemJ9DkkmaI4PJGQp/OugcRrljn+28P+s7tNOGq1tUPeqxzmmPAH?=
 =?us-ascii?Q?xte4H4awSEIm0lDAdODzDelHJnGoVYDcnLoXxIsUl2uIKjqD7B+XbbuySZwL?=
 =?us-ascii?Q?k9KvWduvjSfc2Qz0aQRSph7kb+igsbGFaujXJQMUBkL/QpFhXfUosd3kSiwH?=
 =?us-ascii?Q?I3y3r5Khb5++SLDccQXlHVnEoyNPMcCMbOMt+QQeiYNuGRTd7pCIQ3LK+/Bv?=
 =?us-ascii?Q?SuQW054kYVTEYAHHgcfPIPi102lKPg/aQeGozii3vG59C0VVFay4RhdQwHAj?=
 =?us-ascii?Q?QmxA+kGfOQamriEfBs94zcqWU9dHejTsYwH6Ff82X+fEBilnmQpvN/TwReUM?=
 =?us-ascii?Q?bJsx+PnJ+YSdXIF+rg3syXXzT3bF9fQ429emrFHWRzQzj2yYK7nrciHakBLW?=
 =?us-ascii?Q?rSoCN8wIwricwk7/vIWPf7DSJZgrtDOb4hg8p2EvJn0y/Nfl/f0zFcKSkQug?=
 =?us-ascii?Q?z0r9hn4yPrVoZRATjXoWzJLz6VnJGncNs9/5DP7S8v68a2l5jrLum6+LvQu1?=
 =?us-ascii?Q?oCqgWFh/16WABvb8VDuNdwVMHsMhGQpR9LdgcxyFWhqJMkBbjMoFkMTf1yWS?=
 =?us-ascii?Q?Aga1g7/HO1nOZloTLp6vgwU4udiQT5STY+5a3uPRuBlsvcPJqp7aJU6HVD86?=
 =?us-ascii?Q?mvqbGaDGAmu8ifDmz2+XLbCYJQTa61BGGMVPY4C7pDwgJ2S/7p/h1PCBNPhj?=
 =?us-ascii?Q?pC1wV02xsaHr/sXff3vzFFYJl7CCyha4Eg0Ss21tqcr5Zjj9HA86GgknSsDa?=
 =?us-ascii?Q?7C3Ymuo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 016a59c9-6718-42b4-02e4-08d910059bc8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 20:37:32.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Et4OKvrpNGF6dnWLRVJzlljMIEse5J5UUWSzxq6McS6wz2stL5ey1A/ApydLFMZL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3080
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: fv1mk3r-SkXCh02QDuIq0ekgYz-jQsK-
X-Proofpoint-ORIG-GUID: fv1mk3r-SkXCh02QDuIq0ekgYz-jQsK-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_10:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050143
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 05, 2021 at 04:06:09PM -0400, Waiman Long wrote:
> There are currently two problems in the way the objcg pointer array
> (memcg_data) in the page structure is being allocated and freed.
> 
> On its allocation, it is possible that the allocated objcg pointer
> array comes from the same slab that requires memory accounting. If this
> happens, the slab will never become empty again as there is at least
> one object left (the obj_cgroup array) in the slab.
> 
> When it is freed, the objcg pointer array object may be the last one
> in its slab and hence causes kfree() to be called again. With the
> right workload, the slab cache may be set up in a way that allows the
> recursive kfree() calling loop to nest deep enough to cause a kernel
> stack overflow and panic the system.
> 
> One way to solve this problem is to split the kmalloc-<n> caches
> (KMALLOC_NORMAL) into two separate sets - a new set of kmalloc-<n>
> (KMALLOC_NORMAL) caches for unaccounted objects only and a new set of
> kmalloc-cg-<n> (KMALLOC_CGROUP) caches for accounted objects only. All
> the other caches can still allow a mix of accounted and unaccounted
> objects.
> 
> With this change, all the objcg pointer array objects will come from
> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
> both the recursive kfree() problem and non-freeable slab problem are
> gone.
> 
> Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer have
> mixed accounted and unaccounted objects, this will slightly reduce the
> number of objcg pointer arrays that need to be allocated and save a bit
> of memory. On the other hand, creating a new set of kmalloc caches does
> have the effect of reducing cache utilization. So it is properly a wash.
> 
> The new KMALLOC_CGROUP is added between KMALLOC_NORMAL and
> KMALLOC_RECLAIM so that the first for loop in create_kmalloc_caches()
> will include the newly added caches without change.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Roman Gushchin <guro@fb.com>
