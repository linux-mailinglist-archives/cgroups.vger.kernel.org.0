Return-Path: <cgroups+bounces-336-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A41B7E8D99
	for <lists+cgroups@lfdr.de>; Sun, 12 Nov 2023 00:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052ED1C2087E
	for <lists+cgroups@lfdr.de>; Sat, 11 Nov 2023 23:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0321DDDE;
	Sat, 11 Nov 2023 23:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LkarHBKi"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A351D524;
	Sat, 11 Nov 2023 23:55:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254733253;
	Sat, 11 Nov 2023 15:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699746903; x=1731282903;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WKeCjC1/ThjiakBH1kr9zJLBngvVOEPZL0FswuxkkwE=;
  b=LkarHBKi56/pRdyhcAeRy6F3ZeFlvKHQqdTLiIHoK4JaxOY+o/2T+3Qy
   euRJOT6wGwQTHpcgtn3+InR6GNfD1feU+/MdMvvJtzYAqdleFeLeUGAWP
   zIBs2aXVehxpdBYMlqQ9gs9/eSeTOk1HXaqtZ0IxyZRf6S43LfdXQ5r2x
   9d1e+YcA1TmLmWjFnk5G8x/VqfU8WX/gfdBk1qhU5QAlRfv6RvX3ZN5BE
   sv+aoX/I6CTkCSe1oQog0nQB59ekVJ1ErK3fIehGpnkTixebdz3zMRo52
   p7lYKasf+Vz4wxjz7APUw8qBpxCJHRjcNQND3NhHP8fQkzkjwLkfoX2KC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="3357243"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="3357243"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 15:55:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="5345744"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Nov 2023 15:55:02 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 15:55:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sat, 11 Nov 2023 15:55:01 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sat, 11 Nov 2023 15:55:01 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sat, 11 Nov 2023 15:55:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QB2WTtRoxJv4WhhhswE7knpIxrM9UXLxsGCzLKj7tbhAPSDWKs1gPsuNznTaJ6UopGZWTTThYGqvZsFUhRK85Rj6uTZhC59V+sCyR+NzSdXu03sglyZtHXxErSuRaia8PtDBi+AvG3eObe4YqOBc0PEqMjBuFri6Htvewoj7Tu8ZKQYlVSDAeY7UbGli693dzyDAUfkwBm80KGIVRrQBzrryU3d46J4S6iO2UOLvqHwob20HvtM+A62e0RSraDXWPL/mi8bn9ANBimaplI1s0DWs9lU3dDvfoS7n+oVd8FmsbCbv9G0HJxf20Rhz73HYtd2vVlqLeOq3qGqkdmAeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dBvj5Fv7iFGI2RU2CK5fvWxPve9gFzLT9trgvwfoss=;
 b=RBRA+XJoedlxF659qshcoYlNRM/I57+eEfnmWlI6M9c2uYrS0Z0ybpohZ1cz5p6dfJ5R4SQphkO5lw5sYjv2aoWOna+N9woOWYHtzfOc1Ow1z2GaM/dYjZHzhtyz4bblV0yePV9Y3r9awWkgJ30834iGobrKAxylr13Moj/KbzSqhAyFbQvYYqz+IiUoMQb/1ph+8f2gnnIiNtU3qo+qB1HiJaNVALkKf7urUY/Bn8udmiA4l7L1dGEKMx3Pb21BrLSxY3PMhwzWRhK5rkaXhxpPCUEWoJzjM1vdr7yAUbtCsRGT+jx3sJHW5YX+nEpJ25x26Wx10aZBZG23KZm2+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Sat, 11 Nov
 2023 23:54:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::a49a:5963:6db:77ce]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::a49a:5963:6db:77ce%5]) with mapi id 15.20.6977.019; Sat, 11 Nov 2023
 23:54:58 +0000
Date: Sat, 11 Nov 2023 15:54:55 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "tj@kernel.org" <tj@kernel.org>, Gregory Price
	<gregory.price@memverge.com>
CC: John Groves <john@jagalactic.com>, Gregory Price
	<gourry.memverge@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"ying.huang@intel.com" <ying.huang@intel.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "mhocko@kernel.org" <mhocko@kernel.org>,
	"lizefan.x@bytedance.com" <lizefan.x@bytedance.com>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"roman.gushchin@linux.dev" <roman.gushchin@linux.dev>, "shakeelb@google.com"
	<shakeelb@google.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>,
	"jgroves@micron.com" <jgroves@micron.com>
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Message-ID: <6550144fb048d_46f0294be@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231109002517.106829-1-gregory.price@memverge.com>
 <klhcqksrg7uvdrf6hoi5tegifycjltz2kx2d62hapmw3ulr7oa@woibsnrpgox4>
 <0100018bb64636ef-9daaf0c0-813c-4209-94e4-96ba6854f554-000000@email.amazonses.com>
 <ZU6pR46kiuzPricM@slm.duckdns.org>
 <ZU6uxSrj75EiXise@memverge.com>
 <ZU7vjsSkGbRLza-K@slm.duckdns.org>
 <ZU74L9oxWOoTTfpM@memverge.com>
 <ZU9ijZHZZjRgUctq@mtj.duckdns.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZU9ijZHZZjRgUctq@mtj.duckdns.org>
X-ClientProxiedBy: MW4PR04CA0272.namprd04.prod.outlook.com
 (2603:10b6:303:89::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b25bee-a6e1-4bda-c6d0-08dbe3119c8f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PvK6Q9zSbHRbs2Qdco4N7lo/2WJcYpVoSfmYV97xghAeNSoDS1V/tr1ha8uEpmHNO0gPPxY/LMtnBFerNqxheV+i4H5eY0UKroAWNzkgzXshwnjJKnCO8yg9xETysrYhwVLrCk9a5YyYvvxF1/izMwgSUhH2FS6hWcPNMqNn5n5rFZoBRfPHgwVAjoPDf0Wrie/BnqkHsPXMT+Vw4CkS/kzX3tObkTdCOuAEHNQEVqM6319VYKBliALeJ6Lx+eMGHj+buq+QY6D5GJUmDo43LVN3nK6C3CuU5b6zARcGPYW3P1dfRGkm/mBoYNKAtaPypO4vDyLTzkKs/7mnM8Yk/gb+tTTsyfVCsb5vpCtO6G+MTKlvUSn1+YMAjIHdQuxrPvoI/RwQt/vyHcsiZa9kw1zZy5ceezjZI+HOP6DUh2Ke6TfnjxE1mD7sPdN+wt0BBqDkDwrkwkhEsJ0YigXCUKSrL/tnICHxptQOyKIYogtZdwxXDjNwFT/d8LcUH+Xmqr4XUMlNNGSJiAkuhDROoxDGaIxbrULZ9RZF2hq5pZxkhxp2vvTQkbGj7aYmKcMyUKSZKv2ZEp/fnUwMjjy+Mqsop4MKJu5mxsD9YN0IYjpgIgSXUQjs4Vw0zbXlHo+LLPv1zGGHNHKUvCmAk0/kXdpTpn1n9s5OwvnW/cUZffs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(1800799009)(186009)(451199024)(38100700002)(110136005)(5660300002)(54906003)(66476007)(316002)(66556008)(66946007)(8936002)(4326008)(8676002)(7416002)(82960400001)(6512007)(478600001)(6506007)(6666004)(9686003)(6486002)(2906002)(83380400001)(86362001)(41300700001)(26005)(16393002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D1lCRbz0jB0XPpbBXW+ZLdRVf0BlouPQqzLWacj89Rn43BybblrOP5V0vQcX?=
 =?us-ascii?Q?nUvPa4CIz2lCPXh48oWhJWaHczUWnaacJm6OaMq7lD2WNcMbRDBPY7UapkqV?=
 =?us-ascii?Q?GJWL04d6LsC8wKX5wjmqTIUfOyIN6byxMdZILM9qev/NxeeErrhnSzka6ta5?=
 =?us-ascii?Q?mh4Q+CpF4sGxki35JKn5e2HYrQ2VlFxyaoglrEAL5cLjV76gtKxpT6SQrbZP?=
 =?us-ascii?Q?b28lqrRSOlyYlzVcrMLZcHb52zqfYVF9HV9IAM0nEiKnnEEkyWK1nY8in/Pp?=
 =?us-ascii?Q?SPbvuaemqa9qRSbr38MzS6A8H1dzQ4j7QvCsqPmLeS9lip5Y/Ful4YT7fDXi?=
 =?us-ascii?Q?fT/HH5VZk+MyW4zG4JLWHxBcCgy9AUV72S6asqrSp8XqLbyk6+so8Z/uruev?=
 =?us-ascii?Q?Vxxyr47P3O3nF9MbiJX+jNEZicllXMLmFvmJavTRAOfofTQ8y9bGltzkOtXw?=
 =?us-ascii?Q?41Mj0rJgyn0+Hh8lL9hiiyzpbRpqqT+S3sLFgcOneXxWqsCxLTJdLQf6Dx2w?=
 =?us-ascii?Q?+Xv5z7dCyjIDrUo/Jpe7PDrrpWtAxa7ChcY+CShUr/zxOItTEpyN2xFP4+lN?=
 =?us-ascii?Q?FcU22E8k+Rgs71aYiEdxFCcdacx8hR3Fm6SWS6r8p4lzAN6hurW59xu+f/2x?=
 =?us-ascii?Q?l39t03NufDLWQpP8oN5GTH4D1RsU/4HvyJuQIy081R/fPFEAojCf6zaMX+eI?=
 =?us-ascii?Q?GWod6I6HlWnzVkVSfd8U5aozWFNeUnzrrZC9asFQMaNx7zZEq0Idf+f7qTKj?=
 =?us-ascii?Q?ibqTqaIboSIB1jd27yhHJTgcNuruk85NvolUnD8VE6qgKp8mojy875i8WDFb?=
 =?us-ascii?Q?sLohHqUqLJ22nG7y/UgpCufJ1WqTviA0iXce57woY3YXb88x3i1kOf+/nPp+?=
 =?us-ascii?Q?p7nZDMTYWDHCUolUrNaSdVaAW5zVnI24Chh0qOt3DNW+3jKGuW+hsxD3uLGa?=
 =?us-ascii?Q?RNQoi+w1NGBl9UKdcMiApIP2ZYLfl4R2io5dQD4odtx2QgscLBESD26XcvnC?=
 =?us-ascii?Q?MoJ73cfjFKjbq8WMbW1OSzchAOQLPfnkL2snwTwmIX87Qq4GNaUtIduPE7ta?=
 =?us-ascii?Q?rHcRqi3DPfz+GWgGqUcYkq43q7rzQb58kk4HgSNgkCpV0Ap89Gnb4o77CG16?=
 =?us-ascii?Q?SstGEtTP9ke4jyAkJdhf9NAikDMDST66jWuZZjEIfUQ9zsjLFw+dQLipn0dA?=
 =?us-ascii?Q?4o9MbnNmPR/DXVRVq45cY6rC7yin4ThBUkjA5IuihQ0K+oOEiW7qWW7AdwcR?=
 =?us-ascii?Q?V/301DFKaEame6EIlW+NS7U2/HwwykaLQIx5hxHJ56Z8hh49vle2o70q5emA?=
 =?us-ascii?Q?i0kkTfFmdlrLv3pv1tWKVi5GppsSLH7KlusMTIDSaMCMskt3CmORMMRpuyd0?=
 =?us-ascii?Q?hUGIRARXYIzfyo5z/a5b06BZgCpeZRtieamTrzvJtugxaa6P/oQhXwj2i9kl?=
 =?us-ascii?Q?jHsXV6e3sFDx7BGNJx5WE5PHTPeI6umsRV3n91TZhjomEmGfPlXqjD8VexRn?=
 =?us-ascii?Q?Gnvk+2IiGijo1GBf8WgW3bzVZLHugS7aWx65iy9a+Q5kCIAhILs4Oj+9Effe?=
 =?us-ascii?Q?iJk5us9yRdnBHidDYZCrVxxOYclrhW/uU4q1hcCY73EuIMW1+s39pCMjRmkv?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b25bee-a6e1-4bda-c6d0-08dbe3119c8f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2023 23:54:58.5390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8PJ1pd/WIJw1SRbF//xRtTmPtXeHj+tdmZ80n2lNDPPSOC7Dp+k4wOGJ55ymHBb1+fDtXFLg+E36Qeq8zCzzEyf+5Hmms55IhkJ6iEPyOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7897
X-OriginatorOrg: intel.com

tj@kernel.org wrote:
> Hello,
> 
> On Fri, Nov 10, 2023 at 10:42:39PM -0500, Gregory Price wrote:
> > On Fri, Nov 10, 2023 at 05:05:50PM -1000, tj@kernel.org wrote:
> ...
> > I've been considering this as well, but there's more context here being
> > lost.  It's not just about being able to toggle the policy of a single
> > task, or related tasks, but actually in support of a more global data
> > interleaving strategy that makes use of bandwidth more effectively as
> > we begin to memory expansion and bandwidth expansion occur on the
> > PCIE/CXL bus.
> > 
> > If the memory landscape of a system changes, for example due to a
> > hotplug event, you actually want to change the behavior of *every* task
> > that is using interleaving.  The fundamental bandwidth distribution of
> > the entire system changed, so the behavior of every task using that
> > memory should change with it.
> > 
> > We've explored adding weights to: mempolicy, memory tiers, nodes, memcg,
> > and now additionally cpusets. In the last email, I'd asked whether it
> > might actually be worth adding a new mpol component of cgroups to
> > aggregate these issues, rather than jam them into either component.
> > I would love your thoughts on that.
> 
> As for CXL and the changing memory landscape, I think some caution is
> necessary as with any expected "future" technology changes. The recent
> example with non-volatile memory isn't too far from CXL either. Note that
> this is not to say that we shouldn't change anything until the hardware is
> wildly popular but more that we need to be cognizant of the speculative
> nature and the possibility of overbuilding for it.
> 
> I don't have a golden answer but here are general suggestions: Build
> something which is small and/or useful even outside the context of the
> expected hardware landscape changes. Enable the core feature which is
> absolutely required in a minimal manner. Avoid being maximalist in feature
> and convenience coverage.

If I had to state the golden rule of kernel enabling, this paragraph
comes close to being it.

> Here, even if CXL actually becomes popular, how many are going to use memory
> hotplug and need to dynamically rebalance memory in actively running
> workloads? What's the scenario? Are there going to be an army of data center
> technicians going around plugging and unplugging CXL devices depending on
> system memory usage?

While I have personal skepticism that all of the infrastructure in the
CXL specification is going to become popular, one mechanism that seems
poised to cross that threshold is "dynamic capacity". So it is not the
case that techs are running around hot-adjusting physical memory. A host
will have a cable hop to a shared memory pool in the rack where it can
be dynamically provisioned across hosts.

However, even then the bounds of what is dynamic is going to be
constrained to a fixed address space with likely predictable performance
characteristics for that address range. That potentially allows for a
system wide memory interleave policy to be viable. That might be the
place to start and mirrors, at a coarser granularity, what hardware
interleaving can do.

[..]

