Return-Path: <cgroups+bounces-16064-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TEk8EeoNDGrRVAUAu9opvQ
	(envelope-from <cgroups+bounces-16064-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 09:14:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6D1578CD6
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 09:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 653C6305BB4F
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 07:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA3F3B47DE;
	Tue, 19 May 2026 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NQ6YQVTf"
X-Original-To: cgroups@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C945B305E3B;
	Tue, 19 May 2026 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174602; cv=fail; b=sJ2nCAojM3yqibghG+PpJSukReKYytigvJbYURkDT05CCPde46QXlxiS1z2AYApGsma+44JXcPg3GhFSSHsgfOBUPmhEKp1jDdMBh3qJlwGoUoCYSY/JDrvlEUluLJ5o/JtJoisndr8Mx4OgkrkYoI9DO+K8xuAUNJ55BN1pmr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174602; c=relaxed/simple;
	bh=VkVQPqLCk3O5ODQdCMZHroFWdopgNmZC3kj7PS+E8cI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ADr2zvyUhFIyHJV6ivrdtJM6jTEwoobGKm/dIrFOHFQYUW7tHttoSoo/xHmFN2JjC27qw3Q1VhwQ4C9nW0A6+x/FYrV8c/hxJfuswQD5tlRqUQALjHRsKSwI6NZ57LNhG6erRN3BoiorW8XGMMMfJXVpiICxlEHUK+b1T+mSYN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NQ6YQVTf; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VESfoGjqVsylJhPLkZucjg3PL/p9xwpG9oNT0/nxlHO6zMSMH+qEa1dkiYuKP/BFvwvLVNPvVSDss2cDL6yWye3z3Il0QSpSn2pOAtN7/jDjmAWgPPFMZQIVaoNVxpXO2hCfBIHwr2y0iA5fUIu6MHa5a+uC/T7/E+bgamUupfrTizRM9zAmakwlivdvYnih+7O8xG3+lwVwX4+s6XrKNvbuvB4H0UOxgJUaRSsQxaqHTk0pL+K/wHkUMsoUpCnZW0iu6HdWfRvK/xTXsoO321Egtf45zw1Bx0N3NdJBdNI8w5P19kf+QHO5Lc6wwy8k5idliiFSd/wr1FnErCgIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDby89GDFbE2WlCNFDnN5bITqJ0cJDi+MZpwXASlNGw=;
 b=bX++wGp4czlwfL1byR7lCEzA3EQ/o8ypDZD0hZA6ZTeMb93kUxD0JPUKpRws25qC2P/Qrg1UIQ/Z+Yrjgf/Yq11QnqttJHtXOOWZMUTrlWJB6qAMtv1Qig9elXbGoWDIHR0uLbxlShnheOHAE4FhJpXgDJqBWD7bsJBgOOjTlGLSnyuQlmzAtmUpB3CXzD5LCqX1HLag5JYpyaqGnaqG4CM0uNyT6AAgCxx6+lW2TIxEpVQvInQ1E8kQPBC9E+9nc2JdZQqpGWfZ0LidMuRqioilqTMNOz/85svBPxetUwXoZawN86Lt+UvzJnh2kyHLjuKV3sy+acbyPvK2JlMasQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDby89GDFbE2WlCNFDnN5bITqJ0cJDi+MZpwXASlNGw=;
 b=NQ6YQVTfXtVDhmneMG3j2JS8cH21liLeDjrSSBIZynaMbfnaP/mqLNFLDl4tB+c1GCRoJT/H3eAUc8NMc4dbiIuejGHv85Hz09l0PxaIDS6gbmgdtOhjZNKPkKXfBdLA5//qdoeZoWRSIUA0POKrawd5uamIU+8UbLNm8cq9RUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 19 May
 2026 07:09:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 07:09:56 +0000
Message-ID: <8a13b1ad-f1be-4ef4-905e-0d9828ae8cb5@amd.com>
Date: Tue, 19 May 2026 09:09:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Linaro-mm-sig] Re: [PATCH RFC 2/5] dma-heap: charge dma-buf
 memory via explicit memcg
To: Barry Song <baohua@kernel.org>
Cc: "T.J. Mercier" <tjmercier@google.com>, Albert Esteve
 <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri- <devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mripard@kernel.org, echanude@redhat.com
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <8ef38815-6ae9-4359-86d4-042554357639@amd.com>
 <CABdmKX2uwZ12kYJYPJGfWxuMBOJS=64b1GRj72tfB5D=NKM22w@mail.gmail.com>
 <CADSE00Jq_uvNgvxgPze0mEdUd+hF4-DPZkHy0KroWHZzygf4WA@mail.gmail.com>
 <CABdmKX3DhejYBis9htLDnzPrG7vuF3R3URLVNEbnyd61SSsx=g@mail.gmail.com>
 <CAGsJ_4zyecY6E-=Tm4_couT7uoM9LMcFdTMUPkZAjj4zUKE-dQ@mail.gmail.com>
 <cb84c2ee-9de1-4565-b2e0-60984721228f@amd.com>
 <CAGsJ_4z121v4tK_3+j-hkD7HH0gH3w8tWD8nk0CwRhFE5T+4Og@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAGsJ_4z121v4tK_3+j-hkD7HH0gH3w8tWD8nk0CwRhFE5T+4Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b26d90-c393-4ec2-7819-08deb575a1f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	Z9i1JUP7T+NrdAaxJm32m2qm0GXls+gvyn2fH+HCuRApRWYZZiQmjf7P45wCPXf7JfBhMfuKP8M6R3+dAC0pwDAk6YGDmIPUPlzpNaJswORqhtjMY5c17JGnbxdyUWYztcJYyCnYNijqXDfqM0GYVVOMyCUJltJquNlScMDBx0s5nvbIQN0m+QuDNrjyb9I7EmtGxbUu1lS/ZZo1Trt5rQ88NVb+74cNBehZ1V19Uk+MgE5wtvXFBcQWS087BGN51MPD8pMEbJZg4Zakmwd1KsGtDjPIs/p9FGQtRs4hkqct3Ox1thkPG/c6AmdEXnkA26WNze7C3zn9HAJbWlcYMnhFvktQ4KM2GglQVbJwzFtDBl2Iib1PsDHALfUekrKoTCS7cnGZ3pFtdsKi8qxHJIY6YIJpLj6mmc+Hd/MTn3ZvoeUqo69msFe5wf5RBBTUc3kmspC5dg/dx8QLkH2Yf6LRcofiD00r+GMEXObmczSetfa9mE1qQkRAy+fHcqa2nKPbNjACVZy6sNfQK2BBrXdEFj3lgxoPapP1N4Eu76WWjrsApW7s3tS5CnM7TIwIPgphHKFXH3PRLXXy5sw4mA0KywNPhiXrfyQhkSBCcpYRn9A45h4S3+jLU0aS3fpdtO7bmbL7EEcaHcUZpwyeSMqwHVzWp78z8FMJbLZJh2MVYwL8tTiH6gSj/XJlIjC6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dks3UVNwYkVHa2pZOGp3ajFwT0pwakpUbmJXS2tQQ3hOT0ExRXNxb2NxUTFP?=
 =?utf-8?B?d0luekY2NkNRQWU1R28xbzI1VklyLzNSK0tHMVFFV2FLY0VwREZOK0ZOeHB5?=
 =?utf-8?B?dzAvNUFFbXNhTm45UUJWSTJuM3FmUVB5VG9xQ0U0R2dwMjIzbjJmQ1VSSU9V?=
 =?utf-8?B?OStrMlE2OVQzYXVueHZSemNHMVlTb3JKcUNpUXZtUmJ6R3l0RmpZVHdMTEpU?=
 =?utf-8?B?SVZBWWQzRjMyTmNDSCsxeDYwdHZPalU2S1dPczZUY1RheHRhRGhIajB2bnJk?=
 =?utf-8?B?YXRNS2dBRk1tU3R6OFZKQ0N0RWg2dU8xbkxMbnRvOUJEcFF3WXNaQVhpTWty?=
 =?utf-8?B?bDMxYUViYmE3YkdyVHZRcGJiMC9FNmxsYjZRcDBsbG9nRzdDL1UyWVhiVyt0?=
 =?utf-8?B?clFad05mdTFMNlYxamdGem9UcjdLdlp6c3V3V3U4cFhEQkJ1b2RIalQ0M3dj?=
 =?utf-8?B?cUJBNkY4bElMbVNhTEkzdnVtN1BScHF3Y2FhbEorTXR4ZEthcVJ0VTA4TVFi?=
 =?utf-8?B?c3BaQXdFOG0wSTBDU096SGY3dzZTNk9uUG16UnhMTGtkaXE3TE1FSG5hMGpV?=
 =?utf-8?B?NTRMMENEMlRHSzE0aEFESFlPdWVTNVBscURSVEZ1dU1sT0JkT04xcG5vd2RS?=
 =?utf-8?B?aktVcnJtOFQ3OWh2Rzh1dHYrOVBIaUZKSXowNCtWamI3emxINWF3dGNERERO?=
 =?utf-8?B?RDdzb0plN0h5OTM0MTRTbDdKRks4L1liREU1UDJxNEtSLzMrKzRtVmpXaW1J?=
 =?utf-8?B?WkoxV0tyU0R0cHhyYU1tbFU5dVo3enRYL0VYbTJwUHZJdkxXVHBRSGtCbDZE?=
 =?utf-8?B?OEpxbldSMkFiVnpKZ1ljNmh3UEF0MDV1VmdPaS9EcWNDY01NR2VDRkVGdWtG?=
 =?utf-8?B?bnJQZHE1NVBOMjFzZnZTYUQ4bHh3VUd4K29rT3VMZTFsVWNkQ3l3eEJ5ZWEx?=
 =?utf-8?B?cmJpMU0zbUwwd2pOUVJJTURyZzczK2FLL3M5azZhZFZ2L2lZZUhuM2M5WGMv?=
 =?utf-8?B?UUtaOVhWZlhROE52K2FIZStwREVzcVo4MzE2SWg5RlhkcXdoV3dkQjBXZjZC?=
 =?utf-8?B?empraXk0enhabjQzZFMrYkg3K2QzQXNWV2FrelFlNk53NzRpUkh2SGV2U0VI?=
 =?utf-8?B?WGcvRzl6ekQ3RmpDeTdITzNLZ0ZuLy9MTVpjM0Z6Qkg1QW5hOEl1UHg5SXRu?=
 =?utf-8?B?cnpYVERGQXNaelgrclVrNDE4WG9NY016cDRQbUdGMUpsQWhOQUFDSDcwUGJQ?=
 =?utf-8?B?dFFITVllVGZxaWx5MXZrNExMN3BudmEzUnJVcEZHazZPREJMQ2pWMjZSNllq?=
 =?utf-8?B?bmVDekkrWU9lMWgyY2ZVUDBIQlV4dHBLTit6aE1nWDNGMVcyQWJMdjV0cTFp?=
 =?utf-8?B?WjhjRjYrbmlBNUhzZ3lrYWowOFJxOTlYWDB3ekkrODE1bE5SMGg0TGZ3STVz?=
 =?utf-8?B?L3VFZW0xRkJTeEF0N2c5TEZCQjZWcVFEeU4zeFZOeUZsSTdrQlVsbzdkdFZR?=
 =?utf-8?B?Q1dHeFNmWHM5czR3Q0J0TThIV3REclk4bmdKVkkxN3Yzd1piaGE4Q0hucEEw?=
 =?utf-8?B?MzVSdy8wd0NPU2Nqb3NZclRwNkl3Nk4zNWg4M0t4UUovTDRnTndUK28zU0xt?=
 =?utf-8?B?SzkvZVVJTWdQajVJTWhQcEJhOVg5ZXhUay8vQ2NlV2g1S1hYK1FwRU4wVGhK?=
 =?utf-8?B?Z0ZnNTh5ZFBSMG1zcjRJZUJ1dzEvNFQzR0JxOW1RMnlpYmt5M25lOFhYUUw4?=
 =?utf-8?B?OVl0ZHZzTHQzdk56ZHB0Z09ZdDJPTms3MWhqNWc4VzZhaEg1NTVxeFBGck50?=
 =?utf-8?B?TkEvUVgxZmJQSnR2YlFZcXNYV2d2eTUzTlJYSTRROWFpamFmNGNOK2VHZWpB?=
 =?utf-8?B?NnFKZ08vNW1xdXJSUE9qNlQzaExBckN3ak9MTkk4TGZrRVQzaGR6R2lQQmdj?=
 =?utf-8?B?cmgzMUJJN3VKRmlQUUVhczZJSVI3N01YdGJBcStPVUE2eUpsTVF1SGpzSDJS?=
 =?utf-8?B?d1QvVTM3d2RkMFlSTC9ocjRvaDRlSnh6NXZERU9wdUpsQmV2UURPTldiV3NY?=
 =?utf-8?B?ckpwUGtUMHVnUU1aVVk0cFNpU29OZEVCTVpPcmpnaURiRWVWNXNvMHFVRkpK?=
 =?utf-8?B?Q3J4cXp2am5hVnVjVkFiVUZsNWNRaFJHWStQdkt4RFFqcHh6ZS83Njd5M3FF?=
 =?utf-8?B?blo2ZUptUDN5bFRVcWtGM3QxNDJtSjZBd2dtbnd6QVIyUUR3UEt0KzJ6dzl2?=
 =?utf-8?B?N3hRd3lPajNhelc0UVduN3FuckZuYlo5WG5kdHBJK1o5YjJDN0FSUTEvalE0?=
 =?utf-8?Q?+aHqYm9l2vxAg0i2cl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b26d90-c393-4ec2-7819-08deb575a1f8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 07:09:56.7940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88mu8R2ynre5LClCmoXXIPU27rEcIQmhD4NxaLne/k50dawo2qKFfZnyN2BgAJq6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16064-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.freedesktop.org,lists.linaro.org,kvack.org];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9F6D1578CD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 01:00, Barry Song wrote:
> On Mon, May 18, 2026 at 3:34 PM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 5/16/26 11:19, Barry Song wrote:
>>> On Thu, May 14, 2026 at 12:35 AM T.J. Mercier <tjmercier@google.com> wrote:
>>> [...]
>>>>>> I have a question about this part. Albert I guess you are interested
>>>>>> only in accounting dmabuf-heap allocations, or do you expect to add
>>>>>> __GFP_ACCOUNT or mem_cgroup_charge_dmabuf calls to other
>>>>>> non-dmabuf-heap exporters?
>>>>>
>>>>> We're scoping this to dma-buf heaps for now. CMA heaps and the dmem
>>>>> controller are on the radar for follow-up/parallel work (there will be
>>>>> dragons and will surely need discussion). For DRM and V4L2 the
>>>>> long-term intent is migration to heaps, which would make direct
>>>>> accounting on those paths unnecessary.
>>>>
>>>> Ah I see. GEM buffers exported to dmabufs are what I had in mind. I
>>>> guess this would only leave the odd non-DRM driver with the need to
>>>> add their own accounting calls, which I don't expect would be a big
>>>> problem.
>>>>
>>>
>>> sounds like we still have a long way to go to correctly account for
>>> various v4l2, drm, GEM, CMA, etc. In patch 1, the charging is done in
>>> dma_buf_export(), so I guess it covers all dma-buf types except
>>> dma_heap, but the problem is that it has no remote charging support at
>>> all?
>>
>> No, just the other way around
>>
>> DMA-buf heaps can be handled here because we know that it is pure system memory and nothing special so memcg always applies.
>>
>> dma_buf_export() on the other hand handles tons of different use cases, ranging from buffer accounted to dmem, over special resources which aren't even memory all the way to buffers which can migrate from dmem to memcg and back during their lifetime.
>>
> 
> Hi Christian,
> 
> Thanks very much for your explanation. So basically it seems that
> dma_buf_export() is not the proper place to charge, since it may end up
> mixing in non-system-memory accounting?

Yes, exactly that.

> My question is also about the global view for both heap and non-heap cases.
> After reading the discussion, I’ve tried to summarize it—please let me know
> if my understanding is correct.
> 
> for dma_heap, we have the ioctl DMA_HEAP_IOCTL_ALLOC, where users can pass a
> remote pidfd or similar information to indicate where the dma-buf should be
> charged, as in Albert's patchset.

Well that's the current proposal, but I think we need to come up with something more general.

> For non-dma_heap dma-bufs, we don’t have an obvious userspace entry point that
> triggers the allocation. So we likely need other approaches. We could either
> move more drivers over to dma-heap, or introduce something like
> DMA_BUF_IOCTL_XFER_CHARGE, as you are discussing, to let userspace explicitly
> declare a charge.

Yeah but that's not only for DMA-buf, we need that for file descriptors returned by memfd_create() as well.

Regards,
Christian.

> Best Regards
> Barry


