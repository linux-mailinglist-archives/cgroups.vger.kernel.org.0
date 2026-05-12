Return-Path: <cgroups+bounces-15865-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCFcIT2EA2oJ6wEAu9opvQ
	(envelope-from <cgroups+bounces-15865-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 21:49:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2290B528D10
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 21:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FCFE307376B
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 19:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D32E355F54;
	Tue, 12 May 2026 19:49:08 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020096.outbound.protection.outlook.com [52.101.195.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CE03EDE47;
	Tue, 12 May 2026 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778615348; cv=fail; b=FW2fB8BLgNEJJ2Yos9GWCS4MmcAeDKNMJleNbfVzIv9ldqYGcB0hYxTmopvaJgv6zDs+un9shnx4o0mAiy3yDivMBU/vBU5uRWtB/JKsy2t6j4l/sn7pspThfhhMCAPDKQV547UkJsqTbH2hfi9TW8byo1a1C6vOarc8rLMKj+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778615348; c=relaxed/simple;
	bh=05nVaklWlKnuIj99XCcMvQvEsBiL0FTCTRQFqK4oLV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LjD7DtYoOkcf/GApjsqSYnp3G4FNv5HRdRMlCe5Bv5JPjELqkD1BsprCrAA4LthAPlHKxQ1iIPjrucowj62SfBzGU9Lz7YvGva3je3CMr+oeQ3TRWKAkrGs2OkCmmfakxXE4DkZyp1IhVEYxK5l72XVDRRnCXToY+dmGa/sZ9x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkFkIGu0TNu1vDWVrVtQh5oyt+RKGRxLNv/WKRuiR+rM/qjo3SxRKJQnIkQIM+9PRhaR3YviqS1D8WkXfulzf9korjU/Wag2P/whALmmat8PxmrwbvN4uROMLfZ9OOjXUyWkQuMlIKbYcwTWkUVzjE6UtKxRhwv/OrrF1B3oE30yaRSJDEOlBcVYP+kZ8vThMHyM7s6qNbNgXgoYRlov5YVE8Nnd3YIuawCPew+DCifo8AKHlZffFY46EyIPattW5UsdHp6nd1MhoQczCaWPHPr0RyE62j8Wc6NG7x20MNvaMRFgSf2TNKo7XFxbx0iTNIqE3I57Ng2huS5AGuh/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQs8FaRhvhOz02LcZ5XSa+oW4AR/KbhNCfkmbmgySo8=;
 b=ZGh+jBAyae8HlFLMZWkCfpcHTP3LXdL3hewdaHw7Yy/S5cc4Wn6MY22tnV+fsMEe1hJeTpby9uvjtiuFOWWZhPiQ7/ZtdssMQe0Eyjn1kgal1Lugl1FtZwzHakRhxzovM4la89jNJPK3SbJwLMsD+4i8gSp2iB81JXHW9HyKtUrTuxw/9/veLBpVlqfEuidUxDlTkX0HHQbClO4uCd6NJKEtO5IMjV0CVX9pJn40lpVAJzsw/ppqtVo3jrPoubHWKSYSi4rc/uP4wq54t3CqoAdaTvWnO5Ya4NUX2kx0OjYC1GeUFumrYfqfzlaOb1X5DTEPwdSYtCf3CnrJE92u+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOAP123MB8340.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:43a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 19:49:03 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Tue, 12 May 2026
 19:49:03 +0000
Date: Tue, 12 May 2026 15:48:59 -0400
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
Message-ID: <bscbywzzx4nmxzbuw2bkzltb7rrmgmzy5u4gqy5pfpmafcnlto@eznniiguusqb>
References: <20260509213803.968464-1-atomlin@atomlin.com>
 <20260509213803.968464-4-atomlin@atomlin.com>
 <CAHC9VhQthq7y2akbQSdJwBEex1MQYWG49wcJK3b8gSQuQ_d1cQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xpeaqr7xbl7sve5l"
Content-Disposition: inline
In-Reply-To: <CAHC9VhQthq7y2akbQSdJwBEex1MQYWG49wcJK3b8gSQuQ_d1cQ@mail.gmail.com>
X-ClientProxiedBy: BLAP220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::13) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOAP123MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e33a71d-cca0-482e-1ad2-08deb05f84cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|18002099003|27256017;
X-Microsoft-Antispam-Message-Info:
	5EtELfs15bpnFovr0XXWZJ4xRdfcydtMwVQTZs7rkjSABREqlgThz6OnHQHFAiJffyxR1tG+XA/r9hTrj75x3WhfuqNSi1jQt81znmBsDpJB6GtC2EbhASWwCTKHCBw3fzyFhlcC2917Jac1l/fCyARo34L25PGnGvqRADLGCHVHqNuYVdYiwlL41kSro1gIsn+R/YUFLpH6EDS5BsEzI0hQmZhdXvZYlkbe0Hzq1uHhgNIQjnuSLfVMA4wjvD90+ixuqn71wJRKwuoQXk083Di0Whz1Hv6xrpmAgx9vRG8u9U4zYXxgRaoUquq/of0ZLdJk4mNKeeFtxuNnFMVYi6TSM16Ar6t7BrMwi7kewYgk6A2DyrjQJ1+HMObNkj0S6PEQklIIJqYHJGNxXQiE7fiFwlgo14oVI7qtPjBXoOQgqPAYrmt2Mxx978bmW0ymVdhdftvLqJromNO/toXhNJS8kzvdZDlWfKo7akg5e5ZeuqpVTdJNql1DLoyYgc60/zLEW4LtMn7uO56Mbn+Pg46aqoublJuEGhhGXzTJ/20rqBV+rcwdc13L0XXtqd2hNhuPLq0EAXss9kIIpkR2jXl4bCkHGH6vAXy1JL8HFXqPups4uJYcFUiVLvfj4KvchouGyK3Q8Px5ZAXQDUjd58szQoH6v3VDIeDvwX2XCcg2HkjsM3u2isa30fM/X+96J08bCGVa0CbksK8+YehRjs7NEq7CXzgfI6yM+mjrrETU/07uQWP9Ji78JchFoejH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnFzTy9ibWoxTldvYTF0dEhHbFUzWUVzbDArSDhORHRRM25xMG15L1hpd3JB?=
 =?utf-8?B?dEVlU2JNK1E1VHFJZjU1Vzl4ZCthOFRVdkNLZFJydkF2Q0VHcWp5VVRpUGNu?=
 =?utf-8?B?UkZNZW1nUWRaMXFXbk1hcE8vbmNWdXVjV3E1a0NnTklWUWZwckpsSkRtUklw?=
 =?utf-8?B?WlVMc1JXNitsUVRaZEJsYjRkVy9kMkhjY1hVaXpwSjFBTWZlZnZBMjRKa2dI?=
 =?utf-8?B?S09Qb0VGY1JOcUdKRVJNMnNLR2dMQXRKWnZ3NGtaclFBTjNPL1dsd1k1U1Fl?=
 =?utf-8?B?dlcvQ25RY1RPWG5FcThsaCt3NEdwdkVHZ1QxTUY0Y3NvTFJOWGcyZmpHQ1RS?=
 =?utf-8?B?enNRcGxWdGZsUkUvOUpFVkdWNnpQUlo4Y0p2MW1pTWtyU010ejN0Ym9DMUFP?=
 =?utf-8?B?V21LbzJJVU5ReWg3V090OHBEZlF4UUQ3NmZodWZsRUVNM2IwUUhxa1VZVDd2?=
 =?utf-8?B?OSs1YzFiSCtuR1ZYa2U4SFN5MG1kMlV1bURLMExQUFdJZTlaVE9zVno4Y1A2?=
 =?utf-8?B?MzM5aXFycWZ4Uno2YnFGSUJvNGtEdUxYWlNNblB0RnZoQVBkcDVlY0JtQW9M?=
 =?utf-8?B?WEtGcTBETlBMUCtpMEE3cVdzQ2RKeTN3OGNDbmZTeURleHRSanNObHBMTGVO?=
 =?utf-8?B?TGJyQUp4UjRXNW14VzV2dzFIUXVDa3pmSmg1ZjNmd3doclBDOXd3WTM3WkNv?=
 =?utf-8?B?SmJyYXdNcHJDcXVKUUxoMGIyRGFicDcxU0FMbTJlMEVURDJGQ0VHWTR6Z3Vu?=
 =?utf-8?B?WmZ0akRUaGdxdTVZVGVVb1ZySWtuSFVtTXhwa2cvalVZSnlKaStqWGs2TnF0?=
 =?utf-8?B?bFdIZ3puUmxGM1hqYVZIU1Z0eEVmVlU2YUhyOFo0T0gzUTJYcE1vV0VsYnor?=
 =?utf-8?B?Q1NweTV6WlVLZ3ZMNi9NSzU5UFNtSmVQUkpENzJVemJwRkkyMWhGRXFnUlRv?=
 =?utf-8?B?TGpYSC80OFBLUGd1YXliQXVPZ3h2bVFWSUcwa0QrbkY4UzVTVTBMVkhsTEZV?=
 =?utf-8?B?NjNWSXlkZmV5QW50VG9KZGUvRmdjWVRQbHpMVUpGcFBpak1LNkYrWm1pMUJl?=
 =?utf-8?B?QWg5dmMwcW5qU1lKVFRJZWhPMGdGakZzUUxnMlY5UmJwWE9MOGVkYXJHalRv?=
 =?utf-8?B?T05kQXFVcUlPN2dDWnJhOVVkWWtMbml2NFNDSGUzNEJqeVpsc25IaGpudTMy?=
 =?utf-8?B?S21CWjM1MzBVaktYZEdFcXZYRHJrUWpEcWo5eXNLOVc4OXBVa0dRa2hYM29u?=
 =?utf-8?B?NUZKcjVSSjJQaTJZTytDNlMvL3pXZ1NtdHlvb1E1L2l2NmI4MGVYRkJCQlNx?=
 =?utf-8?B?MmpsSUtQbUdoZGZWSTlPU2JLZFluajRQd0Q5bzZZZFBHeDN5R2k1SG1RYW5r?=
 =?utf-8?B?ZjhxRm5MK3gxTGlHOTFOQmVlV1BMMHhpUXVoZHhtdVlndkRzS2hkaFB2RjVu?=
 =?utf-8?B?ZUc5WUZBN1R0THMvRFQrSFl1VDFHWTltWTBPWStRRHpSeDJJRXBGV0dFeS9G?=
 =?utf-8?B?bktDa1IvM21ZTUlRNE9OOHd2aUdJVTJOMGJxYkpMMkFtUDRkamdodVlQUHpB?=
 =?utf-8?B?OXRaT2xsRDVGalBZU0tEUXhWRjM0enFtaEpSZ0ZIeVp2RlprbkkxeGdLNndR?=
 =?utf-8?B?OWVkYUdqbnE3WFJoR1dmcitlWHpQUDZLQmtFektkTkNEVWdoMU9jMTUxdGl1?=
 =?utf-8?B?dHV1UTZ4eWZMMkE2STEvdUJRR08wRTlid1llVW50RGJlM3YvVUlGdWlvMERD?=
 =?utf-8?B?c3kxdWVxZUdUMGwxUDc3WnJXS3NXa0Zwc29XSFRkRTBRcFVpQkV6WDNUTVRw?=
 =?utf-8?B?eUc0ZHVBZlZFYnZmZXgwT1ZFUGhKWFM1Y1RNenFKcHp4S0p1dDI0UEtBL1Bw?=
 =?utf-8?B?TFBocmJ1YTRsbkoxbURqUUFMT3o1SHIzS3U3ZjZpV2E1TDFpTGdsQ2JuUEgx?=
 =?utf-8?B?OGFoU3hQVHFTdGtZbjI1NHlyOHBEbEJkS09nalBwOHNqYnhIQ3ZKeHdnUjB6?=
 =?utf-8?B?MEFTQVNMSUxCVzBmZGhjQWk3dE4yZ295OFBpUjdHUG9ZeFhNWTRHOWYraGV0?=
 =?utf-8?B?T0lGZmxnaXovZjRrOFlPNmJ1R1RUUGovUGFsdXhBWGFic2hUN1JLTFN0MkJ5?=
 =?utf-8?B?cytjSW9rTC9qUDBCNkRydGJFWWdUbDc1OVpWOUxLYmR5N1lZQkNXd1Ewb0l6?=
 =?utf-8?B?OFFQN3c2UXFNRHdMeG8zd0poU2I3S29YNFR2dis0aDNSV3kyMXNERmwzbHBw?=
 =?utf-8?B?OU82YjJnMTVISFQ0RE9JVm1sNlVlWVJBNXNuMmY0UFc5MDZlNlhTbG9CTUUy?=
 =?utf-8?B?NTR4U1R1WG4wMXNNK2RkeGYwa3lTS2VCSDdIRC9JSnpheDFqMmh2dz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e33a71d-cca0-482e-1ad2-08deb05f84cd
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 19:49:03.1580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfmR3zccs0ooXRVxUZljzdu4j5Me5PrdcExdF5L/CPN3EItzmXNzBHRNgjPjGXCH0yHDs39H2P5WAXQv8rxxrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8340
X-Rspamd-Queue-Id: 2290B528D10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15865-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[alpha.franken.de,namei.org,hallyn.com,redhat.com,infradead.org,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com,huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,amd.com,ashe.io,abita.co,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--xpeaqr7xbl7sve5l
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
MIME-Version: 1.0

On Mon, May 11, 2026 at 04:28:09PM -0400, Paul Moore wrote:
[ ... ]
> > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> > ---
> >  arch/mips/kernel/mips-mt-fpaff.c | 30 +++++++++++++++++-------------
> >  fs/proc/base.c                   |  2 +-
> >  include/linux/lsm_hook_defs.h    |  3 ++-
> >  include/linux/security.h         | 11 +++++++----
> >  kernel/cgroup/cpuset.c           |  4 ++--
> >  kernel/sched/syscalls.c          |  4 ++--
> >  security/commoncap.c             |  7 +++++--
> >  security/security.c              | 11 ++++++-----
> >  security/selinux/hooks.c         |  3 ++-
> >  security/smack/smack_lsm.c       | 11 +++++++++--
> >  10 files changed, 53 insertions(+), 33 deletions(-)
>=20
> I haven't looked too closely at this patch yet, but based on a quick
> glance, can you help me understand why it is included with the other
> two patches in one patchset?  The other two patches look like stable
> level kernel bug fixes, while this patch introduces functionality to
> an existing LSM hook; one of these is not like the others :)
>=20
> Unless there is something critical that I'm missing here, I would
> suggest splitting this patch out from the other two bugfixes for
> separate handling.  If there is a patch dependency issue you can
> always mention that in the cover letter.

Hi Paul,

Thank you for taking the time to have a look.

You raise a perfectly valid point.

Please note, the cgroup-related BUG fix will be dropped from the next
iteration of this series. As per Waiman Long (on Cc), a solution for the
BUG was already proposed here [1].

However, I suspect the MIPS-related patch will need to remain coupled with
this feature patch. Because the first patch fundamentally alters the
signature of the security_task_setscheduler() hook, the MIPS FPU affinity
code must be updated concurrently to accommodate the new parameter.
Separating them into entirely different series would likely invite
bisection breakages or awkward merge conflicts, depending on the order in
which they are applied, no?

If this approach sounds sensible to you, I shall prepare a v2 series
reflecting this restructured grouping.

Please let me know your thoughts.

[1]: https://lore.kernel.org/lkml/20260509102031.97608-2-zhangguopeng@kylin=
os.cn/

Kind regards,
--=20
Aaron Tomlin

--xpeaqr7xbl7sve5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmoDhCcACgkQ4t6WWBnM
d9YfiA/9HVuly40Im7Pag5DmcL6QtcWejvKWzWzyGGWllLsUtmdpOl+o2S0aQTrD
tUj2t2nq9lrYORqzv6xr0iiTVkstPEYXSV+tQyTTqFo7rs6lnU9FGGqrR4+diWJz
x2Bf1lvW9N8cxfuDPJc096OT30CPL/GXGiXCAou3G5Y5zCVyF74M+njA31+yhove
9dIUI5HRCbat2rftSkOXhvqpub9lII5dCEg0vYPJZcrwZcbCc0tgb5y3Yq8svnwu
6RNOab4rPz7jydPefTO+nVN/LSW9Ic1Ih4ZX417MX7rWxUo3by3HTwASqyDqcoFw
ddFKEImoNGNsQ2ahQLp2ZXm1OSqxRwRRRtffwhg08aaPtq3tplpg8OX5iKIs8blo
DomXShOYMGiXaEqaMFoBIFsDf33JzdG4OfP5AY2U7UEzDB5NnAX8RDx4y7fl64sc
Nx749lttC8BpO8E9eNMXyxP21H65P+PDbYsBgzGKuYagPu4kOWR+6CzJ01BsF7K+
Oe13s52km5HMs1e9v7Dd7/hyIunXyr4/h/MS6tY2DYQdrMYkatgof05Le3TSd/bs
hURMBZc4tDBhqiZ/tE5nw/Z6Xgg+1hTpAINcIEiK+T3JAKaPmfILihr7mQ78q1m8
sKgAMfEIPmO+kSFZQY9JTRU0PbvEJIM5XY4gY8blK1oc4a0lhtM=
=68b7
-----END PGP SIGNATURE-----

--xpeaqr7xbl7sve5l--

