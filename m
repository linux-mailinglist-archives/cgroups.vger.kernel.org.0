Return-Path: <cgroups+bounces-327-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 485A97E8319
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 20:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B908AB20DF1
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 19:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF03F3B2A1;
	Fri, 10 Nov 2023 19:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="p5Jk+7QK"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D905A33FA;
	Fri, 10 Nov 2023 19:55:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D56268B4;
	Fri, 10 Nov 2023 11:54:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo3k6I3L3+GaMcPE9W8IN9T7AObg33M0tnp9fSppm7I2/LPuQ01fvN5xCzFHvPV9FklloyS2iASNPyhGljNo/hMfOzLArTkG4QBLsgFTR5QYkH0FewtmCWNe7VxrGc+An0q7hlb1jzoylRqsxKQJs/Dl9tJcRotEXOr/e0DCXxBZzzQ5anv5xjNxOoUZhlIDcZzdX/hmO5x/m3nBRGle2dHPnfWTLoZZiIK0wxyecKb7n4wDRihwomWJYB/Q49b7j/eN1OpZ97uZF3fmOZKVqJ7QGvZUfTSghLBQu/GAXYvY7yTTXO6jCyn+o3jAZhtwyvpQ1B9uWRZQ9Y2H0D+Mew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5un78N5+jUds3zCNWYGkXwpUGcb9pwtuVmOvn+vG6+g=;
 b=QHMTCL6K8zA0AUBcjUkc1CbcPCVKn6V+yfJLgCd39uD21xK6QBSGQADwxgQj/giXx7i7WPzSFZKRmEVWwS/JjO4O3xyDNxpSRxsNQ91VgwR3xMH/e//WZ/kJXbXdn/zkXDEMCeiC0jJ3CfYDl2TBK9g00+QlDVoGCX8MrW0Xv9tO/XxB53Zc/mxJSpEB92pgn5SvMryJRi7GP1OdL9Mi6L7lKpsi0C8lM3OESMJUXsLWWDU9jyl2pDC24R/Iq3ZJlOTUzPGj++bBBT414jP/PAetYQnGRdwbZ6BZ5P9CNDHlMwe1Iw3DMPSkfClV202r25e0sdtOHbYkDPIe2grkBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5un78N5+jUds3zCNWYGkXwpUGcb9pwtuVmOvn+vG6+g=;
 b=p5Jk+7QKKq26MxfR03EpBuuzlDUpmrXloLoD/gB8sz1hXHJffWUEUG7rOx9CVmb/EsVjDnE6moGa1539yOW+fg2GFHhTwCTn6sg1ALmlfPpXSAbCY4Bx1V7ZCaTlUglbwTVNI0fLlUsepn5h9EOHzpAfmUldG4bk0cQtwoVWhjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SJ0PR17MB5557.namprd17.prod.outlook.com (2603:10b6:a03:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.9; Fri, 10 Nov
 2023 19:54:53 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7002.010; Fri, 10 Nov 2023
 19:54:53 +0000
Date: Fri, 10 Nov 2023 14:54:49 -0500
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
Message-ID: <ZU6KiRv7iy/cUY7N@memverge.com>
References: <20231109002517.106829-1-gregory.price@memverge.com>
 <87zfzmf80q.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfzmf80q.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::15) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SJ0PR17MB5557:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe52eac-d646-4b7f-29ec-08dbe226e7b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ygCsEckYGxQbY5Fk+kAkXixzlSI9OQqJq3C3dErJeDeXmYI7Ff9GFIqKRmZl8wPGsX04Eo+8AjLrQCEOwEbLwZXbGJbbxA01ZpC5TRflDoSwSiD7KOnY3cbVAhOzZdXoN/0zVujiJa03EqE0APEw7Xp9SyL0E7Xbkg15coSc+UXhedooPSjn6I2NrXRQnmxvTUqg6gdi5Mu3fIHmP2FzjXgddx1kcsjvuAk39PXl6a4WvUSRSQtX5eq9GW7zZ684XDwIKFnB2MuOJiY+BPNSeT3IZhu/BkbG/bxzw6LIeUK6DRl/mtwod5oaaQA6/TZOAkALZPDJBpQcrFSmHbK4mzv5bmDS3VTzuhE45dmdlSKeaYTvT0WLMTNjrlPL6jrOypy1jTPI0SnTTh4NQcca2W5AauYpGw7MMisoIs4oonTfcbEVTyV8oNhqV9bw1KUZvoOIgyRkiW4Fd8aBG+bkrcrOAQK0mvU8B+HspjcEoDFqNxlpUgirPnl5Aq2g5JbDG2ZI80Aypc+uQmruEbhpdtU4TnxGFQQf5/hyX/zPj/pq9SFzUCFDcRZfD6zap9CaCJdhvO+YKEw1LcDtcbvUzJyc0vRwBsuoTaZ6dIF4F+4LzEs7fEMYwd2//xbcnBa1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39840400004)(136003)(346002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6512007)(6486002)(478600001)(2616005)(6666004)(6506007)(83380400001)(7416002)(26005)(2906002)(66476007)(41300700001)(44832011)(66556008)(66946007)(4326008)(6916009)(8676002)(8936002)(316002)(5660300002)(38100700002)(36756003)(86362001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?khNQ6xcg1p90yHKbACXCFKc39HEbFJJisoMILo3STSYeCy0t3dpqPmjHFqZP?=
 =?us-ascii?Q?Gp2cOQa+bwbDwJNJallvEp6VxTBzdEwdhgth0cPpU6qIlh4+V6P2NO1nS4SX?=
 =?us-ascii?Q?VJANZVyyAThex6CqY+iB7l8PiWf22APpJz708xq1hRil8/rezuMOybjEBn7P?=
 =?us-ascii?Q?2jRaqYxfVag/I0fe++KOexK3icwWN17XTa1UgpojBsU0jhDfKZOX9RkWICh4?=
 =?us-ascii?Q?o+KJvPae1ir+4u3SQDPvmrDUlay0GNVuZe8mLqdIRjJcLY6HaST3EQNDw+cx?=
 =?us-ascii?Q?zOF9OJLq3gYWdtUm352JCoGujUHCQN+eS7r0LlbevsGEhtBZGwZzEVLWJ4WT?=
 =?us-ascii?Q?oYiZ9yZ+qPCLkw3chD4xtv6n2zAdzUlVepeGyf+k7g1FLT1cxkUNrWGns5vo?=
 =?us-ascii?Q?5DgfHhowBdUB9XGKC9K6C0PkQMLcgRFmclQY7SGMSnRq1Vz954/mQe2MrZeX?=
 =?us-ascii?Q?FwPalIqPIqqxYH5pEJxCNplFcEpfKpukP+VzV5c1Yks2iT2R16Ik7vD2vGmv?=
 =?us-ascii?Q?1YZ8c3nbSlcd4tlPCPiPuK7Qvjfhq58ldVjB4K9RzwCQtL5ID13QM/K5nxOP?=
 =?us-ascii?Q?4Kg9PwNCNhBXE+mvMnbN/HyIkxC4PzR1ho75XxKyI6DNCSYo08GYynakTwIP?=
 =?us-ascii?Q?xY5OJ/ny4seT2vQ2I14Wf9zjtwvhLcg8/X6hV5+mj7Ja7kiCcz0P1uEhG9lw?=
 =?us-ascii?Q?hMcvWGX8dCQX037xj9yt3f/f/VNNHva8Wtbu8+/Tbt0HQL/YyIaAsWXYtgiV?=
 =?us-ascii?Q?daKuiVp2CHwrVcdvWIQNQoklgxXO3wQdQ/Aq6/UeBBIVEAVQkFxpkXAVcmvH?=
 =?us-ascii?Q?qSukY544+4WWUHmtQm7q9Bi/hLPkw9AwDPZS2BHuLX0tZdt56unOirf1IbGJ?=
 =?us-ascii?Q?dmXD4nRoWWjwz3JF+eYkE4W5+h8PtrAPWo/mscur4QgxCePI/OZ/CAinbxDj?=
 =?us-ascii?Q?MgPvL9NH2Y3LWl90HlQcKEzdSuUS5KD8RJxss0BOP9VEO2euDEHxZXTm4ycb?=
 =?us-ascii?Q?sykDGRzTworuitDdGId2rBc2lI1JQ7oFy5GO1OHNnuG94r6EWccqgZgG1xgD?=
 =?us-ascii?Q?b2NvDlzMd+SujyDNHNZjHO0PuoYtT6iGsBu9VZbZmd+F6RlTo/EPLQpgMRt7?=
 =?us-ascii?Q?N2DR4Z7mqW7EzXuzTz5sNtT6IB2EvT9Mq1EjdGegNWUnRlrCrArwgnfNk3ag?=
 =?us-ascii?Q?0BzpqXjNzPWJAHWTuKjAWphHyU7ATZJpTVDwt1iCxfzv5OdgMjBIVubK9JhO?=
 =?us-ascii?Q?8AgCJLG4fHASOyXkA4/TqXvcdwN+zO2wUDM+wz1FLnafOqgTly7Em/KMu59K?=
 =?us-ascii?Q?LljvDacrNSwz7f0zpZ6ukiGzKYn8QPFZ8rQA7vkG9iu9/ZrG02q+hkuR2ghO?=
 =?us-ascii?Q?Z2efm6sLkjQcufdxFBxlsC3VuovSezoUjyE9fGmaDzoTRHm2mcK8MkcFe8RQ?=
 =?us-ascii?Q?vlj9/U5AU61DJVG1jONFYZ3e92yMQN/hk2HhgFBuNlYNzhiTJES0YBEa/v6N?=
 =?us-ascii?Q?IpC9QdfWN7rO0/8e0dMQf2d2akOp5IDa93QzAhAtwOOAOPb0mSpZhPChoneL?=
 =?us-ascii?Q?Iodep4OHQ+byx+m4LxyOx94VnL+9HE7QrV8l/kHRAr7j9KMLq+h21F6CMJuC?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe52eac-d646-4b7f-29ec-08dbe226e7b8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 19:54:52.9199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6yfi5kzXhOoqRhFI+tMxURcCuLvwl21P/zV2VhUIipZZgNRsyNOQ+fwvRvarmPhjRxwA4QMted4sWmR6ZEOJ/Wfd3Nzp8YKFgvGtRO3pIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR17MB5557

On Fri, Nov 10, 2023 at 02:16:05PM +0800, Huang, Ying wrote:
> Gregory Price <gourry.memverge@gmail.com> writes:
> 
> > This patchset implements weighted interleave and adds a new cgroup
> > sysfs entry: cgroup/memory.interleave_weights (excluded from root).
> >
> > The il_weight of a node is used by mempolicy to implement weighted
> > interleave when `numactl --interleave=...` is invoked.  By default
> > il_weight for a node is always 1, which preserves the default round
> > robin interleave behavior.
> 
> IIUC, this makes it almost impossible to set the default weight of a
> node from the node memory bandwidth information.  This will make the
> life of users a little harder.
> 
> If so, how about use a new memory policy mode, for example
> MPOL_WEIGHTED_INTERLEAVE, etc.
>

weights are also inherited from parent cgroups, so if you set them in
parent slices you can automatically set update system settings.

by default the parent slice weights will always be 1 until set
otherwise.  Once they're set, children inherit naturally.

Maybe there's an argument here for including interleave_weights in the
root cgroup.

~Gregory

