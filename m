Return-Path: <cgroups+bounces-15740-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEeeALK5AWpGjAEAu9opvQ
	(envelope-from <cgroups+bounces-15740-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 13:12:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 936FC50C8A0
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 13:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A69DB306A9B7
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9979E365A19;
	Mon, 11 May 2026 11:08:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021105.outbound.protection.outlook.com [52.101.95.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F367A3630A9;
	Mon, 11 May 2026 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497735; cv=fail; b=ovtQemJQXyiNeftofEKOXj3ReJlYd/0nvHBdUD0i/OB80+IgQwIlxPaCgfZyc1mjY/tRLAk2mgW3/jr/itpwIGkvWDJZmpxeVG970G/FtGxfMeRwhxkE9Ai8ySd9Zw9fgPinxKm7afo74KeyTHBgxXWlYnlPV6ZuAazHlydqq6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497735; c=relaxed/simple;
	bh=mXBacL2oEggFrNHuEUSCEndhkqPPWvGDzHk0v0lmO6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rcvloaLwTQD2/BgXHEuofPcD8o6rNp8xYmpYSNWqefd6uXuQqFCkQW/mtNVisyCdQewvW9EKPBA+klTXK4DpQBoIPH20ifTvyTxDVGh+YzaDc6XVn/V/0Uu2CqXPaxAwtmIsZp1qQXZoudSSWj2tmaHV8/GjBS357kcfQn0TtY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGmSGrM6PgITfIcUAkBmJYvZBNjS+HR42Nmh1lwVh1sQFhUA8rplBcKpx/cVsNA8jB8UYvicHxTtidjirR+k1lnAMJHEBtP9VkhTiBxM5rVNXFpvSLMnqu5uME+RP2+i2jXreuPw4CkV6qZmJ41+SBZNl+gEYsHIeB50QgWSZ1rceSpIhxQBO3xkbLcwfmp0VmgUHujwSinfoQp7XNQCLAeiDsuEoRCKz/xN5cTdDjTpGOnofhmrKNSyoRx56BToXuOcyqz+zuqSFfyIkE+TdCx4xDfijioJcQvi5hf9VP4u7bxTnM2Sve+RgwyoQiTv0l4ToVfz5XIAzbvw2LJGsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXBacL2oEggFrNHuEUSCEndhkqPPWvGDzHk0v0lmO6w=;
 b=iw6Ys615R7YE9El9u5Gu/2AAsOdCEOyD2JXiOiUCC0Oep4tgzQhq71kmKU2hs6Z3HaIPpg50YRLFTS4QTw+Wx8d+4XuXeoadirNEl4A166RYi6rGRZd/0MlzVtgkD2wyEohpQiHak19nC7KS9IhdGPWvPMKEMRwZQ+Qdc0aL1UClS6yzjSAYKFasRav9QN7K7FEiXP0Dzec2KM+exnTLFZtT7Mmm4Iwx3UOgqdPe/kWO0hbp+m+eHQbqNGHw+le3rAL0hcss3KaPhytOhOqZrHWKNmC52KSWVz4kcmDHk6Ne9f//pHkDnclrYUlNO5WfZ5yGIDvKXJVEKMnizS4maQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO7P123MB7647.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:411::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 11:08:50 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Mon, 11 May 2026
 11:08:49 +0000
Date: Mon, 11 May 2026 07:08:45 -0400
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
Message-ID: <aihz6zlfmcaxwb3ef4luisfpwqibwsajpphy5vzuksy3ftfkms@whhv2ax5plpb>
References: <20260509164847.939294-1-atomlin@atomlin.com>
 <20260509164847.939294-2-atomlin@atomlin.com>
 <8aaa7dd9-2426-475c-af64-85ef5f2aa855@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="34mfdjxs7nhcxtld"
Content-Disposition: inline
In-Reply-To: <8aaa7dd9-2426-475c-af64-85ef5f2aa855@redhat.com>
X-ClientProxiedBy: BL1P223CA0033.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::8) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO7P123MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f18010-87f7-42a6-44ab-08deaf4dada2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|13003099007|3023799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	AlcqtfPgtZUAVDnEkc/91P3vzIKDLRoL1N/Oveyi3hklcNvgQhTJjRs+rEMSI2JvPDmyz/wNlgFAY+qLoyDEAhb8MvS26wqxT/VfwbzZhSNxVOLellJddgtNj2UaBDgsDQmbsEm2d95UjjVBqA1M+cpoCZ+GsqYcIxvnqGD5KWympSIFBOzYVqu09YBIUkzJXjucUNKkBuPY2/04vYW6J3YwfSHMbCztfSn5/q6gRChGrmgxMsrpLzqo7XInb0iG6+lRa3HvI2RnmOOoz5UXqlQbJOb4gcDQbK4gZbU93Ti6IsALLXpV8kX9JeHEIcWofQVbf640pKsjBoY4tmXyjN87bGm3ER1XFdtR17BVenbJlaJk7cs9N6bQGB0GwrDDW+qOlRlFK1NBNsMMTMYTZTzhMLIcAOCdymbQexlpJMlNT9km+Jv5YaPKH6bkq6RQ854OCNhZNtbePrp6EencTHV4Jc0i+9Wsho/I30aNgGjSooIA92ew9j2PumWA3CLCIYuJWogXiy2HSYZNlJc6YeViiAhPu+alm+YQZYfpB61lhNezIexiTXOIRnwXtwmxmiKnc99LE6ykj3cORH8D7UVRZPCocYJovC0EQNocOCl6doPJGFVp7fYw704Ofi+E3qQ76+jNEb+mI9+Mj1vf3/Ui1Nh1w7CJlldtnHipebCZ7MWn099C2aqNmyobY5OB1BPqMXK1aYh91ERBdDcQjQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(13003099007)(3023799003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVc5cHplUU40aTNLNW1hSnlxanV1RlQydGN4TW8wRmJrMUZ5eDZPUzVyZmZx?=
 =?utf-8?B?RU53ZDFGRk1ieG1hYUVCYVVUcFR3MVNJdTRjUzh0WG5BajBPenN5Y3hvUTkr?=
 =?utf-8?B?Um9id29QaFNlaGtSZzM1U3BBK0FNR21SQUdYTFl1ejZYQ3FwSFh6WktRY1Ft?=
 =?utf-8?B?MVVtS3YvT21EVmVQNThYbWpmU1kvOWxtWGNtalNVZzBkTExqOVJIdlBmK3Ri?=
 =?utf-8?B?VDJhWXlyQkxRbml5N3BJRDZ1WFR6bGJiZHJTcjQ0NjRQMk5kUDIwQjV5TEFR?=
 =?utf-8?B?WUladHRLWVMrN29tTVlESTZkRy8ydS8rdjZ3QjYvNUZrczd0VVlNVUtzUG1L?=
 =?utf-8?B?RHRQL0kxY0d6aFJiNkhYY05UeDkwK3ZvNVBRZ2lxZDBXSVBaRWV6dTViMWYw?=
 =?utf-8?B?d1RZakg2ak1vMEM4TVhiYUE2RFJ3SGVielR5UVZsR25NeHpVWGU1bFcwRlJR?=
 =?utf-8?B?djlaMXNDMlNmRmxHTzNJdkYwTHVYWEtOdllpSVlUWHFVSzJLM3M0R0xsdnUw?=
 =?utf-8?B?aHVBcWxXbTNySkw0MENSRXBleEZXb3VQWEdzUjJpemh4NWRqUmtIbXo2dzRn?=
 =?utf-8?B?TDBmUnl0Ri9ZQUV0dUUrakEyajFRcmtaNmNrdXROcHdLWmpTR1NxUHdtYjUw?=
 =?utf-8?B?WkJjNjRDS2dES201QTlpblFiREpUSjBTc0NvS09FeTVDem0xQ1dtTG9HV2NY?=
 =?utf-8?B?RkJ0cGhXNTVqK2FsejB3RHdvUkJNL2hTK3h5NEFNVWFNUTIzeE1KS21oNDFw?=
 =?utf-8?B?d21ncUtWYlgwM1E5RXIvSW1iTSsxRHlZdWlicEc0NDFrNVNYZVZKeGsrVXpF?=
 =?utf-8?B?Sm5JWmo4UFIvZDVNbWZrdjVxQy9rd2tPU3JwbkxUQklOb0xEMGQ5VE5BQ0xZ?=
 =?utf-8?B?QWdNRWtiekJPcGRrdzNtZjNtR0N4bUVnR0JGcGVjN29jL0ZxbnZwVVBXWmpD?=
 =?utf-8?B?OHdSNzdIZzR5NGQyME8yWmpOS2ZDRWJWWXZPWG5uYTNRUG9PenpwVVBETVBS?=
 =?utf-8?B?WHM1WFZ5RWxZTU8zRlBLcmcxem1rRUorRlNLRkV3V3U4R3NCNVpWYlpXMSsr?=
 =?utf-8?B?Y0MwSmJEVlF6a1JBdVNFbjFURmlVQ2xkUE5rU3JVRVFiZjAxbGFFVGRWb1Bs?=
 =?utf-8?B?dmFSVDZCY0Ixc2RnTmI1TnVtTlA1ZnZ4VFRTUHo2R1h1ZERuU0l0bmVvRmx2?=
 =?utf-8?B?R296ZjNNbFppRDlSaTNwSFR1S3dQbkdRdjRQSlVhc0NIL05WMmdnNWJKQThU?=
 =?utf-8?B?MXpPa1FKcEcwSCs3WUplcytOYjlDdVh1TmtBVFdYRTVZd0RvTk9jL01xTTlO?=
 =?utf-8?B?Vy9oeXZWYTVuZG1IN1VXN1QwWVVReXN3QkR4MDFSM0IwNmNvN1g3bEZ6bWdp?=
 =?utf-8?B?VHJZMy96Mkp2VWZ2bGdmMkp5UFJVNEs3TXlOSkNTdTQvZy9JU1IvNGtzaWht?=
 =?utf-8?B?djMvR0tLUmVCUzk0cm9PUlhudGlZSVZaN3Q3dVZQQVRmb1ZkNlQrQTlVUGY1?=
 =?utf-8?B?enB0NWF3VzlKOVN2d0RscG1nZTJNa0Vvc3NqaXM3bE9TQ1Q2MjZVeXA1RHRB?=
 =?utf-8?B?UnYxamlORmZJd3dUTFJ5QlM5aDNodUF2M08vbHZGVkkxczh6T1d3c1Robmtx?=
 =?utf-8?B?dkRsWGk5R0dYN0pibWRibVlHT2VEbkkraHlmYW9QcC85bElFNVlqamxIUzQz?=
 =?utf-8?B?VlRvTzdseEtHL3NUc29KTkgwY0V1eHpGWFlidjV4akpKNTBYdE9nbVZsS2ht?=
 =?utf-8?B?UTk4dnJpdWxUM01GOG0zS1VJRDUwMUNGSnlabEI3SXRhMjh3ZEFDV1hEdXVj?=
 =?utf-8?B?eVFWdk9zaXJNTHE4RGNwN3FtZXBhbXduZ1Rjb0c1a0pQKzYvSnhjR2tZZ2hR?=
 =?utf-8?B?NlJhdFRBbkNWby9PSUtzVHZjUWtnZ0NQK2VGYk9pV2lyM2JwRDdlT0xxMWFz?=
 =?utf-8?B?Y1hZNDVvTzNNa2E2RlVMamRobUlpTHZVaGhXaXF4MTUvTFJqR0dSZ3lnYkUz?=
 =?utf-8?B?Ym8zRHVrYVFET3VmT204K3puTmNMZUtNS3dXZlZtMldkZHdLMkJDK3VHTi82?=
 =?utf-8?B?aXF6VEZJTGtpNXJkbzdyMjZzUHlIK1dQWWhGb3U0SDd1aTZrZjBlN3gvby9r?=
 =?utf-8?B?Q1p1aE1DSUl0QjJZamhuSHRlMlNkSjdGN2pLU0FYRnc3QU5tRkFhaFBkcjU0?=
 =?utf-8?B?T3RFQTZXbHdhekNnWGxyc3Bwbm12L1dLMk5pZ0FFczI1WDlWLytlcThOQjB3?=
 =?utf-8?B?Zjdydkd3V1djaHJYTDgxTUVickV4ZU0yY0NIWHJnbk92R2xvd0k0UERySVVx?=
 =?utf-8?B?anZCYWRXaHVueTg5VjB3K2ZqbXRxSis1VVZsenlyNkNKcm9NZXBYdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f18010-87f7-42a6-44ab-08deaf4dada2
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 11:08:49.8036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVqJ3ajHA/79KQJUj9AgQO0wYpi9H+afQh5/R+nKV3l8TYaEoFuksVfN8nNRceTf9pWLQvKiNJZX+hrGOm1lrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P123MB7647
X-Rspamd-Queue-Id: 936FC50C8A0
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
	TAGGED_FROM(0.00)[bounces-15740-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.922];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

--34mfdjxs7nhcxtld
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] cgroup/cpuset: Fix deadline bandwidth leak in
 cpuset_can_attach()
MIME-Version: 1.0

On Mon, May 11, 2026 at 01:10:02AM -0400, Waiman Long wrote:
>=20
> On 5/9/26 12:48 PM, Aaron Tomlin wrote:
> > During a cgroup migration, cpuset_can_attach() iterates over the
> > provided taskset. If a task within the batch is a deadline (DL) task,
> > the destination cpuset's DL metrics (i.e., nr_migrate_dl_tasks and
> > sum_migrate_dl_bw) are appropriately incremented.
> >=20
> > However, if a subsequent task in the same migration batch fails the
> > task_can_attach() check, the loop aborts and jumps directly to
> > out_unlock. Consequently, any DL metrics accumulated from previously
> > processed tasks in the batch remain permanently inflated in the
> > destination cpuset. Because the migration is subsequently aborted by the
> > cgroup core, cpuset_cancel_attach() is never invoked to unwind these
> > specific increments.
> >=20
> > This behaviour results in a permanent leak of deadline bandwidth, which
> > incorrectly restricts the admission control capacity of the destination
> > cpuset.
> >=20
> > To resolve this, introduce an out_unlock_reset failure path that
> > conditionally invokes reset_migrate_dl_data(). This guarantees that if a
> > batch migration is aborted for any reason, the pending DL metrics are
> > safely reset before returning the error.
> >=20
> > Fixes: 0a67b847e1f06 ("cpuset: Allow setscheduler regardless of manipul=
ated task")
>=20
> That is not the commit that introduced the bug. Anyway, there is already
> another patch sent recently to fix this bug. See
>=20
> https://lore.kernel.org/lkml/20260509102031.97608-2-zhangguopeng@kylinos.=
cn/
>=20
Hi Waiman,

Thank you for the follow up.

Acknowledged. I will drop this patch in the next iteration due to [1].

Please note, the sashiko AI Review bot reported: cpuset_can_attach()
incorrectly assumes all migrating tasks originate from the same source
cpuset. At first glance, this feedback is valid. I plan to submit a patch,
if no solution was already proposed.

[1]: https://lore.kernel.org/lkml/20260509102031.97608-2-zhangguopeng@kylin=
os.cn/

Kind regards,
--=20
Aaron Tomlin

--34mfdjxs7nhcxtld
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmoBuL0ACgkQ4t6WWBnM
d9bsww//Xwh+Wwf6l9x/WxaqjQG+15NRi711h1Q2u+jCojNhOzmupUhEngRTlL50
mJ8UXgEFkIicGL9POYhvUVzRcv+xa3/vRqG7O26Ruxk4Xtv+7iNf7B3ye6OZ0eKd
HvKkaPxkhok4B2xIa3Vycx/lepgwTKqZ3ChHS7h/b0Z1aalK7TifwipOqmUdqYLk
z8CYfQwwaKo3lMY2EE+iiwWui+i3ImJ3nH1PFLPoeYMEsWs3g7Yi+WJYaDtI5vbN
bKbMKvb1tH7DpGNmxtyKWVKM4EBSxpUmqa5vDeZO+mXD0gLK/y8Zq5FPwNrGlEqZ
glRvYu3xhF2tgtYYP2CvHDdHR8zZONkihkgx7/6gEWBBY5iH920MD9lz2wzvA8N0
buDBQHpVphCsGeKAbIpRsK/ZVRam5q2X93pLYZOvLZq52Mh7Do+l2rZjZoIcWnaa
Hs0823Jb/Ls+zT6Hf3FRPNlWKkeBSvqPjXPKvXFIkPGQpG+ZEYoybhAY94tErf5o
3ficumJeXB4+TA+A1HHuKfxDFoGwdk0D8AcbPMwUKrMVQEQzeGwXyzEdAOYWcAsv
TyodxBXm4iqHElbsLogZQ7VkGI3LlOxxzvmpv8jpGVDUR5LQA3oaoBOGSk+3uCA/
PYJNO4je5KCys/K2EYObAy84d4riVFIJZ8JFSSJaYMTAGr5DMmA=
=gQ4g
-----END PGP SIGNATURE-----

--34mfdjxs7nhcxtld--

