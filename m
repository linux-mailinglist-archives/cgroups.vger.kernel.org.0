Return-Path: <cgroups+bounces-10399-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ED2B96981
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 17:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 485DC7B1168
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 15:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB0823C8D5;
	Tue, 23 Sep 2025 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HrICihJn"
X-Original-To: cgroups@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19700212551;
	Tue, 23 Sep 2025 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641497; cv=fail; b=GPFJbhDN8KSaXb65wuuex+1ixaIedZM7hMdbPHpLNeMhiIgH0m8O+35NkzOpxG+fd7D5x/+la8ArmXf4S7RL7XdozH4KzhKlRb72IDX7JzzR627bnKR6hakWQpDBgXL3FHnFZuKTuaf52eBP/QuM1u/NP9SwnBaMUQDtP/LX3aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641497; c=relaxed/simple;
	bh=swAVUfKCIe+r3KNO2dPr9zuRK2JjDWC1lpLFFQ0uzeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mVexf9+N2wNr0vJjVFwc4PvV/nIq++oIxGxj+VWqSrUCnGRuQAPX3ZWT5O+DqUsh6FM/1Q3SyRjqgzT1/SchA1l1+OvitjCsUrbZmQkGk6Xa8SsnhoH/Adtk7CHrKwf+U9C8IWVwNBHJEW/cyBw2KbZRpNPCfz9xQcRUM4C6y/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HrICihJn; arc=fail smtp.client-ip=52.101.193.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/Y8BiLsY1JmLEr5lAAAbYSHC0CyO/EA0kzr01YELU0/LShiANgMfB+Lf+TvUUEE+PebsDm9kWY5uAiNcil3UKb0gc1bZSyyVMApWm5ttKYZ5hMsH8C0GrvHJVNLkIHpcSvkYE8lByHjps+2KXct5fK1sHGMPTqF3ncNx9E0u2E1RAywyv/Cp7nHBE7aZzLEYYjRXPNohE+ZFsZW4Hwl91U5yBVsxANl1MGfP1Zfwj3Efo7gIrjLkW7u3ft/m+a/3O/VukOvSd3Z7sXFjUPEB2x5pVCQEDYYZBIeUHZNqQ7VX0adFaOy7xpW6y82GVNShLwCEVfcxNIagCvpum2UjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz7+h+bKvKAE9MHndOWwDku849T5BhmJ13bcosQhQkY=;
 b=njfwH/2tigeUS5LnbXCrrS3HLZbzRXEQ7OPJw/RTkkfpZPF9IB9R+O5QeCQM/O2kBf6wTgO956drCfYapJXbchVj/+x+1Df0ZmCTRb3duOe858nXQAQbrXsa//U5BMLk8uEvMSl+2v7ptxTRD4H7E5jXtj9rCFgMpbalUpXpTbPplSYjG3L0lSSxnW/T/7nxZucY9OmnHS8KSSCU1k8YHyG61DINFG77ndURz2ct9x14N2i2IjERc5mphbAFEIWWtN3dZFqZa18HUYMxKw6IkP5de6RC6ZHPJN6Qio4MYqcdIB/6MWh0BQMIlcFCIEyQiWbAeygXtwsld6UQib3PgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz7+h+bKvKAE9MHndOWwDku849T5BhmJ13bcosQhQkY=;
 b=HrICihJnIPMYic1rqluXN4dk+lxeM7dJPbs1daXmpj7mfVfuQOSniFAWsFH9RY9tLTupg+c5LdNCeYGO97pzz5p4KzYqNTPLIf6iGNOHCI884PiGqDRQrSxiPOqO/1LcZuQCOOlvx00ATHVtV+zCwwxAnO4BcEhSzFJNWQrRokOO+nTBx0feJz8gIEtj0kmtf1nk2/kCdawc7hJsO7XSsbedGdFRc5wiZKDV57jOpL/g03swDNrQd2yjn+BgSCbDNCWu32rKDWcKWFeN30jQVDPGdVCIv3FlBIu3jkFvUj7QV66QK/m+IKmkPyWtpdr+V4yv4SFwKmfOgjBRm5Z0pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 15:31:27 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 15:31:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, harry.yoo@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2 3/4] mm: thp: use folio_batch to handle THP splitting
 in deferred_split_scan()
Date: Tue, 23 Sep 2025 11:31:23 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <A64EA303-74CD-4CF9-B892-C0FF9699F3FF@nvidia.com>
In-Reply-To: <782da2d3eca63d9bf152c58c6733c4e16b06b740.1758618527.git.zhengqi.arch@bytedance.com>
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
 <782da2d3eca63d9bf152c58c6733c4e16b06b740.1758618527.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BLAPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:208:32b::6) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: b18cde6e-c3f6-4f59-21c0-08ddfab6429c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eC/AfwKFTzTddYa/0MCBxkLePEV1XMkFa6DjcDWK3zOHTu2DEfOQV21IWEuZ?=
 =?us-ascii?Q?RkqUSs3KZVenbjDddhJCwpsy+ZTafSs27lSGRYTeDyuVqflALmWEh9sbNfBL?=
 =?us-ascii?Q?WsZ4efNvUlRI5TgK5KN9WUhC0nen1gcaH5ogGSFkx4NZlnqSkzyZSl9+2cpq?=
 =?us-ascii?Q?zjhqvVh0w7wEQ7kFvMoIMZtgTFi3RHsoiVP/8ehfieg9jZxg1TBb+DjQDIqM?=
 =?us-ascii?Q?u1jNo9jaqrPpQ0K/TmSPP20QwS3jkr3ZWAJe3dCmy9sM9PwfO8ghlYFKHpvs?=
 =?us-ascii?Q?rt2w4VgBUlye4LElAAj+DmDCbPr7ScXbNb2DLxHluY371y/KDRACd8+54BO3?=
 =?us-ascii?Q?Kl47KXjvv6UhrrwZ3pdv33/1L0KYfpqaCtKmbdUsKQrHpoNIZE0pGVwLnBbn?=
 =?us-ascii?Q?lhNXx9xn69/x4nABaLo9C4qcyZJL0z/iIHlo3ZqO8p+En/g86Q0W8G3TvhBO?=
 =?us-ascii?Q?SwG5y0c8IeO2JfqYjSLym/5Ie0AUNvScUpaCJZKWRwwigNhIjZhHkm72M51Q?=
 =?us-ascii?Q?VuWz7P2NsbC2dABz/v+UIH8orC8lde8Br/w6IioH8167YaJYiNPTnaZqh57o?=
 =?us-ascii?Q?9JLmTySrwfUUEvAFZ+p0IiljoniQn+JFL8kn1sx/gLoKTpjwekfiA2tabSth?=
 =?us-ascii?Q?T8QYs714mLgY7oVhBuGG4Vlcxam8JAXOBOnZBjlIqgbvZidTcRT+57XFWfdI?=
 =?us-ascii?Q?pdulgmiPcMQ5fzpUVtwBSpcFRrTirzUb0Wd7llV9T+hEJAz+POmrBcbmSLyX?=
 =?us-ascii?Q?nyWyjZNpAAzO7e2TJq+NpQsfreZ6jDBH6iX8AiFJouCiCcOe7Ir5r8/bJnk2?=
 =?us-ascii?Q?WzAzEeiqXsRvBlr5EH9czmdIvU6WxDXjAV2zadrck6sBvUQdfEXFArzIwkAK?=
 =?us-ascii?Q?XqJxHVGbvhWdEwm2YjNO+DDUVMN8xCP+CDODNAwjk/PShks1ym53XGaSC9SS?=
 =?us-ascii?Q?anIRYW0K5JYmqeJy480HIiyLQw9lzPgiO4oMdwcNAw0eH22rb2FlOtEg+PS3?=
 =?us-ascii?Q?SstKMPI1252YLxqG0slhp5Dgy12Z3+tVUbs/Q1TzowDbfLSkrpaVqG8NCOxa?=
 =?us-ascii?Q?dLQO11CsZesazJmoE0jYzERh5v9IRMqlZT6XzeitYpjlO7IYmZsYfaRXfKHI?=
 =?us-ascii?Q?t73h6JdpwVobAjgNyFMSezWBw+vcwKl7hFPNZXFQiulIssjmkwBHI30OLHI0?=
 =?us-ascii?Q?GL04kc3hntju8vEqpykUQZtdKBnB4HJSc+805z2sSLec0jwdvnF0SiLY9Um8?=
 =?us-ascii?Q?Ho1jkkQrbOuL+L+Vo21kVqlPd28tHSahaKUkkFkVLW78Di8HiTvtXXgN3WUw?=
 =?us-ascii?Q?FOHKy4uXtVdrnKI6j9fCuLOsGMH22yP2ZVrMG6OKHoWtAm3RinIGqOmqMp9p?=
 =?us-ascii?Q?Trxerw8QLUneeMGLRgXzRy7qpzu+OMHJLZr/Z6EMLiMC8g7VXFKO4d7/UjGD?=
 =?us-ascii?Q?5cWY5hr3MBQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TK5B2Pb7WiZfL7Rcnd+5+RkbjUEfLKyXtEIGaadvKgCxjchzx4lqcCNZUKh1?=
 =?us-ascii?Q?eFMCOu3C2pA+cdpiodhJWhyHo+aOFKHF/BpsV8XJj5Nvksk1HkglQJrvDoJK?=
 =?us-ascii?Q?B0VBrtHY/v2SCopsI7P54sKHvzSj/W9oBfJp3E2F4wTLUH0TcBbVKQ7jJlam?=
 =?us-ascii?Q?VXlOViP+Dtua2KcSe7gjlfsK2s3790eU1T6Hm7vSY1eOf/Wbc2+IRi7Gzv/m?=
 =?us-ascii?Q?i/Hwj4H1EyOXlJ7r9QRj3jXe9lyBZFBxA16oljqIEfJ9Xjt3kFHxbQkgwTXH?=
 =?us-ascii?Q?jz5jnAxvB+vpmWJh3OyRGeUv08LloO4koqdfBAlhz1XZQ3SxFH8H2B7/wxfm?=
 =?us-ascii?Q?bf/9nZilZdQXSer6qmP6Z9vctD7sIRwHTWbeLwrthCV54IiwUdZU7GxTlaan?=
 =?us-ascii?Q?DV2w4U3t5GJVZoCSrePGHHLyAmrxFz2VR8li6p14O7v9l4zz/Hz9osht5bEn?=
 =?us-ascii?Q?Qellbcbdtl+vDm4NUeAcWHdoI+EpZtrFbGO0MzvKzVag72f+rKiFi6bLqkld?=
 =?us-ascii?Q?urLp6vMuxH22VnmahrS1vjO44jZvb74Ivgxju2/oYmJLIxL0iHzvZI1XAqyF?=
 =?us-ascii?Q?vDRfa4yxZAA8OKwXEgG+rTb8ANRgeU7B9iOvXf9L5JIg4pO8GiBYmmmwb9CB?=
 =?us-ascii?Q?WlE1S2J7YyzihkSCMeohf4CN+XpsfUADbSS0dUaAVMb+5sKDLCT/0Ja0tlQR?=
 =?us-ascii?Q?CjuGUwy8z5WjRjKuTPFsDmmPgHpp6g9EfNp6YXJaxT2tNeVVuRI2fvNnNMkK?=
 =?us-ascii?Q?9Rld4fY5MEOE++3AS8gbvQiRHZ3RYFaS9Lv5wwr16MKi0zolVkFiv2pHJKLJ?=
 =?us-ascii?Q?H4EAh89lQTRy3fyxYO44VeYIYPBHZwSaHSvuSoAIKpC/HwazsmSNQm65P4Ra?=
 =?us-ascii?Q?pBfb0l5ZZO6e5LIlFy/3VjGAxZ04pqHMFF2c3ug0M1YwR98oIpu6pTR99GDs?=
 =?us-ascii?Q?LieqbBmh0hPDVIGdSURQVvC25x8Eo4nmrmGuIDI/fPC6zSEN3dHVKjy/wfzq?=
 =?us-ascii?Q?ZpGtmZsVkddL3DMQ36TeO3B4xE9p3fAwwwdRFv/w+oCVTKMCIWeSNvREseh9?=
 =?us-ascii?Q?cWUHK1297lQItXRiWdF2er9JjcXoqOurRLaNeEpk82CoeQnWZTlg1u33/lVp?=
 =?us-ascii?Q?Y7lr3O1/IYt46JcIcF+wMSdvfpknTMHPPQ/xYMS96Y+1tC4lM5yizxrFygbv?=
 =?us-ascii?Q?Jko4sWGGIJNhJ+qcmgs800XohC9h6ggM74y9obRpDu+/iGdoXhrQ0YLeUCS1?=
 =?us-ascii?Q?+wGjDAWHd5XDdpxUV/Yr/TiGK2evHL3wb1B3qtkYDe3ikZRJ0fjLhv2/bGLr?=
 =?us-ascii?Q?chx5t6pL9yd1XQwgSPCmMBwd+ccJGo6IACE2Pml1/AG+4BMfzEL+f1onFg7K?=
 =?us-ascii?Q?myZt+s4LlC6GNw/56ezeRft6O+Po3T4JNSaS/WYEgaWboZwsaPAiyvM1FvMX?=
 =?us-ascii?Q?LkqNSX4qnRojY+CSSV67tg5Hkg9hLIfRzMdsXa2I5gF6kRBZxWYwHGGCW+cE?=
 =?us-ascii?Q?N0EIHh4dQy2aWf4uh7SNyAjbYc6lQZq+DN45SP419JahUhNflCtxUR6sXPI0?=
 =?us-ascii?Q?jJvaA0MM86/SMEPUP2lMeStLpoExMT+Xm2RqiQCU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18cde6e-c3f6-4f59-21c0-08ddfab6429c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 15:31:26.6738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEb9RsW4O+H4LxyrEfWXOJnIkRKH2wwK0tN1q3rlTGePYhNu1VXEVOuw8E22WnXv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601

On 23 Sep 2025, at 5:16, Qi Zheng wrote:

> From: Muchun Song <songmuchun@bytedance.com>
>
> The maintenance of the folio->_deferred_list is intricate because it's
> reused in a local list.
>
> Here are some peculiarities:
>
>    1) When a folio is removed from its split queue and added to a local=

>       on-stack list in deferred_split_scan(), the ->split_queue_len isn=
't
>       updated, leading to an inconsistency between it and the actual
>       number of folios in the split queue.
>
>    2) When the folio is split via split_folio() later, it's removed fro=
m
>       the local list while holding the split queue lock. At this time,
>       this lock protects the local list, not the split queue.
>
>    3) To handle the race condition with a third-party freeing or migrat=
ing
>       the preceding folio, we must ensure there's always one safe (with=

>       raised refcount) folio before by delaying its folio_put(). More
>       details can be found in commit e66f3185fa04 ("mm/thp: fix deferre=
d
>       split queue not partially_mapped"). It's rather tricky.
>
> We can use the folio_batch infrastructure to handle this clearly. In th=
is

Can you add more details on how folio_batch handles the above three conce=
rns
in the original code? That would guide me what to look for during code re=
view.

> case, ->split_queue_len will be consistent with the real number of foli=
os
> in the split queue. If list_empty(&folio->_deferred_list) returns false=
,
> it's clear the folio must be in its split queue (not in a local list
> anymore).
>
> In the future, we will reparent LRU folios during memcg offline to
> eliminate dying memory cgroups, which requires reparenting the split qu=
eue
> to its parent first. So this patch prepares for using
> folio_split_queue_lock_irqsave() as the memcg may change then.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  mm/huge_memory.c | 84 ++++++++++++++++++++++--------------------------=

>  1 file changed, 38 insertions(+), 46 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2f41b8f0d4871..48b51e6230a67 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3781,21 +3781,22 @@ static int __folio_split(struct folio *folio, u=
nsigned int new_order,
>  		struct lruvec *lruvec;
>  		int expected_refs;
>
> -		if (folio_order(folio) > 1 &&
> -		    !list_empty(&folio->_deferred_list)) {
> -			ds_queue->split_queue_len--;
> +		if (folio_order(folio) > 1) {
> +			if (!list_empty(&folio->_deferred_list)) {
> +				ds_queue->split_queue_len--;
> +				/*
> +				 * Reinitialize page_deferred_list after removing the
> +				 * page from the split_queue, otherwise a subsequent
> +				 * split will see list corruption when checking the
> +				 * page_deferred_list.
> +				 */
> +				list_del_init(&folio->_deferred_list);
> +			}
>  			if (folio_test_partially_mapped(folio)) {
>  				folio_clear_partially_mapped(folio);
>  				mod_mthp_stat(folio_order(folio),
>  					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>  			}

folio_test_partially_mapped() is done regardless the folio is on _deferre=
d_list
or not, is it because the folio can be on a folio batch and its _deferred=
_list
is empty?

> -			/*
> -			 * Reinitialize page_deferred_list after removing the
> -			 * page from the split_queue, otherwise a subsequent
> -			 * split will see list corruption when checking the
> -			 * page_deferred_list.
> -			 */
> -			list_del_init(&folio->_deferred_list);
>  		}
>  		split_queue_unlock(ds_queue);
>  		if (mapping) {
> @@ -4194,40 +4195,44 @@ static unsigned long deferred_split_scan(struct=
 shrinker *shrink,
>  	struct pglist_data *pgdata =3D NODE_DATA(sc->nid);
>  	struct deferred_split *ds_queue =3D &pgdata->deferred_split_queue;
>  	unsigned long flags;
> -	LIST_HEAD(list);
> -	struct folio *folio, *next, *prev =3D NULL;
> -	int split =3D 0, removed =3D 0;
> +	struct folio *folio, *next;
> +	int split =3D 0, i;
> +	struct folio_batch fbatch;
>
>  #ifdef CONFIG_MEMCG
>  	if (sc->memcg)
>  		ds_queue =3D &sc->memcg->deferred_split_queue;
>  #endif
>
> +	folio_batch_init(&fbatch);
> +retry:
>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>  	/* Take pin on all head pages to avoid freeing them under us */
>  	list_for_each_entry_safe(folio, next, &ds_queue->split_queue,
>  							_deferred_list) {
>  		if (folio_try_get(folio)) {
> -			list_move(&folio->_deferred_list, &list);
> -		} else {
> +			folio_batch_add(&fbatch, folio);
> +		} else if (folio_test_partially_mapped(folio)) {
>  			/* We lost race with folio_put() */
> -			if (folio_test_partially_mapped(folio)) {
> -				folio_clear_partially_mapped(folio);
> -				mod_mthp_stat(folio_order(folio),
> -					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
> -			}
> -			list_del_init(&folio->_deferred_list);
> -			ds_queue->split_queue_len--;
> +			folio_clear_partially_mapped(folio);
> +			mod_mthp_stat(folio_order(folio),
> +				      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
>  		}
> +		list_del_init(&folio->_deferred_list);
> +		ds_queue->split_queue_len--;

At this point, the folio can be following conditions:
1. deferred_split_scan() gets it,
2. it is freed by folio_put().

In both cases, it is removed from deferred_split_queue, right?

>  		if (!--sc->nr_to_scan)
>  			break;
> +		if (!folio_batch_space(&fbatch))
> +			break;
>  	}
>  	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>
> -	list_for_each_entry_safe(folio, next, &list, _deferred_list) {
> +	for (i =3D 0; i < folio_batch_count(&fbatch); i++) {
>  		bool did_split =3D false;
>  		bool underused =3D false;
> +		struct deferred_split *fqueue;
>
> +		folio =3D fbatch.folios[i];
>  		if (!folio_test_partially_mapped(folio)) {
>  			/*
>  			 * See try_to_map_unused_to_zeropage(): we cannot
> @@ -4250,38 +4255,25 @@ static unsigned long deferred_split_scan(struct=
 shrinker *shrink,
>  		}
>  		folio_unlock(folio);
>  next:
> +		if (did_split || !folio_test_partially_mapped(folio))
> +			continue;
>  		/*
> -		 * split_folio() removes folio from list on success.
>  		 * Only add back to the queue if folio is partially mapped.
>  		 * If thp_underused returns false, or if split_folio fails
>  		 * in the case it was underused, then consider it used and
>  		 * don't add it back to split_queue.
>  		 */
> -		if (did_split) {
> -			; /* folio already removed from list */
> -		} else if (!folio_test_partially_mapped(folio)) {
> -			list_del_init(&folio->_deferred_list);
> -			removed++;
> -		} else {
> -			/*
> -			 * That unlocked list_del_init() above would be unsafe,
> -			 * unless its folio is separated from any earlier folios
> -			 * left on the list (which may be concurrently unqueued)
> -			 * by one safe folio with refcount still raised.
> -			 */
> -			swap(folio, prev);
> +		fqueue =3D folio_split_queue_lock_irqsave(folio, &flags);
> +		if (list_empty(&folio->_deferred_list)) {
> +			list_add_tail(&folio->_deferred_list, &fqueue->split_queue);
> +			fqueue->split_queue_len++;

fqueue should be the same as ds_queue, right? Just want to make sure
I understand the code.

>  		}
> -		if (folio)
> -			folio_put(folio);
> +		split_queue_unlock_irqrestore(fqueue, flags);
>  	}
> +	folios_put(&fbatch);
>
> -	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> -	list_splice_tail(&list, &ds_queue->split_queue);
> -	ds_queue->split_queue_len -=3D removed;
> -	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> -
> -	if (prev)
> -		folio_put(prev);
> +	if (sc->nr_to_scan)
> +		goto retry;
>
>  	/*
>  	 * Stop shrinker if we didn't split any page, but the queue is empty.=

> -- =

> 2.20.1


Best Regards,
Yan, Zi

