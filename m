Return-Path: <cgroups+bounces-16379-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yihvNR6YF2qiKggAu9opvQ
	(envelope-from <cgroups+bounces-16379-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 03:19:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2215EB865
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 03:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5810B30258AD
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 01:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6574199EAD;
	Thu, 28 May 2026 01:19:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020140.outbound.protection.outlook.com [52.101.195.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B45191;
	Thu, 28 May 2026 01:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779931162; cv=fail; b=Fq2UqqsREoSA6hVF4oCcJrJ3T9bCESZdrhhaZB3VbyNVNhQT7ShtV2r0Ox0rUwLsMqfeDfiZnygPJElS5yhz1bWspqB8W8YNr2YgSv1RlorqOTDl0eZCoiaDOnJn05cNOpu9IjT/SPqTDUJ5ztCqvmy6FDV2rXB719BpmTigl2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779931162; c=relaxed/simple;
	bh=ekcAlTHlrP+u+ylOfb4hCE57kyvpdf6hz/Wt9AThXeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KP4IVeOkcpIFKsJrAw8W+a4s1dK0z4Z+PSW/HAHCeeqVW7qhVdigYXHZne27mE6kvzcMtbFsNXKv1mf/Hmp1TIBtl+Gp29OnxBUKWamMj0im6wL1PpE7C9KZU6V+PQA9woCoRhulCnvVePiwJhG70K3mnKG641H11BvIL3uuqB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBrnoDarmLOlK02kBEa7OCw0jW2mPNSVAGSZ9Nu6ePfaOQ9H+aA7k0XxWuBpyQ/Ir2Davxpj+EF2C/8YdXPauJ2asbbB40H8BDH8/z0GgZb5634rLCGM39LPaTJriahurA+L2avX3a1otMFlyOT5MHJ7ffD/E0qgyf0Mcoc/0C89HtNngUuZDT41CIe/VZu1Jmll7k87xsyirlXtaDPSs02nFtICv/Mqms+tq+nQGWSAl4/Z79HkjN+29Jsaolgb4mrT18NeeQExhisru+hZeLDV9HhP4m9FAdduXTsVSueVIH6LrBNYbNLL1czzU4y1pRBv4YXvObpsGlP03srJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ekcAlTHlrP+u+ylOfb4hCE57kyvpdf6hz/Wt9AThXeA=;
 b=dwhy7f2n/24wySFMU5EdjDGV3oNpfAgwNciqUv9V6UCgs5vV8tjDN1f+KGCE0HXIFqpyJpmAjXYDx7KmymcNae4RaR4Jkb1JcIvBTM9XFDQt284DVfo2LZgZxnZk3XLbJveFVuNdo2sAl7X3FfgTYFdpBRPHjPzu8picYkarMdxX41PaNJpgpbWO/3l/3fZcz+nRVzrwOPu0mPictdimip/qadGYCWn13474zuz/ny72B4uwotCrHhulVMuL5CzRf4JDCrp2k7KHQreSyeJJ6LgMS6ArlD8J32PiX8/TOFcp9wmhuTLfEBZxl1CNZQsImN8d4gEIx4d5bLh6wxC4JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWLP123MB6178.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 01:19:11 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 01:19:10 +0000
Date: Wed, 27 May 2026 21:19:06 -0400
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
Message-ID: <6hqq5oxvlcpmjvyns42dy2vtfvvixy7q4xyyjrrn46jrvsx5ar@gkmjsteqlpzd>
References: <20260526142838.774711-1-atomlin@atomlin.com>
 <20260527085221.GQ3126523@noisy.programming.kicks-ass.net>
 <bgjagepcfb7gz6jawatu6kpfmecw46gwg5cvb6r7dl3dn7bt4l@rtymdaslx7ef>
 <20260527155404.GV3126523@noisy.programming.kicks-ass.net>
 <ov33cu2wosubbfufcmfyoinfatecskjgmkvqyit33komlcla2d@2qgj45724bql>
 <20260527195858.GC3493090@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kszlm3lx6cl6sn4w"
Content-Disposition: inline
In-Reply-To: <20260527195858.GC3493090@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: BN0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:408:e7::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWLP123MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: fc399a0c-eba2-4750-2970-08debc571f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|6133799003|22082099003|18002099003|56012099006|4143699003|5023799004|3023799007;
X-Microsoft-Antispam-Message-Info:
	uRVEXOkZ30QIHQNWJEGhMF339rRI4DnylgNMmG2Cob1xGS7jOohRARLWXf9Xnk95nzDDeU156XOb4O//sLZ9bZRO5FmhJ4YbZfnhiUtnyGtcPdVkTzrXf1Enm8dsIpZNsUpaPox7TTHSf8UBDpknPEx6nd515OOrB5Q/e/c4oSsU2ayxIEEfXlawzI7xxAYIyySg47gje/aLneQZcSP3+7tAzBpdKGu1AUQpHjQVoTnvF4XxCq4JBfqumfhp8t+qk98Mi3H++xFkhn031HFqxQDTrFjLV0EUXCEbTaA25U8SeLP1cNLTd5YwabbhXT6OXTuzWwXYnIG7D90+rMD2flGPX94dMf39Vi6F3GOV8Tnpb5BYOZAX0ntJSElsSxHpahZWyl8OQdTl1LArLIipVz9+/5mRhCxxrRfAXvU2hEOj+9tgGM89Y6tLg8peT2xJ00vrthXXtOBYFsiQAJcSsC+PJfT7f84hKV1x3dTv/Q1VS//ZWY2+6r3FU36QKb6wnFSmRDuMada0soeKgyRGPK/dXZuP7lUID+0tjWUEGmJpXfbd2I7wexaW1ZUm6N2FevPIZWZz4VxvGq8iKZ8Jda/UHHt69LeWfppiHnrW7gtGvqn4eJQsijjDPbXxZog88C0D4/3yROiKuiiX1A9toxlRTZDSB5TIqYB/RBT+k1TLenoEI6+BLlBnWEUapg/K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(5023799004)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sld0d2h6YWF1eFNBWmttL1pOSzJWVFhLOFNwMkFWOGsweHU2Y3BtclhkZHNG?=
 =?utf-8?B?ZEQ4VlNxYTZSUEFMUy8vTnJLTHRGbmVRb0o1aXFaYklFaXVYem1UbWlrYk0v?=
 =?utf-8?B?VnJNUXZXYWVwbm1UTmxzdDZKS2VJMUhBeGVRS2ZENWNMZ3dRY1V5cE5qcVZx?=
 =?utf-8?B?Zzh5TjRnRkpCMG9Qd2lKRVBEN3pmTjVhR1VnQXNIeXlPNExoeVBXWmZ6M1Z0?=
 =?utf-8?B?dURYZzFYVHNlVkUyTy9FNFMvL1hEUEoza29xc1ZYRXBtK1d2QVVocnhNVHZ3?=
 =?utf-8?B?akhCUlJoaVIzZW5kZ1lUd21FbU4rc0Jqb1d3d2NkMk8wSjhjK1ExMmJib24z?=
 =?utf-8?B?U1J3YnZSWFcxZUs1LzI4MEZ0TVl0ZCtrVXJrcHRTM25aTHhyVVJKMTlhakZn?=
 =?utf-8?B?TVovRmRIQjVDQjZmbVk3L3llSFFCZy9jTS85bDBkQThwaGpqZk03aFp6aWM5?=
 =?utf-8?B?RStZMm5pbUNCaW1vdXhhdERtVG8rOEhIc3lWdDFENmZyTkx1OElPb3AzWW9k?=
 =?utf-8?B?NUZCSHdRbXZmUnMybzJ0YkR0WENZVXY2WUZMY1E1QWtFTTZhSVl5amQ5YUdu?=
 =?utf-8?B?YTRLWlN5VUw4WURUL0tHbTVmNldhVmhybEFqblorb213dElzK3MzM0hzZkxX?=
 =?utf-8?B?YjBjWkxjRkZLN0c3QW00aTRJbS8xbW55UE5KWmJDQ1dQZERHbVdiU0ZMUzVD?=
 =?utf-8?B?WjhVSGdnOWRWd2hJaE1wUjBmVm9MU1U0QU4xTTNJVGVVQWltOEpaTnFXQnVo?=
 =?utf-8?B?OWo4elBHNXFHV2cyOUJiSzNPOWMrU1lkaGdLZytnWEtrWXoxTUdMK0M3L3V2?=
 =?utf-8?B?d29oRzlkRURRMUhJMllYdmY0VjZ5QmRWL2tGM2xkWFdJL1huWk5FQmNYRXRk?=
 =?utf-8?B?QjcvQ3lzelIyU2NjWUN5emhkNm9rRStZVHhlbE9vRjUvNHZHajhLQ2xVWmRK?=
 =?utf-8?B?WjQzZ1pJK1JYWmpHNkhEd0E2TE01TnRiNDlUcFpCMXFoVmZJWUQ3YXhuYmhF?=
 =?utf-8?B?dmIvMm5Sak9pWHU1bUVwSldUQ2J4L21YWi83c2hpaEtYMCtqa0RzcmM1UWRT?=
 =?utf-8?B?OFFTelJ6czQ1Z2p6dVVlb1lyaEtOS0R1emNOT2NtdkZlVjBMZUJiOWVDQVBS?=
 =?utf-8?B?aTJaczdVRFJRaEMvYkJNM1ZZSlg5ZkxiVlJ1TkhqV1JkdHlHdUZ6YmlXSVR2?=
 =?utf-8?B?Y2tOMm9LSWRUVWJWS1RrU0JYR3haY1lRbWNnOTNXVklDbzM4bndhcVNkTExP?=
 =?utf-8?B?dmhxcm5OeXhwaDIwWFA3d0lhcTlHSWh5dnZTc0RyN2VCd01Kd1ZvVEVMQ2xo?=
 =?utf-8?B?d3NYbHlkYVl5SmlmRmhTZEtqdkV6WWhWb3J6UTBQdEQvOXRoN21VcDVCOG81?=
 =?utf-8?B?OXN6bTF2OWhONmRud0czU2Q1dWN2bS9oSkZwdVFFcmt2UFF5czVIRThlTC9r?=
 =?utf-8?B?TFl3aEVDQTYzdjFBWHJ1MFlDSXZqWTJhWHRuN2JnZWdIN3NQZ1dJS3FCNW91?=
 =?utf-8?B?M2dzb3V5NWtpS0hQcmpJRDlCc3VmcDdyWFhlTHhsN0pFK0tld3cxbjQyQ3I3?=
 =?utf-8?B?NEJvUXoxR2QwSitXL1lzblFtaGVWTThhcURiallmY293SlV1VGNTR3JHeThv?=
 =?utf-8?B?N1FPS0MxOUl2OFFyK2lzYXF1OTJOclhiUFJKcUZxUUtPVC9NWHFXaGIrQkdv?=
 =?utf-8?B?YU1IWEowYW9kdCs0MWdXYTVwS0hnK2ZDNFNZR1hld2kyMkJwZXZYSEhxcmNQ?=
 =?utf-8?B?WXBzWldBd25hRFVzU2t3VlJoT0xXWk1sQU93aHBxY1Z6R3J1eWV2THhkbXc2?=
 =?utf-8?B?UFhSbVowbjh5dFhtUnIzRTE1WWEzNjZDT2xQRGZvb3ZQQU82eDJldVphNnNv?=
 =?utf-8?B?RFQ3UEtmZklSb25kT2xYbmtOL0RaekVNNkxIZno3T1RsdFNKSVRtczVVUkxY?=
 =?utf-8?B?WDlSYVpXVGo2aHBtV2VBLzVtMnVib3ZMa1NhdmltTWJBUWJYRnZJUlZwVWxT?=
 =?utf-8?B?SFpidGZVNGZFZUdZd1pYYWlMbHk3ekMxSWl5Q0tQN1ppN2JUWWJxbkhUaFBT?=
 =?utf-8?B?ZUt3bVl3emw1d0tpQzBLL0R1UEVFc0VMK292WmFraTFFZDhhcUw1aTAveFpo?=
 =?utf-8?B?Q3dPM0hIcVQvNmdIWUt4ZG9OeUR1TElPVkxQTlExSFdmM3lZazV1enRjOGF3?=
 =?utf-8?B?NGdrUG4xT29sTU9FVklhajJjM3l6Tit5Smk5eEpXSlFobm55SE1uVWJ4aU4r?=
 =?utf-8?B?b09uSGh5RkM2NkhnaHRPZ2F6TER0S2svaDJjMXdCdWQrK0ZwK0o4YWFHaWN3?=
 =?utf-8?B?bllHeGtuenFUVmJrM3BoeVRxc2phRzYwNi9ScVNVSWtxSjNRZ0Y1UT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc399a0c-eba2-4750-2970-08debc571f0f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 01:19:10.6207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LWN3jPZarCCym+5B4TsL3SlnpirQbKqu+jXCIKiD3yr+JyLbrc1CfDe/hoyfN3rNoBuzEH1/mjfDVSFLej0bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6178
X-Spamd-Result: default: False [0.44 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16379-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3F2215EB865
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--kszlm3lx6cl6sn4w
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
MIME-Version: 1.0

On Wed, May 27, 2026 at 09:58:58PM +0200, Peter Zijlstra wrote:
> On Wed, May 27, 2026 at 01:41:52PM -0400, Aaron Tomlin wrote:
>=20
> > > > The actual use case here is multi-tenant workload isolation and vis=
ibility.
> > > > Passing the evaluated cpumask to the BPF LSM allows operators to wr=
ite a
> > > > simple eBPF program to detect spatial boundary overlaps (e.g., logg=
ing an
> > > > event if a requested mask intersects with platform-reserved cores).
>=20
> Why isn't cgroups good enough to enforce this? If you create a cgroup
> hierarchy per tenant, and constrain them using the cpuset controller,
> they should not be able to escape, rendering this event impossible.

Hi Peter,

You raise a very fair point. The cpuset cgroup controller is indeed the
kernel's primary vehicle for spatial enforcement, and under normal
circumstances, it successfully prevents a tenant from escaping their
designated cores.

The cpuset controller does govern resource limits, but does not audit
intent. When __sched_setaffinity() is invoked, the kernel compares the
requested in_mask against the task's allowed cpuset. If there is only a
partial intersection, the kernel silently truncates the requested mask to
fit the cpuset, without raising any alarm.

The BPF LSM hook, conversely, receives the raw, untruncated in_mask,
affording operators the visibility to detect, audit, and even reject these
violations of intent before the kernel silently sanitises the input.

This patch does not seek to replace the cpuset controller, but rather to
complement it by providing auditing capabilities.

> > We are not creating a bespoke BPF hook here; rather, we are rectifying a
> > historical blind spot within the API. The existing LSM hook is invoked
> > during sched_setaffinity(), yet it presently receives only the task_str=
uct
> > pointer. Consequently, the security module is essentially asked, "Should
> > Process A be permitted to alter Process B's affinity?" without being
> > informed of the proposed affinity itself. Providing in_mask simply
> > furnishes the existing hook with the requisite payload to make an infor=
med
> > decision.
>=20
> It occurs to me that this same argument would require to also pass in
> the new sched_attr, no? That way the LSM can inspect the new policy
> before it becomes effective.

I agree, the underlying logic does indeed extend perfectly to sched_attr.

Presently, the LSM is equally oblivious as to whether a process is
requesting a benign transition to SCHED_BATCH, or attempting to escalate
its privileges by requesting a real-time policy such as SCHED_FIFO with
maximum priority. Just as with the CPU mask, providing the sched_attr
payload would rectify this parallel blind spot, allowing BPF policies to
inspect and mediate scheduling attributes before they become effective.

If you are amenable, I should be more than happy to expand the scope of the
forthcoming patch to include this. Alternatively, we could address the
sched_attr expansion in a separate, subsequent patch. Personally, I would
favour the latter approach, but please do let me know your preference.

I very much look forward to hearing Paul's thoughts on whether this aligns
with the broader LSM vision.

Thank you.


Kind regards,
--=20
Aaron Tomlin

--kszlm3lx6cl6sn4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmoXmAoACgkQ4t6WWBnM
d9ZTGA/+I+wiTJFbsU4kq9EMg4TeuzCfcjQ28UFOCrZqIdAGyQc/SMUZjEyD1bSs
TD2LmeQdBROf9rJBJ5viAl8Gtbhbe1S4cuv2QHitAGE6cKA1RbWwwU2sKKedmi/Q
gkT9BPQ+ABz47zzaQsHHqFnpygR2XtCDeTt4BsYWVOMcQXt908ONk6pD+XNpIwvx
/hG84SrTXffIoJFXENGv4rJTFlks7TCYca+1PfBtA33IQugYHHV8ZV3kLKCQaAdL
z0EtPNy7vRxx7MPed8Az5RSqHC22127TFam/9atjUZ40/AcDjwQ+dLCpdwxO4N5m
HOwkd66G8zdXlP2kdMw8lE/1ngTtNl4DBnCYQTwGYT5NizppJJ3q25z7DTWAkf7R
X/yNxQMflP2pDPoOuBO5zHCBG3vs7BregVqskz4BnS8RkJZ7zGAn9PZmj3StizC5
drRi0+Gn1hrSiDGiwsL88rer2lrCA8mnbAP+N7zak0bG1d6BgTAMRnErzeWVXhH3
Dos+Iv3kzwKKKMfLMF9b8F8bM0zYCM9YNzIK4TTDhMf2SncZVDpY8/VNVyt0AS5Z
Fobwo8NLfkWmsGfi6xRgVfPRHFqi+FpyTrCvQqwQoQ7BSIGQYM0Ig1QphRTF8EB5
G5gW8RXBLkT4LSzMWRHp4l2IU4A8gLz450bfZ2vcbunm4hmYGPo=
=KjrL
-----END PGP SIGNATURE-----

--kszlm3lx6cl6sn4w--

