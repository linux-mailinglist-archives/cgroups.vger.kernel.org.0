Return-Path: <cgroups+bounces-330-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F997E85C3
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 23:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5E82810B0
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 22:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AD13D395;
	Fri, 10 Nov 2023 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="Dm+U0w3u"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F893D38F;
	Fri, 10 Nov 2023 22:30:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF59959DB;
	Fri, 10 Nov 2023 14:29:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQjQM8qwyEroilZhZwnspwXRlZQDnf/kpJ+GjV/1DJykTV8dD5WpBdoM3MCUgZsX9WVwtIqipauR9AOXmOK0G9Mj0KgjyyVdO1cf0aXPIcGLsb0KSVXKfC8jNyaVB7gXjldiUrLCpLnwg2WUT4ioe2fwpgbpmUNogDrrJ+pkg22bEL+qZxWIzEws9S+BmxBVWM36AxR2q+41Ha50C1+Fky4+maUitoJp1MEgY/3J8mBcN68rkg/l6VAt3f5YTCdv9qQIss0OaRQQFV3UJGxS/g90c0X+6Aw9HN0ogD9oTDfVhhPx8p65eY6H7iNfM24SWvIdPUsAS/RrarCKcarv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ6HzzRCDC4mF5y3X9giyKkmGrV+CkPT9s51r/kBVE4=;
 b=HA6wgp+R2kQqrEe15MOaOXrtUfNZrJnjqItwST5BDS6Igt63lfevo9B32KTf/4csb8k78KbSImg66KogMTA6FLe82vuhV+6j4NzeguANDjUlnC9c5hix8bhh98H8D6MzztcPLor+DWPz1v1Nel5IKzf6SpT24/AByYowWsk3tcbo3IesRT4sOm2THjDuELZ+Fu1k3wnRYAhn1FVaU4VAJBPMmdUYHSGd0bRhtleAeZNsF+mVfEpQQmP9q4RuQZHJ62prQRarzb8bNx7p/LU+6DMDNxivPsODW4y7VD+mD+UgwpBVIyyeq6Fe57HlABK6T3jJmEnrHvOs8ETNThYxMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ6HzzRCDC4mF5y3X9giyKkmGrV+CkPT9s51r/kBVE4=;
 b=Dm+U0w3ubVPlhfMP9gULdzMvCMigi0Wj7V9dMsfXMqJBkxeBRNGg8/kHSq0H7de8yjiwQqSAbxcpW24NIOeyGpPQRmHD+p3ESLZFKUrW+7klJDInyz72o5nDrDakdvD4v4rzxzfMMS2svqZwMO/XnX2kvp3R5SxOQGgarOjpyd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CH3PR17MB6714.namprd17.prod.outlook.com (2603:10b6:610:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.9; Fri, 10 Nov
 2023 22:29:34 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7002.010; Fri, 10 Nov 2023
 22:29:33 +0000
Date: Fri, 10 Nov 2023 17:29:25 -0500
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
Message-ID: <ZU6uxSrj75EiXise@memverge.com>
References: <20231109002517.106829-1-gregory.price@memverge.com>
 <klhcqksrg7uvdrf6hoi5tegifycjltz2kx2d62hapmw3ulr7oa@woibsnrpgox4>
 <0100018bb64636ef-9daaf0c0-813c-4209-94e4-96ba6854f554-000000@email.amazonses.com>
 <ZU6pR46kiuzPricM@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU6pR46kiuzPricM@slm.duckdns.org>
X-ClientProxiedBy: SJ0PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:a03:331::15) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CH3PR17MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b215eb-5256-48b2-1a97-08dbe23c8382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jy4zek7vDboqlotz2wtfAa2akNGWkku3IEDq1zI1DpMN8c5Uf7iGZ78tfVCmpRlfvwghZCHtqHZWmJs3KTazOV7SX56EKJFlvPyF0lyG1Z4GJxy89lQWZidYcUnHuWJmHkl9VV/2ZaqYpGQTDDo8aiPL59EEnBK69nYKPQxfZlbOATUaxJKhKs46963UlD6aifwNZOeBjVvJBTGcx6SIA+FLthx0BI2shFLWTwb2vmh9OiA6HKO1O49LNMEv9Ke9z9O5pNt2MqeU6N59BjU+o3PWDfQHwzImx9O2OwOZ8S+juzzNuA0OoMB/Ot6bJn+ONQWH255MHPiZV7Y85QAuzm2BUVFbR55FR2FEEyCXLsTRmb9X5lTs1RzNHkh8rmt6EVkZpQeXymuRK860B668LzE5khBYQjiw/MvQ1l9PG34XRv+uER4x0T03+VM7hxFFniProFBv0HvtAbEmyRAZCOBUtHa5Q/hH6Z6IU5DBvBM3JauHyhMNlu241+1h6ZgZhicHw63J8VWGXCOVnc/aqhlf88edKqtoSZXFmATEnJJQZrf/R3Ed0kAL8BfhFUrWQ8kUcxnfLjiE8N8WAPynjPAyCmMWoYiGPVG9jQbnlzU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(366004)(376002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2616005)(26005)(5660300002)(83380400001)(7416002)(6512007)(86362001)(36756003)(2906002)(38100700002)(8676002)(316002)(66946007)(54906003)(66476007)(6666004)(66556008)(6916009)(41300700001)(4326008)(6506007)(44832011)(8936002)(478600001)(6486002)(966005)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KhD1W7PcrTxKpYP67+AcLFC7Qoy0b+Djsapn3eOvvRO4SKSCPC0NC8O08NEo?=
 =?us-ascii?Q?O79j1a3pevwx0Hvkv//bY/lZ6zZ0sWdSl8n/DMO+owIuJyncnzWC58tb+cvD?=
 =?us-ascii?Q?Nhbu4NtO2bX0FaScgLnFgu874Y5qSV5QVwRcT+hJKecdq7hUiEHmKf/eRAT5?=
 =?us-ascii?Q?b5RPxHF4Xwb30asp2bqbIfJIotAhSIdVXyMtdvZ5E8+dPZI8H9XJNaLST+3j?=
 =?us-ascii?Q?EGggoHLaIEM2U5duLCVZUlg9sNEPvx0PtPif2ZeSqXYCWcVH9ZtSfY/Dk0ox?=
 =?us-ascii?Q?bftgFNerq/sbRpIxU8Ecd44ZMN2VBJGGj3rHSu69Zo0tNKgn6zQ7SYtIcCdW?=
 =?us-ascii?Q?dFBjBLZ2q4oxl2ROxU0p/nednahig9JxP/3wzROuzMVsNRshe11XWigRMN31?=
 =?us-ascii?Q?yAH4UP+UrGq+9BO0epUztw7fOCECB+OyJbvznbli48WyYl/+bEgoVdWMAm+U?=
 =?us-ascii?Q?bCvJgjczPz8nKsTU8iEpP1iYA9K1bWzCcgb8vbeUzDJFptR4KV1p+HJgHbHf?=
 =?us-ascii?Q?dy9BBPqOZQNc7wQGO7XnUhM1ehcRfK82zqitZrz/l1G4qF/NXVvomykm13dA?=
 =?us-ascii?Q?7IH1jhFYljPU3sQtCU1W0bdOSTVMOLnW55StOcwORtLaaJYm9oOa0rg87Pzp?=
 =?us-ascii?Q?4cyT32MTI/B18r7dM+kDaQx9jIZ36r/57Wek0RWJgwaJF9SUHxS4v37U+bTU?=
 =?us-ascii?Q?qs+i7H4zHiL6h6KGSjd3wx90AHxiHQP0SI34Y17uHbikDbgY3nu6iDtOG7zT?=
 =?us-ascii?Q?BamUeQg/Ap3YdQeFa+TN3ThP/LGVY+c4k4Fvsu5vystEVQKUfigHnHN/iVI+?=
 =?us-ascii?Q?K0TFPceC6Ov1vHSqwnzg2AO+LaV/p9KAfiljI7TdOdb4KKW26hAmeA3GcRyA?=
 =?us-ascii?Q?Fg9cPjiOt1zgxow8iXpJ1I8LrPCIaQZUwigrmjKIPg1aypRXq5a1YWDGBZd+?=
 =?us-ascii?Q?qdEkwvaAIzTnhOA+8wjLPVRc9zly1SW+0Vqy+veREM78N/nxg89i5lHQqj2B?=
 =?us-ascii?Q?o7KyHMKGXkICY/td0tQzXPFmANOoZFSXuzZSX6Id3IM2wEDywRWKIkB67A+Y?=
 =?us-ascii?Q?xnMJ3sPb57+mtZ0turVZ4wtYjwWu8lDvwQ6xRQ7wVLJvo0LVMsJ9fEBpy5ls?=
 =?us-ascii?Q?UNKfdmXs2Wn+Ks9UFR4ORAQjDph0qhYdBG7R1omMcE5odnV9df3ND5CH/rgh?=
 =?us-ascii?Q?kpDRllsz0UgG4b7NWArBVSm1Wrj8N5TKOsbE5X93dCSQAEfcjjXceXDy7zOX?=
 =?us-ascii?Q?Sb0Un6mOxqTLKCf6oNpQIfnRB6YQXYrtzchrWNHfOdcg7fMwEQmT+OktCZry?=
 =?us-ascii?Q?4ofY3ai7Z1KyJvleX96O1g0h/gyFvyIISPg6p8Ree833qfAVpeF4N5+cmC2w?=
 =?us-ascii?Q?ovFdsu0ieNhBXgS8nC8JreLw0q65htXMdnjEYGN3absxK0KUYdjtzJSuwIi9?=
 =?us-ascii?Q?JYSWilW8FzRo1hZlR9lHkTZm5WfzYyuEdIQV56QKflqNKBzbp2UJox0Xypwt?=
 =?us-ascii?Q?CVOanyXQVBL1B8uK9pHvMhbVHCSfJ5xeKbwKrjvyb03CyUJmKHBy8ZBKZf+b?=
 =?us-ascii?Q?/nuqf6gIwMPmB66AvzZlgqBGmaBWJwXdDa27k8Fxhptotc+sv8VtR9ycYiv3?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b215eb-5256-48b2-1a97-08dbe23c8382
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 22:29:33.7238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LFtGjgZNYW39WiMDTibchSGHW9I/guWfXM2FyIIVz3nXZNGLPXdxXktnN328WMKQ2FMLINfvKIc3JIY1WVljPsjDBr1wL1AvUSO7+KkvI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR17MB6714

On Fri, Nov 10, 2023 at 12:05:59PM -1000, tj@kernel.org wrote:
> Hello,
> 
> On Thu, Nov 09, 2023 at 10:48:56PM +0000, John Groves wrote:
> > This approach checks all the important boxes: it only applies to apps where
> > it's enabled, the weighting can vary from one app to another, the
> > kernel is not affected, and the numa topology is not buried.
> 
> Can't it be a mempol property which is inherited by child processes? Then
> all you'll need is e.g. adding systemd support to configure this at service
> unit level. I'm having a bit of hard time seeing why this needs to be a
> cgroup feature when it doesn't involve dynamic resource accounting /
> enforcement at all.
> 
> Thanks.
> 
> -- 
> tejun

I did originally implement it this way, but note that it will either
require some creative extension of set_mempolicy or even set_mempolicy2
as proposed here:

https://lore.kernel.org/all/20231003002156.740595-1-gregory.price@memverge.com/

One of the problems to consider is task migration.  If a task is
migrated from one socket to another, for example by being moved to a new
cgroup with a different cpuset - the weights might be completely nonsensical
for the new allowed topology.

Unfortunately mpol has no way of being changed from outside the task
itself once it's applied, other than changing its nodemasks via cpusets.

So one concrete use case: kubernetes might like change cpusets or move
tasks from one cgroup to another, or a vm might be migrated from one set
of nodes to enother (technically not mutually exclusive here).  Some
memory policy settings (like weights) may no longer apply when this
happens, so it would be preferable to have a way to change them.

~Gregory

