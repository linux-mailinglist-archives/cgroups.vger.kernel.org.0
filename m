Return-Path: <cgroups+bounces-778-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08B0802A8B
	for <lists+cgroups@lfdr.de>; Mon,  4 Dec 2023 04:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028511C20966
	for <lists+cgroups@lfdr.de>; Mon,  4 Dec 2023 03:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D07723AD;
	Mon,  4 Dec 2023 03:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="LPeQt7ER"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ADFF0;
	Sun,  3 Dec 2023 19:33:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQNF7lm2w2y3XCO4gX3tOMHbvJwIjrw3KeuyWRLzcrNSd+vQs48r/tuQwiN4s8n8HK9c088KxF0Nl/pmaPcPDQKApXiXomL94af98HURTPE0YUwDupJjGKI/xNwLJxRKmA71kLSq3Xs6q+a98TWLCMpORYEc6XqplAwn+KG1HYbyftje1TENF+dxR5USVfY6DWyFtRnGfwefUQQAK2TIKcUk+hmkMUfOsMtgjvwotAOZzpe9kPj8vewInjQ6kiOPy8FAWWXjBLfoFehp/Zj48q62StVviMjDQNmq9YO9uhGbIoOhfDZ/ugAMOu44QtYu0eAT2Ca46ORypsAIDGnhhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrET9Cxe1BsiaNt9O7cDfPjCBHlV1wNMoDuYrI6s2GQ=;
 b=BIN7fMjmRuXc9eiZN1wHKgFkV9LOXMsAlsm5neq+YBWuXzHD52O7SNGfS8EiaIjQXBtsFbZFqY5LPC++rNQWzb9gb3Vt8y2i0lGXZagLbfXCxG4UaGMySfbM7pKNctl76TgiXA6ulqeetnPuxyKGPyiPnbhF72QQ/qcSTAHZ6cNHIWDToaQVTyfCWOB9S7+tBy5mYZ7T1mA1JzSozVotOVBEwkTZxdzEgGn6HrKC8Pm6qGY0xARD/v3pzlYjFldgWNAf/AahIhn65XEn+wOQRNDAQeqkaoIUNaKOScAPnEqE+JkvTldUmNOSsR7fhG3yRg3NE4pF/ZfHei9+n2tf0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrET9Cxe1BsiaNt9O7cDfPjCBHlV1wNMoDuYrI6s2GQ=;
 b=LPeQt7ERosXT6/5r3X5/g7+ChE4Mb0S3kKrBPKuAboMvFJXHIOqPT3r916KUJxYr+GXyn9WN8FsXk/bJRN41U1yC6JqFok18p/8FCVj9lY6mkPiqtiU0gMMoY8p42/RzhqTh8y9zghfi2mk6HXOfWOGd2mATkadayqL1jyNsNkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA1PR17MB6501.namprd17.prod.outlook.com (2603:10b6:806:339::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.22; Mon, 4 Dec
 2023 03:33:17 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 03:33:17 +0000
Date: Sun, 3 Dec 2023 22:33:08 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Michal Hocko <mhocko@suse.com>, "tj@kernel.org" <tj@kernel.org>,
	John Groves <john@jagalactic.com>,
	Gregory Price <gourry.memverge@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
	"shakeelb@google.com" <shakeelb@google.com>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>,
	"jgroves@micron.com" <jgroves@micron.com>
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Message-ID: <ZW1IdPI11nhKcdZl@memverge.com>
References: <0100018bb64636ef-9daaf0c0-813c-4209-94e4-96ba6854f554-000000@email.amazonses.com>
 <ZU6pR46kiuzPricM@slm.duckdns.org>
 <ZU6uxSrj75EiXise@memverge.com>
 <ZU7vjsSkGbRLza-K@slm.duckdns.org>
 <ZU74L9oxWOoTTfpM@memverge.com>
 <ZVNBMW8iJIGDyp0y@tiehlicka>
 <ZVOXWx8XNJJNC23A@memverge.com>
 <ZVOn2T_Qg_NTKlB2@tiehlicka>
 <ZVOzMEtDYB4l8qFy@memverge.com>
 <87o7fveeze.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o7fveeze.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BYAPR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::22) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA1PR17MB6501:EE_
X-MS-Office365-Filtering-Correlation-Id: b0bfb101-1553-4e2d-d043-08dbf479c0b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xQRwa0gMjDFM8GdnJolt+sL0PRjwHxhjwMv0tKVlqTDuSM8RwTmmNcA5MQTbpjtAhenjT6m1wra7VPVZnCINqFZsRsP/CL7dNCgz7Dr1VaGy0Bxew0H1jqvOyf9bEoioxTwGdn1NSmYSAdePRs6p6nTVwdyVHEN6auISBW1PGwnimvugI4O29r99SdsLW08m6P2U/aEStsQEEfpD46otf543nqmqXO6AHa/gYzCxWFKw5xfeS92pwxS3F9/yx+yVZU3TZNzDQsgwy3I9cCSNIRlM264ThJFiS43YZi1CyVl6UF/mej7bM1ONF4/+egvIqMIvw2ZmF6Ha1H6jCz2Dn4wSL0fEWBS3D1iurfRZeQnbcBLnK1UuhXZM3rO5GyaP7ChC834q3Vjd6a/TBtyMzF4i9cjGnJzV1vCUsniFKFf9tpKAu8LjSx0v7TseZ5ive+6ZRuQtpwYzwYQTmBJwVdfCWBmg5St6gUjjLcdE/yTZf6TSDMH1BXay3BQu4x3CPf+aR8LppeKp6VA6aKyQT5XmnbpK7VnMCPqSA+UOeUWB8obiCTb7FinafdL8GAIrMAsZDiwNKoWcRh7xzaDakXoSfguPiFtr3eMsoEkqVEk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39840400004)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6916009)(66476007)(66556008)(44832011)(66946007)(316002)(54906003)(4326008)(66899024)(8936002)(8676002)(86362001)(36756003)(6512007)(6506007)(478600001)(6486002)(6666004)(2906002)(966005)(2616005)(26005)(83380400001)(38100700002)(41300700001)(7416002)(5660300002)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V21aODRuYjZJZ2ZYay9PWUt3M2VOYm5XTHVMQ3R5SlY3clVzUXN2YklwS3hv?=
 =?utf-8?B?MTExNWsxSlh0WWdyUzc2WjhRT01nRHgvbUZ2azBJZE9tejlScE1yeThCK0Fx?=
 =?utf-8?B?S1JxNHlLUVpGT2VEN2VBMDdsU3lCc1VLbE5nMG5MbWNhdkZkS1R5S1JFVEZy?=
 =?utf-8?B?RWxUcGJYZ1JXV3h0Z3NiQXRPbjhvMnZnTGxuOXhFWHg1K1FNaUhtSTFxTG1z?=
 =?utf-8?B?NkZTZWtRZkdESWoxT2xIRmVMT1FVSWxXWms1Z0hpdmt6OWZWSlZJT1g1MWJs?=
 =?utf-8?B?UUhhU01YYmVSZlVCeVpDMjNrcGcxM29ONnMvQ2kySWc5b1RQQlhmRUV0S0Rr?=
 =?utf-8?B?WDdHaDg1N25Ebit4T1V4Z2pBTXhtbFN4cCtiWGdxbWs5Rk4ySmU5TkZodXNP?=
 =?utf-8?B?NVlwMzd1Q0VaU0U3eXFHWHl0OEhnQS9CT2RMbkU0U1dpNGxiVHpJSG9XLzBq?=
 =?utf-8?B?ZXR2dW4zRkZSTXA4UDVKTy9IN2xtdFBBSDJvRmh2ZlVzbHpiUVF4VEU5bVIv?=
 =?utf-8?B?OHUrZWZaajFvUytZVUtMVjlXOVR6RTlYWTBFZUtjbTNCTmxlOFR1YmVhYmVw?=
 =?utf-8?B?bmY0UEJaMUNJeU9GYnNjQmlJdU9wZ21NeTJlTDl3RHlMMlhPckUydng0N2Ri?=
 =?utf-8?B?VzQ5a3orTXRlaDJMK2NPdzV5TVppUUFvS0VRUGxhSnFDUlVGcjByMDZNekti?=
 =?utf-8?B?REdmdy9LbDRUSXA5UzliaS9DUG5lQVl5dy9TQkhyU0UvQUF6VUhyM2FSL1FU?=
 =?utf-8?B?azBVN2pSTTIzaHB5eFRnYmRkQlo2TDNvOTdnSDllQTRGdHdwZk5LNWliUWpP?=
 =?utf-8?B?eEhOaHRHOFovNm82cDdxQk96VG1zTHB1ZUE5WXdrd3prMnpqRU1hbXFubklJ?=
 =?utf-8?B?b2lXRmtGVE5acnA4NXlLejk4N1k5TWUwaHMxano4SEpMdkQ0SkNraEtRZTVJ?=
 =?utf-8?B?S09ackpjcjlCRCtEQWN2TDQrcWYyZVdwcTh1MUYxMGY4SjBNcnZqdmlLVVVr?=
 =?utf-8?B?QjlvcSs1dHBKOTZKUnRlUzJkMU9renNxYzdtRER4a1JiRkNZTnhUSDErcndW?=
 =?utf-8?B?WTVkUStMMVZrU3FHdWU1dkQ3SVNwNzA1NGVyNm1VOThxSWtDQXhUeWVTQ0JN?=
 =?utf-8?B?MHRZWk96dUhyWm0wbEFQZldaeXFjRGFXS2pCZlpLaUI3L3lJdVhFMUlJbUFq?=
 =?utf-8?B?ZlR5ek40Y3F6S1MwNFkwaTZ4OElHRUV0ZnJGNVJZWnQ5bFdRdmRjeG96S0du?=
 =?utf-8?B?RTRBdWFHQWhxS2wzNmhORE1ZeTNzNlhSdkEzWmtzUGVQdjlwNHd6eHNBTTJ2?=
 =?utf-8?B?TURhUEVjRjdIZEkweE5SZEJ1eFpieXFhQnpDNFErZWVrd3gzMWlxU1NISXZ4?=
 =?utf-8?B?elZUUUNpR2lsVVcxUzRiaWlCeTRkQkJFR1R2a2lYUkQ3QUpGdkxBaVFHS2pD?=
 =?utf-8?B?SGFMazZTWmtwejZ4NGpObkwxY1VEcndJelJXdTRHbW9KLzFwOEV6Z3RXTkxZ?=
 =?utf-8?B?dFpsRmxhSkZSOCt4OFgvZ2dwcU0zM2Z3UUFVVjA2eGU4SjRMdVQvb3JvQjlM?=
 =?utf-8?B?a2VtTG1MdE90TlhxWUEycFc5VkQzcHBOT3M5M3pBV1RHTGdrVDRUSlZhN2RT?=
 =?utf-8?B?bFRkQ0tucG5iUTU3WnJ3VHgvWXI4T2xqREQ4MTVBWXJJdlk1emN3Z0dNSTd5?=
 =?utf-8?B?ZHlobTkxSHBHdkM1ZktVQXJ1bGpYei9Wb3dCOEhGa3poa25wWHR3WTFpUWFh?=
 =?utf-8?B?TTZsL2JHQjFRN25NbUcwZXlldWdxaWIvc1FWNHFuUUZ2YVNMNmdKWDhiblE2?=
 =?utf-8?B?TEg3WkJQNHJZQXA3OUV0TERaRU1iNXgyZVNxNlFDZjhqdmNMV1Z3MStVNTFZ?=
 =?utf-8?B?b053N3RaVzFRNmJkK2VJQVF0ZjBiUUhNQ09vZktZRkNpalJrNGVndGZ1RlVX?=
 =?utf-8?B?MDI2YWE3MEo4c25XMStBeTNhWW5haEtHKzQ4THJrVFQ5a0dMSGdocUNMeFlD?=
 =?utf-8?B?V3laWDZiNjdpTC93ZXY1U1EzcFQ0clFhR0ZKOEtwTnJBbW9aclFmbldLQnZs?=
 =?utf-8?B?aDY2OElTdUtabHlVMHJjZ3J1Y2ZVUlZ3aEUrVDE0RnpPQUFrc3VVVkNWTWU0?=
 =?utf-8?B?aG1NOUZwZ0g4am9nU0FoU2pKN2pRNnFnRFU0Y2lxYzJ6azh1NDlDWW53Q1l2?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bfb101-1553-4e2d-d043-08dbf479c0b9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 03:33:16.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TR34PvB/NPC+UsYzDcnknlZbnU6jTLyMMvBQ6gF6Bm0mnAhThrJmWKOUYfbZCZzqoPZIuG5vO99NMBvMe2pmbH5KX8uV+7FBWqOKPRFeoBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB6501

On Wed, Nov 15, 2023 at 01:56:53PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> Because we usually have multiple nodes in one mem-tier, I still think
> mem-tier-based interface is simpler than node-based.  But, it seems more
> complex to introduce mem-tier into mempolicy.  Especially if we have
> per-task weights.  So, I am fine to go with node-based interface.
> 
> > * cgroups: "this doesn't involve dynamic resource accounting /
> >             enforcement at all" and "these aren't resource
> > 	    allocations, it's unclear what the hierarchical
> > 	    relationship mean".
> >
> > * node: too global, explore smaller scope first then expand.
> 
> Why is it too global?  I understand that it doesn't cover all possible
> use cases (although I don't know whether these use cases are practical
> or not).  But it can provide a reasonable default per-node weight based
> on available node performance information (such as, HMAT, CDAT, etc.).
> And, quite some workloads can just use it.  I think this is an useful
> feature.
>

Have been sharing notes with more folks.  Michal thinks a global set of
weights is unintuitive and not useful, and would prefer to see the
per-task weights first.

Though this may have been in response to adding it as an attribute of
nodes directly. 

Another proposal here suggested adding a new sysfs setting
https://github.com/skhynix/linux/commit/61d2fcc7a880185df186fa2544edcd2f8785952a

  $ tree /sys/kernel/mm/interleave_weight/
  /sys/kernel/mm/interleave_weight/
  ├── enabled [1]
  ├── possible [2]
  └── node
      ├── node0
      │   └── interleave_weight [3]
      └── node1
          └── interleave_weight [3]

(this could be changed to /sys/kernel/mm/mempolicy/...)

I think the internal representation of this can be simplified greatly,
over what the patch provides now, but maybe this solves the "it doesn't
belong in these other components" issue.

Answer: Simply leave it as a static global kobject in mempolicy, which
also deals with many of the issues regarding race conditions.

If a user provides weights, use those.  If they do not, use globals.

On a cpuset rebind event (container migration, mems_allowed changes),
manually set weights would have to remain, so in a bad case, the
weights would be very out of line with the real distribution of memory.

Example: if your nodemask is (0,1,2) and a migration changes it to
(3,4,5), then unfortunately your weights will likely revert to [1,1,1]

If set with global weights, they could automatically adjust.  It
would not be perfect, but it would be better than the potential worst
case above.  If that same migration occurs, the next allocation would
simply use whatever the target node weights are in the global config.

So if globally you have weights [3,2,1,1,2,3], and you move from
nodemask (0,1,2) to (3,4,5), your weights change from [3,2,1] to
[1,2,3].  If the structure is built as a matrix of (cpu_node,mem_nodes),
the you can also optimize based on the node the task is running on.

That feels very intuitive, deals with many race condition issues, and
the global setting can actually be implemented without the need for
set_mempolicy2 at all - which is certainly a bonus.

Would love more thoughts here.  Will have a new RFC with set_mempolicy2,
mbind2, and MPOL_WEIGHTED_INTERLEAVE soon that demonstrate the above.

Regards
~Gregory

