Return-Path: <cgroups+bounces-15920-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLyfB84EBWpRRgIAu9opvQ
	(envelope-from <cgroups+bounces-15920-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 01:10:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B747053BCDC
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 01:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B99E43019D03
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 23:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7234A394493;
	Wed, 13 May 2026 23:10:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022110.outbound.protection.outlook.com [52.101.96.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EA129AB1A;
	Wed, 13 May 2026 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713801; cv=fail; b=BEhjNcUb8AwJsxXL9rFDaGyIUug/nzxMactjOiBJwLouioH8R5AoXaw9GjnJa2PKFWmsfw0cwcHjsGaPIT7900Dtbu7YxrMV5Aviw7QvwqLW890liyvwpOltTk57TTmb21RV1T0dfgxZl8XfkZdVpMuXyJqf7LLpFTXpIVnAWJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713801; c=relaxed/simple;
	bh=mu8psHfHItiLvYjFegnMm6Xb8JRo0QCTfUL57Sud7YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s0maxDOidDurg2FlhtylYmYsbCEiITCCtE7eqq5cqwZcmiZ9lPo5tpmjc7XHPTRtz8ZI1SH5Hkd8+zqtG90o28hMthFgaNBOHHdVfvqgcuDGy1uwgtOUz6+/y51C9bAg2INOr7XHRhIAHfuO2Hr6D6WxDSpHsHTZVUICJR9Ax08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXgtAPQzOwxS07im4GDUsfMsRYf54DqOapHAc5w4M8txYJlC6Q90MlhJzqKAFufg2GocEf9EjY5vrj4shJJ8BTvlqqEPpS7HsuhsmRU5SzA3myLO3gMmIIYj7ZY7dW/rvF8polWE+yzgh+H0bpbRQtybAyv4Wqg8oh5lMEJ5RGuihbv9Rm/bZ/7+fTgeBZThmSZ1n/0P9vC9QhHuShATattkH/ANJQTBQ5gHOIf5lsG+/sQ+9LtI14aCnSPupSRzbd+KPqoHgekYxF16NNDqn7a50pQNM1fGeva7790Qs4J2s38m/ZbFiRNDim0fzQKe2lgFbRmAJc+f3RFOEeUgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dYTM1S6MCTSLxhQFSHifpyPhHBourf4xkxYVVYLmQI=;
 b=cnan/4PrTWupKAcvSyVHELJrlCIgURurKEf5d7+gwmpKHFrdx/QTHQwVM/3Qw4k6kpodMlOxG14kM419htSQrqHi7OunxRB1Fe5JMX6Gbdj0dyLAmTMyPxmbikhAjDFEe/fJ755mkd+Sqm1OqpfUXswWr5BGAzoahQf3H8gozUn6AEXzrfTdLaXQQXRmzLSlilqhd+ZnsvreRqoNeju0pIny2QVszEJ9RoNPfhl3AAHQtZ8ld4BOS1xROWzqjqa5Qt3U/SdO8Y5AOurMmJY1gnt6pYknw/HYsSsQqU32W86NVWb6ytiNBnhNAjANwJSlye6HUEBBVxpTQUCc/VuoSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB2821.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:41::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.34; Wed, 13 May
 2026 23:09:55 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 23:09:55 +0000
Date: Wed, 13 May 2026 19:09:49 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, chenridong@huaweicloud.com, neelx@suse.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset: Fix multi-source deadline task accounting and
 bandwidth bypass
Message-ID: <qk22cpgfqlsxo3b25z25eve2vmsm5hxkzz2dcqbe475ckkjsfj@p563fnekimdc>
References: <20260512010341.101419-1-atomlin@atomlin.com>
 <ddc8040f-2186-4c72-a69e-26b388cb7249@arm.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kq232jr6wzwx5xna"
Content-Disposition: inline
In-Reply-To: <ddc8040f-2186-4c72-a69e-26b388cb7249@arm.com>
X-ClientProxiedBy: BN0PR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:408:e5::33) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB2821:EE_
X-MS-Office365-Filtering-Correlation-Id: 10cb71a1-fec6-46c4-2dcf-08deb144beaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|4143699003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IFvFs7LwbWtRKsNbTC3tkia9gwRHGOmn9GLi5y4wJceCbhwx1ppWsmWOI7mdfeHHOhQNlJuJQf/bQWhGTRSbW0q2ZxL6PI0bk/ufFwzMNl2chxTicHTcNO/2hMmD/+Fmbqf1FZu+P0/aMEcChbTW3c4ric0bd6+BYswHhG/Bxm4M6l4JXH3HWLy+cpFmK+HYDmRgZ3DgVzU5yC/1iqaWliL+FyfhwQpCGFgc8Z3nJpF/JgMUWQpS8DzwdhRkgcogsmKtqSU81cP1CiKx/gmwkWYmwPtoEqSmZIMJlEaomT2SgC3xkPPmLWKuW6sY8IT5FWr4QaMtmf8LGhTBvNQCEnSqLJsWFL3258WF2NFUSrFbm2AVrG0X5tLkIHcwLCuejVLZgu6t4EyVBJpqm0ltnblwWQQnu0Qmini/uuXDO0EmYTYdW/cYqHDjHQJ09oe5ZYUgTYIIFIeuUcTqQob6BWCQ9CKUU6waDlpQO0k8sdqGxIm1Cro0kouZHn7y4jV+1I3Hzdwmd7SXBt/t9Y0sp93Ag98ZmnBG351ZYyIawbr9fXowxZeTri9zhiO7JWuUfeCRYtB9ZT9Ia0yt0Gobw9EPHzxk/HsOlYULJ4Ue2r4vjJxwC8KCHvLe9BvVuF2xpXb4R8n6CIuW5uEY55d0uBo01yhI6GzEFQcbDvPOCJbWSEgjV/Q7woWT16hV0FH4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cElSSGdkVmlvbEFaQ3I0MFQxL1JTTlkxc2xXRzVRZTRqUStZeGlMUG9zRUx1?=
 =?utf-8?B?cTQxeUpqMzQ3N0FSYk9OUStXdXphQ0REOVJadncwQmRJSG9xWG11SGdVc0Rn?=
 =?utf-8?B?SW1UTjNhU0M0Qmp6SlZMaGFLYzBEU280dWtacGZ5VmMxVWdINWRXM2x1MXBN?=
 =?utf-8?B?Snp4RkhPQnB1aVZrVE0zTHdsalc0ZmJrU2UrWXN4NGQzendWOTlpVUhFelR5?=
 =?utf-8?B?SGRlbE5lbFBlWnJIVDZPNndsRllrcTlMT3JEL0tKN1VCU3l2VVFXTnpaNmk4?=
 =?utf-8?B?M2c3cjJjbndtNGZsWlpwZFl3OXIzaTNiTWViQ1VNbm9OSkpKUnJPWFlkMEtU?=
 =?utf-8?B?V01YeE14NldHci8reit0YlJkNU9YYVZIMEFPd1JwSGhsSEQ1ejU3Y2ZoZFdp?=
 =?utf-8?B?dWpodU1vLzFHOGJXQjdqamJkdVRTN2EyVkg0RTBZMG5ab2JmUnNjcm13NTVE?=
 =?utf-8?B?TkNWRkY1M3AyN0pIeGZqdTY1Y2lqcFNZanVINFdacUJ2bGwxckQrMUljV1Fo?=
 =?utf-8?B?UFExWHJ4YjlHdC9OQ2laQnArVG1YZGZ1M01SQ3k0OHZNVXJoSzZzbGpLM0sz?=
 =?utf-8?B?cWpaZjFmcno3LzlZcGxEb3F3Ymk1ZXJjeTN5aFhZVDRRTUpQS0ttcVdEc21E?=
 =?utf-8?B?U3VpUHVmdUd3TDVaR1BlY0RmS3d3WTVTVkhBTWJxWWV0T1lVemhuZCt1dWhV?=
 =?utf-8?B?WmNMSDZhb1BTTXhWTDkrRHRjNis5VDIzdFdHVTRwcnVIQ3U3U3FkdzVXUVBj?=
 =?utf-8?B?MXFiM3I4dUNoU3Z3YTJ5Um8zbmpxSnJrNUlGMzNBenR2SkY3ODhMRW5MV0VN?=
 =?utf-8?B?cnNsTHNPNWpWd0hhb09FQkt3NlhLR3M2WURMd1MvcXMvOURCMWpGRlBQMS9Z?=
 =?utf-8?B?SHJweUk4ckU2TjZDQ3hZdUhSdW43ZitmYlBCSW9TellQNExpcUtYa2VJSVNm?=
 =?utf-8?B?NGl5d0QxcWhRMFBxM3BNaUZmek5aWGR4KzBRaThMTW04ZHg5bDV6RVZlbGE5?=
 =?utf-8?B?YlluZW80M3U1b09Zc0Rpby8wR2d2WERWSHJnSUxrUXNFUWtWMGc0VlpCYy9R?=
 =?utf-8?B?TUZLYzE4eXptTTJGTTMxRUwvdEJUZG4rcFgwVlN3cFlTU3BBZUVnb2FFRTd3?=
 =?utf-8?B?bHFCN3ZkSFdPaTg1NEtZbVA1amwvZ2xNaXZlZisyMXdqenRqbm1xcXFzVlVP?=
 =?utf-8?B?ZlJ6ZzBzVk1GOFhwYWg2ci9jSE56SkRXZUtNdUV4TW9EcmZISEI2U1R0Ti9v?=
 =?utf-8?B?V3F5MnJnMmtGRm1YYXN6T2tXQmNObG9BS04wRmF1ZjNzT0JlTW1ESTVaMXF1?=
 =?utf-8?B?blRISTZZeUdFWW5QUUswcnRqeUJ4SDF1Y3FrY2h5VGNiaTNjT081SC9aRERu?=
 =?utf-8?B?TEZKZ1BnZmJHNHpmY0FKS1kramx3c3BxQjZJT3RIdjlkWStab3Y5MnkvM24v?=
 =?utf-8?B?dHVjQVY1QmphYktqZHJjM0RqU3FNeEpGM2hKOC9DU1RidWpLQnFTV1FPY1Y1?=
 =?utf-8?B?SS9TNVFPTEhjcnU2eUEwWVdJeXZFT3RPdVdVNWtlWFd2ODFrMVozNEh6U2Z4?=
 =?utf-8?B?MXhGNHE4bmN6c1pJK042cHludVRmWEhjdzljeXRqWXZ4ZGRlVTB4ZVpXRE5W?=
 =?utf-8?B?RmYva1RxcThGRy9yd0Y2MVhlV08xcitZZ2hPekZ2RFVvMWc3M21EejZiYmJO?=
 =?utf-8?B?cWxrZnBGZlhCVVROWENhVUVFL3B6czJuUkk5STlSK01OcDFiNXhiTFBxNGNv?=
 =?utf-8?B?QXlyZTdxYzhBaFBSWVZEdUhJeG5QczhRSTNSRHNNL0QwcTUwZkxDWUpZNk8y?=
 =?utf-8?B?WGs4Y2RDT3kycFo5aCtHQXpRRm1PTkJKZzZlNVBOTmZLbi9zeEZSK1NSbnBU?=
 =?utf-8?B?Z3BFTG5iWVhBRHFJcnZHN1kzbk4vNTROZHk5bXZZREtmei8rYVNLaXFwK2hW?=
 =?utf-8?B?clpSczNZZkl6Vm1DS1dTWEtwSThQc0IvUk12a1Y2ZFg5K1Rad01sWDZtMTQy?=
 =?utf-8?B?bmxtM0k5YlVmbmg2WkVTaGcwdVdTd1lZMUgyeG9VOFgzeW1SNlVUVWdGS1By?=
 =?utf-8?B?Vm5uMHVMYTRSOTMxRWF4YnFwNlhVVzkxdHd5UW5ZYW1qalk4NUloVXk3blB4?=
 =?utf-8?B?N1dXcjJjWFR3VU1mVjN4L2FIKzIvZHJiVFpCaFI0MFJIV01ucjVua2pZd3RO?=
 =?utf-8?B?M3JNbnhTcHhxMHdKaTJPZUxRcjkrQXdUb1ZvY0svZDVlRytiRktMcWZ5blFI?=
 =?utf-8?B?SndVN0ZJOHQzaFd6c2V1TFFva0s5cWQxdDc5US9pWWZLQmgzajBXWUNKSzVD?=
 =?utf-8?B?WmdxdnRtRlpWTVJxd2tvZlJtSzI0WG5KbHlJeDU0UEhRQkRCczJFUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cb71a1-fec6-46c4-2dcf-08deb144beaa
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 23:09:55.2796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RWvYZaNwFCA1u0CkPSwor9PgOhXo2Av1QWk/g7sTNSZ+t4R5Zv2FX7ciuZ5wy/uahGBMSd0AjsjrjJPcHTUUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB2821
X-Rspamd-Queue-Id: B747053BCDC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15920-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_NA(0.00)[atomlin.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--kq232jr6wzwx5xna
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cpuset: Fix multi-source deadline task accounting and
 bandwidth bypass
MIME-Version: 1.0

On Wed, May 13, 2026 at 06:22:25PM +0200, Dietmar Eggemann wrote:
> Is there a testcase to provoke this issue in the current code?
>=20
> I tried to move a process with 6 DL tasks from one cpuset to another by:
>=20
> echo $PID > /sys/fs/cgroup/B/cgroup.procs
>=20
> but in this case old_cs is the same for all these tasks.
>=20
> [ 1991.852034] cgroup_migrate() (7) leader=3D[dl_batch_cgroup 823] thread=
group=3D1
> [ 1991.852068] cgroup_migrate_execute() tset->nr_tasks=3D7
> [ 1991.852238] cpuset_can_attach() (4) [dl_batch_cgroup 832] nr_migrate_d=
l_tasks=3D1 sum_migrate_dl_bw=3D104857 old_cs=3Dffff0000c4955200
> [ 1991.852246] cpuset_can_attach() (4) [dl_batch_cgroup 833] nr_migrate_d=
l_tasks=3D2 sum_migrate_dl_bw=3D209714 old_cs=3Dffff0000c4955200
> [ 1991.852248] cpuset_can_attach() (4) [dl_batch_cgroup 834] nr_migrate_d=
l_tasks=3D3 sum_migrate_dl_bw=3D314571 old_cs=3Dffff0000c4955200
> [ 1991.852249] cpuset_can_attach() (4) [dl_batch_cgroup 835] nr_migrate_d=
l_tasks=3D4 sum_migrate_dl_bw=3D419428 old_cs=3Dffff0000c4955200
> [ 1991.852249] cpuset_can_attach() (4) [dl_batch_cgroup 836] nr_migrate_d=
l_tasks=3D5 sum_migrate_dl_bw=3D524285 old_cs=3Dffff0000c4955200
> [ 1991.852250] cpuset_can_attach() (4) [dl_batch_cgroup 837] nr_migrate_d=
l_tasks=3D6 sum_migrate_dl_bw=3D629142 old_cs=3Dffff0000c4955200
> [ 1991.852328] cpuset_attach() (5) cs=3Dffff0000c1e9fc00 oldcs=3Dffff0000=
c4955200 cs->nr_deadline_tasks=3D6 oldcs->nr_deadline_tasks=3D6 cs->nr_migr=
ate_dl_tasks=3D6
>=20
> dl_batch_cgroup     823     823  19      -   0 TS
> dl_batch_cgroup     823     832 140      0   - DLN
> dl_batch_cgroup     823     833 140      0   - DLN
> dl_batch_cgroup     823     834 140      0   - DLN
> dl_batch_cgroup     823     835 140      0   - DLN
> dl_batch_cgroup     823     836 140      0   - DLN
> dl_batch_cgroup     823     837 140      0   - DLN
>=20
> [...]

Hi Dietmar,

Thank you for your feedback.

When you write a PID to cgroup.procs, the cgroup core gathers all threads
in that threadgroup into a single cgroup_taskset. If those threads were
spawned normally and never individually moved, they will all share the
exact same old_cs, which is why your test yielded identical source cpusets.

To provoke this specific BUG, you have to split the threads across
different cgroups before you trigger the batch migration that pulls them
all back together.

Here is the test case to reproduce the multi-source edge case:

	1.  Create two source cpusets and one target cpuset

			mkdir /sys/fs/cgroup/SRC_A
			mkdir /sys/fs/cgroup/SRC_B
			mkdir /sys/fs/cgroup/TARGET

	2.  Start your Multithreaded DL Application

		Run your dl_batch_cgroup app. Let's assume it has PID 1000 and
		spawns two SCHED_DEADLINE threads: TID 1001 and TID 1002.

	3.	Split the Threads

		Instead of moving the whole process, move the individual threads
		into different source cpusets using the thread-level interface

			echo 1001 > /sys/fs/cgroup/SRC_A/cgroup.threads
			echo 1002 > /sys/fs/cgroup/SRC_B/cgroup.threads

		At this point, SRC_A has nr_deadline_tasks =3D 1 and SRC_B has
		nr_deadline_tasks =3D 1.

	4.	Trigger the Batch Migration

		Now, trigger a process-level migration by writing the main
		threadgroup ID to the target cpuset's cgroup.procs file.

			echo 1000 > /sys/fs/cgroup/TARGET/cgroup.procs


Now, when you execute Step 4, the cgroup core gathers TID 1001 and 1002 int=
o a
single cgroup_taskset. Because they originated from different cgroups, they
have different old_cs pointers.

However, the unpatched cpuset_can_attach() loops through the taskset, finds
the oldcs of the first task (e.g., SRC_A), and caches it. It then counts
that there are 2 migrating DL tasks (i.e., cs->nr_migrate_dl_tasks =3D 2).

In cpuset_attach(), it blindly subtracts the total migrating DL count from
the cached oldcs:

		oldcs->nr_deadline_tasks -=3D cs->nr_migrate_dl_tasks;=20

		/*
		 * SRC_A count becomes 1 - 2 =3D -1   (Underflow)
		 * SRC_B count remains 1            (Permanent leak)
		 */

The patch resolves this by evaluating task_cs(task) individually for every
single task as the loop iterates through the cgroup_taskset.


Kind regards,
--=20
Aaron Tomlin

--kq232jr6wzwx5xna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmoFBLcACgkQ4t6WWBnM
d9aK9w//Y+QcBn96b9vTZhfFdo30L32Pua14eyYpJv2NF6a+sJLaFaE1sxsp6+MP
0BcjU6BrgTXvW506lLLp6cyPryEvR47ZoHpCwjIvVmjTBsVf5XRyK42xxJA+j18W
s64QYtWiDHbO94fGqvpYrLaxQu++55DR/++2UO8ieJ2DJnmuXl0SBcPVRd7Hx0UN
rXunUWfq9OJhdDAWXTEvXQ4OkxRQlDjpgEIgxeABh3L/Caf9PB7CZ+RQcHxU8Fjr
kZzxKPqZAgzkemY22QCDsthwS1dDgFHUBH06DK5rCqSBUJeaoSU/y9PcxU6fSsCK
nt0rpMisqN/gv7kEBYplTeL0iaGr6pV4SQvMbC7McZI/HZHtuqdBnG5d6VjGuIUd
hSOqKF/Dwh1sYeQPcwIVIrknmobEmUYY/sIDlK8ast/q868tUJhDsGgg9yw49Sdz
4d5XQEoCyMIWN6EzmdECZrf2FTxwvxJkX3gBhCr1FulYEbY8lZUOKepNIfL5ebXq
9Ijzw4AVgw25fvFzewtX47/N4AC89CltyPHTypcqIGuGYHgu26Fs0Z+UKDvCyDLa
SEJsQEtVk7Cg3Dwpo/5LLV0R6vyAU6r5MBlLwZ5XNw4sh4Xy2yOWmrJDTsjEy200
WfkEuMVxyKSbpnQX+kX1LA4X7gWdTmdLADGXlDukMAVz0QBB1mw=
=2LIu
-----END PGP SIGNATURE-----

--kq232jr6wzwx5xna--

