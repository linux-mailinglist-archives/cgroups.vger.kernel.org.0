Return-Path: <cgroups+bounces-15922-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE3xLtcLBWo1RwIAu9opvQ
	(envelope-from <cgroups+bounces-15922-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 01:40:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 382C353C16E
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 01:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C01BF3036488
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 23:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C620D3CBE8F;
	Wed, 13 May 2026 23:39:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022102.outbound.protection.outlook.com [52.101.101.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625B62253FC;
	Wed, 13 May 2026 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715589; cv=fail; b=SCk41yUiosIUwpoUOqSssAQzmjgxCvkyBYO16d7ISeCHKt9G2T2xjwVyVBYwPnE1x2LxVq73IEXMj5uUBzBW8J0oJrgGSawWyIPd/oZ/Ct03o/5dY2N/9mA3heok1ZvH2+uGRwqbKdTWcCcC4J8NK9l3Vektl10U1Z8KmNPTKvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715589; c=relaxed/simple;
	bh=yhIEcRYZgufhZtChZCb42YmK73ile3xPVAw0fzW9CUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OkcmvTlfURV9XHNMRYDO2S4rFEzltboLFtGoPCGF/I1VB9B+UurG+XThjnbN0LJ3F0cZtkDxZ1Ieh1yOBsurSyncR6AW+kwfLb7xuiyxBh867ugOW4+9ekZV7vuEBaZAzw8chVDCpt/61cfYotbL/S6MYukX15CVnzndOLJbbyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOuKbF3AORvVxA6kM3fd3hkp5F7XSsz1dEAWr8yJ9i0qbouvqX6EKP3s47ISJio+M+oM+LCf0ZSlbmh6P8QzK8e7w66IuuRBP6YRHDFK9juD8J3+EsWEuLdGufLSbTThkDxGy3zW6ZMP5Ve0VUQqfgxce9aR5GfQdKXCb16qQLEHif5pkkKojBKi9Kih0VNTmZ8dZXB+GRaIwVy9wxU/fKD1YugJR/mjfbiLucT9XAAG/kp2RVMrJY2fBbuiHQybnC2NgmiPNVop3Cv2X0LejIVNEWUhWPgpaZF+NE/iBm0nETVlUbNN49xKI/DMbfPFDxfHqFlQr/gw96wc4+FN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhIEcRYZgufhZtChZCb42YmK73ile3xPVAw0fzW9CUk=;
 b=zL5A6UN0E4Zvfs0qY/di/lTHXA8rAgk3PFeQzue0kMAylW7cI63naF0hSoOxqO8GJseNnt6MWgK2lLctfuRk63SlFMR9me+lV7WL1zfRfgaQit5DCmgVYOJs+huxwI5raFCYH1dnxZWPC9+Wv/J2KqPzVoWCgXcoVJg5vgfeACCItPsvr7XPZ3izFQyh1viXDFzFpL5CdhXEJrDMSp1zXpEqtHJQ62OJZXtGKMapJKRWhfXCahQKseN+eAYVJ8vcLviMbC6FjFYgYYVB9it9OZvjx3bAdwQfUaWfb6KqD6O2kYU/GakUcDgUgWwBEJ1W2RsrMu9V76/ZAR2vJRXUEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO9P123MB7635.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Wed, 13 May
 2026 23:39:44 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Wed, 13 May 2026
 23:39:43 +0000
Date: Wed, 13 May 2026 19:39:40 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Waiman Long <longman@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, tj@kernel.org, 
	hannes@cmpxchg.org, mkoutny@suse.com, chenridong@huaweicloud.com, neelx@suse.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset: Fix multi-source deadline task accounting and
 bandwidth bypass
Message-ID: <djbtucfusnpngys2nritqsi7stjq243zchel45ahfgaruba7el@4rtk534mfq4j>
References: <20260512010341.101419-1-atomlin@atomlin.com>
 <ddc8040f-2186-4c72-a69e-26b388cb7249@arm.com>
 <7ae7fe29-6405-41e3-9f3b-6c1d0255dc9e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wkf6li65dykpojer"
Content-Disposition: inline
In-Reply-To: <7ae7fe29-6405-41e3-9f3b-6c1d0255dc9e@redhat.com>
X-ClientProxiedBy: BN9PR03CA0669.namprd03.prod.outlook.com
 (2603:10b6:408:10e::14) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO9P123MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee7bce7-69bd-4fad-1f36-08deb148e8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eH+0ocTJuMA2TRe1uOR+Ln45JeQ4MJrKIJjhE63Agi0ITx9JvUlG/i9QpmN6orvlaF3AeLkgOjmNooRLmyB8rgzrK400I5srd7vD8qQCH+RqWfhkLLGYrps4TFKGTWVMu8jD1W8bKimtMaqhbcGxWQS/DgshjldDkc/1KiCGzpwOBIFV0dpMWJHA4RoUojz00Wrckw6W2AWGVo8MAg6IVphoUiQlHLc/7kmXrkahLvF6exMgXV3ZdwPo73NjMkCgGyGVi/pwBmX+Ec0zRvbszv9wgsYkuuOzeVohQdd96NIpTePz4dgtQUnXXYbtT3E0INKftY3quNl6UnVCxfWAyhhvUU7d9SFH0dKgY3+T960vgOQ62H/SucfSTdzJPCX3RlRlX0b/PHZTS/aEIgaXXP7luWfqhlwi8/QIz0pf5SDm2SiXs+QbrFKYXtyeTtQGMI17jBmnT6riAIF0Po4N/LCIsQlyLn+cnkFOGcJTnPlQXusZZiJRJ8eNgG1gOw9ChvvXa5+lgNx5+7eEdpChPVwj53oVJ1AbzdDxoOo40rwmtUL5QvzkKqAxdgEFJS5fmL6abrshM7M7WoGM2yQfDMgCsjHhBBOy2pGfj+wOilvs0FrvGkBROmKep7tXugAbcLuyHZM4YpITg76mnDMuYRh0ynZV0Yc6QmcIH2+wn2U46Gh1C2VH0wo80r7I5I17
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnZvL2NyQ0t5SDhmUVVHK0RIRzR3TTVEQkRYdm9jZ1ZEZmFXNm11Q1ovN0lI?=
 =?utf-8?B?a3ZwTEkxZ0kxZG4wZFF1UWdQaUY2azdESGJxbW8wRmhCdWVpaWlGL0J5WklW?=
 =?utf-8?B?THhtMGpDTlg2c0JVNlIxdERCTk5LNUIyTUMxNTJQK3FHejFVOXV5dzMvWjNr?=
 =?utf-8?B?QnFrV1YzT1dtc25wQmxOeTc3cUhlNG54Wkpvbmw4b2NIUVZCL25MU0xwOHJW?=
 =?utf-8?B?aHZPQUF4QkJhem5rM0xtQm5DcXhYQzZuQklqdVNqVGx2dVJQYVhSa2h5YWpH?=
 =?utf-8?B?eU9SVEcra05mbGc0aVJCNEs0bU5QSWsxdTErMDZ0YXp5eTZiV083eFl5VzVy?=
 =?utf-8?B?RG85RUhsMWx5Wi9PSG9jVkFVOHYyRWpCQnRPMUdJcUZucjROZ1FKSEJZWGlW?=
 =?utf-8?B?RW0rOGZWTFI0c1o3aFJBSFJLTkJFMzlvcTV2YjdnUU1rR3pmMGd4N2NJK0dU?=
 =?utf-8?B?SEdNUlRUNkRBK1RhZzJ0b3hzb2RLTmJNV0NsWjlwSFIydVo2UkEyZHd6aXBp?=
 =?utf-8?B?ck5QYnZmakJmdlAvOEtNN3MrNXpNTkRFc2N2WC9tR0lJRnNjUzdBcXhqVDlt?=
 =?utf-8?B?OFd1SStPVVY3VWhvRnRrR3hwazZ5eWlYcFdPTWh1anJxYldaMFk3OWlKWkF4?=
 =?utf-8?B?RFBIVEg2YVdxNnR1eEx2aVNITmNJVk0wU1lockVzeGtPb0FYUVFIb1hKZ3pW?=
 =?utf-8?B?ZytjNkVrNVJ0MVlMdk1oUUFtR0pINGI4aFNRY1JoMFFkcjJaWVBwS2EwamVn?=
 =?utf-8?B?KzQvSzNjbU85aG5rWFQrTTVidnNPU0FPZWljQ2R3bWU0YURkVm0yZ2xlOE8r?=
 =?utf-8?B?N2JyS1dTQ1hpUFhSd1pEdUVrclluWUdYbEZ2SFkxUHdzQ0tRQ0VHS3R0ZFlH?=
 =?utf-8?B?ZzVQbGsvalcvMjBaUFRnVkdUOVNWdnIwVXJqelNEWEszUGNoVCtNcU9RVW9l?=
 =?utf-8?B?UUJCNnZPRVVOVW5IWTZlb1RSL2IvcjN4SGNJV1o1T08ycEJZVFk1eTZrTklz?=
 =?utf-8?B?NkFMQ1ZDaHFNVHBxVCtrWk9XcWVTZ1Y0bUt4dWtSQ1pRdmQ5RGd6Qm9tbFdx?=
 =?utf-8?B?WGpZR1lnbHVnZ2d0U3NDRER2Wlc1aFYzWE1LUCs1R3hJVjEyeGlybXJrRFRm?=
 =?utf-8?B?V2h4VUVoTmUwU0xXS3NzemEzTC8vdUVzRVBOUmZWamJTRE1TbEFPSVlvNDVu?=
 =?utf-8?B?MjhlQytQZU1DejI4MlY3ZzFvOVdyWmlDRjB6UHM1U21zNVFKKzFFejc1aHJt?=
 =?utf-8?B?OHhGZjR3WTBYUmExU0dDZnRDay9VQ1RMajBoUUVza3d4eVVUdUNNWkZMYmRI?=
 =?utf-8?B?bVdmSFdKV2QwWW8rOHU5eTJGbmtpcHJiUlFxa0lFNVEwZ0dMSFJkNWdDVFNa?=
 =?utf-8?B?NkQ0TlhCRG1jTGRtQUxYQjV6VVJEdzlpeFhJR1FzSTY4djVQaUNUcWZac1dS?=
 =?utf-8?B?U3ZRdEJoY1pqbTdTSHFHN2hQdWxSMUo4Vm40ZVBNdC9kMFhkRVc3RGNmeG9o?=
 =?utf-8?B?ZWxkSkdhOGRxei9aRzY2YjJiWjdIT3FhYzVhVk0vZTZMTFovbXI5TytBV3NG?=
 =?utf-8?B?TEwwNE5BY2RvWHQ1S08wOUlLMWRWMEYxN2VRdmc0bWcyUDMyUEE3MkpVbUgy?=
 =?utf-8?B?cUY0OTVscHFab28xYVlWOUg1OGdQQjFHWm5wN25rVEdBczB0UklJU2pGSVQx?=
 =?utf-8?B?L1pyc3phSkp2TjR5YkFZb3hKNFVPMGdBY0hJSlFjWmRxbWxGcElTYUNieFB0?=
 =?utf-8?B?aURPRmgvZzFIM0ZnSWZlUDcrTHVGTnZsU2lRYmtEd3RYNjMxVGdBWnVUajdo?=
 =?utf-8?B?RnVHdFpYWGk1WlRxWU1TcUR3aVh2UFhZK21MdEhRNHM5Z1krQ0NsUGJZUWh1?=
 =?utf-8?B?ZnhMTkQrTWhzUmVCMTFqV1BpNUdrQS9ScGxEOGNRR3E0Vk0wVFM4TjArdUIw?=
 =?utf-8?B?S2kvVkd4QmQvT2cwYzZCZ210NXgyTXUyRWhGZHZhcitiQVFVNnZpVkltWFow?=
 =?utf-8?B?MjhUNnVEcDlsWG1WOVZvaTNaL29Ueks4T2gxVVFTUXpKeFhQTDdha1VWTkxr?=
 =?utf-8?B?MXVlenNXejJHNzJnNHhMTm9xRWJkOUt6cTdLUys3dW1CamxwbGIzWDBmNlJB?=
 =?utf-8?B?SXE4VXp4L3REZXZCcWpVeEZxTHdmZ05UR3NUVUFIU3RYbzQyOGpJTk1ZdEVR?=
 =?utf-8?B?eWdHNzZPQWxLZTZjZzYxU3Z3STd6ckIwczBvMWszakhJUzBvZ3ZDYWxaQ2hl?=
 =?utf-8?B?YjYyUFFjL2pZYThOc3kyb1Q2VmJzbHFxeU92ZTloTUFTOU12UW9pVnNic3FD?=
 =?utf-8?B?Y3RlNnBtc0NoSHYycUtJUkxVU3VmN3JxbzZURGd5YnBaZ0MvUVVTZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee7bce7-69bd-4fad-1f36-08deb148e8fa
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 23:39:43.9237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4M7DXTQwycdv8NJ71omDakf6f5P3nc5ET5pHacwutn9Eu5tL59ev8dCZgej8j7OoPFBUUVpcRisULKHNsLYpMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB7635
X-Rspamd-Queue-Id: 382C353C16E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15922-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--wkf6li65dykpojer
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cpuset: Fix multi-source deadline task accounting and
 bandwidth bypass
MIME-Version: 1.0

On Wed, May 13, 2026 at 07:19:18PM -0400, Waiman Long wrote:
> Multiple source or destination cpusets in task migration can only happens
> when the cpuset controller is enabled or disabled in a cgroup subtree. If
> there are DL tasks in 2 or more child cgroups, enabling or disabling of t=
he
> cpuset controller for those child cgroups may lead to incorrect DL task
> accounting. This patch will probably fix the DL accounting aspect. Howeve=
r,
> there are also other issues unrelated to DL tasks that need to be address=
ed
> as well. So this patch is incomplete in this regard. I am working on a pa=
tch
> series to address these issues. Hopefully I can send it out in a day or 2.
>=20
Hi Longman,

Acknowledged.

Also, the Sashiko AI review reported: "TOCTOU race on dl_task(task) during
rollback causes state corruption."

A concurrent sched_setscheduler() could alter the scheduling class of a
task between the initial pass and a rollback. This assertion seems valid to
me. Currently, neither cgroup_mutex or cpuset_mutex prevents scheduling
class changes.

Should I let you handle this too?


Kind regards,
--=20
Aaron Tomlin

--wkf6li65dykpojer
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmoFC7wACgkQ4t6WWBnM
d9b2Mg//SC9XsD0B3ocNUTyFBKGoQktnJJjj1yIaact6MQZ+cNTo9PStRebxE/tM
PIMSn5w8sq1fhSbH7vmSdUJQmQ7suA9lfKxwJgrVqTl9JTn6hIsy64roTr2tE3Z3
cdhCV/g4VfTNyGdSKpuIZF1nYEkrPhhwuCrhRpwBTaTHp3mKfua+6tNplja0K4wE
TpjjrDb5ekJBcbkUbEiciFNnJS2zkBtKdlTX6DkWZebhu1PFfOdiCQ+XMgIwjxSW
a9PHCQOsADpVIzlKJQX8xjHSdqP3OifcshLFbVaYYQ8LxGSMsnkU64Tmo90Lg/No
CITU1Wng7IETVrjQLhCCpyZ4GQZGHXAuTV88elF0nEL/aBQefRJHcCIxGXwJA4uh
53Pk3GWU/nP7u3rM9ZTfOaKVwBoYS8uZtSMcs/nPB9G2gUJxRYlsLFKnVHmw4e/V
kqfopZK18WfqmpAI0eTMFK4iasSquiipMW+PaZdyVT1WIRIIpkzB2D+KICPeon6m
VwINoxFTiVxcaoiWPQTMG7V28VaMRPJwy3v+oBmf4foitT3rXxCqDH/w821c11cG
2dBF3r+W1jRH1FhJr4IlNBebftZVSNhDo4hJoNvwm3aWAuu8F3OfOPoBNvQhanBG
2kynChzjBpaDPlRhhFu0AGyYqIQ5e50oEHQAVJiuXy/k8/tq2KU=
=jtBf
-----END PGP SIGNATURE-----

--wkf6li65dykpojer--

