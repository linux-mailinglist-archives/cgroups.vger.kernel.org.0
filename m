Return-Path: <cgroups+bounces-9977-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE38DB526D4
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 05:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79D84467174
	for <lists+cgroups@lfdr.de>; Thu, 11 Sep 2025 03:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8AF1A9F92;
	Thu, 11 Sep 2025 03:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="P70jUQMH"
X-Original-To: cgroups@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013023.outbound.protection.outlook.com [52.101.127.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101E44A32;
	Thu, 11 Sep 2025 03:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757559880; cv=fail; b=WFn70iwVkHYuZTuBz+cZGA/hMqOQb1SpAPHtXJSKVkv+0h+S0QtwCWqOsgeRLbkSNrkhW8T8Avkcs5kyQO9mVm+LUEmjku8mEHL9A39NVh6Qm6MVweUDxxRVhS3p8U0w94s796hCea031SxjRvfSQhONrAqtbmKt7+DmeSJqADA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757559880; c=relaxed/simple;
	bh=cRbGvgmHvyULbjdc4WklCHtAfWNi+SOsZ3jHQhwCQYg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lw2OdJ0fyJBr1Aa7tJx4ikwU226l+q+JeMivjSppW7bKNboGfWxI5B+Ab1Ep894Qh7tqC7QeJMo/9Rak56+THvy8ii+2zZu3wWdol7+323hSju2/zy4CflSai8REKsaVKqebMUYzcxTOW9815MS2LE50Hy1jcTTMQEN8DH89BI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=P70jUQMH; arc=fail smtp.client-ip=52.101.127.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhZmpvTBl8aIkOo2XS+Wwt8YYBIlYXXl6zQP+ABcDunlEOTu4hf2XkILA7LI/PQ+TC88Coi29lN10UTHpvlG/oGzvjCcI4MB9rnKJnQw+QU+2T3hOm7JAcEZTeqC1ndmE8GLrgtyO6nkbUtmn65qfKr+LNXpjWxZkdbG91WBx2D+11oN7cQwqUKg3hPD0CkAhSmhE8hVxc/4+rcmC3rLsq2reEgDh1ScuJS5k4SlpPrw3VzGJIGmT4sPB+PPiDoFgD3csbH9RN1DyN7frSILTgP0e/Hxb/GuQieXQz5vYuRv1Wvx8Lzc20072h1hn4MAltaaVZgodMMDmzL+5UBh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRbGvgmHvyULbjdc4WklCHtAfWNi+SOsZ3jHQhwCQYg=;
 b=vfLJWeknX9DyT+/GJSe/cd0HQLVVJdYwP5807feWeHHMIDgcS9FtmAYZMjLiX0neWoQfqfFdgGBcM7+Hl5eTDp3BbeHeGksOy9SaUHl48stDXQdrVFPNpm8ho+BR0lE5+T3ij+4N573YgDcDApxYftQcc9BTt/H9FLqCWJi/thf+jrI2EfYnQHQCfHBg/YiYjCbLrH1pLPxakXxVIBzEecR9kVPGNcUSS9S5wQhWx2PkUAehKpoidhixTRUOZlqztqMn/OEMRNPKDXpm7TNYByBQrbDAJylBJYNVz5vNUuFiUmCNij488aeR/WRgCxIX0xsDIYgNZfmj52zr5yYnmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRbGvgmHvyULbjdc4WklCHtAfWNi+SOsZ3jHQhwCQYg=;
 b=P70jUQMH6X55M0U5r076FmxAfSJ7X+GV+SRmb13eknglsbn9LIYATto27viAXkeImtWWSiGqs17jh0Mp4ZBnQ7X+IhJq3ZsNt0LBig3cViZSxgJdZgLcd1gFWe5H368Zsb/fmyN9RYQlbNzkYd96f1G8DsJBtqPmk2ncJwt4K8fekO2MxvRaF/LckGext8YTKduAhtO8hrx+LhK+L8n/AdxY4G7R3fR3JUWGjRpGthOteRO+sonNLeWRZ2P1FMvn3lmbMVbs900Mnf9Aqiq4A2AMvY0Z4Bvu1b/M9ZYDoVAqWwxHMmjnqRIAATgzhGjboLI061oK7GX5f0GQ87nl2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by TYZPR06MB5179.apcprd06.prod.outlook.com (2603:1096:400:1f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 03:04:34 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%4]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 03:04:33 +0000
Message-ID: <78e45bc6-20ba-48fa-8247-40d745cd7c38@vivo.com>
Date: Thu, 11 Sep 2025 11:04:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v0 0/2] mm: swap: Gather swap entries and batch async
 release
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 David Rientjes <rientjes@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Chen Yu <yu.c.chen@intel.com>, Hao Jia <jiahao1@lixiang.com>,
 "Kirill A. Shutemov" <kas@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
 Mateusz Guzik <mjguzik@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andrii Nakryiko <andrii@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Fushuai Wang <wangfushuai@baidu.com>,
 "open list:MEMORY MANAGEMENT - OOM KILLER" <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)"
 <cgroups@vger.kernel.org>
References: <20250909065349.574894-1-liulei.rjpt@vivo.com>
 <fszpgct7ywqy6qq3qnjflol3theovmgnau2wgdqqdxin4q7ezm@zumgw533hxon>
 <CAJuCfpFaTj8PsXkoYRQKQ0sOu+mKikUAE8Wbcx+YpZXZ4M7cMA@mail.gmail.com>
 <b74b1e28-8479-4b14-9210-5b4334d3ce22@vivo.com>
 <uwqrobr5xqtvav73srbe6v2nccgtoy2456vpgzemwex26lwsq7@2g74vl5oomfx>
From: Lei Liu <liulei.rjpt@vivo.com>
In-Reply-To: <uwqrobr5xqtvav73srbe6v2nccgtoy2456vpgzemwex26lwsq7@2g74vl5oomfx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0309.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::10) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|TYZPR06MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: acae6fd2-b29f-46c0-b4d1-08ddf0dfeee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|42112799006|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGlZYkN3VmVKTUt6Y1FHLzVMYXdjRWt5bUtDaDN0ODRQcFVickVOWkhMQ2JD?=
 =?utf-8?B?Vk9iY3VITGFHUmlSQUxsNmFHZ1Jqd2JKTkpNaXI3d3BNekhSaVRQWi9RZkJI?=
 =?utf-8?B?ZHFPMVcyTkF0UEhTa3NPdUVvM0JVTFg2YW9nLzdESmpCeVRnWXd3d3YvcjRJ?=
 =?utf-8?B?cEFKd0w3MlZFa1p5WDNLYWxlQ3JCYTF1U2Zka2JhNmVyYnAzeTkxTEx1MHdQ?=
 =?utf-8?B?N2JwTmFJbmxmMElHS2dqZzJLTklkL0JnRTJVbk9RUFlYT1FWeWlDZGlHSy9z?=
 =?utf-8?B?KzNma3c1cm5GaWJWSzh5Tkx2d2c0MUo5ckpxNEJhTUIzMlo5K05LLys1NTlW?=
 =?utf-8?B?Q0h0dUtpaUc4NzBJR29mdkl5c0p5RDVmdlp3ejhPUE52aHUzcHNvcVJvVVN6?=
 =?utf-8?B?eUZxOEp0ak8vQ3lxcDhBNVQzc2Y5TTluNkJVb0RHYXdzSE5uSUZGOHRQdEts?=
 =?utf-8?B?bWhMQ29LOEljNXVMd2UxQnBqdjg1cGNIMnFFdGFJcFhxdWdWZnQ2b2FhRGNq?=
 =?utf-8?B?MHZDZm1RNXVKQmxUR3hyOXZFYzZic2pTVlZ2V3pCcWM2OUIzRWYxajlpTVcv?=
 =?utf-8?B?STVtaU1kUmlJNGVOVDduTVpNNkk2NUhKSmNicEEzdjRVWWZnVjh3aEZXYURM?=
 =?utf-8?B?aGZ1Z1Q0M2syOWVGZUNNMnhaWlE4NThKMWZqTVc5MkpsdC9mRmVseWMrdnNF?=
 =?utf-8?B?cXlCMklNNHkyeFBzL0wyQWJDLzlhTkE4bkFjd2N6K0RGUGM3Y1dSQzZmdzFT?=
 =?utf-8?B?OTVMUGtZRFp5N2dOVHZiNldraGJBYzdOZnhlWWh2eGFsRkhXZWwxWEp4dDZJ?=
 =?utf-8?B?RENieGQ2U3hkaFAvM2cwUUNnZUVWaDdvRERyT01hUDMvVzhzamRUZmlVaHlF?=
 =?utf-8?B?NFAwUnY1RG1vUzVvZXJFVzY3SHg2MFlGeUFyNWt3UWxaRHNzSjFtR3d2T3VJ?=
 =?utf-8?B?TjlQM0RvSmhvVXZlUmpmbHk3T0YvMHY4UlM3TTNZWTNoSldnQWUrSExLOWtR?=
 =?utf-8?B?dVNnQW5pWEFiQWt2dXVjMldqL3NxdTdjTnN3SmtuZUt5SEJJUzdUdm00eUgr?=
 =?utf-8?B?YjZ4YVBhTnJSVitJY1RkWXFobnhWbTQzelJSaVh4aVFrYTh1c3p2RjZGOFVW?=
 =?utf-8?B?NkdZUUU2QWdVU0wySEFBNUI5UjlZak9OMjM5WkpvM01MbE1wTTF0bG80SXpM?=
 =?utf-8?B?SzM2S09hUUlUck9vcmJPd3o1M1RDQU9VV3FGUXpGZUcxR3Z1a2o1OVZSVnUw?=
 =?utf-8?B?aTBSMEQvL0VIYW5OUEVMcmhBKzhEN01tRUtNM0JVNVhwQndVZ204NmM1Q0w4?=
 =?utf-8?B?TnJCSTJFTUNMWWx3SVdDUE0wWGtZUGwrWEVsM0JSZ3ZhdkFKajYyTHlibm1a?=
 =?utf-8?B?MkRyZ2Z5RkZ3Zzkyc3JtdlRNR0FQMTd6Q1h0SndVTlhhY3hTZ0JNS0lFQkF6?=
 =?utf-8?B?ZDlOSlJMRmg5ejNMaGhoUHcwTk44QUM1S3IzZ3poMnNzb0lHN0ZJRGJyTTk3?=
 =?utf-8?B?ajFDaGc3QUdFVEFjeXhPTDNXYlk3U2MwaFowK0FmZDJHcm9Wa2dhaTl2QmJK?=
 =?utf-8?B?RjdUY0VaMkZZaVBXb2VrZ0tESDdnMjJxNW1OQjhGdnRqTEttK1BBMks4bFRJ?=
 =?utf-8?B?REdWSlVaeUxNajhoblg5QzdlSi9McFpkM2YwbmNpbDkyNE5hSlBMVkFTWld6?=
 =?utf-8?B?MmlWWGFrQzZJM0lEQXlqRjI2Vk5Hem81eXk4MEI2cHljalFlMEFsbjczSUUx?=
 =?utf-8?B?a2FRdUJxUEtsM0VaR09IaEMwNm0vbEN4dHBoT0tUOVppQ3VJVTFZdHVlRjFU?=
 =?utf-8?B?eTJpd2RHRHF1NGNvbExXdW83ODRlNUE5WWhoZXNWN3dhaDF0aGxReWJOek5i?=
 =?utf-8?B?Uy9IM3NvKy9CY1BLZ3ZPOWVDdnJuSzl4bFd3ank2WjdEOTY3dklRbmU5bXJX?=
 =?utf-8?Q?YN/2QNtojdE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(42112799006)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2Rzd3JET0ZQKzdudlRERGRraWhrOGNGRjV6dEQvYzhiTDE4L0lzcGNRRjl6?=
 =?utf-8?B?QUY5M01xWlpYblc1K2JnS2hkWTJQdC9YVUxGdE93c28weU9mUU1oMitiVmdG?=
 =?utf-8?B?eGk0UDF1YVN0Nm4yMkJZcnlURFowQmg5RXAxL3RpZ1FrYUhLQlZoc2VwaDhJ?=
 =?utf-8?B?UWIvOFFjUU9JTklVMEd5WnZaRDZWYTJITDZ6eSs0S2FFRWxiK3E0S25Pc0No?=
 =?utf-8?B?RTlVWk45SU5Xc2lyK0RqVGNBWjdNTzRVajh1d0hsQ3hMNEZtZ0s0a2ppZWNR?=
 =?utf-8?B?YlVsRXhLS0NxSGFoWGN3TmdvdVBzekFVaVpBOHlPSjVVdzh6eVlEN3FXOUZm?=
 =?utf-8?B?a3lEZVcvZCs3S0tlTVNBdmtRc0xPaGhaOEZtRkZURUdtNmFWc3RKa1JYZVRm?=
 =?utf-8?B?b1REL1hidTB1Ty9FMXNMWGRpUTZSa1BTNzdmeWJkOUljRDdPWkRMOXpwdEFz?=
 =?utf-8?B?RkI2VEJ3NkVlRGZzZDFaenVjejQxUmRvZUNaUTBNcU5QSHF6VGk2RlhySEZt?=
 =?utf-8?B?NHVtYkEvdmVRWlUzaG4vWE9RRVl1c3pxSEJnUm8yWDZwakREN2lXanpkdVNJ?=
 =?utf-8?B?Z2EyQzlVVTArV3VXaWJra2JVajFRVzhqbFRHaVZFRWwzVXA5WVl5ZnRheVZp?=
 =?utf-8?B?Q3pxRmlGanRXQ2tJZHZUclpLdWt3eUhtMnY5eWQxblhNcDhmR1NrLzlCbHJR?=
 =?utf-8?B?RE9PNWFza01ZN2lWRHVPVkRzY3BoZ0FOTEVobE16cWJEV3JTQ2NsN2xpNDlR?=
 =?utf-8?B?elRMczBkMFp5TlhoWFFQWTRvRlozY0c3YlpTcDhnQ2p5L3ZrZ1JoZXdBS0J4?=
 =?utf-8?B?ZHA3SG1NUkgrd21YMzJzTjVySk40dlNsUms0TTJXQ0FuR04wWXU1aWRkcjNh?=
 =?utf-8?B?YngzOTdCZmtTcVlXVWNyb2Y3U0w0SnY2Ylpta2RnVU5Tc0s3RS81Yzg3RjRH?=
 =?utf-8?B?VHFoa2Y1T1RYTjFwZVFZZm5uN3pZQlBEZitUZURSMytDU1crcDM5THNVZTBh?=
 =?utf-8?B?a3hoTFlONUxzQjI3SHVaQUwrc1V5NWpkUlkvVXFrWHpjOFB0dGtNbjU0eHNx?=
 =?utf-8?B?MDJidzJHVTVqQjlEVFRVbmZuRjhobGJ1SUc3SWlCaitZcEVzSk9rZTdhbnUx?=
 =?utf-8?B?SGk4bmZWTzRvaTFOYkRXUWhTSlN5RmFyZkZGU3BjamdKNTVIS3JGUkx2Tkpn?=
 =?utf-8?B?a1h0TUZNWkxURVFjYXo1ZWFtWUU5UExaaDJUbmdsSHV4eVUxcHBFUnVvbTdH?=
 =?utf-8?B?bVRobmRSQU1Cc2o2Nk1IK0dESXRRZDVMemJnZUpMeXc3dkhFc2taRUFOWGt6?=
 =?utf-8?B?VkFuOHZROXhRam5NbTRkUXA1UlBjRkxJaGpOY3M0N0s4dHJvM1Z4bFNhWGdG?=
 =?utf-8?B?cXRtYmVMdlJyZU5DL3JJNzBudlRTMHc4UWs0WEg3MHpTNnJCZ3kxMExETHR3?=
 =?utf-8?B?Yi9NNW1TdWxWL3p1Mld5MnJ1QnJkTnZsWDFueWVNL3AvRW9YVE5RbHQ4T1ZG?=
 =?utf-8?B?dHl1bFR4Z1pOTDU4dDJVcjR4V1RGUUpmOEpYd2RYdVdMbzdDdWk1N3BSMmRs?=
 =?utf-8?B?eGJkYTRtWG00a3hBbWlhUFZQWkFIRzhBckN4amswRXUrUUVGSmUxcnYwcldr?=
 =?utf-8?B?NTJMVXBJU3FLSjB4QmUrR3dBY3p1VnVucXhySVZ2NitEbFNYS2x1UFNBK2lj?=
 =?utf-8?B?dWdPeVU0cnY4ZnZSbWJKdHVoa2kvVnJTZjZMVWQ0TjJ5Q25TWmo3SUJjK0xt?=
 =?utf-8?B?ZGhxR1NRWXRlaWtSR3RCZ2xaOWVYbFRmZ0wvQjE3aWxsZmQ3NHNIbkNCVWxL?=
 =?utf-8?B?RjFuc0RaUExtRmUrQXJ4VEFQWkR0aXRaWEdPUDB2SG44NlpNQmI0TVNVaXly?=
 =?utf-8?B?VkxvVkhwbzMxa1dpUkZYT3RIRW4wd3BhYnkzdzJ5L3JrQm5lTVVZN1NOSnJN?=
 =?utf-8?B?ZlRRdCtBVGJpYVlxOGRKMzIvSVVwbEMxZFNEVThXeThkMVltRDMrY2dSOEIv?=
 =?utf-8?B?RjA0L0FSMHpUR3BncTUxOTJUek1PWU9iMzZITmRKYiswYnlVaWhVZ3BOeURU?=
 =?utf-8?B?ZDVvK0hwUlZHNklUV1BBTmJMeUdCQ2JVRktleWMxaTB0MU00bjd6ZmdDRkll?=
 =?utf-8?Q?Zuo16JPwqiZ1bB3CD2QHuZl39?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acae6fd2-b29f-46c0-b4d1-08ddf0dfeee9
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 03:04:33.5165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJS5QZMimr7M4lUZHknF/iRXizkJKn0hM0znUhgZcgEQgIPg+9KEjBZIf2b8vawBQ9BqG57wvV4hJ53KYAW/Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5179


on 2025/9/11 4:12, Shakeel Butt wrote:
> On Wed, Sep 10, 2025 at 10:14:04PM +0800, Lei Liu wrote:
>> On 2025/9/10 3:48, Suren Baghdasaryan wrote:
>>> On Tue, Sep 9, 2025 at 12:21 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>>> On Tue, Sep 09, 2025 at 02:53:39PM +0800, Lei Liu wrote:
>>>>> 1. Problem Scenario
>>>>> On systems with ZRAM and swap enabled, simultaneous process exits create
>>>>> contention. The primary bottleneck occurs during swap entry release
>>>>> operations, causing exiting processes to monopolize CPU resources. This
>>>>> leads to scheduling delays for high-priority processes.
>>>>>
>>>>> 2. Android Use Case
>>>>> During camera launch, LMKD terminates background processes to free memory.
>>>> How does LMKD trigger the kills? SIGKILL or cgroup.kill?
>>> SIGKILL
>>>
>>>>> Exiting processes compete for CPU cycles, delaying the camera preview
>>>>> thread and causing visible stuttering - directly impacting user
>>>>> experience.
>>>> Since the exit/kill is due to low memory situation, punting the memory
>>>> freeing to a low priority async mechanism will help in improving user
>>>> experience. Most probably the application (camera preview here) will get
>>>> into global reclaim and will compete for CPU with the async memory
>>>> freeing.
>>>>
>>>> What we really need is faster memory freeing and we should explore all
>>>> possible ways. As others suggested fix/improve the bottleneck in the
>>>> memory freeing path. In addition I think we should explore parallelizing
>>>> this as well.
>>>>
>>>> On Android, I suppose most of the memory is associated with single or
>>>> small set of processes and parallelizing memory freeing would be
>>>> challenging. BTW is LMKD using process_mrelease() to release the killed
>>>> process memory?
>>> Yes, LMKD has a reaper thread which wakes up and calls
>>> process_mrelease() after the main LMKD thread issued SIGKILL.
>> Hi Suren
>>
>> our current issue is that after lmkd kills a process,|exit_mm|takes
>> considerable time. The interface you provided might help quickly free
>> memory, potentially allowing us to release some memory from processes before
>> lmkd kills them. This could be a good idea.
>>
>> We will take your suggestion into consideration.
> But LMKD already does the process_mrelease(). Is that not happening on
> your setup?

Hi Shakeel

Thank you for your consideration.

In our product, we have observed that in scenarios where multiple

processes are being killed, the load on the lmkd_reaper thread can
become very heavy, leading to issues with power consumption and lag.

This problem also occurs in the current camera launch scenario.


Best regards,
Lei



