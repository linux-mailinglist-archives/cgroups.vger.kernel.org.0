Return-Path: <cgroups+bounces-14627-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIZmACD/qGm/0AAAu9opvQ
	(envelope-from <cgroups+bounces-14627-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 04:57:20 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FED720AAF7
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 04:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15D23302E868
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 03:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE7F285C88;
	Thu,  5 Mar 2026 03:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KXjLoelo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xgwH8kMW"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633392690C0
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772683035; cv=fail; b=t/xmxwdixBO9jfkGH+Ab5BoCKkf79vMb+FcAPEk0XuuQMywtCfJltW1asd1GTvuICfz5rqpQVfKIjLM8mRhCuf4fFZYuTnZ1SVqrMCwtkH7XlFj9Ii4AtgfjKoSJK54TntWooSyX4EGToyCS23iOIYuEh06eNuHZkwrkwkgcKrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772683035; c=relaxed/simple;
	bh=9Kb5Bv9UTEkj1nUFPcbwwmPPimgQ1HOWzSDFLvclDC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hPChzkmb51I/bmNiwBvhl6O2rK09Of0ZJIOG+NbDfsIfTQS7MPiIftQT/DwCm07L8wtwqEPxDfOJJxSUKU/CNDZTHdtW/TQ2YtmEK+50VVJeqYWVreGyHwR3K2OwWsvQvNcF3Pi0roipToULfHV6btIMtZ135u+ay94HbmcxvSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KXjLoelo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xgwH8kMW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6253mN0h4044280;
	Thu, 5 Mar 2026 03:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vtPMwjUY//n/LbOZdx
	gzAqxXpCzhgqfyjy8BnehGc3o=; b=KXjLoeloZW18UrbpyOCZQDssbLnTBPudhd
	iK4g/X7XAJjLe6xjd3LkucSv7EoWkl9Ih4oVZygpPUTNEuGjB/43X7IBweOr7PpQ
	J3f5+XnGS0ud7p3tXk49w5BVjM3tKollgHKJSw7pDNT63UMkbfNEQPWJnFZic4n4
	ibpo6EJIqDw0uPl9Nt6F9DqjS2zKRfTboSRmuSD9jEWf26uzgbkUCwgY84PhqGEs
	go14f+n39rFSn6McVvC8FH1jpT36n3uuwIRhQeuS6dYTkHNMJuQ2TnPU8jUwsSh4
	tE/fNW4eSQA4sD+oAiFHrEYHPR9PjZGxonRTiDmHIfQNf1ccq/sA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cq28f806d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Mar 2026 03:56:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6251U1Za001441;
	Thu, 5 Mar 2026 03:56:50 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpth0dbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Mar 2026 03:56:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRIwtGLPY/XhU6ALCaQIMIRH19WeEd1LeOp5RSQUWCsAyhqNtCLTSeZjoixyjAMHiYPQ3nos2DF2Ete+mVxTWe/887kc9cTExwPD8g4XBcsYGHGrMeF4npyPifayBoO1L4UY7hjO6mce8xsdDrGhOONlR4fNIIe43J7QbV+G8Iqbh4NfjrBn5zLBHWtEl38Hh/bOCsqn8LPLg6A5q5E5u+/AbwGA1+BtJFnNRxj/JWofvNMpWEx7AnAlRR5zWkZ7ot/WRngiMZCPKzxM2XvbVWkH78Nl8zjQ+6JpXDKtcJC6Gglfw6VWBdYODvjbOHvK7EPIgUOmMgLCyQCnkP+mzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtPMwjUY//n/LbOZdxgzAqxXpCzhgqfyjy8BnehGc3o=;
 b=lgyyRAYyRD63wEzP64aIkbGZ1p3NywTJlpagywdMXQ24qRW0ZCuQMyt09jiMxxQxoVxAOxx5/JI88dmPlU8Ys2oPE/fGvEdzS2Ve6wTeNfOTk4HT2WPCWoMYjhI2y2A+Qr6Ua5Kn4476FIEedMLq20ANmrgoKvMdrb1iZsbu7ocM5a1DksjBHWrlrRBOpBhf8ygFkbG8uLxKsvOGeRvmsrpt7s/RsSeBlpw/Rvk0rtp0QpnBgKAz8/Tc3FVxCXMnjCLKvSQntatU3kobwx4wu1/ykYJUh6dmlhrYpZX0x1HGGRrqv9QK9n/nKJiRpgqbEB3FwVfalrffkMd+aaRwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtPMwjUY//n/LbOZdxgzAqxXpCzhgqfyjy8BnehGc3o=;
 b=xgwH8kMWOuP68v/agTKOvwAXBSB3eQbjD+79CEGT0ZoLTH9irH+9usJ7ARJkyUvXZErs8uGFUVwidhous2VOZTupt/AUeGN5sne9bqIpU5X5B+JLSOwqKniXSJ4w7h42tTtX8Efguf93ttikj8jRcxCmehzA1kK+ep+UCZFnkko=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA0PR10MB6771.namprd10.prod.outlook.com (2603:10b6:208:43c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 03:56:48 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 03:56:47 +0000
Date: Thu, 5 Mar 2026 12:56:40 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hao Li <hao.li@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.com>, vbabka@suse.cz,
        akpm@linux-foundation.org, cgroups@vger.kernel.org, cl@gentwo.org,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        shakeel.butt@linux.dev, surenb@google.com, venkat88@linux.ibm.com,
        pfalcato@suse.de
Subject: Re: [PATCH] mm/slab: change stride type from unsigned short to
 unsigned int
Message-ID: <aaj--Lej6kWE0aV-@hyeyoo>
References: <20260303135722.2680521-1-harry.yoo@oracle.com>
 <fe9dacdd-8b96-4375-8730-8fb9ed5fad60@suse.com>
 <5r7p6pelk4u5c43kvuxwi75f5dr6msx3x7hapaezourrpgvkr6@jlala4o5z2xf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5r7p6pelk4u5c43kvuxwi75f5dr6msx3x7hapaezourrpgvkr6@jlala4o5z2xf>
X-ClientProxiedBy: SEWP216CA0139.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c0::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA0PR10MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 407497ed-80c3-40e0-3914-08de7a6b3960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	daWzcaGJu/xXxWP9Qh0GgSLI0U/PqExVYgHxRScX1PVNN0QjK0PTWY+Ipvwa9wcjFRLnO7xFMNQe1lyccCwRlOOIF6QWuBIShWsBXCSNmaZys52J1OUmsMna+iby3+3wVUPKn6l3VVmpNnIJ/SIBh2Kmhp9uCYe4ykrPWXQ8xwaf2HiNzjpuuGNRcClvbzJ0QwqLpFG3ZhWBATSKdbR/Ona9wL0/8g4nDo++5g0gPP3z0BjCPPisCtM9UIwHkNi05KOIa6XgwuFNEaz66ZRQcOjwWwloiYBopU/ZM8zX6ChAoGbL65cn8Dfv8dk0DK0gmYaL4SptU1zvHL62mz67DWsFPn0idLq1N7Lzb/jnuTijKNB0NPZ/IBC+BbH4lQVTdaNtOHlzXnIrLhe4V5NnJ5zIGFi6xM98BYzEzvusBCIlrtvmj6wN0eZGa86DZfpTehUjoMsMb3H2nT/nBldM9WXRH1k3D63f0A8iXu+WqXMeNM6LaS6whCDeNCB6SQ/zxVbZezqPpPc0zRqOhtPeRphwMEGCMx7/YMqzbd2SZOTEn1je7pJdRUdLsVfldIijVKuCt/QN4hymTFG0qp+TxQ6I2h7sFoqYpNCR70Qi1RCb4949K4xmdWZHSsMgXjvaLDlZkXLEQAXStwWHIK2kCtWU+ty5pTpn76vblA7hKhXTZ5OX+n4OF06ScSj3HIUUeqf/vdFPdiu8jubxU19r6yrvLL96HJGr5LXpcetWkjkMwaCf5JNB9KQYG+8KeYhL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yf/UyLfFdwuX2W8Te83OjJWSQkb3RhKsBmxzEz5yL8UbTfyaTdQ9AssOzeBy?=
 =?us-ascii?Q?sOIdTLAvHtx/Ht/kth4d8QWKExK4gI1uiWz5+wCLgGqvwAgwJ+YeW5PPkmiS?=
 =?us-ascii?Q?K4bfi6mirVfP1pi7535yBl7R9RxH7h/dymfQbHP0l2F3fBqOlwREfd3TM5qP?=
 =?us-ascii?Q?exBmCsE3y/v+vhRjrJ5L2jzjkhsmQiO3R726zqfz0HrkaKxVNq5H8s86qEkF?=
 =?us-ascii?Q?YoG99vCCsW8+sqY3oqPkUftgOOOIhdLIITec0RUDBzDvXS1uEFCEewnZxVrs?=
 =?us-ascii?Q?nYrT+FGpMb95dGYuj7yL8/zx8Tu5Qjobbzjpi79I55f+Fl+C4pDVJ+5QpBGK?=
 =?us-ascii?Q?vAdIx9V0aT9IBpK07HLh08ZjP2TkcIfwuZRGK2h1aagagY/kn7rsNM99PjAd?=
 =?us-ascii?Q?VQOjvDdAgfg/Ht+sAKpKJe+8kPBfrox78VwhYqPz3r0YJvnZW/vyoxQbapsZ?=
 =?us-ascii?Q?iVyBdvRKDD8oe+F/1i14AL2kxnoqwzz4puFssVDtTylL0+uLou1zNU5ooO+T?=
 =?us-ascii?Q?i87jcjT3DVPPuDah9ETt7dDWA5v4f98vAf0lNGUsLzj+yJIJ4LDcAwdzUqGU?=
 =?us-ascii?Q?7BE/DQyCrEGftM2CXiJrvRw9JxZlvQQ4lQyeanu7yJgN4GF9tgFL/wWi1UUx?=
 =?us-ascii?Q?2+PIAxK3EXqII4vt2MVjPYfg1h3s4qJLdlKREf+JTny+qdZjLTZhpAqudfyW?=
 =?us-ascii?Q?wWDdtNO+bQUZGyUY3p7CdIc2XsaLZIz84YOmK2rSH5NwT5l2DY+29DLcLdA/?=
 =?us-ascii?Q?YFLoLAed+PcUQXDPflG2Mr2uf/5OYN2yCvPGy+BkUNCYAkNBupw/Ok/heuUJ?=
 =?us-ascii?Q?FRf49Pyhjab76MiocXWPp0j97lI7iXBVnl8hmDlK/vS+5W1ml3gfEDviKLez?=
 =?us-ascii?Q?MBmm41M4fCIKoKZe11rePlsadvgvsYvmdNPtaTMBbUCGKlRwcG3+q0FiyWZZ?=
 =?us-ascii?Q?0131/uDOzPIzGHU+7/dR7PQ/zC43xInM1G9116brphdvXBomn2xorMhPLFRq?=
 =?us-ascii?Q?skqssRg2jI0d8NEU2GEKA2YbDLN5pLnhO4Cv8ZUEnbFoXJPLZ+Kk16C+saGI?=
 =?us-ascii?Q?CJyoTIeWCrTJOYGtj79rSHbLXQwP7XeH2LVBWPM1RE4DlzSWJ3tyf01peB5L?=
 =?us-ascii?Q?hWFkEVo8EiUfTdJihlz+H5edekqYMLWxIdNviNjofmpRZV3+0ej6PwxANNav?=
 =?us-ascii?Q?Bpc33F91PCUvlXh8kIZQf4OYD1LJtE1z5aBLdS/npG5dHcbJIKR5Pj9TUPhN?=
 =?us-ascii?Q?+FHxSnh8zmfwnIbggEQ8ukHlW5Ft7xM89WaxsyEDxPVgOlOp3OeycrqdND8K?=
 =?us-ascii?Q?XsONAu4JdO/8/41UNqYlYFcfW7i8ANDusUDM0RYPXFdO5+KoDveGIrdVT+sO?=
 =?us-ascii?Q?5BO9jqHdfhOo0fcurRbkYlOA7hEm53suIhiJkuxt9YGAaL4vCugdZSzjUK4R?=
 =?us-ascii?Q?bYYVGgv//7sRYhSImTfL7+3gLkhTnqYG8jw2XDCqdCsC/SdqcfCRVPlsBWro?=
 =?us-ascii?Q?/rpmO8hIcMulQo7uk0PKr0rgSRqkkzHXGjwrxFcg4Bwswj5jEao2vfncKaNu?=
 =?us-ascii?Q?eUp8MzDdGWF7ZZXg4N7E4kOSxciHGeuVOJ4/ahB4H2V4RsWmO44ZiERa3Z2C?=
 =?us-ascii?Q?BqWNSZHAo84mF8RJQMgkg24QTIUPCP+qeBakfxoXrysACKWkuqrxPKIMecsm?=
 =?us-ascii?Q?HmABaF8bg62vi8Kh3YgodgWHSK41tu3EkObt+tBQylK1NEo9uBGpTKTLUERf?=
 =?us-ascii?Q?oW3xER6+Ig=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	esS4dlaeaCXMESSiraFeHTHtuETtGToSdkzBFH/bVNSNS9nDmov5+bVwva/JrePWMl6In8NGARdpd3CN+WrFF4dHFuPEr1c3k8noltPhs4hFPio7e4DfY+4Ldgz2u3iJbnzAwqX9zTBZdUVPBzBkYKQuxzyxJs3P/WQqk7i316Xqhir0WaApOH4XEwaslwx9KcWeO1/IIEoRvLaIyQxc8y0kc6kT1nZLqQHRIG9R4hj5OSbFDn8K+NRQ4m4904wVVCDuyocgvCCNg+omzfWWoSk+sLrinJAHQWKhjWcOer1n2FNT3lS4uyg4ZYprdox2WZCOzC/zZz2p6NmpPRxxgw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MXCpu/Txz8vmodNP+c21EAnaTDBnO0du3rZJpbj40BLp/weqqnBbnuYQgnH6zlU06rF2AvSwsXpAdM1JelXs7giufhfochOgMfiQMtpQ9mxt5c7AItNZ0X6mxPhuHDOwzQ2/5oG0/6gldR3EYJFcQ4K+oZOJE/zSVLNqQ3hOb77mfgGNern5iVMXcSNQxV3J/vui84b08p1TgaY4Sn7Edbcd+M855nyu9QxH4DIPX5Ej3RdyqoWxBhvyN5EoWH5WTd8y9GydPCz0B+HUfZetVO9oUdJEPD1VcSWXF/w6Mh6JtgHO//SKfwV5ATfHL9iFc+idphVPItWsehXo2IVw+9R0xLIkQB8Mtwe8cYRO0p/gkLOlH+ENsgYDFL7H2ng8vT8cbsSz/Kkl5ioYoU7L35Nn+xQnjhGTCXCFcOq77OazBNUupd6J84A6TxAZYb+mXoMy9/nxhn7umsB7CZrvZ3PfTCmrqWFmpWk+yIPu9JvnLkw6xdF3vEhUxrfhaN30nnZn43cGyNlrISTLk5cgiNrcP4CFdQci+IwL+lbLyZbrHMDKTnv3mmbQSUUbRJ6cRt44ShqnNkpNmTIxA/LUjFZPSiQrfDxGZrD9V1KXS44=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407497ed-80c3-40e0-3914-08de7a6b3960
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 03:56:47.7579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33Bt0lbLqcaMRyZIlw+chOgpetqgdrO6xR7QzhAGrA/a50kbRJkdbbWSwuKTZgg+rBADK0HbrbpCJjZK4S2MsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6771
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_09,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603050028
X-Authority-Analysis: v=2.4 cv=UMjQ3Sfy c=1 sm=1 tr=0 ts=69a8ff03 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=ELS0WAB775T2GiA-jOwA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:13812
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDAyOCBTYWx0ZWRfX0Iwc/znS3LmK
 XC+Tss6WGLKGsVEAqTrokSbPYZjghj8NxYDHZ4EnpvXQ4xjovF2gCwRcY7UEDXy8vGp7lauzIyP
 duS2TUUraP/p7onTTSd5siInHzGvPGpg0CogdH0Er72BL0/KZbMC5PHW1K2Xpz17kLuOc6H7pmq
 fjm/xpq6TsPqeSYhCZ/fCNtFvFQfhgFMDMU+B3E/5tx4b9YbOZji4boAvbP8hgwLiycX46mJYFP
 6WjPP1/ZrEfxkamkQnIO3nk+WTA9MpQRAlGvcR1G/Jp5D3O12OYWoOUpcwARpRKFERJB8ejsG4k
 deG2ZJzo7yL6JZnEFXDT8Z/SNnG57EypIGuWZ7aXfcFIEk6igYKlnZj8t2Yoxlo62phDK6VEmBH
 8ONyp2roaiDCGg864AuHovQ9ufmS9aJCnHsRpxMosSYpnbZJ1gHZBsaE7SH+f2eeSnPcMSW1ZVe
 qzrOdGtjcjKKcEwHpEunMsZlehbv2tvLR8IVM7UI=
X-Proofpoint-ORIG-GUID: QOX6q4WPu1700VC5PyZ02Oj04tJipr2A
X-Proofpoint-GUID: QOX6q4WPu1700VC5PyZ02Oj04tJipr2A
X-Rspamd-Queue-Id: 6FED720AAF7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14627-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 10:51:19AM +0800, Hao Li wrote:
> On Wed, Mar 04, 2026 at 11:17:46AM +0100, Vlastimil Babka wrote:
> > On 3/3/26 2:57 PM, Harry Yoo wrote:
> > > Commit 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
> > > defined the type of slab->stride as unsigned short, because the author
> > > initially planned to store stride within the lower 16 bits of the
> > > page_type field, but later stored it in unused bits in the counters
> > > field instead.
> > > 
> > > However, the idea of having only 2-byte stride turned out to be a
> > > serious mistake. On systems with 64k pages, order-1 pages are 128k,
> > > which is larger than USHRT_MAX. It triggers a debug warning because
> > > s->size is 128k while stride, truncated to 2 bytes, becomes zero:
> > > 
> [...]
> > > 
> > > This leads to slab_obj_ext() returning the first slabobj_ext or all
> > > objects and confuses the reference counting of object cgroups [1] and
> > > memory (un)charging for memory cgroups [2].
> > > 
> > > Fortunately, the counters field has 32 unused bits instead of 16
> > > on 64-bit CPUs, which is wide enough to hold any value of s->size.
> > > Change the type to unsigned int.
> > > 
> > > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > > Closes: https://lore.kernel.org/lkml/ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com
> > > Closes: https://lore.kernel.org/all/ddff7c7d-c0c3-4780-808f-9a83268bbf0c@linux.ibm.com
> > > Fixes: 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
> > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > 
> > Added to slab/for-next-fixes, thanks!
> > Hopefully Venkat confirms the fix and we can close and try to forget
> > about the memory ordering can of worms again ;)
>
> Oh, by the way, for that earlier patch that added a memory barrier, the
> reported testing results also show the issue no longer reproduces.[1]
> So, could it just be that it didn't happen to reproduce that time?

Indeed, I think so.

Although the original issues were not (mysteriously) reproduced w/
wmb+rmb pair as Venkat reported [1], I observed that the debug warning
was still triggered with them (experimented locally).

Thanks for the review!

> [1] https://lore.kernel.org/linux-mm/84492f08-04c2-485c-9a18-cdafd5a9c3e5@linux.ibm.com/

-- 
Cheers,
Harry / Hyeonggon

