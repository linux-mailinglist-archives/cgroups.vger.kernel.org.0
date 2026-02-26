Return-Path: <cgroups+bounces-14434-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAv3JC9woGk3jgQAu9opvQ
	(envelope-from <cgroups+bounces-14434-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 17:09:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBDB1A9B27
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 17:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 116AA30E9130
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 15:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3499640F8DA;
	Thu, 26 Feb 2026 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O6DxWl3R"
X-Original-To: cgroups@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487352D595B;
	Thu, 26 Feb 2026 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121177; cv=fail; b=H7hPtuB7UREeaBjjuSugZ9Z4Eh6uizHy2GhTqHVN5FJk2sqSrYhHl1SdFk7ZC2B4DxkdQTFvVnPJszmoFyR8lu20SZUaeL9ringV6rZxh5tKLaXiGJf7vVL9909euiGbvF0UP/kJ1ty7LiOk7Y17/eErALwV7wUgDlNs/0mqp90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121177; c=relaxed/simple;
	bh=xWqR2doOtD2Rm7pkLY8azN5vajKo/YXz1iSXugxX+Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NI/wAaMrzWZP0DUPiUDE6zJ3ob3jpRoUVQx1elyMHD5si6D/0oOn/YRUyjPN4fFPHx7Lt8JkBCdjbJ7xyA682WhUOF8yRyA+dWow3ZI9akbEIlICIY8cwWmfJ+p7iLamOz8cwgsMFOjIetq7tBZxlMDx6nrJV/tCQ0OE6zitDHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O6DxWl3R; arc=fail smtp.client-ip=52.101.43.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djhsLxV0vimqp5iCVnsDLB9eBDIPWaW0q9px+Nn8EQ1xoANvTx6r1hjXxoRwuXIlbDXVvxJNFkHWpXNYL1P/wvKLmJgI4dwTOrdN7VWENgVv+gC/dFuR4kdgt229+M0KL8SIljJEXeAPyv3o3bTOUQY2VRRsF4IixXn70gAS6NMlCeYMMcmmtfm73d0dPTs2NaGC632OOncRkNC7tz3HcHophGK/R5sxjoudkEqHBTv1qKdLqZ3gpOopbVF4Tl/860J6DyzaQfBO9Ma/J1LFg6JJKvtsqHXPzr18L/zdOM7VRVBot5CqszGAGZTikt8QB52DWzPH8kRaC+fKxholvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNpgjNG4vDPh34o8KzjavlhhgqG1z8naisS8ge4NViM=;
 b=F3J1MztxltdK/e8N0nV2tXwtDGOmxmV4VXIdMDpTcFc2JVwYUbLwMcLg3aCCHO/X8DXh2/eiZiVI8VR2JUpMg/RUz/h+dS5U3tR0XO6Akb2nFvZkzmXhlXwpHXp5yNXDwCvckGDxago2I4iCRHd1Ixav4YeSSsjO0cXlpemPChkwzsYJcxXT+Quj54d6yaCjXdzHG99PwQACZ8cKCk2il9UGUcsaKekM5GTA+tTzjtbrSGampJi+3BOyNM+9AHdO4mRf1dqgcMFQkFC7puLUCihMbp+e2+rp3upusru/3opArbOxJg5WNgEtI0zyjfHboCWf3vBc8ZD0JCVZx9cFAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNpgjNG4vDPh34o8KzjavlhhgqG1z8naisS8ge4NViM=;
 b=O6DxWl3Rn6HmdIdbc70f6oelrRotj6NL4DXS6aen3Afxn316FBHYX6AZiOPg8+kWrYeo4RgYhX/XLQAsxJ4YtS4XsJlPUcmldc7QiAtivqinJyyXScLvBLXn3HmlyB/khOAdfdZ11Yp7sKtYR/YM7Ca2Rsp+EN0VWO5uvTDCCGt6tUDy0nJOmfTd0Yt03oIvD9s+XV0p/zIOiytS8IKKFnxofowMjf33Pivr4oZJsOgpdA1JKFlTRVvp2e0NJRA4Z16ysh5IatwLZidd9dYTwWnnJ1696Fi+cpwSfQxGX+bwoF5CUccjVtq6ixkEzqbrs2VbwDngD/csdHV+3oWUPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB7764.namprd12.prod.outlook.com (2603:10b6:610:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 15:52:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 15:52:45 +0000
Date: Thu, 26 Feb 2026 16:52:38 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	void@manifault.com, changwoo@igalia.com, emil@etsalapatis.com,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 07/34] sched_ext: Introduce cgroup sub-sched support
Message-ID: <aaBsRu4_4OXv4d7-@gpd4>
References: <20260225050109.1070059-1-tj@kernel.org>
 <20260225050109.1070059-8-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225050109.1070059-8-tj@kernel.org>
X-ClientProxiedBy: ZR0P278CA0116.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a45b86-e8ad-4abe-ffe5-08de754f1539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	sbBvV28vvtVhp2FFVh0ITqG9zPRst69cd9AhSZiBFztj0zyERmi+ANxK1zQRKKY2qLETxKoMnGb1Oij9rd4XmVGOoYEXPSUhN7aboMYO2jO4buFCeUu10Kl+ZsX5bwB31M8bc8tiLls1rpUTf3sFsSBcquh9O5Z7D+my+yW87tgLHgUB+npZCrIuVoN5OEDnYfSToD53SuaK8+yL0BzXQdWFD6tG15b29uG/T+zr8ROElMkls2uKX72RQtUjgCU/YtCEJOwMJ1IuhT79XjDRjVkMAgt4znUJePka0sxhXjztvCfopdMrkGEblFmj5+IWG6KOOYLj0MSgHKeYaEvnIWKi4xr3Phcaii4TuuJ/Yg8sudLrd+9E+np78vQgDIBum5U2FRlF0LPQIGlg0eBF+Fkx3JwbLwn+9ZJbJAVlfHKC0LmcRM6NsGJBBHpuDldDsHZSbxTqEK5JMdBfrO5nHyUZOK2Ht5XylzVQKQpcNwYhmNkW3Q6y2+mt86HG5LAuyyHiuAcIzAssdL7eV8n4cYuJNGGt+YIRCvj2+fAOpRFoNlU+jbuBUXdzmo2/qK2wLZffzC9MRrVgjUmkxdpLo9OnExBvm6++makwPdDSZ/6/vg/jeJlERNiVKEPQKblGBiy9KNfttYzOr4MjgxHT0nQS56Hyo8/ElLxR1ElYnbNgrMXcSo4a7w4T6FXCovvHgmClSYf/hFaucEK8Mr6jPi+PuH37VPUSmDNz7fgWK20=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6yLN7qvM7C4UPoKfdKdxDjqh6yb8QTacwVL1yUkpmAcLV1K8SMfJ/XR625KO?=
 =?us-ascii?Q?NAGSXrPR0SrmvdJzDbBJwBibKlV87iRNpTcAOJZJq1ZRElW3C7o3byowNNZZ?=
 =?us-ascii?Q?+NDlZVYfN44xOn04fHlGVpFv4i1oXsf9UE+qXKKwEHQzDbPndfKpI9UMfu56?=
 =?us-ascii?Q?gEJlyV2uQDF2rcyuaCuoYHAQSrl2XjZHE5LAkeWEmKGlzms1L+wBQxY3YuIA?=
 =?us-ascii?Q?Q5Q/vW0scvxnpTGtcUMGW66JF5VNq1UCLuO9XpGSlEZOb4MpPiLaN8Prn+Qq?=
 =?us-ascii?Q?hrIGFmZ2Q7N52OKzZwJu94C3ZKKRFSD0Nez1046Zee+3B7nCZYVsn7ACn+mS?=
 =?us-ascii?Q?U+RQ4h43rFzC9xRf+m+CIyXmlheOD4faOCOgtAv+hJ1uo5OLGJhwPnRgS/x0?=
 =?us-ascii?Q?HI0OlwsSwLdlxKR/IjZQcw9LfyFbKhPvqGR5UQMWZ7cC6+djlP6bKKbTLDCc?=
 =?us-ascii?Q?MXzZyy4nHLs0KKIaQGQl+X2cMAUhqetj8JSwok1JsZ88T3vr1SzobHTuYUpR?=
 =?us-ascii?Q?f1RvgODeHKcxhoEq4Hz6U3TMmvSGuX9+r+YzfM3mgf1EOSfY04WDlBkPv8oC?=
 =?us-ascii?Q?nJfSz+CmDg1JyxInrgMwqeIQoFCF39mptkoVW5qV9P+9p5xTw7BD71AmFMig?=
 =?us-ascii?Q?t7YzAipkMNZxxI/GvFHomaoDGk5EHt5aCPOkrYXAUYVP3KpRU0VbFs422w9G?=
 =?us-ascii?Q?wI7YFVSrUT2yl7EERpQGg22DmnZq1u7IA2O+hpOIM50gPUtYJtCNeF7nXZH7?=
 =?us-ascii?Q?oMkrC2g/acut3MsBEAc5p9GhqFKoe3KG8GgxopbSoHzdRsnfROGGJk3R0zp8?=
 =?us-ascii?Q?5R8lxb+aSbnF+iSQWcTCSNUWhoBU4Yr1nZZurwpzTnXzBsr/4bwMLjLLB+BB?=
 =?us-ascii?Q?gaPplbRnJoegxlm7zCECN+9I/dnz8t7FX84/TL5cBMYURmKo0FVoX0k+lMhp?=
 =?us-ascii?Q?1ex1IQZfT5ti57za9AFqrbtBXaeTgDaLw7K/U0frztOvDbUyyoq549siC7YV?=
 =?us-ascii?Q?QZkKxhT+DQ8eEB6RznuAyp2P7PDyrOfXymbOw2dcSySXwOwFEzmf+PesaXxk?=
 =?us-ascii?Q?816J8fUQ4GXj2gIOBQ3GRgK67I1nERlf2GMmTUCWY7K+kb4Od3HVbK9ElDzm?=
 =?us-ascii?Q?isNCTahZmzpMIta8Wd+ZnZTKWFEyh157zkaTJ6HcMfqvaWVX2I0hDEIwciIz?=
 =?us-ascii?Q?pBvcLN7B/UVOT8IQsoo/h8J7dPnEfvILpUjOsXcct1vtXQMIjX4K7gJz4roL?=
 =?us-ascii?Q?2cCBl39ETje5OrqhAl0GKILrm4piSlDPPx9KHhlx97lIShex9hhUklFtFWeD?=
 =?us-ascii?Q?ueT1m0BStHcfLI2xCtz7FYZSMT/rfufWp6NOEY8h1d0aPBr9TJHACHlwDJS7?=
 =?us-ascii?Q?F77Xo1Bk0wxrNM9ae/NEDVmyMntshyAbZF+RBunxiJpOzFRajgcXlwILaDcq?=
 =?us-ascii?Q?ReOu4HaxArTxL/gQiaWpY3fz1bfd0sQ5l/RjYqPrrcbrwhzVg8hzjCRzOQdo?=
 =?us-ascii?Q?SJLz0yE3YYIWNbg+T+fjO1JPGYvYQLNUMPWJyDvMJOcoPPTyti9GcNbXDjfJ?=
 =?us-ascii?Q?9p+KgRF58NsmLvaUukLdQDJOpbL3vjo4JIQIpVPIWYArbIa6Lc6MBgVeXLFO?=
 =?us-ascii?Q?zqyb4r64fEGWrzeXsKSe0Bej/pbhCojjHeJz5BRXHAkB6NKGwYOXKIz2x2Lh?=
 =?us-ascii?Q?FxnIshc6COGI70eptu59zt4lpFi9qXx9y4ZgA9nZ9eEKrLiyrdwGqLHz/xG7?=
 =?us-ascii?Q?/PbaKwFSZQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a45b86-e8ad-4abe-ffe5-08de754f1539
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:52:45.3321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5WUY1YrvzaNtSr/YO1b+u+YAJ+bbeNkMLHDkpWseMtFmw5pjv8LnFaDGqEvqksuV5NZoIbA1d6NE+gtC2phpOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7764
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14434-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 0FBDB1A9B27
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 07:00:42PM -1000, Tejun Heo wrote:
...
> +/**
> + * scx_is_descendant - Test whether sched is a descendant
> + * @sch: sched to test
> + * @ancestor: ancestor sched to test against
> + *
> + * Test whether @sch is a descendant of @ancestor.
> + */
> +static bool scx_is_descendant(struct scx_sched *sch, struct scx_sched *ancestor)
> +{
> +	if (sch->level < ancestor->level)
> +		return false;
> +	return sch->ancestors[ancestor->level] == ancestor;
> +}

This seems to be used only later (patch 31/34), so it's an unused function
for now and may break git bisect. Maybe we should introduce this later?

Thanks,
-Andrea

