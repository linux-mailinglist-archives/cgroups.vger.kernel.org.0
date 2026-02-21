Return-Path: <cgroups+bounces-14083-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMEdN2dGmWnySQMAu9opvQ
	(envelope-from <cgroups+bounces-14083-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 06:45:11 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4784A16C361
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 06:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC8923037988
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 05:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F513009DE;
	Sat, 21 Feb 2026 05:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kXV36NZW"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE13314A83
	for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 05:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771652709; cv=fail; b=Qx3mER5csf/5SedooOqA+KnLLbFu9M4GaLm3W1NX40irmRb7GsmmNuFHor96TgWLLGQekuC5GWhMLFn2rzmJ/y54S5bq8QjNUrMzAPSvZH3PvsPxvQKooH7+bXiOQxIb+BySu9dOJu3h9Qw+itsGYxB4PMRddaF8KlfcSVYw9I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771652709; c=relaxed/simple;
	bh=6uWo5rWeBRK45EKsNDpWF7cupocX25CLLCouJMjzyGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WTgOM+bWq0Y3HswfwS0IT/9RcuNnGsW/zMJoFjhbhdzw5Xy4AGp6carIufQ1hgK5D6MkyfiIS+xvmRtN/LyNhb1hNprUxuCUdlnDKZ0NF0yqKMvJtP11Qpiv8A4Mqr7hE4Rgn8AMWabyKaLoNTXKHlo8KsFyP9eT6ftoeLU+JDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kXV36NZW; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771652707; x=1803188707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6uWo5rWeBRK45EKsNDpWF7cupocX25CLLCouJMjzyGc=;
  b=kXV36NZWIS2OOOzvHv4k8Q0icjUtidAv8QE9nBRIIMEQS1rW4UaymRrT
   OgavQ9iGzduWTgdbdRgxtinZZB7xO6vWhrpmhw9c+5pILWo/XXa/DK4f6
   9JX7Z6dhh41W9tSvvSBvkEEQTNOnp1Bt4og2vTGBu+ylDUPw5cBJMQJ9f
   8LMpVgL7SIWDhNcCiNtpjEpAvaMfIRdqDvo4SB3A4tzbqqFK+s28eMB0J
   JsF2Jx+QTH0PIbGAh6tBDyKfCsSigPh1t8zQ3Jk0y/fsVjiaFSyQ0JmRh
   NR2XhQeKCH/smm/B7twKD5KCxdZRdhFwo2fAKd7Ma+DLwYyqMb274yxHX
   w==;
X-CSE-ConnectionGUID: GE/dN4hnTWKSWLeQgtYgng==
X-CSE-MsgGUID: JVb+4HqHRCiCTp6nCG3cJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="83839465"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="83839465"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 21:45:06 -0800
X-CSE-ConnectionGUID: 2rHSnDYpQR2tPeqel0asUg==
X-CSE-MsgGUID: AizuK0AQT5+gJcQBt6Tlkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="237998414"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 21:45:06 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 21:45:05 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 20 Feb 2026 21:45:05 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.60) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 20 Feb 2026 21:45:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y94vTvatzGBuNqUtw7WTrILfvjbDGprsnudk7o7Lpk+zOzQxrNEJL8s4VbG8/TjdpNtuBaiOLjHuXd2TeAXhfmn8njDZK15Hdr0SgWIfh24jZtvcHjS/JT57y86pE45/QLLanRqIW3DWpZIeTGzr8SrVRc86SpAekb8ALkxagyGp4GSUPZcg1jK99A4ps9Fwq7sn5SRpe5+R56unzJ0rXHJefAqlj5rNH7aCnTqzAh0KuMmWlOxshczxrnjp6RtthgDOtMaRwqkVfumWAvP7ds6K50BQfUhEUGXYdWSRu9qz9MTN3zHaEf1Pr1foPhoMrc2ALqkWhpgPHshAicPCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObRk/PUN4iXYUXN84opDz9EVq8qqWq+VxJPBWDv6tDY=;
 b=B7Dxqz686MSORAKk9ncco5WjwMBbuzU+kbYJQyD3iYQbzRol72gNA+GABF49OSl3Xc1W5Lfgp80dLGlVfMcarZG5XTbY0LuWwU82qxvDDwQUGPsO+cClie/G8GJC4x7O8frjzfNSpHcE4h5ddBQLtC7ZM62Mqim8fjwi689A3+jH99iHn6hFPlFdcuEA4YSQ1EDFPRiMwkx4BZz4N4e0XjrX8Jn9XsGvOFdrPbZtpvQDn1lwu8yMNIWgXWeWq+3604kHe4B0elng3as3sr/K9Q8v3PoS4nXLRZTest872p3XeQ9NH9p34VZwaH3a+AVXeIp6F9tWO3r1fmC9buCeOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19)
 by SA3PR11MB9485.namprd11.prod.outlook.com (2603:10b6:806:45e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Sat, 21 Feb
 2026 05:45:04 +0000
Received: from LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5]) by LV3PR11MB8768.namprd11.prod.outlook.com
 ([fe80::b22e:7955:ed0d:54f5%7]) with mapi id 15.20.9632.017; Sat, 21 Feb 2026
 05:45:03 +0000
From: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
To: Tejun Heo <tj@kernel.org>
CC: "hannes@cmpxchg.org" <hannes@cmpxchg.org>, "mkoutny@suse.com"
	<mkoutny@suse.com>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: RE: [PATCH] cgroup: ensure stable pid sorting in cmppid()
Thread-Topic: [PATCH] cgroup: ensure stable pid sorting in cmppid()
Thread-Index: AQHcou8CwtCer08LG0+zXk6qCDC9p7WMos7g
Date: Sat, 21 Feb 2026 05:45:03 +0000
Message-ID: <LV3PR11MB8768B0A29D442DD409E6D8BEF569A@LV3PR11MB8768.namprd11.prod.outlook.com>
References: <20260221034907.2110829-1-kaushlendra.kumar@intel.com>
 <aZk707rPX4DrQIWb@slm.duckdns.org>
In-Reply-To: <aZk707rPX4DrQIWb@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR11MB8768:EE_|SA3PR11MB9485:EE_
x-ms-office365-filtering-correlation-id: 1e5add8b-f630-4cfd-1894-08de710c5c6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?dEFXgkyCwxR6+uLPhUd2FkppSRfmPEtW9cnVrsbi24iZZsntG+8KT44WjWQ8?=
 =?us-ascii?Q?8xvW09lofSGi1Va+CEUGs+vsaRgKK1VeAcN7s6jgD16vlORYxlv2hR+3ZBkI?=
 =?us-ascii?Q?UIgj3ng9Q9Q+7IYcGKfdq4AtEDGXFgoelT151Q6wJ39QsAXQkqsr8LTK38NC?=
 =?us-ascii?Q?3U/TEbo6DHod9W00CyWTtG8uHmWp1Ea3VYU7Pb6sCo0IBYIdtodsBaIXwwtL?=
 =?us-ascii?Q?IVlkfnvwx0xcQRkun3BUGwdGG4bkc9F9lbS0HL6uNUJgKvGzjk5NgCNT3PAr?=
 =?us-ascii?Q?+mZZV6W2Cty3JjugZKne3Uy99+tnQpxKXnD7fDkJSMiuQ5dCLpegqbhNG/lV?=
 =?us-ascii?Q?bkn2IQZXBM3wIMro75AslziAP4wcgYOXeGpePl7RdzyQ/L4TzuLJdHEs0jx5?=
 =?us-ascii?Q?cUZ48BM93aMF6TgofrwCPVpCRxNYuWd55kAIer24lsl7KO/b6do3ZkN/+4ju?=
 =?us-ascii?Q?xjd8ISQk2J3w3KXFguj2L5DWkwBnSZUewqG9mma6SB9wrH6Ld1mq+rikdj06?=
 =?us-ascii?Q?+Z4R+4jiyYM3pFbPum71NjQHdw4xY4Txduf2pKhLXILRY9qLtjBau4xMZyaN?=
 =?us-ascii?Q?pRoSY1KVRVT8EoY98hdCZqBKZ7TUTzloOaSjGxDN0u/d9SAlasZz2gLFC+/F?=
 =?us-ascii?Q?6ewrj1UwSj8+lH51zNiLGj728f0MXil8l37/KAXRw8iPJHo7BpccFOTRgzHB?=
 =?us-ascii?Q?Fx4ZHPW/0jkK9jH880Ki7Q2+CukGLzWVLb6LoDzp2C+mpph06FxRzu4Av/98?=
 =?us-ascii?Q?3iC0c103ij++1ZYpBS+5U6wluqB30F4BFNYWee0byKiwLXKV2hHbTn25TK8H?=
 =?us-ascii?Q?DWXD2GdEDVPreOl5phphSjktNHWZ39qh4A72lBDnDH2hdS35Fye7lXlsRwWN?=
 =?us-ascii?Q?0YAUKZ0t6mBrRed/iRYeycuIPOJrrQwTGkVieYx7txHG9t6oLsIGJK+aUeHO?=
 =?us-ascii?Q?Zto8fFFhIdx0N3Z4Z4ARdSzV5j7y4JekKwFxHpfayNL1RsZY9neR9mCKMYyh?=
 =?us-ascii?Q?JYUg84D5MH4DB03dWZwEPXMJn86wTZjIRuGIA5tCP8DWgzXln21g8XXk+Dd6?=
 =?us-ascii?Q?hI85GO06AX51EPTuk794GCTobwzWKaMFCZUsUKAeJsTlK+PIUCoEzCP4mxYB?=
 =?us-ascii?Q?c+MLZRXNC/XxXRSWmk2Eshs2PBtVLhM1MJjKzTMxPEm+eVqbe4wTUiF6/eMJ?=
 =?us-ascii?Q?u3B9XqsqrM+hgvCUn2XxjySFlLjAIfpDQYyhHmZehwR3XxHEBqZrWUejwozu?=
 =?us-ascii?Q?+fRrNRiqexkk9gs7Y1vMZlCaVl0dovHstDXTKOCfGVS1D2Gy0/+rZLClst3/?=
 =?us-ascii?Q?g8xsOTwTeN/+BE6Pi2Fl7R2ZN8wNUusyHIsXmlsWK2T8rrm1RrfSOczgjTCb?=
 =?us-ascii?Q?NGEJyFYXY/vHRdtyKbRZl/rYxmmGkhEFAkdazQEyA3ZU3puz3htOM929SPKn?=
 =?us-ascii?Q?PyuyOQcvDDmchBP9RRngGmbG4Vl1uvIbuHmCR8YVrdIYn0ylGy8APJVQxLCL?=
 =?us-ascii?Q?HUbOvLexDEpcJhUjoyaBH/gy+FGNIuB5gpaA0+GBwDfCAqfjzC6fLCoIv7yM?=
 =?us-ascii?Q?nt5LECDloUxmfVZFp09ReHyhsluTLtlDP5d5hicNgUcaWBa0cqEUHXbZx1pF?=
 =?us-ascii?Q?BGBAkjkRdtVaAuWVejf8U9g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?02ySZatNqDXIaj1rkXda0j/OEmWPI3USiSKJpHcW8GSoeacwlhsjHCV/MAmS?=
 =?us-ascii?Q?Z+rTQO3o469JmL+zrsSS5TQVxLleC40B9MQVsjOO1arKlD5Qq1/sXNLG2NPX?=
 =?us-ascii?Q?tPeXu8a+HTZkS08De2buWEKKLqUh3+vjbWIVI4I9sm3Pa+yZitR5aCAxHSWl?=
 =?us-ascii?Q?dj9ivOfCD0Q4FuurLnnRquU1GuykRcrhoYW2Sw0CuzWlXdd9SrgAazEg3FMF?=
 =?us-ascii?Q?fO8Yy9I0E7G5sIymEaQJEPEj16/c5Zgze/lyeinx9W/ZXxlhuLZ9nmfJ9jH1?=
 =?us-ascii?Q?GP75OEf1jITu8GDRiYYL/tosIFYTDSsDRJcG0pA7t8vb8KG2LFCBM5vzPtSj?=
 =?us-ascii?Q?cV/y8XkXuTZ03OHmim1ifYZwExP0klfCwbC9oVj29muz8w2BjpbaUBUC2Vy9?=
 =?us-ascii?Q?nxG2Mk9ftp6JLc87EWF3YM9sJ8SlGREPd3H3eqx8b9hf9iOddykUGl7mo78i?=
 =?us-ascii?Q?/g+Xvek44pkQOotRcguXZRDcH6pL8ltueeEmMl+Q7rT/SvEH+TfF1oYwZH6H?=
 =?us-ascii?Q?D/CZWiHkNegvg6C9csQcxzqMBsxf00vNbF1X0wwvie8JDTha79KOeB8CqWa4?=
 =?us-ascii?Q?AdXs8IxBeq5zJN5/R5CyFKcn+Dg9vpDlIaNfOSEwlm7rzb8EfBfV0dGjvWYZ?=
 =?us-ascii?Q?4kjksX5ADnKQRiECFXq2Z657hAe1RlociAHxzqmCbOA9/ZvWFPDypaowGq/U?=
 =?us-ascii?Q?YjGu0CxM8QeZARgGzL6jZYtJOOBEAourwuiUcTntQ35cTR3DYWreUUl4o/5F?=
 =?us-ascii?Q?8//1lYvs3pNJ0F41tfnwRZf+n2Ah71WEo6DMCWxV+63DltxssbZuGogcFjEX?=
 =?us-ascii?Q?7Kbn5sYgevhlHhkMZe8JaNoTVH93av83pu2B+CfIYkBTadKFZwW7Hh80OHU2?=
 =?us-ascii?Q?V6/y8MN5OwMQ4Ol7gKQICQ5epX+6TGc/H5Pvd6MCv/UiizofkFXzEnQ1n4w6?=
 =?us-ascii?Q?rhcB25+Y72c3zquNDGk/+dbjkgkmaE+qX3vLgFT1gE527paq8KQfUSD41DCC?=
 =?us-ascii?Q?dc9abnSEoyf842dcWSTVH9oLvxOYSvMhU/P+5tiFtdg+2C0b2HVUATmo56cY?=
 =?us-ascii?Q?qXfKbpOqfKW/h9AkaXOS8WMwn11bfppb0g9nfD0a8I79IEHwSQMsV1SlAChu?=
 =?us-ascii?Q?qmaj75pYnWG3K4C0iGlTS2U2SppqVtdym98V1FZDoJkMCGCKPGsbdOJb5/O0?=
 =?us-ascii?Q?ExlyJUj/96kSqrsaBrKnOBHlpkJLF4VQmlXGLn6WWL+pZF/0D825pz8bwz5n?=
 =?us-ascii?Q?JHIAP7qAVxIgbnhSp5hrvtX0r7WAAXZek5zfbGHf/qJcNFFfyEdNTGVPzKqJ?=
 =?us-ascii?Q?jSEMFfYGNUSXXVX3FhhT8k2s9KDU0MmoxzbxLyiBKUi4QoODG0HoA7B71wuP?=
 =?us-ascii?Q?MzsvNgTU391fhO53Z/OvX1Zi16ZN6OI3nhJyoz3GdsgSTZsDFuhHCF5wt/lM?=
 =?us-ascii?Q?LaDOj4QUdv3j9n+Fnru/jZfK1Ornc/srxm+UwAh7WQbPaAOg8tuhevAURElV?=
 =?us-ascii?Q?d5UOa58jcJzMsDbw8ydhu0NXqQ3srU43Hx8CXwlNrQta+WljQIus6AZCTZ3I?=
 =?us-ascii?Q?1w20n0qnpRRUlkiUSD0bc8WhLov8iz4VWlwB7dTIL3bVNVbeFwiqyp1LvlfB?=
 =?us-ascii?Q?TcOwcSxp4UcAcnnCxRlkU7wxpEmuebmA4XR4IHxQ455CQLCe1E/uEaVr04t1?=
 =?us-ascii?Q?E0eWzZZFSmqF+MMEBI6IO15cqMdEv15yPXx+WcOatPvsWjbRLy1PGW5eMYGr?=
 =?us-ascii?Q?EBu3SgcyFQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5add8b-f630-4cfd-1894-08de710c5c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2026 05:45:03.6895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mU2c5e9S8CyagGQW4WGVLDY5do7aqu0sUxUswYEVkOQ6weHXbMTamNi/U3/u0KK6trlhcv0tUnTx0JDgq9ek+KquHP4SwgP3U2lttHALk8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9485
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14083-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,LV3PR11MB8768.namprd11.prod.outlook.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaushlendra.kumar@intel.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 4784A16C361
X-Rspamd-Action: no action


> Can you give examples of such an overflow? What values
> would cause that?

pid_t is a signed 32-bit integer. Consider:

  a =3D 2147483647  (INT_MAX, 0x7FFFFFFF)
  b =3D -1

  a - b =3D 2147483647 - (-1) =3D 2147483648

This overflows signed int32, wrapping to a big negative value.

In practice, pid_t values in Linux are positive
, so this overflow cannot happen with real PIDs
today. However, the subtraction pattern is a known
antipattern for comparison functions, and using the
three-way idiom is the safer.(less, greater and equal)

If you prefer, I can adjust the commit message to note
that this is a correctness hardening rather than a fix
for a currently triggerable bug.

BR,
Kaushlendra

