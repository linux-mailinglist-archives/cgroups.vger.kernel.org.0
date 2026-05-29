Return-Path: <cgroups+bounces-16448-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPPTB1nXGWqjzQgAu9opvQ
	(envelope-from <cgroups+bounces-16448-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:13:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0AE6071FA
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B06F329C1AD
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 17:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C715639282C;
	Fri, 29 May 2026 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KeNTl0ho"
X-Original-To: cgroups@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013010.outbound.protection.outlook.com [40.93.196.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE1A3921E6;
	Fri, 29 May 2026 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076847; cv=fail; b=d7ppUjkGjKXMUrnuwUyNJl9yPHD9BAzefHBR8mzcMln4qynXejY/hCKEfuvydCIo7wreoN6lzpHWdipioam2aFfaztKqigcwzQYPtgBCm/gHuNO++BJ48SkA+riDtrDI4PSlwQoThPZA/nf6IPl2eV/CHr0suyCHtKtPyse1+zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076847; c=relaxed/simple;
	bh=IqZFvDmat9TiUq+B1YTORaqf9zkEp1JA6SO7WmzdyOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t4C30zAFQFvHuzGaiuF14BK44DTZV9zAhuF0pu3/9zTPODMDGGqDqwMjKOou8sYJ6KeUxstNZzwk3psKiXtiRKui22Rgf393sCjqbNewk3d82h/7XG9fEHXNlkWoRUM8IgcHJIArBqxiS5DraHT6E0SpD1kR+xn7OKit5u8EMVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KeNTl0ho; arc=fail smtp.client-ip=40.93.196.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PN1m+mEv4Q3Izz51eu1sniphuEAJUW5NTqjVRD+1Zi2ukiwpHJhlenIuPg5p1/ggWlW8erqCBcVQa4uPk7P3mBg0Z23H6WxkQJQc9MDLhM19MVwy6T0x0IoJQfQ0j/7cbuF0ha9vR2vnsAUNSNX5sYNdrxWNP/vhdGTtDBRiQa9q1oFFk4jsf5uiuRix+OU9OpTLS3rtdL4W0SRVrNABekL/ozqOGLNHfvS3GV3s9H7J1OO4RWFZdtf5l61UnCgRhRZ/GKtO2S6vUS/ic+2i2hiAXWAhSaYbdxOjOgDFSdkUvj3b2lMxN/fFG5zyAbdTyB/fG3jTM8zOHJhqT6nSfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1NdEc8EFoSv8gDJynk8YxJXTJBMkiTq0KnOaAqSXEs=;
 b=eZZqBDnFjprj62hXGarymaDqVrQZCJzj9W7c2dHl3PGULIM1WzX53WsKpkiwXt80Owa0IyIko4zYviKZGvXKpsIeqEvCWK9Mx2KNjri0hB4VID+67BEjB+3mL3nZOTQ8a9swd0UF/dIEpZM+UoGVrrpa3e9+2sg53LdjGBcb+rqJH8/NURn2ziWL+e/HV5bs9WqduQuYisi7KWElC1nmqIm2nJ8Ft43okN/I0ez/OAltO9pKEXFjD4J9GwSByHnSAFOwOA62hQKwKEjoilR08xbQJ24FkWCYIFqNviwParwcJAH3q5CR/PNmHX6tZJOZGqsXIO1e1jxwIZ8nMgmbnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1NdEc8EFoSv8gDJynk8YxJXTJBMkiTq0KnOaAqSXEs=;
 b=KeNTl0howmNusRdjPBbDoy0+xLyp4GYemP0G+0kOvxZOE9p+lrhV0py861lmJQM3Rx4QXzHGMYYDtj1gadDou7zlWZlkyHGalvmwx0vaTN6yeXBCTqg9RCOAz58WTjUfA+pmmorJNCcYNYv+qFaQSWhGkr77CL/9PqC/4JrPN4bPq//o3EEpIZfxfkD7IWljDlq+01WXJ8A6lpSFccyrvZh4GVY69gN6BE17qYhjA5qto8aLJaI5gDEE4zdj/fGciPK/uUWnrAlMRfru0enAbLCUJmj94By5OZj0S00jgcMdzxFKkG7JoDbHOEG+jdgwOhs+8BiCuLOr/okD9hPkTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 17:47:17 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 17:47:16 +0000
Date: Fri, 29 May 2026 13:47:12 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Waiman Long <longman@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] mm: don't allow empty relative nodemask in
 mpol_relative_nodemask()
Message-ID: <ahnRIDBk4bQ3xX2q@yury>
References: <20260528124133.c88c27b11a8ea0ef05e494f7@linux-foundation.org>
 <20260529152616.2308736-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529152616.2308736-1-joshua.hahnjy@gmail.com>
X-ClientProxiedBy: BY5PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::29) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: f96b4a13-134b-4adc-a94d-08debdaa5267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|22082099003|5023799004|11063799006|3023799007|6133799003|56012099006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FTznmb+lWo7WJxr2DT6zArJSd9ftF+Y+BvZAF8G14y/m/Dk5K2jZMWAPOLxllqSLfPRpBeN6x+9fmsh4ULoI+w8McR5/5Vht2MBYkK4811Bb6qXVNEd+W5A0Pgqw1cpZv9+mLc7bcGSyHlvEgnLbrIaZoJHE5k666x5WWfNba4pBJtCtAXI6euIvmNRQfxpcYI5J3QJ8WS8n8pyAn2lkDvRn3pf7QHy22QlZ6bjPaFn2me6IojEOST8z/U+TT5qAZ4R87ZAIIzXIQcWnI5SMKv0aLqKCHyKdZQbbAeSwgIZF0DkO1GYdgayD3b0aVf19r8cZ/meMU/YgzouPW5UwGMcdE+sfFpxYptM2NL69DXo8VEv1cQKg7dYZFZ6hf+hvXJj3ENmPS3d4+Yq+ICjpxZ1Kf9a+yjpir0Z+85/mS7QRWHM97YpbLQe/xi8o0J+Td6ZQjK+shhDjm+B2Cwm3N8uMlfP6QFrFMdkbZEhwKPazlECtOWRGicPRN+pHCSQzP4pAv5YXN2MuToSU9YYk1V77WOZpYoqUywygyJbDQ0I1VJiEVpexKtZgnEgnZo81TJmbt1rnRKiLNksUlj5/D+wCZHWRhf0IY8Ym9IJF8oBwFvhKR3L/y+JmGIdXZopdfbCoMIAVeeWCm6v8l989JXyw5xmQrz/MMhQx0oBy2I8Y1IpWHzt8+1ixD7m/JMJ/RsMkmUekC82TTZppS9FRVQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(22082099003)(5023799004)(11063799006)(3023799007)(6133799003)(56012099006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TJH3jxjwixCGr3Z/X3g8gg/E/Kb2AItNfzZzsShb5/p7L3kRiTW0AB6iCTZK?=
 =?us-ascii?Q?wsIDsP+0+5lvOfDlRvTZNLhy5Smn8eSqixWy99ZVijmIV9m+TVGFZQAewOge?=
 =?us-ascii?Q?LIl6p+nUThUGAlkOLKds1PxiLYkSgzCIBOLDO930CgxKRHN3lhioR1IYNJj0?=
 =?us-ascii?Q?PgjCoAPssX8gbNZ3ZG42+gUIOVKCbjtrFO8CbnyeT7sc/xX1nw0lZG8BNaBW?=
 =?us-ascii?Q?Nd+W6r71/+UUAAc2Pc2l4/ZbgepJSH7NL1QVSOx3zF1O5zDw5zUyjzx20CyP?=
 =?us-ascii?Q?noXXpCsS/ELI4J4tbR+aPLBbMPH8f/Qac6VMXFAn/qbcgDPBXz20hpf1bF2G?=
 =?us-ascii?Q?/rVUN4W/TSFFbAREwKmLWRJwGvA+4d8cOwxCmldgGRkXKpw7Zolxi/HrWSpq?=
 =?us-ascii?Q?lbW89UsX65xbordanznClf3hek3SEXtopX3TMUbBjaXnx/sKza+vC8tGdvm8?=
 =?us-ascii?Q?R5XXL6UjoNvhP8pvj+x8+DY411suImWs6CJjTzKrdj3iE8YvBoSI2fE9egHW?=
 =?us-ascii?Q?rlqvxk9/IZGaArjmKlkCz98njlHlD771ocvA90AfDKN+uHhc2ElkNGuWQFZF?=
 =?us-ascii?Q?FRclJDsP50N0sNf9znb3q54fQM9K1uxkUFUvKFkeIppQ+fbzj52D0tUjnIe4?=
 =?us-ascii?Q?JxFu54swJVTd0ZvEtc5iEwUNog++PSMb041yaViLwy0fgc/auI+NB4q22Ml7?=
 =?us-ascii?Q?oLxjRSWmwUI2CRJwQAHFj5oussLY7Xw/7AxAMIggPEZoHFmBu/nXgouxgyGP?=
 =?us-ascii?Q?7CNV2Ra3Hp5KKlqQKOTxhfHYkT15C/S1rdqG11W0pDXvU60mciMlYR6EyBBA?=
 =?us-ascii?Q?CrydE+e2RkwQKd5SjTPaZ9T3XCJekR1De85wz5GjHaafV6mahvovmVaWvjL1?=
 =?us-ascii?Q?h+67Opq/UMOME8i9QDzd7/qYjCCI0pkPRCfa8Jik8FqqdAOjb1E9Vx5RDtRQ?=
 =?us-ascii?Q?u9UVSKYCu+/0smRv6bAghVr9uIhYdJ43/CyhctlKptcDOPyNsbVNe7tgYPVz?=
 =?us-ascii?Q?AZoOT7pkjbNXDT92aWgU1V6C+CspMJyt1Qq/G9Lh+XWQgayA0fOV88EW84jN?=
 =?us-ascii?Q?SJOW9uP2U6RQ4DMBguF9YOV08wl+KD6WNXH0Aj7XuFbXppj9w7NQ5vwCn2Q7?=
 =?us-ascii?Q?1Jsd3cuEs6a2p4itUxloWAaCkTBU17HDQjT+Qt6yJVROaoOfl+slIR+qAsZg?=
 =?us-ascii?Q?VOyGsO/5erl+EgItNiq/vdwd5FAGrfNM4tJw2jlT1YwQtfc2I6xMNEyTlYZP?=
 =?us-ascii?Q?iJM97y3hsJETfVMbtvaGQDdqD/GpA8eE7U1onzeKhMYioDfxwyneHtq9eHf5?=
 =?us-ascii?Q?I3bkwFPs605Cb1+lgEBWCnm60YYpgO2GyQAcvl/ZCjFI+WBErAEbE2ewTwWn?=
 =?us-ascii?Q?QVhweXsPOR5NtQmVu2Ywth+8v5b947hfwollMm6xyhOKgYMATPyNT6Q1d3fi?=
 =?us-ascii?Q?hXvoY9wntnMz03Z0MUfTVNjI6h9z5+rSHLxnseTdu1GQX6S6RhqGjaTxzjwH?=
 =?us-ascii?Q?IH0eS/gACT8DJT1E3bWF4GGPh+6nMsoXSTN0SJdF+YyB2mnXXoVg1eIqsgOJ?=
 =?us-ascii?Q?lJ44brkn7dj5cdGPPQKFmIfeMi8rXZx7HJipo/Q0f/pp3UUj8Bff7qylZQVk?=
 =?us-ascii?Q?uHMStCL/DSveN7eYuNa8UIn3BH+URQdA16zaghmB44M34BCv/PSiV1VNQbI7?=
 =?us-ascii?Q?MYFVV17DKwBhh19m5X63V0d6XkIewLWXL1AezR7Kjc6cq0LnuU0nIP/B7UrP?=
 =?us-ascii?Q?T3ZeXJmmFoc7Sowq98NMTCEA/9XLoKbH/Xsl41BQwOOzvcwqZwIM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f96b4a13-134b-4adc-a94d-08debdaa5267
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 17:47:15.9375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+4EqFpvWl6NWvft7EYXXfa4nTcDj2/kLfl7TQswLjt5CTjKwMKXblTxy9j1aketEYS/Zxz+jwxuQFl4ozgXGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16448-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,linux-foundation.org:email,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,berkeley.edu:email]
X-Rspamd-Queue-Id: AD0AE6071FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 08:26:15AM -0700, Joshua Hahn wrote:
> On Thu, 28 May 2026 12:41:33 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Thu, 28 May 2026 15:03:37 -0400 Yury Norov <ynorov@nvidia.com> wrote:
> > 
> > > Reassigning nodes relative an empty user-provided nodemask is useless,
> > > and triggers divide-by-zero in the function.
> > > 
> > > Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> > > Link: https://lore.kernel.org/all/CA+0ovCgxbZkXa+OU8w3s84R3KNPNxxRfmsNR-udh+afQBbGNmw@mail.gmail.com/
> > 
> > Thanks both.
> > 
> > It looks like this is very old code, so we'll be wanting a cc:stable in
> > this.
> > 
> > > --- a/mm/mempolicy.c
> > > +++ b/mm/mempolicy.c
> > > @@ -370,8 +370,13 @@ static inline int mpol_store_user_nodemask(const struct mempolicy *pol)
> > >  static void mpol_relative_nodemask(nodemask_t *ret, const nodemask_t *orig,
> > >  				   const nodemask_t *rel)
> > >  {
> > > +	unsigned int w = nodes_weight(*rel);
> > >  	nodemask_t tmp;
> > > -	nodes_fold(tmp, *orig, nodes_weight(*rel));
> > > +
> > > +	if (w == 0)
> > > +		return -EINVAL;
> > > +
> > > +	nodes_fold(tmp, *orig, w);
> > >  	nodes_onto(*ret, tmp, *rel);
> > >  }
> > 
> > I suspect we should address this at the mpol level - it should never
> > have got that far.  Hopefully the mempolicy maintainers can have a
> > think.
> 
> Hello Andrew, hello Yury,
> 
> I agree with Andrew here.
> mpol_relative_nodemask is called from two places, the first being
> mpol_rebind_nodemask which is the calling function seen in the bug report as
> well.
> 
> The other place is mpol_set_nodemask, which has a helpful comment that notes:
> "mpol_set_nodemask is called after mpol_new() [...snip...] mpol_new() has
> already validated the nodes parameter with respect to the policy mode and
> flags".
> 
> So it seems like we are missing the big if-else if-else if block from mpol_new
> in other places that should in fact have it, like mpol_rebind_nodemask.
> 
> The approach proposed here of just checking whether the node weight is 0
> won't work for a few cases, namely for MPOL_DEFAULT and MPOL_PREFERRED where
> empty nodemasks are actually allowed. So what should really be done here is to
> do the full policy-nodemask checking section in mpol_new and call that from
> mpol_set_nodemask as well.
> 
> Thank you for taking a shot at fixing the bug report, please let me know what
> you think! Have a great day : -)

Hi Joshua.

Indeed, quick and dirty shot.

The problem is that nodes_fold() can't work with the sz == 0. In
other words, folding to a 0-bit bitmap is an error. We don't check
that on bitmaps level because it's an internal helper, and it's a
caller's responsibility to validate the parameters.

nodes_onto(), or more specifically bitmap_onto(), is a different
story. In case of empty relmap, the function actually clears all the
bits in dst and returns.

I see 2 options to move this forward.

1. Simply disallow empty relmap in mpol_relative_nodemask(). There's
no valid cases for it, AFAIK, so the nodes_fold() limitation looks
reasonable. We can consider it as a new policy.

We've got 2 users for mpol_relative_nodemask(). In mpol_set_nodemask()
we can simply propagate the error; and in mpol_rebind_nodemask() we
can throw a warning and do nothing.

2. Follow the spirit of the nodes_onto(), and in case of empty
relmask, clean the ret mask and bail out

I'm in a favor for the 1st option, because empty relmask looks buggy
anyways.

> The approach proposed here of just checking whether the node weight is 0
> won't work for a few cases, namely for MPOL_DEFAULT and MPOL_PREFERRED where
> empty nodemasks are actually allowed.

Not sure I understand this. The mpol_relative_nodemask() is called
only if MPOL_F_RELATIVE_NODES is set. In mpol_rebind_nodemask(), if
both MPOL_F_STATIC_NODES and MPOL_F_RELATIVE_NODES are set, the former
wins. How would the RELATIVE mode mess with the others?

The mpol_new() code seemingly tries to disable empty nodes in case of
MPOL_DEFAILT and MPOL_PREFERRED + MPOL_F_RELATIVE_NODES, but obviously
it doesn't work very well in the rebind case.

Anyways, I'm not really deep in mempolicy domain, so please educate me if
I miss something.

Thanks,
Yury

