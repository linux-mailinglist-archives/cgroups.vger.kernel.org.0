Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F62928D256
	for <lists+cgroups@lfdr.de>; Tue, 13 Oct 2020 18:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgJMQgT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Oct 2020 12:36:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23792 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726942AbgJMQgS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Oct 2020 12:36:18 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09DGSoul004056;
        Tue, 13 Oct 2020 09:36:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=facebook;
 bh=IxPOCF1993S3QaPPdLtUzkCPBFxHymBIwLPrdYNgUZw=;
 b=ez3E8wTMo+8YusLEdFHMzSVj5HiKb17A+bdEYInP5J2LBW6HiJRoASajcHfLRIxEa9/9
 Gegw6eIh850DfRJYf3skFQGEdfybl9zq2UvbcqvxBlb9jBgxhZSe/6mJ1cIpmBmJK4e4
 BvVkVPXI2u49+H5gjqyv+wmsLjvuT5+HEB4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 343w7nutmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 13 Oct 2020 09:36:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 13 Oct 2020 09:36:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8oeEy1ZlkfI1g0lnN4ICI57XFqCijq3pS6zZ6lZvpzyHjyvZwP+fhjSRWX2/5SXjxbh8XfHMB9zKdHG17Yh2fvcT65JAkT4tN0LsJwvCt2tC33eUDvqmUr3+I5kzcM/WS03Lk2y33q5eMLnqwap9S2QHW4PR46LVKwEMYyIWqCslDhpPpy1QnpLYsxyUV2cPDkcRiRSodCRD2lU8Zk8l2koRSxoq+2ZJiQl+igBtsV4eneNXeMv5yNNLVGcaB3E/I0GkrjUhfqK+kiSaEscyvSLhsa0DnXg2rtYNW+HksC1UltmEVzjwdIyvgyYMii6PT8LYt+m9YGNz0qXJGdL8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxPOCF1993S3QaPPdLtUzkCPBFxHymBIwLPrdYNgUZw=;
 b=Uu7ji/I3h0FkSEWfqEaousrHtCIHMdnCJDTzSrDfoLf2c2ub2d4UbebozqXhxdSGupDobK3UVllm4a0SUIhgx6vMVJB+EgDHETmG+8LTsdRZztFBtuaWAK9m8SYuqwgEULG9b6OVC8Tk/8x4vZQHDtyNtSoqAfgMGKagl114oHJ8x8Hx/7w6kMEc5RQYMeOU86iPh1h7MDyXyBDvwOqtJNaG1GNPy5w3C1hMgahkzbCN/vtXnuqyrVlxPLh4KJreUN+CMPa/ePfP7grak7j9In3oXFiOdeW7UG054NeODrhO5EnSuOLUsJIN8gUyKtyn3wvJ05Ar3oCSFGanmwwr7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IxPOCF1993S3QaPPdLtUzkCPBFxHymBIwLPrdYNgUZw=;
 b=TA5BHPbhHKDuivIXAhI0lykStClJyPHWeQ6Iip0U/pS0rC7tKevp8VTWipBCGRacqY3wQ2edC+T7Ny5KK+Hrhwrj6pdME/7Ig4zCGBJEn8by9d+FMAcYilgMXICpYcD2YBMyjSV0GEPoXHi8+xZnel1dNVy3PkHDSdHmkHHmHFQ=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3078.namprd15.prod.outlook.com (2603:10b6:a03:fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Tue, 13 Oct
 2020 16:35:59 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3455.030; Tue, 13 Oct 2020
 16:35:59 +0000
Date:   Tue, 13 Oct 2020 09:35:53 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <shakeelb@google.com>, <vbabka@suse.cz>,
        <laoar.shao@gmail.com>, <chris@chrisdown.name>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: memcontrol: Remove unused mod_memcg_obj_state()
Message-ID: <20201013163553.GA3754702@carbon.dhcp.thefacebook.com>
References: <20201013153504.92602-1-songmuchun@bytedance.com>
In-Reply-To: <20201013153504.92602-1-songmuchun@bytedance.com>
X-Originating-IP: [2620:10d:c090:400::5:618f]
X-ClientProxiedBy: MWHPR10CA0060.namprd10.prod.outlook.com
 (2603:10b6:300:2c::22) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:618f) by MWHPR10CA0060.namprd10.prod.outlook.com (2603:10b6:300:2c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Tue, 13 Oct 2020 16:35:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed99a0fa-0ea1-4448-8f54-08d86f961106
X-MS-TrafficTypeDiagnostic: BYAPR15MB3078:
X-Microsoft-Antispam-PRVS: <BYAPR15MB30788030AC257FF5E25F73BFBE040@BYAPR15MB3078.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AiK83zk7FzrreFQ3+Oy5WQ6YMEX561QnW588DUDnrZFiQssJvnwObh+Ud0SoPvdGZbwvAulKU34YJ4RRcrOQ3LblS95hg+eIRoUmYd/nXLiWCK6cip/ztLVuCyJNuOL56w5dMg/5TkAtGhucwgmGBH8j7Pbzyp03oSMERg5H0b/NFOAE5c2AO98lFCp51u1mPh88ZX0BuMYeSvrJNcy9mNFHW119mwkrlNHAy8PTlkFimuOvbzQrd6jndxeY4V8W3mxS0rOvbjqBL6DoMBACQ3Qxue7wUY3alTHKmOJgsi4wf5TO6tVF+XStv4Da/cVZHdCmmSuIi9RtwBVpAriNGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(39860400002)(376002)(66556008)(66476007)(66946007)(9686003)(2906002)(4744005)(52116002)(83380400001)(7416002)(186003)(478600001)(5660300002)(7696005)(6916009)(33656002)(16526019)(86362001)(4326008)(1076003)(8936002)(55016002)(6666004)(8676002)(6506007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 7cyF+oBU2mXY4gpzrsZ3KAqTaIHY1pP1LtMamhnEXEN8KDKse0VVAeG7PFaNaXuIbNV17x2OPer8i/c50iLS/e/wX/icnFmL8DfKmGyEy+XTe5uvR8RTVSQI7AHFpOn4VtPJ42Bjtj01JEiHi55mpunlj4wEmseBlEU/EQ1ea5+R6crA8F6lbrdpdpa7NwZDTA29TfnMI6dcEFa0o3CZYeMcWIrdsMdUZ77trTJpx699MDOoy4QclSIBnwAsUHYACZWw0S02TPaOpop9UGJB5eEc8PYXWlQObwFegXZd2myaICiuzOYAzdO7Hfj48XcpVIWV5GMqcvS5jCJx6H2M6CjeyS4DYk8fnsSXwxk0WYykrEFE/QbWGRoC5Jk0wDgVugZEpyoXxRh0u2DrcDsKJCTKAkBEFXx7Zmkc38icID9d1h/OZDj2Mje+BReRKdW+rm6gSm4TgKzHNH3J3zrwEAWiqdK8Hi/fLCgB7klFUZ410gPGDBXzXq2tZLW8txFyueIDBwXDytkYRVML938h9/xr5okm7mc51VCSsaR/ET22kzviaYcubOv+eMjbg6MLq4v4695N4VSe62vOK1Fq9/uF2LrVgBm6/gvNBGKyLWOgZ9V8rng7jiZNNtPQFlhD4LNuKleeZZeBQYpqiHWckAExt/vNIBhogQEOz0byXSU=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed99a0fa-0ea1-4448-8f54-08d86f961106
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2020 16:35:59.6294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Om8VpvsVOHRQFxEtO9vxifzYiZTba8lzlRq8kanZLu1ceFmSyAW0zs2DbEbYCAUC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3078
X-OriginatorOrg: fb.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-13_09:2020-10-13,2020-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=1 lowpriorityscore=0 priorityscore=1501 adultscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010130122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 13, 2020 at 11:35:04PM +0800, Muchun Song wrote:
> Since commit:
> 
>   991e7673859e ("mm: memcontrol: account kernel stack per node")
> 
> There is no user of the mod_memcg_obj_state(). This patch just remove
> it. Also rework type of the idx parameter of the mod_objcg_state()
> from int to enum node_stat_item.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
