Return-Path: <cgroups+bounces-7250-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03D8A7489C
	for <lists+cgroups@lfdr.de>; Fri, 28 Mar 2025 11:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40803B386B
	for <lists+cgroups@lfdr.de>; Fri, 28 Mar 2025 10:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E973A214229;
	Fri, 28 Mar 2025 10:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Nkooocty"
X-Original-To: cgroups@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A31E8343;
	Fri, 28 Mar 2025 10:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158727; cv=fail; b=Z/YUrdBqECRy5OSKP6n12Kt7Ui1M87legZPRTlPFOk7mRWEaRTP+tdPgLpXQyIQEX49aKtpoCp6uhBv6lUQHnwbbG4AsxxcGfxLihbY4qned153KYRy5XHbPvw+LtX03U4VXvgrcBwECuCklfu4aeSvPssTaRwl/HIzBokNk+U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158727; c=relaxed/simple;
	bh=Us1HTeZJKz0JMDW3cQbajFBWOF9x6TAJVcpItqrzuJ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D7jABL4GiYcAxqfQxENbwkaT4Ju8NjKhZxoDiaYLK5QlZZHhfJ7hut6YrC2z5FIOW+21u/cdCXenwqUl4jDKd3JduQUNvhU1HO8RKRIxiCkKxiXVEN4cvl3eG5OiPRsFSGFAeT6evfXGEcdd6cLg6mHJb7xd8+po/6r89eH9eaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Nkooocty; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S6tUq6011582;
	Fri, 28 Mar 2025 10:45:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=Us1HTeZ
	JKz0JMDW3cQbajFBWOF9x6TAJVcpItqrzuJ0=; b=Nkooocty5fUDgJVsoEafGTT
	ItHWTK+5mDxT80hTatfMt/GUbZ+iG6JEMx92+4BeXo8FlGtE/4KoTlL3wJ2jhi3U
	qX6B2P0rpsPjlrnBSm5MMcxuNxGIoMSDXOUfAT2bZZy7k6DUBIypAqKABJ2qvdlG
	IyUH7JJ1GUieT57d4yLGddYNiLOVYVBq0Ry5rGH6lh5e6J3H/10uAMf9XypIpBZ4
	6ognX1afhfZFpW2Sypf3rOhoj+DH4lBQBKVFMQGPl4PykzrUxE+yKbtmrfFJUSNY
	5uVM4NkgX68Tna4SzXNfbJqtN67dTq6Ve3jcq5E6+dNWS4xD4f87yBoi9VYXcgQ=
	=
Received: from ty3p286cu002.outbound.protection.outlook.com (mail-japaneastazlp17010005.outbound.protection.outlook.com [40.93.73.5])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 45hn63e6qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 10:45:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lvrh57tl7H+tu8hSu7XmtyQHR5DwEkzXc31fwklozQZn3KXu+ryaFjZzbNCuPzDFogDOPIopUg4Z2OQKmw7JDzOCIbbhhFMisUzBGvFSO18bUMkG5IlI5s5TSAxl4ZSokVQx9eSzMZ2MZsDtmy+ojWmAjJUqKOeFGKhqMot84prauVdFbAY8Kll15l94XOpnaoECL7ZsWnDUdqCyumlHOlZAOGE3PumXRZo7WK+9+FXDVp/sfFj+1XDngyHBD7ybzEEga7ilXyenXGEM0Ca0k+msd8hB9pzLGS0WcR/dthST8T/s8lckBPvd+xsbhv4U+vhoqxHPashccNhOQWfZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Us1HTeZJKz0JMDW3cQbajFBWOF9x6TAJVcpItqrzuJ0=;
 b=YuoNl0qVWubfVdyFDAC8Ku+O+FdlkshKhqXYATuf5gyhG02+JkZodzG1KRcfnkRk0MkItKv0olHNNPizxrl43Nff0zAcJdq9W45EZ6FsxIn/J4fZETf0WUG9EIzxTSAxle0NAqTJG5IYqfCy42dc/Fnx+SsZNytVyEA9AndlNHpal7r1Qu5O2XI9WsdIbQut/IYsoRCf2LW5FzCnyc+OUKq4ZzJrVKCffLV2+j3+7OgYlgzvwc6/ELgcyjdrgB7GIw3p9lGfEOuyElsgnP3FkKy4yKabYZilGwZBhL+rgnxToEj9whOreP1tQ4szWBWgyygslziCPAOcXrxmwh6AXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from OSZPR01MB6711.jpnprd01.prod.outlook.com (2603:1096:604:111::13)
 by TYCPR01MB5583.jpnprd01.prod.outlook.com (2603:1096:400:40::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 10:45:03 +0000
Received: from OSZPR01MB6711.jpnprd01.prod.outlook.com
 ([fe80::1fcf:d37b:e319:1b17]) by OSZPR01MB6711.jpnprd01.prod.outlook.com
 ([fe80::1fcf:d37b:e319:1b17%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 10:45:03 +0000
From: "Shashank.Mahadasyam@sony.com" <Shashank.Mahadasyam@sony.com>
To: =?iso-8859-1?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
CC: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan
 Corbet <corbet@lwn.net>, Waiman Long <longman@redhat.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shinya.Takumi@sony.com" <Shinya.Takumi@sony.com>,
        "Shashank.Mahadasyam@sony.com" <Shashank.Mahadasyam@sony.com>
Subject: Re: [PATCH 2/2] cgroup, docs: Document interaction of RT processes
 with cpu controller
Thread-Topic: [PATCH 2/2] cgroup, docs: Document interaction of RT processes
 with cpu controller
Thread-Index: AQHbjYTtFFcCGHzYHUi62vR2krD9qLNkucmAgAE5gPyABrFxAIAb27rk
Date: Fri, 28 Mar 2025 10:45:02 +0000
Message-ID:
 <OSZPR01MB6711D710EC3199A654434D6193A02@OSZPR01MB6711.jpnprd01.prod.outlook.com>
References: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
 <20250305-rt-and-cpu-controller-doc-v1-2-7b6a6f5ff43d@sony.com>
 <thhej7ngafu6ivtpcjs2czjidd5xqwihvrgqskvcrd3w65fnp4@inmu3wuofcpr>
 <OSZPR01MB67118A17B171687DB2F6FBC993CA2@OSZPR01MB6711.jpnprd01.prod.outlook.com>
 <2vvwedzioiopvjhah4jxlc6a5gq4uayyj2s5gtjs455yojkhnn@rkxanxmh3hmu>
In-Reply-To: <2vvwedzioiopvjhah4jxlc6a5gq4uayyj2s5gtjs455yojkhnn@rkxanxmh3hmu>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6711:EE_|TYCPR01MB5583:EE_
x-ms-office365-filtering-correlation-id: 19ee1c7f-e55b-4de9-5837-08dd6de5984b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?8UwwuOgYAyJ8CgeablNgbYfV5SXA0x6de+lBSylxo0q2PJkJg4yRtTaL2E?=
 =?iso-8859-1?Q?+p+vfjP94CdW+Ddb2SiaKDv3xMDWRm3l9arpxu8LrLR1SMze2f6+hMyG8S?=
 =?iso-8859-1?Q?l32GGUfPV8LiSwDtG4KNyXl3JkchKzEed0XsqBlalT3VTaXtuYOq0Js2AE?=
 =?iso-8859-1?Q?rCELf6ADXTT0gmUNfak+80/Z8JL+WhOXFiBJtPzef1ZfP/XWx0XXDBewI4?=
 =?iso-8859-1?Q?LyQmTM0zmVBUutl5N3t8HdI191md21epaxEoe0HynhHFhuaweEUMN+Hv+k?=
 =?iso-8859-1?Q?jbi953Fcxqlf4UOz1m62BRQoJD+CMynR1BjPP1+X0heKe5ZPSTsbnN6okG?=
 =?iso-8859-1?Q?qB25l/dydLk6g5hMgB1hLc89SlcN1NGsoldxXrXKDXJkV0OQt/bJTMcgoE?=
 =?iso-8859-1?Q?CbOuhaBDetKS6X2MIoIirSSiUMJDpAKu2X3rw8FYB1ASSIdHogEa8Ye/en?=
 =?iso-8859-1?Q?gliiY7IOHnEnep8xW24u6i9gaa44CBFd16o4/i50wqcqJZbXqLSdwxWOMO?=
 =?iso-8859-1?Q?fHbsQEiYADNv6rpP2CckIgzKw6nfOlUVzkHECsLg0cuEFrS56EQITRmkb/?=
 =?iso-8859-1?Q?+ejNyGZuR8GIG154QNNLM7geUSxt/O5F0OTuVR6vzH7Y23lXoF+BbM45SO?=
 =?iso-8859-1?Q?wLoqyDc/hMZr8PzQsyv/hUrRK2Bs7HKAl/cCuPj6Zwd8lusIQeX9EKBcx0?=
 =?iso-8859-1?Q?fgyxiwqM/g5+DcVbKPqswEjg3t+bzrhAX9z9Sg1Mf3FuRL0p4Hd29zZjgD?=
 =?iso-8859-1?Q?adLOCKElBlBSeYICc3OP3az6LtUSP6I39uuMDVn7v7fLJ7LaQnbQoSuVrk?=
 =?iso-8859-1?Q?QQZh4Vo7bADbmH3apuY41ZMYfXF7CnMbx7zPHgaOzLpcCvoj7azEdMcYYW?=
 =?iso-8859-1?Q?ItymFT2HvFdXzUAEgGAbplpMq/VOMnHH8ocL4x0eZwQnpaloWPrLh+4vKY?=
 =?iso-8859-1?Q?IbOaCp2pQHoLsezrhZPNLJYSCURCNhCRSvhreuqJX3mOiSIq5j0R3tQALI?=
 =?iso-8859-1?Q?L2EiszcVRIHwpQ17dwYR10PO2Z6BJGWve8AsVFayYHM54GexZgcoAGCSrM?=
 =?iso-8859-1?Q?MCzBHAve/Jyf2lKTy9NyrBukDA6kEZoL2P7uPObtLXVMb+/BDBooPHcN+8?=
 =?iso-8859-1?Q?bPvePnMGTLic3RUKyNzk9NfCUv1RSapgvZJZEIVIxjE+RZxOo0qFF/Unpg?=
 =?iso-8859-1?Q?6Dt6cbHU9M7d4dHg95obGDZmAfUhRiYGq7As/OWTSnf8gjt1Voae+xy8JU?=
 =?iso-8859-1?Q?CQOR6e4VanTSGrQjE5kABJLMoOTsgRRYD6jF72Y1aDQJnij3yHroFzJJGp?=
 =?iso-8859-1?Q?ppNm0slsNAYOw1Beor/82eQQf9IAHziYMbuyoUVx2AehJIvJ3L0RSadQly?=
 =?iso-8859-1?Q?n0n2ZBNSrtYMQEyEzDbADIqsTp1a94uZemby8DOZ2I0IMr1HoWMX1bFukS?=
 =?iso-8859-1?Q?RGt6PwgHfajymfv+shT0b/6ezL4rhrRDQ/hLi76nNSXlq2Lr10MOVaKwGY?=
 =?iso-8859-1?Q?4npywQZcn+agnun/FvuBz7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6711.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wZ3NcXPKnFIAkwNHTK0mDh2Vlbmw2MpcMAFe3OHGuxAGifgniPLk1+pj5L?=
 =?iso-8859-1?Q?3X1x2S0l2U/moeMuaVmbI28GDfn/GD98p475Im1ZvI4s9oNsFZnpfGO/oK?=
 =?iso-8859-1?Q?LNtZmdsPwuRnXoGYGeCLkSIzIZMXV6vbA/rr5U7tw1R0KV/88NK/fmPGtg?=
 =?iso-8859-1?Q?C5xx/3Vz4ODbB/VMJ5i03VeAZAok+pzrEt094vxElSFfd5SJiWyYiTrQ/U?=
 =?iso-8859-1?Q?u9ujWv0l5WWMpOnq5wVEwuDngLV6IYE1Z0gRmppWI8wTXdrd2Y1Tc5JQIn?=
 =?iso-8859-1?Q?czM1p3MyT1khZXPxofMa2lAc8t5BtcGCvATbIEnMTUqhsWh15VopAkcG73?=
 =?iso-8859-1?Q?8gwgXjE+BZXsmCqNt0v0PBB20Wv0IkqInVms5Aphs+0vcXHlOFfXrnWwjH?=
 =?iso-8859-1?Q?9Ex+4wtrMNGjDnbJRXFhxU1MTQOBjTz1aEjtvZnhIpG/PAQMZTU+HF844S?=
 =?iso-8859-1?Q?dKrbtP0pmtR+s39XofWTrJljFeCrWGzDXmNVOopZN2HhVENR4ySsTjX6d9?=
 =?iso-8859-1?Q?jwNc4uM7iykp0FzP9h0nEVrgM9OM8Aq/8e6JwPy9fH3pJCmK+bTVGVVAcU?=
 =?iso-8859-1?Q?53bLmELUH0hsF+VZWKsUuI4piiq03wIQZMrYSsWcs9+41xKToB7W49NBfj?=
 =?iso-8859-1?Q?6IYmZ3p4efXo4rwj0LpSU/1twBTkcsXRzgYci6aRp+0WpR5ughLvbNZ1Li?=
 =?iso-8859-1?Q?NwMalqMtCnrpoqLpW93ywkyalC9jB2BWLK8Z3jUbKRcMy2sOwyBe7ZCE55?=
 =?iso-8859-1?Q?6HWWwc3nbBbXocDzQeMyLWJJEcYEgobTslEGylcHloC2WjReltMktlvB5l?=
 =?iso-8859-1?Q?kW7sD4pMhf/0XCfX/1vfGPXVnke0zhqpR9vHgV4zJnyBsazfFV8ZaQ0FuK?=
 =?iso-8859-1?Q?lvGBlrqmzZfDX0BtAyAH5v9ekmCCGm80wd3n8biVU+mfzpaHENFPldYopa?=
 =?iso-8859-1?Q?7qqt4U1YuxaauHtfoJWZWa4/yz1joGHIUuREHDOk3w+HbsSP3LcDIgzJfU?=
 =?iso-8859-1?Q?UN2LLzs8RYC+HjW+cHSJtZG4poUH2NigHTPAulI9G7puYGHCwXcenSRYss?=
 =?iso-8859-1?Q?VfLwNynsI4HpJh2Rq6nEqYqMUWPYYdlSQtxb3pZCwmTslI0UV7L15BgMvg?=
 =?iso-8859-1?Q?ZKEqKXOtc8T9vsu2ghwRDQNgRCzLc59T2uuciAYNaQp6gpzS9ks9Q5ccCc?=
 =?iso-8859-1?Q?YvYDd/OFovAz+ellaWvM1GLJ7hXZRi7myAYjR2kIKy4O567WLYGbPKHSi7?=
 =?iso-8859-1?Q?r1R4RAuS9iAxgG4FaQnoJQyS4FNTUN66rHQrBBT5nS4HA3+iWK8sV76oyi?=
 =?iso-8859-1?Q?xwR68vj30oHvbVMnDpA2V+zNEo5G0EIJgDK2Pl4tegcnqOG7P4rKgW1M6t?=
 =?iso-8859-1?Q?Nn8HBu0LRxQtMkf/KIRDz8oupiXWBm5VqHSBmg+KpPPCy7fgoEh0SGRhOQ?=
 =?iso-8859-1?Q?3qgMOuAj+9SPXULDHpi6GJlWbiIYMVhR4Kv+mYnJsVvZWby5ASOL9um8lg?=
 =?iso-8859-1?Q?KfQZZvOIGdmSEti/48p7mfK6RAvBhqx2wgVvwpivAD5Ik3m1L5QzdsbFCl?=
 =?iso-8859-1?Q?BVgfk73jMwv0UhEoLDKl8j3xW3dc9YIK1w70xNqFUr2eZva1f3qHJXJTvv?=
 =?iso-8859-1?Q?btXldHqnrT1keuB8yAltjSLDdAc1yEKszr26YpN0tDvv7pPj8kNJAF2zgC?=
 =?iso-8859-1?Q?hgPDnLUXeLiKVBBzgnB02HsLXFiErfDsAcqKvJbY?=
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
	aQQD8yTmSKU7qk74CyEmwEqYMvhRfTUGJfFiury2fgUWtek3tePFylX6/J3b47YErzmpU0dAS+zVtarBVQSh8/Gz5EDMrzCQcz8QobFAMnRQv4vZEXs56AWbSN7ldV675Af3b+b7i3BoG3gisivEw/AOeRf2K2ghNKM8oDOWOI5XY7qbPNokz9/s8mSL3nlK4QgAAocj6gEglW7LI5ic2rs6iVfWAu/kpjctMk8GYpiPsR3Bea0381WCsJjPMTGyeTPamUkQqJn94zURBiVwjRwM25lvw2SXIwwNx+5FKNeEMF1LDXdIEvBHkoBRq8CSbXR+ch18lmi+RJKEIlXsYWT1kfdrRKYAoF/Ps8nKaX5bQImR3Eio0sG3pn5AlExrl9Tz75AhcQeswdp25KwZUB56ruNFhmXGcp48iVxP7ilwiHQOAjv2XAKMhvEcdIQN/9KccGtQxJ87oIP/nkHag7tUwVZtuNQPoJMZ+YO/kk5qiTqZKypcsRsFXtvMUE9hC3BAftuyBv0GI5W6TRPnbiNzEPsAKgDAjKAuUoJVtbYqR0cU9NKu9/ZnE7PfQafQAf3Jaj7TKg9GyrDoKBUao2DKw41vmY38wRmS7zrvUy335wXZOdYa2gOMP9ELkxx8
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6711.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ee1c7f-e55b-4de9-5837-08dd6de5984b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 10:45:02.6438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oov0qabc/iZ4MLQAprEvrjsIeyL2rRknFn4rMlfaxiM4qBN++vvB9sJ7riWTFGt5P1IjfRlIzDCj7hHH7WoQ0QtO3ug/5L5RaBrzDNjFo78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5583
X-Proofpoint-GUID: 1tyuvnQ9eRfv03VQ0-DjCFdtpiu5EpKg
X-Proofpoint-ORIG-GUID: 1tyuvnQ9eRfv03VQ0-DjCFdtpiu5EpKg
X-Sony-Outbound-GUID: 1tyuvnQ9eRfv03VQ0-DjCFdtpiu5EpKg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_05,2025-03-27_02,2024-11-22_01

Hi Michal,=0A=
=0A=
Apologies for the delay :)=0A=
=0A=
> On Thu, Mar 06, 2025 at 11:02:22AM +0000, "Shashank.Mahadasyam@sony.com" =
<Shashank.Mahadasyam@sony.com> wrote:=0A=
> > Do you think it should be rephrased to make it clearer?=0A=
>=0A=
> Aha, I understand now why it confused you (with the paragraph about=0A=
> realtime tasks right above interface files).=0A=
>=0A=
> I'd consider such a minimal correction:=0A=
>=0A=
> --- a/Documentation/admin-guide/cgroup-v2.rst=0A=
> +++ b/Documentation/admin-guide/cgroup-v2.rst=0A=
> @@ -1076,7 +1076,7 @@ cpufreq governor about the minimum desired frequenc=
y which should always be=0A=
> =A0provided by a CPU, as well as the maximum desired frequency, which sho=
uld not=0A=
> =A0be exceeded by a CPU.=0A=
>=0A=
> -WARNING: cgroup2 doesn't yet support control of realtime processes. For=
=0A=
> +WARNING: cgroup2 doesn't yet support (bandwidth) control of realtime pro=
cesses. For=0A=
> =A0a kernel built with the CONFIG_RT_GROUP_SCHED option enabled for group=
=0A=
> =A0scheduling of realtime processes, the cpu controller can only be enabl=
ed=0A=
> =A0when all RT processes are in the root cgroup. =A0This limitation does=
=0A=
=0A=
I'll incorporate this in v2. Thanks!=0A=
=0A=
> Of course wordier rewrite is possible but I find the text as you=0A=
> originally proposed unclear due to several uses of "only" that imply=0A=
> restrictions that aren't in place in reality.=0A=
=0A=
Given the different scheduling classes (fair, ext, rt, deadline), it would =
be nice=0A=
to document which cpu interface files are related to which scheduling class=
es.=0A=
Like, cpu.idle applies to only the fair class, cpu.weight applies to the fa=
ir class,=0A=
as well as ext, if configured so, cpu.stat accounts for all classes=0A=
(I'm not sure about this, I haven't tested this yet), etc.=0A=
=0A=
The proposed patch is in this direction, but just for the rt class. Any sug=
gestions=0A=
on how this intent can be made clearer? How about something like this:=0A=
=0A=
CPU Interface Files=0A=
~~~~~~~~~~~~~~~~~~~=0A=
=0A=
All time durations are in microseconds. The scheduling classes mentioned be=
side=0A=
the interface files are the only classes they are related to.=0A=
=0A=
=A0 cpu.stat =A0 =A0(fair, ext, rt, deadline)=0A=
=A0 =A0 ...=0A=
=0A=
=A0 cpu.weight =A0 =A0(fair, ext)=0A=
=A0 =A0 ...=0A=
=0A=
=A0 cpu.weight.nice =A0 =A0(fair, ext)=0A=
=A0 =A0 ...=0A=
=0A=
=A0 cpu.max =A0 =A0(fair)=0A=
=A0 =A0 ...=0A=
=0A=
=A0 cpu.max.burst =A0 =A0(fair)=0A=
=A0 =A0 ...=0A=
=0A=
=A0 cpu.pressure =A0 =A0(fair, ext, rt, deadline)=0A=
=A0 =A0 ...=0A=
=0A=
=A0 cpu.uclamp.min =A0 =A0(fair, rt)=0A=
=A0 =A0 ...=0A=
=0A=
=A0 cpu.uclamp.max =A0 =A0(fair, rt)=0A=
=A0 =A0 ...=0A=
=0A=
=A0 cpu.idle =A0 =A0(fair)=0A=
=0A=
Thanks,=0A=
Shashank=

