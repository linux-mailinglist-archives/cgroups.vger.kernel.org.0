Return-Path: <cgroups+bounces-14432-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLRyLeVroGk3jgQAu9opvQ
	(envelope-from <cgroups+bounces-14432-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 16:51:01 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 169D41A91BA
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 16:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0DC331A759F
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 15:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F7640F8E2;
	Thu, 26 Feb 2026 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rux/Gls6"
X-Original-To: cgroups@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013051.outbound.protection.outlook.com [40.93.196.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE13B8D65;
	Thu, 26 Feb 2026 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120288; cv=fail; b=SLZPlwZXd/OptTFJzh3zFxn96zop+pPNV3Q7KhQy8n/2dJRkaZuYGHwsvJOImLUiyzVlqU/goObcfqwTq7ex1KxL85/l/rNo7ICGhvxCnaGkg4i2KWWGR2WPLqtNQewzATD+HoSNvB/4YCUBxEH0IbI0RkBrGO696Bfblo/tAC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120288; c=relaxed/simple;
	bh=HLRXB7Lr6ahlMCFxXOKrZf3KG+kfiXutXGLkdZKf7jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ExeosXFQmxixFBZ+3t2ClNb6PRsda6oXQHJUCh1Zlfo3kdzLJsh3xkU3hcNj4PkKRHRSyaIg+X8J4iJzSLlJaSnqYs0J5RP2N0zuoI2KotNUYhIOycWDOMgjWbV5kyCLLv7KW6rZqCNERncTQm8eMXAlWNjxFES+4xyq0v26GpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rux/Gls6; arc=fail smtp.client-ip=40.93.196.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lt4SDWixj3rND08h32JYW/EG1FKTFh+YBZdxoqCC8yp1wCJalBajm+3jqZYjn2Sr8kI2HH0HTk8FCiWuWrR4Hu594IcXSk1pqznZpsX+xcFg5Y3kbjBTDcmod0Ila6Zw2NadQMDSCOgRyPno+VvmvcfmUSTRWmvUYzhQPIja0XGjMaugh/FOYe/868wdMJw7717hkGE0qoat6nEOo3XANC9zq0eNKePcOzB2qlRmvJ0kZ3OOyfaBbbJQCbtDsADCqTzDCEBobonhI9KwAz23VPvjX3G8GDhciZIyXwbvr6XuhyjEB+XI0YWv9rUfkSMhbiKm7AM+RNshM1zW8T3IdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LY1K3xoaoMVjOP5kjMJorOaJEvo+3GprBHdZEgQEk3Q=;
 b=KjhiN2znhFWthS2G4LPHK8xXNK56MhEG7uwzOoz08eVu0cIWnxKQ/hCb6sz5jMt+DCGKlWyqE+/DFONWF30nDm3Njru4ApjeGp0/O6Liywn5VG0Jm69BkUxYrFRNY6w8bha0/BRSOJ6Te6D+MkqB3mHtVK3niZpI9mSbnW66EqS9gwHJacImpCn4esZV2yMgfTkQzYzTxRaJTG+8LVx1KOrLLFkec4SA3k5jalAIFygOXSbQ/73oGCjALs4BbViilLJWXLhcgSLywKQ/cB+3kLAAiWwEJ4wbSOuSwlZS47Pt9JqqRhW9yUaWuno0AKM8cSN2V9GvOvR5TYwpaEjkwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LY1K3xoaoMVjOP5kjMJorOaJEvo+3GprBHdZEgQEk3Q=;
 b=rux/Gls6gXzp6KMuni1Ulcq+kv+myfALQe1DjlY5YGfYF0p4Ta8g92v/4b8KvCrPsCDJVoGvqy5jZcAEgkLNgXlcnb43COiJ9Hm5u9gtkhg3E4U7jS1FLt6UkYS7WzWl7PgJbCyQgXs9TzTRPj6RaXXE90SK76qEDvwGbH5ct4ArW9oQwOGs6mGTcNpm9Cb+tScy4wigNDHPEQpaQkVaNZqfFbYzgzoVLJA0gGSoh59yt00p9Exy2XIpYIJX5UbZjNAkawsgbOg19xZTy1W8nMIbniJfQNvKggWczaCpQT8LIT/e/vLTz0S2pE6adwszsNI0xbSIDdMu/veJBD+2tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 15:38:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 15:38:04 +0000
Date: Thu, 26 Feb 2026 16:37:55 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	void@manifault.com, changwoo@igalia.com, emil@etsalapatis.com,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 07/34] sched_ext: Introduce cgroup sub-sched support
Message-ID: <aaBo0zDdwPNpGQaI@gpd4>
References: <20260225050109.1070059-1-tj@kernel.org>
 <20260225050109.1070059-8-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225050109.1070059-8-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0163.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 352ff9d7-ce4a-4519-6c98-08de754d07e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	cvnoMfmaa8NgtBGEdG9HetQxf2jhoqlLhFizO4WpwBrK9rp17Os0SnvDrHgSFMWG/zsAytlnl+/5ET15dQbUol77ngCjHLwBp26MumS8WOGnTqT9y/2ZQ/ygegB1sWzvPBFVGqlH62RhgOcysBYfcm5jZJjusXlrABGDzabFJ1RnzJKvH504DLj5gpvuE11Mv9AE7lFYrfc/+9QxfY/RCAx6h8WHxJKDNdL/VwcOoAF2EIwsWRtsebDFlfaKQOsxSiBR/osnVp9iVv+gcO/Ps2Wwpwwif3T7Y0KTZVsM80AczccnMawZWOlrRtEdijWW3kwBKZG+9r8M0Lv5fthEuWIg+h2/txqqlkW03Nhg+4cAROdpdwbEqSbcBIPZ41rLCogvuyxjOSniTSeXP49WsN5QCCqDiHNTg1h2gknmKvHRLM37EVh00X7pDosIqgsS33dkQaIt0l1wMlSjKEXe3SjC2qkjG84lVRkzxsWQY7B1TLuX7zhJ6FHiK9Cf0jkH3LyAcYIfz0mwqIcp9y4LUbC3HXJfgHugqrEgd5q7jAzJrkRX0puA6wSzYJUddCRVrbJBqJ3JSBvyeUNvfchxuM8S1cZi4+6lsPNow8QzU5dy6QlOl5PX2xbLH72JOXzbdoGOjJs91j/s7lsA45V/1wUqlxP7oCu9TzjLdNfB88GhnVfPXO8HJ+PYKDgwAFqSqf1vv3Jphjl7bMCxSj8By+yGNNodTuMM/oUKDELB5q8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzF3ZW9zejBqbCt1WklwdmFqQnZhaFljd1Mrb2xuSzc5ejZ3c1pqTEgzRkFy?=
 =?utf-8?B?Qzc1NW9SRXQxWlpnUE5EQkFTRnNMdzFZa2w4cjdRSFFtc0tkZWhKa0lnUVZs?=
 =?utf-8?B?U0hUVzZhWEtITGZrZGpvdEJxTE95UTRuUGlhSGNRbUFvT1A1UWlMblZNQ1B0?=
 =?utf-8?B?S1RXMnZzOWlKbVZGU1h5VGJnSHpBd3BDdmhTTkJFaW16TW1uMWVsRGZwZ2hH?=
 =?utf-8?B?WjBPaml1eXQzQkQzYTlKcjFnUGJXMnJJY3o2UHh6dHpObTd5UXlURm90aVBC?=
 =?utf-8?B?R01Oa1MrNG9LcTRlM2tBK2NYTThDZExYNDBkdjE2M3czbnhUSjE4bGtzMUN4?=
 =?utf-8?B?dDRGTEdPaDArVXhrQndTQ2NGQzV6Qm13Mk9XdHJKeDdOSE85bFRubW5IWWdV?=
 =?utf-8?B?M2ZnRUpvb3NRWG1ZNDNnM0tmRHNXelNDeGFHeC9WQ0xaSUhLbWY5SGk2MWpR?=
 =?utf-8?B?OUV1Rjl0L08wdEx2eFNJcXlMNmtOTEd4em96aHBad3VFNUpQMDVMQlNNa0kx?=
 =?utf-8?B?Qjg0NHpCTWlsLzVTbmJRakhNRmpVbTBOR080b3dmdFhNNlhoT2RjTVljUitU?=
 =?utf-8?B?M3F2TEZZUkpFaEVQWm5vZEhydmxZYms1RFBsUUkvRTJmdVV4VXVEME5DK1FF?=
 =?utf-8?B?cGNzdzcwdzlOVnJOZ3FPVzdRVGhOWTdsTE9XTUx6T2hTUi9DLzEyem9FejVM?=
 =?utf-8?B?RlNvb3pJSE5qeEMvWDMxbVNDbm84OUNhcUJ4V2RudjRJY3VpOGJrUThlbjM2?=
 =?utf-8?B?SEFkaXpiYmMwc0lkUE9FQUhlc3NpUkxBVE8yaWxHOE03S1JuUzVYMlduZzdC?=
 =?utf-8?B?VWdqRzFEQ3B1VFNoQzFDM0ZOa1I3S1lCVDVDWFFOWDNRN0JjS2hseWZnMDdH?=
 =?utf-8?B?N212ZFkrajFDOEh0YWNHdWdVNlVRbDhicE1LOGRub21YRGFzc0dHTXArSmdj?=
 =?utf-8?B?YVpqc2lwNTNaYjNBNitLek1GQWE4cWFaTWRSTHNhS0x5ckNIakJzT1oxRHZ4?=
 =?utf-8?B?Z2JTR2Y5QnRNT0pGelpIdHlTb1ZXNWhsZ0cybzJjUFg0MlBnckwvZGNWN3o4?=
 =?utf-8?B?dEtjSklhSkZIWXkrazBuNk5Lb0NrQjNyaHdiOVRCdmg3MEJJYjQyREZFQk5q?=
 =?utf-8?B?bUxLNUJQOWJ5cWx4RFJsUjYwakhTajczZHQxcW84WlVNejZNczYzS044MHM4?=
 =?utf-8?B?VXFNaHJoKzlpbUttcFJIOUZtbEZVUHQwY002KzlGNENZZ3VVZGYzNCtYeTlr?=
 =?utf-8?B?RTJJMUkxMTJXblZPMENiODA4c0tUUG50RzdYZXBlTldhQnN5MG1TRzR3UW9H?=
 =?utf-8?B?cVUvL2pCZ0JOclJkWXVmcGVwTW1xZE5FOUpaMUZzeHptS2RWWEtucFZvK25E?=
 =?utf-8?B?RmFsU3k2SmJHcTVGcHZyQWlBbk0xYlh3V3Jsa0QrcVZ0a0JVVUlESDlZYnZD?=
 =?utf-8?B?Qy9XTFh3U0pxbjFWK3FadnpTNGVPeE1ZajBjbDU0RDVUODNEV1JZcXplOUh6?=
 =?utf-8?B?SWxvYUY1RUZ4WnJDVzFsMTlZMjlGWDFJTE9PTGtyenpzZkRPcThWakUrYzNS?=
 =?utf-8?B?QlhDWk8yZWVNM0RJUy9UcVhhQ3VjNmNHUUJCdDd3VTBHa0VJS1ZvSDdJdjha?=
 =?utf-8?B?UURoWitSL0U3MjdIN2QrTmM2NmV6WUVXUk9mVzYvclhzQ1ovREhYWFREbVpK?=
 =?utf-8?B?bW9pb2dmNWNlSU9HTjlRYmlJSW9Bemt6Z1lFVWp4Y05ONTVtTklLRzdidmFY?=
 =?utf-8?B?V2VWQUNPUTJpQXMvanNCS25NYnVCcDNMcXdrRjBUZFQ1TGcxUXZTRDhDV1pT?=
 =?utf-8?B?aVF0QUpBUGVzeGdsQzRPVlVaRk1GZEZZUUhUb21SU21VLzRWblpLUUdKcUJF?=
 =?utf-8?B?dHFzOTVLZEFGdGRWbjhSV0ozYkkzemtqZDRzcDE3aXVMcHhXaExQb2pLSzVk?=
 =?utf-8?B?LzRtNENSaXNBY3p5blhjY3pPWFM0amFnZ1BkNVZwZElXNEw3QWw1alBYeldu?=
 =?utf-8?B?MWtqajlOWTJFK1ZJTGZCeGhQNlcrcnVrdHE2N1VqSHBqRmpLOU0xSHRMWFpF?=
 =?utf-8?B?QmN0emdyVi8zZ1JXcFc3aHNhNFROQ0NPQkZWQWtBVWxQU2VITnRwVmcvUzVP?=
 =?utf-8?B?TTJ4WTExZmREWENDc0U2enlscGRxNUEwaXRNU2RPR3pxL0l4SmlydUgvR21N?=
 =?utf-8?B?VFdTWjZWSWNlWGN2WHROakRiQlhOb2FSalRRRnczN2ZNNHJORCsyZ1h4R3Q3?=
 =?utf-8?B?ckZpbGE4dzFYVDdQbVVTYy92ZUdVbjMxSHR2TlBkTnNLM1haVDNsWG1Da0Fw?=
 =?utf-8?B?alNMVVFmRXFSMHZaSVBhd0hvdGl0SGxjVkM5WjVVaTFMZXlzUXlQdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352ff9d7-ce4a-4519-6c98-08de754d07e7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:38:04.1280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfYwyr3uSPXQeJFsHxQ6zANuN7WpZRM5CeZloOkFyyp8dd8G/Vju5hm2BVTZQJTW93NBGDAcjZJXki+YbkuIbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434
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
	TAGGED_FROM(0.00)[bounces-14432-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 169D41A91BA
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 07:00:42PM -1000, Tejun Heo wrote:
...
> diff --git a/init/Kconfig b/init/Kconfig
> index c25869cf59c1..96ba2fa08883 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1176,6 +1176,10 @@ config EXT_GROUP_SCHED
>  
>  endif #CGROUP_SCHED
>  
> +config EXT_SUB_SCHED
> +        def_bool y
> +        depends on SCHED_CLASS_EXT
> +

It would be nice if we could opt to not build this. Also, if I disable
CONFIG_CGROUP:

kernel/sched/ext.c: In function ‘scx_dispatch_sched’:
kernel/sched/ext.c:2454:52: error: ‘struct sched_ext_entity’ has no member named ‘sched’
 2454 |                 sch == rcu_access_pointer(prev->scx.sched);
      |                                                    ^

Thanks,
-Andrea

