Return-Path: <cgroups+bounces-3486-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F8692385A
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 10:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A841C223B0
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 08:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0F5148841;
	Tue,  2 Jul 2024 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ROMGnPAC"
X-Original-To: cgroups@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2063.outbound.protection.outlook.com [40.107.117.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100AD1422B6;
	Tue,  2 Jul 2024 08:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909968; cv=fail; b=qwgBPfZOGkshtyTbXNo1DcjFYUL/xwIwCIjS+jXaAm64+E5RDOETm2FBLASqBQt9mM77S1pyyvFTvVl2XC/E4qvDTQiv6baj7HDmqZoqdOkqAAtk0yHFqGWZiIwtE9wvq0yJU6aMCl/sq83c+v9LfmMQu5VhXyOYWoEXS46doGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909968; c=relaxed/simple;
	bh=v4S0HzcwUI9uh3zvSaCqzPGqffzkgubZW6r0v05bbk8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kV8p4YMa/194JlegYRhpChHAsHOa06qgPYZ7gOSyj83SP9ynMrfJVhXWfysEr+7/J6SAT+68a3tGXa3HwYBDmcrd0+VtDGJjAnJWA/hfAlVdPILDnDMahDbSUME2G6b3YgZBmC7JxDZ73+X9pq+eyNpgmmU9aRTduuPRwOuy8kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ROMGnPAC; arc=fail smtp.client-ip=40.107.117.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0wble79eEfzY9YgM7XzmwlIj4eEs5OK7KmBhfElLNEt8qIsHF7zh+2VaQFmoLK9oPO5N3hsKWbFCTg+UNY/9AYpBPDSJufkmzG+XYbbzlY24HP9FNNh1OzYcxlR3oIEaDq5WeAiHduPSGBx7EkjuN8VfpQsHOi5sVKhHGK8lAIHw31w+OmUn7SDq3ntFX9lLqDXEu41IQcn7nQwEEHYXzJpi5FRYHWYccjqIvGUI3Fn3v8wv5tGSbNx8fetMwfEO0QuDRlSid8rfpcTV0oXcfjmgUec1GgMGCtzqhp20ILaOMvkEmdIAd1w1a44eyJgCundn9YV9LzCyRvxpO41sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXGrPsUSwM7UDTr+Xy8l8D/8QVX2s2rwHYeg+bJMefI=;
 b=Iw0DkotNBTdmBjizMAW3K8us3mDZxQ/muLr6J+3ZUBxwveGg9aHrFqf10ZP7ETznTM66T/Tv/O/Z8sJ/pKqurz2REXBD9h8aBhHZIv3pWBxB6h4AGb1J264WRAHO3wjjP3vGKQxYi2zoAyCatSPTfthngIoNuyqO7TnCfOlpHpzBa+s+FWk6RcXm9OHrJ2jBw2aza954xtFxR2LM4T6FrzwdyNtsrI/J0FaR9mO0Yj04K1nK9uU1EK3mAYuwyVtVYN2kbaGd/Mg8eOyO8+3tMUlAvJwnqy17Xawf+2pac/kKqJvhw/6L7dJupbwPEUKcRcIcbC+xR4IUr1sundzrFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXGrPsUSwM7UDTr+Xy8l8D/8QVX2s2rwHYeg+bJMefI=;
 b=ROMGnPACtPoO8aoVxEipSDgHTaWGDZkeHNaI1OLD4S6wIs7jSJ0fh4C/GALHvwFythxCuC1TzfFGAqSfM6ljCVTWPI0fI0yNxuJTCiUmBarsRxiJs9SDiQXMRByk3lcIg3s+PFmBJAZ/iGF8LB9RAzy098UEpGPAkNN1u2nPsL9sXyaI6Q1lQKkZ+z7fAlYp543HV+FUAw/y2GfLf771oxTnMsmQMz4d6t+dJ0ZQgLnv6w9d5mAyJ6B8IbETtzSzMCksN5InYhcRQBEqLWFTVWmYpfNjLSzyBBm6F528HsyaFxcK0u790GO6WEduHrKoZpk4xbly1ZLsUxwyQQAIbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEYPR06MB5790.apcprd06.prod.outlook.com (2603:1096:101:b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 08:46:00 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 08:46:00 +0000
From: Huan Yang <link@vivo.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Chris Li <chrisl@kernel.org>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Huan Yang <link@vivo.com>,
	Kairui Song <kasong@tencent.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: opensource.kernel@vivo.com
Subject: [RFC PATCH 0/4] Introduce PMC(PER-MEMCG-CACHE)
Date: Tue,  2 Jul 2024 16:44:03 +0800
Message-ID: <20240702084423.1717904-1-link@vivo.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0148.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::28) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEYPR06MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 4992ed90-2588-4b32-53ee-08dc9a7365d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h84zMWQXmFIh1sM4RDIxu8tV9xTtZFUOakoesYfCqNdrHRF8n1N3ziF28v6K?=
 =?us-ascii?Q?amg0MJvlaY11iIBOjY7RQYsG6rX5e63E1C5Hyj+VNLsJUnsQIUf2MHaQ3YxW?=
 =?us-ascii?Q?5/2Er5S+b4t5VIkPNIBqLwbcf2nNyy7kw95IaDtQcvrWYB7j/7PF2cRD6B6q?=
 =?us-ascii?Q?Pol7KGnpTE35018/56tDJp72XBT8lPX8j2UmxI35AMIpH4mHUVy0SwdrPwZc?=
 =?us-ascii?Q?Uju08pkOH/2gGTt5jgig593T3ZUkhfN/SMjZutGJAkq9opmTrRcFSFvSOI6D?=
 =?us-ascii?Q?693VT+2a249v0YmlLb2DCRGb2wXxe43Qm6L3YC0qGyYG0Jfyfl3PtCSjDwHP?=
 =?us-ascii?Q?g65QRZOC63dfeUGIVPVx5mnPFiYgjLCe4vjdtlTNGVdRNu3e33ZhvaSwflrY?=
 =?us-ascii?Q?QZb/Ga0I262aFhmALbz2uxzbySE1LzCExaIuSeVAr20vvkNs6PXFmZnLX9J7?=
 =?us-ascii?Q?sM0SpcxmHb0wuTfE0211IrSVgnUg/9Nahd70rzbXqf74nnuIWFKFRwoOJW6/?=
 =?us-ascii?Q?mzjAPKNYpoizcD+yCqMOQA9/FfxGxqvoY7z18A1Hqq8L8dQbNg0LNL4l/srV?=
 =?us-ascii?Q?gBngX0abTAVfNXjIOl9guQlbxBjIXqhCndpc1W42JCsFSswx3Iht8Rz4pp/M?=
 =?us-ascii?Q?nRfhO3/+r/oRzOzkejvrxbxo/OqjRbDG1w5ZAdkD+ZLm3gl0xnxyEw+qVzPJ?=
 =?us-ascii?Q?K9Wl9BSgCGykSii8pgZjKhIfaVmRf2zEfuMsFXkYbgG0aLTmuwujMllOnK19?=
 =?us-ascii?Q?ZivnCOSxt3BUB3RMMnQF4kvj3/BF/rAecBPE9kwzdpRcvb56xcLBspJh0MWF?=
 =?us-ascii?Q?eKtXrqRCxPxiVXL168HkWkSzYiT5e3gImTQqkfTl6khhnk4ceXhK3PnqbiQm?=
 =?us-ascii?Q?s83/UctmClTD6eJx+f+XMADUPCPqGlBfPpZ2cSku1KWfu0s3qdrxkcu7Vhn0?=
 =?us-ascii?Q?HgwyzpUNeS+Qkg/DcwnNA9mBBaoE50cXd3P13zqrdaTsgD4psLb8UYIywLkg?=
 =?us-ascii?Q?AmJxb5RRUNIGhEGHbY4/p231h9nXc5urm7j4lzmG1+M8I2foK9xOeoZSBAig?=
 =?us-ascii?Q?d8pVjNCBNsi4/mrT+cEK6uihb08GW6V6HSLDl7ftwXVkEsHIe4Ri3fprZQHW?=
 =?us-ascii?Q?9aruj4XNJS122p1tq0ywlPYK9mUcQMRd9rxzcY0bhyNZcFKrz9ItNyuaQKgn?=
 =?us-ascii?Q?RSrO+asrp24FRuaevZivh4dlGKuy546jRUXf/FYRVk2eCVEGSEW+nuKei9uJ?=
 =?us-ascii?Q?8SJIsi1ngr9Kq7/aW9rCApOpLhay+/x9AQSsnaQ3gG92wz23u2ITXoYQY77N?=
 =?us-ascii?Q?49JWjvRPb6uIcdiD+x9uOo0jVaCBywNQMZFGgjyFZ+YMEA20HFkDuUrqRF3p?=
 =?us-ascii?Q?GCQfAbbU0jED0QD60ZLZMPPBSJ7Y08AQejhiau0fy200BedsuoMn999sVi7G?=
 =?us-ascii?Q?paD/KM3rPd0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gwyimZQrAL1xYWgVLwD++pjfed/VfyHTJMLiAvLbOExlIYkTpgiWeGF+WR8K?=
 =?us-ascii?Q?PPxu37XVGqQt6MjWeWymxwL7Kql1iWNIDFlaMs57N2oiixDYzlHtmEuYj+pg?=
 =?us-ascii?Q?mS8h0VoyY4Dpqc2mewzgXUygV2lXRvL3o1UI3nsXKF2MGask84XA68SN28Wb?=
 =?us-ascii?Q?oUQ7fJ+VtCrd8Mv9XDaWZ4gcG4jJ5Mscxn85MfjcaZDU0uNbHsJHWULFYTXz?=
 =?us-ascii?Q?nqtAKQ2YnV/Sy1535uWNvJnNAAoyg91W3nI77Uahudp9b7dqywsPE98hQp4n?=
 =?us-ascii?Q?M86jNVXiH5nkaL6j6CRi8zbWADaZ3CgI34AgDaHdkoxCrMwWV0YRxrzEaXyb?=
 =?us-ascii?Q?/7MYsyKSDChZUbxPHsvmoHVjFOD7vB/pWa/dapzeDFj60K3/W93cSgtgbdeC?=
 =?us-ascii?Q?Yxer3cnjXIpY7XuE5RDnB5WT1d4UjfjgUc1kJaSpHbwU4W0UpK72IV6Y/gks?=
 =?us-ascii?Q?1ePoKQsR6O4/7tWAkDBhUhP9ucR7Ga1IlTjMCrCF66HjW+jXUDV72M1VW9S3?=
 =?us-ascii?Q?1aDIUKGvCk1pVla3TDEZGcjCTmH9pWfI6PkEUv+exPkJej7aqDMrpT67lbGo?=
 =?us-ascii?Q?AqeFbc+bfzN5zCZJV3ZofTYMGkkqW4EzZ76LUb8EfdlXgwCuwfXuSzUFrII+?=
 =?us-ascii?Q?wVjknPZPoiEV86lPMuPoEiAgk1HIzeE1vs4NC3QA0ltkWTCW8l+FWzTRardH?=
 =?us-ascii?Q?aHlqulBdMUKdc9+4Tft+3rpMZfBScLQI/kKmtzErRTD5zHKf3QqZKXCghkPc?=
 =?us-ascii?Q?YESahV0urUmOnW6MuGNwp2IqYegkQfbVtS+eOMbHvdp7rpzEew9Ui36OM/d6?=
 =?us-ascii?Q?fxb0RNgnjzhJfMcz3W17/LSx7AgIW4lyhCEg0HDUGd0m/kLCLlFlGOTdBztJ?=
 =?us-ascii?Q?q1RZQJ9Ua5DLzBJZeSKCC/68ItCxpM4njt/yv8fNgl5mylGlPrcQYbOdJVcD?=
 =?us-ascii?Q?/6MHJxGK5u5g3/e3jSieZV90flx1wCI8blIYmmL2Abf8DG/EmCC1DYVKCrrY?=
 =?us-ascii?Q?6DbBo5752swN95OcLjBZjcJi1i4Tsk4FgcXeAXbijID0NjTMudjJcOlXz5/a?=
 =?us-ascii?Q?jD0P2yYdBJL2B8uyqMPQPqjvNNn8IXLA1nkLRHiQuVUBO4Ud5VVk9+2W6iZq?=
 =?us-ascii?Q?0ZEnzKTKSTwQSJogNBOvVekr16/EV5peTBhX/v9sZMOm4oNy4e/k5hTtDKBH?=
 =?us-ascii?Q?iaKDxQFqNjV2qHoseoILAKxhkfFOMApPM/LFrYFGb1NwjJS9WZynJu5t8nOc?=
 =?us-ascii?Q?N2zGBbQgg4kKjNjbxSicXw//B3as4IsZ5LAMB+abhQ2Qqq4DqzX56JrdCFAn?=
 =?us-ascii?Q?KeWtMYvOiwy+anKBP1LRIclCDDicoMcNtzdXnKQhFHO9PZihqykg0nK/96rZ?=
 =?us-ascii?Q?H38PxN5Y9LGnA35CvbE+Hb9YEVblr0tNmiyRjvMZ5CaBKky6IiX0A5tNYL7s?=
 =?us-ascii?Q?J7jRgVvEe9BLTzutIf2bAl4ZDz4DRsZIo7T71VI5sEgFG/hgR5CqqnROvvfU?=
 =?us-ascii?Q?DJ4FRS3dSqD8SpwJsShCS4oMvMDLCVVj8DPBVuLzlJN+LG3AfiiotgPH8ip8?=
 =?us-ascii?Q?SUnKIrlNFaEViMKa+S5CiZI7UcF7JGJ1jyfH8r0T?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4992ed90-2588-4b32-53ee-08dc9a7365d6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 08:46:00.2260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8TFlp5fZ2MqMFp2dvTItqU7VCox4A9xraQUzn9bsIRHfGhlPBlJcONY8IsWrBw6IhI6wRNXxTgyxLOTejpQZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5790

This patchset like to talk abount a idea about PMC(PER-MEMCG-CACHE).

Background
===

Modern computer systems always have performance gaps between hardware,
such as the performance differences between CPU, memory, and disk.
Due to the principle of locality of reference in data access:

  Programs often access data that has been accessed before
  Programs access the next set of data after accessing a particular data
As a result:
  1. CPU cache is used to speed up the access of already accessed data
     in memory
  2. Disk prefetching techniques are used to prepare the next set of data
     to be accessed in advance (to avoid direct disk access)
The basic utilization of locality greatly enhances computer performance.

PMC (per-MEMCG-cache) is similar, utilizing a principle of locality to enhance
program performance.

In modern computers, especially in smartphones, services are provided to
users on a per-application basis (such as Camera, Chat, etc.),
where an application is composed of multiple processes working together to
provide services.

The basic unit for managing resources in a computer is the process,
which in turn uses threads to share memory and accomplish tasks.
Memory is shared among threads within a process.

However, modern computers have the following issues, with a locality deficiency:

  1. Different forms of memory exist and are not interconnected (anonymous
     pages, file pages, special memory such as DMA-BUF, various memory alloc in
     kernel mode, etc.)
  2. Memory isolation exists between processes, and apart from specific
     shared memory, they do not communicate with each other.
  3. During the transition of functionality within an application, a process
     usually releases memory, while another process requests memory, and in
     this process, memory has to be obtained from the lowest level through
     competition.

For example abount camera application:

Camera applications typically provide photo capture services as well as photo
preview services.
The photo capture process usually utilizes DMA-BUF to facilitate the sharing
of image data between the CPU and DMA devices.
When it comes to image preview, multiple algorithm processes are typically
involved in processing the image data, which may also involve heap memory
and other resources.

During the switch between photo capture and preview, the application typically
needs to release DMA-BUF memory and then the algorithms need to allocate
heap memory. The flow of system memory during this process is managed by
the PCP-BUDDY system.

However, the PCP and BUDDY systems are shared, and subsequently requested
memory may not be available due to previously allocated memory being used
(such as for file reading), requiring a competitive (memory reclamation)
process to obtain it.

So, if it is possible to allow the released memory to be allocated with
high priority within the application, then this can meet the locality
requirement, improve performance, and avoid unnecessary memory reclaim.

PMC solutions are similar to PCP, as they both establish cache pools according
to certain rules.

Why base on MEMCG?
===

The MEMCG container can allocate selected processes to a MEMCG based on certain
grouping strategies (typical examples include grouping by app or UID).
Processes within the same MEMCG can then be used for statistics, upper limit
restrictions, and reclamation control.

All processes within a MEMCG are considered as a single memory unit,
sharing memory among themselves. As a result, when one process releases
memory, another process within the same group can obtain it with the
highest priority, fully utilizing the locality of memory allocation
characteristics within the MEMCG (such as APP grouping).

In addition, MEMCG provides feature interfaces that can be dynamically toggled
and are fully controllable by the policy.This provides greater flexibility
and does not impact performance when not enabled (controlled through static key).


Abount PMC implement
===
Here, a cache switch is provided for each MEMCG(not on root).
When the user enables the cache, processes within the MEMCG will share memory
through this cache.

The cache pool is positioned before the PCP. All order0 page released by
processes in MEMCG will be released to the cache pool first, and when memory
is requested, it will also be prioritized to be obtained from the cache pool.

`memory.cache` is the sole entry point for controlling PMC, here are some
nested keys to control PMC:
  1. "enable=[y|n]" to enable or disable targeted MEMCG's cache
  2. "keys=nid=%d,watermark=%u,reaper_time=%u,limit=%u" to control already
  enabled PMC's behavior.
    a) `nid` to targeted a node to change it's key. or else all node.
    b) The `watermark` is used to control cache behavior, caching only when
       zone free pages above the zone's high water mark + this watermark is
       exceeded during memory release. (unit byte, default 50MB,
       min 10MB per-node-all-zone)
    c) `reaper_time` to control reaper gap, if meet, reaper all cache in this
        MEMCG(unit us, default 5s, 0 is disable.)
    d) `limit` is to limit the maximum memory used by the cache pool(unit bytes,
       default 100MB, max 500MB per-node-all-zone)

Performance
===
PMC is based on MEMCG and requires performance measurement through the
sharing of complex workloads between application processes.
Therefore, at the moment, we unable to provide a better testing solution
for this patchset.

Here is the internal testing situation we provide, using the camera
application as an example. (1-NODE-1-ZONE-8GRAM)

Test Case: Capture in rear portrait HDR mode
1. Test mode: rear portrait HDR mode. This scene needs more than 800M ram
   which memory types including dmabuf(470M), PSS(150M) and APU(200M)
2. Test steps: take a photo, then click thumbnail to view the full image

The overall performance benefit from click shutter button to showing whole
image improves 500ms, and the total slowpath cost of all camera threads reduced
from 958ms to 495ms. 
Especially for the shot2shot in this mode, the preview dealy of each frame have
a significant improve.

Some question
===
1. The current patchset ignores the migrate type because the original
   requirement is to share between DMA-BUF and heap memory. However,
   this behavior will cause serious system fragmentation,
   so is there a better solution?

2. Current patchset only supports order 0 and use reaper to reclaim cache.
   Maybe better adapt to drain work and high order. 

3. Actually, above internal test set cache pool free before pcp, and alloc
   behind buddy free. So task will push common memory, and cace will only be
   used in emergency situations.(before into slowpath). This will result in
   better performance, but it may impact the system. Even if only when
   application start up, cache enable. So, which better?

4. Current patchset is simple to talk, some struct maybe need refcount/lock to
   fix race access.

Huan Yang (4):
  mm: memcg: pmc framework
  mm: memcg: pmc support change attribute
  mm: memcg: pmc: support reaper
  mm: memcg: pmc: support oom release

 include/linux/memcontrol.h |  41 ++++
 include/linux/mmzone.h     |  34 +++
 include/linux/swap.h       |   1 +
 mm/memcontrol.c            | 481 +++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c            | 147 ++++++++++++
 5 files changed, 704 insertions(+)


base-commit: 727900b675b749c40ba1f6669c7ae5eb7eb8e837
-- 
2.45.2


