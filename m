Return-Path: <cgroups+bounces-2226-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF6088FED7
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 13:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311BC1F268D0
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 12:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF817E76D;
	Thu, 28 Mar 2024 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cZmC3IVO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="t/XFWuMg"
X-Original-To: cgroups@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B1405FF;
	Thu, 28 Mar 2024 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711628473; cv=fail; b=KPYhpt6d3mkjRDKXMJNUfPiVL6Y5XkrXmhPUGcFVXiN7ktzPqGFy7C2g8yI7CgDsM427vrdTEdo+MdC/o3WmrTn7wQVV6CI9Cwz0lHAz/S2XmNfRSKoVOQ6Kg++ZyRKEXSmxr+XilZYtjB01FKEIq2C4xVdT6NFF99FbY6dk9ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711628473; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PQ0oIsCseEzm2I7RTXqcJpL3sURJzBMUqQB2l28LFz2vNg4/vshw2yF/yBD+HDY1ARIlplZZWN27WkFfQIgL2SQ0cKBoeVs2XlirAsmmQ7fii+UyVi63vD8eZCcnryBsfFK5eZb1yiP8XiXR5C8x2xCyXjOzX/zLxU+FZXqA6vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cZmC3IVO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=t/XFWuMg; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1711628471; x=1743164471;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=cZmC3IVOh7W3tXXLW7A/6NYJXTAxaBHrDkjAUa3aFs2V0MfrW9GyXGNB
   GMxShPsRxuwFkd/JCJK2cLohBb584Bjy4WaKqGjYDeYS+AfEsUmSHd8ku
   ypm+xckoj1hL6v2GO8su+B8zvWq5w6o97zmuPIoIlrIUGBvFX167jiI2e
   TB9tFXPECArciNfuNP4VN1TTc8FDSq0u15jfsGQ2T+1yIGx/KI+vXadcG
   y68MR9v5UecLHNCNcSYBEFfqnVEpCJKqDAV2byp+WMc6XqRTFU8lCzfKz
   lFq5h+eXVwfYceqo8puwQUTl/7qPocK7Ehilq3BO6X+wyfELLMZd4I6/E
   A==;
X-CSE-ConnectionGUID: ebIO6gpCQraLvEkas3Q0kg==
X-CSE-MsgGUID: Yu0sxhy9Qnu7/gTAbyEy6A==
X-IronPort-AV: E=Sophos;i="6.07,161,1708358400"; 
   d="scan'208";a="12690025"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2024 20:21:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4P5lNv6HWn+UiEeVpAw0L5X9lv2Tq+JYC5yQzLN5RPDiSo6QJ/NojT7+D86ZWuz9AOwJgDVpguKAF+zDAPJgQITr75aKUEKxv0JrJjMYSVROCkoGPD3ZBtixDbdTth6w9tsPBXPILeRExwaZRXP5dIJ+ZOGOWH3nwNNJ61Uuv5ClxuaF3U6P7LNUAauL4HBO2YQywUN/ZA+0Gi115PYtc1QywchomP8qoOyT9WhIT2/UqZRF3nfYmODYJWxco6Mhp7uLt1p2OaWrFcZ5rc80yixiV/uRoOFHzuJ6jC9lyBfofqg5sHij+L/TLiUcul1yDyK0oJ9qud6UjIrHwKqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Imh5IIeb8Iu+QjSlKe4L2PkJQRcJp5lZUSGijM4bg/93ebyHh7F0JmxjACl1oybgLL/Oi0LIzkmYObp0gTATnglXt/7Ve5ADZv8vwd6Q82Z4xT7ejnlPeKkUVy3G2/ukxMjJSODQPS5t/eAHyyEQCcxXf1UrXCYwKQttiQ0L+TL0CTVIR8Nz0kNGmmXByqMR9k9d4VLVbgAk4CVkJvpD3/AKSVaftz1GRYnnhV9woKLlcyYctUvS6BnDPJ8gTD/+7BEDWr2e40v740Ygs/+MMFcUNUHjO1dpvTXgi2J7Ci9Iwx3FcVqa1VWlqaBP+MNvx5gp1EMYY6gsd5C0zXjNJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=t/XFWuMgN0QsyVyW/WjU1Ka9r9CQ95gUfywNKmv7TSWrrIFvp/KvH2iFeGtpL0oAX5wGpmaXul5KI3YNJFMgvL7e8w6zohbZZnvqXndt3LCr5KOmQb6gdiISL6Lwwqcjfw4E01D1Ue1MDQbSsQ47OBwQKUONB6OR5GuwYS/yiwI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6813.namprd04.prod.outlook.com (2603:10b6:208:19f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 12:21:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 12:21:07 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Mike
 Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Matthew
 Sakai <msakai@redhat.com>, Chris Mason <clm@fb.com>, David Sterba
	<dsterba@suse.com>, "dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: add a bio_list_merge_init helper
Thread-Topic: add a bio_list_merge_init helper
Thread-Index: AQHagOvSjpDiA5VFG0SahBsX4A1BvLFNEvgA
Date: Thu, 28 Mar 2024 12:21:07 +0000
Message-ID: <5ed8e2ad-1ed5-4988-a625-b0a67f800d9f@wdc.com>
References: <20240328084147.2954434-1-hch@lst.de>
In-Reply-To: <20240328084147.2954434-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6813:EE_
x-ms-office365-filtering-correlation-id: f5dc80f4-75c1-4867-f76f-08dc4f218b65
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NdvP8M1WqvHzwhOjjNbTIC6aVK45u/VurONf0sFLx/rinxwY92RHbBEhfJPmHVq/t9vGjJTOQSgPxfKi+QpVTNoMU3kwCJ5eKFm92htU3BS6R+kyOpTQOodIOxQZG+Vh8j2pPV8nB2l0agEKazY8syh4OVGjOdK/kabqHOrbmXLEgHhW4UnEJOf4RY+QGf11+vIxz+/7/v6iO2dD4vLb4TsWzlS3X+8ya0CViQV6Aen6GapZPA34qZ3SdYqusC8uBMellLJjeji2GlWFBjOJ5zWcytJ0nnwYCDQi1laC34T9ReePhr4MN5N17xOBLUhROdAs1N/6sZKKCGYTdbAFaic4KGmRDVHWFNIwqz5m2cZG+RJBTasuxGOmPQbHqTx4ltjQsC/FaOO2VjTMF9Zbj8TfWyaOGA3UwfG77iYmpRC/auoRjsjpeLtYpOXO2Sp3T3h7JT3OWYWcnSd18YD+rCoGHpTa92zMEi/IS+Uv+KGK8jBzdrVXRlF6B+CUmJyP4bl5rfGdb5MIvpsB8fzeNBHDpCoTbFc2ri16jYpIXihLGcfI+jDb+Asfdket2n7Iu+NQgvB9eD0Ej63LigKvjmAjBt91mJqaTKGy/1PI+bSMoHyJAEUyE9LV7+dLbQCF979oYT8GbZ+6G8SmLf0IPKa1qnX40ExCFUgQO+pxfdKdutYrl7KV4h3DhIJ03G8U+kX4RlhSYkl8piJTe6anfTMDiyNOgUxudV0izZsOoSQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bHlzSGVjZEhwcGxnaVlJbDlLck9vLzFTZXlzcXhjV1pVV0lyT1lVZTVVdXFV?=
 =?utf-8?B?MXV6SGU2NUtWT0Ewd1pqTy83ZnlwU29qSEc2MGZrNDZVamc0eGM3Q3EwajFp?=
 =?utf-8?B?YzhpNUlkdS93UUhDVk4vY1lsaS9KUm5lWHV4Tk9FWjBDdWdGOHd1bXI3cmxK?=
 =?utf-8?B?VGVHQW1zMFprNit5c3YxWXZnVHZzU3drQm5icm14YnNQWFBsY2Jvd2lITU40?=
 =?utf-8?B?T3BKSFpnWmNWL3VNU3ZRU0U2ZGszRWkxQTFiekk2dHNNbFZBRTlGMVNPZmdO?=
 =?utf-8?B?ZmJyZ3NoWmMzTzEySGdqOEF3WTJhV2E3V2daWTRFaUY2dGRhcXA5bE96N21R?=
 =?utf-8?B?RFE1RWZvMXBHeSt3bFhzcE5GK1hyTERRTmZxRWFjQWJtQTBzVXdSOFlXVFRZ?=
 =?utf-8?B?TlJRdStxZ3ZqdHJhN0d4MGlYSmh2U29pUHZpQUZSRDgrZTZGSG1DR2g2ZnR4?=
 =?utf-8?B?a1FGQW9MQWxocjl3YVA3TEtiOHR3bEVFVXZxQWdqS09VK1dOOUovdzQxc1c5?=
 =?utf-8?B?cVJoakR5V25lTHJpZ0o4bjJZM1hvQ2pwZURFejlFR00yOWNGRnB5aTR0cFVO?=
 =?utf-8?B?em12N1RUOGNVYkJwWVRVRk1ja2plQ1ZkS2E1NmFXYlU3TkVOR2VxemVGY2dX?=
 =?utf-8?B?Y1JlWmFEc21FdCtzMEQ1SDFuLzZuaFBFM1d6ZVVJVmxmSldjWDQ5RGZDMnV4?=
 =?utf-8?B?Nld2VEduWk01ODk1L3pROFhsQXZyZW1JempmL2VHMG1JeGNtMkM2K0tCM0R3?=
 =?utf-8?B?bjNTMkQvei9BYVZkNUJxWHVMMDFNVmU3ZEo2NThEWE9udTRNZEx6UHIzUHFr?=
 =?utf-8?B?bHl6QXRiZlhYNkNOSWZXS3U4WjBjVmVtYm50ZElYcEZZdXZLM1RLaWdmUG5F?=
 =?utf-8?B?azNtZWFIMTFjMksxVFRIYVhjU25Fd3dOamt4dkNRWWdTblMzaVpVdWlSMHhM?=
 =?utf-8?B?Q3o4c0dhT01leWVIUDN6ZGh4eTFja3RDS0NLcEh3bTUvdmNJeEkxQ0ZNdjJ5?=
 =?utf-8?B?NUZXSlRSWEZQdzl1YS95cGI5NHFsNnYvaXlnNmJlakw4UFdxbGNQNjFXSHhp?=
 =?utf-8?B?UGF6NUJzWEZUZ0JnNVJ5YnJxU1hrQzgvUGYxUk94VERRbTlhaXVMVjl2a1ZG?=
 =?utf-8?B?dS9kay82bDkrdEl0NlNlTVJRM1UyLytMam5vMUFaMkRicnhvckhOcHlOdHdB?=
 =?utf-8?B?QldLcEhqN2tzeDVCMTdvWFpzeFBYWXNPZ05VcnFJa0VMd1l6TTQ3Q3JZN3FV?=
 =?utf-8?B?OW1Zb2NOcHplM1hFZmNOUzZ4WjdnT0Z6cHpvRmpOc2FEWHlLV2l5RkF4MGhM?=
 =?utf-8?B?cUh4ZWx4RTRaM1BwcTFmdG9CSjNFakZTSENMMWlkQkRFb0RwT2hidmROZ2NE?=
 =?utf-8?B?aW9jRjRuVURmejNqYnZkWGd0dEp3Wlk1RlJqaHBUYkNMa1dEVkVEVitpekI3?=
 =?utf-8?B?Tm5WSE1sUjh5RndYV3dYS0gzRjBWcy9aTGFVYzFDa241K2pnNmtWcWxjWVln?=
 =?utf-8?B?QmNpYkYxcjV2QVZ2QTVjalVrNEZNeDBlT0RZVDREWFF4Q3VOMHJCR05Oemg2?=
 =?utf-8?B?aHlWSDBHSEpIQmdvV0dkMjJwTHdScGtjdGxNYW9WY29tV0dPdVJrWnllZEg0?=
 =?utf-8?B?Q3ZmUzBXN1dUOHhHL2NxdDVUSHA5Z0Voekw3ci8rc3pWRFFNVUdkbUk2MzN4?=
 =?utf-8?B?OTcrNnpnaXFMcTdhKzQ3bVVDZ0JibzhlWkR6YndBOFRkSUlEN3IrQkdLOFBh?=
 =?utf-8?B?d2dGUlZwNDJySUJzRGVIa2N4Rk9lNDlFWmpYUHJCNEFFazJ2Y2x6WUx3dmFs?=
 =?utf-8?B?amdpLzFGS21Ob3RlbDgyU0plMFAzU2FvUUZxcWZLdFpoU1VoUmxKNzd1cUhG?=
 =?utf-8?B?ZHRpK0NSV0phcWI4S2lpVTdrMDFGc1dlQVptY2kraDFyT2wyTFh3M3lFY09G?=
 =?utf-8?B?Nk5DaU1pZmxVdEVsc3NsSFY4TzNsb1psTktMT2x6d0pIV3NyRFo4WkRBbjV2?=
 =?utf-8?B?K1U0ZitVMUdDWXFLWUNLNUh4dTRlMGRoQ0p3Y01hcFE5SllISy9iNGgyUjdO?=
 =?utf-8?B?MjFDd0w1bTJRMFFFZDk2d1JWSnROd0s5WXFuK1J1TjJyc2dqMForZlJ4NVR3?=
 =?utf-8?B?bjlQRXBKeFRXT29BNmYwOEM1ekRRYW9YN0wvMC96dHVhcmdNUDJjd05NUk5D?=
 =?utf-8?B?Q21UWUQ3NjUvNHdyMElMYzRBcVFqSXErMkQ3OGtzcmJjcmVyQ0RRZUtNTlpV?=
 =?utf-8?B?KzNMNmNCeE53UUlLa25ncWJaR3BBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3D8253A0299694D9E976A6F298ADB5D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Onco7K0wNNwjeQOdA7eKrKIQiwnVpckn6tDbXsAWBgUjmaqsOz8dTk+1hJ6hDr0jMsD9u5P2QDXpjc2NKMVFUd8pC+trMldPbTvP0rdXud3z3GzjIpRAMCff+khvn1jwXjM3mWllnHFgAHGWFe+WHCM888OiovWQC9PDiI4BCT+sE36K47biYbxv/DNAIy1w/WyOaIa+FWqnwhB7xJ2GQZkL4Fu6p0CsvEjMdo46V8cBdQ6J68qsC9TWIZz1ENIfjevfF+JFje6MY5Zi8bg9exyZritd98xjOYuzngnDcUrg2sjbG1I13Zmsh7/xpkkhjJMkDfs/DqKOSJ7fIgzKXONJlUWgWHzOk9gyho5/f1r8iAOQ670EY6GPLZbBqn77RjN5K74/eKubDQnkQcjLrco8JhLKPFZu0ZtdNemQy/8gBRNMcZuTZZv+7ov4wvYSccBI2kgvXRmJJU0zDi+UmZKN/g0TxwhGPdhQ0r+oOc17/N7dzvpOMVJhmirQktos3P22G5Q+uV207fv9X39moZUga++t2t+dMf4wcnUbJNZlGerjOtvrvWUChKbUTr7nCNwY64khiSJafmO8120l7aJyo5Bb5SdN9AUhRC1asvF8liPTOl9thVqIxEGhl1Dn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5dc80f4-75c1-4867-f76f-08dc4f218b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 12:21:07.0623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zw5TTTTPguKN6+Cu9uY4GS0thtrh0a3CRcnEgNerjiEH9/DVJxcBaP8+jQoQRFujF+1Nm0A1GlqfLKb83AtnLh1Jqwbu1tAbF5K34AaV7Zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6813

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

