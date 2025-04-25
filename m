Return-Path: <cgroups+bounces-7817-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B83FA9BC28
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 03:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884DF9238B8
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 01:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E61422615;
	Fri, 25 Apr 2025 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kwqbG7ZT"
X-Original-To: cgroups@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012064.outbound.protection.outlook.com [40.107.75.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D77C4594A;
	Fri, 25 Apr 2025 01:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745543505; cv=fail; b=ItjIHqUdKD3rrmiz6LHvxakEV+XM2fDreJL0++L1v9HriSSguooHBkstWEEvLy6qCiyYvWDHLb8Fuv0t+p4GHvfh11igDITcwzM7mWGca0Axl85702ekuJxu+N4IVpnrp6qwVFXBUJ7m7112Yi+bLnLwARtscFBzRIPMW7luJVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745543505; c=relaxed/simple;
	bh=CrI+D61k6TGFVhdNrkGJ7SQaWuhxII0l2MW1Qhc+ifA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T2ZfFf1dd/YeBf4p0InS7BtRirB3PjqrfxJH2ROesH+eekxD8wUiBKCg5HtOZrH5shX9klXzrEj9mBNRKJ7nXH773WPK1rzK7oARJa0BdiT9k2fX+9WAHxSgPhf6vwOywcqAwxkrFgcm0SVg80vG8pCk0EgN2aI4mj52TYk08tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kwqbG7ZT; arc=fail smtp.client-ip=40.107.75.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKd9SrzHGL2oCj/WCbtE/Hm6hA945xw/lHrmSfomJXOS1JY0d9KMNEqoXwPeTYwuvvmufgTXneD849GuF72NBPBTUifkaOdBc0F6A/npz6Zplx2K3nNhPrjthYrJ/UJn7ScUDblxPQtd2bjV1gt9Le9cF3XvYDqxMKse0l/eoLrL5S04jWZjDdWJzjpkoeW6rW+uWkKJWPV6YlNeAKZn1rvuHjO366RBOW45iucIckk35mOO+SVpy/6gKMnfS3wxIQfEu6jT5HQVzElVLgNqYczwsLvKgzqQzC+sv1UFcSJbPO14nq4MUgyYDHq64SmkDd9hD0T2R9dSgJTRaDTRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrI+D61k6TGFVhdNrkGJ7SQaWuhxII0l2MW1Qhc+ifA=;
 b=SnYJZAjn7dL/TULKn/pM4FtH91n8of7t8nZrFwXa7aCzVFWINnzW9cKtXVvSIvpVSjpmd/0wGhW/FHRV/dzrQzGlpcOJIEhppk+a5gacE+O51Y+bVfQlEXGFzGpfjZuBhs3OWjF/3KM2Vf+OpIqqWjeZSs44SmSLcREhAmlM6gjRMDH0PvSTk0EUIgdMHjz18P/dSy5uaRPinESi5WguhHIxlwPNddIjME6cV58qmo4wafrCxXdLGJW8Z+Hl5aGvWuYbphaBESm1RB0mMGArRS8neSQjSS7BnuZCVmjwYcZHaZl7PvjalfO2a/A6bYbT/o00lrW4FSMY0LXF1LcqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrI+D61k6TGFVhdNrkGJ7SQaWuhxII0l2MW1Qhc+ifA=;
 b=kwqbG7ZT1yjhWC+nQZMlhiE6BGdRgwdyAVXSFij7sVHm41WVA+9JsewIqlZ9XFzZtCm3VaEp5ABMzmGUg6MaAIT1cuox4mp0lHfWx8WeT1NcTvM8VKMESIgVHjQySO/7PSZNWHEoUIFD8NEVekI+v7RHqT5ik1r45yK+ZKfqp08xGVT34NqHcRLVQNOTQ8MA6oGj4RMfzCsehx8S7uuqLinSJFZ1T9MpBtCDEMcJMcRUTzu+YVvlOT0/7qM008cSOhtIdPE8eAT+AS5c7YRLonAG0GG9RT0bTW/uam+Sl5zc+5ohC9A3/5nNhKVDuEaX3vHyZYmIgp6osrGZ3e5XGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEZPR06MB6529.apcprd06.prod.outlook.com (2603:1096:101:189::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Fri, 25 Apr
 2025 01:11:39 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.8632.036; Fri, 25 Apr 2025
 01:11:39 +0000
Message-ID: <c4ddc913-fcf5-43c4-b95e-7c71748dba03@vivo.com>
Date: Fri, 25 Apr 2025 09:11:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mm/memcg: introduce mem_cgroup_early_init
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Francesco Valla <francesco@valla.it>,
 Huang Shijie <shijie@os.amperecomputing.com>, KP Singh <kpsingh@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 Guo Weikang <guoweikang.kernel@gmail.com>,
 Raul E Rangel <rrangel@chromium.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Paul Moore <paul@paul-moore.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, opensource.kernel@vivo.com
References: <20250424120937.96164-1-link@vivo.com>
 <20250424120937.96164-4-link@vivo.com>
 <2u4vpqa6do7tgtukqb7orgxmlixguexsxilhnsiwv7atssnht4@o4cwziz26wrs>
From: Huan Yang <link@vivo.com>
In-Reply-To: <2u4vpqa6do7tgtukqb7orgxmlixguexsxilhnsiwv7atssnht4@o4cwziz26wrs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEZPR06MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: cf39c9d5-ad89-452b-b042-08dd839621fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3dKcTNEUFRpL3pnMGVFTCt2WVpsNGR3bkZqZmhuSFJpRHkwQzlQZ1dVOE1N?=
 =?utf-8?B?ck1ycnc1MmkyNnZQb3NzNlREU0ZRVEk2TXp2bTcwanM4V2kvMHlrQmRIZFVi?=
 =?utf-8?B?VDNpMWNvRGVPcnlhRVRHMmJqTUswMjVXaFFueTlFM3ZNZHMvcGwrdzVrdXRJ?=
 =?utf-8?B?R3RVeVovYnJ0L0RpZU12YXBPSm9ySWg4a25rNUFqcmRISnI2dEo4dDVPUUdw?=
 =?utf-8?B?bWdHaWMvbE5WeHBzTDF4SGlPZk1CaTRxcWI2ODJzVkp3QVdPdVdxTElLZkJ4?=
 =?utf-8?B?ajFlWlFGaHBoeEN0eS90NzhpZ0Jza0ZjS3dTc2pPOTVma01iQ3lRdlZjQWpi?=
 =?utf-8?B?Vjc5QU50V1VSTHhwdEFwYXhXSXJtcXEybVRLN2M5dGJaNm5ja3daa3doVmJZ?=
 =?utf-8?B?ZVlBYkhwdnk1MEhlWEorUTd3ZmUyMWNtZUtTS0tNc0pHUEc0d2g3TkNOcXM4?=
 =?utf-8?B?UmxFT2ovS2ZRcExWdmxZZWRIYS82KzU1bmFsaW12b01LRGNHRWNoK2xtQTRm?=
 =?utf-8?B?cnBWN2ZvOXhhMFJRT1lnSnNpenNQQXhZa0hxc0FNSTZOV1p5cmtjNFRwTWxF?=
 =?utf-8?B?aWZrdHhWM3hLMmJRNk10YkxBSktaM3BwUjhmOFF2UjFTUDZjRnpMYTUreUsy?=
 =?utf-8?B?NnRrTyt4R0pxVFRPejlKQkprUE5sNk01cXNISXVZQ2k0WmZzbWFITWU3OXpB?=
 =?utf-8?B?dWhLYldWVjBFVG9kQUN0RmJGWmFHSm9RZ3VPWnB1MDg5aXFtcFZvdTdRQXBY?=
 =?utf-8?B?WGI1R3VEdlZ3ZmlmaitRMGQzOVAzeGdwWjhSYlh6MVlCOUNCbld6Z0ZUZVlF?=
 =?utf-8?B?UGZHeW0xTzFzS05vRDc0bHRWbXlYdFFISjF6b1IxcHFzUCtGMHl5ZmlxQUdh?=
 =?utf-8?B?SWJ0UGlaMEVMWWNFb1M4cTBWUW8yNWIvNk1VdkEwUFl3K0pKSzI2aHZndlJo?=
 =?utf-8?B?S25IRDZzZnZITmdqMGE2Y3BNU1B6WWl2Vi9FcUdoNGxnZTlJM3RjTDBMMnBa?=
 =?utf-8?B?cUcxb093THI1dGV2TlBwTE9HSElBYkJHWGMydlFvOGpvTm5UYzhJWGNrZ3pu?=
 =?utf-8?B?a20wY1BKQU5UMGV3YU1ORzg1c3ZHdFRaTzU0ZFRmTUtNWlA5VmV3bllGdDFL?=
 =?utf-8?B?dWViOUpseFhlOXNPSXZkOG45ck0vUDU5NGVQYlEwOWZubDY5NTBueFUzUUpt?=
 =?utf-8?B?MzN4dW9YcHFKQ3F1TGZIM1ZUeWpmb083MzR1UEdLOW9Na05XUTJtQ0hJZnY1?=
 =?utf-8?B?dWdqYXFITDJVclVKcFV0Zi90NTgxRVVSTEJyemQzbnJiQ1RndUNNazZCMFBI?=
 =?utf-8?B?cE5uREkzMmszTksrMm9Wd3c4SG81VFhsZWpEMnFMTWM1azdWUnFTUjR4RzRG?=
 =?utf-8?B?VCt1WUNLTGZ2U29vVDBoQkFldlliVDVnd0NvU3dhOGplR3IyQTN3WnNvTE1W?=
 =?utf-8?B?V21DTEsyemh6WWpPLzFxbGVRUXJPaDJLWWhlSzRKR052aUtQV001YjMyVWhY?=
 =?utf-8?B?T1NycSt6MU8wZncvaHhwNDJsU1J3SXVoZHJVRHdoSW9tc3UxSlpadUFmb0Qv?=
 =?utf-8?B?SVpVeUpmN1FKamN6dWhBM1U4WHNzcmpWRVJXQkpEazlEc3BzclZRY2l2WU5h?=
 =?utf-8?B?RmM3b0ZVRWtYeFFRcTFmVlJSWVEzQUROUUtFNnBZRjVIR2QxNlJoTkdscFZK?=
 =?utf-8?B?Q0ZKNEEveitMeUtLZEVubzF4Y01PWllmdEMrWVF5SlhMTHB3ekVOUHBmdXlS?=
 =?utf-8?B?VUJRVXRVQjlkcm8zY3VTK0xta2NXVEEvbjBqZU50b3pPSnFUZm9HUWV6NS90?=
 =?utf-8?B?V3JwbC9uT3U2UFZMVTF0YlZwSzBVeEIyRkZwNGRXdUk2ZWtNakRCYmxxVnls?=
 =?utf-8?B?ZzJVcGloRWprR1ZDdVNqUDRkZng4bXlLTGlyNnovTUFWTXBrM3hsWDFEc0d3?=
 =?utf-8?B?NytueGF0RWNiRnlxLzZMVktYWmZyU25ncnYyeGZJMnlkQk10cEZOM1MyMlZu?=
 =?utf-8?B?UGhQVUY4MVFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzJoekJ4eGZmTmJSUUdkaERvUnRJazdyd0ZOSDJtUlFZN2c0cGtndzE3MFFV?=
 =?utf-8?B?ODJLTlU3Y2U4UnhSdXNWQXJkM1ZhVGpWbTFmVkJaais5bU5wQVV1dk02UVhv?=
 =?utf-8?B?OUlya0s5bVlTQ0xWcFZVYVBMQ0FQQnZNOHg3NUcvT2ZoYUx4NGQzMzRWU1dP?=
 =?utf-8?B?YWNhVHo2ZllKMzZFZGFVSG5tQy9aYWRVNStINXJmdTkyeWRja0Z1MUsxNkND?=
 =?utf-8?B?clRsemdkTXh0UW0yTUc3aVZneTJrMTVvWVZ1UkxtTGo3b25SU0h1WE0xVVJ1?=
 =?utf-8?B?c25Zb3hYTlk1dFFpSXF3Q054OUcyQTg4dnh2d3FBYXY1WlBpSjJXZXZkdktO?=
 =?utf-8?B?cENtaEVnQ2pnNW1mL1V2ckxON2RIamNXMTBKS3djQ1FMMjdOVHBUaXlsaEVF?=
 =?utf-8?B?SWU1WkxDT0dtNTRXRUtGZXdZQml4ZTdSTmc4NXRHc3hhUGdSZXBoK0hTY0FL?=
 =?utf-8?B?dXl0L0pkanZHeCtTRnJaNHRrbmpzNnZCSGc5UjFzRFMrd0FvakcvaWF6Um85?=
 =?utf-8?B?T20wZzFvNzN3RldyVXdVWThVdG83dDRkeE05YjBnYlVMbnhxdGxaaFR2ZFlw?=
 =?utf-8?B?TGExYVYrMEJ4N1pKRUtRN1dtSDNEYVdha29CQm5GU2dnUU44ODdKTE82VVpz?=
 =?utf-8?B?eGtzM0dHTHdhSlp2cTIwVHpvdzNqTzhsMzNvb1pGQysyaGJ0TjllZCs4RG1h?=
 =?utf-8?B?MDRLWkEzOEI5WUYzeFk0RExubmY4dk11UjZiclZaT2RZdnJGN0ExSTRNYXBB?=
 =?utf-8?B?bm05aU9sUk04TExmQUxuZC9KNkFzOExrYjNFUEdRcVhqYjFoNlpUWHRmdGI1?=
 =?utf-8?B?cTk2WnhERU5WVGhUZ2M2STlCWUxJK2NWd3FVQ1Y5NXRVemdRbm1BOXUzU1oy?=
 =?utf-8?B?Y3h5WWJOaWQ0TS9QM3FsbmxRVk0wcGxPdytadC82YVFiTFh0OGRnUlNJNWdy?=
 =?utf-8?B?bzA0bFpEV2UwWmVLMXFlNDROZTVVS2l3T2J3NGFZeDVCZ2RKb0RERGJRb2hU?=
 =?utf-8?B?a0YxSytLSVlzcUdRN3dSNUwySjRRMWNwNUQxdVcxdis5TnVUZzNkODBJcG9u?=
 =?utf-8?B?ZGFCUFQrRC8rNFBMTUpTTi9zd1F0eE5BU0wzdElxSjF6UmV6V1RWcEdpMXh1?=
 =?utf-8?B?NWgrbnlHRjlxYnpuYllIeGFrek5YdGo0ekcxbDNiWm9ZSUdtWHRiaWlURDVs?=
 =?utf-8?B?TjQvc05ZTlZ1Vy81c3NicFZrM0IxV2doSEkxQWd0TWx3cG5zS0grQ3k4NExH?=
 =?utf-8?B?ZjBoSFU4QUprc0cyU0ZvQkZqOFYwb1pFOWh0Q2xqRDhPS2lQd1I4TFR5YXFO?=
 =?utf-8?B?WThmdThoS2RKMjV5cEF6WEcwMUpmZS9wU0k0NGpRZit1b3N6UDJMc3diU3V0?=
 =?utf-8?B?ZTdHWFU0K0tvaXA3LzBIMjJDZXd3RmJsTml1c2Ewbnd6aXNOcXd2WEZGbHdY?=
 =?utf-8?B?dmEzVkdWZkhvN2hSbFVHdWphYlpkUlU2NWF6ZnNGakJack5pOVZGWHBkcU9H?=
 =?utf-8?B?ejlNNmpvT3BXN0dzOFZPVUdadHdUZFEyWXRtSVZHbW1yRDZkQkhQWDFRR1Bp?=
 =?utf-8?B?MlZYb1hGM0VWSFZkT2JJd2FpM01pVzVMMU1SK3FhTEh4dEpQZVB0cW9YNCtY?=
 =?utf-8?B?OE9ETjJUMk1qUEE0MTJPVjgrVCs0cHJSRHVNN1ZLak43YkpueCtJZFZBZUh3?=
 =?utf-8?B?SXFuODJnV0kwYm1nNFNjd2JtVzdFbDB1aldIZ3ZEYU4zZ1YrRnpUdE5WaFU5?=
 =?utf-8?B?R0txdnAzM0ROZUpvUjhibGI5dGlWSjA4U0kySWtJTVN5YXR4VDAvRFZqOXlG?=
 =?utf-8?B?TTIrN3JKT09DSUUyM0puVStNbklDR0Fzd05pZTFBQ3dHUmpDbnlDdklucjNF?=
 =?utf-8?B?azBEKzNqVFNRajVITDB2NTN3UHhyeGY0MldSSUxTYlpiajZiY0lObGx1U2Fh?=
 =?utf-8?B?ZUpLd3l2SVVDMjJic3dpalk0T1NlUTBmYWhIY1lzWG9tZ2VTZGs0THhYR3lC?=
 =?utf-8?B?eXFrOXZZa2dZSms3bXVUWnBITmxDWW1RNDlFeEdHRzQ0ZEVDbGpQWWVoUGlp?=
 =?utf-8?B?c1Rpc1VQQzhrdmJkUDREMVhVVHlVVHB2ZFZ0NmJ0MDg0WHE1dDJKR05WdFlt?=
 =?utf-8?Q?XFz/61rSilZNjbhVlhH2A5fSy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf39c9d5-ad89-452b-b042-08dd839621fc
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 01:11:39.6845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+Fj6nL0+KJTp6VpbtdRLosUJCi3wjeSnmlufhSMlVFVgvI5+0Wu1Pp0Tcji6u0N2vvKvGFQP++ojWfSKX9f9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6529


在 2025/4/25 00:00, Shakeel Butt 写道:
> On Thu, Apr 24, 2025 at 08:09:29PM +0800, Huan Yang wrote:
>> When cgroup_init() creates root_mem_cgroup through css_online callback,
>> some critical resources might not be fully initialized, forcing later
>> operations to perform conditional checks for resource availability.
>>
>> This patch introduces mem_cgroup_early_init() to address the init order,
>> it invoke before cgroup_init, so, compare mem_cgroup_init which invoked
>> by initcall, mem_cgroup_early_init can use to prepare some key resources
>> before root_mem_cgroup alloc.
>>
>> Signed-off-by: Huan Yang <link@vivo.com>
>> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Please move this patch as the first patch of the series and also remove
> the "early" from the function name as it has a different meaning in the

OK,

Thanks.

> context of cgroup init. Something like either memcg_init() or
> memcg_kmem_caches_init().

