Return-Path: <cgroups+bounces-6096-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F9DA0ACDB
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 01:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4D13A65D4
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2025 00:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF97CA6F;
	Mon, 13 Jan 2025 00:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="lImJ92c6"
X-Original-To: cgroups@vger.kernel.org
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE2C2B9A4;
	Mon, 13 Jan 2025 00:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736728751; cv=fail; b=gtxTTln9YsgoPFgwSyYz4Ah62q6Xh07ree0/m2Q3nay/O3k41mvdqEh7xfNWEwQOxo2Pj9S08rdIROB9DwD7jCG8/+adVbhPE3HKZMLNqXyFOAL2M8dwLe1nSClslEGaqUivR0Q7oOt3GprhgPzYQAhhrXf0idFshsRtWATqbcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736728751; c=relaxed/simple;
	bh=b/85iy9iMT+0+wIDCxRLPe8fxggMWY7D4041rzjkJWQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LlG3cubj7cdGXpSRSLvW4I1ghzlmJCfL3x+XPWxl37GeTTuhJnYXezJDdqGL5j6+LpVR3aXUW0zTOP46Ns39L3KpPagOsR+EutWjFEdqkhEvbMqloHfz5KcjYQYvdAvxTTJ91yujFOcAp2hBv1mf5mZF/lGrWgqJxFWlDtb32p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=lImJ92c6; arc=fail smtp.client-ip=68.232.159.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1736728749; x=1768264749;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b/85iy9iMT+0+wIDCxRLPe8fxggMWY7D4041rzjkJWQ=;
  b=lImJ92c6aJbI7xbZAzfP0wauOQe9TFfkxw24h7FnE9KmYHAhF4Fb0Wyu
   tZrUnCnopIgmxf1lS9+N25X38Zroxw2mapO3UTAjYyn75jz9/M/sK+sNd
   eW27ipHrLkWMh0no6ecAwRLDJRuTl5seN+dgb5X1bOl1KGbWk+7l5Cj00
   +O/2mXIu4j3QYReD9r+OQKRgVogBnipPQqJxwDGJ4NRodzlcqZr8Sm/lL
   U4vi0WadLPHYsAikWoPdlWvLyKLniKvBqkD6GX7oGrfEii2hh7nTBYY5h
   j/nazGGGJ0Bls8sqzUQaRrcH9A4jo0YzvaaVxijT8Wj8DC+gffinoY1t1
   w==;
X-CSE-ConnectionGUID: W6lwxFRATv6Ge4e1Vw5GfQ==
X-CSE-MsgGUID: /79cFfqOSjC6Nem7Am2+wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="142743898"
X-IronPort-AV: E=Sophos;i="6.12,310,1728918000"; 
   d="scan'208";a="142743898"
Received: from mail-japaneastazlp17010007.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.7])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 09:38:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bhntrj6rzEzm/6sje/xEqDELKCcvIkHPj3pnejfZgRPoBMZBvv8FCsyrOagu9i4N+DQyuLayU48T9zu1CQ7j2KH04P2JxMVd5idoWS7DLvW/fWt+w1L0iY0WWyp44A8b8aUQMfmmozQq58PlCsDx3FwepdbaPHJ1jFmnBZihpfOze1pACgMIifDndep4j2X0dTJxKGjCL4HmjevRcyEyiSFeSSfVSbpNBlFDbQG8mpS+q0luJTTR0XK0rbA+z34GactdR3isTYbG5n7NlqVLBS5oLlOGj/Ha91BSL2iC/tpOCMfgs9D8QRrv6VX0/7ln/KWyodoMRUJcyrGQ4e/Ivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/85iy9iMT+0+wIDCxRLPe8fxggMWY7D4041rzjkJWQ=;
 b=ACcEFkyPDHXV1wFuX7joBvuBdZ3gihnAeksO6d30j7ms3Jwm0DJ8+144r6AnB2oq4WzSZQxsIac7jqql/iam2I4ZORw2VI6zxlNH3pBHLBzqCHOIqu+JeYrXSGU2J0InpZqNp+IFSZmXyC3cUsX08jb/UsYHEVb6SWcKBSfXoH77K2BvaQbu1cfbTtVS99JpHztwvqIYTkk6lXOFrvp+pYA1OIoq8oFFK0nMViMDBhx4lySQqMT9lvmnF4GyOsSJHCjeGFIupl1yXAuiG7W0reTZYnJyKETmAColu9A5POZypkGW+zEB/4OmIWtlybvwtrspxHroyTe1cEW3jt6yYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS3PR01MB8746.jpnprd01.prod.outlook.com (2603:1096:604:152::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 00:38:56 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 00:38:56 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: =?utf-8?B?TWljaGFsIEtvdXRuw70=?= <mkoutny@suse.com>, Waiman Long
	<llong@redhat.com>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Tejun Heo
	<tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet
	<corbet@lwn.net>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/cgroup-v2: Update memory.numa_stat
 description to reflect possible units
Thread-Topic: [PATCH] Documentation/cgroup-v2: Update memory.numa_stat
 description to reflect possible units
Thread-Index: AQHbY1tJ7nmGH8oLA0S6HPS6Yi7P7LMQIWAAgAACYACAA7yMgA==
Date: Mon, 13 Jan 2025 00:38:55 +0000
Message-ID: <fb14b1d1-53b9-4f0c-a605-a82f113d2189@fujitsu.com>
References: <20250110123019.423725-1-lizhijian@fujitsu.com>
 <a8d5ded2-6921-4c6b-890d-17227147c28d@redhat.com>
 <2piu6sz3vkjl3scu6puo45ewu5ffuzv6ikeetgt6rizpswkcec@2uezwhes37io>
In-Reply-To: <2piu6sz3vkjl3scu6puo45ewu5ffuzv6ikeetgt6rizpswkcec@2uezwhes37io>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS3PR01MB8746:EE_
x-ms-office365-filtering-correlation-id: 039c58d9-a91a-4c8f-b6c0-08dd336aa955
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VmJRNnM0cVVtTUlQTm5PZmhoT1NsN213eUNJL2w3Zllrd1BnU2N4eERRV0dK?=
 =?utf-8?B?TWhVUjFCWHRVLzJ2cHNzQjMzc2E0cmY4NzdzaUQrSy83TkNsUU92d0NYM0Uy?=
 =?utf-8?B?Ny9tanc5cytNdk1kWUVxQ3prN1VucEEzWE12bXdyaHpkaVRuTUlsWk15b2oy?=
 =?utf-8?B?UWJ5TEluMHBZWG5NK3JYMTJDQlhxVXBtaHRXQVpVSFNhRldNamh1cFpUNmlG?=
 =?utf-8?B?Z0M1a05CT21uVTA5anJnc0U1bkJlU3VKSWhEekJCNmlZaWJqVVRZaUtLRUZM?=
 =?utf-8?B?NndKUm1kY0Q4VWhqeDJxQTZTRUJ5aWMxUFJqQlpJUFk3TTNlSFlTaUk5azFM?=
 =?utf-8?B?SmJ5anE0SHVrOUgwQkQvNUhIaGVqQmVEUXVpLzNPaE1iemFHRGlwTWpVNmpV?=
 =?utf-8?B?TS9wWVliWVJnTklLbng0aVhyNTc2YWdBTGV0dFA4UE1ucitFRm5CckQzb3hl?=
 =?utf-8?B?c01rZkRRYnprbzhnbk9YVXZ5aGozSXdqaTFEOWxxYk4rVTZDWE5EQ0RTZzlP?=
 =?utf-8?B?MllIRnIwQXh6dk9DcEgzdmxDSTVkb1FMdWpSNDgwUFpqckQ1R2h5ZC81cXAv?=
 =?utf-8?B?TWJqYmpIS3ZHVzBybC96N2VRZUx1cmlvMXUya0Y1anBIYXBlaHNNK3Jha3ZU?=
 =?utf-8?B?U2djb2NNcGpCWUFOVHlDRFoyS1lza0lJeWpKOUIxWXpxVERYOVVJNUJ3MTNP?=
 =?utf-8?B?dTRZd05Xc2x5U2RHT3NkamNJbE1oUEdpaG0yN3lSVGJkZ3pzcFdxdmI1QnZG?=
 =?utf-8?B?VXc3b2tqT2VTeTF1dndqaGwwTHhGU0grMmUvRXl0bkRGV0RKanBOMUlLTG5o?=
 =?utf-8?B?Y0dnenVrcTdPS1gvL0lSNGtyR2FTWEc3TDVvN1dOeW1kMWpSQjBRN1hpSHVv?=
 =?utf-8?B?SFNkOTJzOWprd3plcHBiczh3KzZPanlhaUpNL2xnR25KeCt6ckkwZGZDa083?=
 =?utf-8?B?dzVra0hjRGhDZEplMERHakZ1dVY2K0R0UUhEK1RlWENZeEs1ejAwclQ4czFl?=
 =?utf-8?B?UlVqdHVQK0Eya2RBc1IzZHVkM3kxMjNEejlQdmZQY3I4eVRMVGlZeHFWeWRL?=
 =?utf-8?B?K3NtYnR2K1k1TnE4UHJ5WXk2UEVqQ0IrM2ZoMGlKL2x4L3dQdEsyalpDcFlT?=
 =?utf-8?B?VXZFaUJnRmZBTkdwYWF6a1B0bm40eC95MEZSS056UjNUYmRBazJXMGtLMFhj?=
 =?utf-8?B?Y1pYQU45SHp0eDVvZ1FVa1F2UFRZdkVtb1FuZnNOVm5Tb3ppUk5CWkFlMGZ3?=
 =?utf-8?B?Z1BYUHVuNFFEa0NTWnV3QTVXT25ndFAxRzJudUVvOGhtMlQ1TmNCQkJHWC9a?=
 =?utf-8?B?ZnlYUWo5VzJSZy9wUDVrRmNhQVZacit4STdJMStPeUZjKzd0Z3ljSzEwckVs?=
 =?utf-8?B?ejZzNGRvVjliTlE2M3F0UDBHR0xrNDFraHpRQWJBcHpRemxwTCtuQnQ4eWNv?=
 =?utf-8?B?cThKS1NycGNWYSsvSmxaWGs5UGlVYU1RR2k3M2d6U1Jkb1JqL0RndWVrRy91?=
 =?utf-8?B?dXhzUjh3MktsbDlDUytjU1VsdVFEUkR1cC9OMDJGamdWWS9EWUtSaThHaEZQ?=
 =?utf-8?B?WWRuTEhsZGFFaDFLam5tOVpXRHFQQWFqbkliM3cxMlVINk9xRWFuYzdTWmhT?=
 =?utf-8?B?M0NCVDZ1OGZyZG9YN0pCQ1Y5MDhhc2tFWk5ORXN2RmJTeEtrVFN5YzIzNFVC?=
 =?utf-8?B?anlhOFdRUXZtcnZOYjBDR1BnVUtCa1BINzBEaEZUdlFoYld6L2xJWFM1NG1h?=
 =?utf-8?B?NXN0a3ZvejlUL3RaOC9wWXNaaTVERFUxVHJZbDRPTk5mWmswTnBndkRNZ01r?=
 =?utf-8?B?cDBKSFlodU80bk1FNjlndDdNNHM4ejJKSnhvYUw3VzBzdUFmN2J1Z1NyYTRH?=
 =?utf-8?B?OWphMW9RQ1Y2NUk2Mi9MZFBhRXJjTkJnM3hOd1BsenFuRVc0aVlCVXZBMnVw?=
 =?utf-8?B?Y0dMeGhHbjE3VUFWMFgrMXhmaXA3Q2ZWbFFKRUltT3hoWlFWYVhUcjhKV2RF?=
 =?utf-8?B?VHpWeEFFZmJ3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1RBY3gvK0dpTlUrVnJOc2xvQ05tSXkydUpSWkJCcDVkdWhUYzN1cXE2T1RC?=
 =?utf-8?B?WVhtSFdvaFNiejdaN2dpdlZ6WHNIWlU2VmhGLyt0cHI1eWtFUytQRGljditB?=
 =?utf-8?B?QjloTS9mZkJIeFRMdHFObjFRRmxuYmNyK0ozVy9XMFdZTUE1cmdWSSswWExR?=
 =?utf-8?B?anAzaFNSMzBMNmdGbWNBWWRoKzdqeVNMR251d1dIYnp4SDBCN2hZSHlnUFdr?=
 =?utf-8?B?MTlsQjBiaXpzbVh1dU9QTXg1VWlaZzlwTCtaKzh1c1RqUXhTSlB4WmxRUFJa?=
 =?utf-8?B?dWFJZDJWKzJ2UGs2YkFROHIwTVBhYUN1YzcxSzNvNGNLY1JNeXp3dnVzMzBr?=
 =?utf-8?B?LzlQSlp6MzBGb1pSdmkxUHRlYWZvL2NSbzc5bHJycjB5eXpUd2FueWVlZlJq?=
 =?utf-8?B?ODJYVnIvUGpneFczajg4Z0tISmRLSTFEV1JZa2l4OWJxWFBac1B5eG9nZGlX?=
 =?utf-8?B?MCtOMVg4WXFVOE0zK2JMd1ppV2VTM25yRG9NbUlMc3k0NzN1NWRtK0dsditw?=
 =?utf-8?B?UDlZZ3hSU3EzcjhxbGl6bVVsVmY3NEJsc2tEaXViZUU0aDJMaGwvN1ZiVlAx?=
 =?utf-8?B?Q1JpL0FCRGkvLzEyWER0VWxHMCtOd0FnS0hHR1ZaUW9BMmljR1RSWG5qQzJl?=
 =?utf-8?B?ZnNEWFpSajJncGl1elBDZWJuelp3NjJQWUpKOC9JTkd6WDBYb0J1TUF3MTBi?=
 =?utf-8?B?S3FwdGpQZUgzZFZZR09YY1EvT25Xc1pLZE9VMjBYVnVSVHp1Q3c3clowcExu?=
 =?utf-8?B?MFk5dzB3cHZDRTVtb25TU3FnSWdOcHNRMklVSTBIMGExby9OT1pKWmJnT0pP?=
 =?utf-8?B?cTQzZnlhMzlPTHBpTUZ2SVBJSWFsNkFQc00ySGs5bmdEU2RTMHdtNnhEUEp3?=
 =?utf-8?B?c0luYWozaDNOb2huUkFaK1NkUTVmRThxVktHcW1HM3QraGZFUForaFhZdlVY?=
 =?utf-8?B?KzVZeWtTTm9TRDFkS3RaOEE3TmFmd0dVSy9RSlNCY1NicW1hTk5ua0FYZUlu?=
 =?utf-8?B?VXQyanlRTlVYWWRPTXFMYkNjTGxkMTUxa2tjUVRnWlM5eG5hS1VGK3JwUS9D?=
 =?utf-8?B?L3FRaEpKeG1qUVhORXRLU2xJekNHd0tFVStVZm9TVldKSDdpSzNuMzJoUVJp?=
 =?utf-8?B?ZXV6L2NTWlhyd0FQYWd1YUtTLzJKMWJRQTd1d2pYcmFPWXZxUDFjUjBvVHky?=
 =?utf-8?B?TU5YMytlQ05NMnhaeWhxUEg2NWluS2pyT0g1RUt6S2RiNjRFUFdKWVpvWG9J?=
 =?utf-8?B?UVJCdDd2MEhwM3VoU2Jxd3Ixa1MrZkxWMGRvU2RDcUZsbEc4M1pyOEpKeGdl?=
 =?utf-8?B?WlR3RFNoY21pVkgvbW5sRSt6R0dsVWJya2IvUUphNWh0NFN6ZHYwZGdPcnU2?=
 =?utf-8?B?SWRJaGZvcVBCbGxkZlNJUU85TTZpUlFtWjRabUp5RU1CWEUwbU5sYlJCanNi?=
 =?utf-8?B?OE16VHBpcGo5VkVnVUZmNk5pZmlyWVo2UTZESExhMWJtZTROd1VOM2l0RzJW?=
 =?utf-8?B?YzR0VVZmaGFseEE0c1NhRG0yRVlzWmpIcDluSHFZelpjMnpCSFJwUmllWmI0?=
 =?utf-8?B?R1NZTVFwRGhMMWsxd1hQWnEremhkdGpLS3B5RTJkZEJFb2FkWEhqdHFyTUFP?=
 =?utf-8?B?Wmg4OWdTV3pDclBCUUdzY0czKzh3c0ZSbkNZOElwUUJVN281bXVIK3BVWE1J?=
 =?utf-8?B?Mk4xQU9aalBBTWViMkY3MjRld3paeVlSVVdYM3NUNFUwVTdjZlkvS1NUYWVM?=
 =?utf-8?B?czJjQldmdk90alhUWUZ2ZDMvN2xjUzNKSUlycDlDV2Q3MU9MMXZVOWwzbUZD?=
 =?utf-8?B?Nks0WFlyOFZTRjFkQ1lUVGhLZ2E4T1lUWVZVbWpWMWxXb2ZvWnRUcGFyNDJ1?=
 =?utf-8?B?bURaY1dnZWErT3MrbkhyZEtlNkZib0RZbkd4amlhaHRCWGZQa25kWnlHVS82?=
 =?utf-8?B?TmlmclJSOTNwN3dRRUlwR2pLS3JnVURjMjB2aFBoY0o3RUZ4TnJycDFMK3ds?=
 =?utf-8?B?bzNWMHh5a2ZQcSt4ZTdXUVM3ZEtCYUtCMG4vVEdMRU8vWk9EUDdnSlhMSVZV?=
 =?utf-8?B?UnFselc1cTdZNlc2RlVmWGtnSEQ5YjlMUGxyOFRvbjJLSE5sMy82WkFBWXpx?=
 =?utf-8?B?K3MvU05QbXFpcmJFZy9SdkR0bEFDSGx2bFBxK1JEQWtZcGcvNWZ3OU9na0tm?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FB53B7D743F0546854ECB8174D1D0A5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	synmJ895nLscvSIpgmxKvHPRsUkNYhOe2iqTzn1zmkS6s2GqMWskr7iaba2BUCfBBhf8BkIsuJPq97iiF2Z9vbme3PEIcMy7BljWGEk+7HNkAQVQyn67Xo8P/+f3js0f6mSMfbDE9gj75l02MIB3gM/nePG4jjYKPKTcrYsmQuzFOFTtoJ1TXtZJX8wSF2KKT5EVur0clvlMwMDgoZl7RuinhePAKAS2iXoqTwQVmOQSA4Kas9nmivLg+GvuSq4UqNzm4TYTD7mplL2Eg7+ox4sNPnUzU97n5rAaM04/ZMXJEvgsnSznJTgp2PdAbya7dT/P9VIG4AzMcO7IVLsLDD8QjhF5qr98ue9duj5bUOq0LsbDiacoZ+oEhESJj05Yn85Qr4lJ0LSilC47qLojGFEn96Km+5DDyb4vCtCNgyK2NhVpLhW/sNtCWsBi29n+RY6qH/vHeEgly8luubh5LWakyJ82SWjJSI6NYWOfubFlDpxet4NitE7U1GmDnduRCF08GU5DAMOGF/3Z+QF70jdbFvJV6U8cp6x6O7cQSetJx6uWzhOh8mdtiVjKCqk3BVfavrU+Ptz1tJ0hS9XdBMS8FmVJaJSxBvb5Gewym4nCN/Lt9CTDD9b3mtOOaXUF
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 039c58d9-a91a-4c8f-b6c0-08dd336aa955
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 00:38:55.6919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UTl+fKDZsToiHKrxJ9dFSav0eMNoASjsscDp2CIBe7SGv/z7WuhCoACce0L9RImL1jjE8HUaZPBHNyCxesUNeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8746

DQoNCk9uIDEwLzAxLzIwMjUgMjM6MzUsIE1pY2hhbCBLb3V0bsO9IHdyb3RlOg0KPiBPbiBGcmks
IEphbiAxMCwgMjAyNSBhdCAxMDoyNjo0MEFNIC0wNTAwLCBXYWltYW4gTG9uZyA8bGxvbmdAcmVk
aGF0LmNvbT4gd3JvdGU6DQo+Pj4gLQlBbGwgbWVtb3J5IGFtb3VudHMgYXJlIGluIGJ5dGVzLg0K
Pj4+ICsJQWxsIG1lbW9yeSBhbW91bnRzIGFyZSBpbiBieXRlcyBvciBieXRlcy4NCj4+DQo+PiBZ
b3UgbWVhbiAiYnl0ZXMgb3IgcGFnZXMiLiBSaWdodD8NCj4gDQo+IERlc3BpdGUgYm90aCB2YXJp
YW50IGFyZSBsb2dpY2FsbHkgY29ycmVjdCwgdGhlIGRvY3Mgc2hvdWxkIGJldHRlciBzYXk6DQo+
ICsJQWxsIG1lbW9yeSBhbW91bnRzIGFyZSBpbiBieXRlcyB1bmxlc3Mgc2FpZCBvdGhlcndpc2Uu
DQo+IChzbyB0aGF0IGl0IHBvaW50cyB0byByZXNwZWN0aXZlIGV4cGxhaW5lcnMpLg0KDQpNaWNo
YWwsIExvbmdtYW4NCg0KDQpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciBhbGwgeW91ciBmZWVkYmFj
azsgSSB3aWxsIG1ha2UgdXBkYXRlcyBiYXNlZCBvbiBNaWNoYWwncyBzdWdnZXN0aW9uLg0KDQpU
aGFua3MNClpoaWppYW4NCg0KPiANCj4gSFRILA0KPiBNaWNoYWw=

