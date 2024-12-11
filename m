Return-Path: <cgroups+bounces-5840-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 669029EDB0C
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2024 00:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDD6283B9C
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 23:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938FA1DE880;
	Wed, 11 Dec 2024 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p/aMxKYP"
X-Original-To: cgroups@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC0B17838C;
	Wed, 11 Dec 2024 23:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958952; cv=fail; b=Jes8s0ujOPcoklKhNfNUvOnOHIDyxHHmOo6LgFKBo44bNGWHQY23HRdcduUNemhUKzJ+nS9hJ9XrmrXDQixrJt7TFrW1YjjFT6eIwxnpNMIJAD2okQjmrHI4bpKJ36tmi/cRrnOslyLL2J1xzB1q7AcCFKF/K+oMOp6FYwYbwkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958952; c=relaxed/simple;
	bh=W6v2AHDC3+b9ZC8UtZGAGkvUNj8I5fAJ/aq/g313bqA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S0S+VwH5TSkbk7EocZkUP93t2FCa4bZe66x5YoZOWeBoq8Vz9rRvfySSfIIOwVIhlO1qk1zzd/2cByGVMZNh1/lZkYlQKpk4ubiPj5axTIuMn9ZQrnIAyXdC/OXKwFxNVVbjH6UhcZ3MtAGHXFNphjB+nPSr5ZozfvqUiz+Wvdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p/aMxKYP; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abx+jXkmMk0YxW98agXi3wIlHCrcMnPtDW1SPm1xBE8oGBUsSNG75qXkSiahoMdL5xgbbe/MuZeT26QJ64Wj4DFi8Ff4incU56ZZ8orB2rBbZXx/JcemawqKEqVND3Y0qMVCdiSf4duaYKVn56bm7Rhkvg5sj3883LiqbFdQTT1RBAC4IYMhGSSIBQwwkU+2GXl/dr5A8PFb491N+3OKiLbZBcIFIl9LKREg7Pdu+V/EArR7oGv5XI2O+CFCiTprWFId15PP1SgWihQcygwWU8m63GkCfLJqDYbC4bv3lwHJhC0ZIAc/HNL6StxX/roMbKeftPsrCIMBnMJvMjcxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QH3TzJ2RDWfGiKovofjJQNBsPyrIcb1as5bhbck7OE=;
 b=hcpU3gvKg57HTe2C10zGlmx/xPWOc1IjnTAoEGjc+TL6emFh5a4dlSR4lKGcyDeDxYYvmWWD9qDLOWgsfB+4uYdEO1ycaFzc97JlJAMnwcAZk7LYPMqKxV/imk2xDphreTVIj4tD1fgVKpOJkz7tpLtl0IZvC4cDKiZfNoAP9e7y68SO6LlmdywGP/2nXl53Y1SYAn44uMcrkGoApm8AHUWghGQhvRjvLl8sUShJvjnvAjQcWsUSbd8uusPTjxDxkJ2PMtufDKMxZ93vO+KGJf4M2Gjtdv3yAHbJ8A+sjV/Llw6qnAR7yoVc/FWNzKfAxN1VSUABDKC3ymZ2LjJaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QH3TzJ2RDWfGiKovofjJQNBsPyrIcb1as5bhbck7OE=;
 b=p/aMxKYPWdNRG/A0YtWDZspfUshUgeqLYQUUOebkqm3DlRw5GQ0FPXL5ySenmnD4EC4Jdfkrnrxf9nxEsPW0/JcyGc7I8X2meOuF/hyXdohoxj+IPcBQu2mOhXU7xMjeSpdWBWpV1rFfZSRCApeniQiQj9ZxnKZdbjdMZj0pmdxqRnRUVodGaidLMvuHxPprkdS9GpVixSwWKDhqynPQFBzC+cl2MVwbcPwD+1cG+IDR11uYJXjoGsuzlQU38jcUI/uR7F/wh6UEJk96LCWOeSqs+DKm/qwqUDK6Ok67cM04MoRcykTmTfEQSnxHlNSGQvKD7dGNNiyJ5CQZXW7UFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7)
 by PH8PR12MB6746.namprd12.prod.outlook.com (2603:10b6:510:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 11 Dec
 2024 23:15:40 +0000
Received: from SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868]) by SA1PR12MB7272.namprd12.prod.outlook.com
 ([fe80::a970:b87e:819a:1868%6]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 23:15:40 +0000
Message-ID: <766a28a1-c82b-46fd-b3b0-fe3b6024f462@nvidia.com>
Date: Thu, 12 Dec 2024 10:15:35 +1100
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
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20241211105336.380cb545@fangorn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:805:66::27) To SA1PR12MB7272.namprd12.prod.outlook.com
 (2603:10b6:806:2b6::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB7272:EE_|PH8PR12MB6746:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ceddbce-1a51-41a2-ae69-08dd1a39bab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THN4cStoaXJnaVIrb1c5RW1uNEkwV21qZ3pPUnpJYUhVUnpMK3Z5TUdVbzBL?=
 =?utf-8?B?Z1plNVoxb2dIMW1wa3hJMDJVeFdJbnJvSENjNjRZaGxVR1FrNkZEekxWTm1E?=
 =?utf-8?B?d1FuK1drOU9XZXF3ZDh2Ym5PYjV4ZTk3cEZRbnBUL1pGbm41YlhwWGRDUmtW?=
 =?utf-8?B?NTRoVXhRQTl1enNPcGQ5bXFiVGdiRWlqeGp5MUZINDVyakZnMlJjZWtHRmZ1?=
 =?utf-8?B?RStRM21LeFJtN2tPaUZ3VERFcE1MalVXMTJHN2k5bkx5YS9MYWNFY0gxcW5u?=
 =?utf-8?B?ZTczTCtiOWlaUDBxdjNOSzZuOGZWSmI0cHZyWGJSb2pLS0xWOW95M2kydXJI?=
 =?utf-8?B?OXVXNUNibDRLVDlCai9XWDNuRjYvcExpSk5OMWozUFhhQ3FldWRxYlY5dnV4?=
 =?utf-8?B?YzMycEZtaytUZHB3QmFoOERqS2I4RTg2VWdkM2h2ZStrLzlQN3ZOT2hkaHhw?=
 =?utf-8?B?aDMxRFJFem4wSFFmTmxwdXc2eE1tRUVpR0VqQ2R0VWpIOHRROFdab21kNUFY?=
 =?utf-8?B?MStCMEgyS2NKZUs5WGJFMnQ3cGdyTk8wNnErcktiY3R1MDh3OGR2NmM2b0tI?=
 =?utf-8?B?Vk11cVZXeUJuWDlBbFNLVXc4ZC9rMkx3dncvWDRpYWpQeWFpN1loaU9TUzVJ?=
 =?utf-8?B?Z1JJSEpUMUhSV3FxMTM4TTJWcFFHbXdOSXlhVitMYjllblRrRTdzRmFPQ3hL?=
 =?utf-8?B?V25ZTndEbUR2N1dSM3N0SjMyZUdCUGcyZDVuTmpJTWJZeGJLVWMyUUxGeXFW?=
 =?utf-8?B?dXJyYklmbG1nZVpjZHd0dURpbk1OcEdLcytFRUVEYVQ0Ry9CV1lPWE5OUkIy?=
 =?utf-8?B?Z2swNFlYYldqeWd5dEhlZ3Z6NE1jSnZrWVY3TGZ6VnhlU0Nha0cwU2YxdlFU?=
 =?utf-8?B?RUYrbGR2VUdIUEZCWG1IV2haUDgyL3VKT1pKelBKWVRudjVkTzBOWUtEUUN3?=
 =?utf-8?B?cDVCVGN2Y092T05TdGJzQzdQR0wwbEQ0bDgzSXFTSDhqYXdBbmQ2SkF2Wmpw?=
 =?utf-8?B?T2JiYWpvU0dwU0hJTjZvMjE4QmNjUzlGakpwZjhjZVpPS0xqV0VFYVVnQ0lh?=
 =?utf-8?B?cEdyaHNSd1M4bjdMNlJ5aGx2bmYwSkdtdWlsVGJLUlBtcFFxWmdialFGNWMz?=
 =?utf-8?B?cXNzcnM4UlRYMy9iTDFrV3FkODdNU1VuMGRiaUt3Q01TQ0VXNytEQXJKU1NE?=
 =?utf-8?B?VzNXN1M3SlZZN1Z1L1duMmFoN0xjejJtZERDZEJ4M2FTeld5K3B3Rm5WSFli?=
 =?utf-8?B?TGZjL2VVN2tEUjJCVXBzbUl1cUdFMmVmZ3Y0RDVNaUw5WDVhU1ZWWUpyOXRu?=
 =?utf-8?B?c05LSDI2RU1VUHhwWFZhK2RPV1ZqTUhwNUtwZW9iSjFxVlJyalpZZGNNWEk5?=
 =?utf-8?B?aE8rNzNMcTdxK1FXaEpQbjRhTUtJWlk3QUlpcVFPUmdWZC9EVzArQUMvbUFY?=
 =?utf-8?B?MHQvRytjTzFWWVNuNWpDT3RZZmU1dWE1Rmh4R2ZTVUpwTzA5SUhpVjhzdHc5?=
 =?utf-8?B?OGsvVzllZVY3Vm9VNEZra1RTUkN4THJhd2wvbmQxQlZ4R0FYNUU1UFZkSXZz?=
 =?utf-8?B?MnBUS2F0dGd4WCtDTHNCV0NheHhJQ0VES29uMitPK3Y1T2F6Q3FCUThnTk93?=
 =?utf-8?B?M2hPK0pkazhFaVlyNldKU1FxczlyaWp0Szl0Q1Ztd3g3aFpYOHN6U0VKNGgr?=
 =?utf-8?B?L1BrRTlDaE1LanJiQm9iRzFsbmZlKzYzODdEVmNzMnBUR2FxOG40TGFFd2Nn?=
 =?utf-8?B?TFFkY2F0UllpSzZiVVAvTE1LNTROcDNkMEtneERCUXZidU05czVIditURmla?=
 =?utf-8?B?UUlMY3UzUE5odEJkSzBvUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7272.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzVRQ3RIVWlpaG02RjA0MXZzcnJpWlJlSnpXZjhqeXJzZ09xVUVzbnVuQTlu?=
 =?utf-8?B?VUZNdlBUSDA2T04xWm9CRTh0SmRYeEw3MXB5bFpDL3FQYTJCUmMrNzJZSTJz?=
 =?utf-8?B?TW1pNU0vRGovWWd4L3hNckFMSDJKMEh2N1BvV2RPRzlUaXp0YzhtdXdPcjFo?=
 =?utf-8?B?RDAxbkgwMUdxSnByTTVZaFlQdkxoWHVXVDY3Z1NRN08yOHZZVzM2RkFSSnJq?=
 =?utf-8?B?STFSSXo3Y2FUZFM0SkV3SnFsck9ZcXZTdWNaVGRaWUlHMnZ1ZFpkZDRIWU1K?=
 =?utf-8?B?b2JlQisybklmNm9VL1hoVUpHMTZqSjRLczVaR25sZHJldUZBRGxhbGpxekZV?=
 =?utf-8?B?RzZqKzNMa1dUdFVHVDB4Qk84NUJJb0htdUovVEZGUUxwTXVaSjBRa0RiWkZ4?=
 =?utf-8?B?TlVTK2R3QjFtL0RYMTQxZ3JKQllxVE1oa3NGUDVLQ1AvWWs0THgxZ1l3Ujl3?=
 =?utf-8?B?K05wUFhxdDFhdVRzSlo0Q1h3cU0zTFJ4US9BR1VPQmZJTDZGVjhXMWU0STVt?=
 =?utf-8?B?dGtISDdqQUFrVDJVc2p4cVpVZ3B4TU5ROFpLSkRMU3BvWTFZc3cyTE1yNElE?=
 =?utf-8?B?LzFrbzcvaVJEZk5oOVV2QlgrWVUrV0VuUGRHeGV5K0xJbmR2cHV1ZVBpR3N2?=
 =?utf-8?B?YWlQUlZCb25ySHkvQjZCUUkyanNzVmg5WEFKSkcweXhwR2x3RzN5SGd1cDRL?=
 =?utf-8?B?WmZzbFdRaGZxNmVhdmk4TmlpSXlMZFBGU05PT3FicEFPUnVTZHVTU0gxVDF1?=
 =?utf-8?B?dzBxYnFFMlR0Nkh2bkJxUXdIN25aQTUvQ3dDN2UyVkczbUtMY2szNU9kN0Jy?=
 =?utf-8?B?M1NpdThucjdYcVpWM0o5ZTduT1lWU09uVW9rQnBaWlNRZXRLNkNadWh4dUdh?=
 =?utf-8?B?OXJYVUV4a3g2WWpaVDNvZ2FSRnJXOS9sdlBlTEJnNUN1RGNlangyUGxJZ1FF?=
 =?utf-8?B?K01HcjJOZnJNUE52OXVvdVRlTi9BSEJ5akhsa2FaZlEycTBLWERVem02QnBQ?=
 =?utf-8?B?bDA1YWlobU56TWVmL3hNRXdDUzRGWVBnL3JiZ1V0MTlBbUlFSDRhcWlrUk5a?=
 =?utf-8?B?QjRDaWdQNEtSYlNuWkFNWEl3b3FhU0h6Q1k4NzVXbWtCaXBjTDNhZGlNcVZS?=
 =?utf-8?B?M2RkR0JFcGQzcUtaNHFYc1R4dUdrQ1ZOQXNuQ3VLdlB2US96NjZzaXhuTHRS?=
 =?utf-8?B?UUZmMjBNS1g0dXNjMEVLcDNiNklxQ2U4cWtiQmJjRzNhZXZQbnBpcVRLUDdl?=
 =?utf-8?B?Umx1Mi9yV0w4Yk9jekh6QVRKSU5kTUpkMFpOcWF0TUV0eUtuRTM4SVhZOGRw?=
 =?utf-8?B?S3NpZHpqQmkveEZjMStCdTl2NVMrLy9OdEN0enRFaWs3Wkl6TUhxbC84Vm9v?=
 =?utf-8?B?ZDB6V1lsSkFpUUFRbzYxTWxUdGVqZi83NDVwUVFFVVVocExnRmdxVW9SeERn?=
 =?utf-8?B?VERaaXBUdDhON3R6a24reXFFWlowTTVNdjFENjBHdGhwK2FKT28yRUV1NCtk?=
 =?utf-8?B?RldaQXp0QUFnell6emoyNWpVWEovcC9nVkdFdnlSQjhINy9hbjQxOVdlN2Vs?=
 =?utf-8?B?ZVhaeW1PZDVzZVhDODZoVjNHSE9BdVRkV0NKN0gvcnRSK1VpcGZocVNkQThq?=
 =?utf-8?B?R0xjTUdBakYreXRnS050MkhZUVM0MVAwTUdjLzkyZmZEQmdZcE9OeVdaRGNP?=
 =?utf-8?B?OTk5WmRQdXpUYldSZHdIdWo3TmxKZ0tPbUJHN0lsQzdudlg3amJwalFtUWE3?=
 =?utf-8?B?NlZGRjcwUEpBQ1ZoQ1JjTk5UMmk2THFhTDgyRDNxa1JuQWRySWlHUHVuT0Fn?=
 =?utf-8?B?SThhSTBqbklBa05adkFpdkljMG9kSGVvMGg3ODhYY1hjVDZvYnNadk1MUWdJ?=
 =?utf-8?B?amVuelF4VEM3cUNoNW5lbHZJVEt4VXVIaENYakwzd2xwQTMxcXhQa2RKaUZX?=
 =?utf-8?B?V1JyVC9PNVozRVZjOWxNS1hTNnZRR3JDREY5SW1nTmlDcEJSSDR3ZjAxSDhY?=
 =?utf-8?B?VWJrejJZeVBmbE1ycHZybjQxQnYxTG12cHRDVEJQQWJtL29WTVJlbHV2ZW1p?=
 =?utf-8?B?cUxIL2xmY0wvRFBKb2grL1RwOGlrVmxGRXQwa2VsRHNmdlh6T2ZDUGhYeUtO?=
 =?utf-8?Q?nt5vivf+CkTtivA0RFq5yW2nR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ceddbce-1a51-41a2-ae69-08dd1a39bab1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:15:40.7166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHftuwv0LsrzGi07q5i3XSSWXEQqmHmOV1gLuifKufda4GySsfmY6+d2Yo+CS4Tx1B2YzXGhjHZdvGyF2zew8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6746

On 12/12/24 02:53, Rik van Riel wrote:
> A task already in exit can get stuck trying to allocate pages, if its
> cgroup is at the memory.max limit, the cgroup is using zswap, but
> zswap writeback is enabled, and the remaining memory in the cgroup is
> not compressible.
> 
> This seems like an unlikely confluence of events, but it can happen
> quite easily if a cgroup is OOM killed due to exceeding its memory.max
> limit, and all the tasks in the cgroup are trying to exit simultaneously.
> 
> When this happens, it can sometimes take hours for tasks to exit,
> as they are all trying to squeeze things into zswap to bring the group's
> memory consumption below memory.max.
> 
> Allowing these exiting programs to push some memory from their own
> cgroup into swap allows them to quickly bring the cgroup's memory
> consumption below memory.max, and exit in seconds rather than hours.
> 
> Loading this fix as a live patch on a system where a workload got stuck
> exiting allowed the workload to exit within a fraction of a second.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  mm/memcontrol.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7b3503d12aaf..03d77e93087e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5371,6 +5371,15 @@ bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
>  	if (!zswap_is_enabled())
>  		return true;
>  
> +	/*
> +	 * Always allow exiting tasks to push data to swap. A process in
> +	 * the middle of exit cannot get OOM killed, but may need to push
> +	 * uncompressible data to swap in order to get the cgroup memory
> +	 * use below the limit, and make progress with the exit.
> +	 */
> +	if ((current->flags & PF_EXITING) && memcg == mem_cgroup_from_task(current))
> +		return true;
> +
>  	for (; memcg; memcg = parent_mem_cgroup(memcg))
>  		if (!READ_ONCE(memcg->zswap_writeback))
>  			return false;

Rik,

I am unable to understand the motivation here, so we want 
mem_cgroup_zswap_writeback_enabled() to return true, it only
returns false if a memcg in the hierarchy has zswap_writeback
set to 0 (false). In my git-grep I can't seem to find how/why
that may be the case. I can see memcg starts of with the value
set to true, if CONFIG_ZSWAP is enabled.

Your changelog above makes sense, but I am unable to map it to
the code changes.

Balbir

