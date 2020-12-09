Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8562D38D2
	for <lists+cgroups@lfdr.de>; Wed,  9 Dec 2020 03:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgLIC3x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Dec 2020 21:29:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:23488 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725796AbgLIC3x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Dec 2020 21:29:53 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B92PVvg024070;
        Tue, 8 Dec 2020 18:28:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=oB2by1Ra07Mac1TV4ubkEGeWAms1163mRFDXdVWzvBI=;
 b=E5Kq6SKS3iSIUv61ab5rnDkuLl8gNkMQnh99e6JPlKfrevrqHFTChHbSnOi8lETFgK0W
 wrhDq0hIw1ZUoB3EfVQNq7rQZa4BvcdiZggD/p1P7JXk+RKQ657GzQJV8V/Cb4HbZhMw
 XZeyBsHsj8JcofWd3LoyEF/If9X9BvUMQAg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35a0k5s62d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Dec 2020 18:28:59 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 8 Dec 2020 18:28:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYrrcpCG2cBFrZpgZWLnEaNWFJnYf0liKNrd4NQ8J/2GMHAeVOs/F/W4q2qzQPKSRj8yoTt9c0IxY4wxfa/2gOnm3heXnOgYwTrFJp7Qa6PQ59C7dCpO92FV0j2MlTWS99iiL2ltarKUhckMa0NNub/gU9mGV7dSJRit8jK/NtwvTJH474Nff3K0lpzGWTFYDYof2ijNuV30owa/fSqeuylUUH8+ohwQnAts9rArFpVUoKn8K7iWFVsY63doMoFIdzU0KY4rrWUBhdqCaDkthirV+ohiHVxBu5l/rFiilQY71vn/TRMa7YLc7rQu+9rhn6RFrjeyVu6ebdDZZq6QVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oB2by1Ra07Mac1TV4ubkEGeWAms1163mRFDXdVWzvBI=;
 b=Wxnydc4AOmqXzmCqTB+QqRfsbyVaTUBVYwqQ9j5oEkfWCHnK1uzcsSH3xFTPEMWeoCYGoixwol7I6tEoV+Ptnb5TMy+jP2a2cDb5Ok/OjNn7Ar7MXV+OXCcrYOmAom3L7VLQQ7N7UZ16xelEeFIMbu8kINw8r+gCcKK0O9PdJwIqIW6L5zeAuLULjwIdOxf7TELdseuOq+TJDRFLRjN3QRAf+LNOCdGY+D/ssXe4IhYRvz1rmoczr2nNVVc5ZEDZAz+2DNnyB9G+2YZyaM6o4BKAzi3jQO6CelGlRnZCPpl/cdKu7SjF0sHg12jinbSPhKCdnqWM2gGT7GNSBuLv6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oB2by1Ra07Mac1TV4ubkEGeWAms1163mRFDXdVWzvBI=;
 b=fNFDbVP0l4WuVoaIQuuZBF9gDqUohtITiaKvZxszipBlbAYFdsLk1eqBqCsIl6uLSwM0MqV12Dz/1hQ00+nZpZhARiyxMC2M6OilWOoU28FZURbnKlg6V++vOJF7yL39MzuK2L36Goz649+/Yx1CJURYpFXmZkY5ad9OZ4GNasQ=
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2341.namprd15.prod.outlook.com (2603:10b6:a02:81::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 9 Dec
 2020 02:28:56 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3632.024; Wed, 9 Dec 2020
 02:28:56 +0000
Date:   Tue, 8 Dec 2020 18:28:50 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <sfr@canb.auug.org.au>,
        <chris@chrisdown.name>, <laoar.shao@gmail.com>,
        <richard.weiyang@gmail.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm: memcontrol: optimize per-lruvec stats counter
 memory usage
Message-ID: <20201209022850.GC2385286@carbon.DHCP.thefacebook.com>
References: <20201208095132.79383-1-songmuchun@bytedance.com>
 <20201209022118.GB2385286@carbon.DHCP.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209022118.GB2385286@carbon.DHCP.thefacebook.com>
X-Originating-IP: [2620:10d:c090:400::5:129c]
X-ClientProxiedBy: MWHPR2001CA0010.namprd20.prod.outlook.com
 (2603:10b6:301:15::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:129c) by MWHPR2001CA0010.namprd20.prod.outlook.com (2603:10b6:301:15::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 02:28:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6778b9b2-30ef-4b14-520f-08d89bea2dca
X-MS-TrafficTypeDiagnostic: BYAPR15MB2341:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2341635D1962DDDFC11AF86DBECC0@BYAPR15MB2341.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vt/4cDhJsLy1RJ3IZdARyTHNlq9dIRUi/81HS2kBRs4FMcS4TMgtvK13i2PtWcE0dRlvbd/4v2ZQchXb/qyp9AOk8lqEWjhLUNBECvQBHBsA0yJH5gYnPNgdq5lqK4st5wzlto5hgBPJ47Nc3HujgMhFFZEpN4c1ntijfjT20xrHeRjDZgW9CQv69LFTD8dAegICDoSGtPZY07SNsTaAaUEXf2EUExuIoP8DnTJ+mtTCK+ojK4dpcqHcdXK3YT46hb4cws/xOsz+VODbsaNzk+A0+zq7p/bKumXCphsqs0Ftq0yh4OQItw3smOSBC1kuTKqYWX34nWKRuTTF7Y0uEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(366004)(346002)(2906002)(4326008)(33656002)(6666004)(55016002)(7416002)(5660300002)(86362001)(9686003)(7696005)(52116002)(508600001)(186003)(1076003)(66556008)(66476007)(66946007)(6506007)(8676002)(6916009)(16526019)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bQUSNkeCRGQXiowYc8q29tTZI7w9PC2zDWhzl7xdJdrqPrXbeuUAlo9BN/Em?=
 =?us-ascii?Q?nvZ2atESkCixJYHkCin4/MoW8SMrMD59NJtTerFusiGSUot33yo9+1OVJyNP?=
 =?us-ascii?Q?szav5zqrFWtmm10cNp/+5WKW3N/j/UIMWKbEphVjO5cejZsak68ABspK2MEu?=
 =?us-ascii?Q?JSFdQhyxzhRQe7wcAhKyPSWr8ee2WYxUSyM/R35MEh7Oh8idX72KLE+oEEjK?=
 =?us-ascii?Q?Ck6HeMR0Q3PZj5/zP4WToMbo76tcFykNkaNx2Hajl4SnOsRzaCa9lRnGE/Mt?=
 =?us-ascii?Q?5+F6OcjdnSpLAKVJkLwxFQo+GOZ2EWCEl7zO00us2QyREUUfcWtHs0xZkAu6?=
 =?us-ascii?Q?Y1DV2ZxmUT+qAv2UHCaG/hkoIPTE2AG1j0eqKZjQIf18X6CFrL+TifzFByuf?=
 =?us-ascii?Q?LS/S0twgVC0/CsA83qhZaTpD+kHoUS2TiDlpkQT4lszzQeDrYNaxPOyW6w3W?=
 =?us-ascii?Q?ex4/48h4DSeAfFz9We+zL0lWTjEdWlCo2IRtqOwyI83LcrHeeZ7lVASlaasW?=
 =?us-ascii?Q?fRQOcLzWMkMMYPEdHHVnF+ie8HlWHvZw+J6Shxm7eS8R1M9T/jaAuSEDajym?=
 =?us-ascii?Q?Ur6JG/foYz0wUv8RnqjG/QIFVEJ88ukAMjR8m7oJ4nMq4DPvQaAyAtrrx68N?=
 =?us-ascii?Q?F35wSdQRZV+h7u8wWYbHZAB1RAAYGKym8iw1um9YKL0W12OCv2Ewo1RRJ2ay?=
 =?us-ascii?Q?nhgq4yO1XJAtLdBmqGYoWOBDy/mk490EHsEkHo3zQQ8AYjnRLLQnrYl/r9hP?=
 =?us-ascii?Q?Naqh3KV93R8/b8v7IYQ74LvTPtgjNAA1cgcImAG7DGhWteCj5h2X1BiYSRD8?=
 =?us-ascii?Q?yr0u6BGpbBrP+5NH6BL+U5+lXAmYNh3aioyMwad7vpBUiF/e6e2P6NYbEuS3?=
 =?us-ascii?Q?yHK1qMPmdbvvD5RmojtDDiTjvKDPmpBWG9pJjWJXaoeB6tQb82cHtIHvlTTa?=
 =?us-ascii?Q?zJq3vdLRrY5/BljwpxRA+hqZfVnWa90w5xxtGd7f+DVaTchFVXBfzonLvKCq?=
 =?us-ascii?Q?4X4jSAt9weMQO5lXu3JwMHdbbQ=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 02:28:56.5082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 6778b9b2-30ef-4b14-520f-08d89bea2dca
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zoT5dD9zdhGRaeAGyDZR1WuhTzM49z67U0VicXUW0h8rHkIrayAzY297kQETQqy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2341
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_02:2020-12-08,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=1 bulkscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090014
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 08, 2020 at 06:21:18PM -0800, Roman Gushchin wrote:
> On Tue, Dec 08, 2020 at 05:51:32PM +0800, Muchun Song wrote:
> > The vmstat threshold is 32 (MEMCG_CHARGE_BATCH), so the type of s32
> > of lruvec_stat_cpu is enough. And introduce struct per_cpu_lruvec_stat
> > to optimize memory usage.
> > 
> > The size of struct lruvec_stat is 304 bytes on 64 bits system. As it
> > is a per-cpu structure. So with this patch, we can save 304 / 2 * ncpu
> > bytes per-memcg per-node where ncpu is the number of the possible CPU.
> > If there are c memory cgroup (include dying cgroup) and n NUMA node in
> > the system. Finally, we can save (152 * ncpu * c * n) bytes.
> 
> Honestly, I'm not convinced.
> Say, ncpu = 32, n = 2, c = 500. We're saving <5Mb of memory.
> If the machine has 128Gb of RAM, it's .000000003%.

My bad, it's actually
(32*2*500*152)/(128*1024*1024*1024) = .0035%

but it's still in the noise.


> 
> Using longs (s64) allows not to think too much about overflows
> and can also be slightly faster on 64-bit machines.
> 
> Thanks!
