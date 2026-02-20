Return-Path: <cgroups+bounces-14046-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFzuKcmvl2nO5QIAu9opvQ
	(envelope-from <cgroups+bounces-14046-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 01:50:17 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF42F16402D
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 01:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CF6C30053C7
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D982236EE;
	Fri, 20 Feb 2026 00:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UnPzSo9w"
X-Original-To: cgroups@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9AB18A93F;
	Fri, 20 Feb 2026 00:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771548393; cv=fail; b=elR1dltWFpO+OBGT7YnvPRzn+ETbfNf6/mx8lF/P1WorK3i1SUivCQ9D/0b2Sfkr2BEvMCf1FetqyP2JwL5T8mjAk5/VUTza0HzdTK87ZapQOYMFLQ6/B0natyZQEbGDZ1cgxeLkKA/81QLq4DHk3mVEeycEYLhN23/GwCkICdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771548393; c=relaxed/simple;
	bh=r3lIg35qaDS46bvIDHfiWfJ6KvJDTgtTco4eGxvCLRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XRzbvh17dT5P5VuQBKiAv1TQPEcU07pq5/2U91X8enusPxcQ+xsmtgD0vCfT3Il+WEUybTzm8ryTxcBU+DqOasOSNZkQE2nJ7cve/ei+1aTr1MGyd4FaIOVKeOusyBMskts5BixBMKEzQC2/cffmK9uIy3t7VRJTKf4UpSh2sBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UnPzSo9w; arc=fail smtp.client-ip=40.107.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4rsDvUiahlJUOPVSy7ST6G2TqmCtWgaYqaYJpZ0RrfJn3WdbKVcxbhw4f1KN34+84n2oHzkCz+8bnA7B5F5ntNtNNg6+wPcxCAZ3fmsMkWaFHIKtLmBI8k/NPxSwuIkeFgudBPpUxT22IYzI5mlCcMLBwWGFlPXvC56b5uOjhutOTIezsv+O3qaaodosqugz2Q/ZT94teZz8uoSadJWpD0C45aQh5FRYCIKez/yHp13Sjdk207nxPSCrfXjrUXrLATyrVgoffDkgc+Muy7hgowv65mZGmPDKpzU1zw+n3dH4uPhnV+oiy57rPfvhW8YSKLN4b/ftatdzHq/ouq8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNGla3EPjchP1bGq3rV4aRSqGWhqTv4q4Prc7DIIGcU=;
 b=e+lr8dESb0SWjhwoqjvfAyBb0dD4x6emSRVZ2v4UEhZJhE5qfeyxSmHto3LBdYGYzls4k+wD7AYvg8h2k/8FJsPvbTCnrU9JqmRZ4PTxL56ySVe/bOY5NI1jadtvFTSGvPUF7t6itMqtIF6matr0LvXDINRnDCJLQFXJh51ZurThmtFX41a/5+k785Uz8uBeP43D1EwyiGZb4EqbjyZrQTrxXA+K4IcgemPMooilrHyoN2fMRXf7hlXAcNlv+FWGG/7LMd0X5xb5wDIzdPgpwr+t0pgk/3nIW7mvc5uniU9mtSEDicmPc/jEyDoVfQfjrf74g9F6L62fdTnGKo2cxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNGla3EPjchP1bGq3rV4aRSqGWhqTv4q4Prc7DIIGcU=;
 b=UnPzSo9wtK+vN0BQPMew2w3BV6MtMKaIfTUte+Pv1Ru1ouFQToY89pK+MlNQbW/CK1EOEsu3p47DNooaJQjUpPzE8dcjdUZHg8ZXb0uoqDQ8oVQBtx9OacZxxmsOk5oHerjxnlhJsGkAnr02dfHni9CZFjF19J6046XAX2rWvQ6aiS2liPmD7qq71mqFF1jYKKb7nOzUX0zPYlXoBzJtaZOEa4dR90Ex+qj7w/bMDJ5eqUJ8iVC1rjsLoDWpR01vXraHJ7gT/INAcX7TUV+LZEgzCEuq+R6h5j/29GB5QJ/kf8Bb2ax8DEvlr5ykdhWQ/d28185uGs4plXmLKj8bag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.15; Fri, 20 Feb 2026 00:46:24 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 00:46:24 +0000
From: Zi Yan <ziy@nvidia.com>
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
Cc: linux-mm@kvack.org, mst@redhat.com, mhocko@suse.com, vbabka@suse.cz,
 apopple@nvidia.com, akpm@linux-foundation.org, axelrasmussen@google.com,
 byungchul@sk.com, cgroups@vger.kernel.org, david@kernel.org,
 eperezma@redhat.com, gourry@gourry.net, jasowang@redhat.com,
 hannes@cmpxchg.org, joshua.hahnjy@gmail.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 matthew.brost@intel.com, rppt@kernel.org, muchun.song@linux.dev,
 zhengqi.arch@bytedance.com, rakie.kim@sk.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, surenb@google.com, virtualization@lists.linux.dev,
 weixugc@google.com, xuanzhuo@linux.alibaba.com, ying.huang@linux.alibaba.com,
 yuanchu@google.com, kernel-team@meta.com
Subject: Re: [PATCH v5] mm: move pgscan, pgsteal, pgrefill to node stats
Date: Thu, 19 Feb 2026 19:46:17 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <FEEA24E1-D62A-4378-9D80-04E8BFE6D6CD@nvidia.com>
In-Reply-To: <20260219235846.161910-1-jp.kobryn@linux.dev>
References: <20260219235846.161910-1-jp.kobryn@linux.dev>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8097c2-16d5-45e8-3cf1-08de70197911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xAl92eCCihAuBrBITaqjTyxlA0/ibos7oLXSPbRPlmFNMiip9fN0sGlAzZiX?=
 =?us-ascii?Q?FcoLM+SQd0+zr3/4RvLEMHfKDQBPgz4Q2nKUqpcQL/HnOZhdOJYMxzy+g1jr?=
 =?us-ascii?Q?oW4WfOd135CmZMl4GCWCDjP7bT8+4/f4w71BKkMLo4Ncj7bwhKntjc6/nRK9?=
 =?us-ascii?Q?birux1VN2rPHQfh2pjVtva5KQP3NUZZxCnDkh5goT/n7Hme/5BxIMPPtUHpf?=
 =?us-ascii?Q?VIQ1B+6QLX8EiCmi4RXjEU1cWmyzQiUUeMeaJfzz+UNyCc8C9iH4HXJaP65M?=
 =?us-ascii?Q?TdU70Yv9Dg05XdRWrvjbL68l80DY5TKbgcDiaz4qjKZOVWpcC8WiJ+r4HE5J?=
 =?us-ascii?Q?YFsPsYIO7+a1yabcJjmVGMAfQ7uXaGwBOn6jTSmnAl1KWuBHYPHMjXJgDPTg?=
 =?us-ascii?Q?DpnkWGZsrxGQE46a2thNXXLR0gLIbhPqgx8QgZGk64HFq8BChtDsSTVV7J0v?=
 =?us-ascii?Q?xd9DpGpb0CcU8y8H9BidTEDfjPUVOGtQGs3/CBsVkl8ECblO60mfNToOjBJW?=
 =?us-ascii?Q?z0MiiC2xmyTMz8FWDSeem+AXiOPKXPRTsMZz6AFKlqJbf/qqJiFaNTgzMSXV?=
 =?us-ascii?Q?l88yTzEE5cS/0W33NT646tFVQ7VEAQekB4/MQJZWyKd5x1LZmfuknglHmyck?=
 =?us-ascii?Q?Q3rDGzbiy72I67X3wH/mkdT2IHrElMzjc51FUCEUlomibo8GBVlLAyvR75ln?=
 =?us-ascii?Q?5qPubkbhiJXa4hmXOUogVKN1W1yRVVe9ll1dAUDvsw71HOo7VlBQA4W6qHIO?=
 =?us-ascii?Q?f4LEKc7R82MAVKmBgLaqb986LykqhgFu4HqdXl7E0DHKMrL9bP1kJl87DciV?=
 =?us-ascii?Q?3xxEXIFt1JykubSeUwrPKBaAGTDPdJvmzbOHwIUYw4YOOpq3c6n3uiycnGO1?=
 =?us-ascii?Q?OXSBSJNGAJRdzeQ5KeBs4dlLqEYInu3iig84kFiBvfagO/bcJDrKbhmCJ2of?=
 =?us-ascii?Q?8l9o0BB99gbpFeOMRIJFKCj6nchutc3JTDs2zvik27uEdcPhCi1mdTBsSeuG?=
 =?us-ascii?Q?0iq3aKEaI+qMx2Truwizm/J4UKd/vAeyplIO/P+Qt0WgQmLbIQ2z6apmBdNi?=
 =?us-ascii?Q?wnzwvY3TkIIdNgvbaWwFOVN8pPejaMxV6QW8us+vb7Mu3uqKn+dY87E/PmoG?=
 =?us-ascii?Q?4cajRzvcEapO/3tCTLZAqgPGbnoiBgkAmwWvlCfPRQnpALq7tlcMAX6SmLDN?=
 =?us-ascii?Q?7IocrCch9NDrvP5WpBqlKOsIGsX2e36YUOsMeJA2s0O37UIvJwyKHWP8J3Pw?=
 =?us-ascii?Q?9vt7DYTAEheUYR4r13GRSF0/vy/xJa1+i/kHbp7+HieglAP1vF7RmjcZnJwb?=
 =?us-ascii?Q?5QmSo9ZDaOoT2pTJDuWbuHxp435zKU3b2729ogwPOsmWZJe4Q30e5/+J4eJS?=
 =?us-ascii?Q?Fk97+VK99INXtOHSKkaDrTkq2s2ut0QcPG+AbVJ0dMvoTCCCTuyS3nIfHRhQ?=
 =?us-ascii?Q?B/oOpvFzN8hX9l6IlmEdkW5xUf0zIicKxD8/GSsBG7Ad5Kgl3bvoZnB2OLmU?=
 =?us-ascii?Q?B7Sbn3eXr43/prSjcK8u6aQ0DasFI4iak8xW5Cpb19am+ywiEIIEf7Si7lNw?=
 =?us-ascii?Q?i1bfNWwdr8viBkDjJjc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0GcUWp7SZVhCZed5VJR5HKcqEf0fZu3JdyqLn/7LEBEM+Y+vV2uhqUSF1ANc?=
 =?us-ascii?Q?q4a03UKhWboQKcMJDMFObBrrKbMrTE/5fcvAQjeUwQKnlgbZTkXReh2Z6MeW?=
 =?us-ascii?Q?lJjL2tzCrANf7UNrBQEDCpSaMMKyrtA0s0F+EG0lp/tX0CLQNU9JvLCthoBf?=
 =?us-ascii?Q?ux5xXroO042r+2RvJKXoiVtDd6XUeyS/fpSj9y4Oy5uP9MUvSmmxItLaESLC?=
 =?us-ascii?Q?c0BDUjiPutq7JDsAJnBPb4x+QiJcw7E99+3wAj+3L9LvU33bvArZl4I5HmdZ?=
 =?us-ascii?Q?L7vPPEKhEXxNsjxG0c93vljV5A2p3IaT1dgTQ/yn7ciRxhynJcakbS8g/j8T?=
 =?us-ascii?Q?93Fu72hc7JgAqHK+fPjsaM8B4BQIjGahB+Nv5pSFUC5YXNrIIZL3LIu7nMqs?=
 =?us-ascii?Q?wwErqLdf+5YW/N8wW5+raLRGThz3yEx4A2iF/pB+RrdZT+V4ic8HjEBg9wnr?=
 =?us-ascii?Q?d64u3SfyRbJ6qeJ14+TeJxpcuihkP7dMgHHU+sZ9CPmFPUcVjVs+cfFKMabs?=
 =?us-ascii?Q?3ud4Nq3CG8CY0LlvpY0I6CshHx/sr9uICER5UAHfhQ/gR8NBDoLxlN1unfjI?=
 =?us-ascii?Q?0FFCpxqCMPxOstb3YJ/gzxe9AJPyzOXjQ2QWfbhapl6Z1YsIZZQ31IEMUYe0?=
 =?us-ascii?Q?f/ygaAItHnJZPgtEXDANweAqMCk2qGNp3mo5+DassQr1M+IQlzJm4/3rq+94?=
 =?us-ascii?Q?KXuwQwkXQdBPoj6mzWONVLdUP/92EZyhw0q8NzzAGjmhDSkYFyJca6uMYSF4?=
 =?us-ascii?Q?S72ShO3baDCe22qZXcBtL3t5+JxVKO3RrdzD+7EstvBv66tYxQGCCQs0aUp0?=
 =?us-ascii?Q?8EPhxn8CXMxZgzCEbBHQ7+jPnMPpbOlUywRzr5i2dqkORVvGM+7cXVUtHwdO?=
 =?us-ascii?Q?1p8ELKhRkxi6EJ4BkJEMau4oHJm8CjVzVDCB464riZhqfLquOU6rcaeOEKBW?=
 =?us-ascii?Q?8dUYjvzmLMaVpXOeAsBjNvw6PkgByWSzTipBVtFpnjHSheXhA6aYIKK9AvD2?=
 =?us-ascii?Q?3EuTu9Ajzber2qR0jzalUrNg83mFOG1mCR+8mn3RyjrKytl1HzVIQSzvRk8f?=
 =?us-ascii?Q?TTxVC7cyEeSEgVAdFkUIs2pZptfUMEkyBv6y7Lrtb6Vu40xLAwZkGkAWt4Q7?=
 =?us-ascii?Q?uUReWSjD1pwAzp/OhIS7wGFKDzjej3aFl1lqQKYljRV21/SNLjwrs2YNjTc/?=
 =?us-ascii?Q?vyz0oiu/dLMIpkLIlZXqlB+Gw6dqiEI/jXNhHWczt/T82d9n4MCUILccwqIA?=
 =?us-ascii?Q?9V6gxCEWYG6w/HpgofopW45mqo6dynxW6QTrBemP5OOxN2eOcH8uWGP7gGbC?=
 =?us-ascii?Q?XQh/aKO4osmCbGuPRggTgzORMF/RIwtTKuoMJLyFKJ7qxxOI8BXvSxqHcXru?=
 =?us-ascii?Q?QsQJQJwQI96vHz/bPElP0p1LTfKB+nH93q7TprNrao7+IFG3UjMjDuMpwwB1?=
 =?us-ascii?Q?W/0WtglKTE6H7gbe5FVA/cgq8NR7FrAfhpgwoE01HZUonLjuZu9YifOKPsFu?=
 =?us-ascii?Q?Pwd/L/FlhUXcWK6CH6+P2jhe87tOqmZhyiwoj9PVS5hDU0jQpykTxrfjP+1I?=
 =?us-ascii?Q?OvWSMqMT9dPmpRlO6melVQDeWtiZ7UlW7EGpwxRoIq3yCszUYyDKIVdf9Jst?=
 =?us-ascii?Q?2nLRa8epK1cWHwliPSOl7r2mJi1i978yszu/a7UPjDOHeOAtUBYgn3prVNad?=
 =?us-ascii?Q?6EWyG0ek/zPsMeoqqTyqoh+DikLgu4IvP/Ac9eZp1+KYlHra?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8097c2-16d5-45e8-3cf1-08de70197911
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 00:46:24.2294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+1XysDdh5IcszGtnUj4vbfy5dkhAgAj9exCrIj3+VcKlU8zOZI3oNNodoy2iF5C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[kvack.org,redhat.com,suse.com,suse.cz,nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14046-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cmpxchg.org:email]
X-Rspamd-Queue-Id: EF42F16402D
X-Rspamd-Action: no action

On 19 Feb 2026, at 18:58, JP Kobryn (Meta) wrote:

> There are situations where reclaim kicks in on a system with free memor=
y.
> One possible cause is a NUMA imbalance scenario where one or more nodes=
 are
> under pressure. It would help if we could easily identify such nodes.
>
> Move the pgscan, pgsteal, and pgrefill counters from vm_event_item to
> node_stat_item to provide per-node reclaim visibility. With these count=
ers
> as node stats, the values are now displayed in the per-node section of
> /proc/zoneinfo, which allows for quick identification of the affected
> nodes.
>
> /proc/vmstat continues to report the same counters, aggregated across a=
ll
> nodes. But the ordering of these items within the readout changes as th=
ey
> move from the vm events section to the node stats section.
>
> Memcg accounting of these counters is preserved. The relocated counters=

> remain visible in memory.stat alongside the existing aggregate pgscan a=
nd
> pgsteal counters.
>
> However, this change affects how the global counters are accumulated.
> Previously, the global event count update was gated on !cgroup_reclaim(=
),
> excluding memcg-based reclaim from /proc/vmstat. Now that
> mod_lruvec_state() is being used to update the counters, the global
> counters will include all reclaim. This is consistent with how pgdemote=

> counters are already tracked.
>
> Finally, the virtio_balloon driver is updated to use
> global_node_page_state() to fetch the counters, as they are no longer
> accessible through the vm_events array.
>
> Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
> v5:
> 	- rebase onto mm/mm-new
>
> v4: https://lore.kernel.org/linux-mm/20260219171124.19053-1-jp.kobryn@l=
inux.dev/
> 	- remove unused memcg var from scan_folios()
>
> v3: https://lore.kernel.org/linux-mm/20260218222652.108411-1-jp.kobryn@=
linux.dev/
> 	- additionally move PGREFILL to node stats
>
> v2: https://lore.kernel.org/linux-mm/20260218032941.225439-1-jp.kobryn@=
linux.dev/
> 	- update commit message
> 	- add entries to memory_stats array
> 	- add switch cases in memcg_page_state_output_unit()
>
> v1: https://lore.kernel.org/linux-mm/20260212045109.255391-3-inwardvess=
el@gmail.com/
>
>  drivers/virtio/virtio_balloon.c |  8 ++---
>  include/linux/mmzone.h          | 13 ++++++++
>  include/linux/vm_event_item.h   | 13 --------
>  mm/memcontrol.c                 | 56 +++++++++++++++++++++++----------=

>  mm/vmscan.c                     | 39 ++++++++---------------
>  mm/vmstat.c                     | 26 +++++++--------
>  6 files changed, 82 insertions(+), 73 deletions(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

