Return-Path: <cgroups+bounces-14524-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAdAJN3mpWlLHwAAu9opvQ
	(envelope-from <cgroups+bounces-14524-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 20:37:01 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A25C71DEDFA
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 20:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25977300C34A
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 19:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73D547D943;
	Mon,  2 Mar 2026 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YZdpEe71"
X-Original-To: cgroups@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0304F22A7E9
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 19:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480203; cv=fail; b=f0AGtyylAde4WPHyuKqu2f1J97EsmRPb9riYuhHAR1J/09hYJsyvI9d4Ou5EMXT9F1KrA3dKBSIEuswUqNFQvVCXLq0/qDtfhAcJLJKNeJUwRVsz317cbU9HxO4tPIoPHx7E9i1fPltD4tyR7nicg+8+gMh4g4TnMyWxH/NxJgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480203; c=relaxed/simple;
	bh=qC2Rd9Rr5E7trGE6oAuMMKBSwixQlkqHOxgAs4NtTBo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cwZ+N1M3dpD4+V8RoeNeP3RcMbAbssCXInPHSPwvc2S6S4xCF673VlkwPRIzS9zbZojO1snb33hL43e3hjEiuIJQTbcnX8lcu1SQsryBZQd8oSnb7OST7t4g92FEyp40jbEJQW52M83YCsi16V8ZDZLEDpa0Qo0KR2CsmLG8w9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YZdpEe71; arc=fail smtp.client-ip=52.101.52.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bz+EpX35PVULT7HqCFF/XXtdslFVXcS9RP9UeaOqfK8Az9VyJ+hIszgogHpdMufb7aravXuDTo6SRWMcwQuP85UZcqVo5D6QVSB16RQVqYd22RgsUJXnDUnGOw8Icc7lP8pIHjGrazgrpTFy5BcV4CRb/XvuTjfd35WZTyV3tcqOsl4u5rMrxoWnSZsj53RCQ03jigSFqeL/CrrXWV9+XdWZ2pCEH9DST6J+DiqExXZY51fzOSEOFylZboMRehEQU/+pJigEGkD9VU/HaRffDHILFuANlQRNVoQbbsXErknWmuLOGkXJgf9Dijdvyu1AsgR6B4U1mSF8Jq5ZxQqynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VqWLGx8TxDpasbh/khhlhPNBnrEi4S3NEGHp2jgz1k=;
 b=kXHiquqyesXiNDStmBx5/AlPjWwevYZxEzsb98zP3X8bX6R0adPETHJwPjTvDnT3ho3Gx0nc5ygmWMjNVwNju3PSomawwba6tW3qNDF13DrZZ8M+542uH1uH7UEKv9GvEvfNKcstXdMTpiG+URURjRz5zYMhr+gYnqO8yuIY3u0YKJ4Tj2bDzYeTsvnxAHEy7pY8SRkruZJNbfR4GrfcwFu4/ExxxCskescxGXxZO5FYZMZVTidWmKUX3IAltqQJ/uhKeP520Bbql0lnr/nsyatQCM63W27EBnHaK37A5n377jNLmw0e3itY9vWrelh97i1zDCqLObwTvLeJ4s7nYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VqWLGx8TxDpasbh/khhlhPNBnrEi4S3NEGHp2jgz1k=;
 b=YZdpEe71Q6+4C4wnWnROzRUrVNDb0dc0A5JGxO1RJx+1YPRLTf+oVAPTRSZ5bfKXUrWSPQIZgPvjzfSVoa+7JhqbpxOtYEx5b3SdPyYlhfKokfu0cLc2zoSmkhsiDdnCPeM+qmxtkITDcwhcXWTMFXYNKsWm6tYZuwrW3fw3pXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL4PR12MB9724.namprd12.prod.outlook.com (2603:10b6:208:4ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Mon, 2 Mar
 2026 19:36:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 19:36:37 +0000
Message-ID: <391bca8e-3685-49d5-8b30-93ab4eb1e84a@amd.com>
Date: Mon, 2 Mar 2026 20:36:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] memcg: add support for GPU page counters. (v4)
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 tj@kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, Waiman Long <longman@redhat.com>,
 simona@ffwll.ch, tjmercier@google.com
References: <20260224020854.791201-1-airlied@gmail.com>
 <20260224020854.791201-8-airlied@gmail.com>
 <ee914ffb-5c3d-4d41-abdb-5ed02db326c6@amd.com>
 <CAPM=9txUuS-qzA+gX2DvTuYR2OZ79RG86FuDA6czkpuJ_SR6KQ@mail.gmail.com>
 <4fddf319-50c4-40ab-9e36-04d629a8855e@amd.com> <aaWZrTZGsxxjbBYv@linux.dev>
 <8efef755-e429-4cec-bef4-b15b3f9f4632@amd.com> <aaWuoe_CQwbtcxEY@linux.dev>
 <63dccd9c-f2e5-421e-ac3a-a7c13cec9121@amd.com> <aaXEDLpXLROBO7To@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aaXEDLpXLROBO7To@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL4PR12MB9724:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b229558-369e-49b0-1a3a-08de789304bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|3122999024;
X-Microsoft-Antispam-Message-Info:
	Rd7S8OAnYXcTAAafF/GS5ZNZfMWl7C4FLDTZPXXzlNCd/846Curb/ycSaDWGTpiRXztHoadosBat216MuqaOn+FqDjGvNSL2iHu132A3lZVtto4n0mQqm47/A9tNbDGJHXEPlsciyOTbBvLMixulY1uaDtqUBLCYv6T+pyr6PQ/chjoYiSLyDCEkvqfSnOSbKUx8YPRmIqgOakZmPwfOUqHOZCgh8t6bZwoyNQ1YQCTxQCZ1BGB+waXkRBDYBupsxzsLAodTYoEICph5r/yipK9XJkA6Hd+4UB2rCRlsCJcFaMECo+0zF42VnpNDNz5hNAEMYJA2x7M+Ry1mlXnbdUgs0FIB/nEmNL3oDqcREoICb8e9YXUVDahBy5DUJvs2qS/vTbUVDaF5qvEWu3/7IiWgZ+5A0NJavvz3s9E9xTbr7WIfavbFLq0cOGTa8XX6g+nw4cdmETwrc3MaWAiZpKRUXsds0hMaasXsg8gO89n2Iei/4v67USL6RAWGmeip+p8uGylyCSZuIUsvdveIFzBqh/P8f94uLO3Radd3eXaAt6HocFrt2nAcbC5DCKO9iaE7kmw1J/tQvcqzTbVk7yU0d8JMYOrgy+jPrBP6VMreX1WEHcm+Y8DnXzLrKM4cSaER+huk3Po3yXFyFANAgG/rqUCUZyB6+8yRmNjhlTG9oFYgg0CkdSqm2EL/7DFysXnz0F6dHiQNv8K4OX67CZZaGHtBui9MQE5cuoDCasw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(3122999024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUwwK1lUVmRwb21yRWxqNDZkSkovTG9EcmcwZGh1L3l1WDZEZjAva0ZVQ05u?=
 =?utf-8?B?eXlqR0x6Tnh4cUdQY0dzYUNRdERjSVhHdmNWV2NPMUhFRjdySUJOc3hJNDg5?=
 =?utf-8?B?STcxUFFzVldkQzRsYXpJS1hIWnd3aTFCeUxrbk1rYWlDUzZUWXE2MER2YXpn?=
 =?utf-8?B?N1dKcVlha3ZreTdZQWp4d3FRSytKbERISGp0ZXZlTzhDVTc5YmV5VW9ONTBI?=
 =?utf-8?B?ZFVrT0JzL01vWWd1R1NWRW90UVhpa3VydlJmYXk5ejRlRmN4dVQ1MWNwdGhH?=
 =?utf-8?B?TmZFdG1Pd1JXNk9ITjFaMk5LTmtQVHpmUE8xdXBlR1Q4ZlBCL3Frb0I5K3Js?=
 =?utf-8?B?aCtiWndBM05ZMmQxN04yKzNwa1d1TTlQQWIwSTgyN2ZtNDBTRWUvTmlCZnpP?=
 =?utf-8?B?b0pWeHlrTGpLQmkvZzBSaXJXRmpQWnFvZkJFb0x6MnUxWDRVNWY5MzdYVi94?=
 =?utf-8?B?TGNOOU9iNDI1S3B3UVIzckFLMExLTnRpR2FjWjdtM05BcVExYmxRYmhjMDc4?=
 =?utf-8?B?WVRuYm04TnlmbUYyZ1dRYXZZc28vUHJSWXpxV0FpbkppM3B3RTFpMTVsa1ZH?=
 =?utf-8?B?TTk5a2M0bGtWSmw0eEczTkxMNXVQem9QVzBHS1ZhWG1yTktncmYxaXRWQkRi?=
 =?utf-8?B?Z2VPOUpESi9mdCtHTVlSK3c5ZHlTNjdReVVoWjR1VTVMOU9DWXlaTlRSN0hk?=
 =?utf-8?B?M1AyRzliREwwT2NEZTAzRHdqRkdMYkVabkxJQStGZkN0bjAxck5RYVRrZExX?=
 =?utf-8?B?QWZaeWpocWFGTnJ1YVFaaWhtOFU5anhvdCtOYWxNNUlubjA4QUs5Z3duRlE4?=
 =?utf-8?B?cmkwTXlyT0hDdklGUFFIKzdubXlLd1czZFZybjFMZER6dS9HelZoRndqcG9s?=
 =?utf-8?B?L1lPSEVFREY3a09pRjdoaWl5NG94RVBjVUloaFJTOXZWZUZaRUpFRFpuSUNh?=
 =?utf-8?B?bnBsS0JtaVU4OUxCQ3dhbThoalBEdXNmTUpMSmUxUWlpamtwZUh2ZDJnMlRx?=
 =?utf-8?B?TXErZmE5LzFGZTVEZXJacDJ6aWhLbDNSUUNvR1crTXJ2bWlKUFluUHViWTZX?=
 =?utf-8?B?R0szdWZuMk9rSmRjVHhqbER2dG92VTZ6eTFpRzRWOHJGYjFaZ2RKNUljcDZn?=
 =?utf-8?B?bFNYQjZSaVMvL1BadkFxSkZoSkExRHA5N0pzSDEydTVWQ1VDTzBPRm83V0Y1?=
 =?utf-8?B?ODFsWWM5dzFmRFhvbC96YzBPa3ZDTlBpM0RqZU1BVmpMMGRLUGNhMVRLYS92?=
 =?utf-8?B?TUYxUmYzYkg2Y0I2OXdJZFBobjcxdXNGVENYS2RSSGdUTW0zZFNyaWpjOHpt?=
 =?utf-8?B?WXFEczkwbitBaVRqdGtZZGQyZWVsdGdMai9KRUhmcHVnb3hlR29idmd5Rmhz?=
 =?utf-8?B?S2ZOdmVMUURtQ1RFd3Vpb0xkcVRUMEZJallwTDdPaEdJcUNpdC9zRlk5cHVS?=
 =?utf-8?B?cVk1ME0xWXNzOFBUaHZYZkdJNHVBdHBSQnRFWXpLSStDRXNyS05keG1JcnZG?=
 =?utf-8?B?dlluenA4a1dUZmQ5WTJxWGFYb09vWkQzSW9FclRuQ0ZTemNubkh5R0FxLzJu?=
 =?utf-8?B?dDJHUlBmdzZySzNlakhQcTdIaUNmSGhsS09WbmpVUnNKTWk4UDlmTXRyWDhK?=
 =?utf-8?B?S2dZU3ozZnFiZEVxWmtXcDlLL2k0MVVLN3hTSHpjZG9vTm8ySWNXWk91N2ZB?=
 =?utf-8?B?QkxiT1NyV3FKN2lCZmdyank4eWl4S3hid2Y4SUF4R3NMTEM3Y2lFSDNVK1NE?=
 =?utf-8?B?WnhBZ2h4Y3duTnJDQzZBL0llejMzTE0xUzFCM0tCelBhLzdVNkdXMDFuYzhD?=
 =?utf-8?B?ajg3NjhaMU13M3hyaHJhSkVrV2haVHN3bldaL3NPWVNDNWUzdU0yVllKUnRu?=
 =?utf-8?B?UndjSFFRYnYycXNuY1V3c0RaZUdzcFJuM2dVTkEyQVdXYkVCQ1A4S3FNOVJO?=
 =?utf-8?B?ODVrbUxiYk9selpFRmhvTmd2ZzM4alBSRmxDS0NYL3pWak43NGU5SXZOdGdD?=
 =?utf-8?B?eWFwQU42R3JMSEl1QkpQNFVOc0R1KzlkYnppSGU5UEw1TFgxa2V0ZlRMWkN6?=
 =?utf-8?B?ZEJJcExZcXBKUE1MRlJ0OU9hbnU5R1Rpb2xxVmhtUHRLRXMvOVF0Ymo5Q0FI?=
 =?utf-8?B?Z3RCWWJ6bnJrTVBPc2FEVEJLZnRxbjhmNmpodXpuRHBtQXNHQzg3T1d1Vm9B?=
 =?utf-8?B?bFFIOFRsclFvZW5zaEM3V3FwSEYzQVJvOWFHSHV3VzNXdlRHSFVxbzNiQVNT?=
 =?utf-8?B?dUt1bEl3ZGFVd0VjN3ZEVGh2TXNkaUFEaTdwQllKVjRDeGNnVXhyVGpIMk1z?=
 =?utf-8?Q?0frtQu1P4VpzLsQ9tH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b229558-369e-49b0-1a3a-08de789304bd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 19:36:37.0563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJHWQV4S6iaFQvLIYmN51TAAYMwsAnvHxjoJUzujErCpME+Qb3UbEnU7WPIT9U+7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9724
X-Rspamd-Queue-Id: A25C71DEDFA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-14524-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.freedesktop.org,kernel.org,cmpxchg.org,linux.dev,vger.kernel.org,fromorbit.com,redhat.com,ffwll.ch,google.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:dkim,amd.com:mid,android.com:url]
X-Rspamd-Action: no action

On 3/2/26 18:16, Shakeel Butt wrote:
> On Mon, Mar 02, 2026 at 04:51:12PM +0100, Christian König wrote:
>> On 3/2/26 16:40, Shakeel Butt wrote:
>>> +TJ
>>>
>>> On Mon, Mar 02, 2026 at 03:37:37PM +0100, Christian König wrote:
>>>> On 3/2/26 15:15, Shakeel Butt wrote:
>>>>> On Wed, Feb 25, 2026 at 10:09:55AM +0100, Christian König wrote:
>>>>>> On 2/24/26 20:28, Dave Airlie wrote:
>>>>> [...]
>>>>>>
>>>>>>> This has been a pain in the ass for desktop for years, and I'd like to
>>>>>>> fix it, the HPC use case if purely a driver for me doing the work.
>>>>>>
>>>>>> Wait a second. How does accounting to cgroups help with that in any way?
>>>>>>
>>>>>> The last time I looked into this problem the OOM killer worked based on the per task_struct stats which couldn't be influenced this way.
>>>>>>
>>>>>
>>>>> It depends on the context of the oom-killer. If the oom-killer is triggered due
>>>>> to memcg limits then only the processes in the scope of the memcg will be
>>>>> targetted by the oom-killer. With the specific setting, the oom-killer can kill
>>>>> all the processes in the target memcg.
>>>>>
>>>>> However nowadays the userspace oom-killer is preferred over the kernel
>>>>> oom-killer due to flexibility and configurability. Userspace oom-killers like
>>>>> systmd-oomd, Android's LMKD or fb-oomd are being used in containerized
>>>>> environments. Such oom-killers looks at memcg stats and hiding something
>>>>> something from memcg i.e. not charging to memcg will hide such usage from these
>>>>> oom-killers.
>>>>
>>>> Well exactly that's the problem. Android's oom killer is *not* using memcg exactly because of this inflexibility.
>>>
>>> Are you sure Android's oom killer is not using memcg? From what I see in the
>>> documentation [1], it requires memcg.
>>
>> My bad, I should have been wording that better.
>>
>> The Android OOM killer is not using memcg for tracking GPU memory allocations, because memcg doesn't have proper support for tracking shared buffers.
> 
> Yes indeed memcg is bad with buffers shared between memcgs (shmem, shared
> filesystems).

My big concern is that we create uAPI which we then (again) find 6 month later as blocker to further development and have to stick with it.

That has happened before and that we could remove the initial DMA-buf sysfs uAPI (for example) was just because Greg and T.J. agreed that the interface is not something we can carry on into the future.

>>
>> In other words GPU memory allocations are shared by design and it is the norm that the process which is using it is not the process which has allocated it.
> 
> Here the GPU memory can be system memory or the actual memory on GPU, right?

For embedded, mobile GPUs (Android) or APUs (modern laptops) it is system memory.

For dGPUs on desktop environments it is mostly device memory on GPUs, but system memory is used as swap.

In HPC, cloud computing and automotive use cases you have a mixture of both system memory and device memory.

> I think I discussed with TJ on the possibility of moving the allocations in the
> context of process using through custom fault handler in GPU drivers. I don't
> remember the conclusion but I am assuming that is not possible.

Most HW still uses pre-allocated memory and can't do things like fault on demand. That's why we allocate everything at once on creation or at most on first use.

But allocate on first use has the big potential for security problems. E.g. imagine you create a 1GiB buffer and send it to your display server as window content, the display server would be charged because it is the first one touching it but you keep the memory as reference for yourself.

For Android the only way out which has similar functionality as the BPF approach is to change charging when the file descriptors used as reference for the memory is transferred between processes.

For some automotive use cases it is even worse. To fully handle that use case multiple different cgroups in the same process would be needed, e.g. different cgroups for different threads and/or client handles in the same QEMU process.

Long story short: It is a mess.

>>
>> What we would need (as a start) to handle all of this with memcg would be to accounted the resources to the process which referenced it and not the one which allocated it.
> 
> Irrespective of memcg charging decision, one of my request would be to at least
> have global counters for the GPU memory which this series is adding. That would
> be very similar to NR_KERNEL_FILE_PAGES where we explicit opt-out of memcg
> charging but keep the global counter, so the admin can identify the reasons
> behind high unaccounted memory on the system.

Sounds reasonable to me. I will try to give this set another review round.

Regards,
Christian.

> 
>>
>> I can give a full list of requirements which would be needed by cgroups to cover all the different use cases, but it basically means tons of extra complexity.
>>
>> Regards,
>> Christian.
>>
>>>
>>> [1] https://source.android.com/docs/core/perf/lmkd
>>>
>>>>
>>>> See the multiple iterations we already had on that topic. Even including reverting already upstream uAPI.
>>>>
>>>> The latest incarnation is that BPF is used for this task on Android.
>>>>
>>>> Regards,
>>>> Christian.
>>


