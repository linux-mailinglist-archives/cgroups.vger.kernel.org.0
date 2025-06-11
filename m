Return-Path: <cgroups+bounces-8497-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05859AD62F4
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 00:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247A5174F8F
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 22:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115EB24DCF1;
	Wed, 11 Jun 2025 22:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qmuZ/jeq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p+P6kAvl"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4F524678F;
	Wed, 11 Jun 2025 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749681908; cv=fail; b=Qhnp6yRlooWslfqY487bQA7MFaoM/7yZlX/kVC+9wpjkx50r5YfesOLTDrI8d8pKk2FWAJ5waKkVgZCj+MnSvRTVCv7mEYO/fKS4ktqA0FhC4mShaz3muP+CaGjdpJBquDaPAjS3p9V6Qn7NNltVlflQ67KEBM6fQBJqaiIMsoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749681908; c=relaxed/simple;
	bh=mkKviuBhR9sfAnW5ooEmVK4QcDzvWABnkOIs5NsWsA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L/TAlGa3pvzYiDLUzH4/8vFiesjWstJfz57ARYy7TzkeZ9nnU5u5xQGd4VKpfPly2eFAQCdUtsLDVdAoaejv384d8fqF9ty8gGm7w0rhHplBK6YU67fwYbdgeLvhdMOnFoFTa7fr5oPPoQCnmIdFyK0NgUCtTb5jubBn3KYp+eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qmuZ/jeq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p+P6kAvl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BMPKfq011246;
	Wed, 11 Jun 2025 22:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3Kxgyhd9g+8eGu9Yu9
	O7X0Jzo/hQDvLXky0IAaCprDM=; b=qmuZ/jeqFTSALxFQXkmSD96mHLulFSIunI
	Fjw+T6cN0jpRXxXHEWBlj/Td8WCDadB+EcjkFaHPgnB7kdFpkwQD/vvXRpuPJCho
	h7+0nQ+2XFpWJq+gO311xGutIpwUTI5be7ORqV2Vp2V0Wnfkn8Jkj2jFrDgsgzQF
	xEzeX7XgpALvF777WWqx8K/femK65slVsxHOUSzgWiAPAbBRlOgWb4jovU+chp2S
	j71yslaknn8BAF6gbRNCQDyp4fVoDB1ePLgPj9aYBQBTNGXB/lFsIp6bgIpGH2qX
	2t6fye0oGCDyDmDhHNICJYeS64CnT8zqOT8aUcS7Z+tWKyuGQdew==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v8n70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 22:45:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BLv7YL020981;
	Wed, 11 Jun 2025 22:45:00 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvh2mrv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 22:44:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJ/beJMOTkfNilP/qS3qrosAfBAFvUv32x1s1nZHvLSf8cwq63IQ3RnHL0QGeYGJHEB/VCAq829lyw5quvyzTaxzMdw11yRSvQLfm/AB6NFj2elZFx2mFGdZpvUYeQ8NSgA0ORxmqcUiSRdWNR+cV0aNvmmeDhhAH7P+PAdtGcipt2esJAHqoCNQvqGk7KabRsN7pXCL1PoNODr7heHQRfwFQMGonu1M7E3LyXn6iaDV9kO7yg1zrVJ2KUv+I6rtXAvzyt4sZMVyOFpc6u/yRBRnbn3BrQjwqhceKKjVkdMeaTKLWRD81yImRueVuv87IATyP3I838Fg3dfcMzXkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Kxgyhd9g+8eGu9Yu9O7X0Jzo/hQDvLXky0IAaCprDM=;
 b=wGkc9M4DfmIOTbnGzQ+DQ7G42BuoaUutySMAISEUHMzq4QBqm3ZHRyH+NArW1SehWxlUjlTGbu7uGOlrCOsNQE/W2/FH3kPvBBHR3gHwyqswkR18hOXALMSBoUeJ2MTm/KJysJ2qb3AKIL7B/rReveB8kH53714ne9R3ODque3zgQj58QBUI9zwM+Zp98rYEpMZ5LGFdcdwyouV7gPH+Un80ljJ/Fld81S9VNsCzxVFpwrSsNEPKMXJPlpwBdww9TL2IX/0Kz1hmi3SYiApJ/YcJd/7/8Uz9DLJrDp7yx+PV4KU2YuHtA99hm0VZMEUbVo9KwW9DNgfclFNSduwWxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Kxgyhd9g+8eGu9Yu9O7X0Jzo/hQDvLXky0IAaCprDM=;
 b=p+P6kAvlghVvZKsFKmUeGPOF6CiWjodERVtes5e7aQ3hA5BC5AhYzgUhYFNvcReIjFKQqaOHrO9A8w4Bg71jlQrvxqNhaYPG9ncKO6VpV54k2Uj99g7R/++p0ss4QzXVysKbaHZ5Rq66KWDvVmKwngH7oigBkU4iy+Ob9mYjBUg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Wed, 11 Jun
 2025 22:44:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 22:44:56 +0000
Date: Wed, 11 Jun 2025 18:44:40 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: allison.henderson@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, tj@kernel.org,
        andrew@lunn.ch
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] rds: Expose feature parameters via sysfs
Message-ID: <aEoG2AU-hWATOQCI@char.us.oracle.com>
References: <20250611224020.318684-1-konrad.wilk@oracle.com>
 <20250611224020.318684-2-konrad.wilk@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611224020.318684-2-konrad.wilk@oracle.com>
X-ClientProxiedBy: BN0PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:408:143::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB5830:EE_
X-MS-Office365-Filtering-Correlation-Id: 419ded74-ed4b-4d0a-f180-08dda93996f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vw3NVHa2oLZqzVednDGARgzeFVt+lfY49cAbI+1ZnivEZqq+JEzYlSdb0Fhl?=
 =?us-ascii?Q?aXeQfb5vTQNQgoLpTmpB1IfNT7TjQQ+CT5RwvPZXWL5BkG8XJg4KpcAUQ48Y?=
 =?us-ascii?Q?GKDchZJc2Nwn0HgSj1AtcTQI9tqfrzGZdgq1/8UxvuaaWc4vZYFeiDpu1yad?=
 =?us-ascii?Q?nxKEzgK/v5LI2qYwHQXyMKE2WPb+fZGqpKDWlVYvkOTsAJXxQSNlnzK03rBb?=
 =?us-ascii?Q?ilILChIQAnPSOyCG20nvUJdnfcrDq/v7zrI+iZRozU2bf4IadoC+DRRr9KOM?=
 =?us-ascii?Q?SiGbZTRbhWb9s1389pudo04i/5tlOUr3A0gJcg3Y+p0Xf8foeOTfBPGTPzU+?=
 =?us-ascii?Q?1ZW9N8PZbUYhid9dmbr2pVE1edOJr+bD3oVaXFFRuQ8tKkDUz5mqWHo/cZrY?=
 =?us-ascii?Q?Tge8c/Vx+tf5Bj/6uyDi8lO0NZkaJI5JtG8S9hgieJVvJUYaIF5ED7coqGcJ?=
 =?us-ascii?Q?CqoDcVrcAK2dIpwLsd4OC0lUxFNaUXSwSEb+8ybnxZL1MQUvISCXyKv6yIFX?=
 =?us-ascii?Q?pWhd4LvFIJzBfOXB0ptOQI+0rH63SXxPiclDTRA3uRW6A5N7B6B5216PqRN3?=
 =?us-ascii?Q?4Nn1QQ2SL33IEYagWME7o4FD++fhxHSqPJdtR+ilwdRSB9rN3NcJBgjZ1syT?=
 =?us-ascii?Q?OJkBabgahmnwpFTq1Gq98gWaoqe47FS9oswIwwv9U3oJFd9xbMqhodGHEDx/?=
 =?us-ascii?Q?OOR2J0sLl7QuQZh3VT1D5RaMXbIOjjzU6uuOumRkKg400rt8iu7uj4fEEh50?=
 =?us-ascii?Q?c1vakqk1sgmhIIw1sMu2BCOrUAnNecvqjrSvlIljQVD2I1T62B4Dzv7wL8FI?=
 =?us-ascii?Q?FZbkR0wRzvtyK4uj2vgDR/OO3CNnOH9GhonAQR7ECrd8re41WgNQGLnVkVoJ?=
 =?us-ascii?Q?M7tieWu1Sw2+qzU8y2aUT/9ECEZFkcGbOTvSg6diK1lbbkeq8zu3q0LYrYqJ?=
 =?us-ascii?Q?JPdtSjXiWIDPZ4IPjtEapkoNf9kUsQuGiDs0ekrWmQDcxDj/koxa5xXQEa0m?=
 =?us-ascii?Q?V/udKLzW2v0Fhu8CuTaTZJpXlsCk7a7ho/ku3I592qkz7MEeAnAyFZpnODKW?=
 =?us-ascii?Q?wWGtmqsSRK5Hr8Ys8BiZ1v69nGOFmhlSS5pepvnVjQuJoKAgJN/49fnZw4kY?=
 =?us-ascii?Q?D+dOAgk+hw+vmCsZE3dBk8v0xw4DS0j8Xb2X5eI3zpKZ4rIxRzY7bKbvKeVT?=
 =?us-ascii?Q?2Q1CxuU7az0jZAGm1kFXUnSq3CRQyvLXMqFj/gxDcKjt53CpvK05bzkdB5zr?=
 =?us-ascii?Q?Fn8L5VU2ZOpPSjBZunn98QU9qzUjGdOYJdH8alklha0mSCHnM6bWPZCZUjK1?=
 =?us-ascii?Q?Nj0n6KANeXN4+nwyISyWFemj3cmY93uFdUJ6HNjHxC9UVosTqPsw/JyqisE7?=
 =?us-ascii?Q?tmFxag3/DMDRsw8ug7sOhPvGqvsR7GQ3X9MnFhYVMfzFcZ2wRik0N9PTq5jR?=
 =?us-ascii?Q?ua41cBF3qCY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ylzBrwrGg+VVjiAQGN4u/MSbZcc/7rvPfyUzoXSbXGnYMy3QehNexmufjOL4?=
 =?us-ascii?Q?acp4o3S1m2ZsQOxAaguzVdf6J17ElMNCKWbUjZu233bKZv2lAXUv7wYGC0CS?=
 =?us-ascii?Q?jvhsl+kZdZo5X7fC0BYoZBp7zeQTVlhvZAaTLu07292EwUAiYW2UWRQib1kN?=
 =?us-ascii?Q?8UElEtIQNSt37s/WhlYVW1fopfAjUeIZ6AQ/zj9YimftslzBu39KdTjCTAMw?=
 =?us-ascii?Q?X2Fhx/st8euJBrgWpABBUAZmMhaMOW+QcyGLyagh2qo6PlYsld2snS8z4cL4?=
 =?us-ascii?Q?4ueZM6EvFZTZcAZGRLVJv5P1mYslmemWWXwACPFkIK7A1nT97PbirjzIbW1y?=
 =?us-ascii?Q?EA8cb7s4KRj19jeJCfvUXozOZOeRxytnD3DpFNOLClQbGS4S1cW/9QUy5uxe?=
 =?us-ascii?Q?SGEqkEFqftNj0TkEFMqJwwqwo9SuN7lUcCV6ZLtFrGKBqOeUZeY8PwOxcqNT?=
 =?us-ascii?Q?QqkHOGvV4lO38N7sU/6cX8902qnPyuTeYbTNd3Gaq5opioVuyxNjC4fKIA5T?=
 =?us-ascii?Q?QrmETcxpjrSiFqBPbiNieU+DPOvywC/BTxerXtuIScXf2vw/HccMFwLMMR+a?=
 =?us-ascii?Q?85+0O+oLzfG+pjVEh/2nCttGWyuxQrV/lxBRqux/4DhJQl/X8eONtm4XwBG3?=
 =?us-ascii?Q?emod58uOHM3fo0CDxnExvRh2wGbHnQkJioJG5+1B9/Te+rqdYyTkBzLr8Anz?=
 =?us-ascii?Q?uD8NTWmsZLNxhRIBM/JrHMweXyoYIhOOJ5nQF6RjfpG4BonMKvRgGapBV/5v?=
 =?us-ascii?Q?MJuG2rw0IvMeO4S9PcrCSNUBnArRlU02Mooo0QTk2VJVlv88OAxfYor1KkhP?=
 =?us-ascii?Q?EMMbiHbQaFddHKSqd0qouuxIajlUHPbuCxBnaO2sVeHUofeBDfE0uWoXWFop?=
 =?us-ascii?Q?PrrZDBCeiwlihOtloh3JSPEkLNtr1pidSey/YwVOpoUfsY8r5ZtT/L5Ng2oH?=
 =?us-ascii?Q?7Koas0VJwn5iUo52XxUqMYlpe3me17xUbDM61oK3uCfdDZ1IjfCHesSI4KiM?=
 =?us-ascii?Q?REhCTVDqIUOGjF8/wc55VPAIlpMneNHiL0L17e9Fou8bN0YVoxnMPBwAD/Gx?=
 =?us-ascii?Q?tQaQVF1IvItNbif8BN+2aS6Rke5ZnviJ8XfWbfiKXOsGKbg4YfG+z5noG4MF?=
 =?us-ascii?Q?ipD5OVUwronSGzKhKYQP+sv37PcBpb4D7sYyn/2tlfGxlBfrwLjX3XuXybql?=
 =?us-ascii?Q?MPdMywLMJae8PDmeuCoCJ733oiPh94a4vA7n45qChMhgqXLmE21uHsZtUbRa?=
 =?us-ascii?Q?3VLxW0S/SpawnAab1VMWaQZBJtBpaocDjwtyb68ty8WP5fZvXmdhVk4cCZzn?=
 =?us-ascii?Q?UsFHpdXbEQTJrNOJWnTszc9ZKMZfvP/kbu7dxv7nvt3zYVqdwOZXWmY0uVHo?=
 =?us-ascii?Q?XM7O15K3TAKjwVTjhcXe+6eP2Z3KaMP9K5YPttKxqQZ6zMh03ecPYeRqs9J8?=
 =?us-ascii?Q?eiAXSv1WguFp45szPPhGJ1/VQf3mroG4QGaus+cEvYbhi4y8INLfM056wjBF?=
 =?us-ascii?Q?yYnDdgEogEzTz3PKJ9rvdvm91TDii0R5sbR7qt8CUQik+XqgHz8a8LXjxYAn?=
 =?us-ascii?Q?PcGhHl7pB25/58bqOo6HA32t1PFbH6rj9IW11lISvRU+tzw9OsqOVzUJjbUZ?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wd3NJzr18YuQtCqJCWG4KV0pcLtphMPCdKp9Oql2mtw627WqxHVwyx9HqsH20l6rxucCNOII5iwPHz0rf6I6++gkNGxTSATvXIj7CSi1F2/VOWBfSKMscgesm3qB+DiLB4cWtN7VadvReVFAJ/DImjwwMXGM437bGrmFZXEmk9UWqfU3gDpbPAvzBnnoKq6DYalEXZtwLkqGJVe+WAi2BEYJmgb4NTfQbCcCn5o7hiLRIA+pMfjQseGOT2yPhi6dqzJMh7lpwC/CSvUk1NpOVQ2WXCfwmxyNUWJD+l6dKRFyv+CLPAMPD59Uz40Lj5CN5kM03cJ+9yG8q58x6cZ8OAxHLGeQ2jwsnxkXS318eonC2dngaEu85rkJ2Dl03iKqcjikITLZkcCzLppBqVYndjCZloY7JrlAsbRoVGTzxaq3JkKUhSUCUqDU4Rqa28CvymJuYHWjMHwBR7U3zuxjI3DxhSgXlAnqoS2NzcCyAKzcsuDt+PtfzmCqHT1vuBiopS57Krkvqhvg19belq0wEGh3zuxP2kGpejQ8b8UHB4eoxUM/V+AA87htmWnFQfsFgB8lsO3UiWCj9FMdRmlzhamBtnmwcb6Zhpu4ajhYHUA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 419ded74-ed4b-4d0a-f180-08dda93996f2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 22:44:56.8528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTHVLwAhJHPhqcjQNh4715F/JCxHpG6r/+P8JD4yeTmhics0ZvMIPao13RiKf/imkXV6JDR8llml9KyOHx6IkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_10,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506110192
X-Proofpoint-GUID: _QbBL47z2p5oaxgBm6C2k7bxb_5icK2P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDE5MiBTYWx0ZWRfX2ojfIIklEW2g LiXkcvVnUN4oh3bQUauDzmf9TD6ExQXZRS7km2oC+4indHdZEq3EApmrXNkCY2ToXIv5QjcTEZv w20FM4rnJfLXbaZgE0qHwctgghyiskMMJhW9ypyqa64BInaZspRdzQMzEZPc+oYY7pDbBQlouBp
 CqtoddtfidIxyi1QihJQokjDY/gKpI1n12SBNqMk6Yqyf1eGtz4hjAGbXjZFsjcw5wCFveFjTfo GFn3kxScDOXFHoWNVMt+FID7J4rjA5kwXQiGDkm4xzYGLh+wmCM6X7T9SJcl8iBucqugjpCUVdu Q5yJfv7LlglQzj5LrTuPrWrLmlAnocp5qtoWI7MZt2oZTahPOqZmej3ySyPSdA72FrPCJPYB8DC
 jRtnU1zZcgHA7yJ2OFbs0C1rPpyveFzkX/1Jg0Fqbn29dhVXBU6Rs9gU0QEaa2sDwJLyuIhk
X-Proofpoint-ORIG-GUID: _QbBL47z2p5oaxgBm6C2k7bxb_5icK2P
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=684a06ec b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=zemhjNPUNy_gsqCrXwgA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13207

On Wed, Jun 11, 2025 at 06:39:19PM -0400, Konrad Rzeszutek Wilk wrote:
> We would like to have a programatic way for applications
> to query which of the features defined in include/uapi/linux/rds.h
> are actually implemented by the kernel.
> 
> The problem is that applications can be built against newer
> kernel (or older) and they may have the feature implemented or not.
> 
> The lack of a certain feature would signify that the kernel
> does not support it. The presence of it signifies the existence
> of it.
> 
> This would provide the application to query the sysfs and figure
> out what is supported.
> 
> This patch would expose this extra sysfs file:
> 
> /sys/kernel/rds/features
> 
> which would contain string values of what the RDS driver supports.
> 
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Argh, forgot to include:

Suggested-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  net/rds/af_rds.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
> index 8435a20968ef..46cb8655df20 100644
> --- a/net/rds/af_rds.c
> +++ b/net/rds/af_rds.c
> @@ -33,6 +33,7 @@
>  #include <linux/module.h>
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
> +#include <linux/kobject.h>
>  #include <linux/gfp.h>
>  #include <linux/in.h>
>  #include <linux/ipv6.h>
> @@ -871,6 +872,33 @@ static void rds6_sock_info(struct socket *sock, unsigned int len,
>  }
>  #endif
>  
> +#ifdef CONFIG_SYSFS
> +static ssize_t features_show(struct kobject *kobj, struct kobj_attribute *attr,
> +			     char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "get_tos\n"
> +			"set_tos\n"
> +			"socket_cancel_sent_to\n"
> +			"socket_get_mr\n"
> +			"socket_free_mr\n"
> +			"socket_recverr\n"
> +			"socket_cong_monitor\n"
> +			"socket_get_mr_for_dest\n"
> +			"socket_so_transport\n"
> +			"socket_so_rxpath_latency\n");
> +}
> +static struct kobj_attribute rds_features_attr = __ATTR_RO(features);
> +
> +static struct attribute *rds_sysfs_attrs[] = {
> +	&rds_features_attr.attr,
> +	NULL,
> +};
> +static const struct attribute_group rds_sysfs_attr_group = {
> +	.attrs = rds_sysfs_attrs,
> +	.name = "rds",
> +};
> +#endif
> +
>  static void rds_exit(void)
>  {
>  	sock_unregister(rds_family_ops.family);
> @@ -882,6 +910,9 @@ static void rds_exit(void)
>  	rds_stats_exit();
>  	rds_page_exit();
>  	rds_bind_lock_destroy();
> +#ifdef CONFIG_SYSFS
> +	sysfs_remove_group(kernel_kobj, &rds_sysfs_attr_group);
> +#endif
>  	rds_info_deregister_func(RDS_INFO_SOCKETS, rds_sock_info);
>  	rds_info_deregister_func(RDS_INFO_RECV_MESSAGES, rds_sock_inc_info);
>  #if IS_ENABLED(CONFIG_IPV6)
> @@ -923,6 +954,12 @@ static int __init rds_init(void)
>  	if (ret)
>  		goto out_proto;
>  
> +#ifdef CONFIG_SYSFS
> +	ret = sysfs_create_group(kernel_kobj, &rds_sysfs_attr_group);
> +	if (ret)
> +		goto out_proto;
> +#endif
> +
>  	rds_info_register_func(RDS_INFO_SOCKETS, rds_sock_info);
>  	rds_info_register_func(RDS_INFO_RECV_MESSAGES, rds_sock_inc_info);
>  #if IS_ENABLED(CONFIG_IPV6)
> -- 
> 2.43.5
> 

