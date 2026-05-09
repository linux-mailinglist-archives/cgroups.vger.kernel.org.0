Return-Path: <cgroups+bounces-15700-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK+lMTh9/2kU7AAAu9opvQ
	(envelope-from <cgroups+bounces-15700-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 20:30:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E851500FF7
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 20:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCB48301187C
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2026 18:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759213B6C09;
	Sat,  9 May 2026 18:29:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022124.outbound.protection.outlook.com [52.101.96.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD5E1A9FA4;
	Sat,  9 May 2026 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778351383; cv=fail; b=icMUOMPFeo1ck+EgdCNuOxMoMzQ2qvRFV2BHHesEM10mrbnG9ZbSYKgehe8oYomRFqNSA8nSNxGLVnxFg54RKAJ0vhvtAGqP+yZUbxTj+gsPJIqkivk4JgiUY9gBFnH7gPW7gNCvWl4dMHDqvDjJX0vTWRfo85qTc/xVP8GdbVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778351383; c=relaxed/simple;
	bh=k02jLqSfXwie33E+/vasoJP+CnqQInRAw0IOjkxOkdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MX5YiL2q/XMB46+VEyK0XKbdYy83OH9HSeTTS6I3eM3z1Oyh/a4tacKATiOUJ+jfosniPIK0/4ssiHPJDt0LccIqj1bLEWQeWRb6TVbtHwh8PlXScaCXsAZpTsmbcRCJm0ZviKOiGEjoedUFBOew9SXskCzjtmKie76BwwLvKTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A53ABu011bLRbyRGcGoQ2X9KOvXS5Smr62gXELofMDmQygcxPOQ3X1MUflpyGa7w+/ebPeBWTlMnPu38a0a3858EZdwWYiG1MXq8xlbknCGpJCYeRC+CQrErIlX/3SZFLxnkvLF38FFvs8wPYyLsfNyfPb3htSBMKQ2W8r0KXNbpDYNWiSKY58XpdfPp9JhzrLlsK8nAYFJfFnZWif3LcZ2rXfCS1K1l0b07yDAlnrHJpAny+mHb54+E/YpQ3P8bak+/2QbcmQHGxLmwi+2fx2I4Yij3XRhYXXds7HoyqdoejSOly2EXL1O28c6jsiCQB5Zwg4oN2gaWzrWVGMkSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCJPfQTly8F0Z0XF2rs+TFm7JQXr0vLLvAqRkrQdu/4=;
 b=O6d7CEWtF5Pvv2TrTZlRWTM+nPu/e4KunOvKRkRt2gLaCmmEP2aB/Zb8RWyaq6HPak4Pjol8NpRZiiylMR/7JQpJYoONOk5LsKh8cbGOaN3xSDnwsxtYUSPybqZcV+UHzLyJS67+B7qocIms2P2MLgOrMrTaOG7eaMMkOiMB/tQ0/vwWydL2449/eJ/CN+VT69q7AiI14IHvjilbYw6OzGawWasuATH5dsqKPilTu2h+J++H3u1LcthNvjPQBLQ5VxTlY/VcvmWrNKPD5QN5MWejzAGvIO8mV8YpDJDa1Rs53VxhThItJgVRsQ4n5lCagyffDky4ZJwJ0U6aFOBMCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO2P123MB7306.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:32a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sat, 9 May
 2026 18:29:37 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sat, 9 May 2026
 18:29:37 +0000
Date: Sat, 9 May 2026 14:29:31 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: tsbogend@alpha.franken.de, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, stephen.smalley.work@gmail.com, casey@schaufler-ca.com, 
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: chenridong@huaweicloud.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, omosnace@redhat.com, kees@kernel.org, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, cgroups@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
Message-ID: <ork67oi3zx4fgclrv7mukdhw7pgwbb6gjvlchfjc25edfulbuh@azozabcximwr>
References: <20260509164847.939294-1-atomlin@atomlin.com>
 <20260509164847.939294-3-atomlin@atomlin.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bfnb57jctgu5ouv2"
Content-Disposition: inline
In-Reply-To: <20260509164847.939294-3-atomlin@atomlin.com>
X-ClientProxiedBy: BN9PR03CA0515.namprd03.prod.outlook.com
 (2603:10b6:408:131::10) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO2P123MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c373d0-b894-48e3-e7a3-08deadf8ec02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|56012099003|18002099003|22082099003|27256017;
X-Microsoft-Antispam-Message-Info:
	YeSUtSvevzHTfqRfjbxPATI7Log8h5JDbZQ1QFeMc5pK2vrYj+p6j2KJ7R+zHrxO6MVEaTXbpVQXr/e2bBc+o1n4OdYKj+bGaj1EyIcKShdlMI6c86gIDYlP/m5Z504oasF96yDkcLBXkkkkukzUSGT2o4W06fn/xB20GOxC/Sg1hDxp0Gw08ZBKoHOuQJlOh8sLq3rOyqor1jts2tIAwXfDOS4qYCI+ZgNzp3Qw+zoemljUQIK9LdrJP0W2swnxpoLLKvi4CW2nxiyqmQHdRRNPwr3ikVEdgf4UEKePO/fAWdYSKw03TX1DAmMDzQuoUdbJ+3l5rp1IzLqa1gATD275Ct2juQnsckTUr4y5DNOj5XTXtpSTqU24MYlQHETnzLsAMRAtDyF2oc0EOsgCEUUpW8M0+WHwDOsuzhrclkPzLCWVskY2q/+KEBGuOov6RgpLR9NooZT6ytdpMNPx8SGI7nBV/nYvgYkz5z2rETMYTFTH6nqxeKAA/hz4t1AgBCo6LAPAcBp6/cUcmFkSSMR0qTJLCzIjw4DSP6f+l6Zen8w12+Qgjy4w3E87tmAjmnrqf4bV4cvBsW9sMgODiKZal5m7Pr7AaLT6cThqJV/vUs9gmNXroqErTCqBd7Dabzuk8hVfidBb0eQ69E740Ha/LgoExn7vXdxDO80NhQokqpyaY1Ncm0TzVTPDt2aUeQ5XqhiGG7DIwhU+Pkl8YnHfkeWEVwpcjgSNkkwnngybeQfPIQGpvVyX3RHEqVae381wC8kDHGRUlC+zZxZRvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(56012099003)(18002099003)(22082099003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzBvUG40bTdPR0FyR2hFOXB2THJsYncwdjFqSUhjTyt3ZDNDVEpuQ3VPMHdn?=
 =?utf-8?B?ZE1FWTdtTFBpQUNXVzFZRjJRa2lOZUF5ODJxVmk5WisyWTU1Y09HU3p3bEJS?=
 =?utf-8?B?aXhjYUQwbGsxdmdoRGlGL01RN2ZBcjVnYVFDZ3JpT2xTV2xKTlNHc0k1RXU0?=
 =?utf-8?B?MlFVUThzQ1ZrOEM5R25EMkRiVkdwSmMrQlVYZkp4dy9CYUl1d2hONmdodmM4?=
 =?utf-8?B?aFlQcXNML2tNV0tKN0d1YW1pNFpyTCtoQS9XWTRzWWhQd1ZXSk5FT3YzaG1i?=
 =?utf-8?B?UVFjUGI5cDZsSHRKQ1YwTkY0OTU4cy9vQU5FQjNEYXZ6OUpvYll5MWpRRmJM?=
 =?utf-8?B?eFlQbnU3QXJ2L1AwaENhZ2I5aVAxNGI3OHV1MUVFOWpWeXEvSFFGeFlEcFhz?=
 =?utf-8?B?Rjh4eU84UjV3UkFLTTdmazJid1NJQzgwbXRVY1dqd3lHZmJxQXkvRE13VnFV?=
 =?utf-8?B?VE5zSWVsc0ZBUVFCSlBJZUYyY1JWakkwS0xLdUthakFzQ0UrZk5BZ0g1OWFR?=
 =?utf-8?B?VkN3T05OLzRDbmU1U042UGZLMUhtSzQxR1VHVi9oOVp3SlRxTFc3T3E5WkxL?=
 =?utf-8?B?d3FVQUM3Y2hBN2RmRVpoaFdNOTV6eWJxQzlqalVxZFdXZEJpL2ptZDAxcitl?=
 =?utf-8?B?SUdEVzZCSjFsSmpCaEtOWDdjSG9yR3pzV0h3TGh3ckdrU3BDUjZSOVQ5RjZn?=
 =?utf-8?B?MlI2alZmMUZ5Zk8rbFJDNVRKMUhYV1NIelN2ekdTTy8yL2RPQlJwS3lod1FF?=
 =?utf-8?B?cXByUGhKOEQ3aXNFSGRCV01wVWxRdjBwNitMUHhQeEg1dTIwOEw4aG9RTGtn?=
 =?utf-8?B?c3U1QlB4QWFpQUhxUzlvY0x4dUVJTVVzZms0TFRBRGdhMDRqTllmN3pZeVlp?=
 =?utf-8?B?UlpxMm1ua0VjNWFrOXNFOFgydXFMbTFUY2h3YStkYnpwdVlISW1KU2FMVlZK?=
 =?utf-8?B?SHIvdTFCVWVkMnNzV0pZQjl4U252YThNbDBIYnBzb0hHS252QTNkN0cyZlRX?=
 =?utf-8?B?dGJsRW9WaGpMTUF1akhlamZFUjdqOWRPK1g5dmt3RkpIUWhzbTEzZWd5NjR5?=
 =?utf-8?B?TzB4cW9ORUtpVnR6SDdTM2VrZFRTZURWdGdWYWUzYi8rdy90bFViS2Q3VWxT?=
 =?utf-8?B?TUxMaERBUWU4NnFmRm42a3hZR0tlWHZjLzh6dFM3Qmg1VndUN2RrMFZtK2JL?=
 =?utf-8?B?MzNORmFCZFh0d2JDZlZNQUtjZFc0c2tXblZPdXk4SDVsVm1mQkFIaFhYWnBW?=
 =?utf-8?B?Wk1jbmFiSlNPRDE4cnN0b3kxZVd0MVRwd3c5aEtlb05LRjhtWWNQNVJtNDZ2?=
 =?utf-8?B?aytBd3FFOFdoRGNhSTRPb1FyUTZnS1dsREl2Z3ZYZEtCN3RiVFZEbEs0bmxp?=
 =?utf-8?B?WnQvWE1qUXlJc2lYYy90L3k2OEp3K1lqanVMWTVrTUI3MGxOZ1hmM3l2Sm00?=
 =?utf-8?B?TDBTbzg1MzdSelZFcUtPdWRlem1pazJHTHRXRlFCeTljUURNQWJKMCtuV2k2?=
 =?utf-8?B?WGtEbU8vUnNPQStSY2lkV3FzZkd0TmFEemEzTjY3NVlTaENOWGN3UGxOSGFY?=
 =?utf-8?B?Z3A1Uzl1aitrKzc5TVR4akNTTXpFMkF4MzFYdW5ocFhMV2VJSENla0xNQVht?=
 =?utf-8?B?RGcvNTdTb09vS3pSeWV3YnBFU2RWTW9ITnh4MWV1aHpLdjVuWDllT2l5Q3hV?=
 =?utf-8?B?QkpxbWtGSTZvenhFc2RLaDFlZjU0UnA1c2ZWanFleFp0WEt6aHlPbUhXY0lG?=
 =?utf-8?B?VXVXYi9VWjVmSzN2THFxZTZKZXBrdXFGb3pQL1RQcTExVUpxT084bVNNVGtt?=
 =?utf-8?B?anB0bjZkd3owRmNla3NJbGZ3d0ZTcmpyN0tZTFFyMkcvbTQ0Vnk1UWZjdjdR?=
 =?utf-8?B?eXZMVzB6MUNKNVgzRnQ5MFVObUlPSmVZemt5ZExOWGdlQjE2emFZblBMQ3pF?=
 =?utf-8?B?Tkd2K09RS1Bwc3NNandmWWQzMFR6Nk1vQnZxQ2ZaSERyRUdaMElKSFVpbnVD?=
 =?utf-8?B?a0hNaG5wd2diTnRKcG1lcTFncW5IZlNmSjZCWnd5WUJLajQ4SzZRSVozUEZJ?=
 =?utf-8?B?S3FnbGRrNm04MWtaVU1hT1J4Rlo1VUFvbkowM0ppdmNFKzJLUkdIQnAxRGpH?=
 =?utf-8?B?MHNpSzQ2NFZLZkFPcmg1VFpFeEovTmFpTThVMlRmZTdhZUtwZHRaQXpyZjlX?=
 =?utf-8?B?T1ROdEdQVzhCWWdsZHdJb3JmbkpMVW55T01ac1phTzFqaDZVcDZEVUR2SUU1?=
 =?utf-8?B?a2ZGSGszK05yOFlGdmNJZVNOb2RpajdrcW1WZi9xb3BKYjJtQjdlWGsxS1Fh?=
 =?utf-8?B?SnM4L2o2ZnVjSlIwK0tCYm1IVEJId3l1K2k2SUV5WjFvUDVoWTU0dz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c373d0-b894-48e3-e7a3-08deadf8ec02
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 18:29:37.4434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JOJY42Eiqzda4i1vAjf4UckhQL0maRglgCZH3YsAhlqCVxQp805aTg+0cMJ5fDIyhbi2hKpl5+Ylo05hXvaXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB7306
X-Rspamd-Queue-Id: 5E851500FF7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15700-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,infradead.org,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com];
	DMARC_NA(0.00)[atomlin.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,redhat.com,amd.com,kernel.org,suse.com,ashe.io,gmail.com,abita.co,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.887];
	RCPT_COUNT_TWELVE(0.00)[35];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--bfnb57jctgu5ouv2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
MIME-Version: 1.0

On Sat, May 09, 2026 at 12:48:46PM -0400, Aaron Tomlin wrote:
> @@ -3592,7 +3592,7 @@ static int cpuset_can_fork(struct task_struct *task=
, struct css_set *cset)
>  	if (ret)
>  		goto out_unlock;
> =20
> -	ret =3D security_task_setscheduler(task);
> +	ret =3D security_task_setscheduler(task, NULL);
>  	if (ret)
>  		goto out_unlock;
> =20

Apologies, we want the CPU affinity mask here too. The NULL should be
replaced with cs->effective_cpus. This will be addressed in the next
iteration.

--=20
Aaron Tomlin

--bfnb57jctgu5ouv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmn/fQsACgkQ4t6WWBnM
d9YjuQ/6AndL9DQe3dSQXU2X/diy4JIic5ikCsyVYf2QgjbgIBCfItEzPMiHrWW5
qh0lupYXoSwdnMWhCnwREcGG6+9svLfSZxKdXiSUIoLS2f6nxvrx1oUVktwx6hyJ
ZZUda7Ts9MAhGtTBZAVFBlUlIfXQAjejM+3D1fEhUDkypW7hlQaagx9JLW2dqG9N
NRIeQ+v0oL0hJMbLSzVuIQJgurrbLNkWYIaMe0qRZTZCfk3DzDpXZahnCG4lTjNm
oLwMbJYBC6RZ9HVkc02X4z7odzwvIYmLWq7B7TiC90HTSSrlm4348Y3oBEjCgm/H
iK6kN5hyjaYtK6TZKdZR5f068c1pq1yZaeHqB5eS4/dMpLunLnMbsYwFWah9TwaH
D2ACkHHnguLoxJnvMrPUx37b+bP6QxOxj49cIaUJYO5PZAWqXddcoQr8I/7Q7Rej
Xo6HlLqHBrF4X0HVEdCOLNLBXgTR6zPVjMaSFbculvZFtbvUBjEzw3AN/ySUmMOj
H5GMTfOLE+NChlyCOFW5pHgUMPSfFhj2kh+IDypLM7C7h9I+kWJi7gUU5BrMy5st
EwMJ401cX2SEMC0XEFxxNcAhkTsUKg43wM6yU2TmFF4curxDPqIwFZsIQK7ltmAn
X2VMCt+6grjkmeYoImZAGHDVJcp9+pCWE1PkkiUp+TjxGh2vyuE=
=YX/I
-----END PGP SIGNATURE-----

--bfnb57jctgu5ouv2--

