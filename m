Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC00F3DE4B0
	for <lists+cgroups@lfdr.de>; Tue,  3 Aug 2021 05:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhHCDa1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Aug 2021 23:30:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55812 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233197AbhHCDa0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Aug 2021 23:30:26 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1733PTZR015381;
        Mon, 2 Aug 2021 20:29:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=MzggrC06bOF07UdsUXgsuqCYhfxwS9khUj7MaVcp/N0=;
 b=UYo5wwHhTd1XrAuWEmcNj/xtuCS8M+FK2vrbdSk27aM2YWWAv7Yzwa8JbQLbXW0BocOM
 uK4Xwu8DTogr0OzsAbbTZJgfBe6ZkXi6QQNc5tTdcz6FunP+oo2gcPCB1/gpGK4De+t2
 C7JJoWMkLsqMUR5lV53ySt/sm5hDA8efbd4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a6nmmarxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 02 Aug 2021 20:29:01 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 20:28:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4xtRufJaMFv/GT/IGl+6fnGTsK+ldrfBTIl3JGetFjcFU7/5Lif4dOuYpTvxqvoSr4a6x1TjpqIpc1GKzKjsY4CcmN5sXYiT+DctZIFcUeux4xjLb+HAu206lS3wutgb0N1Blz5lawDnVSAIeePfGrySFrY68rR2mW/Govuz+5/dD4f9XVDw/+PLFf1HYou+O/Ehzy1ha32hArVAgovcaV4TyEwQ/pvcXQkDlBiXUB6g0HXVAPVMYSDj56CAuTHyDlTsMEaGM2jpOitoJKvDZDo6U4BGLHQI6qxOEjSZbiPGY26Cvn2C2ehrzjlOIA8t1B+zAjEDW5NbQLHtdriVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzggrC06bOF07UdsUXgsuqCYhfxwS9khUj7MaVcp/N0=;
 b=YLD8IV4GovBugeMfjC58IpBT3sZ311rHYXzWwxdLAGQIbb3xGPr6OIJmSF0lsycBqP5MYIUjklGj2rGlGn14vVazRRdqE7JN5TEyDQRRqB5Au7TILR1G3Ruvve+REooi5YMM9pnu9SC396MaiuOV6VaNAGxeTj2wy9iJybLaIhKhLJrt3Oh2nK+8KG5SsuGI/TIcJ6VwE8j2FwzxI91OrZO7a4FCfizhUwZNLAJO6MWmvFWNJ05PeXPFvtSYeS+KJK7IKfWExwjxz+oCd6sJTQFHSjV7VHBmSrmiA1kum7RMlR549+XhxH3ImnZXD7YA0/uXsKLZjV2QWO/n7TwTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2661.namprd15.prod.outlook.com (2603:10b6:a03:15b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.23; Tue, 3 Aug
 2021 03:28:53 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 03:28:53 +0000
Date:   Mon, 2 Aug 2021 20:28:48 -0700
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
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mm/memcg: Fix incorrect flushing of lruvec data in
 obj_stock
Message-ID: <YQi38JlQQD4nsgeM@carbon.dhcp.thefacebook.com>
References: <20210802143834.30578-1-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210802143834.30578-1-longman@redhat.com>
X-ClientProxiedBy: MW4PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:303:8f::30) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:6c4e) by MW4PR03CA0025.namprd03.prod.outlook.com (2603:10b6:303:8f::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 03:28:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec48ea28-9ad7-403a-1a55-08d9562ed155
X-MS-TrafficTypeDiagnostic: BYAPR15MB2661:
X-Microsoft-Antispam-PRVS: <BYAPR15MB26618331CF46ACFE384CFF16BEF09@BYAPR15MB2661.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wXSSPiCYlfO1qRBSYtjWBr4TMLtS+V61H5ibjViCC6bnAiIg7VQY8BTNY+vrfNMfKn84D6dPD2zuSIQ0XX7jRC1nMMgYRjWN0H2+B4Rthzm3fjEL/nLcAh16JXQEw+bMSOZy9eNt/sO6MHZn78YdimNR1dufUDT8TmRJak6DruW/DikLQqhxaQUmVq4mPmMdIHhbV86NIzo0QXL8NXVlII9Cbs4kN0iRhRDgwOtQ3TJyYbBQ9jRPZP0oTYyqOuxolxz3q/CGaM06og37Lm3oQXWKYjmz4sq8hirM+odiEX0YJHNmiXNWH2m3J4hQVXT8WxnW6Y5VWGJ04n96BMiY3uGc2k2DqOuKEZ+LZWwB7doBlQnpSuUJOrA9ka6OI5StJvRvDIO+ZYL0tuAzskj+Ef1zr/I0NnlmOSGRSzNKgZH+skV982KNF7pZ7nYgkmEs6beAuz/D5In9z55d9laMU3IUpLQls5VCrhhxNG+eaKU3XiXy6oWUoXXv3zC37LaKzHKpR+54QcembOM6P9aE8rhSwiYcM65O4HKUCnX8L/ksw7NekeGaNj4FI6F52i6pJOady4H2kzY4md0yui/mPIRWaYTz+Gc0IU9AEjU08DQY8hs2Ec62UgpU074a35oUSaXyJRS7H5vAwiOMahLIYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(7416002)(4326008)(478600001)(66476007)(66946007)(7696005)(66556008)(38100700002)(4744005)(6506007)(54906003)(2906002)(86362001)(5660300002)(6916009)(316002)(6666004)(8936002)(8676002)(9686003)(52116002)(186003)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b5PIRCZm0X+YCgQsSFvhI6iR2dmXALEnn0J0qbnfA5+3bEHb1V6ieit5nkge?=
 =?us-ascii?Q?svFgv4h9jlLC9OIOGT7oMuwfRnb9GlztoU3JfUP/8Iqyf3iapZMtrxMAOrFK?=
 =?us-ascii?Q?CFWADOwg9uvrlPi7cSAeCwoEgxmrsB2WVTB2Itveief91IIuSido/28of5Wy?=
 =?us-ascii?Q?x+O9DcPb9zD7zp0cJ/jaH87a9LJBLboMX6/QQoMmq5dokwP3JqWl8QpYR5oq?=
 =?us-ascii?Q?B1UaMx7g15oW9dOF/Va11M+acf+IMwmlgrs8JUspR5xZTIbQCcgMHpRLKcZS?=
 =?us-ascii?Q?HD4PlW/lKt/pVs8XJ5HIBWlx+/6yjP3xAl7xjaMrGQN1IugJjMs0dD6Nj8IA?=
 =?us-ascii?Q?+6A00wm6fuBYJ/bCnJQfqUqi7gy3hlASapHmXXbIwfca4YdbLW/PIzrGjDjn?=
 =?us-ascii?Q?YMJAhAzZGXykS14Kpaq+V6FmXLMTFtk72RfP7gP9ZNujsMoq21qkUyk8EDvK?=
 =?us-ascii?Q?Gp2MFnjUk9xRfaLZaI1XUMIe3nZN/Zj3JpWW2xNu0Xkqs6LR7wtAz6M/K8/d?=
 =?us-ascii?Q?zIZrPfVa6d4+EUIedcg8KXbH7lvs3+fa5FKbpH9n0Du05GVk+1hDGfVLpEAQ?=
 =?us-ascii?Q?oQClyjGGeAZHjJhOC1KSIs6KMqEBVI/xAReG2vxsmcpA8eOorJ3h64/YTdV3?=
 =?us-ascii?Q?KBophUHJCk4EoXYTKdatomMCLfDwDm0mLWcWaB+8hEQNHJxp/CgxdC+NNLC9?=
 =?us-ascii?Q?6Aq6ahmHIGSPHECiyONWZgoxqPxKEfqwvLwZAluin0BG2tLZQ51hTXaKATkn?=
 =?us-ascii?Q?3d/jyR9b2FaKpOm2jJlDmg1HHrmUUYG3xIscnmFKaFdiyO+Qq3Nwh0/uBEQL?=
 =?us-ascii?Q?IkA6G5e/Gy5se/e665DbF/CZQuJ/kEatgPcnSUfN5hUBuxjsp6kGsw60w0D0?=
 =?us-ascii?Q?JXwNcbbvMQPqDYIRYbgzTFhUcGqIqg9MMhJsY1K2yP+XRDjpr/FLO9fJDDPP?=
 =?us-ascii?Q?Wu75I40wbx7TwUE3q2As8UaCZDYftJGRXD4KJh5xyL/+xK6AWwBZGODlT16L?=
 =?us-ascii?Q?bTFbqkrh6ib6gQCSYROR8LIFqiWIgV6Wzr2g0kstZilSAC+B/4xw64OvLHRJ?=
 =?us-ascii?Q?bwbV/Pvef1enRkPd21cOVXfSn3MNHlj1CR6qm2Smbqdza8kFgoq0nlbW4jpU?=
 =?us-ascii?Q?GdD/srpL6NeYybc4PYfEl6Xiif09473LQLFJP40x823WMV76GywrazIBbMJ1?=
 =?us-ascii?Q?qGVWKtInOUOM4xSrGbY2Fcr5KeqV7KGfMgq07p6njShQ4EqjEe2c8vt2WpsV?=
 =?us-ascii?Q?4upJemzYfftYTHsuKi9S5g931jiAEpHjXEEfFJA0ImvFDcAhOQGe7+6V/hXP?=
 =?us-ascii?Q?PuOv/qFLH61qHOkfym2EZ3CEXLCLn+O21X0mAq1v+6xKeA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec48ea28-9ad7-403a-1a55-08d9562ed155
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 03:28:53.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gmg61ffEAuQsIFTCLqESgRCEw0px2iPh91qxZe3llQ+ehDnTualrGKkXyYR4qlbZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2661
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: stwQjsgPGcESPAVaYU4khijbtogUSdyb
X-Proofpoint-ORIG-GUID: stwQjsgPGcESPAVaYU4khijbtogUSdyb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-02_10:2021-08-02,2021-08-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=744 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030018
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 02, 2021 at 10:38:34AM -0400, Waiman Long wrote:
> When mod_objcg_state() is called with a pgdat that is different from
> that in the obj_stock, the old lruvec data cached in obj_stock are
> flushed out. Unfortunately, they were flushed to the new pgdat and
> so the data go to the wrong node. This will screw up the slab data
> reported in /sys/devices/system/node/node*/meminfo.
> 
> Fix that by flushing the data to the cached pgdat instead.
> 
> Fixes: 68ac5b3c8db2 ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
