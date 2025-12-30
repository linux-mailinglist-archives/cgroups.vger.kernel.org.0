Return-Path: <cgroups+bounces-12831-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E84D3CEAAE4
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 22:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B619300699F
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 21:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E825829DB99;
	Tue, 30 Dec 2025 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EUXw8xfE"
X-Original-To: cgroups@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C99F20C488;
	Tue, 30 Dec 2025 21:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767129203; cv=fail; b=Hgxrhfyxob4HDx5Y7d+IlScFm6URw8G3SyU51JBf+YqOcqMjUDkCGSzbZuy4VQMFL4xkbG/V3AwX2Uig67m02uD6GkJ8848dCnTUcUul+PyUaR92zIRWKpHlpKW90sWWEa4oYghQ28lZ3pYzyeuwrbELO/67LG18Spnp1vFR0yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767129203; c=relaxed/simple;
	bh=OCmk8Ag1RietpnBGFBu7zapzGfH7Tk1rDdIxjUPo4V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TS4Ygo7oDzdHHehIu01CKs0DHNtkv8i0/KPTyioIIpKVlbZZB0GvryuVBYW3nmhJhR/eNy6DaMPsgG/JHnvmF+VlXr4TspqxYnaXmmJQ+mcPbp9VIHVxQdUvlyd0xEmpOp1uOlSsHs+OxzxETfqzhDGYA1GF6D/sB+fpYwIxi4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EUXw8xfE; arc=fail smtp.client-ip=52.101.46.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3zPdYW9fKi18+EioUFo2JUTUkFfOPVHxHrDhHn3UKwOMVnzUvHANOzMIXcomDG6w4vX9GvEH1pG6UAtSxgz2582MweRUr6c1QWaTn5yTLg+QXIn3cXFWpgJ7q6DYmCyYmdnwGoP/MY4uXjE+g33FSIyCJ5yTTd9e+2P99aRwBrMhyq80PX9fltBg8G3VbIXadUbj2zJKq35FzCeq/gx2S9GcP5r1RcK+NDH5syhBGUTEuJtVQyyl+eNx7sPu+j+8igmf7i2pS1m6k7dfv7bMJmz3LwnsSljZEAS7xIQMiKvIOLuR0n3cSitwiFonfIa571D5F8dtQjyp2GNtF1Gzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PcILKFRq/rOfIBUEky3a+xKmU8zZxmEkzp6gC9QtSw=;
 b=Jjnm2ObbKjzyt+AO6ufvVCR8Kj896uQ14600efc1IRMgGs9dN9lu7Uv4RFAoP8yKAEstYa0QIAmgLgL7N9nfDgV3dZDs/yogWWelKMOHAM56y71CELFt/G0RRsY1eYJJCUC+qpUKTVVnhOfVQ1weU1KtmhbrhrrG2pJVngMB6eiE1oWwHvDj0OhqIVt0MCfU+rY+cl53bISRfV0TUYO+MR3qDdOIAuEzstgX9T8vuB+CG66JNNCG6mEPCAw4wNkuEKPt8NiqiL+BJHJRqwoPY/em0YuXC7bDXGtjO7YH/NdaW4GOKXihGuTm8ioM2yIyQDMjTFYcHIAtCYx+aWrcVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PcILKFRq/rOfIBUEky3a+xKmU8zZxmEkzp6gC9QtSw=;
 b=EUXw8xfELuZay9VzGCr2NIrP3LdaNvcmlNDwxxfPqiZAnOskF2GSt+X8qBgBEntGop5RzwtMWTsyvTjx+i9tL17zQfBWUOONopaW5HR2GqzbDyQWiHbSY+HWa4749H0uRbgEzhXIvKzvBjvsfnAI6IwcFHL6EGv04DZj6cD+Y0Uco15ltGHvUOtqJyeKe1ludC3xNWSP1OOkz6SDpfUFptGOK56KWZLJC+luldCkWxJhIZ7Hx78c8KJcrAYCwHxqR3+ZzXe9FgrFwls1DLvICQ+QYcLNqu3qKK4asn+CjFizbjtwiy76eMiFBmnmpBKd7EF7H65WZUH7mHJ1RUlNDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB9494.namprd12.prod.outlook.com (2603:10b6:610:27f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Tue, 30 Dec 2025 21:13:19 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9478.004; Tue, 30 Dec 2025
 21:13:19 +0000
From: Zi Yan <ziy@nvidia.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
 hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Date: Tue, 30 Dec 2025 16:13:16 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <4D71B0D1-B7A5-4C29-BBA2-2E055E19A4C9@nvidia.com>
In-Reply-To: <7ia44ip7227h.fsf@castle.c.googlers.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <7ia4ldikrbsj.fsf@castle.c.googlers.com>
 <1fe35038-abe1-4103-b5de-81e2b422bd21@linux.dev> <87tsx861o5.fsf@linux.dev>
 <c3ee4091-b50c-449e-bc93-9b7893094082@linux.dev>
 <krpcb6uc5yu75eje7ypq46oamkobmd5maqfbn266vbroyltika@td6kecoz4lzu>
 <03C3C4D4-DC37-4A2F-AFFA-AACC32BAEBEF@nvidia.com>
 <7ia44ip7227h.fsf@castle.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR1501CA0018.namprd15.prod.outlook.com
 (2603:10b6:207:17::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6e9ca7-14e6-4ec2-26db-08de47e841d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHdrWlZBSlcwUzg3MFRRNFl2QXpHMENXb1c2SVZKV2pKRXR6N0xkVU8wYzV0?=
 =?utf-8?B?YVNnWU8rL3FwZFY2M0xnazdhYjc2MWJrY2F3V0NQcitkZ1dUbm1zVG1Nc2g2?=
 =?utf-8?B?NUJSRkFnR1ErRXI0K25QQzZqUW1ydExRVEdGQ3ZTdlFlK1JsM0xuQ2hwbFVB?=
 =?utf-8?B?aVNTK1NldjFsRHlKOVRIRHRkeldqbjVMQTFNOWkwMFFqaXRVMWo4dzMwSUhk?=
 =?utf-8?B?Q1ZDTFlFZXdXS0Z0dFJNbVI4aXdqVytCcFdOQjV1bjdJRktnRlJIcDBDUDZp?=
 =?utf-8?B?eEJYK0xOb3dQYUs0MWZKcENLd09CV1NpQmVzMEpOSzZFY2hPcFF0dk9FT0dK?=
 =?utf-8?B?bXZndWZjNGFiTlg4VW8vbmtQNENBU2M3REUrbysra1hBYXNKVjM0aEp5WXd6?=
 =?utf-8?B?ZEhwbGh3TEdKWmJBbGxLRlhoYllsbzNWaXg1Vm9NRXE4S3dOQzM4WWpOem0y?=
 =?utf-8?B?TXdWSE5SS1YxdEZMR1lrdnU2TUJqbW9NZStWNkV5RHRQREhYOXJ6VkwrbG5u?=
 =?utf-8?B?OEhzNjNERGIwcUtPOFhPVVVIRFYrZGdSWjBvOUluOWdDUDdXWG9QV29VbEwv?=
 =?utf-8?B?d00zNWppVklhS0x2cjVWeDhoUXVvL3ZHWGszZ3hSMVZhNS91RFEzUnovRXlh?=
 =?utf-8?B?ZFpENnRCWDhYVEdHR0VmcnlUMExzY0xHTWdtY0NhTnZJSzlqL01UY0VlRWpN?=
 =?utf-8?B?NWxZK2pNVGptd2lvNmN5S2RhTjRIR0dBZTZsRVJGMStZRVJ0eitobFJ1NmNu?=
 =?utf-8?B?TUNZZXc1UUJ0OUsrWlZTSnZyeDlCRDJScUhtTnc5RXJOWnIxU3JncEhzYU91?=
 =?utf-8?B?aFllY2UrcXJraU9iZlF0MkpwVWdXL2NMMW5vOFlNMGpDS3d0TEswb2xkWVhO?=
 =?utf-8?B?RXZKQ3J5U0hDNW8wbnl0MUNDeWtBUVIreGk0K3BVQW1yYk9WemhSakJHb2sz?=
 =?utf-8?B?bldlWlZtUjNtenJTemppd01LSlowQ0hvYlcrOUlacFBNUGpGbWZkVENhWjdZ?=
 =?utf-8?B?OFBRcm5wcmJadm8zZHZDUHhIYmNnWXh5R0J5bjlKZ2tUNmI5cGEyOFRncTc3?=
 =?utf-8?B?N2kzTWtGYXY3MGllY1Q0R3I2cjZMODNXSGJMSm9GRUF0QUhCQm9TS25NTWxQ?=
 =?utf-8?B?UTdaYzNQbU5vRHJOSjdBb09QR0czcjlCTTMwY3BuempUd0ZtRGc0SURHMmlE?=
 =?utf-8?B?a1YvQVJhMlJJZENLdEdHQkdkRkR3cU0zb2R2SlhEZ0x2Y1RERENMcGRzSXBK?=
 =?utf-8?B?Q0ZIUGRmMkFWa3BGNThsdWMvYzdHOTNXSE5uRmFHK1dXR1B0dmdQaHljRTl0?=
 =?utf-8?B?Y1l3aTdpVjI5TEk3aURIMFBKcmhVdzdzNFZ4NTl0bWdnc0s3ZWc0d0lrczlG?=
 =?utf-8?B?WXd4WGlpdmpZNUhTbkp0RnFPdnFlVW1YMXNPbWpoL1RZYzFZNFd4NW5SRXhS?=
 =?utf-8?B?NVVlWlVObUJDWU1wYk5FNHpVbm9ZQlhyV2ROSnhzaStqS0FnTVE3L3ppMXNx?=
 =?utf-8?B?QURNeFh6cFZWVGZkNVM1Z3JXN2NBUFFLTkU3TXVJeUhOQ0RsNHhaZTRJOWpF?=
 =?utf-8?B?R1lXS1hwSzZyRUsvdmJ0MjJTaVRBa3FGNy9INitDTlhqTEpaSkZXbk1yaWR4?=
 =?utf-8?B?NUo5RnRiMm5ERmNEUHNuV3VFR0F2aXhPTmZLZStmK1ZWaFIyYVN0WVRYdE5s?=
 =?utf-8?B?b0JuemhNZ3dHbXhWdzBmZ2l1d2lITHVma1FmTG4wWSttOVFqdlFwVEozaUo3?=
 =?utf-8?B?dkx2bEd3SHgxN2grWTV6VlpjcXBNWSs2S3BIMzc1RFVhVFhDeVN2ckxiTkFw?=
 =?utf-8?B?UDkvemxNenFlbHpoeUQzcEptOCtWTXpGL1RCS0I2VHMrTXJEZ3NZdEpJWE14?=
 =?utf-8?B?aUd5ejlUckdBMk01dTRrWFdiUjlxSVJWZU5Wa2tBb2pWeS9qRzJ3T0M1RUN1?=
 =?utf-8?B?aTRpK0QvTC9SWkxndkpkT0RqY1BhWDJrYkZGcXpETjVNWmJWSEVVa1hKR3kw?=
 =?utf-8?B?REVuSTN0TUNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnpXWGRLT1Jhc3FjL2MvK3JYMDcxSG5RV3BVckFhOHlxYXRkYTVaTkpCVm0z?=
 =?utf-8?B?V1lDOTBxQmN0bWJSNXV1OFU3Ylk4cUdxSjd4aU9OTjhBYWZBekVWUFU3WDRx?=
 =?utf-8?B?NTVJekR3NEpZcWkvVW9Ua1lNSTNXa0oxY3dWU2xvRTRJQXJrRHp5NUU2VDZz?=
 =?utf-8?B?QkZzUllzSExMS0FrY2V1bWk4MjNLbUtpWUZLSHZGN1VITFRxMjk2ZU96Z25E?=
 =?utf-8?B?M2twZVY4bmZJc0liTlFsa2dVNzJmbU9RUnQ4WU5WVUVsUEVxb3VQTERxclM0?=
 =?utf-8?B?dnNOa1hQWDl6MlI0Z0ZGTUxJQVFlZWtVRFhhTzN3UjVzMmh6eXRDOHhiNytH?=
 =?utf-8?B?d253MWZ2ZlE2NThsL0NiaTg0S0xlb05nbldwMHpxaWJTSDFTOWpsMlBXWjY5?=
 =?utf-8?B?ZmkxTmJ3TlozSXRQUE8vemV4a1NNN1kwRG9zQjBYZ2ltTVAvdTVGbTkwbjJo?=
 =?utf-8?B?ODA1aXdGbmlseWVvUGo2ODY1ZXBsM05TZzgrNFBhQ01mSW1iazhVbnF5RkRJ?=
 =?utf-8?B?eEQ4VGRBRWU3YVR0alBYU2t3cUZIZzgzY2R1bzNzV09LYkJoMmsxSEdGaGgy?=
 =?utf-8?B?bjNObTFqK202VTh6N1NFTlJtbGJTblJQRTlvbnBzZ2U2V1NtQjkvYmJwdlBV?=
 =?utf-8?B?R0NKNlE2bmFaZXNWcVNGd2hyaVJ4Z1JFQndvSFRkdEVra1E3V0Z4WVU1eE9z?=
 =?utf-8?B?WDF6TUR6Zks2c2FmWEZYY055OW1FclZzQ1QrcGZHK3lJZHkwMTVoTXkxU3pQ?=
 =?utf-8?B?MC9jeFNZYWFMQlRQWGhTYXN4d2kwTm9ZVGxadTl2K1hkWk54RXk2QjdMVnpq?=
 =?utf-8?B?YW5Yc3E3aTl3b1JJdFhWb2x1VTIweW50VjJRaTliejRPdHhIWGRkdlZONTZz?=
 =?utf-8?B?M0pyM2dMMFo0OGxjeEEzQ2x1a2xYL3RpYnlVYlZpK2ljamxmS0FWYms0a0kr?=
 =?utf-8?B?U3lsMmdGblJyaks5dGFvTFVRU0tNNGhZdnpuOWxrbmE5ZTkvTzYvSmpCc3p5?=
 =?utf-8?B?M0ZGZE5UTG9GN1RReDJ0WGp0eDFwZUpWTUs2K3EwdklXUld4N2hvNStEQ1dS?=
 =?utf-8?B?ZDlGUHhSV1dwNzBaWTZzVCsrcXRtUkpCUWlGT2Yva0VKYm1HKzFyTkxPd2J5?=
 =?utf-8?B?a0JTUFBDV1FjSzRlcE9NWlhrcEpxTE9LK0ROcUJWQUJEUFhjNi8zZTh5Q0hC?=
 =?utf-8?B?MFVmSXBJRE9adkE4ZmNLLy8rTFNpcnRBeUZNbUdXOExqVTJ0RkRnRk1nNXky?=
 =?utf-8?B?Y1hjcDJyNTExaXdNRkFoV1FVL2szcVBiMUs2RkVyWTY1d2xsQ1EvbVU4K3JQ?=
 =?utf-8?B?TXlrMjZiU2NLckZGMU5ZN042RjdaRzQzSjdyYk40eWhEV1RyKyt5ZkVVRk4r?=
 =?utf-8?B?b0tndGVwVGhSNFNJVlRPZitoc3MrMlBaY09CZ2JDSzNNZ2JGekJueDVtL3FP?=
 =?utf-8?B?bFpwZVZFTnlLN0hoUGp3VDNjejhSZ2RnUklwSElqeGV4UkFaNEJuL0w3c2JE?=
 =?utf-8?B?SXFuK2dsdi96M0hVaXFiYnVSMElkVlpVb3BnYytxakZGdUk4SkNLaSt4Undn?=
 =?utf-8?B?WEREYUhGSnZ6TnRVbitGdC9kYVpCTDBVS3RIWTN6NDNtNnEvemJuOEtDSWQ2?=
 =?utf-8?B?b2s2eHpQUys1TXEzUERPUXpiM2dPVWNCN2J2Y3BNSWlVWnhJRXJmbWR2VFZw?=
 =?utf-8?B?bXRDeW5IcTRSSS8vR3VTQlVsSVExZ1ViZE5BdXFlTUV0K3NwRzJsdG5uSERS?=
 =?utf-8?B?THVGQnFnSXFKcitQc3cvS0V5Z1ZZR25hNTFyazNTVDd4alRJZVZ1ckpXOUlQ?=
 =?utf-8?B?RkpYUkMya3F3UXBXS21NUDFKMnBzTjFtU3hhcklYSXhUZzFjY01maWloMTVW?=
 =?utf-8?B?enFibS9SUXN3S0MvbkV4WEN4UEJ3THpHaHp5dGh0dElCWk5Md3B2bzZBODFr?=
 =?utf-8?B?WDR0YWVNRm45T2VhTzROZWdoNzNleUFCSnM4YUVLeGZ6V01zMWliaDcvbldn?=
 =?utf-8?B?dnczSzc2YW5YZXJaTzZwRUZiMEtJZHo3ZDFXNzJodDVlMlRjcWoyOWZIUG8y?=
 =?utf-8?B?TmRKdWhUanhYSmZycUJmc3pqS0RHaTFTVGtJckg0MThLVXZKMFBNdlJyZmJH?=
 =?utf-8?B?c1NlZllSMjlHSjJITFdNaVFJZ0QwcEZjU3A2eTd5blF4d3FDSWVlYzJYK1RR?=
 =?utf-8?B?WG8za09EbjlCN0hid1dXS3BrMjBZTTVwRmEwc1lGa0VxUTJkUlZKRFpjRkQw?=
 =?utf-8?B?MkpZVUVpUXcrN1F4aVlGS29BRzJNVXhNZXRpaXZPcHNlQUNlSzBsL1hDN3Js?=
 =?utf-8?Q?b6GBSIkB7VgK0d3iUG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6e9ca7-14e6-4ec2-26db-08de47e841d0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 21:13:19.6144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ujrtgz8/MtYbQaclCu/lOVDSgzuQi7Uk8NldgrfPy4WwnMmCUbyaaP0PpEIdPNRT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9494

On 30 Dec 2025, at 14:34, Roman Gushchin wrote:

> Zi Yan <ziy@nvidia.com> writes:
>
>> On 29 Dec 2025, at 23:48, Shakeel Butt wrote:
>>
>>> On Tue, Dec 30, 2025 at 12:25:31PM +0800, Qi Zheng wrote:
>>>>
>>>>
>>> [...]
>>>>>>
>>>>>> Thank you for running the AI review for this patchset, but please do=
 not
>>>>>> directly send the raw data from the AI review to the community, as t=
his
>>>>>> is no different from automated review by a robot.
>>>>>
>>>>> Hi Qi,
>>>>>
>>>>> I don't know why you're so negative towards it. It's been great at
>>>>
>>>> No, I don't object to having a dedicated robot to do this.
>>>>
>>>>> finding pretty tricky bugs often missed by human reviewers. In no way
>>>>> it's a replacement for human reviews, but if a robot can find real
>>>>> issues and make the kernel more reliable and safe, I'm in.
>>>>
>>>> I just think you should do a preliminary review of the AI =E2=80=8B=E2=
=80=8Breview results
>>>> instead of sending them out directly. Otherwise, if everyone does this=
,
>>>> the community will be full of bots.
>>>>
>>>> No?
>
> The problem is that it works only when AI is obviously wrong,
> which is not a large percentage of cases with latest models.
> In my practice with Gemini 3 and Chris Mason's prompts, it almost
> never dead wrong: it's either a real issue or some gray zone.
> And you really often need a deep expertise and a significant amount
> of time to decide if it's real or not, so it's not like you can
> assign a single person who can review all ai reviews.
>
>>>>
>>>
>>> We don't want too many bots but we definitely want at least one AI
>>> review bot. Now we have precedence of BPF and networking subsystem and
>>> the results I have seen are really good. I think the MM community needs
>>> to come together and decide on the formalities of AI review process and
>>> I see Roman is doing some early experimentation and result looks great.
>>
>> Do you mind explaining why the result looks great? Does it mean you agre=
e
>> the regressions pointed out by the AI review?
>>
>> If we want to do AI reviews, the process should be improved instead of
>> just pasting the output from AI. In the initial stage, I think some huma=
n
>> intervention is needed, at least adding some comment on AI reviews would
>> be helpful. Otherwise, it looks like you agree completely with AI review=
s.
>> In addition, =E2=80=9C50% of the reported issues are real=E2=80=9D, is t=
he AI tossing
>> a coin when reporting issues?
>
> I said at least 50% in my experience. If there is a 50% chance that
> someone is pointing at a real issue in my code, I'd rather look into it
> and fix or explain why it's not an issue. Btw, this is exactly how I
> learned about this stuff - sent some bpf patches (bpf oom) and got
> excited about a number of real issues discovered by ai review.
>
> I agree though that we should not pollute email threads with a number of
> AI-generated reports with a similar context.
>
>> When I am looking into the prompt part, I have the following questions:
>>
>> 1. What is =E2=80=9CPrompts SHA: 192922ae6bf4 ("bpf.md: adjust the docum=
entation
>> about bpf kfunc parameter validation=E2=80=9D)=E2=80=9D? I got the actua=
l prompts
>> from irc: https://github.com/masoncl/review-prompts/tree/main, but it
>> should be provided along with the review for others to reproduce.
>
> It's a significant amount of text, way too much to directly include into
> emails. SHA from the prompts git should be enough, no?

I mean at least the GitHub link should be provided, otherwise, how can peop=
le
know the exact prompts?

>
>> 2. Looking at the mm prompt: https://github.com/masoncl/review-prompts/b=
lob/main/mm.md, are you sure the patterns are all right?
>> 	a. Page/Folio States, Large folios require per-page state tracking for
>> 		Reference counts. I thought we want to get rid of per page refcount.
>>     b. Migration Invariants, NUMA balancing expects valid PTE combinatio=
ns.
>> 		PROTNONE PTEs are hardware invalid to trigger fault.
>> 	c. TLB flushes required after PTE modifications. How about spurious fau=
lt
>> 		handling?
>>
>> 3. For a cgroup patchset, I was expecting some cgroup specific prompt ru=
les,
>> 	but could not find any. What am I missing?
>
> MM and cgroups-specific prompts are definitely in a very early stage.
> But to develop/improve them we need data.

Not just data. You are a maintainer of cgroup, so at least you could add
more cgroup specific rules to improve the quality of AI reviews.


Best Regards,
Yan, Zi

