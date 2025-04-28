Return-Path: <cgroups+bounces-7848-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2BEA9E636
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 04:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DECA1718BE
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 02:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F99D13C914;
	Mon, 28 Apr 2025 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qdjmGih4"
X-Original-To: cgroups@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011045.outbound.protection.outlook.com [52.101.129.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945B86352;
	Mon, 28 Apr 2025 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745806820; cv=fail; b=WQvBCl0kyaTOTsyjTSvZmatRP24R9GZMeYoIYMRugdeHK/l6w5J2L6Hx5Xq3mfrR37SCRj0BtGrn9ZFJP0iVnV4Y2Hky1xqVYOeV/H9myzZSvYHiBq68O4e8JhfCGANRilAjfHQfpOapJc5VzxYtHMXHZ4Ri7r7yMFjceY1Bcps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745806820; c=relaxed/simple;
	bh=fRCvoy9AhMycxBuPvMiwOdvLxPyiXzXIwhxMtY4ukBo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V537gzFCDW2S8/MWdfW69PSqie6ARL2LU97bvagJTKJItIAHuAkElvb+wkeSPLu2nAvSOy7NxTK7BKtgumP+paCPjtiaVAJP0rKv392sgyAOoXUsSe1zeswvFX/uPWCMSFrwjOVA8m6qiwZJG/SV2hN5vFRTDaEV6sdu0wKphBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qdjmGih4; arc=fail smtp.client-ip=52.101.129.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GECCTh63GZ8hIC6gIkgzw6QLvo8v2/xhHOCfjzDMQWT43ylnezLUGn2Zo5ixmnxI5fuGNKQewBu1ILhdGD7D3eQaUG9uhkXCxXOhjwPjQrj3nsXVa3JOrttNQOMh5yIDG5mnND4Ym8KVkQSTMsvepxRBfaA8ZXPPWCi6v7CJN9sqTiiwzLc9Wb20NrI0TU+rA3Mts1zW1VY2aA82PrCUYgASzULbzkh788/3n/Wm+8kuiEFkh3Z+Rs3xzMJlwt8JBnhAx65VPmaQ29NaHPAmp/DWd0hhr5oCvARqzvFGUgU0FbNGYF+nuUGC7UMdaPtU9ss5Ms0MGNGQwGeG2zXxjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRCvoy9AhMycxBuPvMiwOdvLxPyiXzXIwhxMtY4ukBo=;
 b=LEQIEfKkBbl/CKQepUf8ZM18MFeQoSgLDqFvSvGrUS5y8RZPK0xpDtMwHi3717OZ9W0d84bi2GZpwebm/mzHCmhtacFXNV5yrQpOLjWKOPsBKhvpXc3Ff9HlPrtytpG176bUnZEOPBc5QY/waE296ibHxVB1jD0wh5lMSDpb2V8k9/qbqUACaKIwHNf2iCGBtMiS6TAqX1DhFfwv2JuDv3OA5BbmFuDAX/Eag18G2tmaD3Zxk/g3aLAnnvHZbqbzwBdQs7865HtDg3wKQEht5rYt/WRVLdGp2T4qQCN8bNmw6jv5mD7wjkLiGhq7Z4e8aaD5MgtClYVrPIZNoXAXMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRCvoy9AhMycxBuPvMiwOdvLxPyiXzXIwhxMtY4ukBo=;
 b=qdjmGih4URcQzQNra8+cEqI7/yzw6chsbmL9W4bWsWRh6gtOzAUNRH1OW120gL2xX+oqqNO/t5Lv6IQ0XxOf4parOcWDmQzj4EJS27h6llFkpUYKdKhHTxjNVZucAuSckyxuhaOkEMgE/SQ5Gi2SaqNvvsMAgWAiYsh6RzTJCTVEnr1pgoQzNFzif21PxfXDsvFhmjw0Brmkmjb2Z5scEOdi9glCI42Arpsn/8rVC8BZYQI3kLage3xVz0X998i4wjcGhhk6ESkWL2yXOH8EgZCWkPnZUiGdWpcElpB58BP07JmejFABkJozg+9RqnH8zEnWN36PUkI2DHeLnhNO+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYSPR06MB6607.apcprd06.prod.outlook.com (2603:1096:400:474::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.25; Mon, 28 Apr
 2025 02:20:13 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 02:20:13 +0000
Message-ID: <30033ec9-cc64-46a2-8d3f-98b03f57c39a@vivo.com>
Date: Mon, 28 Apr 2025 10:20:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mm/memcg: move mem_cgroup_init() ahead of
 cgroup_init()
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 Vlastimil Babka <vbabka@suse.cz>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Francesco Valla <francesco@valla.it>,
 Raul E Rangel <rrangel@chromium.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Huang Shijie <shijie@os.amperecomputing.com>,
 Guo Weikang <guoweikang.kernel@gmail.com>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>, KP Singh <kpsingh@kernel.org>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>, Boqun Feng
 <boqun.feng@gmail.com>, opensource.kernel@vivo.com
References: <20250425031935.76411-1-link@vivo.com>
 <20250425031935.76411-2-link@vivo.com>
 <CAGj-7pXOCbhzssjRsYP2FFvAE3aYdxbPVH9v=rBfq0aPc4wjQA@mail.gmail.com>
From: Huan Yang <link@vivo.com>
In-Reply-To: <CAGj-7pXOCbhzssjRsYP2FFvAE3aYdxbPVH9v=rBfq0aPc4wjQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYSPR06MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 944d77db-d529-4bb7-0870-08dd85fb354c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDBXbVpvbU0zNXhtekhFdVJxWStHeWl4b28yOGwwdDk0c3BVY1o3NGF6RnA2?=
 =?utf-8?B?UUNKZ2h0cG5FZ0JLS1EvZjYwV29RYWc2Q2JDTlZqYVE5ZTZtYnBVTjhJWGh5?=
 =?utf-8?B?QXVJYUgzVEF4b1VnbEl6bFNFajg2RVBoN25iWkFUMExiWmtBanhxM0VtSnBD?=
 =?utf-8?B?QXhCZWdJSHA1NHZ1VFRNQW14SU5rRG1GMS9EMlE1TEdpK1BCUHNYd1hZNG00?=
 =?utf-8?B?WjZUZEtTT1Q2dmV2UE1Nc3VNUWdZQzNTdnBZOVB3WUx0ZUI1LzZpbkJjSzBG?=
 =?utf-8?B?cW9kYzdZWS9Iak8zc0MzQ1dHODhJRGoyMUx0dnBKOUxDbHUyejdsa2NEajk0?=
 =?utf-8?B?L3NRWHBKZVRiZytZdi9pM0ROdmNFL1l2K3h3UHEveVRYVVZid0RKMWdqd2tV?=
 =?utf-8?B?NDVZZThhc2c4ZUlGNEVydFFlN3J3ZTQ2K0QxYUNNampTZzV6U29xZXFTcHEz?=
 =?utf-8?B?a0NMWFNxZ2dGTEo2RExsY3hnSWxGaEVsYTlpL0dxYlJJS3NLS3NpZ0QwNFJO?=
 =?utf-8?B?V1BuNTUwVHA3Rmtva084QzZtOGFnWmNDeHRmZXBEQ0JHbEJMbVBCNE0zQUpI?=
 =?utf-8?B?WTMyWjFVNFFudDlmeWd1ZFRnSXZGZVMzc3ZyWWhnSTc3ZkdqYVRIcVhyWmVS?=
 =?utf-8?B?d2R4U1RwZG9KZG1COUMweXFlQjhUZ0NNbVFUV2dOL3Zpb0ZQWWNHQlQzdkZQ?=
 =?utf-8?B?L2tNWnNSQVpmMFplZmhIN2dxanNtK20wWDVyaVZLUFprbDdmdCttZ2phSkJI?=
 =?utf-8?B?elVHeFNqVERlcXg5ZmNWdFZyZkZrWVUrRm11em1YYjZSSmw0SldLNDB5WmJU?=
 =?utf-8?B?T3ZtUVFkQVNzT0hhekRjZHI4dVRuQUxxaEhBY3pEN2h5ZWNXZ3NUdC95NC9j?=
 =?utf-8?B?QkRzQnY4Ky9uUVBPU3BqTVhtc3pZbG5aZXhzaWI0WWlLUmIvL0JXNExXckhm?=
 =?utf-8?B?Y09KTFptQ3pGSDBPL1kwMTdaWk5pTVFUQ1pibm1TVGM1QjQ5QjdqSmF5aDhC?=
 =?utf-8?B?aDVGY3lQY3JOWTIvMXE3TlJRSUtQQWhZdGhvSUl0aXZ5b0ZaMGR3VS92emEx?=
 =?utf-8?B?djdlR1BjVjlKLzZXSVlxbWhXS29Jc2VQaXJLeUNGenMwWXJNaXVFVDZ5czBm?=
 =?utf-8?B?UlpaWElGSVB5aEFUVmJYT0NCNVNtQTc3dFA4QTNkZDlsWmpKcG1rVEljY0x5?=
 =?utf-8?B?b0gzSm9tMXZLL1lQOG13VWt2VUIweUtUak0vaXJ1YnpOeWROTXlnWmdRR2Q2?=
 =?utf-8?B?RHFLRmhnUktzSHlsMTFHcG5qeFZKZjU0Vy90NzJXcmkrWURCVFBsVVlYSTJj?=
 =?utf-8?B?dVlsdmdhc1RJM1B3QWNIZlQzSk4vbzMzdEtLTHFqZnRWU2F3MWpiTDhWNVJa?=
 =?utf-8?B?QTRyei9EaUFjNDIvU05tbXVPUlU0eE0rdFdDNk9sSlhlMVlIVTA2ZDcyMVA1?=
 =?utf-8?B?aUNmQmcrMUo1M3RwcDlpVXRnYWdLSk1ZSjU3WFFmQ1M1YWRzd3pXR2Q5V0Jr?=
 =?utf-8?B?ZllkaVl3dDRPQWFyL3ltTkg0RkZNUlRGWDVpL3I4MGcvN3BPK1BJdGN0SG1Q?=
 =?utf-8?B?S010VzB6bE8yYkZGZ0xDV3hXemFxeWpLRXI3VTFQbUl0WVRXT1JwbjJZbjg1?=
 =?utf-8?B?M2hvNTFtdnc2dnIzNHNrS2l5bUVrRzh0VVp1eW5vRGxFRHJqTzZwdGhTZ3lZ?=
 =?utf-8?B?UTdhV3kvbFVabC9UV0VpSDd0bWFiaEJyc3lqNThuSENFQ1UzYUxKU2xLVDh1?=
 =?utf-8?B?ZlI1dDRYbjJOUGczYks4d2dtWjcxemFjYXNnai9zeEdScmhZS2xERER1V2gw?=
 =?utf-8?B?VXBEL2Z5SHhhZVZ4cXR6QjduZXF6U3FseVlza0tqb01naGQzelFLendsNW1F?=
 =?utf-8?B?bk04bWUrOVJMdmxlRlRJaUtsdHBhaVo2VTVONlFXVEl4TmNSQ1diOEQrMVJG?=
 =?utf-8?B?OXEyMWc5OUQ1bG1RL3FRYXNkd3dHZGVBeERzS1hlTmV0MDFkZDRkTS9iZHYx?=
 =?utf-8?B?eUtBUjAvODZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WExNbjZtb3pxT1NOd0N2MEZlK1pwSHNoYmlaUDVrcTVIb2dsRHV2aU55U2tm?=
 =?utf-8?B?WXNIQUEyQWRScUxUNEZucHNRVmFUT2lONk5rRXNySUVwanBraVVtcE4rZFNz?=
 =?utf-8?B?MThVT1FENFhTMnZNWDE4UXFtYnIxNWs5TlhZYS96ek14YkZXRnlpa01vYTd6?=
 =?utf-8?B?SFVhQUZFejZkM3VwTG90SVV5ZUZKTjdEdHdzY0NnQk5pMXQ3ZW1UbE5SUUlW?=
 =?utf-8?B?Rm85VnRrUGpvMXZWTXhYQ28yTmpidnN3dFNQeHdMK2U5cElVS2FTZzB1MTFl?=
 =?utf-8?B?UmZ2ZWNhK1Y3UlNYRUxpd0VJUFlGL3F0VjBYTzNVaHhtcmJJai8xTldZOG5V?=
 =?utf-8?B?THF6dFJmM2dmSFJVUTd4cmt4dkN1RVNiQnFhRWpPV2VlejRRV09hOWhDZXln?=
 =?utf-8?B?Ui9NRWlkUFJxbzcyTG83NkgzRTh6eXpUdDUwUGZMMkFLajF3Q2RBNHNGSi83?=
 =?utf-8?B?SFpERnVSbTVZMDQwa3hPNmNVbWZDWTg2K25BZEFvY25iVVFlSmljTTNIQndU?=
 =?utf-8?B?aGlra25FWmFqU3dwRWFHRTQzVDZqSHNYU1FJYjB1bUlTbXQ3UWtZdkdjSWtF?=
 =?utf-8?B?S1BscjdKbUpKN3crM0U0T2tSNTJwaEdVRXNFczZBS2kzTXllSkZSbC9md2M3?=
 =?utf-8?B?NVE2Z2dUVTZYSlFicWFPMU42TmlGWnZGaTJMdGY3UExmcStQUzlHOWthMFl5?=
 =?utf-8?B?K3NHMWNFKzV0ZUtzZDFBTzVCMGxKNnZ5dlJaeExjZjJmeEtJaWhIRGhteVRl?=
 =?utf-8?B?RVJGRjJVOUN3KzFLaUJ2Z3JGQzJ3SUNpNXdHMFNuaktyNm1sK2xYdU5zWHhs?=
 =?utf-8?B?SWRnNU1PdTEvaytPdEhXRVJ4RjlOMnpEM3NiWmx1cUxXeXZ0cmlKcWxMUkZp?=
 =?utf-8?B?TVg5Ty9CTDhMYXF6bVdoQm9kZXowYzlaaXI3SDFSV2RqTkZ5YlJlZkVZR2hs?=
 =?utf-8?B?dEVxdCtWVWV2eEZiNWN2b2xKa1VkRVJpVWlEY1A4MSt2NVhPdTNuTXFtcFlw?=
 =?utf-8?B?d05WZkNpNHBmVnJNVWZ5L01EcTVDU21UVjBDR0FMK0d6VmluVmo5L0p5TnlF?=
 =?utf-8?B?K0M3NHZJMDJiOGNYMU8xaGxjcHUvNHYzYUc4MEtUTVl4eUhOQ3ZmV2swS3Bi?=
 =?utf-8?B?bmVSdU9WSnFQb3RZMXBCS3g1RzdVUUtXTnNRL3lXWW1MWCs3VmxuMEpKVlYv?=
 =?utf-8?B?S3RiZlp3bUZ1NE9JRjFLMlArdWZESHdJTUxrY1IyaTRVTk5OYko4cktzdWh1?=
 =?utf-8?B?UUxNMWViTzY2dnVFK1AwRTVzVjFYUEZ2NXl0cDdYQ0hrWTdmaXQzeW9kUmh1?=
 =?utf-8?B?aWF6SE9WYUNEb3N3TW82VjFDV1JLUkhCSGZxQStXMVNpS0o5aENhNllXblZY?=
 =?utf-8?B?d3lIdW5hT1RDN1p6UVgrVkV1QzBNQmZYWXBYcXpDWE91UWtlRlgydlB5VFg0?=
 =?utf-8?B?ekVZck1DTWs3OG5rcmpPNDl3cU1HeU9tRUJYTFhmb1dGWmxPVkVQb2tXSFlz?=
 =?utf-8?B?VjdJWXlLZ0VISW5yUjV6TjIvSXdLek5BUDZDdGNOdW1VbVc0K0dWck5HQ1kv?=
 =?utf-8?B?N1dZQU9BS0xhMkpYanVQWTMxZjVMRmpmV0c0dy93VVg2QTBBRDA3V0ZRM29Q?=
 =?utf-8?B?SjlZcWFCTmh3NmFaZlVJOEhBYlF3ZUJzM2pCc3VZY2FqdUc2Z05qQXBDbDlM?=
 =?utf-8?B?Wk00a2t0YUpQcHVzdXVvS3NHYTFxclFha0xXZEpTVVU3K2h6dnFYbjhtN0FR?=
 =?utf-8?B?ZVBzeUFpa1E4OXkyN0JwVk42ZkVkWmJaQVJrRTlzdTA0bm9NaU5sNVdXMjRr?=
 =?utf-8?B?QlRERTgyYXFtWVl0TGxON29wbkh5QkMrYnp0L0JqYmtubFhlSXdCT1JZNnFZ?=
 =?utf-8?B?ck5WalVQKzJiblVLWFU2UE9mbmJMUkhmcktTNGJTc1UzQkV1YjlDdjdXUnQ0?=
 =?utf-8?B?aEpWeEMyMy9ON0duYTZneU50UFRhTjR2RitYdUFuNU51NmFTZVpIeXFrcTYw?=
 =?utf-8?B?MkdEZlRFQm0vQWZISGFlSnFNU09ZMnZIemlSN3Rud3dGNzVpZUZhM3ZYdnpW?=
 =?utf-8?B?K0NGTkx3T2ZnaXVjOElCMjZyVXl0WlcwKy8rbEFPQjkxS1pmejRaeTRRWmU3?=
 =?utf-8?Q?R1P0CgJ2pbx8EYDuUTwJGJ45v?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944d77db-d529-4bb7-0870-08dd85fb354c
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 02:20:13.5934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+F8CGZanAyTUWH3U6klxAik6/cPfon63JSSrSbuAi+ruW3sVPaRQVZzKeqXyGrZGP3r2y6tK/aYFYSewenUSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6607


在 2025/4/25 12:11, Shakeel Butt 写道:
> On Thu, Apr 24, 2025 at 8:19 PM Huan Yang <link@vivo.com> wrote:
>> When cgroup_init() creates root_mem_cgroup through css_alloc callback,
>> some critical resources might not be fully initialized, forcing later
>> operations to perform conditional checks for resource availability.
>>
>> This patch move mem_cgroup_init() to address the init order, it invoke
>> before cgroup_init, so, compare to subsys_initcall, it can use to prepare
>> some key resources before root_mem_cgroup alloc.
>>
>> Signed-off-by: Huan Yang <link@vivo.com>
>> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
thx.
>

