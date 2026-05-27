Return-Path: <cgroups+bounces-16359-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBeEGBstF2rd7wcAu9opvQ
	(envelope-from <cgroups+bounces-16359-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 19:42:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4935E8685
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 19:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60A5F302CD8A
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 17:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01D94508E9;
	Wed, 27 May 2026 17:42:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020113.outbound.protection.outlook.com [52.101.196.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFDC271464;
	Wed, 27 May 2026 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903741; cv=fail; b=ByAXLO2aeEh28x5gbnsAVs3iW72j/FWKeFLMe0lIYNzPyX5Gbo+FcQKQRXfai1ZGW/PpIxh0p1xn05KpofKEFlpgwkWcJMhe1xACCuvH/OLiIshkyttlBacAfw3i5YmTheMk4/mu36PI1SJmYLIblSRqU1xY8uDhhNxGoqnSYKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903741; c=relaxed/simple;
	bh=51KEw5JIIpVSfO5JRdr69EJzCHa5boQogQyJVUpZlgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oGQ3byWAlUCPbyKzwqI9rdxzdUyBEb6Qh+bfWv3Y7jFBcxMUqgmEgTyYLhwQWc28apMeb6bNcCqxrNeYdwhdh/z9Tn4upGiB1tDGvSFyrqCk2ViHrNO6jQ6tdiR9A5vVBcd/xEbqCs9vfPYxbPlTtXMIIrI/q+TqpngsTnkFD50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXT5dZNfmru2NbynLnjA6WgKLxlH9BMQByVbuWnKSqC8L/hZO997Vv15w53FO0y754tpoUuT0jqeVrx/CIm6KfelxLWC4u7NIDBh+vG4qBbCDxEiuaYKqCAgwBsPVEe7tvItrC/jHCvXrJgK+aRZwBqs0m77J7gVY69u+szE3PQ7aGIhzjMEcUWIpcWyt1dszvL4JuYkPq8eluIaUvWcbEqpMafSHunCzOjlav/ETUKOsMXzuhYbqrj7yO9Cni5qH/mnGay58HXMtDfo3mMwgi9k2oUJfhQlYie5KpRz984xph3pld8M4JpJetP6fejj9ld3RnJAe1tuDBnRt5tOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=51KEw5JIIpVSfO5JRdr69EJzCHa5boQogQyJVUpZlgE=;
 b=MrCXcsSSTOQGjncwBEqWK4F6Ezw2zfoZhsB30vLieyAstTiKvVveX/JSxlsWc+3ucVn8jERoo75ZkQmVIXKzgGsfmo9yD98HnQ6XAefWuZqr8UKl73E+YgC2XfZ5JPBzC/ISIaQOocpOEj8gwZNm1POkYlGcpaHOXxlW5e9DwzGp2RgM7X9t5zaGg6YaK6PhwXb4LatuI0eSfPPENjegK56IGa/UIwzBnNMSVTeEjQeac/SOvuMvHeordwPb6wijLq38R/9/SzlozFY6WrBD52L3eo/ihZIVvnH7EYg+79CmP4NB9/csNB3r74NXJggbEsg+RN4iTXnrTAEpCAwlcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2b2::11)
 by LO8P123MB7758.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 17:42:15 +0000
Received: from LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 ([fe80::3975:c5e7:bc1a:f383]) by LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 ([fe80::3975:c5e7:bc1a:f383%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 17:42:15 +0000
Date: Wed, 27 May 2026 13:41:52 -0400
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
Message-ID: <ov33cu2wosubbfufcmfyoinfatecskjgmkvqyit33komlcla2d@2qgj45724bql>
References: <20260526142838.774711-1-atomlin@atomlin.com>
 <20260527085221.GQ3126523@noisy.programming.kicks-ass.net>
 <bgjagepcfb7gz6jawatu6kpfmecw46gwg5cvb6r7dl3dn7bt4l@rtymdaslx7ef>
 <20260527155404.GV3126523@noisy.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ez7qyus47kipbfhs"
Content-Disposition: inline
In-Reply-To: <20260527155404.GV3126523@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: BN0PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:408:141::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO6P123MB6616:EE_|LO8P123MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 47fa8bb1-f61e-4095-baf5-08debc17411a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|4143699003|5023799004|56012099006|6133799003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	fD9HcbxGd8o7qN8mejBXwW5s31x+ObUwWxy/rSbLloVYmgz9426VV8duSnxnonUZQhacohFQ7RmerUXmVcM3ZvMcRUE5S8f8a5HfIxy8dl2TYxLwE3lOC6cZP/EcDCW9z6EoVTYMN4ghUJddkQIv2YlV+zePjDpes4dqEa33lZB/VfsOMaBJPAPRodAsXOZMfU/AnsYLj+QfO1JkV8pNg5vldVe3UuvoXLY9oOWbaOK9/ZndEeRlhWDv0PwTPRuLulziFs/SgyVU0qc348BDqaUTQp+Gc8jurVzxUrT1mFHGkme1mqOOB4q0DifL3hWIdcFp+VxXIxUN8+Pmn4jsTdqQB998gBrwN/Y2VdpeUmqyFYQ5Kce0AJoZh2VHa480p0xapVAecn2ifAcU5Y5ReE6lvpTmZI/iQx74TlGdNBZleg/ZioatHC6QeCnkmyAlPBxW96smKwhJ7vmxGVIcXgqnwR+tE7ud6ViN0fJzBTGkwTWhzXw4rTwqV2t8KI4cLCFTx1AA0PdS3cbuA2qhSSlPtikPiEK6KlzieSoLzFI12IAaJiNWMqNKxNd/U/R07chv7D5ihfLE/aPqI0/NW7j/FLHlx6o1tnnJ373QkrtckRW6TsfWWuFXUel1a4A66gcotq4iZJoi+qGT6wM0wZ9VY7BPAFWK4Dq6GRo7QThXAfm5hYUIx98zbKApV+Ju
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(4143699003)(5023799004)(56012099006)(6133799003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHBkOE5nVjNnK0t0K2xtdVJUTkF2UENVR2xHWnRCZ0dNMm8vSjRRY0pVSk1X?=
 =?utf-8?B?YjdjNng3VHdoWVdsNmFPbzVyTnVoTms0blRNaFFsODNCbEpqdHYwQTVkdlJv?=
 =?utf-8?B?Y1hOd0hiMmpFcVp3MmxUVVNiNGxIdDVrbGd2NkxjL0kxZTUvcWdtVGhhUTJR?=
 =?utf-8?B?T2VjZjkzRnd5bkcvb1BRaGY5QlYxaXhGbUExVm1remV6MmdBbDRVR0ovTFU5?=
 =?utf-8?B?U0NQdEkwMVFkOUgzNnlyYXZZS29peGtpTEdkbk95d0Q3QSs1eHQ2d0JBUTBU?=
 =?utf-8?B?ZXZRaTA2SnQ4WlYyWWFtNGQ3cjZGVXp2NkhENE5EQXBoNExzQlFZMHZCbWk5?=
 =?utf-8?B?ZGFrUWR6ZU9oZjhaU3pZUGRZL2prMEFXS2NqMjdaS3RYZDMxUVBxK1RFWVov?=
 =?utf-8?B?c1BnVEtHTU1PcngyMzBFcUw1cGtLcjJFcjJsVUZTSkplRWZ3eVJ0MnZ5YnRG?=
 =?utf-8?B?WllxYi9kU3NsWGlRcS80TEZWYThsRHFtaWwxczlEMGhjNkV1TVFzalYxanRU?=
 =?utf-8?B?ZjIzU0o5M1BqNFF0N01HOVVIRTh5ZTJ2dkhlWHZJOUhQZnQvS0VRbjFueXg0?=
 =?utf-8?B?a1I3MDZJVHdhc0JwT25ZWk5zeWNpN3puNWdEbVpnS2pwemo4dG9YUURYaloz?=
 =?utf-8?B?ZktadjlrNlR5QlR5TmpKR1A0cE9SZkRhYW9lR0VQWGMyZ21YSkpHU29OUVRL?=
 =?utf-8?B?UEZmb01mUDNJeitTdVZGZ2tqWWU2SnhQcTFaQVUxcW9OUklmbWw4UlhHcDlv?=
 =?utf-8?B?eTNzdFdpNm9lTFl2bzJoWjdnS1NjajBtNDJhU05FZTdxeGRtcndHcEhZT2ZP?=
 =?utf-8?B?aXJWdXdURzd1azVETmoxQVdTdVJXYjJmZ0tjN1c2QXlGVU5VbHdqNjNqVHJw?=
 =?utf-8?B?N1hTci95T1hXaXdmazJUMlk1WEtLajBkOUYyV2NKU3ltYnNCSm1hSW5wdmhL?=
 =?utf-8?B?amVQOUxkWDlEUHVjc25vQk42VlJMOXRTWERwTVdrVDREbW92NEpUQm5yeUFv?=
 =?utf-8?B?YnJYWFMvM1lhTHVtNnQxcjIzOG9mS09TOVRTV0liTXFmY2NaUG96cld5a1ky?=
 =?utf-8?B?UFAyRnU3NlFsZE9tb3I0WlVBVGVKdlFHWHVUeFR5OEZaRDdwNG5iZzVGSVdp?=
 =?utf-8?B?TjljaGhvcFFjdHF6VGR3Mk52UWNjL1ZhWmxUNGE1ZVB6NWhpWVFmMm55RmZF?=
 =?utf-8?B?UnIrRDJqZnN2NnJxTjN0N3M3TmtQbFpneGpvS2N4dXBoTXNHOHV1TkRYRmor?=
 =?utf-8?B?dU1UQXdJWjA0VHE1YjZTUGNvK0FIazJGN3k5QzZBS1NIRkxCZG9UVmxWcnN4?=
 =?utf-8?B?aTFVS0hkektqV1NyZVd3czJiTi9RMlZnUHZnOTJ6NVBzbjg4YjlBTUVNL0hr?=
 =?utf-8?B?Y00zSUlNZzBZMHZ3RXpjSTR6RlVlNkJjRFRwTmtaTGNVQXhRNGg2WHFBMjBT?=
 =?utf-8?B?SFhOQS9KUW5wQ1VNSnFrTGJocldVaVpSMWduNHh3UVVEUGtac1ZmN1pXb1Ay?=
 =?utf-8?B?RHhCeitueFB4L1FDYUZVOWNvMWNRT05ZMEtwSDRuMDdiaWd2WGlENUJ4UDN6?=
 =?utf-8?B?WDN0Q2ZiUXlYV2lXOVdsSUFLNkUvaGRoelNHUGwwbHNxL2poOHFNMWo1T3p5?=
 =?utf-8?B?YVEyNWdwZUE3N2J0dWN5cWZzeSs4eFlJSzVlYWNnK1A4V3RKdUxBcHI4bkRM?=
 =?utf-8?B?c2NxeUpvZlZoS3JnZlFwaWVPS1VsTGt2em43TTNLQVlTc0g4ME9Ga1BmSGdD?=
 =?utf-8?B?bTd5WG53VjFJa1JVZlZDRDRDbGZRcVVraVh0NVRrbGI4eHYvVVdlSUl4TDJE?=
 =?utf-8?B?RTM0azFGSzExdk01empNV3lmaUY1Ky9UL1RSMU5xSGtmTHY3WlhTSzllUUdQ?=
 =?utf-8?B?ZURuemJPengwdU03LzIyWkFzM01Ba2p2RmdYVGhmTzB1aFRwQ29NRTgyR1Rl?=
 =?utf-8?B?NGt3TkppNElXbFAxN0FZR09EdTU4eUxYOGUzVWF4UGxJMTYyQnRzSStncEZ3?=
 =?utf-8?B?L1pNbTZJUTRhSzIyVzI5blQrbnpxd1VSRVFqV0drQXBmbkNCTEtUNXdGTHky?=
 =?utf-8?B?czZaNmJZT3ljQnRuc3JNNkJNNWJTZHBaMHRmS3hhUXAvY1l6ZHdTb3B6K2RH?=
 =?utf-8?B?eFU1dXgvenpOZGJBT1J1Q0pneWk2T3NTWFVibSs3RUd0R0hWVmNCTkl0VFBR?=
 =?utf-8?B?d1NlM2crdnVCd2UveTlVZDFjckpIeksxZ1QrMHdJU05Uajc1eHRpS24xRzZZ?=
 =?utf-8?B?RUhHYWlEY1cxRTIvN2E3U3FrbkluTmdaS2lRWlZwRmpPUmtxcWJqVGgwd3ZH?=
 =?utf-8?B?aWUzOFZpeWUvblJqMnR5dzF4WHdjWDZMdDg5cFozNFVSaitVdlVtQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47fa8bb1-f61e-4095-baf5-08debc17411a
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 17:42:15.1754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ph9FMByP1QvwkDKgk1QqJuKAiIUWJGgUsGUIz+IOkoItThowB0kLcRRRQC1krKRsXYlHaqkpUrh6JkQWb/dJcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB7758
X-Spamd-Result: default: False [0.44 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16359-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4A4935E8685
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--ez7qyus47kipbfhs
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
MIME-Version: 1.0

On Wed, May 27, 2026 at 05:54:04PM +0200, Peter Zijlstra wrote:
> > The LSM hook is currently the only infrastructure positioned to do
> > this safely for eBPF-driven security policies.
>=20
> But is that correct use of LSM? Or is that working around short comings
> elsewhere?

Hi Peter,

I am in complete agreement that we should avoid indiscriminately grafting
hooks onto the kernel simply to accommodate BPF. Nevertheless, I would
argue that this represents a textbook application of LSM.

> I realize that bpf people rarely care about things like this, they just
> want to hack their thing and will take any hook they can get. But I feel
> people *should* care.
>=20
> > The actual use case here is multi-tenant workload isolation and visibil=
ity.
> > Passing the evaluated cpumask to the BPF LSM allows operators to write a
> > simple eBPF program to detect spatial boundary overlaps (e.g., logging =
an
> > event if a requested mask intersects with platform-reserved cores).
> >=20
> > If this justification makes more sense, I will focus strictly on the
> > seccomp pointer limitations and multi-tenant workload isolation.
>=20
> I suppose it does, my only remaining question is if that is indeed
> proper use of LSM -- I really don't know much about that.
>=20

We are not creating a bespoke BPF hook here; rather, we are rectifying a
historical blind spot within the API. The existing LSM hook is invoked
during sched_setaffinity(), yet it presently receives only the task_struct
pointer. Consequently, the security module is essentially asked, "Should
Process A be permitted to alter Process B's affinity?" without being
informed of the proposed affinity itself. Providing in_mask simply
furnishes the existing hook with the requisite payload to make an informed
decision.

Were the objective solely one of observability, a tracepoint would indeed
be the most suitable mechanism. However, if the aim within multi-tenant
environments is active enforcement (namely, safely returning -EPERM to deny
the pinning request before the scheduler applies it), the LSM layer remains
the standard, architecturally supported gateway for returning syscall
errors in accordance with administrative policy.

I shall defer to Paul Moore and the LSM maintainers for their final
blessing on the LSM API semantics.

Thank you once again for the thorough review and for keeping the
architectural boundaries honest.


Kind regards,
--=20
Aaron Tomlin

--ez7qyus47kipbfhs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmoXLNsACgkQ4t6WWBnM
d9bMFA/+LafSwwUtJWzhoOqq39YL0SkkvF754SG0T8pzLrNuaeXENJ+cXH9paD52
9XYCQXQ6HjZjq9YgwfMiNyvEbEVO9IRW1q5tO7U7oJ9H/RKGK8Bj5HzZeBjWXHYl
GStoOaeBoKc7BYZzhNXQaGc99eIrz7gOPRze1fVpSMSn/me1/t9SvWAre2C3qTb6
alGg94VQYyPACPntMGonZTHlcSMBNVC3aYEuGiCYCv6NXmnKkrlOFDyZXm0IwPlp
7Pi8t7xNcDphBtiME5jUTod9Vr5BGBp7l3vB3M0Rt+yubrbLbjv3QdmSEmtdZreg
MgGHhwmV2xJ0Ue4kGDAkcTXTugShgmLUEtyvJoJsx9FnbMQQIQ9qgWi1ENjN1FMP
GFzaWsdQg20zwpWqBqRZNTSMRA27pX/GRlR0Va0KD5Uvnvu1M6WVYMS7uLEzec8G
ggUtQLHd08j65IZXEQpS/HwN13NszEIjkG8hWMkLonE4cCxe9BcGBs5rplT7zHBU
fNPDq3IRqKhwDEXq45XdVQVcWVg5g+HB9iehwU2FpbLzwJtHpyTe9bKhTjlWjnTM
O3scEz9gUXBHqiN5Z3wm0c1tpKPLCOQiBYswxJ4ge3PLe5yHDRoD/WYVyOOu0uNK
Ath3+2ImjfYo7b/Z7mYN2fZx0bGCcNANse4BBDLKNlhZBsC+eFk=
=8gKr
-----END PGP SIGNATURE-----

--ez7qyus47kipbfhs--

