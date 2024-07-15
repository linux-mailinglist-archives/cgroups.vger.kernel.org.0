Return-Path: <cgroups+bounces-3672-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2A0930E8D
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 09:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D141C210F8
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 07:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8230518410F;
	Mon, 15 Jul 2024 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gdFJxYsd";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hB0RTVy1"
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E391836FF;
	Mon, 15 Jul 2024 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721027737; cv=fail; b=Aq/buA0Imrp6SaFnJjQ0Qu/sEg9ua213JkH7ljFja1laxmhMz75Z1QuxNRaUGcNJMXaRbsQpsMshhRDL0rKT8T/nVyxHQqGq2pXuatqeJob08zM8QervAhU0ugGAbJoZqYTBtEng+hUGalJHKYcyJPrxwFI3rJeHV5OfNJxow9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721027737; c=relaxed/simple;
	bh=ghL+j9DTxMwjSqzl5oXNH+MEj2Crg7D2uVLfXZNBVCA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YI4nhbep91y5pfZcfa1NWnKa4s3mJseVKotz2jK1dz09dIbmxLr76V3hsxz+JRm+zd9JMbFcbeOM6wEn29WQla5KNytRzCffIIy2oZqbgZnW8/u4Lp3KHUh48BBUa2bYS0LfhLP8NKxRVo5TH+xShtTAlxZOtj6OB99WePBmRe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gdFJxYsd; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=hB0RTVy1; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 03d8ed7e427a11efb5b96b43b535fdb4-20240715
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ghL+j9DTxMwjSqzl5oXNH+MEj2Crg7D2uVLfXZNBVCA=;
	b=gdFJxYsdeUmC/FxY3YvW5N/iIQ2gDtIym0kkRyHvOd4LkHVuc7jARV7yVcAb85BA5/km5+/cUnhF/QphI1DPCXjt3MOLAgMRtVVhdK2jxzWJWkKJz2kbGyqjA0m0O2HpyXUjJISjcVBOm3t1hwqbusGmvWmadBSFHCNbn814E2Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:1f838bfe-02c1-4a86-8ddb-7e979e8b6a1a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:5e0b770d-46b0-425a-97d3-4623fe284021,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 03d8ed7e427a11efb5b96b43b535fdb4-20240715
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 274055565; Mon, 15 Jul 2024 15:15:28 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 15 Jul 2024 15:15:28 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 15 Jul 2024 15:15:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnRJnBo0fv3mfLgPstZPZstpnuBLjeEC1phlE1W2sQvU7brpVHtFhgGcu8pCqXFuXgTbCikqzM37xH7E736Dz3zpUulqp3aa1v1J9d/K2HSNlVgzm9EtZBQRfqwOT8qnAJWwfDT/O6pNUvDwLatw4REENGsNxCFjTB1nRxKdFRTYzooNQvnx04UldrwUA22sUZz+fJE9k5i8LvoVvheQI9VEDT9t7sHnlFCabbVmQOlvD7KQlZW5bAGiQwxuLxS/L5L6Cw4jbIdHq55m5MFLfeY6idQF4hHaBJR85YBWMDgxvGcjmmCRL5xkb0A5RwA6Y02PJzM81EuWTh6HQZrGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghL+j9DTxMwjSqzl5oXNH+MEj2Crg7D2uVLfXZNBVCA=;
 b=t3cERtm4JsQze6AwakM5trttqVRiNxqow9Rillic/7IL2pVePwySGJQcdxRt0tBveV6UflaUEpm1Dj+14BPHSigCjt18PYEjKiXUkWNKHOzbAxzkJVtDao72aiuZVveReJ1HAW5zcmE3woHvEQNlm5RY0+mPE1BdbVy5V1LWyvuxzKAOqzQRQtZZnByVj4vqHwWQtD1nVHoh9JfCn9FSwNTG5dmwQk9mGP1qZYBkrvUAoTNpmriIeNlKKX+ZfEij4aVWVZWCGAJXx08oLWwIEBWzBCTfO29elHVgsT/lMxTor7hsvkeuNp6jl3KfSYFz9jaNO6xwqdk5cT5xKO3hLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghL+j9DTxMwjSqzl5oXNH+MEj2Crg7D2uVLfXZNBVCA=;
 b=hB0RTVy1cB056i6ZidJyP8K147isO9h/EQbtoZKBNUSnRknBOxWSo3wI/5hQuMZ/MxxOPS13mE6Ua5BQiXO5n9C1SFezkQaxyotBwvNHOZFLYOgO9lh+QLQn9f1Up/KwpDOvPf/kFjIJBkawjXhHzVv1P5nYTurMeEvs7/lYu8Y=
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com (2603:1096:400:465::7)
 by TYSPR03MB7452.apcprd03.prod.outlook.com (2603:1096:400:430::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 07:15:25 +0000
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9]) by TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::f95:7de7:753d:4b9%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 07:15:24 +0000
From: =?utf-8?B?Qm95IFd1ICjlkLPli4Poqrwp?= <Boy.Wu@mediatek.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"boris@bur.io" <boris@bur.io>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	=?utf-8?B?SXZlcmxpbiBXYW5nICjnjovoi7PpnJYp?= <Iverlin.Wang@mediatek.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] blk-cgroup: Replace u64_sync with blkg_stat_lock for
 stats update
Thread-Topic: [PATCH v2] blk-cgroup: Replace u64_sync with blkg_stat_lock for
 stats update
Thread-Index: AQHa0pBR30AINLT9pky6tv6t6Zyx7bHwh18AgABGsACAATg2gIAATVoAgAEcvYCAA/gHgA==
Date: Mon, 15 Jul 2024 07:15:24 +0000
Message-ID: <5a1e1bd5168696a0857b62572336c5e598cb5493.camel@mediatek.com>
References: <20240710061334.1888-1-boy.wu@mediatek.com>
	 <Zo8HTD2AD-b51q0C@slm.duckdns.org>
	 <6114fbad7bce9b15806bb9fee25a1075ecb53dd1.camel@mediatek.com>
	 <ZpBIfwThiVwstlXL@slm.duckdns.org>
	 <70c37035f006de3a4fde895ceeee92826cd280e0.camel@mediatek.com>
	 <ZpF4Pfu83W9Wp_R9@slm.duckdns.org>
In-Reply-To: <ZpF4Pfu83W9Wp_R9@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7867:EE_|TYSPR03MB7452:EE_
x-ms-office365-filtering-correlation-id: 576f5b39-0da4-4e4f-96be-08dca49de53d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UkRuTFdXdENjK1J4SXJ4ajV1MGtpakl4Uy90TTI3YXA5TmhYaFcwendtZS94?=
 =?utf-8?B?Z0c4LzdkRUwrajFCa3dLbTZNRWJhaFI4eTV2WFlWT1IyWmdsUFA1c0I0QkRJ?=
 =?utf-8?B?a1NLQ1FBaGlDa1RiNDJXTVlmcWFJc1NoZy9lS3dWVHNKR1Rza0hRRmZxTnBQ?=
 =?utf-8?B?OHBUbWdFREkxY0w5QlhYTDRRa0RxNHdTWW16QnhCS21jUzk0ZitsSnJrV3RS?=
 =?utf-8?B?VDNoMlhFNXdTWVQrQksreEFtN3R3TXRHOGlHMmJHWnpaWG1QL0NpeUdCeTRa?=
 =?utf-8?B?bzJJekJMT2NBOWhtaDJkNmg0dFY4K2YwSWhkb3NvL21qMEk5TDl4ZjJYSWtj?=
 =?utf-8?B?QS9yT0c1c0lUMFEyK1VmeVF3dlhYWml5Qk5YM25MYjBPL2t5RVRZUTJmMG5v?=
 =?utf-8?B?Y1B0eWU1RVluZEZtQ3Vxd0tJNGUvSnBua1lrY2lDMldTT0hZbEkrNG5UNGpU?=
 =?utf-8?B?QklNOXJROGU4amtLOVlTaE5yZUNoM01Da0wvbUMvMEZESE1yRUU2cFRsdmQ3?=
 =?utf-8?B?ZFMrT2VMNk5jMC9kenBIb3lFRkNNNlRzVjhmR0ZxSGk3ZGFuL01IRXoxQ2Uz?=
 =?utf-8?B?THhtSk54ejVYTllWL05jOUpxWXV0TUUzdGVpWjlLUHZoTW9DNmhndURyTDMr?=
 =?utf-8?B?YlFOU3lUMWhWSjZHK2g0ME1tWVcwNE9KVk1WYlc3UkJ6TFFWdTFEK29xQUZD?=
 =?utf-8?B?OFZndXBjbXBuQVhpM2dGZ2hrMnRXdTV1cys3YUZ6Uk8ySEV0VHQ1cDlTODVk?=
 =?utf-8?B?M1djbWQzWEg3akJwd3hSZkJZd1QzckZidWVnOXdjMWR1QWhTR2Nxd21VOXZQ?=
 =?utf-8?B?eUlmT0pDZVY2a3BJMDhwK1cwQ0RRdE14V0daVFVBWkl4ZjNGK3lGaVBEUTFU?=
 =?utf-8?B?OTZXd0lFdDVrblNyNzlDS2pXRFhIVVJwa3hhRFIvaGVpbjR2WXpKSFd2V29s?=
 =?utf-8?B?Z0dWUC9WVElUVG9zcFlCV2dpS0V0anI3TkhDTFRZVzBoUDFHV3pEcGMxejB3?=
 =?utf-8?B?MXRXZjk4WjltV3FLVVJpSlZpOTh6eGdNYVR4ZXNqRDBhbWIxY2oxeWpMVzhG?=
 =?utf-8?B?UHVRN1kwZWlvcExlZjVRZkh0dXBFaENuVW0yNEM2SW92V1BCbEMweWtIcU45?=
 =?utf-8?B?WXdxazUxS2lDNGtUcmxQMnYxK2Rna3lPRDJIYWl3ZUJMQk42QU1lZ2kydi9T?=
 =?utf-8?B?Y3V1Sm0vVWcvMlB0ekVKTnBpSjl5bFRNZjkwOHp2WE5jMy9tcmtHVjA1WTds?=
 =?utf-8?B?WEJXUG9CUXlvbU0xa2NYVEMxQ2lCUUtzWkM2UUJucENTTXI1Y29kVVVETzBo?=
 =?utf-8?B?TkNMaFlUWEFaU2t3UjFXS3VCRlpXVTF0QnF0WFFVSTlScCsyblh5V2lONklC?=
 =?utf-8?B?aFVFTjkwZFRkWUxYalAwOWRSVENqMUs5NnVKdUNlQUJCVXRxMzZ5VHRxdjNk?=
 =?utf-8?B?SDZpZUNHVzlYUUgxeWZBMTE2MDNsQWVyYnZYQ3B5QStLT0RZaVFXc21DQzk4?=
 =?utf-8?B?V3h2dStmRkEvUHpGRXYwc05UL0ZSSXRkM0RHMXpaWTZMYkJOR2RHNkh1WUxX?=
 =?utf-8?B?a0tUUVMwem5WejVYMWgvbWJLSjgzbHluTUJGME9FRHJrdVRIVFBRcXJWWnow?=
 =?utf-8?B?cXZlQ0xJdDJLQ1M4V1RFNU5hVzErYjFXZ2MwS0VFdWNaVmhqTU9pMGo1eDFF?=
 =?utf-8?B?NVJQMUZmajFtbDZJY2xFcHdJdjgvRVoxSTYxck5UeW82TDZTbW5UUWxXVng4?=
 =?utf-8?B?WndnWlFyTHhNMlpnd3BqdUk4U05iRnphczlhV0ovRjV6dGE4MUxxRzJCeFd5?=
 =?utf-8?B?dkl0Yi9LZnVoMUljcm5PM253d3kzbklUWkx3VVdVSyt6V0RSdWswdk52V2h6?=
 =?utf-8?B?L2UyeVQzNDR6YnMrdzBUZ1NHU0JYZTM2dGZ0N1UyRDRQdkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7867.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTdqV3VBTmJtenZSK3R4Qmh2RFJNVGlEaFFvN1FyNG1qNFJPOW1rU0d3Z0FH?=
 =?utf-8?B?dVM3U0F5OUxyYWFveXhqa2E0bW1Dd2hyM3hKVGJsRWZkWmRHcXFNbkF3bmhW?=
 =?utf-8?B?WVZsaHZ1ajkwU2ZIMzFEN2xEb252TGlXUlFpbUh2dVVMV1EvajR2TVJWeWVa?=
 =?utf-8?B?eE1iYWJSTGg1MWxQQ3JxSDJWeklsTWJoMDV0ZmR4ek1VZVgzQUpUS000OGZS?=
 =?utf-8?B?c05wSUNGWUhxM2R6bTR4UkdjRmtpTTh1NzdZaEtQSGdVTGZaNlFJSEw5RURH?=
 =?utf-8?B?eWFtd0VDVDh2QnZRNjNJOGsvVDFVNEpwcnlrajFQd3daU0VHL3VlMFVaU3F1?=
 =?utf-8?B?N0tFc1E4bTFya2szcjdWVVlmRzAwb3RaSWRkV01ETXo0Nk9jS2YvTnNMdGlV?=
 =?utf-8?B?d21WVDBHTXBtRTNtREVLdms1YkRIWEZ5b1JJM2g5aitSZjFmRnY2VkxSTks1?=
 =?utf-8?B?NGs4YlR3dGh5V2dxUEF0THVERHAvUnRFUWNDNHhmOXI2eUJKL3JHQnRha2ZN?=
 =?utf-8?B?eFhzVkFoZiszZCtJOU52akZmTVppSDBaSm9qK3pjazhTQkZDRzFDQVQvdVVk?=
 =?utf-8?B?YVJ0ZGh6VVUvaThvYnR3TFFDK3JXZCtCZ3A3OStxR3ZCZHN1a2RLa2FxYzdx?=
 =?utf-8?B?WjhhWURHRUd2VkV6NDRkQ1FZczZDQnltWHlqSXVTcE1qM2wvMnNCY2IvUDFN?=
 =?utf-8?B?ak9meEF6ZHZEVTU1bHBoYkQzMDdUbWFHZHVJOU9uWnhlMDc2akMxZ09xMDF2?=
 =?utf-8?B?U0NRM1owa0ZubVFsRGpJM204MXBoQ2J1WXlMdGZEME5VU25LZDBNNFhCSUk4?=
 =?utf-8?B?dFdlL3FSTk4yTkdMRlA5QXJ1M0lXVGczVDI4QXVzeTNCaStQS1VYSEJBaFN4?=
 =?utf-8?B?bDBWS0IwS2k0ejNoSXBoWWxaQjhwMGpZaG5QemxCVk9pN09TMVpnaFJ3Q1N5?=
 =?utf-8?B?K09KTDBsSHdMU1NEUEJDc1lpSEthSTd3VmJucDc3VXVFOWx3Q0lvR3AyUXRJ?=
 =?utf-8?B?aFVDajNpZHNaNkVYMSszaWk0UkJyQ21hcnk5V3RLWXR5NWhsdVc4dXcrZXp6?=
 =?utf-8?B?eHdRS0x6eGhBSTJjaHpVeEk0eUlsRjBTdWswbHM1bytDaTBqc3VEVHR5STdt?=
 =?utf-8?B?MnA1Zkh3M1djSG1VRTAvbUZDNEtzOEJncndSTERlOUErKzVJMU9uMmNoMkVs?=
 =?utf-8?B?K1JibUVlcW9OemY4aHRXZysvbWlmeDEwZVNWUWtrUWVxUjY0WStWUDFJd0k5?=
 =?utf-8?B?SnV5bngwaGRxZDhvbjRzOFEyYU1jSG8vUlpZMTVSRDFFYWROVm9PUW9pay93?=
 =?utf-8?B?WUR5L2owOFlENXp4Q1hqOFVTb1piNHhMNTdqTm9sc0hiTkdBbzMzNTB6Z1hB?=
 =?utf-8?B?L085TlBPNXA5UEFncDhRTnRNOFFCK2VEMXlSMmtEMGV1b3p2T0w2dDV4THJm?=
 =?utf-8?B?elpOREVyOVRvaU1WNHQ0bCtGKzArdVllY0dNWmZXd1BkdFV0Vzg4WkhzY1NJ?=
 =?utf-8?B?c1B1UmJVd0R5K1owVXFRTko3eHNzWVl0NkRHU0ZwTXR0dWlvYUZ2M2lzZXV4?=
 =?utf-8?B?R1dQRW94aVJGMmRLb3Y4Y3ZTQi9NNExVVExjU2xVcEFIR0ZBNnNiOFJRdU1P?=
 =?utf-8?B?enhzVVI4T0dvZlE0SHp6dVZMVTlPRG5PL05PTm5rVTBvQkNaeE5NazA5citS?=
 =?utf-8?B?NmhWSkxYS1ZuRFpwZVo4R1p2WVZOeHVxU05xMGs4cDBZdTZsaEE0MHJ0Y0Q0?=
 =?utf-8?B?VmJUc3N6NXZXRHYxL0IzblBXOXBzVXpOWDFQQlZZRlNLZ0VKRmdtTk5KWEdv?=
 =?utf-8?B?N0VKaVAxcHVpdmYzWUtTeEJqdzJmUDlvWldOSHAxVXhnWTZobW5Ob3p0bWFK?=
 =?utf-8?B?T1U2TVhHS0FWVkRId3NqeXFrRE54WlVBMHZFaXVibWM2OUdZOW4xanVFOHlv?=
 =?utf-8?B?QTRPZjhscGk3ditCYnhLaGRQaXJjM21NNVRUd0JqaGpSRlFpWXMrbGFtQkUv?=
 =?utf-8?B?SFdQeHpKSWFadjRlWWh3V2ZBZG1KVFZxVXROVFZtSGRDdTFjTi9tVGtmMjho?=
 =?utf-8?B?OXhYOXNGTzRQdm54VlhaVHBWR1hiYkEyMWNMTUdWS011VzVKS05SNzJMVzBZ?=
 =?utf-8?Q?UjZgIfUf1VDHTFUhS2I/Emdm/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C330565F21DDCF47B203ADA4EEFAA451@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7867.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576f5b39-0da4-4e4f-96be-08dca49de53d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 07:15:24.2257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HIYcdmS4vvvLtvIVmfqm3sU48yL+m6znsldGbsCjqXJ68zReIclUxEtBn3otPMqvXvtjgK7gHLheR4nranenKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7452

T24gRnJpLCAyMDI0LTA3LTEyIGF0IDA4OjM4IC0xMDAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gIEhlbGxvLCBCb3kuDQo+IA0KPiBPbiBGcmksIEp1bCAxMiwgMjAyNCBh
dCAwMTozOTo1MUFNICswMDAwLCBCb3kgV3UgKOWQs+WLg+iqvCkgd3JvdGU6DQo+IC4uLg0KPiA+
IEkgYWdyZWUsIGJ1dCBmb3IgbXVsdGlwbGUgdXBkYXRlcnMsIHdlIG5vdCBvbmx5IG5lZWQgYSBz
cGluIGxvY2sNCj4gYnV0DQo+ID4gYWxzbyBuZWVkIHU2NF9zeW5jIGZvciAzMmJpdCBTTVAgc3lz
dGVtcyBiZWNhdXNlIHU2NF9zdGF0c19mZXRjaCBpcw0KPiBub3QNCj4gPiBwcm90ZWN0ZWQgYnkg
dGhlIHNwaW4gbG9jayBibGtnX3N0YXRfbG9jay4gSWYgcmVtb3ZpbmcgdTY0IHN5bmMsDQo+IHRo
ZW4NCj4gPiBvbmUgQ1BVIGZldGNoZXMgZGF0YSB3aGlsZSBhbm90aGVyIENQVSBpcyB1cGRhdGlu
ZywgbWF5IGdldCBhIDY0DQo+IGJpdHMNCj4gPiBkYXRhIHdpdGggb25seSAzMiBiaXRzIHVwZGF0
ZWQsIHdoaWxlIHRoZSBvdGhlciAzMiBiaXRzIGFyZSBub3QNCj4gdXBkYXRlZA0KPiA+IHlldC4g
V2UgY2FuIHNlZSB0aGF0IGJsa2NnX2lvc3RhdHNfdXBkYXRlIGlzIHByb3RlY3RlZCBieSBib3Ro
DQo+IHU2NF9zeW5jDQo+ID4gYW5kIHRoZSBzcGluIGxvY2sgYmxrZ19zdGF0X2xvY2sgaW4gX19i
bGtjZ19yc3RhdF9mbHVzaC4NCj4gPiBUaHVzLCBJIHRoaW5rIHdlIHNob3VsZCBrZWVwIHRoZSB1
NjRfc3luYyBhbmQganVzdCBhZGQgdGhlIHNwaW4NCj4gPiBsb2NrIGJsa2dfc3RhdF9sb2NrLCBu
b3QgcmVwbGFjZSB1NjRfc3luYyB3aXRoIHRoZSBzcGluIGxvY2suDQo+IA0KPiBJIGRvbid0IGdl
dCBpdC4gVGhlIG9ubHkgcmVhZGVyIG9mIGJsa2ctPmlvc3RhdCBpcw0KPiBibGtjZ19wcmludF9v
bmVfc3RhdCgpLg0KPiBJdCBjYW4ganVzdCBncmFiIHRoZSBzYW1lIHNwaW4gbG9jayB0aGF0IHRo
ZSB1cGRhdGVycyB1c2UsIHJpZ2h0PyBXaHkNCj4gZG8gd2UNCj4gYWxzbyBuZWVkIHU2NF9zeW5j
IGZvciBibGtnLT5pb3N0YXQ/DQo+IA0KPiBUaGFua3MuDQo+IA0KPiAtLSANCj4gdGVqdW4NCg0K
SSB0aGluayBJIGdldCB5b3VyIGlkZWEuIFlvdSB3YW50IHRvIHJlcGxhY2UgYWxsIHRoZSB1NjQg
c3luYyBmb3INCmlvc3RhdC4gSG93ZXZlciwgSSBoYXZlIG9uZSBxdWVzdGlvbjogd2h5IHVzZSBi
bGtnX3N0YXRfbG9jayBpbnN0ZWFkIG9mDQphZGRpbmcgYSBzcGluIGxvY2sgZm9yIGVhY2ggaW9z
dGF0IGxpa2UgaW9zdGF0LnNwaW5sb2NrPyBXZSBkb24ndCBuZWVkDQp0byBsb2NrIGJldHdlZW4g
dXBkYXRpbmcgZGlmZmVyZW50IGlvc3RhdHMsIGJ1dCBvbmx5IGxvY2sgd2hlbiB1cGRhdGluZw0K
dGhlIHNhbWUgaW9zdGF0Lg0KDQotLQ0KQm95Lld1DQo=

