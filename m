Return-Path: <cgroups+bounces-345-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC907E9472
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 03:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46A91F20EFD
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 02:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABF45380;
	Mon, 13 Nov 2023 02:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="fyhWonLc"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E471A5232;
	Mon, 13 Nov 2023 02:22:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F36F11C;
	Sun, 12 Nov 2023 18:22:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3JdUwqkKs7bUi82AuIjPdjpKYorS3jLHEkshJW7rCC5WMhXimsPPvmFw6FJt3C090nQSqdgPBVKIMpEqrJSbf7fJSyfCDnCF5r6/ElnMPdVko2Rv0v7Eg+EliOa1ka40MKsz17YXGOCeruBhqlwWGRYcop1bCE8khLmHsUl9bPQG/FbAeH7dNLdKpvRzosiwYBVnUC3cF2Y0hbtmOXz1DS5abhG4q2GEH9Sv5XSBwvoMzPCFbENJYsWhMaCS489HAvnBOzOaW7NjE98BIojRSrRt6PYQkjW/T6qAzakyTkANCVZ+0S3BjHCFlyLzXf4ppWbZKTbNLZ2USt8iUx0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FczW7ZbDfZ8fxt7GITKnaXG6oC9QzgSV7+UocEjM558=;
 b=lAEGzPzOJ1gYamk/uLiXRko/csAAYg1KU2c6kW7S7PjjYoCiK1LInHYDsTOzI7uT+eKDJHT4MMZwi1SsFrdcuPJlXdj673HXMtZoyIKuf8kPBVZ7OCIRmnEXsfOft7uWVx/z3CAkRGPwnLNgkp5cW/ElH19rZwoxb3mnq/mUE4D5uOSUAGYOj88M3QUWVzbZlbNcHCgEFEFoxc3+TcCJ2Hh6Q2KpkjbpydkDEV88w9zqGGxz7jnsxPcZH+pVYio1UGbXBX9JFZmZHW9fEV1po/Uk58oB9RJXCEM4pcp9h+JCWqKDInDMNXgCk8BWNJQxByDrzwSLnf6iTZXHqQrwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FczW7ZbDfZ8fxt7GITKnaXG6oC9QzgSV7+UocEjM558=;
 b=fyhWonLcFQXypXFqH0C/vTPsO+Sp5SU6TxaVSv9QSGTx4OiPgHDj+TCY03L9OL2f5qRphJWTn3U3tcBJtiN/NkUA0+GT52+tJ0n/0/qgLgxukxbzzbqesG2K1AOMPGr0xcL+ftGJJxm5y9GTDQTlY4zYUuLsGNCY0jIuur5Uc94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CH3PR17MB7052.namprd17.prod.outlook.com (2603:10b6:610:12d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Mon, 13 Nov
 2023 02:22:31 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:22:31 +0000
Date: Sun, 12 Nov 2023 21:22:20 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "tj@kernel.org" <tj@kernel.org>, John Groves <john@jagalactic.com>,
	Gregory Price <gourry.memverge@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"ying.huang@intel.com" <ying.huang@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"mhocko@kernel.org" <mhocko@kernel.org>,
	"lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
	"shakeelb@google.com" <shakeelb@google.com>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>,
	"jgroves@micron.com" <jgroves@micron.com>
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Message-ID: <ZVGIXN83qG7jQmuj@memverge.com>
References: <20231109002517.106829-1-gregory.price@memverge.com>
 <klhcqksrg7uvdrf6hoi5tegifycjltz2kx2d62hapmw3ulr7oa@woibsnrpgox4>
 <0100018bb64636ef-9daaf0c0-813c-4209-94e4-96ba6854f554-000000@email.amazonses.com>
 <ZU6pR46kiuzPricM@slm.duckdns.org>
 <ZU6uxSrj75EiXise@memverge.com>
 <ZU7vjsSkGbRLza-K@slm.duckdns.org>
 <ZU74L9oxWOoTTfpM@memverge.com>
 <ZU9ijZHZZjRgUctq@mtj.duckdns.org>
 <6550144fb048d_46f0294be@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6550144fb048d_46f0294be@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:a03:333::32) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CH3PR17MB7052:EE_
X-MS-Office365-Filtering-Correlation-Id: a274114f-f75f-4247-c3ad-08dbe3ef633f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4YeqWXOInnMnue6dha8WJ/UMHFWHSXmBlMYzyuTDIVe6EUF2wyccM7Xm9Jhk3fPLptgPldUQzJOTYZAte9VTIji9Rhf6+DdIOx1MvNgERBd5G26EewsCi5KKFMsmsGstddw3KutaTd+CTHPaIfVhwCOxhSXOnquuQASSgaVFp0OyeoJJeEG7l/eQsWRZdAlWGUjtkUDt3F1U/6pwH8KsWJmFZLvHie0FSRgLax+xqLVxxPUndVr/WIcEvmFPfuCfKH5ZbHd4VubECfaudmxJlPRc1Sozov55kJmaUnDf0iRjt2dVrVGpedRgnI8XGrruLsmZaxXVXR2Rv98xOJvd1pRntQWr8STh7XEM1GKuHjtCy8Lr11Unykce0yOOuOVsswKVCxFWko+Pv/XLbqFX8UaVBexr1kAYLPMIrEdCDnjFYCasg8C33LGaI4/eEIt7obRehxoQG712YCfF3ZDgUQVez8p31ofmTPOrYo2QVO/NaGYoZjtF4geSQYIIsY2lF5Iamsp6WdR62zFS8nt5AiHOKQG1ecJyXFwyLV2tYeH9TAGd8UvQ1Qpb+3ea18AkuR3bCEqMlcWREatRcIl0/dfO/FqoRfmdfDtYqnYz1CpZnO66rRhD6wFLlJ7AxcyB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39830400003)(366004)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(316002)(86362001)(6486002)(36756003)(6916009)(54906003)(66476007)(66556008)(66946007)(478600001)(7416002)(5660300002)(2616005)(2906002)(26005)(6512007)(44832011)(6506007)(6666004)(41300700001)(8936002)(8676002)(4326008)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qZ1geNFo7Xvej5Do/WW4S0GeNShlZvsOdf/OrNX7j2jiYujglyWTaxeyD9RQ?=
 =?us-ascii?Q?ZAYguSLMSM1cLieKb3cm6UHYa1eatK6UXa5AEigV0oXVUkTA1GZxueGatdLw?=
 =?us-ascii?Q?kc4Zyh1GG9rkz0dH2bG5m0lBp2JwRBvOA87+MaYDC53mbRrF28K8Cr5FCP2L?=
 =?us-ascii?Q?o06JhJrvexlokJUcPZzBi4HwvjPpaz9E1uWS53+pDPP6qp+/zhCrK0Xamj3C?=
 =?us-ascii?Q?oVVUqrO2c24iXfFfH/Sy/uiAQvQXWE+lBbSJ0npVIhYOUS5JuaHOIYJE+TzV?=
 =?us-ascii?Q?wBJ7pnl2G5skpjIorf7Gl/BkOAUn1FPhLp1/Vo1ee9gaYDqAH4ISeuC355Lb?=
 =?us-ascii?Q?CDG3wZtprsGDdpoKzBfZgaBadg4fiwS6t74UZ1auazY4d9P1YiDeoxFfiLNm?=
 =?us-ascii?Q?FsC177LvCFne4kFRD555cDc0htHAIuGFsbuuyzOdLNwQB7E2nt+Rmmm7Bwgr?=
 =?us-ascii?Q?b+9M9u4XjzAfeVYrtHyBIGux+vQj1ntPDtlrzyfPO0ejwnwifQgWTN9RfjY1?=
 =?us-ascii?Q?/xqrg80lVRo6kd4Yzppd11mBVqlfsjA8RVssVqtK/l31eaDQThHRczEr7vbZ?=
 =?us-ascii?Q?byUB3+ohzR1LjRkpNJS6iiiti/A+XAtp+wkWJvJdIRYD9sU1peKu2Kvlj7la?=
 =?us-ascii?Q?HJi7kosFDExMTfRCPl7Q85wMEiFzk0k5I9YmW8DdHsra6PPyn11toKp6HPq1?=
 =?us-ascii?Q?4/YMlfiIQp+vJH2pE0Q6wccsSOvxgZbbxLe725nEBTI2rg2ZLJpcdUkB/iGi?=
 =?us-ascii?Q?JWOEPDF0mginpUvVMRe+lsRFCelxsA0UMcUmjLzKiRSx+44VmTbBb7MFwnjM?=
 =?us-ascii?Q?l8Dlkp8iUvTWzyWk4UCML/qsoQUn5ADgueHmzQAdQ7zo118zb3qDQb52OA7F?=
 =?us-ascii?Q?8bpzGV9cGTyrqDllZsJSDRjjfJhPLAfGeUElkFE2f80oDqVnbKSBpIBhytf5?=
 =?us-ascii?Q?UrKX3sGYgnDZOVCqBS3i3/XzjFIo4GZc/1ctaNzPWIJxOCzRk+FPnA1jZ/rA?=
 =?us-ascii?Q?jVcwTgtYaEzuBpLKrSPOAQjW7fW++2+/Q8cKGeDQnsoB/rD7e4ZdaDxgiLQT?=
 =?us-ascii?Q?dsboaLALHqyO57CP2bJKmnnOOe/9999ddpXPoXgfnOnmt0d3MDnH9l9TBVdc?=
 =?us-ascii?Q?3FX34Iz/2UXubRBnAqiivAMW3afPigaRpOE6k/k4ktT15IrBoaMP0LQboY7K?=
 =?us-ascii?Q?VvD2FzSgjoIZzO8D8cxyA4UAtEwwuzPnzcCv6XAbt4O0mLrqiD/9ZJTcmAPI?=
 =?us-ascii?Q?5LUy+JO/EhCR7+gQ2HuSNYO6TFJY/Z1DSXuYlP0UC6UR2MfITZ4R+zxmwY+i?=
 =?us-ascii?Q?+Mrzc2nlqdWeiZLMFrbDb7/GFD9olxEZhk4A6YiIbIYMGZLZNv/9Tai0fAhs?=
 =?us-ascii?Q?WwxCteJZ8f3b9nMzSxNnTPkn1B3rcYGSV+x9dwg4fbQSZygQF2i3/eS+RjxK?=
 =?us-ascii?Q?bDkhESYj5ctCknsATyg9EPzTves0xxHB2U4iTb/TIA5pSSseoSJ4FzsjQTBi?=
 =?us-ascii?Q?2lqMTg66gNtGdayUMUkP4w/KGtrIWerDZ3XDTjkbcDsSCbMmHAUH13yWLO+w?=
 =?us-ascii?Q?MKbpjzMjbLaQoPTQIdsLwWdoJPTb0Fk/zLczsmV9LAw4O9dYcr2gAI3WSRXe?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a274114f-f75f-4247-c3ad-08dbe3ef633f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:22:30.6127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGiQIlC7fbInknxjOyxj+S0dCRJ4TgV1KS4udvXQFnKBsyBL4zXZ9zIudAv/JAuFs5Vrem+aU+nB9HopRs529FA1rx+EitBHc4fhKMhgzf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR17MB7052

On Sat, Nov 11, 2023 at 03:54:55PM -0800, Dan Williams wrote:
> tj@kernel.org wrote:
> > Hello,
> > 
> > On Fri, Nov 10, 2023 at 10:42:39PM -0500, Gregory Price wrote:
> > > On Fri, Nov 10, 2023 at 05:05:50PM -1000, tj@kernel.org wrote:
> 
> > Here, even if CXL actually becomes popular, how many are going to use memory
> > hotplug and need to dynamically rebalance memory in actively running
> > workloads? What's the scenario? Are there going to be an army of data center
> > technicians going around plugging and unplugging CXL devices depending on
> > system memory usage?
> 
> While I have personal skepticism that all of the infrastructure in the
> CXL specification is going to become popular, one mechanism that seems
> poised to cross that threshold is "dynamic capacity". So it is not the
> case that techs are running around hot-adjusting physical memory. A host
> will have a cable hop to a shared memory pool in the rack where it can
> be dynamically provisioned across hosts.
> 
> However, even then the bounds of what is dynamic is going to be
> constrained to a fixed address space with likely predictable performance
> characteristics for that address range. That potentially allows for a
> system wide memory interleave policy to be viable. That might be the
> place to start and mirrors, at a coarser granularity, what hardware
> interleaving can do.
> 
> [..]

Funny enough, this is exactly why I skipped cgroups and went directly to 
implementing the weights as an attribute of numa nodes. It cuts out a
middle-man and lets you apply weights globally.

BUT the policy is still ultimately opt-in, so you don't really get a
global effect, just a global control.  Just given that lesson, yeah
it's better to reduce the scope to mempolicy first.

Getting to global interleave weights from there... more complicated.

The simplees way I can think of to test system-wide weighted interleave
is to have the init task create a default mempolicy and have all tasks
inherit it.  That feels like a big, dumb hammer - but it might work.

Comparatively, implementing a mempolicy in the root cgroup and having
tasks use that directly "feels" better, though lessons form this patch
- interating cgroup parent trees on allocations feels not great.

Barring that, if a cgroup.mempolicy and a default mempolicy for init
aren't realistic, I don't see a good path to fruition for a global
interleave approach that doesn't require nastier allocator changes.

In the meantime, unless there's other pro-cgroups voices, I'm going to
pivot back to my initial approach of doing it in mempolicy, though I
may explore extending mempolicy into procfs at the same time.

~Gregory

