Return-Path: <cgroups+bounces-346-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFE27E94C9
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 03:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 018BBB208B9
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 02:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E313F846F;
	Mon, 13 Nov 2023 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="W+ufqGzS"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280D17488;
	Mon, 13 Nov 2023 02:28:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6163D4788;
	Sun, 12 Nov 2023 18:28:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kx1MwcAiE6tIypzgqUS7Rkb4AmzWNJkYSUULY4ILRw6/Eb/mlTdusq0NFDmp3qBY+vDDY8PMhL3LPphCIWvyHCcmy2Q5JPF9SccwxHNBDxbLMWaxDzziAMOH15jnPVD63znIq7UFE6g0Os3HVbembUaYrpJmfiQtb8ryJExV7wPp1rpmNJboHp4vg/ha70fUAwuaHagbBgTAp2AIBAu/VoMcqoDWz0ZcmEuXMf+9mlpIcJymhbHvVNUjuk/KjBMbFNmYvW7mqORt4d02cJelZmu/qpQeiRYl4rKWJ47xMehBq2cOZhLqdRKU8bSn/rPUEwYRbIkMhBeGpmK/GyCiEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qDWZUqgyRs6H3XL+VfbCWFeIm3LAjtBGVKpV+jbYJ8=;
 b=NmCeGfCdCyUe9RZq/gGxr7y4bjxjfM1k9JmqdPvDA4zgfEfdXPgghW73MISm+oYuPi7uGK0dWiiOgbX/UCj58PO48IW1Tv6R7TYg5r3VVpEvNqFwExSe9llloeSoXTfU3mHTONK4lRy1kkUmjg0wacJ5eXb2XLmvrezgGBiBYPpferPQmdW8dIGGOOEUEjH/AtihrgVdJrRGH8c6Ycid4Xjw8mZuJGEL9obUHNyivtl7PDi++RYI6Yoj9VqDPPMlq1fDRnK6uAPZx0QBQ6t9xOp+/12UUqFjBo5q4songQy0y1GQDhmLroS9prQNEFGUeIN5711XuWvq0tRlLyDFxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qDWZUqgyRs6H3XL+VfbCWFeIm3LAjtBGVKpV+jbYJ8=;
 b=W+ufqGzS44aOOhq+Eryh1QwHENT5vTU/+7xnB3Zkdn8uKEaaK+ZkNIizebm/XQxfd4bt+CXEjyEyLw5GwYxPM6rjsiP6zR6zcHOlonWBdCjx2u/ay8FuZeDmjOj4MnJgM839aR3SzjVVLHEHeA7JM5Ve4KMOewF/AuPZHgWDtuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BL3PR17MB6067.namprd17.prod.outlook.com (2603:10b6:208:3b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Mon, 13 Nov
 2023 02:28:27 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:28:26 +0000
Date: Sun, 12 Nov 2023 21:28:21 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	akpm@linux-foundation.org, mhocko@kernel.org, tj@kernel.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
	roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Message-ID: <ZVGJxfrFQMqZI+3z@memverge.com>
References: <20231109002517.106829-1-gregory.price@memverge.com>
 <87zfzmf80q.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZU6KiRv7iy/cUY7N@memverge.com>
 <87v8a6fnhg.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8a6fnhg.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::35) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BL3PR17MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: b18cb6d2-070d-4907-7556-08dbe3f03777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JiWuWf9SyL7/SpnZWCAQEBe86kfjDbc5lRPFfXda2aq6U6xHduSkf2q9w71p7KEs5J+F3u6oRuMD6zdPo08hIEaF0AshfvRL2v68dk0fWAi5+LwHBlrpSOALPrO/basJKSQLz0EE0xFEKCy0mgLqRk2ryAeoNpZaXgshkAkATHrpfI8gIS3LBbifX3WXXRIfz6tQ5/aJT9LdbUyrc+oss0wVCBVJY9zM0i0Ull67Q6tJQqmtsN9OQP4vDEWGHgeaTyYVGyTmfMKhck3vFhC2b05vVfB7YFOHPXFAQW5+t+soNbZdR1fyxdJiAeOqIEsIpJiSG4pNfeCNVR5+gOIfe4rpLcaIc7PqATki0rovWFj4gJwRJdLxZtgHU4Yfy218pNj3sxCzOrFJHllnS50HfCp7iF7FPr2YiAWSPdwNe4Jq/pvjh7xiim8eSVyzZdJ5PL8ISQcru06PZkZPfP98Rc3e0xbn/MHl9s8iDkFAIw5mmQ/BEi9Qs34+WyPYUF1yWQy8Z0TxYwTMTeDoqzaHWIDXw2MHYNzQEjEo96jKcwMGGm+PhGSJsi13OCW7spH1GiS1H/6LcTytJHTsUM6ieuuYMlumDNn4jrrtGsppNYJ0BYK8lF43v7hR+yTPVMFVe6DiiNWPPpsUSGZ9sm80Fw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39830400003)(136003)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(66946007)(8936002)(44832011)(6512007)(7416002)(5660300002)(41300700001)(2906002)(4326008)(6486002)(478600001)(316002)(8676002)(6916009)(66556008)(66476007)(83380400001)(38100700002)(6506007)(36756003)(26005)(86362001)(2616005)(6666004)(16393002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qSHhqSIGG6heYyzZJesLfApMXg39URjOKU8wzQbBtvaKmnpZko81KGXO+jLs?=
 =?us-ascii?Q?xVvaAdbOrdYTo9VYK3BuNRE7WZWaAezCDY2XTD3/vQKKGaoGXlEXt7P0eNg4?=
 =?us-ascii?Q?8MBidf/m7X44TA5j9f6FHvB/w0hnlnsS950VgUYj3IYOrYqQVI1tNjP9DnEK?=
 =?us-ascii?Q?tPxl2gZc5KdHxBbvd2Kqk7Xd4XSDTuRa7OYB9ceI+7MzVT0cjQLGaF166+pw?=
 =?us-ascii?Q?PXRpWCBVHRaRuwZUqFivyJPloFvNU+xppTcMPSUzWrUN9XIYcFvIt/jFARCV?=
 =?us-ascii?Q?cmXh4WEpgjZynBy9kkEMkk1wqrQs4UlRGR96SAQnqKG6WuSxN+i7mrl5EHBf?=
 =?us-ascii?Q?0fz/7EWwqS8UwlB49CczRx4WfrBWq9QDJYOSYfrMw2QyR6S+8JQVyZpTCTqj?=
 =?us-ascii?Q?kVnJ8DVTaPtR1gbcIJx3su/ZrekWQdCUWs5QAgLj+LG0eE1/LJuYB0JnH4xL?=
 =?us-ascii?Q?c5ZKPELRCmj32OU5Dy4DQR0HLGIY/3m7DhBtYl9vXqWDpYgNxerBcbwHAkqu?=
 =?us-ascii?Q?d4wMgHEASQsfOUpqUjTn0aosJ/5esk5/lhPUz12M/yv6jt5RnoucpNxoRSwC?=
 =?us-ascii?Q?uvSOvOKAxD3LHoO7BAVS/AEs9tdB4ZkyHAVTmJDNYr+zY6KhkSiCQJ0haWC2?=
 =?us-ascii?Q?w4tzbv4GaBvBpKg+UBM4U5Ejxb9fZM6xaED/HmetTVDchF0PqjKYNU6C/uun?=
 =?us-ascii?Q?y3HmpK0zzyPMp+Zpg4aSrhY+h+rbAEh4h6B60i5yhqoYbRGEX5drHF4gPEzG?=
 =?us-ascii?Q?83za69m3xvj1LcW9RkRb6JV326ZS1tPuDZtv6TLChD1hyjCG/lNR3S8jCH4C?=
 =?us-ascii?Q?XHJPGSF9VNWirZDwcyfslh/xweJAzH1FLO3lfFYnBRQTNK/XfWAxjO5hi3+F?=
 =?us-ascii?Q?q8Ij7uZ0e7zyy7KROzVm/UkRGSmxvHKq0KTHhRgXlG0Qmeo71s9j+GGC8YH6?=
 =?us-ascii?Q?X+1u23soc0Wst8VWeA0A2iUXE2Qvy/PayuzS25Ptrv7xEQe99gIjlCJcRDkk?=
 =?us-ascii?Q?pfgDR6g/8Lqo1Srend8Ec6VzabJjwWiBmKqjEZeFnX7VmTrAM8DzVA86+SeZ?=
 =?us-ascii?Q?i/asQBa4YP+97T+pghhjD2kH3mpMWPBaZ9sMgRgVIKsF6QNTGrL2RaFJm/01?=
 =?us-ascii?Q?t/GhA1iRndjzBnTByxpnJTge9/ac+FT9KOBWEeEJaaUflYW87A1/GcRqF4s1?=
 =?us-ascii?Q?NeTsx4FnV0hc358xmUUew8Mk9TB45xdSUoE9LZgpxuxbH/fcEku0BhCdcciR?=
 =?us-ascii?Q?fR8TgRW1LDom+79c027V1S+SCAwaPwisqAsSS7BPoZkVE+NoHf1Al5cWyuY1?=
 =?us-ascii?Q?ON2AdZpYpklQbYbXdsioQWDQrCJYMwkgeERTx/Tvp4JtwK4FoKHvJLBrkfy3?=
 =?us-ascii?Q?e5Grw+qXYe3mtgiyBorxOKQbCuBO/jRTLNMmvBIA9Ii37XJ44lHzxYiE/iUp?=
 =?us-ascii?Q?PGM6pioFIPtCwZfMzTAySY5kC3d6cK8FeQs0BMyg2WheMdbg0zuNSAEWqO9m?=
 =?us-ascii?Q?pqrxXp1nYHTUyu+EBQ7G6v05qDFcAJGIkMIwiwLqQj8B+VldRph04T4EM2k+?=
 =?us-ascii?Q?HQpyrVzh+03v64Psmt0xnPlMlZh8OSaNaNflSPkw3JAhtHL6PFJHsxkLuiAI?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18cb6d2-070d-4907-7556-08dbe3f03777
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:28:26.6248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTu3T8G4N8s5aR5Dsmc7BT9FBckub0WQKweRyKvHrX9rBwd6tOSvVBGjtqUl8WB/3WNplqenCLRr+1Pi/zV/ISFnoomuGbKKTFzv1y+UTms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR17MB6067

On Mon, Nov 13, 2023 at 09:31:07AM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> > On Fri, Nov 10, 2023 at 02:16:05PM +0800, Huang, Ying wrote:
> >> Gregory Price <gourry.memverge@gmail.com> writes:
> >> 
> >
> > weights are also inherited from parent cgroups, so if you set them in
> > parent slices you can automatically set update system settings.
> >
> > by default the parent slice weights will always be 1 until set
> > otherwise.  Once they're set, children inherit naturally.
> >
> > Maybe there's an argument here for including interleave_weights in the
> > root cgroup.
> 
> Even if the interleave_weights is introduced in root cgroup, the initial
> default weight need to be 1 to be back-compatible with the original
> MPOL_INTERLEAVE.
>

Sorry, I am maybe not explaining correctly.  Right now, the weights
are not *replicated* when a child cgroup is created.  Instead, when
weights are requested (during allocation) the requestor searches for the
first cgroup in its family that has weights.

while (!memcg->weights && !memcg_is_root(memcg))
    memcg = parent(memcg)

We only create new weights on each child if the child explicitly has
their weights set.  We manage everything else via RCU to keep it all
consistent.

This would allow a set of weights in the root cgroup to be set and then
immediately inherited by the entire system, though it does add the
overhead of searching the cgroup family lineage on allocations (which
could be non-trivial, we are still testing it).

> If we don't reuse MPOL_INTERLEAVE, but use a new memory policy mode (say
> MPOL_WEIGHTED_INTERLEAVE).  The default values of the interleave weight
> in root cgroup needn't to be 1.

I agree, and I already have patches that do just this.  Though based on
other feedback, it's looking like I'll be reverting back to implementing
all of this in mempolicy, and maybe trying to pull mempolicy forward
into the procfs world.

~Gregory

