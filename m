Return-Path: <cgroups+bounces-16350-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPcKHcwKF2pB2AcAu9opvQ
	(envelope-from <cgroups+bounces-16350-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 17:16:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DE35E6B25
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 17:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC6393046569
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 15:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1413C42849E;
	Wed, 27 May 2026 15:05:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021139.outbound.protection.outlook.com [52.101.95.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E896426EDA;
	Wed, 27 May 2026 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894334; cv=fail; b=J9DfnWL9tHdYxxp16il5Df9q+6P4gvbFKHEwivC0OjKxNThOo7ZGF36bc6jciMbNFZX/LUVIY4iBNg8wCQnq7No97pT+b5N7t838QiQGA6Xc7MhjiscyAo5jhOtfXYW+O8JSK03fE8ilBpSH5jBopOuNks+CsumFvwjRr4+1dqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894334; c=relaxed/simple;
	bh=h8AzLWDmOj8KTftvlNvWLXvDLiNKzZ4oiYB+wpJONsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tJAMK7MjivgyGwl6qStbIShWq1IVnj6T0F89133acHUe4o5k4fHg6nax9k9fGFsn4pFnUop/56u6Gf2Pv7HIVnIql05iPuqSZcD6YlW+WDfykzPbjsJAGcpjTuULoRii7sLs+BJCEo5Co9Vjb1sSp2g4bbdZVYRhvfBAxFyva/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGi+bB7abXN6Wd1nkFew8rets1uNLrQW0404HF6DJB/8sW3NSzmNPYocgAlj5N3iy8aNyGoq2FwD1i16/Mk98Nr8iSo/brG4QrHLjJGCq3sQx0vEfsccuQiGXooP54hZlFh87PzozSDgSNxNSTG/MbcA5HMdpFJwZaR+wm2B4LRso2f5eBdm0M1X4WCro0QC3yW9rcb7rhbo2k59//XrLxu8jcvjMqsU1WNk7/CH0gNOb21rEZQuVfbtJ6TwOJMOaNSCwT1sHBexPj90fH/WHadXKKV9zW6FJlj2d6TtFmGquhoRic6ck11h7tTn+IdqlHvDlla5ChEyJ17Sfoughg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=h8AzLWDmOj8KTftvlNvWLXvDLiNKzZ4oiYB+wpJONsA=;
 b=PhQEPWYFcJy6MTwe1D4PsGY0nZXmyy5bjOpFXxtt3XS43bRjwezk1lGmjgeaa7MH258nI+P9yOcgWdyUg4eYqwKZUckXUGLCP/0sm2CIs3wWihpFGo58Mfbx6oS4EEzpyyfVTEiOpnybQptmHWF4mXI9ez/P+1BD5Nu8b37IWL+0QPLHFdUNhOQviNC+16JwrBrxEM7AEExtooVCPzEVy0y77GA2M8LrgdnhMubdQEfiuPLaSQpEXYlf4AktSLcU2sd/xZYt+DaepGEd1vf8bkOep5bXW4LMJDyWNNLGeJK7J/rz5r6sWYsr6W1qhIw4Ap9qkMohvmOvOF+ItKUBtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB6303.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:28a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 27 May
 2026 15:05:21 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 15:05:21 +0000
Date: Wed, 27 May 2026 11:05:17 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tsbogend@alpha.franken.de, paul@paul-moore.com, jmorris@namei.org, 
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
Message-ID: <bgjagepcfb7gz6jawatu6kpfmecw46gwg5cvb6r7dl3dn7bt4l@rtymdaslx7ef>
References: <20260526142838.774711-1-atomlin@atomlin.com>
 <20260527085221.GQ3126523@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wx5nuid6cri5pbzd"
Content-Disposition: inline
In-Reply-To: <20260527085221.GQ3126523@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MN2PR01CA0060.prod.exchangelabs.com (2603:10b6:208:23f::29)
 To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e52063b-d14e-4a2c-0860-08debc015f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|4143699003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6QDHvmBQiQdTYziyfhNyw3VhN41o+czne3s5IJmed6Vw/+w8DghUX95bQeXcvGKldidijpsnsnmUpVbiIBs1q09l3ugYbJnPUihOwX6jdFi0A6SwPB4CtRrO4HPWc4Q8ZUlmEJtUfOVT3NijQTGJdYjpJZBVBm8FicJLcx2Xdtf57JsmDmcvKYsTuHvU+coYNkp5aIG9Q41n6PXg4ueG5dGB2d9CPORXecMR1s5UrfKCUoxI/JAqEPFHJkojnevUPmItJXKMvONY1GlazoYYCKaoCny4z7LSQu/dLyZBVqViYEBU12J+j4EABtj6wm8egiPwJ8TerpbRoyaEeMJ5xTKFQOSeNN86mOASF1Fj0uBmNWymHFFWGvnPL8Ksk1gBNSdELYWAS+iARa6/MwGqWw9f6E9r7mLptWtkRNbS3vyDyswe9ecBo8K0vs3SzZJh/7lCJUEwbRyb6XZEWI7wDBff7YTgkCqHuBCs1mcCnupIZabnDp3JIUq2oHi79qPbs04nyJjoIYy2Oj5Vv+8XaUuBrdep9NzVmCgERGrY2x523lK8/CDvqSpKSmbNcO9PV271AphJjxs7P5vkAxaUbprqJs+kE00dKH40czfH/jg3qjO8y2rhBpQoZkPPO5U6jw6dXkSfcwhpBhFaRKoamxkNWJjq2Mm8CgvzNuQ62KihQ4mjFy3w4R0mtNZ4p9yG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnZjSWRXQ0ZnSG94bk9TZythejhFTlp2RjZMSGR5R29FTlRuaXBjTHBuRzhX?=
 =?utf-8?B?OE81a3l0VjFlTWhuZ3RmNmJ0MDdFR0hGcnFOOFZHUnJ4S3pKRUwxc3BhcWJN?=
 =?utf-8?B?Zk9PblRSeDQ5WFMyNUhTalY0WFdaa0IrQjdidzVLNmRQUmhqQUt4VHJTcUtl?=
 =?utf-8?B?TmZ2d1BHd3lDNnhuNGNmb0dDcGdNMUVrR1dMYWF5WmJxcHRVZTdrZ0lMbXJZ?=
 =?utf-8?B?ZkxpZ1NhS0RWVGtVQS8yd2MvMnRKQ1lodDlpUmRwdWZwUkVsRzFkcTVBQk9D?=
 =?utf-8?B?bUM5S0pWRndNdktmVHp6UjhzTURnWTg1UkdGWkluRTM0MHVlZU9FSXVVV2NG?=
 =?utf-8?B?RzMxZVAvU0dDTFByVGlWbHFDdWJ1UjNyQWdLVHhhYlJSUDR6Rk9ScU11T2di?=
 =?utf-8?B?bXE3TEcrcFVXUlJ1SlNUTTFwUWJQSzl5UkxzVDZFM1RQZjZCN2t3djNjZXRk?=
 =?utf-8?B?bS9HY3kwUkwvd1V2eURDaE1zZk9heG5tckF5aXF4bktGV0U5dU0yc3VXUSs1?=
 =?utf-8?B?aVFyVXNhNmsyTStCbXB0cit3bktZc0lBMXhyMVB3RkcrM3FTU2s5aHBHT0JW?=
 =?utf-8?B?WDdXYTZEbnAvaFlGc0hjMjVGUXF1dEt3U1RlTDR2a0VhVk9jK0dFdGM0S2hq?=
 =?utf-8?B?UDVoRHpJeWMrb3p3MUhEL3J6WVV0RVRpRTlxNjA3QzVXd21xcllLMHZqZith?=
 =?utf-8?B?akxTZ3VTamlJOC8xSkJmSGxuMzdIai9jOEFzdStKeER1c3RkZzRJczNoblNh?=
 =?utf-8?B?eVFRRndRWjEvUVdSa2tRakUwMDNnTS9veGtYRFpmMFcydVBuRmF0NXBMNERi?=
 =?utf-8?B?MXBGWGthVHEzV0hDWXBaTWltSzF0WUNsM01qaHJDOGRDNUxLOGU3dXRrL0ZQ?=
 =?utf-8?B?ZWRFMWoyTVJnblhTU2hGaEFabUxKS1JCeTE4eEtvYkx4Q2Nkak80eDZnY3dC?=
 =?utf-8?B?UWk3MVU1cDdnN3RXZ3dkVXdkUVRwYmdoZzIrczJUNVVNaGI3UkR3SlV3WlRH?=
 =?utf-8?B?WW0xOXNKeGFIWU9PWWJWc0ZOWkIxUzc3YndpMnptT05lejdTUWcxSndQM0RG?=
 =?utf-8?B?bCtqaitLME15SWNMRXVkTlVLZ3o4MmZZY1lCYmsrWEF1ZnZJZzF5WVFSNW9r?=
 =?utf-8?B?SXBCY2JmNkVySFNkclJ6RXM5aDJ5U1lVMzdkenRYRUV4Z3N0TFREREFkdkk3?=
 =?utf-8?B?bGFxcFhBczlKU3pXRUtNMVVNUkNwNTRlSC9XQkk5S2VEcS92eXdpd1VlV3p2?=
 =?utf-8?B?NFRaRlg0cUFmVUYySjcyQWpuZHhYa1lXWmpzRnpNRnQ1OEZzZGFzclpZU1Bn?=
 =?utf-8?B?OHlLeEN6R2xCZHpmd1I4aE5uSGRINExucTRPYTN6R1RMOUFhNnA5M3lDRE0y?=
 =?utf-8?B?NHM1aXRRN1lNUWJJUFAwdm1Rd0ovQy9xZTJEQm1IRmR2ZDdUckxzUit0RHhZ?=
 =?utf-8?B?eFlhdnZiNjMzMGVRMmMvVDMvc0kxbW5CUFJwR0dMdk9ranRmQU1tVXFNY092?=
 =?utf-8?B?eklVNmwyb3R1YThJU2YvZ2ZxUW04RkVidGFwb0o2QUNycFFPN21mUk1kVTU4?=
 =?utf-8?B?VWdzdHVib2sxNWN5aDlMOWhISnh4SGhsYkVScGZPSjltTXRuem42dEJuZENK?=
 =?utf-8?B?Wis2M3A2UFB6UC9CY0puQzZGR1V4SjJBZWNKMkV1ZkxBT2Mrck1vMnE3VXl6?=
 =?utf-8?B?Z2hrd2ptR1dtcXBmWUkyNk1ESnhXSW5ORHRpb2xVbFBnOVAydFYydmNMMGtr?=
 =?utf-8?B?YnhsYnh5cFBObEZ0S3F0SE5VVUNKT1BFcUhTdldpSWdQQnB0S1Q1dVZ6ZkZS?=
 =?utf-8?B?WEFKNTFPUFoxbldsNXp2VTRrRXRTZExxSjI0UEVRa2dNaUNNYWYwWGhtNUlU?=
 =?utf-8?B?TDRXRVhxRmlURllrMS9nbjJncWVscE85TVVrazMvNWE1RzAyNzJyWWdSRFNU?=
 =?utf-8?B?dmNCY2xBbFdlUmo0cm5GQ1UwaWRxZ1JoUDdzZFZTZHFEKyt6WTRqcWxpOEQv?=
 =?utf-8?B?Mjd3bFFGNDJzL0p0NmxVTzVjeitZWnRHUXFVbFRURkFtNTFzc1Q3OEJySXl4?=
 =?utf-8?B?ZFNwV0tINjdmcldLYjNNUXp0cUIyKzlteWd0Z2pGWUdXMitEWEhxTlVJb0NL?=
 =?utf-8?B?VXkvNkZtNERvN0V2NVd1YS9oVWtUamJ0S1l3S25mNEs1TWZiMkxiMWkyVTF0?=
 =?utf-8?B?MDU1YlVZTi9TZEN1YTQzWG1JQUYxd2Erc1Z4REM0ZXpEUTZwSmFpWGd5aUMy?=
 =?utf-8?B?Lys3WjYrUVk5Q0swcXo1aVN6b2xoc3U1OE1wRGVKTnJCbTRLazk5VVBoZkw4?=
 =?utf-8?B?WDNrNGF1OTV0cG1pcklLeG94cGU4emNqZ2MzNnlhR29obUZaTkQxUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e52063b-d14e-4a2c-0860-08debc015f3b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 15:05:21.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyMSaAlA9Mvxeql5KEzmNprc7/CPaDw8tbC7PR8Ib/YF1nkcEgqQkI9CUY+fYtcCWYyPcEixINQ0vZd8qSv41w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6303
X-Spamd-Result: default: False [0.44 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16350-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com,huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,amd.com,ashe.io,abita.co,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 76DE35E6B25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--wx5nuid6cri5pbzd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
MIME-Version: 1.0

On Wed, May 27, 2026 at 10:52:21AM +0200, Peter Zijlstra wrote:
> I'm not sure I really buy the Real-Time argument here; that really feels
> like a straw man. Real-Time will need to account for the shared resource
> usage inherent in using a single kernel image across the CPUs, affinity
> alone does not Real-Time make in any way shape or form.
>=20
> And the compromised task vs crypto thing feels like it wants sandboxing,
> but wasn't that what seccomp is for, rather than lsm?
>=20
> So while I don't think I object very much to the patch, I do find the
> whole Changelog to be utterly questionable. Which makes me very
> suspicious as to wtf this is actually for.

Hi Peter,

Thank you for the blunt and honest feedback.

You are completely right to call out the changelog. It obscured the actual
practical use case. I will rewrite the commit message to drop those
statements.

To answer your question regarding seccomp: seccomp-bpf is strictly limited
to inspecting syscall arguments by value at the syscall entry boundary. For
sched_setaffinity(), the mask is passed as a "__user" pointer. Seccomp
cannot safely dereference this pointer to inspect the requested CPU bits.
To actually evaluate which CPUs a task is trying to pin to, we must
evaluate the mask after copy_from_user() has safely brought it into kernel
memory. The LSM hook is currently the only infrastructure positioned to do
this safely for eBPF-driven security policies.

The actual use case here is multi-tenant workload isolation and visibility.
Passing the evaluated cpumask to the BPF LSM allows operators to write a
simple eBPF program to detect spatial boundary overlaps (e.g., logging an
event if a requested mask intersects with platform-reserved cores).

If this justification makes more sense, I will focus strictly on the
seccomp pointer limitations and multi-tenant workload isolation.

Kind regards,
--=20
Aaron Tomlin

--wx5nuid6cri5pbzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmoXCCgACgkQ4t6WWBnM
d9Y4MhAAornb7ubJ8KDR3tNH2l1S6EU7tVaxicXH2UVND6BNnfc5ergnVZK3XxiD
39/wnFqJdQ6RvSg7FSb075RPeVJ0uq9BTJrwqWU/bwa8mvdNNle3wbu5bldHw0NF
L4rmiYJmqgpJAtG5fhcVb1ScvtgUBOVwRtkewEy1XeVtew4JnVAKmV27gwUPZT4R
1FLoE1syKRgYc4pE9nPfYS+gl1OqRwdUTIDiKeOR4wNYhJ8orKPMZH6DIVSRVvx6
/YHSry1CfOcotUE3nracgybjH+AG354I5qBv28b5jEPpNDG3Db/wb0WyfzVxu20X
ngScXLn6/NP+l2sVgGGgWDCEbSvtSCOPUz7tq97iRZLzzbgDUDVLBJ4ovwaRYdZE
zCmQudnNfaKkrh3PgnyB9kIekF4403TUnkBkEuMveQstZawjjPsMnVN6nsY6iuyD
aDqYJShCM0t923piAW60x2lSCN/vCyI5AM4aDyEcwns3lu4rr/fgvQkeODvsSHME
AdW7hUt5CfFhS3LowDBELEDTYctz7zdVDkKd7y5tLfD98ZPhkt8Z1PAQ4p/QWVmO
Yn0uzwQXD20djvkuGKQyui9QHoij/wnDVdQwMtt+kQFg9ZTvtW2D7pkDWgwhn5R+
zCTGPUGznVEd962exI3t4sYOytem9hGWPEOKzkDdPVq75qyS8fg=
=vQEN
-----END PGP SIGNATURE-----

--wx5nuid6cri5pbzd--

