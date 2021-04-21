Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64033675F1
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 01:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbhDUX4l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Apr 2021 19:56:41 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43340 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234878AbhDUX4k (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Apr 2021 19:56:40 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LNrgIA030760;
        Wed, 21 Apr 2021 16:55:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=KXymcwLV1RUhO127TJbcozKUy+8pPOtW5b5KBrtdntQ=;
 b=BRXxPZJgu3bmq6GKfll8Imb4Qsk7O6PD8vp09GdJs9tfG+UA5DhCtPN5IGjd+DWUTD0G
 nRdKTbtPJL9MJXg3LZa0rjJ1bRiFA73kEAmNyD1J2IKdFlcvXZugy6T3vEb8d/lPL90s
 fdqxhhfSU8pf8hyEdZ0C+Bjaj2ZhnDIsFpI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3826yufpgg-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Apr 2021 16:55:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Apr 2021 16:55:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcmZpwL+mvBfDrk7agtQJJmIg+HF88QPQsRBi6cSzandF6+FufKRMx/mo/g01blKDdIyWcmVhEgyT+fw9Ee27J7xAlZEsvJ1HCgaWvfT6Ikwa/P6qAu63GxT3dTWzrzilT7MjUkFHLMYhAK095YMc2Z/LEx/+DnlGqnWe8TB+hClIEntVkq/Uv3ErFWde+1Xd4koau3Pvulu6sTllh9qY1rj0ddfBfjW/uYOmLZD17qRKXVgPjJOOUoD18ZaOyqt4SL2aHyVWyJ2zyhppjskxJ79LE/BvTOJBD3LY444ZMGdwSJgv+AHnkAgUfwww3xEKGbTAC4XGi5jCdRLUH33hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXymcwLV1RUhO127TJbcozKUy+8pPOtW5b5KBrtdntQ=;
 b=HMavJNxXHAyoaa4dPvxoqYlE7nPK+v64egw13I0k7hDReO1QNl8P4Oi9h8bwPwAb343HosR3y4sFsoWHpIyFg6GRnU0WAEAU36i/PRYMsOzjLj3Ccm1SOmI46ucCJXiOWKJw8vB4DTvOXvgbpgutjJmh8dRowKyaMwVSe6UstgMhz16tvrrXwEHXoYM2QYtkPN+AY6TBdd95YbuPz6G4/fpKCfWHM1mUGjn0vRNe5IP4ze+Z88f20gFsefcIQVIuKgNWNPMQ9H05KRU+6pX5zfyJ1XBdEk2gG1XmxfOh8ymWKN3KSjpID0GpAQHNbiMyWp3j7P+AgOuN1YX+jGarIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4469.namprd15.prod.outlook.com (2603:10b6:a03:372::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 21 Apr
 2021 23:55:40 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 23:55:40 +0000
Date:   Wed, 21 Apr 2021 16:55:34 -0700
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
Subject: Re: [PATCH-next v5 3/4] mm/memcg: Improve refill_obj_stock()
 performance
Message-ID: <YIC7dh0+nQDFmU+T@carbon.dhcp.thefacebook.com>
References: <20210420192907.30880-1-longman@redhat.com>
 <20210420192907.30880-4-longman@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210420192907.30880-4-longman@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:4579]
X-ClientProxiedBy: MW2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:907::15)
 To BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:4579) by MW2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:907::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Wed, 21 Apr 2021 23:55:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78d83adb-835f-4316-a044-08d90520f787
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4469:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4469C09B11CDAD6C3844A12ABE479@SJ0PR15MB4469.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UPWg/HNj3Mv7PzqSfYIp4kWomF0/fmsfY64FG6hN3Jj/OyGDC/q6VE33ypCcNWauzrfY+zMwJBl6d8zbYiZpBHbcQ1PoQjQXC84s1dkbYLQDLeLzyh9Txy3d84SFfDHLMNk3i0LS+99lEIy/ykxngrgqN15+5/WRdePUALKpIL7GuFDc2dtZ/XLrnXczM4T5H2O16nXNKjDlLvl2q9LHXsOe+7DZJtxI8KsZcsysxkVcvWxHKbc6NjcvGoHqofncH/hDho1QV7oUayXI56yDhIUhqjf4z3E8iC6ShLof2b6nfzsVFT4br06CKk2PJs263iNd3E55sCt/jojS8qLSA2KMNw1cOQE3vHtDsdkve5c7qiSfwjFoqpm3S+Y863oj1u4bHTqNgq+h1b3hKWNPZ6hW1/QN5y2vdRj3eOwObPKvOK5665SfHnD4KzKZRsiPEJzKeSC3JFNhvobgeZ5AO8qtQwxEOKHBP2wMg1J4EazyCXxc9mNFoZdWRaTce3TsnZdL4w07H4yDj9G/2EuR+aSgj7IvpE13E+or3UDZClW1Bw1uMTzsyB6PZ+nnU20ABbTIqURePYg2+qkl0xwx+pVeGJV9M2VNO3rDSCJgCvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(136003)(376002)(39860400002)(6666004)(66946007)(54906003)(7696005)(186003)(8936002)(86362001)(52116002)(6506007)(478600001)(38100700002)(16526019)(7416002)(9686003)(66476007)(66556008)(316002)(4326008)(5660300002)(8676002)(6916009)(2906002)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RHjyQZOu4reTBOIX336wtORVINdxnjtLw3Q4gEJyhrD87y651fkiFyJHVkN+?=
 =?us-ascii?Q?X2pjdpd5Q3L+ykMrHx6ybhXxLw+TGEUOQlUFkfEDZE4ZIZcJVK00F54bwZm6?=
 =?us-ascii?Q?PoOiU+IoLcPkcFueXvwKWqhLLv5MKs1CRgrC6pA/ohdYfPxTXmjs9ID0Mjh0?=
 =?us-ascii?Q?YZKZxNpd9PNa9ZzreJ5rpl3HF2wk0H1pgwzCaQ3lYyCSYHZ1bejZMV5WuLEJ?=
 =?us-ascii?Q?97pdMm2OwgqGxvPvxu0e6GtGHSnsKQpYgVRx2ndfgmDyMeW9GhKhh1/pM478?=
 =?us-ascii?Q?FNF8Xa/yFHhZtq1hjR3YuGGNW40ZH0lPGebmItvFwERhpkYHCmOGgPIThzC/?=
 =?us-ascii?Q?1SACh13yjDROgwP7SHPOFkF0e53UWyb/w0xpArQxv+S2zFqI2wInwXnIeCdy?=
 =?us-ascii?Q?BvvpyitY5pnbJnULf+5hgat5zvEBQOwFDyKbDdt9rw/VblEg7EpxGZZyQI30?=
 =?us-ascii?Q?2Vvbevxe/3uvriwNEGZJ+p58fFXjqN6od6gCgqCSaCuF09uO5wIzHj9PUk9d?=
 =?us-ascii?Q?rB3mOkDXYDnLM4neM7NBzUd1DCSvMEm5pgkwE4Xm7lK6685Xmn1CJdY14IGp?=
 =?us-ascii?Q?+kGnFyUPgATsXMPjZVgyID8Ct6SQYutKrr3Ng7gOu75LedEEfZTt6QBpyNuO?=
 =?us-ascii?Q?JEDs5DxydjmOi9ypZZSnNLBEi67OR8CrMaCnti30mwcp/JQHBdkNaXGYX9RV?=
 =?us-ascii?Q?nDIvvaQMslPA38sppngI0Ft2ny5wLz2P6t/+mSJ2Hi4/OSSkicVYC5UF09YK?=
 =?us-ascii?Q?rKi9j2CMZxhwHXgX5kezu7HLBDs6hFq8S6YMOwf2Sepi9hdmMrzXMyxp/R2I?=
 =?us-ascii?Q?VdC4vsJy/sZbDasb1PrShUKzLTf4jfFbhi9Hf8GsMCcgtarbevJTq6o6dkL+?=
 =?us-ascii?Q?DfgybkLrYl5scs+sEBG4HT4IGTG5uM2c7RVMQ+dgglmKy5AKIJ3jcCwNqi/A?=
 =?us-ascii?Q?lmQb/U8Gj5zSA8ZDpgLPfhePnNWS/4svX1uXv1CScAh/3LbNXXgRfgc3mvV3?=
 =?us-ascii?Q?m54v1crvWNN+swojitoGw0ppBc9HJtNsvmDS4IKfqMhQgRYEZz1uG5jn1EN/?=
 =?us-ascii?Q?luyUR6mmSHlOCWnd40UJUZU0jsKu8tmJ7dNa4LWVVDndxQlC2M6NxwKqGxnE?=
 =?us-ascii?Q?xzeR0H/xkxUWd2awYesyxwFZ4sgKGxxA7KG/qIEzkm/ajr7KxNfxBKVfSevy?=
 =?us-ascii?Q?+NnVbKV4PBLvFBdy/6oWUKsO/SCf1AEZRlWkjhGtj0MndESfqURxxUn8IRR9?=
 =?us-ascii?Q?P/gwOOm8bzLMmWTkz0u6KD27HuJXJ/EITDfS/sUOJFTZFU0pj9tP15S5lbse?=
 =?us-ascii?Q?TagLhUNwMndqiAZljFBOWx801uVQ0ehHiDvnmf/0EKwy9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d83adb-835f-4316-a044-08d90520f787
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 23:55:40.2087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MD1Fx7aRDH7VWYfcxnvppYt+0y6UzPKOlHbRwfQ64WhfnSqYzEO/2OTUiBmbPl2i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4469
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: FpGWz8gN1kx6WbjLfCKlKl2Hz129IfEI
X-Proofpoint-ORIG-GUID: FpGWz8gN1kx6WbjLfCKlKl2Hz129IfEI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-21_08:2021-04-21,2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=893 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210158
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 20, 2021 at 03:29:06PM -0400, Waiman Long wrote:
> There are two issues with the current refill_obj_stock() code. First of
> all, when nr_bytes reaches over PAGE_SIZE, it calls drain_obj_stock() to
> atomically flush out remaining bytes to obj_cgroup, clear cached_objcg
> and do a obj_cgroup_put(). It is likely that the same obj_cgroup will
> be used again which leads to another call to drain_obj_stock() and
> obj_cgroup_get() as well as atomically retrieve the available byte from
> obj_cgroup. That is costly. Instead, we should just uncharge the excess
> pages, reduce the stock bytes and be done with it. The drain_obj_stock()
> function should only be called when obj_cgroup changes.

I really like this idea! Thanks!

However, I wonder if it can implemented simpler by splitting drain_obj_stock()
into two functions:
     empty_obj_stock() will flush cached bytes, but not reset the objcg
     drain_obj_stock() will call empty_obj_stock() and then reset objcg

Then we simple can replace the second drain_obj_stock() in
refill_obj_stock() with empty_obj_stock(). What do you think?

> 
> Secondly, when charging an object of size not less than a page in
> obj_cgroup_charge(), it is possible that the remaining bytes to be
> refilled to the stock will overflow a page and cause refill_obj_stock()
> to uncharge 1 page. To avoid the additional uncharge in this case,
> a new overfill flag is added to refill_obj_stock() which will be set
> when called from obj_cgroup_charge().
> 
> A multithreaded kmalloc+kfree microbenchmark on a 2-socket 48-core
> 96-thread x86-64 system with 96 testing threads were run.  Before this
> patch, the total number of kilo kmalloc+kfree operations done for a 4k
> large object by all the testing threads per second were 4,304 kops/s
> (cgroup v1) and 8,478 kops/s (cgroup v2). After applying this patch, the
> number were 4,731 (cgroup v1) and 418,142 (cgroup v2) respectively. This
> represents a performance improvement of 1.10X (cgroup v1) and 49.3X
> (cgroup v2).

This part looks more controversial. Basically if there are N consequent
allocations of size (PAGE_SIZE + x), the stock will end up with (N * x)
cached bytes, right? It's not the end of the world, but do we really
need it given that uncharging a page is also cached?

Thanks!
