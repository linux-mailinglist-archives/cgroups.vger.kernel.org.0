Return-Path: <cgroups+bounces-3095-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1748FB64F
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2024 16:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6091F21D09
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2024 14:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADD713957E;
	Tue,  4 Jun 2024 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sIvlgvcK"
X-Original-To: cgroups@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2140.outbound.protection.outlook.com [40.92.62.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7039C846D
	for <cgroups@vger.kernel.org>; Tue,  4 Jun 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512996; cv=fail; b=eoP8uSbnDclsIx7SG6l5GvLErZ5mWB8+T37Nazg1UTnoa9JXJL0oTKeKxYHUEaLI2IxAwFKTRVlUiCavwj8Etocq2Q4qr8/d1j/79F1Y9ZYKubhhXAEcK+kUrP4miFHkqeHkH+cVYBoE9OmbutIu5Up5VeNyzigbDW2/zDEHK5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512996; c=relaxed/simple;
	bh=YMMX/fbO1oOmbGctATb1pazQaxtuj4sxmNv98nIzk5w=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S8YGefOQzlXhV9wOPeM7uDS6DFvatpzC8YGNCQrFEgA+h5zYYhLUNm1QE1hJE9QOlnZoOwXHrxit7ai9IVASI4WyLN0PmYBWyCmuV3G0rGpAtsHswDyxs3NtlGoluCP5CpoH/qDRC33JkE6RqjHZiIRkbX5ip3ZI0FKnx6ji3Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sIvlgvcK; arc=fail smtp.client-ip=40.92.62.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCGc7rS/xEaQe1ooYH9O1WgOfMyzaMCYJxRMr1BEHT89kI46L5BknRiyZ7u5r06GifYsytQ+zy+w/Z+pvhFcb4l/PVcxGShApBfyGT8OJTcNJB9ylLd2PDnl6/MWvPkE16Csp3fAR5qVIf7cyLrRYVUZFQTNp5LjIhXIZXZkak3E+vkxvZFYGobbLlyN880x2aFqRBEaEJO01hVbi13ndtBz1vovQbPKg1neATY7jo7wyhgWEGrK/vYWMxBPHM8v3jxaxCWzSpyKRjXg/1IkSLdBd4N3Qr0F1MDfeURkmZQP0cjJ7VKejryrNTXBJBN9ZwMFzOnag356XPGR4bKGXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMMX/fbO1oOmbGctATb1pazQaxtuj4sxmNv98nIzk5w=;
 b=g4lp4T5PM9XpYQmQP4zk33o7+LBN5DYicUDRG6DJKRYJk8/wX5EVUhzXfZICspwtjd/5ckHyWQXIpTWkft8t7uUk5WxpYWhhM8+cZd7qqJbVaws3+hYi+UuLtl+oAIJKJpPL9+0eNZ9g6ZvqcpmTTlTGkko6S/wXhcHuQ0n0/TSFVV/uHnKnmyDnsrBtwYli8HIUfV8DhyJqekFwR0ZO3GCjZ4j49S3g0CB6+6Zn4T37QPvWlZ/eXGJTNrlIn4rKB2LRA4S+3O9iXlV6HVo95Y4yAFzCa4lMFFNjQ4jJ6jk9vdugug1TeMok9xIyDunyXG+DEPbPLFt/wuhcD6aDCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMMX/fbO1oOmbGctATb1pazQaxtuj4sxmNv98nIzk5w=;
 b=sIvlgvcKQoezsXEsXoxynch/MIVW8v8h2RTda1HxPyr1b9I9uKWcpALAcNdjmcPz6EVF2eV7Akjrnwuq+lzORZhitgNBViMkUJSApwW+mqUorAUKNbjm63EvqC+VPZC2ApU0eY3pf6/7vOYx8h2CDlvHa4lhwnOmFgKhbfSpyr036gc440ImHYXHVMnoe+DpV+Fszz9ffoCA5n/FX6G2i1KH9T6Q7/W39mfvPQIHPz+O7ECZOE/gUOeoRhYyVnFrNaiyJCT1G7B7hgPr24YaxB/+H2waE0HJRT0flQ0mDGg4kyHWVycFCvCDOcgCF2IDQxbBBsCTdWXEIQEASDvqSw==
Received: from SY6P282MB3155.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:162::22)
 by SY8P282MB5375.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 14:56:31 +0000
Received: from SY6P282MB3155.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6fdc:b2d5:c7ce:237f]) by SY6P282MB3155.AUSP282.PROD.OUTLOOK.COM
 ([fe80::6fdc:b2d5:c7ce:237f%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 14:56:31 +0000
From: guangya bao <bgy.cn@outlook.com>
To: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Unsubscribe cgroups
Thread-Topic: Unsubscribe cgroups
Thread-Index: AQHato9iDUQhZ/+ytUiLd6/Nqolk1w==
Date: Tue, 4 Jun 2024 14:56:31 +0000
Message-ID: <601C8DBC-F40B-4D58-B77D-AC27149C1B29@outlook.com>
Accept-Language: en-AU, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:
 [FnGX6Yy2pKMveuDyZthPOPuGpOXrOF2B5P2a6i8j4oV0zpsgK68EI2pdFtMOjztbMX4wlSm9SBw=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY6P282MB3155:EE_|SY8P282MB5375:EE_
x-ms-office365-filtering-correlation-id: 92bdb822-6303-4dfb-f61c-08dc84a68572
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|3412199016|440099019|56899024|2406899030;
x-microsoft-antispam-message-info:
 FMy7QenpvxXOS/c0CwCashDTbGKFA50zppoSZ2EfmSLhsLSVMYmJWAvsEZveDnkirgb1j15q55tlqe33u+rCOEJOSX1TC72zDBRwx1O0nVGxSN3pXaHAQzJiUjN5jGOtxOh+nNw0ke5v7KBH0aXUk8vWMqkd8azeKWJEaaUMbxOW3eSl6y5Ojn5ZoibX3V/p+OhFPj+4ainBpdBCZ+rPtq9WdqE5u7SMrTf8bSbvAaOiHZCGWA08Ui4rV9TvFgCbtGCfaAT+7Ealc3usnKLeD8r+I57gE/iE6/bClz5THHcucOURSBPk/TsOg8WVG1kXlWo84XAA3C2jNJJiGWRfXj5GnYlapzbyrN3WqIB9rJ3Iru2h2XKRWEvbgLUOqYQ43YXC/L/nSPYwiJ3ybHi2GwnNoNkJRspPPRCFo60crUsKaK3HXH5Inzef5djtXrr6razMq1zCtWeTlFzYW0CHTj7kf0xmUqqbpmcvuDkg1sqIuBO54Hh16tn0bai0a8D1CV7XoxtVVdQLg/OryzSN/nQ8PQSBdzcImYx8v+3wn4EtSKbR0zcohCVP444MHdiu
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xb/wi5jMAke+pAoTfspGcGWTn+NPvqU/xYcZ0Kro/XzSo1eHnpfw9a74KYMt?=
 =?us-ascii?Q?JgvV2rOuVeqldY2vHUVn5QsbLEVfXXwFO9crpc967dr032s+KfHUjWE62uml?=
 =?us-ascii?Q?OOMxX0gq7VS36+4hQkbVUiZVRzFF4FNewu103bJbIDCp7s0mMZXBjc+f4/e+?=
 =?us-ascii?Q?gf0AwWSfU/ABdbb+mCO+yc1t59SeKylGAHb014JYkqkLyNH33dbIFADbcepj?=
 =?us-ascii?Q?davSoOPkwiEkE94eZV105yUlEKuJRmY70rl+PnpPAfwWnJ08TFEe/s/VS1A6?=
 =?us-ascii?Q?5UVHhQ7RpjUQgRJZeXHqNjvbaoqXNnz7CiXiA1/9mwnY/bR00KVN3nzDjItm?=
 =?us-ascii?Q?oLVcgd+bNmmw2l8At8LPoo5KUoifBjAdDeFA4laBrZWSmQj7ez3+B6QDdxeg?=
 =?us-ascii?Q?wwdpIzMcZcHGljPIYdMeJfi1p0+D488HRkp7CbSfqx+aCuALfQE6WHcCUCq/?=
 =?us-ascii?Q?dAvOAv46EXSVjp9v6ObEu5tn0U5EVrz3D1buEp/sNFSHxSt4QWq4t+EK0RNK?=
 =?us-ascii?Q?DpGbpWu5C2/gTQ6bLt6aJSPV3w2TIIta5zGPlapE6ZM+klpwPCqGaXAiH+9l?=
 =?us-ascii?Q?YBxH1sb9tIHkFaXrBSAep8ZwzCf7snW1FzNxxXaa+17KETPNlUPSmrWo5Rwm?=
 =?us-ascii?Q?nb8wk7C+3wwmAQ++ca7iuKXrdUQXX6U9j29+YpBHWY+DkV19v7xMuxFXEkk5?=
 =?us-ascii?Q?c3h385jVFKCtU6MX8bgdnzp3N6AXM+eifua+4qZIFEIKDG8TxojaGAufFvIl?=
 =?us-ascii?Q?57oQ8v+SyPrVTDXl1BMslWQXa1BKKiAObQIutBs2HdSSEen/tzUu97OBbXPp?=
 =?us-ascii?Q?HzzXLO8IlzSEfrNCqlVsFw7aMMGMbZGzdvoW18namHUq/VqarN1yraUKPUYr?=
 =?us-ascii?Q?UoqDLc/iuFnLWAYPqk5+J6tREY83m3vx99EkSadlJmn6cnqkdnDZxOtF3fAQ?=
 =?us-ascii?Q?LgzquoM4VjH3lmeVZ3GP75ob8cwfou5j/POpthdE26xo25CmBWpY+Ffoc0xu?=
 =?us-ascii?Q?51cFF3CsiJwLnLk2IwYVNKXYg6pqbF/muRlaonTEI/grKastpUmF/gMnERHw?=
 =?us-ascii?Q?l12MNK0C/mU29K8e8ZfA2pl6L6X7/TDl6kMpOBol/3BRIS4b/W+wMlGK7h+l?=
 =?us-ascii?Q?V2AlciFNI5Iychinf5U57AQobs0C/g/djalR9uO2g2nUx82YDa6cI89fZEKk?=
 =?us-ascii?Q?itauzi/K8apj61glSFSENx4JtEZ0k/lmPTJkfZxbOv2bVWD1EdwkidLuzZrl?=
 =?us-ascii?Q?PLvFHJ4WTEBQ2GT1mtSffI7GnGcASmQV71msgofiO8umnkL28W4HaxLjUmsM?=
 =?us-ascii?Q?TRM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6C65AE858C98644CAE9E29BC625F0804@AUSP282.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY6P282MB3155.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bdb822-6303-4dfb-f61c-08dc84a68572
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 14:56:31.7961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P282MB5375

Unsubscribe cgroups

