Return-Path: <cgroups+bounces-7781-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C57A99E75
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 03:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4BC5A5564
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 01:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACCB78F59;
	Thu, 24 Apr 2025 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Dc1bOxNo"
X-Original-To: cgroups@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012051.outbound.protection.outlook.com [52.101.126.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B609C7081F;
	Thu, 24 Apr 2025 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745459233; cv=fail; b=ufVZRNtHn2ygexOa8x/MjFkSVN+2BjZqvf7Wg0zyrjD0jg7upXIcQ48fZ1nNGrFUdwlbn8iPSG4F+nOX4j7RDVrHrQXkildU744cofRGTLQr9rDFs2zHMRgnzlxlXVeKFnc+sVMycLoAUwvEh0Nl3vXBkU5R9jy7Bwc9tF80dOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745459233; c=relaxed/simple;
	bh=G/Paxe82fWpmUMPElGP4c7s92NiRUDGz1tPb5X3oWRA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lBVVyUX2YUvQuxOnkRVMlhuByDO8CCNCSDGB25/u6lmCO8uzSNTFUOq5QGH7dY31kbMyeZ9kl1froyrhiy10pW1I2HW9H92nj5Isd6GBM3/ZqPlu3x+tGwY4DrRdzFr6SDcseHBZJx1bBPLyp8D4LvTKPP3dI8DtEOL3D2VR4r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Dc1bOxNo; arc=fail smtp.client-ip=52.101.126.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymMpeSAKENl3OwPesbr1MPzdHcdLznyppJAwpHRbbiIedQvLrrr5SwILnnUOC17yBRq5hzqNdJDzuSMlmY9LwdtzwngRqXDOvl7iSCHzAir/2WTZUFWdEI0LjKIPyYzSuin+YUeDtk2rqf4IkwxukG4En2XoKKx/5rrAppMGVMtB9TAOu36mUKm6V+xO6RcT3EUvB4mO+UVM+lg/cBTkjJMzyF8xOD6gVh+OhYDKhJA877oLEmNqBOIWG7NWVXTUxH335/2gePduNm1IOajpQ79yk7rnpY7w88laCucp9HhWqnAtv8+Hsr/GSLhV9SkS5m0MuBF8YiJfew36hM/tkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06TfetUtpHntN1owasQNt/PGqU1cxfifuMBviVboOcc=;
 b=ZzijJ/k1+h4XkyqV6HEpcsl4mzetpcI9pRKxsv42sPhzLAktcmg7L8o/h5N1n87PKpSOASl6K8SNCqIFLtqz40DhUjx6eF3yKnKym6sMDxwOO20DEKcwwxJKvTjxvsMC3Kyl64wqRd/SstwH9hrlI+B4PxagTjjvDRZBz3dDD7uLpThpyvAimWAksO10J793GeTLIvnPOvPfHa+hemgEutkBfifM6WWR+31pQTEOxSDVlDZZx4oQngb/9X/I2ei3kvBPDK78UasR+qY9b53/ajRVQ+Fx3N56ogaVD0LZ2evh3JPkc4pd3+tmqdWLE48uz5tjc+LcpT77+s6LgAwfqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06TfetUtpHntN1owasQNt/PGqU1cxfifuMBviVboOcc=;
 b=Dc1bOxNoTAUk1w8JFiUjqMmrWi2SaOkocWNxw9aC2DtLrKX/1HEn3fUP0IE6Y1lT5QgZKNsPQa9uXIoLKZSruxaAtvfb+Fa28UbArwARvtw+DO6HgoiYxz84l7yxnz9mlSZO5ZSQqa3ttWZwn7VrnY+Kpt8bQo8FXFZ5ki3S1VACtRX9N/QL6MTgF2pCh9FCnCZbkv4WrYAe9NiwQxCmaGp3qVaIim1IzMTe7/2WFEp3LmYNW8M0rMyqS+kdNwKuPCLMFlK966hf/IFB2o/gep2TewyM61U1v/C22YBN1Kc2eGOh0X1oQ/e4b8rjqFqhJfRv5H+DAJKMzqlOtwBgTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TY0PR06MB5563.apcprd06.prod.outlook.com (2603:1096:400:328::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 01:47:05 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.8632.036; Thu, 24 Apr 2025
 01:47:04 +0000
Message-ID: <7aa9ae65-12a1-4a26-9405-216e6b00b6d6@vivo.com>
Date: Thu, 24 Apr 2025 09:46:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/memcg: use kmem_cache when alloc memcg
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20250423084306.65706-1-link@vivo.com>
 <20250423084306.65706-2-link@vivo.com>
 <20250423145912.3e0062864b6969b3623c8ff6@linux-foundation.org>
From: Huan Yang <link@vivo.com>
In-Reply-To: <20250423145912.3e0062864b6969b3623c8ff6@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TY0PR06MB5563:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d169c3-a692-4498-8d89-08dd82d1ea02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGJMMFhJeUZHai9ldHJpc2xTRXBBZTRRUVAvU2JyR1V3ZDRzOVFKeDA3bGhp?=
 =?utf-8?B?K001UTNxaU1PWjV1WmMzNUVoV2dXUTNibmsyK3QwSDhqclNHS0tLcmtMMHdO?=
 =?utf-8?B?SWdWNUI2RC8wdGlHS01OVldoSmliNlZnZzBrSkFuL2ZTMTZBOWU2OWpOaW5o?=
 =?utf-8?B?bHBmdzFKZDRaVC82SmNPZmlJcEhGeHdhdkNJZzcrQ2RMTkVONUJ5Q1c3VUxy?=
 =?utf-8?B?RzF0d0t5cStVbzh5d0NoVy96bWNJYXY1Q1VBbzNJcC9PeGliZkpXamI3cnVO?=
 =?utf-8?B?aS8vbWJJVDI5N1cwNHd1ckhlMXFDQnFzalVFR0ZtRjR3Q1VMM1JBRy9VZDBj?=
 =?utf-8?B?M1pOZjhNYzlVNEh5UGxqVFduVHQ1WDRDREVROU9iYWJzKzB6RjgwY0gyQ0VZ?=
 =?utf-8?B?UDlab0RmZHNWT280UEp4UHlHUFZZaTlMZ3gxTDM0ekh0ZEFSSUN0bEJGeFlp?=
 =?utf-8?B?b09EWnYwNGkzQ3BwN3YzVElPMTlBN3J4S1VDL1o4YjVlekhpWDVKUmZTYWJ5?=
 =?utf-8?B?dm9GLzNBNXVHbFRGdkZIQnoyTFlCK1NSMndsbFZ0MTVFdHBibVdaL3p6eUVX?=
 =?utf-8?B?MFBsU29jZ2pIeE1TZGwyQ0dyRnZ2Ulk4R2NrRlg4RFVmS2lueWtLakNLSVhz?=
 =?utf-8?B?RXJjdW1iS0ZUbjZuVC83UjBybElMT2N1SDFDaWMxeTNhRzJPNDFWaE9YOVF3?=
 =?utf-8?B?cVpCQUI5eVZCL0tFbzJETldQYnZneTdMK01SMTNUUlRxbVFaZWJFcy9INTVB?=
 =?utf-8?B?YUU5NDFyVUUxWi91cWhneW5DcUsrNm9WNk8xTXdmZ205V2o2eVVKU0pnMjZy?=
 =?utf-8?B?ell6N21VcXZ4K2dWc1ZwWFFLQWQ2aVFQRW9vaEYwQWh5RVVBa3RIZXlHdXpk?=
 =?utf-8?B?MGtra0FNS1ZZalYzQzFHUUJ1dWtSV2xvbUxJcFZ5bE1tSkRNMm16SFltMUZU?=
 =?utf-8?B?b3VMY0JtdVpEZXB6d0thc3luSlM2WWJEdVVYNnpLcGVuWDJwaC9icjBiNGw1?=
 =?utf-8?B?ZjFjTGFGcytkc0h2SWw0Z1lPY0ZRZWVtQTRzY0ZSNkN3QW4yQ0hQaVFPeHpV?=
 =?utf-8?B?NWcyUE1aZVBueG91SGJnYTB3R0ZBeXQ0cmF4SjdmOFdJMVE4L2JXLzlad25r?=
 =?utf-8?B?YXNUTDF6b0hvQ1VEZmZyaVdjUTZqWEZDTzlNQWRiY3lLMitEM3dhN01ibStl?=
 =?utf-8?B?Uk9SZGJJeDFzbTFIYWRqdWRQWStBRDB4eENvTzA5clBXemhzY05kYUVhbkZX?=
 =?utf-8?B?TG0zbFhZWXlsMFBHYkk3dndOcXN1amVadnAvbVFuZW10emJOTFNkbXcyays0?=
 =?utf-8?B?SFpxMExYdzNlZ3RyZUMxVTdmdkNFOEc2R3Fpb2VLRmJRdHA2MzF6UFVrSkF3?=
 =?utf-8?B?VjVpWXg4TWVMeGMrMnE2cWduOWg2cFU3anNxaktoakJOTFpwZ0tGdjBhV0Z2?=
 =?utf-8?B?aXdZRzNRWWNJemRBR3NsNDhHK1JZaHNyL0phU1NLbXIzL0NCNVd5SUdSWWE3?=
 =?utf-8?B?Y05PR2JoZ2ZIeEQ3em5vU2Rsb1dFdnN0S1B3Y3ExVFphUkJWcGJKOHVoUWQ5?=
 =?utf-8?B?S1pzbU1aTXhoT1ZoSFZEQldvaEVQQlQ0ZC9LWWRIRzg3Q3A2NmRXR253byts?=
 =?utf-8?B?NFBBVnhhcnA1T09KMlhqZ1k5VEZxMUhLQVUxT0hYdFpzZlFxTXF0bVdlNHlw?=
 =?utf-8?B?a0hiOTJxSnVEempOaThJTUhibXpUcHhMSDlWZlExZmQ5WHFvQVZwRWNld0JK?=
 =?utf-8?B?TjdjVEpkQVVaSllKbTlsRFhBZzVlZGgrTGhLdXdGcldWRHREUk10UHhDM3Jz?=
 =?utf-8?B?Nm9pNVRNemxObzlFMkVIbTN5eUNnMk1HVDZ5ZnljRG0zN2FLQzJWQUE3QlNq?=
 =?utf-8?B?UktRd01VMVRRUStsMHVIVGVXMUp1ekdzSzFHYlhzdDFuZDNOVGF2YWhCcDZJ?=
 =?utf-8?B?aEtIc3cwODhHaU5kS1pSN3JKWFV4cEpyeVhDQ1RyTjZOU3lQbzErVUNTM05B?=
 =?utf-8?B?K2ZBUzJSaWxnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnoyTC9KR3ZyWFgvQ3dRV0xzUlB5Qi83Zk1mMi9HZEZBN1ljbHVGSHBoR1Mv?=
 =?utf-8?B?OGoyTGZ3VHMvNm1UTVhPMk13N0ZNUGIwZkhzNDA2Rnp5TEgvdTNFMjhORzA2?=
 =?utf-8?B?a0k2RkpmUWJjdXJLajNuRXR2MEVaR1VsZUhVRUpaaE1nais5NHRDVHZiWFRG?=
 =?utf-8?B?YWtwTVAxTjVTRjM4RFJtNVV2bk9LWDMwTzYxVmVhU1NhblF0VG12VEZIaFZv?=
 =?utf-8?B?NTV2T1dkZGdTays0c0YvZGtWOE13S0VKczNxcGpjMTVzUUUxUmxYalQ2U3Yv?=
 =?utf-8?B?cWI4T3pGVHU5cktLc3JOR25oNEUyckltVnBhY2p4NmJNTlRuTzBpVnZUZzFz?=
 =?utf-8?B?eDlidkdMaEtxRVdGckRjU3lvelFnSkFQTThvNG5uZld5ZmRpNnlOYWZ4bEFI?=
 =?utf-8?B?dW9FdkJ5YVFPZmVZRkVDTHpHOVBqRzQrUm9MNVkzcUp0Ui95T2tmWUxVQXFi?=
 =?utf-8?B?cHlLZWdWVUh5SlcyR09LaEo4RWlpY0ZkRGo4eGxja256ZUhVREpFRFI1d3JO?=
 =?utf-8?B?RVoySDc3N2trUkRtUTAyaC9TQjFzbk1mZFIzWTRObUdwZnBhZ3BoZWhvY1Jl?=
 =?utf-8?B?anBoNkh2WHNxL0FHZ0UreU8zTWg0aVNlTWh3K1ROQzV1WG5SeVh6Nm5pRUUz?=
 =?utf-8?B?UThhYWY4dkxpTFZJTWxNN29LKzc2NUpwT0Q4SFlxa1NwV3lLenpzVTRkRXkw?=
 =?utf-8?B?MVpLcm1DUDlRQzlwTUFJZEpZZ1AxNEtCamJ3emFBUkEyU0dMUkowcWgydlVw?=
 =?utf-8?B?QkhtT1lJSFJkdTVjSVNlcEdsVWlEWEZZNnRwT1IybU5SbEhBWGk4T2xrdmJx?=
 =?utf-8?B?bHVPa3ZkNGJ1VXoreXlYTkpWUGMwVjRqUWFtY3NaVGd1S1EyNHEvWW0wcmxw?=
 =?utf-8?B?TVJwWDZod2d3OUREbjJNNGlFNkxXSytnbXFZR3NNcmJ4R0pqNmpDUUkwQll1?=
 =?utf-8?B?YWFhQmhLVCs2MXlJcjlVdDgwUWl3OUY3Z3NhRHhRc1d6eExsaXBkdXZDYmd4?=
 =?utf-8?B?anBydTc3djFWaVkxcEhlWlF5VkZYRkNYQ0R6WGJNZ2ZTTlExZXpUZzVFeHNT?=
 =?utf-8?B?SWpySWIzeVdDa2plUHRLZXRtT1BudGhBNDJBbFErMWtLTGkzK3lvK3IxS2gz?=
 =?utf-8?B?VE5FNmZ3NE1XVEJOTEVkZ2lCcDBpeDlFQUNpQ0lMRUh2bElRK3loU2lmczZR?=
 =?utf-8?B?VC9nYTRpM0lrUE83TEV4clZFVXhjKzZjM0VPbFZ1aGZaL3FaN2J5S3o4cHVl?=
 =?utf-8?B?NnJXUHhiNy9LS0hkNlZtU0ZmOTgzaFhUZ3RmSFFqK2Mydm9yWUdUblIzcXJG?=
 =?utf-8?B?SVdkZW9OWHYwQWt1R3BtM0RBTmN5NTdOM1NTVHBOKzVpYitlUWRaS3BBNE5O?=
 =?utf-8?B?cysrK1hLSWlsYmdqUGdZMU16bnFIQ0NwbUhaSSthL0NoU2RKdEtoM0N5L0lE?=
 =?utf-8?B?dVFnclA5WlY2aVA5bTUvY08xazFic0tvTG1NNmpzMWRYWDQxRThXdXFaa2dy?=
 =?utf-8?B?aFhyTEpuazNOdDU0MDVzUGwwUlRVdk9yUmhlMDBVenJGSVZHNm5NUUZ3U2Z4?=
 =?utf-8?B?WTZpZWJtOGg1ZnQ5SGNkSmFnZitZd2pWZU1LRDROZ0VJV3Z6TkliQXhDQjY0?=
 =?utf-8?B?bE5GV1RUaENjenFNS3RRNGRhZzd2b1FheVhiWjdkMUEyQ1Ixd2NTSlROQWZj?=
 =?utf-8?B?OXV1MDNsOVRFOXdiVm5IczB3Z3d4eUJoMjhwcDM1VVIzMnVRYnVsclQ0QTEr?=
 =?utf-8?B?aDFhL0p3bUtFOThnME5kSUNweHl5R0VYb1llcTRZaWtKZUJKQXR0aWdYejBw?=
 =?utf-8?B?bmo3NjE3UzVTZ21iOW9WQWtLekNYTlFPNGZVamJLbWw5NUVoN1BiYjNuSkg5?=
 =?utf-8?B?UGJ6c1FQdmtrS0xiRitRSnRLVDJneDcxbnF6VFI4ZWtjNyswc2hxb2tEZmtu?=
 =?utf-8?B?bENLR2tnazV3RkhzVGdVMzNXVndQZFlrbUN2ZVdLN29rWkdYN01kMVlEY25E?=
 =?utf-8?B?NzlHVThaTzZDeU1hSk1IYnRuUDJtd3BNTlAvTHJSaHpmUVVaT2FLbXIwd3Bx?=
 =?utf-8?B?S1BwbzhZdFBLVEVqK015N3Rveis2Nk9GcjE3MXJ5RlpyM1VlNTd3K1hQU2Ja?=
 =?utf-8?Q?Mp0C7lBK2T7MVtgF2GZGDqyjo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d169c3-a692-4498-8d89-08dd82d1ea02
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 01:47:04.4642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2wRfCLy8XvpD0GoHhhRu0vIQxMCWk9xso570Xl1WjxoCjQQyK2jBMkt8wMvVOzo6IgRQpWj23QN+qStCfMPpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5563


在 2025/4/24 05:59, Andrew Morton 写道:
> On Wed, 23 Apr 2025 16:43:04 +0800 Huan Yang <link@vivo.com> wrote:
>
>> @@ -3652,7 +3654,10 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
>>   	int __maybe_unused i;
>>   	long error;
>>   
>> -	memcg = kzalloc(struct_size(memcg, nodeinfo, nr_node_ids), GFP_KERNEL);
>> +	memcg = likely(memcg_cachep) ?
>> +			kmem_cache_zalloc(memcg_cachep, GFP_KERNEL) :
>> +			kzalloc(struct_size(memcg, nodeinfo, nr_node_ids),
>> +				GFP_KERNEL);
> Why are we testing for memcg_cachep=NULL?

Due to cgroup_init ahead of initcall, hence, root_mem_cgroup create will trigger NULL pointer access.

So, here test it. :)

I don't find a more good way to avoid this.

>
>> @@ -5055,6 +5061,10 @@ static int __init mem_cgroup_init(void)
>>   		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
>>   			  drain_local_stock);
>>   
>> +	memcg_size = struct_size_t(struct mem_cgroup, nodeinfo, nr_node_ids);
>> +	memcg_cachep = kmem_cache_create("mem_cgroup", memcg_size, 0,
>> +					 SLAB_PANIC | SLAB_HWCACHE_ALIGN, NULL);
> If it's because this allocation might have failed then let's not
> bother.  If an __init-time allocation failed, this kernel is unusable
> anyway.
>
>

