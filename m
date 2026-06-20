Return-Path: <cgroups+bounces-17087-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gSChAAQPNmr17AYAu9opvQ
	(envelope-from <cgroups+bounces-17087-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 05:54:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E256A849D
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 05:54:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="QVuweg2/";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17087-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17087-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ECC73038176
	for <lists+cgroups@lfdr.de>; Sat, 20 Jun 2026 03:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736551FF7C8;
	Sat, 20 Jun 2026 03:54:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AFB2BB17;
	Sat, 20 Jun 2026 03:54:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781927679; cv=fail; b=CktIPQZqv7sBO8nTXDYZ4UHpSsZj5vLXcvqkWW1N1u0bvYWc2irfbXFiF4KtUHL5XP664dCoCyRMKNrGmDiBc7JQeh6/cdJYK9XVaECjDpIHXeJGkyZCKCqJlbBNorwq/EMDVJyHv/OwBW6FU8HMKdVo84qlx+N4Yak2oWl9frI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781927679; c=relaxed/simple;
	bh=WIm1kmcEf/7OGmZtbA0r4PzDqFUBEympjJCPKYBOY4k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dApFvEtk/yz44nw+/eD6Bt5DymQp5pQw2PNc/10pheDO0jtejs0dXUNkzviwBfORo9RbqsqSin4Z9rIHleKXEVxqO6/+YNb2OTQG9y0WTL5rrZuESr8/3ToYG3EbYbaVE3D4ujSeM18Jv6llEsDit1BTJVuUEA0hdGIgI4fqBOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVuweg2/; arc=fail smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781927677; x=1813463677;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WIm1kmcEf/7OGmZtbA0r4PzDqFUBEympjJCPKYBOY4k=;
  b=QVuweg2/wEJI/PoOQ63DNRmxTXIlfrLR5lTf/9XaRezyaYQ2FGCK3jU7
   poc8doG6n3vMwLUqVhrSs034indihzqqL1spVH8fTqyK6O5ENV6+TkL2Q
   7XJlTtfDtQpKnggJabaoga5Z8bzXyrhJWQDArMXkkJhHh6158BJlAG46i
   8HJEXXFew63mXlNxEwSYWHTrANjI4CbwyCq0IvamO2fomf6f/OGqcb4WB
   sb2vdJSPg56PlCeMjhgHY+U+OcYfM4ehWxR9hMHaNDBXJNspWtHqjuRo6
   wePO47g4O7VlgmnjjFph+eIOraIGPaT0bSBoL1y8TupCNPfHbmMW+l86t
   Q==;
X-CSE-ConnectionGUID: QvqZ99S4QYKnRiQD6aSCgA==
X-CSE-MsgGUID: lImBpO+HRd+1AkTbrBPrEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11822"; a="82645361"
X-IronPort-AV: E=Sophos;i="6.24,214,1774335600"; 
   d="scan'208";a="82645361"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 20:54:37 -0700
X-CSE-ConnectionGUID: 0dRmsQ0wR/2+Dpa9kmwXWQ==
X-CSE-MsgGUID: VCjqEOQxTf6NVv3DJrz3mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,214,1774335600"; 
   d="scan'208";a="272451317"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 20:54:36 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 20:54:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 19 Jun 2026 20:54:35 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 19 Jun 2026 20:54:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oytCdko3njcYypSWLTP6EVAajx4OVIXdIZW3gUlCB6FZ9IfWu/VXUhR2OykODoXoVdj54sGD4+sqCEPlKexwhAUeyoGmQ/r6JKi1UkfSmHjZYiZELW6hIv+cfqY/m7eU3bq36dCAaw0L7hkFitSereDJLHVYOW3bXjEhvHFaCWlwRj1gLwPG16sBDOuf412DSrtqnhWodkfpGpFBi4XoTEfhs1o6MgL8+y+o+qs4S6nuLbqtwR6lS/u365z4deJPGVHnTdtvGk4m4nBjyf1tflRV9jw0LuVoWj25l1zR8OAh6lN/yI28z3MqAOhMlK15M0IZQonQAkdMGRKcEg7sjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIjtNLqLHOC0baWQ5Tqj+JGnKqw3aD3VBwflb9SgafM=;
 b=GErALxuTkQE5GCvb6KhtkxMTj/4LATSG3FfZuRkwUk3NPzTPAV5GpkG6ioSxFwH7NgBw4aLUmtY7n7BER8r1ccFxCx/p1tMiAl6Csdew04jMBHN9VVUnxtLHMTvDS43xA9dm6ZukwqETpCaMncdYmETDpku8r9OV3rTzdag5+pywCIK0pWXlfCBEBSzKPtDg36gK+zagJyt9TY5D5jzaPXQqLnVyA/YesqlE3tEKChdjipRA7lb1DUwqUm6fEkKJNLBg6vWH6nBuGLOOE9TyoGKO54hvmoon+KG9BZvBmzURGpqB96aCDz2L0nA9IMHxDUsW+J9sfRPpNzzxKxx7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SN7PR11MB7996.namprd11.prod.outlook.com (2603:10b6:806:2e3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.18; Sat, 20 Jun 2026 03:54:33 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%4]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 03:54:32 +0000
Message-ID: <a22eea2b-4c4a-4623-9a44-d7b18c0c91c8@intel.com>
Date: Sat, 20 Jun 2026 11:54:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] sched/eevdf: Move to a single runqueue
To: Peter Zijlstra <peterz@infradead.org>
CC: <longman@redhat.com>, <chenridong@huaweicloud.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <tj@kernel.org>,
	<hannes@cmpxchg.org>, <mkoutny@suse.com>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jstultz@google.com>,
	<kprateek.nayak@amd.com>, <qyousef@layalina.io>, <mingo@kernel.org>
References: <20260605105513.354837583@infradead.org>
 <20260605124052.227463677@infradead.org>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20260605124052.227463677@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0030.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::16) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SN7PR11MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d5bb2e-de37-4f00-e968-08dece7fa31c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|7416014|1800799024|18002099003|4143699003|5023799004|11063799006|56012099006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: eeZSQMVlUROADXU6EEkt7MM1Iv5aFIA3ESSM8B0VTHxnfPZwMKK8hog82AN42ir9KAvjWWA7PMBxVkusChTeX+ihVhi5PeaT26CIKWChFp2RGuWsPTdovMDXgLY5MFHzv2O332ZV/GW+klibhMCNsOOj5sT1ZLz8s5RzbPhHJpigrN68D9+qUPbG8Kd/erCVRcUHFnRChCrBkW3Cr+FoHPH9w2SJU/2W41MqVWrwB5E2fi652I9ww+3Az10EjwIy4cQMNxeE9I4VurphacK4PmhpWTox1Kf/IWvrsky6VuXVqCi80ivPXc87vVoGRKea4wFpF4+CT7NS/qO4ybq5AxjjpWJaiqp2Rw8Zy5G7lN/CGeKiVI5aQ5q2DJUerhKlyqZw7iPbEtz3CX2SeFWtYjzVcUHTtZ8ayMaIfwQdQWpcabYM7a5i43UdGtBMdJ4yWg+bPqyHbYwdWYP2Pj+BzfJFGB9CIfa6Q4uUwJe7FjfzvN7lgmCdcJZqv4hbAynR37wGCCagSxol7z0Rmr6R/AVP+L5EHPpunEDlNe4qh78tFwNyKjT7X9qBeF/bZwqQIZ/72zGrrGHj4trQNjhrvYWirHs10I6ZzsynUQMfgjjwmL9xVi8aWtEVj+iq96jSLSk7fnD15WAOcg28zz4mgSTUN9nsyXelqHqdeqBURkc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(18002099003)(4143699003)(5023799004)(11063799006)(56012099006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjFUOWY2anVBM0kvK3h0Rmp2RUR2RUdsSXZ3N3JTRjNHVVFvV0tYaWtNZ2F4?=
 =?utf-8?B?ZFJzMGVpb2tGQm0rWXRzV1JBTkU0aE10Sys3TWlWaE9YZjR3T0NkUE85aU9h?=
 =?utf-8?B?bXVNdGRickMweUdCbkw3MWNkVmVOTnZhVW9obUNsaWZReTVIdE1NUmZyV3dM?=
 =?utf-8?B?amJ2enVJd2kwZHJyUjdiOTRvUy9RMjJhT3dia1JsVWJLbDJpNFBBMFZmK2w0?=
 =?utf-8?B?Z1JkSHJVVnVKWC9uYkpKZnZtWVpQZUJKT3dDSWRaVFBON2NCcTBzeElMSVVs?=
 =?utf-8?B?cEt2OU8yelhscjdvekFqMDUyTjlpU1RnTUk3T0ZxVkZ1c1VHWnFEZ01sOTBB?=
 =?utf-8?B?STNFRktDTFR4SnZpL00vcHJVSnMvOVFhdkZtRFlGTnQxTFBna21ZdGFXQWFx?=
 =?utf-8?B?U25kUkRFbVpSajJKOHFKRjlnazBmWkl6ZVRBRVE5NHVYNEJSYmdaMlFRbkU5?=
 =?utf-8?B?UXBvZlZsRURhY2FKU3BNalRaNytOam9GQndXY00reGZxVllPMGJMNmM4RDZJ?=
 =?utf-8?B?MVhmckhiKzVyNHdROUpZMXl1UW1PQ254Y1NkVTZTQkR2RHQycFBIaFpmMnV4?=
 =?utf-8?B?bXpkclA4WFlYMnFnTitlV0xsbVBXOEpEZTJKTlBHT3Q1K0JSZTVOQjQ2UFl3?=
 =?utf-8?B?M1RJZzlDNUQzVkRndWg0TU0zZEJtVEZmeENXUkZUYTBSWkxBcnhrNUZ1WG1m?=
 =?utf-8?B?WlpHK0JWUy92Qng1NStIaXJ1KzJrU0ZndnN2bjQyc2ZoWDYrUFZieEpYVzA4?=
 =?utf-8?B?Wkl5a3pBZlZMbWVJU2NjWjVvVGxmZzBWUmVYM2R3TDE2ZmxDMjVlTHZqNnlR?=
 =?utf-8?B?WE5LRDJuRXFBZm9iOWtmZkY5N3IzZmc4d1JaK2ppSTZBdytkOGg5d3ljbEN3?=
 =?utf-8?B?aU9yWGtxSU44MkpQQlhjRU0vYkRHV1RMOHZFL0VFWGJrdHhZaWVsMFJZTDJi?=
 =?utf-8?B?aEJ4M0VHRk54Mzh6QXZMNkNKTnR6MjFUbTBlRWpZVXNIcTFSV0RFMDY0dTZp?=
 =?utf-8?B?cTAvNlpsRU9FTHh3T1YvVnNVbWNKTXNqd0tvVG9lRkN1MHBZZVF2UHdQMHlQ?=
 =?utf-8?B?dm14a1NuVjk2dTJ4UUlYU0RKSUFIUFNnWmZOc1lvQTJ1aVVpSzNiWGs2Ym95?=
 =?utf-8?B?WldIRitxM2hjbkRvRFA2a3pZaXhpZFBQbXdqeHBBNmF4V0F1SGNTMHQ0YmNX?=
 =?utf-8?B?dnlZM2VTTU9vQTcrQkMzdm5iU0JLNmtqZG9DZ1o1TmxXMmI5cEVsc2JuNmpV?=
 =?utf-8?B?S3FtVzB1dlZKWTIrdlR4bGlhWWoycFFpY2JxODg4dzM4ZVQvVmdqQlRNMWJi?=
 =?utf-8?B?S1dtaFo2S2lIUnkyWkQrODhKbkx5OEhpazhSeGpUTDU0cTcwTmJyQzVuNUEr?=
 =?utf-8?B?TlRtVFoxcHB1WXdBQUdMaUZnSU1VN1pYTnNxdVZqTTdOMmRXQnRQb3dHZGd0?=
 =?utf-8?B?THNud2FWcEV4YW5ZNlhZaTNiN2xjZTdLVmQvdElsaWFXZEpTQzE3WS9TSHNF?=
 =?utf-8?B?Ry9QUjdLYzhLNTlxdXBTTkYwaGtsbjdXYTJQa205dDFMSlNsRnRCQ2dYb0lW?=
 =?utf-8?B?aGxmK0xDY3pYaXZZSHU3cTlMenk1cTRZd3pTVnlhY1Y4Y282M0VURTlvZUZP?=
 =?utf-8?B?c3l2Q1c4UUpiRjl1SHMrcWVVYUpIYzlvV3VZU0gvV21YeVo4NmIzNFlyeFdU?=
 =?utf-8?B?Q0w0aWdGS0IzcUxMeHJ5N2NtYlFKNko1K1BQWUJxajF4VXVBVyttcUV1dHd2?=
 =?utf-8?B?SEErSlN3a1pvSVpGaWpuMGcreHhDQUFBaVBqMDEwOW4vcDVkTDRGV1BVU1NL?=
 =?utf-8?B?VGlqNzdidDJqNEFFdGxNZ3hKeHZnR1NWY0JuVnlCMlN6bFJIUVBCKzdRcGVw?=
 =?utf-8?B?Yzh6SWlIYmRSaHZkZ0VwZ3pyWjltS2JrRTJXajZUdDBMQXN3SXBtbHJCQ1Nz?=
 =?utf-8?B?NnlDNzZpUjBCTEcveFBZMzY5QmlsNzNJc1NDOW04bmdmOWMzcU5VU1hZYmRr?=
 =?utf-8?B?RzlXN05tdnZaV05iRmUxWHJSTzJvek9UaVNvQ3FuTmphTGhiU25lUXhpTDlV?=
 =?utf-8?B?UklBejNGdlRKUmIrWGFKdWxXd1BsaFFMblRiNEcvd2t2MGJwVDcvZWxZZFJl?=
 =?utf-8?B?V0U3akk1b25ydjc1NnJSVTBzUnhJblNveERja1dvTTc1cjhMbktIVWpHaU9T?=
 =?utf-8?B?UEVaZzJQMU1uZmVNUzhnUCs4NFZZMnhBaWppSVk5MzRmR1ljbnhZeDRUTEE0?=
 =?utf-8?B?ZTV1a1loNVNKRk9WUlU1Mlp2MkRmeTNnRnBIVWJHck44UFhzaDhBSGx5dkMy?=
 =?utf-8?B?dGNSWmNHd0gxUmxZUzR1ekxuVlZqTXZIS3VNM3hhZWs3NThMbDRmdz09?=
X-Exchange-RoutingPolicyChecked: qYnh8b3FCX2HT2xp/JCShqfuaND8q4XWcFhTw3QnHoS4OpoerrWFabz9/btBkDLb57IrBTB199WwxsmtUb22m/lm1R97wsBJbr5cvNwQlay3MErZ0bc3ZBudGOMpQGOWafnc2+JS9iVBSS6V8lXUGupBVr0oHiaxHv1BYhck76D4Kr+pJmQF/uQLMgtnfhzcFBr/vHw6RghZlAGRZItKCs409WkVrsmXJaI5hLQdxhV752qkK0dQ8OXUOTVfdLhAlwglG+PuWJj4OJSA0G2qQA73XWpumR2zc3c4wgCj3LLh1DIm72N7FcfOp1aD7WASMGlE7bgtAYxH8X8zqpet5A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d5bb2e-de37-4f00-e968-08dece7fa31c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 03:54:32.7074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6qaavTnXI2K4y+lTyI14UniDyFafNmoOZJMw70N8f8IqgyKCMtCjn+w4d4z9lKlTzULhvVN5MvtWdzxFe9yOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7996
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-17087-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jstultz@google.com,m:kprateek.nayak@amd.com,m:qyousef@layalina.io,m:mingo@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yu.c.chen@intel.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,infradead.org:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yu.c.chen@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46E256A849D

On 6/5/2026 8:40 PM, Peter Zijlstra wrote:
> Change fair/cgroup to a single runqueue.
> 
> Infamously fair/cgroup isn't working for a number of people; typically
> the complaint is latencies and/or overhead. The latency issue is due
> to the intermediate entries that represent a combination of tasks and
> thereby obfuscate the runnability of tasks.
> 
> The approach here is to leave the cgroup hierarchy as is; including
> the intermediate enqueue/dequeue but move the actual EEVDF runqueue
> outside. This means things like the shares_weight approximation are
> fully preserved.
> 
> That is, given a hierarchy like:
> 
>            R
>            |
>            se--G1
>                / \
>          G2--se   se--G3
>         / \           |
>    T1--se se--T2      se--T3
> 
> This is fully maintained for load tracking, however the EEVDF parts of
> cfs_rq/se go unused for the intermediates and are instead connected
> like:
> 
>       _R_
>      / | \
>     T1 T2 T3
> 
> Since the effective weight of the entities is determined by the
> hierarchy, this gets recomputed on enqueue,set_next_task and tick.
> 
> Notably, the effective weight (se->h_load) is computed from the
> hierarchical fraction: se->load / cfs_rq->load.
> 
> Since EEVDF is now exclusively operating on rq->cfs, it needs to
> consider cfs_rq->h_nr_queued rather than cfs_rq->nr_queued. Similarly,
> only tasks can get delayed, simplifying some of the cgroup cleanup.
> 
> One place where additional information was required was
> set_next_task() / put_prev_task(), where we need to track 'current'
> both in the hierarchical sense (cfs_rq->h_curr) and in the flat sense
> (cfs_rq->curr).
> 
> As a result of only having a single level to pick from, much of the
> complications in pick_next_task() and preemption go away.
> 
> Since many of the hierarchical operations are still there, this won't
> immediately fix the performance issues, but hopefully it will fix some
> of the latency issues.
> 
> TODO: split struct cfs_rq / struct sched_entity
> TODO: try and get rid of h_curr
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

A divide-by-zero crash is observed when running hackbench:

   [14697.488452] CPU: 112 UID: 0 PID: 124791 Comm: hackbench Not 
tainted 7.1.0-rc2+
   [14697.492627] RIP: 0010:propagate_entity_load_avg+0x35f/0x3e0
   [14697.506799]  <TASK>
   [14697.507411]  __dequeue_task+0x2b4/0xc70
   [14697.508677]  dequeue_task_fair+0x36/0x370
   [14697.509047]  dequeue_task+0x101/0x2f0
   [14697.509426]  __schedule+0x1b1/0x1a00
   [14697.510868]  anon_pipe_read+0x3da/0x450
   [14697.511400]  vfs_read+0x361/0x390
   [14697.512053]  __x64_sys_read+0x19/0x30

The divide-by-zero happens here:

if (scale_load_down(gcfs_rq->load.weight)) {
         load_sum = div_u64(gcfs_rq->avg.load_sum,
                 scale_load_down(gcfs_rq->load.weight));
}

gcfs_rq->load.weight is an insane large value and is truncated
to the lower 32 bits by div_u64, which happen to be 0.

Using AI for investigation, the cause is a u32 overflow in
update_tg_cfs_runnable(), and flat pickup became a victim when using
tg_tasks():

   u32 new_sum, divider;
   ...
   new_sum = se->avg.runnable_avg * divider; <-- boom

The following sequence shows how this triggers the crash:

   propagate_entity_load_avg()
     update_tg_cfs_runnable()     # u32 overflow corrupts runnable_sum

   __update_load_avg_cfs_rq()
     ___update_load_avg()         # computes insane runnable_avg
   update_tg_load_avg()           # propagates to tg->runnable_avg

   update_cfs_group()
     calc_concur_shares()
       tg_tasks()                 # long-to-int truncation, negative nr
     reweight_entity()            # corrupted se->load.weight
       update_load_add()          # corrupted cfs_rq->load.weight

   propagate_entity_load_avg()
     update_tg_cfs_load()
       div_u64()                  # divide-by-zero

Fix by widening new_sum from u32 to u64(no need to force tg_tasks()
to return unsigned long after this fix)
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
  kernel/sched/fair.c | 5 +++--
  1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d991ea85873a..99ea51448981 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5305,7 +5305,8 @@ static inline void
  update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, 
struct cfs_rq *gcfs_rq)
  {
  	long delta_sum, delta_avg = gcfs_rq->avg.runnable_avg - 
se->avg.runnable_avg;
-	u32 new_sum, divider;
+	u64 new_sum;
+	u32 divider;

  	/* Nothing to update */
  	if (!delta_avg)
@@ -5319,7 +5320,7 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, 
struct sched_entity *se, struct cf

  	/* Set new sched_entity's runnable */
  	se->avg.runnable_avg = gcfs_rq->avg.runnable_avg;
-	new_sum = se->avg.runnable_avg * divider;
+	new_sum = (u64)se->avg.runnable_avg * divider;
  	delta_sum = (long)new_sum - (long)se->avg.runnable_sum;
  	se->avg.runnable_sum = new_sum;

-- 
2.45.2

