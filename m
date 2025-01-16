Return-Path: <cgroups+bounces-6180-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6906AA132C1
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 06:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9158C18863E3
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 05:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79AC18C011;
	Thu, 16 Jan 2025 05:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="O2nh9jhG"
X-Original-To: cgroups@vger.kernel.org
Received: from esa18.fujitsucc.c3s2.iphmx.com (esa18.fujitsucc.c3s2.iphmx.com [216.71.158.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2FD29A1;
	Thu, 16 Jan 2025 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737006666; cv=fail; b=J0t9Ifj1odM0VQwWtAc/IRb98RJB3XHBqvJNjiv2p/j/laesna3ElwWY5/OABfeyBl+M/Nft9UCpluXGUJI5fmxGJ2ry1PuM6bM9F7yRNv7iDnGRIlscbSsYc1qo1xCqwLtmJ00FZf/uBmfb2rNcAmE0aM9PHPWhTIwyv5ootSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737006666; c=relaxed/simple;
	bh=ROmSdqwf0IoB4KubkSxzcqt3X1m8W6Jys8oRwN2IjTM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fl3JPJCtUPySb+pTIuQQC8liI8pQz8R2mXEzjsooDtRzOPmtbvon6StoulumIc34C+D70Kb7IjlOb/qPyoOlfEeEFYV6je1NcWgzmuOvY2osCWE6C9I2Zvrqm5LxWOcj08YbOIvTjxqLQSoJ+7XYwjKt9fCHVCxuW7FsHkVcLKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=O2nh9jhG; arc=fail smtp.client-ip=216.71.158.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1737006665; x=1768542665;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ROmSdqwf0IoB4KubkSxzcqt3X1m8W6Jys8oRwN2IjTM=;
  b=O2nh9jhG946ch/siCEuq/qc27NdFOaerflj/xI3xYa8QD4KvkRXIPJEt
   EsPIaW57eCRtcnnPM3+/+FtxQF/axjcAqGMx5m8eZ7WGODrjndQMTddI0
   2gxrgle0FnbQkf0nbaFjcNcfwrcvR8vPFT2EnssValx7cTa32TpIN0qOF
   jI7HOV0crSkv0+jj6KAVa7sb6FWNfLC0765ZMjSwkn3wSwNUDvNqv0E4I
   L9CqmFXZv2WV1/JkdBs/79gZUh1rMHoNFuaKuG7YsJL+S/8Vok9CCvkHS
   ljRbGH3wx2RVTa2Yv5s7NNXOTrflScZtJWUd7urYCRB75rMh3EttpwGo9
   Q==;
X-CSE-ConnectionGUID: nCvX/BoTRBiUpdDH6Dw54Q==
X-CSE-MsgGUID: tKBY1pqRSgGO9PdqDhZXpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="149044927"
X-IronPort-AV: E=Sophos;i="6.13,208,1732546800"; 
   d="scan'208";a="149044927"
Received: from mail-japaneastazlp17010005.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.5])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 14:51:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+GsD3JmTWhJ/j41rNavCyuzeM8BUl8soyc7XizXBWzdUtqkrPdPH8TpmqY/26wU/IDs400sLKBuSsn2iRA6zYX3ifgCjnb6T7RemnpnhN9gkPaFXTR4Rw9kATfmlHLzx1QNnjV9uC4RSAPU9GvkD3BXOhvl6UdxqtHSG+RHED3yOFQFFew0Y81J097Vwda6tAq8GrhBujsvjwqxozUSFM/1mfuM5DBZg6GaiwCFmGKbt9C7y1GWbcMnMILARJbhtEtIWhFms2CNmZ/6Z6zTZT8YD8WGnHvF6fSCPcq7nTW98TatClhW23Q9HUnzR3tuvXeI1/JuaVc2rSh/Oy3MNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROmSdqwf0IoB4KubkSxzcqt3X1m8W6Jys8oRwN2IjTM=;
 b=P1O9aSezlK9Xx0TISXoFVuGeuEMx7Wdq3sdRBhvZ1Ba0bYITfAt6QdIWXLYgJ8rNCYY1uplTQvWH209L/g+DT3QZK8beq3fnlOWzufgK5OgY4j0uuQUNZgwJ7RoGaj+pWes7jCJQnon+zaC5l/zTTLRjoUM3hXLaEMk7i7w8Qd5BBbZ2SsamH4CnpTp+5PPHGsf9wMDk/w3x0WweWna9BJ2RF4KFKNcSZT9j1IU9fiEPvYDtMXJjbrGU/w3PH1Lfq0pRAgAp2XIR9FQ80FGPZJDddZJxvi2YT6mVMvWqZN3st0Lu3bXviDt3RbvHS5VepgJjp1Jqbe1sB1XpgjpTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS3PR01MB10232.jpnprd01.prod.outlook.com (2603:1096:604:1e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 05:50:56 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 05:50:55 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Corbet <corbet@lwn.net>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
CC: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	"mkoutny@suse.com" <mkoutny@suse.com>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Waiman Long <llong@redhat.com>
Subject: Re: [PATCH v2] Documentation/cgroup-v2: Update
 memory.{stat,numa_stat} description to reflect possible units
Thread-Topic: [PATCH v2] Documentation/cgroup-v2: Update
 memory.{stat,numa_stat} description to reflect possible units
Thread-Index: AQHbZVca7HnVju8RR0uYmYTVv8vbIrMU/FsAgAPuKYA=
Date: Thu, 16 Jan 2025 05:50:54 +0000
Message-ID: <4e96a241-a996-4289-9ac5-dc1ff65cbff8@fujitsu.com>
References: <20250110123019.423725-1-lizhijian@fujitsu.com>
 <20250113010530.432396-1-lizhijian@fujitsu.com>
 <871px6bo3v.fsf@trenco.lwn.net>
In-Reply-To: <871px6bo3v.fsf@trenco.lwn.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS3PR01MB10232:EE_
x-ms-office365-filtering-correlation-id: 38a261fc-5ff7-423a-9638-08dd35f1bdf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NU52OW9jRXZwSzhlN1pMWVN6TEFNMkVQeHNSZDkwNFdJOHVHYWV2UTBjdEc3?=
 =?utf-8?B?alV6SWlRUkpBb1dsTDFYbzFTUTVzRHZtR3dMcVU3alAyVFFMb3hDaEwzWmJM?=
 =?utf-8?B?OVA0RUp5N0VhcHY4akpub2wxN2g0dVBRSzdkcHIwZUJFV0hMQmpVREtOb0t6?=
 =?utf-8?B?SXJmSmNhVXNRYUxaYlRuYXdpYmZyYUt1cjB3akNzTXM4Z3FnVklWK1AzZkxL?=
 =?utf-8?B?WU93MGZxNkZ0L0VCbEZYUWRxSnI4YWN2TTB3OCt6WHRoWlJCaEFaMk82ZlFH?=
 =?utf-8?B?ZngvQ084NUlLVmJ0SjZKWTM5VW9ncTlGUjZzaS80OHZDcUw2U1hIZ3lOTmpM?=
 =?utf-8?B?TFZ1cGRMb08wTWRVb1lMQXJOVjdkcFZHbUpoaXJYU1NyR0J5dHFvOWZOYVY5?=
 =?utf-8?B?M3dUeU56b0VSVTlZZFU2M3BzZTA4VmZPT3dSUTRCNzREVU9YNFdYbGE3aCtB?=
 =?utf-8?B?a2l6Y3RmcWJUSHJmWTc3VW92MlpyeGJ4eFN1azVaSzVWTDZmWGIxZzQrMmdT?=
 =?utf-8?B?cVMwUERobEE1ZlBZR3FpR01vVWlZY2s4TUk5bWwzMERVUEZYbFRLN0NhZTRo?=
 =?utf-8?B?RDdRa0JyRS9VMnZzSDQyalFOV2t6ZVJTK0xKc0RRNzd2Y3IxajdMZmFsYXds?=
 =?utf-8?B?WXFid0x1NWZTWE1QYndqOFZ0K2ZFZ08vM0pSOGltU0dDYU8vdkpCb0pDZ2JR?=
 =?utf-8?B?OTRObjIyMGxJVDA3bXQ2cmxmeEcvb3RpTWtPcjdUNnVBL3p5eTh5d1dPcnF6?=
 =?utf-8?B?L3hiS3RMZnMwaHZtanFLYUVKemNZK2g0cmZXYkh3T0ZhWDJjYlFTOWpnUVhO?=
 =?utf-8?B?Z0NMbllCQjVuck8rVEc3WkE4SkN3S0dGWlA5dGMxVVhvNndhNVMvczZjZVdW?=
 =?utf-8?B?Z1VGZjBXa2JVSTZXeEJUdDFBQ1QwSTMwL1J1MDZXMDU3SzZiV1dzY0hFL1cz?=
 =?utf-8?B?Y29HSTVYSmk3eWE2bkdFV3ljNUFxUEFpV3hiUm05SjZhSWY4aVpIWDMxL280?=
 =?utf-8?B?bHdjMVdpeDFUNVpxMkFKUlZqU1dLNTRvRlFVUUVTWWVWUHd4R1YrQzdxRDRx?=
 =?utf-8?B?RzRLSjdBTnFBTU1NUUJGakNrSHhIZHR1TDRWSFJaaERhZ1paaTdsY1V0NDRL?=
 =?utf-8?B?OTdoQTZUMVZING1zQTF5QVFDYjkwQkhnTHROY3V0L1dmNTVEeklaRVpxTHYr?=
 =?utf-8?B?eFV2NlhobW9vcGY0cXVaODdnSmF1dGhXdzJaQWkzdVF2RFM0clFSOHJPcjZP?=
 =?utf-8?B?bHBtNzZxY0FkTkNtdjBaRmJRbkVFK3FZWHpwU09CM2R5Y25ldm5tQ09ydVRQ?=
 =?utf-8?B?aVB1Sm5kRmE1TjdVVEdHMHQycElmMGNFbWJtK0k0QjVURlpHblo3cC81SjNr?=
 =?utf-8?B?MGZYWmtuOFoyTTJydzNiaFQxTElrbXBhd2NMbE94T2E1SmNWWEo0M3Q5U0Jw?=
 =?utf-8?B?T1dTUWR1ZzNmSDcyWU56dEtBUzFUOGhJbUltT3ZSakNYU0xRaEh0OXQ0bmVY?=
 =?utf-8?B?NFJNSE5KeEdhUndkK3JTNUVKV1FaQ09PMEltcWhEcDB6R085SmJCYW9qQm01?=
 =?utf-8?B?cGpyU3V2UktlMVVUWmdMN3J2N1B0Mkx1ZzlmTGVlWlk2TTg0N3orcFk4N1VI?=
 =?utf-8?B?YUxkdHIxLzBmWGpmanc2cUJmTWJOWE9RSjVtcUZqZStPWUJ6YnZCTEtrYW5m?=
 =?utf-8?B?dnd3SlR2QXEzZWVPWXlWUWhjVGNMQ2dKcTAwRGdoWVZKNG9wRitXa1JIeFd2?=
 =?utf-8?B?Mk9tVGNNTGdwelQ1Z290clFBTmRTVXlCd3U1NWRiVXQ3NmYzM1NIVXJjU2Nu?=
 =?utf-8?B?TUluc1JOTnZ5ZHhockVMV0lqUmtLMDltM1h5NDlqWWhXK2ptbkNyZnJoTUlS?=
 =?utf-8?B?ZVEwN3hidTdPS1d3RUk3K2Q1OTNzYm5EWVMrQkRtNU5jT1BGdlFFU1g3eTdu?=
 =?utf-8?B?cTZFcG5pcWh2SkNMNUEwclRCa2p6NnpTUXZyTElLNnFDb3ZLQlUvMmV1SHVH?=
 =?utf-8?B?aW44d1NWWUJnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUthVGdoVW5hbjFHMnpUcGtCbk1IMm5WaHltZGVZMklML2VqaVBQcVJjNHh3?=
 =?utf-8?B?M1RqTDh5Qm12VVdiZWQzRzBQUzQwczJMdVYwQzcvRHhCWTBPQ1VEa1VCWFM3?=
 =?utf-8?B?bmNRYWsrZUs4bFRMRHVoSkRBSndZSEFoS1kyQXF1L1FldWZNZ3FGRTNDUk04?=
 =?utf-8?B?NXNTc091eDRJN092NzYvN1p5Mkd1aFo4L29wdW1WV2pCMWU4VEVUVGNhMUJ5?=
 =?utf-8?B?TWl0bVo0cldGejR6eXowSnJkdDN0Njc1a3B1eVJuQ3NWR3QreURvRFJ4aWVl?=
 =?utf-8?B?eHBsdjBHWUpEMy8yRlRKY1l3MDc4dG1JbnZ0UGtmditZdWY5T08yeitXS3da?=
 =?utf-8?B?d0FqeHNDVWNJRk5vQm9ISEkyN1o3dUkwdGoyR25kekFsMHlPUWJDYTdOemJN?=
 =?utf-8?B?YkRvcS9vRWxKZ25WZUlFUEZuM2QrdkxBMUM3dHhyZXZrYklxbE1SWEpKZ1lZ?=
 =?utf-8?B?dEdRbS9UbmRHKzV1VHVMU2t3K3dYb1V0NktZbWp0ZmpiNVdoN2FweWNFUXVE?=
 =?utf-8?B?TnlJbmR1Z0JHb2NYVUc1Zkl4OFd0Qm1ZYmFtMVdlTWtTNDlMQ3hlRjFoU1VJ?=
 =?utf-8?B?cys2SDl1ejZZM3E3YVNFRUdQcUhUTG02eUFEUkV3VDJ1YmFndE12MUw4U1JY?=
 =?utf-8?B?Zkk5NTA3V2FzcGFXMXEyQUNhWndGZDl4THJpallXd1JNUFhCSWg4K0JyYXdu?=
 =?utf-8?B?WHZBYmdHZnUzWmdBNnJCaUp6Vk1JWStnL1g0cndDWG5oVFJDTW5lZDVKbDln?=
 =?utf-8?B?TzB1amwyVWlYaUM5Q29FTHlTbURhRGxvUkV2YllwWWtTS2FZRG04SlVXN0ZX?=
 =?utf-8?B?cTNBbkcxaFRubXZRdGtQY2NZaUtUS3VhYUl6RjZ0U2tneXkrTWdxUmE0Umhw?=
 =?utf-8?B?UlJBN0JHVkJRalFrWmdiMXZjeU9jUXptbk82aW9KeURBRUZSTEx2ZktXOExY?=
 =?utf-8?B?elRta3dXUzZhZFpKcVViWHNtbnMySmt1a3B0d1JGTnFjbkZhUW5KM0w1K1B5?=
 =?utf-8?B?VWVrMmRpSytjNTc4d2Q5b3pxSlRNNnlhdFo2T3JoSDN4anpGMkJBQjAwK0VE?=
 =?utf-8?B?VWxPY2ZRcHU4dWhHdkZRT2thc2Z0VDlRTWp5Q1ROdy9hUWJpQk9RSGowQjZv?=
 =?utf-8?B?WGNhQWkxb1pjT2N3ZzBtNHVidk4ra2JiZUJ1b3BBRnYrZ0JiSEY3QjlZKzB4?=
 =?utf-8?B?cTRVVkNVZjlFYWlBNXlaM0JkWFl6eHpRdDRndk15M242WTd3UlFRRjRYc1J5?=
 =?utf-8?B?aHQycHhES2VJUzJSY2VQZDNlYmdBdFBXdUVZczBaaC9SS3d4cEtYOTZzMlh5?=
 =?utf-8?B?aWwvWkFTUE9QakFPeTlSSDlkTHh0Tk5kSEhVQUNxak4rd3hRNXhoTUZKVmFq?=
 =?utf-8?B?YVkwdzJrbmhLRTJzWmd5UzQxQjdtK05DdVMxamRjYS9CWjdrU0N1TjJCeUlS?=
 =?utf-8?B?aXhzS3M1NEtTckszZEtaRVBYL1padkI3RVNEQzhPS2RPZ3E3NjJSK29xaDl5?=
 =?utf-8?B?SEcxa2xtUzFjeExRSWljZHMrVDg4WXVWSnZrZU5tTmFveE5YUHptbndadGRa?=
 =?utf-8?B?ckY4V2VuNS9URXVoVWZNYW5KdUdPVDZ5Q1NIQ0pkRm04Rm54dXdabmh1UWNH?=
 =?utf-8?B?ZXpWUUF5V0VvZDJtU2lZSHZKYXAzS3VQdmdDMG9LKzl2ZENyZVhlUUdWZ2p6?=
 =?utf-8?B?NzhZMEJFL21wdTdVMmdENWEvTm5kM0VzN1IwUlAveldBcFNGdEwwTHUvcTgy?=
 =?utf-8?B?NUZWcVFXMDVuanhoS05UV1RJZGZEc0dnMjdRMTA5SUVUMytFZjltT1Jiei80?=
 =?utf-8?B?OFJ1TVpiUHU3cmxtbUo0SnBpdFNHRCtuOUttM2ZHL3k3VzJ0QmpPSVkvM3pR?=
 =?utf-8?B?dUxiaG4xMUhaWEcvSlArMzFQK24zQUpNa3lVRDJVYU1WVm5jWTduWXZ4dW9i?=
 =?utf-8?B?azZnd3crNDZXL3lvV0M4ajZDUDJURDU1eVE4dS9zbmN4UTVkQzQ3Sm1vdTE3?=
 =?utf-8?B?OUI4S1hMbzBmekloMkRuVVZVNUYwaXJxbXg4dWd2bTRvT0p3aVIweFBXRnJm?=
 =?utf-8?B?cEtSeVBRdnowZlh0SFZlM3NRQmVFUGwrT2hPZ2ZyRXo3dkVWdzhjaTZaMXNl?=
 =?utf-8?B?WVdvVVlFYlo5SC8rai9JZzZpckZ5dkwyYmwySnVOTEpHclZpZUVPOFRhTVVI?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D64493B98191A945947951461CA57838@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SMgAdNmw8QkLvhwY1Qtpkzjm5YT5rYkq0QoFNh65ab68WMw77NNOn1D2hkWGocRTMb0wi6TQPRG0+HODuooRKAC1kDKorhYv+GaGMxoP1t+HPLPd/v+D062m3A3jTtN+HkdaeXoy3fLDyVsJ1WmVYCIF9KWJZ5cg9DmTEUUkGL5rheuhiiPugTk0NbdazYxNO3P11/JsqsBuEjB8L7NHUJAmbmmNQgwbm14k7T8y/YX0R05xZVOKyHWLD+3UGPT0ZH2vNG6hp9I/3gy0awRM2xD7h0Smkz6EMaE1N9q/eVxBwMUshATzI5ImL3qjMdOpxFUoI22nL1W0VS0Se2fUrWaOqJzFfwcxl8+hTJeXwLjHQypqXMyXZjhpbik4fQa4LCI1siOFIel0KbzUJUToPvE8Ndix5NawHpCyHqFg2AL1xqENHNPbosQVvWv6xqR0FbZJE9keJIyMFgmbNzRyv0FvNMeoElL+SernSzR5bKBBzbDvNDupu6qWWiCKyqp8SesZig2FTyPfo1fWDfyCBa6KCFXoY8tPdvuNflck01WS+ZTMz9TN8fT9q/HT72ZSHBDA2OD6odNyzGkZh48vDfhC1OAiUQZrbz1Hk4dLZKr5l/Gteh94M4qjyqivpxf7
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a261fc-5ff7-423a-9638-08dd35f1bdf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2025 05:50:54.6153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZRcz5+asxrP+p4cVge+Jf8j9v/+wF/y/98nICGHsqeDUNglQA9Vv5Y352Y4yP0dOrS2eXNvpiDh3rnJN882PWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10232

SGkgSm9uYXRoYW4sDQoNCg0KT24gMTQvMDEvMjAyNSAwMTo0OSwgSm9uYXRoYW4gQ29yYmV0IHdy
b3RlOg0KPiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+IHdyaXRlczoNCj4gDQo+
PiBUaGUgZGVzY3JpcHRpb24gb2YgdGhlIG1lbW9yeS57c3RhdCxudW1hX3N0YXR9IGZpbGUgaGFz
IGJlZW4gdXBkYXRlZCB0bw0KPj4gY2xhcmlmeSB0aGF0IHRoZSBvdXRwdXQgdmFsdWVzIGNhbiBi
ZSBpbiBieXRlcyBvciBwYWdlcy4NCj4+IFRoaXMgY2hhbmdlIGVuc3VyZXMgdGhhdCB1c2VycyBh
cmUgYXdhcmUgdGhhdCB0aGUgdW5pdCBvZiBtZWFzdXJlbWVudCBmb3INCj4+IG1lbW9yeSB2YWx1
ZXMgY2FuIHZhcnkgYW5kIHNob3VsZCBiZSB2ZXJpZmllZCBieSBjb25zdWx0aW5nIHRoZSBtZW1v
cnkuc3RhdA0KPj4NCj4+IEl0J3Mga25vd24gdGhhdA0KPj4gd29ya2luZ3NldF8qLCBwZyogYXJl
IGNvdW50ZWQgaW4gcGFnZXMNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpo
aWppYW5AZnVqaXRzdS5jb20+YQ0KPj4gLS0tDQo+PiBWMjogdXBkYXRlZCB0aGUgZG9jdW1lbnQg
YXMgc3VnZ2VzdGlvbiBmcm9tIE1pY2hhbA0KPj4gICAgICB1cGRhdGVkIHN1YmplY3QgYW5kIGNv
bW1pdCBsb2cNCj4+IC0tLQ0KPj4gICBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2Nncm91cC12
Mi5yc3QgfCA5ICsrKysrLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2FkbWlu
LWd1aWRlL2Nncm91cC12Mi5yc3QgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2Nncm91cC12
Mi5yc3QNCj4+IGluZGV4IDMxNWVkZTgxMWM5ZC4uMGE0M2JlMGMzMmQxIDEwMDY0NA0KPj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9jZ3JvdXAtdjIucnN0DQo+PiArKysgYi9Eb2N1
bWVudGF0aW9uL2FkbWluLWd1aWRlL2Nncm91cC12Mi5yc3QNCj4+IEBAIC0xNDI3LDcgKzE0Mjcs
NyBAQCBUaGUgZm9sbG93aW5nIG5lc3RlZCBrZXlzIGFyZSBkZWZpbmVkLg0KPj4gICAJdHlwZXMg
b2YgbWVtb3J5LCB0eXBlLXNwZWNpZmljIGRldGFpbHMsIGFuZCBvdGhlciBpbmZvcm1hdGlvbg0K
Pj4gICAJb24gdGhlIHN0YXRlIGFuZCBwYXN0IGV2ZW50cyBvZiB0aGUgbWVtb3J5IG1hbmFnZW1l
bnQgc3lzdGVtLg0KPj4gICANCj4+IC0JQWxsIG1lbW9yeSBhbW91bnRzIGFyZSBpbiBieXRlcy4N
Cj4+ICsJQWxsIG1lbW9yeSBhbW91bnRzIGFyZSBpbiBieXRlcyB1bmxlc3Mgc2FpZCBvdGhlcndp
c2UuDQo+PiAgIA0KPj4gICAJVGhlIGVudHJpZXMgYXJlIG9yZGVyZWQgdG8gYmUgaHVtYW4gcmVh
ZGFibGUsIGFuZCBuZXcgZW50cmllcw0KPj4gICAJY2FuIHNob3cgdXAgaW4gdGhlIG1pZGRsZS4g
RG9uJ3QgcmVseSBvbiBpdGVtcyByZW1haW5pbmcgaW4gYQ0KPj4gQEAgLTE2NzMsMTEgKzE2NzMs
MTIgQEAgVGhlIGZvbGxvd2luZyBuZXN0ZWQga2V5cyBhcmUgZGVmaW5lZC4NCj4+ICAgCWFwcGxp
Y2F0aW9uIHBlcmZvcm1hbmNlIGJ5IGNvbWJpbmluZyB0aGlzIGluZm9ybWF0aW9uIHdpdGggdGhl
DQo+PiAgIAlhcHBsaWNhdGlvbidzIENQVSBhbGxvY2F0aW9uLg0KPj4gICANCj4+IC0JQWxsIG1l
bW9yeSBhbW91bnRzIGFyZSBpbiBieXRlcy4NCj4+IC0NCj4+ICAgCVRoZSBvdXRwdXQgZm9ybWF0
IG9mIG1lbW9yeS5udW1hX3N0YXQgaXM6Og0KPj4gICANCj4+IC0JICB0eXBlIE4wPTxieXRlcyBp
biBub2RlIDA+IE4xPTxieXRlcyBpbiBub2RlIDE+IC4uLg0KPj4gKwkgIHR5cGUgTjA9PHZhbHVl
IGZvciBub2RlIDA+IE4xPTx2YWx1ZSBmb3Igbm9kZSAxPiAuLi4NCj4+ICsNCj4+ICsgICAgICAg
IFRoZSAndmFsdWUnIGNhbiBiZSBpbiBieXRlcyBvciBwYWdlcywgZGVwZW5kaW5nIG9uIHRoZSBz
cGVjaWZpYw0KPj4gKyAgICAgICAgdHlwZSBvZiBtZW1vcnkuIFRvIGRldGVybWluZSB0aGUgdW5p
dCwgcmVmZXIgdG8gdGhlIG1lbW9yeS5zdGF0Lg0KPiANCj4gVGhpcyBzZWVtcyBsaWtlIHVzZWZ1
bCBpbmZvcm1hdGlvbiAtIGJ1dCBjYW4gd2UgcmVhbGx5IG5vdCBnaXZlIGJldHRlcg0KPiBndWlk
YW5jZSB0byBvdXIgcmVhZGVycyBvbiBob3cgdG8gaW50ZXJwcmV0IHRoaXMgdmFsdWU/ICBXaGF0
IGluICJ0aGUNCj4gbWVtb3J5LnN0YXQiIHdpbGwgdGVsbCB0aGVtIHdoaWNoIHVuaXRzIGFyZSBp
biB1c2U/DQoNCkxldCBtZSBxdW90ZSBhIHBpZWNlIG9mIHRoZSBudW1hLnN0YXQ6DQoNCkluIHBh
Z2VzOg0KPiAgICAgICAgICBwZ2RlbW90ZV9raHVnZXBhZ2VkICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQo+ICAgICAgICAgICAgICAgIE51bWJlciBv
ZiBwYWdlcyBkZW1vdGVkIGJ5IGtodWdlcGFnZWQuDQoNCkluIGJ5dGVzOg0KPiAgICAgICAgICBm
aWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgDQo+ICAgICAgICAgICAgICAgIEFtb3VudCBvZiBtZW1vcnkgdXNlZCB0byBj
YWNoZSBmaWxlc3lzdGVtIGRhdGEsICAgICAgICAgICAgICAgICANCj4gICAgICAgICAgICAgICAg
aW5jbHVkaW5nIHRtcGZzIGFuZCBzaGFyZWQgbWVtb3J5LiANCg0KUHJpb3IgdG8gdGhpcyByZWZl
cmVuY2UgdG8gYG1lbW9yeS5zdGF0YCwgdGhlIHByZXZpb3VzIGBtZW1vcnkubnVtYV9zdGF0YCBh
bHNvDQpyZWxpZWQgb24gYG1lbW9yeS5zdGF0YCB0byBkZXRlcm1pbmUgd2hpY2ggZW50cmllcyB3
ZXJlIHByZXNlbnQuDQpUaGVyZWZvcmUsIGFkZGluZyB0aGlzIGN1cnJlbnQgcmVmZXJlbmNlIHRv
IGBtZW1vcnkuc3RhdGAgZG9lcyBub3QgaW50cm9kdWNlDQphZGRpdGlvbmFsIGNvbXBsZXhpdHku
DQoNCjE2ODAgICAgICAgICBUaGUgJ3ZhbHVlJyBjYW4gYmUgaW4gYnl0ZXMgb3IgcGFnZXMsIGRl
cGVuZGluZyBvbiB0aGUgc3BlY2lmaWMNCjE2ODEgICAgICAgICB0eXBlIG9mIG1lbW9yeS4gVG8g
ZGV0ZXJtaW5lIHRoZSB1bml0LCByZWZlciB0byB0aGUgbWVtb3J5LnN0YXQuDQoxNjgyDQoxNjgz
ICAgICAgICAgVGhlIGVudHJpZXMgYXJlIG9yZGVyZWQgdG8gYmUgaHVtYW4gcmVhZGFibGUsIGFu
ZCBuZXcgZW50cmllcw0KMTY4NCAgICAgICAgIGNhbiBzaG93IHVwIGluIHRoZSBtaWRkbGUuIERv
bid0IHJlbHkgb24gaXRlbXMgcmVtYWluaW5nIGluIGENCjE2ODUgICAgICAgICBmaXhlZCBwb3Np
dGlvbjsgdXNlIHRoZSBrZXlzIHRvIGxvb2sgdXAgc3BlY2lmaWMgdmFsdWVzIQ0KMTY4Ng0KMTY4
NyAgICAgICAgIFRoZSBlbnRyaWVzIGNhbiByZWZlciB0byB0aGUgbWVtb3J5LnN0YXQuICAgPDw8
IHRoZSBvcmlnaW5hbCByZWZlcmVuY2UNCg0KDQo+IChFdmVuIGJldHRlciwgY291bGQgd2UgZml4
IHRoZSBjb2RlIHRvIGFsd2F5cyByZXR1cm4gdGhlIHNhbWUgdW5pdHMNCj4gd2l0aG91dCBicmVh
a2luZyBzb21ldGhpbmcgc29tZXdoZXJlPykNCg0KDQpPZiBjb3Vyc2UsIEkgYW0gbm90IG9wcG9z
ZWQgdG8gaGF2aW5nIGFsbCBlbnRyaWVzIHVzZSB0aGUgc2FtZSB1bml0Lg0KQXQgYSBnbGFuY2Us
IHRoZXJlIGFyZSBxdWl0ZSBhIGZldyBlbnRyaWVzIHdpdGhpbiBgbWVtb3J5LnN0YXRgIHRoYXQg
YXJlDQphY3R1YWxseSBtZWFzdXJlZCBpbiBwYWdlcy4gRG8gd2UgdHJ1bHkgcmVxdWVzdCB0byB0
aGlzIHNpZ25pZmljYW50IG1vZGlmaWNhdGlvbj8NCg0KDQpUaGFua3MNClpoaWppYW4NCg0KPiAN
Cj4gVGhhbmtzLA0KPiANCj4gam9u

