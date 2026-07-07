Return-Path: <cgroups+bounces-17563-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YDiuNRtATWptxQEAu9opvQ
	(envelope-from <cgroups+bounces-17563-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 20:06:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D13DA71E7AD
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 20:06:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=JcVxcm4f;
	dmarc=pass (policy=quarantine) header.from=amd.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17563-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17563-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 09BD430091D3
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2026 18:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99D943B6E9;
	Tue,  7 Jul 2026 18:06:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A311231987D;
	Tue,  7 Jul 2026 18:06:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783447571; cv=fail; b=jvHQV22WSPKirBo2HTxa+AfxYenVt8kSU0Omxv2eBDwurX0Buw/BbZBN156kHoJPrti0lgKhDP6EnWwxrSiscnrJB+6s4+hyvGqtr27mlC3QGlKsGWJOV2XrSX5pRUiOmJT+DYho31KnyHch6GmYMFuvbSC+HvBdeJIYOmMqcp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783447571; c=relaxed/simple;
	bh=aqqtH58T6+kX3JWrMkQfWn3MxDyC0EDTbySkXT5a4tE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DjplWCbxArFtTWisz+81ujHOiQqsChA1ffdu1shR5VtdHdTiJxfWdorAyR6SPrtDAIBUncvmle6eAozk4JsSJx/fWDUkt1j4scV2zP816E+ZXYc/CeSMiLc3JvjQpdnOwZioI9tiH0k0gMq+C/DbBqqtXHVsqd9rwoQs2OcCKs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JcVxcm4f; arc=fail smtp.client-ip=52.101.62.70
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rs03I55BnEeQJ/63qLbNR3+iyMUQxuF2i/39jbXld2Q0AiAINpdRvlxKMxWJxtA4UTsUaM2Ndwi7ESXxfcM3R9knRdOtFCPzC4z2Mgd7jD5pj7Lsktc8VICZKjNSdDY0W5BAXqsiha2fsniDmWyjoO9/o0OstRD1Y3D3qJSZbiyXvjn4BKsfNwYaUrnkD+0IV/Xe2spqzxRQ0C1l2Z3+XE//uoXPyxtDpz2rj/S5cKTA9iIuq6Y3d/MQmLUEvNfxA1xrkANSv8F1Axej8mACl36olEEuVVj2Ge0fZCM6ynqA53By1sp4JVqXlNp45sphoSJJuQDOF85C9IvdjbKKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DV9QgixgGJnct6ZGQhlxnA1riKOLAEdR6ycjknjIwk=;
 b=rF95YC8QJxbpGE0qCwwVspDbfwK+O1M9RXBhx0gXIY30x5gfXM38XrsKwRT2U4uQwIpY5nCGoWKLPQBSQd2qpQiADnDYr8QwTQn27sh+2oBSnHyuZt1pan72a+vbZYyPZjgg3obePK35gzMy7vfrOvJxY1LYtKoJRxGq6v7zzyvF6y+j1iDTn8KoLvZAksr3fdLFV4eNqLCu5lmfRuXZsL4wuEsxR/JSuO6RVCJGjvdfRnwhalrnoMeYK9X9awg6l58YbZOV9qwkZSXujf1bcUVf8yiSbEBsj3WI6uZjKchJc1XFS1ZpaJ8gXfocAlXXxPSiwhzePJ8OvyHkacrMGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DV9QgixgGJnct6ZGQhlxnA1riKOLAEdR6ycjknjIwk=;
 b=JcVxcm4fDw2HcYZu4FuXPbJ9PYE8E+VC/Hp0TH/BSeUqC2pBqxyEAcdsKhr5dgjifA+edA0cOfm+cY+nOTxQv3TRWPG1bhr3jQCyKMMzdRmGq1T/oKELDyexI1xj61/o+Vg9+UwKTFzbT5KxZ3oIVCScGfyx2/F6/MVDZDiQZrg=
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 18:06:01 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%3]) with mapi id 15.21.0159.015; Tue, 7 Jul 2026
 18:06:01 +0000
Message-ID: <9c8b4367-c029-4731-8ea8-b8263e11ada1@amd.com>
Date: Tue, 7 Jul 2026 23:35:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/6] drm/amdgpu: Fix init ordering in
 amdgpu_vram_mgr_init()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Sashiko-bot <sashiko-bot@kernel.org>,
 Friedrich Vock <friedrich.vock@gmx.de>, Maarten Lankhorst
 <dev@lankhorst.se>, Tejun Heo <tj@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 Huang Rui <ray.huang@amd.com>, Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-kernel@vger.kernel.org
References: <20260703130541.2686-1-thomas.hellstrom@linux.intel.com>
 <20260703130541.2686-2-thomas.hellstrom@linux.intel.com>
 <9eae1a5c-d2ef-4d75-a581-58299ca37a1f@amd.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <9eae1a5c-d2ef-4d75-a581-58299ca37a1f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0051.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::8) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e68940-b02a-4da3-666f-08dedc526719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	+3E3fQqn6lD7wdGfgeN+sD33bzFP5EtcXa72j+hENQG2cpmW8gW1DL0SvSLQvKdCIFOGu70N29Qf8IAD3oR9jj7KsJ9N2sIXALkwOuxqQdE7t7+feVUghu+h0e63TvtJYujp0I75NqSkRN0QCNun3lkvYflO4xRH+o2LEOokeH4FeuusB/SyZMGk3fRWKCdpQ5s7Os7atte+P0h78p3nGk5rVrOrVYk6pPx0/6NooCoJeWFyd2bJAvTcmEs+ixjuq0GLbya7hTJPWqSRgBoiI4sHdpOu4el3i9KfjVpb/0KztBqpX5bnbyXly5rCZerZqve2QkoTOdtCmn0kZCvh8+RIl2IjgakJVohjGDV96z4enXvD/VxiK4CzUf9ttdt+/FUf91wHrQGzYY6GmI9AqGU8FhxACrAdGh6nm1I9oVtwMI22iT15QSMPoP7Jw8E3bLUQ0l1zsOgeAwQtIAxF8uz6tpoEKE2okCKPpWLKGntsLEnUQM+Eo2N3I6ik0e17SIT/2Sx//3GGOwg0CCxhWw1s6MyR1+CaQrVRboY7AagAdD8sbn2r5i+x60Yz2dqhiV9tTrZZ6+x81l4okK31s4p8cjOlVzWZzz+ca3dCcPk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5039.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVN5OUd0aFlzQWtyMjEvWlVjQ2VUS25hdFlyNTVjdTJSK0MreTltTDgwczZp?=
 =?utf-8?B?dXdFWFIrczJ1aUNjaXd5WjN5WCtJQy9yTWlrZUg0TE4rRzBzdnBPVWRSYUVp?=
 =?utf-8?B?TC9mdFNhTS9BYXdnTFBxQUswcTlFNmZvMlhVKyt6cTNyOFd3ODdaY0ZvQS8z?=
 =?utf-8?B?UHFWLytiQjZTdURSZnc0T1BPQThnMDU4RUFIWXQyVS9EWWJnOVhJR2NpNXF1?=
 =?utf-8?B?cVlvSnRtVmQyVU9XT21HcHVFYWVkeitlSWRzdkFUNHdndk1UczJobGFnMEND?=
 =?utf-8?B?OHhUTWozOG9COTVzTHBwZ0VHZ1c5bVhaMk1Oa2RNWkVtbytpNFBlNzN4Mit6?=
 =?utf-8?B?KzBTMUJFREtXa0doTHVCZmRNcVczRHVlZ0Q2cmx6Mi9jcENxZGc3Y1FZOGJs?=
 =?utf-8?B?QWFVR1lET01yWCtFMllEVll2eW9RRnlLVUducENLdHlmWnk1VGNKWXFJN1Rj?=
 =?utf-8?B?d1hCZ3h1WjBvVTArbTYvMExYdmNBUGIyNy9CQ3h6VGo3WUtxbjdMRGM5djYy?=
 =?utf-8?B?dDU1MTI2aFhvQkxicjZYbVdvemdJOUFzZXZtdjNYZ0J0a2hnZTNISWVkY1Nv?=
 =?utf-8?B?L2xJMWF5RmU0UGNnVW5UVUp2YnBmSlFkQnNMRnIxcUlDTEVkL0FLWlJHOENm?=
 =?utf-8?B?Nk1ibmV5amdTZjhwM20zS20zUXZFTEpYT0VWam5pMDBNUDFOQ082SzdQbERy?=
 =?utf-8?B?eW5WT256MGNudWkrSE9UYU1VWE44MjNTdEdxclU5RVZENVdzL0MyUG45dHUy?=
 =?utf-8?B?Q05FUzFSOHdJUHI4dHhBdG1Iam01ZU50ekhYb0NUTkhQclJwdklPbU01eXhQ?=
 =?utf-8?B?cjZRUCtHTXdqUzd0cks5UnY2REhXZWNNMmRBK3p5YXRILzRyK2Q0RmptYkFy?=
 =?utf-8?B?L3pvdTN3c3d1amd1Y0thRUZ1YjhNVW1KaTh5RzJjSTlCWUV0N1lGbTNnQUR2?=
 =?utf-8?B?MWpaeXpsWDJhVy9BKzIvRjZqUGVMa09PM0pvRzBnUWtEdFQyUTJncTFuZnlq?=
 =?utf-8?B?c0tXN0t2ZWhWVDAvN3RUd0pWYVE3UjN2QXFQV2VsOHUrYmMzODlyTysyMDhr?=
 =?utf-8?B?dE5KcVgzeUhGakFKM1kwbTJjNjJuZHM0UVhLV1FPQkg0OXplczVlMVhSUFFq?=
 =?utf-8?B?eFpWZFo2c2hCbkhIWjNpbkJCTmNsYXVrOUIvNVFMaXBQaTg0blBqd2tJVU53?=
 =?utf-8?B?aFNCdU5XSUZtdnJ4RnJjSS9RRjdvd2YzbmNZVlFkRysxcnRiSE1Pc1g5UmNi?=
 =?utf-8?B?TTNNMjgzeS9zNGVvUURUeVNnTmdHQjRiNGMrZzdGTHJweW0zeGd0Z3VhYUl4?=
 =?utf-8?B?M1FwVkxmbVEvYkIwdjRaM0hobXpYQUY4UHNKQXF3VVZNanA5aGhHSUl6NUtS?=
 =?utf-8?B?L1RhM21heXBnMWR2aWpZSTl2WnFEYVV4WjN6QUNSVGp1Zy92dHJ2bnBIZ3lh?=
 =?utf-8?B?VGJPdHpkbzM0TnR4SDFiSEQ4Z1Z1bTd4bWJMWllWNFRlU2R6ZmFPL21KQTVG?=
 =?utf-8?B?ZmdDanZrT2ZGTnhTNUM3YjlDZHVTcXBsSk9qQmhxbjJCb1YvTG9WRExkUkdm?=
 =?utf-8?B?N3JHdkNrR3c4M1FKNHZzbUp6YXZFRXRzS0pzZzFlaTc3OXJHRE5KL3FqalBu?=
 =?utf-8?B?UFJEd2ZhMG02LytDOWxDUVlYRlUvTmZGcHBPTHoxVmV5SWExeEtSTHlXZ240?=
 =?utf-8?B?YTh3MVppTVhpeDR2Vkk3MnBWRDlnWWlVK0FUWDFmMldYY29Gb2RqemFKSStl?=
 =?utf-8?B?UlRseTBkV3NVVUd1b2JFNTNNaytFRVhadXplcEVsQnZJd3M3TS9ZQkhndXh6?=
 =?utf-8?B?RjNGeGYvUG1Ta0wyUnMwOXMyS1dDRXg3VVhtWmtCL29PQU56REhyY3BwS0FE?=
 =?utf-8?B?VWlobzRtVHk5dTJxUzRQcU02bEJjd2VyV2ZCenQ2YVh1cjN6bUZScFNSUHpB?=
 =?utf-8?B?K205bFJKdHdpVEtCd2QvdEZMaDRGY0VQb3NDMzRtdlhXeUVYS3IzRTJtVnJD?=
 =?utf-8?B?bjhjMk5TbWNwK2FSbDBidTRKZTlCeUtxTkM0M2VzVElWK0tvdzd6MGlEVkJh?=
 =?utf-8?B?NnZhR3Yxd2orcXdQZ2pVcE9jSGFvTU54S2lzZ2ZYc25iT3cwN0FjNG9SS1Ew?=
 =?utf-8?B?cmMyQUdEZ0plSnhHWEI5U1hHSXMxUXRXeTRqd01GaExrdTJtcmNTQ0p0VWwr?=
 =?utf-8?B?YjNyemZpaysrQVZEbjlhR0NnU1NrMDk3Y3NQMlliWWVIREJ1dm02MTlNR1lE?=
 =?utf-8?B?bGQvWTdQT2NIMVBCMzNxQjBjMWcxQldBRm5wVml0Ui9LT2pxMlZyV1JpMzIy?=
 =?utf-8?B?NW56TXI1b0ZwY3pmMjcvenJTemIzV1lTT2dMaFcyYklOVW5Ebm9nUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e68940-b02a-4da3-666f-08dedc526719
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 18:06:01.1760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HWtbM/zxRrjWtGuprl94nTxAAPlscQjYOYT5HjTCDbiFORb0+hTCI5EL1EzSrAme5GJx0FpObtTzl/AT2UWwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17563-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:christian.koenig@amd.com,m:thomas.hellstrom@linux.intel.com,m:intel-xe@lists.freedesktop.org,m:sashiko-bot@kernel.org,m:friedrich.vock@gmx.de,m:dev@lankhorst.se,m:tj@kernel.org,m:mripard@kernel.org,m:alexander.deucher@amd.com,m:amd-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:stable@vger.kernel.org,m:natalie.vock@gmx.de,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:ray.huang@amd.com,m:matthew.brost@intel.com,m:matthew.auld@intel.com,m:maarten.lankhorst@linux.intel.com,m:tzimmermann@suse.de,m:simona@ffwll.ch,m:airlied@gmail.com,m:cascardo@igalia.com,m:rodrigo.vivi@intel.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[arunpravin.paneerselvam@amd.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,lankhorst.se,amd.com,lists.freedesktop.org,vger.kernel.org,cmpxchg.org,suse.com,intel.com,linux.intel.com,suse.de,ffwll.ch,gmail.com,igalia.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arunpravin.paneerselvam@amd.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D13DA71E7AD



On 7/3/2026 6:38 PM, Christian König wrote:
> Arun please take a look at this.
Sure Christian. This fix looks correct to me.
Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Thanks,
Arun.
>
> Thanks,
> Christian.
>
> On 7/3/26 15:05, Thomas Hellström wrote:
>> drmm_cgroup_register_region() is called before INIT_LIST_HEAD() and
>> gpu_buddy_init() in amdgpu_vram_mgr_init(). If it fails, the function
>> returns early and bypasses those initializations.
>>
>> Since adev->mman.initialized is set to true before amdgpu_vram_mgr_init()
>> is called, a failure triggers amdgpu_ttm_fini(), which calls
>> amdgpu_vram_mgr_fini(), which then:
>>
>>   - Calls list_for_each_entry_safe() on reservations_pending and
>>     reserved_pages, whose list_head::next pointers are zero-initialized
>>     (NULL). The loop does not recognize them as empty and dereferences NULL.
>>
>>   - Calls gpu_buddy_fini(), which iterates free_trees[] unconditionally
>>     via for_each_free_tree(). Since mm->free_trees is NULL
>>     (never allocated), this dereferences NULL.
>>
>> Both result in a kernel panic on the module load error path.
>>
>> Fix by moving drmm_cgroup_register_region() to after the list and buddy
>> allocator are fully initialized, so the teardown path is safe to run.
>>
>> Reported-by: Sashiko-bot <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/patchset/20260428073116.15687-1-thomas.hellstrom@linux.intel.com?part=4
>> Fixes: 2b624a2c1865 ("drm/ttm: Handle cgroup based eviction in TTM")
>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>> Cc: Maarten Lankhorst <dev@lankhorst.se>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Maxime Ripard <mripard@kernel.org>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: <stable@vger.kernel.org> # v6.14+
>> Assisted-by: GitHub_Copilot:claude-sonnet-4.6
>> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index 2a241a5b12c4..ac3f71d77140 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -918,9 +918,6 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>>   	struct ttm_resource_manager *man = &mgr->manager;
>>   	int err;
>>   
>> -	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev->gmc.real_vram_size);
>> -	if (IS_ERR(man->cg))
>> -		return PTR_ERR(man->cg);
>>   	ttm_resource_manager_init(man, &adev->mman.bdev,
>>   				  adev->gmc.real_vram_size);
>>   
>> @@ -935,6 +932,10 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>>   	if (err)
>>   		return err;
>>   
>> +	man->cg = drmm_cgroup_register_region(adev_to_drm(adev), "vram", adev->gmc.real_vram_size);
>> +	if (IS_ERR(man->cg))
>> +		return PTR_ERR(man->cg);
>> +
>>   	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
>>   	ttm_resource_manager_set_used(man, true);
>>   	return 0;


