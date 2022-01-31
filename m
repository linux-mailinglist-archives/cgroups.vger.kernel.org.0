Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925624A4CAB
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 18:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380615AbiAaRBq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 12:01:46 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4534 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380092AbiAaRBp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 12:01:45 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20VGnUVt005868;
        Mon, 31 Jan 2022 09:01:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Y4HUQwPeuAbzYap8tBpYSb9KNcPloBhp0o+4zwLzb7s=;
 b=WmqesgWQT0e/urveuv4u/sp5o892fmT0SwOSn6lorEPgiZI5adxBdwbUz1b0Qbx5rXQh
 hUGV+Uef9jgjjZSJZGU/0V3aRCt7QRHn7JoVpR7pYuegCeLrPVs7900chOs580donmrC
 5/ahSCWZWfsALgNRwUyITfUKQGiEPhLwTsY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dxh0p176t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 31 Jan 2022 09:01:30 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 09:01:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=df2TuqT22zOzsmMvKZeTeBWbGORSx+iQjAObxwZO4sTTNpQKDT6CHa1wkkPx4UnpkarmWNHya55XmR6j1Nt5Vs2sIkfIodPFrGgvqAUC9xnqbQjZA5tiwhlhDQ0PX8F4S61rpOi3Ix3GPccHIaGbXerRC7j0weRFAtocY2LBXFl9kax+VPJ/xeOzIp1+noM8jiFCRAjQmQ9V8mTM07RRlRs2oWxKW8eLkA8tm2OOtHBNfF8NRS+DWHF93AdBhAjKnZMSgzz9nubMNeZrlO7DL7/dyBrChNza+yZdTbw1YqU/ENa/QMu9y48ev26kiFGXe+Pbt2Y9/bx+5TrH0yGvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4HUQwPeuAbzYap8tBpYSb9KNcPloBhp0o+4zwLzb7s=;
 b=Hf1VLmWAyO84IyyupbGoQ/Q1NEMZpczTkRTYH78NYZ6oBytpJYUB9FX0TPFwPyK2z7rsDcGvl5jW7LstzscfWqNU0xaTiK/hFraW+F3sKZGXbFv4RGChdTFinz0vUyKtu6kocug29HNSDpdtc0Muw7X30P/3fzHOr3HueauTAGda7IxbqZdcRIlcFOYTElWSZ+579oO76r6geSlnka9m8D1DAc5Gxlq1pK1GPGI8Q53lyk9knE74zUVFFV7SM/FQ3bc+wXZPUJCVlQ2ojP+CLKelg+kXIgP0hcnxPIEw/KYyQ9c4j5umPcPfkkTW+WaNBQ1DvpI1giBDRvdIQvs9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by CH2PR15MB3654.namprd15.prod.outlook.com (2603:10b6:610:e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Mon, 31 Jan
 2022 17:01:18 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d4ac:5796:5198:ecd2%3]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 17:01:17 +0000
Date:   Mon, 31 Jan 2022 09:01:14 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH 1/3] mm, memcg: Don't put offlined memcg into local stock
Message-ID: <YfgV2iiaVlR0hozD@carbon.dhcp.thefacebook.com>
References: <20211001190938.14050-1-longman@redhat.com>
 <20211001190938.14050-2-longman@redhat.com>
 <YVefHLo1+6lgw3aB@carbon.dhcp.thefacebook.com>
 <f7026256-4086-6632-569e-5b13594cb3fc@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f7026256-4086-6632-569e-5b13594cb3fc@redhat.com>
X-ClientProxiedBy: CO2PR04CA0183.namprd04.prod.outlook.com
 (2603:10b6:104:5::13) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecea9a1a-71a0-4946-0e83-08d9e4db4c2b
X-MS-TrafficTypeDiagnostic: CH2PR15MB3654:EE_
X-Microsoft-Antispam-PRVS: <CH2PR15MB36545AD09ED5847EE196C440BE259@CH2PR15MB3654.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVZckLg+P2pJbDYQNbsIxMffPR2nDLS36LBVDdNFOf4pVaedhqi7o76A8exZTRxDvMo+Sw4H0DEyq7Klj7ZalU5Py+KvWssxg9k2Sm2bMtyIaqNbtV5me6WWKhbbU+qarijB2u/b2sND8sATIz/0hdU4BCvj4pcShs7vRZY2VeYQW5aPsHRSZ3OwuN34BTLcM+I6jQds0kgRtvdZ4VnjJcc1NkPjb28zXI0BvQFeMq7ai091StasMltF/dqcc1syGPWxcm6hyMRPtO6g5xDAQGPwGPZPpH17xDInG6Ng6gt34JgcxObOulTsvoB0Lmb9fvov36LqSpfgrvZWPwoDP59hbbEXUKfIfZPW3xIKsr8E0E+FBUQRRlU849jyg9EfAdyrPi2t7WnVmNOwVZHBzQnp6dwPuINs5dvaQlQtPTumSBJ3D/caT57UFYmo5sIwo9AAdU1MH2rlc/lx+6zuVY7NMjqR3IIAw+GRaSb1dy5wfwnFnNKmBoFT2zWgO7XWYrsDnfgBy3PBNKwVhgLtyMwwrN5DkrzqdAC/ahNrcL/uWSsgta2v3tjhN7WsQWhMLFzm4pMhFQLTyHPO0Xiak+wDElku2H0tmmK/v4eqB195uKU9JKGyf2sbnNdujzuz1LmOQfxh1FNyOTxLyWQ41BGbzArVHQIQvmK44+YSpSLOhEtb2jPAzOWKbB6boS2K5NhWRIXYdUBo97SjfRYuH9Paw4j+L3GTPcaygssC8ro=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(6506007)(6512007)(6666004)(508600001)(53546011)(52116002)(966005)(5660300002)(6486002)(7416002)(4326008)(2906002)(6916009)(8676002)(54906003)(316002)(86362001)(38100700002)(8936002)(66476007)(66946007)(66556008)(83380400001)(186003)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UL9A+gncwP+7GUsNWh7Gs5w2zf+46i8JHV77JjeVVFZ6VjkcdEHmOy3NDZjr?=
 =?us-ascii?Q?dXJAadknYMnQGg5BXWawiKC5bBz4lObbzqDbyty1tlh1sVjnl6jEUpxEt0mg?=
 =?us-ascii?Q?V3guvID4GGUVjIOQFhnpfvXapUA+4C7bkog0xXi8+wo0VNJUV4PfrCiouMvT?=
 =?us-ascii?Q?kgjr6nwVhxkAyOQdOAHC1RHsO9Oqug8o831ITGy9k7GUWlpoHcoz0X048mGt?=
 =?us-ascii?Q?ai0b6ee3SJ+BQERNkK/6LY7Q2Jr/pqzyDm6+F4FenKXjHhTRCfNJW+ovt2V1?=
 =?us-ascii?Q?zLqzTs9Jglh6jrieFjopeu/EzEMAkk+e1FN+CADo9JcWI3oHfOdB54yV59Fi?=
 =?us-ascii?Q?8Y0ywESdB0oVvqMaWBqcn6fgw/5zvWrraeZaNYah49pNDY2naeH51bc2LwQS?=
 =?us-ascii?Q?7KF/cjdRm/A+t6C9lIpxQrwVB4OsE/mEmAFeFbTsAyiauebzweFFmhj2al2U?=
 =?us-ascii?Q?OhIuwN/JMbjVwGfkGMf8uHjQMJE9lkMRKQ2y+RM0SACc/w7aGAFI5qaCnzv2?=
 =?us-ascii?Q?ndkDg2r/aDdzMJw7oWUW5lJKqKID19yiKdzOSPuGQjyKxzfLVZWjTlF218T8?=
 =?us-ascii?Q?69JT2nq2rlk9vMTNrZQw3Az6YwGf/FGC+NY2k0DEjApLcRwEy1hEgkk2fy/g?=
 =?us-ascii?Q?oAdlzQvRnP3703XJtACKzvOqy3k5Qz9CYDOSjTvnovxhNDOGCaqUJTPOOWqA?=
 =?us-ascii?Q?rEfn4mMwSWfgvfsA4c4evVUMKYOHP3fqfIRdWdmzsuUGCipf1wIU5rXWkUlL?=
 =?us-ascii?Q?Sb8Uf3g1GhyUGUt+ADO3Ozx9+JJAwCwvTb/zfYmk76Jd/913r98u4YC8Rx8g?=
 =?us-ascii?Q?Q4GeTJ7lXKmRAwIP1kcLHAziRJcYTNaW/yuw8qnHMn3mvhpiijWXxIjMPtd1?=
 =?us-ascii?Q?7ufqMmVTIxEkDFHKn66hWym+eSxdzTYgFKBQCup0o5F8rHgWoSi/x/abgGlX?=
 =?us-ascii?Q?4dIUj2FY8gWuxcWu2EESdbmf0wxYpyfKg6YdKuZROyXVpbGpYvnHgr8nFNci?=
 =?us-ascii?Q?pRXPJnEtiLDO6W0RWgp+NYDKYkyBAR9xO2A4gWtoLDe76kVw+vw7pNzksKV4?=
 =?us-ascii?Q?iTfdIBJexmBuckA8NX/c+x8nhfHYfw07L6fK3FIyYzfMUgkZeSEvn+IabnkY?=
 =?us-ascii?Q?6FxPTQJCtXTlxXZbQoz3xnY1RUuW79onmhjfg9t2hXmaAPu/4JRvD2z8VXun?=
 =?us-ascii?Q?NBvRyGfjIdCZ3E44p+4LJBLzBjVL1KTc+Qq4zxB+jpFugvqo6VPJ2wm7IYzi?=
 =?us-ascii?Q?fJVYvJi5LfavAFA5YMYlQ/QSPDRqefEmK6rR/U3k3qXXszFqDnXPB+8pr/tH?=
 =?us-ascii?Q?U1KtlquvyMKp4Z/RWjnQiYpKfiiU+VyVR9q99w4ILh38iLEWhraTajdOtLzH?=
 =?us-ascii?Q?Q3brtASz+EXEyKmN6ywjBMcLvcIfi+ijxNJuOdOUFBz4yYWf0ixzlDOwBan5?=
 =?us-ascii?Q?zWdlkS6GQ13kFA6I/kI4M6bombYBZv+VDiFH1pUMvx38cKV8sA1olSU/x+pQ?=
 =?us-ascii?Q?JaIATrpZ2/fjpl89fz+L5wPVD9KBiQr6CW26NTOAroGLffD1jt1Nbn7ieaPe?=
 =?us-ascii?Q?GVlJIa68ZPTxLtrM4Ac9/oZkn/P+9pIDAYh7sSt3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ecea9a1a-71a0-4946-0e83-08d9e4db4c2b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 17:01:17.8684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUiJIipV/j+sFPlxTxEcxaamORqckKQGD4hD4u1EwRvBvvV4luNvzuvHXnLhdIGs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3654
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 6m2deS2d4q1BcZ6N52kLfQwrKDf1CF8V
X-Proofpoint-ORIG-GUID: 6m2deS2d4q1BcZ6N52kLfQwrKDf1CF8V
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=1 clxscore=1011
 mlxscore=1 mlxlogscore=196 priorityscore=1501 lowpriorityscore=0
 spamscore=1 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201310111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Jan 30, 2022 at 10:55:56PM -0500, Waiman Long wrote:
> On 10/1/21 19:51, Roman Gushchin wrote:
> > On Fri, Oct 01, 2021 at 03:09:36PM -0400, Waiman Long wrote:
> > > When freeing a page associated with an offlined memcg, refill_stock()
> > > will put it into local stock delaying its demise until another memcg
> > > comes in to take its place in the stock. To avoid that, we now check
> > > for offlined memcg and go directly in this case to the slowpath for
> > > the uncharge via the repurposed cancel_charge() function.
> > Hi Waiman!
> > 
> > I'm afraid it can make a cleanup of a dying cgroup slower: for every
> > released page we'll potentially traverse the whole cgroup tree and
> > decrease atomic page counters.
> > 
> > I'm not sure I understand the benefits we get from this change which
> > do justify the slowdown on the cleanup path.
> > 
> > Thanks!
> 
> I was notified of a lockdep splat that this patch may help to prevent.

Would you mind to test this patch:
https://www.spinics.net/lists/cgroups/msg31244.html ?

It should address this dependency.

Thanks!
