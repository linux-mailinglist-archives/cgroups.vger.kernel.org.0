Return-Path: <cgroups+bounces-14508-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMeAHdGgpWmyCwAAu9opvQ
	(envelope-from <cgroups+bounces-14508-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 15:38:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5A11DAFE3
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 15:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FEB83006145
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 14:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0D93FFAC3;
	Mon,  2 Mar 2026 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jHMJY6N8"
X-Original-To: cgroups@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F138F654
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462269; cv=fail; b=hk+Sa5eAnY2tBtV8u7wqWVy1y2iG8Nv0gw71kG4Af/NP2HOBPDkDILTcp+eL64CI698Z9ov3ee4Wc7a3KP2BvD0LjJJ4Lm2VTG9Jkob/U0we4n2W17tB5v/uaaY6iPVNr+pQClYRRGLb7TIUHL6Ut+HtAlcBrcVdjyAI/RbZcSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462269; c=relaxed/simple;
	bh=zDKZr2FTRxfwV43U5/RmzLqzwjYMd517zoj61mKQX4Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=My1HDHUIaoYlLrzuvqK3TPmOLQOzLjMMxDNv1/GDFhnhGKUfFNygsQA3sAaYy/wgpEVYVBT16+57IowNxHNS4Djr489HAgJjow9pk4HXgvu+/OiYcbjLJGzKbU1q/QaGLL6fkV2lBEmdIez6ZZYRxCADnVffyFZZpNkbJI0BeTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jHMJY6N8; arc=fail smtp.client-ip=52.101.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3JXCu273BJVP43rCRurn2W6wQlCJpmY+Ks+hT8EuvGMznAC5/dX8lq2ZmF0M1oPTi3pHGvQvNTdyRnF1mMD9QXaqxvxKCKIeIohqFsrBuQo94x4iNPqtg4vpEFU1jSbsdcYJda0ssUoP0uzuCbwjD3yBHrnGr7Q9wiGSSaBRDBYuuKOf3HnrvIgNSvKE0VkflCDjYwhfTz4MHVEblAxBvPflXtjyOK1lFOM3li/mPe+rU9YgVzaa6+BsfqlArcsKlU7akrZpFD2CQrfpe7YMz4iKAvIuWA/G7NVG8ewrbSSXjIzTqpWP5X/gnW2PM1VrO8QKL05CTeTWY5mkDPCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hM7AjwuRFlOv8ElN44MGYlm4I0pOLBZ9a3hrQlUaDdg=;
 b=D6dPY4QZtoRucpSUCT6VOsym69kKGJBrxVbQ9JMx/5zN/WHPfHa14bwxiJJeqkYJEPVEn65Xy9nQvqsOLbDqpn7Ne7/X2ZO3F++gTPLHk6+saz1YvnfmLLGMZtOAfsC67Uxgs4F74KhrzVB6oahulACAxSHCXv39UBeZnUQagc6e1B3gt2/QMyjI6OuIKDXTcQ7l+hY77fhmVc0p3SvLlJjirxA25wUygTkWb0y7F4PfPwu426WVBUMiHPp/r7rQ13dzGi+LGDO/Ce5NN2kqSfpqqO+UJ6WwUQ3AdyRtS3tYMAHQHiq5gMZKmOIyOSMu+72J9ML55oYd+HfegC4Jig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hM7AjwuRFlOv8ElN44MGYlm4I0pOLBZ9a3hrQlUaDdg=;
 b=jHMJY6N8r7XZzLOQ+LRTf+I8BbzPf5k7T+S+0RnuMhQ3TgNLD5Nj4c15Zs9tkHUb9tPgm4eqvc8tfomE/+EhQvcyVHnLA+fIRmTWT8BWG72SrzwVPMWntoiqUo9gIYmVK/DyGtoKWIDTYYtvMwBrCeKmN+28kpN1sN3Rjvgkbrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Mon, 2 Mar
 2026 14:37:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 14:37:43 +0000
Message-ID: <8efef755-e429-4cec-bef4-b15b3f9f4632@amd.com>
Date: Mon, 2 Mar 2026 15:37:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] memcg: add support for GPU page counters. (v4)
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 tj@kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, Waiman Long <longman@redhat.com>,
 simona@ffwll.ch
References: <20260224020854.791201-1-airlied@gmail.com>
 <20260224020854.791201-8-airlied@gmail.com>
 <ee914ffb-5c3d-4d41-abdb-5ed02db326c6@amd.com>
 <CAPM=9txUuS-qzA+gX2DvTuYR2OZ79RG86FuDA6czkpuJ_SR6KQ@mail.gmail.com>
 <4fddf319-50c4-40ab-9e36-04d629a8855e@amd.com> <aaWZrTZGsxxjbBYv@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aaWZrTZGsxxjbBYv@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA0PR12MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b4b593-9735-44ef-ba2b-08de786943c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	D6wDR+4AwY4k1j+X1VOPLrCQHmPb+MPTUmi0J1R8ar98Iyfz6jG8Kp+bypcXU7j5pFf6Liqzemum8nu1zg+7A/Fzmp3FkVncK1doTPxFUWqG5aTEqRno8ECH8eYCEc2hw8MYcl6jOwxqCWQAF56FgkDnfraX6CwPMpPGr8ubmAPCdvXfSp1CKUgbXrrmsMrHSgat3hmmXSWi2ReqnaRSd029MUzRfoWx42Amh/riR7Hp/Zz03L36yz1OgLlM0ZRwV+B2rAtRZ2N24o9OrTiezN817DIrf/LYJIJaQRSTTRmhzImoSCczbdzNp56nDjw2zSFw6mh5moJx5E9T4Z/OMcVNdlHpve3U3jcto8zD5OKNgaYK3AECnk+MQBZQ9rShroVNMoFJDsUd2LIp5iFxLYpQHcGJeQ/lP8ofJnj4ctKvfMDM1SAmDuKIvZEv7286ZqUEfrLS+aBP3t+tZ/aKCjDA2eagNVVzT3qKAUmqVA2LjoHmD087tKw4u6P846jm7bJ8FHPyIfOPxHWBzx/eRYqCqMjcKllXvC/ejPIxicIkGc5leZY3egeqseHxpusgx8wQA3XaTYejEr5CfQMZizfymnu4uyLYlSZr/sPT5Vy7pZ9yAM7+sGV3y6FOY5JpldBfrSMibWAI8O59356I5bxp2+ykXbum6ct8WvWj+2vlu9PaBXsn9Ofy4nKjyRFNnVUtKynB1+//iR3gtT2Stu0xraYVv6VdhYGVaSHRBuU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEJnb0l2T1hQTm9vS214ckFsYSt6SFhmM2ZrYlJUK1k2OG5zU1ljc2RrbTU3?=
 =?utf-8?B?VnRZOHhUTkIzOG4rK1l4d3B3cUo3VmRqUm0zeDNvN0NiRGtHWE5KRU1OdzVF?=
 =?utf-8?B?Ymt4Z0wyR3FmRVlzWm1XbVBtZitQQlZFbnVpRWdYUjNaQWYxYUhYQVZDNlpT?=
 =?utf-8?B?blFtNjBVYytIYTBEY2VYOC9kT3UrM1VKMU5sQkpiK0EvUExXY2JleHFQa3Fv?=
 =?utf-8?B?d3NnM2xLK2lBRFU4MHd0YVRJZjFIZmlwTGhPTnJQODY5bk9mWUozQTdzb2Jn?=
 =?utf-8?B?YUNOd04yMjN2ZFhCRlJOak9NSE81TmxwQnlsV2d0cVZZaHVOcTBhM0NZdFBy?=
 =?utf-8?B?cWdXN2czZ0VYbHBoSlV0emNGNmNkSUpSdU44Y3JXQ3ZNaHVqMmhWalEwcEN4?=
 =?utf-8?B?bllYY1RiVEwxRmlicHl2UXVoSDd4cFVJMzZucSt2UkkrU25lV1Z4cHh2cm8v?=
 =?utf-8?B?eEliNEdlbG1yVmNLSlJuZTBEZ2xjTk9yK3V4ejRrZ2g1T1dLNTBqWmRWU0NG?=
 =?utf-8?B?US9sTTdTMzFpRmhIZitRSFBWOG5PdFl5cmp2UnJYMjRtSzZSYS9OeFRQblJT?=
 =?utf-8?B?SEhGOXovdnVwRk85U205MGF2OW9IZElWeHNDQnpnZE5QdTlnMTM5bDZYNUhD?=
 =?utf-8?B?N2d6ZDUrcWJIYXVhN0J1eE10cElEMVdzcitBYm5rL2h6WVkvZWdKbTdtNXM2?=
 =?utf-8?B?eFU4RkduNUNKMThZdjhjMk5Qa0ROZnpBR1BYOG1hTENtb2xYMVNyVlpvWEpT?=
 =?utf-8?B?b3I4a3l4YmhxdklaTUk1dE1sV2VsaVBPbi9BTDJCZzRSTi8reDBUYUgzUHNN?=
 =?utf-8?B?ZSswMXJFZlJtTDZVNGlNOFlxTHJQaVhFY1RTdmxKSmRpS242SDczVnF6MVRk?=
 =?utf-8?B?RXRpbEtJZTdHbzJHRkozVGM4MFh2SzBCZlVSZ042TnBNWGJuKzg2Y1ZTMFIy?=
 =?utf-8?B?d2IwcTVxMm1hTTQ4S3E3R2dkbmNibFB0eFZlbXBrdDJNNmNadFM4NzBxWXd5?=
 =?utf-8?B?NjBsOUVDUXFoY0NsVWRFa0UyOVM0Kys1dlg2aWZKM3ZkQ0lGVmVRWlV0L2lO?=
 =?utf-8?B?QUExMms4eXhRUVdZdnVDYW51UjVPY3FULzdMeE02aW5ZbDdEb3JkVk1UOGx1?=
 =?utf-8?B?akE5RTZXc29vTThXSkt4ZE51UUhRNXlQbVF4YTdtQVlFNm8xbm44YXQ5NHlZ?=
 =?utf-8?B?Y2h0U0VwTWg4UXFnejJrdjhtQm5ueGpIT1U0dDNxZk1Oc0NmUEtlRmpFSUlC?=
 =?utf-8?B?NmdncG9pNlAzVzVXRjBVd3poMTU3RUNOSU8vdkErZUFkd2ZkZjY1cldacmhs?=
 =?utf-8?B?NFE0dWYya05ZU1NPZ2sxOVh1U0YzSUdNMWVUSU1YY3lUSW9La0dIWDZNUnZl?=
 =?utf-8?B?RmNLSVdBUm9Nb3VqK2VQdWRCa3MyK2kxNW1NQmZvYm82OENacmNqUW1mcTVw?=
 =?utf-8?B?b2ZzL21ZSk9hNENsanZsV3lsRmJ3OWtqUTNVamU4THpFc0hYaDlXVGtTRzlv?=
 =?utf-8?B?ekE0OE9uUzl2SFJ0OUVmM25hUkkvTjBJUlFqSXcvSHFENjNSU1FwYkhRcWk5?=
 =?utf-8?B?WlM3VVRwTmVTcmVQUXlLQStjUmo1U3RmTlVHT1IxQXgrQzdoaW1RUCtJMCtG?=
 =?utf-8?B?K0tZdmsycHkvS0JRN2MyVG1mU0lMNnNWSit5YnVpd0JmbUIxMmVYVnZ6ajli?=
 =?utf-8?B?WWZDN0NEdkovdnkvNzNwQUxDWnNGM25uR2pzeisrMkJkZjBYbmdKK2NETnd1?=
 =?utf-8?B?VUc5MVdsY3ROOU1uZVo4aEJYcGdxbU5YOUs0eFZ4TGdIZjBqR3Y2dDAzZFVx?=
 =?utf-8?B?c3VrNVVqNENJNDJ2YW1BaWhLSTRmb1pBdEtVKzBuUVo3WWVwNDYvMzl6SnZW?=
 =?utf-8?B?MTdwUG84d0p0VnN1QmQ4SXR3OUQzRWpVNm4rOFJjSVYrTFJzeURha1o5bnRw?=
 =?utf-8?B?L29EY0M2UHdFdjBoSSt5alRTdGZ1NXBuQTJ5eVBZS1lLSGlkVVlDWGg3NXZ3?=
 =?utf-8?B?d0VieXMyQkgwdG84c1dMTnNsZ1ZtY0VxZW4rNjVzdTFkb2pZUGVGaWFQRHAz?=
 =?utf-8?B?aFFKT2pGQkFPQ20zb1hnRUJ0bGZFZzVORzRtSUM1UGhleFArbHFGR1ppa2dZ?=
 =?utf-8?B?OGduR3VsSGdiMDVlYXNLc3BRc0R5a3lLNlFPejdBcEE3WFhFT0tOQmNadnZI?=
 =?utf-8?B?WTZnVnZkblhDNkszSEtxWHkybGtCSEtNZE92enZUUkR5YmVLa01oL3U4ZHk0?=
 =?utf-8?B?WDA1Z3VCQ0NnOHlGblQ2Z1g2VzVHNEc1RUdBaWtueU03eEZuYS9VV3BUNWJz?=
 =?utf-8?B?ajJtdHBUaHg4VXNkM2cvKzY0T3dlUlh0anZsbmtqdUQzdVNEZFk3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b4b593-9735-44ef-ba2b-08de786943c7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:37:43.8637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUtdkyMabbfCCXeTD3OWw6V7HAB71F6fgkxff0aD2S0wA+ybQ/VtBi79AhoNMcxp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480
X-Rspamd-Queue-Id: 1B5A11DAFE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.freedesktop.org,kernel.org,cmpxchg.org,linux.dev,vger.kernel.org,fromorbit.com,redhat.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-14508-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 3/2/26 15:15, Shakeel Butt wrote:
> On Wed, Feb 25, 2026 at 10:09:55AM +0100, Christian König wrote:
>> On 2/24/26 20:28, Dave Airlie wrote:
> [...]
>>
>>> This has been a pain in the ass for desktop for years, and I'd like to
>>> fix it, the HPC use case if purely a driver for me doing the work.
>>
>> Wait a second. How does accounting to cgroups help with that in any way?
>>
>> The last time I looked into this problem the OOM killer worked based on the per task_struct stats which couldn't be influenced this way.
>>
> 
> It depends on the context of the oom-killer. If the oom-killer is triggered due
> to memcg limits then only the processes in the scope of the memcg will be
> targetted by the oom-killer. With the specific setting, the oom-killer can kill
> all the processes in the target memcg.
> 
> However nowadays the userspace oom-killer is preferred over the kernel
> oom-killer due to flexibility and configurability. Userspace oom-killers like
> systmd-oomd, Android's LMKD or fb-oomd are being used in containerized
> environments. Such oom-killers looks at memcg stats and hiding something
> something from memcg i.e. not charging to memcg will hide such usage from these
> oom-killers.

Well exactly that's the problem. Android's oom killer is *not* using memcg exactly because of this inflexibility.

See the multiple iterations we already had on that topic. Even including reverting already upstream uAPI.

The latest incarnation is that BPF is used for this task on Android.

Regards,
Christian.

