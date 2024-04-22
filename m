Return-Path: <cgroups+bounces-2644-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4098AC28E
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 03:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39CA0B20A87
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 01:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2213517C8;
	Mon, 22 Apr 2024 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="d2RHM/wW"
X-Original-To: cgroups@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010000.outbound.protection.outlook.com [52.101.128.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CF72579;
	Mon, 22 Apr 2024 01:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713749869; cv=fail; b=k4uvek7CJmNSFYQe2HsTq2Ua+mu12/kFlJbsgt5bBuiBLSj8fq1rVaOKFp61OarhnNOg5petqXLphL3nMnpbOSgyE3m880xcxYbyHcTgqkRH+tVM0ldhtZ/FSKdql11qWibFDANkLYkhhYfk3GseQ5dv/ympdrJ8FncpJcEiLFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713749869; c=relaxed/simple;
	bh=LlSYaVeR/cNhoM9/JCk3z4XyQvMK3cCNHok05YTwiy8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DrHDhzFKbO9fnUaLLqU4980OjtZU/uGjDyZxgDByDp5j9vfkQGtQn0O6LirzrQ+1Jx/CmEySgFu4t+rBYyJ5L9h7Zsk+3yAqABHpm5fj8Ycc1wAz8H+zcHS5dIdySDeCyOwYhONJFzgi6vVWZGe/8i3QTupZuF0sDZl7pYrVvH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=d2RHM/wW; arc=fail smtp.client-ip=52.101.128.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehVKtO5RTK9jBRBP4wsE4d/qfAwF86zaEOHaMdPhA4/pF0N5jIDF8xlMoTFrgrVuhZdBqwFda1YtrSqNIRbVDuQlYh4uBwUI4tKhBkjfcnECl/nhBUfS8amNBufLPJtQ62muLYeEwRPH0mgzE3ekDQZBkVG0OVm0/D4DRyWynOWJ2/yGA8mDd6BEoBCFaYaESa9ockRoVbnG10JXjPy9J9NPFiWFqyvWHDfoXnLDsxhwYVAzcQzoxESw7ak6mh3XGevEz+yUoT/K42o4X58FekZ6Pr+9PjuTUlZccEmIgmLana2Tz+r1Q/OQ4rfSxp2FI5e7pWk2DR2Oa9mv9aLOTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlSYaVeR/cNhoM9/JCk3z4XyQvMK3cCNHok05YTwiy8=;
 b=GDr4mYKpbUkThWuhcDhgsNGtxrgi/xJBEqm0Qx1aXAP1xYMT1kiPg67AA+9l+EhI2oTMeQsXvov5Ak15zx2yRryR1mcOR4KvLEtonUgqltWLXJ+26TFzfBljvl1hURSoFtaXH7IBmg7iquKqwLjueO1o/1Z93QMrmC9Is6L8auxt13plPom8DhbpthyNUF+GDeMQTSpT3pySADbf+WHWYUPhVc5cDBFM++WobRIizakorCqji/zYIcyZo3WdoU3FwPjkMfLgfPElC7oDv/YFXBNXBj2h/kEtqQ1h9K2dETcSdtXLw26R3UxdfO/Co0Ga+wkwkqUQeutiTHT80GE5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlSYaVeR/cNhoM9/JCk3z4XyQvMK3cCNHok05YTwiy8=;
 b=d2RHM/wWq5OnaQqpj+8oX8+JFN4SBacIAtWMVOunjJx4PLsG/ZtSy726y2KvnYjVuEXtOn0R3NbEzmXW7fTKTWrMj4EfpvlNjkDzx0XNJ6SxgC5ip8+Gtd016cPXhsH4txt6htngZ7ZSpcpgYHnlQH8XrHlgeCBGQyJy0FLKoIzsWqCn28oA7/VlOJ6v30z1a8CcO/J62+s6qdNbF9PGRjO00EHzHiV15wFqwXhEnf/PTsgEiFxaA77Wz90YdTeaF52kDv1zYYNb3FKVri9iCyOLx7n8xdPxRjaHUpi6X+IGcNSf4RlxixbcwbFtSGGx8+hsC4lS/67bfFNjy+t6wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SI2PR06MB5172.apcprd06.prod.outlook.com (2603:1096:4:1bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 01:37:43 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::ad3:f48a:aa04:e11a]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::ad3:f48a:aa04:e11a%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 01:37:42 +0000
Message-ID: <252d97c9-4d47-413c-bc42-67499df25987@vivo.com>
Date: Mon, 22 Apr 2024 09:37:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: make cgroups info more readable
To: xiujianfeng <xiujianfeng@huawei.com>, Huan Yang <link@vivo.com>,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240409021826.1171921-1-link@vivo.com>
 <9d01ab99-bbfd-536b-a375-9c44f988aa9a@huawei.com>
 <945d1e73-21f6-4a56-81ee-9625491f3b26@vivo.com>
 <a7205c3c-4abe-fb43-9c18-976e22bb226e@huawei.com>
From: Huan Yang <11133793@vivo.com>
In-Reply-To: <a7205c3c-4abe-fb43-9c18-976e22bb226e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SI2PR06MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f6a209-8530-4f34-d6b2-08dc626ccd43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXZuNnozQ2VjUkRBYm9kSTBtRTRiWnZtOFpwU2dDZ2ptTlNORW1DNmEyTHNp?=
 =?utf-8?B?MVRHc3JvN09HTm83Z3pkQUU5U3czU3NybEtMYjZtamFuYjhTL01ZTkFSenJL?=
 =?utf-8?B?SUpucGpXQU1RVjJYbUZFNUJ5MHEzWERsVXNGcElxNlhZMEIrRUtzWkVBcGNZ?=
 =?utf-8?B?YlJjRU1FN0JsQTQxVHBMYTBBbHo1Nm1WdldWRzFLNEZUR0pwck9CRHRSak15?=
 =?utf-8?B?NnZ5OWZzMExtTGxONVB3V2dBNTd2R2wvcGd6Y0lzSG5wVnJBdEpnaWE5ekEr?=
 =?utf-8?B?TVdkaWQya3ZrdzJTakxFbkJrTFJ0K0liTUpqa3VXZDZaNGFpaUpLRW1tS1ls?=
 =?utf-8?B?YlJYak9BaDZqK09rUitCZnplVFFBNWlsaUpVYUFHSDhXSkV1aHkzVGRaWDBI?=
 =?utf-8?B?Vk1oRmZmdFk4QmFucjJYby9Kb0NOazhjVGJUcnpNZUcrc1dBcTkvNE5uVGJG?=
 =?utf-8?B?Viswam9OeUVubnVuR3pxVTNsNTJYSmdBSlNJYmlqWFhlSEFVU0VFSzdWb1l2?=
 =?utf-8?B?dzIwVldET3ZYWThCeUdocStlY1oxMDFLOHU1SUdyV1lzRFZyRWxMeW9UQmpa?=
 =?utf-8?B?UUVNMTBzbmd5RysrMW93MVdtVXJXc1FLaW1iK2UxRGIxR1dVdDhPS2JjTXda?=
 =?utf-8?B?eEFxNUtpVXE3OXpCbEVCLzZtM3RWTUhWWERzZk8rNjcva2dhOEd1SUt1aFBC?=
 =?utf-8?B?MER1T25lVURES0gxcXNPaTBPVEc4T0RHamJxQVRtODZtRHFjZ2FlMHhGenRi?=
 =?utf-8?B?ZHZSUzhmNFozUVpEUEhLeHRIU25QaWd2N25neTFPNStTQUNERng2bTBCT0Vu?=
 =?utf-8?B?QXhWeVhzV096Zi9zWXZtOHBvSUdSSThjSXFRTXNHSXNlU2JHSm1JYkRPU2tn?=
 =?utf-8?B?TkhST2FTemRHb1cvRjhoMVFrQ0hvVVFWTzZVTVRuRXZ4dytLbHRtOXI4RFZl?=
 =?utf-8?B?QmtSZmRxbzdjNGY4NzhGc0hFMm9ieUJ4bFd0aS9LWkdranh3dkxCNm9HalR6?=
 =?utf-8?B?Mkt4OVFBQmJNOXhSa2hzckM0VVpYZUVCbTdiK053MGQxK0hTaFhqYlY0QlJY?=
 =?utf-8?B?MTlMQjRtSDU1YWFIMGw2Ukt5a3BrbFRHMTZJbmJyM2NkWWZTV29DaWNHSGNw?=
 =?utf-8?B?T0laU0FaZ0pYMWY1WlZ6NmNqczF3cDMybkFNRzZLN0RPZnlUMkVEcVB2Ni9j?=
 =?utf-8?B?RWVuYmI4QVRRUHpvNDdzZzNOalQrMjBuNVBBRXhBZ0N6QXNTZEdkWlRTZlFU?=
 =?utf-8?B?SklaYTY3VDZKeWlUcmVZTHpMdlNZM1A2VkdvTGtvamFIUENmemNqSnJMeEhM?=
 =?utf-8?B?MmhQK3BDcTBTM1hqdEpaaHJraFVDZ010dUlzUnF5Z2o1U2VjVVFNazkreGs0?=
 =?utf-8?B?S3B5alJYUmxFSGRmUkY4aEdkQkNZbTdVSlRqOWF1V210d2xYS2hCVUJlMFhH?=
 =?utf-8?B?VWdDdlJzbGx4Uk9PbzY4dTRJT2NrTjdMdllQREs1N3NxTmx5bmpkZVc3VEs1?=
 =?utf-8?B?QkgzOVErT0cxOWJBN0VUcE9sT3A0R3lzOGtwV3RvZFJDRWJXejdqUVNYMUdG?=
 =?utf-8?B?akxJOXVGUEhIdVlJU204SnY2U25qNzdYYnhGTTZ0MHJpZ2dPNXhMeEQ2eXVa?=
 =?utf-8?B?M2gyTGhHYUswcjlJUkhFWFJvSlRVOFJ4MVRHd0FOSjZoamJTSUxGeS9kM3Br?=
 =?utf-8?B?R0wxbXdOQy96alc2MVNhWnJmSEgramY4UDIrL1RHUjZ1NHJDR1N0bmd5b2N2?=
 =?utf-8?B?eGpndy9SZ2pOZGNUYXRTK2JPcW9XVkxpY1RaYzBxSDNEL2U3YkZKc09sQTU2?=
 =?utf-8?Q?XJBbUpG93hMI9V6h8ASAkzy26JsILyxy+F4jc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(52116005)(376005)(38350700005)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0dqT0h4YUZ2UlVrQkJEVkRGbVJFaUpPY2Q0MWhvczlqSzN6L3BKZXlYS3Nm?=
 =?utf-8?B?bnFVYmRxdmxxWEJOVytGeWx4RGxmRHFxUWQ1TWxKUkI1K3FHNyt6OExiQlRv?=
 =?utf-8?B?V2hTWHRjSWVqcFBXRDBXM05sMzVyODRXU0U4OFVlamZOUUJtdGNLUDJPUEp4?=
 =?utf-8?B?dmpBSWMvei9aLzFSYTUzZUhlM0ZUdFhFSno4djkyemJSNkNibDZkd1FNUmpx?=
 =?utf-8?B?MW8vR2RtUGM1dGp6VWtSQ0RlOWFIK2JYbjBJNG1aK0M2VHM4NHRvTkd2Rzdt?=
 =?utf-8?B?OXArb1hSdHdOZ3RtYWt4WWoycU9lZUx0RXNOMml6QzRteFBLL3IyT3I3eStN?=
 =?utf-8?B?L05sOHlGREsva3NGWG9pRERKdU0xOUpneG5vbXJBbEcvYStsdG1lM0w4OHQy?=
 =?utf-8?B?bUtsWmFvejdMckdNMFRwcDVuQktDaENNL3FHMW54UENaR2tDTnJnSWl6WFpm?=
 =?utf-8?B?ejFVWmw3UHNVd2Nlb1paVHBON2kwV0FYUGZCVUZEci85S1I0bVAyZ2RRYXVZ?=
 =?utf-8?B?cGVIL011SkFoVkdQdCtYWGROR3hIclNjcEw0K2lDMThMVFNEQmVZb2ZZakwr?=
 =?utf-8?B?empmZ3VJRm4wRVdhYzk1MFQ1S2tOT2NXbmgzamZJRDJqNVlwVjI1UExhMmI1?=
 =?utf-8?B?MjgxWWRQcldJbUhsZEk5YklaaWZVL1Z4S04yaWdlVEZmSHRYZm5pby84eU9o?=
 =?utf-8?B?L0M5L2MxUDNweFlCQzVYamdIaXlWN1M5K2pqRlI2VnI1SXFtRFJqTUJXNTZk?=
 =?utf-8?B?UURJd0tZRFJuazNvcTBySXNHWVRZSlA3cmpjWmhZV2I3dUlQS0dLall5U2FL?=
 =?utf-8?B?L1hVY3N6WWxtR21Nc2RoTEhVOU1kQmpTMlJOelVhSEsyaDVaei9neVB5MlBN?=
 =?utf-8?B?Y2tYQWZkRm4veksvZTQvUXVlZkVZZGR3WE9MSzh5NmNud2VJcDg4ZlQ5aWls?=
 =?utf-8?B?NEdHVkRXVVcvNWdiclgwZ1Fyeklkc0Q1SlB0QU0vbFhFbkwvd1ErdUhqUFBQ?=
 =?utf-8?B?YUxNQWhDakU5aHY4aXRnVTdmbEg0RzJLZU43WG9UWTVBbm9pdGdyQ3ovM25U?=
 =?utf-8?B?QWhTZy9RQTJBUHpWNVUwWGhwQTBpM2wxRmtYVUY1c0o3Mm5vSTM2eVlOVi90?=
 =?utf-8?B?TXh6c21tVDV5dmlrVU8rL3B5OHVoM0RkbFlwV3YzV1NhT294dTd6TWNtUVo4?=
 =?utf-8?B?cURPMHVOYXVnRGFPdWFDT0hxRGdLVy9rZnBSb1ZtQUxjTm5QdXlWYjlwTStD?=
 =?utf-8?B?dTE2OWFmQU85RDE4L1REWjJaWEJFUHU5RU9QSklmYU1HS1lEWEpESUpwVTY0?=
 =?utf-8?B?UHBYdmJmdzdZb1B0WGxFTEFBTEtmMGhaK2srdkhGK2gwVDZOQnZsSGRXdWla?=
 =?utf-8?B?dmlWT0hTOTFLUE5vQ1o2b1BSQWpWaFN1QytNUjE0NWNjM3NrZWlham5YekVs?=
 =?utf-8?B?aE9DN3VwVGU1R0pUb01wb3JFaFNxSytlQ3Q2THQyVm1nZVdLOTAxWnhaVUYz?=
 =?utf-8?B?ajhJS1dlWWdJUEtXSEZOYUo1R0xvYXBUWURnTmFmKy9TUWh1cTVseS9WRFpE?=
 =?utf-8?B?M3o1NnhsYTI2STVoeC96L2dIR0xQNFFDMGYvdXFLNGRFait3cUp3a2Z5Z2RT?=
 =?utf-8?B?RW9RVVpRRU1kUE1jK2RROTg4K0JPM3E0a3FLanFOcW9IZm8xNUVLb1R4NXpJ?=
 =?utf-8?B?S1lES0VPcmFHZ1RhcEtUT3BYVk0xUmZrTXNLNUlyelAwNnNrRVNScW8vWFhk?=
 =?utf-8?B?dGVBbmJrNXF1bncrSFk1bVM0Nk1nZ2hTOXcydkZzN1RrUEtVUER5bGJhVmdl?=
 =?utf-8?B?NkcraXNNOElYUks3cHN5MmY4b0lNS1hDZ3BUVktTVUxmQUVYM29aaG1scTB1?=
 =?utf-8?B?VlBxK1RjcFFnenNDbUI2eVRSMjAvVWVWUWRhd1VkRk1scUp6a1gxYzQ1Qlpz?=
 =?utf-8?B?TUh6d1lEWStReXE4SjY4eDlmZlU1ckNqNjRsRDBGUFBmaDlkYkNUbktQRzRt?=
 =?utf-8?B?dHBZczk5SUorVUNnVDNnTWlGSlYrSnpqYlhwZE9tMFFEdVliZVpvakdEaUl3?=
 =?utf-8?B?ZkR6WU9TRjl4OGh1SURJU3JXMTRvdDcyYUdXY29HbGpBeElveENiQzVBL29P?=
 =?utf-8?Q?Kx59MoXvIfOmJEgMN22PIy8lB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f6a209-8530-4f34-d6b2-08dc626ccd43
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 01:37:42.1193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDJ3mHnLsbLVUFJvfPkRnNHL1ZHg8yKf+jGBlZzgxFrpsb6F531+zy1vjdjgOyNhyPrGQFBRRgjB+IKEA9ekfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5172


在 2024/4/20 10:47, xiujianfeng 写道:
> However, I don’t think this is the right way. Even though the
> information shown by /proc/cgroups doesn’t seem as useful for cgroup2 as
> for cgroup1 due to cgroup2 has only single hierarchy, it’s not entirely
OK, thanks for your reply
> useless, IMHO.

