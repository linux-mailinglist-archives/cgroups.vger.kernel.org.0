Return-Path: <cgroups+bounces-12633-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E29CCDB598
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 05:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C24ED301E14B
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 04:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A339A2D948D;
	Wed, 24 Dec 2025 04:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="R49GQnjM"
X-Original-To: cgroups@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020084.outbound.protection.outlook.com [52.101.84.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE20D26D4E5;
	Wed, 24 Dec 2025 04:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766551451; cv=fail; b=Nv0Eix6K9urk0GR0I00FQJsYrh7N+9pTmaG09MY8tAQ9RM3OvilkeauGzmpc+eknWHipJqPkUcx3IULXNPS2iiqcOhTx1ICFBou/XK+0XIamIi733G4kPQ3gSoY8uI3Uzw814Pj7MzhoaQLH+hiKwYx2yE6vhFod6QJI0agAmZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766551451; c=relaxed/simple;
	bh=vSGJvGyEuTSbvZwMDaKzP2GkGtTyXus9wQ6FK/Ha2K0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nxItQYBimzsdAAQrPy071gMB8ERB+UaMQpmKUpz0JUxEYZgq0guppmD9fPTwv+hFcKXkyZ0NZmqM2IWJ5i7GILDjXi6QqBlsLodX17eispmD2jMS2xzgGdX9wCIPPX8tlHQKhhawTY8pz3NqZc6rqYDH4rXaXZ+l+scK4buFprE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=R49GQnjM; arc=fail smtp.client-ip=52.101.84.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3RKcqdFEYZnCv+TsN8lPn5GqmhT2Bz2uAvk2etekgvEyQGtQf6VGhTGAlK8YG3+MEjl0el6s2dNec67drJlLJr7VTTaY5v4nEmhgLOLmQ71asUkNOqDrzZYkDOUQEw0+DfDrFEs1tOMTuG7lJDL8+e6tzLuWyN9Ljc0gDVGsb3XGMudyLA3k+hj7wg8aZSmV0DQUG76t5z2I6xNMKvlS+O3kdEGfPzlg9goRrNQn9+Rctbr2Ri8zgT/3WUDSMnadCboBxxVj+rtLniTP24Hp5XNWZSdWmJyCBX46F8UgqtjwGRZAm1oJo2rSnsyTvo0BHd7rL3OTCfgwkRO57CeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZu3V7Wi9M5QE77FeNXz+Jx6E9LtfiiSLDY5LzC4wbE=;
 b=RF6G1nV+ErJYLRzfwqnyDuxDJrYHAkMA6rkZucWDiFpv913kay+zCKzJdeNZzcoCZLvrUuzl/DSkzLUZB5Bzp1WJx+YE72JQ0H9XiqpL6J7IHfP2UOR86AxWca2fFO2dNRBJTo0RGAcAHK3ng6aqQOhRsj8dcDGaHm4gt6XKNGOUzA+PTwviROk517YUfYrWpt3aMVxGllhZ4Okoi8AcWq4rNXt7It2bbbcIgGvHDkKvudlmIEUj7xvzaWCrDLQPHbNu9SqTYcPWzBKdmZwVjArf4AlyOatTbnV54MXgeJjBR/PGI38aVLuHGqvWLPTtFQJUK8tH6r4Or1OyqSLokw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZu3V7Wi9M5QE77FeNXz+Jx6E9LtfiiSLDY5LzC4wbE=;
 b=R49GQnjMvaVjMeh5S3og2kDaZil//kuoFbJP/7vSutRiw4UrUroMNOz2y7p2VzpZoA6m9noYtaSyy09IDUq+QTf5+B2qSyHV6TBPekISoJomFG7ZllQS7lef/9apLyt6+HjmZhhTzJBo9cJ6uwj/MLMywGIz0jKsTo1vWmRoTGZyjGLML3aY/gnLT0rpromijghbYV4yxLALPXbqwPJDwcko2jFD0zewJC+DvnK3Ow+Gkhd7LV0gNNhlNd2R6iAN2HWdYIaow915kX/kCWyEBVRombZkjSvp8j84BZcYHHOlHgU4gVa+nxV7taqyuC6Axpzq1aaeWuqka3WLX3ovRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by PA4PR08MB7410.eurprd08.prod.outlook.com (2603:10a6:102:2a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Wed, 24 Dec
 2025 04:44:05 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2%4]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 04:44:05 +0000
Message-ID: <1c21533e-347e-4faa-b6d3-385ec0edf0cd@virtuozzo.com>
Date: Wed, 24 Dec 2025 12:43:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cgroup-v2/freezer: Print information about
 unfreezable process
To: kernel test robot <lkp@intel.com>, Tejun Heo <tj@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251223102124.738818-4-ptikhomirov@virtuozzo.com>
 <202512240409.06R0khaZ-lkp@intel.com>
Content-Language: en-US
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <202512240409.06R0khaZ-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:820::35) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|PA4PR08MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8a39b5-0011-42ca-156e-08de42a71129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NC9IQ3FZM3BSSGptb2JjRytpSmdWc0Z1ZExicjBCTXJ4Y2Vrc2h1emVOcXhJ?=
 =?utf-8?B?MGZlYnNManVTaEpMaC8yVm5tRmVaUVBnSko4TGo5NHdjUHVhcVpMcjBsTWll?=
 =?utf-8?B?eUZrSlNNRUJ4ejJhaHFEQytHSzg3MXRsNWdNQzkzRnc1clkrU1c0RHhqc3c2?=
 =?utf-8?B?MFQwVWJudklXWVZRbzV1czBGSUE5U1pIODRPSXYxSVBBS3M3c21VMERMaG9J?=
 =?utf-8?B?VU5wWEoremd1bVE0VE5hb3A5QWRodFJSaVpobnBicHBubWl1aHNJZHZGT2FP?=
 =?utf-8?B?cU9wcnlRTEMxK1BTY3o2ZjZTMHFTOW9TREUxd3hvZW1IRkc0bWQ0ajFKZ2xP?=
 =?utf-8?B?VHFVNVFUbVNZckVjbGc4QUpwWnVHdjVLTkQyb2VrNlZld1poczZ4K29GcWxs?=
 =?utf-8?B?RUFJNXRpRUhBSkxERG52VlF1NnZoZjVDRGUzNjVGUk5saUo5ZUQvaWpGaklE?=
 =?utf-8?B?azBLUVI5R1dRaEd5K1NVcW5QeW9LalVSSDUvbk8yeDhLeEp3MmtaNGE4Vm5k?=
 =?utf-8?B?TVh1ZGdZU1FPZk5ZeXFMYjBrNVpOMnRCMUhWUzNCZmo1MWJ6NWU3RDdNQkNm?=
 =?utf-8?B?ZmRHMTVKYm1ZckhWMDg0Zk1KMjNtc0FCeHU4SmxnTFNaVDBqWE96MkFxVzBX?=
 =?utf-8?B?dGIxK1pRaFVZd2kyZVpzMkwzMDR3Q0IvRUxYM1k4L0hwRGNMZTNXd1ZZWHFp?=
 =?utf-8?B?ZXdKYjRoZzg0bi84eUtFaWpod1BuazFEK3p0a0tjWE9vWXlQTG5pYnBxaXpu?=
 =?utf-8?B?dVZudzQwNXdVeW9heE9laDVIOWo4ZGdydStnbkRNSHpzU0xSOHE4Mms0K1Uz?=
 =?utf-8?B?Q0E0NldGdncyVWpmR2F1RkJTSENEakl3TVUzbVlFZURINzZ2UE1qb2hUdGdx?=
 =?utf-8?B?SFVGMFpoUkhpY3c5SVpzVXVGY0hJUTZTbWMvWWROalVaTWpUVUNuOHUyM0x0?=
 =?utf-8?B?RlFONWo3WlJvc285VFd4VDVkVHRiNzlJeXF5SjBHQk93eXFZZjhtekNaa08v?=
 =?utf-8?B?MXNwYXJLSmdGQVZTNk1Lb1dPVjhUZVF0Smladjh4eEYydVA1a09TOEN6STFi?=
 =?utf-8?B?QVdyUHJiT1JUYnV0ak9tb2ZxUjFHeUJuZUhtdzhURmZ5MVU5cUVtWklFOVNX?=
 =?utf-8?B?Qnh6MjhmOEllQVNHOGF0bENwT1dFNE1RZU1vaklsUE5seERIWkxIakRscHl2?=
 =?utf-8?B?RVY2QVBXWWMxR2U0Q0ltK0ZsUkJ2MVcrZWh6YW9uSzh5aDAzNnBBTklJTzNP?=
 =?utf-8?B?MnJGV1htSm5Td1luMHRRN0k0aTIvL3l5dUZPTFJnc3RycExkbzA1bzVleFBh?=
 =?utf-8?B?c3RJNWMvZDdidmhPVVRJY1I0YmM2TTVoRmZpcWM2Q3JJRHZkV2lyaXZDTG9q?=
 =?utf-8?B?Tjh4aTRRVEs4ZEgvdUNQSVVQZDN5UWFHMjVmSWlDR1F6T1JlUGpiSkpiYUtO?=
 =?utf-8?B?VFJOb2xSSHE2NnRPVXN2Nnd1dVZUSUlPVnRnYmhMNk5rNHFLYURwMGdDZytY?=
 =?utf-8?B?dWxUUXFHYUdDUVErRmdqSStkanNDaGJ0OVFqK01oUWIvRGt0VFpyMFNDZy9r?=
 =?utf-8?B?VTVRMkw1QS91Z2tQQXUrcHVLaTRHQ1dRM01jQWlObmdDQUx4UnpyZTlld215?=
 =?utf-8?B?SDNMR1EvSVZXYjVVVnBiWGJwanpJRXBja21ESGppTjhVTEVKck03cW03eGxk?=
 =?utf-8?B?V2R6YVFkUzJGVU1taVh4S3lsZzQrQkRxbnBBNGNaNWgyV3BqekcyNGtYK2Rh?=
 =?utf-8?B?bkhGWDR4Z096OFdTMWNIWlU0VzdrNG9xTDNvZUVGMWtsVW9HL21NOWRmNXhY?=
 =?utf-8?B?K0hKaFdGWmJJeDdZcG9oem8wajFiNkIxSTNjV3BBTUZYSG5ad0tQdXJzMXR1?=
 =?utf-8?B?RDZodFVHakZ2TE9MemNhc09PU0JiV0lUNm9JL3BsSGlxNUtLdWlUQVozZGxa?=
 =?utf-8?B?bW1tYTEwcWNZS3NXZFFtTjkxOCtyVjc0WktwSnRVSzBrdnh5THRMeVVhM0lt?=
 =?utf-8?B?UVA5dkt5R0dnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mmk0RDFtQUpUYlk0bmY4K3NEdXk5L0Jldkh2bElZeUhXelVPWjhvdVhTUmxY?=
 =?utf-8?B?QWdONDk5bTVYL0JWNG1mN3hiZWd2R0p6cGJyZDhlYmZWRExiY1FjZHZtSWd6?=
 =?utf-8?B?TUtxQzNlVC9vSFNTQllieE5HSFNGOFY4dUU0WjdCRG9HQXFmUU1aVXg2RUcz?=
 =?utf-8?B?UFNWQlAxSVk5emF1dEc0MU1ERWZkdHNyaWtnK1JuQ0NPa05tUVJxd1RMY1dk?=
 =?utf-8?B?UVpWc0J2cnI2Z0Z0NlhYU0s5RWVHcmYwYVdSSlQ3YWh2S2gyYXJaTVBlS3Uw?=
 =?utf-8?B?YWFCdFRMdXB1RUIwSXVMWk1lbExiT3NSa0lwYXM1RmFHT00xQzFkSzhBUWRR?=
 =?utf-8?B?ZlR2YldlcEFlT1JPTVIrenJpV0QxcU80WDNpWStucy93SEhpQ1VFZnBnV3hC?=
 =?utf-8?B?RXp4eGorZW9XNGJaUzVhQ3pvS09oQ0RYV0gzcVBQV1RxZlJwampzMkhYdHRC?=
 =?utf-8?B?cmlEbWRyN2U1akJnSXJHeXBlb1h2VGhIS3BvaGt5SXdBbnlKYml1YmJxVml1?=
 =?utf-8?B?THdyL1pLWE5lcm5YRXh4dkdsSmxFeXlBUEExOUlVc0JmWkVmQzZBMmRGY0Vl?=
 =?utf-8?B?YVR2WnlMdHRvTzh3cUNtR1lJQW81M2VYTjF1ZEdOQ1Y4MURiZzFhNGxnNmxB?=
 =?utf-8?B?R1FrSWFCbTFEcGRGNTZFN0xRNmpTN256NkFpOE03bkFSS2RmaUZXMy83d3Ix?=
 =?utf-8?B?S2VrVGVaVjkxYmxvdWFOcEdtODVNMWV3dzdvVWFEcUVsQ0Q5NFRIc1RORXdY?=
 =?utf-8?B?S0xkYkNGdjBreGRtTGw3NHZiNFJoMUNIbEd1U2VTSzhrVzVjb3FwQ0FHaTF3?=
 =?utf-8?B?bHZxMzEyUDU0UndZT0s5ODRtRU1rbzkxVFBJUmV6VXVpcGEwR3F1VEVjZ1FU?=
 =?utf-8?B?VlJ6dS9IOWtURVFFUEFvU0hUL1RRR3FYYmIvQ1o3TzhCVDhXODU2bWNmYWp1?=
 =?utf-8?B?eTZoVjNmam1LQ0l5Y3c3VUdyZVlNdjVLTkZNWmFXRmRkc0lwYlNNaDFsU05N?=
 =?utf-8?B?MThDc1VJc1AyT3R5dFRBU1U1eHdMSXFoT2c5ZDZuditlK000WFkyMHRkd3BH?=
 =?utf-8?B?VlY2Y1pmdlE2N0xIaG5GcmJaMXA3S0U5aCtpWCt5enUxejdCekpveHMxc1Vq?=
 =?utf-8?B?Q0xGOXBsTkJIcWtwVFc3LzZ2YWQ3TGJaZXg0dDArWDYzUGMyNTZuUnUrQlVN?=
 =?utf-8?B?UzZxY1AybUtQZGQxOC9wUVgyQXFmWkMrWkZMMzVud2JyT2x1eERIY3ZZS2ZJ?=
 =?utf-8?B?Wk9yblFsTXhjTVE1ejI1MWVqakdoN1ZZWmtyMVJXbTd3bmM3Uy9adnNISEZp?=
 =?utf-8?B?QXgvQWlFcmtSNHRWVlNyS3pkQ0xRVTA5VWFiYzFxR1VoSktnNlVJMUFyRnE4?=
 =?utf-8?B?SkErZDNTN0tFNkwvQnRMOFowQk44empmcjJYMVJWblJVVEZYL3hmcE9ZZFV1?=
 =?utf-8?B?aFdaQzZ3eXk0MlhtYVZJTFJCQUZPOHdpSUhSTkd2cXpCTnRlcG5rZVFVU1Y5?=
 =?utf-8?B?TFN4eWRHT3VRY215eVg5L2VMbk43Zkczcmx5SFQ5MHI0N1llbFRaM0szd0NG?=
 =?utf-8?B?YUYxRDdlN3RzL1hWUXFYZGd3YndGdkZSVm5JS2tIdG00L0ZnNTk5QnN5a3JE?=
 =?utf-8?B?WGxoZm50dzNQT3VMa2ZCdUF6NThmT1NJMXBVVlU5YjVrYVVhOUpoREN2WVR5?=
 =?utf-8?B?Yy9ucUh2N045cnBlSitNWnd2a0NEdlpERlNJb1F4MHFRdW9WV3hjR3JTcUVE?=
 =?utf-8?B?Z09TYVRZcHFRUlRKVTlQM1RpRnVVYmduSUxRRmd6WnVGYlQ0N1I5NTZvVlZE?=
 =?utf-8?B?cXRnREpLOUwwdUF6RXZ3WERuZm5RenNHZDlDekJRSHM1cGtmd1k0RVhoRmsy?=
 =?utf-8?B?czF5QlFOUG5KNkRNTUxkMTIxUk56R3JaZHlBUlk0N2ZKZWZiZEJ1REpzL28y?=
 =?utf-8?B?N3dOSTc4WFlCSmRUZXh5aWIvWE9BZ28xRGxDNlJjaWFzY1NjYUU4dW1hZXZv?=
 =?utf-8?B?Q0JmMVhEUzV0MXBPeDRQWHVxc08vYW9la0Z5WHE2TnRYYnBFRzloSUVmRGF2?=
 =?utf-8?B?VkxUUFF0dHpNR0RtdFFocVVWek80YVhsNW1vN1JCUXBSRWpxV1NUTEN4VHJV?=
 =?utf-8?B?eXBJR054YjFVV1cvN1NnaHFkMnhQSEdZRzl1aDhjWDVOV05ESHdVV2I2aE9M?=
 =?utf-8?B?YkV3OHBvUmlyTTA2K3MyMmFKb0xNckN4aU5TQW9TeGtWNTN4blREL0VOMnNX?=
 =?utf-8?B?WVRnWGxkMXdCRW4rWnRFOTcxYm5mLytLMThRRTMzdGV2VjVoam9jeHRFQmFy?=
 =?utf-8?B?WlRNY1ZDaC9pTXRYaHVmK3oxU0lpM1plMU9WbStHSnJmbENacU1uTjYyWkxD?=
 =?utf-8?Q?QLyQnsX0Pzmn+G6NDtTJoP9hsFHXXRKNCVQzqmL8+L6y4?=
X-MS-Exchange-AntiSpam-MessageData-1: tTWnAkdp/+iKNgIzh8TslNSu5kuAPv28f9k=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8a39b5-0011-42ca-156e-08de42a71129
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 04:44:05.0786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VgGDtuzLYdPKzCxq2JbIAKqi7zTdB/K7BhjKjgXAHJAN8sasRo+pMmExHwUFEcuWnmkeMngBXOaSWYwcVATqeHZIlC/UlHQezzSV5d1qoEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7410

linux$ git diff
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index 3880ed400879..21a0edc4a97d 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -4,6 +4,7 @@
 #include <linux/sysctl.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
+#include <linux/sched/task_stack.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
 
the above should fix that.

On 12/24/25 04:58, kernel test robot wrote:
> Hi Pavel,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on tj-cgroup/for-next]
> [also build test ERROR on linus/master v6.19-rc2 next-20251219]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Pavel-Tikhomirov/cgroup-v2-freezer-allow-freezing-with-kthreads/20251223-182826
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
> patch link:    https://lore.kernel.org/r/20251223102124.738818-4-ptikhomirov%40virtuozzo.com
> patch subject: [PATCH 2/2] cgroup-v2/freezer: Print information about unfreezable process
> config: s390-randconfig-r071-20251224 (https://download.01.org/0day-ci/archive/20251224/202512240409.06R0khaZ-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 8.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251224/202512240409.06R0khaZ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202512240409.06R0khaZ-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/cgroup/freezer.c: In function 'warn_freeze_timeout_task':
>>> kernel/cgroup/freezer.c:374:7: error: implicit declaration of function 'try_get_task_stack'; did you mean 'tryget_task_struct'? [-Werror=implicit-function-declaration]
>      if (!try_get_task_stack(task))
>           ^~~~~~~~~~~~~~~~~~
>           tryget_task_struct
>>> kernel/cgroup/freezer.c:377:2: error: implicit declaration of function 'put_task_stack'; did you mean 'put_task_struct'? [-Werror=implicit-function-declaration]
>      put_task_stack(task);
>      ^~~~~~~~~~~~~~
>      put_task_struct
>    cc1: some warnings being treated as errors
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for CAN_DEV
>    Depends on [n]: NETDEVICES [=n] && CAN [=y]
>    Selected by [y]:
>    - CAN [=y] && NET [=y]
> 
> 
> vim +374 kernel/cgroup/freezer.c
> 
>    357	
>    358	static void warn_freeze_timeout_task(struct cgroup *cgrp, int timeout,
>    359					     struct task_struct *task)
>    360	{
>    361		char *buf __free(kfree) = NULL;
>    362		pid_t tgid;
>    363	
>    364		buf = kmalloc(PATH_MAX, GFP_KERNEL);
>    365		if (!buf)
>    366			return;
>    367	
>    368		if (cgroup_path(cgrp, buf, PATH_MAX) < 0)
>    369			return;
>    370	
>    371		tgid = task_pid_nr_ns(task, &init_pid_ns);
>    372		pr_warn("Freeze of %s took %ld sec, due to unfreezable process %d:%s.\n",
>    373			buf, timeout / USEC_PER_SEC, tgid, task->comm);
>  > 374		if (!try_get_task_stack(task))
>    375			return;
>    376		show_stack(task, NULL, KERN_WARNING);
>  > 377		put_task_stack(task);
>    378	}
>    379	
> 

-- 
Best regards, Pavel Tikhomirov
Senior Software Developer, Virtuozzo.


