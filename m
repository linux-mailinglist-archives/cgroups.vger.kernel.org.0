Return-Path: <cgroups+bounces-408-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD86C7EB42A
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 16:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D7C1B20AB4
	for <lists+cgroups@lfdr.de>; Tue, 14 Nov 2023 15:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB65A41778;
	Tue, 14 Nov 2023 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="Ygoe5pFV"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC241771;
	Tue, 14 Nov 2023 15:51:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F0EFE;
	Tue, 14 Nov 2023 07:51:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBavb1OJRuhNdPmd3WZaXH8ZhV0kzJqo2XZQJsQ4F/1vkcrwFRJFSLI3OQxnG+V1AubVK8rv/hpHa7MafdAj5Wx2ktI83Z/qi9jN7ZmMrUFH73QCgf1ueyioY75B1xn7pQbx5tqlqUz6gjLt0pryECIXw7j7NUpR4gyFLtbyovvxhNZLby7hJr7rzJx6vKUk67lbBHnq6ZR+gOOJccxnW7QxAqIWsvE8qayHatuG0MW/fBepKLkgleOtipxRp7iLsxX3dr+o5Rla1Ij7b20ktyqelp3WpQLaUe2+IWSw9Tyoo7yNueAOAZlaG8WpyQccmJlXA8672DE9hFUh1SBA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2s5yCu+VBTc0peJFZhX9wSLIQyGUKKnAx53gD1QYE4=;
 b=UfMPtXo2iBbwaR0C7zrDUk6t7TZaci4s4KrckfnOAo5yHQ8rrXNYRfHwHjvgRU5jtFqx+BMXBtFg4GSJsN/ozWUmna/2tCPVfW8SO07wUeCZV5IAm0TbUWzXqYud0ZY6rYcaLtUVy0q4BJqqbKEFUik1NA+NWCG1VTxDRjO8JScMoFWjTImGTSjTiaB/cqmts5a3/6BLjxVNzj1ELBlrEBRbQPye7AbCX8akh/0hSyNPAcRcyIHAelrscQgI4scySDHF4moDPn6Q1/YDoP/Wl2Ac5cFATQ0K59NGvd/XF59i8KJ2LqZ5n/vfpSgoU5H1QVY5QRxsm5MWNWfYJR1TlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2s5yCu+VBTc0peJFZhX9wSLIQyGUKKnAx53gD1QYE4=;
 b=Ygoe5pFVCwT/mPn9e3VJ69tteAVgmtVeKvTqkpooOitKFfx7oZKx5b9EWNpwTxmddV9oth8TGOU/5nfwzS/BRhC1BkyjR9LNQ+wpvnqsNORj4nqi8wpx2RUpypgI8RmGxz6MOo1pbSL3hetHQCC3WhtM6FZX5RUtXuI8LWrXsuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MN2PR17MB3966.namprd17.prod.outlook.com (2603:10b6:208:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 15:50:57 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%5]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 15:50:56 +0000
Date: Tue, 14 Nov 2023 10:50:51 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Michal Hocko <mhocko@suse.com>
Cc: "tj@kernel.org" <tj@kernel.org>, John Groves <john@jagalactic.com>,
	Gregory Price <gourry.memverge@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"ying.huang@intel.com" <ying.huang@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
	"shakeelb@google.com" <shakeelb@google.com>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>,
	"jgroves@micron.com" <jgroves@micron.com>
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Message-ID: <ZVOXWx8XNJJNC23A@memverge.com>
References: <20231109002517.106829-1-gregory.price@memverge.com>
 <klhcqksrg7uvdrf6hoi5tegifycjltz2kx2d62hapmw3ulr7oa@woibsnrpgox4>
 <0100018bb64636ef-9daaf0c0-813c-4209-94e4-96ba6854f554-000000@email.amazonses.com>
 <ZU6pR46kiuzPricM@slm.duckdns.org>
 <ZU6uxSrj75EiXise@memverge.com>
 <ZU7vjsSkGbRLza-K@slm.duckdns.org>
 <ZU74L9oxWOoTTfpM@memverge.com>
 <ZVNBMW8iJIGDyp0y@tiehlicka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVNBMW8iJIGDyp0y@tiehlicka>
X-ClientProxiedBy: SJ0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:a03:331::35) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MN2PR17MB3966:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a65911-6084-4f78-da6e-08dbe5297d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8Yf3xfwMMjIH4Je8NQjzjuGd7LS9ah7lpYqbWIlKS369fAoBYlfgxLKoM8V0WIj7OEVxm5FsE61UXTtbEAhKp91U4XqdArANuyYcD3tYjtBbgUwYxPSuoOtE4GTHBtZUjVxVDFr0o0992MjYsfnG1QzoDk1SAIPbEYPBFNr9eu0IXnYDKHnXQ1vOw633PJtDy9ij7mXspyN8CCspFZR5PKzOlZdaAAk7fzSTso4f3tJgJeR13jFY71KnTYz05LJV7o56npNP4KJgojfAYQIUOrjUx48Fl6LPho5uDSmFOy2OGH6taEHcfoCfqK0jF28mhQsShIRGeFY3tkmyY3QHB49MasOnGRSsBh4JG5VLOe4pcXOux251iDzo994AuV5wTYW4u3C5eBoBH6SufYnAM/e3gK/lvPsssVPBIyIBVcZ62dgMsG2vghd42raB2JkhzUimbsmYyOMMvmclXe1uEdJlR0ITe/YhS/45KxqQHCyuZINwgD7TW4J0D1rmILL5mBJj/O4LkDPTE7ykBWdXqTKbL+3D1kLacDcXJzjc3sKn4SacObWAeYtEkdmCiCeS1bw1nLpnQRgE9MVoKcuD/+ngD/n533nVd8JT/VaSn44glfUdQ2gcVCCB+tM1j7fmhF7WjtOoK9Ax/iLZjpxSOw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39840400004)(136003)(376002)(366004)(230273577357003)(230922051799003)(230173577357003)(64100799003)(1800799009)(186009)(451199024)(66476007)(66556008)(54906003)(6916009)(66946007)(86362001)(38100700002)(36756003)(6512007)(83380400001)(26005)(2616005)(6506007)(6666004)(2906002)(41300700001)(478600001)(316002)(6486002)(966005)(44832011)(4326008)(5660300002)(7416002)(8936002)(8676002)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N/sMedg17XLb5fEwFbeJRVFghGD9YwHBIIEAujRjxICu4CdNg8xCXUdli+rZ?=
 =?us-ascii?Q?BcPHOC5Dyxkru7YcPHF1/Uapnru9bFEwXThJCMyS4fhjsxAY3+7WVfbJLadR?=
 =?us-ascii?Q?uerW2RDTgCadL46jFMFG1Rr+orIR6fmePmPOT6Iqc2wZtNx88qAS9gNTg3S9?=
 =?us-ascii?Q?hoxHmMSTsQdzR5l5Zok2iBIlojAGD6qQlJ2A7AjRh//0z59Oo2kQXk2AmSyr?=
 =?us-ascii?Q?Tig1RwinS5Qy3uIPZOis3RgXwbbxHynp0Y0BK+xJ90YQB/Aw1R7UjT30xe15?=
 =?us-ascii?Q?g/E72kNNwWOo1HrF+5Ed50LcXiQVSl4lSskP0LRBpOoGtJJe2fn7Xmh1MnI0?=
 =?us-ascii?Q?hAJ2VQiPcUZ8Mser+TgIhNiOXF6bt6s59Am8GMaqiuDxKtZQw2le/BmfVjpM?=
 =?us-ascii?Q?zQb2KUd6vzdYvSbPI/9mE+NqhyPXwpoEdTkDMS4SFTeLSgSVsv2tWB/TaFh7?=
 =?us-ascii?Q?dMIbr2lar/mi0qyt4etTOxvQr9+6WvReqFHoRNngGQdvL/k1E3403pzixNfE?=
 =?us-ascii?Q?ZtsDdCXsjn+jZGD8tEquaLFiCE2eNC2Q2l1UZ/uKcGX8Oi7kFhDkXaj42aXE?=
 =?us-ascii?Q?FrmcWfLlnMjwl7HsU5yD7O17Kdn8j0fBnL9Ja7mvF71JO5JWcB9v8GgKFQq6?=
 =?us-ascii?Q?sn0TUT8O7GEVpeYAlZ/j7vVcZ2ViPOab0tLDnAvKIAT9Ul9+cSfIf/OMQEDk?=
 =?us-ascii?Q?5vVUYGCO7Gh0jgg2bakL+kj1ZmXbUKsKy5GIxsl6rODBgKnSCJh2+oLiAP4q?=
 =?us-ascii?Q?x8p+gp/Si0sooBw1RYLu4nvYMcDk1oDXRFKDxupKiMc6QjkFRGWOJMvTGU1r?=
 =?us-ascii?Q?O5SaKmSB7oIfi8TShrHu1H62F3Ym8vbEytFv+xr2YdlCxN3FJ64hH22HJPfm?=
 =?us-ascii?Q?3TQAAooFIFfu95hUMuGGj6/ISpxJRNSJRnbMrNF6UWQOQ8yRhzQ+9Cd73sXQ?=
 =?us-ascii?Q?a4Png8FxCcbE7WSZ5B+tE9Vjg+HgIZ2aRs+FsmoQsfolOXvb9KXEFrFVtPDd?=
 =?us-ascii?Q?cOFrdkpHopMElqfDx1ZUFHgRCF2w62ht4xH6XpQ0MYovixWMMstT3g0CWAZV?=
 =?us-ascii?Q?6STV5/2pNk3ifBT6VRQJyiuiAhqcKFCEIw+vMCzdj4P5V/cRjdhqR0x6kkzy?=
 =?us-ascii?Q?aakUJOhUjY6vvf/VffOnhsoWkQjoSxCYfWWjXjfkDGNSJ/arlpJGmtk3aZuL?=
 =?us-ascii?Q?eNHLbjit/ikVJ/yonpIeM8Kam4gqrDMsX0/7oocb9X648jmlpwK1ksyZf0Hs?=
 =?us-ascii?Q?BFRdKOwaW5ZQMeEQmlHd30Wre+7TOGmS4SqkJ3HGE3731+THJ1NUdNanERhG?=
 =?us-ascii?Q?hF3jh7KFLHWS5fhs2Zi+kSHXPJwhqfJ/de/VFWzB4Y8f9/j/ttEPg3zG0aKr?=
 =?us-ascii?Q?wmzYkzjEA0loZsUBiY9fHzg6ZXiXB0gNDhDvUnrZTacXT9YBH2qOmVXEyAOT?=
 =?us-ascii?Q?iBHy26BgVHHzGDIVQ2bIbbejLnC/TeQtikFQ3DXaC6evU3j/lPeltk42RyVJ?=
 =?us-ascii?Q?qiCxI9GlS7Ive0Tt0qUGOpjKiO99rp11RScqvidNE+iBb44geANT22PJ5ybd?=
 =?us-ascii?Q?yEMwxXwmSuSTaTF+oP5rCX/H6P+H6P/GoO85KMdl6BmqDxgA9QKMNGD7gDaY?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a65911-6084-4f78-da6e-08dbe5297d35
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 15:50:56.2024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygdfaZKyuKRN0kmHIX6KO4u20g8QAoo0d8eWYpPFsq+w0Cnrfgfp+O4FpONt/YcprPCRisf6jHfwzSLHiy3BU7Q7XAj3v/1mSkl1F9qVQRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3966

On Tue, Nov 14, 2023 at 10:43:13AM +0100, Michal Hocko wrote:
> On Fri 10-11-23 22:42:39, Gregory Price wrote:
> [...]
> > If I can ask, do you think it would be out of line to propose a major
> > refactor to mempolicy to enable external task's the ability to change a
> > running task's mempolicy *as well as* a cgroup-wide mempolicy component?
> 
> No, I actually think this is a reasonable idea. pidfd_setmempolicy is a
> generally useful extension. The mempolicy code is heavily current task
> based and there might be some challenges but I believe this will a)
> improve the code base and b) allow more usecases.

Just read up on the pidfd_set_mempolicy lore, and yes I'm seeing all the
same problems (I know there was discussion of vma policies, but i think
that can be a topic for later).  Have some thoughts on this, but will
take some time to work through a few refactoring tickets first.

> 
> That being said, I still believe that a cgroup based interface is a much
> better choice over a global one. Cpusets seem to be a good fit as the
> controller does control memory placement wrt NUMA interfaces.

I think cpusets is a non-starter due to the global spinlock required when
reading informaiton from it:

https://elixir.bootlin.com/linux/latest/source/kernel/cgroup/cpuset.c#L391

Unless the proposal is to place the weights as a global cgroups value,
in which case I think it would be better placed in default_mempolicy :]

