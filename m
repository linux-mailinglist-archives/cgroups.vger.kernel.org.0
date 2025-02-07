Return-Path: <cgroups+bounces-6460-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F941A2C4AE
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 15:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4EA918855E2
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 14:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C3C233123;
	Fri,  7 Feb 2025 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gCMmoG3M"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0A6215067;
	Fri,  7 Feb 2025 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738937088; cv=fail; b=G9n6zOEpS4LUdVIZoGJ+SpS6sz2fG+At2F8rdMnDs329efY693u0N1WL8rPJvQbh6ixrpXfDoPzNTq9rYZ/CVkFqWEXAw4+hW+ecRF9guw5AuPkYNudlTIeFQZVbwq+xMBPwN0THA4PgaeI9eOW86wJHzpH9Lytl1vHKa26Q8Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738937088; c=relaxed/simple;
	bh=sEuVHyl5A+Sa0qf/F5zv9rJZu039pNl1J6HdzwNBTcg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VmwCxja95xw8HCAnnYRJuu3sna7hz7HeGF8W9BXNGvI4Ju2oxfn3CbfijAal3qe5+Nbu+kpB+Rfc2ulWnOZl21ejWj/1w3V2bjnW/H5TPzuqMYUfpON9fdLu/nBLWQWvJDTKU7pWYVZA5yPtEBSY30YTWv2E3tlW0xqU4P7ZK4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gCMmoG3M; arc=fail smtp.client-ip=40.107.212.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ty6xYLFyENLqweVel4YRlgkqBucZkCUuC51old44zo8s157kVvy5GLODc4HpdyAtNWoBH3V2htodqlc+xZfodrl2w5TOkBqLQzLsa2dcGwjLyNhbrdB4duq7rNmGrFaFAueKcbjFYaOZz2FJeE56fAkQ0vPtlJaXqZksyFiNLHkeDhCZeMTI6nCQakFjoi3Kvpzc5NZbx13fwVl1H+6nvKj4z2EvpfhOH6uXjVOKdaCeMk87QJUdvtf2yFZSv90ACJJLnAdJbLrR/aQkXFTtGcxoa5d4JxFE2GxjXU2IIwrOEmAmGCbBmppvmpgmJ9ZF0//XaHN105HZuRXeH4Xpaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39/Yn25EFozZzelFColA01aQwQJ8fwWVQxa7y6BXHOs=;
 b=sfmr4pf7NTryYgj4LnyIIfH4Zy/gsHv4eWnX/w7VkxMil3e0xf9QY0wvmdLfc2W09d6pzOksXZ7iQZ7UMtgkeU8dIxUkEdIDmz7NrIDbhmM5KjBVp44v6b+LCWfZE64JTNO/QDQkoJ1G85992+CjumQpaVA4aQeGHDHSKHM1QsFj/OgaaW0HIHG+KcBp4V/G/5hK4pcDzJuPyK0uEE/v2p16q54Zwn9ILrl+sFsV7kwGM3yESF9YtSSu3TIesDO4UR0H4tpyQWaEnNvRUkbwbBZZmsC/PmWpt/qkf0+3lTHqBnuAYd/196rrHF0Nay1Lu3l3XCaezjm8kAo2gJq0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39/Yn25EFozZzelFColA01aQwQJ8fwWVQxa7y6BXHOs=;
 b=gCMmoG3MEnHgH6WqgvCqfLEREd7JyVC63FelUWM9ddmGeMPi3Jyu9g3Xi3Bc6S5LrXIF4ZksEN0xVu6soxBHePeXJTZBvh3mpvtaUJMSsCuChgrJshRTOyPD+3JIXNe8L/7O9hkgqs9u3y/Ws0cyIWCyKS0je2IDaiv8OXArx4ggn3KJcIQhXIP5gdlAC45esWAJah32sZOcIVhoCoFbBQOCw1TgqpTdB75nhnxgdtyacfmkwMR8yoD9YaKYB9WUNObPHFgjRuzE9pjR7ku5fRqqG87zSLViImqeMbeDKjaK9Y8jo467mx91g3QqjCCFuBGWCX0GjH02xAGQDqStMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 14:04:43 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 14:04:43 +0000
Message-ID: <3937ef26-86ae-4dbe-b64d-6ec625543996@nvidia.com>
Date: Fri, 7 Feb 2025 14:04:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Thierry Reding <treding@nvidia.com>, Waiman Long <longman@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Aashish Sharma <shraash@google.com>,
 Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <Z4TdofljoDdyq9Vb@jlelli-thinkpadt14gen4.remote.csb>
 <e9f527c0-4530-42ad-8cc9-cb04aa3d94b7@nvidia.com>
 <Z4ZuaeGssJ-9RQA2@jlelli-thinkpadt14gen4.remote.csb>
 <Z4fd_6M2vhSMSR0i@jlelli-thinkpadt14gen4.remote.csb>
 <aebb2c29-2224-4d14-94e0-7a495923b401@nvidia.com>
 <Z4kr7xq7tysrKGoR@jlelli-thinkpadt14gen4.remote.csb>
 <cfcea236-5b4c-4037-a6f5-267c4c04ad3c@nvidia.com>
 <Z6MLAX_TKowbmdS1@jlelli-thinkpadt14gen4.remote.csb>
 <Z6M5fQB9P1_bDF7A@jlelli-thinkpadt14gen4.remote.csb>
 <8572b3bc-46ec-4180-ba55-aa6b9ab7502b@nvidia.com>
 <Z6SA-1Eyr1zDTZDZ@jlelli-thinkpadt14gen4.remote.csb>
 <a305f53d-44d4-4d7a-8909-6a63ec18a04b@nvidia.com>
 <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0484.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::9) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: dd798054-7db4-4025-3bde-08dd47805ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVZTaVVGZGV4cktNZEVIalNtSG43YitIbHFHaU9yOERqS1kyamhWR2JuSUt5?=
 =?utf-8?B?RzhVYnoxUDdCV0JGWTB2SlJabnM4aVFkbzZKcjRXNFJQYkRZWjlNYUU3VGJK?=
 =?utf-8?B?NDd5MVRRYlE5VVhPeTROWmhqWVNTc3lSd241czJ1dG5kT3Z3WDFmZTQ4MFVn?=
 =?utf-8?B?WUlVSW9tL21uUW9DajdPTnB4QktJeENoUGdrRzJUZUFxQnJRVTRuUnEzWGs3?=
 =?utf-8?B?UmNybGkwUWtIWEY3TFFDZ3d5UW0wejQ2dHZuZ3N5RkhlNTYzTUpkZzQxazJZ?=
 =?utf-8?B?d1FzUnhDbmlpdlJMYWxBazRVc3hDSTg2bEg4aGorQ3liNSszeUR1Wk10WVdh?=
 =?utf-8?B?SDRLNVg2cUlYN0ozQ0JwT2hpWThqclNvMExPS0xSbXdSdkxsenMyRlFVVVhz?=
 =?utf-8?B?UVNjZHVjVmE4WCtSVThMdzBFbDhDdnp0bytTdFRZeW1HeUhBT2JVb2hjdHFw?=
 =?utf-8?B?b2ZLS1d2Sk1NYk5UYkV1MVBLZnRRUm1paXU1Rk55Ym15UGc2U3VrdUl4NFFB?=
 =?utf-8?B?cUMyd0NPcjdEbmFzZ3ltSmJGeVpvNkFwRThVZHlHcHR5YndiYlZnVnQ0MEtn?=
 =?utf-8?B?SHJtR3ZoeHZTdWcxdmRydmJxOWlxcnFTWERLUUlWdzB2dERSVjdzTVhSMldy?=
 =?utf-8?B?NXVwZDRoZ1FOZDgrVmJKYmRnYVorc0U4WjZMdDdXOFJDQ3h0QWpvSHdhb0F0?=
 =?utf-8?B?MmdoU3QrbjBIb2FwQU5ZQW54aFB0UjNDdVVCV1V3ZlVIUTdJNnFNTHJ0S2ZP?=
 =?utf-8?B?SStXa1JxeTc0N1hFTGFMRVV2NVlVK01uYW04d2g2cG5zZUtLcitvTTF5U2o1?=
 =?utf-8?B?bmFvS2JrSTlkLzBUNm9VR1dUZkdTem5DK2I5UnFrY2JsWTFKK0JHSW1Kek5p?=
 =?utf-8?B?Z2pzSFBWU0k3Mjhva1N6L25DUzRHMzliamo3UlpqVDVYMkN5R1lTdlp4b1F4?=
 =?utf-8?B?eFB0ZXpKMTErdjBIbFdiYStya3NQTjBleXpKUkZaZ0toZDF0cFoyay9TMmIz?=
 =?utf-8?B?TEdlTUJLWHFsdTdyOFh2bEI1VHlENTZvODFCSDlqa1htRnhGbjZzUFVISzFO?=
 =?utf-8?B?VE5wSkJYL3lqcTNKZVVXRUtZSHVzbGZnYm1SV1lsSUI0K3k3V2c4bVMzZTBh?=
 =?utf-8?B?ME1KNytrcVNvRXFuQWFBVy9YK0JYRFhwdG9BNVVwUnJ1THdDUXUrUTlhWTVt?=
 =?utf-8?B?YWFSWFVOKzFocEc4RUtxSS9aeitVK2lhdkVVNUpXWlJVTUQ5QThoNXhvUWRq?=
 =?utf-8?B?T1B5N2FIVkp2YUxhVnRWdWVhd3ZaeUZBa2RpLzF4RzBsWjkxYVowazVMc3lt?=
 =?utf-8?B?ZHpVQVdQVDFMTWxBMmw2OEN3UUw0NnRkTlEzWjcyVFg1SkdPYWZqRVNtc3F5?=
 =?utf-8?B?RkRHNXNKQXB1UXY5N1lTQ1dFZ211Q3R6QkRlNExtM1AvN0t5bVFad2NteXht?=
 =?utf-8?B?bEMyQVgxcjJneTFUam1TTHdTOFpOOG9JU2xOMlRpZkVaV2gxUWtBYUpVYW8w?=
 =?utf-8?B?VEJKKzRhN2VLZVorRUY1RExTeHZKSmUyR1dDYjYzSTRnSTZQR3NRajN6blhk?=
 =?utf-8?B?ajI1NnRLZXJFYzkvTUM5ek0zbS9GNlNGdHRaZW5PY21NVW9QQkNQWU5XaGh2?=
 =?utf-8?B?a0puTVMxemlRdFJ6dExweEx0MDJEdFJnWXR4WjV0WmFGbGdoQVQ4YzBnSFE1?=
 =?utf-8?B?alg1Vk5LY2VwY1d5SXNvcGZHZGg2VlNJS2RtVXlEY1RDUG9zWlZKRzhYUWJC?=
 =?utf-8?B?cFpqS3NLQTNrazJyV3JPWEkwL1dzVTMyMmsvK1JlNDFiVzV3UlpTUmNnSTdv?=
 =?utf-8?B?UFF3cCtSYWYveHNBUmw0QWR4MVZZQkJXeDNOZUJQTHZQNG1pdmpHdFdaSkdC?=
 =?utf-8?Q?Vmr8vrxoxqbR+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1NoR3R3eFVvUjdTUWRsSS9oNzZUSWV5THR3UFZGOWcrbHdyY08xalAwREky?=
 =?utf-8?B?YkFnVCtHTDJFeVo0Sm9mY0o4cktjbUZXSGlaRVNJVWlNNTJFT3lvVGE3Zzhm?=
 =?utf-8?B?eVNpWXlOZ1ZTajl6cHIzUFR5ZUhmT1o3RlhBRmw5aEpJc1JFcjJRRVFZRkky?=
 =?utf-8?B?SEs3VlZCSEZ6dlJxdm5uVUFPU3gxOEpzc0piYWFNTTdSNWpSd2xaQTBpTzBU?=
 =?utf-8?B?a3UyTzlRakxtc0lrYWZKMHJCK3lIWGlvbzVFdW8rQkc5MkJjQ3RkeFNFbE1G?=
 =?utf-8?B?bFh6UDNTR081T01LWU5RcUM4ZmozM0tDM1FaODBvU044eUNGNzR6Z3ZPTDJi?=
 =?utf-8?B?MTk4bmlQb0c2NlhPMnAzWWdVMHQxSWxYdVdqSlZTUGhZT1IwZTRKMW5TdjlW?=
 =?utf-8?B?R2VGbE52dUt4U292M3ZTVGxMejVCYWtUNHI2SGFoUy9IUGVaME5BNmY4KzFk?=
 =?utf-8?B?THRRRWh5UTFwdDhqSkhNUElpMjRFaFA3RjhMWFdPNVBrRE1UUlpGbTFLTWRL?=
 =?utf-8?B?VUpUWVU3L0ZoUWY3Njl0Y1dscEVINGpoNEpXbDdjYWJJK1FldjZUUzlzRURC?=
 =?utf-8?B?NDZ0N0x3L1EvYXcwMWdqRm9rQ0t0UnYyRC9OYWxKTVExQUM5eWlYYURVS2JM?=
 =?utf-8?B?SUhDbG1lYjVSVk9URzVvRHFYR1Z1K2txRmhKaVFyWnJOaG1IOG1rUHdCWWJs?=
 =?utf-8?B?alo3aWMxS0tONnBINjNQZDdIM2FPaVY0SnhtWDFUeE5OM0tEWmlzTG4zUWcw?=
 =?utf-8?B?SWU3b0hIRnNoRlA3NVoyNmE2R3FrbGNHeFBTRmhOOXRoMXBlK3piaG9LWnZL?=
 =?utf-8?B?K1FCRUVSWGQ5SXl2NGxlR3R0aWlyZzVKMlNPRlVjSkRRZkdkVlR0c1lzZ2tx?=
 =?utf-8?B?QzRTdk90NnZ0dHJhMFBYZWlqdDduUDQ5eTlXc2V1NXFKY0FSSnRJOWJVWmtK?=
 =?utf-8?B?WExsVkpJRG9jZ2NqVUtSeVVnL2VNa3RVTW5wK3Y0KzE4bFBZTDJwSnFNNVFT?=
 =?utf-8?B?SzIzWnpKMllHejVmaG9ZVUdJcjFHTnJETjFod0JKUFhsaXkrUTBuOEpPNzVC?=
 =?utf-8?B?dS93TURLSis1WHlVUUdCZUg1UzNnUE1LUmFGd1ppRjBxRzJ1dVlDOGJXQ3Y5?=
 =?utf-8?B?SXlNV2d5WEFjY2lsRk94R3BEOGJMY1NRVkhTQVJzWXZneS90NDV1dzR2K29k?=
 =?utf-8?B?eU1ZT24xVzRmOVQyemE3UThESVpnK004enVjbzhtRWpxNW1xN2o2VmsyVTNx?=
 =?utf-8?B?Rk9GUks0MVZGMFdQdzBWUDZBR0wrdjQ4VnM1MndHUGpHVGFLeGRIb0hKL0Y0?=
 =?utf-8?B?bFU0YmgzbjAzaVBwTjhocmdFTmczZEd3QTl5OUd0UkZad1JzZmZtRkt2bXdJ?=
 =?utf-8?B?T2RRdFh6ODdXbFpndk1RRjZzdEdHbjZ4RFNaR1R2bUZWbGttaUd2MVVudFdY?=
 =?utf-8?B?MTdYeGMyVjl3VHFjTjI5d1FaRWRhcERYU2cyTmRCSzZuYW9YSUVibWYyYUNP?=
 =?utf-8?B?aGFvcktOMmllUExhOHVyQmhqMWpwYlcwNHVtVDhCUUlPVmtCKzZROUlhVHpy?=
 =?utf-8?B?Z1F5Q0RDdGo4ZXpxY2ZDM25OQmVlVm9BME9WTnNjWitOVHl6OGg4UE1PRUdz?=
 =?utf-8?B?OE91SHBhVDY2OGtkMVQ0S3lxSWIrTVl5SW9xcW4vTWQ1dWNaaGdPZ1JiQzBj?=
 =?utf-8?B?SG9lT2IvR1ZLYVUxTktsLzNxQlQwSUhBTTZKcDlReVYza3lEclB6MzJEOTlE?=
 =?utf-8?B?ZkhINVBMNlIrRXNiOWxhQ20wM2VSWUFyb21YNWhrNnlnNmlyaEcwbHFiY0xt?=
 =?utf-8?B?UlkxUDlFUzJwc09la09uOVlsMmRSV1FKTVB2MmJ3bUVTR3B4b1dSVEtoSWp3?=
 =?utf-8?B?L3BLSzNYTHIxNUNLWk1ZWkh1NEV2bWtadFhESW56cSs1TUZTOUVPWHU0Wksw?=
 =?utf-8?B?ZjZ2K3B4U283MzQ3VDZIY2creEVSSE52Q1l4NDBsa1lrU1Npa3dpbzJOb213?=
 =?utf-8?B?WWExQ0h4c2l4dnRPa1k2Wk1QaXlvWldvYnM0MzN5VEN4UWttNlpaOVkxZWs3?=
 =?utf-8?B?S25TQWo1am9jdmVTNXpOcGlDYlNodjkrZE1INnJlQnEyRDRpWnV0ZjRxaTVw?=
 =?utf-8?B?aXpiWmloZ1FBTWtDVytvMUxudnJVTWJ1cjk2QU16c2oyQlJsaWtseEtnYUg3?=
 =?utf-8?Q?nqIa/8QkwzhLMiFLsCV2w4rH3WSDMMdjqgYg9SPcAYBH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd798054-7db4-4025-3bde-08dd47805ef4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:04:43.3571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cg1S/R5rGxbt4P+0ESH/Pffg5jP6aSaLK95drv+uTSN1mKJtKncIfIp78J4JFAaJw+HDAQrSSeYstVwA+X956w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033



On 07/02/2025 13:38, Dietmar Eggemann wrote:
> On 07/02/2025 11:38, Jon Hunter wrote:
>>
>> On 06/02/2025 09:29, Juri Lelli wrote:
>>> On 05/02/25 16:56, Jon Hunter wrote:
>>>
>>> ...
>>>
>>>> Thanks! That did make it easier :-)
>>>>
>>>> Here is what I see ...
>>>
>>> Thanks!
>>>
>>> Still different from what I can repro over here, so, unfortunately, I
>>> had to add additional debug printks. Pushed to the same branch/repo.
>>>
>>> Could I ask for another run with it? Please also share the complete
>>> dmesg from boot, as I would need to check debug output when CPUs are
>>> first onlined.
> 
> So you have a system with 2 big and 4 LITTLE CPUs (Denver0 Denver1 A57_0
> A57_1 A57_2 A57_3) in one MC sched domain and (Denver1 and A57_0) are
> isol CPUs?

I believe that 1-2 are the denvers (even though they are listed as 0-1 
in device-tree).

> This should be easy to set up for me on my Juno-r0 [A53 A57 A57 A53 A53 A53]

Yes I think it is similar to this.

Thanks!
Jon

-- 
nvpublic


