Return-Path: <cgroups+bounces-11857-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3F4C512CF
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 09:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EE63B3E18
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 08:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D91C165F1A;
	Wed, 12 Nov 2025 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N432U6bS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MeUULvx1"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861192C026D;
	Wed, 12 Nov 2025 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937279; cv=fail; b=hffa3FpdKuxb+Ho90KSmssu3kSYy7oMnMHTlPxPZGxd0KOC6GSRfA2bq2sJD7h6E9yFvL9zpAwa+HphVn8RoKlnfxtP0BmLpVbVQVbK49H49fa6PANMppQPcK2GKV9emgoktEtmxhUdMj8alv1atOajq2OrJg0k/LBUdLEYsPjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937279; c=relaxed/simple;
	bh=Gr/NOaHoXnXZN8J20W6Z8wrzFiHKgeRKXUg0NdrPvWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ADLFVs6uHOZGZR1GHNekkYV+8Afu8KmxfuicG67B5InAlGNMlC+SBtfwoXVXWso7GXoukUtPWtfsWb3pAHr5nSjEDsykbdMetRnks4HPCy4EWYMZRRpJ6mWoJFn74xqlw3r1ctgG6GdzkK/OizZ1s/XNfC+hJ72PFs7U7yLY1cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N432U6bS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MeUULvx1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC8cXVi025794;
	Wed, 12 Nov 2025 08:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4S4y/c4idXXwe1c5HC
	lny3umpOKfCOsObZ49bjTDKh8=; b=N432U6bSiKrkw8soJQgsYFca1z1pV5YZIN
	sicidkJbYbeXuD88GKQgLurGvmPS3RutmOuGZ1CxIXYK9/P2zGa26Cy4Nk1DmF7T
	H5wF1hvpDh0yMWlr/79lxu2jdtWXixY04tRbARjuKT6/mslXhsNs/baBns8bAyEg
	XqBUVnhpB9Woz9WiKjHefQWAdOMwr1irFIKO33+USWv2SGsKT6cnx0uH5B0Ifwf8
	XZ6Qeal0GGz4pg9eKp7ZCiarttO/h3SEWGtonQ5Tzh7dwJtLt3DN7mg/EyXuQlWL
	z/gAJJ7ZB7xjf1PO4h8lIQ6waAs/NA38MHkdw8lo9HpOM+TYCQbg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acpg681m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 08:47:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC7N1VZ007534;
	Wed, 12 Nov 2025 08:47:06 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaayejb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 08:47:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlVFBJJZe0BbehCqnhExv13LMURHEs3zklehput527p4S9hVqUvWmXTel9STji+NDz/xqVi+BUKPEtQOob+71LOuhJ4umztonlZ7r5734ZNupjALK04oPxSgoulLrbBY/YyuZrLIhw6sw/pl33AhqKoHPjhuNbvnUjOsS84zjVVn+eeOCXtCa9erKHM4uH24OiJFt6jbfkIe4NzSd7mRuecvCyu7EYc58qsQAWLX54OGCGFjL4xRYaHXCDO5SwaF4QM0HLeA6j2qbL0kOtGrNBk8CfmMYfi8x+qsi5GaTBtKEfQ5SXX2T2l9+SArOqqiSQ5ZMP0y/vvSLSGdRkQFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4S4y/c4idXXwe1c5HClny3umpOKfCOsObZ49bjTDKh8=;
 b=ThQfQSIgqJNepB7cB1L9mZZ84Jp5Y8cvieDh75PqzeJdHW2ieuw+xjjp0cmRoEyH71jOSRVTGBcExUAp4t/i+eQs3yW/Es3+GsV5hHrNYiNosXziO0yMIEP4SwcLXqyhBcBOgkAkC8GEAfKvt/B6SScz/ggwrvbzGJhI6OuYWBeRhhEszvxHGi64bMkLKH0zjjMS6URKcXrebC2h8MiSqJtTAz92qAyHsD5bYU5Fjx8iG23zq1MMPh8wbiGC5oJssL1kXbJw5TG2f/peYhRmOhmQmQemkpdJ0XiugX9pu+tFNY2Iu53e4v1u94WAw5XETQtN2R0llmUWpvBsl/kO5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4S4y/c4idXXwe1c5HClny3umpOKfCOsObZ49bjTDKh8=;
 b=MeUULvx1hTQMJsp+jOSGgVtsFBr726y5IvWt7vfQTYm7OtcXBs4wlGapYPVY1yJqjPntIT0ahV96CjaEjdiSSFXdsqNb+KeD4oT27RY3dvkbQLDsruYj5Ouk9sWFWl0hSOphU9Jk9FKxRDFJXpjuCmkIVdX+K8OWCheYSanXTnw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 08:47:00 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 08:47:00 +0000
Date: Wed, 12 Nov 2025 17:46:51 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
        hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
        lorenzo.stoakes@oracle.com, ziy@nvidia.com, imran.f.khan@oracle.com,
        kamalesh.babulal@oracle.com, axelrasmussen@google.com,
        yuanchu@google.com, weixugc@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
Message-ID: <aRRJe3PzN3cmgvcB@hyeyoo>
References: <hfutmuh4g5jtmrgeemq2aqr2tvxz6mnqaxo5l5vddqnjasyagi@gcscu5khrjxm>
 <aRFKY5VGEujVOqBc@hyeyoo>
 <2a68bddf-e6e6-4960-b5bc-1a39d747ea9b@linux.dev>
 <aRF7eYlBKmG3hEFF@hyeyoo>
 <aqdvjyzfk6vpespzcszfkmx522iy7hvddefcjgusrysglpdykt@uqedtngotzmy>
 <8d6655f8-2756-45bb-85c1-223c3a5e656c@linux.dev>
 <aRKqm24Lrg-JnCoh@hyeyoo>
 <20251111084900.babaOj0w@linutronix.de>
 <jzihvbb6w26d4codfigy2o7b2h26izb4ahihouw54cvuzau54d@jyaa6rgpzuai>
 <20251112074930.mKu1J__U@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112074930.mKu1J__U@linutronix.de>
X-ClientProxiedBy: SEWP216CA0084.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH2PR10MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e630cb-a1c5-4f29-e562-08de21c80b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qjZVNmHCKMyIvZ5imGVUx+J+hs12XxD4sY4aikrnsv3tpHmhRizwyj7ROUMi?=
 =?us-ascii?Q?OvLQcc7PY+G837IfhlJ+FdrnosT1zY+sOMGGhR24xTdqk4YDhXHBEukz3O8R?=
 =?us-ascii?Q?J3WUYSxMwvmHiDXBDLlyhdGefOXVlKjUfhYBpOqWY/jVpWm6PgVGrGi5MIFj?=
 =?us-ascii?Q?oFS73QuRmG+NqNhVscsZpRSKZD1k2WURmB+MEIWnqOYwsp4b7Bq2XXPr53tv?=
 =?us-ascii?Q?VbmTJtGPWaehkQaw5baJhC+bdDilt9JOU/3q4aqMurTDxAhJ/SHDkNbz9Gp7?=
 =?us-ascii?Q?yiSWYkbwAXuvyIO8f1HgnoxB67xrxJCaI92p8XlD49k2CST1ROOR0u97TIrG?=
 =?us-ascii?Q?UK2iOxV1TSBER63bP3FmyK86gZ3U9eqPs1l6W9ECRrm+sCNWGY2T3v126r6k?=
 =?us-ascii?Q?WuMDWZUmVu6P6uRS/jCuOO3j4eN4tvLfw3L6vvH+vM+80bP6HA6bGFU20J7a?=
 =?us-ascii?Q?IDDQDEDsCS+uf5X//ex6rYnBCpTDjI+Xo3dP6UtgjXE7IrYCHm9xnF/ldiE7?=
 =?us-ascii?Q?E/+ndTVOGrZe1YjD50KQOSv78xLkcm0GUF/4M9qqkSbrywdqQ7lN2JoEvh42?=
 =?us-ascii?Q?7nzqyicWV0WwM1hle4Iv4Ryb6NAbGk5YihLN9lgr2mjJZhu2mZqf4Np+L/E0?=
 =?us-ascii?Q?7+w/PTUF16SBy1FOEOJuYUlzSAaCftL7oRUV4JgtNiRcsJoLAKE57Rvj4gNp?=
 =?us-ascii?Q?iMd9MUiSseJB1VyYQix09d8OBIMMAc3+kMpf00uS//CGAfFW66PwtXSxM4P3?=
 =?us-ascii?Q?m7elhwiCcKvITKCS1Gkl8hfG7OioE8iaDgSmTW/cGRtwpLxW4jG1tyNcSMwe?=
 =?us-ascii?Q?v8s8aXQWkUfLQKVbOQT7apBqnq+vS37ZeZVK1pT1kD6lFX6BDNiUED7TjbYd?=
 =?us-ascii?Q?2osdpIgMUhMdRlvoNFt7XFrytAVRHd1cfN3/eU3rl5QE2/6zgFtW2N9DOYA5?=
 =?us-ascii?Q?/qwVc8v57bzJ76Snbntx36VJPFAhSyMYSz7WaSW30KPzuJSYf0XSU9UxLsLC?=
 =?us-ascii?Q?v2Sa7OSkCVSiqrngig7pN/nV4zHgNM8vbCDEFje4jU7OOjFshILx9zYLYLYp?=
 =?us-ascii?Q?TdybAMUda0nX3DHe3ZxQR7Eq5kYzZ08dd3Ao89XVlXqbWOhYqevmnhr6Hrtn?=
 =?us-ascii?Q?wFgFSHLMG859flL/iJj8ZEkleTHBYq1TP4Ds1XvkVbIvmSMDnsyJpZ/y6GzJ?=
 =?us-ascii?Q?/Jt15iFpDS7SchlYsL3sJoMTgXIccEA+pxf+HeBGaHY7B2E44gsIy+jLQcLB?=
 =?us-ascii?Q?OUC5Vnfw181A40KcAgfQKS6s3cH6R+epuywlWHrL1bgMyPBtvXFk+H9KSWIF?=
 =?us-ascii?Q?cZeS6dPAY6cmzDmyUlAB30dtWN+x+T6lQP5qhU8P7cxfjz0sTND8oYIPaVxt?=
 =?us-ascii?Q?+AFbXZx3zbXp7SESP1xeBPrI0v/Y4qi7zQ2CDNfWszXR5cv+I6j4RrBwZuSl?=
 =?us-ascii?Q?lyZfW+oeS1ebF/uJKPDVdQa89r845nJb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ry8HgmWy8ZJY+m9zUp6taLiF1Lkgk8wKi96N2UFbfmTAGJ+38i7PlLNCs3tw?=
 =?us-ascii?Q?VhkmW69i25Gy2fhnYQ+8QbkjY+dCpIysHbc0edTTyvaw1Mw6aFXzBLb8joM0?=
 =?us-ascii?Q?rLxYoKKGzBf96bPuprIELAQr5uwKZZGhLx/c25P/H7TYMgU6nXFeBwI+NeUx?=
 =?us-ascii?Q?nwfLL1Cb/u0dEfyHDUZIY+4S2hLZ5S28JwLmKpfY5K7oitrb3oXofgcXGGaL?=
 =?us-ascii?Q?aiy28lvV3NsD7Kw9gsp9Kxjj5mIvFI04p676hxYZX/kfLLLDF8XHr8PW9mdu?=
 =?us-ascii?Q?VdrC755NMhNaB6Pywn++lh2Vk0IOLvdHZUUSRGXkLjk1S7y2sMUCoxpVfH4y?=
 =?us-ascii?Q?2XjLsIp8kM6FreTlxJgSE3ZpbivdogsyVomNoOZ7uOESwgJFRtJwjHjiJh/h?=
 =?us-ascii?Q?ej8+9E/sOsGRqxggtwVwGq8c0vB8C+IUZchnlpUk0e6j9q7lzF0q9LNR2alx?=
 =?us-ascii?Q?/GoTQqVHrnJwBefD2vL6+hpzvrQedy7k8oTHPAECFVx2FRnRh7gpy++rfrMW?=
 =?us-ascii?Q?iFJ8LVlb2zYHC+OYiGgGilUFcDNaM8m66Cy7QuLby3RkqMPDU/d7MplEQFgR?=
 =?us-ascii?Q?dtf+KGfrScpiGId7kByf9z7CiP84tfeeM6SLmpuPFYDofmqKqFxrhP34GTrK?=
 =?us-ascii?Q?K8N78+mNi/PHDiAW1DAs/5+YY5xzZ3z7aGLVxAZSIi0PiaJiOdgaLDKqaBy/?=
 =?us-ascii?Q?AcslNQ1d+8toa2m+fBQPnb97hJd9N5h+HrDNuzorE6xPLjEViRe+Ja2Z62/M?=
 =?us-ascii?Q?bjNju1VEYOv5BdEdsr3fpgkh3kzE+hMqyKDbx4+mPW0yU2ZwNjh5Pf70X+9Z?=
 =?us-ascii?Q?YIoAAGqeNjl7EsKvkDCsrU7wOU8IqYMi1Rq0lpHC3jq1tuu9EQ6nR9/1LH+n?=
 =?us-ascii?Q?IuSM5Xg8eWwT/bK6pBkDaEKxGG7KF7pTZTxmnJUV+B59v/7qrDH64wGYw87c?=
 =?us-ascii?Q?gt3zcqBoNO4gMwrrM/6+mirS5Kg0wHflowWV1rTvficXXvvR2Rgjkxk19EIB?=
 =?us-ascii?Q?j3UJ55uPWrr72CqUca7tvVNRx4+z+C7Ar/VSgdpexCLIWBY9w5Ez/hDkYxRD?=
 =?us-ascii?Q?Kr+8C6Gt7JqDAUFQLRsY2JXCVktZy4NGrqNtbk7X5Wq5ivGeoDbvvLD6Kc4J?=
 =?us-ascii?Q?Bh5dHdzG48iMRgURFNcRKgSIQ/3FRbgJVRiBGiVjjopgIIDgWzKJioG8zYvx?=
 =?us-ascii?Q?m2+NVxdXcL+HJb5UdVFnUdYxG4mmzC3KEnh4maUvGyht4QHSg1DOCho42iCp?=
 =?us-ascii?Q?7kanBtZidM5vPfIjsaYrGVsPEzszluElEetzs+iV+HrtKTydO2pcT7KD3kpB?=
 =?us-ascii?Q?3NEg17O7tfwLAFtAKAvVnQ1viaBO3C4QkRaJnFaUOyAvQzRmJbqVOfT2m6+b?=
 =?us-ascii?Q?UJnEs0mMKGCZJl2GFWxUJfgZLRkPxvqJKGk62c3rqet24k2SdWPT8Y1rSqxx?=
 =?us-ascii?Q?uTEjz5WQcXp5qrGmoOP1bur98BIVfLyAt3lD7T/aXrJNkdrXf/w/NYX4L0jR?=
 =?us-ascii?Q?wPQmlmWgzngWH0ldafm784JWAcfNgYQ6xP3yOlGrdFF0uBu5vMyp4SN80Wro?=
 =?us-ascii?Q?mLmlg2GwJgdQagt2946HRND+mj0q/iSoSBj2N0oB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hyBslb4bqAxVrHZqaGQoYNfSSbt3nFAM2p/F8wB8zrmCu36IWiiUVyqbCnJACVplpzz7cZdCy8o9lCkXPU8Y+mnncuI+cu4/fdHNqAGA3OYxkOFGDvTA8U51ivSFCKyOYnWu2/ApvjRqdlqbQESXkAaYmrHPFzNLjrHwU/4yFcfG1AElarHLsAI6wBCAD8TZkgLissQa/c6p9MzjtZv+ARZx1Rr3xMy55gxqBAcJgylkHNuZjcHon8XFgyHGyDStBoD8QXDYEiEiTDqKV5SH0+rsKbOAldD231b6HbbtqZrq1fAl/4hHrL+Ify51qSXHiphkvzOoq9K6C4ot6V3L9Bmjk8hSRW0w7j9lmIRHcjgmjicFcZsxTM8Kqt6ecUlqQUyVgSzXEuHfbftL5IaouDm7qFy/Ike+P8LwdAsFkTlwLS6SwYg1wXGdr9cdG/vZ6eQE/TkIf4nH/DUJEspV9xfuxE2aY0NMTL6AVJ6Ugx85nqgeV96MM6BCE/vXYm2WJB4XdSW43o8D9Ixd5UmmduCAZLOtZjDNrzSD/tMDZXFRJfPaZXAzvlTzunU5nVpacj2l1oav2Yq3DNk3G2zibpwrlwg6mAgI6aYOuaeR1SU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e630cb-a1c5-4f29-e562-08de21c80b13
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 08:46:59.9925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3diuG/f2Yo2N7YEkbscyurLdud/wtluSwkP5j7JtrmO8PyHspD1YXHHjDMMAhpxponhYGbenTblw/dLBaE39Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4312
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_02,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120069
X-Authority-Analysis: v=2.4 cv=FK8WBuos c=1 sm=1 tr=0 ts=6914498a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=hP2J8AhH8-oPSbiQFgcA:9 a=CjuIK1q_8ugA:10 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: HDGPil0VG6gYbd0kaG7yhrW6YbmOwfDY
X-Proofpoint-ORIG-GUID: HDGPil0VG6gYbd0kaG7yhrW6YbmOwfDY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA2NCBTYWx0ZWRfXwb2c6euzE8Zc
 mAez53DSQw+imghQB+MfBdcb86U6lBQTqatiQhx/F0Ns932IAP1DaHajPq5JOYIIJNnwGCPOct4
 vzYOidRy1QJU6YI50TIyKwPeeBzsucfzy6BphaLej5fIzDi3UhH6ehlctq2HXHoy+sV6gwYBteU
 2gS/tuUHzf+vizltw09Q/gCB+cvSzOcCVK7UJIrKOc/c1fGSHhOF8qZY5jg6SQlUGzY7/jTSuBE
 cmHnFfXUC2hsM8iywor0RkJxgB5WGd4qtq7J1L1Z8RntfbooBv5L0occeSkaJSbt6Nc4TkKmiLR
 oht/jMMTIFCD/fpnjVXIWCqXPA3aS7x7aix3xR4iSpBkQ3LA52bPipwrTPlrC/Yx3MgCjX83yjD
 wyy7Lmr/CBf8SNuHyLq0eCdUCBU05w==

On Wed, Nov 12, 2025 at 08:49:30AM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-11-11 08:44:14 [-0800], Shakeel Butt wrote:
> > On Tue, Nov 11, 2025 at 09:49:00AM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2025-11-11 12:16:43 [+0900], Harry Yoo wrote:
> > > > > However, in the !CONFIG_HAVE_CMPXCHG_LOCAL case, mod_node_page_state()
> > > > > still calls local_irq_save(). Is this feasible in the PREEMPT_RT kernel?
> > > > 
> > > > Hmm I was going to say it's necessary, but AFAICT we don't allocate
> > > > or free memory in hardirq context on PREEMPT_RT (that's the policy)
> > > > and so I'd say it's not necessary to disable IRQs.
> > > > 
> > > > Sounds like we still want to disable IRQs only on !PREEMPT_RT on
> > > > such architectures?
> > > > 
> > > > Not sure how seriously do PREEMPT_RT folks care about architectures
> > > > without HAVE_CMPXCHG_LOCAL. (riscv and loongarch have ARCH_SUPPORTS_RT
> > > > but doesn't have HAVE_CMPXCHG_LOCAL).
> > > 
> > > We take things seriously and you shouldn't make assumption based on
> > > implementation. Either the API can be used as such or not.
> > > In case of mod_node_page_state(), the non-IRQ off version
> > > (__mod_node_page_state()) has a preempt_disable_nested() to ensure
> > > atomic update on PREEMPT_RT without disabling interrupts.
> > 
> > Harry is talking about mod_node_page_state() on
> > !CONFIG_HAVE_CMPXCHG_LOCAL which is disabling irqs.
> > 
> > void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
> > 					long delta)
> > {
> > 	unsigned long flags;
> > 
> > 	local_irq_save(flags);
> > 	__mod_node_page_state(pgdat, item, delta);
> > 	local_irq_restore(flags);
> > }
> > 
> > Is PREEMPT_RT fine with this?
> 
> Yes.
> The local_irq_save() is not strictly needed but I am fine with it to
> keep it simple. The inner part is just counting.

Yeah I was wondering about this... and thanks for confirming!

-- 
Cheers,
Harry / Hyeonggon

