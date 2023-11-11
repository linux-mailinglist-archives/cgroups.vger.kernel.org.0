Return-Path: <cgroups+bounces-333-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 221F17E88FA
	for <lists+cgroups@lfdr.de>; Sat, 11 Nov 2023 04:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F8B1C20A16
	for <lists+cgroups@lfdr.de>; Sat, 11 Nov 2023 03:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9F063B6;
	Sat, 11 Nov 2023 03:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="kYJ28GhG"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F298363AD;
	Sat, 11 Nov 2023 03:42:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109AC2D7F;
	Fri, 10 Nov 2023 19:42:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf6alVANJXdLEsEEb8kRyvZ7ULc5HfqSSYe6sLHwYbQvuXnRjDIToV2S0x3F3Manq5IDCiOz6ZQZ7U/J6bRpxqg4+731ktFyKfDAPwwN0hk/bZXQnIArIAWs3nRxaV6nt6zxCxid+I8o/zIKobbVY4FoOxjkY2fJ/xbv7UKxdB1PMpnWI50uuh55/U5Zg1MrpyQUx5WlY9V0T6pYOWMlFft5wUH/5Sbo2DMloW75ZfCtxw8e57i7U1Nr5mPWh/rvDOykjXXp8znHxTM8f5qM6748n+hYVFqzFQX9LzzidbNMTIjMIvxa4b+vSPfNSYsqg52qkACYv5UtGFonePaBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8XeemSD0Xopewp6PWXP4tKn2THwcFqfu/JBi2l7FJA=;
 b=nmIVPTD2Ts1Y8fhfoxcEciMpKg7V14i/HhpPdsE5rYo3LEkGVuXrKuSab4SvoR8dXSFErO2QRihVxIGCGOtPwasAQ2inPKlDcxBCvI/nTQmXNG6BMGc+qhzof1P2myrDoSuGr9nGKJQps/C/gE4ufyswr+IWGEqa8Td2xRxfh3DGfWDYpUqXT27xwdFVSDrAgL6RIOYXlPKccLuKUAF/EiK14IjN/UqoiD2UJAnVbl0IcXwogQwBKsZdZ0Zeb1b4LfcF5NmuAVwTeHDfxJSufjLgWvBHSrPBeVj72lVvlRbRiJJFF9jYZnoIU+pBq71DEkG1ipEM8DRGhGsBjkreXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8XeemSD0Xopewp6PWXP4tKn2THwcFqfu/JBi2l7FJA=;
 b=kYJ28GhGuWz54jBQdTl/EeCESLL8EOeWrnmOaLcw6tXCDEFuzwm2kUeCOvn6qe7H0NDq+Cf583cL/thpW+JwNso8wLOps3Rfd8EaexdOGVoWzdbaJyRT3chQ2Ux5aPucUBGc+YHxoNRGtcesVXQoFajA2wmiok1EAfd5w02GnzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CH0PR17MB6967.namprd17.prod.outlook.com (2603:10b6:610:191::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.8; Sat, 11 Nov
 2023 03:42:49 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7002.010; Sat, 11 Nov 2023
 03:42:48 +0000
Date: Fri, 10 Nov 2023 22:42:39 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "tj@kernel.org" <tj@kernel.org>
Cc: John Groves <john@jagalactic.com>,
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
Message-ID: <ZU74L9oxWOoTTfpM@memverge.com>
References: <20231109002517.106829-1-gregory.price@memverge.com>
 <klhcqksrg7uvdrf6hoi5tegifycjltz2kx2d62hapmw3ulr7oa@woibsnrpgox4>
 <0100018bb64636ef-9daaf0c0-813c-4209-94e4-96ba6854f554-000000@email.amazonses.com>
 <ZU6pR46kiuzPricM@slm.duckdns.org>
 <ZU6uxSrj75EiXise@memverge.com>
 <ZU7vjsSkGbRLza-K@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU7vjsSkGbRLza-K@slm.duckdns.org>
X-ClientProxiedBy: SJ0PR13CA0116.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::31) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CH0PR17MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb26cec-4b15-4c84-2e1f-08dbe268460a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AWtUrFHt4zt9ST4FWeAWeswMW5KIJ7Fy8cLaYeSj4fZmyl0FYdLn2C+eUMDLYWPmoXck4Hyw1QhcyAkUwykeSmxmbHkiLa0bJurwkBjvEcrYn4GVYLfGCZzujZ8HxuoifObEw0h/l42SaL4QoeMDSZCtAyenuocMz6lczipEyZV8zJtuWq290F9Cwq8aggM4Y2Eq2S9+i3+sSc3eqZ0KPMOMuwpY9Fcv8MyW2znu7cz3orQxUIE3CFy6AoLVjluEh63OMzZ21zJNT6guFmIea8cGpWeJ+meL1hjNrNpF0BZXdSqvHVKeadCGCdXbTv6AWTja6SLNYRcO4TX5Y25KGWiobcBgdyB0DN+vIgEUdUrG8sg1vYGVH5mDYYOiGBiGVxonCV2GPeh+4X/rNZCQn/GUXfoZjpeavz5GjbGOgLUfG8m0S7ZMGO0jqG+RrQA4cJstc0AodgVM9U4ln2kMpmJ4BfqLxJBB7PMaHovFvBtOmzmRX8w8ZAhsdGu9xVy10mXVr3XS5wiltXFpqDwHCyX+JXCSJtqHJldGj9bT3dLrdSH5q4DaDZaybrN+QaCs5ThPQo6Me5lAZzT5u8ZqOmR5M38nSVc9n+0qONBubBm8LeMYhIJ5+Q5n17XaQrTBBVIC7329zIy977Av3QzLA9VbQRUNOfOgodLO11cyqg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39840400004)(346002)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(478600001)(6506007)(36756003)(38100700002)(83380400001)(26005)(41300700001)(6486002)(2616005)(2906002)(6666004)(7416002)(44832011)(5660300002)(54906003)(86362001)(6512007)(8936002)(316002)(66946007)(66556008)(66476007)(4326008)(8676002)(6916009)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hHZFImJA5/HfjX3hXAewTnXqtFK4s3/snfgbi6Fi7IKNI+yoshvgqU/pMSAu?=
 =?us-ascii?Q?1WP2W94bsHvsW9MlCJqhSxe9lu5yZ9AmGLRxJYkXZsDpbA/Py4m6kgXoWQnE?=
 =?us-ascii?Q?DsZ8o4sLCxkukjfFquyi+vgDYMif5xjQCMlHEqAZ4SlWpPCc7bRxcNNxpJ6d?=
 =?us-ascii?Q?giA8tO9TeVvQkP9RHhajdPtHDm/HeOKndswsAiwAteZ9IBgRhhph2VdbncIu?=
 =?us-ascii?Q?wwoONBtf9/yxk/NvNefPD+jSVMzBNoNfghw6w5yVCs2jlgSBltmM3DCCRqrY?=
 =?us-ascii?Q?gEK4XmEyi+QIagj1yqWzu/sliA+nv/4XokVsVcC2IKLhWkd3mFDnRiiUdj9d?=
 =?us-ascii?Q?OWPILSX7q81C2XT2gCj6BoXPeE8C2aciZBoORTtn9n8nBmS9XGDVOQ6GkitQ?=
 =?us-ascii?Q?3wSzGVDeI7gDc5anIXKkzrOBhVGAwqNT6Pb1K/30Dh53ztwPumLA+/c9aJYC?=
 =?us-ascii?Q?AsxNuswChiUXFVsZeaXZzAlypWmXVl0XlshzalBoj0fgAYdr5tNqMNGndrD3?=
 =?us-ascii?Q?r4bA9kuqqvaogbzC/a3UB5he1iKbfEHqIcUX7YFMVykN3zmppi/2/sfyIFzW?=
 =?us-ascii?Q?1G3sTZ8kBbhAObpT6D3dGQfmQS+tdjzgeN4ottbUPjGH16aZ6lRcMIlL+Rde?=
 =?us-ascii?Q?RVY5ZNO+dDeY6grqf4Puu1p2nJSZshMYc1H6/Sat/sJUUoai93sb+68joJB8?=
 =?us-ascii?Q?EJXywm9zs6cFTvyk/R3Ibd/dUTe4xi6NtIAKL7URFG12SIibK/3v2tPfBqGx?=
 =?us-ascii?Q?ykAZoKbxCB3/VVNViMMq0V8K50ebDSBrPq+ts0bJErMGjGb702w4Jv04/5RE?=
 =?us-ascii?Q?0KpYkydzQ9vKxe5lj9bKCMqHtyMWtqBYaUk46lQgaz3lWXjNUcCV9ctXok86?=
 =?us-ascii?Q?MSb3JBwbs2MSTocet3vu0ea22AWk/dfm7Yu5EnxDaQOl4LizwiCwQ1MH8Eto?=
 =?us-ascii?Q?S3YFkkEaenjI/7OehdPy9LCkk+ovD41+nvr0z02oftYvcsoPmJl1ibq2wd+U?=
 =?us-ascii?Q?Em9wFBeH6yBOM6tEotaEekMGJzUAp6viSczR9jtURFZhQRpChQ5c4L5fCxyy?=
 =?us-ascii?Q?ZX92upifPgYGNveFx/0wtmM4Ih8XZtM9YGzDfMITh0fBnUaIaDN0k+AfLU8y?=
 =?us-ascii?Q?Plfw00Qa2HGZmXYc2GlrLY5sD/pd2MlPOfjQuV8PyHtfUwSNHM8lCwQkFApv?=
 =?us-ascii?Q?umVs7rSooECQCmUWLx802+qlHjYlWKJPZPbo8ZeGLLhLJ27IQLcvZtVaGbdU?=
 =?us-ascii?Q?UUgv0S69/iKyJWjyrpZSGqDRTgcqatjPBeikJswqYXZ8LDF0iLdeOqtQxmJw?=
 =?us-ascii?Q?Z0BPOcR9KJ+pn1ZTxrLUFlkPQanuD0uhjgRtXMlT8YDh6htfM2eEeGzpdMds?=
 =?us-ascii?Q?/KFH71aGr+T6nFXkkwS2CQqe0rB42wibk90LZpHGK7CDz5cUOGZnDC4WUu+d?=
 =?us-ascii?Q?BLI/Ka9DZ27tfSQkH0SYZZjLTMWGL3laZVdn0sAy2+IGwhbmTrQ5V/FrESlS?=
 =?us-ascii?Q?ebHUW6ZDUUeCq6WFTV/pjv9BZBT3miOUZklU0s5zWWo3ks1LAM4Y0tEwn63t?=
 =?us-ascii?Q?+Z1obcCGlegC6zg3+6oT3xGs5rkCU9agcWOuGJRBTKgXqC5EclZTMJ7rzhlQ?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb26cec-4b15-4c84-2e1f-08dbe268460a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2023 03:42:48.3937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mg/ShboQwPM2PNXZdmuRNxx8ukYnlenK5q/v8IOmOgBbY+G9EGs0Oh1u2IPAsbxhJAC+xTU7IrivnAD+O8AutDUME38MVxhh4YptnQYC36w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR17MB6967

On Fri, Nov 10, 2023 at 05:05:50PM -1000, tj@kernel.org wrote:
> Hello, Gregory.
> 
> On Fri, Nov 10, 2023 at 05:29:25PM -0500, Gregory Price wrote:
> > Unfortunately mpol has no way of being changed from outside the task
> > itself once it's applied, other than changing its nodemasks via cpusets.
> 
> Maybe it's time to add one?
> 

I've been considering this as well, but there's more context here being
lost.  It's not just about being able to toggle the policy of a single
task, or related tasks, but actually in support of a more global data
interleaving strategy that makes use of bandwidth more effectively as
we begin to memory expansion and bandwidth expansion occur on the
PCIE/CXL bus.

If the memory landscape of a system changes, for example due to a
hotplug event, you actually want to change the behavior of *every* task
that is using interleaving.  The fundamental bandwidth distribution of
the entire system changed, so the behavior of every task using that
memory should change with it.

We've explored adding weights to: mempolicy, memory tiers, nodes, memcg,
and now additionally cpusets. In the last email, I'd asked whether it
might actually be worth adding a new mpol component of cgroups to
aggregate these issues, rather than jam them into either component.
I would love your thoughts on that.


> > So one concrete use case: kubernetes might like change cpusets or move
> > tasks from one cgroup to another, or a vm might be migrated from one set
> > of nodes to enother (technically not mutually exclusive here).  Some
> > memory policy settings (like weights) may no longer apply when this
> > happens, so it would be preferable to have a way to change them.
> 
> Neither covers all use cases. As you noted in your mempolicy message, if the
> application wants finer grained control, cgroup interface isn't great. In
> general, any changes which are dynamically initiated by the application
> itself isn't a great fit for cgroup.
> 

It is certainly simple enough to add weights to mempolicy, but there
are limitations.  In particular, mempolicy is extremely `current task`
focused, and significant refactor work would need to be done to allow
external tasks the ability to toggle a target task's mempolicy.

In particular I worry about the potential concurrency issues since
mempolicy can be in the hot allocation path.

(additionally, as you note below, you would have to hit every child
thread separately to make effective changes, since it is per-task).

I'm not opposed to this, but it was suggested to me that maybe there is
a better place to place these weights.  Maybe it can be managed mostly
through RCU, though, so maybe the concern is overblow.

Anyway...

It's certainly my intent to add weights to mempolicy, as that's where
I started. If that is the preferred starting point from the perspective
of the mm community, I will revert to proposing set_mempolicy2 and/or
full on converting mempolicy into a sys/procfs friendly mechanism.

The goal here is to enable mempolicy, or something like it, to acquire
additional flexibility in a heterogeneous memory world, considering how
threads may be migrated, checkpointed/restored, and how use cases like
bandwidth expansion may be insufficiently serviced by something as fine
grained as per-task mempolicies.

> I'm generally pretty awry of adding non-resource group configuration
> interface especially when they don't have counter part in the regular
> per-process/thread API for a few reasons:
> 
> 1. The reason why people try to add those through cgroup somtimes is because
>    it seems easier to add those new features through cgroup, which may be
>    true to some degree, but shortcuts often aren't very conducive to long
>    term maintainability.
>

Concur.  That's why i originally proposed the mempolicy extension, since
I wasn't convinced by global settings, but I've been brought around by
the fact that migrations and hotplug events may want to affect mass
changes across a large number of unrelated tasks.

> 2. As noted above, just having cgroup often excludes a signficant portion of
>    use cases. Not all systems enable cgroups and programatic accesses from
>    target processes / threads are coarse-grained and can be really awakward.
> 
> 3. Cgroup can be convenient when group config change is necessary. However,
>    we really don't want to keep adding kernel interface just for changing
>    configs for a group of threads. For config changes which aren't high
>    frequency, userspace iterating the member processes and applying the
>    changes if possible is usually good enough which usually involves looping
>    until no new process is found. If the looping is problematic, cgroup
>    freezer can be used to atomically stop all member threads to provide
>    atomicity too.
> 

If I can ask, do you think it would be out of line to propose a major
refactor to mempolicy to enable external task's the ability to change a
running task's mempolicy *as well as* a cgroup-wide mempolicy component?

As you've alluded to here, I don't think either mechanism on their own
is sufficient to handle all use cases, but the two combined does seem
sufficient.

I do appreciate the feedback here, thank you.  I think we are getting
to the bottom of how/where such new mempolicy mechanisms should be
implemented.

Gregory:

