Return-Path: <cgroups+bounces-15444-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG18LPey52no/gEAu9opvQ
	(envelope-from <cgroups+bounces-15444-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 19:25:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E07443DEB4
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 19:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C797304F205
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 17:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7E82FF170;
	Tue, 21 Apr 2026 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ac9CoakD"
X-Original-To: cgroups@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10454288C34;
	Tue, 21 Apr 2026 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792211; cv=fail; b=WvMKPqjPdAeJy0itWpvuO6eL1fh7NiXqgGQIeudd5T9Pwy5LGW/owGW7l2ZLWUB7EAGwHWV0yDr8z8xHE7ufalwylv6Rz9aCsUdvYpyWV7XHAKk9T9j6B2NDd//juBSRRAL5EhluJu3/r4EY3jatmxItt5fGW/Dkrzo/8HgYcMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792211; c=relaxed/simple;
	bh=XxMDGd1idzufYsWGAAHZy0xda/aYCvkjJnCwcJUp3Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DsMyuEl9J0Ag2Nh7nfiVIUQgC1LTN3QhS3QWnISKW9z8wzlGR3Co8zsqTlUn0wU7h6zAakeRvwO47PmGa9NOoUAaE8aysx4rwBh6zViYHJe/jG7ZRNWxVnlHlr1kH8dG4zq7kFK+FYz3DsuWFJuVNzoofZBSZ+utHLLOMD8r9e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ac9CoakD; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnzNEeRb32W7z8NYuvc101JcSLx6Wmsx3Zwsy9I0sVtit4U6N1bOOTZjYra5k4uUHH3PdcVRS4BeXxZW8MkbET4rituOG2gC8VGvq2KnRjzU34LhfoQetDuZJHc+cZFwlugduJD4deRpwacRQKSkGDcYIfU+MKygJWvvttIyFHbXpF9W1K6xyQ4SpP7N58Q4FV+ZXeZbmbSJI3Nyaq0f33QfyZU3TqIMiyESZ7Rw0gK0Xi/6ZV2OsZLuJ/4r2jNAmoKWgAKb8loTzyKy4yYj9Adw01ENy525JOpM+f1FbkPIG4OkNe1VrK3SWSkAbcnoOcvJgQgiCxJ3j1NGLDEdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjKizhDaVxH6SVaOtD3IKFx9Mu0ZVYHXfGAOHP81juE=;
 b=XY3cVCywa0hqnI/9YCmIY17pjhZEnw8q9twuVlosdJdLTYcWCrUc/c9pRNmwr4mQjj/lOJihtYN9f3sIwieFlDTkmc+M5iA8qlqtPT9HC76fNdMZKVAXkf+BcC43EScz2VrhKs9WJYMirTUiiV+BlI9I1qux+o9r5AYo3qGkAlG3r0yzss+BlESYKMqIAB4ZJ6EVkAolzozUxNnJqMrMcnpA5tWPZ06ff1VR9maCOFD149TM9pxNooDFdJXC4jtHGPZ04LtjDagxND7mn7ENHND0wsSj92gRIEyqVAoSg/aCM0VN+ot9iSGKSBYfVUD+/02ESbpjUOuLYngMeTqI5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjKizhDaVxH6SVaOtD3IKFx9Mu0ZVYHXfGAOHP81juE=;
 b=Ac9CoakDdk5DyvTEv+LMUtDt9EPMN5DtklJMi29zMN+BLAWA+vHFFB9rttJ2nn3C97nz07MAQhbjiEhfVthQ3TfS7io0aQbqoFBkg8R5dY2ZWHWtfmR8DUJP4yngBhk3xg6OAHOWrfgEy50609vze6k+II6s2pinYRx8xCQ/pG6blN3MaCbFFHWY+C+m5NkLPQTWRCjczTrMpRdB/+HBTz+NhDNulGRO5CJD3D2HmtrvyuJuDFYZaU+KD9d/9KtSBTlvy/elM2x2n23ahAd8z72R6X3Uhf1XfhPwNWKeaCuc6zcFwX4cSARIF4NAnK5JnUiww82LcrG1o9cJN97jzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW4PR12MB7264.namprd12.prod.outlook.com (2603:10b6:303:22e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 17:23:16 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 17:23:16 +0000
From: Zi Yan <ziy@nvidia.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Youngjun Park <youngjun.park@lge.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>,
 Michal Hocko <mhocko@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH v3 03/12] mm/huge_memory: move THP gfp limit helper into
 header
Date: Tue, 21 Apr 2026 13:23:12 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <125AABD0-02D5-4656-9F55-4B5BFBD5BD3D@nvidia.com>
In-Reply-To: <CAMgjq7BDmGWaVWBL+52_c=jgs293bgB+Qe-MafKE7dWZRsmx9A@mail.gmail.com>
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
 <20260421-swap-table-p4-v3-3-2f23759a76bc@tencent.com>
 <D631DCC9-85F0-4E68-88A0-AD5DE328818E@nvidia.com>
 <CAMgjq7BDmGWaVWBL+52_c=jgs293bgB+Qe-MafKE7dWZRsmx9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR04CA0195.namprd04.prod.outlook.com
 (2603:10b6:408:e9::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW4PR12MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: d208b36f-e11f-4766-3da9-08de9fcaacf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	KqPhUQXuFX4PRDus2f599rfQ6tMC9i7bJVbHPIh/fL0PCb8Aj9biQyPiSRhkIUmpNsHBnnoFefPaOPO3XJN/g4N7sLqGJ0KMiCYn2IYOcopcLMVGVcEJkKpdyh/wxR9rkrrHS7WV6fHJfArmCTH0Rz7LU8+cT/wAnd0QdaTSqwwfnPfOnnLUxIu7zqvRSfNvB/rp5g8Px+K0w8MukLI8Yyg6NjlaB93ysvmRqDRjxowva9eifCMS3DpKY3NyTT/zt4Ylt1ZYyvlF6qxpzq5Q1xBWDIFADl92UXVL4t1mgJrtEaT/OSXT75b0vY9OEtLpmAduZvRH2VGVQKN2D4j8JrbMTVuyqjwejEC7CtZO3QWLDaKQ594fFLk/4wVCdTh9Kvhsr4/ixurfeDboqkTNkW9wTbTdJMIYMpCBfYReWTjgvMHIhpwXqo+0QLC16bszfF0mggPoYtIVm/tiOqfIY294bFYHBawQy6NuEMCriwCZCgaEH/9an27IAC4LExc+aZFw/M+FfYI/mzjTIIlB5RLtigFIrbU70YVRvqa6b9IDMyQ3aZ/iS2PkciYcFlO7DjBciJLEPVbyIeIQbY6NkRfyOjOJ3CA+sVtcEvK7LbnN2LvbzfJiEM1vxTaBiSAYHPW3TJAj9bohzBqf+xwQBUkmq/fRB75+mmxN58keNCRzpuYhWTcK93hhb6R3kaS7oUgvhzgy11eQMPhueP7pfxGwfpDLqb01scurtsx7IyI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjVnVDBSaWZ2N3pndk5nWlluaVBOYWI0Uysrc2doN1A5UGxMdllwQXBqNmF4?=
 =?utf-8?B?L3E3UWJwcGoxQXlBd0VpT2tFVVcvRXlKNmVkeWQ3VEV2RTZxUFNzcVV0S2M5?=
 =?utf-8?B?cCsyazROanFaTFd1d0N4ZCs1N1c4MTE2TlV3Y09wNWhJTngvcGRUM0dxT1NV?=
 =?utf-8?B?RDlLWUdDQXV3S2swUXdlTTFLSjlTS2dsRFo5S01qc21kU0NwWHVpdjd0Undi?=
 =?utf-8?B?dnJlMWthSHlHUnFsQkxkdDMvQ1Y5ZzV5NkhlQkNyOXB1b1ZxVWFKMXl6a1Yz?=
 =?utf-8?B?VmNTV2hDUi83N2hsUnc4Zk9kRDBydXpkOTVZcEFKRWsxbWhSQ0hkYjBaZ0xa?=
 =?utf-8?B?ZlhuK2Eya296YmNDTlNPVEZwb2pMV2s0WkpCWjFZbmFCQTRaaUVrT1QzVklT?=
 =?utf-8?B?eG9HNWI0Y1czNDQyNXNtSWsvM2w2WmVzZU1WME50bHlUM0JlWWxwZnRNdFpI?=
 =?utf-8?B?ODQ2cGlWY0NHbVRyZU5lZys1cUhVY0NYbVFyQjRMTC8vSksrdHlYS3EwY1R1?=
 =?utf-8?B?MWRxWk9KYVovV0pBTVBtTkdhR2hhMy8xSEFuSkw2Ny9LcnlNYnlCbDcweUtp?=
 =?utf-8?B?MWxoNzdmeFRPTWhJUXo1bGtvKzJhVjE3aWF3dzVLOG1jQWE3YXRSYmFEZS82?=
 =?utf-8?B?ZVFET1Z1N3dnakZZRFNHWVVWdGgybk9BT3gwQ3RTUDg0Qno1U253NC96RmhP?=
 =?utf-8?B?MEt2bXUwajJ1d0NKMXltWnZYTjBGM05IZ2txdFlIbk4vY0Y5ZGFCYlNYOGVM?=
 =?utf-8?B?cm5yNENjVjNoTnFDOXhnSVAvT2svRlUzV2lYdktOZHY1YXBVOElQaWJLcFFR?=
 =?utf-8?B?Z1pqNkVYL1lNUDhoM0dhQTgvZkR2SXNJYll3T2txcjlxTk1uSldGdU9EeWVy?=
 =?utf-8?B?Zk5HQVNzeEtjU1JEVTEweDhLRUtEY0tIZFViOVVMRGVxZXY2bzdMdzdmakJH?=
 =?utf-8?B?K0tzd0hQZlppWkdNSlMzSGR2L0g4bEExcW9nUXZtWkVmOHdWUDhva2N0MUdy?=
 =?utf-8?B?Q0tIMlIyZVFIbmhCbW56cWU5SUo0OVBwblhSZEwvVHUrNGFoL2VzNEJzeDVy?=
 =?utf-8?B?RVZIcHNGVU1UZ1VlbHRROStMMmEvYTIxdXlyTjZjQmVGQWdsWTFXMWVuVVBa?=
 =?utf-8?B?Sy85djkrUm94MEQ3aytrc0dPTVZvYWFiUy94VXY3bk5IVnpzbmFNV0p2ZThW?=
 =?utf-8?B?V3gwWTVTYU0wYzVnL2czZFVpd0RZTnc4dFdMUSt2dDc5eDArais2WXdVU1ZK?=
 =?utf-8?B?em8vN1lENzdveUVwekllUzhEdXVDNEJleVZFMUt6aFIwMWg5bVNRRjlZWmVa?=
 =?utf-8?B?aXFvaGwxR0RrZ2oxcW5DeUQ2bllrVWY1MDl5STQzRkdQWnpNK29WcGhzVWlZ?=
 =?utf-8?B?OFRRTHliSGsxOVdveHlFTlJQV0hZRFg4T3VYcjNJVVJaejRac3VId2F4VjZS?=
 =?utf-8?B?YWVrV3dVdTlrbFc4Mzdtd28yK2FLTnp1elVhdkEyMDBlVlNnK29heVFaa3Qz?=
 =?utf-8?B?NzZ2bS9sTERGRDdWOXhjOWFnM0UxVGM4djV2K0RsQzBUL2kvdjNmUWZrcUd1?=
 =?utf-8?B?b0VWMXYzcW91MWJsY2o0T01SeEttb3BITGs3bUJaM2lBcElUVEpxZStCUEZH?=
 =?utf-8?B?blJDbTNPcEFPVkFjQjQvOEpZaUlWQWdZVDY1REJlMkQwZFlGcjl4cVJMcFdU?=
 =?utf-8?B?UWF4N1VyaEhWUHhDeWNGY29BN09ac0N5QjBPYjlKQnFPRUg0ZUJFSmNSbjUv?=
 =?utf-8?B?TzJCQUdnSmRrajVzNEIreFk0N21sb2EzOHVqOUhYUnpud2VCVndJQ1Y0NUZV?=
 =?utf-8?B?ZzNlaWdjdmRGaXRDMEZqSWZVQkhDZElQVFVBU3BIQTg2cWxxaVdYRTM0VHJG?=
 =?utf-8?B?bEZGeDZzbVdUb2Uzck1BaEdvVEhJUXNxS25XTDFPTjNoazBrZkV2blA2WTgx?=
 =?utf-8?B?THRPNnc0ZHdqcWV0L2NJaEZDYVA4VldRWVJ1SU14TDh6RXI0bjlJUGw2QTRa?=
 =?utf-8?B?MGhndnBRcy91NkxnMnFTVHRHbHpEUXlsbk5zUU9ESU1xa1JMaU1UbUM3Q2s2?=
 =?utf-8?B?SEUydDZON05UMXJhZHh5VlE5TitaRVkyNUNpSkMwN3NuR2F1cDVyejFUR05B?=
 =?utf-8?B?dXAxYTRxK2pXd1poV3cvVStNcDIrbGFxNllaRkRlbjc3YWtzZzZxd0kxUG5i?=
 =?utf-8?B?WHVhdngwcjlzMGdUQkYvV3A5VDBvUmJ5TlpvTTA0aXlCOVY3cFdBOXdtTGRU?=
 =?utf-8?B?N1kzeG56YitxQzFsbzE1ZVV2d1RWOHpkaGV4L3oxeU5NZ0thaUxIVHdQYk5T?=
 =?utf-8?Q?X/Nr4PE77LT7AMTvHD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d208b36f-e11f-4766-3da9-08de9fcaacf3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 17:23:16.7992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0La98lfGxZwIURx+DUGZl3DBgpSNvOCA8BwV5wYinpNdjugHRLqMaS4V7bc9vI4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7264
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15444-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,tencent.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E07443DEB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21 Apr 2026, at 13:21, Kairui Song wrote:

> On Tue, Apr 21, 2026 at 9:14=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 21 Apr 2026, at 2:16, Kairui Song via B4 Relay wrote:
>>
>>> From: Kairui Song <kasong@tencent.com>
>>>
>>> Shmem has some special requirements for THP GFP and has to limit it in
>>> certain zones or provide a more lenient fallback.
>>>
>>> We'll use this helper for generic swap THP allocation, which needs to
>>> support shmem. For a typical GFP_HIGHUSER_MOVABLE swap-in, this helper
>>> is basically a no-op. But it's necessary for certain shmem users, mostl=
y
>>> drivers.
>>>
>>> No feature change.
>>>
>>> Signed-off-by: Kairui Song <kasong@tencent.com>
>>> ---
>>>  include/linux/huge_mm.h | 30 ++++++++++++++++++++++++++++++
>>>  mm/shmem.c              | 30 +++---------------------------
>>>  2 files changed, 33 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index 2949e5acff35..ffe5a120eee4 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -237,6 +237,31 @@ static inline bool thp_vma_suitable_order(struct v=
m_area_struct *vma,
>>>       return true;
>>>  }
>>>
>>> +/*
>>> + * Make sure huge_gfp is always more limited than limit_gfp.
>>> + * Some shmem users want THP allocation to be done less aggressively
>>> + * and only in certain zone.
>>> + */
>>> +static inline gfp_t thp_limit_gfp_mask(gfp_t huge_gfp, gfp_t limit_gfp=
)
>>
>> Would it be better to rename it to thp_swap_limit_gfp_mask() or somethin=
g
>> more descriptive? I am just worried about misuses in the future due to
>> the generic thp prefix.
>
> Good idea, I wasn't sure if this might be helpful for any other user,
> but for now naming it more descriptive does help to avoid misuse.
>
> How about thp_shmem_limit_gfp_mask? Ordinary swap is fine with thp
> gfp, only shmem is a bit special.
>

Sounds good to me. Thanks.

>>
>> Otherwise, LGTM.
>>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>
> Thanks!


Best Regards,
Yan, Zi

