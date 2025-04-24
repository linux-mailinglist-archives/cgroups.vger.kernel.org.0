Return-Path: <cgroups+bounces-7782-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B6BA99EE8
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 04:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997D5461C7E
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 02:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235A4188CB1;
	Thu, 24 Apr 2025 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="e9dhE9rP"
X-Original-To: cgroups@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011059.outbound.protection.outlook.com [52.101.129.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283501CD2C;
	Thu, 24 Apr 2025 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745462716; cv=fail; b=cDPVBkITjGZxEGliUKk6FNKk327mTK/e8ROFxcA36S8eCtzCMOoOHyZtKdmc1iCBiPs04Rw/9znJU98NGgCjZ3omrs01nfa4bTYohBVhpgd6bkeKBq4Qdlsrz7MEBvuF6EfIi0FIGVbK+w9JfkdiA4ky2NYHG/R84YXfSiyUug8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745462716; c=relaxed/simple;
	bh=SarvpjRwdGkOktVjNnaLdo/4871+A9LSqyaEBtdZC14=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eBQu2rPSb+pceSNuBU7Ryr19KZEW+AspcqT78OtLHyFTGpklY2cdUTzEFPEatHw6wu1LaF67DGhqshsh4EVznPzyrxKUDeNQ+ICwMvgrHKlgbYOvGUAefj+eR1SHIDEFLwXV6PHxhVFQETzmhmJxeUlivZI7wBwy6KUIlfi6wLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=e9dhE9rP; arc=fail smtp.client-ip=52.101.129.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=onYRBqGJMybk2xDrXgzVIt+/TYADii+TW2c1r2OAbTPftjMemmpxkZXYdhgwPptyE1li3WAmh5uycPiZ8shD9sXK/jiRhZh67Z2scrWV7hM8vjd60gUecNlPabe7GXzC4fi0ID6S2TLLMpdwrMoy8MH0KbzcVmcKtqNbXWyo1037ac9dGCZdBDs+IQ/ZGfLIqqpA7se5OgpFfFhBY2IC3eqUwbs58ptljMBVHRTGdIQCr5w0Rug2FIfmQ55RFH3yUeKEirQ1ptb7onFJLbf2oqHtaQ981UfS6TneWTfbAgJRvkfie3nh/c0OCo4/5KhMMQUqZI5YHLecieKgAr2SdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EicpJL+8GWUC7sISaqFp7H1njiX18Cfa6lYvzgQRZzU=;
 b=Y7Ttd/7SDLDvB8r3/oivArk6jdIaWSvqkqictcS6amGw1KPbQSNe9tKWjrDJjYx3vbhVRc80Y4i9TA5c1a3Tx7S856h2JR8L+xn5C4k4JfcyYjmjPbc8pRIOqvgD+fE2qgdx0Y/3Ff+EGXezPeS8hOH2aeL5zK6e3XIFmUwnrXi5fexkQaCsKEyakTtvLQlHBMVAZoDuMn61zObKneXW7douTfXKMtR6JfqWNybEa7En9542C9J8zLq4uBL/hcPycrevMvVHd+i6Nasl6C2HEHxBOSYS0GOySOUNUZY+NfcEvD0qgmHc0r+a9Iz/LjRUIXfLVAnINcoVOODS56x8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EicpJL+8GWUC7sISaqFp7H1njiX18Cfa6lYvzgQRZzU=;
 b=e9dhE9rPj0pV8ZUFpH5m0hPKazUNJXJmRiglMcG7t/QlHTwEc2qnPyHOI+Jhbt8nbaMm5Mti5oPbEfjhNwvPY95Y5mTFb1cH8g0c4QVE15hH0dczbT1lEvgTq5RxqW2RDxSdEbuja0JXENspRQf6EOUziPleFyoE975liK1q2bJ21jofkYuHP+UwUoa4PK4t5M1WYW/+aEmMqsG/BhEm3HqYaRAHgIO745kEnfbDy415Kc+kxu8vox7GoIrfg+dZ0+89ItcTt5++fSofaLqPhNo+WgEo3asjIVa4QcJ1UK8uO+Dq6Pue24e1XkEx4MDFlQxGjCtKb04ffs1G8KKCqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB6915.apcprd06.prod.outlook.com (2603:1096:405:3c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Thu, 24 Apr
 2025 02:45:10 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.8632.036; Thu, 24 Apr 2025
 02:45:10 +0000
Message-ID: <142e6a02-80bf-4e7e-9165-1b5690fde690@vivo.com>
Date: Thu, 24 Apr 2025 10:45:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/memcg: use kmem_cache when alloc memcg
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20250423084306.65706-1-link@vivo.com>
 <20250423084306.65706-2-link@vivo.com>
 <20250423145912.3e0062864b6969b3623c8ff6@linux-foundation.org>
 <dp5frcrqofkjjp77hw5sbkri6etnpdsvxnahs6nazvakaxt6im@xouxw25rggci>
From: Huan Yang <link@vivo.com>
In-Reply-To: <dp5frcrqofkjjp77hw5sbkri6etnpdsvxnahs6nazvakaxt6im@xouxw25rggci>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::12) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB6915:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f364be-2904-4bed-1705-08dd82da0780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3c4enB2ZlJSTmliQ1pQY2NDZk9PNGg2MGpuY1ZEa2pLRUpUL1RBYnZuUTlj?=
 =?utf-8?B?TnRHdGFXUjVQN3o4T0U1cS9UcHhDeEIzZ2tUcnFXeTcxc2xDMUpRWTZBMGsz?=
 =?utf-8?B?bTdNSEtmSS8rdlRtRUtOK2NFNjlpRDBCNlNjQUJPRStFemZvMHJ6Yk1kbm5R?=
 =?utf-8?B?TlcyanpydllRQmZYYVVZY0pXajhKMndqQmFHV0EzSGYyQ1YvWFNJazFiTkFG?=
 =?utf-8?B?QmxCNEkzdTlkYnJnV0swRlcrc24xNjROc2IxZkYyZWFucmI1bnRLTERtck1L?=
 =?utf-8?B?ZU5CSWVWRk8wdWk3VmM4SndVRDQ2cTllMWlQZEFYUUI3OTczQ21GS0ZpbEMx?=
 =?utf-8?B?WXVOQjhXcUJ5cGI0bi9KOSs2VVcxTEJlSVUyZmtCd1NhTVhvR1VSVVRxU1VE?=
 =?utf-8?B?cC9zZS9YSFM5aGkvVytrZWVqVzlPblZoZENtN3BRS3d6U05MQTRJd1V3U3Vz?=
 =?utf-8?B?Z0x0MjJva0k0UkpXVkpSOTRnVUVLUlRYUGplQ0hRL1JkUUhjcDMwbmtNVDl3?=
 =?utf-8?B?OHpRVUtEMEd5Vi91WlYwMEFqSCtXUjBIdnJvSE9oNzBFREJLb1NCelRrWllX?=
 =?utf-8?B?bm1FMzA0VHdCNEJHTFlKNUlnaEtpUXJkV1RtRnRxOTVhNVBoM0dWRER3TWN4?=
 =?utf-8?B?b1c2eHlvZ1hyWkpCd0MyQTVqNW4vVDdXSUZHSGx1NjM2TkRoUzc4M0ppbHVP?=
 =?utf-8?B?ZERVclUrSm1LY2poRkhod2o5K2VxbEdMck9pYzRJVkYrOWgzMWNxVEthQzJX?=
 =?utf-8?B?ajdNMkpaUXlNZkVTVnpQWExwWjQyRTAzWlUrRXVVUllaczJkejBPY2F6L0lJ?=
 =?utf-8?B?cmpvRW1BZlVuU2E2RjAxMjE4N1IzdFBnVlFJdTVzeXFrTWhWVVExdjYwSVV4?=
 =?utf-8?B?ODdXcm1yUG1Oa2ZIcjg3NEs3d1pZeTJsV3pqTmJPU09MNGI1cXVDUCs4aUNB?=
 =?utf-8?B?QkJhVUlZSktEajZnRU1Icmh1ayt4emIxYlZOZ0huaDErZEIzSnlsV2ZpTzJG?=
 =?utf-8?B?QTdnb0JxS0ozaFk3QUI4UGFOTnVNZUhzbjc0MklOLzdHdEF3K2Zna2ZVUWVC?=
 =?utf-8?B?VG5sQVFhRndHbWFIUVg4K1cxVEJxZ1phU0dvaE1yc2g4ZFl4L1BydjlWZldq?=
 =?utf-8?B?N0J1dmQrNytpWTRiZmhzMTF0TUpENGRROFM2M1RzN3VoUHBhTmIvNTF1Ymo4?=
 =?utf-8?B?R1pNL3NObjN6VXo3aTg2bjFyYlduc1d4enU4V0NESk9Xd25mT3lnL3NwdFJ0?=
 =?utf-8?B?d3FRdzMxMlJ1T01jcHExTnFONGxvUUJQWDFBR0QrZExVZnhaN1V5WVpDUWNJ?=
 =?utf-8?B?QUp0TVBJZGp0aTdYSDFJUWZacEh4ZytyajV1YkNhbUNkVlEyZHlkQzFUWWFM?=
 =?utf-8?B?WjRCWGppMkdaN1JTZ1V2UGxGUk81NmZjdU8vMWRSb3JYK2VHNlJ3YXllbFhk?=
 =?utf-8?B?TFJhVTRPNmlWUUM0WTBoTkd1MWNmOXV6L3BFakFJWTA0U2NrRjlXN1czMXI3?=
 =?utf-8?B?QlVOWkhZQVYrVTJhT01TUGU2YWpBOGh4NUhDK2pBWWhoUmFPOGEwWmh2cTdp?=
 =?utf-8?B?Q3JudWdWVW9OZjJHRXJLSTZUZlV0aXNjN3hBQjBjdVVzL0Z6SGhzVC9zYmg1?=
 =?utf-8?B?NnkwWWpsYWNtN21vaXdETDNiVU9LRDhOSFRRT1ZmUENyQ2VqTjVSOU1vWGxV?=
 =?utf-8?B?eG00L1JFMHpQcHVKL1lGRnNwS2E3ZUhGMElXREthOGtqMGhkMCs3NUxzeVZO?=
 =?utf-8?B?YzlPWjFYbFBHV0xod2oybHU3WXhBWnhsc2djYUhmVDhjcHBoakxrZFFlOUdH?=
 =?utf-8?B?NVdXdDk3cGNNSG1aWStQNVpvV2JvUFBJa1dtbWF0TzkvNUZNQkorS1FrU1Jq?=
 =?utf-8?B?R1lJbS9ZcWhSaVJYWHBOZFZ4dy9MT0FpWjJiRjFMV1UzcmJxR1laeGU3V1Ns?=
 =?utf-8?B?azNNMzZTbEtkbUlyR2xtd2hWck9Vd0FPTFlWZk91TlN2K094cUN0bE11UVdP?=
 =?utf-8?B?L1VsMXdoMW5RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW5WUjIyaXY3MVc3RjVPRUpWUDRMRVBubnd0ek9MTkFmWjVVc0RYa1VlcXJ0?=
 =?utf-8?B?TnFoakRpQk9UYWwrSHdtSjFnRTNVZGVFWWM0WmlXUnh1SjVLdUFFS0pYZHBr?=
 =?utf-8?B?LzIzU3BkUXpVVStTNG5VNW04RzhIMXlRblBIYmtXRHNMRWFDRkxsd2gwNWl0?=
 =?utf-8?B?RjJ5MFUvNGtXWUNpcHM2dDVxUEpvb21NeDV4R0tqY2RrT2VTN0ZKdm1SQXBJ?=
 =?utf-8?B?bVlEY1l5MVRkZTRzWUx0S2tmeVBHK2FwVjI3TkFnN25hTXVSNkhXRjJINThk?=
 =?utf-8?B?a0RGd2xaelVSUk02eFhJK1ZmTFBGWFhtS1RPRTRDTUpveVViK0JYYm1zenJG?=
 =?utf-8?B?WTJMbGcwK092S3dwcUdmbk9zbU5GcTdCU1NDNE5kVDh1Yndsa2U4YXVOOTls?=
 =?utf-8?B?NDZtcm4vZXZwQWVyalZROThrTWRLaXRaUFN2Q3owVDFEckh3ODQ5YUpVQzlK?=
 =?utf-8?B?OW5IVndxZ0JkNGdzV1gzekFaQkY5RCszSTN0ZTllR1B2WHE2UlkzNFJSZ0Q4?=
 =?utf-8?B?RUhWU2I3SFJHK3FpbGZhcHc2ak1SOXJZQTZCK2s3ZWtIckxFWG9LTXdFNitl?=
 =?utf-8?B?bFJUZkFjSzJQN2M5bVFjMzAvbG5MWHlHSUdKZkpodXhkVzkvNHIvSitISHpH?=
 =?utf-8?B?djNWSHEwejFXc29mNHl0V29RM0VhNVpvT1hodzFYYmpuQnZRM1pjZFhZcmsy?=
 =?utf-8?B?ZGdQZGYxQTUvRy9pYll2OE4xTjZwRWpySzBZNVVadk45QmtaaDJ6ZkU5aW13?=
 =?utf-8?B?em9IOEdZMktXRjdIZ3psK1VUNk91N2FXbWxQZzM4Q09mMkNaWG9rRUZEU24y?=
 =?utf-8?B?TnJqU0hkMEM0cFFmY2RZTU5VanlUSG1udUQxUDkyWTNSYzdDdXhIemFGUmhW?=
 =?utf-8?B?TENkOEp5anZwL29yaUFoNDVZT0I5UytmRE5kdjF4dEEzYnlvYlEvcExxOWRV?=
 =?utf-8?B?Y1JlNFREZFhEbCtCOHlhMkxYNjN4cjJyWVRFd0gvOWJwK0ZzN29zZWd4MzZX?=
 =?utf-8?B?cUFHRWJ6UjZhSGRhd3J6Mm0zeHdvVlpPWDNOSWFIV3MvejYyZHZWd2dlRW4r?=
 =?utf-8?B?MGdwNlJ2OWdaWDJwMkpLejNJSW5KT2p5dnFtakpieW1jc1E3akZoZHFvWUJw?=
 =?utf-8?B?TFhleVg1Z3Q5U2RTTzU3T2s0c3Naa3FkZ0J1Y0c4NUc4UjZiU0J4djNzQldr?=
 =?utf-8?B?cHFqN0pKc3MxbW9DeXQrYUJINS9kR09LcGdoYzhYUnRKUk4vMnVCb2pxM3Bj?=
 =?utf-8?B?UncvVlV2YW1Gb1hPYUNySlplZk4xclNpQ3lWbFYvZ2lCenI0ZGwzQ0phR3pI?=
 =?utf-8?B?bzk3S2R3YzZsSDBMSkJJQVV2b3JLbmlTcVQwZnloVnZSaTdyamlNNXgrT25r?=
 =?utf-8?B?WHp3QjBoaUtqOU42NnZNR1Y2ZWQ0QjBGVTVxZk1sK0Q2MWN6VEROaURWK2tn?=
 =?utf-8?B?Mi94YTl3dFVMUjRJN0J0WTV1QWE5bk1iNEFhaU05eWxEYkdiRWdnT0xudElT?=
 =?utf-8?B?d2tHeEpMU0hHMHFveHRIYk56cmlWQ3hxRHlRQndpVW9Ha09lZVZYZGJmOTFX?=
 =?utf-8?B?MHF2QnZHdlJtNzhiVkErS0RKVkpKM3NoVnJ1TzZkOTdRUm53ODFXM2JTNGNZ?=
 =?utf-8?B?Mno3SGVZUGx1dUNPbmNwZUkwMnR4T3AxcVB6YkRWUGh3aFZYVE1UeFBBQjlp?=
 =?utf-8?B?d2RCaEpkaW1XL0p3K1FTWk1mTnRUckVMbmlINTRtQWtnY0kzZ2JYNzhoQWN5?=
 =?utf-8?B?NG5uRElncDNTUmtzSGNGVDdocy95anVSTEQ4QW15ZnljQmNmcE1xbWNKcGdL?=
 =?utf-8?B?alBnRlc3R2djTWFhRitmbGQ5SllFdkVuUXdzNCtXVEFjcFkxMU1ZbCt6d1Vj?=
 =?utf-8?B?aWxYRlVBMXBVV3lmODZDNGlXajBmTzIzcmVXS25pWksxUjJzYXI0MmdDY3RI?=
 =?utf-8?B?TXprQXVNdWRDeTR3OHV2QnhWcXNGaUVuNHFBb2ZGblNYT1ZzN0tqRUp2Qzh3?=
 =?utf-8?B?YUVXaW5USlA2cFlpVldUejVIeGx6RHdHcjlqcDNZL0JCZ0FKZDhvS1V2Qllz?=
 =?utf-8?B?RE43MGQzdmZ6c2lvaTdQVXREQkVDK2tFMXBvazFvVVFjNFJXOHlxTHc5cGZh?=
 =?utf-8?Q?Fa//Z/0esIANOwzYxQO6y5CSZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f364be-2904-4bed-1705-08dd82da0780
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 02:45:09.9043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkMNTj8IhbuBagBzMuxwhNN4Fx4I7j2A4P0lpYsfQlVnFilE3ztxkprVCrU4Oc8KiwiEU8FZqUXPXYEWWfp8JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6915

Hi Shakeel

在 2025/4/24 06:13, Shakeel Butt 写道:
> On Wed, Apr 23, 2025 at 02:59:12PM -0700, Andrew Morton wrote:
>> On Wed, 23 Apr 2025 16:43:04 +0800 Huan Yang <link@vivo.com> wrote:
>>
>>> @@ -3652,7 +3654,10 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>>>   	int __maybe_unused i;
>>>   	long error;
>>>   
>>> -	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL);
>>> +	memcg = likely(memcg_cachep) ?
>>> +			kmem_cache_zalloc(memcg_cachep, GFP_KERNEL) :
>>> +			kzalloc(struct_size(memcg, nodeinfo, nr_node_ids),
>>> +				GFP_KERNEL);
>> Why are we testing for memcg_cachep=NULL?
>>
>>> @@ -5055,6 +5061,10 @@ static int __init mem_cgroup_init(void)
>>>   		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
>>>   			  drain_local_stock);
>>>   
>>> +	memcg_size = struct_size_t(struct mem_cgroup, nodeinfo, nr_node_ids);
>>> +	memcg_cachep = kmem_cache_create("mem_cgroup", memcg_size, 0,
>>> +					 SLAB_PANIC | SLAB_HWCACHE_ALIGN, NULL);
>> If it's because this allocation might have failed then let's not
>> bother.  If an __init-time allocation failed, this kernel is unusable
>> anyway.
>>
>> +1 to Andrew's point. SLAB_PANIC is used here, so, memcg_cachep can't be
>> NULL later.

I see cgroup_init(in start_kernel) ahead of initcall( which in rest_init->kernel_init->...->initcall). So, root_mem_cgroup create use

cachep will trigger NULL pointer access.

Thanks,

Huan


