Return-Path: <cgroups+bounces-837-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D5880647F
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 03:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F102282224
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 02:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFB153A2;
	Wed,  6 Dec 2023 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="LFBHd9Fu"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C38DBA;
	Tue,  5 Dec 2023 18:02:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNhF87acw9MMvCGnuukYiDqIaibFOSqNXGC9wYSq8C4SfywHlDTpBcIglYGXC0si4WTN1jd0HxUK7EOiUUr5o4mI6cC7LH1V1xnDVj50+z5HZqGdY6GpDWC0ic6G83MeKh9PO+da5B80I/i/B4Hj5CYIbbIkOAWYj07xattp9gZMsG4QdyU32b5K0NprJ6iJoZmG9x2XCyZw832oYIs4hKxgTfwXsnqvYPYjWKWHM8kX3XsQ3pgB1Mp9VkiTDhrouId4d0FMuUb+aCLOfMqgCmgMy/k/eEiOsHNxxWf0O+1lRloom6mIlVKNd1EPtDYddMBOhbWh1yw8aGrTudx5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j+qoLoOzhtEAelUrP6md3EBv44E66c7k5hDa33fkNU=;
 b=NqYHPDbSeMYt25BGlMDjXstGXC6jOWk6PMwK5HmGUND3BcxksUMiVdUJM41cKL16luAzhtxOh3Bj8YQEELFvX4L1dO1L2Pko8YuRncaZMLwOV4btw4K+f0GdA9TEJTgOA4LZBv2vu0M4A7pPIlFveClD0Kqai/t+Tp7zl9pMh+0O8UkS6SP8sIZyxDtxeqoeyMjkVS4erx7rn0BLkNEByBjlzKdqRHgYmBn7bBc8zU43lWs67sIF58Q2ZaFbcI0IkTreO5cClola91IOJK3mB5JZg0LQ5HHuXgA0pP2LNizo06hz26EVKUPJLxhoCEUMvmX763nqitqr7zZeTTKu6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9j+qoLoOzhtEAelUrP6md3EBv44E66c7k5hDa33fkNU=;
 b=LFBHd9Fu2cNLiV/HtOa1AstaeOLUe6/SDtR9ZP3cdMX+McRLZT+j9JbLkTZMsebhKL2RzC2XUiiedvXUY02S1WA+VqlqTKH7GZYDu3qke+xDeL9rWRA6RTTI9xthMcNDJQRA6XXVzhXqsiCXjweNcmG4S+5uYANIbI+p47ccx14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB5529.namprd17.prod.outlook.com (2603:10b6:303:124::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 02:02:00 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 02:02:00 +0000
Date: Tue, 5 Dec 2023 21:01:53 -0500
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
Message-ID: <ZW/WEVbVnEXXCYSM@memverge.com>
References: <ZVOXWx8XNJJNC23A@memverge.com>
 <ZVOn2T_Qg_NTKlB2@tiehlicka>
 <ZVOzMEtDYB4l8qFy@memverge.com>
 <87o7fveeze.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZW1IdPI11nhKcdZl@memverge.com>
 <87sf4i2xe1.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZW3ZFDeTs7xotImL@memverge.com>
 <87fs0h2fb4.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZW84F5PUB/0yPW9d@memverge.com>
 <875y1c2lyo.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y1c2lyo.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::29) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB5529:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d5ac63-5b18-4050-c29d-08dbf5ff5559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1RQK6CH4XINEUNIPL7vp4rrEuC8mMA/iov2ncYxDZr26IudeTdpCPpN1bh4P/gPbFazO6u2cJW50jU7CFr5SwR00iT6X+uVFHv2phavdIT0QirWWoYWjdoggpclY4hVjTdH3xTj+mV6KZ3dpffHI2cFm2PONCdjI6E0AI0mzL8naBiyN16eMXqUdCnFj+2Y/wt0Yn4aIcJvLhJenSzHX3jWF2qzV3CBSyGIJepEHgK9/UUjsm2Ll/bwNHE/oLXCzP/txj/PqFv5CP+rukqiBmoYBdhREEhz5RXE7iuU0we2P0z+/7Nrr8NTVYk19yQqPE5UwNEEBKzejXxGl9homYGf3wy6wlg8sltyydh6+C3uYRagBQ5a1IAL0Qt49UCnCNnVej9MVSN+nixYRaO6Z07TTae63ptTpbVG+iELiPBzecQxJJx1QKEeT0G8IMx9i/OHokZcRwWofe/yTBe5y9GtV7LVvTnCb/vm2TfSc5/luiupuclRstHCLGY+J9RVpjNIdxqR831VUQ4pyJDXNt/z7bzOcMvJsP8FScDfLU2LRHxIkrTPxR/h+Nl+P/RGAZ5blW2iaNd/ZRApZ1YrTz77sKYrjR7uelH2M0kiOkgQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(39850400004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(8936002)(83380400001)(4326008)(8676002)(38100700002)(36756003)(86362001)(41300700001)(2906002)(44832011)(7416002)(5660300002)(6506007)(6666004)(6486002)(26005)(478600001)(6512007)(2616005)(6916009)(66946007)(66556008)(54906003)(66476007)(316002)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rivkT0UnoVtKlVDkNIkGsqY0SyIJwOtFHhpNug/Hk9dJacCfp4aDELQXQ2Cu?=
 =?us-ascii?Q?OWPje0eapyQ6/VBTR2mdoOcg+U8tJfVlqIL99r8ySDyND0oVsepAE4dHNwHK?=
 =?us-ascii?Q?picun6x5DQe45HJcXkSe7S9LWSjupV9gDtJ8s1+bOjo1jyPDRMuNvxco0a2w?=
 =?us-ascii?Q?BWAqE7PyfFsc0zoQPFdEP4Mv9zdRKpCDHOW4qEHOxGSjaePxy2YlldhrlEJp?=
 =?us-ascii?Q?XTSheCVEj7yrM+JRXzocv245gFFDQNk9RK5gd14SgwsiGjVAv677doRgHLM5?=
 =?us-ascii?Q?l1hsaFk/KV8MmnaBOqpxYNtxfMJG4BHDoAC5uTlfgYGCsMAPLSqRofTYMe6C?=
 =?us-ascii?Q?pYESnUyq5aFtG60ph1piwpUapYnzbMB2hfQEqhYSRPlge8jlonrqLrRKkRgn?=
 =?us-ascii?Q?YEDb1Htyo1xDrSoWqZxAsoHzdisBhFmVfQyWC6duMsrgTdhlq9QB28hNlY20?=
 =?us-ascii?Q?EH4LB82S+23mJ0zZTplheANgJJrKHIqpMpeWvXEWgOL2HqkaP6eyodqGfFuj?=
 =?us-ascii?Q?3FIlNAuQmoXCbNzJGoggjrq5VoYe2n4cKdLDYRTbXFRY8H3gUeGfh+Z/vAjm?=
 =?us-ascii?Q?DyFEPlkA8Rm3v0m7tydnlff73fSSBXJXjzD+8i4sIuTH7BwDD+U8aQBtCEnd?=
 =?us-ascii?Q?yOMi9NfpvmNOJEuK5KHXgmrjfhZShquS4bbdMxDuCULjzn0dCoZxE0a5U0VW?=
 =?us-ascii?Q?sCauVGVhuJcfjidSBoOS/9Pa4/Sba0XywuOEgwp+wQbeVWmFYhqVHNh+7kBk?=
 =?us-ascii?Q?nFlH5N1AbK6mzhUm1uVZaQBuo/hvU8V6EGCWJ9AvBQGeWNeg6jjiBv9NPO1o?=
 =?us-ascii?Q?zcrVshTkb0Ep/pWGf/cMrAPB2AIkv+JvHYQ73bybmSItodKkfl6yL0St0q60?=
 =?us-ascii?Q?eY/PHanp6Sd/O3+o7p6MnIcfoQ2tUPwztBQ2cYY4w2KLtIRpJlxsay/ukJX3?=
 =?us-ascii?Q?mp64ILFYhMojeR9yDgDg8Vc+P1D6SAUKRnAIpVPtD1PUs3czyRUyEYLz0Ajq?=
 =?us-ascii?Q?r6YOHlN/Dtgw7WR1fXB+b9nnWA9YV0bhXLszr7EGSmlsTFP9CouoBQsPxOtT?=
 =?us-ascii?Q?KJKXxerZeyNY3sltR/Hb4qNuGH68lvQuEJ6D2d1MIsx2DLsrzri0SFX5YrlI?=
 =?us-ascii?Q?NE/iVlLpdfNF5GSo1pvpNqsf3UrmCsZPCe5si9a4hPMHT1iAOZfe1BT0hwyE?=
 =?us-ascii?Q?Cfh54WdMUA/qMiwZIz/a3f3fvaz4m5mNZkQl1RmfF12gDGScJRe7Gjk9Vhl+?=
 =?us-ascii?Q?oW4tFE6Q6ep0+o4hTZSZFYO83b0H+Hg0Ugc68F8uJwE6+A+/snVKMfq4VJDl?=
 =?us-ascii?Q?uj/0KuBaAVexhVj3GDAt2m3iGjcDBZ/JCWANO/3Z3b6EtmkAF65OGIsUHWOl?=
 =?us-ascii?Q?aph7vnvPwyX+sduqtRVGk4K1exZfyZ7cch4N+p0T93PvkxqfkGuohsP/Uia3?=
 =?us-ascii?Q?wxhvJDSPEqKSXEk+Z66XwfHhjwpJ/ikQ5CyPkbspfNkw/THVPT9Z0O8YLPEd?=
 =?us-ascii?Q?PDRyyUOQUJQbo4OOo8j1hZEQY3Pm6myZ3WFhTMhxw33mOtC/CacdOGkhYRMl?=
 =?us-ascii?Q?a74X6G9dSABmSDr6ZQ0AKTr+qmFMZyGLs6pPRFZOCZUzMoub0N+2QEhyTZkY?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d5ac63-5b18-4050-c29d-08dbf5ff5559
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 02:02:00.3039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SuL5rFCdRvqI1fZfeJ/LwJrVI1wu8hGKZrlg4WovHCI1ycW5/YEWHf2O+tA4OABvk6xhL/7DtXH5iIMHmAQmf6JU2XTqRlsotWcW9+5RBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB5529

On Wed, Dec 06, 2023 at 08:50:23AM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> >
> > From a complexity standpoint, it is exactly as complex as the hardware
> > configuration itself:  each socket has a different view of the memory
> > topology. If you have a non-homogeneous memory configuration (e.g. a 
> > different number of CXL expanders on one socket thant he other), a flat
> > array of weights has no way of capturing this hardware configuration.
> 
> One important task of the software is to hide the complexity of hardware
> from the users.  At least it should provide the option.  It only add
> complexity based on real requirements.
> 

The global weights are intended to help adminstrators hide that
complexity from actual end-users.

The administrator of a system should already be aware of the hardware
configuration, however to hide this complexity a system service can 
be made which auto-configures these weights at system-bringup and on
memory-device hostplug to simplify and hide the complexity even further.

A system service can use ACPI HMAT (ACPI Heterogeneous Memory Attribute
Table) information to automatically set the global weight information at
boot time and/or on hotplug. Such extensions have already been proposed
in prior RFCs and on the cxl mailing list.



To break this down a little more explicitly into 6 example use-cases,
lets consider the potential ways in which weighted interleave may be
set via set_mempolicy or set_mempolicy2().

1. Actual end-user software calls it directly (or through libnuma)
   a) they can call set_mempolicy() without task-weights and accept the
      administrator configured global weights
   b) they can call set_mempolicy2() with task-weights and use task-local
      defined weighting
2. Actual end-user uses `numactl -w[weights] --interleave ...`
   a) if weights are not defined, use global weights
   b) if weights are defined, use task-local weights
3. Administrator / Orchestrator opts user-software into weighted
   interleave by wrapping their software into `numactl -w --interleave`
   a) if weights are not defined, use global weights
   b) if weights are not defined, use task-local weights

The most common use case is likely to be (3a) - an administrator opting
a user-workload into weighted-interleave via `numactl -w --interleave`
or an orchestrator such as kubernetes doing something similar on
pod/container dispatching.



In all cases where the user does not define weights, they are trusting
the administrator (or system-daemon) set weights to provide the optimal
distribution, removing the complexity of understanding the hardware
environment from the end-user.



In all cases where the user does define weights, they are accepting the
complexity of understanding the hardware environment.



On the topic of the ACTUAL complexity of system hardware that is being
hidden, we must consider a non-homogeneous bandwidth environment. The
simplest form is an off the shelf Intel 2-socket server with CXL memory
expander.

Lets Consider a 2 socket system with the following configuration::

DRAM on Socket0:  300GB/s local DRAM bandwidth  (node 0)
DRAM on Socket1:  300GB/s local DRAM bandwidth  (node 1)
CXL on socket0:   128GB/s bandwidth             (node 2)
CXL on socket1:   128GB/s bandwidth             (node 3)

A single linear array of weights is not sufficient to capture the
complexities of bandwidth distributions on this system, because
of the presence of a UPI link between socket0 and socket1, which
changes the bandwidth distribution depending on where a task runs.

For example, 3 links of UPI is 62.4GB/s full-duplex.

From the perspective of socket 0, the following is true:

Bandwidth to Socket0 DRAM:  300GB/s    (node 0)
Bandwidth to Socket0 CXL:   100GB/s    (node 2)
Aggregate bandwidth to nodes (1,3):  62.4GB/s

From the perspective of socket 1, this changes to:
Bandwidth to Socket0 DRAM:  300GB/s    (node 1)
Bandwidth to Socket0 CXL:   100GB/s    (node 3)
Aggregate bandwidth to nodes (0,2):  62.4GB/s

With a single linear array of weights that apply to the entire system,
you cannot represent this configuration.  And in fact, a single
configuration of weights will always provide a sub-optimal distribution.

The goal of simplicity defeats the entire goal of weighted interleave in
a heterogeneous environment.

> 
> For these complex requirements, we will have process_set_mempolicy2().
> I think that it's even more flexible than the global matrix.
>

process_set_mempolicy2() has a *very* long road to exist. The problem of
mempolicy reference counting is non-trivial, and the plumbing requires
changes to no less than 4 subsystems.

Beyond that, the complexity of actually using process_set_mempolicy2()
is the same as any situation in which set_mempolicy2() with task-local
weights set:  The absolute highest.

The global weighting matrix actually hides this complexity entirely.

> --
> Best Regards,
> Huang, Ying

