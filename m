Return-Path: <cgroups+bounces-12967-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D79D0163B
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 08:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F421530060DE
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 07:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852B132ABEC;
	Thu,  8 Jan 2026 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PwBlFpYn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TcRSqbrf"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2233BBC3;
	Thu,  8 Jan 2026 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767856970; cv=fail; b=ABZ+bAJmGg8KFQIHP755VirSOsycjW53uON/zUb+bJQOPThRqqaDPCrQUFCMJx3pBvY7A2JOV9rFLEMozuvlyKpdjoljk1NX7DzcARFgIxxFjeqJPUE1pCkKQ5Nyl6QRk/iUK2qPCvedUXvBoppTZrezEHxdOqSPdCOnLCDFvPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767856970; c=relaxed/simple;
	bh=DtqFFIqMJLGYz3+8dveKLGK6Br1i0pdyMHdFP6IsruU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hdo0PdwXptpJWtZkcvUGN3jXxTbZMJOehvFLjQB6U7BPdsXErv2hHT24gxt0nIq+vbT0G1ISTypX5nQKMaJDr9e2/qzUTkdimtCy6sCVViVprnprCqZBDA6UgpTMaqPW6Ic4IAyQn+UREkCyAGKXvMRCcQxIEN3Sq7MfbZCy0IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PwBlFpYn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TcRSqbrf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6086isTZ3723993;
	Thu, 8 Jan 2026 07:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=oyKTEuoaL0jw0PtqZu
	0pTnVJRazLB94OuChEyoxaeJ8=; b=PwBlFpYnVwGg14AnY7v523sZugf0/YHK1a
	6W8VFCePHe0jD8fVx4TVrnMo8p841NWa1gua4Dmt7tkdNNiG7Rn8+4qHHNYaMpTS
	YwOJ0IZKtP+WOql5YELbdE8fmtETPYU6/RTo6NWFoLXIQqAogogq+m/VVOSU+xMw
	VuuRRqlXzLDZVu4/XFW+Xj+OGPAVCWwjM2I2NeIkdabc8gS6Djg1gzOcC/y1JsHW
	ks9zRtRiq4E/2VSRtRAyZiRMeuEe1vpMeBVMvmbfjI1wq/DazYWi3ckocbTNVIwa
	ctQAeXW+l7+Y31Tg5FP0x14b/2H4Bikh6900x7bYL9I/KM/q4VCQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bj7k0g106-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 07:22:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6084jh8a013560;
	Thu, 8 Jan 2026 07:22:10 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besjah1xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 07:22:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmxdfvu9n2G0XGwHxAROMgUSpbDAUFu+natZl3bWKp3wJNx62nbFcwjTjcfewzM9jbpv2sr7XQ8gVCgE/K8hp2Q1mLPVekPvxrAzxRUTw2KS6aJMTRXKI2a8IlK9XtnTvECaR/e6yKwm4nwpP2UF86Pe7VT45121UhajfQzLyUfQlgD1gha1UE0mpqZMmRqRblbnvdq8lKF4jsywjbwsAH0WS9ozr5uQgKbwqqzL3vNp3jYNStD/97LEajVmw6OZh7/1CkJvau4m6qz/uZsQ4kxN8KoaAFM2ELswDMzVn0D7AwhxXa9Mr37qfm08tyrR+sA2hVvsu/p0yTzzKi+9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyKTEuoaL0jw0PtqZu0pTnVJRazLB94OuChEyoxaeJ8=;
 b=qI+Wdmg55kVQYz62OCs2wXxT0GYlIbu+rZe1HLTPWQsJ62O6dwAea+R0aZIjpfbFzGMGBl9PJCrAQQWMmZLdaCiI/PPyTjAQNPqoUdcxW+bhUe6N5B4zYaKkuxY7AGW+fH/tXUI3JkuycNRudyWOWIO6Cl/nCtGwqU8BUAuwpDcCW17wXK/IlbE7z7yS/3+uyhDv564QO9u0179axoZAdOFifDw7ap79dILmPWOT3yUCPpC+AVQsSxbF+Os3s3r+raXMPE+x0sD2Fc13M7lfJ29DRoGAkRUDfbGJrHoJ5UcgTJjMRk7BgLQfFvArWpKcmcyue6HEDYPtIzNGLtoGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyKTEuoaL0jw0PtqZu0pTnVJRazLB94OuChEyoxaeJ8=;
 b=TcRSqbrfiiB1lZGgtq1cBE6PEDyqHdzTyOj1ZY1QwDtwfCRuODHi6MbdylAuGS9kdk54ysvMPS0w5/TVXDIacQhKG6JY1Dh6+IwgiuN33xJX2VEel/XlzvRV3TBLVR2S4DLQ1kmg3tLlwEDZ6py6bWbaYc43vxqOxnfmgEkaigY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB6028.namprd10.prod.outlook.com (2603:10b6:208:388::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 07:22:04 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 07:22:04 +0000
Date: Thu, 8 Jan 2026 16:21:56 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hao Li <hao.li@linux.dev>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, andreyknvl@gmail.com,
        cl@gentwo.org, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH V5 4/8] mm/slab: abstract slabobj_ext access via new
 slab_obj_ext() helper
Message-ID: <aV9bFEuaMoXIjTkP@hyeyoo>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
 <20260105080230.13171-5-harry.yoo@oracle.com>
 <n6kyluk3nahdxytwek4ijzy4en6mc6ps7fjjgftww4ith7llom@cijm4who24w2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n6kyluk3nahdxytwek4ijzy4en6mc6ps7fjjgftww4ith7llom@cijm4who24w2>
X-ClientProxiedBy: SEWP216CA0061.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a15e64-d04e-4436-a80f-08de4e869fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2RBrwHjD3PRa1wFHj8tx71cl33UOtlcPRStEv4NWyQscs7KlhTTzLGZBKdUe?=
 =?us-ascii?Q?rHD2FtfZGSEV2KmmNSefGPLV/bRs0F/pkeuiMNKWHQ563cEvm79RN845D9xX?=
 =?us-ascii?Q?/YpcSeHFgZr2LwaQ72To57CW75rZBKWe+JS0BQ6jOigLVz/+fOGXdxbMklsi?=
 =?us-ascii?Q?qBM3Fb7CnT69diFxnL+aOSb0lZ6nFpIpObq8Lh2DV/ygmwLtBLgff3ZmYOIY?=
 =?us-ascii?Q?8H3soKG0AynGsHmOrdIpGAyLxZQceE75l7DVQzhdS0h9yo3K0mLatVXc+noR?=
 =?us-ascii?Q?D98PTUccCXEnM4bKN9BxpyAwCKHkEIcK5oU99Fb4+iwhFQK+3F9VzNYjqaYp?=
 =?us-ascii?Q?BUPsF8/+PFV3N8V234Nhm8szo/T23KRKwGjHwi+EWsu7STzYNXVLQj4ydwZG?=
 =?us-ascii?Q?mSZd/Wb7EE6YwJEvjXuiu/pZj4F8fySKFec/b3cyiffGoDVpBF2U6ohAvxMb?=
 =?us-ascii?Q?fgU6B3JLkBV85nhYmci1+WYePTYqlcpwEtq880Uo7rYjEYIZZI5gWkBBdPTn?=
 =?us-ascii?Q?9RX1bep1ZXtaC5K+wAtM1/FBK9Fmb3y4YiyaMUQvjsDTGE3mnNGOjGx17/f3?=
 =?us-ascii?Q?CHdWqKRkOXUYH4a2sN1AZj1Lyj/vr9bluKsjxwojxPsfRSdYGhHv8ilXks5D?=
 =?us-ascii?Q?+kFH6nwUwlIwBnWKmsFQzySUGxKCn6s449vc9nyI4xN9fC4fH8Ex24mYt22l?=
 =?us-ascii?Q?W5OZYI+H8jfLr3el4xEvTyBllgla+20el4yooMVRFb2tsCIlkFwpDjtDKo1M?=
 =?us-ascii?Q?fF+cWKSj//9ZGaqONH7vf3RJgm+TDD6tzHiJk7bb4lrBNwLgn4gDbu9M/vGu?=
 =?us-ascii?Q?f1V2apLMazUBNs8Tjc/pHFhsYNq4B+4Ker6MAKSMQN0/SeUieC738elRsW5H?=
 =?us-ascii?Q?N0YPD5qEJe/ZZp1u+4m0Cvv/VObm08+680Y0kEatQlrptobsxADmqB7Bh/ap?=
 =?us-ascii?Q?itL5c7v+R4cgOM1aKt5751Ybxefw8r+zOS4yVfuaUQW7Qmnth1Ls3yrpFnns?=
 =?us-ascii?Q?BQZx10NW/8p8DLEtjAj/00gW0T4s33B89IacEvd+EhnBJ6MYN5p9VZYF7HkR?=
 =?us-ascii?Q?mSaAP5xLmDlL7RkF0AhA8Ab59Y92kAfjakp554Uk+9TpnWh1UsdQYh911uAv?=
 =?us-ascii?Q?zZwrrKNRNa1JklQE4fFyiPExp/ZcSu3jQ+tUrdTd9hY0zuQgJTeI/QEg1Azv?=
 =?us-ascii?Q?Mb+1ziszcVi/APRexHOFkCxaqWaJ9yTV421c7WXteR00DDXrXF7BURz9P+L+?=
 =?us-ascii?Q?u+stxwDY5t+mqYg4OYdS9HHE+mZmxts8EaXFv00NrSGbJJLNlqlQFTUjYvFL?=
 =?us-ascii?Q?Z2oymCXlHQ4tPKyDmP552/CCXfLPYrzCWE6B4oGbRsm6y2iFE0krU57iyH6h?=
 =?us-ascii?Q?Z6mXyOsRo1OgytSBlBw0vAZQChQe4wUGjvKHCBPWSYQkiKA2L2QGxTBQnnCo?=
 =?us-ascii?Q?mWPgIwYEwiH8kU2yTwF6moAW66ZXRLZD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xcj1pAcCSrwLbf8qm8hrzIToyZyAAUVFcfGyse2ZCvMRjxh7jnekhFvp1epO?=
 =?us-ascii?Q?jfSgyIel7SOJ1thgfZ16cUu1JZsKChU2TaMrQI+qOa+PZQ8w9O826CoxgzUh?=
 =?us-ascii?Q?yWAIQSVPtqCr0x7RYxxtDM7C/ZnhhvHN7vZtXnXdy6MGZgsQzH9TMkRmjWCY?=
 =?us-ascii?Q?XyOcwqrW6gqK6kdKvlOOnvsvE+FcCLi/38cAQdy7rG8Ovcde17KnrEihMDT8?=
 =?us-ascii?Q?T4giuLQwKOzbW4B8sZHDEPrkVg2c9NCIi7n7UROVs3kxRkqs2FkcTynQ/tyl?=
 =?us-ascii?Q?adoQPy8QX1dWH9hHXyXy2Abk5bCqRMeIb0fmBdfqotrc9zjHlvQXrPxUWMAe?=
 =?us-ascii?Q?VjBFhZavp9RqCq8iCB0pGsbtRoDOP2ymEiC4pMXGFyC8adpojfSxImRNMvLV?=
 =?us-ascii?Q?/SgTLgEUcCts9JdfvSsgY/j98l2gy7sXTxdYv27YQu0NENog7EQbjCTAWAHI?=
 =?us-ascii?Q?oVOmtATMk4hc7zhRJ8gKE8OpqYBRa5UmFcza5AWFg4D3Mw7UdJMYQmSqyNzN?=
 =?us-ascii?Q?FQHEEkHukhPjMXFifx6eyeH770wl099bN40IUS/mPgt/U4bIw7cc1YLVN2jL?=
 =?us-ascii?Q?LQnA0fARDQ+QjjYoFQknTDz20LHR7zd6EJ1rOi6NZPGamhOUhSGwt4R7LVRg?=
 =?us-ascii?Q?INzgO0fG/TQRKDY7gzilY/2fVsEKDvUqI9I1d1T4Ftmn0HK/0RnfXQjtUavg?=
 =?us-ascii?Q?lSlqIBRyBhKnCd4boVQ6yAPWvRYu5cskzWA6MF0kUybvSxdcmypf5xXdp2jh?=
 =?us-ascii?Q?hIBexeK7WqPRNxAHxImjH5QOuhi+2PSFcbGa6ywibJYa/htKlLR/fbOi4slI?=
 =?us-ascii?Q?y7T7d/NB18BSR5jIepf8oiz6MCNUSeUE/6I7lSpMmtvG4ay0tUWBZoK4PuRj?=
 =?us-ascii?Q?g9/vnv79BXlA5abDYCrFKXKJiXRLcqNbJ9gSda5M5Hhz73aqN+5X5HUaxGWT?=
 =?us-ascii?Q?d3BpbxrYUK5dxiOIdA25t5KaRbzZgF9GJsYeKgQEEQMYGA1Ro7asKMwpNYSe?=
 =?us-ascii?Q?DpBqk8dCmcdsMvYw4MSm0SS23uWer5aMrCvB1LiASgIuSZXYKJizM1NWBeN9?=
 =?us-ascii?Q?B5M3TVUT/6HqtBUgg+m1+nc/yGr9sedynn8ZA72WdyJxUf1u6QsSlWCUe6nC?=
 =?us-ascii?Q?XAkV23lnL/bqBOtD0mVKh+1ANrTw6t/3o5M3pATHuaDdJ+jSqEMiolgw8/gK?=
 =?us-ascii?Q?2KZy/Ra1K4ut9CDmcZ3qZphQnnya406B7A/6Z0e8t0xh+3rFdTlyEs7yvwsq?=
 =?us-ascii?Q?NpgYkuuZApLHG4Bvvg7OLGwqG15fN5oTnafeGDwfUQRxRwyLj8nzyje2BeZD?=
 =?us-ascii?Q?V60fdpdvj8AbkSpTO5OT4NhyTtjK42AuB+iqaq7icQ2cyNLdepmTOO/tXkSc?=
 =?us-ascii?Q?CIPN0GkmFDBypNMg23HjqpLiHyktTLAxkQfjir9tr3hXrlmD1nV+TSoe1cFz?=
 =?us-ascii?Q?i1w57dBqyfyBD8yMojArWhOeIpI8uyEg0hD5WqpJMMUOrhS5BdD7e17nl1Sk?=
 =?us-ascii?Q?ERQ/o0dZvfgMGMNQktVuCfA+qZMQEpRHZb/e9U1HxW3hz+vcfaLcJadtBCQh?=
 =?us-ascii?Q?AQXAGwBEaCQj29ZORj7M9+xBstVyVHeyS33zXCEqzdxUcxnx7Af41/JVs9xn?=
 =?us-ascii?Q?gDM8pQ9MYcpbLoBdrEuOR/IaJ5mBAS7REBhWGHsAP7bFKW3S2QVZeVt9xdwV?=
 =?us-ascii?Q?kO6UgoMB9zqJcbpyV6k2HkOiuGHvHBa8kG1Mqf1AVRPkfOli3eMLnfc4dRre?=
 =?us-ascii?Q?eBit+8uMAw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pmTvIzrM2a21bgMcLg6gYdS4wJNuDOpxgWyx1oEuTULDydqCMec0nTi416b9flsR/pD8ud1GoMYhaV7ar5bs7MbPuRicwUsezpDZvWIAEFvHpLkEO6vM4HltKO73RZvxQwusypgQJJiwe8uJ9DciGR2gM1B42dfVTQuofWuFGXSbDLbfZ+rjjFLY+XvxJfMNVtE6zCd2CDSpw93IJgFfWd7m5Zg7c9rwqWMQfBuDTDsIV7svcKwzhHLlQ8LnArKjtDxC9cWxByxcAq/cNovWUCVY9tCeNdesG8wyKk9s0wm+PE09LRXgHis0m6kmny0tch1Lg6ByXekLiZu0AwPhjBX/hSaISj1B0oQdYly+LDMgj4ZV1UXlPtBBCcOzKkf8EIeL/XatnskJ0uME1/kGlIwBjEIlHV0V3ZEqSHFIgayAOCoZaAxxgkEUNZY3a5sQJ50yxEHk52K9/tUQoui+Mp+xM80pdmcHCfchc0F1MfS1ktTIxIubsAly0OpRwtydwIIKE5W+b1r1pClGYgCbTfCgVFcIjvP1omjEL5/5tMqLU9Nl7Eidtz820QBEZfulVQb80s7FAUr4E5BGD7dDB5h3PXA1fxgo4tO3zlInt4U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a15e64-d04e-4436-a80f-08de4e869fa8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:22:04.6354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwsLj17AY9Lt1SIKMwTcYjcLKxy18ZTopzUoQ+xFmdHKlrj9Sh188wY+fvHGtUYJnHBljaJeiuk446GQHbcQiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6028
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601080048
X-Authority-Analysis: v=2.4 cv=LakxKzfi c=1 sm=1 tr=0 ts=695f5b23 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Pa_Pu_fn-6NKhFeHKgYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: SkPtXO8HKKfZ0n10lB_8Y2Hk9EMdoh17
X-Proofpoint-ORIG-GUID: SkPtXO8HKKfZ0n10lB_8Y2Hk9EMdoh17
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA0OCBTYWx0ZWRfX4tq+qrCq20xC
 IBHpUCuKCPuKzdBNTMqxbOXe4aXX6RBzH3hq4uM7AbVfKOontUwkiYwLGL4X75PvM6x3uAa1Vop
 wGBuYw1AFCQ73uuqQT6YBX1zl9I34vmFBBKDE0RW6My2DXLskXn2vN8FCHzfyTQrsaS+ZBCU7LE
 UtZ4bxGEVPw4te476mvCE5kCKOTAb8ZkYlHsQSsTUxdgkxJ3UypVFqF0r8QEcJKIze5tinbwT+5
 uUD/HEwG4+PYjHWvcMVzZCSfh+8p0UKLbZiJvVvrDeZKUmxlEsoxby9EPYH5iS/lWdyCnRJ4sfR
 gchqfYI6V0TX/ou6U++5NMiDMQ6ZoUFMCejg+WsC2ZQM9Kv2wq0gig9ao/yhFpeojHTGDwZ5BHg
 2plCyPYY/R0fE8cg1LqpaJ1he8LSfbyzEy/DhkC3MfA/LHxkAelWfg8rWQQp1qYMoThrt/WN7no
 Vy3s2MrWTTN46PW3CSQ==

On Wed, Jan 07, 2026 at 10:53:48PM +0800, Hao Li wrote:
> On Mon, Jan 05, 2026 at 05:02:26PM +0900, Harry Yoo wrote:
> > Currently, the slab allocator assumes that slab->obj_exts is a pointer
> > to an array of struct slabobj_ext objects. However, to support storage
> > methods where struct slabobj_ext is embedded within objects, the slab
> > allocator should not make this assumption. Instead of directly
> > dereferencing the slabobj_exts array, abstract access to
> > struct slabobj_ext via helper functions.
> > 
> > Introduce a new API slabobj_ext metadata access:
> > 
> >   slab_obj_ext(slab, obj_exts, index) - returns the pointer to
> >   struct slabobj_ext element at the given index.
> > 
> > Directly dereferencing the return value of slab_obj_exts() is no longer
> > allowed. Instead, slab_obj_ext() must always be used to access
> > individual struct slabobj_ext objects.
> > 
> > Convert all users to use these APIs.
> > No functional changes intended.
> > 
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  mm/memcontrol.c | 23 +++++++++++++++-------
> >  mm/slab.h       | 43 +++++++++++++++++++++++++++++++++++------
> >  mm/slub.c       | 51 ++++++++++++++++++++++++++++---------------------
> >  3 files changed, 82 insertions(+), 35 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index be810c1fbfc3..fd9105a953b0 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -533,7 +558,13 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
> >  
> >  #else /* CONFIG_SLAB_OBJ_EXT */
> >  
> > -static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
> > +static inline unsigned long slab_obj_exts(struct slab *slab)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
> > +					       unsigned int index)
> 
> Hi Harry,

Hi Hao, thank you so much for reviewing it!

> just a small nit: the parameter list of slab_obj_ext() should
> include `unsigned long obj_exts`.

Ouch, made a silly mistake.

You're right.

Interestingly it didn't break CONFIG_SLAB_OBJ_EXT=n builds perhaps
because it was unreachable as Vlastimil mentioned it elsewhere.

I'll fix it anyway in the next version.

-- 
Cheers,
Harry / Hyeonggon

