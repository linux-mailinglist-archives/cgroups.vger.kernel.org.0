Return-Path: <cgroups+bounces-11793-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4EEC4B8FE
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 06:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AFB3A7783
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 05:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCB92877ED;
	Tue, 11 Nov 2025 05:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B6Shfh9k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FnWbMgzH"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4921A5B9E;
	Tue, 11 Nov 2025 05:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762839734; cv=fail; b=i8eRhP38/3bBAZIvbxUIl4sm9h0Ej8JOybzkMX4zohx6kJTiP+jDqdNAO6n2UVhzsOK4BNZ2zOgkJaU4rYh8O406jpuiWJCtTj0G5w7n0+7W4x7woPtyW/mjkxzx6P328FmQR10MvIc7+SR/cdRPVA18nHEURWVkSYO/H8oriC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762839734; c=relaxed/simple;
	bh=Jo9wo2NSemmKojQ+xjzshn1eKRdv6MhIWKezLkuxl5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bjCX2ubTzLI3O8qqZJKE+gel0StzoGr+ni6DmK1SJoiz0RMvg6OJbShNOh3vH9IBmf9PM77LnGmypXh0JFOyuqV+e6aoeTj0hDZq/Mo4A+zaywbhuX0NFlaAvl9GQh6FhJhRIWl0eljKDZ1Hzo8onSPg7DKL1b+Td5u1guN5MTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B6Shfh9k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FnWbMgzH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB5eok1028576;
	Tue, 11 Nov 2025 05:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=SAFegQ60qyENe2B6l7
	BjZgYJElsyV9blo6sdP1HdsNo=; b=B6Shfh9kE8y8udUH2xNi7CN4zWojDsO6ou
	7RyZ0F7wYwegH+48qLzGZlyjoyzQMMo74KbVm4XSVPOVX4HhjQDaqklu+TYnV6bB
	dVyQUe7dFioU1zpybtmc/mHlOBtKe0kdeHsW54xS3vYmzBa5a/MCKSB6bifshcNm
	ataXmrzKXcoZeiDT+egcUayMNMuSBSRda8959d+R1q3fOnmFYiZJN9fBnzkHU1X0
	8Zvg8D+quD1AniTa5JIAUwdJJQXPXNHngc4tzmy7XsBvFxHdrnP2FWPnre3ze8AN
	cQA/rzt6U77FJN4Z4FdhjpvIPKWo2HoUXDMl23d4ld359t/r2EVQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4absq2rcgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 05:41:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB3jc2a010226;
	Tue, 11 Nov 2025 05:41:55 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vajugct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 05:41:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+Q2WhSODey9paFTlEV70yash1yRZYRGvZ6+55AB2CUcBiRGmdqSsVyrXAFHrjLQI8Ndr374LnEl2RIqFvDMEeE3oD3Rj1O5mAATPtyvXUDZhmj8yI9iUEFoQuLFx5s515i0NJ030U3/oVK7UxfnRpExkXhbo2b4unwZAMQClk2HUuYVDzatE20igTfJ1dNDc76LEusuK02GVx2IVzCZ3sPt9Tuq89a91HXCzbJC1pN0VPdgPECHXIKekXt4BLC15o+K2VilP6i3ZV4oLzOk+r12T9kCv69Y+gElxpLUduCsZ9yRXp/uRM9sZEWkuGrD9FIAuSxf1psPj8zcfEMW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAFegQ60qyENe2B6l7BjZgYJElsyV9blo6sdP1HdsNo=;
 b=RkXdk01cPzg/LdHYzQxrlZi4qRfxMlOGTOrH+Qe64K93lrpaTwbylYyvr8pOSJ6d3nbvlbLE3uEnkT/dod9WbBFV0NNpw/qhJHpofElJDafgkIxDXgCZecABaAm4lBQ3UDhNkfoWHoYPXZfpo8jJ5sGooxPa6iY9ZIQLE1kya/J5IiUrCq/2GwyoXwegX95XgNVxZ32pUSYKWP8CtHO1OBnw/Y//j0aqyYvStZKvVfqfUMshJhCswanNQjf7a423+lv90EutzpeDwh+/4f7WgeYUyWZ1p8IMfb8KlsiIzP/JfVGuR3YJ/Ot/w5NZVhgW6UGApv2Dyz71nN3OPlFo2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAFegQ60qyENe2B6l7BjZgYJElsyV9blo6sdP1HdsNo=;
 b=FnWbMgzHTeqMC30HXuZIajfU6H4fLAqcBt9u40mg7/fshcrXUvTqzhoe953Y4jwar3+7BxIuPmFDAdtbqhtyqABrJIfSq7UVSyUiu2QQT1c5dpQ/13EXY5LqF20z0eruUX4DbqjTqGiSobvj79QADhqIAx53RcWGzRVDcoi+IGo=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 SA1PR10MB5824.namprd10.prod.outlook.com (2603:10b6:806:236::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 05:41:52 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 05:41:52 +0000
Date: Tue, 11 Nov 2025 14:41:45 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 4/4] memcg: remove __lruvec_stat_mod_folio
Message-ID: <aRLMmYXU0TrwmgwI@hyeyoo>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <20251110232008.1352063-5-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110232008.1352063-5-shakeel.butt@linux.dev>
X-ClientProxiedBy: SL2P216CA0138.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|SA1PR10MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 39775435-772b-46c4-cbce-08de20e503f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VdaqShNNlO3cbW15jMqyiyYyA/E8+7xiN/zm1BeZQ0YjEzwrF3kEHATklNX6?=
 =?us-ascii?Q?OIhu6xOBm8dFCe1cs4Il/JuoP6/c7HZyc9fE3xkLMwd3vv9BG7+WZib441XH?=
 =?us-ascii?Q?jnLFpySDfpgpPNoM9GUKE0HzdOcleoFbCtwcmIIb7YeghGC4cXlCucQ41ymS?=
 =?us-ascii?Q?P8zFiQtlsx5R4GG3FNL+hFM/NAFVmTtRxWSS6ee8csxMMzlXK+V4VQuUnkEk?=
 =?us-ascii?Q?RaWKhGYb2OBb012wocbvTwcylVZamr/LxUaHUHgD6FaJvXbgXXOfzZbYfrsW?=
 =?us-ascii?Q?P8gERMWPvjwNU2oQdM3gcqWyY+dcO74NLmmiEVRKQOXt+q2uosQNtKNveTiD?=
 =?us-ascii?Q?Rzm7PFqKTrgBiIUEacirgGVoftMdQrO8Y9yrNpQ7QM41un3RuThxTcE/V1D3?=
 =?us-ascii?Q?FNsNXc9t/I0WOIg5QQ2QSNlw2zhmsvxSpr4UJgfqMwpYvvTmpW4OlJH3bD9R?=
 =?us-ascii?Q?375qlwGsh+wlGjQeYnF68znX37vCr1U3Nlnew1/J7Zx1t5TCI+5Oie9vaF+I?=
 =?us-ascii?Q?wjgBPLwF5cUE+j87Ru2JBpsbBZdRnO8WZONk3ZwmjJ9dqNOJTzx0j3zzQydP?=
 =?us-ascii?Q?zOKxP2NqudQeBuPUOW7S1tJZIB1bTUcsLIiJTbc6ez6XIKYbHoo5UpFPCTvv?=
 =?us-ascii?Q?bPPEPSOcutmK7qa+EVZLHUp8QN/7bK1jHzFmqtlKNzO48FIi6oQSmSvmAEk0?=
 =?us-ascii?Q?e3vcnd62qmloiivDSQM+Zl8pTrk+d4Kvmoo78shCkafzESxTJq6amYyNZvX6?=
 =?us-ascii?Q?jTcldUDq/6Z0s3bBS5mUYYOeb/+1wdGGJBeI8ex6E0fcXVztzcOPi0Ys4z6o?=
 =?us-ascii?Q?4sqt1j4rxiRPekzahOFt1LTaJjTGvZW/OVnqJy/K157szNHAbgAHOE5Cj/rg?=
 =?us-ascii?Q?xxqpKEXdzufSaf81sLgIvvgMuFnu7iyfUucvOW0uvgAt8+z+nCytG1lRf/Fd?=
 =?us-ascii?Q?YO6jXiA9P/jk3Utr/u0bFPXDMFPXQut8UWmsl2aCSDvimLF1n8EI383RfZ+Z?=
 =?us-ascii?Q?559bSPbBPKKh+N80ad5J4S7f345e6LtvnJ8eC7gKwrIdRnrc+IYDey5nu1gH?=
 =?us-ascii?Q?GNYuPGDMoZFAp9GdoyRlSaZvieoqJRMNRiUZk34xC0lnZM/S7u2F4Rrrre9q?=
 =?us-ascii?Q?Kz4raOnuPzHMKjLEJLWL8a3XJh/PswhPZC67IMgD7qj2NTd0bnCnz7LQ9CM/?=
 =?us-ascii?Q?yt+mRGOFcR/boFNlLr4TVMPcztFbO3ht68U7TLz+/agW9k0jR+mhhl6QojLm?=
 =?us-ascii?Q?TICuj3qFm0F6NcGS4ceCDNNAllBPBVvJd8T5I2tdAoPOLYZDlJ4tQkbMcAdX?=
 =?us-ascii?Q?NLNRYBf9j8P14gnN15TyBINojVUa22jE/3bIcB5Nq43VuNdvj2+g02e4KbaK?=
 =?us-ascii?Q?2Jsdjdn+QOIzBTe/dEwnr3bjTUj4sXKYphA5TP8e6kiCWWwdF0xLQ+T2qzp0?=
 =?us-ascii?Q?LAaI02BoKjUC42YIrz9N6LfMewnWh0FJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dg68EtTcx6pztgGcmR2rX8OrV6eQwlRmqJ8gw/tJ6cstEDBU1Ih3zyPA//Sb?=
 =?us-ascii?Q?U38XZQuKdKNUo1A88xkmsa3N4BzdBqcqvF0nz9l21YjccsSrkPK87X39bTZc?=
 =?us-ascii?Q?m3hINSEJqMeTs3upPh9r4jk7PnzCSiDzzo8PGih5QRkxQi3ASazXcvP6vd9b?=
 =?us-ascii?Q?XjV0qhvkcNQ9TUHJCJ0RW9moZFLMev17TvGExapplGWNK5vOnwFx6O3DsgdL?=
 =?us-ascii?Q?+DljwbBjPLfHGsGAhE7CXXuPM4bjFXj9xPvDSe6asY61DYkeltnwYq4TaSrE?=
 =?us-ascii?Q?46cvvYP3QyMpQmUzGuXEGaHCEEwxIPE0be9Ju8TfEOGd62H0sektDIa+089j?=
 =?us-ascii?Q?H4AVSxmMmn4XgQgoe4GqxOCfLtZP9nVzpqrVgnpQei041JbDW02ER2aK4tBN?=
 =?us-ascii?Q?68S8nQC07cZwlfNhkyjR9bjW0HBT/rS7AJ4csiHETL3ODhZJvgurLj+om+Oq?=
 =?us-ascii?Q?eafKi4UhsrEaw2rox9dFa8lqh7O7DLkn//14dPYhiCwQwkOhyWT38rPE3YmA?=
 =?us-ascii?Q?woFHaQDI+HtfX/0GsHgZwu8QzqgDgLyWmALQgMXT/NXvMO+wmWeKkPLBYiFg?=
 =?us-ascii?Q?aJv3lDAYrRm/1pExHglKl4r1r/YNVP9B1YnqUzfT1Bzms4URDauIjyV5FkuY?=
 =?us-ascii?Q?uMBp8L1faGKB61ECcjOFdZ6yJw9guB8gZON+XO6X7PrmT3cOuAlPO/NGtWdI?=
 =?us-ascii?Q?Xcfivh8eCfzaqBILzA7+zR6RaNZW+N0damavOsKM6mWfrN6u+p4eCrLFD8Eb?=
 =?us-ascii?Q?awJQ+6LEjHKqyv0paNoEqMZCTeOCyoV4YXQ81eqjysarAvr+dnW8Zle6TMZR?=
 =?us-ascii?Q?+v5VOhOlcZttIrqZJUi995ncH57XBUJocVoU99EtiWbIH2irGsO+TNG1AvyN?=
 =?us-ascii?Q?x5f3z4eBYwntsqYiouSls+wm5wn6bAZ+jAZzxQfDgJ/868nVz7biJO2uxpE5?=
 =?us-ascii?Q?tZqbDX81X0EPbGI9WewU3Rz2Gvxc3dqcAVmU7ssOmtciYRcJLF1oJoyhN67n?=
 =?us-ascii?Q?Gb6W6qb2R9+vRWWZbF15L4k9aXdvFUzajxG0Ji9Qio5gowgHbVYMzMH2A3bm?=
 =?us-ascii?Q?IEkTW1met0xymL01oW36lYqnKiC/lpWJTqkA0R96kDko/9NCPKdRmfxIOkD3?=
 =?us-ascii?Q?bHSZkmT3SDfwaD8Xzl5smEXlphy9CZGeoNCSz24onwBy2v0O+ogInBkzo4Tm?=
 =?us-ascii?Q?UWNfVILmwTb79c6OljwRU76qauoZxwzHTxkHokvtJ8dJyxBDNRSSaoSKnwU6?=
 =?us-ascii?Q?J5SdvloM+RVXcjRBh8ey/ysY71Pq0YIYihbfHozPehMmociSLw9N8AFGCUrn?=
 =?us-ascii?Q?g+fUoXMaZ/NVjk3oWmiV5sGswANIcS0i7VJus4ZU/m9YFL5Db8gHkGtZOFuC?=
 =?us-ascii?Q?tRRJWZxDytAIElcm5HtpQ7mV/CGgac7jKqDRLZFCHzBN6vgH47oCUtTLwhFy?=
 =?us-ascii?Q?iPsUqojFfHkGr6fqYCIAu4edQv+GxZLurKeqP+sm56r1l/ZNq9pdKGE7pHsB?=
 =?us-ascii?Q?yjr4C0GOcpBgNqwzFcEGWCxSxHxtYDZr/+k+1GYZeUUZZMh16MnPZgp9Lbjx?=
 =?us-ascii?Q?NMmXSO9Kw9kBO+2EiozidOixPLUXIPQcrvAG4VEF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W03tvYkHvFVBpWirSxx9kWTCj/9gXZ6WG7XCm14Gi709p/fyzUxxF73oWSmYdnVo21CiIQY+I92T8O9u23AgQIi0B6ULV2Z4Y0pJhZIFa1TFN4h8bbF3ApF8ompALOTBmiK9BmwhsIKw8EjD2FELkZjNd7qh6+fkjpp6ZUa6aUiV8H8VbBi8tPq27Ra7QGvv0jteBh6x0ui7N9yuFM32q7RDc0HI589lOtzz5DT4qW/QcRqiPucJ4Tx/dmdG3XBBdHTIHumDh7TpoNbS05xTQ3EQV3ilOcTY23XxTSal98JYH3p4T9YYhO2NqCW6+PQCr3yvfvJKyXiiKbpZn0ieMGnGa69ED3ughDi5C8Mls7HPMh8iAug4or3+AuJw2MmVVfEmJAnedPZ7t6DzUiJJiO9RpDDcFA5FQsSL/rrL4lge76xb/GvZpxtyTD2wdwnu1fynj6VMc9ultRRdiGu5znmxvu9RAmY7ZP9pOV4/OChHX+f05UJKCsqgVkr1BoMBzpAkG1eY+4YbRVfuwoEpTtMDHR3fWeEW5gEoRtbLbYRdCa94JtrFlWyL8576KAP5iSBNvX5VE/9qegFfiK80MKQwp1ra4YbT95D2V92YAjc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39775435-772b-46c4-cbce-08de20e503f0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 05:41:52.7048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ms2JEbW3vONT8XdVjSqokOuCD0I+IBW1heAvqT4gL4oEYHdN7uBGjWTbc8hqRg/eoNyxwCVNKP20MaE+9hZcow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5824
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110041
X-Authority-Analysis: v=2.4 cv=GtpPO01C c=1 sm=1 tr=0 ts=6912cca4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=0TK8oYno-o0yUqdDhYQA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12100
X-Proofpoint-GUID: yuIPjohyMqg99xWvZ0Fy-ktUteAWAKJ7
X-Proofpoint-ORIG-GUID: yuIPjohyMqg99xWvZ0Fy-ktUteAWAKJ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE5OSBTYWx0ZWRfX8HDo5/BUbka4
 /m/7ttImANQPmblgD/zTS2CdXFcU6QPX+b9H3oE9GwIaT2rn0szMXouCJMfXY/+CWI30jWW2Zd3
 txLBSOSs624PUp1PXlrGIGrXtEWCGm2sPxG2n5WbjOF1dvmjqZsXa3dblLxaJh6Qpw5dDAhD4xZ
 QyB4Lq6G2F4/QkDPGMfW89B6hjb7OKGEd25WgjjiREhk5XVZb37P4MPOcSL9/OAM5S53XkZYZbb
 cxjbZRCGLdkSa+LtE1QR/lh4kWIdBFWu7uqDLsxf5V2mddzk748ts9zV9hy8X7DnokNLgp2tj/M
 CylEfWbD2t7x47fKwvAZNeOU36U1+53fDYTgCHKE30ls33OGDUhF/I5XkEbcMvmFn6PbvjEYhOv
 qrK56CYWO3dMOSJCdozwhdzDvEUWKtI1+4LEGFSG6MOX+w0b094=

On Mon, Nov 10, 2025 at 03:20:08PM -0800, Shakeel Butt wrote:
> The __lruvec_stat_mod_folio is already safe against irqs, so there is no
> need to have a separate interface (i.e. lruvec_stat_mod_folio) which
> wraps calls to it with irq disabling and reenabling. Let's rename
> __lruvec_stat_mod_folio to lruvec_stat_mod_folio.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

