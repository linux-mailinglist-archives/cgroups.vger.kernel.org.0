Return-Path: <cgroups+bounces-15845-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDjEHln+AmrJzQEAu9opvQ
	(envelope-from <cgroups+bounces-15845-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 12:18:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3825C51E69C
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 12:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FD3A306126F
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 10:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9EA4C77B1;
	Tue, 12 May 2026 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w4dVIAOW"
X-Original-To: cgroups@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A99745BD67;
	Tue, 12 May 2026 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580866; cv=fail; b=hNy84JFPHrFycw1EpS7un/JyOqxl0EJnIj3bx9QggJAMFZTm+Ge19clD2xhglrqnQT2xI/uiF0RsWA4zQQ6aT7iCSVpLr3NlgyBT78B8Qd3HcVz1blJE2k//dUvEFVPaDZOEYRffvcOvqjkGyWu4+I6UwR7lSIAAZjglZVewbWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580866; c=relaxed/simple;
	bh=OxkBPdSxl1gpiL7OaivlN7aJiIWCwfQF6M2hv40PDnY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fU+i3hrDn0NqdB7gJTQZBfPhCxb/9QTN4jLFqIZann9YprmWUXcdqLcxwjFyYIAPeEm4TyGpQp1h9GNIrAO5RnqTf4uGGC/tmstQwLYaom97iu48BRcs3d+Qa+JqWiwV7Dpbtc/0yDA65Aom5ir0utj0BkD4NdaKuLWMqwGXofI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w4dVIAOW; arc=fail smtp.client-ip=40.93.194.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHw4F+ivP5mat5tzp742DZdLBxfJfQ06+TjnJp97ogpG28gNVCN5lSg06t4htXJsP+4B76mZvqVTtEnzR4eozPmXVMaJR++v7k4jdmv7Wx5gfdeUZ39+juRpm1hRRfhcPaaORwID3fZyPdKyjg7shPyeEC7laBowG2kqZBA2ILH+j3zS0rjEceil/fHHH0WbxoVU4qDZDG4//KzNvL14if1GtE7WT11Y3AgKv1Au6MsHGy1hYFrzBZ6IHpOKOdrgJS9cv83N/F2hHuIXzu+3PX6mJcRV3kZlG7FgVnwAAuuneAw8AlykMA2BYWF/Zstv0ultAVVhWQWVyWKQY6TpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1AgsBUgIqDDCdQ6Jb108iHmPFSl/YnqkUZ3BRoINE0=;
 b=SzoOTIxnuJvpWBiORSFHqufndoZu78AuConxEE5rXeZB2xdrOnkdGxSgiR5Z1MfAtskABbZ7lnIp6jlGk+HTyq6jfSEKS4t3WQrB6yvNCzGivqr0Byyf8utb+ABghJTdHRFx3OGm2yjcAhXkLvfsJEHe989x8fJgqh5WNkIZKwCIOqpjl8Qmk84icp1ttH3DbkXO4BY4eT9ENv/jNO2o2yXAfVEFKaAzVE3e7SZciSIppVytfg5LvFhiuMFgyn6VWGGWtPgcG/AUtXSrf5Fj22BNPMty1MXXCMowjFgSllVYJjYQ/doBG/e03JvFP98Exp3e66bJ+kk/5DPDvc6vAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1AgsBUgIqDDCdQ6Jb108iHmPFSl/YnqkUZ3BRoINE0=;
 b=w4dVIAOWI2brdKqw0/jd6TsqNgNQYdC268HPavC2yLj1nwFnVV/aKZYc2AXO9z0CL4woe4zjIJp8qO75GabisnyNbTeKD286HPZQwmSPo8ZtIRgx69HGWBHdHDLL2xAv0vrmyn+jsfu9ycpqbQf4fDYMLIl4zV+dDw6lPFbNrlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 10:14:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 10:14:18 +0000
Message-ID: <8ef38815-6ae9-4359-86d4-042554357639@amd.com>
Date: Tue, 12 May 2026 12:14:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit
 memcg
To: Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>, Christian Brauner
 <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mripard@kernel.org, echanude@redhat.com
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB8113:EE_
X-MS-Office365-Filtering-Correlation-Id: fae49e82-4694-4282-b6d0-08deb00f3a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	djDjlrJAyT/YhkM+s8clRrIxzShJykyziyhetMutct7qtZRXrzwLsoq2OfyguD0tHYpFdrt2XeNFFtnro5h42IuSB3SLWY92zbr1tJ5E4n5g68M1NChYWCEF973uh7ZDS+/V/mRvgeuHcKjVK0c3GCXkXOiRSb68THBzV2b/775jTV/it5BZjuOclrZbPXqZMh2bOpjpG+S29Ste/vZJlxyZ+fE8l8OdvQ7W3X8EPhIbYxU48xq9EKbCD0YI/6eCvBWOLJQcgRnCwAlxCxM5f9HJ4Q2duDyoMwner3nsdGC9HHNcdQlrN/ACgDW5HrGNgauGbNPM/QycjZH2s3sEOYz22d/YAXtyCk0D8XpuUixc1esXh3Y+lVZC0L4oUK5xi4NGIBoEu96szkPDfRgg2IyK0yHdGR93u9eXr5ILtV2sPMQhNrVc2+OXy+NVIidGU+60Lr2DCTmpMMYhJTDgCz7tvgNLa4KA5qPt7jqPH6498agzYBfgdtghr8IOG/blTw68I4fcEBmSnwvw8YE999vCZxNv830sue1W69AJG390ovsEYjp1I7dFwALfoy3RxLH/ZSVZjPP04qJo0vOvd4J4bPBGpCD29MjEHXBsaTDBqGBL5LsZC5nk9ben9sG8/lEnfw/EX9uQ0biIcqMeOAgHtreVUsqm8GeC2YrdoB5gxebaRWD71+fLvFz97ovzL/mHjQZCJ6FoWmBIb418M7E+UJaGs3jlY9m+6IG/btw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VktOb1h6UmFVM1JEM0tMZ1Y5ZVVRNUx5TktKd1c2aGowTk93NWJxLzF2REhR?=
 =?utf-8?B?SmEwcmVzS0VRdVBMYkNCMjF6aU5RRXBzVGlqcnhjR05rTHFlRElnT0V2amxO?=
 =?utf-8?B?Tzl0ZUNLUmk2T2Z5ak15TFhINSs0Z0I4Q0dwcjJTK09SSXZOMDJMUUkrUThW?=
 =?utf-8?B?alBMdjBFRUhWUjhCMXRUWEMwQnBDRTF1alk0Q05sM2YxU1lodzhVQlI1VEIr?=
 =?utf-8?B?MFdqU21ZbEhjbEZHM1puWEpLdXpML3ZZbktUOFA1a0Q5cFl3aFRyaEdsbVZY?=
 =?utf-8?B?RmxsV1dEN0ErZjZBOHZOZFBLSnZxckFhakFxVEJwNkZZa3U3MjVGdkkyYXVF?=
 =?utf-8?B?MXVtWjRrVHBTblc0dXd6Y282SDRWaFpxK2h0a1EreHdKbllhTXA3Ly9sSU1r?=
 =?utf-8?B?ZDNVcnQ2ZnZ3aVNJMWNUMHNGTm5FdWx2U2N1SWZqK0VUdFEwMVFnWW45YUc3?=
 =?utf-8?B?UFZvQUxyY2l2allvUCs2UThHekZvZUFGNFhxS1M5bmV0OW9yZUpzYnNVcUFl?=
 =?utf-8?B?ekloM1YwRU5ieWltU05ocDhxellkL05pK05GSjlQVUc3S2dOc3FJNEEwK0Jm?=
 =?utf-8?B?aGFhNzRKSFdnVUo1NENPb21WNnB6ODhEcDRHL24vWGl5R0U3dUZtZGd1ZUM4?=
 =?utf-8?B?cDR6QXhLV3lIb1lrc2NDQVFVZUVLYVM0b2NkZ2tZUXM1Nkp3WWdOdjdrcWo0?=
 =?utf-8?B?aTFmV2RtMlVTenZPbCtYemZGT0N0Y3N6Nk0rQ1d5WUw4bHpSSFVKKytLcllO?=
 =?utf-8?B?bmZaQlVSYVVHQ3Y5Z1phaGxFYmpSRVlQRjhmb0VJaW5sN1pINWhiajFLQ2Ry?=
 =?utf-8?B?SHNBS1lhZHFPRlF3aHVwUXkxOW9oeDdkUGJsZHNlcDhuK3RiMmg2d2hUNE5z?=
 =?utf-8?B?QXNpNXVCWE82cnUyYUtua1FrbVZWOHd6UGJQOWlvM1JrWmRSODlyemlKMGhh?=
 =?utf-8?B?dkRHTFFXNU9CWmdPNkhLRTBzWnBQcWRCUUpXRkhlakdqSDRLMzdTd0xIN1Jy?=
 =?utf-8?B?UHkycmdoU241dXBibEJmVUVGVXIzbHFsU2NZNWNmSU5xK0NiVVVnVFhBcmxw?=
 =?utf-8?B?T0VCd1MrWW1LRWJlbkwyN0hpWWFhbkdjSmw5ZnVEcGIxbFZXcGY2UWt6RTI2?=
 =?utf-8?B?UjVJVzJmMlk3TnYycnVBOEoyUWJSdXprdzVubVl1QkJUdkVOd0FJa2N5NW5o?=
 =?utf-8?B?M1h2ZktPd29ENDBEUnlJOUpGT1FyRkI0bWRWZUlUNDRIUVFHMVdabUhlM3Bp?=
 =?utf-8?B?WmRjanJSb2J4QWhidHJFOE5XTU8yL0ErUkdqWDJMS09IUVdlWldaMVp2N3Zp?=
 =?utf-8?B?djE2L2dHS3ZrdUU0eTRCSmM4MDdFOG93V0Y2TEo5ZkQrUFA3NmlCd1htNW1m?=
 =?utf-8?B?SHBPbjR1SFlka08wcWw2YnBwZi92VEcrVDBpdnoyOEROdjlqOTY0cGlyY2Fh?=
 =?utf-8?B?akV3UnMwdVRmL1laVytHVExOcUdyTStGcVRSWnA3WVZiM0VpeEVTUWFzeEVt?=
 =?utf-8?B?M1R4dnMxaFpXWEJuZ1lQVDB3cy9WeW9iUkFnK0hKVVFzMkplL2hWcndMVVBs?=
 =?utf-8?B?Z2NqUnhJQnpwZG8zaFJRWlZwYS9rM0dvNVRKNS9OTE5oN1Fua01ia1FmTkdM?=
 =?utf-8?B?S3NlOFlkZVlVTk0rcHozanlGZDQzbFJWQWdRMENHVmhmRXowUUxJNWhhQ2or?=
 =?utf-8?B?Vk8wQXlEUHRqcklMUTRDUDNvSjRnamRnc2tPdEdsVzVyUkhKL1NTTVd5VnFG?=
 =?utf-8?B?YS9CcHplOGVwdjk2dkMrNTdtdlViU1RYckJFTEk0ZG9pMHdlMDBsbjRvVUhp?=
 =?utf-8?B?RStnUSs1ci8rZW9EZjQxZmc3dzFXUHd6NDdjOThCZk1oWHBxeGVuaUFNYnV5?=
 =?utf-8?B?VjdoQVFNZE9lTnpIR21yS0lhQXJCeVNPYlFWaUMzREVFS0JtampVa0kvT2Zh?=
 =?utf-8?B?Nm43SmlhL3dNTnN2N256YStpOW9PUVVINjJycDBMZ2pCM2dZWjZCSGZrV3Zu?=
 =?utf-8?B?eFdRMFdsUmMyL3lDeVA3WFEwcHAwcG5LRVZla3prcTl2NG5FYkZkb1B0Zzhn?=
 =?utf-8?B?WTVHb2FTNWlEbVI4U2R1OVJTMmllMHVablFsUDM0Vkk1RVlzU2JFK0N1a1NW?=
 =?utf-8?B?bDNmQ3gyT3FLL2lEbHNLOExtUi96cENRZEppUTkxVnNzbDBUaW1MWHJERDJT?=
 =?utf-8?B?YXQvL2RMdWZUbmpMWnlpWFd3aWRJSHUxVmMzc2J1VGVXYWlOcXVaL2dVZDJl?=
 =?utf-8?B?bnBrbEhVL0VlOS82eGJLWCtaRVBzdmNzOVBZSWJnZXJKQTNwVDdoU082RUJW?=
 =?utf-8?Q?fCXWBqXg8K4qS/jLGt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fae49e82-4694-4282-b6d0-08deb00f3a23
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 10:14:18.3260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tKWR5kOOf15E/vhFWQJxbEPpiHeHylMMkKPhn5U44Z7UnJ8hRhU0aMHT+zYukc2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8113
X-Rspamd-Queue-Id: 3825C51E69C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15845-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/12/26 11:10, Albert Esteve wrote:
> On embedded platforms a central process often allocates dma-buf
> memory on behalf of client applications. Without a way to
> attribute the charge to the requesting client's cgroup, the
> cost lands on the allocator, making per-cgroup memory limits
> ineffective for the actual consumers.
> 
> Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
> memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
> inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
> the mem_accounting module parameter enabled, the buffer is charged
> to the allocator's own cgroup.
> 
> Additionally, commit 3c227be90659 ("dma-buf: system_heap: account for
> system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
> page allocations. Keeping __GFP_ACCOUNT would charge the same pages
> twice (once to kmem, once to MEMCG_DMABUF), thus remove it and route
> all accounting through a single MEMCG_DMABUF path.
> 
> Usage examples:
> 
>   1. Central allocator charging to a client at allocation time.
>      The allocator knows the client's PID (e.g., from binder's
>      sender_pid) and uses pidfd to attribute the charge:
> 
>        pid_t client_pid = txn->sender_pid;
>        int pidfd = pidfd_open(client_pid, 0);
> 
>        struct dma_heap_allocation_data alloc = {
>            .len             = buffer_size,
>            .fd_flags        = O_RDWR | O_CLOEXEC,
>            .charge_pid_fd   = pidfd,
>        };
>        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
>        close(pidfd);
>        /* alloc.fd is now charged to client's cgroup */
> 
>   2. Default allocation (no pidfd, mem_accounting=1).
>      When charge_pid_fd is not set and the mem_accounting module
>      parameter is enabled, the buffer is charged to the allocator's
>      own cgroup:
> 
>        struct dma_heap_allocation_data alloc = {
>            .len      = buffer_size,
>            .fd_flags = O_RDWR | O_CLOEXEC,
>        };
>        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
>        /* charged to current process's cgroup */
> 
> Current limitations:
> 
>  - Single-owner model: a dma-buf carries one memcg charge regardless of
>    how many processes share it. Means only the first owner (and exporter)
>    of the shared buffer bears the charge.
>  - Only memcg accounting supported. While this makes sense for system
>    heap buffers, other heaps (e.g., CMA heaps) will require selectively
>    charging also for the dmem controller.

Well that doesn't looks soo bad, it at least seems to tackle the problem at hand for Android and some of other embedded use cases.

I'm just not sure if this is future prove and will work for all use cases, e.g. cloud gaming, native context for automotive etc...

Essentially the problem boils down to two limitations:
1) a piece of memory can only be charged to one cgroup, the framework doesn't has a concept of charging shared memory to multiple groups
2) when memory references in the form of file descriptors are passed between applications we have no way of changing the accounting to a different cgroup

The passing of the memory reference already has a well defined uAPI and if we could solve those two limitations we not only solve the problem without introducing new uAPI (with potential new security risks) but also solve it for all other use cases which uses file descriptors as well as. E.g. memfd, accel and GPU drivers etc...

On the other hand it is really nice to finally see this tackled for at least DMA-buf heaps. On the GPU side I have seen just another try of a driver doing some kind of special driver specific accounting to solve this just a few weeks ago. And to be honest such single driver island approach have the tendency to break more often that they are working correctly.

Regards,
Christian.

> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  5 ++--
>  drivers/dma-buf/dma-buf.c               | 16 ++++---------
>  drivers/dma-buf/dma-heap.c              | 42 ++++++++++++++++++++++++++++++---
>  drivers/dma-buf/heaps/system_heap.c     |  2 --
>  include/uapi/linux/dma-heap.h           |  6 +++++
>  5 files changed, 53 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 8bdbc2e866430..824d269531eb1 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1636,8 +1636,9 @@ The following nested keys are defined.
>  		structures.
>  
>  	  dmabuf (npn)
> -		Amount of memory used for exported DMA buffers allocated by the cgroup.
> -		Stays with the allocating cgroup regardless of how the buffer is shared.
> +		Amount of memory used for exported DMA buffers allocated by or on
> +		behalf of the cgroup. Stays with the allocating cgroup regardless
> +		of how the buffer is shared.
>  
>  	  workingset_refault_anon
>  		Number of refaults of previously evicted anonymous pages.
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index ce02377f48908..23fb758b78297 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -181,8 +181,11 @@ static void dma_buf_release(struct dentry *dentry)
>  	 */
>  	BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
>  
> -	mem_cgroup_uncharge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->size) / PAGE_SIZE);
> -	mem_cgroup_put(dmabuf->memcg);
> +	if (dmabuf->memcg) {
> +		mem_cgroup_uncharge_dmabuf(dmabuf->memcg,
> +					  PAGE_ALIGN(dmabuf->size) / PAGE_SIZE);
> +		mem_cgroup_put(dmabuf->memcg);
> +	}
>  
>  	dmabuf->ops->release(dmabuf);
>  
> @@ -764,13 +767,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>  		dmabuf->resv = resv;
>  	}
>  
> -	dmabuf->memcg = get_mem_cgroup_from_mm(current->mm);
> -	if (!mem_cgroup_charge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->size) / PAGE_SIZE,
> -				      GFP_KERNEL)) {
> -		ret = -ENOMEM;
> -		goto err_memcg;
> -	}
> -
>  	file->private_data = dmabuf;
>  	file->f_path.dentry->d_fsdata = dmabuf;
>  	dmabuf->file = file;
> @@ -781,8 +777,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>  
>  	return dmabuf;
>  
> -err_memcg:
> -	mem_cgroup_put(dmabuf->memcg);
>  err_file:
>  	fput(file);
>  err_module:
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index ac5f8685a6494..ff6e259afcdc0 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -7,13 +7,17 @@
>   */
>  
>  #include <linux/cdev.h>
> +#include <linux/cgroup.h>
>  #include <linux/device.h>
>  #include <linux/dma-buf.h>
>  #include <linux/dma-heap.h>
> +#include <linux/memcontrol.h>
> +#include <linux/sched/mm.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/list.h>
>  #include <linux/nospec.h>
> +#include <linux/pidfd.h>
>  #include <linux/syscalls.h>
>  #include <linux/uaccess.h>
>  #include <linux/xarray.h>
> @@ -55,10 +59,12 @@ MODULE_PARM_DESC(mem_accounting,
>  		 "Enable cgroup-based memory accounting for dma-buf heap allocations (default=false).");
>  
>  static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> -				 u32 fd_flags,
> -				 u64 heap_flags)
> +				 u32 fd_flags, u64 heap_flags,
> +				 struct mem_cgroup *charge_to)
>  {
>  	struct dma_buf *dmabuf;
> +	unsigned int nr_pages;
> +	struct mem_cgroup *memcg = charge_to;
>  	int fd;
>  
>  	/*
> @@ -73,6 +79,22 @@ static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
>  	if (IS_ERR(dmabuf))
>  		return PTR_ERR(dmabuf);
>  
> +	nr_pages = len / PAGE_SIZE;
> +
> +	if (memcg)
> +		css_get(&memcg->css);
> +	else if (mem_accounting)
> +		memcg = get_mem_cgroup_from_mm(current->mm);
> +
> +	if (memcg) {
> +		if (!mem_cgroup_charge_dmabuf(memcg, nr_pages, GFP_KERNEL)) {
> +			mem_cgroup_put(memcg);
> +			dma_buf_put(dmabuf);
> +			return -ENOMEM;
> +		}
> +		dmabuf->memcg = memcg;
> +	}
> +
>  	fd = dma_buf_fd(dmabuf, fd_flags);
>  	if (fd < 0) {
>  		dma_buf_put(dmabuf);
> @@ -102,6 +124,9 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
>  {
>  	struct dma_heap_allocation_data *heap_allocation = data;
>  	struct dma_heap *heap = file->private_data;
> +	struct mem_cgroup *memcg = NULL;
> +	struct task_struct *task;
> +	unsigned int pidfd_flags;
>  	int fd;
>  
>  	if (heap_allocation->fd)
> @@ -113,9 +138,20 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
>  	if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
>  		return -EINVAL;
>  
> +	if (heap_allocation->charge_pid_fd) {
> +		task = pidfd_get_task(heap_allocation->charge_pid_fd, &pidfd_flags);
> +		if (IS_ERR(task))
> +			return PTR_ERR(task);
> +
> +		memcg = get_mem_cgroup_from_mm(task->mm);
> +		put_task_struct(task);
> +	}
> +
>  	fd = dma_heap_buffer_alloc(heap, heap_allocation->len,
>  				   heap_allocation->fd_flags,
> -				   heap_allocation->heap_flags);
> +				   heap_allocation->heap_flags,
> +				   memcg);
> +	mem_cgroup_put(memcg);
>  	if (fd < 0)
>  		return fd;
>  
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> index 03c2b87cb1112..95d7688167b93 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -385,8 +385,6 @@ static struct page *alloc_largest_available(unsigned long size,
>  		if (max_order < orders[i])
>  			continue;
>  		flags = order_flags[i];
> -		if (mem_accounting)
> -			flags |= __GFP_ACCOUNT;
>  		page = alloc_pages(flags, orders[i]);
>  		if (!page)
>  			continue;
> diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-heap.h
> index a4cf716a49fa6..e02b0f8cbc6a1 100644
> --- a/include/uapi/linux/dma-heap.h
> +++ b/include/uapi/linux/dma-heap.h
> @@ -29,6 +29,10 @@
>   *			handle to the allocated dma-buf
>   * @fd_flags:		file descriptor flags used when allocating
>   * @heap_flags:		flags passed to heap
> + * @charge_pid_fd:	optional pidfd of the process whose cgroup should be
> + *			charged for this allocation; 0 means charge the calling
> + *			process's cgroup
> + * @__padding:		reserved, must be zero
>   *
>   * Provided by userspace as an argument to the ioctl
>   */
> @@ -37,6 +41,8 @@ struct dma_heap_allocation_data {
>  	__u32 fd;
>  	__u32 fd_flags;
>  	__u64 heap_flags;
> +	__u32 charge_pid_fd;
> +	__u32 __padding;
>  };
>  
>  #define DMA_HEAP_IOC_MAGIC		'H'
> 


