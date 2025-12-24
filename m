Return-Path: <cgroups+bounces-12639-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6348CDB881
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 07:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42674300EE5F
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 06:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E918311C1B;
	Wed, 24 Dec 2025 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P2QYuozv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pRRAoRsX"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FC82147E5;
	Wed, 24 Dec 2025 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766558390; cv=fail; b=tqQkX4rdRqVX2kMsB6ZP3UC1XaIHpXjvfsIdhnoxQP06jAAZAxG33ZQnbPMBzwDK5zVFmT31YE0M2fBWRFIEvnGW53qI34lkjHIqEF5RL+Q4jJp3zd3gr4izWhAwp/E2MVXC/hdGYfEA13yzqdbUcTR4JLO15pduoQuDp4kWWoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766558390; c=relaxed/simple;
	bh=LgdHKC4typWLKaDnZ90xqaF7p+xuXuD83sHC0gurums=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LbCVRFETsC5nYY+LpJ0xm3QGSvIhBPAgAdC+GBcM+FUAK19d28KnpW3mQRaW/1rJK0Uys17Za1ttB2KrggkKu4uepAk/6lbJ9CYUS7U46aG7HO0lEPWYIVUTxVSlaaXG0Hwbozlx5wyzg0lGUiqPTFGzdlZU4VpNoBMX/cP+O6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P2QYuozv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pRRAoRsX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BO3IcKt2167892;
	Wed, 24 Dec 2025 06:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=E1+AiXHLom/JkiZD0IKnPFknWaRABFoJBGK9uXkTdtE=; b=
	P2QYuozv5yieNuJvONhEaZh6gkePG8TtORjcaO+4Ij8omi4kBQqfwEcP848ASRkS
	Ll6ENE9F4MAZC4Lmi/MvF3Pme3Jh+7hBIserQUnFBocG7PAtAy++VOiImQAVaaL1
	bFyafTEfE+9sgBflXRssaEml+139MfkQDsOt266IfTwacdmysb+wrIq+X/BVRJ43
	ymDpwAvjdzPeD1VLWgrqsGGjlSsVxwg59qyYuHjyHN13B2iobmGMsrm2c9uz9BGf
	OrGoU2lGVmObGr6j0FgtJz35P7/7a3M8DxSqKlj5q6sPyJCoOK28sowqxL5y0pHA
	3qSfRBHONsKh1EpxXCcD2w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b885203vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Dec 2025 06:39:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BO62dCD002402;
	Wed, 24 Dec 2025 06:39:11 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012004.outbound.protection.outlook.com [52.101.53.4])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j895hbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Dec 2025 06:39:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJd5PbBR0pby7/oq0APOT6g+1m1xfSPi1Os8EV7Zx+tFekPrMM/YKNzmhCGvxw8eHPljFJTi+uTOm8vL+Fgjt+P5lg9YFfJ0nMdQur3EtWWy1VpVVfXgdsbQQuwhTqZls4rzDaqoaAF/OHVNIz3OnwVQ+iPYtNbX6H2WEBteZCwyzMpAEcuvmYB5WaI/P33IDoplDuyb3V4df12I2IhaE/RqKzkPZA2fbveqgPwKVd5jIK3mNSCIyUOxrMbD8tA/JATbIyPhNoqTwajoiNAMWoaVvOnYcxEGiMCsNvIIdKALCHQS9pMe5T+7QBz1YBh/PwzNVRtFS9nr2GiA+ZexDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1+AiXHLom/JkiZD0IKnPFknWaRABFoJBGK9uXkTdtE=;
 b=xs2TqtSiaow0jJVIy6SO/HBieWtK1cG4zUIs6yFgSvN4aZn/tTqZYkOc9iOhqDfXfKDF/61K3sk4eob1VXmL3Ki4N4cOWHkfbw1vs0OlhPoUn9hMJJskrebAlBZ4jlTRt/OSt3LjTRIzD7HRR0jP1VCfjwZMaGyARuRBq4qr74z9NjA/m0p/TAPIwPH0ngkqT+f3E8/6KZI4Bl9tsLA5dzV6XhvPWa8WMb4K43nn6QW+bD6YNWJ/8AMtOaH5taSpGwWgGTtrzAhMpUIaOPeWeJqOBOwNYf4xcInctj6ALooN1gENO5hs90UWM0HeKKGvkQBnOlwsdEk02vV2rn0v9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1+AiXHLom/JkiZD0IKnPFknWaRABFoJBGK9uXkTdtE=;
 b=pRRAoRsXuoeFdFlH07+s9Mj1Ib698zIeMMnFQyVlJXTq8gGU8NRF/tHEdexWDNZkDSmxyksfAOXIB9mqxa8P5rlnBBEVOPk9fSz1FQ1vv7zoEN7W/mBqF19I6gTER7B2M4DtsTx34neTdh+W8+ANChFCDILDA72dxtkmGADFulg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4456.namprd10.prod.outlook.com (2603:10b6:510:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 06:39:08 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 06:39:07 +0000
Date: Wed, 24 Dec 2025 15:38:57 +0900
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
Subject: Re: [PATCH V4 8/8] mm/slab: place slabobj_ext metadata in unused
 space within s->size
Message-ID: <aUuKgRlI60Hw3-Et@hyeyoo>
References: <20251222110843.980347-1-harry.yoo@oracle.com>
 <20251222110843.980347-9-harry.yoo@oracle.com>
 <l2xww4mysued3fjc2jzzy6cjrq5guygsxesmfqrhv2laxigpaq@ghj7xitfq7fh>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <l2xww4mysued3fjc2jzzy6cjrq5guygsxesmfqrhv2laxigpaq@ghj7xitfq7fh>
X-ClientProxiedBy: SEWP216CA0062.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2b06ec-4ad3-4fa6-1ae0-08de42b72386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDZtK2NvUXlsUVlCTU5sMTNVdzBoalArWUY5NFNabTM5eWVTdHEvZmZmSk9Y?=
 =?utf-8?B?Z3gyYWVlbVdyNTRJTm12RXd6aXZDRDlMTWxxdlNNSDZ4UTVWckxXOUxndjd4?=
 =?utf-8?B?TE9QS0kwT3BMcU9WR0l4RU5WQk1vRGNxTkcxWnV0Q1lKTzRqMW5HS0hnWFF6?=
 =?utf-8?B?ZTdJLzdMbkhsSmY4WDR6ckY5dHA4QmliRGdVbFV2YTFmUGE2WWdwV1hNajlP?=
 =?utf-8?B?UjlMUDBpcmZrVjZBYkdJbU43MVlVRzNKdHd1UVNTQVFDb1JGWWJVSVJsWWZB?=
 =?utf-8?B?SXhzcDNOWmgwVTd5d2hWVFlESE4wYk9mQlNuQmx5TWhyMTV3ZlhFbkVwNFRV?=
 =?utf-8?B?U09qM2doN0tBUWxaYlZGbnhTOEE2UUdPQ1lHbHRQWHN0amNBeU9DbWx3Z0xs?=
 =?utf-8?B?eVdTZVVRU29WKzBrVkVWRG9tbmVEWnJHRmt3U2hTZ2F1VmtsVXYzM0t1d0pX?=
 =?utf-8?B?SXBmWFNLYWlRbWJnNGhDNmVwVnYrOVI3aFFWa2FpV2pSb2o5dCtmekZGWWJM?=
 =?utf-8?B?M0VueWJUS2RZaTN6UEE4aWtPZHpwSzdtcXJwb2dmSjhhU2c2RWJudnRhMlhK?=
 =?utf-8?B?SGRLRVpKbnJSM2dJLzgzUjR6OE1LMUJzdmJVSEppbmVDNTR3SVdtVk5wSDVo?=
 =?utf-8?B?bWgwVE56a2d5RFVjNmJyMUZrYm5zZzFIZ3ZxalZPaTVMSWc3UmxwLytjSHVh?=
 =?utf-8?B?VmZzS1ROcUdwT0FvWTJHQUFpbCtEZU1IbDJlc3g0TVBVRzR5OSs2d2N5cWdz?=
 =?utf-8?B?dytHemJXV0RJRktZdFNqNVNKZWkzV0lwYlBDVVQwZSt3eWVpZFN4dUpXbmlq?=
 =?utf-8?B?RnRzV0V3L2lZZUNhaHM4bjhBZFd3K1poNjMyVXk1b25LdjhpZ3B2TWd2RlR4?=
 =?utf-8?B?dUNIb21kUzV1RzdtWEkvSkNtbytBTEpNTXJVR2c4ZlB2cnlrKzlXdWZNajNE?=
 =?utf-8?B?Vlk3TWgyV213WGVQbzRDTnhhbG5mVXM0V1czZHBrQ2RsT3ZPZlZWWndlQTBT?=
 =?utf-8?B?WXVGVldVWW8xeDV4dDFaL0M4cGJPYVBrR3BNUEpvMlpzdWZ2OGlaMEJOQ2lT?=
 =?utf-8?B?WGltSnRhajAwOSsxaVJZMUxVTU9zMVk5NlY0TDl2UC9XdVdFUEprN2UzN1J1?=
 =?utf-8?B?RGxIQm9zWWpXbUZDemlvd3NvSTBkQi9tUmt2R2tibEQ2Z2lsVlBWSUF3QThK?=
 =?utf-8?B?d1kwcjVkSlJhbS9mUzh2RW9haTlxeFBOTm1OMkpQdEUrZTdFSWIxSzZxbjR3?=
 =?utf-8?B?OGVzblFxNWlaNm9Jdk9KQ0lKeEFZaVp0Z25HRGp3L2hJeDlOK3l2MU1aRjFT?=
 =?utf-8?B?Mkt5dGg3dy8xTHVlVkJodTh6TlY4ZU5mTUkwRVNCY1d5U2NDb2xJSGNYTkYw?=
 =?utf-8?B?WWtoaDhHVG1LS0IvQiswSWJ6bG9CL1pheUsyc2dGS3FzbktpTUo2eXdxSkNG?=
 =?utf-8?B?ZlVJVk52d21aenN5cDl5ejloNVFOZ1JuMGdzVnpSWVJZYmxRazFHS1oxandk?=
 =?utf-8?B?eTQya2VYazZKVWNmQmw1VHpZK1dQeWVBT3E3V01PSFVLcmVIL25OUE5HZm5l?=
 =?utf-8?B?WG5HZW1vOHY5eXJLMStHMVVkOVN0Zjh2QWVrUGpTaWJKaFMwdkNPa2xwWkxS?=
 =?utf-8?B?RjBkMmVxMG9DUmdQQzZqYjhVNnZWTGJRSmg4MU40Q1I5cGJyU1pmVVlHRnJt?=
 =?utf-8?B?U0Nyc3VoWkVmWnlmZW9ZUXFRTDlFcGtuOTJWV3VRb1RKRHNYRG05eVZJNExR?=
 =?utf-8?B?L05nb3A0QUpWenhxNVFjV3Mybmc0elZJbS84UGp2MG1ac0h6SmZIZkdXRkNU?=
 =?utf-8?B?bG1SNGdqUDJVVjNEbzVJdjYzMm1RQmExbzMrUTJqbTE5WTFuVytFV09Nb1Vr?=
 =?utf-8?B?ZUwzalM3YXY4ZzdSUHR0UE1DRGJtRzIwVFVBZkkrOEVBRkJnOUNHM2R6Zlpv?=
 =?utf-8?Q?BAI300A05rif3GA9EMO11fpfGY1PZj+x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d21jUkFUbHV2dDliU1ljQ1V2UWdpeGhxVkFVbW1KeGVuUU1QUkl4Zm55U3d3?=
 =?utf-8?B?VzhPMXdoK2F1NDFaTEJ4TDYvNjRyeXhHVEtSUDFxdzYwaHBhMmhXeEJhQ1Mx?=
 =?utf-8?B?a3IzYTF1UUlkRE1PUW1CZ3UyTXRFdXo0T1Q4aFpJQmZCQkxFdTR5YyticndZ?=
 =?utf-8?B?T3ZBT3BiM0U5UkRhQVkrNWI1anZ6UGRhTlVVMFB5TjVuQkYrckZGVTFZV2V6?=
 =?utf-8?B?bGNKM0JnMXRiV3hlOXMwcHVnWFB0bHAwUDEzZWdIVjB6WlhvTUgyenlDamdn?=
 =?utf-8?B?LzhNZDF1S2NsRVdvUHJJQlM0M05TZCtMMGpnY2NJNU5WS20relpXbWo4dEJ6?=
 =?utf-8?B?Vk8xM3V5d0F5Q3I1YWdUUzZLM0xjVTIzVmIzczdBM3EvUzRERUV6SGtzeEtT?=
 =?utf-8?B?Rk9vbWptcTJkVDdidU9ZRlh0SWFmMHJ2K1FNa0NXSW5FZENNK2h1a3FMRTVF?=
 =?utf-8?B?dmJHaVNWMnJFZTdCWkFxTWx2RHN6cmU5WTZaSjF1NXhycWNXRzBjM2dXdTlL?=
 =?utf-8?B?RGxnZDRNaWtLUDRhK3VuRzNVeHJEL2psT25rTzVXb2VmcG5teU9weGxwY1pY?=
 =?utf-8?B?ZExhVUMyTFJjUThOZCtkRUdtQmZWcjNFaTZUQnhKOURRb1FuRWpyVjFyR3ZN?=
 =?utf-8?B?MEVIMUJWam9DL0NFdm8ydWtHZEx6QkszTmdsYlNkd0hDWXVNSThpK1VlMzRt?=
 =?utf-8?B?RHA4WlZPR29oM1JCUUdRYUxjQWtFYVY2S1cyQldNdmh1SHRuZmlxRnY3UkdZ?=
 =?utf-8?B?ZENmT2NwNnBFdkpvVExMT3U0Z2hkKzdmWVFKREVxR1VkWnQ0Z2pDT1QyWDBv?=
 =?utf-8?B?SGZMVHFCMVZZWHRQUnd4SGtNUmxGMGMzRElSbFEySUZ2RllGY2hhV3lha2x5?=
 =?utf-8?B?VEdIVmtxY2l5SElrVUx0ZnhFellIeXpJaGZicXAxeldTVE5RYm9YSG11Z0tv?=
 =?utf-8?B?ekExVTBJMGdRVUpHTWxZQ1NCa0NROHNaNzhTNDJaQkNrTTZpai8rYTF5a2xV?=
 =?utf-8?B?QUh6enA1eW5JZlZWTnM1UFlKemYvVjh5amdvY3RHZFdKRVFUYVoxbU0zVGJu?=
 =?utf-8?B?STNhKzg2akRSSFoxYkJ3cXU2VlpjeThoUEIxTmk2dXYrMDNqak5RbVVTenl1?=
 =?utf-8?B?VC9VUTAwY21RVmNWdnRWL01takp5ck0vWkxFUll5S0lIeE50eDlyUkxaOUFJ?=
 =?utf-8?B?T0E5TGsrWnlEV3dOdTA0Q0RiTXdGRGJJbEppdFJQRVMzRG1kZ2xZalRxQTZL?=
 =?utf-8?B?bUdaQUNSYWQ3Z2ZSZlBEWFVLcHdlMWdiUlNlTjNZUzgrNFg5QWI4OHdRNko5?=
 =?utf-8?B?M1BITEY4dXUveE1vU2hET1Q5YXBBeG1hdmdHMnRUakZ5NUJXbFhaOWFZRUpP?=
 =?utf-8?B?bHNIMlpyd29Db0ZLMFZmVlRMbERTbXpiOTdnbFB2Vmh1SFdtTUtjWFNtRFJS?=
 =?utf-8?B?YVZRT2RFaDE0cXovT1ZDN0d0dzExUDlkUnI3SVIwaWsxUEdlU3M3dHp2MmpE?=
 =?utf-8?B?UjdpS1NqeE00MVhuc2tFYi9wT0dTNWxPYWlFdGV2TGdmL3ErSWNONEZzVVVt?=
 =?utf-8?B?Y0tyT2I4bHQrNkx5eC95UEp1V2tPU2xtc0FRVzdlVTU5dmt6MXZ1R0FSM09V?=
 =?utf-8?B?ZGdGMEtXcVRSaE91WEpiQkgybllHcGZ4eGRyOVlLMU41TW5kenltL21tRjln?=
 =?utf-8?B?NFZmK2RvUG9wOGlYa283NGc1TEZTZk5vTjlTaW4yM0d5endMK2lXekVJa1pI?=
 =?utf-8?B?MFpLVGdIN2djVkVGdkJWMk15WTE4azdFMlZCTEJ5TmlXVjdvK0Y2UzZaRkh3?=
 =?utf-8?B?c1VPTm5xdnJnT0Joa3NxdVN6ME1MS1lrTHFUMXpkc2wrZlU4OTRWNTU1em1U?=
 =?utf-8?B?TDRFU1FGMEdZU2IrTG5FamNzSXpSRU5qbmJZWTZLbFNIVjhtcGw2UFJ3L1ds?=
 =?utf-8?B?Z1NQYVJ3TkZsNnl6WmRLMXNzbHhaNEFkZ2dQNW50eGpUbzgwaUF5YnZGbGtz?=
 =?utf-8?B?dXZiVGxPdjBsc0JFWFlqRjNXSXlZWWwyTGh4THd5eXpiSEZMazBSNnhPYkU2?=
 =?utf-8?B?R3hpUVl5T3B1U0VpSTFxU3I0V3kzNmd4SjhUUVBqRHB5a0tFVHNwQWJnaFFS?=
 =?utf-8?B?VWtvdmpsNCtRTHdheVh1Z3loaklZN3pPY2wvZWl2ekpCbFVNenNXem9YWFdU?=
 =?utf-8?B?ejhLY0NDMyt2NXZzNVhYeDFIdm1zT3FZTHRJTjdpNTFNeFh6RUhXbnNUOUg0?=
 =?utf-8?B?UkM3b0ZndE83cFZYTU5EVVplY1NFN2FmWm52VlhmM1hjamJobWJBdHpFQmV0?=
 =?utf-8?B?S21MZFNrZS8rdWFYeXNCdlRwVFk1ZTZzbjVVSnBIc0NjQ3lCUjhtZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z9oSYC4kajLeNru86eSqEKO78hkeBbb8KaFUOTO6s9m9L/lkUBmr0zpHpgu7v74C1dYiY5kbEqAu4sAvjNtht1wwq5PkvKtKw+PrdZ6/Mlbv8c4tTsL7HmShF1ugwtd4YQeh85MDowbdJ1h/2eEjh/XLhSJm/CkfkTFwKLmLpdpEXi3qUSd1N5ZnU5gtNR0yD22WNuRYGQTYuSS5nu9o8qOVClyi+klWa0HHuRJ8OiADPHJKNiY+X5zEPRDV9VAYq6jpxlB2+PGUuKH1S9P+lnMk3UKxmgoSa8AynOWNdGuQC5gMi+sedAfPtSPdclMQRI1XchnapZ4ga2SDqnlYIL5jsJdMgrMIVvqfS72FJcClkz4zV5iWKPABmZxdGuBXiRPSR6sKtFfBhvijU1cPvwqGXiw7ZrXBeo/ctsGbuAWG4xqhwD/UsihHZDZv5I4kOqwiZhqYg/49kL6ou9/G7sYS9/SWK6PMW/VgArYKON3kvVd5imT31CX65g8SN9Q2yLwd7z5DHt8IOSQGlibu06GCCr0IOOVo93emh/AusnkTGL0beQXCJYaDhuAYFWsvk9d1PEK63oLYVmwh4ChnS6UKoOeX+bBnynPYzsIfJOo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2b06ec-4ad3-4fa6-1ae0-08de42b72386
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 06:39:07.8432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnkkEFJuWgUDW+khpKi8hQVKph1XX3eNcA5mcLu98vGyt/sopoG7r86EEiNqkF1L/yCDGwwy//TM8esm5UlJbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4456
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-24_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512240055
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI0MDA1NSBTYWx0ZWRfX08lqggA7hsSG
 ax1jzrXcapZoNbO/e1ZkORLCPu6G7LFqCJWqgIK60zbcyGzhqiv1D0juLJoDY7y/6/nK1OP+6UY
 lp5WsfZCUYdOu13iw+fkwXFCqSwU3pbIUongs8gXJ84EaKojKgczP5UpKRVlxbtsdf4R0tBm9F5
 xGBJXNdN1MzdeaTQ+NgdKlWmSgwPe8Pkme5oz1o8x7bzqgiOyPZb7qQYZ2o8u+5qyLkxocGHvCi
 5r/pUKfwcW0f5CRzhHzUiU69JNKZ4AeY/qJWvN4i05rWnQrk6I7Ausk/hkKv1MPHS9CheC68l8M
 pjFfTUnRt5TYI/U2qUrFFt5CSR+ifMtiFVW1lDjWPU33NtOp2jFzLZkN+tj2PJACwcmL3fadyQV
 arY9gq2aHXkwZ0AYsgLD2MYdVXq/50EZIEo6ekrogUqRXDYFxEjbi2rAHuyqIp6g7XYNIZsAPQh
 8qvl7ZYsLwtw/9+zmmw==
X-Proofpoint-ORIG-GUID: pYO2kO0aI-oNvsLL6koMoYvlCkHveH5V
X-Proofpoint-GUID: pYO2kO0aI-oNvsLL6koMoYvlCkHveH5V
X-Authority-Analysis: v=2.4 cv=cs6WUl4i c=1 sm=1 tr=0 ts=694b8a90 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=vEGpWmvK-9e_5xTHfKcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On Wed, Dec 24, 2025 at 01:33:59PM +0800, Hao Li wrote:
> On Mon, Dec 22, 2025 at 08:08:43PM +0900, Harry Yoo wrote:
> > When a cache has high s->align value and s->object_size is not aligned
> > to it, each object ends up with some unused space because of alignment.
> > If this wasted space is big enough, we can use it to store the
> > slabobj_ext metadata instead of wasting it.
> > 
> > On my system, this happens with caches like kmem_cache, mm_struct, pid,
> > task_struct, sighand_cache, xfs_inode, and others.
> > 
> > To place the slabobj_ext metadata within each object, the existing
> > slab_obj_ext() logic can still be used by setting:
> > 
> >   - slab->obj_exts = slab_address(slab) + s->red_left_zone +
> >                      (slabobj_ext offset)
> >   - stride = s->size
> > 
> > slab_obj_ext() doesn't need know where the metadata is stored,
> > so this method works without adding extra overhead to slab_obj_ext().
> > 
> > A good example benefiting from this optimization is xfs_inode
> > (object_size: 992, align: 64). To measure memory savings, 2 millions of
> > files were created on XFS.
> > 
> > [ MEMCG=y, MEM_ALLOC_PROFILING=n ]
> > 
> > Before patch (creating ~2.64M directories on xfs):
> >   Slab:            5175976 kB
> >   SReclaimable:    3837524 kB
> >   SUnreclaim:      1338452 kB
> > 
> > After patch (creating ~2.64M directories on xfs):
> >   Slab:            5152912 kB
> >   SReclaimable:    3838568 kB
> >   SUnreclaim:      1314344 kB (-23.54 MiB)
> > 
> > Enjoy the memory savings!
> > 
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  include/linux/slab.h |  9 ++++++
> >  mm/slab_common.c     |  6 ++--
> >  mm/slub.c            | 73 ++++++++++++++++++++++++++++++++++++++++++--
> >  3 files changed, 83 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index 4554c04a9bd7..da512d9ab1a0 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -59,6 +59,9 @@ enum _slab_flag_bits {
> >  	_SLAB_CMPXCHG_DOUBLE,
> >  #ifdef CONFIG_SLAB_OBJ_EXT
> >  	_SLAB_NO_OBJ_EXT,
> > +#endif
> > +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> > +	_SLAB_OBJ_EXT_IN_OBJ,
> >  #endif
> >  	_SLAB_FLAGS_LAST_BIT
> >  };
> > @@ -244,6 +247,12 @@ enum _slab_flag_bits {
> >  #define SLAB_NO_OBJ_EXT		__SLAB_FLAG_UNUSED
> >  #endif
> >  
> > +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> > +#define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_BIT(_SLAB_OBJ_EXT_IN_OBJ)
> > +#else
> > +#define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_UNUSED
> > +#endif
> > +
> >  /*
> >   * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
> >   *
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index c4cf9ed2ec92..f0a6db20d7ea 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -43,11 +43,13 @@ DEFINE_MUTEX(slab_mutex);
> >  struct kmem_cache *kmem_cache;
> >  
> >  /*
> > - * Set of flags that will prevent slab merging
> > + * Set of flags that will prevent slab merging.
> > + * Any flag that adds per-object metadata should be included,
> > + * since slab merging can update s->inuse that affects the metadata layout.
> >   */
> >  #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
> >  		SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
> > -		SLAB_FAILSLAB | SLAB_NO_MERGE)
> > +		SLAB_FAILSLAB | SLAB_NO_MERGE | SLAB_OBJ_EXT_IN_OBJ)
> >  
> >  #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
> >  			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 3fc3d2ca42e7..78f0087c8e48 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -977,6 +977,39 @@ static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
> >  {
> >  	return false;
> >  }
> > +
> > +#endif
> > +
> > +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> > +static bool obj_exts_in_object(struct kmem_cache *s)
> > +{
> > +	return s->flags & SLAB_OBJ_EXT_IN_OBJ;
> > +}
> > +
> > +static unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
> > +{
> > +	unsigned int offset = get_info_end(s);
> > +
> > +	if (kmem_cache_debug_flags(s, SLAB_STORE_USER))
> > +		offset += sizeof(struct track) * 2;
> > +
> > +	if (slub_debug_orig_size(s))
> > +		offset += sizeof(unsigned long);
> > +
> > +	offset += kasan_metadata_size(s, false);
> > +
> > +	return offset;
> > +}
> > +#else
> > +static inline bool obj_exts_in_object(struct kmem_cache *s)
> > +{
> > +	return false;
> > +}
> > +
> > +static inline unsigned int obj_exts_offset_in_object(struct kmem_cache *s)
> > +{
> > +	return 0;
> > +}
> >  #endif
> >  
> >  #ifdef CONFIG_SLUB_DEBUG
> > @@ -1277,6 +1310,9 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
> >  
> >  	off += kasan_metadata_size(s, false);
> >  
> > +	if (obj_exts_in_object(s))
> > +		off += sizeof(struct slabobj_ext);
> > +
> >  	if (off != size_from_object(s))
> >  		/* Beginning of the filler is the free pointer */
> >  		print_section(KERN_ERR, "Padding  ", p + off,
> > @@ -1446,7 +1482,10 @@ check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
> >   * 	A. Free pointer (if we cannot overwrite object on free)
> >   * 	B. Tracking data for SLAB_STORE_USER
> >   *	C. Original request size for kmalloc object (SLAB_STORE_USER enabled)
> > - *	D. Padding to reach required alignment boundary or at minimum
> > + *	D. KASAN alloc metadata (KASAN enabled)
> > + *	E. struct slabobj_ext to store accounting metadata
> > + *	   (SLAB_OBJ_EXT_IN_OBJ enabled)
> > + *	F. Padding to reach required alignment boundary or at minimum
> >   * 		one word if debugging is on to be able to detect writes
> >   * 		before the word boundary.
> >   *
> > @@ -1474,6 +1513,9 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
> >  
> >  	off += kasan_metadata_size(s, false);
> >  
> > +	if (obj_exts_in_object(s))
> > +		off += sizeof(struct slabobj_ext);
> > +
> >  	if (size_from_object(s) == off)
> >  		return 1;
> >  
> > @@ -2280,7 +2322,8 @@ static inline void free_slab_obj_exts(struct slab *slab)
> >  		return;
> >  	}
> >  
> > -	if (obj_exts_in_slab(slab->slab_cache, slab)) {
> > +	if (obj_exts_in_slab(slab->slab_cache, slab) ||
> > +			obj_exts_in_object(slab->slab_cache)) {
> >  		slab->obj_exts = 0;
> >  		return;
> >  	}
> > @@ -2326,6 +2369,23 @@ static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
> >  			obj_exts |= MEMCG_DATA_OBJEXTS;
> >  		slab->obj_exts = obj_exts;
> >  		slab_set_stride(slab, sizeof(struct slabobj_ext));
> > +	} else if (obj_exts_in_object(s)) {
> > +		unsigned int offset = obj_exts_offset_in_object(s);
> > +
> > +		obj_exts = (unsigned long)slab_address(slab);
> > +		obj_exts += s->red_left_pad;
> > +		obj_exts += obj_exts_offset_in_object(s);
> 
> Hi, Harry
> 
> It looks like this could just be simplified to obj_exts += offset, right?

Right! Will do in v5.

> > +
> > +		get_slab_obj_exts(obj_exts);
> > +		for_each_object(addr, s, slab_address(slab), slab->objects)
> > +			memset(kasan_reset_tag(addr) + offset, 0,
> > +			       sizeof(struct slabobj_ext));
> > +		put_slab_obj_exts(obj_exts);
> > +
> > +		if (IS_ENABLED(CONFIG_MEMCG))
> > +			obj_exts |= MEMCG_DATA_OBJEXTS;
> > +		slab->obj_exts = obj_exts;
> > +		slab_set_stride(slab, s->size);
> >  	}
> >  }
> >  
> > @@ -8023,6 +8083,7 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
> >  {
> >  	slab_flags_t flags = s->flags;
> >  	unsigned int size = s->object_size;
> > +	unsigned int aligned_size;
> >  	unsigned int order;
> >  
> >  	/*
> > @@ -8132,7 +8193,13 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
> >  	 * offset 0. In order to align the objects we have to simply size
> >  	 * each object to conform to the alignment.
> >  	 */
> > -	size = ALIGN(size, s->align);
> > +	aligned_size = ALIGN(size, s->align);
> > +#if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> > +	if (aligned_size - size >= sizeof(struct slabobj_ext))
> > +		s->flags |= SLAB_OBJ_EXT_IN_OBJ;
> > +#endif
> > +	size = aligned_size;
> > +
> 
> One more thought: in calculate_sizes() we add some extra padding when
> SLAB_RED_ZONE is enabled:
> 
> if (flags & SLAB_RED_ZONE) {
> 	/*
> 	 * Add some empty padding so that we can catch
> 	 * overwrites from earlier objects rather than let
> 	 * tracking information or the free pointer be
> 	 * corrupted if a user writes before the start
> 	 * of the object.
> 	 */
> 	size += sizeof(void *);
> 	...
> }
> 
> 
> From what I understand, this additional padding ends up being placed
> after the KASAN allocation metadata.

Right.

> Since it’s only "extra" padding (i.e., it doesn’t seem strictly required
> for the layout), and your patch would reuse this area — together with
> the final padding introduced by `size = ALIGN(size, s->align);`

Very good point!
Nah, it wasn't intentional to reuse the extra padding.

> for objext, it seems like this padding may no longer provide much benefit.
> Do you think it would make sense to remove this extra padding
> altogether?

I think when debugging flags are enabled it'd still be useful to have,
I'll try to keep the padding area after obj_ext (so that overwrites from
the previous object won't overwrite the metadata).

Thanks a lot!

-- 
Cheers,
Harry / Hyeonggon

