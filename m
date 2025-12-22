Return-Path: <cgroups+bounces-12585-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C67CD5C3D
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 12:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40EA03037521
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 11:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792E5315D31;
	Mon, 22 Dec 2025 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="btKtn2iX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dupeM1A0"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A4C13777E;
	Mon, 22 Dec 2025 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401805; cv=fail; b=QIZXjDUaGPOs0YGo0PFBkgt5CJghSpYMf6pBDnXqPchWuXNBVTSYKmwVFipt5v9UAiSahTQNB0jERYaRYIZfDqM9+kGgKcHXdZkxWTdnzHoVtP8gony1Z8ZVlla6Rh7OBHo1wOlit22ZHvYoCUv/ulQzMiogZRnq39zK8iQc2fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401805; c=relaxed/simple;
	bh=jlj+RPj032T1qv1lutct2uFuYjEuo+PGjzQS6wjFu8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nhcXcG9ns7hWoOqYqZ1c+htaEQ3+WhMqh7gzgMHyYSgAMTvJXByBjbG2sqw0VJcocbE5Dk0Agko3yzxx2qBSSdvAIrrklGfMQ60zhKf47nP3k8skBFqVDKyYazxnPpPboveoGvb/RVayFoazOAPhULgGjtCOiTYAuefvu+eS47o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=btKtn2iX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dupeM1A0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMA3JMM2073891;
	Mon, 22 Dec 2025 11:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=w1LTaVCtL9+obgq0UEnAkXhGb4zJzer0+Q4yFCr1zxE=; b=
	btKtn2iXpuG7i76dAtjPcvQatTbG4R6hTpWxIGjH2yQGKm6wTSAcIJJaKDIZnQJT
	tSMQuqmU18YjKlLzkgU6ak1Jmf2KDfgqGYjFm+5a3yepnilUKkeYyl1rKZaZ2PWC
	OAl3i6TUOP1zPXm/tcReiKKX/oaQDIaASzRhBnA/3LpRyTba4bZhycaFt8bIXQ3k
	GqV3TFUb/avaQVHZHe2ICQOwdZdlOIoDEdfOOujefXoI/MNRnz8AfCcterJUWgYb
	Y5TySc9khU9TwGaj0yPEpQ82VvnbEzT8V2Pblb1DzBFiJtN7tBghs22RHbGi/IwU
	DVjUl0jNhU5T/i8ZheAffg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b73vvg286-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 11:09:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM9Vw5h032709;
	Mon, 22 Dec 2025 11:09:20 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013059.outbound.protection.outlook.com [40.93.196.59])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j876hyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 11:09:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxNmhJd69mLqkvo+hM8o7H/rm1aaHQw3Ri0ymsDJ+98aLCXY3oW9yVV8F0zkYV1PZWivG5SCMH/GQh+OVTAMe47R1Xlk9yOojzrrFHizWcEFeVfcetKEWmRbqB153IseSAtQM1m2VrH9Dyky/dQxVPq+xZF2kWnsMJRfmug2kMyKOJUIf7FoLlbdXooOwr4G92fAkBx0HpRfahS/VKMJZSORft4cIxCeHQjDItJoQtHOu8my620w3BzcLK4GdtEqR/wJFvMR/4qkVXGra3dCS1eU0dqBScdh4G/oCsKus2RZ0/eP1grE7n4sWpzG5p2S/Ovxd8VWiSwYb6CVIEUF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1LTaVCtL9+obgq0UEnAkXhGb4zJzer0+Q4yFCr1zxE=;
 b=Ve3Uo4Regc798IF65g+PgMu5i3NQMJvsdSenCj+cC8JCAh15NTyinTeL/1UXL9K+1s68PxDtCNXm/st0ZT+J7/BuoPlOOshpPr5G/7C/U1j9ne31sKwXKBgWSR1w/+SQpYWZOshVQOpiNsMcWEaStO/+kxIIow7DbFlDSBA+hZNUO63oyYP3F8u1AXSm2mUd60Ki/DU0w7TPVvmygKLY998N9PH3DrxfPR0ckyYTcqsuECz18VKiTAnxAtACe6xtxNXgRZrgZ6psVfld16cyiOyb7GTeHMTCZ6kMNEbUE3e7zHShnXrWCctrjlBwcvbW3mzRXnNsUJvy2QyJscv7bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1LTaVCtL9+obgq0UEnAkXhGb4zJzer0+Q4yFCr1zxE=;
 b=dupeM1A0yR3OVyDxhQ8yTLiIPMGsed6uPTMtCkNgJYIgeGVEpPMJFXJg7yXWVv6Skjp2aD/+2PbQRmnGT7ldPDKrJ8JqiGUV9/zYQaqrMM7JmIfrRGMS2Hni4PKBOAuK07Un2qtof3ReEHtBnmZfjnKLpL2jdN0h3AtYBEVicXM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4741.namprd10.prod.outlook.com (2603:10b6:510:3d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Mon, 22 Dec
 2025 11:09:11 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 11:09:11 +0000
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
Subject: [PATCH V4 4/8] mm/slab: abstract slabobj_ext access via new slab_obj_ext() helper
Date: Mon, 22 Dec 2025 20:08:39 +0900
Message-ID: <20251222110843.980347-5-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222110843.980347-1-harry.yoo@oracle.com>
References: <20251222110843.980347-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0141.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c8::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4741:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3ee74e-65c6-45be-9fd6-08de414a88bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UgTLtjo/gdLOtK02b9gGzwv2g8m31H/NVSzucNg+laofgRXJ1EH8NFxySr1p?=
 =?us-ascii?Q?6SqO86ZdEoD6KW1OLQ+TCEq+4k1VKusbVN5jcqr0AZ63T9fp+SbVBPW6mSu9?=
 =?us-ascii?Q?zNB1YhEdLS5psZtsOMJJIneMOg4tTN0RB0ie5Y5qO/g+h/Vcbbjprz/xFahr?=
 =?us-ascii?Q?iStkCJ3zrYWqj10iNm2GRxipTiJ6yg+0oyYxHUUHh3O7jdFqjDII4+LIZC8e?=
 =?us-ascii?Q?9DehdmMsWAn4hdwguZ713bKD1hSgLs2XFlaR1gYKd5Rt1jixTp3NIYKJuLGr?=
 =?us-ascii?Q?a52olsrdSNMX+I+SjFk/njuNEK4n4nUunmYy3X7ZTu2FO3BVaLv0+fEYImto?=
 =?us-ascii?Q?0ZVFTdg2JkyVn0H3CI2lX32Z8zRvGVBEHtOKJ3oBJCbG+tZIVsuCxN5US/x2?=
 =?us-ascii?Q?QzEbqpYIcwph1ePgta3s/a8cTJ5zZ8ubi6mkqLZao8EH8t+VB4hw1YyACfNb?=
 =?us-ascii?Q?8lGLcU9Y1BPqUUgREHcdNvKjCexqPZ7MCOpn3jtmd3IY8OdaVhFjJG9nmge8?=
 =?us-ascii?Q?AM+jAgI+C+qCTNYfavrfWQfGdGBOveFFmdy0BClJnucBp9ejoTAyIMOUx0xh?=
 =?us-ascii?Q?u/tCakz9+1o0QNSTvxqN3Olo7NImz6qizjS9g5kj6+kTtpKWza+lbmRyJl3k?=
 =?us-ascii?Q?2HI01gWMitO+7CrGii+sEYAUXLq6lloWLfwKrIWag/FG9z4CpLzOjVXMZcPk?=
 =?us-ascii?Q?j0SP/vFf+3lXjp1/FhC0zdFNRo8khsWHRKGOC22TLL9mIK2YGzdggTefu3Q3?=
 =?us-ascii?Q?axMgJpPdD74PUSPa2PQTx3r7wOdW9i/m3hHV9FGuWQnszxTMl8BXjpBCXIL+?=
 =?us-ascii?Q?VoHE25yguaPLFH2C5//PQCgQEYGF8NB7rCGnFCyT3hwVsAr5FgXkvtbeQSqi?=
 =?us-ascii?Q?LIHAymBSJ6KhFn7OJ8VZFkRg9zvXKlQMFyog7EMlV+zLWI4xKeSLUe+jBsy8?=
 =?us-ascii?Q?oOBWHMcOhEZzCtxAxsScZKOJl3B/PpfHsZylzNsgQD+G8fJcyoAlg07cE8Xi?=
 =?us-ascii?Q?be/BbfvlQRPgmynPX/jU4u/B4DftUxMmO7NqlCGFuPUeR/MlVW4JIu5zKXGY?=
 =?us-ascii?Q?tCbKgnFWUArb9rSu3JLJ0PHN64DWeZfXWzXKtZ8ifZ+GhamR1dJTmvYjKG5w?=
 =?us-ascii?Q?Lt/3A3n1Ofup4d+q81Lf5iznDGpN9qPxemjflDbUccY6dfLknbtLP7w7qZuq?=
 =?us-ascii?Q?vObQxsQXabYKi7A7ii75a5KKTAhcTUDwV9zja58eAIwQJiNN+FKEOK5rdgMW?=
 =?us-ascii?Q?ZIYq7hUyu4+9YKBtuWep9Da1YaoRrmLGSxvkXMXEoEKViH4Yy3zJWmAE8T5J?=
 =?us-ascii?Q?UWLxa9zQNVcLah3NWAFz/TZQBhznnsMjH18BEFeG1J4oahyDyRat/RDaYTQs?=
 =?us-ascii?Q?Jo0t37/It91UGH+/9EbFS+/go8Ex4pH5Icnkk2rkmox7jHd/8a9Qc+XXs0Mx?=
 =?us-ascii?Q?UeuxRRm58vSGdE98YuVoz6fUvwp9gx+p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+em4wA7QV/Yj7upH6nHAdlmyh0PCRxTsZtWNDKtbwYl3FR9SqNj2aMA4uaIv?=
 =?us-ascii?Q?/zl5f+GicORXqWwVk+dygkVb71Rl6mtEHISbWLGPYoMNDQ/ppXdbxrZdeDuw?=
 =?us-ascii?Q?WgY/+lL/tx3MpocSatrfEMtrJKtZU6KSnYYd+P6gdLDFtdYFdxoE1Bvig6rR?=
 =?us-ascii?Q?3Db7sVnBPbJuJEglOGP3zvpEaOPrGc7bGk06C7vVzBWlfQFzyNZjlTjbD6rh?=
 =?us-ascii?Q?ILIZm8M3l3IXg1+i/LCodQzn8rPaDyq9LeaP+4SOj3px6QqHdKZ5x1oAH0JN?=
 =?us-ascii?Q?LOMaipPhCWgPAW/0rUntsXzH7O3UAIM5x5McFg6fl1m8tKzxAj42xKmXFkIR?=
 =?us-ascii?Q?wmYA5+9Fa8TKJKnIvaiBVIbEZbq1Uj7cpbDuoYwZ/xzxMqE9KI9d3wawIs4h?=
 =?us-ascii?Q?K/4gyFxFnfBqx5qkSN/6kuECVnoPYfekyzinEi0PTwVvulzVzZ1zzwVAuJ03?=
 =?us-ascii?Q?rGNVhMzuzgIQdOlqYVtcARhppgvbJa5elD3fjo45q6ZkP52+L4rqCatO/MIg?=
 =?us-ascii?Q?klYSTF4bt2AzqcCA661zxLgy91DKoSTMLrBIdH9fjoXB2t2xVnUK+t2MxTco?=
 =?us-ascii?Q?HmvdRUGiP6QnzsW+7tbrd7x8cLu/LYl4VJ8QxMzur4FloMngpNLx1Lre5iEX?=
 =?us-ascii?Q?rDGBmBkpODl8cwyAFDqiQaPirL8Zndbmk0Nu2ZUvvGVgyUBhUNiMGOwZ/6EZ?=
 =?us-ascii?Q?pqPMgQokPDqTOkTEultKz+4l8OtZwrQoSrtcK0UCVOqOk7O+vb1ClboIYgTq?=
 =?us-ascii?Q?rxbdu+nF2RYKStajTBXHXTMfnLpoB6+ETkYQD3mCnKLcqDQoke8kRxu+5c0u?=
 =?us-ascii?Q?3PMAfhQQDiylVL4wKbuGE3ZMGP/9fOD14soF/pMoYnUkDSQWOysipHIVmCk5?=
 =?us-ascii?Q?RxQ/CzCosMJSlgCG4jy915kIsZ0+FJhKrH5Bg/tw32GUchHqz408tlzcRfYR?=
 =?us-ascii?Q?axzecKTTaYi6D/SAGkxGxSG0+7uljLI0TShA93WjGYFts/FcNSE5b3S+CWz1?=
 =?us-ascii?Q?HS/arixZPLU2DmJzFWURgT84/uM69ljqubUHz3gYRaYC+jU7dbqb6O5g7oKP?=
 =?us-ascii?Q?PCye92udeU7RzV0TWQ0Kkzjm77EBHjIS3Jzd4IFwFkyKf1ZD3Jqef7DM+ZW9?=
 =?us-ascii?Q?nERRMkdAuKPOG5g78ml9b5udkV6b83K2ioHz3NAWwi646vPeBFeC9QodhIII?=
 =?us-ascii?Q?8PGbMrstlwVlQNJ/IsbGgj/JR0jorjy2XF5hHPiKtbDEXZn+09on8A2/NBpC?=
 =?us-ascii?Q?yPCDdbbEIW9L0MHAil4smjNFNi0oNiYducyM0MIf+PEzYXRSHTkZDGKZjAdi?=
 =?us-ascii?Q?Uon3jhfBXemqnwlqVYnF1Pk6k04qjVouvn9zcWUd0sOW4D3bdL3vwiBdbK3x?=
 =?us-ascii?Q?TccF1JkRuGTqqO4Xrw6HRGBEGkKn3o4th0rBmFIzzzZ3+ulPZCemRCv4SZpa?=
 =?us-ascii?Q?6vgJn6ciwWknh/dGPFb8WJ57VlTUICHuXQkn/YSMzJVIHh4rdhoLl+7nZv1D?=
 =?us-ascii?Q?rEn7g8MfE+a8KAqvKzHIPtQKeqMa7PSXyRgUpAItJUpSNoJOAorqUGFuNvl3?=
 =?us-ascii?Q?JWYma4lj1+BLuRCpxEYFAZ6gWcAQgXX/B24VdIyGThXoz9Avyd20UkB6k9JF?=
 =?us-ascii?Q?WRdWep7iD/2l8B7cIEWwLELKZogfN1icDvvksyQR1g48rMpSdqosGFI2tZEB?=
 =?us-ascii?Q?/sGtlIG8iqLlxvQFL3ugfdnHCp1s8gRSvmK02GFmmQeviPzoPLr6pzcIdWSp?=
 =?us-ascii?Q?YVaaKtieBw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pNsavuIm3KLwrncmtUWbuSnVfgSoC0YPplIG5XFB8zPLGX++x/Wfz2XUQHKiY4xuxiJ4OIPGjZ6xLA9rrwqMNUJCQDW2Js0ZPy1oVCfKqUg5pf7IhMIlrJJEALEjkQIv1ugdDtwtHvJkhqFoxdxm+JqiXzBLckC7/iasBZ/LmLwimoh4Cijp47ptftyWe2xjG2982xvBneFGmRV/Bi+cheM4SfeISjUEwzXIMc0agkYF647VM/TTX/OguS5M2kKdSj8T0sNjjwhAmbbAziTyeFk2hLhU8PmJIS1gkfZ9q5KvWlByVa7D7H1NM4Z5IBfucD9/NuaM+DL+3bT7WbCoC1Yy/tZTK775BabJG0oRC+A4u+RaON/9qn/VHbVyNqDXno8bgUqBEzHcZTtNx/Nc6Yfr4uzFN6rpp/4tz0DB6/eq39EsH8NYJrtHu1eCiePu9k+n2Q44z3OsfJD78SBJiqfmWulFA/vFfg/UPo18RvEQ8ftcqmLOzjXiY5DK9D+w4jxYN55xyEh8LwDbbBUnMr5USWQ5bXXzUHHVPpC280UJSeeK1DUFjLqOXnzh2ahnYR5g/uB/CQdZC/bvqffAXFYodGCQbFxalUO3pGS96KI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3ee74e-65c6-45be-9fd6-08de414a88bd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 11:09:11.3436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGcnl1+/Blm15sDdwRr7ZFWjzng5J5RvU5hviXqg75p6TzpZ8icrX97SW/LIi8o3Ba5i8ZE8cejhF/cMEoDNsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512220101
X-Authority-Analysis: v=2.4 cv=VeX6/Vp9 c=1 sm=1 tr=0 ts=694926e1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=hqUfzwhSJLVLa33He1QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEwMSBTYWx0ZWRfX/hDYOloRmF5v
 650WTF5WbHzTTFnurGBV2hhIP4mokfPRRIvabXCtw6YBE5s7dmLSIvZto/zxDv36njXceiNm/Cb
 2KFw67P1r/e8hciuvs9VTVxi95an/45NZE60q56PMhSIhGUo20kAQC9/OlMmRnBAYilhfPKfmVw
 wf4OJCrksbq5jANcF6ogVJNNx/1G4qxqzv55GG/BNgDyaCSERQ9yNsx2XrZug2q5TnKpZX01n9T
 j/nTYhNhzSbp1UoyZLPATmBJ5GQ6+Mca3NxyUZb06hz0RIC33obfn/oJredu2tSKnCCG4FglnuW
 4nRixPBjv8M6FjIDW1K/iB2Ipx7NnQGHSmwkX/40hW9htnRKsUcdZSGkI2M+4YYs17QBdR1WOcl
 hj7/5XQtuXL2/eftrqvHjSmrOhLWrlZcLRZXSpiBw7OiSNsRbYzZz1GKMy0fD9sk2joTspLHmlf
 zEHdDFT8fgIUuVVYmRA==
X-Proofpoint-GUID: aOTvmqkXcQnhHCfDvgnIL_De-boz4eor
X-Proofpoint-ORIG-GUID: aOTvmqkXcQnhHCfDvgnIL_De-boz4eor

Currently, the slab allocator assumes that slab->obj_exts is a pointer
to an array of struct slabobj_ext objects. However, to support storage
methods where struct slabobj_ext is embedded within objects, the slab
allocator should not make this assumption. Instead of directly
dereferencing the slabobj_exts array, abstract access to
struct slabobj_ext via helper functions.

Introduce a new API slabobj_ext metadata access:

  slab_obj_ext(slab, obj_exts, index) - returns the pointer to
  struct slabobj_ext element at the given index.

Directly dereferencing the return value of slab_obj_exts() is no longer
allowed. Instead, slab_obj_ext() must always be used to access
individual struct slabobj_ext objects.

Convert all users to use these APIs.
No functional changes intended.

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/memcontrol.c | 23 +++++++++++++++-------
 mm/slab.h       | 43 +++++++++++++++++++++++++++++++++++------
 mm/slub.c       | 51 ++++++++++++++++++++++++++++---------------------
 3 files changed, 82 insertions(+), 35 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index be810c1fbfc3..fd9105a953b0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2596,7 +2596,8 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
 	 * Memcg membership data for each individual object is saved in
 	 * slab->obj_exts.
 	 */
-	struct slabobj_ext *obj_exts;
+	unsigned long obj_exts;
+	struct slabobj_ext *obj_ext;
 	unsigned int off;
 
 	obj_exts = slab_obj_exts(slab);
@@ -2604,8 +2605,9 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
 		return NULL;
 
 	off = obj_to_index(slab->slab_cache, slab, p);
-	if (obj_exts[off].objcg)
-		return obj_cgroup_memcg(obj_exts[off].objcg);
+	obj_ext = slab_obj_ext(slab, obj_exts, off);
+	if (obj_ext->objcg)
+		return obj_cgroup_memcg(obj_ext->objcg);
 
 	return NULL;
 }
@@ -3191,6 +3193,9 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 	}
 
 	for (i = 0; i < size; i++) {
+		unsigned long obj_exts;
+		struct slabobj_ext *obj_ext;
+
 		slab = virt_to_slab(p[i]);
 
 		if (!slab_obj_exts(slab) &&
@@ -3213,29 +3218,33 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 					slab_pgdat(slab), cache_vmstat_idx(s)))
 			return false;
 
+		obj_exts = slab_obj_exts(slab);
 		off = obj_to_index(s, slab, p[i]);
+		obj_ext = slab_obj_ext(slab, obj_exts, off);
 		obj_cgroup_get(objcg);
-		slab_obj_exts(slab)[off].objcg = objcg;
+		obj_ext->objcg = objcg;
 	}
 
 	return true;
 }
 
 void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-			    void **p, int objects, struct slabobj_ext *obj_exts)
+			    void **p, int objects, unsigned long obj_exts)
 {
 	size_t obj_size = obj_full_size(s);
 
 	for (int i = 0; i < objects; i++) {
 		struct obj_cgroup *objcg;
+		struct slabobj_ext *obj_ext;
 		unsigned int off;
 
 		off = obj_to_index(s, slab, p[i]);
-		objcg = obj_exts[off].objcg;
+		obj_ext = slab_obj_ext(slab, obj_exts, off);
+		objcg = obj_ext->objcg;
 		if (!objcg)
 			continue;
 
-		obj_exts[off].objcg = NULL;
+		obj_ext->objcg = NULL;
 		refill_obj_stock(objcg, obj_size, true, -obj_size,
 				 slab_pgdat(slab), cache_vmstat_idx(s));
 		obj_cgroup_put(objcg);
diff --git a/mm/slab.h b/mm/slab.h
index e767aa7e91b0..5c75ef3d1823 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -509,10 +509,12 @@ static inline bool slab_in_kunit_test(void) { return false; }
  * associated with a slab.
  * @slab: a pointer to the slab struct
  *
- * Returns a pointer to the object extension vector associated with the slab,
- * or NULL if no such vector has been associated yet.
+ * Returns the address of the object extension vector associated with the slab,
+ * or zero if no such vector has been associated yet.
+ * Do not dereference the return value directly; use slab_obj_ext() to access
+ * its elements.
  */
-static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
+static inline unsigned long slab_obj_exts(struct slab *slab)
 {
 	unsigned long obj_exts = READ_ONCE(slab->obj_exts);
 
@@ -525,7 +527,30 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 		       obj_exts != OBJEXTS_ALLOC_FAIL, slab_page(slab));
 	VM_BUG_ON_PAGE(obj_exts & MEMCG_DATA_KMEM, slab_page(slab));
 #endif
-	return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
+
+	return obj_exts & ~OBJEXTS_FLAGS_MASK;
+}
+
+/*
+ * slab_obj_ext - get the pointer to the slab object extension metadata
+ * associated with an object in a slab.
+ * @slab: a pointer to the slab struct
+ * @obj_exts: a pointer to the object extension vector
+ * @index: an index of the object
+ *
+ * Returns a pointer to the object extension associated with the object.
+ */
+static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
+					       unsigned long obj_exts,
+					       unsigned int index)
+{
+	struct slabobj_ext *obj_ext;
+
+	VM_WARN_ON_ONCE(!slab_obj_exts(slab));
+	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
+
+	obj_ext = (struct slabobj_ext *)obj_exts;
+	return &obj_ext[index];
 }
 
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
@@ -533,7 +558,13 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 
 #else /* CONFIG_SLAB_OBJ_EXT */
 
-static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
+static inline unsigned long slab_obj_exts(struct slab *slab)
+{
+	return false;
+}
+
+static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
+					       unsigned int index)
 {
 	return NULL;
 }
@@ -550,7 +581,7 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
 bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 				  gfp_t flags, size_t size, void **p);
 void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-			    void **p, int objects, struct slabobj_ext *obj_exts);
+			    void **p, int objects, unsigned long obj_exts);
 #endif
 
 void kvfree_rcu_cb(struct rcu_head *head);
diff --git a/mm/slub.c b/mm/slub.c
index 0e32f6420a8a..84bd4f23dc4a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2042,7 +2042,7 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 
 static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 {
-	struct slabobj_ext *slab_exts;
+	unsigned long slab_exts;
 	struct slab *obj_exts_slab;
 
 	obj_exts_slab = virt_to_slab(obj_exts);
@@ -2050,13 +2050,15 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 	if (slab_exts) {
 		unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
 						 obj_exts_slab, obj_exts);
+		struct slabobj_ext *ext = slab_obj_ext(obj_exts_slab,
+						       slab_exts, offs);
 
-		if (unlikely(is_codetag_empty(&slab_exts[offs].ref)))
+		if (unlikely(is_codetag_empty(ext->ref)))
 			return;
 
 		/* codetag should be NULL here */
-		WARN_ON(slab_exts[offs].ref.ct);
-		set_codetag_empty(&slab_exts[offs].ref);
+		WARN_ON(ext->ref.ct);
+		set_codetag_empty(&ext->ref);
 	}
 }
 
@@ -2176,7 +2178,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 
 static inline void free_slab_obj_exts(struct slab *slab)
 {
-	struct slabobj_ext *obj_exts;
+	unsigned long obj_exts;
 
 	obj_exts = slab_obj_exts(slab);
 	if (!obj_exts) {
@@ -2196,11 +2198,11 @@ static inline void free_slab_obj_exts(struct slab *slab)
 	 * NULL, therefore replace NULL with CODETAG_EMPTY to indicate that
 	 * the extension for obj_exts is expected to be NULL.
 	 */
-	mark_objexts_empty(obj_exts);
+	mark_objexts_empty((struct slabobj_ext *)obj_exts);
 	if (unlikely(READ_ONCE(slab->obj_exts) & OBJEXTS_NOSPIN_ALLOC))
-		kfree_nolock(obj_exts);
+		kfree_nolock((void *)obj_exts);
 	else
-		kfree(obj_exts);
+		kfree((void *)obj_exts);
 	slab->obj_exts = 0;
 }
 
@@ -2225,26 +2227,29 @@ static inline void free_slab_obj_exts(struct slab *slab)
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
 static inline struct slabobj_ext *
-prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
+prepare_slab_obj_ext_hook(struct kmem_cache *s, gfp_t flags, void *p)
 {
 	struct slab *slab;
+	unsigned long obj_exts;
 
 	slab = virt_to_slab(p);
-	if (!slab_obj_exts(slab) &&
+	obj_exts = slab_obj_exts(slab);
+	if (!obj_exts &&
 	    alloc_slab_obj_exts(slab, s, flags, false)) {
 		pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
 			     __func__, s->name);
 		return NULL;
 	}
 
-	return slab_obj_exts(slab) + obj_to_index(s, slab, p);
+	obj_exts = slab_obj_exts(slab);
+	return slab_obj_ext(slab, obj_exts, obj_to_index(s, slab, p));
 }
 
 /* Should be called only if mem_alloc_profiling_enabled() */
 static noinline void
 __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 {
-	struct slabobj_ext *obj_exts;
+	struct slabobj_ext *obj_ext;
 
 	if (!object)
 		return;
@@ -2255,14 +2260,14 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 	if (flags & __GFP_NO_OBJ_EXT)
 		return;
 
-	obj_exts = prepare_slab_obj_exts_hook(s, flags, object);
+	obj_ext = prepare_slab_obj_ext_hook(s, flags, object);
 	/*
 	 * Currently obj_exts is used only for allocation profiling.
 	 * If other users appear then mem_alloc_profiling_enabled()
 	 * check should be added before alloc_tag_add().
 	 */
-	if (likely(obj_exts))
-		alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
+	if (likely(obj_ext))
+		alloc_tag_add(&obj_ext->ref, current->alloc_tag, s->size);
 	else
 		alloc_tag_set_inaccurate(current->alloc_tag);
 }
@@ -2279,8 +2284,8 @@ static noinline void
 __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 			       int objects)
 {
-	struct slabobj_ext *obj_exts;
 	int i;
+	unsigned long obj_exts;
 
 	/* slab->obj_exts might not be NULL if it was created for MEMCG accounting. */
 	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
@@ -2293,7 +2298,7 @@ __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p
 	for (i = 0; i < objects; i++) {
 		unsigned int off = obj_to_index(s, slab, p[i]);
 
-		alloc_tag_sub(&obj_exts[off].ref, s->size);
+		alloc_tag_sub(&slab_obj_ext(slab, obj_exts, off)->ref, s->size);
 	}
 }
 
@@ -2352,7 +2357,7 @@ static __fastpath_inline
 void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 			  int objects)
 {
-	struct slabobj_ext *obj_exts;
+	unsigned long obj_exts;
 
 	if (!memcg_kmem_online())
 		return;
@@ -2367,7 +2372,8 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 static __fastpath_inline
 bool memcg_slab_post_charge(void *p, gfp_t flags)
 {
-	struct slabobj_ext *slab_exts;
+	unsigned long obj_exts;
+	struct slabobj_ext *obj_ext;
 	struct kmem_cache *s;
 	struct page *page;
 	struct slab *slab;
@@ -2408,10 +2414,11 @@ bool memcg_slab_post_charge(void *p, gfp_t flags)
 		return true;
 
 	/* Ignore already charged objects. */
-	slab_exts = slab_obj_exts(slab);
-	if (slab_exts) {
+	obj_exts = slab_obj_exts(slab);
+	if (obj_exts) {
 		off = obj_to_index(s, slab, p);
-		if (unlikely(slab_exts[off].objcg))
+		obj_ext = slab_obj_ext(slab, obj_exts, off);
+		if (unlikely(obj_ext->objcg))
 			return true;
 	}
 
-- 
2.43.0


