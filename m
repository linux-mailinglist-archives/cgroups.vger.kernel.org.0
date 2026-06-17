Return-Path: <cgroups+bounces-17015-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K054EZQcMmqhvAUAu9opvQ
	(envelope-from <cgroups+bounces-17015-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 06:03:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 958186965ED
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 06:03:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=ozuDjcCh;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17015-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17015-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D0D53072F40
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 04:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE11B3128DF;
	Wed, 17 Jun 2026 04:03:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013069.outbound.protection.outlook.com [40.93.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A3D2F8EB1;
	Wed, 17 Jun 2026 04:03:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781668985; cv=fail; b=DsuD+3at9jyHEALVVNb6/Rj5pwi+j2K7QWe9jyJVHr41zM+CTS3+R2xYwthtte7r9E2cyPrBpfitcFfN8vEI8h1evCuMUwN12haNEa/p9lJSa40+l8X0zTN2Cde5PCz2i1IT/dpUhCwS7gvDWAbxsJkw8yJgCN0Ppt5CQyEJHDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781668985; c=relaxed/simple;
	bh=yV08sE2+LG9scfa9oj61C3SrmwPdC70yUH3kcF8gvdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=USYNGbpga3rNVS3bDK1v3hS0LQ9WyguPIzM6bnfnyLimKeo2TicasQ3hdpX9MPw2wgaEbO8N7f7qEBWfH1qvLtpkkoSNyJnH8PzqRpj9TuNdb0D+9jWSD3yNq5PuBuLRtYSFUbjYmBxJ5s0I2nzWUuQmSNoZlfu/82+2d+ae0oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ozuDjcCh; arc=fail smtp.client-ip=40.93.201.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8aeupI7OMtTdzJD7Uu+FSe8BbRdbBC6cTncg6d3luIg+JtSWjJSk0KhFf6UYZtEaEcLmyDcqnvz/cfVNi4Jo3n9Wm+Ps9iMX5zD8e++cKJ+5cblAlkv89cw8DIdI5Ww1ner2MI4hUa1oWoysWeFV8wQx46+Icp1ENDJH3XESSc8psgzRXzgUFEid2t9QXkq3ww4zvxkffeC0/LnPspCa74kb/FaTCs3+G+kf/+K4zMY9jiF3BW/qizJtmlojWwWw3JTkf3ZvUfjv+gnp2V8ZiPkSQ5QnzPx0t3teehaTQRQHPjtGudt9Mb4GlHMUVebt75JIBWn1HhwBxL/kHmjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FB69vVfVPBhIwbobVxhKuOXjePDausT/B1ctopKcIw0=;
 b=XmJtFVBcc2wBWeNJC0ru0+tO94lpyw3CQMl1lhFyh6tB0855gurwcTewVpmT8kn5nHrilpA5sEOFwuJdmZT9hKe/n+bOQJapdhj37BWsPeJpFHL0A5PmrSVVoJY61m3Cc1BfBQQL624z5U7wNr1CAVtdgPXKh0XwSnO3jsB9DQHiWo3Dxm8Y74MFkJu4tZ+90OgoikcoXPIqchNGgsBWnxX2QB515pnn6tguJuz8gvuUWR3yd3r3LV3ErBCVESUfxsmUC2ozOMSyytiKZG4AASSiWYvJXXQmBW8KfK9zaiNuaxdb37OWa1ewa86ddOHYNrj570Vyx58XxrlyX8QOnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FB69vVfVPBhIwbobVxhKuOXjePDausT/B1ctopKcIw0=;
 b=ozuDjcChD6ZpuzEBokN8YLTk4A3jIhvRolGTz1MMuSw+OfeufQ5RHFiIfuToI8lh8W+uA5CHbw4V37w/zEFJZHLElwR90fSFTurCsJLFrlPI2OZEVyh5y6kjT1vwVO9/+/oZNR3XFiiBhsWdKwnfnUdPA+dENrUKln91iJpZB+EOQXIYXnnVcxHkbgy8yIeItopm+VROJMukjdLlbLDAkjtp6epTvytsyXMJpnx+MsF51X7Y/f/1XvIF0roLTce/D2vp8smPJdO72g++zoSuDX+9aCdMT8/gpOtbyz1CBL+AuX+wlRnWKKBps/IbVfyrkhtJmmwm0VR7F4STE/URlw==
Received: from CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 04:02:55 +0000
Received: from CH2PR12MB5001.namprd12.prod.outlook.com
 ([fe80::89e3:6df0:de90:8dfe]) by CH2PR12MB5001.namprd12.prod.outlook.com
 ([fe80::89e3:6df0:de90:8dfe%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 04:02:54 +0000
Date: Wed, 17 Jun 2026 14:02:47 +1000
From: Balbir Singh <balbirs@nvidia.com>
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	damon@lists.linux.dev, kernel-team@meta.com, gregkh@linuxfoundation.org, 
	rafael@kernel.org, dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	ira.weiny@intel.com, dan.j.williams@intel.com, longman@redhat.com, 
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	jackmanb@google.com, sj@kernel.org, baolin.wang@linux.alibaba.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	muchun.song@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev, jannh@google.com, 
	linmiaohe@huawei.com, nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com, 
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com, cl@gentwo.org, 
	roman.gushchin@linux.dev, chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <ajIb4DJdLGPbMB4V@parvat>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <ag6XyvxR-NU5rGn-@parvat>
 <ahOqzpzAua96HVkn@gourry-fedora-PF4VCD3F>
 <ah47NNhuiClgGCdn@parvat>
 <ah6bDNxlB1zBUnzN@gourry-fedora-PF4VCD3F>
 <ah-0CyZurn5D1ezY@parvat>
 <aik_ddHymus2DJ6D@gourry-fedora-PF4VCD3F>
 <c1b66e7a-bb95-4295-8193-55ceadaaa578@kernel.org>
 <aimSzvoJDrpeQsmM@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aimSzvoJDrpeQsmM@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: ME0PR01CA0080.ausprd01.prod.outlook.com
 (2603:10c6:220:233::23) To CH2PR12MB5001.namprd12.prod.outlook.com
 (2603:10b6:610:61::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:EE_|IA0PPF73BED5E32:EE_
X-MS-Office365-Filtering-Correlation-Id: ef50179a-2e7f-46fc-45e1-08decc254ded
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|56012099006|11063799006|5023799004|22082099003|18002099003|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info:
	LX/0QUaZzdLTRoGjNspt9VKVAEJbth1SqxwFY/9ESxCysxQXkrLZz5JVjxQ4CTpxZ1W+ziH/cIqGRDtpfj6uFgpZUYsS/zATGcyzj6vvk+NlZ0mgprThl0l3EtTYeNO5t/aCPhzHCqPEHyxsGk9i7mfm3/XaXJSySYQzyWw+Mx/vub/n0TQnys4AtzXx9NpHJAmU5EidVXckol5lkaaNeownWOC9s6IPGzBFOvIMntV3I118RgCIAj99ITWFiHdwyTj1S/FXOEv5lgj69GnhTFDJLAtIwcfTAIrvqDjCnIuD82mMkWPtp6T99zfjwzX10ydPotFWAlEwQYiK7ctr3lhCDnzCC6txKs4lwd425vNxpcgqb3mPsP5wE2EA3Vz2yO56mUA3xOmEkGoGwNfOESMCSKimfGzAflYfOorCRJ4jdK7JDZORfXR7roVyruktanMytrSMFFGuFHvUoEwXHlPuMKoOpLunaVDINMvH//WGGZ5ddiwOcb5jjnMrkltNH3QQ3Byy8z9OFle0dd/QYk73Oe6/372gbBld00EC+ObUlh2y9s2A7cb6cwHVDpazKV1iyhDg9qV7/nGz7JMkyvwzaWlJdban0GKWPmX77veewzvD+QDtpIOh4BCikDeOKU3lMAd9fAuUJkxV+klnG5xtBP8Ucdlc2NItN9gxsIy/WaLeNUP9FCfP3C+xyGJW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB5001.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003)(3023799007)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1gzM2c0TWhKbk00R1RUdERaM3dDeTNaVWpjY3VWb1AzTDJpQytBcWpYRTh2?=
 =?utf-8?B?aGNsQWV2OWN2OW5TRHl5M29PSVYxR0w0V1BsSVhUODJPT09sVXJtdGd4RFpj?=
 =?utf-8?B?cnRiZmpCcjlCYTBuaGI4T3lPd00wNmZRUHdtaHlQL3loTzNFMUZ1OFplODVX?=
 =?utf-8?B?Z3NsRHQxb2tUTitzZmw4UUhtZGxqUWdKbWE0OFhmYmNoUjVSTmk0aUw0ZmNp?=
 =?utf-8?B?ZSswYkl2dks4V2sraytzNGc4aG0yUWpBRktnTlhtQmk3NGFoRW1zV2FvVy91?=
 =?utf-8?B?S3BLMTdKMGJmR0I4bU53bHNSS3dFWFVsWGVFRWhmZU5oYU9pc3h0NmI3SWl4?=
 =?utf-8?B?eDZhaUtBWEUrM3BmczRFVkVLakRPSXFyVUlEblNsUmpMRWNhL21GaEM3Sjgx?=
 =?utf-8?B?VjFmdnUweTRZcG1WVnRFVE9jSWJmRGxkdkJDNHR2b2V6YXZXcDFoTlRFQmhG?=
 =?utf-8?B?QkN2Z2dzb2NKUjlPMVFTaS9NeTk4WDloek5mcmlXemJlRFQ4U25BMW5vbk55?=
 =?utf-8?B?T0ZOeTVyOS9ZL2tOTEdhL3Y4M2Z3Q3NvMDZraFFCTWNKL3F4NHlyRW9Ka3No?=
 =?utf-8?B?T1Z6R092d0tsVFRkYlFKVVBUaGJ1YXI2QU1YcVg3bWE5Qyt3MHdwZUNLWkFN?=
 =?utf-8?B?V091cFVIcWJnNmUwc1FLVFQrQ1RYWmNUbXFnSVJVa200eElaQmxtbGZjdCtE?=
 =?utf-8?B?cVRZdUNYMG1xWVNwZFR4WFkxTDlKNDJFaXBBaHM0bGFKUVpCRnEzdVNZdHlx?=
 =?utf-8?B?cS9qUUxsL2VIUGlvZGkyYjMyUmNRZWNYMTI4a0FjdGlqU0VyWjE2UTdtNm5X?=
 =?utf-8?B?NzRWVWhvQ0k0QllHS0FaNGUzalVPSVN4RWI3YUxQSEwrNGlEU2x3SGxQN0hw?=
 =?utf-8?B?WkJXU3pjditLelZPaHhYRmZTZVc0K2JWVnNWRGdhQlVGd3N1bGNRU0Y1cFpj?=
 =?utf-8?B?dG4zUVB2VnJsMXdRS08yNlFWVHg4RHZPS3l6c01EM3E2Q3VibENQTHdGVVZo?=
 =?utf-8?B?dlFyamFjWVEyTlhuT1ZvUTN4dkRqUUhaeno4clVHRHdBUDBJM3ArUUo1SjZP?=
 =?utf-8?B?a2dxelpwaGc1LzBEdHdIY3RJcWkwOWFYdkVCb2JSN044YjZDNkpJWWplZDRX?=
 =?utf-8?B?TnpaSlBEOHdkTDZkbms0dlJWbWVTYnA0eVpvWGpwbVRLWE84QmErM2dRSU5Q?=
 =?utf-8?B?bkpzWWRsQUc0RWdjYzcxbkhpZHRqUHNGZFNyc0pMRDEyV0lFT3dYdTZ1TVVt?=
 =?utf-8?B?VVpuOXphZllrOGVGd1NPSnJKT3lsUXZYcHVsR29QakV2STcwQ1oxaVd5U29h?=
 =?utf-8?B?WnZhbFhzdi9sSUdDL21PRFoxMnRPRzlMTlZRQmtqL3FHc0RPUDVyZytKT1c3?=
 =?utf-8?B?bk1lSitHUUp3VWJFM1NSWUN3VDE5MG45NmdOS0hLNTFrY2pOUk1tNzFnV3hX?=
 =?utf-8?B?NEVWSWlERDFvSmk4VGlBc3JwZUExS0xRYWZGZmpkWjRrQnpsWVcxVUxLN2xt?=
 =?utf-8?B?dXhxbjZ6VWdkME9vWlB2aWdlRFRvLzRGc1RjbXA2Wk0wdExPSWQwZkErZ2VD?=
 =?utf-8?B?V0VIUGl3UXpLR2pDMGh6SjgxZTR3S1oyQjI3SkhTWjUxZWg3Z0VtbFhJV2xq?=
 =?utf-8?B?RXFxdEdENXlLNmd6UGE3bW0vSHJEUTE4aHZkazdCeUlSSkJ6RVdPYXd3NWRr?=
 =?utf-8?B?UHFCb2hVdEdHUERtUDUwc0FQTHJYRTJhL1RGSjN1SEVsemZXc0xwblVjRllG?=
 =?utf-8?B?UXYrTTZRV0crcVVsSmUveDUrVEtuT3hzVFNHRG12UTNIOEhPNUtjdk01Tm9o?=
 =?utf-8?B?Ykh6REZxdkJ5U2dQSDJqcDYzQ3NNTVZBRjZST1hESk1aU0RnQWZRWUFjck1l?=
 =?utf-8?B?LzhGYjdnZWQvMXRHK3R6cEhWaUJmMlR3Y281SXVKNGJVeTZQSGllbjJBZGNk?=
 =?utf-8?B?YUtYRmgvaC9xMzNpT3ZnVzhvZXBlVGYrdStVU1h4Wi9WaWJBL2h6K1NGengx?=
 =?utf-8?B?TG85SlN6OU50M3UybUt0NFZkdEdjSGwzU1VZOXNUU1RmLzFTSVlsODJkVmFv?=
 =?utf-8?B?WjU4OFdFZkJGajd0N0ZDNFBjUXlBRHljWnZNdW93ekVvdDdScjdsQ3h1aFFK?=
 =?utf-8?B?L2JDcVFNUXN3YXF6bEIzaStBdEZ6eUIzRFFVRUZNcExGekJjSVlDaWQ0UURN?=
 =?utf-8?B?bUpWS2JIdmpZSGZNdWNrZk5HTDJ5MFpXajZiVUh3ZW5TLzFLTkFGc0dmay83?=
 =?utf-8?B?SVp3UHZuWDl3eXdQcjFmNGpNYk1MSEs4N29nSjI2QmNRUTVxL3NSdzdmcnh1?=
 =?utf-8?B?djJBRHdDbUVXNzJrSTFBcVJ3bDFRalBvL0VxWUJoaE5RUUw3cmROdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef50179a-2e7f-46fc-45e1-08decc254ded
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5001.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 04:02:54.4739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpKV9YIpgmvq5DJ+8nn525AIpdnxq3cYhoBtCJ7MmnCSh1572oL6iYkzUecQ4LHu+q9swBJSAdlbL2Q4ys3e7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF73BED5E32
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17015-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gourry@gourry.net,m:david@kernel.org,m:lsf-pc@lists.linux-foundation.org,m:linux-kernel@vger.kernel.org,m:linux-cxl@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-trace-kernel@vger.kernel.org,m:damon@lists.linux.dev,m:kernel-team@meta.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:dave@stgolabs.net,m:jonathan.cameron@huawei.com,m:dave.jiang@intel.com,m:alison.schofield@intel.com,m:vishal.l.verma@intel.com,m:ira.weiny@intel.com,m:dan.j.williams@intel.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:lorenzo.stoakes@oracle.com,m:Liam.Howlett@oracle.com,m:vbabka@suse.cz,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:osalvador@suse.de,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:ying.huang@linux.alibaba.com,m:apopple@nvidia.com,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:yury.norov@gmail.com,m:linux@rasmusv
 illemoes.dk,m:mhiramat@kernel.org,m:mathieu.desnoyers@efficios.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:jackmanb@google.com,m:sj@kernel.org,m:baolin.wang@linux.alibaba.com,m:npache@redhat.com,m:ryan.roberts@arm.com,m:dev.jain@arm.com,m:baohua@kernel.org,m:lance.yang@linux.dev,m:muchun.song@linux.dev,m:xu.xin16@zte.com.cn,m:chengming.zhou@linux.dev,m:jannh@google.com,m:linmiaohe@huawei.com,m:nao.horiguchi@gmail.com,m:pfalcato@suse.de,m:rientjes@google.com,m:shakeel.butt@linux.dev,m:riel@surriel.com,m:harry.yoo@oracle.com,m:cl@gentwo.org,m:roman.gushchin@linux.dev,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:zhengqi.arch@bytedance.com,m:terry.bowman@amd.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[balbirs@nvidia.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[balbirs@nvidia.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCPT_COUNT_GT_50(0.00)[74];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 958186965ED

On Wed, Jun 10, 2026 at 12:37:34PM -0400, Gregory Price wrote:
> On Wed, Jun 10, 2026 at 05:00:33PM +0200, David Hildenbrand (Arm) wrote:
> > On 6/10/26 12:41, Gregory Price wrote:
> > > On Wed, Jun 03, 2026 at 03:00:01PM +1000, Balbir Singh wrote:
> > > 
> > > Notably: slub.c injects __GFP_THISNODE internally on behalf of kmalloc,
> > > which causes spillage into private nodes because slub allows private
> > > nodes in its mask.  I think this is fixable.
> > > 
> > > I have to inspect some other __GFP_THISNODE users (hugetlb, some arch
> > > code, etc), but it seems like fully dropping the FALLBACK entries and
> > > requiring __GFP_THISNODE might be sufficient.
> > 
> > Sorry, I haven't been able to follow up so far, and not sure if that's what you
> > are discussing here ...
> > 
> > After the LSF/MM session, I was wondering, whether if we focus on allowing only
> > folios allocations to end up on private memory nodes for now: could the
> > __GFP_THISNODE approach work there?
> > 
> > Essentially, disallow any allocations on non-folio paths, and allow folio
> > allocation only with __GFP_THISNODE set.
> > 
> > I have to find time to read the other mails in this thread, on my todo list.
> > 
> > So sorry if that is precisely what is being discussed here.
> > 
> 
> So, I remember this being asked, and I didn't fully grok the request.
> 
> I'm still not sure I fully understand the question, so apologies if I'm
> answer the wrong things here.
> 
> I understand this question in two ways:
> 
>   1) Can we disallow PAGE allocation and limit this to FOLIO allocation
>   2) Can we disallow [Feature] (i.e. slab) allocation targeting the node.
> 
> 
> 1) Can we disallow page allocation and limit this to folios?
> 
> No, I don't think so.
> 
> Folio allocations are written in terms of page allocations, we would
> have to rewrite folio allocation interfaces and introduce a bunch of
> boilerplate for the sake of this.
> 
> struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
>                 int preferred_nid, nodemask_t *nodemask)
> {
>         struct page *page;
> 
>         page = __alloc_frozen_pages_noprof(gfp, order, preferred_nid, nodemask);
>         if (page)
>                 set_page_refcounted(page);
>         return page;
> }
> 
> struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
>                 nodemask_t *nodemask)
> {
>         struct page *page = __alloc_pages_noprof(gfp | __GFP_COMP, order,
>                                         preferred_nid, nodemask);
> 	return page_rmappable_folio(page);
> }
> 
> At the end of the day, this all reduces to `get_pages_from_freelist`,
> and at that level we don't really care about folio vs page.
> 
> __GFP_COMP is insufficient to differentiate between a non-folio compound
> page and a folio, and __GFP_COMP is passed into __alloc_pages_*
> interfaces all over the kernel.
> 
> Trying to detach these paths things seems like a horrible rats nest /
> not feasible / will create a lot of boilerplate for little value.
> 
> (I did not fully understand this request when it was asked, I do
>  not fully understand this request not, please let me know if I
>  have misunderstood what you were asking).
> 

I agree with this, any changes to folio only allocation could then be
easily adapted for N_MEMORY_PRIVATE

> 
> 
> 2) Can we disallow SLAB allocation.
> 
> Yeah, but I think a better question is whether there's a difference
> between alloc_pages_node() and kmalloc_node() when it all just sinks
> to the same fundamental code in mm/page_alloc.c
> 
> Maybe there's an argument for something like NP_OPT_KMALLOC (allow slab
> allocations on the private node w/ __GFP_THISNODE)
> 
> On my current set, I don't implement any explicit filtering at all in
> mm/page_alloc.c - the filtering is a function of the nodes not being
> present in the FALLBACK list and only having a NOFALLBACK list.
> 
> What __GFP_THISNODE actually does under the hood is just switch
> which zone list (FALLBACK vs NOFALLBACK) is used for the target node.
> 
> For isolation w/o __GFP_PRIVATE, we're removing N_MEMORY_PRIVATE nodes
> from *their own FALLBACK* list and only adding them to their NOFALLBACK
> list.  That means to reach a private node you MUST use __GFP_THISNODE.
> 
> I realize this is confusing, but essentially we don't have to modify
> mm/page_alloc.c to get the __GFP_THISNODE filtering, we get this from
> the fallback/nofallback list construction.
> 
> 
> Ok, so how does this flush out in practice - and why do I call this
> filtering mechanism fragile?
> 
> consider kmalloc_node() and __slab_alloc():
> 
> kmalloc_node(...)
>   └─ ___slab_alloc()     mm/slub.c:4406   pc.flags |= __GFP_THISNODE
>       └─ new_slab(s, pc.flags, node)
>           └─ allocate_slab(s, flags, node)
>               └─ alloc_slab_page(flags, node, oo, …)
>                   └─ __alloc_frozen_pages(flags, order, node, NULL);
> 
> Slab silently upgrades the page allocator flags here to include
> __GFP_THISNODE - even if the user didn't request that behavior.
> 
> This is exactly the kind of "spillage" I said was hard to police at LSF.
> 
> Without __GFP_PRIVATE, we have to keep an eye on what around the kernel
> is using __GFP_THISNODE and how.
> 
> For mm/slub.c we can choose to do one of thwo things
> 
>   1) 100% refuse slab allocations on private nodes, i.e.:
> 
>      kmalloc_node(..., private_nid, __GFP_THISNODE)
> 
>      And will fail (return NULL).
> 

Doesn't this iterate through N_MEMORY only? N_MEMORY_PRIVATE should not
be in the regular for_each(...) loops

>   or
> 
>   2) Do not upgrade private-node slab requests w/ __GFP_THISNODE
>      
>      This allows kmalloc_node() to work the same as folio_alloc()
>      or alloc_pages() interfaces (__GFP_THISNODE is the key), with
>      the understanding that any __GFP_THISNODE user
> 
> We can opt these nodes into slab/kmalloc with a NP_OPT_SLAB
> if the owner wants kmalloc_node(), with the understanding that any
> caller using __GFP_THISNODE may get access.
> 
> That's the kind of fragility I was trying to avoid.
> 
> 
> That said, in practice, I have found that basic kernel operations don't
> generally target use kmalloc_node() w/ __GFP_THISNODE - there's just
> nothing to prevent anyone from doing so.
> 
> So this seems promising...
> And then theres arch/powerpc/platforms/powernv/memtrace.c
> 
> static u64 memtrace_alloc_node(u32 nid, u64 size)
> {
> 	... snip ...
>         page = alloc_contig_pages(nr_pages, GFP_KERNEL | __GFP_THISNODE |
>                                   __GFP_NOWARN | __GFP_ZERO, nid, NULL);
> 	... snip ...
> }
> 
> static int memtrace_init_regions_runtime(u64 size)
> {
> 	... snip ...
>         for_each_online_node(nid) {
>                 m = memtrace_alloc_node(nid, size);
> 	... snip ...
> }
> 
> static int memtrace_enable_set(void *data, u64 val)
> {
> 	... snip ...
>         if (memtrace_init_regions_runtime(val))
>                 goto out_unlock;
> 	... snip ...
> }
> 
> This is the *exact* pattern I said would be hard to police - and it
> doesn't look like a bug, just not informed that private nodes exist.
> 
> This is why I'm concerned with trying to depend on __GFP_THISNODE as the
> filtering function.
> 
> That said, the number of __GFP_THISNODE users is very limited
> kernel-wide, so maybe that's an acceptable maintenance burden?
> 

Balbir

