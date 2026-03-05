Return-Path: <cgroups+bounces-14635-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMhwEQNNqWk14AAAu9opvQ
	(envelope-from <cgroups+bounces-14635-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 10:29:39 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF71D20E693
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 10:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC51D3041D7F
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 09:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630D72580CF;
	Thu,  5 Mar 2026 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MLNseS/t"
X-Original-To: cgroups@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011012.outbound.protection.outlook.com [52.101.57.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694C2378D8C
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702762; cv=fail; b=giSo/OuILHU5qvAstfiGDjCdhr6hRFqb7omkPM5YR0Maw4UazlPTkXLnZ8nMHUG+XJ6nFxHUVt/xbOtbSbIftwSl+D+9Tay9IUX1+vuHgFPQ5YWmpOH7oVQNF/XaEtyvwTA8b95PO98sfwOTi+Mm0NFKNZSGkz7gQZewVfQOKBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702762; c=relaxed/simple;
	bh=wSpzodweUzf9X4AQPWpS6CpSSZ45QJaVxR7uYZ9a5d0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bqSTwvr/EghDJdICXtCzvU1rXiihk+Ivn8uULjAuo8fkw+ppzSnDGEi7UTuLaxGc/FQI/X8g3LrkLTy8envqjuuQyRgwcTVxSoCYhd0M3aeW4dGp9kTNd1aFaIN13SFfzm0w0OjcrC8u1ZgtMyhnQZwpedbKqxuM7C53BxpsvBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MLNseS/t; arc=fail smtp.client-ip=52.101.57.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEGGrQTvErJHOk5QmprjcQimM7ARwbHXFDPGqZ7SC7CCW/LycHvAzmq5N02F/uYu/yVu/7K36aGWsWPLKZ4geoHtxPYRv7zmib/UgIsyqoRTyb4hOwxj6uPKvMgeMuXn4m+ZXElqX5HoNf60VDi3meh8ivJD5Q7fm0G75TM1Wz4Cap22XJjiNe7cMBu+iRvqbf5puG1TuGVdzAF7TGqbR745+Sl1jXbnuKKXaR2x+6mfXNKW+YJZ2RBJXpeuB2kWhLKsh/1+a4ogiGJO7F28zrL+bOyeyO730jqHocP6w88v9O0oyQPJ8SFigJgE/5AHiWOfesug6cg5lbeH7comuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhjVADwR3rQlNpGjTezD89dgMIS72YdrRPxd0VpnZmo=;
 b=QjaxdikbTaFGutRGrE8Cz97WizChG9LDDbLVl1OsHtPbQpE4Mnz7jgpwwlEoZZz5uL+famthCmc9uylCqXWGh6I4hYla18Dg3U1CXmIAxcmQ6taFt2uJy388EL/j+WBztxw8snL3mprz9AmWREJiv7j7RtLeaTPjZIzS01n8r/isGtWIdao/rLuWeXk6UqJA5nlmWQ+mKX1lzwht7hnCCCDJOfWvuvI4oMU4xEXIyKW6dov4DQEXG4FPs3bl3JIxzZ+8ZYyWFHEhDRgkLfS1/XDadI0ZnKI/jRsTXnht5nPwyihXDv8mqTtH8y4oYFCnb8L4mntn0EUluoLSoqghfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhjVADwR3rQlNpGjTezD89dgMIS72YdrRPxd0VpnZmo=;
 b=MLNseS/t0Pm50PPdCAjknbebBAxlKWSJBhaHv7pLk6xOnHnpcS3L/423FcTNlDnzX2aBQ/gJaGz2BwIO7wI/UerzXPzS2QMApnLXVGJnif/Kmjhs6FUxnFVvTgrUdmTVoM7CyC4ugR4WpNraaegTtNIJHocUpHwPJXJ2Oe+suRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7530.namprd12.prod.outlook.com (2603:10b6:208:440::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 09:25:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 09:25:56 +0000
Message-ID: <f54308f4-7185-41ea-9ff0-98315dd8f39a@amd.com>
Date: Thu, 5 Mar 2026 10:25:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] memcg: add support for GPU page counters. (v4)
To: Dave Airlie <airlied@gmail.com>, "T.J. Mercier" <tjmercier@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, dri-devel@lists.freedesktop.org,
 tj@kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, Waiman Long <longman@redhat.com>,
 simona@ffwll.ch, Suren Baghdasaryan <surenb@google.com>
References: <20260224020854.791201-1-airlied@gmail.com>
 <20260224020854.791201-8-airlied@gmail.com>
 <ee914ffb-5c3d-4d41-abdb-5ed02db326c6@amd.com>
 <CAPM=9txUuS-qzA+gX2DvTuYR2OZ79RG86FuDA6czkpuJ_SR6KQ@mail.gmail.com>
 <4fddf319-50c4-40ab-9e36-04d629a8855e@amd.com> <aaWZrTZGsxxjbBYv@linux.dev>
 <8efef755-e429-4cec-bef4-b15b3f9f4632@amd.com> <aaWuoe_CQwbtcxEY@linux.dev>
 <63dccd9c-f2e5-421e-ac3a-a7c13cec9121@amd.com>
 <CABdmKX0=xPiwXgOHskGkE9Umj5=NrC=7OtngJjrm=mtOZmyzvA@mail.gmail.com>
 <CAPM=9tycvBguhM6r5ytm9S7D608iZDthHgfY=hxUvSjXLqsZAA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAPM=9tycvBguhM6r5ytm9S7D608iZDthHgfY=hxUvSjXLqsZAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8cd1de-9390-4529-b5f2-08de7a99343c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	MBMuP7uG5GbanyWnALldpZdowHb1qDCvsmIAO4ErKJDLAV6OYgAENTgQIUft6676I9fjL7p80WtSt1yfkh8ZkIMiFqE/nFgTrsQU0PLfYbmEnYjJbpKObUoCSvGGSkDNgWrlFLCMuMqxI01f9RsAD3/aWIfRLzemjXXj7AopBLtmFv3CfAWT/FHknAYjTCdBmjM7V9pQ11CF5ca1H0XsRbfKJt+nxDBzYeZNSN+/4z26lhz7p29sggMWTBlHOKb9rYZkz9HvzVls0gZ1EQbYb5ynzc1DOoipFRU7KniFSDEV5oFGCt8jgD4sR5BsXkubc9qkhvCcEdWlLNSVfbAlO1QbCXNxljW6f4A39nUoWUxJL9V4nF11bkalUPeAOz6+tO8cfUqxBeBeSsFE5IsW/5GoftSuAGh3m8uxwWqXudyib33EsZJfiz6+RrFAwo7dToQvuhJ0ntu9WmeaLGUZIQU2RraSi7gnrQc09gFkFLGF6cFivJAUrfKHBVl4kYQ2SwYYjMEe7UEjuPHFP/M2338LVTxMDgvi7BUQ2chhc8Aes85uwrDnaue/K08DX9GH0/IRTXErmpPGvFIVfzcucvx97/3MoxhE3V8Jc+2WQsZYRMoiweLOmnXtb5JEd5B1trlnJMW/aKQgyQ+NZMUJJB3tfhgs+TR7dMJDFCGukbHwA89pew79++xe9xEcvxNWtlb1pdLdByTQy8LIxRebn0JSDIvRTUBWt8LBLGiZeSc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTF6ZmFxcXo1ZkZLVWdLMVl5a0FWQ0l1bk9Id28ycG1KeHBEbGJTc25sd01Z?=
 =?utf-8?B?T2JXMGFqbUJpQ1RxaERQWlFJMnBzaS9FbkpUckh3YkhBdURzcXpTREc0ckFZ?=
 =?utf-8?B?ZmdQeThLODJMOWo5WUZCQmVYOEVtQmVrQ3hLRTMzKzU4dkIrQk9vMVhEc1o0?=
 =?utf-8?B?cWdmVGF4L3hQcFRHWG9ZbHVXRkE2VW5sTnhFa2ZwbXUxTzJUWWFURlM4NDZQ?=
 =?utf-8?B?QlpqcUowd3ZETW5vYm5EajU3R2lsWk15U3BmNFNBaUF5ZXA4VnB6YnFlWFNY?=
 =?utf-8?B?TFdvVWRmMVF6ZDJjWEw2OVlUZ2hXQXFRZE54ak90NzlveUFDR3dUcE5WUVk4?=
 =?utf-8?B?Wnh4MjNiUUlDeVFqYjdPZThsU1FSK0pSaXp2Q0ZjL210dmhqeEFySElLS2Np?=
 =?utf-8?B?UU93d25YQ0c4aFBoMU92MExiOEc1ZzI3UjhPaHZDdWdjNURHV3pNQ0xHaHNa?=
 =?utf-8?B?OEVYbUVETnNqMjFZeE5WbVdiZjB1ellQV3lrMW50d1NEbnNuMk1xZDREaDVJ?=
 =?utf-8?B?SGZyTi9mTlo0NHZtV2YxM01DMXZFNHVoMTg1eS9YOGZrMWx4RTFzejgwcnJU?=
 =?utf-8?B?LzJnUFZRNm4vVFBjUUVsQ3NhZVkyMmFaZytHWXUvNkIzZU1Pb25NVGNRd0Rk?=
 =?utf-8?B?Qjc3V0FDMUJRODZaTmhXdFUxaHcwcVdGUU5LUi8yK0Y5U0xpSUN3QlFPb2Iv?=
 =?utf-8?B?OHlvRXp6ZHkwNTZ3bk54RjEyQ3Q5SjVMMEVxeDViaGVha0h5VVNWT043MGxj?=
 =?utf-8?B?b3ZkRTB1WUp4czU1RFh4aWlpVStXRUhTZS9hRS9qeml0UnBFZEhZVmcvMDhH?=
 =?utf-8?B?blNhZ0FIMGdWZys1ZmFJbVJoTU0rVXpNQ0lTbDFFWmRMODhEdk5ScWRYcFFp?=
 =?utf-8?B?cC9nUWtkbElXaUV0QzBwak1qZmpFdEsyZFNyeXhCVGVmMVdkQytYSUFUeUtl?=
 =?utf-8?B?aXZkTXhZNGJJQm9GRzI2NDN4RmF5emRjbHVad0kydDVERGUxRTd5VTZNU25v?=
 =?utf-8?B?emRRSXNQZGhvVFdja0FFNzg3djY0Sm5jWUlHSHd3bWxZdnU0S1IyMEk5U3hJ?=
 =?utf-8?B?cTcwWHVrb0RuMDd6eVFHYS90a3dvcGYrTDljVXcrMld4T1dzWU1oMDA2Qm9z?=
 =?utf-8?B?YkVWeW1YSEYvVEtNYlBMWVZiREF1ZFpjVktESjdDb3ZkU0hTTndtajhRamll?=
 =?utf-8?B?TDBsZDN2MXcwYmhwSnM2VEdRN0puWlpTUXRtOUtuejMyTVhiMm5TVG16aUR6?=
 =?utf-8?B?ZUpHdk1UalkzUVhmaW5heEN6M0FHODBES0MvanowMUVmOVBzVjROV3NLbFdQ?=
 =?utf-8?B?NTBFMVNRTjdKeE01R2JmMTVWWlc2SlRKV29pUlJUenRRVEhaNEFkd2I3TDlE?=
 =?utf-8?B?QUtVRzdncHp4bmdlMEZhbEVPVlExSjY2VHZaL2xiclpDT3pMUXAzb2dPQWJk?=
 =?utf-8?B?NE1SbzdjU2xPSWxkWmhNZGpTUW5PbTZxMzNhTzBOZ2o0OTV0T2hYeFBBWVk5?=
 =?utf-8?B?by95S3o3RE1NNllPdDZkRHdITVpKd3NBT3NhOFd3L2xTY1BtSXVRekZVZjdU?=
 =?utf-8?B?b3VtM2pjSmkyQlBRUkVRaG1wTW90VXByVnp4b2xwSE1Lem1IaGJOZ0tHTWs5?=
 =?utf-8?B?ZHcrMDRPR3o5QmcvZWZUeFVOQ3Q0a2pRTnU4Ry9wbDhkQTBZUzgxV1RxdXJS?=
 =?utf-8?B?S3M4eG5jcVIwNEFUdlMvRjRiajRRWEFON3ZVbkprbUpPcG5tVWhoaWI0Zk11?=
 =?utf-8?B?Z3VQODNhUGplY0lzY2tIYkE4L21qS3Rmai9mcDJqNUJnVzNjdjZ5aFlOeS9t?=
 =?utf-8?B?cUZvQjZFaTB5VmVCS05qYUxIMDZjV3d6d29ZcXdLZmpzVU44ZC9RMFlla2xh?=
 =?utf-8?B?T1FaNHBJL1E3V2l3Sytaa05FYTdYZG1EcGlKRng5SnBqV0Zkd01XdGVFamw2?=
 =?utf-8?B?TzlSZDRUbUZWUGFVSE4wa1ZYbGtDT01ocDR4a3ZJdzV6R1dkZWIrei91T3VZ?=
 =?utf-8?B?RHo5MSt6SEJIQ0xOSHQyeHo4VWxtb2RWQnpxelBTcHkvVXdQdURVOWxRR1hY?=
 =?utf-8?B?Y3BPblUzbTBIUkVLZk1ZSC9FZlRwVmlzUVJ5V0Q2MnBqclptM2g5dWdEYXJI?=
 =?utf-8?B?MGZZQmtIVmpuRUZoUXpjbnF0MnRMM3Z0czVBUjRuTlpna0dnRlFDb0FiaWFL?=
 =?utf-8?B?QkNlbFdGM2czMXNERnRPUm9CdldWVDRiU01qRjZueFMzOHd4SEY3aHdFcDlY?=
 =?utf-8?B?R1Q0QjM2K1MydGFxQWEvRVBYYUxHVlczUy91UmpPTmdOU0cwdmNhWG9KNG10?=
 =?utf-8?Q?47gwubELv8Qh4RxDAg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8cd1de-9390-4529-b5f2-08de7a99343c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 09:25:55.9736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yX3fsICfRfUzknOOawhmXXk24+kg6idzkgTwIvAaTvuijGHKcn4L/fpcxVH3Gt73
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7530
X-Rspamd-Queue-Id: AF71D20E693
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-14635-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:dkim,amd.com:mid]
X-Rspamd-Action: no action

On 3/5/26 04:19, Dave Airlie wrote:
>> Independent of all of that, memcg doesn't really work well for this
>> because it's shared memory that can only be attributed to a single
>> memcg, and the most common allocator (gralloc) is in a separate
>> process and memcg than the processes using the buffers (camera,
>> YouTube, etc.). I had a few patches that transferred the ownership of
>> buffers to a new memcg when they were sent via Binder, but this used
>> the memcg v1 charge moving functionality which is now gone because it
>> was so complicated. But that only works if there is one user that
>> should be charged for the buffer anyway. What if it is shared by
>> multiple applications and services?
>>
> 
> Usually there is a user intent behind the action that causes the
> memory allocation, i.e. user opens camera app, user runs instagram
> which opens camera, and uses GPU filters etc.
> 
> The charge should be to the application or cgroup that causes the
> intent, if multiple applications/services are sharing a buffer, what
> is the intent behind how that happens, is there a limit on how to make
> more of those shared buffers get allocated, what drives that etc.

Well the problem is that by charging to the process allocating things the kernel only makes an educated guess what the intent is.

As far as I can see that approach only works for containers but basically not for a huge bunch of other use cases.

Taking the Android use case T.J. describes as example what you would need there is to charge against is the file descriptor and not the application. The application only comes into the picture when you then want to know what is the total of what a specific process uses.

Same thing for native context for automotive, here it is even worse since the role separation is different and you never even ask what the application uses because that is completely uninteresting for that use case. But you still want some kind of limitation for each use case.

> If there are truly internal memory allocations like evictions or
> underlying shared pages tables then maybe we don't have to account
> those to a specific application, but we really want to make sure a
> user intentionally cannot cause an application to consume more memory,
> so at least for Android I'd try and tie it to user actions and account
> to that process.
> 
> On desktop Linux, I would say firefox or gtk apps are the intended
> users of any compositor allocated buffers (not that we really have
> those now I don't think).
> 
> if there are caches of allocations that should also be tied into
> cgroups, so memory pressure can reclaim them.

Not if the cache is global for all cgroups. Tying caches to cgroups only makes sense if that cache is beneficial to that specific cgroup.

In other words you need to distinct between caches (which contain cgroup specific data) and memory pools or caches which doesn't contain any data.

Regards,
Christian.

> 
> Dave.


