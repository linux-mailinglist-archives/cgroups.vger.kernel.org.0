Return-Path: <cgroups+bounces-11294-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0DDC1662B
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 19:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CC7188672F
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 18:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EF934C9A3;
	Tue, 28 Oct 2025 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="iDHsH6+h"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915B303C9B;
	Tue, 28 Oct 2025 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674640; cv=fail; b=F0+2PwWzBvVP7s0nXZtWUqIa7XA+y+A2yPC43wr+RokBeS2P6acnsQ20sbT1gqUD6aUxfh0ExQX7qnnMbPefdfQPoyEmUsdoxaOPAZFHioVRQNr9ng3DdbVe2Y8MbA/uzeOiYtYo1aEqTzTaZKNgFiaVfy5hliLsy2QtCKlQluc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674640; c=relaxed/simple;
	bh=JVnxl0y+sVCUe84PjRsLwhDfaD+pmWD1+ULbv1WH8Us=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HBWmNw0P3MufjOIu+6Y/g+Mqx6qfTS2wSx0w02f6L+F26ZTX/lAlmm+N416v3lEHNbPjnvjcVBSr02ZeeMljub79WyeRVHsBfSCrD06uoF+DmcL1z9sQVHnDHI5d3tDoMEaMcv7K2E9bbSalsD35QqtSJM1gLvKIpEsQX9Ka1Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=iDHsH6+h; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SI3JNx2340040;
	Tue, 28 Oct 2025 11:03:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Qt0tCib+UXBRxoGDXpT/QvkqlGU3z0zaLS4VEqx5mDs=; b=iDHsH6+hOrU/
	T4KUpIOOdKlKjqo6CLJv05fY5iDCu55d8fYjVBSmh1tZ5yCn3WYJxehrL9gJ/lqW
	5fcM/mK9cR4HF/tlfr7JaWgx+JT2IsTamM2JsLRWiMdKSV/uvLkxOT25WWm+dGP5
	YVOxQi1/DZldRZ5vxUZawwegxN4C8QKkesexngcjF5AbFXQkibgXv23Pum4K2lwF
	VhTcKLI0+UD/AXuhkiew+VmDyBlayU/3cQT74HSBbY8KDlCsQqJ3BGNtsnX8kvcK
	4SfqC8QGCCp1NhrrFVjfJ7rCfPX3nJ3xD50pqQTUSasvOv5WHBI33mxTKlaTPmCC
	Y6F5jv8Ehw==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a2x8t35qv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 11:03:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlV3CclZ4gcUd92ye0Qi0jtOdOZlSyXOD5xTaRBC5TaGAtdNdNqG9Is7uVqsxmhPnD9oeH/goh+nwlijIDEOap4cc5lFu6tcwE7QGH9RQHdzrItVUn8U1b9ijyJ3gQhN1vVZQV4rPBKphU9XKaLV03Taman5z0YnPR9aATk1rfBaZ2sGIvO07pUP11j113RbV3SJ3Ftr2ZDEAkMe3CJnoly8VTBmmgSbpf9ihAVgxipHKNHplF6j56ee5J642tcCAJ8wxz0OAYpm5GrUuXtObeboEWqHZE0aa7CTzkUxosFa/nv3fxWJ8+gCZ/yjZhorrk3iZ9/GBlvgb3IiR1vryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qt0tCib+UXBRxoGDXpT/QvkqlGU3z0zaLS4VEqx5mDs=;
 b=gTYMkdqv4S1uK0og9NsPUCwIrWR6G4GXt0JdfjKGvTyzvXD7oEL6vUZsNMD0PPxgxMJt480jDBsOzQb7TWJJGpcAeW7c23NUodiLVuHeWavUI9CJ4/dKVr+BclYFyHOBJGBYoIx7WgCAOiag+1U1tKGMNpvmqeXA5YaE/5zWnk7c/rG6rmSPRp99ajlN2qnUT/8bNz5pA9rv/+/lo3GqefBGyy7cRJXbdQujHJmBLOZy7GBXNBbOrVuASZEXRoIQTTvhsppErGA+hWTFK7on5rA0WT8i2GGDzq7dHke44kx0wCUaAIpIsJZnp/C8gFGi+VqsR8VIq3kOpGTwXE5adA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by BLAPR15MB3810.namprd15.prod.outlook.com (2603:10b6:208:275::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 18:03:28 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9275.013; Tue, 28 Oct 2025
 18:03:28 +0000
Message-ID: <f5d71202-188d-45ff-a5e8-387d060fca47@meta.com>
Date: Tue, 28 Oct 2025 14:03:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/23] mm: introduce BPF kfuncs to deal with memcg
 pointers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc: bot+bpf-ci@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        inwardvessel <inwardvessel@gmail.com>, linux-mm <linux-mm@kvack.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>,
        Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Eduard <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>,
        Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20251027231727.472628-9-roman.gushchin@linux.dev>
 <2c91977fcab04be6305bf4be57e825f7e84005d16667adcdfad0585be506537c@mail.kernel.org>
 <87ldkv57nc.fsf@linux.dev>
 <CAADnVQLkza5_95qc0vGYBLUu-4FN_cZEcVywTs5XemTE9O-ZtQ@mail.gmail.com>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <CAADnVQLkza5_95qc0vGYBLUu-4FN_cZEcVywTs5XemTE9O-ZtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:208:52c::34) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|BLAPR15MB3810:EE_
X-MS-Office365-Filtering-Correlation-Id: eb8da542-376c-4aae-96e7-08de164c4bd5
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGFmaEgxcWEvTHFxOW9GLzhyMXo0S0NoTHdPbi9GajF3SVVWWVRhcVZIalN3?=
 =?utf-8?B?VXBLYzFldWlOZXF0YTZCUE1zTndwdDJWL2U5SUlSY29RSzNQU095LzFuRUJW?=
 =?utf-8?B?V0hqeDF1enZtbDI1Vk1oMVJraTU0WnRmbEl2Q0pnaDhmam50T25qSEI4WjFt?=
 =?utf-8?B?bnEwRGFVU1dTWlFsbHRQRnJ3bmJjSVY5V3BHeStHNVh2T25aSTlUdXFlcm00?=
 =?utf-8?B?TUFYTFk2bFFwYmdIek5PdytUaG9mRHdFczdDZ21mcFVPOGV3b2p6dFBTMnRm?=
 =?utf-8?B?NUdYWk11aXNyZkpoYzBmajZjYTE4SDFTVk45dUh6VGVFVUJYQ2w2ejVPdmFu?=
 =?utf-8?B?RFdsSDMrTDczWjV6UUxNNWFPWXlSQi9jT0RLaW84aTZtLzNIUmN3WWdja1VX?=
 =?utf-8?B?V0lRSFo0NG9JUjQwSUkydkJxdWdmbjNuRHZsSmZ0V0s3amVvVFo0QkhUMHB2?=
 =?utf-8?B?T1BYRDZ2K1NrTEtub1JIVE10VlkwQ1BhYVJjTkp2SW5lSG9MN0ZZMGJvdmc3?=
 =?utf-8?B?RHFjaXcvSGN0SFJKTTluNXNvbVk3UERvb01ZbTBQVDhpZ0Yra0o4SVRycnpY?=
 =?utf-8?B?VWRUL2ttcDJvTm04MWVtemNlT3hXWHhMVTk5Y002WUxHTWVQUjFMY3M1WE5w?=
 =?utf-8?B?RVNpODVVbDhiMlQwSG1vWVZTZ1BjdEQxRFN1TTFmNnF2aGhBSFpYZGNZZXlR?=
 =?utf-8?B?cU80bjdrMFFJK0RBTDE4Z1pJMW1yRm1BSytoMXkrTklEZjZISlVGL0IvdWE0?=
 =?utf-8?B?cWNZNzZESDV3emg2ai9KUzRyNXcwUExlMzZoYlk1K3dZODJWWXVGUml2dloz?=
 =?utf-8?B?NXZtSG5tTnBKUVJGMnh4T00vZlNWVUN4blpSNWw0NmRnS2diRFMwb0FSYTQx?=
 =?utf-8?B?SUs5cnAvYTM5WUF5YUlFdytQNGJVbXZESzkyaDFYL043UU5VSDh5d1NUdFMv?=
 =?utf-8?B?V25WeDQxRVMzY2hKdEsva1VYaWROTmNRajR5bkVGQXY3SWNrRUFxOU5LWmlN?=
 =?utf-8?B?SmppSlFYQ1pZc2xCTmRuUnBabFZFMnhDeUZFbTZzQkFGcHg4QVA4VHNpTHBH?=
 =?utf-8?B?am16VTZlT3ZqK3F4eSt6YW1aaGdUNUdWWlNZb1FaOC9VckQyMlZyaGljSTkr?=
 =?utf-8?B?N01LVmU3dkx3aHlzbXNkZ2o1VkoxbTNwSUFnZUo3NmhnYzhveDJDVXVuTmhn?=
 =?utf-8?B?K3IwTGliT3Y4T1Y4SlRtY081NGNXRWJJY1U3QVhxRzVya0RMY2gxYURsNkZD?=
 =?utf-8?B?V3dlTzd6VnBxM2twQUhzbjVHaFpia3lWejVrMGFWYzN4TWFYcEZ3Z1YrSVRw?=
 =?utf-8?B?S05VSTJLYWl5U0ZPYUwyd2ZQam9BSDBydUo4Z1l5d29JQ3RSSnpyckhJK0tD?=
 =?utf-8?B?b1c5U0cwZ2hVZHEzOURiWGQyY2YrbEZ1U0hweFozQ0hRSFlvcEY1Q2Z5NmhP?=
 =?utf-8?B?VGkvZ28vMUREbkVxQ21nSkV6QzZGK2VRejk2MDJod09TRzUxajJoTkJic3Vz?=
 =?utf-8?B?bmNkQ2RNMCs5N1NKWGg5Y3k0Sjg1T25iQTh3QjFkMFRHaW44Zlp3bzB1c1c3?=
 =?utf-8?B?eFFvM0FPUmF1eWZweis4K1E2NE03UUNpRnJnU1NQMkVTa0FkQjA2a2JwMFl2?=
 =?utf-8?B?MGRTM01BOWtHS0hnM0FqcEZIaXF3dWt5TlYvejJoMERRUnNLZlQ2ZzJqWG5j?=
 =?utf-8?B?bngvaFBjdmZrTTVOSU82Z2l2NFJzbTUrTjVoUmdaTXR3akc1N3VnOHlqc1py?=
 =?utf-8?B?MnV3ZkVNWDM3c2Joc0s3TzVYQlRITGVqWjdUYVJTK0J4VUh3eENpTmFWWFZQ?=
 =?utf-8?B?YU4vdm44Tk0zWDAxZTNqN3Avbnl3SGZWWjBTQkJEMm5hQ3Q4VmJENUpMYnhH?=
 =?utf-8?B?OCtXYThBZUtCMGFDdzFsT0V0S01ZYjhJazZmM2FIbHdvQ0gyL1VLK1A5NkFE?=
 =?utf-8?Q?QhohJ3yKp8re7RWrw6IS6SHTzGV99sYQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUpsWDRscmVJRTN2Y2VKSFYvUTJOR1ZHUzYrdExNT21Pa2VoNU5VMFBCYkZ6?=
 =?utf-8?B?anZNQWRNb3J0Sm9ucUpQcjdma3JXRGRNNGVqOW1kNWNWOEVMNHVJNUw0NDRN?=
 =?utf-8?B?ZXR6ajJGc0JtZEdtb1dvem95RmRHclVRMHpRRnowTHczUzVBWmlyUFZnR2VG?=
 =?utf-8?B?WGVHQ2FoV3lUL0ZVdlQvaVBBNzhEZi9YVEE0Wmd6c0R0NXJuTlVySmZwSDdM?=
 =?utf-8?B?a0VHZGYyU3ZIQTZGOGJhbWJ5Y2RBaDd1SGRSTENpZ2Q4RGQ0VGVwbFlxaWww?=
 =?utf-8?B?QllzdWgxY09ZZGFBUFU1alZiZmVIZ2x3VjFaSDJRejVLU1M4Sk1oMVBYTis3?=
 =?utf-8?B?akVzbGlCY2grSnZGR2pXMnZQYU93Z1YyZ0w5VGJkL0FEb2Q4UkE5RUZnV3VW?=
 =?utf-8?B?U1B3eVloeDFaT0toZ0pMdlZMWWs3OEcvRmJUTnFObDI3VXBDNFkvd2plbzgx?=
 =?utf-8?B?NzJjSmYxSkxyVjdTUmZBVjNVYm1pNWdHMzFMUnhHODhMREIvVEdSVFVMNHB6?=
 =?utf-8?B?L0FzaTZBZEFtR004SlFDTUw2SUNRRi8xNWYzbU5ON1g5RlhKKzVNTi9VR0VT?=
 =?utf-8?B?TllvdmUvSjM3RTNRb3MyRSt6dzNQbUtPamNKYkZtTlU5Y0NpMzh2aFpITHlv?=
 =?utf-8?B?ZXNwaVI3akV0dUo3RkJudVRRMFZpdlBpRWNSYnZxRlJJUHBhZE00aXJxaGtZ?=
 =?utf-8?B?VmFSL3kwRXJqQWZGYkhRaEJGTGVDcTlaRUYyc1Q4K1pCWWUwVkhxS3RqR3ZE?=
 =?utf-8?B?RGNBTG5FVHVHd0FhbVdmenVrb2NzUTcwQ1B0ZWxuQmVDVGl3M3lOamdhaG5x?=
 =?utf-8?B?dHlFSmZSSjFMbFJtS2p4ZTNMZVRoYUJrTVVHR3pzcThmeUlUcVM1dS82czlz?=
 =?utf-8?B?Qkl6dXBDblNhK2U5c0tCV2YwNTcwZlEvMXlzcE9rYXpXVzlweWZMWFFsdlZC?=
 =?utf-8?B?b3hpOHdCZHh2cUJ3VFhRZzJYbzJNMjBaT2dLV1ltNENGV2JtaVRDSDVaZUFK?=
 =?utf-8?B?c1RFbmRPcS9jcGc2eGE4Rmo5MVB5YjVqRTN2L29RSHVZQ0t2RXlFVFlOenN4?=
 =?utf-8?B?M3BFSlNmTlpjVU14WkZiSVN3WHF1dVl6TnFQSzdud1NsODVKQjNlQnBFUGhR?=
 =?utf-8?B?UnpWa1hnY1llcy9OMEhsM09laHViekYyblhSUmloNi9tUTFQWWF6a0V1a1pp?=
 =?utf-8?B?My9HbEo1bGM1dCt2aGVvUVdHQWdwTEthTmdTSlMzRFZOK0lPUWUwNk0zWVFI?=
 =?utf-8?B?SFpqWFo2S2NVN3pwY1BrWGNEOVcrUVBMeTFSTFFqQjlod3dEb3ZJRXFSNkMr?=
 =?utf-8?B?V2FoRFFweGR1QzVWY280T25maDBTVzBGMWhVWHI4cEU4L0RuUzRrT09KV2dX?=
 =?utf-8?B?eDRYeW1MNUxHK1NZTXM5QkVsRjFSWUFDOUZpbFFuNzJSbGJqMys1dnJ0d2ZN?=
 =?utf-8?B?ZEVZc0RDcmMvbUxwVzM3QXBpUjlxZ3V3OXBLcDQvd2VKS1ZPUzFDVUVEY21Q?=
 =?utf-8?B?VGdHek5tZHE3SW5tNHNleUJMTCtWWDBlYWJPajRmalJUOTRaTkk3dGNPMm5r?=
 =?utf-8?B?U1RoSW0zWlZCMmZJQmlRWFFaSERsQ1YvTkdxc2svcklpSUt6Y0ZkWmUxNTVZ?=
 =?utf-8?B?TEdGaHJhRVhwVjRpUFpiUnBLYUNiZHRUQXNoNnBFc2h0OTd0M2FMNEVldnBs?=
 =?utf-8?B?M1ZTQlRWUmw4V0VxRExSMXYzZ25tcWFVeUNVcS92YTc5K1RUVDNLd1RmeExY?=
 =?utf-8?B?Vlk5MG5WdVFTNEZBR052dkhuWXBIS0NQekdMU20rUVJKSjgzSUIxU1o3bk94?=
 =?utf-8?B?c0tPSk1JSnhVRjZkc1ZiT1g5bms5MkoyZDhlMjlrR0FYMzJPK0NFMHZNTVRU?=
 =?utf-8?B?OS9oYy9WMldRVnR2Ti9CSXIrSGlWWTY0MW43cGdNQ2x0enVZYVVXYkdsM3pa?=
 =?utf-8?B?SDVFcFdJOVFMbFFGeUFRcThmc0pCQXVSa0xZWi9RZzQ5WVlXeFFsT09wN0or?=
 =?utf-8?B?cGw3anpvWjhpSDZMRDlpYkZ6U2JPWTVBNjh1cmpYdWtVMTlRa1dDRm9hMkpG?=
 =?utf-8?B?ZVU4bURZVHVUWXgwWFZieG83ZUxsdlRZWmpHckt4dVNrckplcHJxS085dERB?=
 =?utf-8?Q?VjSk=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8da542-376c-4aae-96e7-08de164c4bd5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 18:03:28.0917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XkDTAIJGi/uFKXub67OrGZPVwv26OPUBC4LRm72S4w0onai+1Te+vjeVyAmHjlgX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3810
X-Proofpoint-ORIG-GUID: zpfbGEQNz0REPdltqS7syUAXJQOkmMTL
X-Proofpoint-GUID: zpfbGEQNz0REPdltqS7syUAXJQOkmMTL
X-Authority-Analysis: v=2.4 cv=ZKTaWH7b c=1 sm=1 tr=0 ts=69010571 cx=c_pps
 a=l7cXxZGRKbMfBYROU17HtA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=jre4oYD0tLkGBLZp-RcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE1MyBTYWx0ZWRfX4YHZPdO6zZdC
 OySlurK1hzfMGvzbsjp2QZb64wRHd3h4GJHbPazlDl+4WONvcYOK9Bx0ao7aDyamShSTHTsMZem
 CjgyG83QXOUMjniRIeJEG0TNO2JJtLI0C8hKHg3+AM9kt64cvnFdFHy9abnRA5vaYzI8n8SV1uJ
 P0T86LozY5y/YeKBRwBZJVUHiLMBrmn4nnIT+70sH9nwBpUhso8ICXGPKDEu2WEJDoLyPZuW43Q
 Pfqh5sgLlIxvePZsB5Re6x8nBFnBmKy1v0jIuoGuWYlwUMJ65ShT2iISFHxJzervIavDXhRphEA
 1QnT2XxsgXs/Mwe7OFYpg3knp/34CxQxCJw2dxYMi5BMy7HyQZdrdVyynCfeeQKOx69ad05FSwB
 XuxcDLrmmuTIlucPjT30CKjfT01NOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_07,2025-10-22_01,2025-03-28_01

On 10/28/25 1:12 PM, Alexei Starovoitov wrote:
> On Tue, Oct 28, 2025 at 9:11 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>>
>> bot+bpf-ci@kernel.org writes:
>>
>>> ```
>>> commit ec8e2e1769704b4f69261f36e6aaf035d47c5f0f
>>> Author: Roman Gushchin <roman.gushchin@linux.dev>
>>> Can this dereference a NULL css pointer?  The function checks css for
>>> NULL at line 42 with "if (css && css_tryget(css))", which suggests css
>>> can be NULL.  If a BPF program calls this function with a NULL css,
>>> wouldn't it crash here before reaching that check?
>>
>> Here css passed as an argument to bpf_get_mem_cgroup() can't be NULL,
>> because the BPF verifier guarantees that it's a valid css pointer.
>>
>> However the result of rcu_dereference_raw(cgroup->subsys[ssid]) can be
>> NULL, this is why the "if (css && css_tryget(css))" check is required
>> down below.
> 
> Yeah. Not sure how feasible it is to teach AI about KF_RCU semantics.

I pulled it down locally to try and w/semcode it is properly catching this:

False Positives Eliminated

1. EH-001 NULL dereference - css parameter dereferenced without check

- Why false positive: BPF verifier ensures pointer parameters are
non-NULL. All kernel kfuncs follow the same pattern of not checking
parameters for NULL (css_rstat_updated, css_rstat_flush,
bpf_put_mem_cgroup, etc.). The KF_RET_NULL flag controls return value,
not parameter nullability.

My plan is to just have the prompt read Documentation/bpf/kfuncs.rst,
which Eduard suggested.  I'll make a bpf kfuncs pattern and do that.

-chris


