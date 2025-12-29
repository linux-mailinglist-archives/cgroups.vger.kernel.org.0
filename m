Return-Path: <cgroups+bounces-12789-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B17FCE5F87
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 06:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C0C83005FC3
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 05:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D2C17B425;
	Mon, 29 Dec 2025 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ruRHGSOC"
X-Original-To: cgroups@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023122.outbound.protection.outlook.com [40.107.159.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07DF10F1;
	Mon, 29 Dec 2025 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766986342; cv=fail; b=peAUn8C/tv3Q2kuLHXAGhleriOvwQMeEL2rljFWiijfqcT6MKXa4DPXFNIisvX0AhvJPpYcPGtrPiZQ+w2E/zlgJu0PxiDP2p3DGCDKrqyl+XJZcTNyY324846RvCt3SC7gypSkRZb5aaQDIerA9f3FJMIVL8oMdsBWNLALFC2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766986342; c=relaxed/simple;
	bh=zJfBV9c/aI/VRKgaAv487Kds3cpY1Ctj851Xv89Qmm0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bn4PNRlD7aRIHvUpos3+b3B6TZQkVnz9UV9zqP2BjUoveI2EL1ntCzjThCHBKXpIXjskH8Nj4OmBe11qocjbFQfX58HIBdiy3jq1itrod/Vk4Fstt2bulG2PaZDJFnTxYkRX2MxQuSl4Yq7KRqFh/3TAbt0x6k2ZvQY48Ysk+FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=ruRHGSOC; arc=fail smtp.client-ip=40.107.159.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDdbP5u43t/fnPbckCrMYDpxL88JA/eVVg9ETLblJsJ53Zk7wRjHLN0znWLecraXS2xDi3GXU7NMMFHT00fRiFL2oHNkEQdtbcot1ECSYTJEfZugEoish+n8gGp4IpFt2l+8kfTH+qe02ocNgN+ke494VZEoqsjg3cjk6SoBBwDTBz7GLIj+Na4KIZhTX9p6PResDTVzqZ8lTJEQnkhrsrpTpw5ZyNxH6Y8dweEtZKj7MkFIftA+vdY3Et+GgTIyFp+44ihOtmfqs/XFZs7ET5kCGDucQsRLI6nXqLMt5qKWlM2YB4MBBk0QrdFIG2zsZ3AW9namJ3K9lfEh0DlW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gspwRkZSf3cEN0xunfEjzk/xw2Gl8LQLgNyvn8C0GPk=;
 b=tw9OPpYd2AjfRYwxEUvgjJYPrVQRBHah6cUoeUytwrLwVDdCquBlFTgvUD0Pru6R15JxqqQkq+UWMu2EOY+1DpmMyPW/K/VqjJWYmJnrYX67+lBSCm8ICDUqJMI6R0Hkxgoc0LBmjPx6HW1DOgu9BF4EgNV1xZgIeRlj2kjQPBLZO+4G4YZE5siqpvalsBpZUUMk4+yPk/6r+osRXF0DaFvUW36qxKT3y6/0QE/C7cGkDueRgAX8v0LSeVL+NU7AMh/RWTkEPdjAszxYME0Uiwc1+Mcm7XLHIwDItykBIaATaFUptgOaaF99ivO59oZBhrOYNLx4BGli/o1fuG3BQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gspwRkZSf3cEN0xunfEjzk/xw2Gl8LQLgNyvn8C0GPk=;
 b=ruRHGSOCMLfJeJpsPrZf0C4gGB6Q5d0NdiMLjWhBxeAaDplAHYVsSsnPoFO0fOt9JpQkEBxjOLP71aL9n+86fNhpiYWS8fKF2hH32Px+F/me+LVkRj1CuEc9GXI6KDe78lwJ2TsZM2a0vcP9TgfvWj+t8QUdXh/wgOQQps2D7H/M7ll00/H8s1feb5bywqNSFAdUkaSYMoFZYXZV6V/ml98Q/IDRiCiDD7U3nssCJ6uGpEDRnRtGQf9mtEsOag4pSSle68Utr/DM3/SpWQWkTz1X0qjwfVaDnHaqyX8Z7uWBNvnbQEau/kkudRqftjd8RLHGljz/TRDoqTWs45htRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AM9PR08MB5924.eurprd08.prod.outlook.com (2603:10a6:20b:282::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 05:32:17 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::3470:51d7:36e4:36d2%4]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 05:32:17 +0000
Message-ID: <80d36215-de7e-448c-85ea-9e848496c210@virtuozzo.com>
Date: Mon, 29 Dec 2025 13:32:11 +0800
User-Agent: Mozilla Thunderbird
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [PATCH 2/2] cgroup-v2/freezer: Print information about
 unfreezable process
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251223102124.738818-1-ptikhomirov@virtuozzo.com>
 <20251223102124.738818-4-ptikhomirov@virtuozzo.com>
 <aVBjDYPQcKEesoKu@slm.duckdns.org>
Content-Language: en-US
In-Reply-To: <aVBjDYPQcKEesoKu@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0033.apcprd03.prod.outlook.com
 (2603:1096:802:19::21) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|AM9PR08MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: e53b7f74-744b-4b70-2e64-08de469ba14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXY0TkNMb0dhQXp1N3NySlAxUDM5Y0IvTllrU2c5dHpROFdIRHAzTkxHVjV1?=
 =?utf-8?B?VmFBeUM3QWpPMnorN2lwSG85a0ZEUS9LaGpWUVNzNUtXclZ4YVZ2Q1p4UjJh?=
 =?utf-8?B?b04wUGVPNFB6Nk8xOFpiWW55SHlLaGhOc1dOUHl0NjVZWTdRL3V0d2Nmc2Vq?=
 =?utf-8?B?QURyOVZtWGlycFR0STY0Rm80VVV3NzZIa3FxVUh5eHl5bEVRaWY2b3NTK2N5?=
 =?utf-8?B?SHEyc0Y0ZkpDRGVNdm45WVhObEhGSVJmcERvNXYwdVFVUGhTdHV4QXcyb3NP?=
 =?utf-8?B?Q1FTVjlBeUZmdXU3Y0pOVzhrT0hoZzk2ZUdBQnBVTWFIN1VkWlo3WTJLbmZ3?=
 =?utf-8?B?WWlwQ3VXVVRVN0VnNVo1REs2U2VtNHYvM0lDRG0rZVdGWk5PUnhrRjZSUHZK?=
 =?utf-8?B?WUVMczA5QWdWTEx0bWFSckhRcS8xVXpmQ2ZKeWpvMUNFd3kzc0RvSnNGUnBG?=
 =?utf-8?B?ZElzcmIzbll0dHRNUkRENGZXWmQ4QWtwMnhFMTJiVWtmRVIrOVRsR2FKbjNK?=
 =?utf-8?B?UlBvdWQrZmhveFFUY0RrM3V0bGhmNFFNYkpWZDVtckFtT0o2VWxGNHJwemJB?=
 =?utf-8?B?U2ErRURma0NFRmdrSXM2c1dPLzV0Z3MzTmxJVE1FQitTc0s1cUFmeHNHdVE1?=
 =?utf-8?B?amozbUpjTWh6U2ZYbEFTQlN2YTFtbXpGT0ZYbDFXMVRPZC9rbC9MaHdxbWE4?=
 =?utf-8?B?Q25CN1RCdUVjc2Q3ZDQ1a3RBd21lMjNpS1RWTHZvNWk5YnY1YUU4c2VtSlhF?=
 =?utf-8?B?Wm84d3ZyQ3hvVHZtV1ZHK2FxdnlCVGphc09jS0JUV2wva2prVWdsQ0o2YlFo?=
 =?utf-8?B?Y3hXZFNRWU9WdmFjT1oxeDVjNUFSc2ZTbCtGS3NUVDI5Q2RFUGlNY0lObVVV?=
 =?utf-8?B?L2FvaW5zSEZ4blNXeGdNUmFBQmZxMk5JWDZScWxRdEJVYUVLanBSSzlaUTlU?=
 =?utf-8?B?NU1BNm00a3lTU1NQeFZFaTBycktBYzJSZ1EycnZBVzBNVHFWcGE2MnFEMVlp?=
 =?utf-8?B?RzFCU0hjdnlwOHlFcnhCMUMvS3JLMUVBUU5jOXVqamxqMEZNQkkvelB4NmRJ?=
 =?utf-8?B?SkU4dnJRV1czYVVmZE5oRms0d0ZNQkdCdG0wWUZsa3RnbmpWWG1VUEY4L3E5?=
 =?utf-8?B?cWJtdDdROHl4Nnd1eHlFTVVDeUNmM3FUY3dXR0FhNXpQQUhZMGp3TXk2UXFB?=
 =?utf-8?B?c1AyNTh1MnFwdnd6djdNQjZ6dTh3bUM4RVpGc0pmTFo1bXZtYkhzdlYzdGdj?=
 =?utf-8?B?SnpsRUdjcXUrTmhoblVkMUwyTGFUSUQyVFFkVUhMVmUvYm4xbHR6Tyt4QTM0?=
 =?utf-8?B?Qlgrd1lVeHhrUUxtNlRUMHRZUHBhZ25yVWVQUEdYLzZEZko1SnBhc29QVFVU?=
 =?utf-8?B?eTV3TVNlb1p0cVFFWHZKNmV5Y0FvT1RoT21Lay9OUHo4VXpnSjF1YjM1MC9a?=
 =?utf-8?B?K2FkeWRxeUR2MW55N1JEMllLbmFlTHpOL0ExMFBveVFianlsT3h4YUFxcFRy?=
 =?utf-8?B?bDZWWnhoVHpWMjZmK2FwdCtGVXppdnFqV1pWTUF2aE9XSjVzZDM1dEN0ZHJ0?=
 =?utf-8?B?bUphMDU5OTNoWENiQTgzZGhTaDhFWlRtcGtVUnR6SjZtYkRRQy9jUytWaWU0?=
 =?utf-8?B?WXY4SXV0ZDVGVlVMTFY1c0VqdnhTQmdteVRMdlVOeGpXY1ZEclZ1VXVkNWNF?=
 =?utf-8?B?L3V4NGdjb3FEa2g4WDN3cm9WQVhOSnRVTkUzYXdncTgzTllpZGJrdzdCNFZY?=
 =?utf-8?B?Nit1ZVhqaDFnSnM2cU44cVJkYWw0NlFFejZYbXNWaXBKL3R2a2FZZkROWm9o?=
 =?utf-8?B?M2YzM2d5bkNGVGtmZEtYQ3UvdXIwQkd6NWd3WlhVZDBvT0JXMCtmekgxQkd6?=
 =?utf-8?B?Vkg3Q2VqV0xjdlVTaXQzVVVmRXpnWTY3TE13RlFrWjVGOWRYVm5wQjN6VUht?=
 =?utf-8?B?RkFyNHM0Q0ppNzU2YldESzBPR1g1NkkxNTBEY0Y1QUFiNU9wWTR3bjV0bXU0?=
 =?utf-8?B?cWRHcTEwTkpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVJCYnI3dE1Lc2M3eUwwUytNc3VMNXVhOFJndFRHNm43V0ZuaDNQZ3B1U1RG?=
 =?utf-8?B?RWZITEphbmNiYk00NlcxRkE2RDhFM2NxQ1pFTXNaNC9TZ3ZTMVM1dWp0Rmoz?=
 =?utf-8?B?b2V1OGVXd0c5NWJiU0FIdEtCMTYwcE04bitVcVpMNWdGaUFLOVFMRFlpazZR?=
 =?utf-8?B?R1JMNUg5R01qYURMYmFhN3JOZUR3TlB1aXhFU3JrVlY3aVhUOWFtVDJxNmt2?=
 =?utf-8?B?VWRZZnJEanVpWUppaEpLWHpON2prejZMT0syR1ZMYkRwRkpmSzB3TGZmN1da?=
 =?utf-8?B?SjJibXl1eXpwTEx0SWZ3NjVkK0xYMVp4Z0FpMkRrWDN1VWRtNHN0VGRJNjhv?=
 =?utf-8?B?V0srVi81K1hiczhHQ09QUTRTYkh6ZTNFZmpDYVhVc0JrTzdVa0o1cjhQY0hq?=
 =?utf-8?B?aEZFZTZNT0ZZbGZSTnVOYWpibGhlUGtyZERiNnhBNzZBTUxYN2JnV0N4WXBq?=
 =?utf-8?B?RUxtOXMwS2VMODliSGpmNFl6UjZXenJBNjQzSjRWZmZtYThYb3g3dzJvaWta?=
 =?utf-8?B?RXZ0c2xYdzBsUGxpMnFaZVMvQW13SUdxVEREd2VJMG8zQnUvdmlIcFoxNVRN?=
 =?utf-8?B?dHAxYmFwY3R3UDZQNlJzYUs2enJEVlZmUkV1Z0E3czBNVVk1b0Urd3oxNlp5?=
 =?utf-8?B?b2VqMnkzVnVwSU5aVTEvamczaVQveXVIVkJOTWNwcUlHWnVRSk5XNjVDN2JB?=
 =?utf-8?B?RWpCcC9pcHFvS1laRzNiUzVVNXVzeTZOUE5xMGRSNEJLRnVmQWV1OXZYZStM?=
 =?utf-8?B?TUdoWXpya00wRktTSlR1ZkI3UWQ4L01mRVdpRjVPUXM2REpGNU5kMDBLMWVQ?=
 =?utf-8?B?ZDducUVidHBpYzBUMWIrc005b1d6SXdYR0s2bGFIaS9RcjJFYklhUXdrbEtQ?=
 =?utf-8?B?UUgyVlNINXl0S3RpZmo4L0Fwa0grK0hLcDVyWE13Vk5jSDM0NXpld3NGVVJp?=
 =?utf-8?B?QkdKL1l3Y3UvcWhMM3M1cmI3TVhKQ1pOeSszNHI4VWJnVWV2aVdQRWJBVThq?=
 =?utf-8?B?ck5tTWJKNVBHVXhldGZiWEFoTDlBQmZySlRvb2lBRFdQclhBcUlONkthcEdM?=
 =?utf-8?B?bW85UE1aaHF1WC9JQjJIcWlxMUhWZUF3NGdFRXVpS21scytGemM5djJNK3E1?=
 =?utf-8?B?WWJZN0g1K2JqdjFhUjdiajlLeTVsOER4RVVxTTRCamFqc0duY2ViK3kyVHd1?=
 =?utf-8?B?aXEyeUsvZzhCa3IzZkFMU2VDYk4rdWtoSU9WRWphdnNHeS8zM1UrdDhRcTEv?=
 =?utf-8?B?SFpua2kwUGJRM1ZQU1o5VWc5RklDUlR1Slc0TzFqMEpUOVB5RGtKSlN3V3hj?=
 =?utf-8?B?R0Exd3FBZ3lnRGF1SCtodjhnRWVYejBNcWZWTndzUE5LbGtKVWtiUmN1V2Vz?=
 =?utf-8?B?UEJaZFd6WC93TlFDNnhpTlhhN29HVmFNMlJNVzdGUk1Sc2JwbWZCdlVDWU0x?=
 =?utf-8?B?ZGlyQnowbGF5RzFheDdhMlRESythNXFaRG5JZWdtZ3g3QloxMi9ocVdhejRp?=
 =?utf-8?B?WkJIYWlJYlByYzJsNU11VW9vZnRoaUVUYWJ2alp2UXZKa29IV0NqRFFpVy80?=
 =?utf-8?B?anc5OFBvOGl3ck80dWVjb1dkVEtGdDM3bEVrQ3FKQVZoMnNSd2dKR3RFaFpl?=
 =?utf-8?B?ZFV5c0w4QnFneDN2ZXQ0amVBWlJWL1lZUk5tRzhoeXNUQmFjVE5aNDhJdUtI?=
 =?utf-8?B?YWRiY3U2RmlMTHozVk9oZ1V6cStFNDV5YlhxanV1TUlJTERGQ05Vd0lxcDBR?=
 =?utf-8?B?dHRLMmc0QTI0UHZudHA4Q1RoWmlKMVpTSEFRdHduV3NzRWdrbjVtZ1NNclJN?=
 =?utf-8?B?SzFwYStQdHhQZlI5OVZyUnhtMzFMUE5iOFVzOFZtQ25BL1ZORlZIS3d4OGJI?=
 =?utf-8?B?VGc3OVlyV2FiTXBnL3M1cEhYcGFQMi8vaFFjVUp4WmdRZmFZQmFGd3lueGFM?=
 =?utf-8?B?bVIwUnVZN0VMNVo5MTZ5UjY4TTdxQVpuajNXK2hiRmxTbTl2aXd2bUprbm9W?=
 =?utf-8?B?VHY1dks5KzBRTUs4Z3BZOWhjK01IUkNxT005UldrOWRJcWNMOHdSdU9DSjd2?=
 =?utf-8?B?amlacENRWlVVanBhYTlzOGxUbllhTXRUaFFMV0xPNUoxU01qbUFxaHMvcytq?=
 =?utf-8?B?aXNSS2FxcTRKMFNwWVkvbXE4VjVrQkJKVWU2Tjc4ZDZ0d3FnUUEyUTIrZ2FL?=
 =?utf-8?B?bVBSQXJtck9XQ3NiWE5ieWtUQ2x0N1RZQmt4alRETVpwRXBMZUFsUjNLVnFi?=
 =?utf-8?B?MFRPNmFGSTNrM21INERjL25MbzF0Wit1dlpYVzJSUUVmenJUOGRWY3lwZVNE?=
 =?utf-8?B?bXl5N0EvUkZ4bFBVdU5wMUtwcjZEYnRHOWVXNzZ0eVNBRXNxUDc1UGNsL2pT?=
 =?utf-8?Q?ePrWgj6m1mTr1moacBAFEr7ox7NVpPJMYkOnz4HuE3dwI?=
X-MS-Exchange-AntiSpam-MessageData-1: IYaW5V0bq5pa48DW0mLFvb/Hn+SOj2yZei8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53b7f74-744b-4b70-2e64-08de469ba14c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 05:32:17.5745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yDZB6gXz9eglOXTSaJdDMdMPgKfF8q+8dbzQciyFlXbnGiQh9NTb3PmDpgZVIvauKbUIdD/9FiIy8ODavMNIdbqA5MlYVxylLMNhLkRWTiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB5924



On 12/28/25 06:51, Tejun Heo wrote:
> Hello,
> 
> On Tue, Dec 23, 2025 at 06:20:09PM +0800, Pavel Tikhomirov wrote:
>> +static void warn_freeze_timeout(struct cgroup *cgrp, int timeout)
>> +{
>> +	char *buf __free(kfree) = NULL;
>> +	struct cgroup_subsys_state *css;
>> +
>> +	guard(rcu)();
>> +	css_for_each_descendant_post(css, &cgrp->self) {
>> +		struct task_struct *task;
>> +		struct css_task_iter it;
>> +
>> +		css_task_iter_start(css, 0, &it);
>> +		while ((task = css_task_iter_next(&it))) {
>> +			if (task->flags & PF_KTHREAD)
>> +				continue;
>> +			if (task->frozen)
>> +				continue;
>> +
>> +			warn_freeze_timeout_task(cgrp, timeout, task);
>> +			css_task_iter_end(&it);
>> +			return;
>> +		}
>> +		css_task_iter_end(&it);
>> +	}
>> +
>> +	buf = kmalloc(PATH_MAX, GFP_KERNEL);
>> +	if (!buf)
>> +		return;
>> +
>> +	if (cgroup_path(cgrp, buf, PATH_MAX) < 0)
>> +		return;
>> +
>> +	pr_warn("Freeze of %s took %ld sec, but no unfreezable process detected.\n",
>> +		buf, timeout / USEC_PER_SEC);
>> +}
> 
> This is only suitable for debugging, and, for that, this can be done from
> userspace by walking the tasks and check /proc/PID/wchan. Should be
> do_freezer_trap for everything frozen. If something is not, read and dump
> its /proc/PID/stack. Wouldn't that work?

Yes, I think that will do, Thanks.

Though the trace printing in /proc/PID/stack is a bit less informative than show_stack(), e.g. for my test module (https://github.com/Snorch/proc-hang-module) the stack in /proc/PID/stack will be just empty. (I guess it has to do with the fact that you need less privileges to read /proc/PID/stack than dmesg, so you can do a more informative thing in dmesg).

> 
> Thanks.
> 

-- 
Best regards, Pavel Tikhomirov
Senior Software Developer, Virtuozzo.


