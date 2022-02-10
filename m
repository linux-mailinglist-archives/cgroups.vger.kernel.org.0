Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DE04B16D7
	for <lists+cgroups@lfdr.de>; Thu, 10 Feb 2022 21:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344180AbiBJUPt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Feb 2022 15:15:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343992AbiBJUPs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Feb 2022 15:15:48 -0500
X-Greylist: delayed 741 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 12:15:48 PST
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D030273F;
        Thu, 10 Feb 2022 12:15:48 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21AK0XNC019667;
        Thu, 10 Feb 2022 12:15:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=znVSLUxVJgvB7Xxsv0c1Vo8l4xO9MfnfaPHIio67DAg=;
 b=ds6TeeeoezIWUgbkNbsITAg/mPilH/wda+VvxpTG0pwFLcADOHHagzljQ+JVWiFZITp0
 fY5WaS16KkGAZoxk6HgUlywgrdlKsWO+cDXp74uTZBv97V6SpG/47DQvvVrRTbLZ6UNz
 oBYhqgBbWQKxhj18FdbtdYitH7Lz0/YwD0Q= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e58e1gp7k-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Feb 2022 12:15:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 12:15:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT3tOLuEA2l2m4ULhlBvvOmUkGubE66vZQ0aX2loZCbQTMZvOuB4nWJYdLk/O+E++vjF1FNP9L6u03JWJAwtgiY1K0nS6t8Ze0JMv/5FF3Fzfpp6vgtW9R5qBphWGfbyoJ8xUO7JxXLM8YcBJGFwyWlG/VdD7wmVtRz7/6dLuVCH6jtJLiZSXo1ByMnxamnbZ73mb5urVB1ARVROwk4JFMZ6a1oJDUacR+JLlqEX9opp45+W5g1hvHrpnRKxfB14gpSoy6Yv81M8bQqQcVRvAMHYWdrO28Q0kIM74Ij7tmgohiG5fRviZ8vAFo0BbsR1rJRwH+FNTSffvx8c2pLTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znVSLUxVJgvB7Xxsv0c1Vo8l4xO9MfnfaPHIio67DAg=;
 b=Lmc0pYrHT5VqIoIQbyIO31Ehtnf7H20FY7CI2lT50pHcMSvQUMFAjJQSQ97O7cShb5ArtIwWEndZLBg9Ghd3QEbTARR/++Vae7Mz1Ozozxspv6XuT7UXiPWsKx+m+EEbOC7/qcKDdhc27ugn7Cf47jkGiteQTs8JzzUGs1q1KiN/sSIbvhNN/JDNsvHT33qQ+RNSWKQy+ltuSgqfQJCfLfMTX9BWyuB3WAFubIkoaFhOXVwe+n5ONZbQ1r65lQQBQR6p2F8bNh4jMBQPT0cNbvu0QDKlGQipCSgI6gqcKx/Oe6svoVRpqfO1BWDpj8nQITgY8FCIJHpVfTPxtowdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by DM6PR15MB3259.namprd15.prod.outlook.com (2603:10b6:5:170::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Thu, 10 Feb
 2022 20:15:39 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 20:15:39 +0000
Date:   Thu, 10 Feb 2022 12:15:34 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] memcg: synchronously enforce memory.high
Message-ID: <YgVyZrDPxVgP6OLG@carbon.dhcp.thefacebook.com>
References: <20220210081437.1884008-1-shakeelb@google.com>
 <20220210081437.1884008-5-shakeelb@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220210081437.1884008-5-shakeelb@google.com>
X-ClientProxiedBy: MW4PR04CA0139.namprd04.prod.outlook.com
 (2603:10b6:303:84::24) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eb1a59e-2d6c-4943-f7fd-08d9ecd21af1
X-MS-TrafficTypeDiagnostic: DM6PR15MB3259:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB3259ECE237C57D332321BA2FBE2F9@DM6PR15MB3259.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PHUw515AP9hrwynqlp1+/qU/39Xl/q+HFWctP0dLsHgtlTcM6HHmstw88Xu1NaeTTBHj3yZJAhXmVSW5Fss0pHVE849tMEwrxk96k/dye280aL70tWMWx6xO+G3i1MNujBwTno+/qLyScJKfw0DhL5NAAeiPBt66aTw+JcEtM6hwaE084yNMV9ee5Uez3ZmN81WSV8ECoCkTzvnHaSMro8S6cxAYt6DW9gD65j4pOS5UxJRGqYfjPvGfzPnzbGBif5l70cOxuJBgibFok6NU+t12eUHk0YlZjoejcKf/i+2PSRRb67GfbhKFdpKMsiMiYgEPz9zEQL2gO33t8U/djMCjocNBKFzWFEwmXU9r15xoLIJilXgjsYX3ewELHKe464ZY4X138iQq1KJA2xaiHuc2863g5ZULczHqvGccfEOoilY4X0hnzAkuzdkqaMtbIRvbOXhACS6tj91tYmZ4Afcj/LAFGTAdJAC+bWzbiRBUa6bkmIxMJ1Qo/GaFs1uElLcPk98EGo20UTI/szxks3VxSnPDdnD6Fgta1xyP26QzWNkaX1O2A4hsvkBcAlU7HvQ8Gb/o0jyIXUJgk9jXxicweZiORuRnYhHtK06hyiCF+q5TmfLgIuFj9ArNCcqPKFwsfHKwWQlLyLPoT3dIfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(52116002)(9686003)(6512007)(2906002)(54906003)(86362001)(6666004)(66946007)(316002)(6506007)(186003)(6916009)(5660300002)(508600001)(66556008)(66476007)(8936002)(4326008)(6486002)(83380400001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D2txfGh1HMsRWhs0vOje1yy85IvLuT9w32Yi4TAmq2qyjMTX2YSjc3uDTXgI?=
 =?us-ascii?Q?SmV7yWdu1lElZL3SQIferwHUyovHTXcFF77Q9fBJTwj6oSjvfpuqdz33zXey?=
 =?us-ascii?Q?0RNE//YCdY3GPWRPsjkMs0YIvb+Ejj26Z66h+41XJZSkVoDSxKA+wXSPK5+l?=
 =?us-ascii?Q?3iKoyPwEvVz3lF7OXU3IsZ/DwHBpcv3wPkdAZDOhrp96kxc2arDolOU73LuX?=
 =?us-ascii?Q?Qc2b1fX2BkX4L5NW0oytqPSs5fuquazC/7DLIGG4K1Njg/t6URZ7Mt7h+YVw?=
 =?us-ascii?Q?BuVgeRu6z3SQB81zq6R+LJ54nwrsABKa//VPFKVE+ioE1Mlpooqtv23OHiPp?=
 =?us-ascii?Q?K7RhBjMVfHKZDUI2yZCS77lR+TUh+5sF+WhUx8L+LRTl4rv6UbPvoh2mTD3C?=
 =?us-ascii?Q?rDtuJfa0k3gtGJNiTUY5plbMlMvik370/OSN6e1ZNGl4gplLWyfbt0uvglbe?=
 =?us-ascii?Q?ZgMEKuaAknvKxOGFYt8Ov1qVSkjxXlhUVevUN8coYKh6Z0aItQWuGCrqbwIx?=
 =?us-ascii?Q?l+1fXwN8ZU6Ilgqx2YMhj/bLuop98l4KL/pjRJMH1oBdDqeoNU1ShzxhDFXT?=
 =?us-ascii?Q?NNSVXE2bkPZiK1q+ZiH7HHbi9u1wYqgkmMhCzRaxmWWPa3WajMGHlFVQk4Lv?=
 =?us-ascii?Q?EhXi7977X5ddlKl+G+gVWbIe1XCNtYiCQicXVGewOjXoN+3JJRGdoxwkMBSd?=
 =?us-ascii?Q?//82rjgwK6Q1x/w1yPhsuQ1N4CYprcw6+brDcClgLx/3hDQa56OP7e08XhHv?=
 =?us-ascii?Q?ukIGlogK5Mj3TGtejDAjXlGKpaZUX8xOqeDtA7Y+SSPGVEzz9sNbxylEDgz4?=
 =?us-ascii?Q?smCCI/pew5+Y5Cv+vxR5UF31uNfVe0J1NdI4K6usnwQZPyui9Q2IB1RWw1Rf?=
 =?us-ascii?Q?sC9BMO16AgIiHnOM+8ucBXHW9gK4wIznGsZ6Kk4WD2wr7i8uClpNKjVoDwVL?=
 =?us-ascii?Q?iJSThE1halyP17TmNNunA6vQXLln2JNWl+7ceLNp55nxCIp/54nb2iYTOVd+?=
 =?us-ascii?Q?d757ao3CzMP7IOM0xwgqLIHg94wuJYnY/hdPh5tj5iWoynlXLemDG+7gh8xa?=
 =?us-ascii?Q?wMpyV3qk7xaOx6opRwv99K1S5dV4Ca56c95St76GIAM+p38pp9ob2QvkaG7H?=
 =?us-ascii?Q?xZrmKQv/Ec90FiR+85uH2GGcfFxsKH8FucQI9mSANShoaciiD+aDeRYTWA9a?=
 =?us-ascii?Q?6g7auTMYZc9g8aZsOdJhVRdMirkNoHlaD9QNRmMIPCjHfbUWbsdyGtPJxUhZ?=
 =?us-ascii?Q?O8tmB6u8YKD+fD5zf29ZY6I58pTnzqCDawORt81nwQVeiB89Bu7Kw5A6qHco?=
 =?us-ascii?Q?u6ZkVJvTzvDAvnleZ3zb0i2UISLjNv49IfWqj5YLt5RmG+RIA+Ygk+FdOQ2t?=
 =?us-ascii?Q?/qLc9bHbuWd47JJXn291APFyd93CZeP9RMrf4Ujr6HDB8g7CFIgUdhBpBVBi?=
 =?us-ascii?Q?cBdTKp9uwTP4sLU+/PbubXUceP6kjRyNqN62OxmVA0g3L+AN4QocQcav0NLm?=
 =?us-ascii?Q?f6op5DuneWag2uT9c0ZzD/0V9UTAPkCeYICuLWzkn9vf/7Mu2GBhW/EtqZM5?=
 =?us-ascii?Q?Z6ng6VscvhicpwDqZU+vYoNSHeK4vQS/XzzF25T3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb1a59e-2d6c-4943-f7fd-08d9ecd21af1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 20:15:39.0082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bZm5l7hFlWwMQdR6AVQIq9/xc5S9y/1WXQP/JA9Aq/r3UsP5HZTZE2HzYAnovPM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3259
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: wSUBwFKUorxOSGXAsMF7uToRDuyVO75e
X-Proofpoint-ORIG-GUID: wSUBwFKUorxOSGXAsMF7uToRDuyVO75e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_09,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 mlxlogscore=409 impostorscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202100106
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 10, 2022 at 12:14:37AM -0800, Shakeel Butt wrote:
> The high limit is used to throttle the workload without invoking the
> oom-killer. Recently we tried to use the high limit to right size our
> internal workloads. More specifically dynamically adjusting the limits
> of the workload without letting the workload get oom-killed. However due
> to the limitation of the implementation of high limit enforcement, we
> observed the mechanism fails for some real workloads.
> 
> The high limit is enforced on return-to-userspace i.e. the kernel let
> the usage goes over the limit and when the execution returns to
> userspace, the high reclaim is triggered and the process can get
> throttled as well. However this mechanism fails for workloads which do
> large allocations in a single kernel entry e.g. applications that
> mlock() a large chunk of memory in a single syscall. Such applications
> bypass the high limit and can trigger the oom-killer.
> 
> To make high limit enforcement more robust, this patch make the limit
> enforcement synchronous. However there are couple of open questions to
> enforce high limit synchronously. What should be the behavior of
> __GFP_NORETRY allocaion on hitting high limit? Similar question arise
> for allocations which do not allow blocking. This patch took the
> approach to keep the previous behavior i.e. let such allocations not
> throttle synchronously but rely on the return-to-userspace mechanism to
> throttle processes triggering such allocations.
> 
> This patch does not remove the return-to-userspace high limit
> enforcement due to the reason mentioned in the previous para. Also the
> allocations where the memory usage is below high limit but the swap
> usage is above swap's high limit, such allocators are throttled in the
> return-to-userspace.

Has this approach been extensively tested in the production?

Injecting sleeps at return-to-userspace moment is safe in terms of priority
inversions: a slowed down task will unlikely affect the rest of the system.

It way less predictable for a random allocation in the kernel mode, what if
the task is already holding a system-wide resource?

Someone might argue that it's not better than a system-wide memory shortage
and the same allocation might go into a direct reclaim anyway, but with
the way how memory.high is used it will happen way more often.

Thanks!
