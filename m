Return-Path: <cgroups+bounces-14462-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA/fBzhAoWnsrQQAu9opvQ
	(envelope-from <cgroups+bounces-14462-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 07:56:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E491B3902
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 07:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1537630AD896
	for <lists+cgroups@lfdr.de>; Fri, 27 Feb 2026 06:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A893806BB;
	Fri, 27 Feb 2026 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OdkeFvGf"
X-Original-To: cgroups@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635023451CC;
	Fri, 27 Feb 2026 06:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772175364; cv=fail; b=ewaDwA7AUCI3ZqJCOrImNB08iSIf1/Myi5tl4m8lbIRM4YwnhjKlczgjO1UIyClk3z6IgC5x9OHjVWx49/qjXEh/zeB1T7ggIHV6WSkGYzZ2pZKftwoUZBmP8v6qKnGlwS66HljRw0HdM6lD/hzAdLr6LqJD58kH5x0ETOZ3sCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772175364; c=relaxed/simple;
	bh=VdeX807rlwmiK8RNAbHMyxCJnB8MLcoIYLUwEL4yV0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k1Wm+4WHL8+0w3XazuRznjHX68D/mRM6xxUvH9DruoqcB1p8aZoZ+R36bDZ3cBphYRSk3SAIGpBSCTZTBynM6/QtOk49HiUuNZkBqd2KIBy2mOTug0it988fAfb376k5Us6WzxgZp79V/X8RL+LEq/JP0WrJFeN8XfPcs7y5Uvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OdkeFvGf; arc=fail smtp.client-ip=40.107.200.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQqOB9W9GpwS/isIhP4hPjlwaDdal6NKfVW2fadnQtCtxahvANJICor3eZD3sHbK4GqiiEeOezW1/d4vOSL01SbFXRLHjno2SPZUmMNaIRWoxJRSb/NkweJOVHTZCnBgzUcGjxAH/jo/LsQ28VUOpVJTilxBlynNOAA+sz8EltB3QSQHOAIwq4Aw0oDWk54zx7mbC4KDT8VhW9MHIYE+uXNrjsYMju6sYOqQGniANd5DqvLGR62dZLtex1qDaKdbr5hlSPDyQJCH5h/LtzP0FpNQWPQCW/WSEjLHqfFA1PbU9fxCGUeGgLqpOpj7TQBWRm94SCFuzCopvWL+REY6nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJHj74vPl8fN5uiBM0DmSZa5KaTkensQoU1csnBaBso=;
 b=EaBHk/pcZm9nQwRYGNPO03XY4GAew6O76cKlMCChaemYgEn8mTeXEufh2EiCsfp3IadL87mpIhzXkRczrcK/M2XqGUiaQheUoQztA8gVEAdr7M9+CU+1Uivf23OF+OZLy/mguaOiHCOKhySAgu2Db3G9gEEDxXxzDkxs0CfOQlUJholMvb3MaPpQNm+QMdIDgu+HplR8gGj94Qu2UdKVrwGPPrYPzSzyyt9llRjRyCEYkt3vI58j/o0UyisGBzKSE5BKWOaWG8awAzR/NpEF5lHDzZ85p3r+hdRyamKCqFTjh9B1A/rPeFSyMManeNq22A9acnJgr31VVg3xE4JB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJHj74vPl8fN5uiBM0DmSZa5KaTkensQoU1csnBaBso=;
 b=OdkeFvGfbqCOLSAPpklPyVF/355I2IAsJKQEpN8oSq80qEEr+NWvA3bnitJUtedX8K0NniGr/tqiZ4HAkfg/2tfk1ILI7coUt9xyHekM1wbt3hI7LBi9fjHt8994r00xv3KNqKFiO7466f4ZMjgCKxDWKo8WYjYFN3S0lrH/RZuCN3NISMnm2q2qtBpf40d0UrCYS7NKCRqlLOStmNfTDvr8hdnfkdusplgs2IlbQG9hF+VNwW416fwHgaGxTLtxNrKsMTsium2wEs097WG7U9pwMsPVo6oZpiT54jsT9PNawNeD7D4vaHE0KfzkGZLk29EuoOqRL77NhPh9w/hebA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 06:55:58 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 06:55:58 +0000
Date: Fri, 27 Feb 2026 07:55:49 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	void@manifault.com, changwoo@igalia.com, emil@etsalapatis.com,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 13/34] sched_ext: Refactor task init/exit helpers
Message-ID: <aaE_9YPu3T-pMXfO@gpd4>
References: <20260225050109.1070059-1-tj@kernel.org>
 <20260225050109.1070059-14-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225050109.1070059-14-tj@kernel.org>
X-ClientProxiedBy: ZRAP278CA0018.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: f6577e10-9c04-49b1-b2b6-08de75cd42d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	O4xpFltMpJ3l2chQbrrOKsNrR+8boVvRFewznVENCt3livVK4V5MD+fjZ8v6AuJb8di9J7h2cCpqleV8TGUriP4k70aFKcruqnMlQr8scVZXiIvio3bbRWAwCjSrdKALRQKHbokBdkUm2IdYjbOrPVQPRYYxRKbovGw4Xb/j9VJI9Fpvu75JOdJETynF1vIxPJWgsAtFJC1hasp3a/dv+Fe+SzcGLoJip7M4DCcytlhp0qrhljQj2MpJPlJe8Z210TwXT5OjdhsJnkJm2JGYjKLMiyHAsjyTXwRRd+vlbfi3vtjCQ5bv/rAhMQrnVmY+YtUiF/MTjTB2UztCcqLbQE9qMU/7Y42MPZdxM6ZN37WomyW4XObzwcFm8m8l2Vwqx/HJU6kodG2sxT7qouSB52iqa1FrlKAScflwg5YSkOSjRpWtAvUqhijuJeXd3CHxNOB7BHfHfilRvz/CEo3NyBUKCA4B4jssuQp2AM+rFeUmjXr0LGHn7U/sa6IiidkL6c7DLYss1pGp5/1/o4d+2iDUZU1XIVTl/4kWG5qkyhC3qZ7QR39EWkwDgcL/mvWEOdli6vVkVfsc2ga9c4cLXkXNyxf9hzpPt6ZVkKLuGlP/8M9V4zh6rTmO1Rn/4r1w5+V0UfOlkwF4ajbUFZo7yfVs09jdGXWI7r3iKmTOFnaV46+IMniRdFCf7rnFOz34MYCE0euxDnV1YeEZ96kKGh7TEmyu5MM3vZZ3eMoqI5s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3FUcWJLMDdhdXVGOEFPbjZGNHZabGJEZFdGZEFJcWhDTEdiU3IybDBkYkhP?=
 =?utf-8?B?ZVlSejZSbFg1NnJ3alprSjRNOUdOdjB6bUVzbVNwdWh4N2dxOElvSkZJc2Nq?=
 =?utf-8?B?Z0ZPVXdYZjJZaEFqWlFLdE5uM2lSSnJzOUgvYUJkU0xGLzhuQ2hxYm1EcHFQ?=
 =?utf-8?B?SThvS3RLTGVJV2lseHIrMS9GTld5OVlGZlhMekVOY3Z3aThueTRqWnZ6L0gx?=
 =?utf-8?B?d0NNck51YlozZzNTcWQ3amErcGJiNi81TzBHdDFrTE80MFNCeEE0Ukl1eDBw?=
 =?utf-8?B?S0hHb25wVGNmcVRYaWs0cEtoc1BsanhmNXR6NnBQMXB5Y0FXeWF1bjl3cHFp?=
 =?utf-8?B?MzJFS0FibmdjWURrWXhaYzVQRXM3ZitUY1htR1p0aitxMEhLMjdiQXFYN2xX?=
 =?utf-8?B?YTNwVEUyYW9rM3hNK2oyTlhBZ3BwNFc2ejRQM01HVXVUK2IvQnFlNmxCMmht?=
 =?utf-8?B?eVpRVVUrUUpKSmcrZnRac0VLQS9MN3RYTDh3ZTF0T1o4SzEvQm5qbVBJRURw?=
 =?utf-8?B?TlFoZHUxWFBXSk4rZm9BMDBXL3JUZm9oMEhuNy9yanlxaTVDczV5WWpXeldJ?=
 =?utf-8?B?Y1ZUQzA5YU5RWVJrNG4rWkJ2aytrVFVMaEZtcERtcU00TTR0ejBxRExPTS84?=
 =?utf-8?B?NUo0aWFEakdSM1gvK0FEdGNFUURsZHByanRLb1JWdzlvUVlvdXVNTmVWUnJI?=
 =?utf-8?B?cklUcG9GM05GMHpzR040Q2pIUW0vTEs5d041L281dWhOam9KOG5pZGkvQWgy?=
 =?utf-8?B?UmpTYzlhTzRPZW1jd3JldEhCdjh2SExMQm92Y0k4ME15VW52Qldvbnl4cW1H?=
 =?utf-8?B?THVyLzNFT1BkcEgyeUk4bi83SkkwOW1OZGg4M0p0YUlSNkE0NW5VTXZ6V2hn?=
 =?utf-8?B?VVZCMWYrOGZocGhMUFdvSHAvVGI1SitIWW1mcnY1MU1SZVVRWk15enlrcXpF?=
 =?utf-8?B?NG9wLzdyT28zcWo0RG5wTy9GTnNzRnEvNm5ESWJkb3FuMjVVY3VKQXdwT2xJ?=
 =?utf-8?B?Y2N2TTNETHlGTnhCQmowNFdxa2I5eVBsVnlqclQ3RHhaVTR4OCs4OVpHNWx5?=
 =?utf-8?B?U3RHQ3dWUmhVRjBlSFlRVWpndllMNjY3ODVFWk50RFBiU3dtVlpFVTVRWFZH?=
 =?utf-8?B?ZFFTR2k1eUM1dVE5am5QTHdYU1hlNkF0b2wzckQvbGMyR1Bja2JSTXdLU3lY?=
 =?utf-8?B?VnVuUklEellFWHZ5M0ZhTHhPbFNoQmpPVmNkZkp0bVBZWTN6MWJSUUF2b0M5?=
 =?utf-8?B?dFpqVStJZGd4NlYzWExNNEQxTHVXS29UQnNlcVRyeDlSVXVYeldvamhqOG41?=
 =?utf-8?B?TTRkMnhvYTg5Y1Fiak1PZGQ0M3RvNWdUdmQvdW9UVjduLy96YWVNQStleWFN?=
 =?utf-8?B?aDRsTFJFYnBxbG9EYTJ1WWxnZXhFMGdEMWw1U0RXK0c1bmFKVWE5NGg0UTBQ?=
 =?utf-8?B?MkUzanNnR3JIcUFJYWc1WnNCUk9kTVR3WDB5MUlEdGYvQ3ZVNVcxa0I4dk55?=
 =?utf-8?B?dnlwMTN4RExsNGlZY2tpVC9GZEFyTU5Hd0RCRHl0ZWNYWkZhTG9KVUFzNmxT?=
 =?utf-8?B?cDBOL3NQYkJnbkY4SzBQODh3dE54NG9iZUVpT3VFVE96SmtXSytGTHB4dUdJ?=
 =?utf-8?B?b1R3Zm1Vd2lsaWZSdEhPUldHcFVOVTF1VGlCUWNoVEkwcHpjWTJwai9KdXZG?=
 =?utf-8?B?eDd1ajJNbUlUVC9jRHlhM3hmeExtM041TlE2SVhTbnN2YTIxRlV0Z3lMOXFG?=
 =?utf-8?B?bkRjbGxHbXJMVnNPQUQ1bkFsVk5laGRIeWJ2cEFqUEpmVTI0NlYvQUxMRTlF?=
 =?utf-8?B?bWtHM2hWR2t2eENnTVNuUTk2UGdaQ0R3Vzc0NnIwbmVpTkFKS1J4VHFISDUr?=
 =?utf-8?B?T1hkUkxpOVJ5amkxTForWlMwUXE3Y1dIRTVFK1lmd1grWEk0WU1PaXpJV28x?=
 =?utf-8?B?NUdCYi9NSmhpdjFCUU05MUxZV0N0dFBhMHBXaGdTa1B1bFpLOHJ4cE1ZWldC?=
 =?utf-8?B?dENmTzBNM2R0N2RzalNEdGtyWTltbElUdThOekJsK0dZSzJxY3N0VGZSUm8y?=
 =?utf-8?B?UHIrNWkvYndLc0J4MlhIMmt4amNrRU9PaWI0RGlNOHUwMmx3RTJVYTZTL2dX?=
 =?utf-8?B?TkZmaVpKbUFXdk1STDQ2QVRWMTdhelp0eE15MTFqbWtDcjR6UTBmUUpQYmNo?=
 =?utf-8?B?UDJhTzVHTFFIUEFNc3MwdmpMZ2lkMlZXS21yVXVleEsvTTUyM0lraHJjTWkz?=
 =?utf-8?B?eXVnSlE4UTJCWUN3Rk1zQnBwemE2a3VBSENENk1CTHIxbzdkM1MxQ0FHWG9M?=
 =?utf-8?Q?aoyb8hQR6CK7+JrS7O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6577e10-9c04-49b1-b2b6-08de75cd42d1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 06:55:58.5906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEt314JxNrDkGj+5IApC1KV78ycmu9tU/jpbckRg1pgJx3djpPbQAEbdhaiTU0dqoGzsH7gSsZveW1so7gOeGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14462-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arighi@nvidia.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: A4E491B3902
X-Rspamd-Action: no action

Hi Tejun,

On Tue, Feb 24, 2026 at 07:00:48PM -1000, Tejun Heo wrote:
> - Add the @sch parameter to scx_init_task() and drop @tg as it can be
>   obtained from @p. Separate out __scx_init_task() which does everything
>   except for the task state transition.
> 
> - Add the @sch parameter to scx_enable_task(). Separate out
>   __scx_enable_task() which does everything except for the task state
>   transition.
> 
> - Add the @sch parameter to scx_disable_task().
> 
> - Rename scx_exit_task() to scx_disable_and_exit_task() and separate out
>   __scx_disable_and_exit_task() which does everything except for the task
>   state transition.
> 
> While some task state transitions are relocated, no meaningful behavior
> changes are expected.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 67 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 45 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 33e9129a8073..5d13b9b93249 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3107,9 +3107,9 @@ static void scx_set_task_state(struct task_struct *p, enum scx_task_state state)
>  	p->scx.flags |= state << SCX_TASK_STATE_SHIFT;
>  }
>  
> -static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork)
> +static int __scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fork)
>  {
> -	struct scx_sched *sch = scx_root;
> +	struct task_group *tg = task_group(p);

Without CONFIG_EXT_GROUP_SCHED we get this:

In file included from kernel/sched/build_policy.c:62:
kernel/sched/ext.c: In function ‘__scx_init_task’:
kernel/sched/ext.c:3228:28: error: unused variable ‘tg’ [-Werror=unused-variable]
 3228 |         struct task_group *tg = task_group(p);
      |                            ^~
cc1: all warnings being treated as errors

Maybe wrap tg inside an #ifdef CONFIG_EXT_GROUP_SCHED or we can do
SCX_INIT_TASK_ARGS_CGROUP(task_group(p)) directly.

Thanks,
-Andrea

>  	int ret;
>  
>  	p->scx.disallow = false;
> @@ -3128,8 +3128,6 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
>  		}
>  	}
>  
> -	scx_set_task_state(p, SCX_TASK_INIT);
> -
>  	if (p->scx.disallow) {
>  		if (unlikely(scx_parent(sch))) {
>  			scx_error(sch, "non-root ops.init_task() set task->scx.disallow for %s[%d]",
> @@ -3159,13 +3157,27 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
>  		}
>  	}
>  
> -	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
>  	return 0;
>  }
>  
> -static void scx_enable_task(struct task_struct *p)
> +static int scx_init_task(struct scx_sched *sch, struct task_struct *p, bool fork)
> +{
> +	int ret;
> +
> +	ret = __scx_init_task(sch, p, fork);
> +	if (!ret) {
> +		/*
> +		 * While @p's rq is not locked. @p is not visible to the rest of
> +		 * SCX yet and it's safe to update the flags and state.
> +		 */
> +		p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
> +		scx_set_task_state(p, SCX_TASK_INIT);
> +	}
> +	return ret;
> +}
> +
> +static void __scx_enable_task(struct scx_sched *sch, struct task_struct *p)
>  {
> -	struct scx_sched *sch = scx_root;
>  	struct rq *rq = task_rq(p);
>  	u32 weight;
>  
> @@ -3191,16 +3203,20 @@ static void scx_enable_task(struct task_struct *p)
>  
>  	if (SCX_HAS_OP(sch, enable))
>  		SCX_CALL_OP_TASK(sch, SCX_KF_REST, enable, rq, p);
> -	scx_set_task_state(p, SCX_TASK_ENABLED);
>  
>  	if (SCX_HAS_OP(sch, set_weight))
>  		SCX_CALL_OP_TASK(sch, SCX_KF_REST, set_weight, rq,
>  				 p, p->scx.weight);
>  }
>  
> -static void scx_disable_task(struct task_struct *p)
> +static void scx_enable_task(struct scx_sched *sch, struct task_struct *p)
> +{
> +	__scx_enable_task(sch, p);
> +	scx_set_task_state(p, SCX_TASK_ENABLED);
> +}
> +
> +static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
>  {
> -	struct scx_sched *sch = scx_root;
>  	struct rq *rq = task_rq(p);
>  
>  	lockdep_assert_rq_held(rq);
> @@ -3218,9 +3234,9 @@ static void scx_disable_task(struct task_struct *p)
>  	WARN_ON_ONCE(p->scx.flags & SCX_TASK_IN_CUSTODY);
>  }
>  
> -static void scx_exit_task(struct task_struct *p)
> +static void __scx_disable_and_exit_task(struct scx_sched *sch,
> +					struct task_struct *p)
>  {
> -	struct scx_sched *sch = scx_task_sched(p);
>  	struct scx_exit_task_args args = {
>  		.cancelled = false,
>  	};
> @@ -3237,7 +3253,7 @@ static void scx_exit_task(struct task_struct *p)
>  	case SCX_TASK_READY:
>  		break;
>  	case SCX_TASK_ENABLED:
> -		scx_disable_task(p);
> +		scx_disable_task(sch, p);
>  		break;
>  	default:
>  		WARN_ON_ONCE(true);
> @@ -3247,6 +3263,13 @@ static void scx_exit_task(struct task_struct *p)
>  	if (SCX_HAS_OP(sch, exit_task))
>  		SCX_CALL_OP_TASK(sch, SCX_KF_REST, exit_task, task_rq(p),
>  				 p, &args);
> +}
> +
> +static void scx_disable_and_exit_task(struct scx_sched *sch,
> +				      struct task_struct *p)
> +{
> +	__scx_disable_and_exit_task(sch, p);
> +
>  	scx_set_task_sched(p, NULL);
>  	scx_set_task_state(p, SCX_TASK_NONE);
>  }
> @@ -3282,7 +3305,7 @@ int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
>  	percpu_rwsem_assert_held(&scx_fork_rwsem);
>  
>  	if (scx_init_task_enabled) {
> -		ret = scx_init_task(p, task_group(p), true);
> +		ret = scx_init_task(scx_root, p, true);
>  		if (!ret)
>  			scx_set_task_sched(p, scx_root);
>  		return ret;
> @@ -3306,7 +3329,7 @@ void scx_post_fork(struct task_struct *p)
>  			struct rq *rq;
>  
>  			rq = task_rq_lock(p, &rf);
> -			scx_enable_task(p);
> +			scx_enable_task(scx_task_sched(p), p);
>  			task_rq_unlock(rq, p, &rf);
>  		}
>  	}
> @@ -3326,7 +3349,7 @@ void scx_cancel_fork(struct task_struct *p)
>  
>  		rq = task_rq_lock(p, &rf);
>  		WARN_ON_ONCE(scx_get_task_state(p) >= SCX_TASK_READY);
> -		scx_exit_task(p);
> +		scx_disable_and_exit_task(scx_task_sched(p), p);
>  		task_rq_unlock(rq, p, &rf);
>  	}
>  
> @@ -3385,7 +3408,7 @@ void sched_ext_dead(struct task_struct *p)
>  		struct rq *rq;
>  
>  		rq = task_rq_lock(p, &rf);
> -		scx_exit_task(p);
> +		scx_disable_and_exit_task(scx_task_sched(p), p);
>  		task_rq_unlock(rq, p, &rf);
>  	}
>  }
> @@ -3417,7 +3440,7 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
>  	if (task_dead_and_done(p))
>  		return;
>  
> -	scx_enable_task(p);
> +	scx_enable_task(sch, p);
>  
>  	/*
>  	 * set_cpus_allowed_scx() is not called while @p is associated with a
> @@ -3433,7 +3456,7 @@ static void switched_from_scx(struct rq *rq, struct task_struct *p)
>  	if (task_dead_and_done(p))
>  		return;
>  
> -	scx_disable_task(p);
> +	scx_disable_task(scx_task_sched(p), p);
>  }
>  
>  static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p, int wake_flags) {}
> @@ -4662,7 +4685,7 @@ static void scx_root_disable(struct scx_sched *sch)
>  
>  	/*
>  	 * Shut down cgroup support before tasks so that the cgroup attach path
> -	 * doesn't race against scx_exit_task().
> +	 * doesn't race against scx_disable_and_exit_task().
>  	 */
>  	scx_cgroup_lock();
>  	scx_cgroup_exit(sch);
> @@ -4691,7 +4714,7 @@ static void scx_root_disable(struct scx_sched *sch)
>  			p->sched_class = new_class;
>  		}
>  
> -		scx_exit_task(p);
> +		scx_disable_and_exit_task(scx_task_sched(p), p);
>  	}
>  	scx_task_iter_stop(&sti);
>  
> @@ -5567,7 +5590,7 @@ static s32 scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  
>  		scx_task_iter_unlock(&sti);
>  
> -		ret = scx_init_task(p, task_group(p), false);
> +		ret = scx_init_task(sch, p, false);
>  		if (ret) {
>  			put_task_struct(p);
>  			scx_task_iter_stop(&sti);
> -- 
> 2.53.0
> 

