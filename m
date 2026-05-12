Return-Path: <cgroups+bounces-15864-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFqxEimCA2pX6gEAu9opvQ
	(envelope-from <cgroups+bounces-15864-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 21:40:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AED528C47
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 21:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE81430A7044
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 19:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A645368D7C;
	Tue, 12 May 2026 19:37:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021079.outbound.protection.outlook.com [52.101.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6902D6E6C;
	Tue, 12 May 2026 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614643; cv=fail; b=jYoCeZj/jYWt0+p0BtumUPXMWdF5epk961f8lTm16mAKdNVRpmoxrSfKLf0UookD6rIEROE+IRW7NMNdbT2DOL1fEKRKJluXkhJJn/a5Q5yXW5g0Y45vP8aYfVJmzpTOopSUy3lwGfqGbZtCpObnZdI0+jZFSxC+xCjVbiWj5YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614643; c=relaxed/simple;
	bh=N+Upmdi4iXoh4oCsoEa1pY0D7tui9pMrmwMfnni4VpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L1bhKrXceWKwKTuwAGt08J+MyoG4YCm/LqI5FC6Mou9fPcunlbOTN6JinJ45of62jb0WW9j0XqOBcNGKIfjIwG0sRpQJUQ4BTy5LNmIwG0e0ji6xheChRWUt8Wh7v120Jz7Bu+uUu28EiMNTXCNAou3/L3nkXm3tSDGf/9Th/kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmEV7EVtyqgudJAsCowU+3POqqb8bapuCfSxre1fLXnCYLkS8FamFkNHGKKDB6+edyj2Ts2pDGaAmqRuzEcXsH7NsSQbUYKalrqN1GmxJDsAm+1gJ+UZOQnP29cZeK/3mzYzzNBH5OT46TxY6NtozYg3JMoFlYhsZ/9i+QIVEQQ4ZKEmnn+En/i3tAohPVIkUboE/azh/wTSUv8TQ2N+RMu5+ig4err3NZ84/3HsmgrK1JETOEuWJqgujaAENc1WDRaXgX61zCq7gsR9rii/Zn73HEmvCprpxamUswb6SF10z54PN7PT/RVZeWXJZrkBSC8PFkIOH1RoPidmFVWUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zfoxGhVQWZ5do4/5OtEIlYMnxXrN59EaRAFwNcRNA4=;
 b=pg1byDJuTJqJHfNjA51YQKB6cFWrdl+E+E/mFw11I4mSL11tXsIDIIJ9AiW5GDAYcXY2r/2cFNcqWr7anlfT7/ABBmaJm8ExZoXv0SWLfQwySGbWarRAjD1NCzUU86G9l/KG5fYFm8T+LJSDv0mp22V9xGftygymxn0zruAXJC2zazCUyws/5JWOWbuerGnMNzU8DNKU+YPHt1EVuQVTcOlPksqfDG+Fs7xAyAdAJozCwsvuHNnbDrG4IQ5OE+vqRzcAp3fLFuTL2So5fPkQmh6Lsa+DRLeKEP6tzByAtrZkZJVzwX/DEGSo5BHjlVXj+sN+oTY9Uh1yg4q6aD0G9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB4310.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 19:37:18 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Tue, 12 May 2026
 19:37:18 +0000
Date: Tue, 12 May 2026 15:37:13 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Waiman Long <longman@redhat.com>
Cc: tsbogend@alpha.franken.de, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, stephen.smalley.work@gmail.com, casey@schaufler-ca.com, 
	tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, chenridong@huaweicloud.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, omosnace@redhat.com, kees@kernel.org, 
	neelx@suse.com, sean@ashe.io, chjohnst@gmail.com, steve@abita.co, 
	mproche@gmail.com, nick.lange@gmail.com, cgroups@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] cgroup/cpuset: Fix deadline bandwidth leak in
 cpuset_can_attach()
Message-ID: <qdmjv7f2zojwxk5nm3roupwgczd6adgnolr5u767tpcgv224ke@sxp6sjevqv3r>
References: <20260509164847.939294-1-atomlin@atomlin.com>
 <20260509164847.939294-2-atomlin@atomlin.com>
 <8aaa7dd9-2426-475c-af64-85ef5f2aa855@redhat.com>
 <aihz6zlfmcaxwb3ef4luisfpwqibwsajpphy5vzuksy3ftfkms@whhv2ax5plpb>
 <354af9fc-1c70-4ee4-a0ff-8821bebec7b8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <354af9fc-1c70-4ee4-a0ff-8821bebec7b8@redhat.com>
X-ClientProxiedBy: BN8PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:408:d4::28) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: f0eaabb1-5c36-499e-7798-08deb05de06a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GO3k8wAI/TqtZ2zXQr1Fb4kkQ+1ocJ9P0hWCjS4JcPeYW86fSo2X0hlBw+BirUimZLufDnJ/duAVf7oJmMavvWURUwBAKtOM6nYnyCazokjQvsi83f15uAOMU7SrqyuZSQxcKKQMef4oovTOBrynTN/TJ6odroDPEFB712rZVxyHYXt0m2cLbxNdB8me4s95cz4qdUvfBLdB3Gr4xgnM6JOZCBaw/fb0NpwiedXo/zqWDuPppduDAcHSjDGpgClM74/hVn9izw17YkG8+8qMyZyQ5eu8i+Vi3n2hv91kXNNViQ3NwPU35YIhAfGC1NjGdIh1L2j5L/uIOjsRKyWmQQssQ6MShSoY6kbaSvlfI/fDw9+YqQ43wZFpc6wfFRPLOx9kGRQT9SefZeeO0NSQ/+jpUqNQrQrP2xtFyvhl5X/coNgUiDT3LRIYtsiv7CArS/EV3TKA/JjbAFjvdbWPUrqZHdLuhebLa7U6O3+bmnx/r63zBstfEX/GYSvYNoqa/1Bp3kDhh5W2LW3VRIJjF7FfT7KjLly2wP41q+IU5N/S5F7ZaTv0pd38fxJZWIwTBrjqEdf/Oan/YT/ditDa1+Y4wytN+Xwr3Ga1s8fSoGDP+NLYChQ6UUQ+9iRY6fQQwZVjJjGu+nzQIWNaCVfJE4deyS8cpXgjFjARXhicZEUA8H1dEHlBWha6ftCOc95QwOoO79/hvGdYFJuP5mUtKg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yll3T1dNUFdwUnRHamQ3L0FYRXhsRVpyUDQzdWJHaHErZVNjN0VPRVZ4OU0r?=
 =?utf-8?B?SkhFQmtSaGJZUlNDK3h0NXFvdnB1alJKSEUxYkVFVEpwaExuMHBYMUlOSDEy?=
 =?utf-8?B?OVdlcFk5bkFJMCtHK0x0SXZySVJwamJPT1REajJ3UDRYWU9PQVB4anUzUGlV?=
 =?utf-8?B?TTlBN1hkMzFjRDdXZ2gzaXJKbmE2Y2RMVDk3T1BQUTRySjdWaExHMHlQYlJN?=
 =?utf-8?B?ZlFZVHR5d200K2hmdG14NjJwS25PcG5ON3h2U0lUSVhqNE1XZGZOTy9xWXda?=
 =?utf-8?B?RnF4NGVrY2hnY0VobkVTM1FrSm15MUNkVFhObXhRYjZwN21KMkxlRkJ0eCtF?=
 =?utf-8?B?YllLZ1JkUFpuQW02TS9acUU2bWFXMmJFZVl5cjFKSWFpblZkVUtrQ0ltVW1B?=
 =?utf-8?B?NFVrK0YwUGl2ZWlxbU1QTXozRUlweXZubUVOT1dydDRRRnlPUFJGR3diTyty?=
 =?utf-8?B?Z0ZFTmJKTEFjMXNnamxRY25haDBBTGpGMzh1ZGRXeWtPdVI4YVY1bXpGZjhN?=
 =?utf-8?B?VUN4S00rbGVpazUwUDErOGp0a1FtcEdiRE9qQlM0ckNLQWN1alJUcDhMcnND?=
 =?utf-8?B?NTE5NXFOUm91RTlkZGlpVUMzMHB1blc4clU4NzFFVFE3KzZPK2I0OHNTVG9y?=
 =?utf-8?B?WFdqRlRpYXdvZUxLY1lLZDNCc2pJRHRZM1o0Q1lhMmc2VVZTeUdTYzhsM25N?=
 =?utf-8?B?NjZmaTc5aDdzRXFPeS9JQTNiT2dPNUFBcFdQa1BaWDRNSlJORlFIVm1KcUwz?=
 =?utf-8?B?N2lSc0d2U0duQjFqYkZSREo0cGlxTUpvZThjQmhwZDBkeXZ2ZWFmQXNlNVE3?=
 =?utf-8?B?eXo5LzYrMFp6MFkyNWxiVURFS05oeFZjSzhzOGVYd1l5NGo5bmtuOUEwSC9U?=
 =?utf-8?B?VnZyNklqa0MvMWR4NzhKREJJcUV3eXYrbDRmN0VBRXNuVDNTOVVrWlpGbHhL?=
 =?utf-8?B?endhWjBmMHdQK1N0SVVlRHcxWUFNQ3BDVmhNR2pVbkhxVnBTbG1LMVAzUTNt?=
 =?utf-8?B?K3FHT1RYQ21FUml2OGlRRHIyNVZYd0hoUHFIQitLMWI2ejY3TkF4R01xUUhZ?=
 =?utf-8?B?RlBmZStnUW5TcEVNbWw0TUM5enA5WmtBOWVQNjNwSUZvbDVMU0lYbmh1RFlJ?=
 =?utf-8?B?QW4zSkhWdkF3YjlYSU02eHdiY3hva2NnZGNlYVhTcVNqcmFNZHplRVpwcXlN?=
 =?utf-8?B?Q2Nja2hVd2tvYWR0Mi94ZEc2Qm01OSs5b1pPMFk0L1UzMVdJU3duK3M0N0gy?=
 =?utf-8?B?SE9XVzhQT3BKU0U0ZVdncG9sTkNpUVZuOFkreU9PMFJoREl5b1o0dU5hS3JJ?=
 =?utf-8?B?SHdtQ0xzMld2UmxSa29vTFNIVDVwblBsT2s5VjBuZmJvVzRlZHhIUmdhTGcr?=
 =?utf-8?B?QU1CV3hMYWNLN3Y0VW1mdjdHdmJJdWw3SlRMV1RPVlFOcWRtMzZwanlPNkJF?=
 =?utf-8?B?Ylg5NXJITlJjNzd1b1o1S3d4czVKcjk0S2xHY2RCODZRZFBudDJnM2NlaDRp?=
 =?utf-8?B?Y0Y3QXA1N3hIQzIxUjh5NmdVZDgwN0ZNSUNWd21zWko2bUZIU2lwbW1aM3V1?=
 =?utf-8?B?TThSb3ZlRXd5ZUViUnczeHRHTUd0ZmZNZlBkRWF4elBpcHQ4cncxUjRBT1Bx?=
 =?utf-8?B?ajNmcXhzbU9CTUZNZ0Ntd1ZmRWsydU9pb2VzeklONGVTVDNCWjIwNndoYVZm?=
 =?utf-8?B?ZlV0bDVlWXQ5eHRNZlN1cVhBTUg0ekJRN015RGo1cDBtMFVmdHRuSWZnNjNm?=
 =?utf-8?B?d2xvdUZEZkEyVWNCeFN1ZWFZOUxuRGZCVnd2T2UvSFRKL09Pdi9QYUNoZTF2?=
 =?utf-8?B?VGdWV1d1RGV4ZjE5by9SOENxZi92VkwxZ2pKV3ZtV0IyclhuME5pOTVBcHRQ?=
 =?utf-8?B?UHg2ZkhrOTFiSGVGS3JJeW5XR1MvTDRFMmZYNXJDdkxxL20xL2pSbElLbDF6?=
 =?utf-8?B?YXNwUnIrWkFkQUV5NHV6andQU1crV3lXUlo2eHZQbGZHOUlmZzVER0lRallY?=
 =?utf-8?B?WjhDa3NERStmWlQwWHI3SnJ0ZGZWN0RkNVdLWktwTXBlc0tBUFg5RVp3WlRJ?=
 =?utf-8?B?N0xmUkQ0YXZLUFkvNUxQNGRMcE8vTDBDM2V4aWFnVFNYYjQvSFk0L2ZQOTNI?=
 =?utf-8?B?TE1CcnJaUTdSc1A2TmF4dWsvR2liVURtRXVMa2dQdVRBWGpMaEtPZndtcDdn?=
 =?utf-8?B?aDJkSjh3Ym95cVB5bmRjRXhJMU1hUmxvckhaejlieDFDUlNQSFhXbjF4N3By?=
 =?utf-8?B?STBtNSt3ZERKNjI1S01ldEhFL3Q3L1UwMzhCeEpEZnhxR3Bpc01sWENNOGEx?=
 =?utf-8?B?bzEvWHk4blhKaHRjQzlsVDNQWHhhdDFaaFlwUSt4T1ZjZVFmZisyZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0eaabb1-5c36-499e-7798-08deb05de06a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 19:37:17.9698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M72La3vXAQtoHjMu1TZ8lZXYzUJ0g8f38hxLehyUEgHFVRgVerKSE61qKdyMzddAKPyIolKzWVwAJySak1+B+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB4310
X-Rspamd-Queue-Id: E1AED528C47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15864-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,infradead.org,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com,huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,amd.com,ashe.io,abita.co,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 01:54:37PM -0400, Waiman Long wrote:
> Yes, it does look like the AI feedback is valid. I will take a further look
> into this.

Hi,

As promised [1], please find my suggested patch here [2].

[1]: https://lore.kernel.org/lkml/dif4xi73znyz3diguyxihzztgosvyj3bjeh3y3oidg4gnt2qpv@5nygeq3rk333/
[2]: https://lore.kernel.org/lkml/20260512010341.101419-1-atomlin@atomlin.com/

Kind regards,
-- 
Aaron Tomlin

