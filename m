Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BE2374813
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 20:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbhEESeP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 14:34:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11338 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235201AbhEESeK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 14:34:10 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 145IScOE000785;
        Wed, 5 May 2021 11:33:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=c9/kI84saANNmtSvVMDkjOfEMUQKQ6R+xzsfRWOt7mw=;
 b=ibj5NT1WAXdStd2dxB9xC8k9GXecsw5i4kF0lGRSYeSG1I2QJ07caRYjmQuzADhEQqhS
 VX1tP3fhz647O6c4Rti7b5WgSWj6iIVXmCI5XPdad6e4b6ZL15sa+EKc4SUx8+/YDFaX
 O4lIYxbld0XmoaD7QFdx/HXZleWG/CGlHck= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 38bed1w53s-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 05 May 2021 11:33:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 5 May 2021 11:33:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Irr2yZU5Zaeno7uC23ribes4Wsv0r3F1kKmfw75YkpPLo/2amxEsVPK09ofx/1IO9edmbSXqWTPcSDV4Ox4bwezCcrHovGe5T2vG7Zrorv5qJmdKFclInCWHamUbnQq9p9shtKZp6u70cDvXVkfpiX+6p+C5/8cNuhNDSZ/5m453B4sd/AOihl9bMjenWlKRNQTDRrTPd5lAGPa+JBFE90sxKwOWnxr5LC5EyhQ/a2twvG9Qe/K3POmc2XuFtW5jX19S/X59/U07A9XoytVJ8FHTzZYKXGUPb9SrwDHHe1Wtxx20uwVvvp3LOnDIKqgq2haWBg3z8tS2wPWA5SM9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9/kI84saANNmtSvVMDkjOfEMUQKQ6R+xzsfRWOt7mw=;
 b=aR86a+Lb/gcAPjARC3l/AduCDh5BDVhMJAyFD5k5FU2dqv1a+HimB2QB8Xe2b3Vsf6Ygxxf6iOMoMgVO80izd1idzJmeauhe1rHVA7TEK9cC9LaunfW0LesruZxWeK++UXigyCEgu1o504pDXK+lPDMY2v1s+1toci5lENmrDFqZONGNQZkJh55RR+Ml4X2bTSaAA00ES1YrW1dyrX+0/Z+NfLoE1BzvXbztIEhsMsgjJI1hhELxm615cJwIku3QvS6R09a0jZeGmuUccium/nLMPMEznw5MYCa9IQLGZJ1wz2RH9VTXlGw8yxVLmI35I29JxGL8UOi+0GSHps2c6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4598.namprd15.prod.outlook.com (2603:10b6:a03:37b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 18:32:59 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4108.026; Wed, 5 May 2021
 18:32:59 +0000
Date:   Wed, 5 May 2021 11:32:54 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Shakeel Butt <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH v3 2/2] mm: memcg/slab: Create a new set of
 kmalloc-cg-<n> caches
Message-ID: <YJLk1tmDeGed58yr@carbon.dhcp.thefacebook.com>
References: <20210505154613.17214-1-longman@redhat.com>
 <20210505154613.17214-3-longman@redhat.com>
 <YJLWN6bNBYyKRPEN@carbon.DHCP.thefacebook.com>
 <235f45b4-2d99-f32d-ac2b-18b59fea5a25@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <235f45b4-2d99-f32d-ac2b-18b59fea5a25@suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:ae13]
X-ClientProxiedBy: MWHPR21CA0037.namprd21.prod.outlook.com
 (2603:10b6:300:129::23) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:ae13) by MWHPR21CA0037.namprd21.prod.outlook.com (2603:10b6:300:129::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.1 via Frontend Transport; Wed, 5 May 2021 18:32:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2a48eca-541e-4271-7d91-08d90ff43573
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4598:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB45980BDB4F36BC30A1D5EC48BE599@SJ0PR15MB4598.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pydyuS+tzXzYMWgoGTeZ2i2ASwUQCBm4bZA/tWEJAI4yeORJ8IcfPNPldQygHM+Z/0b+1vMLVKYv0T5GsJrxPWAFKXuViQEekk4EJ7vrZz99DcrrzsK5UKoPSfFocxA1cbSrggCwEvZh8i8kq5B/hKS1EEbvVElv/E7Nad3wugOwkOLVALJhw8JqlabXJSEiGZkvDl0U1R4wAywSO+SOmVnqgnoxXBrjgt0h2WZg28/4eS+D4Ae8k8Dkt+YtJfShpeGG+8rlG50WiojBkpwWOtq5b63Geexj56jdGXGAu/ip87faplYsJPOzrXHArUP33pC81csFdnGBh9pIFVwpNlWZNCgskCnvTVKEv2lcxxv6BiWcHyDzp6Gp9dH6HxqYKf3saJNUKLez+UUoaIcZlP0bLG4WI7ryl8HzoB0/gh7YRsl6OJwlHTtMxPSKE6EEmr7OUNDLzFXuk4Kp7cXjTXciMip5Vjbzx5L6wjQNaspW/WQeqzebOfilYmpTqRMUkgr5M6gN6STx4vP+Jos4Rlt0UTGDewRodj+uOczS9Iorh2sCAPTTp4nsOBKYiAdW4bOi4I0HbSANJubw2owsKeGVoKjM4YEXBlKybnG2cIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(9686003)(6666004)(66946007)(8676002)(55016002)(52116002)(7696005)(6916009)(5660300002)(4326008)(53546011)(6506007)(16526019)(186003)(86362001)(316002)(38100700002)(83380400001)(2906002)(66476007)(66556008)(8936002)(54906003)(478600001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DsV+nxRbULl+aCIOnSO0dKtLc25IzxPoL2S1CnLTEGnt7tQilAinfiwktdhs?=
 =?us-ascii?Q?4E4SN5iIwGeaV6dMR9yS1PX4qyGY1DxoV4g0SvmMpzRYs0VL3ivUs9ub2X4o?=
 =?us-ascii?Q?KJ0CgWtTSG39NRNh4kO2zl5X7c0JJr67khPXKwFYvwfgb+2doQTOnOrlDBCO?=
 =?us-ascii?Q?St7y7ZEh33r7M+4Q3iEk81LzbqOks/hJPXWsVLfbJj+BvELbC1J1yvRMzOKU?=
 =?us-ascii?Q?68y5tSwQkN1Sdg27yVh70WqgxnvbsJeQf7/6WKocc6WPYi+IqPZhe/fZRZUQ?=
 =?us-ascii?Q?+RCcVx5Ff/DpJV5eienNXZg6Q6+UoN1kISQexkVXCzgvRa/Ah2U/k2VJisdb?=
 =?us-ascii?Q?f2RIkFicvKpQMcpYfp491T+oSig8hxFvgLewgmV9eTGvJ+AXlV2AT0l68xrx?=
 =?us-ascii?Q?Hgvbm3qZxF2JtIuSXMMLo5jH5my+PNa7SQg6QpVE+4jWA4RTVok4CWMTheph?=
 =?us-ascii?Q?vyJPlBjicUVcYm7LO90zBfyV32OISBuH1oWmWtSu0QxGkjHc6wJoCyJLFaAC?=
 =?us-ascii?Q?EPpWLzpsTfdqQ2l5jRknZ8n17C7H2sWjS8ge1fLWLB6QAGl1HzScMjeNGjY1?=
 =?us-ascii?Q?ild6aUBoUc9ImoDUyX6y0aGR2kNBEUl3uO+Gdy047j1W9dU6hX0A+L37rIKI?=
 =?us-ascii?Q?amUu0b5ChZFV0E8mgXSJb6QRKNP6BAaoBf+5FggtdvK8wjjEfosK3HwiArrp?=
 =?us-ascii?Q?BGLZmPbx5BW0XL97E/ykbzxjBnbvWRAGD2Oj9wUVcafKq7CN4u8uWs1ZBMEw?=
 =?us-ascii?Q?Zd2LlnZStjjnVMtcFWs8bfN0sbcuI+MATlV4zxMutIY8ljXHYZufPmnCokF0?=
 =?us-ascii?Q?YiLmqDGLlxe/bbHv7qMbfylI1HqRf/LEjAS7u4+5DY/kfQSKaUxEX6E84Okg?=
 =?us-ascii?Q?LH0ihtuLxl3Xf6i2cpZHhU4jBkuSSwvwokFFhagORIo/GWyMN6oN5kmzoSn8?=
 =?us-ascii?Q?WP6RKvAvdzfxWfoJYLqIfXXIgwVKrpJ75tT6lPB0WQLKwQ2MLNMVE+FNk7W8?=
 =?us-ascii?Q?qfYciATI+NMOW8VITqA6ixBk3xsMoWHmUKbZnKdH+fyroI5nbAYF5ak6kZGX?=
 =?us-ascii?Q?tutmQh3WgkI83AcmFd83lEBY34k/ZEhGKXZNm1iny9CK61G0JciJQNTN19+l?=
 =?us-ascii?Q?jNT2SgmCUtkXvVSnPcqvbhySHpX96DBHiWRdjzBYDJK+6QPEjJ3776/qhmn5?=
 =?us-ascii?Q?iVcp7sKBP6AbjvmyAhkytZ8SyZEwncomhrG/utfMf3juRZaj04B6bSPW8NPx?=
 =?us-ascii?Q?NdAJWrmLa2DwATHGKdhPf00pYcCPRuXwgqwxnmEV/ZZsCl7W66qhV7X9TXDu?=
 =?us-ascii?Q?t/VsPMlyfM6tvR983GjW2JBvwSyIR0qqQwPDxhFQ72lwDg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a48eca-541e-4271-7d91-08d90ff43573
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 18:32:59.4555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fw4k/AM1FRVl+e566IrqwjkVxnIZmB26TJNuj7OPZ234lzrho5Oy79wQazbyKxuj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4598
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: LCz9zzVAs0pC4s4tXxCpSeonp9Yh9Ecg
X-Proofpoint-ORIG-GUID: LCz9zzVAs0pC4s4tXxCpSeonp9Yh9Ecg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-05_09:2021-05-05,2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=972
 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2105050129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 05, 2021 at 08:02:06PM +0200, Vlastimil Babka wrote:
> On 5/5/21 7:30 PM, Roman Gushchin wrote:
> > On Wed, May 05, 2021 at 11:46:13AM -0400, Waiman Long wrote:
> >> 
> >> With this change, all the objcg pointer array objects will come from
> >> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
> >> both the recursive kfree() problem and non-freeable slab problem are
> >> gone. Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer
> >> have mixed accounted and unaccounted objects, this will slightly reduce
> >> the number of objcg pointer arrays that need to be allocated and save
> >> a bit of memory.
> > 
> > Unfortunately the positive effect of this change will be likely
> > reversed by a lower utilization due to a larger number of caches.
> > 
> > Btw, I wonder if we also need a change in the slab caches merging procedure?
> > KMALLOC_NORMAL caches should not be merged with caches which can potentially
> > include accounted objects.
> 
> Good point. But looks like kmalloc* caches are extempt from all merging in
> create_boot_cache() via
> 
> 	s->refcount = -1;       /* Exempt from merging for now */

Wait, s->refcount is adjusted to 1 in create_kmalloc_cache() after calling
into create_boot_cache?

It means they are not exempt actually.
