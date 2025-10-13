Return-Path: <cgroups+bounces-10666-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96430BD5B99
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 20:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33AF14EFE22
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 18:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1450E2D47EB;
	Mon, 13 Oct 2025 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OV5+6Uoa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oNwUoCHA"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E452D3A9B;
	Mon, 13 Oct 2025 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380285; cv=fail; b=ftpLxVKi1vU2awFSj5d2HAmB3aFxwH3AyDEtMYby6svWKlUIOEESQgF7y589OSI11mOIraSMqyPn0UEBdXmxn+7IMtXaCNY8k3JWzrysH8mKbmKKKXy94tTKuAHLPIxTfeB1vMqU74k4l/yWED0wExg3DEd4vQiXKZGKg9ev/pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380285; c=relaxed/simple;
	bh=QG0FvTtqFjpj9XPZFb8gjgRB+7qv237/ANfPZuQxXu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aymxbuwe5dguLW4GFR/4OfZLmCqljlh1Q19Q3OIyxeFQ5pyt4LYZs2XB2OSgDSp7VClaKUhrnIWUaofd1JyER5D2lqfhSZFCxeeaOL1ckE5v3L7Piknwd+RJHT4y76/EyZY9AhJ67Zx5k3D8oy3JjJfyaBDVn7HhGZMhEwMbxbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OV5+6Uoa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oNwUoCHA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DFu2kC015419;
	Mon, 13 Oct 2025 18:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=gVrkpqRm0/w23WZUvW
	88o3l+d+IHFxZcriUw086nwL0=; b=OV5+6UoaymhfJIRFYYKrey4yE/dAmgw4yc
	DPEUPOREzjxAt3PbMpAdAjTmQNmhICGYC3xHgMWyIZueWXMJwE3kihRTXph7A7cm
	y7XuGPQfD8XYV+EG9gQ7fxlVxT2LLF7erZ/De7UErrRTES4zIwtg38qQyN3Kgl48
	PQInD5TAsmO5ez9BpqXI2HzT8dZWdUcL2KnYEK4gikE4Zy5uxv+1d2212uex1xDm
	Z3zLa1uGY93tZ3BQO14cE6LLruouBhICNIKdFnzAl0MxqUPZLjkkgEgUAmQTUZDf
	u4nGB1jSrLNKkldd/pKupJ8sY1O0y+Jgn0lZFb58kVfwHuSkgyCw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdnc2uq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 18:31:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHZ9Ri017446;
	Mon, 13 Oct 2025 18:31:08 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp7p1rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 18:31:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5o7yWb434aLW+2G+amTZ6VhhDuuOhSUUTWMMZ8hAD/cb6hKGrqTKlAD80qUmnlYXhr1P2ACs5nJLzXCIpdweaHUdTxa6c4mUJM8MSZ86BzS9+0wwSih/4yCDzbxIhjKDRvE3I+wzosLnRcfPxFePKsQm2d7tJCHhmfkm3a9AqtIM6oeXaWC9pz+2t0yFYRsD3M4U7Z1BLr3NY3lwQ8gjg3IJcsfRD9TSLaDq8Z+Olcn1lf2PqSHnDjnQ9Sr80aCTxoA7Vrg7ltj2bBvb46Uq1vml2bv3EYbg7RH52gbQ3VserCE+K1Ilpu4Z1kx4JSXqOGuQ7INk4LPXrQQQqgDLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVrkpqRm0/w23WZUvW88o3l+d+IHFxZcriUw086nwL0=;
 b=SdICghs+yBxosGSk9dmXAp8HXPrRkyn5LUE0XTJz0GpGtWx2K6/ZGUS8XVRJ+huJHpmlkxmuB4sKKWI/M40ONjjgR6e1LCn5RKw1EyJ35MEvDk5A+OoDYy2wlEyYSsrk7tIpN5+3UXjw5mJ/COsMwcNv3xVuCJgiw+/GBPe/PPshLWHcght+ZoQH1DKSeBtubBC6FY74bEG2mABUsc/LgsuDm0vDbnV1VmybBv4eOoYc/YKTn5IB3uawK06cKtVEWejd5L/3QPKd0xp8MiB+3RwEJsQFW1aViIV96Hv0g5pOT53iPcejNQBsaYropGf7UciLYw6WD6zCuRBJKHTBWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVrkpqRm0/w23WZUvW88o3l+d+IHFxZcriUw086nwL0=;
 b=oNwUoCHAv+s+gPz6FVio1KOiboWvAsNEgbQYELtDug4yQSu/o8+Xq+suwhs0o92WAz4Ir21SJ3QJIUFxfLXgnR5gpvA+M5gIozYUewM0UA6mCz70WOZ++b13U3lIzDWxvDM0dSkv8UQOEzQVCbn9oIBpbDPLrrDNKLFAWEjIoYs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH3PPF898A57FC1.namprd10.prod.outlook.com (2603:10b6:518:1::7b5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 13 Oct
 2025 18:31:05 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 18:31:05 +0000
Date: Tue, 14 Oct 2025 03:30:58 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: kernel test robot <oliver.sang@intel.com>,
        Alexei Starovoitov <ast@kernel.org>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [linus:master] [slab] af92793e52:
 BUG_kmalloc-#(Not_tainted):Freepointer_corrupt
Message-ID: <aO1FYlFwnVajiB8V@hyeyoo>
References: <202510101652.7921fdc6-lkp@intel.com>
 <aOzKEsav2RubINEO@hyeyoo>
 <ca53e0cd-95a3-43c9-b012-194d80cb3fcc@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca53e0cd-95a3-43c9-b012-194d80cb3fcc@suse.cz>
X-ClientProxiedBy: SE2P216CA0159.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c1::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH3PPF898A57FC1:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d1af4c-1280-40ce-4678-08de0a86ab08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CfOm+DV1T+7gTzCY37VUszNXYj72k+dLwYk1//eI5CzVZVIlMNtJjjCRzkKU?=
 =?us-ascii?Q?0zj6Dnmh8a+nMULm28/age8C69c1n6RO+HMhOrlJybhS1DDvqC7poRPfu3Ac?=
 =?us-ascii?Q?xkH3H3zVRUrx8DiXenmeUBniHThGJbDHHbXOVMvSqhjKWEWPb3+K4r9wVTdq?=
 =?us-ascii?Q?v99nX6+ki8nCYYYlZ+AM+bVk5dwy2vQvX32deHnjn3hPg4pxESnaGWsFH95l?=
 =?us-ascii?Q?BWiAXB5zrFz3Xhqp3jGxe8dX4ogXUvjE70pT8ki1heq2SpRfCWx2lt5TfYuP?=
 =?us-ascii?Q?XxO9+VJDA/H6cgPgIO4qTELhXy9+qPY20QpXMibnITdFllw41Ft6cS278q/+?=
 =?us-ascii?Q?PsGTEX7EiAcjniFkHHDah6Rpmw+ViKR25q5+TpSuQFJ+8QPQxZ5g8nCwtL7T?=
 =?us-ascii?Q?qjK1t6XLDoTAUvBD5Ru11wMToEj/SmMB6fKvYhRASRCKQKbAnhlo9v77I461?=
 =?us-ascii?Q?Ce6LaWYAjRX80RrR0un6pVV5T3DNZXOP85jAvrqNICdkyxMDdU8q5P/XXg9G?=
 =?us-ascii?Q?cBs6+P6RoylXzNZ/eWOGh9i1NNuVRJIWrrakvFbGp9UK9V5O/1JaSd/3s9kJ?=
 =?us-ascii?Q?HH3VdbxW2qTpPK2V0k3S/l5JhaAIN5aAcLO8MUt+QrfTp6Y+oRpvAobzFjer?=
 =?us-ascii?Q?Tvwi53/FiWUOW0GQkNHWR8VRRHENztPS7qvmPtY+X5w12YAt5LW+4IgjfKYm?=
 =?us-ascii?Q?Gxo55YdowFmVm/RK8I7Yy2K00yG8hLZploaCPRm9T90R8h/2+6LSuCaCMQLA?=
 =?us-ascii?Q?lkREthKszdzWAJjW/DQnpPnK3fNoloP5xbSc7Uj8h8kLbuwrI/3PH7ARRg8d?=
 =?us-ascii?Q?ZSbrrovAHZFA+QYnLVRiz3ReG06mtQezIJrUKgO2R8/7ioJU1lEH4ha6G7c+?=
 =?us-ascii?Q?aYcO7qIM1Rh7WJNQaBtzhzLhpn6vr+b4/ax274fBI9GSW1K4XN5oL8cVlMP6?=
 =?us-ascii?Q?tHUjQW74mMCGxDipzAkvJydVh+A8paqI4ckn5VoG3h6d5bZHp4Fp8vLtt8HR?=
 =?us-ascii?Q?nhGj1Qz8eU82+pjFsM2fS7TNLtaznrCN8DxM6yyzoiFUypxyTmKhewoMYRDc?=
 =?us-ascii?Q?LmaRyLstnXx2WNdtx4a9D+Qwo/I9DCDU2ZD44U+v6DyXj0JqOFBs5eIouKtP?=
 =?us-ascii?Q?nmmWKKhbz75mVvNPK/Uc+/hZ7U4HcWqUrOilBEY4jnaJHIvGNjc7k+7MRKo9?=
 =?us-ascii?Q?EkxRMGbd+GSEIVvRv5iiRlDZcHEk49BZFskYR6Ogrv8e4TnwAuK4WvwzZFC4?=
 =?us-ascii?Q?BHa0iFbChanWGPJ0efeFCHSDWGyp0L+N4IVsabr+aGPijMNpTi8Rtr9zbLZB?=
 =?us-ascii?Q?BDA++m1mYpV7ba4EuddHs6PUuqb8GJbY55xFPgeSQafc5ALdtp5IgiayU/GW?=
 =?us-ascii?Q?QRD5AEGHbbkngiLKhVYUFBc/pG62jFWow9cAvsc83vo9L199D1IEaG54y7NS?=
 =?us-ascii?Q?JJ5dBihzT+QTpSwTRyJoFJrJzUJtqo74D5W6r/PcNaCzEv3wJKus/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ps6Tyxvk6vjYt3by6rjqHsmqWylUyLvUssDtwSI3Ftg+wpwjT2ckI1LaPmzt?=
 =?us-ascii?Q?r5MY1WI0IVhi2tsS8D0LxvjPG0b5s4aCJxGULhXhYOGqLf0/4oyDJKQeX+q3?=
 =?us-ascii?Q?nKjGdZ3DivHiw2ti4db6rrJuP5tbmojevRyAGBTjRWDdVfu5IbmAHMRwAiSr?=
 =?us-ascii?Q?8fFVHxLR1QQ51Dgo450v/LmfFRvmqMXmqRc5UAPofL2uhCvIHYwXT5EIjbBg?=
 =?us-ascii?Q?Z/+GsYgpOKv9tEaBydUjXpgtmL1+vNfbwIuDUiAgmXLaig7kvDkdp8hphqiv?=
 =?us-ascii?Q?MRr9PzpQBPXTodj0ZaZ/RAvvXsbmGwGblUUAKCCGd2zY13oakvAM+ym1ts9a?=
 =?us-ascii?Q?VCisrkKu5Iom9R9mLoW98AVyIuraKv/H1L0ht0yWUn8BAbrSUm5amSzbdE/P?=
 =?us-ascii?Q?gxGFIbyZuTzGg5Gw0QFXzngPJCWKA79HF+XFFDxg6v9/cVs/C65iUcrwopvN?=
 =?us-ascii?Q?l1MivCUIQgoG8aJsGfix+1HYWtwkeR2y92WxL5oa5/qXsVUEJ6qMJFRlI4W3?=
 =?us-ascii?Q?/8CAg/oeDQV2xV0hurpp7z3TGYHw1MxAiBvJT8dh75aVVUp1KBoimBQmuguV?=
 =?us-ascii?Q?2/LBozbp2F4uaB4mAT6DdU2+IyIiBfqv4XuiciaECRI8vjTJjL2r6kGEfS7K?=
 =?us-ascii?Q?f6I82I4Ji5mByXYsDd1W1uFPgbSgynISlokZkSUUz69rWJMPRVMbhp860RZd?=
 =?us-ascii?Q?c/Hymb0M+fwTmaDT3lgjI3Eo221hkIKcXyUY5U8piPrjWK+qbITtNolIlUEl?=
 =?us-ascii?Q?25E14s6433FH3iOBf78GJr9REiGNzXlzVvU1Yw1mTbkhgtX25mv5nyyUJGWH?=
 =?us-ascii?Q?WNuW55mIpVijf+ZVnyPWLGfwj0FdPgmVAY+pf4vytig46JV5PhPsx9g5+ItQ?=
 =?us-ascii?Q?NG215LTMCmCtamMFkcHYfd6YriWXaCIDMYTQ3XrdZgLyBzOCyCZ9QNJCT6OE?=
 =?us-ascii?Q?EZPuUnQyqVXK4jQCYBC100YMrcsDakiW7n0rLwb1RFs3N/EP8aIkvhIAYeyW?=
 =?us-ascii?Q?/soeE190faV+Y9UeBL0nIVvjQRbAoc/TJqO4Qqaa1XotUlaM3UDOBt9CTACM?=
 =?us-ascii?Q?xHvVBH3ZWtVk73WO/+ndSkZ0LcBfEKXnfuEuULSlKTR5eSlbwR/2TyS5vpsY?=
 =?us-ascii?Q?VqqnmxZIZROgp68jsZwnQr/5q7g7XNLPhupcvOOnAxL8AvUYQpVIy+ww7fd1?=
 =?us-ascii?Q?RuHKQE+AQ/EX54xVgxA6LghYA/erRZ0POKe+jf67IdVH0aBiJuDBkEtIcGp9?=
 =?us-ascii?Q?c5vrR6gf0BSowXwF4qb+rtXMYMAUf9qNUUY3lHPWvyNkNETJLr90iPPBbGk+?=
 =?us-ascii?Q?gq/NKgLpF+xAGkjlUxhsk36wH2JovlPRqRyNynhdxt7i6F8Zw5hybLckdGJL?=
 =?us-ascii?Q?iqG9rULoPLd9tjkv/MAMLit+knAMhV8VTFWGyBGdjvO+207GXMXd8bNZlWwW?=
 =?us-ascii?Q?H9iWexGTvbzxniJW4/HT9wETqG8rUKG72HDlYyGqN4gyeL2t0CjL7bw82wai?=
 =?us-ascii?Q?QcjlrZcOiEVDMGwp8As8IovNbdDjt3Q5xpiBH2g+nuow+rbRaE9MjkTyK7wR?=
 =?us-ascii?Q?kIqDsrBxmIc7AA/FSTyo/wSp2vzYaj+gX/HK85H/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kzxehd7Pnvz/HltGNu/rXIG/GsPdzpFJfCHKvrHAkm3ri2LFxfNRjxhl5SR/lDb0/Tz8fzjkQ/EYPMCW4MYd7GZDHEyx/QsfA55clmVIMU2XazAOPB+XkyjzzAyapV1RLSaThELXAZbvY4aWTNniLf1MFtboBW1B3G1w3ONhkyHVwXixEgVdFSd05RNhm813AbP2KPyojsRyJsOkXFM3UlZ1ATbNMvWlRD2t1lgY4zy99yuXTkp7Qz6FNjuNNiTqocbU4s0F24u0Nq49Rw3KZwtsq0B4g16W2vyUliR1qZszEZzC7vMZDEC183uS/5BdrK+6W6NUuDyWYdYkM1FXIp6kIjWSHaA5GJQJKBvKMFRWlATWrqZ1kRJ/M9Io4GpuVy384ylEVYMqkZwGtjXNU92E+ayAnbnouKBtGwo3foEBQFYDFs0SgOny78ibHzctUq0i6SPUYKb3evWswvjBdZHAIqCCAb9u4ILLZ/lWdk2z1ioEjCgXb0/ldibyXpyoAvmUFzoT+QNzKVIi9QWu/IsA/H0O9MVeRvFCBW7RS7lbmpqLj1J4YLGT4wRztbdhTznQQIjYqwGhzUsSEJzHneUUkwnGBpE7UCcpKaU0Pq8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d1af4c-1280-40ce-4678-08de0a86ab08
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 18:31:04.9651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otp5z2Nj0ypxLPVizvA3UX07tatUEIXQvczHuFmEiarypmJ0nHugUfQmNjr3JmQGplVyEn1woEtVbYniRbaVBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF898A57FC1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510130083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNiBTYWx0ZWRfX0L9TghbhiZEC
 PkqynW2uv+QyRVKsmupnjGWOIPYUflYQAwUrjCbbrlCq32fZWAHzsj85EVHbEuYD9/S1KNkiVQ0
 JR+qi7s0KZqcVwXO2Rff2A+agnHsYiocXGsObvRJ36OF2uA/NIhL7fsI2/yXswisRIlCwczz2md
 RV0P3162BcqHWKhoWBZnUXctDyn8NB/2OeaQkg997Swb6pQLroYr4BccNlD1VQ0S4Jqt1qkEupF
 IeO3e4BYjMh85o7N0XGJ4YOq3szX1BlLF/tA3dEnogCdbcFWkObOEBcQtv6xFdsdYQLJL+uJ4mk
 Mcx9WdRes+m2a9TVtRh2CC2bH02afrRhm23dcrMi3Cdw+7J4BasBnOzKdEW+P30Vw2RYfInelvm
 KCefKDR7dMvC03sgNOeBMQ2cScbdYQ==
X-Proofpoint-GUID: RHR37TzvHswhRge4ob9uRd_QZqCTtrov
X-Authority-Analysis: v=2.4 cv=ReCdyltv c=1 sm=1 tr=0 ts=68ed456d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=0zEK961ZpFUOy2DkBDIA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: RHR37TzvHswhRge4ob9uRd_QZqCTtrov

On Mon, Oct 13, 2025 at 04:23:09PM +0200, Vlastimil Babka wrote:
> On 10/13/25 11:44, Harry Yoo wrote:
> > On Fri, Oct 10, 2025 at 04:39:12PM +0800, kernel test robot wrote:
> >> 
> >> 
> >> Hello,
> >> 
> >> kernel test robot noticed "BUG_kmalloc-#(Not_tainted):Freepointer_corrupt" on:
> >> 
> >> commit: af92793e52c3a99b828ed4bdd277fd3e11c18d08 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
> >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git
> >> 
> >> [test failed on      linus/master ec714e371f22f716a04e6ecb2a24988c92b26911]
> >> [test failed on linux-next/master 0b2f041c47acb45db82b4e847af6e17eb66cd32d]
> >> [test failed on        fix commit 83d59d81b20c09c256099d1c15d7da21969581bd]
> >> 
> >> in testcase: trinity
> >> version: trinity-i386-abe9de86-1_20230429
> >> with following parameters:
> >> 
> >> 	runtime: 300s
> >> 	group: group-01
> >> 	nr_groups: 5
> >> 
> >> config: i386-randconfig-012-20251004
> >> compiler: gcc-14
> >> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> >> 
> >> (please refer to attached dmesg/kmsg for entire log/backtrace)
> >> 
> >> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> >> the same patch/commit), kindly add following tags
> >> | Reported-by: kernel test robot <oliver.sang@intel.com>
> >> | Closes: https://lore.kernel.org/oe-lkp/202510101652.7921fdc6-lkp@intel.com
> >> 
> >> [   66.142496][    C0] =============================================================================
> >> [   66.146355][    C0] BUG kmalloc-96 (Not tainted): Freepointer corrupt
> >> [   66.147370][    C0] -----------------------------------------------------------------------------
> >> [   66.147370][    C0]
> >> [   66.149155][    C0] Allocated in alloc_slab_obj_exts+0x33c/0x460 age=7 cpu=0 pid=3651
> >> [   66.150496][    C0]  kmalloc_nolock_noprof (mm/slub.c:4798 mm/slub.c:5658)
> >> [   66.151371][    C0]  alloc_slab_obj_exts (mm/slub.c:2102 (discriminator 3))
> >> [   66.152250][    C0]  __alloc_tagging_slab_alloc_hook (mm/slub.c:2208 (discriminator 1) mm/slub.c:2224 (discriminator 1))
> >> [   66.153248][    C0]  __kmalloc_cache_noprof (mm/slub.c:5698)
> >> [   66.154093][    C0]  set_mm_walk (include/linux/slab.h:953 include/linux/slab.h:1090 mm/vmscan.c:3852)
> >> [   66.154810][    C0]  try_to_inc_max_seq (mm/vmscan.c:4077)
> >> [   66.155627][    C0]  try_to_shrink_lruvec (mm/vmscan.c:4860 mm/vmscan.c:4903)
> >> [   66.156512][    C0]  shrink_node (mm/vmscan.c:4952 mm/vmscan.c:5091 mm/vmscan.c:6078)
> >> [   66.157363][    C0]  do_try_to_free_pages (mm/vmscan.c:6336 mm/vmscan.c:6398)
> >> [   66.158233][    C0]  try_to_free_pages (mm/vmscan.c:6644)
> >> [   66.159023][    C0]  __alloc_pages_slowpath+0x28b/0x6e0
> >> [   66.159977][    C0]  __alloc_frozen_pages_noprof (mm/page_alloc.c:5161)
> >> [   66.160941][    C0]  __folio_alloc_noprof (mm/page_alloc.c:5183 mm/page_alloc.c:5192)
> >> [   66.161739][    C0]  shmem_alloc_and_add_folio+0x40/0x200
> >> [   66.162752][    C0]  shmem_get_folio_gfp+0x30b/0x880
> >> [   66.163649][    C0]  shmem_fallocate (mm/shmem.c:3813)
> >> [   66.164498][    C0] Freed in kmem_cache_free_bulk+0x1b/0x50 age=89 cpu=1 pid=248
> > 
> >> [   66.169568][    C0]  kmem_cache_free_bulk (mm/slub.c:4875 (discriminator 3) mm/slub.c:5197 (discriminator 3) mm/slub.c:5228 (discriminator 3))
> >> [   66.170518][    C0]  kmem_cache_free_bulk (mm/slub.c:7226)
> >> [   66.171368][    C0]  kvfree_rcu_bulk (include/linux/slab.h:827 mm/slab_common.c:1522)
> >> [   66.172133][    C0]  kfree_rcu_monitor (mm/slab_common.c:1728 (discriminator 3) mm/slab_common.c:1802 (discriminator 3))
> >> [   66.173002][    C0]  kfree_rcu_shrink_scan (mm/slab_common.c:2155)
> >> [   66.173852][    C0]  do_shrink_slab (mm/shrinker.c:438)
> >> [   66.174640][    C0]  shrink_slab (mm/shrinker.c:665)
> >> [   66.175446][    C0]  shrink_node (mm/vmscan.c:338 (discriminator 1) mm/vmscan.c:4960 (discriminator 1) mm/vmscan.c:5091 (discriminator 1) mm/vmscan.c:6078 (discriminator 1))
> >> [   66.176205][    C0]  do_try_to_free_pages (mm/vmscan.c:6336 mm/vmscan.c:6398)
> >> [   66.177017][    C0]  try_to_free_pages (mm/vmscan.c:6644)
> >> [   66.177808][    C0]  __alloc_pages_slowpath+0x28b/0x6e0
> >> [   66.178851][    C0]  __alloc_frozen_pages_noprof (mm/page_alloc.c:5161)
> >> [   66.179753][    C0]  __folio_alloc_noprof (mm/page_alloc.c:5183 mm/page_alloc.c:5192)
> >> [   66.180583][    C0]  folio_prealloc+0x36/0x160
> >> [   66.181430][    C0]  do_anonymous_page (mm/memory.c:4997 mm/memory.c:5054)
> >> [   66.182288][    C0]  do_pte_missing (mm/memory.c:4232)
> > 
> > So here we are freeing an object that is allocated via kmalloc_nolock().
> > (And before being allocated via kmalloc_nolock(), it was freed via
> > kfree_rcu()).
> > 
> >> [   66.183062][    C0] Slab 0xe41bfb28 objects=21 used=17 fp=0xedf89320 flags=0x40000200(workingset|zone=1)
> >> [   66.184609][    C0] Object 0xedf89b60 @offset=2912 fp=0xeac7a8b4
> > 
> > fp=0xeac7a8b4
> > 
> > the address of the object is: 0xedf89b60.
> > 
> > 0xedf89b60 - 0xeac7a8b4 = 0x330f2ac
> > 
> > If FP was not corrupted, the object pointed to by FP is
> > too far away for them to be in the same slab.
> > 
> > That may suggest that some code built a list of free objects
> > across multiple slabs/caches. That's what deferred free does!
> > 
> > But in free_deferred_objects(), we have:
> >> /*
> >>  * In PREEMPT_RT irq_work runs in per-cpu kthread, so it's safe
> >>  * to take sleeping spin_locks from __slab_free() and deactivate_slab().
> >>  * In !PREEMPT_RT irq_work will run after local_unlock_irqrestore().
> >>  */
> >> static void free_deferred_objects(struct irq_work *work)
> >> {
> >>         struct defer_free *df = container_of(work, struct defer_free, work);
> >>         struct llist_head *objs = &df->objects;
> >>         struct llist_head *slabs = &df->slabs;
> >>         struct llist_node *llnode, *pos, *t;
> >>
> >>         if (llist_empty(objs) && llist_empty(slabs))
> >>                 return;
> >>
> >>         llnode = llist_del_all(objs);
> >>         llist_for_each_safe(pos, t, llnode) {
> >>                 struct kmem_cache *s;
> >>                 struct slab *slab;
> >>                 void *x = pos;
> >>
> >>                 slab = virt_to_slab(x);
> >>                 s = slab->slab_cache; 
> >>    
> >>                 /*
> >>                  * We used freepointer in 'x' to link 'x' into df->objects.
> >>                  * Clear it to NULL to avoid false positive detection
> >>                  * of "Freepointer corruption".
> >>                  */
> >>                 *(void **)x = NULL;
> 
> Oh wait, isn't it just the case that this is not using set_freepointer() and
> with CONFIG_SLAB_FREELIST_HARDENED even the NULL is encoded as a non-NULL?

Oh, great observation! Obviously it should be fixed.
The fix posted in the other email looks great to me.

-- 
Cheers,
Harry / Hyeonggon

> >>
> >>                 /* Point 'x' back to the beginning of allocated object */
> >>                 x -= s->offset;
> >>                 __slab_free(s, slab, x, x, 1, _THIS_IP_);
> >>         }
> >>
> > 
> > This should have cleared the FP before freeing it.
> > 
> > Oh wait, there are more in the dmesg:
> >> [   67.073014][    C1] ------------[ cut here ]------------
> >> [   67.074039][    C1] WARNING: CPU: 1 PID: 3894 at mm/slub.c:1209 object_err+0x4d/0x6d
> >> [   67.075394][    C1] Modules linked in: evdev serio_raw tiny_power_button fuse drm drm_panel_orientation_quirks stm_p_basic
> >> [   67.077222][    C1] CPU: 1 UID: 0 PID: 3894 Comm: sed Tainted: G    B   W           6.17.0-rc3-00014-gaf92793e52c3 #1 PREEMPTLAZY  2cffa6c1ad8b595a5f5738a3e143d70494d8da79
> >> [   67.079495][    C1] Tainted: [B]=BAD_PAGE, [W]=WARN
> >> [   67.080303][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> >> [   67.085915][    C1] EIP: object_err+0x4d/0x6d
> >> [   67.086691][    C1] Code: 8b 45 fc e8 95 fe ff ff ba 01 00 00 00 b8 05 00 00 00 e8 46 1e 12 00 6a 01 31 c9 ba 01 00 00 00 b8 f8 84 76 db e8 b3 e1 2b 00 <0f> 0b 6a 01 31 c9 ba 01 00 00 00 b8 e0 84 76 db e8 9e e1 2b 00 83
> >> [   67.089537][    C1] EAX: 00000000 EBX: c10012c0 ECX: 00000000 EDX: 00000000
> >> [   67.090581][    C1] ESI: aacfa894 EDI: edf89320 EBP: ed7477b8 ESP: ed7477a0
> >> [   67.091578][    C1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010046
> >> [   67.092767][    C1] CR0: 80050033 CR2: b7fa58c8 CR3: 01b5b000 CR4: 000406d0
> >> [   67.093840][    C1] Call Trace:
> >> [   67.094450][    C1]  check_object.cold+0x11/0x17
> >> [   67.095280][    C1]  free_debug_processing+0x111/0x300
> >> [   67.096076][    C1]  free_to_partial_list+0x62/0x440
> >> [   67.101664][    C1]  ? free_deferred_objects+0x3e/0x110
> >> [   67.104785][    C1]  __slab_free+0x2b7/0x5d0
> >> [   67.105539][    C1]  ? free_deferred_objects+0x3e/0x110
> >> [   67.106362][    C1]  ? rcu_is_watching+0x3f/0x80
> >> [   67.107090][    C1]  free_deferred_objects+0x4d/0x110
> > 
> > Hmm... did we somehow clear wrong FP or is the freepointer set again
> > after we cleared it? 

