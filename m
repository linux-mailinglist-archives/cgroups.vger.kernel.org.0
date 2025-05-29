Return-Path: <cgroups+bounces-8385-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6BBAC7768
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 07:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A6BC7AA29B
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 05:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D8E252910;
	Thu, 29 May 2025 05:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qm7hxTG2"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3682374D1;
	Thu, 29 May 2025 05:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748495109; cv=fail; b=GbkPuo0//5ruVbptrWNw+lfVKzfQ5Un7FL5o7UJUYJpQ55RpbDe3AgaQjevqaZvME7S2AL6dCd7nUroeg1yw6mOQ7NSRddbFD1CUkx6NzgQbiOCNCes3Aqx8NxLfWJjAGFLrLUUkqdKMsWgvUFKuKBWxcmJBx0ZdAfc4LAet9p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748495109; c=relaxed/simple;
	bh=tWZMl0x+10+AcW0g1iPs2RCe2cVP+9XX3gBZZ4d5pNM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wmqq9908+f6zPDrV71Ex1UeYJpF0KOFH5WdFxBTL6Sa+qwtu+fkF2ClLfBCiOAMd7T+X7W3eAhJmNrPLHiPOywuotnkJpjrmp2DsRXzXdjXnJ3uFyZxhKtTSW62aNFD+RAvZ8HEHR0t1E84RphT5fqAfijlh1sFJbxqX9ivd17U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qm7hxTG2; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748495108; x=1780031108;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tWZMl0x+10+AcW0g1iPs2RCe2cVP+9XX3gBZZ4d5pNM=;
  b=Qm7hxTG2iRBeXjmhJJ4a3UMbUByHSWctNaYQtckKuSFsQAcq37LhZQ8Q
   8vhNT/tGiTrstLIBE15xLqnRwRjlrlpBX465PUuZzl5JgrOWsA19kEvPx
   7JqqoEFU17fhWIkjYptwRME3HNlyUOf5Ieuu3eP0sr1G2+sUQFHa/StCx
   B/9xJqvmOBdHN/49sPAuC/cES+pEglXRx9tX+nqVRZx47C/asn0d3/xVg
   nMCez7QKEd4spyJL/pTrNVHrQAnwbHeORBXD9gqcznkWZ10esVAls0HjA
   ckRd7iwejiNyJzfoPHGCizxIXkgr+5EJtNP1vOk3cPWwIJEUYGZO2dav5
   Q==;
X-CSE-ConnectionGUID: iTbLQmZwRjuHrb1MRKvz4A==
X-CSE-MsgGUID: xK0tiJwnSzC4ImLIGPgiOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="54205542"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="54205542"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 22:05:06 -0700
X-CSE-ConnectionGUID: 7MGZlp+JSZG7/FjObrfI9Q==
X-CSE-MsgGUID: y+T619TFRnOPzhH8GEZn8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="143350714"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 22:05:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 22:05:05 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 22:05:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.54) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 22:05:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyYjzv3rFYDV0J3Gc03KDKY+jsbmefIjziJgNxMKXZSf90u0NE/p7rTbAV8z7+Y775kOO5m98c4vG2v9bt2HBeC0rc5AYy37wTI6Mw5VrcXXIHo4cDTOzzStycb2por5AJy3UQLJ3bXrDdAPjau/m6kzGnTzvfzt/fjgXt5SqbMLXHVGGtDTfi2i5kxeK8cNg72JIRT6SMR6yRp08QwtDE/RmNKbiaI+MSb85sv+DQa+V0YZ86e1MnFOjo52PjgO0PLeNgyTV9QABA98iSIrSbUwwoxlcQ/OVeWWyu/IFb7OQFNtnhIveGV0DzoXze8tCtIWSLY1vo5gMHDcEmxmfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASq5/Vk2OXVAspHGEQ8WdM4T7j1q5ILdl+GsOYlXITM=;
 b=yMGusxzaa4f9tTbvj/jfmqd41zQNIx4BsFM4gCdZnaVCsUfZvvlErc0D9hzkrRC3GwABo6FUgVLV8A9VDl84iH0V+4FQxrCoTIyhJdmoTUBBwa3wlk4UtY5V2WBtQpim/t/7AFKBmX9ERkgSz+i6FUeh7/AksaadqeLRgthZZ5H1rQLa1FRS5LUzccQQiBKAkrppIEgcPQYbNJpkFuiMLqD+AV/xaAKoTwvAuOQSEbcDR8FgXq2yaektCt3i1yAE/SYJ899/aXWNBEOO75Z7bb5+Ct9TtVYzwHxMppEREHMXWPhRIGbTdLrwfqd8y1/gmy3xP39jhDCusnq6nZ6aVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DM6PR11MB4705.namprd11.prod.outlook.com (2603:10b6:5:2a9::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.27; Thu, 29 May 2025 05:05:03 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::4af6:d44e:b6b0:fdce%6]) with mapi id 15.20.8722.027; Thu, 29 May 2025
 05:05:03 +0000
Message-ID: <5a45424b-dc25-42b7-899c-26a9f09d0124@intel.com>
Date: Thu, 29 May 2025 13:04:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] sched/numa: add statistics of numa balance task
To: Shakeel Butt <shakeel.butt@linux.dev>
CC: <peterz@infradead.org>, <akpm@linux-foundation.org>, <mkoutny@suse.com>,
	<mingo@redhat.com>, <tj@kernel.org>, <hannes@cmpxchg.org>, <corbet@lwn.net>,
	<mgorman@suse.de>, <mhocko@kernel.org>, <muchun.song@linux.dev>,
	<roman.gushchin@linux.dev>, <tim.c.chen@intel.com>, <aubrey.li@intel.com>,
	<libo.chen@oracle.com>, <kprateek.nayak@amd.com>, <vineethr@linux.ibm.com>,
	<venkat88@linux.ibm.com>, <ayushjai@amd.com>, <cgroups@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <yu.chen.surf@foxmail.com>
References: <cover.1748002400.git.yu.c.chen@intel.com>
 <7ef90a88602ed536be46eba7152ed0d33bad5790.1748002400.git.yu.c.chen@intel.com>
 <cx4s4pnw5ymr4bxxmvrkhc457krq46eh6zamlr4ikp7tn3jsno@xzchjlnnawe5>
 <ad9f8af5-6bac-48c0-924b-498863370079@intel.com>
 <CAGj-7pX9yFFEFuMPgXBL_gsWevX8MtUZix5qyUQxOqWGKcbFzA@mail.gmail.com>
 <52a1b56b-9598-499d-ac9c-de99479d5166@intel.com>
 <qcasnjdjet57uxhwavfiaxepq7anf2zvmi4rzkp5lxysovqwme@wwcyh4nvlxiv>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <qcasnjdjet57uxhwavfiaxepq7anf2zvmi4rzkp5lxysovqwme@wwcyh4nvlxiv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:820::29) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DM6PR11MB4705:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c520b1f-f22d-4365-5827-08dd9e6e5ea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QllWNks0ZDN1V211RnorNHFXdmlIZ2gxMzBJbkZUZTN2MStXQzZJa3c0YlpB?=
 =?utf-8?B?NWxZQ1VRK0FKMWkrUUdMR1FwVWtZODVwQ08wK0NZeld5aE5MMTNjZDB0U2ph?=
 =?utf-8?B?OGxhM2ZXM3FoZFNKMEh2cmtLWHZxZktTdldLczExOVVhZm1lYXZueldSbk9v?=
 =?utf-8?B?Q2dGdlE2WEpVaWkvU3B1bTlER3FzSnNXcnRIQWZFbWJ3b1U5ZnlZWEJTSGRt?=
 =?utf-8?B?MlhIUkpPbnJSRHBvMmk2VzBNcXRXYk01NUl2aDhNbjRZcW55bnpJZy93YkRE?=
 =?utf-8?B?emc4cFBwT1JQV2h6NkhYbVEyTVkvcW5lM1l1YTFFSUNuQ1M3NVZEU1hTL05K?=
 =?utf-8?B?TytxU29hUWQ0TXVRdXJIRDY2N0YxR0JTSnFEamJYZDAybmMxVkEzZmhSQWxz?=
 =?utf-8?B?RHpDeDRESFNYZWxGOURqWmtqRC82TXFXNWR3cWRnWFRDQ2lBa3luUHpSQk9s?=
 =?utf-8?B?VDJ1WWJDMVFEdXhyMmhLdWpCblBjNFpqN05LT1VwZnVrQS8xeUNFN2M3R2VY?=
 =?utf-8?B?djRQSXl3RjA4YXY5b0gxSUNLOVdWQnl3VGV0MVNRVmp2NjVBQUhhVC9QVkwv?=
 =?utf-8?B?aHJDQWNGODluSHY5UkVpQ1VCM1hHUW8vUXB2UXB2MmFBbHl2dWVGNEhRay8r?=
 =?utf-8?B?Vm03V05RSkpncDVUQUovMWZxSUNWOFlWSVdyazRNL1lKckJzaWQ0UDNoVmxI?=
 =?utf-8?B?clF2K0k4aUNLeFVJWk8yVGZIYm1LTDZNbFJwM2ZtQ0ZTWFk1b0JxTFNGNE9F?=
 =?utf-8?B?RFR5ZlhnQ29MZW5ReXhsblpTdEV5dXEzK2ZHdWFabzEzY2JQUVVDVWtFbTRk?=
 =?utf-8?B?QWJjVmJjQnZiNmswTVVuZGVPY25HWTdFR3ZzanBjdG0xUndTaHlubXcvcnNR?=
 =?utf-8?B?WC9telVZMnJ2Y3QwYytOakY5Nk5aMFdOSit1SmtJRmtUejFlWnRKTXB4c1R3?=
 =?utf-8?B?K1gwM1hPZjcxQ3BvbWIxQ3NhcGZmU3R2emZuSU1JUFhlVk9WS1J5T2dONHE2?=
 =?utf-8?B?OGRDNURjaTVJUkl4cHNrM3F2eVFMUng2dSsyeTgreEx4aVZXenpqMUdTUHhp?=
 =?utf-8?B?d3kzbk03OVY3NnFMUkZqc294ajR2MkUySjNHZHBxS1hZdDhLOU9xZ3hHSDQx?=
 =?utf-8?B?M2UvUUVpVk5wQ09sSXNVUVViRXRKMTNqL0pJOFRVNnVpUCt3b1B0UFRNUC92?=
 =?utf-8?B?Y2ZhNGx0WjViNStYb0o1ZFJxQnV1aC9ldTNWUnNzeC9xdm9RUmxKQitJY1pv?=
 =?utf-8?B?K01TTHQ0d3hrYlg1L3cwaFpOM1pnUmkvdXF5ajExLzJkT0ViWFdrMFY1TkhP?=
 =?utf-8?B?cEJLdDZkRnhnVTJVTVY4bnYzNUcrZk1yNjkwdlBGaDJUckYwKzZzTHlEQ1h4?=
 =?utf-8?B?UzNtRDZnczI0Qi9ZTW5wT2U1LzMybHBLQzEvVzZkMzhFSDJBbHRDcFV2MnJK?=
 =?utf-8?B?VFIrMVpMeWR6ajBmWnUvWCtBS3g3RkYyZTRCZjNYSHcxdnFySXFpdi85ZFUw?=
 =?utf-8?B?WjRqQ20xR09pOG5idkR4SWFxZm9QNERqa2wyOHo4K3lFVVZ0bHZUTlF1ME5a?=
 =?utf-8?B?MWx6L3A2R1B4UVJCem54OXF4V1c3Z0xPVzFMcnpHbGZkZVJjN2R3VUp6K21X?=
 =?utf-8?B?dFJBenR1NWYrSzFXNkUra2VJVC9XVlVCN05zR3c4OVpsTFZVUnVwdmRRV3Q5?=
 =?utf-8?B?VFV5cnNNbWxBOVFyMVVETFJqM2VPcm5VU3JkY1dYYzE0ZzdVbG9rcmRkV0da?=
 =?utf-8?B?Y25QeTg5OFBLK1FPTWNvdERYbzN1VWthb3hoOUpSemJUbHphRENGa2c1emF1?=
 =?utf-8?B?NjJhQ2x1N25XOElwVjJYZjgybXRNWkxuYmZZOGNWY2pMbWtHNlEzYlVWNTQz?=
 =?utf-8?B?V05rRkJ2OXhHZ1p6OG5JUDdMOE4rTE5Qb1h0cjdvU1NmUnJnN3EyUnFueUlT?=
 =?utf-8?Q?iJOov5kv2+w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUZIVFNycms5M2dBQ1VUaGN0V29BbzBjYVhEaGxtWWUyU1ZNMjREeXdEdmpw?=
 =?utf-8?B?c1VhMXc1RVZpb0pkM25ST1hEM1c0dWRTNkpNTFc4UjNqRExzclloQXJVQXpC?=
 =?utf-8?B?NE9WQlVSL1IyUVlscXpDYlRDY0ZvWG9EMmEvWFEvVy82VFZyZ0xzWWNWRUg3?=
 =?utf-8?B?bDEwWWQ4WExlQ1ZSei9LUko5RHVhdXZpblN2dnVrZ0p1UVZwVXlkMkxPbkxB?=
 =?utf-8?B?d2tHVkRQTVU0TVcwSkN1UnNGNUZSMHpQRTluNTZmSjUwdks4bUJtb2NQa0RX?=
 =?utf-8?B?SVdpZDE4Mm91MGFwMzg3RHdUWk9tWUVRaG11eWwwRGRhaUF5bU1BODd2aHl2?=
 =?utf-8?B?aGRUNWxWUGdqZGZGWTlEY3dzR3JoQ2I5VXhnczVyYzk0ZTRpYXR4ZThuOUdh?=
 =?utf-8?B?SGlDdk1tbVBlQmZGaVhHdENCNmRtdFZpUTF2Z0R4Q2JPdnVHSHRrTE56Zit0?=
 =?utf-8?B?bUw4cVhDeUFIM09wOXhxcE9WVVh1T3VLbTE4Yk9zZWRkSFRLc3pCek11Zko3?=
 =?utf-8?B?L1ZvRnhHRm05aUFYLzJVK25DanpzcXhRMHFaVnZhUGRmVHZjdlVLRnV5VjFr?=
 =?utf-8?B?QlRYMVBBdkxrVHlaSStxcml3VVVpYldBSFlMdW0xZkZCZGFGNFFvcU91UWhO?=
 =?utf-8?B?MUdVRjBPQ1NZVWN1MnpwLzhlQmYxN1NrS3ZuWm5jU29BYnNaMHhUMnVOWGpN?=
 =?utf-8?B?U1VDSmU3d29HMUtQYmtRWXV0bmdDTXdab2xkRHQ0Z1BNVDV5dUd3dWlOakxW?=
 =?utf-8?B?RGhYekJ4MVAwTUtCWENVQjU2TWJySUdPc21VWW5QSWYyajg2VERTbisxR0p2?=
 =?utf-8?B?andWb1RqZ1YvWGIvYkcwM1NabDNSR2FWbm9WZmgxOVJpNmo0YU55RmFqOW5E?=
 =?utf-8?B?bUZQYng3Z2ZkOWFRZm1sY0FDaGNBZXluRWhVN2JXb1E3S01QV01WVFdLL3Mr?=
 =?utf-8?B?ZktHVk94NFNMVTAvODZjc3lzR1dtanFvSWpUbDQ2YkxaQXNOR3dYV3lyVTl5?=
 =?utf-8?B?YzU4MVVWSHRBMGs3SkJBTU9IRUpxMkx0MWhBRGVUekRPMDV3WlQ2ZUpaeGRS?=
 =?utf-8?B?SUVHTEhVVXhLRjFIZmtjTHQrQ1NMZSswMmprcThMOUFBT0daV2oreUNsOWNj?=
 =?utf-8?B?ZzN1Wmt5TDhhM3dJUnN4Q0dNSnZmZE0xakFib2p1TGVmUkZCU1Q2eFBTUEZw?=
 =?utf-8?B?WU1FbTZQNm9CU1JKRElzY2pQdUZYMjlzOWpDbHVTeWk4UjY1aCtYTERwN2h3?=
 =?utf-8?B?Qm5NV3BqTzRuZFFnSnV1SzJYVTNmbWtCNUdKM0Z4aWlQa21ESllCWXZLWHgr?=
 =?utf-8?B?ZWpGNGFldG5lZkh3dEZ2Y1RvdnRocGQyWWI0eTZSZ0I4MjlTUkhabDBjTlNK?=
 =?utf-8?B?U1BzQWNvc0FoRjJUb2xwaXcwbU1BZks2VURoM0ZiNmdSVXcxSHI5bmtlenVV?=
 =?utf-8?B?UG0vaThhQVNvbjY5Wm55Y2JZVjhXWU9rajJaUDNuanpZVk9jOXMzYVcvbDlw?=
 =?utf-8?B?U2NJd3Y4ZEpMdDBhRVNFS2JOYWFLYXdmbEt6WWZtdStuYmFrVUloQ0xnaTZq?=
 =?utf-8?B?T0lyVDQ1VGtTV1U1MVZnSldGMWVRSUZCRUtLWXVIRW5PT2dnYkJMcFg0bHlZ?=
 =?utf-8?B?NlNQeG9sN0RsY2N4QU5XeGM4QTlzb3RjUGpnbjBtT3ZPU1VJNGJoUUZyd3Bn?=
 =?utf-8?B?aE52ME1DNGVCV01EZ2dVZDJMbGV6c0kycHdVWUpReFh4SUVLaTdhUGdWYlBh?=
 =?utf-8?B?aThCb0F1K0taTEJhK1BIZ3dzWEg3bUYxN2ZFQXAzT0dXNVh4WmF1emRhT1Qx?=
 =?utf-8?B?NjJuZ1pFdmFmNlFaYWpBMDUraWJDZFdoSklyY0hzU0VTZ0cwWHpjOXRaVitj?=
 =?utf-8?B?aDN5Rk1PakpDc09IM1ZLUXQ4dzBkeHgwZmhGRWs3OGN5ZnRsUU1ScXFQT3hv?=
 =?utf-8?B?YmZaZnRpR1RwMy9jMStkYmlrQzFzaVZ3Y0pRcW9kQzVxaks1U282Y3hyS212?=
 =?utf-8?B?VTNrYXc5cU5xZEt3NSs3NTBJQTg2LzFlRkZ5enZONTJKK1gvbjBwNVlxWTJJ?=
 =?utf-8?B?aFdYNUtkNkhYRENoS0tWNC9nOFQ3NDIvYUpzSm1BQUk2aUMycFA2TXk0c1Fo?=
 =?utf-8?Q?snNUNPU6fiFTkYFIi1iwFlidb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c520b1f-f22d-4365-5827-08dd9e6e5ea4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 05:05:03.1818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANAQ/lIQKDnRuNTHjHz99AD1Ip+HdgHgOw8+JYVI3HniKy2xGGFgCkSSUqLES+xofG19BjDqFjrowm3p4N/aXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4705
X-OriginatorOrg: intel.com

On 5/28/2025 1:48 AM, Shakeel Butt wrote:
> On Sun, May 25, 2025 at 08:35:24PM +0800, Chen, Yu C wrote:
>> On 5/25/2025 1:32 AM, Shakeel Butt wrote:
> [...]
>>> can you please give an end-to-end> flow/story of all these events
>> happening on a timeline.
>>>
>>
>> Yes, sure, let me have a try.
>>
>> The goal of NUMA balancing is to co-locate a task and its
>> memory pages on the same NUMA node. There are two strategies:
>> migrate the pages to the task's node, or migrate the task to
>> the node where its pages reside.
>>
>> Suppose a task p1 is running on Node 0, but its pages are
>> located on Node 1. NUMA page fault statistics for p1 reveal
>> its "page footprint" across nodes. If NUMA balancing detects
>> that most of p1's pages are on Node 1:
>>
>> 1.Page Migration Attempt:
>> The Numa balance first tries to migrate p1's pages to Node 0.
>> The numa_page_migrate counter increments.
>>
>> 2.Task Migration Strategies:
>> After the page migration finishes, Numa balance checks every
>> 1 second to see if p1 can be migrated to Node 1.
>>
>> Case 2.1: Idle CPU Available
>> If Node 1 has an idle CPU, p1 is directly scheduled there. This event is
>> logged as numa_task_migrated.
>> Case 2.2: No Idle CPU (Task Swap)
>> If all CPUs on Node1 are busy, direct migration could cause CPU contention
>> or load imbalance. Instead:
>> The Numa balance selects a candidate task p2 on Node 1 that prefers
>> Node 0 (e.g., due to its own page footprint).
>> p1 and p2 are swapped. This cross-node swap is recorded as
>> numa_task_swapped.
>>
> 
> Thanks for the explanation, this is really helpful and I would like this
> to be included in the commit message.
> 

OK, just sent out a v6 with the commit message enhanced.

Thanks,
Chenyu

