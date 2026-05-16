Return-Path: <cgroups+bounces-16006-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLAWAAVzCGqopwMAu9opvQ
	(envelope-from <cgroups+bounces-16006-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 15:37:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A43355BEE7
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 15:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35D7D3009F96
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 13:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EE639DBC0;
	Sat, 16 May 2026 13:37:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020083.outbound.protection.outlook.com [52.101.196.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFC91B983F;
	Sat, 16 May 2026 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778938620; cv=fail; b=Jh4KGXvzH6WNjqc95TEur9TM+ULiQJoOkZoKABFJ+Mu3zTPuVfVjZnifxA7JDUwWm1wq69V9/6fXu0j89rm9hCnwGa07CGpDncW6oOggAZhvcFaorUVUE4CStnkPdamh49u+Cn7cXk56cR6idjbt2f2XFidU4WyT/7hSiDYRciw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778938620; c=relaxed/simple;
	bh=w3Bty/AqN75+3Iwp1UiBA0ERrHry8kXNaHeML5h1b14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o/Q9FIguG8W/GI/vFvDPQ5c2EK9Cq4OQFyhlQwVRdTE/Av5CDRHPKlJRnrP9mnYUeS88v6zA/opZCwbKBlCka/Dn724AvS7T290MAm7CNEBel/sNWRnUf2i09oMrgNGumltHohPFdn46GIQR/Uz1ZZSyuq8sLSf6i+HsztJ2I7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8m2CNKu/oZVLVyAz6vHKsWRew2RyKiEIXFAJIxVkCFR8g19I7mqHHP9UnAzCj9VdhnK5l/oy/8nKPcECIfGIqIo/k9PnBEMipk0smBI15Fc3DOiSuCoTn1L/oWmwwUIEjcQnjjFlATomYWEhYDCoegCBziLsf5QM3Ei8xvRCrjXLGeXARoQHbZA02fRCa05uVZj3wwrMQL0mtKTlxCJCLZTF2nm7eMMuerrBi0AVE/RL+lnXTnqeQYA61GMiTAeX8PnjGb19zLnOCXqUVhromEDzSqyChvaQ9JLThkKKyY/fBfeZ3+gcIk8mYN79dhySpF4az4LpLksP9K5HM9Igw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FShBEXD+jn80m91TO69ZPVNUTnfnw8RThDkpSg7WbVE=;
 b=gfYcfgHfjFtWtMaIv7bXLGzyq/kvWX/U4zmZm4hrWfRVLsZQ5ac5qcYtoTzOT95/XCM0GxJbYyIo0pGizFnmX/U9kGXXoKdcrPIqFM9P8Rd28VefYZOJgXN8lOhKCv6/p3Gnoh1Ry/fjDZcRwPjQ3vRfvtV081d3gBCC8rrRkZvyn4an0FQRNov2dRXzJCM9V8eItG9iWB8JGT8agFELBE3U5zS2FNJbBIJC+DgZ5xcUQM4vmA8fhMJMznLz2jMFM2BcrwNz3YgMWxlNbqFPlKvslVUPTOMtLH0g2AYNcdQe4PGs94k/Ey31EaDE04h/ZJsbWV26/Lkc56DcaL55pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LNXP123MB3676.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sat, 16 May
 2026 13:36:54 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sat, 16 May 2026
 13:36:51 +0000
Date: Sat, 16 May 2026 09:36:47 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Paul Moore <paul@paul-moore.com>
Cc: tsbogend@alpha.franken.de, jmorris@namei.org, serge@hallyn.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, stephen.smalley.work@gmail.com, casey@schaufler-ca.com, 
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	chenridong@huaweicloud.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	omosnace@redhat.com, kees@kernel.org, neelx@suse.com, sean@ashe.io, 
	chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, nick.lange@gmail.com, 
	cgroups@vger.kernel.org, linux-mips@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
Message-ID: <ekp6fp7ndac6hdlbzc4ukeh2ioikrf5ymwkeu6t2uegobbsybw@66afrltf6y73>
References: <20260509213803.968464-1-atomlin@atomlin.com>
 <20260509213803.968464-4-atomlin@atomlin.com>
 <CAHC9VhQthq7y2akbQSdJwBEex1MQYWG49wcJK3b8gSQuQ_d1cQ@mail.gmail.com>
 <bscbywzzx4nmxzbuw2bkzltb7rrmgmzy5u4gqy5pfpmafcnlto@eznniiguusqb>
 <CAHC9VhSWrJc=aE1Sg4xfv1ZMmh=JqZFLWGeG2SnzOFqXxcUbtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhSWrJc=aE1Sg4xfv1ZMmh=JqZFLWGeG2SnzOFqXxcUbtQ@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0707.namprd03.prod.outlook.com
 (2603:10b6:408:ef::22) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LNXP123MB3676:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ff120b-6d6c-4657-00f8-08deb3502fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info:
	djItN1ISMS1qmswEkNP78+uCa09q+zZYj20WetJDAVe18px2nZFnD5GX34zA65kK+Qc7UNayJzO+Ab8hWKsqNuPFxZf6enEQxOHzWTcxRQysyOC0fAumnSTJYk2kEJwg0oZatatdUC+v1Jor/4HR5BaNYfiRor0DCocFq7ESZCiaoxZA+G6nRqmKodc1cYb81CdhzpjTV7ty9ACpw07jm6fBu6DAxxsuA2k6ey801LmwYnlaOZLdU/cBkfb+em4kDskBUpVAme0JdD3kImEoLMoCt2SphDP/FAtdL5ugZmQ9/dG25PKpt7ntL+sS/96gA/RTj7kPCuqIeLCYptXnJzgbg/fvO6jceF05CPPQAxuyjt9mqu7jV6cR+SIKwOLoMA8cXy4ucKuJvUKfMyURvgevzP32rFyqfQnWkwoy25Oyc+oF6qtz5i8Mec3jEWtw+Nzo8sbzhLJQK8hs1BP4K30gj0u3hR65eKvfVdBsSlcEZUzN305bKQya7Dqdvvh6e8SYrWAgk5t/3Seq4Df+hYWx+kFXu161Oaf8L1pN59F5X9hYqJES1WQNVnOnKNdPKczGF8UCF24v4nK7weEqOtYI40WWTouZRoDoixCT2D3Sn27Xj4UfeJ3wTm8Bb7mXfIaHDny9FgEnZGvpvU6V1jz1pVTAGeRSU+nigv7jaRaLnNUDWUAt0qvVubKt/gEO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(4143699003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXd6WDg1bHdPVVpxaTFEb1BnUGtJTnZTbllaOGloc2FlN2w3d0lDUkF4QmVz?=
 =?utf-8?B?Snk1TnFYZTdhbWNNOFZQM2dPNFdRUEx2OE1ER2JsWG4wWnJTTmp4UnplR2Jw?=
 =?utf-8?B?Q3lsOWZkYVpQUjZnTVlXTWxVemJ3eVVvNTNuWWp5dW0wckVDS2xJTHgzbE52?=
 =?utf-8?B?UVNZOE91SjRQZ0w2WHREWkt3Y0NSejlSK0JIQ2xNOUhrWHZsZVB6QzFUdXZB?=
 =?utf-8?B?Y0tHUTJaTUZzRUZKTklYTjlTNy9kTEJCRldSamh6SWhQc3g0RVhKbUJDbWdj?=
 =?utf-8?B?L2ZTZm5TeUhsV0pzL21DQmlGUFBpQ3Y0UXg3anJEbjQrMGFJL2lCYlVmTGJs?=
 =?utf-8?B?UG1zNThpUTRTSkI5ekVtOHl3R20reW0yMVIwL1MyTmJkOEVSQnZkL0RqSU41?=
 =?utf-8?B?UHFrMWM3N3RQNTRGZ0RCVGw4ME8yV3gzY05WQ045bmxSR1J1aHRoUUc2V05F?=
 =?utf-8?B?WVc5NG84YW5TVW51cFBMR1NCdVlnMURnWm1PUk1TWnBuaXVxcXJZd0lPbWdy?=
 =?utf-8?B?WVNzVmVpNGE3b29SRGcyRXFhdWVmMzFMNFN6VG1iNElLaGNpbnhMRkJFV3pk?=
 =?utf-8?B?R3NCRWNvMWVQeG5paGhDQ3NLK0lmUXpKVWNUdGdWU2FudTloaDBPbGc0NmpX?=
 =?utf-8?B?dlJjRzFsaXY2K2Rkcm5pWWN1QklidU1vOW1sZTFkM1VyYTlWZDV5UzdVVWZB?=
 =?utf-8?B?a2NlSzhIakhWSFhQaGhxejYwbjlJRzhWQnJreFU5QWE3M2xpTWhVMzZqb0Nl?=
 =?utf-8?B?QVVOcHNMVUNMZW9TSEFvTVVyWktaUk9CMk85VG1uVWRSaEJCdjFmNGlpQUVu?=
 =?utf-8?B?WXg2VEUxeHJERnM5TnpZWTNQMlZhR0M5bWp1cXJBd29FanQzYzBzaVRTdWRB?=
 =?utf-8?B?bnBDb0lWeU81THhjVzVqc0tNU2g4b1dPWTNrM2JqTDE1dUVveGVhdkRQZjZT?=
 =?utf-8?B?QXE2ZG1TTGtkS1dYemdOc0pZNTZwanNwS0t0WUltbUNwbkdkelVYck92WnYy?=
 =?utf-8?B?ZnZVUDVnS1JicnlmS1diVThORGErMTdCM3BqMFc5MnJUQktJUm5xNWc1K0Y1?=
 =?utf-8?B?SXRtNys5UDJqbmxMOGViT1Q0MEtKUi9NQ0VXN3lOSHFUSkxMbEdlM1FubW9X?=
 =?utf-8?B?U1hMQTBMMWlwOWQrNHJZK2pybkRMUnpiVVVzbjdObHlLZE9YMUgvQXpkRUcw?=
 =?utf-8?B?NVBWUmNFQXBmcFVGL1kyanh5Z1J5dE9FNnhQb3ZoaXkzeUtLaFRJY0lrN01S?=
 =?utf-8?B?TDBQbDkzRWdycVF1TkRabG9XaGNKNHVmV2tqd0Rua2RiZzZXVVZBL2ppd0ht?=
 =?utf-8?B?WjY2MWhNaUNNK21Kc2J6TVIyZ3RqN2toT0FOQUxWRi9mSm9Ra3BTSmJmc09a?=
 =?utf-8?B?NmR2SXdmaHJzZjRUNGo2L0VybThvd1F6RVExc3VPZWhzS1dac2t2UWZlTXFU?=
 =?utf-8?B?RFFDN01KTXFteWNDeGFNTnVkalRPRnJsNTRuT1NmeDlrb09ZTTFLU3ZHcWJl?=
 =?utf-8?B?bjNLb0lCS2hUdE9hSVRmcTJpTVJjbHNpRzV1WE9aNC93QWU3cCtzckFlVG1D?=
 =?utf-8?B?ZEl4cFE0NVpDaHZtamFOSDBCbUJtUzN2eUlSZXVhN08wRjhxaVBSeXJibzB5?=
 =?utf-8?B?cUxTZGozMkc5TTROeHprY2lKSG9nR0djN2xmYTQydk1tU0lpOXRvb1JtbTZP?=
 =?utf-8?B?djcxc2ZORWtUNVZ6cFRiSEZFTVBWSHZpVkZTeWxnV3B5aERMa1VXUDhUYmJS?=
 =?utf-8?B?QzN6emdjQWtXaUJBR3FiZXgvZ0N3T2hpdUZTTm9hN1hsRmJaVGdRQ3FYWmox?=
 =?utf-8?B?STcvaEJHcGFCckJQOUJuNzVJQ2RlQ1k4VU5MaUw2MTV3UXRVK1MySnovU0Jp?=
 =?utf-8?B?Ti9pV2pBTlI3Tk9OektNT0x2K3ZKeHkzaEFNMjh5eCt4STdWR0dwcHZvSHZi?=
 =?utf-8?B?T1I3Mkk2SUdEYmFacGErT3c5bjlRUk83MGtWVlQ5Vkg5UW10SEZmcXVtdVNt?=
 =?utf-8?B?MitHRXBHOG9zZWRWWGkxTEFldHRORGhxdjdjRGM3ckI5MS8zamFadU1SODFT?=
 =?utf-8?B?TDdUWktuYTlxeU1HQVFaRFB6czRRZEpFck9oaVVVQjdjTnErdDFWU1BIclVB?=
 =?utf-8?B?aHA1b1F4S0dkY3ZSdm1LTVo5LzhheU9qZ1ZONXdyVDFabnp3YWJCZzV1TUVR?=
 =?utf-8?B?YkRONzliTUxWL3lPYWc0RWprdVU1Q0VjZmFPcE1IbnlIcE94ZHhkUWNPUXlK?=
 =?utf-8?B?NExxRWd5QlNRUHNjNWdjaVEvQWFLc1phcTBjTUFoTTgwNGxualdacXU1U21x?=
 =?utf-8?B?K0pqRVp2VGVZOE1INDJINVJWcjR5YXBjSzVrL3VKd1NNWXZtZEtCUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ff120b-6d6c-4657-00f8-08deb3502fda
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 13:36:51.8177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MlFpi1mZlfRfNX51AtH/2Jgmfk9sBeBN+XowlaFf7aqVlWTE5iKOH/VQm49RMMh2spoJP6+K+joLvABe5fxag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LNXP123MB3676
X-Rspamd-Queue-Id: 9A43355BEE7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16006-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[alpha.franken.de,namei.org,hallyn.com,redhat.com,infradead.org,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com,huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,amd.com,ashe.io,abita.co,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 04:15:15PM -0400, Paul Moore wrote:
> > However, I suspect the MIPS-related patch will need to remain coupled with
> > this feature patch. Because the first patch fundamentally alters the
> > signature of the security_task_setscheduler() hook, the MIPS FPU affinity
> > code must be updated concurrently to accommodate the new parameter.
> 
> I generally dislike when bug fixes depend on new functionality; it's
> backwards in my opinion.  I would much rather see the MIPS bug fix
> patch submitted as a standalone patch and then have the LSM hook
> modification patch come separately, perhaps with a note that it
> depends on the bug fix patch.

Hi Paul,

That is a fair point, and I completely agree with your philosophy.

I will decouple them accordingly. I will submit the MIPS FPU affinity fix
as a standalone patch first so it can be routed, reviewed, and potentially
backported independently.

Once that is out, I will submit the LSM hook modification and the rest of
this feature series separately, rebased on top of the MIPS fix, and will
include a clear note regarding the dependency.

Thanks for the guidance.


Kind regards,
-- 
Aaron Tomlin

