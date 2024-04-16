Return-Path: <cgroups+bounces-2493-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 364668A6147
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 05:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985B01F2235E
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 03:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4110C134AB;
	Tue, 16 Apr 2024 03:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kbdKKuf5"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82F0F513;
	Tue, 16 Apr 2024 03:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713236714; cv=fail; b=X0cL3sq/MTtZqzaT5FA5D/slAGtajYphCut1HrJvdxOkPfQ/PdlIR8+2m+l2vNg77EV9Lz8XnguQ+wCPTCledWfgnmO37dlcSvlcsCMGdFQbldsjNsXJDvBOZOSY0SKeP2VuqynP+2p5cGlaBQiWV7wNKsc60axA2R+eRkMd0ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713236714; c=relaxed/simple;
	bh=OTD6faEKd7LA5ZnjpQQmjPN5Zkp7iFk6H92FTy4a3zM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D+QstgeEj9+DFcgCeDMVeWLIobUvFaSGQpIstWcpP508MQ13zDfDvJs60TIAoK7rA/WaZXyXY9i34z0Jqe8yY3z0fUs9v+J+tAoLGcewwBN6zMRkgerXC5JIK/6gDYUmzNt+7Rd9ejTPs30Fwzau8SZCFtl+AzJHX+VAwXA02EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kbdKKuf5; arc=fail smtp.client-ip=40.107.93.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IEUUhK1i2u4B0H/n/qLUZ7ggvtm0MZkz5TAcEZeL09Q8HKxzKjXEnR8QbwbXb2UDuqUbtcv0VnxRCYrG6KhLcKG6njiXvxJL96h0J1ZQfAGhwySYcgXdB3VhLo4OsaMKR1URV+COceAjfWV/9fd0CjXa33Fvk+/K4sBQyz94Hw2NqLSfnWbjQNmZyoyofDOfVVjwlIRobId3JUGt8SallLh9EJeh0IVTnQVNjO+KtT5efBJmfaKMz78fFQ16YDIO26V+uK5Owrs856Fzxk+9p44g12DBKlXYpv8wahpNUI7+nJy1YE+P0sFVPohLytIwGtQl2vfqSnmr7okABcQpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTD6faEKd7LA5ZnjpQQmjPN5Zkp7iFk6H92FTy4a3zM=;
 b=Pm/QvUq9SiAn8lEh2LSUZFvBIgx3YgvMb0l7UuqTlkyfPHpDfquDApLue1yITHOhamZ5wOAWNjhiq2y74sh4x7jqY21azc57aSnqlRlOMmg77djLv9V2b+wC74asdPG05766YJ+F2yFJOqU4uJJLT6TWjRPq+cRvRkOUdFByzC4ouaCH5KDlV74qO88kvrNxmdr45ZhZwZ/bRgEnQm32oL3MbqOjcaD/K6OPtAD61a3iNAE39kIkrVVLQBc9YPXeq1SSQ8tXeXRPtNqWUFdLC1eBb036fyTl2ueqZIQfLnvZDsywZ48zLGsLsw9r61uFqU+ruCZ1kT/XljFwxPsxXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTD6faEKd7LA5ZnjpQQmjPN5Zkp7iFk6H92FTy4a3zM=;
 b=kbdKKuf5WCeuWTytHcv+McCGmSKRyH+uPf+/HV8dhMWdfk8yOwpVSMHD+q2n0CI2slTIvLPdIA00lXa9bye0OIJJ0xsCruOI9KXyI80eKNRCCuq1poEu3uqyc0IOQgusFCHlTMkzEtMa+QWWelybaHjLTUUPJmtYye8y8iPZUtYZ2SVH5TFG0qXsXl9TtdI+BPtcg5vNtjujpVRln6rvPBnoz8rFLtfOfDOATLMsrNKD9NdPL9T+o3UTL7pMhi3fkTBP+iLv6M+QJASvpQlxHawtJOEZ9pr4AWRkpzUt9JSAXIAMoyYBqvDCE2czRqIjoUa96w5pSFApo/PeBX+odA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 03:05:09 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 03:05:09 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yu Kuai <yukuai1@huaweicloud.com>, Tejun Heo <tj@kernel.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "chenhuacai@kernel.org"
	<chenhuacai@kernel.org>, "josef@toxicpanda.com" <josef@toxicpanda.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "svenjoac@gmx.de" <svenjoac@gmx.de>,
	"raven@themaw.net" <raven@themaw.net>, "pctammela@mojatatu.com"
	<pctammela@mojatatu.com>, "qde@naccy.de" <qde@naccy.de>,
	"zhaotianrui@loongson.cn" <zhaotianrui@loongson.cn>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "yi.zhang@huawei.com"
	<yi.zhang@huawei.com>, "yangerkun@huawei.com" <yangerkun@huawei.com>, "yukuai
 (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RFC v2 2/6] blk-throttle: delay initialization until
 configuration
Thread-Topic: [PATCH RFC v2 2/6] blk-throttle: delay initialization until
 configuration
Thread-Index: AQHah/nBklcJbQT7r0CusO0+yp3Vs7Fk9kaAgACGTICABLphAIAADt8A
Date: Tue, 16 Apr 2024 03:05:09 +0000
Message-ID: <1f2bade6-9a82-4c59-be61-703be45ad5a4@nvidia.com>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
 <20240406080059.2248314-3-yukuai1@huaweicloud.com>
 <Zhl2a2m3L3QEELtj@slm.duckdns.org>
 <7531ba77-964a-169d-f55f-a8dcfcdbb450@huaweicloud.com>
 <f1cbd12d-b66b-131d-44ed-8db67b9186db@huaweicloud.com>
In-Reply-To: <f1cbd12d-b66b-131d-44ed-8db67b9186db@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB7233:EE_
x-ms-office365-filtering-correlation-id: 9543c5bc-44ab-4a8a-59b0-08dc5dc2069a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 g7N/sSt7HIM+nfyIZwtiPJ/4zK+qKWbT542hcyyEj4AHTAuc21shLIx1h1UX+s6T8uMbeJE/OMBCCdDE4jloY6xGdJk2OOXvXUdW1OmalQY6aorxEf2RHRsVV0Yg8DzLkJJJkiYyUtsM7+pFJN4g7t/lMke641ju6HcGOc64V9aPfN0e3cpTD2CRUHinbJrlr2Ilk/fhTQb3QKhBEkszMXHie6B0x3+zFELnIGvamevcx3hSPwgk8JXYPw+DDtm3C0veVf3KoFyPkJL/wQRmhNGSHwxcRusuzUxD6GrCo+yrXq2/H0MkOeKOt2COCHuBwmJyJ0I93DDcbPo6JmYr9+Xf8CMdsAPmzgquK9dNNpZa3s4oio5c90bih+OSRm3pCJH0tXe2BasTMe+OtNuXWZg21smltuW/xLzHhMcWfMybaActuRDovp+6MDHt8gfT+g/8fX/CHuVr//hQgjWQB6xgorAuBgOpTyC8D8uiPOT6IIXPRC3N24FH5R+4BC8PojptNZBBxSlRTthLHeGEWEJITB8H4kbanz7QimXlrVXotRAYyt5GBQYnMVOXiCBhj05WRF7HkOZh8XO1sfQcrZ2bl7O/RLza1k29Z0lPBbG5nA5j9erRA/Zmp+txzPltKCrYkOYhOLi7TsNzCr6sQfkHkWVPwhrv/rd01W65J3NyfDxS8kil3KaJ5Tr1NVPalXCraEiFa/gZVvh7bWA1WFyq3E2JnihZFNboPLoBc/Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1NnYi9MS2NhQmZ3THlTYmRDVnBuNXhwTFYyMzU5TnZHUFg0cmhvRmhINW5K?=
 =?utf-8?B?OXBoRG9UVnY2OVpZRWdFMS9FdlNpbHI0b0NDS3ZoWEpkUjNPS0I2MlM1ZHBa?=
 =?utf-8?B?TXErTjFFekVERU41TGdLL0dDUWtvR2dFZFNiOVREVncycHFsMXRhdktRVmVZ?=
 =?utf-8?B?NjEzbTVlQTkzekVXS0l6UmJ1MjJGL25wdHNpaFZzSWRudEhXQW5OTmhNNXAw?=
 =?utf-8?B?NGtxVU92OFFna2hzbnRJSFJhN3crM3REb2RVVjRzUmJwL1lNdktTS0xjaEVB?=
 =?utf-8?B?SS9DZXZQWk9tbXZsaklIcTJCV1YrZkZjVUZhSDJSSHprRzIwbDNFUU9tR2Fo?=
 =?utf-8?B?bTB1ckJwbGZSSjFoT09ibHlBeG50T3cvRDNzL3ZCaUpnT3BlL2ZpbUpBdXZC?=
 =?utf-8?B?RHppTlBGMWJaQ3EraVNYV21LcWV6NXRHaU4xV0VvRldaTGJZbmFKanA0RTls?=
 =?utf-8?B?SlRYV1UwWUJIeTRaWnV4azhSM3piRVdoMnB4MTRHYVU0Yno4VjdIa0ZWR0VU?=
 =?utf-8?B?QWFYV3dYUjF3b2w4UE4weEN6bi8wQllMZTR5NTczYmRIZk9VdDA0TnZKYUVU?=
 =?utf-8?B?Ukdya3Qzc1p0TVZzTVhJOXJRMDEwMkVnclJ6L0xmUk0wN1hXOHBHNE51Y1Jn?=
 =?utf-8?B?VzBoNUtPakRGZFJXNlIvNlhRY3VhL085QVFxUE9QZkpmUnBvV2ozaEpQZ094?=
 =?utf-8?B?SStJaGtXK0IzVTdqSGI4WWhsOXhIeDJiSTUxSTFPQzByYTR3NE4yNm5Xb2Zl?=
 =?utf-8?B?aFp1K0JxSGtnWW4yVVVRODEzaW9kOXB1Z2RTemdMTTVHVzZDSTZQTnNuNE9w?=
 =?utf-8?B?aVFzUElQRnFCYXdPazZxSC9JVUY0alBLL0tObWNSZHJ1QjRUdDBkaHVzdWY1?=
 =?utf-8?B?STYzc0prcmFKNW9nMXdqc3JvdjhmTW5ER3Fta0xjWkRYTW1JWVJSbU50M3Mz?=
 =?utf-8?B?QlRsS0EvVFdUL3VMSkFlV3crRFJGY0FvYnA0QUMvc0EyLzhKSGxyT2ZqcTlt?=
 =?utf-8?B?VDZuUWN4WG1abzgzQ1ZkOE1sREFhVmQxRXgvQUltRlo3M09ncnlpMzJESXRy?=
 =?utf-8?B?Vnk2MGRoTVlRcTlyME5kZXd2dEhXRTRGT1V4eERXVCtScHU1V3UyK3B5VkRa?=
 =?utf-8?B?ZGpFb25QZ1J5U2NKeFR3eDVMRWNxY3E4bnlWWmI0Vm5oNHV6M1I1Y1FzR215?=
 =?utf-8?B?UXFzdVcyRlBnT01xYTExM0VtL1ZkTFE1Y1Z3aHk2bEhKQ0gyRlRSZG9oSTZ0?=
 =?utf-8?B?eFhiZkdwVHh1azhjRlBxOWJOZTBjWXBBY0lsK3NVYk94aVhEVWNxUVErbmRX?=
 =?utf-8?B?elhkZ3gwYmplUFREWFg5My9qR0VpREF1UkxBZ2R1VVlLRVYrU3VwcXY3bWF3?=
 =?utf-8?B?dVhXOVh4RmsxR09uR1FSN1U0dFRBTFRBZlpvY1doMzJHWVAyclFmVnZHU3dj?=
 =?utf-8?B?SmxZamhudHY3NFFnVHJPZlVMMm9sSlBTTnl2T2QzR1Z0YXptYWxFZGhEb3Zq?=
 =?utf-8?B?ZW53U1V1OFFucFhnczFEVXZYbk9obE1idlpmcFp2ckpYam5GM3JseWwvQW05?=
 =?utf-8?B?ZWl5MVo4ZWpsUkxDaVAxM0JJTUl0NlJBakV1SkRYT0Vyb1ZMbElLWEdYcVN3?=
 =?utf-8?B?R2J1TVNRN1JOaFhqNlFwakFWSjgxamVIc3dPQ1RlK2xIb0kvYzc3WGE0a254?=
 =?utf-8?B?MVlZQ0NZM2ZzZDJtYlRkUDFSTGluNFdvS09nYXVXOXl0SDVpOUtzWDlrMHNQ?=
 =?utf-8?B?RzZlVmZSNEdFUDZDZ1RqM0FYaEFlZVFYdjRramZZa1pSNGVKMDZDQUNwa3JG?=
 =?utf-8?B?aXgraFQwVnNsYVRMcllCbXhDUEhxNU9QQjFyZkd1dmRNMjNhcDgzU1Y5aFlu?=
 =?utf-8?B?cFEzWjg3TC83d2h5VEhMYzd5YlZkY1B2dEE2Vk5TN2RWNVB3ejZpcTNPWXhn?=
 =?utf-8?B?TjNWZmZZczQvSUZZdlc3OXNzeUFDREVuNE56RS8vYnRFa21peXcyUG0zd3Y3?=
 =?utf-8?B?dytDa2pRd0tZS050TGZkQXA5Q1dOVTlmcDd3a3RxUEpSMjRMOEt0QWd4ZUJY?=
 =?utf-8?B?bWpuL3NxaHZIQUFpQ2RuSHIvM2JNNVNrMDJqVTZpYVE0MTBQTTNoNjJIU2dF?=
 =?utf-8?B?QWdaWjFEMU9hN0tXbXplMWcrVUVWWHdoTklqdGplQXRqN2ZZYnVpZ2xnMmNi?=
 =?utf-8?Q?0YkjjDCPjezyfKKZKixE7EQ2QuWvi3KluqPRzUPe0zd4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C9C33850A32E34F9067908049512673@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9543c5bc-44ab-4a8a-59b0-08dc5dc2069a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 03:05:09.4951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xYMahG/rQpD8W6990ZNrgQfsQnT9dbxv+jHs6JVdO8P2kU+vASAciEtvxHj+PFg2bfy5ylgiGiTNMqQj0Am3Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233

T24gNC8xNS8yNCAxOToxMSwgWXUgS3VhaSB3cm90ZToNCj4gSGksIFRlanVuIQ0KPg0KPiDlnKgg
MjAyNC8wNC8xMyA5OjU5LCBZdSBLdWFpIOWGmemBkzoNCj4+IENhbiB5b3UgcGxlYXNlIGFsc28N
Cj4+IGFkZCBob3cgeW91IHRlc3RlZCB0aGUgY2hhbmdlPw0KPg0KPiBJIGp1c3Qgc2VudCBhIHBh
dGNoc2V0IHRvIGFkZCBzb21lIHRlc3RzIHRvIGJsa3Rlc3RzLCBhIGJhc2ljIGZ1bmN0aW9uYWwN
Cj4gdGVzdCBhbmQgYSBmZXcgcmVncmVzc2lvbiB0ZXN0LCB0aGlzIGlzIG5vdCBlbm91Z2ggYnV0
IGl0J3MgYSBzdGFydC4NCj4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwNDE2
MDIwMDQyLjUwOTI5MS0xLXl1a3VhaTFAaHVhd2VpY2xvdWQuY29tLyANCj4NCj4NCj4gVGhhbmtz
LA0KPiBLdWFpDQo+DQo+DQoNCkl0J2QgYmUgcmVhbGx5IG5pY2UgaWYgd2UgY29tZSB3aXRoIGF0
IGxlYXN0IGZldyBjb21wbGV4IHNjZW5hcmlvcyB0bw0KaW5jcmVhc2UgdGhlIHRlc3QgY292ZXJh
Z2UgaW4gdGhpcyBhcmVhLiBBbHNvLCBwbGVhc2UgQ0MNClNoaW5pY2hpcm8gS2F3YXNha2kgPHNo
aW5pY2hpcm8ua2F3YXNha2lAd2RjLmNvbT4gb24gYW55IGJsa3Rlc3RzIGVtYWlscy4NCg0KLWNr
DQoNCg0K

