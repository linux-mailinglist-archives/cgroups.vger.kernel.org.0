Return-Path: <cgroups+bounces-15196-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGeeMh2f1mmyGggAu9opvQ
	(envelope-from <cgroups+bounces-15196-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 08 Apr 2026 20:31:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 818213C0E1A
	for <lists+cgroups@lfdr.de>; Wed, 08 Apr 2026 20:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50A4330156CC
	for <lists+cgroups@lfdr.de>; Wed,  8 Apr 2026 18:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DDF3D669E;
	Wed,  8 Apr 2026 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="AegbyFhQ"
X-Original-To: cgroups@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3B926FA5A;
	Wed,  8 Apr 2026 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.34.181.151
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673074; cv=fail; b=pNZyy+dpHsxOHHu6lPGcdj8mXhEmZqCHvrvFttVzgygVsgemwg65f+idHIjG2JRuLeRcIULGL8f4SZgrZoP6QOEuMgYNqvAvCJOROgJFrYFlTSsJWKH5RHSjlmYqdZgH0L/7ZZD0OpwmGAs4gy+pBohzNZQsdO7h1Zgl9ztJxYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673074; c=relaxed/simple;
	bh=o/ZADr9xwk1hhTNSNLbr4a9lSxvBbuJNsZFRSc9TI+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cbLm3p2vSrd5YzJxEQk7QgDs0YQjqcR86hBEIKCRd8pwpTQegg2vwrAXt4fGPbcjyrit9Fq5n4yqZwyK2KYxsfNVbh4kVGe6mxBju/i1W7deM1tLn1Gj39ftRXe17svR4XFzTIOfMb+ysMEFYe4QZ28gK+w+T42JZ7YWdUakMiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=AegbyFhQ; arc=fail smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1775673072; x=1807209072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o/ZADr9xwk1hhTNSNLbr4a9lSxvBbuJNsZFRSc9TI+A=;
  b=AegbyFhQwyKrOsxmCjZQDNK3H4DeVEnjEiX59EZa+HJToLzTJc3FG6Sj
   2LBedgQICNgOegaK6BTOP9xh3JKSO05lf4eQPu/u6xuHb/HZRVMvVajAx
   gdHjqs+FjISamr2v4tAb4okWJVI63w2UaCmFwNqCCdTt0youugI77UvrR
   GvYDnBeFzQNJzB4mb/TGygZlAhhtBBa0gjz383eCOC7Ty7VWBlnl/Hq2X
   S6Z44bgS8UlrGGQzic0uM2qbxh9CH8ckVCF3eLqWanlkZE8HSGXzvSc/e
   0+CviPAiyIkXMtnPTxVtEEABp8Rpto7uvjMPFjA/4w/9sbTz7UeSYIvRE
   w==;
X-CSE-ConnectionGUID: XB3vYrN9TLyVrei7UJEKZA==
X-CSE-MsgGUID: bYmwfv33TXyu/JHOcljeAA==
X-IronPort-AV: E=Sophos;i="6.23,168,1770595200"; 
   d="scan'208";a="16851105"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 18:31:08 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:8887]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.2:2525] with esmtp (Farcaster)
 id 5e2498dc-006e-41ac-8950-a6d024ba6e8b; Wed, 8 Apr 2026 18:31:07 +0000 (UTC)
X-Farcaster-Flow-ID: 5e2498dc-006e-41ac-8950-a6d024ba6e8b
Received: from EX19EXOUWB001.ant.amazon.com (10.250.64.229) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 8 Apr 2026 18:31:06 +0000
Received: from CY3PR08CU001.outbound.protection.outlook.com (10.250.64.168) by
 EX19EXOUWB001.ant.amazon.com (10.250.64.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37
 via Frontend Transport; Wed, 8 Apr 2026 18:31:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywm96F4G2VzAHQn+GZ4Byk45UfulexL8Z7sFhXkOfbHfquw5v5EDzDFxiIZr8jP03LU1rj+rOjlzufmqUirtO+4TVp+QVyCPkpdQjqzJAy0fScfXjv4k+WU6EylxNehEZnbGKhwRx4TdHdH73oh0JkEBtzTkZqzq7b5BWzobZSHw1t9NkohwC0dVwiHBRJoFRAIpxU/uGBdnuBzWbUbrn8mO6/pPaSsMv1xBynKp10gSVbYktmwn1fl5VVce/yOgsNswLmHb7HXHfKjYxUIWTlxgvg48uPa/3jYXUYNZfIhFPglybxFzJwkZ06HaTG4rDJiOmQNBb4EP2BgMze8jKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/ZADr9xwk1hhTNSNLbr4a9lSxvBbuJNsZFRSc9TI+A=;
 b=L52dv1Csd4yzEWs+OxmnDCgxC5pve+LGldsY6IOgUKEMVrudu2XNm4vPs0foYqN+9lyPyWwxiYtYtkhwc0Iql7IV3+m+CRmF71bg6j+IKwYVmY4Xl8ZRYSLtgGDsmD32nrAUvQToSnPWugLh5CqWFxmlSOTI9ajwYwnqjnreqQHCMoBp8XxgRlkqjHjwrdarcJssWmqkSvUg03jQK/3nNFV7D/yIpEoJc/VMTKa1IDTS1zrSZ2Wc59lhQhR+MhBn+XpzQzkkU1JWT4qgKO4D4AJDY3wB0EJk7EHr0Y18GbdeL55wd70ZFiLHjRoOwqMg2XSeU8EJsnA/dhcglLwvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from MW4PR18MB5206.namprd18.prod.outlook.com (2603:10b6:303:1bd::8)
 by PH0PR18MB4702.namprd18.prod.outlook.com (2603:10b6:510:c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 18:31:03 +0000
Received: from MW4PR18MB5206.namprd18.prod.outlook.com
 ([fe80::3f29:8adc:e300:a9e5]) by MW4PR18MB5206.namprd18.prod.outlook.com
 ([fe80::3f29:8adc:e300:a9e5%6]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 18:31:02 +0000
From: "Barro Raffel, Willy" <willybar@amazon.com>
To: =?utf-8?B?TWljaGFsIEtvdXRuw70=?= <mkoutny@suse.com>
CC: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Bouron,
 Justinien" <jbouron@amazon.com>, "Kudrjavets, Gunnar" <gunnarku@amazon.com>
Subject: Re: [PATCH] cgroup: add cpu.stat.percpu for per-CPU cgroup stats
Thread-Topic: [PATCH] cgroup: add cpu.stat.percpu for per-CPU cgroup stats
Thread-Index: AQHcx4XaOvU1Agyp4k+OzK5cY+ft/w==
Date: Wed, 8 Apr 2026 18:31:02 +0000
Message-ID: <adae5DmaDwYN3f50@6c7e67b75e78>
References: <20260407010642.3249-2-willybar@amazon.com>
 <adVMne0wsVCvc2hH@slm.duckdns.org> <adVoAK8ekj61qykD@6c7e67b75e78>
 <tqtihhcvq26p22eeisy5z3odtnflukoi6lh272gwr66tdj34te@s57ny333owxe>
In-Reply-To: <tqtihhcvq26p22eeisy5z3odtnflukoi6lh272gwr66tdj34te@s57ny333owxe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5206:EE_|PH0PR18MB4702:EE_
x-ms-office365-filtering-correlation-id: 2a1854a5-4c85-4245-27d0-08de959cfd09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 78IJZGRDGUx9kAPvZsstIWkT/Mc/e3IYh3LjLqJrnmN5yAlSt3zxyuBpmmAEhH+Cg3GAoAF0tjDfHMBWJj2mDH0xx1vETPt7gReHzkMPUQ5mp4m73HfDrZa8fqTreD+HJa2+5YlT97a0BXyKhFfpRfgA1sPGpL3nqYo9MUJkc1eiX1gpjE6YStC8x8N11kjBl+qKrJx6/b0DO59tplL3W0NMKkp8qd2q816suAg2ZM0rWGVnk7JjuleZM6PvI4YTz4/+blF7mrUuviQpg5Grn+dmPY7rj23wo4ldI3OzrI4s9iroDuBUIQux0/afLFpArlL413vE0BNj6PM+Ly9BeeBZrF4camDzu8GU75R3yTpoH71xKcn6vdvCmuBLYqilK04t55OpKGJ63eHqKbc6mJV/qCJBJQ6E0GHPny533t4r7vss/MB7WdCzqsUjHOt8C/CvMzQaf+Nwdza+wA7LXvuC43U3s5AhZLSodOKl2H0UYq5CHdHJyo7KZ9D43ordDQ+4EaEa6SNjHz448rqNDYxLU+/CBh3x2PXjFkxwQzGqkqNo4wNFtB6RRn1wP5SejaUn8TFFyyxXdH/s0PQa59yRvzD9RSQUFQAQOwBCqS84JrrOt5G06QEElEIT9ke5hoKSOvcjD+rdLZRmvXVHtpVy42edLYZNJ5VIUBdyQdN3D4fxAPN+Uj+rIzEcHGGeyIiXfbIIrXvSpQeJxzfl+qvT9WYesikvSqKZbEMAryAXt0PIOdQTyVT5VZEnST77lyFQ+9EHGCVyz1svotbSbaGKk6h8/fbuvNo/CjQFGlc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5206.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkdnb1hnRUlKc3JpTGZFdnc3cG5BUHF0TGRxYlNsZFRjcHVTV2dJdUR0dmdp?=
 =?utf-8?B?Mnp2NEE5UVU2a0d3dDJLR1RyOEMvWVZBckg2ZGFOeTYyWk8wNy9YajhvZURD?=
 =?utf-8?B?NmttMFRiaG5leVVRclE3Y2tXR2g5QUw2b3VPSVdqOUYzVm84WVhUckNtWEpE?=
 =?utf-8?B?R0RqRUx1MlFEN2FBOVduek9nd2oydTE4R2haRkpOc2hRWHNBVTZJUFRLeWNS?=
 =?utf-8?B?ZzJ5Y0FMbzdXeUtsY0t0ajlibjlXWHpDZU1EaTViNDhIc0ZOR2Npd0w5M04w?=
 =?utf-8?B?blVyVWF6Q0JMSkhJdmVjNFNsRkVOR1JXcUxXK0F4Q2xYcFcyVmRuNGNqamk0?=
 =?utf-8?B?VHpmdXZNUXZjL1ZiSjlmM21xOENIMFdqWlVFQ3Z4VC9TZ2R0U3I3SXR0b2dp?=
 =?utf-8?B?OEczd1hITGtiTXoyU0pzOXVaZExoYzY2dkQvM3d1YWdudGxZQ2I4R3ozY3pV?=
 =?utf-8?B?SzFCUnplTmN3dGltWVFPSU9YMWtDNGJwWGgwRWFXWHN3V0xYdHBwTHBDRis0?=
 =?utf-8?B?TjFyeXdvYWhrNjRnM0RDNzBZbWZTUHp1ZnRIWFJYc0k3S0VCS1Awb1BhcXRa?=
 =?utf-8?B?SnFTdVQ4UzlXZEp5TU03RFA3ZEFleEZaeGJSUFh4V2gzQnVveWZtK1NnZEJM?=
 =?utf-8?B?ZGVGWHE4dFVYVlV2VUFVcWMwYnh2ZEFGeVdSRUh3ZUIrYzkyc1ZlWEhIa0RB?=
 =?utf-8?B?Mit2ZUluZ0VIeG9MN3hzT3U4ZmJpd1A3ODlVRTdHWlZjT05JckZDUU4wR0J6?=
 =?utf-8?B?eDBuZ2NuNnNlQkx6bGJPM0JjZkNJVnBiTU4rUHNHU1dra2pRUGlnQmJsYUkw?=
 =?utf-8?B?WVEvSEJiOUVBWGVyWHZBdnUrUnVxUjhaZFJvQmlvK3UrZkUrODhsTkt3WEVE?=
 =?utf-8?B?OVhlWmRzSmxvZTJOc0FHU2NNalFXSjFSZndRU01OOFZqcENhMUFWYmZmeVFV?=
 =?utf-8?B?RGtSU1lwS0ZibGtoVGpvaEE1OXhOTkVDUUswWXQ3bnI4Sk9oRDF6bVFYVzYz?=
 =?utf-8?B?eTZLQjBXSGlhUC9yWXkyYTAvbFMvbjRaZytZYVpjK05YaldZcWUvOS9kdzZ2?=
 =?utf-8?B?RDBpeXhsQmR0K0gyeUhoVktqQ1REb3dobmEvbWNTVU1JVFJwY3ZMMnUzZUFT?=
 =?utf-8?B?V2xWYnplK1ArZEZUSGtiSmhnRkFJM3ZldFFVN21FNjlPY04yWGZaaklEemJs?=
 =?utf-8?B?RXBQM3MwS1NXZkdsbTZTQ2NLbVhRUW1mSEYwc1ZXaHJNTVdNS1draUlaWnhG?=
 =?utf-8?B?bHpmMEx0VHpFSk9RNXBnUkZJQ0p4NnVhdEphRC9tcWpKSHJlZHhBOWtsS1Fs?=
 =?utf-8?B?MkV5NFRpS05IUGtKamY3d3kvaDNtWGVLRStzczB4QjVFWmdPVW90L1NTUUdE?=
 =?utf-8?B?NGdhNDJwMk5LV29vNlZBVGVzbWc1U0Rxd2dRTGFzQ01wVkdqam5FRWY0Ui8y?=
 =?utf-8?B?U05mK0pZaVZKSVozMTNKMlVZNEFGWjJtUlJRRnowQ0FGUFUrUk1CcGMvZ1ZN?=
 =?utf-8?B?RXcvL2JQTDBqeUd0UG14TFpuN0JRanhZRnBTd1pGSUV2NmswbUtvVkRodm9n?=
 =?utf-8?B?MC9GOEZrSDlBUFE3NEduaTRybHc3UXVGbWVCdFlwR3VZWTZ0dkpWZmpLRkIy?=
 =?utf-8?B?aHpYSmUyWHVZbDZ1dGExL1Uvak9jcDFUdU1GeDd3L0E0UG9HYmNmalpNN3oy?=
 =?utf-8?B?Y0UrUUlxNjh2U3VMLzRCMFVZZEVrZmNFSFM4RGx5Q3FHd09RdjZqOFVvZDhX?=
 =?utf-8?B?UWdFRDUvK0lFTUtYR3hHNi9uMU5pN0gyMDFYYVdaNThFK3Y5eUZybWdiUzhl?=
 =?utf-8?B?OGpwNjVBamM1M1dyYkVQWCtXd2hiNnJlTlpRaHNFRWVkYWR1ekxqTXB3Ykhl?=
 =?utf-8?B?VmVNRWRjd29xYTFHZlBxeEZDVk02MWVaUUU3R2cvMy9lV2ozOW1Ra25UZ2E3?=
 =?utf-8?B?SFlONEJ5YjFxTWlhckRhMmUwTTVIYmJ4Uy9BeUliZ2I2Mk5jZjNrZ0YyOUNx?=
 =?utf-8?B?MW9QUUxPQUlDTGo3NzJOMTdVa3VrWjhLRjErakhTbnpCNVZPaW5YaXZxdi91?=
 =?utf-8?B?a3JkZ1JqQUVObkxCQU11bzFHdDJlUTNOTGZHdUEvakJKUmhZemRDUTlIZmR4?=
 =?utf-8?B?cTRMbU8vYjhrZWpWRTFDQUdyQUx6Tmd6T2p1ejZzNnhURmNyQUo4UnRYYzM3?=
 =?utf-8?B?TzFwNHFVMEI2SnFMUkN3NkhJNjMrdFBFRnBBQ3Vrc2o5WXFVT1RQTmtXM08y?=
 =?utf-8?B?Y3JwTFluNHhlWVpBUCtYTytYc3Zwa2NZYUNwcW9WZEVLeUJaVFJ1SVJCSWQx?=
 =?utf-8?B?VENuMjFFQkNja0J3Y2t0WEEyNlB4b24zS1I0WUNqMkxXcktXSUk1QT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CB85902EBA8004D9FC43A4FEDC1DCEE@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: K+VdL0v6A5VL2mDbJBXsDSkGfe0LnOwBVdtATmEh1Vv8eG/UJFCSl/fIsrHkq5st2kRAwz4MPxsSD3JUSoUQFYijMu4ZFqfDE0L4KS4IG3FPEEt7CmA/4R5eeZ5nkot8TQAvpgJbZHAXgvj7i0D8tEskoob1Dm5nGMUoFlB76qCcS2wsxnDOpyt4rnXLgwUkiKLPNZCkbd041VgbyxZMfanX9YwqXgQBODsX0bhVEFrLURvpLeWXWfoMVcLEPUhR04sS1JFZ/rBj6UtdFT8ESoTaAiunzvhONSfD8baf7juLtRY0McZ1eIqC+4AYjkYxQOrHTT0c/Bs1x0BCefgKLg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5206.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1854a5-4c85-4245-27d0-08de959cfd09
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 18:31:02.5002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4AExTjug+9XeL4zmTbEeTNWwd2YHMkXApjxwxk1oVn21LX1FoVc2NreSqYfQlSRT2gDFz8UE5t/7NNF1S46kwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4702
X-OriginatorOrg: amazon.com
X-Spamd-Result: default: False [-6.56 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15196-lists,cgroups=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willybar@amazon.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 818213C0E1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gV2VkLCBBcHIgMDgsIDIwMjYgYXQgMDI6MzA6MTFQTSArMDIwMCwgTWljaGFsIEtvdXRuw70g
d3JvdGU6DQo+IC4uLg0KPlRoZSBhcmd1bWVudCAidG8gY29tcGxldGUgdGhlIGludGVyZmFjZSIg
ZXhwbGFpbnMgdGhlIGFjdHVhbCBuZWVkIGZvcg0KPnN1Y2ggYSBuZXcgYXR0cmlidXRlIG5vdCBj
b252aW5jaW5nbHkuDQo+DQo+V2lsbHksIHdoYXQgaXMgdGhlIGV4cGVjdGVkIHVzZSBvZiB0aGVz
ZSBwZXItY2dyb3VwIHBlci1jcHUgc3RhdHM/DQo+KEdpdmVuIHRoZXJlJ3M6IGdsb2JhbCBwZXIt
Y3B1IHN0YXQsIHBlci1jZ3JvdXAgdG90YWwgc3RhdCwgY3B1c2V0cyBmb3INCj5iaW5kaW5nIGFu
ZCB0aGUgbWVudGlvbmVkIGJwZi9kcmduIGF2YWlsYWJpbGl0eSBmb3IgcHJlY2lzZQ0KPmNvbnRy
b2wvZGVidWdnaW5nLikNCg0KT3VyIHVzZSBjYXNlIGlzIHRoYXQgd2UgcnVuIHN5c3RlbXMgd2hl
cmUgc2VydmljZXMgaW4gc2VwYXJhdGUgY2dyb3Vwcw0KYXJlIHBpbm5lZCB0byBzcGVjaWZpYyBD
UFVzIHZpYSBzY2hlZF9zZXRhZmZpbml0eSAobm90IGNncm91cCBjcHVzZXRzKS4NCldlIG5lZWQg
dG8ga25vdyBob3cgbXVjaCBvZiBlYWNoIGNvcmUncyB0aW1lIGVhY2ggY2dyb3VwIGlzIGNvbnN1
bWluZywNCnBhcnRpY3VsYXJseSBvbiBzaGFyZWQgY29yZXMgd2hlcmUgbXVsdGlwbGUgc2Vydmlj
ZXMgY29tcGV0ZS4gSSBiZWxpZXZlDQp0aGlzIHVzZSBjYXNlIGlzIG5vdCB1bmlxdWUgdG8gdXMu
DQoNCi9wcm9jL3N0YXQgZ2l2ZXMgcGVyLUNQVSB0b3RhbHMgd2l0aG91dCBwZXItY2dyb3VwIGJy
ZWFrZG93bi4NCmNwdS5zdGF0IGdpdmVzIHBlci1jZ3JvdXAgdG90YWxzIHdpdGhvdXQgcGVyLUNQ
VSBicmVha2Rvd24uDQpOZWl0aGVyIGFuc3dlcnMgImhvdyBtdWNoIG9mIGNvcmUgTiBpcyBjZ3Jv
dXAgWCB1c2luZz8iDQoNClRoZSBkYXRhIGFscmVhZHkgZXhpc3RzIGluIHN1YnRyZWVfYnN0YXQg
cGVyIENQVS4gQlBGIGNhbiBhY2Nlc3MNCnBlci1jZ3JvdXAgdG90YWxzLCBidXQgcmVhZGluZyB0
aGUgcGVyLUNQVSBzdWJ0cmVlX2JzdGF0IHJlcXVpcmVzIGVpdGhlcg0KQ2xhbmctY29tcGlsZWQg
a2VybmVscyAoZm9yIHBlcmNwdSB0eXBlIHRhZ3MpIG9yIGN1c3RvbSBrZnVuY3MgSUlSQywNCndo
aWNoIGFyZSBub250cml2aWFsIGRlcGVuZGVuY2llcyBmb3Igc2ltcGxlIG1vbml0b3JpbmcuDQoN
Cj5UaGFua3MsDQo+TWljaGFsDQoNClJlZ2FyZGluZyBvdXRwdXQgZm9ybWF0OiBJJ20gb3BlbiB0
byBhIG1vcmUgY29tcGFjdCBmb3JtYXQgaWYgcHJlZmVycmVkLA0KZm9yIGV4YW1wbGUsIHNraXAg
Q1BVcyB3aXRoIHplcm8gc3RhdHMsIHNraXAgb2ZmbGluZSBDUFVzLCB1c2luZyBhDQpzaW1wbGVy
IHBvc2l0aW9uYWwgZm9ybWF0IHdpdGhvdXQga2V5cywgb3IgYSBtaXggb2YgYWxsIHRoZXNlIGlk
ZWFzLg0KDQpJIHBlcnNvbmFsbHkgcHJlZmVyIGNsZWFyIGtleS12YWx1ZSBwYWlycyB0aGF0IGRv
bid0IHJlcXVpcmUgdGhlDQpkZXZlbG9wZXIvb3BlcmF0b3IvaHVtYW4gdG8gbmVlZCB0byBnbyB0
byB0aGUgbWFudWFsIGp1c3QgdG8gZmluZCBvdXQNCndoYXQgYSBudW1iZXIgaW4gYSBjZXJ0YWlu
IHBvc2l0aW9uIG1lYW5zLg0KDQpIYXBweSB0byBhZGp1c3QgYmFzZWQgb24gd2hhdCB5b3UgYWxs
IHRoaW5rIGZpdHMgYmVzdCB0aG91Z2guDQoNClRoYW5rcyEgV2lsbHk=

