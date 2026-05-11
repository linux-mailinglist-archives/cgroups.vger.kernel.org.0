Return-Path: <cgroups+bounces-15788-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEmzFEA7AmqYpQEAu9opvQ
	(envelope-from <cgroups+bounces-15788-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:25:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31900515D31
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99B903017E54
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448143803E7;
	Mon, 11 May 2026 20:25:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020093.outbound.protection.outlook.com [52.101.195.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD43837EFF1;
	Mon, 11 May 2026 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531134; cv=fail; b=VVif1VoqsAIYf0aNJcIS32uqcjy60PhfZZqU3Fld3cbJRzvyQV+TOKgcUlRnpqzU71XdcW3Wl7oJcV9BjX4/yLvOrHEpj1/snWj0ZkFwxutZTS+TU6++VMwdPf5UAo9q7ewvmk12lV+fCfdNXRWwQTIwwnZXOXM+hgXrwHm7T6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531134; c=relaxed/simple;
	bh=r7hDVemhI2YXZfCJE7LzF9SAYP0T8p1nJVdHsC6eF3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g7ORScUQ1fM+rMDHTgyct9CzRdwg7JM6WX9NJdZK5/WZABQ2r8FfcMwPGpmyp+YjDLDUWB9+6G2zTDH3cqlKXVZ/Pq6tV71bRdtBwRtXlvx5q5X3qJphA+hfLRDJ6D9S/lWsNklEE8zv62NORAWeT3l+1GIqwgSCIW08R4GLTOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6koXPU0I/sBtSe1Q7a23jMQYCQ2YX6TYo0uj2+V5IgtQ/Tm7pmAZ7eSraJ9pFVxA34clU4ac7fG9XK2Q5ghHazAGQWkg7rbKs0MRCq+IcI6/p0JjcpfhEJ7RAxOj3HkBKWWNKee9xhNA7sJwz8eT4eqpOVlWQp9Y2Y4CN9iM+21v8ZaYWL8W1QUoP+0gTadYRFm6EtveTFrT6BhxS0uC6AYxSFrd6v4chvvSHy1FW3TPFpm+Rw4bix7rwgnYQqnIKGsLYmVe5jExOWzIyoO1f7Jfh+glFS7yMh6kIXjBYwwH9t1b2NSEVWakdYNmb4nZo+A1qQw39Jpb9I9Rm1JvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7hDVemhI2YXZfCJE7LzF9SAYP0T8p1nJVdHsC6eF3g=;
 b=Ui3YOY2T4yNcWrwAlmyjHToCMZaWsxXzQtB9LePmj7Hqnqvg4VKrSZrFzYTgagjpLB3fXs14+KpeGuziGGI69k4769bHDl3ddYT5IMN/MTeSSO3CbNFjFsIdQNxYXEmnL7LaEymV62yYy36Gw5LvSZcfl5FC0lcENMWtttm5N0gqoIAthGZcjTnG8bF2baPYx2CRCBetGuAt+ZPdFpwNybWPY2MJIl0B8cXo+vOwoK7x2VZXbG8NIiO2ITXgu/7UURV9uwREjyULrHckV6ZJS2HuQCrS+zNkSUPOb76ZwuO2iWojIhspcBjVWNu3u0F2/tmxzptxlKJ2N6n6R35gaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CW1P123MB7820.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:243::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 20:25:29 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Mon, 11 May 2026
 20:25:29 +0000
Date: Mon, 11 May 2026 16:25:25 -0400
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
Message-ID: <dif4xi73znyz3diguyxihzztgosvyj3bjeh3y3oidg4gnt2qpv@5nygeq3rk333>
References: <20260509164847.939294-1-atomlin@atomlin.com>
 <20260509164847.939294-2-atomlin@atomlin.com>
 <8aaa7dd9-2426-475c-af64-85ef5f2aa855@redhat.com>
 <aihz6zlfmcaxwb3ef4luisfpwqibwsajpphy5vzuksy3ftfkms@whhv2ax5plpb>
 <354af9fc-1c70-4ee4-a0ff-8821bebec7b8@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jrqcg3cyap65nupq"
Content-Disposition: inline
In-Reply-To: <354af9fc-1c70-4ee4-a0ff-8821bebec7b8@redhat.com>
X-ClientProxiedBy: BL1PR13CA0270.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::35) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CW1P123MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b6edf2-a782-486d-95f3-08deaf9b712e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	sCWaxIkpj48DqctKtcI9qgp5NNpp81gNVBRYl0fHYmp1XC8KBi+nmT4bXdQ/sPecu4/0WgZxQg1Zi4oUPZPJMTab0QSjq3N9TdqtvSSRVsDo1i3otizMzNSf1ap8omwmEChKi0SaPt5tnBk9iDuPJaXigoEO6F7NfyA+z25n8X8/cMCneWWA8stt6E1aHWCA8/f87t8SJYYYMpX6YJlqr5ug8XnHGBs1+SbmS6QysvmBu69AOOf5uqINZPN9ztfXgRzr1qt1abLnK7hYlRi2WeZKeDisyI+n457UBk0lA7d7D+5KCFsEeK2tj/i5KWICrM1OOzICUfBPqIQyhwKj8PwTqQkXx2uYD91UVouIPlfcdXnj54+d4rivPeyYaVZcd50Oz/f4Auc/78R0BLLi6uCE15AAJJDfDcbSgjYLhCBMRH74ca62aGNfxFRA6hjdj8xGvXXEU8YsylJxhyLxMLDh5N/1gMJUKiBQRxmv4HHZCaV1+cc2LtTeiRY9KnVlCKFzDEauTvILDcCH+agvYEOHq0K0FUR0Q+9KYS9qW1QTOjT19vQvk0Sr4fzk3EIp31rVaV8wniY3orcRnPACLxUhYcIKAi/A1vmwIEU/do041lS/EaHH+l5SLWOk1udJN21FAvM606h3jSLzvGG4ahSIZVG+A4VedMVWkIFzm5EKalkhzIhQ7iW7IZmpJA1aaA8h/0E3hRtclvBEzB5Uxg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXNrUVZjeGF3TTRhMTVvaGxYN2E5ZXkwdEU0OXBRREhJLytmZTJaTWl2bnNi?=
 =?utf-8?B?TXVTK2NQd1drMmpHQlRDQnlWUWpxMHFPNVp3bk5yWUlxNVBGSTJabjlxVjZi?=
 =?utf-8?B?VnpURXJnUmMyM241NnB2WGE3aGwxc0dWSms4L1ROdm5nQzlTMDBxam5URmt1?=
 =?utf-8?B?bFlhMFFvK2FqNW9sc2s1WGhBTFhYMlpuaHhhNENyZmt3Vi8xTEM1TEpQZzlm?=
 =?utf-8?B?b0Zyb0YrdFhIRGh1R1p6M2tuSWw4cmtoLzNudFpmK3orblcxckRmeFFJaHRJ?=
 =?utf-8?B?UE1CUXpoZ0lBcVFENURjczlacVRDWTZsZXRwUkRZb0Z4d2U1elEwY20xVHZT?=
 =?utf-8?B?U3NQdk0zR2VhVkhzMXVRdnhTemR3V05rRWtUVXlsQXY5M1BJTnhuU2VvT2Nq?=
 =?utf-8?B?QUk4RmNqTGk1amE5UWZjNEFHVjlYVEtlTjdSa0t5akxUWU83MFM0SERrQ2sv?=
 =?utf-8?B?TFZnYkRua1BVNW5lQ08zQVE2WEZOVVhRSkpxclB4MDJDQ055UXhBZzA4cmtC?=
 =?utf-8?B?TGFuQVNEb0ovaGhESS9yM2d4MTZqQmxzMUZHLzRjN2UrWUFRTmd5V09HQmlG?=
 =?utf-8?B?QTY0bnRDZnZQOUhSeHV2dDRMTzNNdTNPQ1d4YW9TdmQyang4a1ZxeTlPUHRP?=
 =?utf-8?B?RWZmU2JFMERyaHZWOGNvZVg3b2UxNEZRZ0wwVG9tUEg3a2pEb2tZZjVKOHo4?=
 =?utf-8?B?YVlIeGNHdkMrMXk0aW1XWHdzYWpCaWM2cG9MeWRoUHBYYnczSW10L294YWxL?=
 =?utf-8?B?bGRQWjF6eEdOVEVleVJPWW1CQVpVSndJTUhEVW1pUmVTRWZWWXVQQzhFSXc5?=
 =?utf-8?B?aGVOUkgxUzFkamV3dmJkbVRvSmFTY1N5ajRKOW1sNVE1TnFrMm5pK3Y3a3lQ?=
 =?utf-8?B?Z3g0UFZVSHZ3bmxtT1FMSWdmTjJMdWtHSXZiVlQ2RGRjdUZFQjRWbklDS1d3?=
 =?utf-8?B?RHRVeUlEVjgwMjVRSVFZVlNmeW5pclR5OTdrVWRzR0NZQ004WEZ5eWxaT3d2?=
 =?utf-8?B?UjU4TFdVejlVK1RCN0xrN1Z6b3FPUHh3cTNmbEZTZUt0RTgxYjdUc0NJMEZQ?=
 =?utf-8?B?ZXdKWlNITGpXUUxPVWRqNHZLM2F4bTlFMEh0R05ZMktJU0lsRzludFZJY0xX?=
 =?utf-8?B?bWpEdmxMdWpUbFkyZlhOc1FZK1FENU9pOGk3aUpubDdGaCtjbEVlYWNUNUdC?=
 =?utf-8?B?NXdtbitkZHYwUE1jMkE5RGl5bkt4QmVQT0NlY05jclRUNXY0OHppTVFmTUxo?=
 =?utf-8?B?Njg4MTZDTGErUEh0UjFYZStSYW1mR2FXa2h5ZTJ2ZjZ2OWlsNC9oOFRnTmhN?=
 =?utf-8?B?dXN0N1Qxa1c3Z3k5RFNCSzdZTDFmQkszdkdDYkhTc0g3dm0vU0J1bVo2eWUz?=
 =?utf-8?B?SmVrVVBNa0ltdE0rTVgzR1NUS1c1VXcxSkVwKzhDUitEMWZVL1NLRzVCY1F0?=
 =?utf-8?B?MENDVTJTOEZFZFRKaVEveGhOeU1IWlM3bGFrQXdzNVZ1Q0hYVEIyZ0hhbjJB?=
 =?utf-8?B?V2NtYjkyMTNvTjh4OHVuOHAwd1UzTGdySmdrcXRDMVVSd0RDQk1IZ0VzcFVs?=
 =?utf-8?B?UDdRTlJqMkcrMUpMc2pyTXdzU1J6aTZ4anNIMytucW5Kd3ZScVZQK2pFMnRQ?=
 =?utf-8?B?VXNqajhvZWtYZ01Pdjd3WlA0eUtWcERJVi8waTJROUZGMmc2VExlVExNUnA0?=
 =?utf-8?B?RGpvTEFyTFBYQkNzbm9EMzZPc0JGZjFTdWtMOUQvRGZEU2hpYmplUUhEUFBO?=
 =?utf-8?B?cExncFNtK0NCdmJRdVc3aWd0UVBGRmxjdDlxc0xkbC9TRERyNXMxSzBwbTJy?=
 =?utf-8?B?SThtYVRwNzlLTzBXckRMcDArbHBFUC9FOW1HaUhrcXZ1YmFrenFvcXhRWUY3?=
 =?utf-8?B?RERVNVkwR21DSll2bGdibTdSTWVzSlc3bnRRY2xsUllIVEgzMGx5eDVqSzgv?=
 =?utf-8?B?RTFla3E3aExwenI3bFV1NGh0UzAvR0MvUmZYbkdLSVVYQXR4Vm03SGVxT0tQ?=
 =?utf-8?B?UStLSkZ4YkZzdklXWk01MS9NaEUvVmdmNlFDcWdReW1OVFN4NnFwazlQdUhK?=
 =?utf-8?B?RGJmcjhUVnduV2hHaVZZV2hHQmdiSVo3Y3RrSVZpNDgyR0lXQ1FkNk93N0NC?=
 =?utf-8?B?M0wvY2hiWGFwS1pMcUlRd2MzcXFzU1VJajBDWElIMmhnbmJNQ0NqbHQyZ3Qr?=
 =?utf-8?B?V2FUQ1VEV0dwNnpzam8zL0pKbU5UWnVQWWtFSkMrNW1GellQS01WWG0rTngr?=
 =?utf-8?B?RHVyVkpJVkxmREdQVEtVaktnS1lFODBYYUdSQzEwL2R6ZWN6eE00U3pGR3l1?=
 =?utf-8?B?YUtPVlM4cFk1a1hralpGREJiYjlVWmh6eWg2QkZGOFhaRTYwN1NRUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b6edf2-a782-486d-95f3-08deaf9b712e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 20:25:28.9521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ah7l86FDJvbj3RdeyHcdXA0zwoT9Tm05wokBH0wvd2Ul3wTjX+c6wXNBTSt4WMIq32Yd7Vy1tVLxnZpeK7u8SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB7820
X-Rspamd-Queue-Id: 31900515D31
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15788-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[alpha.franken.de,paul-moore.com,namei.org,hallyn.com,redhat.com,infradead.org,linaro.org,gmail.com,schaufler-ca.com,kernel.org,cmpxchg.org,suse.com,huaweicloud.com,arm.com,goodmis.org,google.com,suse.de,amd.com,ashe.io,abita.co,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.908];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--jrqcg3cyap65nupq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] cgroup/cpuset: Fix deadline bandwidth leak in
 cpuset_can_attach()
MIME-Version: 1.0

On Mon, May 11, 2026 at 01:54:37PM -0400, Waiman Long wrote:
> > Hi Waiman,
> >=20
> > Thank you for the follow up.
> >=20
> > Acknowledged. I will drop this patch in the next iteration due to [1].
> >=20
> > Please note, the sashiko AI Review bot reported: cpuset_can_attach()
> > incorrectly assumes all migrating tasks originate from the same source
> > cpuset. At first glance, this feedback is valid. I plan to submit a pat=
ch,
> > if no solution was already proposed.
> >=20
> > [1]: https://lore.kernel.org/lkml/20260509102031.97608-2-zhangguopeng@k=
ylinos.cn/
>=20
> Yes, it does look like the AI feedback is valid. I will take a further lo=
ok
> into this.
>=20
> Thanks,
> Longman

No worries, I have it. I'll submit a patch for review shortly.

Kind regards,
--=20
Aaron Tomlin

--jrqcg3cyap65nupq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmoCOzUACgkQ4t6WWBnM
d9Z1Mw/9Fvj+bRSfdhTS2OSiYGFkxkwzjIV2hi2rP/F/074x3+NhmlyX6BU//3HT
6jr+qYIn9ahQNAGW9qsoYJNINn5cDBWCAeIyLAygMvhe2uurN6d00TnljBxc15Py
ARodKck6kz2A5MC/c3usSymZhs0Z1FXJAwFPVCEMzj5/n/Mu6k9Y4FL3JnUAKUgs
ilgwo90VgMZTYxfEbTeWLwBga2qUta2TbiLjmR+ydAYrs6HcrXzZM77aj4CQtrbj
EYKqe6btSK2FiDp4M723f02PtMq/AmKBKgjTOUUmXMF/vnsYAz5LxokcE0RxSmri
WiuFY7st6uhL2KlKu46PB2T/dy+GM98su+sno6+ZpW19qDu6+8JZ3/uUvJ7UaDO3
qllX+Qbgt5vrboeLso9FML/1xAKyPaSUSH9/zhK4c+J0j1EuRiWhz+AEOhYknHHl
cw84zdVePJbHoSLq8yJUl6smoNF4TYU+6zuMF2pVXcCx1dvxW0Mji3gsh1yk4qh2
HxaejZPiBTU+ERHW+kKkF0hF0JuI4sNJ8UnwYwgL+DiTHB9/BQYlYokKAjdswAQQ
pKZpwgHHeENcf/rfu+ZG2MgYKbWlAChw3UHmkbXs/HiZYW5mzKvgz3dUYPrlmOLX
6w1dnT2nY0IcIve8RozBPXUZRW5Hg3QXdRoLQDl2gmBeb3+NVqM=
=aVzE
-----END PGP SIGNATURE-----

--jrqcg3cyap65nupq--

