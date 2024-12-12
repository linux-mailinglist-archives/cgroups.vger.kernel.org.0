Return-Path: <cgroups+bounces-5845-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD439EDDE5
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 04:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1CF281C53
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 03:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1C513D531;
	Thu, 12 Dec 2024 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c+ghdrgc"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25112F44;
	Thu, 12 Dec 2024 03:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733973953; cv=fail; b=OFWRLM09xDsMHK8JfNBgRmlwdDD12Y83uvKYtdO5YK2JA3EHDiCpxwY3wnow5+DpGiHH4xvDsjRUSLAvrsdenufcJg+81Kvw1WbQNq7nvKhLrEhkdD5lGtUuW8E75+XGIgmqFgA1eTqLHS+CKPthCOcIquXodQN4H9mDBOd/awg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733973953; c=relaxed/simple;
	bh=uNCxmw6Ir5OBwQrPOx9GaTyEFwwqIP3EmnLF0n9M0Bw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iaw1RONV+NqZF5sAI30m8VSq8M7st5a+ZnTnWjj6TNMJEehiroq/OE+Oq7rJVn6p1LiHs8ynVge9E1RLKI7J3kdXaEFfP2odVNGD1cFjIoXzrDB6KhBiTqe9Ag+xuFPQC3MrjRKoHPSxxYrgXGtL1S4cH6o7D1wV11cQ7SDvcqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c+ghdrgc; arc=fail smtp.client-ip=40.107.244.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKkJJWGHYw1BwA+ZeY89/DU+yUO480AqoMrzY791DmAKugetXvuZtxSvWjfNx+UQnbO7xpL2luX6pz+SB6+gtzj3bCUYgTJdjmxBo2WKTF6B9Wm4jPIYAW1p8XmQlJkJItG3NCyj4MiDLkknykmQ8HNqXkkM9ktpt6uoE1e379W1DNDSeJjEYIhgZhb7l9/s4Yq4Hq/TmEP4gZvBymFZGMo7tqfc20JP4A0MUb2gA5nHnk3enZrUJ2PtjMYlM7U2f4lefBNnbzGE7uLLl+IknM9ulXQexEDzVl2Aj/c8s0jMch40zsQIve5xDltYd2FfVdympoYFFfwhvLr6sEJRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJKl4ACAFlsi2sfz3a/4mi6NyN6/5C+49Mbp+ZxJJlU=;
 b=Ka7Dx3o8B5TZzBoE51+3r8s2/zO0UD92k3wrw8/TKXcR5/zetg5iZ07ClClMjMNgEVw0ZNWCc9NbFrD5xubqaoVDr7zIDZytTMOOhjD1jmfYwGnY7FhA6gmCDd0W2hMy+ayU59i9ouCJnZiggzgnogahHkBHEEQNFKboJQlG44/AHPvl1AnoZNOUlCEULjFe7LsixM7jiEMar4Cjwe0prAYjceH3AZn4foiqKTUA8U2hOX72OCUIBh5ZaWEbskk5oQ4iyGuaaV2MwMKfDMOhi7pdx9AQui5r4wwWGUKIPH1scCZAdc0Jg3p0EsAvhEppwA8vpVEBs2GGst8oRB6Ajw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJKl4ACAFlsi2sfz3a/4mi6NyN6/5C+49Mbp+ZxJJlU=;
 b=c+ghdrgcp+iaNUv23Jr2nQSRByMtPTfD4v14iUCjsRteP1uzSEDc4zuq5UBxuhfmXEBhPcWXJzEyCUo4bvCag9WmXN5Aj7qBNmipSYjiISCbTXeonDnoeESPirmUX50eD8uFm0cF6e3ls9ywgDqQOS5uIg9Q2a2EkDbUcPSdk3vw1lc8NSUGR3ZkGQ2PXsfhsm3395YCzqA/+AM2FOea0j4/j7XZtcPt5TPhOzRbfFedeAVMmB2tfLTpGjlJJs+sVyHaAEakGRtLXwHgs5uDCVDlrYHp84aohLPPatloQCkbKSUtbxwyB509mcDhE/YNOJAno4vbKSokCKQBdMV1qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 03:25:46 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%4]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 03:25:46 +0000
Message-ID: <1974c064-4c17-403c-a0a0-a799cbdae2f9@nvidia.com>
Date: Thu, 12 Dec 2024 14:25:41 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: allow exiting tasks to write back data to swap
Content-Language: en-GB
To: Rik van Riel <riel@surriel.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>
References: <20241211105336.380cb545@fangorn>
 <766a28a1-c82b-46fd-b3b0-fe3b6024f462@nvidia.com>
 <1764e2fc8cff5b07aa9df1ae90a13986a3949250.camel@surriel.com>
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <1764e2fc8cff5b07aa9df1ae90a13986a3949250.camel@surriel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0094.namprd11.prod.outlook.com
 (2603:10b6:806:d1::9) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: dce8184e-2293-4e6d-4ce4-08dd1a5caac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEYyYWd1TFR0czZSbVoyUkx1dHY2V2VjbmVxZzN2Q2h1ditRLzdSMndaN21P?=
 =?utf-8?B?WXFBT3Y5SUsxbHdlREFrc3lzQllBV3pvSmhRbXY3UThRa2h1R2ZpaEhBbEo5?=
 =?utf-8?B?cnpnYm1NMGoreTBEL1hVaE11REZwS2xXM0pQT1NnODlZM2ZhWFRlSmpwajV3?=
 =?utf-8?B?V2dpSmdsZHJrRTJmelZoaTBKWFJQMXowRkFWMnlnR3hrdjdwWHFLaWZ0OUZB?=
 =?utf-8?B?cWpvc3R1WXV6TnZ0b3JXMVlrZzA2OW4wMG9Gdm5jRmYxK1poMEREQWlLSU9X?=
 =?utf-8?B?YWJRY2k0c3BCbFFWamdnTDIvTUxtbldseEpZM2RRMEMxcEpPV1d0T3NIdk15?=
 =?utf-8?B?WFlzTldsYm1VQmwvZlhNMi9iWm9Da2NXYkIzL1hLdk50VGZhdmtkTEF0Rmc1?=
 =?utf-8?B?M1Nob0I3Q0hTOE5YU1hBQ0JBOHA1K1pNaWFJeW5kay93Smhya1diN3d2a3Fz?=
 =?utf-8?B?bEVCSjNpWFR6SHBvb1J1R3Qrc29BZm9SKzZlMlB3Y1pud013bldqTkJFTGY1?=
 =?utf-8?B?UFFqbVhXWmx0d0NWUXV1aDd3Uk5yRG5XT1BhTzZTOXRmLzA2b2laczZ3ZjAx?=
 =?utf-8?B?QUNSV2lNcTVESWhZWXVzRStOeG4zaDdOR3FRNHJmUURqckRvbjN1M1U2S293?=
 =?utf-8?B?Q0twMWlWbjMrZUExWHNTTGgvU3phb285b1c1dnZYa0U2S2R2ZVVDdDNUZWd1?=
 =?utf-8?B?NmVZQkJ5aThDRmx6RlNucHF1czMzVXpraElnQ003a01CNXJoa0hic3I2YWI2?=
 =?utf-8?B?d3BlNllmRm5jRzhxdnhxYklZT21CZ3N6RTZRWWovWVNCQ0E2bEQyLzRheDVl?=
 =?utf-8?B?TW9sREN5SG00bzJMQnk0aWtWL3lNWUJ3dTF0N25mZlpBK09KRkExbmFxTGxw?=
 =?utf-8?B?MzlLZGUyYkNSWDJRREw3M1VYKzhaQXhIREFNMFlKMUdFTjY2ZFprN2FIdEc0?=
 =?utf-8?B?WFMvUTVySVFyVzJVVlNkTWoxQm5ySXdBQlIwdmpuaW9Yckpwd3hMZkFNUTVz?=
 =?utf-8?B?WkVhOGxBZlJMWlR5Myt5czhoenpYZzVkcWlURlRPZnh4OFBHRGtMTmszYUVB?=
 =?utf-8?B?VkdSNW50LzVVbnd6bEsyRE9iMm5XcWJVdVZWWU5ZMHJNK1FQam5EbTd0NUJJ?=
 =?utf-8?B?WW5ndWxDNlZnTG4zY3JJWkpHK3RxR3lxaVdLN3ZxVjk4b2ZMaXJuT25Rdmlh?=
 =?utf-8?B?VWlDeGk3RzhWd3ZRc0pqWlZyRWpNajRCSytxNVFUa1NmbXhMQTVwOW90OTEv?=
 =?utf-8?B?M2k4WlVnRDJPdU9MOGNwWmR5TFVZZ0FKenZ1Vkp2MElvNmdpV1VpMlltTmtw?=
 =?utf-8?B?Y1NQQllXSFZDN2RKTWt2U3YrUVoxbysrS1pLUXdqMDFoNGUzQ0ltWEJXYy9C?=
 =?utf-8?B?Rm42aDFWS3YwNnpUYnJhcU5scDJNSTNPd1JPR1JDa05neTN2WE9VMjNsK1N5?=
 =?utf-8?B?VGlZUCtRMUJrQlJxdmlPQy9yTFZTWnBZVk1lRlIyT2ZCSy9RdlRjSWRmajZo?=
 =?utf-8?B?bkExd2ZkUUZWQ1RxRFhjVUpRY1libW5mL1RaS2Jvem1XbnFJb0owWHdzdm9h?=
 =?utf-8?B?dVRXUmxDUnkrQmdHTTVPTVA1MkorZExTcGtlbTV6WUJ2Y2F5VlJ0ZHFLNmVN?=
 =?utf-8?B?ZndOZ0RTUzdadXBmbGpyYmdiT1RhWWpaaHQydEQxZVF4dmZTdXpWZ3ZLQzky?=
 =?utf-8?B?Q0JjUnFBUEtVaGNRTk9hdzRKZU10WWFwZHk3TmU2Y015c2JDakRleWRDaHJF?=
 =?utf-8?B?V2dkZnZPTlNRTVJjd1NsNXJjdVFJaWxjdnI0N2sxSkhTZVNNOUhPQzlveU9U?=
 =?utf-8?B?N3FkN0ZKVjA2TTM4VkJLUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWxkL0E1VlVGUGxlZllyNitOaGlXZGN4QWpQdFVDNVpoOWpaWC9xOFFTNkNY?=
 =?utf-8?B?MEhvTHZiQzhZaGx2dzAzMlFpOGJyckdSN1JUV1djVzhHcDd1emZ1MVVQdGtG?=
 =?utf-8?B?dTlQeDJONS9GOU8rajVBdFNJY0ovcm16OTlJOTBKc3FOeFFKT3hPeFFUYVhk?=
 =?utf-8?B?SzVPR2szcmJOK2QyZEphNFhzWkpLSG9Bb2ZFUFdIaHZUUGhBcnBxSW03MW95?=
 =?utf-8?B?NjhVemVMN2dZOE1JZHdwMnplbDlUSDRsakY3MHFndjFMbGVmcktBQ1FFZVk3?=
 =?utf-8?B?MEFQZk9KY2d4ZHJrdTg0dmxYOHZIL1hmQm9hb0N2ZFJ1cE1ndS90WUt3MHIw?=
 =?utf-8?B?b05JWXVSWVFoaXp1YWM4blBPcTgzdDJxMUlEZVh5Uk5jZXlPZ0FSenVjcWVS?=
 =?utf-8?B?Q2doMlZwZ2tCdlJqdGZQL0gxb245WnVxbVdCR1hPUjd1ZWU0eGpGOUY5TUlV?=
 =?utf-8?B?a2czRitwL0VKRVY0VTQ2NGZOaUtOMWNpL2U3RFJublUrQUg5a0dYcnB5ZUlr?=
 =?utf-8?B?ZTdCbzRCNGUyMmJaSTRFdGw0ZEhzblEzTS81aU9jdU94UjNuc3hIWWJvRjF5?=
 =?utf-8?B?NUYvem5DSThhbDd3bFFjS1BLWEwxRVNuN0NhVWx4ZDBUU3RRN3hQa1ExcDM0?=
 =?utf-8?B?MURRazBIdzBLU3pNMXJYWlp1YjJLc2dMN1ZkMFZmWTdpNm00Vk1jS3g5b0h0?=
 =?utf-8?B?Q1Rqa0cyNTdLQ2RYS1ZOTEdJaUYzVmFiNFYwOGZNMFU5aXg5UUxKLzBFdWdM?=
 =?utf-8?B?eEtaWkROdzBGVEdMRWUwdjBjUW1PNXZvano1M0l3ekUzWjk3c1pIeTR2RjZw?=
 =?utf-8?B?WWRJK3pxY29oYy9icUpmTlpicldBVUVpWlFpRWRyU0lqK21qOExKRTZLMlJt?=
 =?utf-8?B?QkFQWjdBaVhDMXkvRUZnbDVxNlVpOFMzd3IrVllxWTJEY2J4WVhMOFhDZmZH?=
 =?utf-8?B?RStQNjV6UWNUZlNpTFVpNGhVWHdwY3crSklUU0o0dngvRE9ybkltTENiZURv?=
 =?utf-8?B?NnpSd0pzM0ZyYkV5Q1QrR1VmWEJkbUkyRkNuOG15MnA4ZGpTbHNtT25aY0ty?=
 =?utf-8?B?Z1Rha3Zyczc1WUIyTlJJODFsYnY0T1BDREVzdVFPRUxSYW8yTGFqaFFCUjln?=
 =?utf-8?B?bjdLK3VFRHRONjNoSlJzTTNuV1JFcW55R2RZdWt2OTdjZUEvTm14eTVvN2RF?=
 =?utf-8?B?RGRBTkNOSTgvdFJXemUxMGF1ZHd0Z0kzWWVXdnRRWkhiVFlIU1FZUnJOdWFO?=
 =?utf-8?B?MUVrdmcxZVJpT21Makk5d0RFeFBST0RZb00wQnRLT0FMWHByT2Q2akpDelh2?=
 =?utf-8?B?eVAyUjBIU1lkU0J3cFByeHY3NVJLaG1mQVpWRnVFWXhteGZtM1Nqd1FqZ0VY?=
 =?utf-8?B?K2RRK0ppOTQ4UytLaXJzNlY2bmhXQUl1QlUzUWFwTDhXUEdwYkR3SEJBb3FZ?=
 =?utf-8?B?a2xQWXFwS09mUkdzbGxJYmdodE13cXFMamkxdmhBVUJWTmEwWDB6Ymk4cFJP?=
 =?utf-8?B?cVlUdmw4dU1kdmJTbEFycERubjRFTXFmODJhMmZTWmpEQ2lmR2x4dFFBZGRD?=
 =?utf-8?B?N3dzVi9kR1Q1aDBtVVV0TWU1Ty9OTTFDRUxFeU4vYWlmOTJ4Vk81RnVQY2RQ?=
 =?utf-8?B?VnpFYXdubzRMK3poRi9vMy9JZGpDTmtldlRkcUJVODk5eksrYkRsV21wUlh5?=
 =?utf-8?B?MHRSVVgrSE1rY2kvdXBxTjZDOENDUVBuNDJyMW80SUlOaGpmZVkrNm0vbGJD?=
 =?utf-8?B?ZXdLK0llMzJqTzhyVXhWc3haanFvOEhjd0R2cEFST0p3anZXQlp3c3orbW9o?=
 =?utf-8?B?Tm5TTHZIbFpaM29zV0p4REhJRFZFRVBKWStxSHNrVG53RnNOaEYySG92WGVa?=
 =?utf-8?B?aTY0bThDcnRBYjVnYU9BUndOamNlOHBpUEx4UUU0ZjF1Y0d1cCtuUkJucmxE?=
 =?utf-8?B?TFo4STY2SUFNd3kySFJtSHVlT2RzRnJDWVdudWJNd1doYjU2ekxZWEkxai9R?=
 =?utf-8?B?MnM1STBWMzUzbVYwTTd4SnVvUmpkV3FoSXdoaFFsOC9pamtITmpCazNaWHFi?=
 =?utf-8?B?Q1NXMDNkT1d4OUszYkFBSEExS1VJWk1xQkpRQ1dBMkNqamtiOFRLSFBMR05Y?=
 =?utf-8?Q?vH1FsrirghjDnzakOC0Bph6G6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce8184e-2293-4e6d-4ce4-08dd1a5caac8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 03:25:46.2498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CPjH8UOs/PPzXS7iK96gW7GX1YGdn8Out0dZzJkoa84lsmPtuvSFfw1zR+e1e9pQaFK/tJ//rltibDlnRYfcTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927

On 12/12/24 12:21, Rik van Riel wrote:
> On Thu, 2024-12-12 at 10:15 +1100, Balbir Singh wrote:
>> On 12/12/24 02:53, Rik van Riel wrote:
>>>
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index 7b3503d12aaf..03d77e93087e 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -5371,6 +5371,15 @@ bool
>>> mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
>>>  	if (!zswap_is_enabled())
>>>  		return true;
>>>  
>>> +	/*
>>> +	 * Always allow exiting tasks to push data to swap. A
>>> process in
>>> +	 * the middle of exit cannot get OOM killed, but may need
>>> to push
>>> +	 * uncompressible data to swap in order to get the cgroup
>>> memory
>>> +	 * use below the limit, and make progress with the exit.
>>> +	 */
>>> +	if ((current->flags & PF_EXITING) && memcg ==
>>> mem_cgroup_from_task(current))
>>> +		return true;
>>> +
>>>  	for (; memcg; memcg = parent_mem_cgroup(memcg))
>>>  		if (!READ_ONCE(memcg->zswap_writeback))
>>>  			return false;
>>
>> Rik,
>>
>> I am unable to understand the motivation here, so we want 
>> mem_cgroup_zswap_writeback_enabled() to return true, it only
>> returns false if a memcg in the hierarchy has zswap_writeback
>> set to 0 (false). In my git-grep I can't seem to find how/why
>> that may be the case. I can see memcg starts of with the value
>> set to true, if CONFIG_ZSWAP is enabled.
>>
>> Your changelog above makes sense, but I am unable to map it to
>> the code changes.
>>
> 
> Wait, are you asking about the code that I'm
> adding, or about the code that was already
> there?
> 
> I want to add the code that allows zswap
> writeback if the reclaiming task is exiting,
> and in the same cgroup as the to be written
> back memory.
>

I was asking about this change (this patch), I know that the return
true will help avoid the PAGE_ACTIVATE path, but I am not sure why
this function will return false if CONFIG_ZSWAP is enabled (unless
zswap_writeback is turned off in one of the groups)

Balbir

