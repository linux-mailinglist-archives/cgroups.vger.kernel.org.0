Return-Path: <cgroups+bounces-17530-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d1JwKGxpS2ruQwEAu9opvQ
	(envelope-from <cgroups+bounces-17530-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 10:38:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8711370E2F0
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 10:38:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b="L/gVO26i";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17530-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17530-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0784B303B08B
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 07:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE92E3E075C;
	Mon,  6 Jul 2026 07:59:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB039446D
	for <cgroups@vger.kernel.org>; Mon,  6 Jul 2026 07:59:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324779; cv=fail; b=hVLzVtIwO/CcUcCuwgf3IIaM3XPt85+fouMeGtbK0YZiJCBFNxYXzjpJeKQ4dfPQiOEXlDXLKwUeFyDp4uB1BzjLHxhQXeO0G8W/LshHRE+J4shQJE+8JNImz5qeioEkMpOD+fxkYydXAf95/UzpMUBlYYyPUgvC6AtD1vwVaZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324779; c=relaxed/simple;
	bh=ccAYnXJ2ckfSCKxv+gRKpXspMBSaqWvclXoIcIOo2K8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fSsZ0AVxpxOG8V8xgzjBS9gNHdePRcZd0GgY6PSU3X5fc0ubWagPOXUZD/HdJS+Pbd6Bp7tgFNtifbojikf0ZjZveb9ny7e4Y0JGx12kcexwBC6Ff/jjtNiD+7hGA9WVb5Cds5yBVsg1k8PEL5UX9UOmZKx2zZWdXqkt1iXwOpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L/gVO26i; arc=fail smtp.client-ip=52.101.56.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvfQo1B4JMPzJBBXiH5LT1hNBMf+1boFxeQ3/D95XuSww4kMSW+D0YGZfODHdAYO/B3qD/jFZ1JlAN6xuyy04UfTvomll7iD7Xo2ODnQienzAbXkruyiMzJjhKeSx1C+z/8dbAL9gI1wlGC8Anq+SEM8z+PPmKM/U9MY45ppK1wSL86QDvpiB0/QnyDVCNSoA8jfUAH8UzE2xVBnHH73xKuZ5jzVaVk+bZBy7VTFubkIPQTlzcuEYvLzE/tCnKlnNNPgaG8i0i2n2aq/Fwi/Ig1u3SDZ4PDfh14edXZddOflJsj10ysp1xRWMjSxO4lQnwewmNr0R9GXCkgxMiAc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKgeFL6wtBDI9olSob4A0EXwiQAlodE7buzu+DddE+Y=;
 b=nx3gev+kSnX4S3C4ub67ELXvGUFhnSpl0UzBMb4S0YNglBfkFASS8vWG+5/1FAApN0NAwBEkLM/LMP3cBOKniqHW4neCaItnS27rIpa9Oh9CE5UsLb6b+AHIMsrg343UWkcBzsAfpv3IcwrzPF04TQN7EPzcm2OTiPw2LHfGdQwOLfT/lrcxwqSHDkNDU8H0z6du6wXXfHXFB7T8Qrbquy+MIoju3lXrf/NjYUNMiIvmFQaAlQUfBOUsSbAw9BAmDXCOWLa1wHMui0WtgxQSrhTO6aSQ4OAMaEcQ/qd8zFWDuaYIlFejqo2WfLbH4wY8+gGpf/SzrPZdSodzonwUDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKgeFL6wtBDI9olSob4A0EXwiQAlodE7buzu+DddE+Y=;
 b=L/gVO26iAVG263Kt6vCxIJUy1TUNiuccHB+PyIRw0v0ouvhmxqa4J81FOFpd0wC3fnEnPVj+AKJ34fOIcjlBJaoQTq05gM5LL0vZMR0ZSB1skT35jNzvOdvN9FYeC+PFZXWItAEurYUm1mLlXqRDQcEzRLMpdYvrMrDKdEr0o90=
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 07:59:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 07:59:21 +0000
Message-ID: <a05e0695-8f00-4095-addb-5a5fbd9c54dd@amd.com>
Date: Mon, 6 Jul 2026 09:59:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: drm/ttm/memcg/lru: enable memcg tracking for ttm, xe and amdgpu
 driver (part 2).
To: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 tj@kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Cc: cgroups@vger.kernel.org,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Waiman Long <longman@redhat.com>, simona@ffwll.ch,
 intel-xe@lists.freedesktop.org
References: <20260706024122.853329-1-airlied@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260706024122.853329-1-airlied@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0038.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 995b6d2a-a16d-4fb6-232f-08dedb347ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	e6d0ShPBPqwncdgE+xznUnyzV4FkWBWsGW7ounv3kxtMwpLfG8ThiFJUsRX7nuqkmlykP2Dhntz62ZHBFnOE7mftfeLdnZydsiPgw6iNP1kg2vHbuLQZnAXN+imjIURf7A1m225GwYiyFF2el7Q0Bs5bH66U5s7swwTVAynvUm115qfywE5DGTCVyr2DbdVPEGks27KT/JqBjIpzdUd1jzHMYAfNdHEgh8gM/+L1ktPvrEIoRC1dABF8zJ8ys12k8vuFyn3NgQIzYS6caMzaBIM99ZS994Zw5wNnuSjMP6PKBifySYmGb9znvdib0LgKmS7ZhcQmm6APU7FjLAT6QCgs+GLmXRI5vcOzX0m6p/EDojuIgL263QjHylpoq6EzOzMq8OoUEqH7ncFzuXSWee50xl2Zdw+cB9iUpFdv7hoqQlAcFB2M3Ha4ok6ehQRtiGWg3xzthfX9XYW83WxJ0GpBXV8BLi6/a0446L/oYnWmn0ZDWtBcoNUrlJeEh0LjKhWzSE94zTgl9OruUg1DaDWIiM7Qq8gmH1pdNR7ithz2rmu1bAafmfNJCkaZsCt1HQZ6HkkxBCaguoW5exP1HpuYi7qu1w4jH+ioDu28j4OXwOgosFdtUOoyl75x1YtLnJbwTwAuNIyKO4b1m25qgjsJ6Td+rKMv2EveLe6QQu0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qy9oZmYyTjgrNGdrWGRRZlBQb2FNWFJFbnpVRDVNRHdJbytWV0FHemdjZjBB?=
 =?utf-8?B?UXhpVGdIQi9DcExIcU9ycTlMSXFTSFdlakowc1BLNkRjWHozT3NEcmNuNkY0?=
 =?utf-8?B?WG1HOUlFSUM2bW0vOGY2RWo2aThaMHJpOE5Vd2xPTjRyREJjRDRpbmlhVzF2?=
 =?utf-8?B?eFJoZHl4enhMUjdzWUs2NmxBdlZ6N3NnZlM2ekNGUkdlcUU1TUhXYUpxS2tK?=
 =?utf-8?B?VWpKOWQzWmFGUTZtUE5WMHFUMnFmR1B0TURIUSt5NzJ0eEdncTFjdTA5Q0pk?=
 =?utf-8?B?TkZxa1F6M3llSUpxRnh3d1dobW1IWDBOWWpVNE5rUndJSHY2bmZYK1kwMFdx?=
 =?utf-8?B?RXJKTjRJaXpGQXNObUlBWGdVblZuTGY5a1FUMktmSFM5b3hONStTK1dQczlE?=
 =?utf-8?B?Zk9LWFNHakJmSjRVTFcySEttZnBWa2lCbHcwRXVqQlBuMWx1NDBsQmwxWHVs?=
 =?utf-8?B?c0ZDbGdYZXA1LzFrYW0xcDYyZG1yMUlHejdFM0dWMldxdTBmMkE4U3V2Qk5r?=
 =?utf-8?B?MjhxRlhuQ0lvd3VpSXYxcDQ3Q0tSYzczM0Q1dC9XeXBuVjZIdlI0MmZGZXFU?=
 =?utf-8?B?bVFUcmhGeDczcERpc1hmT0Nla09lM2p0WlRSMkViRnMrelN5S1FORjhxME9Z?=
 =?utf-8?B?SWhZTkxwdnMyT1dnN295SVZrV3hNdDEwcG91VWYyRjRxdVBTOWVjNW1leHF1?=
 =?utf-8?B?WkQ3bjU1WVZZck5OY3VRT2hsc0hFS0F5ajZ6Y0JmRDcydXJscklYYW85aXYr?=
 =?utf-8?B?Rmlmb0pJbm56WDdxcmhqQ2Y1L25NTjUzeFREd2wvbHp6MWJPdGlIVm5PUlZI?=
 =?utf-8?B?dDdWSjNxRFl5TGlEeWxaNUpxeUFiU21FSzRhOWNNdk1pS2lmLzRoSlVGQTZK?=
 =?utf-8?B?dHVLMXkzZWdJYUhCSktKVXN0RDl2TFVzTmd1QXZidDFVOGNxYTJSN2dsVmlK?=
 =?utf-8?B?S052N0xBTlhaVDgyVGJ6dUl4RjhyaG1hQUhmdEYyTFVET0YvREl0THlCWVpS?=
 =?utf-8?B?d0ZqKytSMUh0cGQyTmdvOHZ5RUZCWVFKMzgyQ1Zyc25zaGxkU2dOWU5pMHZr?=
 =?utf-8?B?ZHpkVHVpaXNSaWJ3K1dYR2hxSjFoNHIzaVZqNStOeTFnVm1OSTZyUlY1djZq?=
 =?utf-8?B?d1JqbTA2aFZqSnlhRVdVS2c4N2M3NE56QWdjZnVMUWRrQUo1cHJSOUo1K2JO?=
 =?utf-8?B?bC8rRTJDRHpUdUVxTzRYbVNjVUxvRXJqUk40QjgxRitNc3o1bXZhbUZlUDNJ?=
 =?utf-8?B?ZXpBeC9ZMG9USWRFcmlrRWswQnp0U1RyMEkzNWdPSU9NeXZYYll0VzBja1Zz?=
 =?utf-8?B?eEJJWnVIMkNpdWRUbjZCVTB0WmdnRE4vbUhmelZHSFBiV1BhWHhBK0lRVnhj?=
 =?utf-8?B?QVM1SDFtWGtyQ2NpY2hKdG1BY1EveTl0NlpCb3NYKzhvak56bXhLNlFjVGM2?=
 =?utf-8?B?a3hWOGg2MCtvOUdGekRNdlA1SFVOaThDWmNmRjhhNUV3dW1xbUNmK3UvaThy?=
 =?utf-8?B?OHFHRnNNSWdaaGtUckpWaGJiTjh0M28rdnVDb0JrVVdONFdONzVPRzZMTHU0?=
 =?utf-8?B?ZUZhT2NRVm52bkc4bC96L2JKeW55MTl6cnV2U1ZsbDdBbE82RkVtcVo0eXpl?=
 =?utf-8?B?STFoS2h4UXR2Z3lCd1oreVFUNlFjY2Y0azEvQUhjeThYVmVpWHV5R1VSVG9l?=
 =?utf-8?B?L1RINVJaVXNWNlFsWEJ0MnB6T1NTTm9MbFZmdG1peUlRVFNkM1ZSZ2lrOHJx?=
 =?utf-8?B?aThXVi9ZMlc1dzZZRnk2WjlDZTNpQUpXeFB6cVU0dElPSDNvVjVuZ2F2Sm9r?=
 =?utf-8?B?czhNaWk4c3NUMUQ0TGZobU5uaU51aEVDOVRScXZzUmc5ZGs4ZVVXdnBnLzdQ?=
 =?utf-8?B?czY3VkZVUnd4NEhjVEhTSmh5bEhLS1BsWDJBQVFyM0NzbnU2VkRQSEFESlJj?=
 =?utf-8?B?L0lEQ2dsbkRpRVNNSFB6YTFiT0hHS1FCejVSRkJIK0JtMEpURzd1RHMrUUcw?=
 =?utf-8?B?UjltSWN2N2lhNlJDOEpyYytkM2xUOGFQbFdsRThleDkxelpTY1dESVQwY3I2?=
 =?utf-8?B?alFtcnEyZ094am8rWkRoaE9tSlRCMzBXaUpxQTU5VUpQZitCVDE2RDhEd0p6?=
 =?utf-8?B?WTJvUUswN25QOE5KQytYYTZsc1ZITHNLRzNMUHB1cG5FNmFoRy92MGI3aFF1?=
 =?utf-8?B?MnVSUkM2NzZTSlV0cllpYXNvWTQyYUxmamxOb2NBVUx5cy83TmRraXpHTEF3?=
 =?utf-8?B?NHovUnhmMnpiSzF3ZHpwT3NDUjBzeUMrdy9HMGJkeVQ1NDJ6SGVLdFJPNnhJ?=
 =?utf-8?B?NVZIajEzZVltb3RKOGZhdWUyWnhqVzc1V3JHRUlScXg0OXhJY3dTUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995b6d2a-a16d-4fb6-232f-08dedb347ce5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:59:21.5831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwpB2FMLGZUciElNlCjtTtOAfRgjI5GY+10asM2LzET6c8CW7x6TlUocRl0QMEz8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17530-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:airlied@gmail.com,m:dri-devel@lists.freedesktop.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:thomas.hellstrom@linux.intel.com,m:longman@redhat.com,m:simona@ffwll.ch,m:intel-xe@lists.freedesktop.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org,kernel.org,cmpxchg.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[christian.koenig@amd.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amd.com:from_mime,amd.com:dkim,amd.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8711370E2F0

On 7/6/26 04:36, Dave Airlie wrote:
> I committed the vmstat counters and list lru changes, and they are now in tree.
> 
> This is the remainder of this series. Intel have expressed interest in getting
> this landed for xe, we can drop the amdgpu changes for now if they can't get
> across the line.
> 
> I've dropped all previous acks/reviews.
> 
> This series adds the memcg counters for GPU active and GPU reclaim to align
> with the two global vmstats. It adds an accounting flag to TTM alloc/populate,
> and enables memcg tracking and shrinker support in TTM.
> 
> Then it adds amdgpu and xe support.
> 
> I think for this to land, Christian holds the main objection which I still fail
> to fully understand beyond it doesn't solve all the problems we ever have had
> with cgroups and drm, so we shouldn't even bother, and maybe we could do it at
> the object level, and integrated with dmem, and android cross process accounting,
> but I still feel this is a good baseline.
> 
> I think this is the right layer to hook this into TTM, where we allocate memory
> and I think accounting for this memory in a proper way should be done.

I think we pretty much agreed now to do this through dmem?

At least dmem got the ability to optionally account allocations towards memcg as well and as far as I see there is no real benefit any more to mess with this in the ttm_pool.

In general the pool seems to be the completely wrong layer to handle that for TTM. Background is that you can't reclaim individual pages anyway, you always need to reclaim full buffers and that is only possible on higher layers.

Regards,
Christian.

> 
> Intel folks (Thomas/Maarten) please review and express concerns as well.
> 
> Regards,
> Dave.
> 


