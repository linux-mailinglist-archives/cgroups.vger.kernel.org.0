Return-Path: <cgroups+bounces-13336-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id E+a5NVVOcGlvXQAAu9opvQ
	(envelope-from <cgroups+bounces-13336-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 04:56:05 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 543E250AA6
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 04:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8952D4F1AEE
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 03:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E71E342CBD;
	Wed, 21 Jan 2026 03:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VugvcAwF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A9+0qQze"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340C33B6D5;
	Wed, 21 Jan 2026 03:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768967669; cv=fail; b=Z14xBbu0b6/yoE3B9aUhB+q97HtNnGvjzsMAi+bTndxxBparV+mLBvZuOCueAosQ3zos7lFs0/KbUW9bUnVTj//mY7xJ+fFWLYKD684dpri+gTS2Zv9WANyZ2Km8xeVoBsMLfIIJQ9yP7X/QLuD1AJc+5wrQTuvKaZPzQvpSww0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768967669; c=relaxed/simple;
	bh=NXD5imROrdKKMnVkv53Uuc7berEh9q4wiFtFSewU+Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=an7J2dcj5EsF5k+kfiHRiHh6qgx9z92byrjwAG9BhWEKACE3R2S9OKDgb3NaFNLjn7HyKU9nl6piP8RfXZ8ZRGH975ybognRnoIYsFtMC5w+snR9Hce3e6KCentPbI+lVbAdDTlUybf54Pdo5qf5fCMomJUc5I3Lz5zO5m7qaIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VugvcAwF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A9+0qQze; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KIJwlf3265007;
	Wed, 21 Jan 2026 03:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PtnUkvyNsID69xalKU
	W4TGPjJCowZQMm05LsU0PmwJY=; b=VugvcAwFweVmC5QoGOVoM+2Ea1ovYR03OG
	Do1bIc3mnp49XbvA1OsHenxrio/oBmUwZMWXvUVhrKY9ebgI1AGzyzGm2pOy5nau
	SO+teRl1ieRkVwz5YAVaMaBvSVWySH0oIi3xeXJZnT8tYBs8Y9P6Fv9d6quFKKOF
	Au9OSmpywAIFZJcq2ouRzsBOCAGKyMGLLJYcb+ezCgYt6EhNtOr093i9aMq1iR/F
	xwseNILGsXDsbI99lCoXPtGfXk1+oYiiEcEWoRsHycLZ5S0Le9MN43nFRvS7N1em
	B81EKrX5/pvnF90h2yVByxHVhQW8IUyN7TR2J98AzY2irqV/jUzw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br1b8d2gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 03:53:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60L2tXg3032836;
	Wed, 21 Jan 2026 03:53:42 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vee95k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Jan 2026 03:53:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGjRO0VLSXQBM0PM3fSJZVZ/m4kXCrL71refrf5gcL/YL8yygo/DKMu8ZWSUDyymgoOMtE9qhmZsdWuTwVjANieECyv5hCvHO/kt3JIlZsQL3fm+sobS0P4r70taaPGQtOFFxf8aoNUzwpo0cPfvvGRJLNzZNDH5/RQPdQUBcLa00euEn6ZV3aJJcbiMy6PXeZ7IM05w9LiR/T0KLvWIHOut7PwCs3C8vKeXoMeqPDsPssXut06ZjnYvFdqrCNuszA34GLIOVTNisaMrZSHuP6F9eB3NvLoBgPdibwZPvjWZleGW92dVcDbsggb95iPR4PGJJKoT0v5/T8zzsMWYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtnUkvyNsID69xalKUW4TGPjJCowZQMm05LsU0PmwJY=;
 b=jfNxhBkJrU9dV6/NAHQbCc1eW75CPb5PZzE5VW9uFCucuX/cF0Mjqb38c8W98AEvi6ysg1/OkvQi/mDse0SDM/ebO8DrYRlcA+3fS2mWzQuyXxepHTmV51PIG41d21znoYC8EZYbMmxhhm8sqOSNBPeOl5QEnTkb+wIoy1jPcT34jZmLeJ7jCRCNe5rSd0Q5GHHbUdk5CoawXXRMxeSvzSAhbUd0TmCRToAStvPp68qqB/xmAqCvfx9KV16vsp8omTQXXyhbrah1Dz70r5x2/y+E14hiDeRhUqBb4mDv7rlpFtmH8Hvk6EFSJ2rn0UwczepKXZPybW0s4zanSUtFcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtnUkvyNsID69xalKUW4TGPjJCowZQMm05LsU0PmwJY=;
 b=A9+0qQzegwU1C3j1ZJlblzoiWKFc4inkF3gih0r2EaoPbJJKKHfxE7QRRqBbyOjZXQlGBnOBdklKbzCguGd57H59NYew3Ll+KhODzYkv6/Qz+i1Cli7SP0zxZ+/L/uPqgM320cOOHT4DAQAXkNcFy3XVYtzFRbk7r6Z0zht5Sn8=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA1PR10MB7586.namprd10.prod.outlook.com (2603:10b6:806:379::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 03:53:38 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 03:53:38 +0000
Date: Wed, 21 Jan 2026 12:53:28 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
        kamalesh.babulal@oracle.com, axelrasmussen@google.com,
        yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com,
        mkoutny@suse.com, akpm@linux-foundation.org,
        hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
        lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 26/30 fix] mm: mglru: do not call update_lru_size()
 during reparenting
Message-ID: <aXBNuLDtUmDVyXTv@hyeyoo>
References: <92e0728fed3d68855173352416cf8077670610f0.1768389889.git.zhengqi.arch@bytedance.com>
 <20260115104444.85986-1-qi.zheng@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115104444.85986-1-qi.zheng@linux.dev>
X-ClientProxiedBy: SE2P216CA0018.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA1PR10MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b9109f-9af5-498d-0cd2-08de58a0a8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TZORX2H/zTxopkM3JnabmQ1LYFOiFSfJd4P44kIeYdgOJcg6zJ18VGfLbSdX?=
 =?us-ascii?Q?Vd6/98B0e2GBspR0+begZt4RTEkIP6FcqHe1ykNnoEbhk3qIWmpxZVKlIl1k?=
 =?us-ascii?Q?z7g75pyHe3Rvk4ix8lZBJOawfTZoFis2ci4xqSxNNKsiMMAV2zBSg3r/fbpb?=
 =?us-ascii?Q?HgLHBgodZ7XZe7avz+Z6cGZLGPD2oY84WSCuIwHY/qISr7BNgb0QMVSpnkQJ?=
 =?us-ascii?Q?bRZukWNEjwabPMHE8ll2WnWl7KHZUoJAHVHnIUcPMnfDM8fNZ10Zpn3KWdwm?=
 =?us-ascii?Q?h6AV7E8SRP+11Mo6tTJym7y/ZsLInaPN2w8hPrJd0+wYyEAoqxTNLll3vG5H?=
 =?us-ascii?Q?q8r0q/cZLmMGZ7LPuSkeX3wIDB9WDSAgIUvRTg8z4Vg436f6d/IK1gifoDFj?=
 =?us-ascii?Q?eexNJfqfojE9FdGIijH8aw91yisrvBrxhjTa9c7xdJWemG16JyuG/bFEmpjy?=
 =?us-ascii?Q?xvWJ5Jsc3iWx5w++GKANEvEcmmdaInIzsoLXjEt2TseB9oos4MHr7YSJOidH?=
 =?us-ascii?Q?5Pbq7diwgQDgK31Y/gpEfPZRgnLovkKTDro8atl3rP7GXo7rx2WadhJnGbQs?=
 =?us-ascii?Q?/GArjqjqedVDSp6Ep976sh5Kwl8lphg+K7il5kXjO3+H722p57s8bHj5Nj8J?=
 =?us-ascii?Q?WCKu071RS1Vpiyrn9kLyej1/97TfNLv95Znhrv7otCfmAoyGfbM6p5FC3crK?=
 =?us-ascii?Q?PY0CCkrmW58MDA78pSWLzWgU7mm5Wv0xxhs8SNnBRd4kkdSCQGN+6elCazQp?=
 =?us-ascii?Q?TGh8WPl6qOsK3kKnVtEYo4909160Btz1jnpGzE1mQgW20VOFnVg97Xa5ceyo?=
 =?us-ascii?Q?ny9n7naOMyvIecr/Snpcv0zkFatBnjxMIOON7jqHe4+o0luyfVold/nXcp/X?=
 =?us-ascii?Q?V7gykE67zIa9ZRzsOHqPmYWc86NUfQpmiTs/rBduT0HMIqambM67UkMKqk7q?=
 =?us-ascii?Q?b03H6D/M1AMFY1M3tXtwYfKjH+8SzqE1bQdyM1MDNMDDPVVMTEMcepTGC2N5?=
 =?us-ascii?Q?8JBie2/CrBbAimgdFp9TtZ3xRbXxddvwH4/O3SeIVQTFlx1uM45k9fdQzRpS?=
 =?us-ascii?Q?VSQxCs8nSDzecQFtjmzk6mDnIpn9v/zkZciXqCzJK0qfWaODyufuDL84XdlH?=
 =?us-ascii?Q?wv6WCDnUm3cJksUoWjMXdk6g/AAENpyU/H/d3V6fa8Zx0zUCkUE2y2mJqbqY?=
 =?us-ascii?Q?b1QITOMLuergzGZxw7QrtKY8gkyJ/36xFVaCNtz2apI+AmJqcvV87nGIBn6L?=
 =?us-ascii?Q?IlB+s/SJXqgA+v+nVuKv52s9RlpLGmXx/GddTYSTSRBwCjTvQYTwOQlensRA?=
 =?us-ascii?Q?mSpxlysQjEg8ZtT4l9fMgHZGfZ1LyLVK7qAfjUt0AKBlG8cjY2sNdwCFXHsk?=
 =?us-ascii?Q?MqyHFFP7LQR8+zGSrrWq37iVCOSZst1L8U5/Hzym9/TAxh6S/OXOeKqrgYjK?=
 =?us-ascii?Q?jGcn06MydZM62iDw0VrPanfgVedI01tbqLKc6jdwXLEozjbst6FWnpmBEFSu?=
 =?us-ascii?Q?HAq75lzoCG00Kfjul3Z6z/2U8NVNlbPMTFwaCwmJ6YBjmxQjDszAfCIaqy/P?=
 =?us-ascii?Q?jKmJyQ01hppYxNHOfkw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3wG8u/YKCz1bZieaPVBhXXQEwbTel/DYlnqjj3l+f9L6Jk6+p+iiQ9fG4ivA?=
 =?us-ascii?Q?eEfASV9Dhr0DaQ/7kN9gHQBndFdFJ/MG9z8L6iCNXzcF+kPiZo3KKTt/ABz6?=
 =?us-ascii?Q?UQpVQIl2N2iff660kEkCaF85f737kbmmiXqjYPbt2sbPmb+l+o6h1MyWfQrJ?=
 =?us-ascii?Q?Jaot93WM7fi/HJsSi+ApQyo/N+Vuo+Yi8lqad2gLTCoMOyDGY6LvnU5Yw55s?=
 =?us-ascii?Q?TQXixd7rWPr0hZU4LcAW2cFEaUL4GdRR4SBA+M9N0QFxNMtc8qbKrq6pLVvn?=
 =?us-ascii?Q?pwE7F3BOzIG7Ts90nY1j2Ys/jnOupVNqFYXkRNKKI+mVKQIvPGClD2EAgnOO?=
 =?us-ascii?Q?wut3fNFlt4UVr1neUdz1jDGGMI0QcxBeTSpTgBwEfCoYCbYDDIqko4sx1d4t?=
 =?us-ascii?Q?idRnnLTwKKhKWCc4LuaMx44nWzrp0kgrKHQFGiDSDyQv1j9KP3s15p41VKbM?=
 =?us-ascii?Q?5XM88YfJJeMKshuEToAWS0HfBwhy2umuVqpD/q7f/Dyqup+MLV6TmYdKgm2h?=
 =?us-ascii?Q?OwOzjc85+g6jImgPoWURUvVoR2/csALDwpwHUNA1t7MDMyWZ/HhHlsMfAj8H?=
 =?us-ascii?Q?vj2ui8+qU3LtqXiTUIHxTUebVV54CoGkunWlQBLb0d31r0aUqkGwCOBX9ooZ?=
 =?us-ascii?Q?M/0uXohmzFdjnYnefRTauq9qls6tvXQk2+4eJWwiEnzaBkDGP0UlRk8LUDZo?=
 =?us-ascii?Q?5UTotHENIeNFhZRUDajlQcS0DxzaW0d6hpRPiBzfrsKC8aggAqAuVMKV9BLD?=
 =?us-ascii?Q?Npi8EHFzt4SYclHjsWE3rJbFeZcKYf6ZO2H6xpuHjAIQVXg5P16geu6dnedh?=
 =?us-ascii?Q?iQCKrYPmPQeKjMuEI6jx6aOsZ6LjuaRxhWZAa2B1QYU0U4wwBkHlkvLN8jQo?=
 =?us-ascii?Q?AB/8SUHt4Ce6Jr5pNUEitgGV4SXmyBRmH7mMnW/hAACDLXL5vkR+A6KJV5z9?=
 =?us-ascii?Q?SGcCSjiIovWhZqqhQu8pjwURnY58egLTkieLM/zfDfJ1dLa7h56nAlsMQGtY?=
 =?us-ascii?Q?ubBkhrtNPnxZW0QI0cLf1ZNYIiCWvRT+HeWc00qndtGVD3T4pE+qZ91DuPXI?=
 =?us-ascii?Q?olPrI+T4dh8iGl63AA/sUppcZTXiRfkClWSodyRDla99gknsUTWZt12ApJox?=
 =?us-ascii?Q?CpxRhzF44e1SIVN7oZzXD8hEuX+1c3aHJ5rmquPVL0Hnsv4haC6XcQztPGBE?=
 =?us-ascii?Q?zqnsMfQChPu2152cm/4WikPMoWz508TDVYk2zqYbpoQrVyuIks56hWqdlsq5?=
 =?us-ascii?Q?Yl+0QlF12g8t57nZa+5mEGO+7ZHmfbMU4+PmMSxRWe/mFcyoLZudu+r2q2JZ?=
 =?us-ascii?Q?/7sLf0w5+8i9dC/fUDV+nOGux+gkAAr4D64oA9l4J6zlMVhXiOqV0ELibhEZ?=
 =?us-ascii?Q?J/cBs2Jvn90nzMPp6TIRieX2CU4iUqKg6CmJPD0IINv3KByU+yaFRNQIYhv7?=
 =?us-ascii?Q?1eZ4MyWfYqeQN26wJNh/7Wk1o/0O1i91mqmrHbjAkZjcYOsOMLSA2XI2XefN?=
 =?us-ascii?Q?c4zg2hu81hQOEwg2aflu/fRKMEtz5/TwU/4ev0RPHBNFuu3orrJ1wGdyax65?=
 =?us-ascii?Q?Nc+uf/VOTFTe9P2pkicaxR9s4MAC6FaoxoWPXBCsWnPmWQWlV8Vi96X6uRPj?=
 =?us-ascii?Q?xeZuP0lm/LE/Hr+JiZMLjHHEpRloWFT00uBgc5uzX+6dZkhOb0ke/OzZj70H?=
 =?us-ascii?Q?tMRXUA7KA1ykAVg4pak37p72qLR+gKw30SIGulcfNmuUDYK4GH7RY4inVeOA?=
 =?us-ascii?Q?lO9/2z8pFg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UE/E+OpCFJSq5ckvURHAUfZNrk+40WNMIHmYPKYzxww8T9X2jsKAEF9MXNRH/JlB2SWDXKW0daMRJvoMPcRiiB0LLl8hP4pd9C1HqsnEiwIBDmdQWKwEPmTYlFbMOAUeWrYkSJInGyMjrNthki6DO+cfq4Y944KwLtCLk/ueK+acLZwah47EQnint1oHYTqeGDdgJvK2P2th4vCxPmH1jOI3rU7k4gJDfNckAQH7NTJ+jMovcmjVT6xUX0w7QQ407AleeE34nZFZuys4wMTNc1VywD0Zg+8z97VH1NoFnOvPOshAGreSo6glhwrE/N/RkHmskMWBMMwmy6/9oVLZE+qlwMXnLspNNtHdTSVZpIRXKrVWnRHHUwK8SobEnTrMAyZ+lnCcAuhrneuK2Tjl9tDQLHYbKaycpjCOpjh111HuL1OAQLLLktZHSAnojw4dGMdt+kFtqLA+aakIaWSywuEYQQg9rUFJYlh5zPcthnWWDNMHKWBFn06GibjEpoLSSfpwJCR14qOnS8ADLM3GaK4EVcb/gl1NiepwnPk0DOUbK/o2Erna8SBzJAh5z8Q9HcCUCxZ1S9SbeOqC5LoOl7Fw+FFJMCv6X8XoK/a5Rl8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b9109f-9af5-498d-0cd2-08de58a0a8ee
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:53:38.7049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3Wdr66rke8+gYV/l/0oMaHOCPeXnw3sRu0UPcn80vZdgYp9wqbzJivxp4DcvuIQBpbKhLu6vErS/aqdATxvAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=757 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601210029
X-Authority-Analysis: v=2.4 cv=WbcBqkhX c=1 sm=1 tr=0 ts=69704dc8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=HLvGPcdFKOahDy1OYxcA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13644
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDAyOCBTYWx0ZWRfX8YKcCW+bJFCg
 vZv2YOchpH4sWKhL6EePDwNQivBWCqxIZVkM8n4ruNdCOmPdVP4gvZ9fZyIZ5ILvhtswQ45cCcO
 FE/WWnlgLd3zMQFhDQHKZQbV/0XuPV/1VQVd5QaZ9CU2jI0oHngSohH1Zvcsu0SzU/4ZpF+/R9T
 sglpHNmJn4e4TPsTix08FLC/LIreWT7r7QbbRPNygGzFtBa2G5iYVH/wCjo9TUCgIzkJ4nFEuQU
 Uc95GGNeuSrrO+7BGPbcBscSF3AzClYxVaQq9m1AUoMsAJ9liFS3hnLwUSgdNmTJkcHovMWLlVZ
 IpNSj8oLMskRFJjOs15JwlndLjneJF+DAyp+yxwsP9dqXH+o1qOiNIDrgo51pO2zC8lewib6+1w
 jg9JmWOzLRa6LL0tWOqQSq0MO5oojkrasYwBBe23XucypSM7GHX2w6yJf9jsTR6h4aYXNjUd44x
 bVJdTg3tPr/P5uLe6pbzFtg98RfUF1pIfLVU3FfM=
X-Proofpoint-ORIG-GUID: 80F8IrZRCPcMYQx4kv0OinAPrChgkRfO
X-Proofpoint-GUID: 80F8IrZRCPcMYQx4kv0OinAPrChgkRfO
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13336-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DMARC_POLICY_ALLOW(0.00)[oracle.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 543E250AA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Jan 15, 2026 at 06:44:44PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Only non-hierarchical lruvec_stats->state_local needs to be reparented,
> so handle it in reparent_state_local(), and remove the unreasonable
> update_lru_size() call in __lru_gen_reparent_memcg().

Hmm well, how are the hierarchical statistics consistent when pages are
reparented from an "active" gen to an "inactive" gen, or the other way around?

They'll become inconsistent when those pages are reclaimed or
moved between generations?

-- 
Cheers,
Harry / Hyeonggon

