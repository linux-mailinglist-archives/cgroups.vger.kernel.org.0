Return-Path: <cgroups+bounces-17027-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VqdlJ4yBMmpV1AUAu9opvQ
	(envelope-from <cgroups+bounces-17027-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 13:14:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AE4698E10
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 13:14:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17027-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17027-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11669329543D
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 10:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BCA3C13E2;
	Wed, 17 Jun 2026 10:52:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020143.outbound.protection.outlook.com [52.101.195.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5556538A70A;
	Wed, 17 Jun 2026 10:52:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693562; cv=fail; b=TV/sDTQocc51vXehdSRd+ZxkVAzgyPimSXExnwyBnEFta//xDtRv7ZuLJHXZuoAhzEIXTAUoIkO9zg4PSNVtip2eg1fSNqvfsxGmU7EgBBoUstQR4SYSnTOLoQ0G+SAFdQFgE8+SuCyhWG9MR7323K3RfIEShoIBomHq2cdY5TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693562; c=relaxed/simple;
	bh=Wr+aBnJbfdhGZEvNr0duitBXthNEVXxqIgHWgcj4mPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=konzBnOM0Z9OhZDvbzhZ9fPQxSsBTp7HXKd7wRXdEvBi5aF/KLycxOenxr5nlPPLiaq6jwIGOKGXsaCPnowV+BG88RKF09ixKwWVlG9HuFCWj4e7rdZjPauFV1dtjsJZFnr5Aq2/1oPODOuNi+kvDhAFbCIckcI0zLU8aFn2Cfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.143
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AetnVKyGVGSN+VikmJt/hN0DnBSv3tt8GSfRB8bKVpX5aT8AWUMHubhvmfSx4rX9lX4de40CWB52h2SvemcgBfYJlW0iEUAkQ2ZgdQzfDMQqKIFeo4CAZfPQPBuwEYwVjnZPKf280R1/MdZNNG8s/F/n6Z91EOGqSY4CDhZ13cTkuSxH/p2bGEkeX63m1UiHIotNpJwFVuQBk3wdqbrjx4ynbHG/Wc3LlpcqmK9C+QWIVAwyPo5e67TvcHWn93iF85ylF/cJQ/MvKEZPBaecR3UeXQjp5YHSs5t1KVfBF2F3vPhw2coIbf6Q1ZmC8dWYSjPHGs/F2gKognEcz8IKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ArN8PUdRO8hBUt4rORXbWgXSnR2EgzPT7tnKz8cO9WY=;
 b=Z6PwTDVYpRSX24X/15snGgcL/R+eKuEBzkuoQiv1bruPMoXD+zQtSqjlrhBf01Y8ZKCxutARW1RYL/X+bScaCs/7P+x+IYpMAXhAfVhh6MHtNYiPncJFo40Q2sELS3r+JCgdd3cxJTNDHlu9hGmZIBVIzuKEp6hrm3f0McBmH/abc37xv9CC9M1bocWCh46XkheNCMrpcKIzMVmkQ90PMG/9zpj0phNocENPcWLVclnb+FaxqJwcrGAzVDCWad9xAxeUTb3Bl1hqs2vSjTmsGqqQYlqEF0F8Yq1CUYIsaiNJd+grlQejCJ2E5iNXA85Icy5d0FrRzSZ74wfbEH1z1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOZP123MB8515.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 10:52:37 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 10:52:37 +0000
Date: Wed, 17 Jun 2026 06:52:35 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Paul Moore <paul@paul-moore.com>, peterz@infradead.org
Cc: peterz@infradead.org, tsbogend@alpha.franken.de, jmorris@namei.org, 
	serge@hallyn.com, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, stephen.smalley.work@gmail.com, casey@schaufler-ca.com, 
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	chenridong@huaweicloud.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	omosnace@redhat.com, kees@kernel.org, neelx@suse.com, sean@ashe.io, 
	chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, nick.lange@gmail.com, 
	cgroups@vger.kernel.org, linux-mips@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
Message-ID: <ozsngetxq44lahategdi43sqrwdnpotsrebssczymqtkbh7snl@u6ytkznmpne5>
References: <20260526142838.774711-1-atomlin@atomlin.com>
 <20260527085221.GQ3126523@noisy.programming.kicks-ass.net>
 <bgjagepcfb7gz6jawatu6kpfmecw46gwg5cvb6r7dl3dn7bt4l@rtymdaslx7ef>
 <20260527155404.GV3126523@noisy.programming.kicks-ass.net>
 <ov33cu2wosubbfufcmfyoinfatecskjgmkvqyit33komlcla2d@2qgj45724bql>
 <20260527195858.GC3493090@noisy.programming.kicks-ass.net>
 <6hqq5oxvlcpmjvyns42dy2vtfvvixy7q4xyyjrrn46jrvsx5ar@gkmjsteqlpzd>
 <exlgb3dg2kwxgna6gx2qixexvwjjul7z2ya7npal2gz4jjtr7m@h4oxgd74gsbp>
 <CAHC9VhSROg6RGUN4_ZVBoEwYjRnKvyjnkbx2D88c09KiTgY3KQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sq3cvngnuvruys2o"
Content-Disposition: inline
In-Reply-To: <CAHC9VhSROg6RGUN4_ZVBoEwYjRnKvyjnkbx2D88c09KiTgY3KQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0537.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOZP123MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: 33cdc71f-82c3-492d-6d2a-08decc5e8b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|56012099006|22082099003|18002099003|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info:
	0RRg6fKBbje0B2P5zdimCXgvOKLtLVjmrLAJM13nibcWVmicJvNoipOxxRRSWz0+GVp710vzsdPA0gUl1GHmFSgtBuTMTE17XNk0t2sZpaKhFYgeIg961DjsXkruCyP/pgx51yHS9HE6Ecp+CnmyeabctFopkqN8ipz/DeAh+4Wcd6SXGLV8WF4KS5guHde5fwEPmQAfgLM474jnUeSbzxgrTJtg8uEHxKk49JavrseTH/RPwKrY1w8bnPlEb9f+6/TnS4nEXyJ/iGANkdQvK0tbufKWW18ey3w05WrrT2qJyd74yveT7EZJS3qMHNKECWHxT1J0jh4Wb1qrGUgWctHDw9XG2TFCx3/5HXXdAfuyn6kvi13Vy5OUwrtPxgyx4w2UuAzo5yJLPqu8+awlWv/wEAucQlMe4Lxlmu5UPvmeZHZuSoOJ8HR/mmH2bJPCU4j9rDzxswjBeCslGDWoKt6sXzg6zt+nbIsS4LEWvzDb89VJ2XjNv/5tSMRVbkwzox81D+gKDuZyO2cmiECeg1jMeAx8Y1n3ZcYClkZJaf5SEWRoaldTj4sIhyoyu3LQFpvWqhW7OgFWrvb5b6IXY/ah3pLVDLF+ZqbVu3/QJoPf1Yfs0VbzTOFl9cAT7EFwORCFSqMF1ZGwEansr5ZI80aae4qK5ea5ezE23vdFSWN4lGH9aNz2ShNTLAb4pMUSJ+IqmI26tCILsJlHn1pUxA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(56012099006)(22082099003)(18002099003)(3023799007)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlQvMy9EMGR2Vi92ak8rR2l0eFhzbnlqQkQzWGJ0UlQva3FGMlpYYTlKOXNL?=
 =?utf-8?B?KzNvK0RlTzM2UmNzV2wydDQ1cWVqdkJFd2ZnYVdzNDBGd2dHS3N0b2pTRXNp?=
 =?utf-8?B?dE10c2QwN2xZVXNjcXhFSzlFRHJiR3JLNm83UTVtQ3VVU1N1bVJlSlg2RHJW?=
 =?utf-8?B?aEhPYnNKWXJVZ2g3S3R2SnU5eFRocFM1dm4zalZVdlFVTmRqT1lDbmtiQnlw?=
 =?utf-8?B?enJEWmVDV0ZtN3VJVGtHUWlqVDVIMFNvWC9PS3BCS3JxZ2RRTURSWDRDT3Bi?=
 =?utf-8?B?dUh6dDY1UE81SFBNNXlqUE5tSHZtc2Y4V1B5WUhSWGNHZXN4T2VnNHJPL0Jm?=
 =?utf-8?B?eDBMRlVra2QzUytNaVRWOGNEUWlpMlF2aE9EOEc5M1FaZjZwS1JnR3g3Ukp2?=
 =?utf-8?B?OWRsNk9DQ3FLSzhLc05FZkVZM1ExQlJjNytSVmkzalRaTll2aWhtYTM0OFVH?=
 =?utf-8?B?V2Zjc1BvRzYydFJ3QW4zYlk1dWZyalBiUjlkRE1KdjNEOFhqV0JyelNnL0VC?=
 =?utf-8?B?ZWtoUHlKMlNvank5U0piRjJOQnVOcjIyQk5wVUpjS1UxaGxuSFNHKzd3SWRv?=
 =?utf-8?B?dnJLeDNOMGdsMTNBTW1rYzhUdGgxTWd3aHdPcXJQb2g4dk5odDFYU2ZUY0I4?=
 =?utf-8?B?b2FkYUlWYS8xZkd6UkM1RUthWE12Qyt2OHYvUW52cys4U0dEV1lac28vTmJl?=
 =?utf-8?B?VG1RWk8rU3VpUXVUYkEwTWdxclNtKzJia3o4SVFkSGF6UzZ0YzZoK3JZQ3dY?=
 =?utf-8?B?aVlkcW5sQUdPSXh2VGRYNnNObVY1Z1IwYk5raThOZWZsTE95RHZjNGtSbTQx?=
 =?utf-8?B?aUpvNmJsYUtsL1Yya0RaZ1lhQmExbEs5djFZelhpWDg2Tzh6ZTFHWnRaMytK?=
 =?utf-8?B?ejFxQTN6RThsMklEOUptQXc5N05zaEROVUZqK2tWUXk5TlhMbmhGMXlMOGVr?=
 =?utf-8?B?OC9WekY0Y0xDT3pPN05vb1FNdXVyKzh6VEJ2c3RZelgycHdtbmlNcktyd3pz?=
 =?utf-8?B?SW1vNU5ld2FSb1p4Y3ZsNFBkSU1BSlRZQ2F2Z3orRGtsV1I2SzRybzZuV0ZK?=
 =?utf-8?B?OE9vY0hUaVBUOXRTRkd3Vkx6eGpCTzJmck1CemtMYklkLzIxVUdabTAvbkRH?=
 =?utf-8?B?UXpiK1NQcHdmRHkzblNncVhKVUVSZlM4OWRFUHI4bGU4VzlNb2ZKbGpadGJR?=
 =?utf-8?B?YTduMEo3MUg3bVUyUkZValBpWXlNYU1vNHNPOWRiUTREWFlyT1labnFIaUFQ?=
 =?utf-8?B?ejNWRmVyNFl0TXdCbU53dWN0M2tMRXozTDRGdHZnaXJHQ3lKb1NrbjFtc1R5?=
 =?utf-8?B?NitIemZEY1ZCS1llTU9SdW1jOVJyK1kvRkVYeWpCTGJQWm1UZzhiR09vUEZ0?=
 =?utf-8?B?U0RGbkllUzRXVEhsU0lhWitGeG4vS21PdWRYUFE3WUxMM0hGQVNQRU5LdnQ3?=
 =?utf-8?B?QXFKUjN0SkNxSkl4S2ZnMFpVaVhaWXcwL2JZbXRPSy9NSksxTFRrazhvVUZj?=
 =?utf-8?B?UnV2cytEOWx4Ym00QzZRSHpnWmRKN09LcW1RS1dwWG5ydU83M0VuMGJtWXNC?=
 =?utf-8?B?WUZuOFlFMWdLVXh4VjhUb1kwa255N3JRVjV3NWw3S3lYaWRIQUFJcStySGQr?=
 =?utf-8?B?d2ZITjRIODc5bXEyQ3RPZTJ5TGVOb0xQZVN2NldYcDdMeGJWWVJUSkJMMms5?=
 =?utf-8?B?NzFHZG94Z3NIMHMrenM5UE5tbzUzR2FBNlhtNXJUdTlDRXVOd0I0RUpLZlFM?=
 =?utf-8?B?ZmlRR0QrRUF6WU1vY0RVNDY2ekxVbEFSTGI1T1NVYzdwTnFNa1FITFJQbjV0?=
 =?utf-8?B?dlNMNHJ6M2FxQ28vNmRXdXNrSStWeC9Uc2M5ZS90bWN6RVZOemF2T0lpakJB?=
 =?utf-8?B?TUxDNVdCL09ma1dHWWdOcVRtNFMyOURFRmxuWjZncjVNaklYQ21GZUxIbGEx?=
 =?utf-8?B?Rmd6alFGbTR0c1VqYWJuRlFlMk9TSzAyNHBRRFBZRVVESTBFT2dqZHJpT3di?=
 =?utf-8?B?SFBrajM4djZJbGFFWDNleEphbU9zKy9halZONDArQ0JvNG81MGhyY3RtZGVX?=
 =?utf-8?B?MDJlaFM0TzB6MVgreEp3bGZ3UzRIMGErTlZuZG5LTzkydGNqYUhyVlVMdGtJ?=
 =?utf-8?B?WWE4WWZmZGl6L2ZJektjeTcyOEcvbnk0S0gvcHdROG9XVUc3aVVZTWZGTXR2?=
 =?utf-8?B?QXhWOFlaN0JtRlJRYXYxV2hwQms4MXBkTTdSMjZaOWcvbUNKRXhpQVE5OTlM?=
 =?utf-8?B?UDVBSTh4TWRTVHlHTHY1Tzl0bWlHbnZvUDNyNXVFMUlZWE1EVlN5L1QzTytJ?=
 =?utf-8?B?VktkOHZrbmVDbUozSjlER2d1NFlWeGIxYklBY0NIOWVjQXhhMHBndz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cdc71f-82c3-492d-6d2a-08decc5e8b52
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 10:52:37.2408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIgdrauiXmzlUd8NZidih84mEoi5SlNXN9beGMznPHGuXoua6fpnDwlsZS2mYzyXjsoEenk7UMksgCgMG2mtAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOZP123MB8515
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[atomlin.com];
	TAGGED_FROM(0.00)[bounces-17027-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:peterz@infradead.org,m:tsbogend@alpha.franken.de,m:jmorris@namei.org,m:serge@hallyn.com,m:mingo@redhat.com,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:stephen.smalley.work@gmail.com,m:casey@schaufler-ca.com,m:longman@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:chenridong@huaweicloud.com,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:kprateek.nayak@amd.com,m:omosnace@redhat.com,m:kees@kernel.org,m:neelx@suse.com,m:sean@ashe.io,m:chjohnst@gmail.com,m:steve@abita.co,m:mproche@gmail.com,m:nick.lange@gmail.com,m:cgroups@vger.kernel.org,m:linux-mips@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stephensmalleywork@gmail.com,m:nicklange@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[infradead.org,alpha.franken.de,namei.org,hallyn.com,redhat.com,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com,huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,amd.com,ashe.io,abita.co,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,atomlin.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,u6ytkznmpne5:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17AE4698E10

--sq3cvngnuvruys2o
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
MIME-Version: 1.0

On Mon, Jun 15, 2026 at 06:03:06PM -0400, Paul Moore wrote:
> > Hi Paul,
> >
> > I am writing to politely follow up on the discussion above regarding the
> > proposed enhancement to the sched_setaffinity LSM hook.
>=20
> Generally speaking I wait until all dependencies land in Linus' tree.
> I've lost a lot of time in the past sorting out issues only to have
> one of the dependencies rejected.
>=20
> > As you will see from the thread, Peter Zijlstra and I have discussed the
> > architectural justification for this change. While the cpuset cgroup
> > controller effectively handles spatial enforcement, it silently truncat=
es
> > requested affinity masks. Passing the raw in_mask to the LSM hook enabl=
es
> > security modules (such as the BPF LSM) to audit and mediate the actual
> > intent of the request before the kernel sanitises the input, a capabili=
ty
> > that cgroups inherently lack.
>=20
> The issue of resource control comes up from time to time within the
> context of LSMs, and my general comment is that we likely need to see
> a more comprehensive approach to what access control on resource
> limits would look like from a LSM perspective.  We've seen a lot of
> quick changes to solve very specific problems, but I have yet to see a
> good proposal of what it would look like for a more comprehensive
> approach.
>=20
> There is also another issue to consider: none of the in-tree LSMs
> currently use these new parameters, raising questions about their
> purpose, maintainability, etc.  While this is not necessarily a deal
> breaker, it does go along with my comment above about taking a more
> holistic view of LSM resource controls.
>=20
> To summarize, I haven't thought about this too much yet because there
> are other fires/patches that don't (currently) have the dependency
> issues of this patch.  I would also feel a lot better if there was an
> in-tree user of this parameter and some discussion of how this might
> fit into a more holistic approach to controlling resource limits in
> the LSM subsystem.

Hi Paul,

Thank you for the transparent feedback.

Your point regarding the need for a comprehensive, holistic approach to
resource limits within the LSM subsystem is well taken.

To clarify my intent, my primary motivation for this patch is actually
rooted in observability and auditing, though I view the capacity for
finer-grained resource control as a natural, downstream benefit of exposing
these raw parameters to the LSM.

As I mentioned to Peter Zijlstra, because the core kernel silently
truncates the requested affinity masks before the LSM hook evaluates them,
security modules are fundamentally blind to the original userspace intent.
If a process requests an overly broad or malformed mask, an auditing tool
attached via the BPF LSM logs the sanitised outcome rather than the
attempted action. Passing the raw 'in_mask' and 'sched_attr' ensures that
security modules can accurately observe and log exactly what was requested.

That said, I completely understand your reluctance to review this while the
dependency [1][2] remain out-of-tree. I will hold off on pushing this speci=
fic
patch further until this prerequisite has officially landed in mainline.

Regarding your request for an in-tree user: when the dependency is added
and I provide the next iteration, I will ensure it includes a concrete
demonstration of this auditing capability to justify the maintenance burden
of the expanded hook signature.

Thanks again for your time and guidance.


[1]: https://lore.kernel.org/lkml/ai_T_uRkojOsTE-Z@alpha.franken.de/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/commit/=
?id=3D98e37db4a34d3af3fb2f4648295c25b5e40b20e3

Kind regards,
--=20
Aaron Tomlin

--sq3cvngnuvruys2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmoyfG0ACgkQ4t6WWBnM
d9ZhcA//biVOeNu7Ghf1XHuorsqqaiOTB8LTka+wFoWZuvi0jZ7yWd6S5MDno6cH
FO1J8gvD1TaM+XAxIdXBjkj39CEDoxxwBTPUvYkLiRJxpFLWzWGpexs0k1yL15vW
8tPBW4KSazailXkAtrnRqQZOHH3Z46PWNj1OLuVlKQq82h7eTiuins3RVIiP8nlL
xSEXBgrXiPlT6/XKxeJmMiCw1uqLEFvk3pEQk3ev159ItQF2dL/qXHLG4lFwM8N9
oMSwgicQIGNXBoQLnyaQmSt3JHE3nSKaDxV80ABF4MBawTdu5AnM5AVjXAfYf7pv
GvzBX3sQhgSnJ6sFeND+XEayPmpIzzxliEM7E0zsbIPmwzdBh7lQgcxKQc5mApNC
xREGn/BoZ6E6GYmc1fq2Fd7t37LOo2f8Uy2k0rjq0gzGxhzMSuSwKBNNcY07bOHy
gyhTixEqiztE5sG3NR67glT8bGxn569FweSRyLzcArEU2Ek1OVTnb1YmBh5MpYuK
5zrrOC0e8IICYoGFROE4eIul80+ThKYBYDym48bt9th2HPppKbZr921Fw7jfClBH
Y2AvEgnxikK309DKqQvUH1nIZ8OyirKEQ5isuONsdwey0LXjGOL3wHjIbbQWGKcW
jS3HgyXxMKkkgnmwbTxxXY4wgbPO0O1lme8BJCjgqRbFiirK9lg=
=mPCJ
-----END PGP SIGNATURE-----

--sq3cvngnuvruys2o--

