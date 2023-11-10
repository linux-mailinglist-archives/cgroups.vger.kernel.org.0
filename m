Return-Path: <cgroups+bounces-323-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F387E7D67
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 16:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7088D1F20C17
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C831CFBD;
	Fri, 10 Nov 2023 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="AtC1HlHH"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4FD1CA80;
	Fri, 10 Nov 2023 15:26:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4405A37AC9;
	Fri, 10 Nov 2023 07:26:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8FHpbe85vKFDVEwHAeIIpaqthrZkZ08um/kAzOZpjHfPYI2U84ja63wTC9bk8quSurtXQArygAU7NTDx9anTwoa6+SXNgXFWRrLRDmtps9ZvWE7HMaeESNOcN7vf3MYR2KCwWFKS9ZO8thM15gwNA4rrU6/0SY6+IvcvXzCGGc4pPJn786Mh2IdMhvgB8WWzepIIZmiqA5BrnS/z+S16/drrBfUV6U2G0a0SPK/HPJNnJZbJHYcOW/138djFWzff61Ja1BQtD2l6kFEkvjaXNyHeAOTrsXFfj2Y9ZAFOC4qIHjsTBbuBXV6CMCsvk5rR4ZqDKvpPP7H/N3Nzs8cVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adD0Y6g68I9viqMEMz6mnEW34J2ahp7sMOEBYwQwrmQ=;
 b=eNzngTM18fJOkbj9h4USYul1ySlsCjkzUZbpNtJEG8b/qxoR44Itnx4Tava7nvoY0W9dfKTLJGfJYeE6cWgw2Lr4AZ1ro2LIOekD0bhlOs/m0FX5ScMdQe8SD0oYou/DqA9xIAKL257ik3/Dr5CeGCnMDTjqMJppLetAOK5NQ3gcGYk+Nyy5p2WIQvkSPIGaMFbpI+qObL5+8Qjno/U4MX6IspgWS0d9303txVkLz5KNNoe1XUD6Xx6J7ZRsYIRUQwdWDYy0dadnnyswHvSdHrp/KZnbG8Cf4Kwc1LtLBrIE8Dq9N5sh70/XtamRQfwXrUx+F0TdQUYwhPHB3aKjkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=memverge.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adD0Y6g68I9viqMEMz6mnEW34J2ahp7sMOEBYwQwrmQ=;
 b=AtC1HlHHWxzK0vqJcGXpYTDC/XlMULWI72hsiK/Q2WktChppJ6/xufwzk25vJPR2AlShfrc6OYaKWjjmMPpEyMCF5hT+hpbiL2UOhg3EZJBEEr2BMLpf4OuAN4jOt8BWfcihK2p2hWVKuJjGIf7mMD6hoVoAQR7moFLQvsKcAG8FxaWQLKVHOr+jaJiZ3zLVUie7Y+NPmXejIUnjpoV523pZpwv81KrgSUM2XjE6puzfDjvSu6DJYp+W1QflrDPcXR0EgxWukRR0n7e4ussuweP2b/UwoGqw0vop1NQGHXabTbUxcE3ZG5fPU33hWZjauAtXr6w3iJBoNyvE9ciJaQ==
Received: from SJ0PR13CA0193.namprd13.prod.outlook.com (2603:10b6:a03:2c3::18)
 by PH0PR08MB7132.namprd08.prod.outlook.com (2603:10b6:510:74::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 15:26:34 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::e1) by SJ0PR13CA0193.outlook.office365.com
 (2603:10b6:a03:2c3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Fri, 10 Nov 2023 15:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 15:26:33 +0000
Received: from BOW36EX19A.micron.com (137.201.85.33) by BOW36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 10 Nov
 2023 08:26:32 -0700
Received: from VENKATARAVI-LAP.micron.com (10.3.116.60) by
 RestrictedRelay36EX19A.micron.com (137.201.85.33) with Microsoft SMTP Server
 id 15.2.1258.12 via Frontend Transport; Fri, 10 Nov 2023 08:26:25 -0700
From: Ravi Jonnalagadda <ravis.opensrc@micron.com>
To: <gregory.price@memverge.com>
CC: <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-mm@kvack.org>, <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<ying.huang@intel.com>, <akpm@linux-foundation.org>, <mhocko@kernel.org>,
	<tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<corbet@lwn.net>, <roman.gushchin@linux.dev>, <shakeelb@google.com>,
	<muchun.song@linux.dev>, Srinivasulu Thanneeru
	<sthanneeru.opensrc@micron.com>, Ravi Jonnalagadda <ravis.opensrc@micron.com>
Subject: Re: [RFC PATCH v4 2/3] mm/mempolicy: implement weighted interleave
Date: Fri, 10 Nov 2023 20:56:06 +0530
Message-ID: <20231110152606.123-1-ravis.opensrc@micron.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109002517.106829-3-gregory.price@memverge.com>
References: <20231109002517.106829-3-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|PH0PR08MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f84d4c9-40ac-4a70-25e6-08dbe2016c13
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z8guBpB1TM+wkzi7cErnBmJaItrQGkQwpOLKDUDy7NNUBd89bzcAMSVs9Zlf4SfLF1JRa2hjUTFPhBJQq0KEWuW27e0AHt1jHtuzX4mQvE/IZdC35N3bgt/g0fZJaNRWooeTOayEFrfHWvhUoBBtk8eJQ0wbiaKUx4kArnoXvBHg4xCdKwW9Nl2TE7gEKXmRBDWD9FA5SQ10VLtyJbpFWJYm92Rh8MU0Q+5JobnO+FXU5aK2Zitwzh5/7TLVioFjqaBHWKDNDm4YqdawEVkpMS/vi5nW8YAoHeNLtdfOp7Qcnw2OwkFdJomPArUe857w2N59LwTVfK+Qkm7LSIVaW/PocS1Lbwju1bYlRn2r/8SeMolTQXAX23b6OTQMkHthiZ3BAwSzt9waMvo8uDpeUbvl5JxQ31iy1mumKNomhDRv0LS2qXz4r5x2eXG75/OkscBLkLgn9ERghAFkQhuJI9c0qS1lPMOh65QASFmrKSZWKAh+psuu4FIwYegkawzAOzemH+P3iZ5qUkjIXkPTYvLCN/ADL2jrL/IVZEPdcrKZwPL8b5vG23REC22H8CsTqFXdn91oP3XNAj4JBXa4FnfM2ORoUw+poCvCZGjTanHNsnxZX/rsAJzJsN011slgCPjQNJzcId3ZauYQWtAW1amrNz/s/HgHJvcPYbHJcrvMo0WKmwQUU96M/4BMCCGt5yHySpZKBxjjXws/8LA3l8pog4m1tH98xtHVb3ACqiekjxbf7b0PFJBuDUckLp3SilNE3Yforzqvh4mntIEE4Q==
X-Forefront-Antispam-Report:
	CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(2616005)(7696005)(7416002)(41300700001)(26005)(107886003)(1076003)(5660300002)(40460700003)(6666004)(40480700001)(426003)(336012)(2906002)(8676002)(8936002)(86362001)(6916009)(7636003)(356005)(70206006)(316002)(54906003)(70586007)(82740400003)(478600001)(47076005)(36860700001)(36756003)(4326008)(16393002);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 15:26:33.8158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f84d4c9-40ac-4a70-25e6-08dbe2016c13
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB7132

>Gregory Price wrote:=0D
=0D
>Implements interleave weighting for bandwidth optimization.=0D
>=0D
>The mempolicy MPOL_INTERLEAVE utilizes the node weights to implement=0D
>weighted interleave.=0D
>=0D
>There are 3 integration points:=0D
>=0D
>interleave_nodes:=0D
>  Counts the number of allocations as they occur, and applies the=0D
>  weight for the current node.  When the weight reaches 0, switch=0D
>  to the next node.=0D
>=0D
>offset_il_node:=0D
>  Gets the total weight of the nodemask as well as each individual=0D
>  node weight, then calculates the node based on the given index n.=0D
>=0D
>bulk_array_interleave:=0D
>  Gets the total weight of the nodemask as well as each individual=0D
>  node weight, then calculates the number of "interleave rounds" as=0D
>  well as any delta ("partial round").  Calculates the number of=0D
>  pages for each node and allocates them.=0D
>=0D
>  If a node was scheduled for interleave via interleave_nodes, the=0D
>  current weight (pol->cur_weight) will be allocated first, before=0D
>  the remaining bulk calculation is done. This simplifies the=0D
>  calculation at the cost of an additional allocation call.=0D
>=0D
>The functions mempolicy_get_il_weight and mempolicy_get_il_weights=0D
>were added so that should mempolicy be extended in the future to=0D
>include local mempolicy weights, there is a clear integration point.=0D
>=0D
>Signed-off-by: Gregory Price <gregory.price@memverge.com>=0D
=0D
Thank you for the collaboration.=0D
Please add the following signatures to this commit.=0D
Co-authored-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>=0D
Co-authored-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>=0D
Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>=0D
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>=0D
=0D
--=0D
Best Regards,=0D
Ravi Jonnalagadda=

