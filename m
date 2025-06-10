Return-Path: <cgroups+bounces-8474-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB10DAD4417
	for <lists+cgroups@lfdr.de>; Tue, 10 Jun 2025 22:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD163A5D77
	for <lists+cgroups@lfdr.de>; Tue, 10 Jun 2025 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5690B264A85;
	Tue, 10 Jun 2025 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WLcZau97";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FbJT+xvD"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B192494ED;
	Tue, 10 Jun 2025 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749588566; cv=fail; b=Tz8zO3pmmZ91Uh/SnNeWpbCIQlHfzFAsoG9zn9b7R4vTB5CVsUmKppu5KcsPWGhHSQA+LXegMcJRfxNsmsUnIw4Cn2GUJwdOejYXGuQ4AEOUMc4EhGD2bGFai1VFx8nQrYGzOGhPqPRecmzLPpmia0YP3QxSdlbAmiRxfI3Mn28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749588566; c=relaxed/simple;
	bh=rhlN7wUMXoxwEdcKcy2kv5zqUyCsLv+XWoMSG8h+SZ8=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mPzqtQLmDWgR95G0odACGvO1Itqatwb4u8ag8a8q7F6+6E1hptqYXvYxparZALuvB4LaEN1Y7MUhmpEzxsAximfT6dREuVqjxxsAHwj3iyA0sUX4PVbE8l8qnV6Mp7APWQ33/fjtrX1qkOQmZpKfrDWnKpMu5gL2jZYjMjYOB1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WLcZau97; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FbJT+xvD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AK6jZk018456;
	Tue, 10 Jun 2025 20:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3mfhzUaaLHvXEhpG6S
	T9SnYZXuDj23ZZtUcIFLtfP9s=; b=WLcZau97lASgiYWPdhgNc6JoIOCO/L/juw
	r2ChCOm1XCJ1HVeW3oSURDC1JjB3v7ocIVHcbHx28TRRBb7emYry0fRI1Ly6H7yd
	pDzlIoFeZHSkQXW50RT6r0IXsdNuI5tcdcDbLtyiLjFte+q9SZ8h802W8qlo0c/D
	IhDTCOR79VsP1BMZ/P6lV+DMA+w5wyN9ja95kh2mEHBvL8vE6wO4lnu7BJDI0KPz
	ymCaPqeGTuTN23KQk0RvcMzYyji0rMGw9rcTYbiXRXUC7pQ8CSGiaMCiX5ZVZOZB
	GmeZc12T4yDNCK8rA7uks8oL4OO9SD9Ax79ptkCYMPcirembd+1Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14d261-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 20:47:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55AJpRkQ003281;
	Tue, 10 Jun 2025 20:47:42 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bv98suk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 20:47:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOGZQSaoGHugSCN5g29dcPcog8Z3tvsxtq2YlLBAJJD60X1HoNAAtqM1qMObWXzrNXZAI0MqZ4AscN+hmdErzMLVvqb9PBxdPBBphvzod+lJzfFf4bXnw7udI+g0iILcJdj/0x1StFEgiYiCeiBTEFAfV4YGEzhygR3DD/M/+YYGcqhDhtZIW0cydvHlo8su3vSuTMejyJmvZ/cZnxvdvL9ZijPVL76mkQCb6F2l5Y4Wi/PV5onrpsm0YP4dy3bUGz+qZ3RSWqGv/PnuUyJmnUHf4RSKsFC3uZ0UQqBSp7V9pWOdxZEsjIgzzXqK1i6ZwBaV5fFIQKKJoU00Rznw8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mfhzUaaLHvXEhpG6ST9SnYZXuDj23ZZtUcIFLtfP9s=;
 b=OIwqJRJX7+eJ1wFIQfpTqfQO5n9OZnT4z4vO3YqusMt/0LDsJLdwrTNXD0oYyUEvIcV6J++TCyCt2fMs+85s0NoLePrP/ySQvXGvyN0SNAFSkvLQiaXaaQEULZtlOcvUZzPP2szFIq5ikqzgG3+UqjlzpxC2ab13PW8nqVddaSi1h/O7znPJIkx8VOri2WjzsrTGIVbY09uQhScx6mjqI6Ox5/E2GAadPKixABa3ZV9qAiHYg7gc+nU0qRARdRvYwcpnm0HC2hAEqbFjahNrQMj1WiTQGFKN5Mj5gbixcYvOVFX49ROUgl9tkfLsZRHGMECdLePpC/tAoZM205Pr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mfhzUaaLHvXEhpG6ST9SnYZXuDj23ZZtUcIFLtfP9s=;
 b=FbJT+xvDcF3ZulIL9blq2pUfzGyp29KeqNz7XY7qUJJNLlARdweW6e4XTtgjPwGN3YTpETF7CZJ8oUdAiSRoKkyVpgiV3B89H87ufJxtaNmE+MshQYSCmx7gAPBXa1eErNqbmVxb5irdtgiDTNaiSF6lyZmQMQ7wt/8UfLsLqVY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN4PR10MB5544.namprd10.prod.outlook.com (2603:10b6:806:1eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 20:47:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 20:47:38 +0000
Date: Tue, 10 Jun 2025 16:47:23 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: allison.henderson@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, guro@fb.com,
        tj@kernel.org, kernel-team@fb.com, surenb@google.com,
        peterz@infradead.org, hannes@cmpxchg.org, mkoutny@suse.com,
        cgroups@vger.kernel.org, andrew@lunn.ch
Subject: Re: [rds-devel] [PATCH RFC v1] Feature reporting of RDS driver.
Message-ID: <aEiZ212HZo3-zpMc@char.us.oracle.com>
References: <20250610191144.422161-1-konrad.wilk@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610191144.422161-1-konrad.wilk@oracle.com>
X-ClientProxiedBy: BN9PR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:408:f4::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN4PR10MB5544:EE_
X-MS-Office365-Filtering-Correlation-Id: 555a911b-f5bc-4e1e-5056-08dda8600981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SktT+E3nd+wg3FGT5y+3+SGRCEOlsNWiTRjDmwRNO6BUDS3x89sokc8rrZHa?=
 =?us-ascii?Q?Wy5dXyV5JoXsjwGujMAl1wZQzdwnlW96HhTX96tfO3lv55Y6BJiIEFrVLZkG?=
 =?us-ascii?Q?uXKcZJKrd+vsu+Ox49A8OwmZ7x4X7Zhc1t/gReabye1KjiHnIHeEmKylFEcF?=
 =?us-ascii?Q?zWVmm2qNnq2wrmkLikSHQiZf5U7AIDbtGUM4NBD3DHH70xrrrY8wg2CqBv13?=
 =?us-ascii?Q?ailmNwcXOW3AtIkRfdP8JAU2Hhw84O/sE2yxNnlBZnMpnG4OW0iL+ihwSN5L?=
 =?us-ascii?Q?yP76eqyeEr5NSFNFrzDjmdJ5bY2RJ30te8mH9yVRFI04GT97sOGXJ5Ki73gu?=
 =?us-ascii?Q?IhTSKzRLAMPF/iGAqAuwzBUK7ZJNzzuGvRl31QUTodY4aNnfTKSheYm9Sc/M?=
 =?us-ascii?Q?P+As/0sHaGcHYdyrdslg/8/yJcpOwtD3eRMSpGMhN8C8zxzOb7yYbejBmDRs?=
 =?us-ascii?Q?KUF6eBC40CgrFnTQPIKJfGeC+jBaYhPuFngHyIhgPodVrIjbtPENQGoV+HQa?=
 =?us-ascii?Q?rBUEjyhO1Kr8PqISYfpXVM+lUGu7+mxY1Scy3V2//INnqtH9YDQ0YDkNjjKR?=
 =?us-ascii?Q?H3cQ9VQ1z3VoE/OJSz/H1JsUT6uIhBfImeFAqFt9LmqFRvYRPFU4J2tdnZyE?=
 =?us-ascii?Q?t3fBh4CxyednKtZg59AgCJ1VXYcE6IUeIZw4D9LX3Htx13LClzB6FV0iI77Q?=
 =?us-ascii?Q?tNMvF+2q8hZGaGxLLNzgNMKgNxdbIVjFy4uHbWHNGqYp0KIQea2mjjBQw06c?=
 =?us-ascii?Q?t5HJhxKNVR6eo/eiK9mCV9pWZQrlAO6/VmcJq/2QJZF3uLYJOoluL59FHw89?=
 =?us-ascii?Q?71nQLkwU8CzE279eqcWoraAPbEixZoANLN9vDuoFghdUd+Ry6c6JxjvElN8F?=
 =?us-ascii?Q?NFl+FxzUqqUod2oGi3KgeH9NCHv5vzMxD0CYkQpmgDJepnSF6wD35tnxLKHG?=
 =?us-ascii?Q?LtCZIGKBqEdWf55kzM1Dzj6Yxs1N60p/OIuBirB7jAaoY3jq7U2BoQ3B1alF?=
 =?us-ascii?Q?q+0B21xiIMdIrah0YjjUZeRZsnRWn+AGvBDx7fe5jTJ7yWophInaDDHwzPML?=
 =?us-ascii?Q?AKFZmCRHKeGyUEFxzc1TC3wDTZj5a5lw1eggA8VOo9ZkkjGtPvVdAudblhXE?=
 =?us-ascii?Q?oC1nv6T3a7M1ERiTKJevtWq2K2tirI8cCt6luIq3xoZ5uYa1OD60/ei11BJL?=
 =?us-ascii?Q?VfV6sbnuHHD6QN9pLynqFiiPfIc+Yzt3ccHMyeGLqElN3iQHfVU65KihAqln?=
 =?us-ascii?Q?jhS6LNIYGzflw5h3t+fe/jVI66qxKXLkgx/Q44AktFGYA1nxA2WfWxrX1tp/?=
 =?us-ascii?Q?2xBt8NGGM/Nc1qw0LO0qTVG+m+kQBX2cXml5e/2ZyuIVWD/Yl6I/wk84Y0Nw?=
 =?us-ascii?Q?lEGQ2BhFydJ/oPhg4f/+kIm1mf8iKwSXgm6fgaZoYN5b2cxMYmJriAaRxB3V?=
 =?us-ascii?Q?7Q5ZUm69X9qd5MVk5B7vwXPuj3YvqoA4Ty8aQ+ZemChsfAbskayI/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rIw8y3iNAsRZXDujv1ZT2+jGs6HXM06nndt38LLgDe2kA0hkyTy+fydpVirz?=
 =?us-ascii?Q?96FHw4qq1IjfyIkEe32SJo0MTmr6bZXKa1WynzwUNeAXufC9UoEY/yiTXgd1?=
 =?us-ascii?Q?iXpD1rm1NRrVWPcoDppT6fT5VTW9VMjm9v+fNe/j2lYWNpti+En5sl3o1u4G?=
 =?us-ascii?Q?eoLL0xfrbGghFz8JZopViZg2dJTIYSa2PCEL2xMHSaKDr9AQJh5RB1WjR8Ey?=
 =?us-ascii?Q?BaB9VHrMzkDysC1ME4eBjSDQ5iW0UAo4aM4T2gjZlYgIpwlb9Nk1LqjrfFKe?=
 =?us-ascii?Q?wL4p4L+zcQIDJA2QoMauySW7mlAg62TB3QDdmNFp3tV6q5SWP5TPTs0GERoD?=
 =?us-ascii?Q?fK+YIs/RmBAny/J6tcOsNbzgH023oRr3QlkniyDv6K2T7Zcn54zdRdqS8cl1?=
 =?us-ascii?Q?ccGAHCivocxcNljqtaXbfI+xQldJ5rJkTgcyGiptWwRvF/esBEJkCJ1kULN/?=
 =?us-ascii?Q?SMqI45guBwfVaHeo1WZN7JTk69ypKIIfYY5BISrKCuXwVIFW320nxeEH+GeD?=
 =?us-ascii?Q?LPMxbnZCK95A/fkkfCzqMl/wEfmXOA/E+u2h67jZDGLinBmUV2eRRMKeqP9l?=
 =?us-ascii?Q?P6456vrir2HTUKiiS2ZSl9DHZ8CNkNpf6fM7q9rO8KPFfpMRxchrud4BwZbh?=
 =?us-ascii?Q?w4tNaOmFX2e/CL1Zc5ffSod87vwH2mwd5iwOB1boMBCAxGAdboH3gl9ItB2O?=
 =?us-ascii?Q?ygZ8XEvbNUgESzNpPMGj9HXipJOtAuB2LbGKfzt/oKXum7e7HUKYZCFGWcDk?=
 =?us-ascii?Q?nCO6e6S1oW5DRsMsy5PqW9oSSTmZ03P2kK8hbuM3UN2c7DLQeudJ7hmqKtNq?=
 =?us-ascii?Q?HYKfAl4h49Fhv8rJoYaS3lH/JZVPxRviCKYfow5Pav/Y+4CZ838GAzN+meUx?=
 =?us-ascii?Q?36O3iGO8kWCh2rto7HQlpYdDdbUVJed6kMnt3C3qlcQKhEZ/lFFkeAJg0zpa?=
 =?us-ascii?Q?vdIhtYn86Tl3Ow0XRtxb7YbiUn8hXyblSETSvA6iVW4bS6WY9DzT2wPA6WsO?=
 =?us-ascii?Q?MYvrfSgxYFSaIa7WlN37jMsFfZf8hww5DxPwKCGWSHVAA+kHGUt6EMGOSIsd?=
 =?us-ascii?Q?EMnUqXEQaVLkMKY4rkvW3SWeOGlPAxAvxwsG93mv8GJIj6y7yfjbCweisp5z?=
 =?us-ascii?Q?+CBFUreWzVwRc8q+eQSof8ay8LMvZg92o2uoNLwQCbedOS3M7gpwIHRjNPqx?=
 =?us-ascii?Q?zbpPr3XgPJXqrb+Lsea1c5pNQmsbjn6LxE2cyHmVSavZIg3B/1atOlOluKQS?=
 =?us-ascii?Q?ked0v5N/c6MVK+434NOMFRyTJ1/GueHYcf2D00ikzz2sCuHiRvGOXcPaayKl?=
 =?us-ascii?Q?VEPP7VOq9b06SYtbnzf/pCCBdZokYMYbP08RkdfCuHwoweOti05/VGguoDRl?=
 =?us-ascii?Q?9ckFP7sHNZFEpFpgDd4SYbaaWKQCGZgbRgCeHtQfqiRBgp6wkDzusemJTjH4?=
 =?us-ascii?Q?M5mGDzh5iIQtmZxqsHMuLy8utepcOkqy51DaMX1wyuaVnfciC6zAXNE1VP6U?=
 =?us-ascii?Q?l5Nz/1g45Sntv6fVG5NrDKCbFlj+vz9sW8h3e0FCEozpy0A+2MJAWXZpNwm2?=
 =?us-ascii?Q?uKfwo8Mhqy37Hmzwjhv0f9okuMgTocd8u9juRZgiMZgoVr66/9XzI7NWR7pE?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UT7iDxh0BpL0fiRL89MXVIc7VtLJ9KgZTjLc35qMUY1DDt7RunENFr2gCRUtun59vv3nxDeN/AtkLFep7atH0oEcz1At8UM1aZ5loHOCo/qWGJgGHIKIVPsSTGR1afkSemYwAjeRgwrH3qTQ9IpzHv0j07RWm3vViuQ0bJ3htLQwLAvsTmwNjqID8QIsfCDieyKFnn+w1z/6erOmMjPREyg00qFEwFXy38R4HZntIfoi/yr7DyaA3G8Zmye57BIT+zC76MmXeAbjUrATcZ6tG5U66P6bwytfFRuWsL+z3ha1t8h2siXKWXVSKYwQFxKGtEXYfwaCXJ/sWe/+V2cRt7dB6yi5LAL6tbDHJhW0guQ/FnOQD6Y2Mo0fOjebqKwzf4CMQGQFZ5r+qKDhbAF3Tzjyb+dPhMU5Xp4dcMZxyznfn6/TKnNIYF7o1TzWGMAo+sUqxXOjO6Vb0ffRkDbA8p5tA0VEoxKUpvSS75FgGNZ9ewoCMN7UmELZzHx04Od2v13PYL3FpJTcvWqo3X0uH+RqD1gk025Mrfpxoy0smbxMMP89ymO+q1BcXNsBGT96MBDLtKpkEq22awws3sUqahzslRbfqilI9PyTSOpY5VM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555a911b-f5bc-4e1e-5056-08dda8600981
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 20:47:38.7877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7snYo+oIPApc2C40p6npb56m13yMkmpZBdZPbmcu7DzUvk9Ibz8NPCz53zYrbc5iwa8QVhzdNDn5U+zaGU0hDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_10,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100169
X-Proofpoint-GUID: bkWLjnFe-3PL-GUJML8hoVElVicO9itP
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=684899ef b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Xx5Ru4WvUl7MYDS_qwgA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE2OSBTYWx0ZWRfX7sb1BU2Jzg6g n4It/7hkb27gqoHfFmS3CA+MdyOS+RO0zDwjBPHzQS7AA+Qb2YAH2amGG+cOVcd4MJC3m3BuUe3 a8vXGwVQSo9/+NHj3oiuUqyhpXQJ9fhjayz0O/mBwSHmY3bjlfY1LWd/LX2gTBxKn23crY78ayQ
 o3UfjVY9U/3mHJEJlWoIGWL8DL5rhxL5yH5hnhUKVrGuRZUIqtAoPWFzhoa8SFmF56Ln5fR2v1G Fl1ltReSIEGh58hEwMFsZZpsPcb8+wYKncuzlfQ1qe4PcotW0u3i/jxF+7do6EiM4pxx628GRD8 IOPFDVHx2S8mhFHR5srHbrcKr66suNp/YimQqfDV00vV7FiFqncQ4VjjGHFGzJyS7wIHckwfYSP
 0H7WQe9i/WRjQNheWTojkK4965ZtbeAUgnRg/q2c2B+r/8Hi3sjkVhHDsiXlz1Ktcl4ZgBgH
X-Proofpoint-ORIG-GUID: bkWLjnFe-3PL-GUJML8hoVElVicO9itP

On Tue, Jun 10, 2025 at 12:27:24PM -0400, Konrad Rzeszutek Wilk via rds-devel wrote:
> Hi folks,

Hi cgroup folks,

Andrew suggested that I reach out to you all since you had implemented
something very similar via:

3958e2d0c34e1
01ee6cfb1483f

And I was wondering if you have have feedback on what worked for you,
best practices, etc.

Manually CCing you so you will shortly be copied on the patch too.
> 
> This patch addresses an issue where we have applications compiled against
> against older (or newer) kernels. RDS does not have any ioctls to query
> for what version of ABIs it has or what features it has. Hence this solution
> that proposes to put this ABI information in user-accessible way.
> 
> The patch does it two ways:
> 
> 1) Power of the ELF .note section to put in the module so that
> applications can discern before installing whether the kernel
> has the right support.
> 
> 2) The sysfs way - in which the /sys/modules/ was appealing since
> it was simple and non invasive means of delivering this functionality,
> and requires no changes to existing APIs or kernel logic.
> 
> I am not tied to any specific ways - hence the request for collaboration.
> 
> And as such questions, comments and discussion are appreciated and if you
> have read to this part - then thank you for spending your time reading over
> this cover letter and I am looking forward to your feedback on the patch!
> 
> Konrad Rzeszutek Wilk (1):
>       rds: Expose feature parameters via sysfs and ELF note
> 
>  Documentation/ABI/stable/sysfs-driver-rds | 92 +++++++++++++++++++++++++++++++
>  net/rds/af_rds.c                          | 33 +++++++++++
>  2 files changed, 125 insertions(+)
> 
> _______________________________________________
> rds-devel mailing list
> rds-devel@oss.oracle.com
> https://oss.oracle.com/mailman/listinfo/rds-devel

