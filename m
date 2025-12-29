Return-Path: <cgroups+bounces-12792-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 365C9CE614D
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 08:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A18F33005EB7
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 07:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E70D2EACEF;
	Mon, 29 Dec 2025 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pc08Pne5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HRgzZJkn"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6092EB87B;
	Mon, 29 Dec 2025 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766992198; cv=fail; b=MIELywaoryrbxrKbF6dzcW8c16r2rPGI4IraeU0tPmAxJvB0SBSZJyk/OF1J5jGHzCVLZ1ocwJ+f4QPTEGHp7Mh7Yc43CQ/cVry8Fjto62YSJ5OL1pazbCLOUjaiGh0WSfWliPuarPmLzeXkmj35udMr3lMIuy5squVQmbNT95g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766992198; c=relaxed/simple;
	bh=BPSTKvLZdRWUPiKlZM+h1ixXwU9ww4sfIpHgmuhitIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DEsnBngtfEgs9IFPFZJ05GNIRuZH5yxTW0QJa6GEMEFs17NZVyA+TGqJ6lTnLLJ5g3LQnfjWqa/ApF2v0DzGNxwcSWzg3dUPAteRdwvv20UnRAz2ra2xe7E1/NIXBZCnD4Rg/brptofgmB8zPdvRMvlGPzwcu3t4azuYQwgJafo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pc08Pne5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HRgzZJkn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BT3bFE01000896;
	Mon, 29 Dec 2025 07:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=keOQ8uT5SCDG8BUAuI
	11x8UtJA+xBDQC3YnmQgiBPU8=; b=Pc08Pne5wIaXmGdJ40BXmuYd/YKb9F3Tej
	QsNDpRR/M+3ayd9Qf4jMf+i9p5TThJy28sjZaYi5rcjwUILaekihmvJZsCBdJYH1
	Oak+VfRdINYgAEV+UX3nm52ay1tkL2I2/XAU79VF6z4jk77czx3WJjN84ZcBHOU0
	shI49zhDZ5sw1IG7huKibjSG5nS8H4+ViPcT7TdioZEuCVD5AOI4WkL2UlzVP3x8
	7lzgklm5rWlpGFDrMqk8pjmsex7qhVgP4DE0fXlrtyjFIhYdsmBJDhXlqtDagMw+
	gnKONzUtixTKgut6ep0KDicPRA7tcOTljm+4Fk/hAJil7h+1k9zg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba5va1bhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Dec 2025 07:08:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BT5oF7e033274;
	Mon, 29 Dec 2025 07:08:08 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012007.outbound.protection.outlook.com [40.107.200.7])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ba5w6w90q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Dec 2025 07:08:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wunt7YJbx6yf/n5tUJcFwgBAusB8CNHWJhTvjw2qPSwzNlvEHMtRDTaI2r2jH+hvG9YWQrmSroagyee9ZNNQTo0lJu8bpC3HKUT4S+5iFo9rRIjI5CnTEec2nUozjT0LUd+TBdjGXAlrHJRdYkXZpTQu0Q1Avu32UB66ogtPDLn1xX/b9OmGrihnyKXn1iyO3TTCOvyU3zmFJypyKjunnSUAXanyVdU32QTV65gE6LMBm9IsOhDGUhSn/Ct2rLQfBHJXtA20XTU0Y/HIE9iqeCTzElmtSVnOXC2PptIzD2dMZPzPp43hNKnwOcib0alzJd8fItMKvIra12CZlp6cRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keOQ8uT5SCDG8BUAuI11x8UtJA+xBDQC3YnmQgiBPU8=;
 b=fuwuP54AndsM94ljJhG9ORDsTBZVRsq3hlVnN3bILQ34DC4HysaXygU1QRjQnKzElllW8OtCaTVKsBpCVxVX9cSx3FGg/JkYrIry1mQAaoQ4wmQomV/I6GTyLo1elzGAsSVdIIIZ3SnNCQ+T5Hcd/T8ssDV8RrosikM4U6HdnNaZFft/uY/5MlONhO73OZBIQKQaRln/30XCon1848+yICjQy3JC2GC4VuTcRn5FlijyZZJd+R1VJs32tI3NvhuO8+gL8j745ZwEdewcpCLLLuaj7k2ar0xSUBAhqq4AAwI6qMnSYiUZ+XqqoEcFzlRLsZ/2M8Bbe9fdX4F79miyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keOQ8uT5SCDG8BUAuI11x8UtJA+xBDQC3YnmQgiBPU8=;
 b=HRgzZJknMg3xUa0x/2RhB6YO1zsAUjkb8YsKTNby/+UKTpMZtLiFYMzHxyJ1tJuSAxTI2HZxeNRX9MNGIxeoDOeiWX2zkxpuYzzEu0fC0mQEw2nRchyGccA4VCQx+qPMqPllyxrRI4w5nKP648P0TixRa/Qxic05CTMCuefnu28=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CYYPR10MB7652.namprd10.prod.outlook.com (2603:10b6:930:bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 07:08:04 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 07:08:04 +0000
Date: Mon, 29 Dec 2025 16:07:54 +0900
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
Subject: Re: [PATCH] slub: clarify object field layout comments
Message-ID: <aVIoyh9fXoxKTUSa@hyeyoo>
References: <20251222110843.980347-1-harry.yoo@oracle.com>
 <20251222110843.980347-8-harry.yoo@oracle.com>
 <graryni6wadpi3ytfq7zimj2kbmm7dumxvhxtzmxndrv5s2y67@ju4cdnsmos6e>
 <aUq1x_BowqYpHZAQ@hyeyoo>
 <zex6wgdlxk5vgwm7ou657fdmi27xnxihdndlszfa2chghamfuz@grhtfqw7gm7o>
 <aUrCXYdziRWP9PfV@hyeyoo>
 <c6owr44jdncf7q5zqgq4wn4pm57ai4cd3upauwmwszopuddf5g@52mkqbe2m27j>
 <aUt_1uDe05diks7b@hyeyoo>
 <z7d52kjvlzxohbly42flhtebqc7knfvilierrjr4r5776rxhgy@lcqmkcpzklse>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z7d52kjvlzxohbly42flhtebqc7knfvilierrjr4r5776rxhgy@lcqmkcpzklse>
X-ClientProxiedBy: SL2P216CA0201.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::23) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CYYPR10MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: a64eaa87-525b-4668-ab63-08de46a90280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OMl8Yvw2gUe7zTMGC+7oJYsL3CT4Igt+rMtColW3X4bQKNEWciq9yCUtNGgQ?=
 =?us-ascii?Q?JNYRrfYKHHfqKa4FvejhgBvkS4SVe35ExbkIUPuwBp5jGFgutDIBSTKUbs3Z?=
 =?us-ascii?Q?HsaciMWXM+sp5Z2V7ghBW9Elr9Cb3lwtVUr1721B+4rHZnBEqmbNBPrhKy0c?=
 =?us-ascii?Q?CrQXGwf0OlsykkAkXD2F0mn+9T21Xl+5S85QuiJ/eVVU4CwZyC48wlYgI6E/?=
 =?us-ascii?Q?o8gV1UwwXea3VCAHqoqnGvCkmHExwwkPgcibWmCNQ1rJTUVKg3/56QaUrJ9C?=
 =?us-ascii?Q?bgGgH8HZ51J0oA1jDxaaK3XmUbnpVLWEhLnMFGJqilrVr70E9f3VXVvGrsZu?=
 =?us-ascii?Q?MsubFb8ncUkM3PwtoY4K6rlU5hH3zbmkAkYs/sKY6X8kQWsRbzJv/DXwVZr5?=
 =?us-ascii?Q?+uo9x9AdGDJAcjxhfSzHCXZI/XumF7hE609oWrpx5PqXgDOeZxkquYTCfQcD?=
 =?us-ascii?Q?galb1FYLRVWbYJVm6/lSBkb5GSTqoS2W1A1F+yFKKjo9YlyHSSZWmgawR24P?=
 =?us-ascii?Q?qDRpBLSiQ5Ry7CVumxuYP6tGvN8lJ/XPoov3YPDg0DzKgRWEdp1PlheWZEd2?=
 =?us-ascii?Q?cWvObA9KRkUpVlz47J4KGs6m0oCr1FiZAT6ntRD2qRoKKeU17oCuTW1AKVY0?=
 =?us-ascii?Q?SXe2hLwPNn0i+05KmxIiGpm6tsNIroi9X+Y0PY7x4YJlMJCFWe/JPrd4gwnn?=
 =?us-ascii?Q?8dbpOaetQBxuXfska6po+RGpv54TDmrdS3Qlxi74hTzgw/VXdgJ+M8IDJYtA?=
 =?us-ascii?Q?Gpudmw/QeY7iO4CXljNH/EhFCMV767XypZWkWYNczkdMKzbR5z6aqPG4HfKJ?=
 =?us-ascii?Q?OL8EGytEI6F60LLSwG33p4CQ7b42N3R46/7SvESpnnS/CtoOuBXb0fqr3MXJ?=
 =?us-ascii?Q?T+B20i6dRiyOIOfJydgcHD/1bW1T84CClmvFq152Layt8YH3rHaOG5SUidqj?=
 =?us-ascii?Q?aX83lQvRYZIG4SL3XUnxWNkpRhaNbuwM7XOdPGol/unj1OEjWg8z0WvdvnO9?=
 =?us-ascii?Q?lXXOzTfm4+20nneg1MAXoPqZuRSVq/ozA2dZVGZ/+7avj5HBgtApcAGiqxVa?=
 =?us-ascii?Q?8vUYmmPdY5h9fBJbGUF07TIFuJSgkoq1wVzmqI2Si0AiGQKErCdzgg9N0Gbd?=
 =?us-ascii?Q?S4rKn9bJ3qse7GmjlOPd0bMfS0c+tNG+Ji2m8jSq3QUNZH14JxuPz+BFEuv2?=
 =?us-ascii?Q?AVr6Ff/i6k22vpD6GL5EEeMFOgzdKaBhfnieNJ6fFS4RIa/B2KmlztBO+t45?=
 =?us-ascii?Q?NeEke5GGQKeuk4PdpUuVHcoM8xU3bTZjDeuNVYGKh/Eh7L6Nuf2KX7oOpN4o?=
 =?us-ascii?Q?PBYefE0B4p5SAs9ytts7/Ww6U2bNkjwQQrU68UBIK/cfZ39bymn2MBIw2qPr?=
 =?us-ascii?Q?loSxoUSO0g1p1EDAoUDHXABqi11g7Ic3WU1bGOjJIZfykywzgqoBiZW+RM9b?=
 =?us-ascii?Q?eSrUpq0b81SJDzrC55jMy6y4+JVKoPB1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H5KqJMlcJ4tFkGCGtO1MtMu2KZh+iFP38KcVbqrxN/YpAXIChscsilaW14k5?=
 =?us-ascii?Q?QEgSJblf0tqx/ojI4CQuO8mtClmyglYDe9YVKKd1HZf8YMhYHcKAMlbd2nI5?=
 =?us-ascii?Q?uoCIL1l1hk85ZH0Da3Y2VaFVSy5Hi3WtN/B32aS2zj6d/RVYEw8aGJoedWBw?=
 =?us-ascii?Q?C1i8SVjN+TDRmzIT1oeUzjF9yVGYVCeGySqD6E/d9ZOwlEgLmmSwh3SkpEAy?=
 =?us-ascii?Q?qjABdyymHs/EatVJPVWcoEt8J7VmiP69bzf0LgnppUawuBYzmrtAolShRiUx?=
 =?us-ascii?Q?qKI78bl7J/spV5tuKT7g3itwolwn96YOTEbyfBer2hY7IoYqiA1pqrLR/xN+?=
 =?us-ascii?Q?dQX5CzID2if5h8/fH3ktFIKBAW/Kfi+KnsC/NhaqcIph2W2RxYB+KehVhogh?=
 =?us-ascii?Q?+HN/K9jWG14aZsKSw0QhytOrA0w4pFu8CtSHHZyV1/aLpJSONAZXj1mJkt8b?=
 =?us-ascii?Q?ZpoD2mze1WQu0IN/+AoDIciETf50YQSVYphpw+JTUTE86qf+6sN/NS12gHYo?=
 =?us-ascii?Q?vPFijX7+evv0dJ/J4i3HhDvuDd1S7eqSut3LQdnTmyaQocZtQUYD0YP94zRA?=
 =?us-ascii?Q?c7iPdNoI3E/R9xNEXnM9W82ynOmS/Qcc86bJtU64XXqq5Q4TEbXgr+++pLJn?=
 =?us-ascii?Q?BBLe1/SyHzZgO2rbqCSCMXgjRZJhrV0H3LfyDi4wi23I2n9uSENe/LamjaP4?=
 =?us-ascii?Q?XfIcfhoJNiwiimnmthKlpT6Dv4pDRnC4DHhkHRg6f7XHOdxFHl6j+wpz0apq?=
 =?us-ascii?Q?JDeCKyZCaTbkuRXFmSqgPOmWE8kAH4U3aLnFHPyPl+U4bbpCvlvEMJcf0ID/?=
 =?us-ascii?Q?eBfoizqWvYbKNQNEjSIs37BIpVlu51fZdIRBvzC1M0UvK/Fl2a7N+0TkrqgZ?=
 =?us-ascii?Q?9BwpO+d/8nZI+4FsTyEMozXx3BYv5OL+VMQ5zlMfIEr2hHGpNp8dkFlrVlcf?=
 =?us-ascii?Q?d5l4J2Nd3dpxELbWGW6hx/I+ZUoq8nxeEVCzLjweK5kdfM0/E6Ui2jkJYwn+?=
 =?us-ascii?Q?fR9jnF5TA6qbdzq9APOklNuCryQigo2Blc2RMMhmdF1xMZYHYx/mV70tE3Y4?=
 =?us-ascii?Q?yi639qQN4kcwwGrFS4BRUyg4V338RqVRG6RDsw+GabuBqOTcfcALVzujHBCn?=
 =?us-ascii?Q?q/EKuRCjcf0CKzzyPHMh7MvHSjB4H8z/4X2uHAMY2KQF0C9Piw0YkwYtydab?=
 =?us-ascii?Q?YHklPCelwyNZSr4sJsUT30ln21lAfzxhck3e1h1YKtz+h+wvWX7Gt33JtywN?=
 =?us-ascii?Q?3CF6b73k+fcm5sAHzL1RKDbfYQq/9SsU9B3gUSDHkA/bh/1M4zPpaLBV0w75?=
 =?us-ascii?Q?eD3PLFhyrUAUQpUmGFCjzqYR4KCxnhI3eqchlIjNLLngXITHqPTxie3UmgS3?=
 =?us-ascii?Q?sADssGdmkxKiqV9S+Kw5BtMtxTjhnOMjaKlylpRBHGiPaPC3XCArkM+F/mvJ?=
 =?us-ascii?Q?pBPiWVIkTXJmnft+aMX0Zcief+kUg+pZXva05cM1/IcntDPS6mUgdTXlB0Ui?=
 =?us-ascii?Q?wlQ7zr0X/WkRp9g53X6apHKM7VCy68lvxU0fvBf/km5OjmZk1JmccCqd6Oe5?=
 =?us-ascii?Q?cfnBho7ClTocwQLvQ+pgtcesRcE5sUHXTKoZVmCbYZg/i++5kD0Cri1NJIZW?=
 =?us-ascii?Q?xF8fES2W9Nc2qHkZgqxYrwT02YHN+LR61QXN8TKV4p1Hw2BR2OPsMYYI5dyw?=
 =?us-ascii?Q?c7a0ntGPUS+QzxJ98ueYzqdkZFXGgXucyGxBHohJzg1GMekFK+suVuEv9QSm?=
 =?us-ascii?Q?/Sc8+sn+FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sCPTx6ohC9zrVF2fnCE9u31O7pGvSmGITX5/ih/rbr8om80PXA1YU4XtkyM94sQjxqM5tqzJTy5ooYHKdIofEmHmfzXB957wuFRfd3Znac0kGi2Da+5e8doY/2WZBUn+jztc8WahSwDI7Mk7T4IE2JrYTDae7g4kitJhLifqUxp4E/AFDQCtHAs65lpGR0TAuayAQseh2I6y1gs+2Hw5YGKbT18Olipt0zZURcyl2n9BIm5hhiJqVZWX5dwmw/ShnKGqaGnA0zQFnM3CWzzDZUemnMwy5spNMYKLUhYtxs9SeE1ivfH9hRma9oXqy+wEh9nZl7QLW7A3CTy6LBx3PveHyrsN/wwRuP0O2d5i3LIC075RkgpwcccTPd5iMzi6eZ3WV6etuMsG65itfOorFodVuqRcQnBj3uQPOAEClNZAjHq69mvlZSP33eE1pHkk/SzXxux9NehCfbnlLVISTCqHhiuM942jshAt7zFmpK/GUu1m9vfoUWCRQfdzi48UFqVFxc9K64oXpH8yjrEd+sWfOS4Ozn2azP/49xzjmEMLW1ROD8ZdmkgoPFKK5aKOtu8QGh3gAcawOK75m3JBBte1TXN4LQ09n1wioIgvSRY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64eaa87-525b-4668-ab63-08de46a90280
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 07:08:04.1220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbLYDz+Sby05bDKBctT+NNougOLEUOwiwpKPPu1g7gHhOhWb++fLSFPSQoIvDHM7tJrZdVk5syIlFMjkKtGJSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_02,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512290064
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDA2MyBTYWx0ZWRfX9jSrKCsdaf2t
 5DlQOsEOP0puRb6H+pK9RPJCiQvXEfkuSqAVdXNZ0WMUrz5X7PgGBgljpdyQoAG/uIenKpw6vNd
 XQDAnu5w6wqHSDPBmlf8MFI3Zry9+xLRob0syY3gE5BH5o7+wQyWhC4BwyUHuPWjhQTXUVp/+Kb
 g8f6pBx+5OolZyKki1yxBz0MKYvCViLA3wdKIK3HJDlxNzXzEgOMq0naceWguLwiyesV3xqKnr/
 1yJ8AFXBn7J2IqRY3b4LFd27vqntOQakK/XxjNQ1JCy5i1VaanOpNCB2bzVoHO12gnjNF5f7n0N
 7+SYhTS4J2IE1RLvIUsFM+u4lG7YpJ9z711mV/3UyRgtXooM8PTDMyJz6jQQGX1ig7H/wq8Mf+8
 XChUTHaz/RS6nKx/s2z703fylzm7keOBYphZG3xuhBEyaK8mzorkwATCtmYJg+7MF4TtXQauD+p
 6usTen+8xTCryCdTBbw==
X-Authority-Analysis: v=2.4 cv=NMvYOk6g c=1 sm=1 tr=0 ts=695228da b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=oH9S-jMox6yfbUQrWcEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: bWHMbsMwY3_M34toyVDzPSNGkBrVvu6s
X-Proofpoint-ORIG-GUID: bWHMbsMwY3_M34toyVDzPSNGkBrVvu6s

On Wed, Dec 24, 2025 at 08:51:14PM +0800, Hao Li wrote:
> The comments above check_pad_bytes() document the field layout of a
> single object. Rewrite them to improve clarity and precision.
> 
> Also update an outdated comment in calculate_sizes().
> 
> Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Hao Li <hao.li@linux.dev>
> ---
> Hi Harry, this patch adds more detailed object layout documentation. Let
> me know if you have any comments.

Hi Hao, thanks for improving it!
It looks much clearer now.

few nits below.

> + * Object field layout:
> + *
> + * [Left redzone padding] (if SLAB_RED_ZONE)
> + *   - Field size: s->red_left_pad
> + *   - Filled with 0xbb (SLUB_RED_INACTIVE) for inactive objects and
> + *     0xcc (SLUB_RED_ACTIVE) for objects in use when SLAB_RED_ZONE.

nit: although it becomes clear after reading the Notes: section,
I would like to make it clear that object address starts here (after
the left redzone) and the left redzone is right before each object.

> + * [Object bytes]
> + *   - Field size: s->object_size
> + *   - Object payload bytes.
> + *   - If the freepointer may overlap the object, it is stored inside
> + *     the object (typically near the middle).
> + *   - Poisoning uses 0x6b (POISON_FREE) and the last byte is
> + *     0xa5 (POISON_END) when __OBJECT_POISON is enabled.
> + *
> + * [Word-align padding] (right redzone when SLAB_RED_ZONE is set)
> + *   - Field size: s->inuse - s->object_size
> + *   - If redzoning is enabled and ALIGN(size, sizeof(void *)) adds no
> + *     padding, explicitly extend by one word so the right redzone is
> + *     non-empty.
> + *   - Filled with 0xbb (SLUB_RED_INACTIVE) for inactive objects and
> + *     0xcc (SLUB_RED_ACTIVE) for objects in use when SLAB_RED_ZONE.
> + *
> + * [Metadata starts at object + s->inuse]
> + *   - A. freelist pointer (if freeptr_outside_object)
> + *   - B. alloc tracking (SLAB_STORE_USER)
> + *   - C. free tracking (SLAB_STORE_USER)
> + *   - D. original request size (SLAB_KMALLOC && SLAB_STORE_USER)
> + *   - E. KASAN metadata (if enabled)
> + *
> + * [Mandatory padding] (if CONFIG_SLUB_DEBUG && SLAB_RED_ZONE)
> + *   - One mandatory debug word to guarantee a minimum poisoned gap
> + *     between metadata and the next object, independent of alignment.
> + *   - Filled with 0x5a (POISON_INUSE) when SLAB_POISON is set.
>
> + * [Final alignment padding]
> + *   - Any bytes added by ALIGN(size, s->align) to reach s->size.
> + *   - Filled with 0x5a (POISON_INUSE) when SLAB_POISON is set.
> + *
> + * Notes:
> + * - Redzones are filled by init_object() with SLUB_RED_ACTIVE/INACTIVE.
> + * - Object contents are poisoned with POISON_FREE/END when __OBJECT_POISON.
> + * - The trailing padding is pre-filled with POISON_INUSE by
> + *   setup_slab_debug() when SLAB_POISON is set, and is validated by
> + *   check_pad_bytes().
> + * - The first object pointer is slab_address(slab) +
> + *   (s->red_left_pad if redzoning); subsequent objects are reached by
> + *   adding s->size each time.
> + *
> + * If slabcaches are merged then the object_size and inuse boundaries are
> + * mostly ignored. Therefore no slab options that rely on these boundaries
>   * may be used with merged slabcaches.

For the last paragraph, perhaps it'll be clearer to say:

  "If a slab cache flag relies on specific metadata to exist at a fixed
   offset, the flag must be included in SLAB_NEVER_MERGE to prevent
   merging. Otherwise, the cache would misbehave as s->object_size and
   s->inuse are adjusted during cache merging"

Otherwise looks great to me, so please feel free to add:
Acked-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

