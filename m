Return-Path: <cgroups+bounces-9809-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C51B2B4A2A5
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 08:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF014E422B
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 06:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC633043AD;
	Tue,  9 Sep 2025 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Wdox3k9F"
X-Original-To: cgroups@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012010.outbound.protection.outlook.com [40.107.75.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C3B18AFF;
	Tue,  9 Sep 2025 06:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757400858; cv=fail; b=aIV1RffrnWDbJPBl/WmSWg3biQtB6QG27/2gpzROImXM9JpgFwpFqkfRB1d+OtKeoWB2y1XHbQR9Wm/MirHCYbe+/NRli2GHLIIWk1VsTYHvSMW6FKK+jRAvYl9zckc9Ul52HtFMHJhjMCKAjPwuY0j4zy3cnG77fFIfBglouN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757400858; c=relaxed/simple;
	bh=Su8bybxjSwdCmOg+g10DzVg42Yz8GemdRanllCnqOWs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oxV2vNitbqK8PmMr/PcNScWu9dQlJBtyCK26fZe64ppqm6wpIZA7/z8XJ5ghqcIaMYRoqSKIn6mp0+rFBF7ukpSp605+hB2aR7e/5RgY+9cUuI3hW0vuRV86rFTehONpcIVU6DQefZUHwPETPlzaMPOXmEVfie7oJ+8C0SBc1Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Wdox3k9F; arc=fail smtp.client-ip=40.107.75.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ReaKPr77YY8p3yQlFzn1x5rx9W3hHFGm5oH+1dpJW817cVde9YPdPiUDKFCoYZn4oFnRIG1a/sZAayWb7V+luwoc2ceXN6AGD73UpcEcaB+sMt7Ru+hR7LUqf7ZB7BtevHRXavGYY4pyVwbylOVTIiPpLyx51sUurboz2yqWUnPt9uGBAzaTKqP7mEhdRB+r/Lz29scLuKFMLZYVr+3/73YzOQY1W0EHGogZKlZ+lL2VctS6VJz3Q1mNmGJ5yFXmXxqOMHypKnUvhD2uce9HQwIsDCoh0YNuDTkuz/M4lDDUOhtmCSwRSpXkuIj/soXWIGX4Dvl4+M/jDKUM6h2C0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVN6pfGfExzXJsY4/vdd6IKwITycJNZ4RE4IZujmAN8=;
 b=JdxwlD9AXxuwdSr6XBe0CCJ58C15PnGOWYEEPHhzf5PArsY2/814XHjh+Ju17UqadV2kE1V9+S9Ia1GZRZBRZeZyaetY3LvX705zjbcDI3y0tBTgRanI1Hi1CYuYQLlUC4RBDtF2bRWPPpSqmXCw1cZsKUHva1fOIuXxg7wNy/UA01SsUjcC0g0Ry9xcHCgvo5hEN6UkfxVIHb9+e1UI8FJ69HE/xRgub80mA3zJSQqhlm9Lw468riGuhmddfTlr2NtPXPGfmT4Rk3lMhfd3DFAr2l4MliCeM01cK3Q3qg5Y+1K943mJSDw8RMtkElVLGu/8wlyTlE84CIgOI0U0iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVN6pfGfExzXJsY4/vdd6IKwITycJNZ4RE4IZujmAN8=;
 b=Wdox3k9F3iRe25t9KvscdB56F646Un7ouQcvEL64RyWW77LIRGYTYvSWToQ5iJWAIPJlA4+hlu6QU8h0a4lMUwksG6P/uUVQ8ymml8fHK1EecsgSFfwn0L3SNSuXz1jasnvEruORasrkqXxTmdUdJ7I0Pr7HvAGPQ+0fGq7M2ce/UASvzleP6qRCJdLxxws3ngKlFV+VeYPfjQLLUHqxRqfrb84HnwK4fz1JmdTw0JWqzs2Eh2cnzvC3SJfk2jM2MshbyXTVmnMuiXhYRJqAFrWsEFqmXpCa8yZVACiVBgG+dkxia8psvyvqCFeyUHGpa7tnhn1T62T5hQ9dPksbew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by SEZPR06MB5897.apcprd06.prod.outlook.com (2603:1096:101:e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 06:54:09 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%4]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 06:54:09 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Michal Hocko <mhocko@suse.com>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Chen Yu <yu.c.chen@intel.com>,
	Hao Jia <jiahao1@lixiang.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Fushuai Wang <wangfushuai@baidu.com>,
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT - OOM KILLER),
	linux-kernel@vger.kernel.org (open list),
	cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG))
Cc: Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async release
Date: Tue,  9 Sep 2025 14:53:39 +0800
Message-Id: <20250909065349.574894-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0176.apcprd04.prod.outlook.com
 (2603:1096:4:14::14) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|SEZPR06MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 896aec90-430d-4561-0ac2-08ddef6dad36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|42112799006|1800799024|366016|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vm8KWCz6V/O/91BfMTTHkoaklQE5QdVW/LDq5LzrEg+Z0yTlIBGzRqQ6e2W0?=
 =?us-ascii?Q?fyiFS1zEXL07r4obHWrazDuvZ1079b1FRVgURJ4Jeozd61h+wWqta3SNx1Mi?=
 =?us-ascii?Q?tMP7l2pJBWQZn4R2AR9qf9EJa+oNnSBoQzGh9LXeB98fQrEVxJi7MYx71/8G?=
 =?us-ascii?Q?jDanMzALA4RbKnlMD+F1fs5B7Wc18hesSN1eMvUGQInWrg14yTIwXAaZKB8N?=
 =?us-ascii?Q?3UoQIwp/PAaeNiGMs7iA4MerYDscWjKr9RRnF3p5GzC6A0vSmXhWsi1Ftjqi?=
 =?us-ascii?Q?kuRlax15nN5T+Am1wQoe83t+coJHOf28k5wMZGusuFdb0xnot6UxI06u/HIg?=
 =?us-ascii?Q?TKYAAOCPYN1E784M/ypcqrlXr08sxTiODYsNTS+9lbc3iyojuJIhtnml1TH/?=
 =?us-ascii?Q?mAWP/2Swx0SOtT4Sdt6ZsezVFlskep0fqKhRdb3ubmeDkFN5/X83Ku0EsuUr?=
 =?us-ascii?Q?wYM0W1xdnmeUdQhiWi421QbwS6v6kTmr1DfPP1WxyfcCSaR54bX6KZY1Kk/d?=
 =?us-ascii?Q?Mg48EWw9SsxbJRF1ruUqJxdWfozVMPfx/GmKobFLNrDPR0PHrB6EFF+Llr6O?=
 =?us-ascii?Q?1cjy6zg5Svfzm1e5qp5GWXKWtU689wSe91a6UMJYnMSrjqjQaLCj9CSS322X?=
 =?us-ascii?Q?Zzlbblo6luaEwxgvAYUxQybzimEuTS3EkuCIin9cOW1UZdxTN6eD6ibm8Zvq?=
 =?us-ascii?Q?h9edqhFvr47FkX1JXfks+iGbFyD0Vr0HxpYSulagaBTf+b0tAycWRLZyENlL?=
 =?us-ascii?Q?uaJJuBg88w5cqYuxbU52e0xfcp0njxOfcgrg9jqP5OjR/xQjlSvSZj2RlGEr?=
 =?us-ascii?Q?ftcTddmosTrfKhYr70YoCqqduLnTvd42/7hBwjs8CRtrvdJxnutdA+2CP8Iq?=
 =?us-ascii?Q?roc3XGvcLuu+LIRLWtEOiqAatHtN9L3ieNwigRvdwuVC0gG5XTzEDDFJhT3V?=
 =?us-ascii?Q?BCs64tvEjqX2bYEmqATor9DYghVZCOKPpf8Xuo4HW+ROu+ANynMD+KTkQfVQ?=
 =?us-ascii?Q?TRUcyNLPsC9S3UlZUP+ZVA90QaeKNfva8VkP8Mr9EN2IpCOK3HHMD74aM86r?=
 =?us-ascii?Q?KFguQu7vH825iLoO+UH4A1INvUPF0HkCLdWBrw5Bjqr+BCH0qZ+1mjLkPJEY?=
 =?us-ascii?Q?gEEdIfQs0xjurawWR5cR02TVNyGD4GzMUBJyqMgz5GdRiUta9be6ri0YKhj5?=
 =?us-ascii?Q?hes6Sls7ix7+OVz7PHyab9tWDxHXGgXP+yV8JYrh4CLTHf4RCC9H2sIbw1jV?=
 =?us-ascii?Q?imnobMoKEuBghzi8Qgqgz2u8QybQVaxcS7ZwvS4PGEjVeELiXRW9o8Hplooo?=
 =?us-ascii?Q?yyK+tWhq+k1SD/7okzdCWMjE6zASy+bG84nQN/QSFwFofkmQpaEMHYf0fqwy?=
 =?us-ascii?Q?Er5BeVJ95jHpF8vsy6PlX8gOBQobgNPb6EV34bsTqUSoRWKeJIu63bg6zTZd?=
 =?us-ascii?Q?2CCswRcceS/Z9Ku1V03m85KBezlFQHksWmk0Wl8w2r7jwzjX2O9RTBB841BJ?=
 =?us-ascii?Q?kkRbNKCUzvau8g5bm5W/sG3PG9hLHIOf77bX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(42112799006)(1800799024)(366016)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+tQ5oOVbA+GZ0hea7yta05TmAJUJeQdBVvrFTzc4TxJnt5oPnHT4Lt9sfhYc?=
 =?us-ascii?Q?WX+/+MtpZ+YWZbF1ZlI0B8K0FgmhLhwvtuPP/FAMIFfZpLSPFAf5Z2ocL4fY?=
 =?us-ascii?Q?FnqB0278PBI58GCg3n7F12F7ve9sIyzPFkdmDzUAIV2Knun5c/1tIck45lNx?=
 =?us-ascii?Q?U6nFtTKUulDc8av7/9zQKzI+41K98rD6JG+qJ0Sxi99CX77mBZr8+DaencGo?=
 =?us-ascii?Q?qAwTfAJ21SEggqQbStjs+JrasKDv3IiKs8uLNe2HqPuhKgyoUOobqNNHX78R?=
 =?us-ascii?Q?jzxUN9IM8pG6dMr16OSZDW5Osw59CkJlObi9y8br18f68g7tp/tnkH0DlXa7?=
 =?us-ascii?Q?8VwcEmzdBLn10d/LZQEoDlBpqMiNvEnqddo0dCqwnBV1Nt2IyA03OZVVbzK4?=
 =?us-ascii?Q?P+qefcp9wNcmKkrCH4///5tSWSsKAXTGZ4kBrwM3dgVD7FJzr167q4ANOCWI?=
 =?us-ascii?Q?oMEUYJviGqSzfH3WvmWS1402OEDaJGTxHlB5/AHs7f+GVlBlwvduH5DhXVxD?=
 =?us-ascii?Q?RCN7Bio4kod11qjXUKNeV+Y7TfLfEFw+3b7g0RON20LicNpL3gjLUrWo3IVd?=
 =?us-ascii?Q?UvEypJ4Rzi9mMwxC6v4WBWklb8fKpYX1A9Bx6a7gXICQzUpO/Sv//W+I6dZm?=
 =?us-ascii?Q?Vy59+Q4CVwKcz1ePSVP8EaXhvGtJ1JQ16VTrFafGulRHJ7VFo505D3lHM8bB?=
 =?us-ascii?Q?GaTNUOMVr2ljMzI1zWVe/pUBBN148IW27FufFi67/wx5PynV86qlfAq5zcGQ?=
 =?us-ascii?Q?KrttSi9fxt/bud57E8WGaaLMqllZJMlr0STu97q3R+RNTWKrcrCS8ZBE16dF?=
 =?us-ascii?Q?rvbSjFdM4NXEi/gzqeIsf8CnmqPqLvIK19BKYuszZ9N7xLui8D3GsVc1z9cI?=
 =?us-ascii?Q?shm//zUoBrUAs6AcpJgheWB7ao6chrq09BMlWGjzi9YzAE6qU1RTbakz+dTk?=
 =?us-ascii?Q?6WYb8aMRbFk8Zk/uPklf98delG/TL22mmgRR2c5PoFFm+2DIczseKD5sxVfM?=
 =?us-ascii?Q?wO62g2Fl++pjxDx6Jr3mia4kd2OEugB121smxQ+gbMVGCOO1fmGV07Xr9CTl?=
 =?us-ascii?Q?DLiKfeS71OMiymdA0XGm26ep8QMdFhnOr8irrdFFgMgJovPqPwxBzZ1/4WXO?=
 =?us-ascii?Q?q+zbhFzrlGae01Sbl2le76bSW9T3LkVuRVSdtOZcxsmUyydXdijitQvXJzXw?=
 =?us-ascii?Q?OdUHmBqSgq3OmqM33PsBdw8W8+AklQbFGXsw0XFlfBYWgAkHP330WoF9a9sJ?=
 =?us-ascii?Q?8XoJXVjR2tSGOBhPrruTzQv9mbj+uReMa9ufcBlG70LN2TzMch+9isyTdyZu?=
 =?us-ascii?Q?s0V2Logk/D+NWoxCVLgovtbtHqLbN5s6hcZbSQbeyPzp7SvUZSJ5EUO/O1N0?=
 =?us-ascii?Q?/PbWLn6sQfR8AmSQXZCicXuKk/M4Ts/RXDu7q/8Kv92BM6Kfm/N36PfmWSV/?=
 =?us-ascii?Q?/v8bT+jBczM8RSt6Wy0QNWYZTyH1fP8JVJ10PCx45omNKX6VEg8M2W2Sy3aM?=
 =?us-ascii?Q?oaKRM3uTi4futEg5Ba6rkAW0fpPd4zGH0zL8c1mM2P8dO/dw2pdqLfWDGIlO?=
 =?us-ascii?Q?icDgg0noJWaZZmmRQkTc+NR4dfPNUAdTfez1YbVI?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896aec90-430d-4561-0ac2-08ddef6dad36
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 06:54:09.5562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xg/JxCx22KwGjpH4trAO0eA7SaOuRZH5sSMtYdbMOyuEKybU1HEm68aKDh636cRnX7NGYfLRq7M6wiB1vojFww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5897

1. Problem Scenario
On systems with ZRAM and swap enabled, simultaneous process exits create
contention. The primary bottleneck occurs during swap entry release
operations, causing exiting processes to monopolize CPU resources. This
leads to scheduling delays for high-priority processes.

2. Android Use Case
During camera launch, LMKD terminates background processes to free memory.
Exiting processes compete for CPU cycles, delaying the camera preview
thread and causing visible stuttering - directly impacting user
experience.

3. Root Cause Analysis
When background applications heavily utilize swap space, process exit
profiling reveals 55% of time spent in free_swap_and_cache_nr():

Function              Duration (ms)   Percentage
do_signal               791.813     **********100%
do_group_exit           791.813     **********100%
do_exit                 791.813     **********100%
exit_mm                 577.859        *******73%
exit_mmap               577.497        *******73%
zap_pte_range           558.645        *******71%
free_swap_and_cache_nr  433.381          *****55%
free_swap_slot          403.568          *****51%
swap_entry_free         393.863          *****50%
swap_range_free         372.602           ****47%

4. Optimization Approach
a) For processes exceeding swap entry threshold: aggregate and isolate
swap entries to enable fast exit
b) Asynchronously release batched entries when isolation reaches
configured threshold

5. Performance Gains (User Scenario: Camera Cold Launch)
a) 74% reduction in process exit latency (>500ms cases)
b) ~4% lower peak CPU load during concurrent process exits
c) ~70MB additional free memory during camera preview initialization
d) 40% reduction in camera preview stuttering probability

6. Prior Art & Improvements
Reference: Zhiguo Jiang's patch
(https://lore.kernel.org/all/20240805153639.1057-1-justinjiang@vivo.com/)

Key enhancements:
a) Reimplemented logic moved from mmu_gather.c to swapfile.c for clarity
b) Async release delegated to workqueue kworkers with configurable
max_active for NUMA-optimized concurrency

Lei Liu (2):
  mm: swap: Gather swap entries and batch async release core
  mm: swap: Forced swap entries release under memory pressure

 include/linux/oom.h           |  23 ++++++
 include/linux/swapfile.h      |   2 +
 include/linux/vm_event_item.h |   1 +
 kernel/exit.c                 |   2 +
 mm/memcontrol.c               |   6 --
 mm/memory.c                   |   4 +-
 mm/page_alloc.c               |   4 +
 mm/swapfile.c                 | 134 ++++++++++++++++++++++++++++++++++
 mm/vmstat.c                   |   1 +
 9 files changed, 170 insertions(+), 7 deletions(-)

-- 
2.34.1


