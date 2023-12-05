Return-Path: <cgroups+bounces-813-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169198057BA
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 15:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2F85B2100C
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 14:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FE965EC1;
	Tue,  5 Dec 2023 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="xwAyo+S3"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D783CA;
	Tue,  5 Dec 2023 06:48:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xh4s+N7XtBu9s2fLd/uEkFhOF7LAxGqjDkLtaHu037PMe+pqWWqUIi4rkRcS0EeUertRMATjG7P/nDb7oFvjFONcaYWL2fn/LyhUdHIAqZ+b9G8rVjIyhjDfWk11/YX4lsh1wYKFB+hpdLez07k+9gfVzqLidgnH7jhVCTrJEfE5XzARhgwK71BeMtnYYTVfd1OLS5Q/H5FRMiqqxcb6QtOYjDDzdwvluKL5tfiV4uY9DftoGMsbTfEczgR1K6y2fcYCxSIYwI/kNeaW9CPENBFFXk0tAqmeokza4LRPHz1RlgkRmfhvglHPSnQ0e6mSOxyCPSVSfokShZSUcfqSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CGWv/WudBoNeUlGM0tsKTwHDmH/kQnUGxqZapCt5WQ=;
 b=V3m4gElxznZdyGs1O4RjFWA7zkvccnwo39xDvB2SXrcIqC2jVW5JRMxGkteP8X2Bj7e2LNRk9TIqvbxhnoLT1ZioU7HCEJuYJBrCJLFh35SdPFjcXYPBH/3OgKhXLQvrk7DWHD/ibFoCyEJOZvXd3yv0zcg48Iy5ZHX9sXB90iaj2DnA1aLzqfPYO+amYOoCciCCx5ynPIA4+KtSbzw+ucsimXufm0cePv2JpEV1HAkmQBPmeaL8tXGmyAMTAKRgkyhP/FyJJ9jsZLvjq+IX904T5/4qiLWTszgt+zKb2rdvWawoG4HGdmVlSKgwcYwd1l1rI7OYYGjomceTk/cLQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CGWv/WudBoNeUlGM0tsKTwHDmH/kQnUGxqZapCt5WQ=;
 b=xwAyo+S3GduO3VE6dYyio0FOVl48hL0yQwpDTGbdlxQYuVhXaWvDdLKJnjbx5cd/ilNSzhFiKD6HfvbS+6m2h13iEKg5J89xfsu3loCXH13gAFwWvhzoa1uNngHEMZMZ+iPxyRsfuno5EWMyXvT3azLKDOaz/0Mjc77tmBYZwyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM4PR17MB5873.namprd17.prod.outlook.com (2603:10b6:8:41::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.24; Tue, 5 Dec 2023 14:48:01 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7068.022; Tue, 5 Dec 2023
 14:48:01 +0000
Date: Tue, 5 Dec 2023 09:47:51 -0500
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
Message-ID: <ZW84F5PUB/0yPW9d@memverge.com>
References: <ZU74L9oxWOoTTfpM@memverge.com>
 <ZVNBMW8iJIGDyp0y@tiehlicka>
 <ZVOXWx8XNJJNC23A@memverge.com>
 <ZVOn2T_Qg_NTKlB2@tiehlicka>
 <ZVOzMEtDYB4l8qFy@memverge.com>
 <87o7fveeze.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZW1IdPI11nhKcdZl@memverge.com>
 <87sf4i2xe1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZW3ZFDeTs7xotImL@memverge.com>
 <87fs0h2fb4.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs0h2fb4.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:a03:338::26) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM4PR17MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: b129dae2-e394-424d-650c-08dbf5a12dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R3RcwVnuzLfPGKMve0jsEyis6E+94HvsNBUa+hCm+jGv3JeLKX48fn4keN65whD2snslszvtOZ+8Fr8XZAXTGjVrmpzLWnjxmSRoNo3LY9yndK7At71ldluLArj5EOf/JyeuHRn4Q2aE8bm2wUZlgUQ+4F5uIJKe908ml/ZBG8AGR5GvUMgjnHnU4HsViSR3tRjzOTDvgqtZuBbzJJ4SeE2C0CqaSwoO9oVEo6bNGBKz9xxz2qmOLSA4ddmjXTzUBCSAYztXgC/jp/mqHTOj+/kcJYdzBnXJ7F4GR+Lpcgt7PzQtLT+EnmWxbfvKtPW/y+exrI49jPTZbIahJXKJpkeLj6QCerd0S0gKIbP9UiGOvdeomK8w96ka+wjw1OzGR3WNJ0dBJCig5DWA5KEpPrndgIv+M1uQk9ySSty7U13lqKkDJzHw1cA1zeEqAcn4uk8tIY5FilFpt1kT0I0p4AMCAvGvjfGyZ3BzVmOmUTN3xjqyc+IwF/ED7EyLd2pYoLBgKA8D9OhbRYNaw+zv1zLqQetzcnZ9jjSIhw9GL9TDiERMihDZNmE/cKeUCrwoE3SunazEpqF1kKuGosxrGlnqcAVx/Qm58xKfrAkJG9l512L9NqzxO20sNH+Q1Z5/G/H8d8HbBHSZ3RakYK8xacnM2e1J1uGSYi9afViAZkg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39850400004)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(7416002)(2906002)(5660300002)(83380400001)(6512007)(2616005)(6506007)(6666004)(26005)(478600001)(6486002)(41300700001)(36756003)(44832011)(6916009)(54906003)(66476007)(66556008)(66946007)(316002)(8676002)(8936002)(4326008)(86362001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mrOHwdJqJtOaczQklQ9wozP9Rxcjvl6gANjtkuH/X0r67fxD9PomQWy8EnvK?=
 =?us-ascii?Q?n72TjxZXuSiTdNtAiavYD4R8y4yK4BgccI+UxSDn0tPC4Gqd+wm442sxykyP?=
 =?us-ascii?Q?aQeoD3Cin8pehTgtFf+BzcNhSdjMH8hrjOEoWA3o28/fd54yJDo/UZxEzxW5?=
 =?us-ascii?Q?3/z/IBxtqhc0nwQUK6Bh+DeQdr9azzz3/zhldk/qLTwwwGKgsM8hdH7c0RGD?=
 =?us-ascii?Q?dQvhopB0a83cTQGGFumO1AyVzUOShKvusJlxuGoAsOWUMp/FsSY51KpyiH0E?=
 =?us-ascii?Q?EAoGUZUtfyJ1cKaKe/9FhKkhjQBb4IP+2UnH00dZ7ilsjC34ToL39CgEuWjT?=
 =?us-ascii?Q?B5fFgn5DoT54K8/IO5ax1XlmpjgT+kFCOg0+UyJ3hEMFjLoEgvh/wXpteOXv?=
 =?us-ascii?Q?TOHNtS3Rik2p4QMCumWvJxoAdLO4t8zm2ugEzwEh4hU/07/cxgur4w8sVVr0?=
 =?us-ascii?Q?/AP1X7iecEQGq7I+JvNtCsxYcdfbTdnIMNvU0ud5OV5WTftb1gLLJ+bbJqjY?=
 =?us-ascii?Q?N4VorwlgxCfnjvML94RM57BtuEqI+RkALpHc0UtlPhXDuJQ3+soXO+jdAPgV?=
 =?us-ascii?Q?QlDLfkDuYRvwK6SK/Il/9kqYkv5muZM5DDR11983Pwc4Em+eKo7ENJZ2iJz6?=
 =?us-ascii?Q?yiBvHq1tbSK8Mloxhj4zpt7n0TccEvfwYvmb4Lfqnr+lle8K2Hbfw9SeXmfX?=
 =?us-ascii?Q?9gFLwGqyzZpzRMjLu7xHZgON6VZKgHFslBhFMxuD8MAHYb8viVp6dVzANBdO?=
 =?us-ascii?Q?PBEtYmXNVdqXzAGlleT8nmhIupCmdmq34kuqOPzgEChj6BqD9TJLj6sLhVv4?=
 =?us-ascii?Q?0V8cFl4EOlmMekq2HVOgjTwrOsA6oQdE8Gm7MV38EnvFj+3f2WB65kNClMSW?=
 =?us-ascii?Q?QOQpqMgBI7ofKBKGpnq5TWGOb9Rj3dR23zYeZEW6qAcldGp06qA6mW8dCNH0?=
 =?us-ascii?Q?/sNSlVqrwBfbeI5t+9PTYLpSF25AI1OPdLnb0kB5P4MhiED5Fy4CZwkS+8U2?=
 =?us-ascii?Q?6aIb/j0WnnDYoGAPgmlHspsRF8glOKoOg6KoC4Qtiyo5BVc4tjXNSVLZcX12?=
 =?us-ascii?Q?eDOxpCe5DRKVWhq4YfIzmX0ZhsDDBYZfTAjrbuAekfYWmWhGlge9zN26cCc2?=
 =?us-ascii?Q?gbHR/UVa6vYcASli3fJiAyfIcd2PmLcdI23PkIE9GPmib6CQpkSSqPuPGKe/?=
 =?us-ascii?Q?gcy4/+OeAtocKsjmE2X7sKZ7uMFLbmt4KWqIMyHsypSkiIbgxc/Nq21aZfe8?=
 =?us-ascii?Q?P37ql+CCRNRxn1AYVjBXCQwNbTCIFNkE0RTBqISV7n/XraIejPqoYMKqKaez?=
 =?us-ascii?Q?7AhbcfsSFqq4NDzzParA+GOZYqiIMa9WhFnQCKhmOFQySRy/s6KoU8oE9zcA?=
 =?us-ascii?Q?MRGRK0w5Hi+whSAqmpk7u5rS6irWGfKkOpHV2skPvxfYhmOE8qv60O8O9y0Q?=
 =?us-ascii?Q?m/zJcPca3DkWHowur1jEOMapmQMzcHQdKyGEv3ORsRGYFnN4HLNnEbbrcLGP?=
 =?us-ascii?Q?ukqnZeTpwzof8MFkwx8oYGfkt68x9uThPXtaj6570tFpgufIUhXoGKCJWOZv?=
 =?us-ascii?Q?12zGtwp0FGbMzZ6+KMgNS2dFzYZCE0DqWO2ZXBr8d2T6iOBHS9DDHbyUzaOB?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b129dae2-e394-424d-650c-08dbf5a12dc0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 14:48:01.1462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TH1K+qmAD0Hr/W1uUa15Z6E9IqmE9j6KT+ca0TYuNPGYVS6wG1VyRMl1hjD9eJmW7EkjcIvQP/Bg4mWyK9OAVQ5LoQTohj9jx0tc6s/wCQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB5873

On Tue, Dec 05, 2023 at 05:01:51PM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> > On Mon, Dec 04, 2023 at 04:19:02PM +0800, Huang, Ying wrote:
> >> Gregory Price <gregory.price@memverge.com> writes:
> >> 
> >> > If the structure is built as a matrix of (cpu_node,mem_nodes),
> >> > the you can also optimize based on the node the task is running on.
> >> 
> >> The matrix stuff makes the situation complex.  If people do need
> >> something like that, they can just use set_memorypolicy2() with user
> >> specified weights.  I still believe that "make simple stuff simple, and
> >> complex stuff possible".
> >> 
> >
> > I don't think it's particularly complex, since we already have a
> > distance matrix for numa nodes:
> >
> > available: 2 nodes (0-1)
> > ... snip ...
> > node distances:
> > node   0   1
> >   0:  10  21
> >   1:  21  10
> >
> > This would follow the same thing, just adjustable for bandwidth.
> 
> We add complexity for requirement. Not there's something similar
> already.
> 
> > I personally find the (src,dst) matrix very important for flexibility.
> 
> With set_memorypolicy2(), I think we have the needed flexibility for
> users needs the complexity.
> 
> > But if there is particular pushback against it, having a one dimensional
> > array is better than not having it, so I will take what I can get.
> 
> TBH, I don't think that we really need that.  Especially given we will
> have set_memorypolicy2().
>

From a complexity standpoint, it is exactly as complex as the hardware
configuration itself:  each socket has a different view of the memory
topology. If you have a non-homogeneous memory configuration (e.g. a 
different number of CXL expanders on one socket thant he other), a flat
array of weights has no way of capturing this hardware configuration.

That makes the feature significantly less useful. In fact, it makes the
feature equivalent to set_mempolicy2 - except that weights could be
changed at runtime from outside a process.


A matrix resolves one very specific use case: task migration


set_mempolicy2 is not sufficient to solve this.  There is presently no
way for an external task to change the mempolicy of an existing task.
That means a task must become "migration aware" to use weighting in the
context of containers where migrations are likely.

Two things to consider: A task...
   a) has no way of knowing a migration occured
   b) may not have visibility of numa nodes outside its cpusets prior to
      a migration - making it unlikely/not possible for them to set
      weights correctly in the event a migration occurs.

If a server with 2 sockets is set up non-homogeneously (different amount
of CXL memory expanders on each socket), then the effective bandwidth
distribution between sockets will be different.

If a container is migrated between sockets in this situation, then tasks
with manually set weights, or if global weights are a single array, will
have poor memory distributions in relation to the new view of the system.

Requiring the global settings to be an array basically requires global
weights to be sub-optimal for any use cases that is not explicitly a
single workload that consumes all the cores on the system.

If the system provides a matrix, then the global settings can be optimal
and re-weighting in response to migration happens cleanly and transparently.

~Gregory

