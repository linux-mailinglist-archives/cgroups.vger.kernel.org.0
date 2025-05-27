Return-Path: <cgroups+bounces-8351-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 014B7AC4B66
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 11:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AEC33BC7DF
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 09:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2257524E4C6;
	Tue, 27 May 2025 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrsvSBcx"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB31B041A;
	Tue, 27 May 2025 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748337674; cv=fail; b=DfJnwkYS7f4r96ybNKW0RPBMYI5kIoOk+IuFJAsApIbBgALACmCDDYpKFPcUDufwEKtVn8gv0OXMyjSlz8jQ7J4fn8OdMZSUhkVC7gTEvszXU8CV2jzucLxXW/ykhsdUMjCnaPiXWVtmzMKqIRO1NR3AHI4/mZS2B8ONOb/Y/O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748337674; c=relaxed/simple;
	bh=9Bsqo+zTccu8hhGBLmsnYb/cIjdAy79QPOagcOnML6s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qSwEremybyfnT7qKTK/BFddXU/5KuNneFPY3Klnsed3XQurIjJNR0v8FmL10KSPl8PjQ+i+Vjhh1WdhiDzRWl1CckK0sHX2WnFibiaite0I4J3AvAEEyKXpHZVku7UQfx748Mz+/cv4fGyDKmXx/hGdHwPIBBNVMxu4iiPvoAWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RrsvSBcx; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748337673; x=1779873673;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9Bsqo+zTccu8hhGBLmsnYb/cIjdAy79QPOagcOnML6s=;
  b=RrsvSBcxDsXxHJreLVef6p9dW13yteqh8Fj7qeA8E+Ch3drQ0d2urqRp
   6cNuPaIWYTkWPXNiBk7EBmX70NZN9t6kNFuwji+K0yVrb9/bY9bLfUISm
   ASegXrz0x89IWKBTNlriWGklF4Jqadf/Pnc3EixX4x6SVxk2nwsjPn73E
   keMsNRaw2WzPlzyZhvpozN6faN8QadDJMzGQcnd/5Bgc+/31BFmqfKpHA
   WC0KwRlk4LZcZ7fvDWJ4LK0TybNlpuW64ykf5q3QwKPtuIlkVafHdWKtu
   tiJVkScKRtFMxv//iHM2TxyphXPOOY5kBSHBb/5s/9NR8A3z2BSGR5gPU
   A==;
X-CSE-ConnectionGUID: gI0UeBSDQC6QNtvnuH+rig==
X-CSE-MsgGUID: RPIkCyFxTI2IvPGD1vqwlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="75709116"
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; 
   d="scan'208";a="75709116"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 02:21:12 -0700
X-CSE-ConnectionGUID: BXBRVX8jSXS2Rfou3nrtMQ==
X-CSE-MsgGUID: l29Q4MpUT2+YuZ6ONXdLRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,318,1739865600"; 
   d="scan'208";a="143699462"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 02:21:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 02:21:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 02:21:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.82)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 02:21:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqiW6SEvWiwOPJQgGzvi18lMJN5UEbO2ETi8xRVbJUGisVDcYDopCSvqrXc24SQsaqKB77Dc18PUoMAFbmcIg4Q1ju3XOD0n5vn7+lomQaIKBHPGvfzZnwbX9C/ppAtBft8WtjVGGV5TUDWVvs9u34ik35oZxgugll+R4FmTNlrz0E7/TBKYK2rUF5sFlRygLDN4R9rSWVjIqc/04rFO4fuo77VZifi32mZRK5Ujlko2NZK7Ou3CHZw976ix1pLeAYLwEvJXnQaJ0m+qybV/s9TQgTaDoM33L8oE6BYvB8kQNgAxi/oTyFEgF2MyMk3/YL+EMCHj2p528yBj+q6dAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkPGtVFsqgHaPpMpTJz167j8DKAgpcQd5yYD8Modv+g=;
 b=yapZa6pkrvMm7fxGoTYhER5YLQLoWXRlmfesZVt/BylT85ACgefO6MHUKlhnqr/jI3CD8smL5g9cpLbuAh1datmckMVG+xp/KFTJBzMccs96qfsUgqzcN8TCCoPQFyOc+idYOrV2U59eponCXayZKLCBKrp3jxrxlWTPQ0k8WvGJlsXOygNNrgZ/gWZqZsXBReesXHihhvLAWCgbZyOZQADypn4lvKGTnO/sVIexB3zoK7HBt9r+Kd8RHFSewJDlZCasuamQkwgPGiUvUiOJAmSSysrJQvhCDxjL2iSlC5DPld4spHzThYX3mpBGqvuTLtW4u4u6QZAcafgvjXeiKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DM3PR11MB8715.namprd11.prod.outlook.com (2603:10b6:0:1e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.26; Tue, 27 May 2025 09:21:09 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8722.027; Tue, 27 May 2025
 09:21:09 +0000
Message-ID: <a8314889-f036-49ff-9cda-01367ddccf51@intel.com>
Date: Tue, 27 May 2025 17:20:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] sched/numa: add statistics of numa balance task
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Shakeel Butt
	<shakeel.butt@linux.dev>
CC: <peterz@infradead.org>, <akpm@linux-foundation.org>, <mingo@redhat.com>,
	<tj@kernel.org>, <hannes@cmpxchg.org>, <corbet@lwn.net>, <mgorman@suse.de>,
	<mhocko@kernel.org>, <muchun.song@linux.dev>, <roman.gushchin@linux.dev>,
	<tim.c.chen@intel.com>, <aubrey.li@intel.com>, <libo.chen@oracle.com>,
	<kprateek.nayak@amd.com>, <vineethr@linux.ibm.com>, <venkat88@linux.ibm.com>,
	<ayushjai@amd.com>, <cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<yu.chen.surf@foxmail.com>
References: <cover.1748002400.git.yu.c.chen@intel.com>
 <7ef90a88602ed536be46eba7152ed0d33bad5790.1748002400.git.yu.c.chen@intel.com>
 <cx4s4pnw5ymr4bxxmvrkhc457krq46eh6zamlr4ikp7tn3jsno@xzchjlnnawe5>
 <uuhyie7udxyvbdpccwi7dl5cy26ygkkuxjixpl247u5nqwpcqm@5whxlt5ddswo>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <uuhyie7udxyvbdpccwi7dl5cy26ygkkuxjixpl247u5nqwpcqm@5whxlt5ddswo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR0401CA0034.apcprd04.prod.outlook.com
 (2603:1096:820:e::21) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DM3PR11MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7cf479-35e6-4ef5-6f09-08dd9cffd09c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWJEZjZFNXhyWjNCQWhZWll3czBlRi91WXFVT091a1B2S251MlRXSVp3T0NU?=
 =?utf-8?B?L0pSaXpma3FBdnBodEpqaWw5YVNJS09wV1loeHhPT2dVMVQ2QkZrY2tjL3BP?=
 =?utf-8?B?ZkdYQi9FT0VmMTU2aC9obHpVbytYZ25Ybm1ZMDFjMS9jMi9lTlpzdGlIem44?=
 =?utf-8?B?U0RwdFJ0b041b1NPM0p6TTluUkVEdmhUV2xHNWozYjZzbUNDQTBGdDErcmhw?=
 =?utf-8?B?eDFXRERBbHZVY0UxUzNDd0NjRFNoUHQ4QTNtSWVEcE5oODRQcHpUU2Zxc0NH?=
 =?utf-8?B?eFFWczBwWkF2cUdhZDBhN1NkYnAxYUpxaTI5YmxPM1ZGZGxjY0hHZWViem11?=
 =?utf-8?B?ejB5VElncWpWVVgrMjFISXB3WmRvQTVZRUNvaG9Vbm5WdmlLY1R4Lzl4VTkr?=
 =?utf-8?B?QWlReU9POFdjeFlpVlZUbzlrYUJCQjBxalpTMjJHQ0M1NTFGNjVQMWdiS0lR?=
 =?utf-8?B?R3ZyRENOcVltdXBabkM1VTRPOG5QNTd2ZzNSQ256dkJDREl4Z21obXhyblo1?=
 =?utf-8?B?a2NEYzZRMDNOMDJLMG1XZFplQW9MeGVUb2ttdWtubUFSSXJlNVNvK091dmVj?=
 =?utf-8?B?YVM0NkQ3NmN2QzIzbnBqT2hDY09UcXZHcmNERjJwNktjZllLeEQ2Qk4xYnVX?=
 =?utf-8?B?ZHpjOTB2blZTTDJZRmdNcFZLTnhid0RxSGRmbW91ekRaZWNPSzcycC9sSmFO?=
 =?utf-8?B?OUhHeUhDeGduczJFN1I0MmlqQ3FPWkdURUg2a2ROcEMxSW9wOXdpc1JsMCtB?=
 =?utf-8?B?UkpFeFp1L0JwQzE5ajdCdytkU0dlNzAyQk9taXkxZFVPZUFBejN5VzliUUJs?=
 =?utf-8?B?bnZPWVVrZXBPMnJEWThXdEdZeXhPV3NyTTE5ZjRjc3pYVGw5R2dTTElPbWtv?=
 =?utf-8?B?RzMvbHVhdnVjYU9JbU8zMkMxeWJQMHYxMG1xN1dVQnJoTUhMd0o1blNsZitQ?=
 =?utf-8?B?NzlvNGtPZWdYM0w0WG5jaDVoSVhiaEMwN0pTNWtZUkF3RSs0ODNOWmF2WDdZ?=
 =?utf-8?B?WmVjTnpMVTZiaE5YVE9vK2J1Yk5vdXBkTVBCMUcyN2ZpVlNtQmxtWDFrSGdm?=
 =?utf-8?B?WFpqQnV1U1ovalV0TXgwZXpSMm5LcVVUZWMxcm1tYlliZ3QwWDVyZUh2dkYw?=
 =?utf-8?B?ZWNvSmduNnd5MjBzTFdYQWNjeHo3aWJkSjg5MklqYWhiTGJPVTJKWUZ4RFRM?=
 =?utf-8?B?Nk1XcjhOZHo0bHlRQTBaVTZYOFRsZDNGMzBYaVlUTEdHYnNZYjBmYjZsVktX?=
 =?utf-8?B?anBGNFFQaVc0S2Ztd2ZTVms3bG5IZU9yZnh3NDMwNEExQmFoQ0hUSDU5Sy8r?=
 =?utf-8?B?TkdldFNSRjV6SjNJemR0R2FqSjBFek80TnVNRTB3Qld0Z0hzdXFWZWxIaVlE?=
 =?utf-8?B?MUljZm4wUzVQQlFldnZzcjVaTzV1K2RRbjc3WUVkZjd1R0o3bkJRaEZzSDZa?=
 =?utf-8?B?eG1TSWl2OUs0NVgzckIvU2dsNStCSTF1R2NxNEhMUzVFSjNaWUtIL1VIZWh0?=
 =?utf-8?B?bDY0M2lQS0ltQ1A5d2hxMGRrYndQZ2hINlltMThGZjA1QW12cGxDWWhPYXVG?=
 =?utf-8?B?VjlaZ0FtcVFjTmZ1UEtUenJTLytNL2xIUjZhTHM2UHN3aWU4enIwVGU0K245?=
 =?utf-8?B?cXhQWW9YYnRzVzcvTUE5M2RteW8rYi9xVVRrRlJJb05HMG5qanc5ZTlqL1Zr?=
 =?utf-8?B?a3d4ZSttYkdZSC9KWXZmaHdkSU5nN2pmQnN0cjFva2ltbE81V1RGZCtadjlJ?=
 =?utf-8?B?YkpoRnNwN0tnbVl1WHlYMWx6dnRKOWV6ZEtMa0p2ejVSMElkWmdRQXFpZFRM?=
 =?utf-8?B?MU03R0VFZzJ4emNSVENtdXJaakN4M01SVGF1WituL0dvU3o4Y3p2U2Uvekdm?=
 =?utf-8?B?UFBOQWRDWHgzMkNzNzc3MmFscGdTME9zbjdBczhZaDdJZmdEZWtKM1lYNkZV?=
 =?utf-8?Q?2m/Ae2pt1N0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWQvV25SbEIxNkhGNWRmL0JxMHRVZzZCdmZCZ0hOL3hEK2hXMW9HQzVWMHNv?=
 =?utf-8?B?NkhnOU4wQjU4M3NXemE2S2RlMGNPVDRFd0FkTDZBbmxkNTRWSktRdUVEUEVi?=
 =?utf-8?B?ZzNOTkd2SjZIV2lXT0FhaXRLUUlXc3QrNDBTL3h1QWR0NE1EQjN6bEhaWmZG?=
 =?utf-8?B?Z2Ruamt3dWp4eE5MOGxqS3JFSEdZZHdQcWRvcjBNRE9LaHZtbnVuWUhRak11?=
 =?utf-8?B?ZVVWR0hUNnVzYkVhS1M4SEV2OUZ3RG5scllaRzZaczF6Z2NycjQ0WE9ndEp0?=
 =?utf-8?B?a1FoUURRcTlPTjBxOHltVVZUYjdXaitjRXdTdzJJRjkvN3Vxak9CWU5BYXVF?=
 =?utf-8?B?aHlCUnk1TElPbUZVSFV5QnN2Tm13b2kwYWhYRTE2L1dJczUyTE9rQ0tHSlVj?=
 =?utf-8?B?M0QrV1Fweml4NU5YQXN1Y3dpZDBtUWtJNXRjN2JVQUVtY3ZRNGFqYUR4ZzJC?=
 =?utf-8?B?aUR6cHhrVVl0RXpRdTFKNndHQ2I4RU9TSFhNbjZISzBjTUFrdmtjbWlsaG1z?=
 =?utf-8?B?TGJ4VVBwV0VJbkdjYWlpWmp1STVNa05IOXZHOWFXZThucFliSmVpaUhzdmdO?=
 =?utf-8?B?UE9yRS9YNllIZldPaDRLMXlRc2tnT0JVYnJNd2xlUXhZS3VhRkVyT3F3WnQy?=
 =?utf-8?B?WjJMRi9lNFNuNy9WKzdzNFdJNlpkakdwLytTVlczemN4M3BtbDRSd0NMQ2dX?=
 =?utf-8?B?ZGZnWVpHT2FuNm5tWnV1WnF0SVdOd3k3QmpjY2YrS2h4SlRXZ1lUZm8rRXlC?=
 =?utf-8?B?dm9ReWZGV3lmakZkcUtMNGM3YmZCVEh2TDdoUU9pYjVsR3JrOERiZUNoWCtV?=
 =?utf-8?B?blJadlJsa3ExOUVrV3h1bWtoRi9FL3BpRVg4b3lESzIxSVlNbW81VUM0a1dL?=
 =?utf-8?B?YVROVVVvWGxjRHc1TE9ONDZMZzBUbVRFM1B1UVZkdkhEcmk2OW1qQnA4TlhW?=
 =?utf-8?B?TzhLbGZjczQvb3llMXNhcjVaRHFoLytZN3hnS1pPTDdlOTFCcS9YbFBqWlpp?=
 =?utf-8?B?S0pSQ0o4NWZyVkpwdUNibDE4R1RQaFhaQ1QvNmt2ejZ1QjNESjRTaDVvU2VW?=
 =?utf-8?B?OU5PY29PZktoYmtiYmk3QkhvVUVmVXYrL0IydmM1UWRBak5KK3N3Q3VMNHZt?=
 =?utf-8?B?bklCczMvRDBaeEdMdWdCT0o3YldRcytFMzYyZlE1blYxK1UxYzJoZWN5YVdR?=
 =?utf-8?B?aThZRWY0Ykl4VXcrZDZDbm5OU2l1R1RLR09ab1l3cktrdDZZY0tzaGFScXlk?=
 =?utf-8?B?a1E3T29lMC9UWmdOSVJzMDJqbzF3em45SzRLRE5WZ2NaRUZlT1Bkc2xrVTlr?=
 =?utf-8?B?WDY3RUFhQnlWZTNLSGlSN0c0c2hkZWV2OFF1VGoyaHB4RW9aS0xiczdEckE3?=
 =?utf-8?B?a0FvTXN6UEhmaXRBbVZDTW9USHd1VjkwNGo5cTNoRHhkUXpnMUpsN20rVitT?=
 =?utf-8?B?SHNxN21DaW44WUNvcE1wVFJ1QUtzd3AwSzR0RUg1LzBQbkZpVXd4dUw3Uk5v?=
 =?utf-8?B?bEUybDNKamJ6dnVSN0tDWmk1SkordkthaDkvOG5OSkpXbGdnTTlTbkdVbzQ4?=
 =?utf-8?B?K1I5MlhnS1B4WHZJUzNueHlKRWFxTXRuNUdhQy9SRGUrWXpLQnc4anJvUnpx?=
 =?utf-8?B?M29BL2cyc2xESVhTVVliOXNnKzUweVc2QVhaNWp4dU5VNXNNamErdnR5TE9q?=
 =?utf-8?B?UksyelNGcWRHb1dpb2kwbjdxOGN2azJSR3dFdDRzQmkzKzFhYUE4NUJhWGZq?=
 =?utf-8?B?YWI4c3Z1VThOajBGbVUyMUJ6QjRtd2NFTWowMWtWd3FrVjkxRm5FK3BLNkhI?=
 =?utf-8?B?Z0dLRm1PREZYUEdUOEdnVFlrZjRpd05qbE5tUWxKeUN5MlRIU2Y2b3k2T2N6?=
 =?utf-8?B?Nk5VUEZxaENEZ0xnYUJBVnQ1OURkYlg3d3hielBXN3VoSXk0R01RUGE2Uzhx?=
 =?utf-8?B?MHhpRzNlOFBLVnN0MWFHYVozQkttY2xtbC9UVm92NytJSS9yMEFOMGxBQ3hw?=
 =?utf-8?B?RG9EZDdTN0tITlF4c21uQ0NwZHA0amJlQ3ZFUjgvS0Z2QTVlb0E2TU9FQkRB?=
 =?utf-8?B?cVorOVgzRG9uRWk0Vm52aHpXY2h5ODYrSGNGNG80ZFA4UlpmQmJkWmZIMkNp?=
 =?utf-8?Q?X8XH2AKQJMTf7/eVNdQiNydUA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7cf479-35e6-4ef5-6f09-08dd9cffd09c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 09:21:09.0167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fon95FLbHxHYGtZNAmBl2Bhna5rWQtwrtIYlZOoNYwwoBPN1ReH9twWMjnc3Y7CPg6m5Wg927uM34N1X/0+2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8715
X-OriginatorOrg: intel.com

On 5/26/2025 9:35 PM, Michal Koutný wrote:
> On Fri, May 23, 2025 at 04:42:50PM -0700, Shakeel Butt <shakeel.butt@linux.dev> wrote:
>> Hmm these are scheduler events, how are these relevant to memory cgroup
>> or vmstat? Any reason to not expose these in cpu.stat?
> 
> Good point. If I take it further -- this functionality needs neither
> memory controller (CONFIG_MEMCG) nor CPU controller
> (CONFIG_CGROUP_SCHED), so it might be technically calculated and exposed
> in _any_ cgroup (which would be same technical solution how cpu time is
> counted in cpu.stat regardless of CPU controller, cpu_stat_show()).
> 

Yes, we can add it to cpu.stat. However, this might make it more difficult
for users to locate related events. Some statistics about NUMA page
migrations/faults are recorded in memory.stat, while others about NUMA task
migrations (triggered by NUMA faults periodicly) are stored in cpu.stat.

Do you recommend extending the struct cgroup_base_stat to include counters
for task_migrate/task_swap? Additionally, should we enhance
cgroup_base_stat_cputime_show() to parse task_migrate/task_swap in a manner
similar to cputime?

Alternatively, as Shakeel previously mentioned, could we reuse
"count_memcg_event_mm()" and related infrastructure while exposing these
statistics/events in cpu.stat? I assume Shakeel was referring to the 
following
approach:

1. Skip task migration/swap in memory.stat:
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cdaab8a957f3..b8eea3eca46f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1529,6 +1529,11 @@ static void memcg_stat_format(struct mem_cgroup 
*memcg, struct seq_buf *s)
                 if (memcg_vm_event_stat[i] == PGPGIN ||
                     memcg_vm_event_stat[i] == PGPGOUT)
                         continue;
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+               if (memcg_vm_event_stat[i] == NUMA_TASK_MIGRATE ||
+                   memcg_vm_event_stat[i] == NUMA_TASK_SWAP)
+                       continue;
  #endif

2.Skip task migration/swap in /proc/vmstat
diff --git a/mm/vmstat.c b/mm/vmstat.c
index ed08bb384ae4..ea8a8ae1cdac 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1912,6 +1912,10 @@ static void *vmstat_next(struct seq_file *m, void 
*arg, loff_t *pos)
         (*pos)++;
         if (*pos >= NR_VMSTAT_ITEMS)
                 return NULL;
+#ifdef CONFIG_NUMA_BALANCING
+       if (*pos == NUMA_TASK_MIGRATE || *pos == NUMA_TASK_SWAP)
+               return NULL;
+#endif

3. Display task migration/swap events in cpu.stat:
  seq_buf_printf(&s, "%s %lu\n",
+ 
vm_event_name(memcg_vm_event_stat[NUMA_TASK_MIGRATE]),
+                      memcg_events(memcg, 
memcg_vm_event_stat[NUMA_TASK_MIGRATE]));


It looks like more code is needed. Michal, Shakeel, could you please advise
which strategy is preferred, or should we keep the current version?


Thanks,
Chenyu



