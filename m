Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3479B461D4B
	for <lists+cgroups@lfdr.de>; Mon, 29 Nov 2021 19:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243137AbhK2SH1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Nov 2021 13:07:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35104 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236756AbhK2SF1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Nov 2021 13:05:27 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATD7p6p001249;
        Mon, 29 Nov 2021 10:01:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=E6EXu5NsV9SHRzKySPr0Q0eWkJIFIkz0BNpEbQ0vjvw=;
 b=oLAfzOgimeuOJx951nMpPaa2eBhew1nYU0eeCLpP+rIPijeVoRCduUfKBAyEqlbHTcSw
 vJEyvjkMsgddMKyMItztoH1JWpsRWKmauJVFq3HhNKCBVJUgARnNQug0UHM7gELl1knR
 HmwvOpvX1dj1s+jmW5MnaYBq9kkOjar84ns= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cmyfmj8mh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Nov 2021 10:01:51 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 10:01:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSLBCKXFOKp6JScZH2sEVDlSgW7gRpFaO9Ca7V30RX28zsRANBSP/EnT8MWWNULTy3tL0yuORHhNafnw0rZ5CaZgVeA6lCb4j565aQN/yx5o6+Z/p02zETDaJQ3kGXk1YmwKqq/zpuSdAoH2ljyV58sAu5jB5N45eedFCApWRe+cf9ARzWz2qtSI9iG6MUEUHuvZNIx0/PxNjBsgSmqLtLaxP98VtnZoquVR/rlkoj04vFNqLsoVNAGAUhWASYDXMWOtRVRZyTO2xtf1pK7L60wLBYqq5wJupZiV4HfeJ3JggQokTkbQNTewzWVyfpzA1MLddEFOPQVeh8QTUjNuzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6EXu5NsV9SHRzKySPr0Q0eWkJIFIkz0BNpEbQ0vjvw=;
 b=TREHIighSlbMIHf+W/EkJpA49i8TgMHHTU2Fxsfs7f8QFEhBYGHBBOuG8nwGHzVUX9gCOyAmaOx6NFYPuNxfHGrJE2PYtwFQCUf6OpmXDZ63a/k1t20Nz522l63pjuocHULRsYBHgATtK1VkX2O0taGq1YIqmN6gPPhOpUyrf/ABjupjiupYDJYBD5o+4Y1s/rBpeeDQS7q8vfgnwidlsrwHG5R6m7cpNGXdBBY6NV/2wgwU4+FznxRy7QgmMwuMspbFpU1EjgAGWYVUJoxLFfsrqNj0qGmGdZJCOwzTq5u0U2c5Z5G/26jqbQ/iwT0hHwOO29g9ry4xhOS6tTA7Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2342.namprd15.prod.outlook.com (2603:10b6:a02:88::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 18:01:49 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::849b:56cf:6ec:633b]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::849b:56cf:6ec:633b%2]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 18:01:49 +0000
Date:   Mon, 29 Nov 2021 10:01:45 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Waiman Long <longman@redhat.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, Shakeel Butt <shakeelb@google.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mm/memcg: Relocate mod_objcg_mlstate(), get_obj_stock()
 and put_obj_stock()
Message-ID: <YaUViaGjXgoLGjUq@carbon.dhcp.thefacebook.com>
References: <20211129161140.306488-1-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211129161140.306488-1-longman@redhat.com>
X-ClientProxiedBy: MW4PR03CA0242.namprd03.prod.outlook.com
 (2603:10b6:303:b4::7) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:56c1) by MW4PR03CA0242.namprd03.prod.outlook.com (2603:10b6:303:b4::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Mon, 29 Nov 2021 18:01:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 370a436c-f5b7-4c19-d813-08d9b36250b5
X-MS-TrafficTypeDiagnostic: BYAPR15MB2342:
X-Microsoft-Antispam-PRVS: <BYAPR15MB23428031D1A69161C27EE853BE669@BYAPR15MB2342.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:98;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMYJr7XbVdRRRazQzyJyLFXNN2Zt6TQwjdgsHjrHAoNzD9WYp0aE87g9FZOMiXRg4Temtk174RUYlsxLHYYtgmszCK4+fCMRyl0hoWNfcGu2Sz4n6AV6IIjyaneEuTeVoSR6KuwN/CAox4yOny/e/g3dmKExj5DjtnH0a3h1tC6Aw839L3Szyqm4XVUdE4JNEHbD12E/hHY2rP8mpayRTvLsGabiHWkKvHI8jIcxChjUibIioMuzmIXFZPCWgahQYvirMUtsHvEZme8AW0ldexAhlaeyo3CyJLOb/FHkxgyR+fwFSiZDXrh+SCzPdht25KAKzX+a09dsxtIhLHIWzMK3x2s/gsFo7SgopaL+YPUy13zpEz5OLApV3PdzqH4i4/DsRTq3Kb95+Se21KQ6KG7b9Hmj5w2VyO3ZMMW+sfjqKuRgBzc+hfF+R6QieVJOiRTvJfCEX1ZDAl80ZdpE9iYz0eT6y9jL7EbgtAwXv1JyHurYdLOOZnSmioMakP3c4VGDROWoQzvBbQCb12M+awnorRm5ldIKnJYo3kdQzjjq4ue+5Of1sJZhFF5hb3142zi7p9o3zK2TbUKD5wswKtsQVDDqeKx9O6J8xz7WhybqUasY7enzt9p6WLKwO+MwtLAe+w4maOw8ojE3VoAuFiEsfECQY6nR6AiESc1g89HMAXW68xxVT38C6KYxG7g8JREHLC9RLpQmIEqbM4DR2LtWrEyURGiJsqA0Lmpg1xAOnb2gkOQsvfqjnEiB4Kq+DQxEWIs5pjY6AL0Gz2A8mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6506007)(8936002)(54906003)(66556008)(66476007)(508600001)(55016003)(38100700002)(7696005)(966005)(6916009)(83380400001)(66946007)(52116002)(316002)(186003)(86362001)(4326008)(8676002)(9686003)(5660300002)(7416002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xyIlWtXX0mxQe1/3dBJCFOKnZzQ9H0UlBtvSkr3CB/0lJeg059ugcIfBi/sl?=
 =?us-ascii?Q?WBDBghpwjbEb1LEtxOWbqTrR7MzM6CtufR1wy5TAlI3Kujo2uXjHCdhMXG92?=
 =?us-ascii?Q?Pn8sPac9g0FTkEKH5SMvQR5UKc5M9TxxX/fQmoIdX9XJFyiyTGCAT+2osxfq?=
 =?us-ascii?Q?93d2673lCV+ndNnEVDjEUEnyH5yYE/CiwZCBYTSJjzTH1VAvSv/ICBVDpLFh?=
 =?us-ascii?Q?JO0u8aXTAWVXss/XcrDPz1IDe5ddYI6FupCOgHW+q6U4GYscFtUO+KCDx2Ol?=
 =?us-ascii?Q?zp9YHiKKCqPvEuR5cOO4ZN58uVDZSG554Wsyrc6bRlAiKmsRFUhviN6dndGr?=
 =?us-ascii?Q?bcDppWTVRy8TnfqDjd+HYm1OBED0NwMzO+itbWULfFUOM3dSYe3h8W+5Kxn1?=
 =?us-ascii?Q?nij4/szSckOMp5t6ohRC8QkUJga4kUMud02q+B9M3L91qbSlVeL5FDwNimM+?=
 =?us-ascii?Q?9lv7eyW3Iz3YS/qH6de2TNxhNOiT6jtJ1Z0HrvtI4QgcNbenLEehYZZ6IS7C?=
 =?us-ascii?Q?wmmBV33i8e8kkkbJYXhlWRq7S9fuViipA4hhthBldY7yJzhpNFZzQyu9vX0l?=
 =?us-ascii?Q?DWPrGBhQizBAlBnNEAUahXMBAdhBhYHBzcPPwPndlPsfgj9Ic9NVEhLzWDvW?=
 =?us-ascii?Q?K6b2b+vxqb2w+/TUXnCocc4wRrmyeU5B5LJXrt2pBxN9lYTpVEAgBUcOFma4?=
 =?us-ascii?Q?8aAsaY3XXPtihyDOUQm+K/QkJsiqjgr0s5pbuEMcgavNRD2eShp8kmPZK2or?=
 =?us-ascii?Q?SbFtJXmewGyJwzE8zSkbG0JmMOCv0C46t2PFwBmXOb+GP6qWHl6rE5LkSO1S?=
 =?us-ascii?Q?ULrA5zIao+UGeC+hyuGZP1YOqgPrXwXSGF2lqSGu5hX82LDBrMHlRb51GAbQ?=
 =?us-ascii?Q?dYhDMG71+e7qughFk/HG7VHKq+7GBFc2Gce9mgAvm+ytdiLJPfiwcXFSm8dm?=
 =?us-ascii?Q?RtkhGLwJEy7k2/baIV9aVMBGwR9G0btH7t2lnZ8dnVw+D3tn+Olmmo5TPLC7?=
 =?us-ascii?Q?QPtqeqPvaHuP4HwlcaaUSmPmmkVM3QdRqqczVZ8akn0gXds1KSxZ6JLxkxg+?=
 =?us-ascii?Q?Fiu1yf+59Mkg0tVRTmFLdUL/k1aGCZUnj0fVmir9SiH7xfQuYEpKs2WrvoCZ?=
 =?us-ascii?Q?r4kk7feP/wLwx2PTAaVHf+bhhCD+Q9N2KA1dXDgW1p2vMphK11ao7H9r5vh3?=
 =?us-ascii?Q?yiMBuLdPMQlb3Bg9wXrF/+RhfBzfEE1bcqg4rXaEhwQNMkfRGe8Td97w0cqV?=
 =?us-ascii?Q?un9swQlVGWClo+2jMo0I9e0HuIM1XEgtxd0mQnqNUMY9BR7nkOVfJChbkiG5?=
 =?us-ascii?Q?34Jrb78RbQHQckgv0pcrVKrf2eIkMuC3f/n15+B6KS6O5ntSH9s7Qk2YhRB3?=
 =?us-ascii?Q?huwisGNPOIjFtSO4xrWifQFjUnVR1vqg82ElCy+2+1XsZEu33YxSis8jNN8h?=
 =?us-ascii?Q?B1sbKWV5jAWqfjLNKRhP9nWC/1Ql45s4iTiCDIWWTjJe2EMoBahbED/V1odW?=
 =?us-ascii?Q?4f8BkP7mIJ3l4HUNtbLSKl+sVQpyIZfvIvlOc0qbVzxO+vCazeczqYYINi4y?=
 =?us-ascii?Q?E7i1AMhuOFaptRPlhuld1IrHlmeZEJMxNpy/8ed1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 370a436c-f5b7-4c19-d813-08d9b36250b5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 18:01:49.4246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0CBMXle73c6TLXpsCrbhLFqLicCIxaxIIbnNLpuX/fGc6mLsatKyaW5OtVittbT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2342
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: JIcgTnAWm5k3oDvwMyVb8rPtZAasyM1m
X-Proofpoint-ORIG-GUID: JIcgTnAWm5k3oDvwMyVb8rPtZAasyM1m
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_10,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 mlxlogscore=503 lowpriorityscore=0 clxscore=1011
 phishscore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111290084
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 29, 2021 at 11:11:40AM -0500, Waiman Long wrote:
> All the calls to mod_objcg_mlstate(), get_obj_stock() and put_obj_stock()
> are done by functions defined within the same "#ifdef CONFIG_MEMCG_KMEM"
> compilation block. When CONFIG_MEMCG_KMEM isn't defined, the following
> compilation warnings will be issued [1] and [2].
> 
>   mm/memcontrol.c:785:20: warning: unused function 'mod_objcg_mlstate'
>   mm/memcontrol.c:2113:33: warning: unused function 'get_obj_stock'
> 
> Fix these warning by moving those functions to under the same
> CONFIG_MEMCG_KMEM compilation block. There is no functional change.
> 
> [1] https://lore.kernel.org/lkml/202111272014.WOYNLUV6-lkp@intel.com/
> [2] https://lore.kernel.org/lkml/202111280551.LXsWYt1T-lkp@intel.com/
> 
> Fixes: 559271146efc ("mm/memcg: optimize user context object stock access")
> Fixes: 68ac5b3c8db2 ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
