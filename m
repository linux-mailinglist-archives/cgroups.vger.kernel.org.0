Return-Path: <cgroups+bounces-7823-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E662BA9BCC7
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 04:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC9A17F089
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 02:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9DE1487F6;
	Fri, 25 Apr 2025 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bFCLD3J+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Wil2aBVS"
X-Original-To: cgroups@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6003179A3;
	Fri, 25 Apr 2025 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745547762; cv=fail; b=WwzcmG2fxcTfSef0+jTkKyz9/aS++SI3jSkuGSr7VFsiSmRTCSwkiBwQuaFK4zjXdqYlIK0kXmKHAJMTJVVwXaO2K5KRlEuchDkK3PKc10jutx2sx8YcuNyLqoqMVXnGa8WSmIfFIK/lOEB5sU1g2Yb2hvj2X+36EklVC1Ii1dU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745547762; c=relaxed/simple;
	bh=+S+B85+auvtB2dRBRHPQTLW8nKiVwYoUWIYc/kCo1IE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V+yNhfzHM0h21uTepIhEqRzLqhUH0nwILtlO3BTkLvf9SmDsEAlMIOJUeDbNoa9ne2ka6Ydbdk+IdEcP5MxC60svjM+mrYA5yHpaxnR9VF9BHG8FBOsDZHMm+exwsM648zXwP7PztjaaFAxKn948O+IBI5HYlN5P1k/m9eAtk5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bFCLD3J+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Wil2aBVS; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745547760; x=1777083760;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+S+B85+auvtB2dRBRHPQTLW8nKiVwYoUWIYc/kCo1IE=;
  b=bFCLD3J+p2WSRdzu04iwwVgAFBEXq5rplm3S/hu7MKws/8oWivNO3sU6
   UjrM9SuJU4hboNj28LrDBzBx8Mtj1Q3W1GxGJGu+DvNlGh3v1CwUN1BAY
   /HKmh+JdcB2moBoG5YrC8VygOoNDih7+CtKHhN2xJlgYa7Yce7NjxchQZ
   mpDoK4uRTRAAY9LzI0w3gYS+1xku2cyjKWFphIavcUyrSU60II06NzJLk
   QA2CgbRbbNKFWVtVgPswshSYSQDftwzEU2A75NDEPBiHowOor5sVRlg1V
   wq6nSi47KRJf3gjOYDEWOcLeV29GkEu6pFmyhMn0OWxXZcn3KkVbIVF4k
   Q==;
X-CSE-ConnectionGUID: eivOsb4BTi6MHJUyMsrPZA==
X-CSE-MsgGUID: uVeJukKYRkqpi9LnfP1s2g==
X-IronPort-AV: E=Sophos;i="6.15,237,1739808000"; 
   d="scan'208";a="82365963"
Received: from mail-eastus2azlp17010021.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([40.93.12.21])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2025 10:22:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iP+VI7ChcVKxetTiVAQqVbgOkDQ3tJO6sD7DFui/o/MYhCWJiZ/FjqedhSxlUOplkt8r8pQXRu45R5nfZjVlcfd/hqju3ipydkF+eACdc9LAEiqD2jqSC5VYt8sCcHzi0/xJnETlYlEVc9wDttn7HNS0Jv2XZ62t+dmgUehqK/7Mz9MnDUpDpPw5fqwVx5nSc+xoVdDXQSRjQ4mngCsCNfN+cBBnAxsd6NjD75Y22vSJV+pf7whXqDhVsAAv1yLqUJJjcYw3u2cWRczC1QWX2A1NWV04hRluciqIz3d0vumkov9Oj+utr3HJpPnOJCsW75oj64jgbkHvZJEySR7sdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+S+B85+auvtB2dRBRHPQTLW8nKiVwYoUWIYc/kCo1IE=;
 b=lJsxXb+wl7Tt5fZ3W2VHXVGOwTay6huRQRIzmexy/J2VsoyPjlBLqdOfaRDgdGiPL66JPGZN0DroEql7U06WdPv3VS2/Go7TuBAEAPaGJ/1wxJ9YDhRIkz1Ij+h52EFiEzsdEaMvZ+R7mIZdl90H61p2Dztw4UCxUHgbxnlBdFTf9LT689ISrZzSbqy5vjIRY96gdvtW3ld7Xywpx9ok4Y/1U3E1BWxX0PcjiaZJi+M7e/zWRThsLTtstusk4icSEp/ucc9+35GPLQM6slK/Q6k1qvAz9/JBEOxANG6u0yErdaLlnAOLC8Qb2yjKRni1ygVvGTfxlLvfUI/1AQOl8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S+B85+auvtB2dRBRHPQTLW8nKiVwYoUWIYc/kCo1IE=;
 b=Wil2aBVS9UD5UGb486wtpaTtKRgFGjKclb6CGf3tvZfUvUCL6G7Merps3ZM30Xq6QwioENEWwy3axIyP3iNrV97YkArKET9OIstrxnmM7oTLR3/UW4x/LaNo0gdNzllyETduxLLY92XfPtNkNcPmbtGMpXPj2OBEbz92XFxln9Q=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by CH0PR04MB8113.namprd04.prod.outlook.com (2603:10b6:610:f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 02:22:31 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320%6]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 02:22:31 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Waiman Long <llong@redhat.com>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, hch <hch@lst.de>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: cgroup null pointer dereference
Thread-Topic: cgroup null pointer dereference
Thread-Index: AQHbs867Ho4DUg/FyECYHcuhUwZmwbOxxQUAgAHKuW2AAAyjAIAABKmAgAAFwNk=
Date: Fri, 25 Apr 2025 02:22:31 +0000
Message-ID:
 <BY5PR04MB68493FB61BF28B5268815381BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
References:
 <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com>
 <BY5PR04MB684951591DE83E6FD0CBD364BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <623427dc-b555-4e38-a064-c20c26bb2a21@redhat.com>
 <642a7d6f-9d8b-4204-bc81-4d8e0179715d@redhat.com>
In-Reply-To: <642a7d6f-9d8b-4204-bc81-4d8e0179715d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|CH0PR04MB8113:EE_
x-ms-office365-filtering-correlation-id: de70b73f-6fbc-4241-40b7-08dd83a0082b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?O1xM9eZ0bZq4QTjcbp6qlaKHnm7+Tk6O6Mi/Wj9+FAi27R10nN9UrBQWg5?=
 =?iso-8859-1?Q?gUdfT5HHoiB9nr6U+uo07EYBE0zqNQsK3rmplpsVgeSMWYcvOIdRF0j/08?=
 =?iso-8859-1?Q?vLYaq9oVerKbFrL9KHhbcsTMRk0j05Cy6DARcWbkP2hWsvIi69raVCiyaF?=
 =?iso-8859-1?Q?YJ4GFQpzjUzA9wPj5EcLQ/Qb8SAe6e2L+Q/6VAQ4573fUJPLqyBlMi3c+G?=
 =?iso-8859-1?Q?1pWvOiQsv32PapDduQjW95j4cloYsLIheiAMp47iXs8oj4UxycIEuWLZmA?=
 =?iso-8859-1?Q?tH87FT9fgQ46MRRtfPsbF7hOigG/hjS8I4+2UHkEW4+dS9kLn1GQjim7fO?=
 =?iso-8859-1?Q?edv2uB0pciRVYsq439yDAqTUX/bY6hiPHXWFg07xUp1pNwiJJgJh6TdCbV?=
 =?iso-8859-1?Q?zvA97TH835IM1lK4vWKYDcBi03nGHgoFL/KHSfi7/N3oFmBOwGPcOAGR9+?=
 =?iso-8859-1?Q?cicLaAKr1Wvo0rRpXPfrw3AFegy2aO6k5JTJvL+r8tj7rQyz053Nch1W31?=
 =?iso-8859-1?Q?ZPkFbYoOxsadAiJu1aeIjN7+7IKzSDY92CEm671we+MpDBAp2w2hiy7xRO?=
 =?iso-8859-1?Q?jJIvwKg1lE8v1jrrqIybjG6NjYbmnT3pte4LukRepDaU3OeB6KAfEHvMOG?=
 =?iso-8859-1?Q?hu7ZBrYyRS5GlOUIvl5QlmoO2No2D1ijkEMxnLbTZJ5ehA8GUYzGIMLVrM?=
 =?iso-8859-1?Q?AIwp8uOygT4sIOg3DlGd+UN9aQ0FfLJtyMIzBFMzYUdfZz3t1udlVOlQKZ?=
 =?iso-8859-1?Q?Snfespj7vipa5PzDVnbBnprnRfYO/H9GsjFNR6p0pAaztOFHHuCqSimQ4u?=
 =?iso-8859-1?Q?qllF7Fq2OgqiG+XSj7nRIiaccmzBpvRQ1kHC56DCeIu/7ybp+rVJsfk/YV?=
 =?iso-8859-1?Q?TvA+pMf/o6i5vrWteqHtZrl2ikJCpB1McZjPB/97bEexwtWFzBgUMJTY1X?=
 =?iso-8859-1?Q?6NKhAMfx+1p2RHQYw1UUwFE2ClrcbPlvzL9p8mAAowcwnrmHddNM1Gz1nf?=
 =?iso-8859-1?Q?rN5hKRGfpEtH9VkxbcrGmnqB1oSw2Ob+zGWdfbBsnxGHtDUbZVA9ljY/tf?=
 =?iso-8859-1?Q?JBj2IyvE1SLYFXSnaujz29cL3DorvEgYfMZQ635Kthw7Cv+eF827voLw9C?=
 =?iso-8859-1?Q?QLlMOBmsozV8yOUVi+3xcmFqOdtB863dPMtJSnbMnplhKCDymgcMLO1azS?=
 =?iso-8859-1?Q?cGUkhfYXi4aHJrKZR0iH/AUiYEuYxeozUXy21hsWDymOD6C0pMsUbkws2Y?=
 =?iso-8859-1?Q?K/qtWzrnlY9X1bV41TxeGznEehxKXqFk3LDaVwnxabiqlt1irJneIO4k1G?=
 =?iso-8859-1?Q?Z5uzPfo6nzlIoUAkNPHOBWlin1Cov/s+vc/m+RrQ0BLO8ITvgKLCB06Scy?=
 =?iso-8859-1?Q?T57d2SraBr1zB7RotF1j5rC7Da21QkLFKURJex8MdGYAwVBXxeJKySuLzA?=
 =?iso-8859-1?Q?0dbyO98Qb1jtS71h2qMtCnyOMNG2PfBcxCOMX5vAhEFhL35UqfyliHA325?=
 =?iso-8859-1?Q?xzdmWvdkhhl59ooRhP+cJI5hJxV/PmdPmTg07I77yd3A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zBEQggyhPIghLdUq1c/Fv82q1IdeHZ6tCqsVxZsNGYesE5C4I5N97RftCG?=
 =?iso-8859-1?Q?3ey19HhyFQwwiBK/5Y3w1Rqf+6YrCpL6pnHZQuMNFJC1CFgFWv3rWwm7Qe?=
 =?iso-8859-1?Q?P6Djxb3bo8+c24bn8EPqhhOtX4ls1vwyRtEgtKn4McJDYCJWVIC4d6fUxY?=
 =?iso-8859-1?Q?vZ+Fiyw4vPKZaIagOoz6MpcVPuCdSakj+QDg4Sk6CFJb3qAEox8gwdw/FV?=
 =?iso-8859-1?Q?vH+k5QbXLaSEWE3JcRqcsI140+6lwr4q8wzKFGtYbvR/9cH92NWEfhxRVX?=
 =?iso-8859-1?Q?916GWkiztyRYDi6un8aWWto39o49ZX9D4s9Rbbq2houkgkmOkPGwX+K4xA?=
 =?iso-8859-1?Q?t62pwznSC70X5qiiE5lIbzPpl9LHBh6tElssmSPk+nMMIhfflEFEZKLqXU?=
 =?iso-8859-1?Q?sqCUPhQe6DXuDTZKrfqw9ZMMGNXWZFfGt2COdFvlP4jZ79O5vVL+JOQmqF?=
 =?iso-8859-1?Q?YL0dVHCmLqeOndSr4hVrcZGnpX5FrYorV1VIL+xPhYOzQbunG4NP6CTwPt?=
 =?iso-8859-1?Q?pvfmJLo6M/5f1BwbTFMEytPZAA4CbpQd5fKeI6kciNylZ2Xp0sNFr2/yV6?=
 =?iso-8859-1?Q?qJ5Li5eLTlGGH/Ky+SBDjBMSrT+Ds70UvfUXom433AuaT3vS5h/irUn4Hx?=
 =?iso-8859-1?Q?ONlkvpU4YglvrzXPZV6oOsJKxKwPHJwOZchQN/rrXHKztJf5DDtjreSV2W?=
 =?iso-8859-1?Q?PW0MHxTMm0+v5K0napVZI/61gj6I/oreVA3gfvy3flbLQ26fi/WH2/ubqp?=
 =?iso-8859-1?Q?BZ8UIPVl+3HPiHSdE9Y8GNumwFepbVWrQhkPtpNaTNz00sYbWQb+GJ0Qfm?=
 =?iso-8859-1?Q?43Ztaa+F//O7IwtlcvIMTgG+ZE7V6/BzMyndJcI9WJU67DoBR1EnzE95Ix?=
 =?iso-8859-1?Q?JIP7EFNhYDOPcbHtDVBKAFfbfsgZp+RbktXqV4/1xX44mw6RUkPB0q0teF?=
 =?iso-8859-1?Q?/nceQCjuJALP5D4377ruVK1YoPEC/4lKPbMMr1g0rh0MLu9GIHLlYJlu4V?=
 =?iso-8859-1?Q?NHd52AjbSWA+oTzpFm2KAaf8aJ7mf/Pp6LegfQZpBgTHPmfEUeO72BH7ai?=
 =?iso-8859-1?Q?He8ZjNvoeyI1n4tkMDVbecIHD4jgYXZ3yCjANJdzWovw3Xodj1yN7mwq39?=
 =?iso-8859-1?Q?AxtY5LI2EO1I0+bD7BHhCP9SQ7Sxlcw3COXjWKZsh5P2zp8F3TQce9NuoQ?=
 =?iso-8859-1?Q?kCw/mcZgQd5x3tGLR3x28/JRcaM2Vezolms3FNcQKjg2Ly6OR7E4cVdoC8?=
 =?iso-8859-1?Q?eEzGBUGDzcGQpRnQwvFhU4C6Gye6XCWawD3BnK13khbQfIqYmbVGAGpny+?=
 =?iso-8859-1?Q?OPAN1ZlE5r7j0lWeQFHqJeLa0cf9D9jgi0lnwkJTUIr7S5/vJ7D8uYezoG?=
 =?iso-8859-1?Q?w4fKnO1VE7FzRw78sqzm7oYLXkqM0ylzVDU/+UTy+Zo4zdMxGeZwtwngUb?=
 =?iso-8859-1?Q?92NYmuRLBwi62hkgleiljrsLqoIbGp+7lTmA81bhnsOe+S5/8Yn6AnYcQ6?=
 =?iso-8859-1?Q?TjuAz4uxgDjN3PBkPjZx2/82v0/pjfkWNFfnwFCBsvqx4qxDfaFIWS3AEJ?=
 =?iso-8859-1?Q?f0hth8FrsBPH8GEwTHmVtpRxux6oNr+iPGoMsnte/EaJdRCCq76gPLdKVx?=
 =?iso-8859-1?Q?pxrYYtqG+q1sOVdTMrL0+1f1ccR22F2q9V?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gv4JGUTobPc5qwnjKwWGqACo7iLS2so9M96TQiL0MLQaknB0RPdgQY/w94RoT1c17BrTgd5dDCxg2W08N56OV6fmNBTZ+TRom4gpgYrUPCtqDbeBrZgB4+X5j2ZuOGNsBCJTGnoJY2kJ+CFASI6n6vFQaYBJZuC1mOsjSSjXmgA//6d91Zy32u8iz7eRvxoeFNREEmKfQm//461/AzzIBp6Cme0S9/q5nHSLIkS09rWKWradHqIjeEgw4omA0mR4m5Dqk6caeFXJ0axQsY+ORoRNlJOI8Yhlk5AP6Ry7KGOqSmr6hI67UwS7Vbx5CjXCUgJNT9JZYhHR45S16f1P8BObkwz8Aiom2LdFZy6NXXHYnXjVv6PCuP0ybv4jrTiOAq3jPOTKbsD8BSxz/5Uf3YC9eaf81vvni3V/PWsQH7afiiqMg6Xr9x9acBHMfxKCRhp9Hu3WP9GoGEpxhXrJt8mIL3e5VuHwXiR0Om65GcyyQsbk3HFAeGJOR2iQfpS5jt7vb3DTT4+8BFousA+YmsHdRCnT1VwcmTpxntjQZ9WjHv2BNGQ8ZkRrLOE99JrRhciPB3fk8UG1YnRFmeWGxsuDfrbkBlk3+6wX8MSCMhMKm2Q9DesK5LI06oWZHWzg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de70b73f-6fbc-4241-40b7-08dd83a0082b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 02:22:31.1415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JR6mAzK0yKMujgQyBfrS8QrfLjpO+FxD2Ti6/yMN9EB6//hJJgG1LSEne50vr/uE/DO/prCg7z9kOH9kckOVaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8113

Waiman,=0A=
=0A=
>>>>> In my test env I've added a null check to 'child' and re-running=0A=
>>>>> the long-term test.=0A=
>>>>> I'm wondering if this patch is sufficient to address any underlying=
=0A=
>>>>> issue or is just a band-aid.=0A=
>>>>> Please share any known patches or suggestions.=0A=
>>>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 while (child !=3D parent) {=0A=
>>>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=
=A0 while (child && child !=3D parent) {=0A=
>>>> Child can become NULL only if the updated_next list isn't parent=0A=
>>>> terminated. This should not happen. A warning is needed if it really=
=0A=
>>>> happens. I will take a further look to see if there is a bug somewhere=
.=0A=
>>> My test re-ran for 36+ hours without any CPU lockups or NMI. This=0A=
>>> patch seems to have helped.=0A=
>>>=0A=
>> I now see what is wrong. The cgroup_rstat_push_children() function is=0A=
>> supposed to be called with cgroup_rstat_lock held, but commit=0A=
>> 093c8812de2d3 ("cgroup: rstat: Cleanup flushing functions and=0A=
>> locking") changes that. Hence racing can corrupt the list. I will work=
=0A=
>> on a patch to fix that regression.=0A=
>=0A=
>It should also be in v6.15-rc1 branch but is missing in the nvme branch=0A=
>that you are using. So you need to use a more updated nvme, when=0A=
>available, to avoid this problem.=0A=
>=0A=
Thank you for finding that commit. I'll look for it.=0A=
=0A=
Christoph, Sagi, Keith, Others,=0A=
Can this commit be merged into the nvme-6.15 branch please?=0A=
=0A=
Thanks & Regards,=0A=
Kamaljit=0A=

