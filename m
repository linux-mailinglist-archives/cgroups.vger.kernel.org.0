Return-Path: <cgroups+bounces-285-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C6A7E6EEB
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 17:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79321C20A20
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 16:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1FFD27A;
	Thu,  9 Nov 2023 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="fXWmqWmc"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD8020312;
	Thu,  9 Nov 2023 16:34:14 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C22D3ABE;
	Thu,  9 Nov 2023 08:34:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0AWj8IywtnqYi210/Lgu5Ih7PjQ+9Zvf85BgppYryrkV07d2ioZ5eykVD/Rf3jXyGSW+xvjdHX7rZpAy5/Oj6QNN2cfAHkLOc7n+yPmG5sNQvNDv01jPLsd02ap2bPrUl353+hNH99QXp4E/fY0IYnqhGTA92NYuEjQFEHI3mSFN+utIGxtYWF9bZ1WWFVsr0wlsIYLhjh8yhwL8dvOy0vmcEwm3KXHk0kuJ3zbfWuU+h8f/0rMuivyTzv9xEuAWnL3+ygFkCjbG56dnkSNenmg6buSqdWzvSTCZNlmO7jo+ObAxwuj9alUT2J1GczwIdaS9OStH47ocwOEZpvtvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpzJDiABML0l+uTHZ1iTmSb+gYDET6H197+zrHl3658=;
 b=Z2PpkQxuWzni2e87qRwv06NyFeUaM6m8LHEVwkVKay7lSl2kfcJ/shidgvmN30bQOBUHGwDb3sV4uYW7rxXIscmeTi0te3iyUnYkvRFs04jvk5Tg0I4znnj8riNEXF8OqYLgdANEaRy4jdWQSkb8pGKzGgDEunZVyFTbFN03cz/AcQJ9pxGd3fTLFxzkmgBr4UHOSf6K9/gfUm31gHM8TSzQF8jPBxkKJ9gyJM2NvzjmvO0vtdzFm9cUR32/d+1VxInliTVO7Se145xCRtr/Sho+no/6QNK0M5wRm2MrrusZz5sGr5dD2vc7clnpLknEXe7PytuEJE4EIbn0VaHyKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpzJDiABML0l+uTHZ1iTmSb+gYDET6H197+zrHl3658=;
 b=fXWmqWmc/DEI70hZFaSEUpzviO1x/PebL5RcX7F4pWyUmWQJTTD32MnhBq0CZvkTGxnDXFwIKWCP2jc9eSlLWqgDNC9FKBxO7sFdBcLCz7Wh90y+/e0rv7eV0zAhv2FT85Iufm6XqxZLw69mnq2W8Qx4NN+QEMAz37tE084jLAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CO3PR17MB5856.namprd17.prod.outlook.com (2603:10b6:303:167::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.9; Thu, 9 Nov
 2023 16:34:09 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6954.019; Thu, 9 Nov 2023
 16:34:09 +0000
Date: Thu, 9 Nov 2023 11:34:01 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	ying.huang@intel.com, akpm@linux-foundation.org, tj@kernel.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
	roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Message-ID: <ZU0J+RU1fg8peGJH@memverge.com>
References: <20231109002517.106829-1-gregory.price@memverge.com>
 <ZUyuL9_8PPiEflnS@tiehlicka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUyuL9_8PPiEflnS@tiehlicka>
X-ClientProxiedBy: SJ0PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::20) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CO3PR17MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: 06bbd708-9862-47b4-995c-08dbe141b2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rp7/PlMAoA0mJDRummSV916Hyp7IVEdWiGYBHtq6gork0Rd0OzursKBqO3B+tofozLWgMVbU2uLj5GEZb7mCqgX7jfZornNsZiAuTH/Rj9rixBq88YZYmrofr60FuYmTyhbCpKAXSzw1ykfGIW/AdTOkXYvwgJhRMZLPTms27BiIvZxn9RE4h6FdYjT29daWeAp8DbHRFN9rpcT9VLTVdjxr0WPAVeSaVFQTmTCnGy4sRUOCt/7OpLhnqqZYDlRF3EzFASuaQuobdCu+0G/PDjnfJ+Hmoy6a4iz4TCZSwNn2nuGOLJp+XQKaL478sVMS4zJvi0kiZWcq1X7Cvlg9oqWHeprSZAT+oRtmkJthABLB7XpBhAtJqDBq+IEBb7WjXk/hwW/fpPUOR0J2xlOp0b1WYyu+grElfFiXRSoC6hJy20AcEiL4PIup8cBjpKRXWFOWivfFY6E1OvCSW335WyNbSwThctUF1MCL1oAdhsPgwQJQtzQHm6lWaAK2BGPYtTnntmR0weEE0QkQPemRHGz18ArSDSDz2YCakjl1jMRjHWTiWve+Qy/JhplQ6wnSWuM4y3k074nXz/ikL80SOmXrbmiUT6x2hKWjV3TekGB6w24yqKVMqVmfLby/tUsjc6sVFupU2l8twbJPWXEemg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(36756003)(83380400001)(8936002)(26005)(316002)(6916009)(66946007)(66476007)(66556008)(2906002)(7416002)(4326008)(5660300002)(8676002)(44832011)(478600001)(6486002)(6666004)(6506007)(2616005)(6512007)(86362001)(38100700002)(41300700001)(16393002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vs9NZx5cgJydlPnVCJfKPnGhVpgCehDKAYiU7EU/uR7NyFLoVJqCywitTxfc?=
 =?us-ascii?Q?ijvEA++TQIcCQZuSEfAJ6tgEcgjykkpfQ/ObdHSVgZVwAtLR+YtBx2nn2DVG?=
 =?us-ascii?Q?CBMwvE5BkV3FcPdirvIi9szw2nfKdJipVe7NIUf5qWi1qC+tKblT8Id0c4uJ?=
 =?us-ascii?Q?uEvGV1/q3R0UWMockffA/epVUIirscSIwb3adLJFfEuywUZIIOoEuL/yXMIX?=
 =?us-ascii?Q?wXsQ3qT43kQxB5k/XAW23V3dLCmUaqz1SR4Bq28nBINRjQ8gtzh44mFpQHPm?=
 =?us-ascii?Q?i/ceLns4QLdY8ImPBsXqVQ+eVJk6Bjvf3TLqDL4r+MDwwabcJs4F06MhgoS+?=
 =?us-ascii?Q?VOP0oh0hRfwEzkyt4RlJ6giDJDFHfDNAI7H5akZnCLn/jfpzA+sXX2WIVxbi?=
 =?us-ascii?Q?rPPylP9XR/oLdDk4izDfGiNzAnCK2E6qFnABuS1pxc8GnJqzryN4/4HbzpaP?=
 =?us-ascii?Q?0l6kVaEpj7fO6AJr6WfpCSd3AAClaEwQ0NwjlmA8qwnnCZQR9s9DAHvccQ6C?=
 =?us-ascii?Q?Eaelr09tRdzqG0SEzeQ+plAahRH4WNidG5wubPx4D3I+JwVsFX7CUxf5SN3T?=
 =?us-ascii?Q?6N1AOkVqLV5PDeqcH+QnmjuWe9dwD/V0zwLoyYZHVQJ6SVbybrxoUElyEd/Y?=
 =?us-ascii?Q?wyFXVGDIpfewqpLPpjMUpGfTA0ktUnyYgDxKEkEc+bysQmUZWbuK+uLbCxkG?=
 =?us-ascii?Q?4X/bzVqmFwmdHCIU84wie/IS20I2pYc9l3dYg8+AypFfiiV5e5Au0I11Ieov?=
 =?us-ascii?Q?zK/ReOuWmkCnXxlKVRaaCVFjsdh+g+UgJfVOuqRkj745cZJNKpxgGWLRdjJ+?=
 =?us-ascii?Q?pQ9k+mVWWvc8jjQrhH2tLu+x0ZLK/XcIwRl2hgQs86HcXBYQOm5I8LxNSaKD?=
 =?us-ascii?Q?Sc6MhfPg5iWr8fYICLyJSZ5gF14L3FBFvvj/9xZhDZE3z99FKBmWiJxyeSez?=
 =?us-ascii?Q?K0dJNWTFKnDkqLiesb1NFEr5jqIoTYYJIyrruJLoBg5UbxJYz8aSb/zHm8BR?=
 =?us-ascii?Q?wiG7m9920Cn787FS5WLp3HJFuhqXhWWp5qHM7mDUNbOKr6mmltnU2yiL+FW0?=
 =?us-ascii?Q?BadGziA1kOEsV6u8hQyNMISb4q814i2gPuyocRqeTCvm31S381hVVsUoBO2k?=
 =?us-ascii?Q?qatsHe2A/vPYOhGjZ9Y1uvnhDUQ3Ed31WEJ8VDB2TTNVrZp8MoJ3c4PbJ29i?=
 =?us-ascii?Q?81CZw86h11064b/VfR6MYkt9MBNYQ1NB1JF+tNnVVsDoxkSJE+At7BEYQGwe?=
 =?us-ascii?Q?eIb286RUjOVV+zW8yl50WqQgfyr8MjuuA460v+mw88d/CqIppC4nkkZFEjVn?=
 =?us-ascii?Q?oQ2uma06tMnkw6KRYIZgcD8LeVGRN4xfLiswE1aRmGK9HZ7sRdVwr6nKsUmh?=
 =?us-ascii?Q?jla4KHADWTdYWL1+p+6kvh1swhuWDhSy9xcx638exMZ89W9sk6nhxNeC7zXm?=
 =?us-ascii?Q?jSeSH8wiAo0c4nkdeSqXX4iCCBMBsKWPsqg5CP8WDgL1qYN6rCq9m9Ugo4T5?=
 =?us-ascii?Q?0TBSvw7EA1tLSm+hOtx7wJeOUUDLiOtaGwtxkais0Pcr8Oooayfjn79QbN18?=
 =?us-ascii?Q?xcpYUhLEduoqCCj7AYXSsG7K+ULS3HUN/CNnlDevMPaSBB2fCFItd/AnzMlY?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06bbd708-9862-47b4-995c-08dbe141b2cd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 16:34:09.3710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtwkTM3FZyHRMa3jh4Vge0RMDunOKAQdGEXSkrB7SQIkSrmWR3ilON8/qY9WnXFY98yhc5BYv2t6UFaMsNB+xWEtTBReeP4oLMwNAu3wzAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR17MB5856

On Thu, Nov 09, 2023 at 11:02:23AM +0100, Michal Hocko wrote:
> On Wed 08-11-23 19:25:14, Gregory Price wrote:
> > This patchset implements weighted interleave and adds a new cgroup
> > sysfs entry: cgroup/memory.interleave_weights (excluded from root).
> 
> Why have you chosen memory controler rather than cpuset controller?
> TBH I do not think memcg is the best fit because traditionally memcg
> accounts consumption rather than memory placement. This means that the
> memory is already allocated when it is charged for a memcg. On the other
> hand cpuset controller is the one to control the allocation placement so
> it would seem a better fit.
> -- 
> Michal Hocko
> SUSE Labs

Actually going to walk back my last email, memcg actually feels more
correct than cpuset, if only because of what the admin-guide says:

"""
The "memory" controller regulates distribution of memory. [... snip ...]

While not completely water-tight, all major memory usages by a given
cgroup are tracked so that the total memory consumption can be accounted
and controlled to a reasonable extent.
"""

'And controlled to a reasonable extent' seems to fit the description of
this mechanism better than the cpuset description:

"""
The "cpuset" controller provides a mechanism for constraining the CPU and
memory node placement of tasks to only the resources specified in the
cpuset interface files in a task's current cgroup.
"""

This is not a constraining interface... it's "more of a suggestion". In
particular, anything not using interleave doesn't even care about these
weights at all.

The distribution is only enforced for allocation, it does not cause
migrations... thought that would be a neat idea. This is explicitly
why the interface does not allow a weight of 0 (the not should be
omitted from the policy nodemask or cpuset instead).

Even if this were designed to enforce a particular distribution of
memory, I'm not certain that would belong in cpusets either - but I
suppose that is a separate discussion.  It's possible this array of
weights could be used to do both, but it seems (at least on the surface)
that making this a hard control is an excellent way to induce OOMs where
you may not want them.


Anyway, summarizing:  After a bit of reading, this does seem to map
better to the "accounting consumption" subsystem than the "constrain"
subsystem. However, if you think it's better suited for cpuset, I'm
happy to push in that direction.

~Gregory

