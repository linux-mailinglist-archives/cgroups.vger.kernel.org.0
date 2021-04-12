Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582F135D0AA
	for <lists+cgroups@lfdr.de>; Mon, 12 Apr 2021 20:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbhDLS5y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 14:57:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36284 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229879AbhDLS5x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 14:57:53 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CImJsI011044;
        Mon, 12 Apr 2021 11:57:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=2QdfVKOzUZUP9mQhzuZsqRoGbBGRmOflAC/fZjm+0yU=;
 b=eZh7sMzmuMEYAk8SZy6j26znt1Bq8esGowM6BTbCplxclnrSTO6dkGLcDnqth8ocSm1K
 sk4DFMw/GsiFdBYJVGKL7OtROZjKwW3meJCCRd2I+eSgg4LY91woJJ0cVNx4MucEeVW/
 0C5EZHUDhuoQby0rrakTgyNCYHP9tLNbVkg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37vs1ch5p7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Apr 2021 11:57:17 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Apr 2021 11:56:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5vFf2RoWj/sujGo/UxxV/UHZjHSFId9UTfN012vNAyMoPP4DWryFN815aei3OW0Nj5yITUk/sspZHMKVfjTVpfji0H1kxzWc9Ew42k1TsLMdm79WRyuytuZmKJ1KNkXw3zR6vZePIYQqcEhUZNOjFw4Y9x18XySOwlWSUJJR8OS+vCNxuphvN0rKKDYC7Pgw7vk8vfMXSj3C3YFj4PefRY8P2eTioybNx3KhIaOqHyL6U+ibjeqGJVRYAbbU/9Xu6EdPVVFror7jsStucY+kuqYieeSblk6ShJGObQ6a90zCvKzvWcOT2pnFI9Uf2cA+m01jnheuBNeztnX7N72fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QdfVKOzUZUP9mQhzuZsqRoGbBGRmOflAC/fZjm+0yU=;
 b=HclHqRVqyv00QLfdF6jNTOtmhQU17lWk3zGY31n0RHBibrADjn5ZqMmrNYxtvbKEUmyv7KAG/X6H8yGV92cG8rZCHSXPDRYIuVg4B/drmewqtRDB6v90IuB9jcpO6zwILuDWSfwLBniCwhLC8maCMIwJzu1C72Vsu2GNOheeX3eqQVYwZcc29VG2RdZAxs7UgjOgj+UfKJAjsF7+PM4ElR8e7OgPRpHZVe+49ACh1i8Qa1nbhSoai60e1Q2+mrmf4dCq0bUa1kH5NWfesTYDxKkEAQTzYvE82WQcgiHCSCirhq3kV9ALy2OIm1KVt1Q3EbsywppGAjK406hI9QeEEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2279.namprd15.prod.outlook.com (2603:10b6:a02:85::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Mon, 12 Apr
 2021 18:56:03 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:56:03 +0000
Date:   Mon, 12 Apr 2021 11:55:57 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: Re: [PATCH 5/5] mm/memcg: Optimize user context object stock access
Message-ID: <YHSXvQVvzHu26u7H@carbon.dhcp.thefacebook.com>
References: <20210409231842.8840-1-longman@redhat.com>
 <20210409231842.8840-6-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210409231842.8840-6-longman@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:f281]
X-ClientProxiedBy: MWHPR17CA0086.namprd17.prod.outlook.com
 (2603:10b6:300:c2::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:f281) by MWHPR17CA0086.namprd17.prod.outlook.com (2603:10b6:300:c2::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 18:56:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99813838-9bd5-451b-7b64-08d8fde49e9f
X-MS-TrafficTypeDiagnostic: BYAPR15MB2279:
X-Microsoft-Antispam-PRVS: <BYAPR15MB22796624120746AFCB5F53C0BE709@BYAPR15MB2279.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPC7Nu5vF2DUflzrEgvDP1a2Z/BPuO7vWVyCuj4Z8BSQwppnSE3RLw79MGzIHGKdCdGAdGmxt/NzvyQpWVDDdgjZsNInE4GcZXPWVnpnPdDSrAK/q0L743VlKEe9bLIoCqi3tR1eqT7jJeaYn6ellUZ/+ispU4/nLce/0cv64uB4c0LdCOP/JJce2Q4IqJ7tsIDfGYyvu/7LdO3q+u2cb+N1Q/vstU9cUXp7P+SuVO76uIvNNV+aAcPRTnnd6Lf6ktctSuxPsY7LI6B/x0o6TnKUrQ0dONJ7CF0gtv7PWuJvjBrJIy7UndzJKJbZL2xN5DtqL9N0X74r9dYrrlS6FpZnXz4DadI8LJJrFtXHnQUflNDv44dRxeFieYZF33g63pKHUKq4STh27/HpiSxpfwk+l2gkJFZtPpiGDJGIRDxRuV+HHsvjulMOzHOFpcL43DpbYujdOpoJmvXIXGhvX+VR70LPPU0p0l9uAoYy/AISKH9mX/4qaQ2JmAN9QvljT1qGlua8ruGwuoNo5++lNkMK8vBhAQh877aqvqdh45vI5vZDyhgqkKhYeMoUXt/FiqCkb+r4VLE9lQyHuZeQ7nc0mTj2d2hPEMrFcl7jesk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(396003)(136003)(39860400002)(4326008)(8676002)(54906003)(7416002)(478600001)(7696005)(52116002)(6666004)(6916009)(16526019)(66476007)(5660300002)(186003)(66556008)(66946007)(9686003)(38100700002)(86362001)(2906002)(6506007)(8936002)(55016002)(316002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XvDgZ832Jq13t0KPdwwE4mZeiJNGAo0PnYsIXzFBNdh48PkkJkeJeE/uv7Rg?=
 =?us-ascii?Q?h5fyCMM8h2hoyvjf7C9K22rs3xqdj3j1ekBf+fRpJ+Q9i5EQDEV4bsA/1XhF?=
 =?us-ascii?Q?tsYncFK3jPZkGVaA50Kvt4iWRpOkxFAX8gYj6TVWpBmlQBULv58Wr0f3ZOVN?=
 =?us-ascii?Q?lTtQcghL9UCfAOEEnISTnXhFcJK9JJtoCTINz0jtJRKVEWlq6EnNQ3WVZQGX?=
 =?us-ascii?Q?AZxkSc4YlrdDYBcbPd1oAEb9J2XI3j4+7d3tFyqnvhpxh9SEWcGpOPRrovWI?=
 =?us-ascii?Q?qJea6XdKjtMp3/nQcxFCxPccEb2GbyWVfRE5+MVo2Uv08WDs5AmLhn8/UEQp?=
 =?us-ascii?Q?eQMtDDE42lnDrlScGsRuqmol3WmIlLttufMp070Snn37JsR4K2UmLHEPB738?=
 =?us-ascii?Q?FBgUZgWIheVkTb5Mzts23rJ77fYzGHtIBg0aOX0jxX/O2xBdL09b4cLn8h3f?=
 =?us-ascii?Q?uZqbiLV2gcCsqDqMHj73I4+iehtE+KjTKq8hSLIy7TVVxZpUgThFydwjH1mL?=
 =?us-ascii?Q?bXWQmNej+ZhrG4URlYRXsi06z3ApikMSPW0e8z99vuYJ+YR+um/Lynn0C7o4?=
 =?us-ascii?Q?sQemw8B4CjA9+pU6vODkWX+y+hIjMmbELnCcuinL3bei20A6QNxVhQt9ioAO?=
 =?us-ascii?Q?VKouzmmaylAffoxtUB5BEAtFjGZl3Ua15mqnslQrFuktYsA822BIcRkVj+07?=
 =?us-ascii?Q?FVEuqCFIwI4Zzjv6dD4V2J5dka9edmMfW7gBJ3nGoKXs6bUcnU5Vp5An0eig?=
 =?us-ascii?Q?xzkvF8gwXEsC3dmLOC10IHmANM1L+orBd57qSwqYjqWY7TBXzQAUdwKaqmd2?=
 =?us-ascii?Q?cug+m4MqcNRLCPRo3QaPIpCYpnuwNqxxbY80g6o3//gCGpSHIVqpnRYfPOKL?=
 =?us-ascii?Q?s9v5Enx4jBPiVrk9l3gcbyxJELyr9+cSWIxYzuyq/pgYS3Gapgc5w/3A2/9q?=
 =?us-ascii?Q?4XvslaVHWtAZ1YWo1Rr40mlgIt4agGKeP6n2CWF6NL5G3kIhgpV30CPlc1o8?=
 =?us-ascii?Q?bBEcuRloYJWDfRiOSVN0B+Qka13I6Ldm4DV1nAJZpCauJXJAzLfr5oHmZmK+?=
 =?us-ascii?Q?+F2O6bY6VJA0xlU89BNESZCb/qVDFY3yNWbOkh7gOFyhqpHkg20V4q0XC8Js?=
 =?us-ascii?Q?lDRBLC+8191IMlAiiWw/kZWvIlU11LWPvqN42gX7bxUtXPJld9Ms1DbqAEjY?=
 =?us-ascii?Q?DIawT6EBTfjmcyTJBp5xxmltk5QlXio0kaAlmsNvbV8fF+vXUli/bRkpPESH?=
 =?us-ascii?Q?foCtvX7woiqujRwQeo3lBRez8MoT/FEbXgWOvUAkFlQCMl2WiNL67/Ixm8jx?=
 =?us-ascii?Q?cRB19a5AMYfWwkG7nzpV6OIyxVyr40bAc4ERkhUL5Sibbw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99813838-9bd5-451b-7b64-08d8fde49e9f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:56:03.1566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cf5o7zOX03uSKXymphmdQggGcz6IQ7PbITMgAR4/NhhJJwucnf/VCas5U9gGPnf5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2279
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 0IkPsuGjqzfu2PvBMlng_0ELLvCvP7Pk
X-Proofpoint-GUID: 0IkPsuGjqzfu2PvBMlng_0ELLvCvP7Pk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=818 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 09, 2021 at 07:18:42PM -0400, Waiman Long wrote:
> Most kmem_cache_alloc() calls are from user context. With instrumentation
> enabled, the measured amount of kmem_cache_alloc() calls from non-task
> context was about 0.01% of the total.
> 
> The irq disable/enable sequence used in this case to access content
> from object stock is slow.  To optimize for user context access, there
> are now two object stocks for task context and interrupt context access
> respectively.
> 
> The task context object stock can be accessed after disabling preemption
> which is cheap in non-preempt kernel. The interrupt context object stock
> can only be accessed after disabling interrupt. User context code can
> access interrupt object stock, but not vice versa.
> 
> The mod_objcg_state() function is also modified to make sure that memcg
> and lruvec stat updates are done with interrupted disabled.
> 
> The downside of this change is that there are more data stored in local
> object stocks and not reflected in the charge counter and the vmstat
> arrays.  However, this is a small price to pay for better performance.

I agree, the extra memory space is not a significant concern.
I'd be more worried about the code complexity, but the result looks
nice to me!

Acked-by: Roman Gushchin <guro@fb.com>

Btw, it seems that the mm tree ran a bit off, so I had to apply this series
on top of Linus's tree to review. Please, rebase.

Thanks!
