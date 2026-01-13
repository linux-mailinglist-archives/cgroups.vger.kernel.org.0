Return-Path: <cgroups+bounces-13121-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 184F3D16CA4
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 07:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A32F63025170
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 06:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281C2350D5A;
	Tue, 13 Jan 2026 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fOLg1z2T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ahp/9C7b"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A3A221FBB;
	Tue, 13 Jan 2026 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285168; cv=fail; b=vBvR2G2GFr5wsmPSX8U717JCDN8r+ib399WnI+C2iy53vWcusUk/F/lDaE5Lt0Gp4L2O+VRwHjKPO75mInS6TViu90KGJ+3jxSZgzSHiwd6Uw5CDovJHfdKG3HvCk3tZLJHXQ0SOlLCwZOy/5CHFP6vkGbE+lLt9d0gkRG98dv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285168; c=relaxed/simple;
	bh=l0jntxLpK1YNGONAWknYGnFZdUpfWofrZCnI1To1Oco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e3BxqTKEJEpmTG0MUMEmSYQL4VoLE1F5BTNQwhYUmTznoItq4bGbPvTXON14roQrVP6QtOOScHjfMkpE1cfmpES+N5AfXxbZLQfBx1xG1lyP7HjVm2CCZxVSlY6G9iUjBb8mLufOgtRl6waaGfYO80qNjM7lGnxUHJQuptBaxes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fOLg1z2T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ahp/9C7b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1givL2419474;
	Tue, 13 Jan 2026 06:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gDZjN+uiTUde6t5FthEZlzYE8wBDPol0p9XPfjzNfo8=; b=
	fOLg1z2Tto4wj+P+gKJ0sVY+S5DuYfKDrAcGO8BTN/kWE1EPttNL0VW273FT2ue3
	hAAJBfguZj1aKBHkO7+pfC968fmbvquIeR9wQ+XWFnVG29Y6LDmR5xNuY2GctN6e
	EJJsfmrwbLZE25frWqKO5vkOw51JIx5edoW/ctd8qVY3zvfpW7bACtAxpbFEOUgZ
	P06AC550JWkVTp0mXi+ttuS2wgl1pQUvqkNb0otSvB30s6Z1K9r68RXIdI2kEkqO
	MrleUjL5nRy7l46/Ua4EbsUMyS9FqEzG14flquQg8+2RxHM+kDiPCT3ZvbavBybL
	5kxGN203XE823Ucbq4WOnA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkre3tw8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:19:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60D5gonB004186;
	Tue, 13 Jan 2026 06:19:03 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7j4d9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:19:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DK4Cez4CNkQI/SSsd10h9JnSqRQBsllb+rMguGWJRMVnxj5+4xW1f0cyULV+jpgAfA4ADHyBbwWKHEnmjguTlkh8z6piJ7UrmwShrH6cQgwyhhWjW3f5XOsnNS+gIbnu+Qb7WWeFHyWYUXOYI+Z7LX5w0Ve3vkwIkWzzLywuZwuRMulXfT1I91fwNChE1mkH+1g9Dcd9pDtKO0n+HySYxtjh3BdmoAoY3tN44jyHzj9FmKwIeO0ChswW9diXWT9TvPKace6dqlZ+fKeFdo+O9NPUCoYOjoNj3lbVhUBhCID/hOMxQWzPOTy06+FvQaF7S1cGSu/B772Pfp4yr4qbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDZjN+uiTUde6t5FthEZlzYE8wBDPol0p9XPfjzNfo8=;
 b=Gw/VPp3pESEil00ntduldcVkOn0LkwNXweqUkKkb8763wnR95Z0GEk3QPIIV+JaOZT6bnE5N8wm3RTihF1zIO29k0nF5wD/RjIMowppJY5UAHRMftNnq/s1E0ghpj3h3SApP2kwI6jm8mZUTiQ5C5h1EurqHoFDDWPgJBxtToapEEy87IRg6c1J3wkLljV+vR+JWHAwxhMGDstba6q8Jg9GONC8d4Nhg7WU/XxXkYHEFUH10zSF7m7LHujZGnoBQXq9ScqGBkd9YP0LmjPnAejcp4HdvuPo2bQbzkF8ixzHTsQCp+TULipA+8Xc9QlLiihN/sC2EXgsWQp27xNj67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDZjN+uiTUde6t5FthEZlzYE8wBDPol0p9XPfjzNfo8=;
 b=ahp/9C7bOmq2qSUPQzNfdLMg/8+XPT35ldtfPWXZ/AH9ye7oR2RMScwFxEDbfY1Origz4cRQoBkGDoW9WRrFnJVAfmQYBaPzzgudRQGlGeLkZ/bTmTDDA/ouMcxL5hYR5XNbQJwVNmLVSVLtrvomWLkjEA5xIjcx1CXBwV/1rBU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 06:19:00 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 06:18:59 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@gentwo.org, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, harry.yoo@oracle.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        hao.li@linux.dev
Subject: [PATCH V6 2/9] mm/slab: allow specifying free pointer offset when using constructor
Date: Tue, 13 Jan 2026 15:18:38 +0900
Message-ID: <20260113061845.159790-3-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113061845.159790-1-harry.yoo@oracle.com>
References: <20260113061845.159790-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0020.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN4PR10MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea9436c-5be6-4c60-d995-08de526ba3be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BD9nSWprkFK7sO7tjIU6jRVgCP+2CNBSmwIqJ77ygalQKv6KUs5PUA/krrKb?=
 =?us-ascii?Q?ZgKA0ZK4uMFpZSiw1Vnupuo++VjXePV/xwmUEL9nHo5vIlGPvo9dQeoDQmZH?=
 =?us-ascii?Q?TETUQbPC/3qkVRnxD+n8C9KC+grdEOg9AZhNOSMO0Sa6dRPoiRpq3sBjBX8C?=
 =?us-ascii?Q?aRHsgoY/iZmR5iawnpnP7E5kuiAJp5TZQ8SZvWWVKIlxzdwm2mYL05i6ssDM?=
 =?us-ascii?Q?LznucH1LbYEmWt9REXJZMdN9k394H66fsC4fhCvdkDU5tqcntBN1jYNdSehd?=
 =?us-ascii?Q?DKI+JMmN3+yVEoo6R8EkxXDGsFJl28SxdLJwHPokqk4NAB1bK75iikSfTyqW?=
 =?us-ascii?Q?H/NZtFhtuFcbqL/nfpIUpHDl3/wUiHDYpFF0VyDwys/3Q/Wyl87eAFKnmHkd?=
 =?us-ascii?Q?V73wndMorx9SvV8duP+2ANWYCnngxQzkUL/Nri3GrTK3k22nxJ/jrtsmaIOg?=
 =?us-ascii?Q?7hLOiQvm9YgUSQ53tjfQaWMiQ0odLfzH4anFU/c4qQGTdLBxEJQp4DSJJf9z?=
 =?us-ascii?Q?/eS9qeUvEVaF5Aj8gVI+8xlgUrIZ1RnKA1HDLZ9hlnGTjnyCzjfCwEWb6X9t?=
 =?us-ascii?Q?dz09xlZWbUlImr5vRR5rujjdTHr4NBJiJigftkYNB+9oXHyBuBrQP1lNBAlM?=
 =?us-ascii?Q?vsfZMdqLo0R+l9emPN4M9P9Lr7sw0DPz2bxuPRXfx71HLVJcrWLLB0/GdLaM?=
 =?us-ascii?Q?x93IisxzWC7vl9U20uULH6+DVbq7erwOLttB1w2NKAIk+mHyLi4w6dIQV4JY?=
 =?us-ascii?Q?S7vWhry9pjkeQN+9QXq62egq7+1mQDVtPKLRE7x/QsGP7bdBgyFc9lFShsid?=
 =?us-ascii?Q?bQV0HKMPC1SlYHgTHjrvIPXCK1cDD6iImbrLp33WKgqlE6RJXUVWNQYAWUGl?=
 =?us-ascii?Q?2XpSm0P6pk0xT2EiRBB51LG3TBtVSfJF86jyb3r35UuZTxelMWCg/Xa1Qcwp?=
 =?us-ascii?Q?EA3PrFrywDn+SkqsSMP08TRb5pP2zRq1kGIR7nLBWFD/19UE7fSVJayjR9YZ?=
 =?us-ascii?Q?cfvQFVBAqqUTWi4OmyQ1PYDHMjY17Vt1UI8b8KNiJSHeZQMC7U4+tOcr1P2O?=
 =?us-ascii?Q?W63ThFCmxEamKxTJtLuvb/+pL422N+dTsVVVJQ4reKACNIy3OJavYrGviRxE?=
 =?us-ascii?Q?5O36/2swlUXVXPp0OTjgE7i4pGOAp51pz8ER2pGrdEVXkVAcVDoJIMs+yp0y?=
 =?us-ascii?Q?Ef++Tnvx+pwDKTpDqcwe/MWl0ZfwqBF6QrckSYnNrlC5CErsIR73qmUPXtRt?=
 =?us-ascii?Q?0x9vZUt3xAoTEVj9K8c2sfeTed6czb3at7WKWXoEjQvJJd7beChLx1VLACTX?=
 =?us-ascii?Q?3O8GahRyrjS2QSXAwkvBbfsh5FEwx5BLj7nsilPP7+SjyWLKihxF4sRNZPRK?=
 =?us-ascii?Q?DEHxjp5uIcjTQgR9/mIA73cD1rLPWhSqPUPSHZs78j0+THpEte3pxbjcZ6Qa?=
 =?us-ascii?Q?i/JR4dhpqAXBZWd4r5d8qptY+Pu9HMfT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BgPL9ULggHb9bQSv/miaFfYk1JlwdwcrQSJgrpuyhK9GUNw3iUgwbaSkGuZr?=
 =?us-ascii?Q?1zEJdQ1Z4KST5NqnpfwBwv6iqnMoVcNV1iigzEtbzvD6d+cgNZq5i0NpHJ12?=
 =?us-ascii?Q?Z0D2KzCUAlpLapQtgTMhX9g/wDKxpzVNcRZvkCz2Dv0QYkkOPor+rJA6qkoV?=
 =?us-ascii?Q?TBmK1dqFUAdXt6iQ148FGMyOKPYft1WBErABt2VS0+MZcGbZcW+22Av1Q2e6?=
 =?us-ascii?Q?K975WOG0lUJYTOrizexJN4SRaDJhU0zHgapNHEOcBAd2bZGmGae6jliAeljx?=
 =?us-ascii?Q?0CBkJOZuAPOJigAj65Rv7DQVMDFhpd4IofiA0b26nDYbvNO6c2lu1UId00Ni?=
 =?us-ascii?Q?vEPcisLrVmMkvLeExk0rqMxgqXG5V4CQ0GbLmtFLnQEuAHiQlBflH/RX4V/Z?=
 =?us-ascii?Q?CzUg10xubcNLXL3CU/U0UIe9kaxF+mC5NoW+B2TDuj2uROhwAxkZgfw5Ocsx?=
 =?us-ascii?Q?gEzT/KtvSm0XjUiGEO8UUEi0nklQAqwIs81U9RGFn9q3pAcqNaFRcYBHNOSh?=
 =?us-ascii?Q?GvL54fqOh1qad4oBZFbN5dXKH7A97pzeNKfq3c/Af+EkpDq9RjX4zpr/BwES?=
 =?us-ascii?Q?CjPtMlmlS0B/2MZnkJHOEsv1GN7sGqq1K3VOSBufWqGMrb943kQCvxwHHzPL?=
 =?us-ascii?Q?ISFgyuXZ9SJ5G5JlMpW9lnos36BeJncVWSQYIyO2696D6KhSAp2CU4tfXZWD?=
 =?us-ascii?Q?X9sldkjoFELVgh9Pib/eI7gE/us0/RVxwccZIiOWdnSRDQu5x99XQ//kXlmN?=
 =?us-ascii?Q?WxV81JAiipXEVMaXMPCWdcgJkiI5ikON1G7DiKafrjv5HF2SC6aLTufSBncd?=
 =?us-ascii?Q?BTPA5wSGRWKUH+Od80ASM68rJpxO6CktGygdQOKldXAg5lNLqKfzfmorzouo?=
 =?us-ascii?Q?JSGqvw+NHX9gbhQ7oeKyI7z7yl3K/K6lG7Gk2qvsiTdBMV1W7dV6isPBfcHl?=
 =?us-ascii?Q?U9sQSF06LeN8Aa7HF7/MKmxTGYLX54Dcx4yxPav7BY8rLbnGZ7vz1HtEQsk4?=
 =?us-ascii?Q?lIYY8UXbT1bj9+p/MQbviXjLvAknq9KQX/2SL9yvTEsmBRPN7RDQEyYaBVUx?=
 =?us-ascii?Q?H+Zycwp+QIoRT0Nzb8GU4Zb5jFHT+WuRMOl19Rn8kcORmaZYp0DwJxQYspdA?=
 =?us-ascii?Q?VGoLJK5MBDtUkTG0c8GeMadiucWtC2CGqnX8TDotKY5QclsHZhDOSqLEaWTm?=
 =?us-ascii?Q?ZGEdKC3lTS1MC7KatxrmfqgViOyJF+OmiJgWXKbz3gqq4dhxBPk8/TRsuRpM?=
 =?us-ascii?Q?g7WPcGjud7VR2TvXbqHu4MHNX4+8lW/jrooz4SfAVERQ0rFIrUdrRjrGEfmm?=
 =?us-ascii?Q?QjmNndwgDqow+fa622LQ75ngX8N9cy/sBQBBONlH4OFTZTKxNgXGgVivuGD3?=
 =?us-ascii?Q?PhAsbFxn7s6asSj978BgfNSDd4jDlow5fhVvYNdOFIteU2HRxffltWVMIf3m?=
 =?us-ascii?Q?0LSNomA8yE6TEdXHs5puzRKFEWwmGQAQCyAt2ifoKISo/RBEphfyUqN6VddO?=
 =?us-ascii?Q?9UELGTGK6INUqBI82lBH/RpRotG5TDYw0Ew5dQRMTSASzug/+3R6ZVSO80Fp?=
 =?us-ascii?Q?38vgFYLp0mxeUMIHRN3PJrcn+8/zBzlaovDEywKHz/76ZvwC3E0hxbWRTBcb?=
 =?us-ascii?Q?qA83EV7FRmNs24eGwjfBrAvswqPnLcJcUgK/vIJOZcNlGKXQK0WQBu14Q8vg?=
 =?us-ascii?Q?+Yfy9LLOlcOadtXFtkCnuft7Kp5HvKeHAE8yk9oRDrAmJuezgBnlEA0tbsUz?=
 =?us-ascii?Q?SdLDKKYPPA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i6314HVbS+LrjLLcWYuVllfe5beFFS2mEZk6TOetwFV+BFYUZ/CsaqK3DBG4lM3SwLk9b2ioguOya7gAgAapvJ0TnwF23f2eJVbKbi9gTuOQixdmWNMroLQNaoBIBxAWzWrmZpLgy5opDlPzvXxvMaoaa/yTSHExRpMgSI8L7P584BXkYISWhxsEiXFyMj1mxREfQi5R+LImA70zpX66eMlFYHUmy7TTVirhUDHr6ruTkjO3HxVtVd0JSfy21NhALq0m04WlmYLINfn436MzDUOPPoB37I/O0ivfwx21RVw0P0eDDfkV7mQJR2d8menXoGMSH0V2vBVuT6O3kc8RTM/31DyGTw8hxn2yLn4wobiV+XGy8QoLqbLpZ5xls2DHyJ6NOS/j07ZF+RG7E4lXKcYP+hHj1TBV453WDug4lzZtPiPnUEc7z8nUcAnlwGLyC30sp+HXiJHAxayWbE0/N4sjLC/ajNZjwRu+W0JHrU5n5zZ4n9BQgItw9s5SOLshCn7s9oGEPHw9UCRVdS5Us9NCN36NCO/4rcbYMdlEgsj0OwRIBYMEIlqJd0T296lqj31eTvETZ9b4ykCjijDy1VeXutS6+W1p+QSlribJ7eM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea9436c-5be6-4c60-d995-08de526ba3be
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 06:18:59.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJzdjU+R6UT1YVk03pwtIMedl3UcZFQkRJAJIPaDEDinTvk9cmqK9wy7ZRw9udGm3vWEMVwoJeEy1FsPU2ea6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601130050
X-Proofpoint-ORIG-GUID: 17U4KNIquTwjws_Zqy1GOA9NfuQAG8tO
X-Authority-Analysis: v=2.4 cv=YKOSCBGx c=1 sm=1 tr=0 ts=6965e3d8 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=GMHoajJQQyXWUxyK3F0A:9 cc=ntf awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1MCBTYWx0ZWRfX/WBJ2sCO28xj
 jGkERUd1F+i4CyGtHoODdwONeLvpPC7RpQ+2c4TkkgBrQOkg9yLvGX3pV7mYOcT3Wi7hSfgfQO4
 V+wtAOyBMf45MYZjfy504A7dVOomHFQayF8x+O4hhRrwpqdV49VCmoxms8zBolS3YntIIY6yYMq
 wDWxQKldauU8JoiUums69q2BOT301IjQzHm6FderRjhD8l1NqVzZT7r++ztsQ1YQ6VrpxBjpWJF
 VpW0UhOuiuTI+5FsjyFczVOGx1Ywb29tGDx6Td1Wz+3BE1ZTdKz62nhAPIUFqs1oBzGY55cewa1
 +m2fXkdT0UdxZIL50HJIOFzzzsK3OkviBVMnt37ZNThfCToxEoRo/aAvx9L24Dbwe9PyEnKs0rO
 +3NlwtgfqUFnvrpuiP8ac9OksgpqX/4K8gRXcgk7fc4UiflnQQJsj8Xp7JQTXamIQlem+dNUuiD
 FvY/meKwFNxY+o1PXKLyeC+QA43zW58h1jvqjIOg=
X-Proofpoint-GUID: 17U4KNIquTwjws_Zqy1GOA9NfuQAG8tO

When a slab cache has a constructor, the free pointer is placed after the
object because certain fields must not be overwritten even after the
object is freed.

However, some fields that the constructor does not initialize can safely
be overwritten after free. Allow specifying the free pointer offset within
the object, reducing the overall object size when some fields can be reused
for the free pointer.

Adjust the document accordingly.

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/slab.h | 30 ++++++++++++++++--------------
 mm/slab_common.c     |  2 +-
 mm/slub.c            |  6 ++++--
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 2482992248dc..4554c04a9bd7 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -299,24 +299,26 @@ struct kmem_cache_args {
 	unsigned int usersize;
 	/**
 	 * @freeptr_offset: Custom offset for the free pointer
-	 * in &SLAB_TYPESAFE_BY_RCU caches
+	 * in caches with &SLAB_TYPESAFE_BY_RCU or @ctor
 	 *
-	 * By default &SLAB_TYPESAFE_BY_RCU caches place the free pointer
-	 * outside of the object. This might cause the object to grow in size.
-	 * Cache creators that have a reason to avoid this can specify a custom
-	 * free pointer offset in their struct where the free pointer will be
-	 * placed.
+	 * By default, &SLAB_TYPESAFE_BY_RCU and @ctor caches place the free
+	 * pointer outside of the object. This might cause the object to grow
+	 * in size. Cache creators that have a reason to avoid this can specify
+	 * a custom free pointer offset in their data structure where the free
+	 * pointer will be placed.
 	 *
-	 * Note that placing the free pointer inside the object requires the
-	 * caller to ensure that no fields are invalidated that are required to
-	 * guard against object recycling (See &SLAB_TYPESAFE_BY_RCU for
-	 * details).
+	 * For caches with &SLAB_TYPESAFE_BY_RCU, the caller must ensure that
+	 * the free pointer does not overlay fields required to guard against
+	 * object recycling (See &SLAB_TYPESAFE_BY_RCU for details).
 	 *
-	 * Using %0 as a value for @freeptr_offset is valid. If @freeptr_offset
-	 * is specified, %use_freeptr_offset must be set %true.
+	 * For caches with @ctor, the caller must ensure that the free pointer
+	 * does not overlay fields initialized by the constructor.
+	 *
+	 * Currently, only caches with &SLAB_TYPESAFE_BY_RCU or @ctor
+	 * may specify @freeptr_offset.
 	 *
-	 * Note that @ctor currently isn't supported with custom free pointers
-	 * as a @ctor requires an external free pointer.
+	 * Using %0 as a value for @freeptr_offset is valid. If @freeptr_offset
+	 * is specified, @use_freeptr_offset must be set %true.
 	 */
 	unsigned int freeptr_offset;
 	/**
diff --git a/mm/slab_common.c b/mm/slab_common.c
index eed7ea556cb1..c4cf9ed2ec92 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -231,7 +231,7 @@ static struct kmem_cache *create_cache(const char *name,
 	err = -EINVAL;
 	if (args->use_freeptr_offset &&
 	    (args->freeptr_offset >= object_size ||
-	     !(flags & SLAB_TYPESAFE_BY_RCU) ||
+	     (!(flags & SLAB_TYPESAFE_BY_RCU) && !args->ctor) ||
 	     !IS_ALIGNED(args->freeptr_offset, __alignof__(freeptr_t))))
 		goto out;
 
diff --git a/mm/slub.c b/mm/slub.c
index 2494ca8080f5..5f75e0d5cf16 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7919,7 +7919,8 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 	s->inuse = size;
 
 	if (((flags & SLAB_TYPESAFE_BY_RCU) && !args->use_freeptr_offset) ||
-	    (flags & SLAB_POISON) || s->ctor ||
+	    (flags & SLAB_POISON) ||
+	    (s->ctor && !args->use_freeptr_offset) ||
 	    ((flags & SLAB_RED_ZONE) &&
 	     (s->object_size < sizeof(void *) || slub_debug_orig_size(s)))) {
 		/*
@@ -7940,7 +7941,8 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 		 */
 		s->offset = size;
 		size += sizeof(void *);
-	} else if ((flags & SLAB_TYPESAFE_BY_RCU) && args->use_freeptr_offset) {
+	} else if (((flags & SLAB_TYPESAFE_BY_RCU) || s->ctor) &&
+			args->use_freeptr_offset) {
 		s->offset = args->freeptr_offset;
 	} else {
 		/*
-- 
2.43.0


