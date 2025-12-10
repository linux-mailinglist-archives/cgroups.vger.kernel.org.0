Return-Path: <cgroups+bounces-12314-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F32CCCB20D9
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 07:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE17A3008D50
	for <lists+cgroups@lfdr.de>; Wed, 10 Dec 2025 06:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378042C21D5;
	Wed, 10 Dec 2025 06:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCBgJtJ3"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A3B1EFFB4;
	Wed, 10 Dec 2025 06:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765347373; cv=fail; b=EVnsS/qN2U6Um9+gz+AKcM9x1dyx6NLlkLL+1YJ6yQiXlQO6ZMaI3voyGgNHF1KlLiwVuQftf0bgulZz60g5+IRvA6xG/An5FLPyxUxz5IO5WX1rkqMJ1ABfKVlSCyROWl9yoKvxnhmWSNKnAxGZUGOsrcXsSKb0Q9CVZjB7KIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765347373; c=relaxed/simple;
	bh=eEdraHDNahparPNWnZFo1WAxYYF0iQ56lCbasBxjbHQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=SjoLLPfylDuLb76aLLX55RqoIqKo6WUljTMlsT6ANOFCeVjTxqxuy8SEAKgdJkEEECJ9CJxv1IKBaOM+GLx5fy1aEcnijyGm2n/RjsKghlceFJeZHk3nx8qdUHiQN5mPwTsHztZoEWWZQURGIoXgyUzT36MJBRf/jWIDRA2P2TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCBgJtJ3; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765347371; x=1796883371;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=eEdraHDNahparPNWnZFo1WAxYYF0iQ56lCbasBxjbHQ=;
  b=PCBgJtJ3dcZIz1BTZGtNHVxovAEOYUmLBcnJ0K4y9rtAm8OdIrupIw3T
   Wi9JCpv+QKPh97s8GcvQwt6rDTl/leFSIaQf+Wam3SRgNoHHFqy3CvOyS
   KT76jENULXmF/gDYiAS2bCoc+/0vUkmnRWsoqk4JobhGANOY80/iFj8nz
   bfSxiuWStGtb6nX2pcp6qU7eL5dkBIHeUC+4U1GVjkSaCHHTyT4vmYsQ3
   KpOMoEQe8rwoSHO6bvFyeywy+b+gwVO70ew6eWlwU7nif1IAqg5i4j0TF
   LcSV7a5EtJ69pDnI7I4DHv/DJEO0/12EWpzjRSIiCKUWqA72rT096DoyQ
   w==;
X-CSE-ConnectionGUID: HngsbUklRHG63bijVQaWXQ==
X-CSE-MsgGUID: 1wBtB79nTv6MpHMFB84Grg==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="84919262"
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="84919262"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 22:16:10 -0800
X-CSE-ConnectionGUID: 6tyCmkNtTkep4wGDZ3f66A==
X-CSE-MsgGUID: ahklfDrCTV+rwU1L6l9yKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="196719612"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 22:16:09 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 22:16:06 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 9 Dec 2025 22:16:06 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Dec 2025 22:16:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVnYuFQTIQuBeWk2hyoe0UGW0YdeMjspChq8e9ZCoGhpm8oyF28P2rGB6oxD3YMscjwXw7VsISvbvWtHvuMS2VD0WVLSXN8FH3iKBntfu1VoIZ2o5K7sSHwxySC9unGszIATXGZv24v6wxsu5T5dLAlg2LWe6Dhz8wHPz3OeOl/ufV9iRkigws901f/4qj9E0SKI/eDGsSi//VeuIKM/wOFBGv4O6TjSDdcQ9faIhnztuvkUXqEgqD68lK0roYw+/F8YeJKz5JJajgaH0D1LJMNqhMxJbMPDA0Ca/0LEGA3X/eqWRZP/5XyLPY/uGYxwofMrDKDA0Tl28VsoRDKWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDuGw1jR3DCmAEWFOVql+KTJowQkr0yoNo+PT4IVbqY=;
 b=ttxxdRTl2Jp2tpGVNllrPQtaTdmWXhGwq2z4NxvKVk1x766i4k3oHqyGywZ9q/tXgs+PmO9iWlvpXrhGVPOJUeVInr5aiS+N1cWg8mNJYJZ6XiIdYG2DAGHfhAVZzo2aeJ+bKdkmAV6G2ppVmiyg5CVDtmmgErQES+bilb4mnPiXT7pCa7ZgH/Zc+FJ/hRjq3eM+ACsXdM3XOdal9C5nmWd/gzFtF3pOs6/KO7lBCG0eimXYqdS1lpPa7XH23/mypOCpgagIAjRxYTJfZWlKcCXhlbNKX5LpWLuBytvy/AqBuKbhVfXcYXC0qyBLej7q7/ad/8WKchCeNGi9r/pKsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB7700.namprd11.prod.outlook.com (2603:10b6:806:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 06:16:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 06:16:02 +0000
Date: Wed, 10 Dec 2025 14:15:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Harry Yoo <harry.yoo@oracle.com>,
	Roman Gushchin <roman.gushchin@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>,
	<cgroups@vger.kernel.org>, <linux-mm@kvack.org>, <oliver.sang@intel.com>
Subject: [linus:master] [memcg]  7e44d00a13:  will-it-scale.per_thread_ops
 2.6% regression
Message-ID: <202512101408.af3876df-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:820:d::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 900269ef-f000-45a1-1f44-08de37b397d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?hDkklZesXinPeCxqxA1gLGmbKtNMBKco2ul5r/ohGdFkX90LgasxyuGG+g?=
 =?iso-8859-1?Q?TN0o1VDHRkvGiljVQ1LYHnnu4XeH2qJqHF369ydgOjEqSig9xyz3t9HCok?=
 =?iso-8859-1?Q?/sf5WRRFfuOd7x6mz026bAHkWA0QkdpkYsVtgRR1wT1HmFkmZbCnJ5uNB8?=
 =?iso-8859-1?Q?mMTBiQJZH4emoyjsiNIflPKihbiAZ4ip+HNRfu35D4bqwED+q2otFTaagw?=
 =?iso-8859-1?Q?88UyajSWzm2elxvPwCqWEu8XC7A6aKP59H6EUzyKrN/fe+IUPKWNGIs4X+?=
 =?iso-8859-1?Q?0H7iuknqgPkvTLk6boOvGF7aa/Yql/+M5eb5ZNYUsb38704x+Fu1EKk7cK?=
 =?iso-8859-1?Q?dZdwxCfBzIiIPwUbjY/YjsXpcq0JFZRtQm1R2WgjBClEN6Ou8n76GOhvx1?=
 =?iso-8859-1?Q?HaaRLHS6gObpB8JlB71XTucKgD3U8W9o6kB9cZsdk8V3BWPX6Zikas/jNI?=
 =?iso-8859-1?Q?ApUIYIoTIAfnmodN7kUgrGcB/mzoCR97cMNUgfl+eyPWKTZHvEjUh9tBBt?=
 =?iso-8859-1?Q?9W/YpkgY9D8nS0io2vaP6N8hFHXUh2UsxwbBghJ6NVhtLXQoYJztdrE0ak?=
 =?iso-8859-1?Q?iqZMUL/IVdQ6272k3IAmZsYislZqlRm4qsR0+7OL48TIj6D5kA/wQOfpIt?=
 =?iso-8859-1?Q?NWYqs0N2EWz4QbcO9gB62aJ/x5Emnd0YAGPOCIzhKml2bBX+a2PLlFOqQs?=
 =?iso-8859-1?Q?7fuvVztTzaleN0F5Q7f58+DK0TeUvcm+a4N1EDrGoM1cF98WcTDSK4GoPw?=
 =?iso-8859-1?Q?ZnmKzCAY73tB/JDtDXIqt9GT+cZn6MmLd0LNCCQAqJuTLJQlcrk8590g6c?=
 =?iso-8859-1?Q?2NkOLb98XUuCJ7Ugv0q7qpxNYKDGi0sm8zk29zz+pO+MPIgsyEm37Vtgd7?=
 =?iso-8859-1?Q?C0iBBg6zf3A7kx+bc2RXY7d6v03GYEvaKEvNvscLzKyCKtPy6wI6yhxnxv?=
 =?iso-8859-1?Q?sOVry5CnFHQHCQQ0i4rjaOKncsPHhyyCg3gZzpZouXGzueFnjNXzvARLRL?=
 =?iso-8859-1?Q?g8dIVV7Lk9yuHE/6npWYB/FU/ArrR39xSDOwq/ch0xNdMmqdbi/RG8hH+U?=
 =?iso-8859-1?Q?yhCFCuog6Dn+1JMPctzEULQ1uSiUIpwDR0UsDNLtP/pviDgyJb7wlW/ZvR?=
 =?iso-8859-1?Q?dvptTaNRZIk8qYjjrsR1e9goGVvS5sifFgfb2MACXpBB0tffZkV+mxzcdy?=
 =?iso-8859-1?Q?CdqnuCgiU5XgGo20yibIvqrpGytohainob77z/FNly2zXcGezPXn00lR4a?=
 =?iso-8859-1?Q?LawxdWn9EHUr8MYrEgz83P2mtWZ4j7C7FJF3aKQco8mWbCZM6GkQo3mdhp?=
 =?iso-8859-1?Q?4dH4Q2DlSU/ndZIu/q3sUj0TZ9Zxy2YNFAx9P1B+fGSLIopmT7EfjB3PVO?=
 =?iso-8859-1?Q?OavZI51v5ozqxWB+QVJLUGzCfW7lGgOipeYZBQVzZPiPFhJTyJ3ZOQzIr3?=
 =?iso-8859-1?Q?EOUsvc4IHM8xAuPHuH9cTFt0noxkMp8mpPdO+4bAwEs/Afb3F7jxAbnSqU?=
 =?iso-8859-1?Q?ztV7D0CaazmBH3ANVxYIVNnpSstH+8S1yXQwqOUb5iWQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?03HifE9Z9kQMhijPtPCJd1DFze5GYsArSJ7n5FVVpV0kaLwEcZJ7gjGliM?=
 =?iso-8859-1?Q?cAvt2mMGmc1GkAgl9j8OYJmb2R33u1COdmDKomf4XgvZynt0T6QkpM1QGw?=
 =?iso-8859-1?Q?0y0slO3rhyYgduP3AVrvtBI96wEWC/oQH1J47hP2fNdPG6b6hvDJRjMjRI?=
 =?iso-8859-1?Q?5O7qquBwiPbLaOaDkUyrw411yE6xTMYFlWmEPyFBZsKux4mC+g4JlTg54o?=
 =?iso-8859-1?Q?vKU1gGHuhOH0Em/0vl7gLRVFatXw5WRjLfrBev4/ZxWDKfRGJh0VHyX8/E?=
 =?iso-8859-1?Q?jDwotaem9b1+uZrkKYS1KFtlV4BhbDwX9t4PQkMWDqjEv5MDV6j/FwAgal?=
 =?iso-8859-1?Q?dpAoaQyBbobCVZ1FR6iUDnm8FjFmYRUNEWzLul0CXC8aaXHer2e28dUtFR?=
 =?iso-8859-1?Q?oKLkLja36Ud99NkgoSWAGeWu++PYCIl5/bsTlezJnhNvEEjL3GkQrRV2qQ?=
 =?iso-8859-1?Q?03mJUeJyswICZmLW6yzeUMM1kNbmVfh96g5LLLOLWmmCqJQ8YVeUH1m00l?=
 =?iso-8859-1?Q?LYrxudz/znfWIvkZXqn+eEvgMyuYnArFluDGJpyVK5kmiDf0aiDZQ4z2Jq?=
 =?iso-8859-1?Q?ZdayFJrvTJ0IyrAFymcch5dMJVN5dgqDpvZ3iFVDq47fkbIW77uREzieSc?=
 =?iso-8859-1?Q?CiYNJBBty50qcZfNwwNZUGx6FiEaWzAlkjbe1nuwjnJ5W3UMaEy8EWyZ3A?=
 =?iso-8859-1?Q?5xVorhYHNJbY8NUoYYNQbElOzqf4kkKfdIAbEVKdJPg48qvwL5jN6vB0lZ?=
 =?iso-8859-1?Q?oYH6SPjycIirT6xqR0ILAkg+B15weouxUZH7bLHi0MaS7FS3DJ3qBJuJAY?=
 =?iso-8859-1?Q?ox8wHeTqAnf/r1eWisO9GRQRWFXA9XurYcTJmRqKCnoRPwHrEyun2W/Xio?=
 =?iso-8859-1?Q?5mm9kmxeEphPuiL7htXoOEkJXik27vM74szRlCPF5arlsQv++ESrPdztrk?=
 =?iso-8859-1?Q?NQ2g9ynLWXqJE7msQfhf+RFRbDixS7Nfs7ByWFIRDxaRZ2gXULpKcaN7te?=
 =?iso-8859-1?Q?5toZcxPm0DjYrOLipRVujYs3rsrLDitaJBKg4pAf8qvnbIWstgeb8UfY7a?=
 =?iso-8859-1?Q?KSfKzQFclNH8Ux1nhL+5/3kPRQTPlmyBsItLMeL9EHqfbHqhkRONRVaep+?=
 =?iso-8859-1?Q?tZ/L0ZCWmCshnLfp7pRsWy6C+vBEVIA2K2uWratyZmRV5ZsJqQW5Eo/73S?=
 =?iso-8859-1?Q?LcQ9xL/o3qTl1LAnp2deXeDy+b/vz+VcqyTYopPXznhrfl8h/6Ionln1F5?=
 =?iso-8859-1?Q?OkTLcABkcUihFnM6bexTiQqVEp8DkgSKBmqYLQYQyLLKhuuh5/llPB29Yy?=
 =?iso-8859-1?Q?Bka7hG8c/hH0S1ASrN8gTvNBfBffTdtRnTNdeDito89h40sSvGar8GPxAg?=
 =?iso-8859-1?Q?c1+doampcd3KjWafoaJm+koRQnReHpnXSFqPhzBPUURykdGZ2Ho8cZ8owK?=
 =?iso-8859-1?Q?FSmUwnH0sB5r065EqYz68CgswFdqG81iPFWD08sECDFYroDfbKdFZPWb2L?=
 =?iso-8859-1?Q?dKngR171SASl+3J1iV0b3/pHbAeYlAKH7DB3pZrc6JLv3JUWFusr3p8FEV?=
 =?iso-8859-1?Q?CeMYoRSmu7x6TXbM9yyjrzCS6jMtZaJGQ2PjJBhMApPAXspMHY+DVHco3P?=
 =?iso-8859-1?Q?nHvNh4ZDrIk3WYUUS9F3KTbuPdc7eh5VIlzCvAMSiDvxT1WRJoaGd03A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 900269ef-f000-45a1-1f44-08de37b397d4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 06:16:02.2105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMxLmT6bttKp56LVZflt6x4jr3x0tcfq66XcsXaHgRe9VZ/mYmMLdChW6OFYh94sKNEcFNDQ0G2CT1m7FTM/bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7700
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 2.6% regression of will-it-scale.per_thread_ops on:


commit: 7e44d00a13ca5691caf4f7c46541ee60bf75b208 ("memcg: use mod_node_page_state to update stats")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[still regression on linux-next/master 6987d58a9cbc5bd57c983baa514474a86c945d56]

testcase: will-it-scale
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_task: 100%
	mode: thread
	test: page_fault2
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202512101408.af3876df-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251210/202512101408.af3876df-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
  gcc-14/performance/x86_64-rhel-9.4/thread/100%/debian-13-x86_64-20250902.cgz/lkp-icl-2sp7/page_fault2/will-it-scale

commit: 
  3e700b715e ("selftests/mm: gup_test: fix comment regarding origin of FOLL_WRITE")
  7e44d00a13 ("memcg: use mod_node_page_state to update stats")

3e700b715e1cef66 7e44d00a13ca5691caf4f7c4654 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   3453930            -2.6%    3363916        will-it-scale.64.threads
     53967            -2.6%      52560        will-it-scale.per_thread_ops
   3453930            -2.6%    3363916        will-it-scale.workload
 1.053e+09            -2.6%  1.025e+09        proc-vmstat.numa_hit
 1.052e+09            -2.6%  1.025e+09        proc-vmstat.numa_local
  1.05e+09            -2.6%  1.023e+09        proc-vmstat.pgalloc_normal
 1.045e+09            -2.6%  1.018e+09        proc-vmstat.pgfault
  1.05e+09            -2.6%  1.023e+09        proc-vmstat.pgfree
 3.452e+09            -2.0%  3.383e+09        perf-stat.i.branch-instructions
      0.45            +0.0        0.46        perf-stat.i.branch-miss-rate%
 4.559e+08            -2.5%  4.446e+08        perf-stat.i.cache-misses
 4.696e+08            -2.5%   4.58e+08        perf-stat.i.cache-references
  3.88e+10            -2.4%  3.787e+10        perf-stat.i.cpu-cycles
 1.741e+10            -1.5%  1.715e+10        perf-stat.i.instructions
    107.43            -2.5%     104.76        perf-stat.i.metric.K/sec
   3437960            -2.5%    3352362        perf-stat.i.minor-faults
   3437961            -2.5%    3352362        perf-stat.i.page-faults
     26.18           -34.0%      17.29 ± 70%  perf-stat.overall.MPKI
 3.441e+09           -34.7%  2.247e+09 ± 70%  perf-stat.ps.branch-instructions
 4.544e+08           -35.0%  2.953e+08 ± 70%  perf-stat.ps.cache-misses
  4.68e+08           -35.0%  3.042e+08 ± 70%  perf-stat.ps.cache-references
 3.867e+10           -34.9%  2.517e+10 ± 70%  perf-stat.ps.cpu-cycles
 1.736e+10           -34.4%  1.139e+10 ± 70%  perf-stat.ps.instructions
   3426140           -35.0%    2226448 ± 70%  perf-stat.ps.minor-faults
   3426140           -35.0%    2226448 ± 70%  perf-stat.ps.page-faults
 5.293e+12           -34.4%  3.471e+12 ± 70%  perf-stat.total.instructions
     92.62            -0.2       92.40        perf-profile.calltrace.cycles-pp.asm_exc_page_fault.testcase
      1.39            +0.0        1.42        perf-profile.calltrace.cycles-pp.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu
      1.89            +0.0        1.92        perf-profile.calltrace.cycles-pp.lru_add.folio_batch_move_lru.__folio_batch_add_and_move.set_pte_range.finish_fault
      0.91            +0.0        0.95        perf-profile.calltrace.cycles-pp.lru_gen_del_folio.__page_cache_release.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages
      1.30            +0.0        1.35        perf-profile.calltrace.cycles-pp.folio_remove_rmap_ptes.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range
      2.38            +0.0        2.43        perf-profile.calltrace.cycles-pp.folios_put_refs.free_pages_and_swap_cache.__tlb_batch_free_encoded_pages.tlb_flush_mmu.zap_pte_range
      1.36            +0.1        1.41        perf-profile.calltrace.cycles-pp.lru_gen_add_folio.lru_add.folio_batch_move_lru.__folio_batch_add_and_move.set_pte_range
      4.49            +0.2        4.64        perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      7.62            +0.2        7.79        perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      7.62            +0.2        7.79        perf-profile.calltrace.cycles-pp.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      7.62            +0.2        7.79        perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
      7.61            +0.2        7.78        perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes
      8.17            +0.2        8.34        perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      8.17            +0.2        8.34        perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      8.14            +0.2        8.31        perf-profile.calltrace.cycles-pp.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      8.14            +0.2        8.32        perf-profile.calltrace.cycles-pp.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      8.17            +0.2        8.34        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      8.17            +0.2        8.34        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      8.17            +0.2        8.34        perf-profile.calltrace.cycles-pp.__munmap
      8.15            +0.2        8.32        perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      8.15            +0.2        8.32        perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
     21.20            +0.3       21.46        perf-profile.calltrace.cycles-pp.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
     90.18            -0.2       89.94        perf-profile.children.cycles-pp.testcase
     86.53            -0.2       86.34        perf-profile.children.cycles-pp.asm_exc_page_fault
      1.58            +0.0        1.63        perf-profile.children.cycles-pp.__page_cache_release
      1.39            +0.0        1.44        perf-profile.children.cycles-pp.lru_gen_add_folio
      1.07            +0.0        1.12        perf-profile.children.cycles-pp.lru_gen_del_folio
      1.33            +0.0        1.38        perf-profile.children.cycles-pp.folio_remove_rmap_ptes
      1.42            +0.1        1.48 ±  2%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.36 ±  2%      +0.1        0.42        perf-profile.children.cycles-pp.__mod_lruvec_state
      3.08            +0.1        3.16        perf-profile.children.cycles-pp.folios_put_refs
      4.56            +0.1        4.71        perf-profile.children.cycles-pp.zap_present_ptes
      7.64            +0.2        7.80        perf-profile.children.cycles-pp.unmap_page_range
      7.64            +0.2        7.80        perf-profile.children.cycles-pp.unmap_vmas
      7.64            +0.2        7.80        perf-profile.children.cycles-pp.zap_pmd_range
      7.64            +0.2        7.80        perf-profile.children.cycles-pp.zap_pte_range
      8.17            +0.2        8.34        perf-profile.children.cycles-pp.__x64_sys_munmap
      8.14            +0.2        8.31        perf-profile.children.cycles-pp.vms_clear_ptes
      8.17            +0.2        8.34        perf-profile.children.cycles-pp.__vm_munmap
      8.15            +0.2        8.32        perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      8.17            +0.2        8.34        perf-profile.children.cycles-pp.__munmap
      8.15            +0.2        8.32        perf-profile.children.cycles-pp.do_vmi_align_munmap
      8.15            +0.2        8.33        perf-profile.children.cycles-pp.do_vmi_munmap
      8.41            +0.2        8.59        perf-profile.children.cycles-pp.do_syscall_64
      8.41            +0.2        8.59        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     21.41            +0.3       21.67        perf-profile.children.cycles-pp.finish_fault
      0.00            +0.8        0.78        perf-profile.children.cycles-pp.mod_node_page_state
      0.36 ±  3%      -0.0        0.34 ±  2%  perf-profile.self.cycles-pp.free_pages_and_swap_cache
      0.53 ±  2%      -0.0        0.50        perf-profile.self.cycles-pp.do_user_addr_fault
      0.18 ±  2%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.__page_cache_release
      0.49            +0.0        0.53 ±  3%  perf-profile.self.cycles-pp.folios_put_refs
      3.07            +0.1        3.17        perf-profile.self.cycles-pp.zap_present_ptes
      0.00            +0.7        0.73        perf-profile.self.cycles-pp.mod_node_page_state




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


