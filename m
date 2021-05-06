Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FD2375BB2
	for <lists+cgroups@lfdr.de>; Thu,  6 May 2021 21:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhEFTb2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 May 2021 15:31:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36654 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230375AbhEFTbY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 May 2021 15:31:24 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 146JOm4u018420;
        Thu, 6 May 2021 12:30:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=V/1Ervagg+TQPuGHNxagUcUzsInE01N0m8/R8aAIq0M=;
 b=mi87XVbsxWttQ6ukovPqosC2xxRV433HcwKRNOWFLCrc3i8JCixv2ph8NU2MhCbRg1O0
 lGXsft/lMqmM8gxga0sRd7TsdnEBv0oFCGn4RYtu4Pz7DMC0KzKHeZBNEHx6uqM/gwQc
 FkzZR553hP3S8V0MaTHcShhEQ2fePOjL454= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38cn6s8j9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 06 May 2021 12:30:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 6 May 2021 12:30:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PT0opYKzWZBzl1oBlFovhvzguvxw0kl724+MhppW7T8w3EG/v1aiTM0KfPyttZnFH2oqsD8/4mLi4CKOBcDsqCnRamJa0fCYUATJVm/A2qtyafQ2FLr8INh7+pO4sFYgGupYH+oBWBwD9i+ZZjgud43r5HxEkZ/lJkzJmR7hwzP2KFkO6XuWIryTfYp3153f27ghEcRKEb3ygt/UoW0VXnkbsSlzDy6gf5r/OWd3Ucru8UMKLyHDWAYuWmcd1pxaBrzjt7+qgt85vf1o4Qh1F+pbOTwv5WZ2v9fZTLHD5Nzt7YWHYOIgGUMxNqlq2Tv0ZVnFer07MXi5h45Lk7e5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/1Ervagg+TQPuGHNxagUcUzsInE01N0m8/R8aAIq0M=;
 b=Psxph2Ne/It6GkBbnOSdQPzn5CdD9tP6cHCftQLa4oacnnEJgzREP7BU1E1pyaBbu2Jn3eLQ0lqLfNT+M956evPvMVyeriHAgp+SIOB9wZ6UZiocxiPuhhmmusjN/vg92nT0/lodMcKJ8bT+dhkU12jjc1xX8IIDZWIFUM21vNmU8MLe4oO+E3OOiYup5YucdJdFNVki3Px9ZV6A/G2TbQZtERWZ+Wq+P2oHlGsQ0+34rt5e9AZ+g6NQ+jcX/UIAGwoTkLvi7E0lqY3sTJ0YXt3c2PRvAztPEVK/y2sejyqfY2eHDXZRLqjUp8yDpvuuwf9aVFHMyOJlvSb5fDNnQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2440.namprd15.prod.outlook.com (2603:10b6:a02:91::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 19:30:08 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 19:30:08 +0000
Date:   Thu, 6 May 2021 12:30:04 -0700
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
Subject: Re: [PATCH v4 2/3] mm: memcg/slab: Create a new set of
 kmalloc-cg-<n> caches
Message-ID: <YJRDvM6jtvzwHtvA@carbon.dhcp.thefacebook.com>
References: <20210505200610.13943-1-longman@redhat.com>
 <20210505200610.13943-3-longman@redhat.com>
 <3344a04c-0cff-b997-f357-2ffc8e3de242@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3344a04c-0cff-b997-f357-2ffc8e3de242@suse.cz>
X-Originating-IP: [2620:10d:c090:400::5:b72e]
X-ClientProxiedBy: CO2PR18CA0050.namprd18.prod.outlook.com
 (2603:10b6:104:2::18) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:b72e) by CO2PR18CA0050.namprd18.prod.outlook.com (2603:10b6:104:2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 19:30:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32e6b18b-155a-4141-4a8e-08d910c55b7c
X-MS-TrafficTypeDiagnostic: BYAPR15MB2440:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2440BDD6C996BE6754215A69BE589@BYAPR15MB2440.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5mIX1Ya4qYCVHPXaTMT3jORAfA3zBjdxCVVwNqjfScqiTjypODUpYd+YOQCyoBDZ+hl1+jxM5HYm42QZ8eVyuIi0j9X0RJO5aWXZlk1emoatZUHda9+X4z2uzwyT7AwdjEXyMon7TAqNnkcFf22q2Jw9CMTcSMJSUgjUFZw62A7SMDVr+c8Qe9rVOlhOPi4Q5UwlpJMZ3e/oUxD3Q8pkfOO9b4YLtQplQFgF8rk1xG9d+0SdSVGkg3PWCsG8e03QuYaM4J67DpRYLwuvWMQryQjK5Sp0lF5Wfq+LiZQIDeLun4ZRBjGiRs2ds1IoDUHbZAjG9ADYJNlQuypdkPntaE5UL5nZvaLT0vq9ubZyx91gSfqD6C/LL/66xYp1c8JddXaiT6V86iQFt++kzxFqyiYa9h1YQtS5FnbRpyZYuElkJfwrmr2XsLVUkdfY84bv3j92JWVkRvoE5VIFU1kSdfXZytHGgNnex2qr8rJSl3RDTy036apQtOwSlqy8SXzz/Tag2XULso15CT+bfLRFbK9WlCGmevYZtv8NL+ScAF3wzy5/cbfM0skzvx6Pzofj7doRlkhJjmsvmE31yfq+UrW+2S4tRBuW1cFiHArgUzY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(6666004)(86362001)(53546011)(83380400001)(186003)(6916009)(5660300002)(55016002)(9686003)(316002)(54906003)(2906002)(7696005)(4326008)(52116002)(478600001)(16526019)(38100700002)(8936002)(6506007)(7416002)(66556008)(66946007)(8676002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rkKqe/ozHqMU4poiXWzE62z7iXzCwIbTjipe0b0jkeh1YlAnzcVG0+HfCcdb?=
 =?us-ascii?Q?iL1x6fKaovKIsHsaA+zZn5Vr1bK6IiMmcXZ+w0X8wSCIF6VXXG2rQmTd2n8C?=
 =?us-ascii?Q?AhtNIaLkuyshANV6o54n5NjZ/Kn08Dqz7OZ4Rpe0SbHJ0UY0TDaVSsJBePUF?=
 =?us-ascii?Q?JeHAK+S4hn+8Azb9HFl5jOur/EnQjuffUM/qqV4lYsxko0KdJ8V9OqDDevBg?=
 =?us-ascii?Q?sx3gtkkwdfKPcBHMogIQs986tQGJ13YYfKfuahrvVNCiPCJV3ycqoLfVKBWX?=
 =?us-ascii?Q?uSrM/bH8hZyHELm6oxlMTrZ25Hhd6Hz+zPg2Qo4SCFl7r5aM4YjaGZ8ZfwPl?=
 =?us-ascii?Q?ArXGFdJgoY0jC01Uxv/t4Kh0EoyGs7QcLBti98kpZM2SieidbV9vHXD5cUf7?=
 =?us-ascii?Q?U0+24ZvxdohDlbUL3qLD5ncTnZsSggx/wFm4bbuBqhLThqgz9/yvB04DvVIE?=
 =?us-ascii?Q?f+d1VWePrAHgjpqTN7hXwqGhOfZQ6w1Ps2IdGgR1JTbBn632hTiuiju9BicP?=
 =?us-ascii?Q?DWGacbumtb8zlncXnBvvAFZzmu3ecu4G0FkR4G+Xz+zqXWLW8QNWKGi+Wy6m?=
 =?us-ascii?Q?8Ls6R0JZ5EwrCcW7XU0RcOnjN6cueJQF//BW1ggHgs8tBzo4OdprAEYcERnu?=
 =?us-ascii?Q?SHiGgq5gOkfZKQ2ezexS/TAzaYuBRJJI/4deZ1tXbZVmfmYrTsu/H18VsoG1?=
 =?us-ascii?Q?WwLylWVn1TjbEmAfc4qCe0TLNAJqdOIKlM09iVc7/jsCRNmoQfQL83sLgW7U?=
 =?us-ascii?Q?R9eQLwMh2hWOFGCXhhRDACuj+bOfepd+e+s0FY+OAi0V5IYvflxkQjglwS4M?=
 =?us-ascii?Q?zn+J/iv8g5itGZRG9Q4eoEvupLyjVQ5ZsbpnWSG6NejePkG/xkogC577rl7V?=
 =?us-ascii?Q?Baunq2yk99Xrjvg9mJA6VAsKNqKf+LpxzmtGatagbvUpfjYTOdv4Vx9yqRuS?=
 =?us-ascii?Q?6IYgCcxu+80Ddo74VqOGY7lLC0aVJMB4elFNFIqo3mhBSR1V/y+xCL/RbYnQ?=
 =?us-ascii?Q?Cpn5+d/9sqJvw2MJfULpVzUqsLlDUytRGrL9uueA6FSpWel3EYOgJhUpslmc?=
 =?us-ascii?Q?IBDgQFkixGvnK9vr70CrJHL1C93eIZE6llv8o3QlF9imC5RcF+Z4KWoe0p5O?=
 =?us-ascii?Q?0D4Kz95q6dZJ1c1H+iW8j45ymw8GVHMHAwt8YMUX3+1eO/tTs6DfGymN4za8?=
 =?us-ascii?Q?ngyszDz+vv662VBzIOePoPZXt4c4gIKx0S90rfuG38Oqzs41k/LWrbhp4oJk?=
 =?us-ascii?Q?AVd9JGW3YUMaFI8NrRSc/yMALGJ66QXY7yo+Dp3KIL3T5+M78/6fvQCjakAU?=
 =?us-ascii?Q?p++NiV4krtXeUwQ9H4Ph+JvTNVMON1kBqxL2S4ygBLyajA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e6b18b-155a-4141-4a8e-08d910c55b7c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 19:30:08.0961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsVODHBZXfhFjWY1szfUUMOlrKzoOfmX+HQbA8lYXNDMdKpPBqzSYyISe/+kIigG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2440
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: k3phv586BLoUATQaEqEqt0kjhtU-VxjT
X-Proofpoint-GUID: k3phv586BLoUATQaEqEqt0kjhtU-VxjT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_10:2021-05-06,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 adultscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105060133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 06, 2021 at 06:00:16PM +0200, Vlastimil Babka wrote:
> 
> On 5/5/21 10:06 PM, Waiman Long wrote:
> > There are currently two problems in the way the objcg pointer array
> > (memcg_data) in the page structure is being allocated and freed.
> > 
> > On its allocation, it is possible that the allocated objcg pointer
> > array comes from the same slab that requires memory accounting. If this
> > happens, the slab will never become empty again as there is at least
> > one object left (the obj_cgroup array) in the slab.
> > 
> > When it is freed, the objcg pointer array object may be the last one
> > in its slab and hence causes kfree() to be called again. With the
> > right workload, the slab cache may be set up in a way that allows the
> > recursive kfree() calling loop to nest deep enough to cause a kernel
> > stack overflow and panic the system.
> > 
> > One way to solve this problem is to split the kmalloc-<n> caches
> > (KMALLOC_NORMAL) into two separate sets - a new set of kmalloc-<n>
> > (KMALLOC_NORMAL) caches for unaccounted objects only and a new set of
> > kmalloc-cg-<n> (KMALLOC_CGROUP) caches for accounted objects only. All
> > the other caches can still allow a mix of accounted and unaccounted
> > objects.
> > 
> > With this change, all the objcg pointer array objects will come from
> > KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
> > both the recursive kfree() problem and non-freeable slab problem are
> > gone.
> > 
> > Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer have
> > mixed accounted and unaccounted objects, this will slightly reduce the
> > number of objcg pointer arrays that need to be allocated and save a bit
> > of memory. On the other hand, creating a new set of kmalloc caches does
> > have the effect of reducing cache utilization. So it is properly a wash.
> > 
> > The new KMALLOC_CGROUP is added between KMALLOC_NORMAL and
> > KMALLOC_RECLAIM so that the first for loop in create_kmalloc_caches()
> > will include the newly added caches without change.
> > 
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> I still believe the cgroup.memory=nokmem parameter should be respected,
> otherwise the caches are not only created, but also used.

+1

> I offer this followup
> for squashing into your patch if you and Andrew agree:
> 
> ----8<----
> From c87378d437d9a59b8757033485431b4721c74173 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Thu, 6 May 2021 17:53:21 +0200
> Subject: [PATCH] mm: memcg/slab: don't create kmalloc-cg caches with
>  cgroup.memory=nokmem
> 
> The caches should not be created when kmemcg is disabled on boot, otherwise
> they are also filled by kmalloc(__GFP_ACCOUNT) allocations. When booted with
> cgroup.memory=nokmem, link the kmalloc_caches[KMALLOC_CGROUP] entries to
> KMALLOC_NORMAL entries instead.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
