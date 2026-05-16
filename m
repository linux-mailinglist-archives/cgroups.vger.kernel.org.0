Return-Path: <cgroups+bounces-15998-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMH0LRUFCGpYVQMAu9opvQ
	(envelope-from <cgroups+bounces-15998-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 07:48:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3A055A58D
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 07:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C711301466F
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 05:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF56B31AAAF;
	Sat, 16 May 2026 05:48:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021108.outbound.protection.outlook.com [52.101.95.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D17188CC9;
	Sat, 16 May 2026 05:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778910481; cv=fail; b=gK0OVkYkOJhFLchvUOS4EPGb2R+wly9j7bEwl4Ok0M/MFsqiXEzckE7zaz2TF6BqwjljZ8LwbPpjAk5a0NR/zLxLoUWo4bnVeyNmKv7y+7TqEa+G+PfOAS5Axfbu5CB8XbgDHSUeJRTghMyetFQ5OPLNejasGDvK97WzcGlSkbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778910481; c=relaxed/simple;
	bh=fjOC1/t+F7C/wLh9H21k6WBxGT2SQow8qM3VHzrfc8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YTRRxFtJmk5hSbyi6qu3DH23+r9M1yWZpY9Qsob9y/hXPRtHBZkX1J0QAr7P3wFYNogPcZyD33OSKRQjtAmWdt6pmrqdB5Ub2fwpuDmxjvtqPA7FkCOshYtmkv2VXQblvQ7grd6XNVXCwkzy4/WwtgMlQFqKIUL3YHLRvSTUh08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xcSDwzTYrJnicVzGxmn+EXuiyd6Rr0yVeAilhhSSjxaeqOOEjuaA6U3rF3jy/wRniwhbEmLIR9qCgFE4KmFrCC8eizhfKPX9F5w6aR/ueSDgxwqSzxCI0xvDhWHJUL+xKHrYLWw/MGtvz4YTcePsJE7PW5UCQhBDiJsWQ3S7P52y0prnomBiQVLBP9utA/k0YhJLqJZV016Bp6PAgI6hk3+g7epgA3onQ+r5okTDsLyUPjU6Lp4as9g1VFIk+33+BJFUznNqyfnqq8ooVq9+y0lIEiB5wt4knu4yPHWaTsxxzqAdkA1Qw8HAMilr7HyKV2sC5iVu7cajPk/+faKHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFrcJ1ghRx1FVjAeVkhLeCZOCxBVfJVUmcGfmVbqGd8=;
 b=Mr01gh7uKE9EMKh9KI5f+ntE4fWX2HlW9q0imrDTRd7AsAPbZ+7zmtmacYX2nXKBoO6Jetuk/JREfPNpL1PKr4uOZZPQm7FMDUxjTEm7zzG79Jx0md38S/svd4MPgfh9GSgbcDQeG0ReqTZJUKsB4Vo4oadDlbuevxsl9MPZ2u09B+9HfnKXNrqbgKcOc7Z7Ffi9kfBjfa6omIUfopoCPsFwq9IpvaHALJ+4Kq8x9W6OfTWqeVya6rsMCiMeMjGM4dhYaStODj2dJmN0Es4uRgWLcx7HxOYhDqnyvde3nhPdWCwJQcwzgXIeoh3fJvUgRXSGiItEO8x0Kbd0Y2SSJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB6907.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Sat, 16 May
 2026 05:47:56 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sat, 16 May 2026
 05:47:55 +0000
Date: Sat, 16 May 2026 01:47:52 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Waiman Long <longman@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, tj@kernel.org, 
	hannes@cmpxchg.org, mkoutny@suse.com, chenridong@huaweicloud.com, neelx@suse.com, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset: Fix multi-source deadline task accounting and
 bandwidth bypass
Message-ID: <5eobcykro7yj2pwck7e5ca6cxwerlcjgtnawmmjqd53x43zf6e@7gu7yoimmh5w>
References: <20260512010341.101419-1-atomlin@atomlin.com>
 <ddc8040f-2186-4c72-a69e-26b388cb7249@arm.com>
 <7ae7fe29-6405-41e3-9f3b-6c1d0255dc9e@redhat.com>
 <djbtucfusnpngys2nritqsi7stjq243zchel45ahfgaruba7el@4rtk534mfq4j>
 <bda91fbe-e14f-45b1-8c61-27f16122bcc1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bda91fbe-e14f-45b1-8c61-27f16122bcc1@redhat.com>
X-ClientProxiedBy: BN9P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::16) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f2dd59-8141-4f8c-414c-08deb30ead93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	3tZ1A/zs4qk/o7DcdmDb11zCChGg27Ih2byJ02xidtMrQjU7hzlsvIQgMnLsXLXzJKDfeMM5dBQZZxws84kmiBerIAlsazsQh6SjsZxJ8RZ8Onn19SNT2M8wUAebTfvHtsLyPla2ynb9J9CPLdaFXGxt64VLcEy3CE69o+3aWsVgCpR8Ciwm66biKtQQPc4c3Ttf5TbYOUyFQoYOKPa8z9weJApsYI2SY2m/1a8kqWP+wb9XYlbyEWk4AU3DouY0zx6gDrwr4V4Rr7WjL+OxWlmiwnFZlXUZy60DX4nOJZwXKDLMiIVoJGtc+lMFzEnu/1nnSkp/3VKuZpwgwdu8xYTtehYylSKZYcVX6dnEtf7UGqMHeiZTw6jDCIdXWZ7hlPUhBpp1/rDBxu1RKHrMG2ia/pYWz5k1AfCqNS7UE+uEzxnr8Hhkqo9OznQwbOWk0RnFRfNQpYNFe0XRDtLA8c9YtN7jmGIi9vWPL8xFxeUruZOW5D/SzLLaCe2nSd9jdB/jVTm+eJrLpmjx+J9wfXlI6h33JfkBU4wOBIS+4w/SQhHgyOAUppglGd5lMlOynTv0W4ebs+Fnb3f0XZoXzlXpFC3NS2FmuWCK4FH9OgGwudZ4rqYyXUv5oaArsegOjwS0zkTREcKN9lvvfGlYZUR5m7fKQjqZgLyyL1Rv8WIJYS38eCH1sAtJl+qpFK6J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUZ4cEhVb3h0cXVENk93RHFtNkRCdkZkS0poQkRRcDJKSk1TcmNMKzZpODhn?=
 =?utf-8?B?SlJQZnpmUkFlY3dWcE8xMm4wMW45NDN3RzVOSmRGUFJyQk1xWVhWZkFoS2V6?=
 =?utf-8?B?WkxxZ0djOXVVY3NvdUpQUlZRUEh4b1JKVTZ4bi9NWjcwUGxxSzZoOUVmeXFS?=
 =?utf-8?B?WWJnQms3eHhlMENkQ0R6aGJheG5BZE9BaWw2WGUwNVhXRmFPRXcwZEZEdENr?=
 =?utf-8?B?WmlvdndHL3M5U1ZpZlgxanJqdWp0K0JhKzJkeUZmSmkvS0hZQXhsL2JNQlUv?=
 =?utf-8?B?UFlTa0tDdDZGVk9lWE5KVHA3cTV2NTVaYTVMSkltUm1IdnhRSGQ3MTF5dzVZ?=
 =?utf-8?B?b2FRZXhmQzhFRE9pQmNDSy9kWGdxOFhkbFRVeEF5TDY0cFFORmlEWkxwaUpE?=
 =?utf-8?B?TjJoWHNWMzY4b1YxQitueHFoSWRMV0IzUDl1L1RUL0ZJVkN1elQvVWpYM0Zr?=
 =?utf-8?B?bzhYa0VJenNSVjViTktzemVUeDVSbUdOZ0hNOWNJTlI2ZGx0UTljSEN4aXlR?=
 =?utf-8?B?eXJPRjk1R1o0N1c2bmw0cFpQMGtyZXFnSXU0QitYMG9kcVRob21OTDZ5dmhB?=
 =?utf-8?B?NUZJdzZrNnM5VWxiTXY1UEJ2ckxzQitUU0laeGgrVXR6N21VcE9hbnltczRz?=
 =?utf-8?B?ZlUvOWwyV1N1MGc2ZVVOMEJaSTVXdW5MQjVreEpGdlh4OUhuOE1wZzZTemJF?=
 =?utf-8?B?OEppYTREdnhlVWFxbTRER3dsRWlyclFRZTdvcncvblF2UlVPay9kR1k1TlpM?=
 =?utf-8?B?VlgzYlRzRDJhWTAyYlBNeEJIQXZ2OU5YdmNCQnltMGhjNFBrcEZwSXd4RG1s?=
 =?utf-8?B?bHo2SXloYTVUMmZKQTJETElXb0N2U3N4Mm14UWw3SG94Tk1RZVhtUjJvdHhY?=
 =?utf-8?B?dnBsZXpFRWdBSEhQZWdNN20zQzN5ZjU5Z2lkTm5mbmlEYkozZWhTeGtGaTFL?=
 =?utf-8?B?U0pVYkYrazRXdWZCaVpGdkZoZk9PY1dZRzFuRm5hOXZlSlRTOHpkaGlrcFZV?=
 =?utf-8?B?Slh6Vm9HNGxPdkJZazJUWG1aWGxVS0FHVSttQ3Q4cFNvdWpyS1NUcGR5cVNy?=
 =?utf-8?B?UVFpMmFHZlFMYzZIMk5nbU1qc0xFU0VtekZpUEh4L2YwZ1FCL0RqbzdSZnVD?=
 =?utf-8?B?NEkrZTJURW9ZRXFiN0ZhcWdRczhYRGJUSEpOb3I4dDJNSkZJYlBYN3IvZU1z?=
 =?utf-8?B?M0lmLzc3cnBONUZLaGRScjVLbmpzT2RiOFBHMG5UT2lvRk0vVTRaKzM3MFJP?=
 =?utf-8?B?UmJxRk4yOERrUk5xMkRYN3dSU1lPd3BuYVZoenBNWHlacXpWTGJWQTVtVkdt?=
 =?utf-8?B?Ny9EN2UwTFhGeWlwZ2JBVGY4SXFHUm83T1dXaFZkSGhOOU45M28xNm85aUdI?=
 =?utf-8?B?ajFKY2hJYTdBUEdMTVZVZ2JLOU1xQXoyUW5XZ2V0VkNIOGFkd2ZxRlBIdXJM?=
 =?utf-8?B?T0hQcWtpa1B1NkdNNE15aDV0cjRxR2Ixbzc5ZHd3MkpxaFYxdkMrOXBoNUJ5?=
 =?utf-8?B?alFIYWJXRVdBeWdPT3hUajZEbUtSVklQOGFsQlovNFZHSldmOVV2eGRpaTgz?=
 =?utf-8?B?OUlickx4SkdGaDgyS2Q3MFYwZ08yVkt6RmR3M1NwdVlTQXdCc0FRSENjTEZV?=
 =?utf-8?B?eEpmRWVHZXlDMjhjQnp3aE9la1N5UFBMSFNSYUowZTVuNGtaazB6elRTWUV0?=
 =?utf-8?B?cUNoRDhMTGQzMXZCTFduN1ZHbm1rSk5qWWdTdERqK1VFbUkvRFI1M3RROEpW?=
 =?utf-8?B?alhxSzBJcWlibkVUVFR4NnNUeUNPK0xIODFUK1lGaVlRVGsxRC9aVDRVOGZo?=
 =?utf-8?B?M3MxTm01bkFFZGFhSGJ0NHVla1ozL3JISjN3djQ0bmxXdUQvZW9yWklqdzV1?=
 =?utf-8?B?MTMrRFNrcyttajdabmJHMnN6R2tkMk11YTdPRmdjWlBDK1VHb0dBU0h4cER5?=
 =?utf-8?B?TzJFbFA5VEtGWC8yVHNDUlBQalpiQVB5QmRxK2lveEFiTFVqbUpBQWRRc1Jx?=
 =?utf-8?B?MVk3UEc4UXMxQjZVK2lRWFJwRGRCajhnRkMvR2hTWXpGNDlVWUd2Ym8yRGlj?=
 =?utf-8?B?V2pXK3JIbzhuZmtTemdiL2hhdUxNZTlrblB4QlR3L2pGbjFCdVlwVDVvVUY5?=
 =?utf-8?B?NXd0eXg5dkZROFhRYjRZazk4RFViNjRBSUZ6SDB6VDhXWEY4RksrUzZmR2RC?=
 =?utf-8?B?UDRBQjcyNTFLUUdmcHFNcXRFalRQeERUaTJhRnJxUnVETmprWW4zZXpGVjlT?=
 =?utf-8?B?NlpkbHBjTFkxTUlKNTlMYkpTYkpjVHIyODNQVW9mdytOKzMxZk5DWjlBajVp?=
 =?utf-8?B?ZzhTYXlmNzdwNDMxWE44U2QyMUlXTmxaM045N3pySUJYWnRBSHJWQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f2dd59-8141-4f8c-414c-08deb30ead93
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 05:47:55.8340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JoK5Hywf3qwSvNQ/z7vnd8f+wCAokOW4WSxwPR9WuKWSATBudioTXyVOl+GL0yvGlx93Q/kZkcYUAbNEVFaow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6907
X-Rspamd-Queue-Id: 1F3A055A58D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15998-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 12:26:35AM -0400, Waiman Long wrote:
> > A concurrent sched_setscheduler() could alter the scheduling class of a
> > task between the initial pass and a rollback. This assertion seems valid to
> > me. Currently, neither cgroup_mutex or cpuset_mutex prevents scheduling
> > class changes.
> > 
> > Should I let you handle this too?
> 
> No, you can handle it if you want. I am more familiar with the cpuset code,
> but scheduler is much more complex. I don't think I have enough
> understanding of the code to handle it correctly.

Hi Longman,

I'll give it a try and rebase against your final changes.

Kind regards,
-- 
Aaron Tomlin

