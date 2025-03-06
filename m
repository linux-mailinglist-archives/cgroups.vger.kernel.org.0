Return-Path: <cgroups+bounces-6856-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C611AA547A7
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 11:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4FD57A6577
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66FC2040B3;
	Thu,  6 Mar 2025 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="EovH12x6"
X-Original-To: cgroups@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B941FF61B;
	Thu,  6 Mar 2025 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256633; cv=fail; b=Mg3fHU6SnTTphIijcFXV4rFKwxguuwjZBs41huov0qw4Cf6dkLK+JqZ9KsS62UFuK7HtA/CRnnNF6gmABPwQwINp1GcFl76Rnt76WyDsW/YoYeGk2htnQ8RFvt/T7a/dCdfIk1cqKwnlNFAOCaOZGULN59hBnT6PcBr12g9wJig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256633; c=relaxed/simple;
	bh=4yHwNB38T0SdPLyWMiJpW0xyWNjHeoHCOqEH8C6nZvk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eTteviFyColfx4w2RDglcjIb+Z1YN9qev/b/XBBw6frsvOhEXcy+5oJLnpovQjGHXgCa9IHOV8xzK3qX7rRkh7T3QPfadftHXFGSZFVxl7ab1ZM/VmyKe6Smw8YexXnWLLGR15Gp35aUyiECjdUEH4Ac47E8VnfgL/sIpbqssGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=EovH12x6; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5263c1oN017428;
	Thu, 6 Mar 2025 10:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=ZckIHBm
	Vwsqm8josT8MhkR1vdzxnzkj0K/GB+NKHbCI=; b=EovH12x6cx9gyMFWra7skzN
	RzuDycKYucSMONwGcA43PxtQ1ub+VjUDA0sW8i3nOlgzIVDMUtSGmpFdbeN0gs0L
	7m0fAPMEgqkSLeKiu4yWdUQVBWRuQB7nRfClsRQRIOOUVZznyvj65zYYMtDNsIdx
	u3m+kOhykJYbPNaeUW7loIrw45EeP5SNGp2h9irKbEUphRez51QJgQ3RlGYx99oG
	i+bVnk1+2wRVuPrvC+9WtRpOyk/grW9ejJwdu6AA7itlwvyE8sbo3vjkq3FfzZ2v
	9Bjw5Il+K29bhoMIEbwC/mHC3r6hP8t8od42BQX38I4b3fixCyTZCjv/WtapU/A=
	=
Received: from os0p286cu011.outbound.protection.outlook.com (mail-japanwestazlp17010003.outbound.protection.outlook.com [40.93.130.3])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 453ua1vwr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 10:23:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HDZIAaNvcl5dnXq8kNJzIuApE6bfv8127VRtYl5FhXGgPyhQ+R246XKebyaMstRBWZR/l1F4StrB9ooE0MlQJ0kwotG85rJCstY6hUCR7vLR2hScaZc2ZKLRlJqe+1mOtN+Rv/up/ZvzpN3QO83Dr1ZdRc7kwb7MoiToPKCHSFfEdp5sLIzPdd1d1a6mYy1d0F0I5NgAL3Br4m67rp/hU9WcntwKHOzmHbzzXBa7V2fkahnDiAQcZChfKcTjSimB280Fd5poR4tZXD/I22xxVTL/jjCZ3ttrucFjFTxfE41hOicSdhSwlJlG22l4zKtYuGAnIbt0zrSAtwWbL77S+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZckIHBmVwsqm8josT8MhkR1vdzxnzkj0K/GB+NKHbCI=;
 b=lkpSMhdfg1e1UhLbn2ulxTQ6jXlvzBrHJsZnZb7yTioDIpZNuLzlRFFg1757185PjfF80I1pj+54JOkmWG75tGFWNn8YXbUAk3T9OdP9q5eozrZwkdsTxL6WdFg4xaIsrbAv8IletOOfVfEYhxob80V4k6DKPvTcPhRvU4Ea/k16orAaUdGq0X+XGz+A3s86wu1kPNYX9lSGYqMEz7/OFj3lh902J3G1ha1PuZkKFx4jlOJPeNtWLESd5mgLLAFr/09D8TRgdMzmjhUoaeOzm5BUZB9SnYUJBaei3RYv8JJ8KbPOOHv26xcg937RXcmDdlnvrxpCdv6/v4EeTAU1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from OSZPR01MB6711.jpnprd01.prod.outlook.com (2603:1096:604:111::13)
 by OS9PR01MB13291.jpnprd01.prod.outlook.com (2603:1096:604:313::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 10:23:03 +0000
Received: from OSZPR01MB6711.jpnprd01.prod.outlook.com
 ([fe80::1fcf:d37b:e319:1b17]) by OSZPR01MB6711.jpnprd01.prod.outlook.com
 ([fe80::1fcf:d37b:e319:1b17%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 10:23:03 +0000
From: "Shashank.Mahadasyam@sony.com" <Shashank.Mahadasyam@sony.com>
To: Waiman Long <llong@redhat.com>
CC: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shinya.Takumi@sony.com" <Shinya.Takumi@sony.com>,
        Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?iso-8859-1?Q?Michal_Koutn=FD?= <mkoutny@suse.com>,
        "Shashank.Mahadasyam@sony.com" <Shashank.Mahadasyam@sony.com>
Subject: Re: [PATCH 2/2] cgroup, docs: Document interaction of RT processes
 with cpu controller
Thread-Topic: [PATCH 2/2] cgroup, docs: Document interaction of RT processes
 with cpu controller
Thread-Index: AQHbjYTtFFcCGHzYHUi62vR2krD9qLNkl0WAgAFQ0Oo=
Date: Thu, 6 Mar 2025 10:23:03 +0000
Message-ID:
 <OSZPR01MB6711219F264C5EAC2CE1512A93CA2@OSZPR01MB6711.jpnprd01.prod.outlook.com>
References: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
 <20250305-rt-and-cpu-controller-doc-v1-2-7b6a6f5ff43d@sony.com>
 <d259ba35-a4a5-4e01-b539-85f2080fdd33@redhat.com>
In-Reply-To: <d259ba35-a4a5-4e01-b539-85f2080fdd33@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6711:EE_|OS9PR01MB13291:EE_
x-ms-office365-filtering-correlation-id: 181e379f-bbba-436b-3a86-08dd5c98e0de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Fx9ibtd0LnoxKYEoxalcnpQq5zZuHaizzhThoFdToQtTx4WyxxqBuhn+ZO?=
 =?iso-8859-1?Q?Si1FW+l06lnjtAUkojLfch2Ahj7WPqcX1BVvu9pNzvj1636LPWoJ62SJhB?=
 =?iso-8859-1?Q?2fyiy6V5cObhWMYrWZPsICb+qne+u2g52ub7VFcg+nWi8KCf5aWeXb7Djz?=
 =?iso-8859-1?Q?3cS5P6ZuAY5+HAMWE5wOE65Gs5viJPoq/EyWihVmDC/FlTsh4n+ET3cHo5?=
 =?iso-8859-1?Q?Q91o94BXnb6MIv5oEXcCCdH+t8puwLDMXns5rxG8SJIprTUAmbTIRHt3Fz?=
 =?iso-8859-1?Q?yFQMKUl4c1arWieQFlvt3ZityBSS4sKuuzDJGz2luwbo9xGrnQTNS/JHR/?=
 =?iso-8859-1?Q?DjU22khSrDzlTXPZY7e/A3aeNJi5lKN9RzwrrMULu8D5ZlQdcUr8YSVjkY?=
 =?iso-8859-1?Q?5qUsqu0qnRAXb95glZcq1o7HLoCCjY0a/eBl0NzSdMLTWxXBdKAlnI3cSV?=
 =?iso-8859-1?Q?9ek28ftHMiVWdcDmJbPLeJUmiCFeQxv62go36STxYRJRS2e6fTqqv37mMm?=
 =?iso-8859-1?Q?Xrr/nU7yQq106NLZaDIX6rn3YuyKH/w/hPCyIOgp9KoXxSDmieN1q1xq/d?=
 =?iso-8859-1?Q?zPnjDq6kKe8T0QmWXQaEreLFiSeQ7sqIZrBrq+DdLURTkttK8zEof++2BA?=
 =?iso-8859-1?Q?0dNcF8nWFyefxPglCeYOxB6Z/AWB46PALMQITSt2qZc4LNEipIaEZsGKAW?=
 =?iso-8859-1?Q?M1RwmBhbK8hcvzjOqaGVQl5pvyc3n73p4DLO1wgZGUbiN04Doh4oBXk0uN?=
 =?iso-8859-1?Q?N9FqiCEM7xomiP7NZkOa2b5AVn2n+CsSeqvy1wEOlToBSduGzPGLIgDUvP?=
 =?iso-8859-1?Q?1Jwjos41Tq1mS2yQoRV0HKFAZWAGqpvpSOEZXlSQIRmpCfVg5ZTJPG3CNh?=
 =?iso-8859-1?Q?DO/mVN98VhgLRkiNovm0vLWNJGEOdTlvvIcRO3LzU0VAI2+LIx5HUv7CGB?=
 =?iso-8859-1?Q?P91TP7kjuCpWIOxhjVX5bZUn+j/pq0hILKAmJnXICBRqeVJBDqrpb3PGDZ?=
 =?iso-8859-1?Q?qS4k/E7kleuLrrgHsbgBzEe1MNlLJ+GdC6b7QgmcD3ywNPGaUPYhWZwsJE?=
 =?iso-8859-1?Q?4NeQXtuxyJV4SixnBC6i1UJ/jF8rPxhfByMdYeAJj8b3JyV9hmhIxrm7jT?=
 =?iso-8859-1?Q?ZnL7R3jW2hf+VGxEyTuILAVnWezgQlFqodWMFT18FkfnPJ2ebjXhp3FDBX?=
 =?iso-8859-1?Q?EzNRs4FifsjUAIyqRqrHg4aOPbX481ylBMLR93gzXst6xJCYNb/5rNDHTI?=
 =?iso-8859-1?Q?odge+T0OshnSULfT4JhfNvKoTeq7LmRlvZq7owZA9AvIxOsqagbDkyPrEM?=
 =?iso-8859-1?Q?ff6fxvnYfuJSxf01kRw6ykU+hGOlYAOMPkU2/ZK9OEKVvMOxF3628J4n1a?=
 =?iso-8859-1?Q?VHxUebKlFDnrq1E0hDi4HmBpWoZTd1vo/zfZEQIgr0UMWfEZJLAyADhpt0?=
 =?iso-8859-1?Q?3Kz58TAB2w0DSWT9XCpZLSTJYQ3IbkXqpHKg2Y8ob6nMwqF4tezzsJs95Z?=
 =?iso-8859-1?Q?zDdXWQmXtBMzLU88DjMeXO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6711.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?418LKn4waZ3RT26+UHthv8yX0KPqSjwrcakj97lpGzAD3Jyu5yDKByrWMp?=
 =?iso-8859-1?Q?/Rf+ZHD9GaQdrfYqPmDLm3il+BFmWDlvPk8Gpw9r6SfnHJ3B+S/QhmTck/?=
 =?iso-8859-1?Q?O1BA0EIDwrKP0FYA0w2XQIi7KKp2xJEpgdxnrf6OeA8ze1T9kLTnd3d1sf?=
 =?iso-8859-1?Q?l9EUyEejvOf9clF8uy36sd9h5orKO394qK2a/92Inr9Vv6EKYm8XY9zfTr?=
 =?iso-8859-1?Q?HW2q62anBQnKosaMEYa6xPtkY0FtRohSDtzZLfC8vgqssrevV0iO2Z/aKc?=
 =?iso-8859-1?Q?ysVdnYcB1xrcvfij7nZeE978sjZUomoiSYAIJdMsLiXtnTksxvWgSeDpeY?=
 =?iso-8859-1?Q?9KRbnHnK49FUBG5etFxN/5HDAHxtlmmnFYDnblzNksAfX/bHZ7On7ZhiG+?=
 =?iso-8859-1?Q?vIqf+UVVuH398symeUOF6P4/H1i3mm5ljVelYOCiEM6jGJ8srFzUf36Rzy?=
 =?iso-8859-1?Q?HbDW4K0IrbRrbAcsn5PelTohFI6thHCRMp7RDS+nfMvJS95x1YGI2RAb/I?=
 =?iso-8859-1?Q?EAcDybzcGeAClDr2PgeWhHAIf40WS3c/p0WqJEus93udsXWbTQ0eLW3nLg?=
 =?iso-8859-1?Q?gddOJg8KFc9U6hH8gT+8gQsUWj4IvEaSA65gc5nkPy8tHYnXbUmYBptNka?=
 =?iso-8859-1?Q?XV1+60fVUs0A9JzVHAEQVCbrJtgFLtchkwse8nzeEp09CbZOO5/Zeqc4ej?=
 =?iso-8859-1?Q?Ant1uO2aPWDtgJ6O1q1UHlpd4wNIaId6x4BKUdEzyC8AG8sENidNDxkTnL?=
 =?iso-8859-1?Q?nHvdWOVusP6KW6tcfw02b5cJhL2h8u/nBVrqNwtelVgOxL6vxDAohnQiC+?=
 =?iso-8859-1?Q?PZwyrVgkIAuTDx5qvrT9xbJBxCMyDFEOrVO7sdpYkD2T+cfTZvIN8JFkzQ?=
 =?iso-8859-1?Q?+dghtGRS5Rx0Y/nIptDxs38JaY743lanyY5dxGFOKmZkNc1bLkuqR+5PUU?=
 =?iso-8859-1?Q?enFbwY0hn4xy1sRHzMfBqCqQoKWATzkgU2PlqpOiTNnntfCbGp018oIqlB?=
 =?iso-8859-1?Q?c/88PqgyUOhP41NwQK9N68Z/jQmedc74tOrjOdxwe3z6WHflG25cVRF0hM?=
 =?iso-8859-1?Q?8onTv35aB0uuLlIqyM28Dlm1DuMPiqVR041XvIoh78mler+jiFOksuFgIm?=
 =?iso-8859-1?Q?9DeHDPxD/PueI5rEvUGH0f9JpRm55KmFjDODvYAGahZH1kgbj2UcuLu+2t?=
 =?iso-8859-1?Q?syuVKE41pMqePmDw2+xDXQk3ivXhFFSxEnLb/XbqOBnycOY9eUstmDbSnW?=
 =?iso-8859-1?Q?GdeDQd0YZLodUtYLlC2Y6xl4UC+1dbm2vFwKBRRrijnPDTiTq5MoCpuYQn?=
 =?iso-8859-1?Q?c7GJ2/kBxne0NHHQm2SBRIXhfqB3f5Cg7j48dqwMVqi0DYmmHClTj9oNxl?=
 =?iso-8859-1?Q?q2Lc10Eb40G/izPPUTBGV5tWNqE03ERk4C2bxXqI6cuVTknjFkEYnPBnh/?=
 =?iso-8859-1?Q?vA5rwHDyyyX9TgpqdYh4Oy979gHWFETIiIQcosOUfv8GJ0QPSJ0gXH9bic?=
 =?iso-8859-1?Q?LXDaVw8Lfhvgw6OJKv1rNRWNo6ELHEU8DR2p+DkNL+JrvTOWH5tqYQ1jFy?=
 =?iso-8859-1?Q?ORl1xxNCuHhxBO5ftY4ebomFtIt+l4EB1LF0/7AgnVyENQ/mhESWN3H5gM?=
 =?iso-8859-1?Q?LddxHwLrv1MU/2m9wcq5fFsz8dheeeVPCKX7+NK5kRgROt2zrsFDsMDQ?=
 =?iso-8859-1?Q?=3D=3D?=
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
	mlfJOE/X6M4JWWfpTlv93lfaHNnQEdp7hvAWXz4+9G1tri6B9F0qtCsUssR/tnaHLhDlPMDQE4jDFnE/acza7x9PbQOp/I06Jl7zX/F5k/80UbE53pCz1M/N5v1mfNFWcVancEQC13mdMa9uEOAhE+hYmNo7Wcz3E/u9bKhjK2HtbzlB9qFUGsUrlhuFUvz0AdvXI+5IF5RHHINsoTGHcyIlGjmVX580mQGF6ogOKhaw2HbXW5TZNGxebuYeV7Fe9+fzOlvzBIoIhEa26GINvsgMhZ9vI2Grhz6OkqgDeIZ6oaEx9h5ZI+nzwO2jrkTSbBhLfLSTI4aXSTNZ/EJKNtkygiZDgGSPGP44em6yFpQ34oB6wA6Z1WPOhgyhN2IN/YNb96WzG/pIjNh0Zti98BLQ9ogiWib+NV7y6MkP0b/DrK+o/FgPCz4xam8RPL80ozeB1mVwFC7YMJuFFaZ7wdE3sjJ4j41XxknnN9B3USFrMLEbt25xUNSP/TaJI9Lj5x9EJmNlftZYUxuu6Qlrk0VSDtvIdByK2I4azYGaMGKiy+Y9z1JGFuCJsgE6CjUEaL58eya1IYmwM7kmmmoHOQCaWI2y+FezJ71IZpXx1hSEqqXeqy08U9f7vkoB/Ej1
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6711.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181e379f-bbba-436b-3a86-08dd5c98e0de
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 10:23:03.3619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fz5uXi5RRR3fI1Qyh2YEvCyd1XQPnz+1jPgn6T54R8GM7nrLZihZ2/Y57B73xSkmUpbU6PHGeguch6BQ4+iXF+GkmwlPHPrwStPhBeKZAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13291
X-Proofpoint-GUID: gXhhjY7TFNJP4ian6iKlxgDnGq2owtQL
X-Proofpoint-ORIG-GUID: gXhhjY7TFNJP4ian6iKlxgDnGq2owtQL
X-Sony-Outbound-GUID: gXhhjY7TFNJP4ian6iKlxgDnGq2owtQL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01

Hi Longman,=0A=
=0A=
> > From: Shashank Balaji <shashank.mahadasyam@sony.com>=0A=
> >=0A=
> > If the cpu controller is enabled in a CONFIG_RT_GROUP_SCHED=0A=
> > disabled setting, cpu.stat and cpu.pressure account for realtime=0A=
> > processes, and cpu.uclamp.{min, max} affect realtime processes as well.=
=0A=
> > None of the other interface files are affected by or affect realtime=0A=
> > processes.=0A=
> >=0A=
> > Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>=0A=
> > ---=0A=
> >   Documentation/admin-guide/cgroup-v2.rst | 18 +++++++++++++-----=0A=
> >   1 file changed, 13 insertions(+), 5 deletions(-)=0A=
> >=0A=
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/ad=
min-guide/cgroup-v2.rst=0A=
> > index f293a13b42ed69e7c6bf5e974cb86e228411af4e..2c267f42e5fef9c4e2c3530=
ce73330d680b9b2dc 100644=0A=
> > --- a/Documentation/admin-guide/cgroup-v2.rst=0A=
> > +++ b/Documentation/admin-guide/cgroup-v2.rst=0A=
> > @@ -1095,7 +1095,9 @@ realtime processes irrespective of CONFIG_RT_GROU=
P_SCHED.=0A=
> >   CPU Interface Files=0A=
> >   ~~~~~~~~~~~~~~~~~~~=0A=
> >   =0A=
> > -All time durations are in microseconds.=0A=
> > +All time durations are in microseconds. Only cpu.stat and cpu.pressure=
 account=0A=
> > +for realtime processes, and only cpu.uclamp.min and cpu.uclamp.max=0A=
> > +affect realtime processes.=0A=
> >   =0A=
> >     cpu.stat=0A=
> >   	A read-only flat-keyed file.=0A=
> > @@ -1115,6 +1117,9 @@ All time durations are in microseconds.=0A=
> >   	- nr_bursts=0A=
> >   	- burst_usec=0A=
> >   =0A=
> > +    The runtime of realtime processes is accounted for only by the usa=
ge_usec,=0A=
> > +	user_usec, and system_usec fields.=0A=
> > +=0A=
> =0A=
> Alignment problem!=0A=
> =0A=
> Anyway, I am not familiar enough with these cpu control files to give a =
=0A=
> review yet.=0A=
> =0A=
> Cheers,=0A=
> Longman=0A=
=0A=
My bad, I'll fix the alignment.=0A=
=0A=
Thanks,=0A=
Shashank=

