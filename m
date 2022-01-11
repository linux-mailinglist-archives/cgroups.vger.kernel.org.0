Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F3548B550
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 19:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242839AbiAKSGy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 13:06:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25032 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350239AbiAKSGP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 13:06:15 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20BHROuF023962;
        Tue, 11 Jan 2022 10:05:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=yAY8PX7BTnX7FXfjKgeWGUT8GswRFwwcw+skPdHEHkc=;
 b=pVPIByDh6d18mnh/OwxEJ5Q9e8r5qoRRc5I+aVe2Adz87r8yeXSWbyeng2nKeNzKnXtZ
 QW90psPcDGBeyXXHYd8oYTtikSlXN9dW8wWa9E4TkRoPNq/yKXNqeaf2VQteDWg6n/Hz
 aL0oFK9SnjSFCG01480m2iFE9O682xW/TS8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dh86j352d-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 Jan 2022 10:05:59 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 10:05:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YilFZHlp56COL1JE4M/fY7yha8XvkRyae1/mrp4rlcHeN/5QmDQO+JBJ7Zmi6y2VgxrhhtH2YEkpMQc1Oeb2uGA6kHWlH9qxpIkFjqHODkrPSa+0oHSB2j/uezGn+up26WmaMv9Tn/t6TpbCW4ILuj1LEa05FXjcmIjcg8CICGa1vpjufQfgglo7Ffy6WN7cS7JkV2UNYG2Q6TJGKJ1fJ5zlbsy0ZpnIWwMzYIZpXu4yQX2DPpOM0EB+uFOi3oUSoS7b1UjAwD5s+aZz/nUi/ZQKJGx1BEYwaOmQV9P1YNPep7de6+FrMtrFwcBMjEomioqoVmLXItCOVHEp6DMlEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAY8PX7BTnX7FXfjKgeWGUT8GswRFwwcw+skPdHEHkc=;
 b=NdwW9GO2elsSya/CDCDhKsXiqJh+FEoMprG6z/J/ncD+A/lB9tDV906j6D52Y9LmX5FI/NDgzcAWIhGtsUAxEW7AG6GTjH+RQgO8Mhhkf08O3okbXhrZ9GZhlGKlbXOeXyA2v2C/t8MuABvKDlW2Qkd24fL1bWmqdAKSxU11sfzg1uqXlb932cq0t2igjJdC/DWkMz3O8GlWynhITLZZeKpjqIKwz4uixV2ar8SrljJPIlS2Eoy2r6m24m7evSQZcrIJmmqXhYsP7uEunmVBwgse4zF1AyDlyVECZTsJ48f18QrrDRql3u4mi7wvmyqmQQ0NenY6zaV90fXXIsOMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2759.namprd15.prod.outlook.com (2603:10b6:a03:151::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 18:05:57 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::c4e9:672d:1e51:7913%3]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 18:05:57 +0000
Date:   Tue, 11 Jan 2022 10:05:52 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Wei Yang <richard.weiyang@gmail.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <vbabka@suse.cz>, <willy@infradead.org>,
        <songmuchun@bytedance.com>, <shy828301@gmail.com>,
        <surenb@google.com>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 1/4] mm/memcg: use NUMA_NO_NODE to indicate allocation
 from unspecified node
Message-ID: <Yd3HAIh79YSUfpzT@carbon.dhcp.thefacebook.com>
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220111010302.8864-1-richard.weiyang@gmail.com>
X-ClientProxiedBy: MW4P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::25) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dbae2df-2282-4e0c-aa44-08d9d52d043d
X-MS-TrafficTypeDiagnostic: BYAPR15MB2759:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB27591FFCFBAFEAB81C224E58BE519@BYAPR15MB2759.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZbsZInyusL2ubvX6eZoSHclbYVVZJBZL7PRBLxrvZM12fIEIgyPeeY4Udzdi32dFpW8Emk2wow4PBCFWYZmpA1lS7glhIdHYCy+6WzKDdx405KG0A6OcAr/EJCp7ceL+cZYSjq1KNlCINsj0pZaqfXPBMpcO0x2cgBoDMGKirO1eUQMdUaJD4clRD09D4aZF92pf/fEK02kATd3nrkk9hIKs97+CI1mEqrwXsfUdw7ofVOaKciSj0dRf3o1ji7EZ094DY0AckEY9urQXyM+21hd3uuCDgK6o9M560EvKJ7dvmmpuQ2JgOxEYF8kv0Zb+l2MqwYOl6yyFzqR0hrfUVJWLju+/JhsPKbFDqR5kpApxeEWEUucAzFVfh2GUAnII8CbsRBqZh/Z7fJzIeQVZPNS8UlvInRUu1XPmdDWE1b5PmZ50I1Fy2LfEmII2B68XCD93liJRO4LvsFH+jE3Yk9FAeJEkDYkdEsD6DsbdLc7w63Vg6kCl5ZUpbzZctRuIuynJc30+jSbtGka3jaTYZU5A9k/iPS6n51PZ5k+1eDZoSpIwp6unn/gAA+njWaShsYFwHxd0PdTErc7KG9Ntu69cGxGTN83Ja4BQ+t5/VK7Q1Yxb6nbKX6AfYOBD/5ffzmgUS24lTn2XE31iWBjZdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6916009)(6512007)(508600001)(316002)(6486002)(86362001)(8676002)(52116002)(9686003)(186003)(4326008)(66946007)(5660300002)(66476007)(7416002)(6666004)(558084003)(2906002)(6506007)(66556008)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4A8sCoAAkEPOXGw3XWWeFVXgQse1LIQDDhRMs8gPejlY4CtxM7xlUEXIhOH3?=
 =?us-ascii?Q?EeqmQHKpWiC0nB77XeSkY3CPuBHfoB9t/9lyN0GznJm/jsJESejb7KBDhzvj?=
 =?us-ascii?Q?KikFE1DZW01AYEWDen8vWLqq9iEMy5zcAZwir6IHUIfdaJaaUdj106QueyIK?=
 =?us-ascii?Q?j8lwgBb8IwR+Vcw+ptk+5xOWtqODUL20gHPwDNapvCZJQyWcvYE66sWlXI/W?=
 =?us-ascii?Q?nFg0oJLFA4T/HmNunlwtzENqb7dscoAov1FUrRdsxwYMU3wOoi5FUAe95/Hq?=
 =?us-ascii?Q?q6+diN1PDpKZrkCaKod7bZXzBvyd3ylNl4WsKpweHdqEfcKhHZxArrgTGYtj?=
 =?us-ascii?Q?8txsQkx1UPUDy2VBkvcJFhu+9uXXSBOb+0fOTcTLO9BRqKXvv2Qs+EHYxP2e?=
 =?us-ascii?Q?/+d2zQKOsTtrJoE6lWHUsCa7eq8gl0sctewzbIxW2iHksc6PuzjTmoDJ6QfL?=
 =?us-ascii?Q?y+0mf12cV6K3n/6yzLEj0e1uQUezqWBh9e+yaNGgzIwCA9TN+oTT0FRnacLE?=
 =?us-ascii?Q?5k4b/AfQPJVEseDIjlerMSuFq2qw2h6jrYUlrK9EcvGgox1Ld9Vo2wnryFlM?=
 =?us-ascii?Q?filGANwYmv3PZ7QKw2EhBrD41S4p3xwGLGnr7kSO5D3BnIcTNW4vwmGHA3Q2?=
 =?us-ascii?Q?nidibBWSyHHN9A3NVrixg1UdbcT5SAipGFU8nIe6T0rhy2pN/8b/MRqqTvRv?=
 =?us-ascii?Q?IOSdo8nl+5BjBvGEjJReQOU4mq+lAd4LHV4/xAKAPB1WDNbM7gIIxkEOziQq?=
 =?us-ascii?Q?IBS6/p1XzE/t0VGnTZJ6TO9obV8uz1iK1KEVFkXh7RcEb5/oKHqegIMbMZMD?=
 =?us-ascii?Q?pYYazd2hMzDYos4+in3wrXMZ73qdBLRudVB7ULcOmjP8j2zpVbGopFYFD79E?=
 =?us-ascii?Q?1hSixondh/ssmC5AgUblKGbBHniVAVQnAP/rXMDNELVIxcIdFh5y3BboS9D5?=
 =?us-ascii?Q?jCxCz6XmVhV3Hj5zsDUGk324tgoCdFg4xZJJNuFANpK9hikttLPjYfHUjMIq?=
 =?us-ascii?Q?J3iWBxGadDjnPGTkx4deSALSBOQsIFho+267YKhruoN5pTA01fZcn3GGokjX?=
 =?us-ascii?Q?t9QRjzmNMvahaGh/BxP6HZXOgGZbBOX6wFUjLYM/fD1IVP+CqjdXAWF79Oze?=
 =?us-ascii?Q?XAzEiFB/8lay6UPKEYXdD0SYBqK5NRNYf50znT4YZX2zXSB3zst92PNrIZY8?=
 =?us-ascii?Q?i3L8IsswV+noqKDTBPn0FN6KIdR3KXQBKKzEnyrmRtRMHBNuGWIyEqg3fjze?=
 =?us-ascii?Q?KRj8fyrEmekXwhCP/CV1YRYzX3N3N9ByMdprHquxJJIm1ZGnbwO7uIDv3UHT?=
 =?us-ascii?Q?e/RBQ/v/KvvSq58Mm8CUPiWbahcazT2oBdCPmfP5Vki8xG2B9hCRu9ICbdmN?=
 =?us-ascii?Q?Rlzt4qh23yM9IyjgN3Y+QojYu2U7NP+eMGhsmsQ0ctmYcZpm4ByidwSiUSnB?=
 =?us-ascii?Q?bOuIhJscyiqCJDsuewk/LFeLHnYUXJEFzY90zpuK/K7jIBb+IPndrhwqrbjl?=
 =?us-ascii?Q?npG7P6Ys8K9gi+Vd6841t8HqlEilpTcmLFR4H5A7eMT/JoywKcPXJNsdfSk/?=
 =?us-ascii?Q?0i2Tlrn2lrg06zgJZsASqo4gvDIAGoHxTMpwUZ83?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbae2df-2282-4e0c-aa44-08d9d52d043d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:05:57.2280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6eJFp3ziYizIeDvVEDtEbr8tD9lsXNCQyIqZIGW5UdG5GWr52eSzSvT17F/c14G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2759
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: b7pKnt4ltMs0tC8NLoulM5uczgPqe0l4
X-Proofpoint-GUID: b7pKnt4ltMs0tC8NLoulM5uczgPqe0l4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=608 bulkscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201110098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 01:02:59AM +0000, Wei Yang wrote:
> Instead of use "-1", let's use NUMA_NO_NODE for consistency.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

If the patch won't be dropped for Michal's work, please,
feel free to add
Acked-by: Roman Gushchin <guro@fb.com>
Thanks!
