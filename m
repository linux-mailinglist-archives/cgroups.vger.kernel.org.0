Return-Path: <cgroups+bounces-11773-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBA0C4AFD1
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 02:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801EF1899C23
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 01:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A2F3081BE;
	Tue, 11 Nov 2025 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WN8FdrFc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bkGB7lZ0"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C599A3081AB;
	Tue, 11 Nov 2025 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762825212; cv=fail; b=mTbaSEd772DgU+0KZIMfO10nBRGXv8T0Fx5PKtKc+lhe/yJEmMOlH/qQl2+DmFHOJWo/jdgg8lexvCHUu5b3EgRfovvgHKRMG7Xa/cwtF/Zn2zjVLquda/X8cQ3Z7sbfsxJJAjLic83XTouK+HWDLrFg0cn5xUyUKLxtCbWWBCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762825212; c=relaxed/simple;
	bh=oICvtgjlOb8L0mD4HkfNKaJ9y6lA8YrouX1DhZ826yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=txvl3cAYqjii6iMAjJ3zRwE0vvlMACo+lS0OICRYum9BJ0j3MOU8dSkJPJWAsM8yPERne5qIVA04KDsZpPzCH/OyXgceRONuYho4AM4L2y945pbBB0wKlahIkH40yxiue5iSUCBxXncOzOsvrdTsRvx2RxakDTSI/W29Pl884EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WN8FdrFc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bkGB7lZ0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB06C5T010864;
	Tue, 11 Nov 2025 01:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=pfXof6lNOuDsQcj9ZZ
	Zxlat1UiPEnwMCjBjrTXkP8rc=; b=WN8FdrFciKMwMM/dUSb8EOF9u4RTKTKWs5
	sIxIrVBd0GYi3Exnhu6ZPyRXdPnfIzOtegdrf6Zk8z/lU10a5CQtMQCqnw4HMlA3
	9xz/lMmOe6i5Bfe8RDf7etzCXXEipxcwxkL4vIX+050ASPI08zHESCZKzMYs7P+/
	FXqHEardZLFR3YMxG4JRM7fgOyjWkOlWTgLB4RsiWs395K2HadI3i/ClUANqJsIJ
	ntt6/d+e7F4jMN3INBM/j8wcrOnb1mDKYuIBjiRvzLqj8a3GoDVTSPrOQcomYMqz
	+rjuATICwAf27JcNtCJ1wLji6s5OVz5ZuA/lkvP8cr6R4SO1AY8Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abrpb8946-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 01:39:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AANe20K012637;
	Tue, 11 Nov 2025 01:39:54 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vacdudu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 01:39:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soGOQQ45UT4YlFnR3yAPHsX10TkfyOg3MClw/Y/IrItLyBAgczGaEHvsklPMt4jyjY1SFNhWmelO9hwM4zPHCD2tu1USMe1UJSma3qfpWUfggy4od6WawJPspfr4NCodKRzkoZsCs5mGhwwfzmsHQhuL8ynvsOQbXbeiHAt+sjEImipGT+DKZTumrwDPfdaEpztrceoTWZcB+m3tq6lKPUm5E2R/Wo7ShFP7xNuKkdojZjERYz6YfwH7UVUW3YCaygwT44or/v6Z1aNsq9hRZnJB1wQ4/qNuiBR6mr/eBbUXE5/dJW84u2BwQVl8G5d6AOIoaHfqrzXTZAu7bWvozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfXof6lNOuDsQcj9ZZZxlat1UiPEnwMCjBjrTXkP8rc=;
 b=X8FbGh2qLg65omQpMN2zOofiD8JQqfbUrn+/Io7nBHsx9sN9v2HVZvucwiSWU2DBku34Y9fZpJCfAg5L4PTmGM/IG16sV0Dfp4meARmB+A7g75xMnRl1ukbwnJgR0WDMBKLgPQnxOYcfWUoWrZSJoAmi52BEd9IHDDwvKxUCkaVYAXdHDdwg1Q1+JTjVGN9GHCPbL7txNUg5xR0+6f2BCACo6mUPnYK2TYV0xtkMNJNw69rRGIuJKoDJ0RHja10vcTJhtoLY7Wgx2glqWL+NU2i/2r0jFITY3wuFIY65raPLQaCvNkjlJi/osLYHECnJ6iyeaP3lSTekKN+urOzHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfXof6lNOuDsQcj9ZZZxlat1UiPEnwMCjBjrTXkP8rc=;
 b=bkGB7lZ0tuizDD2daxHaidk3pksB2ZvBh99sJQA60Id9WZWbKVItYPEVD5DEzSPKNJZKkzPSkC83vxCHqcSwAEfNfccf3ev+Ox7pt89MHTZ6RxPgTSiw/0iBZ2zD6R90L4X5mkEFweNzK1Ac1gRVBA4WxvL5zwqGp2mV2grk18I=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 01:39:50 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 01:39:50 +0000
Date: Tue, 11 Nov 2025 10:39:34 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 1/4] memcg: use mod_node_page_state to update stats
Message-ID: <aRKTbMLuNeoY-VoZ@hyeyoo>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <20251110232008.1352063-2-shakeel.butt@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110232008.1352063-2-shakeel.butt@linux.dev>
X-ClientProxiedBy: SEWP216CA0065.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BLAPR10MB5041:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c7284a-7ce4-40ab-21a0-08de20c3340a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QFv8hVZRYLSIDLVU8ECvEbzYPZpbD/gubKZaNuuKrPFrufwSVUMLiOIXn6uf?=
 =?us-ascii?Q?733fgcPhdCeUKOcLBLH6fG7F70d9UEeh7fGC9qkLi7gqxs5ZoX6ehdou0x4M?=
 =?us-ascii?Q?w4f7qactlJGWYA7MOP+sDiPqoNM6fPZj3iMn3MYs6bW2vL49VLJgAqd2wDzK?=
 =?us-ascii?Q?kW6Ed+5jjWijr2b25kb1RE5vZWHUNA1nFAQUdgT4PHTwZSLxdYNWdzU+jd/e?=
 =?us-ascii?Q?UOo86SnFOslLhuloxcsTs0PjdckLBLkXntscz15S7ooAmWgXf/RvejIXSFz0?=
 =?us-ascii?Q?xgLU2JGVgz3c5fyiGlAkcfBzWJtWoOJzkvsCIT5c7owuEW7p7O0qs+t0vwID?=
 =?us-ascii?Q?uSwsQI69zhIjhhASv1OuNW20gwGMNrj0dGzhAjFBokHQ0nINOFQ4eMgRG3uh?=
 =?us-ascii?Q?tVEIokHtHNQuiX6TKrQ4kyezMkau3JXfDaYm7/kavHv7lVlO5Vw2TxeEepR7?=
 =?us-ascii?Q?ipYHUqyH0Z+vtCuqGNivj3aGJWPJoyZKfRQFYulogYlC+0RofCffhpcoY0Ow?=
 =?us-ascii?Q?SpDePg6gAWRmkueBQuztvhSj7ztM0j/vnK9pSp1B64+VqiZQuhq84UW4nYsM?=
 =?us-ascii?Q?0xtC3kcdmIgIfidV7Y+1Xx4J+5TSb/rMFBfq+OcWfShA2eHIK//rz1f9Lqii?=
 =?us-ascii?Q?gfsmDsYKVZe+tGUB1tQXfJd93VQNwbrVV7zSztu7Vk+TxDNPGd8GSnoIF+Gd?=
 =?us-ascii?Q?S15AVXG90+xKIcTr7EnHJkDopBtLVFDd+FZ0Y+FuEjzngZxVGipy5iDKgn4b?=
 =?us-ascii?Q?m/o9+VKg6plrQo218Qta7TsFeX8xc8cwhl7+MxTZ0LG2SvjDJX5xlKWM7YQJ?=
 =?us-ascii?Q?L5Uo6kvy6ooodC+xZFZzbsRgqw44tpxrZiopOTr7Igl/3/fUI3b6PrwwckJ/?=
 =?us-ascii?Q?xXpY7uv5rN3gARqmw1I1fdNo0cYqwGlyu/D0R/jCkShcvyFe9iwJF64U77Q9?=
 =?us-ascii?Q?xY0is6ONU/Adrp5pEI/kkojO3f9BI9KqA7TaYAXA5A93c7xaQXEyEvh26S6C?=
 =?us-ascii?Q?5OBAgNXlD4Uuj5awOeo7x7wLPJ8miE/t1Bkn6Cii7aR/cJTmcn6rdYjcN4+J?=
 =?us-ascii?Q?rkVNPowXiLUbigRg56c1KpgFTTMYtouKpzPv+XIqioTY+Vkw0BqLrvXmXdyW?=
 =?us-ascii?Q?dZAKFsBzdY4T6brLky3/s23jnfGnE8HyxdckOu5J4IA23EhV6W7+m+9iWTJ5?=
 =?us-ascii?Q?aUO1s3Kc9OhiNfCVcF/oT+BBc2HddlXp9pJYCezSVeXExh6P+/atkJUBNFXo?=
 =?us-ascii?Q?kVMDGuUkh+3eeodhIztjbuIz3lIJrwVnaEkUVTkgvcjlddDJkOfLzfy3UZqT?=
 =?us-ascii?Q?0P++pWovwhjp58h8bkn9mQ4mLbJ2k9VBLQAp3MqZ9LI93dpPFfQZcuI/U55N?=
 =?us-ascii?Q?4S4VshlTid+jLdXbCRKv/JrWpcf/4ad8h3jh1aLUuUG1gPZ+IrnIsx9XWGG9?=
 =?us-ascii?Q?Tzsw0xtgehzHYtRvps2N48ymc8eUHAPf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RIz4DeqdS8+4X1j00JDeMuNQCClNWR9PtcWjeK6stMb3xL6dbTT+AZgcG9XA?=
 =?us-ascii?Q?MlhzAnIlkvVgMRY2tryOtqG8FugRY5L4i2E90bn5Gp/PoGAZXwsV+MQnUkqG?=
 =?us-ascii?Q?7cmipZk1XPj3C7BvoJPwp0x8AyIk0f3yz38SXE5Mjhymn+SgXOBq66YCBNEd?=
 =?us-ascii?Q?KBci0iViCFgdrIoDBC1RMatl86b9bA3d70l3jfLWA2bYuU3N4F/4G1mLUcmD?=
 =?us-ascii?Q?dlFjjTyOhXTX2VhhNAQOtepXszPbXtJN6ApIdCwbhy5skYfirDUBrygSUNSl?=
 =?us-ascii?Q?lNwn6fFYuE2uW2ev/O0lNubEwo+Ui+tSO/Vc7G2K6RjI01L1Ew8bcdzaMFWJ?=
 =?us-ascii?Q?zLzI89mhb0QAseEQcU3LDD9ub+uvVjOApLbRC+9V0VGwDxdLvJIwMaN1rU3c?=
 =?us-ascii?Q?NFS9HlENht6gHxP43HGuPP5Ci7031CbnMYS2PcrMGuEmzBpJpPamB7atT1p6?=
 =?us-ascii?Q?+VeqneVt4rd5X6/Kfsr+/SZXae5xA+uuY5LUH7nxa87bcrsyi5djpLA85sco?=
 =?us-ascii?Q?mo8Qf3qjrzA21zfljjZBkBF3akr4NCCvFPB0x8/AaNczM7DaylgGdyr71ln7?=
 =?us-ascii?Q?tnPTBk0kP+sLcQTifHtNZvvgAvK6RfS2cN/GYxeQCX+Ec5ZBtVoPSawpoQqx?=
 =?us-ascii?Q?3OIV/rtRrq7abCe/4YrhcYkpwMiVYxmWtB0cqQg1Cui+WwGIcEIuA6+Pd3+z?=
 =?us-ascii?Q?Ozy/6w+YaBTc5MRiW7OsC7luZ9sBpxrRYUUcHdznw8d/Xu4fa690+u1W9SiC?=
 =?us-ascii?Q?0Il5+oMYXzlkHttDv/SWv8gzLgTUBzNYzeD8kD02giWQqYa0Sglcc3p0hm/1?=
 =?us-ascii?Q?NKVfXRqAVA+xnGIroWuSeo8rva8PXQSGaE5nskIkqCQzEtI1zs9GfzY/sd22?=
 =?us-ascii?Q?lBgjv/nWwgkMxrmPVCkteZIaCImcwiZ64f7MyVSNSVl82uqZnAj964VViS3o?=
 =?us-ascii?Q?30bsUrSG3NNfFX7EqBPUv80jS4rA2JfKV3BH7TVp+FuxnxR2+juprAB4Pn+r?=
 =?us-ascii?Q?gN9G8+4VgunsA5RBiXZEATC/lyieLSqi+t3nTSTuQrzwfka8u2vbFXQliYWA?=
 =?us-ascii?Q?sNVnphYYa8ES2kqqM7XA87d4OjYzfINVwsasWMMNhjz9P+skMq1fkAhEQ3G+?=
 =?us-ascii?Q?a7ujRSe6nWhqWJUxy+rq/7Xnj4zO31213inX5oe325poMnUpbyfjPTYynqdJ?=
 =?us-ascii?Q?OmXhZ3z97YjIeXBiRuUjt3Mz76hboZXWgcjb9g6SMywlLWvbuGScggkp2Qu/?=
 =?us-ascii?Q?5Z7H3bOtLdKIidP2hzd9E4GvP+159d6YonLKkUnGO6N426gN6EQxZgHUtw7j?=
 =?us-ascii?Q?615JR2pZErGuixvSBTXydElXa4ehKZA5mvRwr8zPSxcboJbg9MIm1GwstiHe?=
 =?us-ascii?Q?LNJQa5rpEOwzoRtKPzGPoPXO9NQ/TNQbjRU19mAL6WM2kuUTh1HrCVfxz0dT?=
 =?us-ascii?Q?TqEI/HzdrALfBCpCG7Irz14Or39oN29xlloKagBEEaDNOEYSkLsh+JoUOqU8?=
 =?us-ascii?Q?jwgAjSIHwollpfFW7xrg10zNOizjA/YIs/WbqXS9vyGwAS392kEMJVRv1enz?=
 =?us-ascii?Q?XJgFYRhSF3UPg3tItOfyCrWzmzp+AD60KCsXce8J?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6BzuHStexTXC7CJl4HvMRqnwg57h+b9qBKgc0e7csWdeL3xIXSzjfuThdmfRGoMEaBMb9hxwP39532MMgl1Hr1ciPj2jVXSxX5b5t/iy1d/ZnvgvuEa86pjckA2I8QU3kvYFhwh1RMRyONzXST1DGZ2aBM7/1H5ZSTlr/40GDOAzf2DX1hGS5DswRJ5Hb8nmhpffLp1x9LnfNgorDGL9nglPsvCN+7b8AeLOZM3/+Ah/37sZ/5IjmpCL180doAVJl9h9DlPA7mO41APepSziF57pvVceztBTx9Keuti/0DoxqAyoKYVPSwRwojz9AxNRRszt8iGrlGeDID0Wb9LfmxbN+VHfl308m455yLyedhCmCqVCwpHS1IYZChMlNFFRGziDf76FSmDttQNaTs3WaIpPlNjPX2ntEvdVfsUACdPD2xuULLBDnyZAaMaWDBr9vJtOkCN/oel0PvsHbPeOpLAf/7Xm8Ac/qRAvzwSEfXw665RuEiFGZbRflHQRwya11sY/Qa3tAhqQ3SvTZg6XBmBNKq2k/LN2R8HuPTy/P0GxhIKIfqBgPyZRtyGxGBmMMlza+N4thgRNjdhzJIqyJQUsRiYzDPLoyLm08HN3mHw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c7284a-7ce4-40ab-21a0-08de20c3340a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 01:39:49.9487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZCL2Vtcmwac7m/1Iu6dXwEpa3nzrnQ4ZPNbDv44pDS9ydBEqG7xZECOZBzJY6FunsDLCHexn/UlqFQte+XqXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110008
X-Proofpoint-GUID: W1K7SgjMOmHmd7buHqw_Jhp34nhLRwan
X-Proofpoint-ORIG-GUID: W1K7SgjMOmHmd7buHqw_Jhp34nhLRwan
X-Authority-Analysis: v=2.4 cv=FqEIPmrq c=1 sm=1 tr=0 ts=691293ec b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=4o6XerhRHFhyfHFBqmoA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE4OSBTYWx0ZWRfX8/Xx9c+R+kKS
 2vFr+Bd9BGBGn7FhcCdZekZlYCFd6/8zGfLG7HiXN+Y7O/D3ug7MTsPPjtHM7p6ib16YDLEqAzz
 +GMM0E3xqomTSWNVbOzmjX214e0ZaDFympNTB/cVujKruWPw7S3IBdI77cniD/V0MvUX292qzQ/
 OrzIo9vVV85TRaxvqgBTqs45dRjumC5FNKzmBizXDO7XAQ9eWbb4etBcVjkaJRpOoGe0O8Tmvyt
 TkBSW3SV4D6fMxbMQQsD1osqqWcSWbnJDnEwsU97gj1PEe9qxYEKAPyl6ip8roNefKQVaGK0C3t
 ezeK6OTJwdG7rW0iCauS2QBKP6iAtGXiyA5gHgTBfpnXJFjL68DrUruIzaNlundzSRwjLd96sJZ
 hGW1U02rxEXpi1VyJCdXpo6M4imEf0VEg+D++E/BMQMZFoLQU8U=

On Mon, Nov 10, 2025 at 03:20:05PM -0800, Shakeel Butt wrote:
> The memcg stats are safe against irq (and nmi) context and thus does not
> require disabling irqs. However some code paths for memcg stats also
> update the node level stats and use irq unsafe interface and thus
> require the users to disable irqs. However node level stats, on
> architectures with HAVE_CMPXCHG_LOCAL (all major ones), has interface
> which does not require irq disabling. Let's move memcg stats code to
> start using that interface for node level stats.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

