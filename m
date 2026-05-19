Return-Path: <cgroups+bounces-16095-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAZrLmKmDGq8jwUAu9opvQ
	(envelope-from <cgroups+bounces-16095-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 20:05:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C395583697
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 20:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3958F301DB86
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 18:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E262F12B3;
	Tue, 19 May 2026 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMob2jSr"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FB0191F94;
	Tue, 19 May 2026 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213891; cv=fail; b=CIRWSaAuPXpZYNmFDmed0gm4J03rUMthS7bhlbqmx2x6W6VyKCUE5aacUOWOBQEYRSPxb3TryAXCFlcw5cxkSsoRXkLf3H6YAog2XLF0VoQLF86NB2YJmquMm083qSXMcji40CF196gkHuDkJ5QI9UieHOEF2isbF8BEBY0E4W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213891; c=relaxed/simple;
	bh=mKYdwKZ0mq/hXtjfhQJj6EjYei8GzBwk1uqtRCiJNgQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sc0oi5jAPConZj73DQKIVzlp1MdhOvO1Jn12D7nrSAc2cEk63ioD84ma/MUh+xOuJDRqejAP1UymFY5OYYT9PY7QOJosSddzF/4K9TlArk757MbXwPIrZkj6M++XEdQ8YAxX2twVrqnQmSEWSSGO4oWWdMzzvRegvIEaZbMIk20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMob2jSr; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779213891; x=1810749891;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mKYdwKZ0mq/hXtjfhQJj6EjYei8GzBwk1uqtRCiJNgQ=;
  b=VMob2jSrTlJRbZpEqG4wh2yXqr2Vr6vmLiul/aEKXpvprzKPQG+DR4HA
   5Yl1l9/1tJCGyUfmLiVOQKrUOoZFwuHGBwYjhjlpqB+k1rcqfjHmbPZkp
   wh3w+GulsiGHmvduhIxo6lfTAxNufkYyPRdX6FjZ5TbfUknX1ixNJhmBJ
   JX8QMLXkzZMidL+uONZz6Cry4A+GPxMyzvavZe7RmVRZ3rnjvl8oeLjdn
   +5MLimvp3HcOsmZ2UWj4bRkAJmej9Bjfs76Khp+xNUtALl74uropwjL8u
   VbKikSw0hfzT3BQJGXZYBcVL5CYH9pr8ozJlbDS4ylEyKgDdcyMxzlUf7
   g==;
X-CSE-ConnectionGUID: oMCE5YCuRKSGwTxvPxuVWg==
X-CSE-MsgGUID: z0JKJJF7QcyynD6gxySotA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80275147"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80275147"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 11:04:38 -0700
X-CSE-ConnectionGUID: APb5E6MaRx6PJTEAuJzBTQ==
X-CSE-MsgGUID: DAxJUYLqQ0y3imZNRpxaTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="244820821"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 11:04:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 11:04:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 11:04:37 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.28) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 11:04:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLI53vXFd2XKnu8zL1ctVVDfoLQnaGt+++aCyYKnkjEQgewBbFygfGauL5LOjq8sN7hlLSwIR+4FrlSLrJoeZAmSi/umneNRr5X5/S5Sur/umilprFuWDI9d/9BiqhKP9TYjjpNxXcqls4GX86/ei0pAgU9NqYQMiZwuJFeYgc7MZl7WNvlWlG+SXYbwTDEl66bj6ThK/U7NW5i9x19x8t25aZX+Qm90673nHXg+tKPD3dW5rxCRw0C6loaqPkXwDMARCc89OYUZ1l0CO8sph435P3QqQWhzYHKWt7L4hK91dL1iI0zgLWFYV0q0ZKkZifgwV5d+Y0knaXptJug96g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKYdwKZ0mq/hXtjfhQJj6EjYei8GzBwk1uqtRCiJNgQ=;
 b=ZVzTlXwYdvHEJM9L17VXh9aBe9uLVgKgKyKF2QHy3x3xX70yDHhnlY/DN0+gI5snJ5vfBuEsKKKPMhNlHB257si5zH/hfcrw5agQ94NYSr40d770zUYD+/dZtz9s6/DXbYW4RPHj0SYf2aJXakYWbzjmit9hfu9KmEUTEmpyc3bZ7NHpYcLcow7N4opJdW8bVAVqVOEQr0CtxgNqHZclBlkAZl+H4pHT6OCBcD1K/x9L5OAGYKr7P77WnPtPiMByaMO9lzjhqWTDD9+gMnEEA2bThaLlAz3dMVJWgGjannoyNpePf00UYKKfETPceV4zt2Vb/hsm5/XcLINxoaQ1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6)
 by DSSPR11MB9618.namprd11.prod.outlook.com (2603:10b6:8:375::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 18:04:33 +0000
Received: from CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913]) by CH3PR11MB8383.namprd11.prod.outlook.com
 ([fe80::60b:dc79:1a0d:6913%2]) with mapi id 15.20.9891.021; Tue, 19 May 2026
 18:04:33 +0000
From: "Falcon, Thomas" <thomas.falcon@intel.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "mkoutny@suse.com" <mkoutny@suse.com>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>
Subject: Re: [RFC PATCH] cgroup/rstat: convert rstat lock from spinlock to
 rwlock
Thread-Topic: [RFC PATCH] cgroup/rstat: convert rstat lock from spinlock to
 rwlock
Thread-Index: AQHc57YQ8kvnJ22cxE6k04nQYHfTyLYVoEoAgAAELYA=
Date: Tue, 19 May 2026 18:04:33 +0000
Message-ID: <27091d075bc264a0d33b01dd105389e0dc39d862.camel@intel.com>
References: <20260519173134.1486365-1-thomas.falcon@intel.com>
	 <agyisB5nfUdDBCk5@slm.duckdns.org>
In-Reply-To: <agyisB5nfUdDBCk5@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8383:EE_|DSSPR11MB9618:EE_
x-ms-office365-filtering-correlation-id: 3086f707-efbf-47b8-4288-08deb5d114ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700021|4143699003|56012099003|18002099003|22082099003|11063799006;
x-microsoft-antispam-message-info: QBZlK3kJE9UfV/ryU0TWemkOq/xP8GoNqSUU7VdNFgWRUib2baHQnD5MGalUcxZwNU2G2kCWf9pnRe+OGYvQKsaLJFrBGL1kZLOXwbBH2QZYpkvOYDDqL8J7PqfdKlgnVVRJDTD3vqvCZ7Cf/mB/6qrtbXmWzxILwdxOoSf5udHvjGgf6VniVLMe1ceoQi8ArFtk6+cTgL46deWVylf812XcaaizbNfXUfNGXEbY7gnK101VOMEnNaFK4X5G/ImetL7LTk6nNig8ZJXmW/GR0ms4R54wP1sidtLP7lfpCthE5mVcxn/+WaPC0kDSwXsOc7M4IkOr2i/a+91zPWQO75STWFA/fMj1pC9n8sN7yEqYGnb47cvd2uRiSQ96UYap+Z5PfnpA+M567+XEx5kwV+Nj5VgfOj3ylRqbVmfjBoU0kGJFkCn07RKZU6weeaYd9VUzbkuGwgpR4Xovd+nGz4stqptSBPlvfTxJU/qaLs7Lpz52AxAi4LJQJy80SgA2x9RtcMaW7n0/2z0jp13C0GRlmTsb7zMAfeMxyOIsiOXNUEZlRPZu3qEFiEyIxKMuNlNIlVFPhsnMLoyB4GjM6eCv/hDho1gtw0myHyRfUADjRHxPw05FI3D5pl3vm70gl3F+3AM0Us3bkwbAwvxkX3dMrBFdgDPaYDkLYnMsHRr7nMSmGSR4nlDFqdwlQoU0nlGblaeEIleRUOWE5ARQiF8DGawDNWS62nig2Bt3rWw06AjLSqxdgTjIdULWVdDb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8383.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700021)(4143699003)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUFXMGhrWWNqUkZHYVAzQUpIQTIwQ09nZlNTVWhKSk81UEdxZkRnekJaRmhx?=
 =?utf-8?B?SWJpQ1RqcXp6cW1VTWpWdEEzRHpFMTVtNUtDcDVLVnhGRE9kaWFPY01kbzNk?=
 =?utf-8?B?ME1tZjlLZTliUXB2R1Jub2pOUFFzU1BzRnNtR0FTc25sK3NXcEMrWWsvc2Jo?=
 =?utf-8?B?VzlCcFVTaTZWclJWTXJqN0lCb211WDFYbkpZbnMzd25HK2pUakhDTGJZMUVm?=
 =?utf-8?B?dzdUUSsrWDlFLzcwTVBqUDBlVzlHYnVkYjFTUmNPY1pKcVJnR1ZXa0hsR3E4?=
 =?utf-8?B?RVV6NTBpakQ3U0d3bXkwTTZGYXZqTGhmNDAyQmdZWkFLWi80V0N2ZmJpUWps?=
 =?utf-8?B?QlVjWXE4V1M4a0tEQW5sQnJVay9sWkVYWGJNQ0FmcGx3T1BpS0d3d3lUTTVY?=
 =?utf-8?B?MDVjY0FnaHRxaUlyRjlMbjVtOG1wRmtuWGYwR2hJdEdzUFhML25XZXJTWlpR?=
 =?utf-8?B?bUY5ZjRIdm5NZ1d0SkZtZ0lweDFNaEpiMGVEUmJyWVd1MGJrS1A4QklJaWdO?=
 =?utf-8?B?MHV0elNsc01MNDROb051Yjc1SkVhZ2xHa2loLzBvcWhkTGtHZCtocTBuVU5t?=
 =?utf-8?B?bVFNZlZRWmlodkJHbUZqVFUzVkp5NDg1QjRYNkxFWUt2K3hod0w1YjhKQzFO?=
 =?utf-8?B?ZnZ4Y29SSUNCRTBpNDc0SjhzdG5vaUhsSGh1T0M3ZjZGUnlDMXh0ZTZEbS9K?=
 =?utf-8?B?L3VSU1dhZmh1bk9VZHUza1l6NmVmdm1RQnZRZm5yNDRpemxyOUZEbktaRGV5?=
 =?utf-8?B?UVFFRUVkRXZEOTVYdVdSdFVQWnBhUm1PeEdoQkU2Tmc4K2kyYjlWTUUyQVV1?=
 =?utf-8?B?ZnhzYWVYTnFUOWE5cEtUVDFoOHNJTE5XblpDSTY4SDJYeEY0dmNoWjJpMm5v?=
 =?utf-8?B?Wkp3OTFyMFEwTkNXSWw4bk10ZncrNzRmb01vaHBnMnREMzFyWXlDSlNqTjdv?=
 =?utf-8?B?NGF2T3Q5allZNVpUSHIrdDg0SWNUQm5vOTFKa0RBcW55TVRDaTZtVWZJcjBG?=
 =?utf-8?B?RjBNSWhkWHE3RzcvWmpsTG5NUlV2MjFtNlBMNit2MWRYSGVXaTZPSlI2aDJs?=
 =?utf-8?B?d1ZMbmRwWUE0T1ovVTJtNTNCUi9jNDM4U1pQajNyblBYWHNXM0RjNEdOVnAz?=
 =?utf-8?B?YWpkQnJaNGZCa0l4WFMreUlic1pjNldDc3dNUWQvTjQwVGpTVjdBVCtSNmJX?=
 =?utf-8?B?b2gxZDgvTlh5K25hdXhmZ2djUU8xeGlURkJMNDNZZTRtVHFFTURrTzg1TG84?=
 =?utf-8?B?bi9WL2VvWWlmNjRHWmNISEtRRDVrSDRnUFN0a0dDaXNQVkJSNTMzamJ0R0Qr?=
 =?utf-8?B?c013SnNxOVhUSmFSOTZUVWM3bVAxaHlRR2JUSm41cCt0WXZka3J4dVFKcllL?=
 =?utf-8?B?d3VhVGRxaDZta0xiakMxK3dZYnF0Q0k4MVhNcE4vK0hjUXlRaXJvdXJNR3Nx?=
 =?utf-8?B?WWRYOTRRQVhUVWlpYkRMZmlCSGhaU0NUS3hrSUZyTXcvdEMyQitvNlNQZG1x?=
 =?utf-8?B?dzZkd1FqenJucm5mTnRwVWxmQjM4Z0VweWdldzRNWHpZNkJOeEpKdVBDVVNu?=
 =?utf-8?B?RkNtQ2dGdGp1Q1BDWlQxeEczaWZlUnFaNE5kWVhoUXE5cEdubzRlMEM4REtR?=
 =?utf-8?B?VlhhODZsTEdlYk5DT3c5NHhWRjBzOVF5SU94WEdFejhzcDVzdTZrS3N6M1lx?=
 =?utf-8?B?RWk5TUJ0aHl6MjY0QzRjbzZIcGFYRVNlUDBWT1lDWXdMVEx2NTlaUURhaTB2?=
 =?utf-8?B?NG16NWpNcHVGNGJxdEc2RXF5UVB6TGV3eUtYRUcwUDMrN3NPeDk2b1hXWWxa?=
 =?utf-8?B?SlNCdk1BaXg2c0ltWFJKU1BLMWhWVmZiTlR1QkRIdjVLd0d6NHhlSXhVN1RX?=
 =?utf-8?B?R3d1WFJHcjNCblljZW11UzFZWmo0RHJjMW8rS3NDblk5T0RKTjRtWitUeUt1?=
 =?utf-8?B?UUNwZlRRQk9lcHFEUGtJN01vb1ZBOHhHZDRtU01lU1Rza1VQcmlRU1M5R0I5?=
 =?utf-8?B?alZSYlhKVk02b04wNzJIU1lyZHZMUHQyTlNiSmVLUCtCRnBPY042NDI4c2FH?=
 =?utf-8?B?MS9UY2M5SlF5T3pudFpiR0ZzbXJSRk43ZTB2aGxHbWtiOGJMemxlYVpSU281?=
 =?utf-8?B?WmJaNkNaVXJEU0RicG9WV3NobUJlY2p4QWxYR2laSXczTytoSzNzVUp1ZVk0?=
 =?utf-8?B?UGN2dlhaYkFuN0xTbVMza1ZpTXNOQkEzMmJtTVRldXNjQXErOE5yZmhrTjBq?=
 =?utf-8?B?aCsxQ21rZGpwNVpTSjdoRG1MNGY2aE5iN0l0aTc5Q2YvWGpYRlh1ZXRLS3JX?=
 =?utf-8?B?NzFYaDNnNDl4VUkwSmJxN1BFUFdHcXhjSUR6SmQrOHBwODI3WFdNZzh6ZThL?=
 =?utf-8?Q?aIRXubaAT1IJDnwIUjiOPPCNX6LX983BVrNHRfkUfCX4A?=
x-ms-exchange-antispam-messagedata-1: WzkZxfbCRH8IkZx40a6FBZCkskg8Gr5G2z8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F526A4D421553B469DEB9CB83D01777D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rCY/fcy5xv74eIcRtxxPKpfqmOOfn4+kZZ+U4rDh7AjyNR2tNJsEgOZ9EffY2fsmCHNelg8GKD/auc2LIFrkiSGdKp4hj598DVF0qo+dGp6jhNHnc1QVwNIYFVygYiAProkB5S+mUqCdB1AKBPxiJxYZhWr9j2mSqoOIkWpyQ2UuR8K/5MC3ADrNBROlewzC0zlTeX6eO3Rye0zh68E8V5FBB+0DXizmMlSKFKoYU8QErubjPs7yb+GOR/dUGMwsI3XjGwB9F+cxeWWElfQlPRTJLbAvRQXhXQLXx/0hDglGpEBkUAqFCe+wsH+SNIAatg+INpWzYR9FLL9/76XT3A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8383.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3086f707-efbf-47b8-4288-08deb5d114ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 18:04:33.7854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5S0ilVGpEN6MI+1k/iPXFcQC7hGoBEGb5oXTnUojK9y97I69/9sm6oMzSMvHZx+nPwv8wmi6XZPfuLLCyY8arA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR11MB9618
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16095-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.falcon@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4C395583697
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTA1LTE5IGF0IDA3OjQ5IC0xMDAwLCBUZWp1biBIZW8gd3JvdGU6DQo+IE9u
IFR1ZSwgTWF5IDE5LCAyMDI2IGF0IDEyOjMxOjM0UE0gLTA1MDAsIFRob21hcyBGYWxjb24gd3Jv
dGU6DQo+ID4gSW1wbGVtZW50IHJzdGF0X3NzX2xvY2sgYW5kIHJzdGF0X2Jhc2VfbG9jayBhcyBy
ZWFkLXdyaXRlIGxvY2tzDQo+ID4gaW5zdGVhZCBvZiBzcGlubG9ja3MuIEluIGFkZGl0aW9uLCB1
cGRhdGUgdHJhY2luZyB0byByZWZsZWN0IG5ldw0KPiA+IGxvY2tpbmcgaW1wbGVtZW50YXRpb24u
DQo+ID4gDQo+ID4gVGhlIGJlbmNobWFyayBiZWxvdywgbWVhbnQgdG8gc2ltdWxhdGUgYSB3b3Jr
bG9hZCBwZXJmb3JtaW5nIG1hbnkNCj4gPiBjb25jdXJyZW50IGNncm91cCBjcHUuc3RhdCByZWFk
cywgY29tcGxldGVzIGluIDEzNCBzZWNvbmRzIG9uIGFuDQo+ID4gSW50ZWwNCj4gPiBYZW9uIFBs
YXRpbnVtIDg1NjhZIHdpdGggMTQ0IGNwdXMgY29tcGFyZWQgdG8gMjQxIHNlY29uZHMgd2hlbg0K
PiA+IHVzaW5nIHNwaW5sb2Nrcy4NCj4gDQo+IENhbiB5b3UgdHJ5IHVzaW5nIHNlcWxvY2sgZm9y
IHJlYWRlcnM/IFRoYXQnZCBiZSBkZWNvdXBsZSByZWFkZXJzIGENCj4gbG90DQo+IGJldHRlciB0
aGFuIHJ3bG9ja3MuDQo+IA0KPiBUaGFua3MuDQo+IA0KSGksIHRoYW5rcyBmb3IgdGhlIHF1aWNr
IHJlc3BvbnNlLiBJIHdpbGwgdHJ5IHRoYXQuDQoNClRoYW5rcywNClRvbQ0K

