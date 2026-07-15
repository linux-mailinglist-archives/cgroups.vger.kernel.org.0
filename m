Return-Path: <cgroups+bounces-17813-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6353KUngVmoaCQEAu9opvQ
	(envelope-from <cgroups+bounces-17813-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 03:20:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 030B2759D98
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 03:20:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=lfoDNpr9;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17813-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17813-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79906306F6EE
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 01:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004191917CD;
	Wed, 15 Jul 2026 01:19:37 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013024.outbound.protection.outlook.com [40.93.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8483A371D14;
	Wed, 15 Jul 2026 01:19:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078376; cv=fail; b=aEaxr51PyZRO0DAPCECXsWFCEWSu8awFh6uWQ9PGD1G2wWqxxDRzHoC+QTuPzE2kLO65IqpIz+o76RYwUPuaemWuGEiUPfzKeSwSzk2yqRwL4d3F4NbMArc/Xe3wX3n/KyXw8Kn8pNh+bXoOXtSX3r8mL9mU5sByB/dg6XwUneU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078376; c=relaxed/simple;
	bh=IARK7PcaSAQaxdWKk5KnVFjCrDEVCzTjIIZokqOgRQE=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:References:
	 In-Reply-To:MIME-Version; b=C4MKow+NrkKvTbOt73vS1NsXmNy/dwwf3Uqv73xjnsrZ7k/uBLOsZJwRFeWpfbsYA5YChhENN6bwoazSDtRCDZuJJfFCvAYOsfSiiU//dtr/cdrL/yPS2dasYcmBpw2y/j44eX7iUG15I/MSvcDVUQgohdfT9XgnKnP8eI16UyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lfoDNpr9; arc=fail smtp.client-ip=40.93.201.24
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2si6JJ7BEMCcgFmWmwjZ8MQ9yChtnwYfXzpyGmpNAHdM07zhsKt4D4xBR42u6Z0XcM3dkahclG5gDS8qr94mb2/db3jFZQY3lCTPMeR9dArl4YxfNUe6U9FUbH/VpKPN9kkZOmS/UvMrOg6jtm1+vkNv3l97Ihh4Fq32CzdteWZeIaXx38R9Oftx0GTlIzT56jFfP6s3GK6a7pT2l5/LAK+CjLZixfjlu7lP52dI8gT4hrR/7cWWJ1/Z27S3Kk4CKmO7uQ2dH748qCpzKDU3eSTwTtj0uFzdw9YcUkJize9naYsYPWVtjIe7gg73JplHV7uSEetBnlDVRMJh8QuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0ejwsFMgRrgS/pO6xUgyYgGcplcbvABiuGH3NizbAc=;
 b=D85a1gihoal8+ex6GGgZ6HHUQTwzVj7Yog5OZ3FXITg8GeDKhygFkzhtU7a6PXm2QDSkxf5NXVLlu0l9AUZmcg6T2K+p/ViCsibPGk0sR/75ThUJSh4IYUHlTcKG4CrXGZKwFJctiPRF8dU9dU787u+r75knTPeiTuDoR6uRblwoLgSib4lwmZYRMNb7cU0N3xX/9pRAo6X94ym94p7gXxycwidAxQ0Ty1DcTOu1v/NSksZuE7KLXILwBY/A9KJ28psZASFY+7optpDsXbiPeQR+Sl0ee3/xSLoCYtjCXrXYXTxsdOaZcIh7utdwRwWpKLTB4EjMr3RMGG09ZU3r7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0ejwsFMgRrgS/pO6xUgyYgGcplcbvABiuGH3NizbAc=;
 b=lfoDNpr9W6JTMDILLQEmjLw8+/EXCwvLP7Z8M4Bi466wyYqff6ZADyKseaUL70yML7/h0Q1GCmsPkSRhPvjzljg6vaR3lu5gZMtdBY9OUW4qsTQlCVby+CUG4I7YMspQweAMOqJDvXD9/lZEMX3R6SQ3JAwviUAJ+KdZgENo0f45dOa6YsYRn5EQuKDXt5qZUqZvII7MrLwtZSukq9f5svunyotSxcVKp5VKUlMdYmrLZduD8fW6w7MpP5rdP2ud7puzhGicENimGtZ42JXFkLIvj+qQWHyHmECPp89fTKPppQXv/dg9/5oWmvGDqmh3aA16PRxbzrIw6Fq1AaL48w==
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Wed, 15 Jul
 2026 01:19:32 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 01:19:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 21:19:30 -0400
Message-Id: <DJYR00V65DBO.EAAIW26NL9ID@nvidia.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v2 3/4] mm/page_alloc: fixup alloc_pages_nolock_noprof()
 comment
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <cgroups@vger.kernel.org>, <sashiko-bot@kernel.org>
To: "Brendan Jackman" <jackmanb@google.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Waiman Long" <longman@redhat.com>, "Ridong
 Chen" <ridong.chen@linux.dev>, "Tejun Heo" <tj@kernel.org>,
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
X-Mailer: aerc 0.21.0
References: <20260714-spin-trylock-followup-v2-0-3c20ed032b14@google.com>
 <20260714-spin-trylock-followup-v2-3-3c20ed032b14@google.com>
In-Reply-To: <20260714-spin-trylock-followup-v2-3-3c20ed032b14@google.com>
X-ClientProxiedBy: MN0P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::16) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: db3dcb12-d794-4bc3-b75a-08dee20f1f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|56012099006|11063799006|4143699003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	FyClaYTsuHdkVqvJxc4EKjinONQ3TNT/QhdVk08DL3Cf00472bnojhGN4M8cI4az+Adm+iuOeOwh0gfaA5TlejP9EIPOvSpXmi/Mw9ns08Xfd/q3f68wOb/tKPcoF9M9IcenoCC4FyK95hccgDz93F0CbQFxMIxbrX/RQCh7/3wXUO69LkGvrcE1kajp1zFBTRo85On1x4RP1I0q8kamBkKocDFzW2oLeL4k3jvXWntHvOX/0QZfWMgBwgOgUdUXsaUj4wV1L97SpoUd+A1VUpI4Ff7Qa0eGd5j2iUVpJME97LOaEX451IiuGes0cJlWJ+yUxXzGCFOl3x9L1mD6b5d0UkgFzxaH5ahV27bz017M6LyQTJ4S5131rw3VAotE93YHmM5h16ZuRPhQD1xOcby9mwo8FQb4NUWCwhxFMz3EsfIczf/vMS20qr1e3O/RbU6QwOLO7nAmDSGvGfovC4VLlrm4w0J5XJOOS4B62ujzpQYCYR1oIYpu/idAlSCfFCM+sNBEstfr8ptuVGil/SyZx6bd8HGdu4IapLqVPHKNLJ+7pRBKTgpEaKneo/Vi4cPYA1Ph7KFL4I+AJ9kS/BMWDRJ9ghAx7oc5g9zSODhbqW/Izg/owchCUtGBBWSwwn5VRFo854Ofb9u6IWoPYLtdLEbIXjirH9lw57KK0Ac+vMFwU86h4xmmv+IfQKABUpX1CDlUkXI/n4n0aYbaIA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3ppang1TUxGYWYybTczWEJ2VkRzMW9pMlBSMUxVSjlWYTFxSlF4VVpSQkhv?=
 =?utf-8?B?RlZZTkR1eXFMU0xMZHpIVWRLRGxuallwejdRVHI5UEY1NUVnSTQ0Y1lJZ2Nj?=
 =?utf-8?B?Z3RVcnR4LytxQmVJM056UlBmeHdDRExEZmI2aWdOMlV3MmNzUnRZeEZDOGlK?=
 =?utf-8?B?eHg2OGR4ZzYwRjJ4UCtGbHJkZUd3ZkgrbnpEZFRmOTl2QWd2QWdnWnpET1dF?=
 =?utf-8?B?RTdwWVdjT0tNb3NQN2NLM1NoaWFIRmhUcEttMitwMmdseXJVeDNqNSs3aHVx?=
 =?utf-8?B?QStNMVhlaDBST2dpZXpqeU9XNDMyK3FqYVdRN2pHYi9BdHFlVXhiZmNzT2Rh?=
 =?utf-8?B?bG1YRTErSFBValVIR25oQ3JoUFV5Sm4wbjQ2WkQycjFpcmJTRXlmTXB3dlRj?=
 =?utf-8?B?N1QzV3FqRWh4M3NmN1F4MTBOMlVQVnV2aFp2a3dIcnp3a0VkL2NBajU1eXdo?=
 =?utf-8?B?RUIvMXRSTzMybk9lazFIdW1ER2pTME1aZ3I5VE1TVGJUZHE0S1dBQmE0WXIx?=
 =?utf-8?B?eTBpUHd4dHpTNk15emdqUVNCRGpFV0JpdHo4MDlNWTJIbktXN1J4eWZsWE13?=
 =?utf-8?B?MXJuMmZoTS8xWjY0Rk1jdUNUcGRoZUJQWlVRWTJSbDNKMi96NTBodVllbFVy?=
 =?utf-8?B?NkpRUkxYclRKelhjMDR3NWU1dWZ3ZmJDaDRCYXNMYk1VUkQxcjR3WG1LYXNE?=
 =?utf-8?B?RC9mVFh4ODJXVmZsSkIvaWJZOThjQWVYUklGUjEyKzlVV1lHcUFLVkVjdTRl?=
 =?utf-8?B?d2tOWThpV3FueHgyRnZ3OW5jcnorMHFIaWg5RXJtS3M5RU1mV2xDNEZOeVdy?=
 =?utf-8?B?R2JBZmZhMk80SWZLYno3b2lYZHdHdnc5S3ZDN2MwVFF3TTBiTFR2bFRqN1hD?=
 =?utf-8?B?NW9pdTdRU0hBdHRNcnZPMit5WFVRZ1Nxa3QrTSs1SHlvaTJ0ZW4zZHZPbTc3?=
 =?utf-8?B?YkVzSWNOdDBxYW4yYzBEYlUrVVlrNWo5K0MwN01JaWFSblZTZFJKWmc4ZEZm?=
 =?utf-8?B?d1I5aTFIelRZYlI4WEZkeUdlaHhESE81WWorNzhaUUsrd1pHbm9RSkFxYnVJ?=
 =?utf-8?B?NmZ2S0xNUFcwU0srNmlVUlJFbHBqYjQ4REQrY3JvUHRDZWQ0eE1hWUp1bTFF?=
 =?utf-8?B?a1hwbC9ZVzdZWWVsUzdqNVZVRmY5WkYxU0RWeXFTWGk3WkhxNHFYQnZEekdD?=
 =?utf-8?B?ckxmaFF1cWZtTXlrMnNvdnhCb2hBT3NGeDlHV1h6MFhVUTlOYjRIamtOVUY3?=
 =?utf-8?B?WmJGN05jK2RmUjNBNDBXVFJyZS9NS0RmajhaQVFXb0F0aTlpdXRveHI5UUlq?=
 =?utf-8?B?dVl1cXZ4TktzNVpReHYwMmVsdm9pQzVBT1U3dDU2MTRvZjZqVEFaU1JKaFND?=
 =?utf-8?B?Z1hudGZnZkZZWThIVTVhN3hXd29VaVhlKzNxUEdENVB5M0M0a0NscW96ZG5M?=
 =?utf-8?B?dXNlZEYvMk5SbzJ0M2c0VGFYSStOU01DQlVnODQxUEVYOWJ0K2cxM1UrdHhh?=
 =?utf-8?B?R002dUZNeUdXUG0xZFNVUnU5SllIaXR4bTFVRFM4bEZ0dWpsQ3NlZjNUNHVY?=
 =?utf-8?B?Z1A1UWR4WWY3MFhCdFBYRjJIRXlwdHdsZm9MMGx0UzJlSk1ITnhoZHk0YzdC?=
 =?utf-8?B?UDZiR0l6a253YU4rWmdHYjA2OVJ5TXlVNGYrZHovVnNBUGx3Q1NEcjVHRVhW?=
 =?utf-8?B?NUdybUN3YlJJMUpSM3JpTXZiYzBRWnRCb2NReFluOUNhb21lTUwyMkc1RUUz?=
 =?utf-8?B?V3VXTTZqcDdTbndQak50cCtQcUhDTGJ5bTB6SHRWM2JlRy9sc0ZpaDN5bjY2?=
 =?utf-8?B?K091WGo3MEloS0ZtT3p1UnYzbElFV1p6My9LeHlzd0JCRmRxQWs5UEtZeGVs?=
 =?utf-8?B?aFh4UDlwbEpvRVd0SElZazBycHAxb202ME43VXFtbTBjcG5oK204a2lZeUZ4?=
 =?utf-8?B?UjE3OWtzaEtpS01oeTMza3Q1WVNyU0hQZFRkM3FiMFZIbm81VTI5NmExMHJO?=
 =?utf-8?B?ZmR6cmhCeldIN21mZFZVNXEvaDYzem8wU0FQdWx5Ujl6bTNaQ2xjWjhsVVd6?=
 =?utf-8?B?Qm94cWlkMXdWdnZwcDVac2d4SWJJakFETFJPTXRGUlNINkZ4MVdzekZFaWxi?=
 =?utf-8?B?OFpMNG83eFZIc2hOTGc4M2NRNFdoTm51TXU0M2pvT0hyOXZmYzNZRVdGaWtr?=
 =?utf-8?B?SXlCRjdMWXUzdVRpdTNkU2tDNldCcC8yUDBqWDNmeExMUkhHVFdXV3VFcjJ4?=
 =?utf-8?B?cUdQTlBydEVhOER2SzMrM2FwUldCdnByRVFadG9LdUV4NHE4ZHh4VVJmTUZp?=
 =?utf-8?Q?9Q5p5268gM2DKWwBR2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3dcb12-d794-4bc3-b75a-08dee20f1f8b
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 01:19:31.6306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnsmbhMDSaKChJuMML8ma1Yqz99BHD0kBtOHtyyM26Y+cM5Qq3uph4EUJhdMmx+R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17813-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:sashiko-bot@kernel.org,m:jackmanb@google.com,m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hannes@cmpxchg.org,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:longman@redhat.com,m:ridong.chen@linux.dev,m:tj@kernel.org,m:mkoutny@suse.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ziy@nvidia.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 030B2759D98

On Tue Jul 14, 2026 at 5:32 AM EDT, Brendan Jackman wrote:
> Update the comment to reflect the recent change to allow flags in
> gfp_nolock.
>
> Reported-by: sashiko-bot@kernel.org
> Link: https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714e=
19d3@google.com

The link below points to Sashiko's comment directly. You can find the
link at the end of the title "Patch 6: ...".

Link: https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714e19=
d3%40google.com?part=3D6

> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  mm/page_alloc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>



--=20
Best Regards,
Yan, Zi


