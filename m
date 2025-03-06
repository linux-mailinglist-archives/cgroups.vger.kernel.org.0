Return-Path: <cgroups+bounces-6857-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81624A548AF
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 12:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CBF63B0E53
	for <lists+cgroups@lfdr.de>; Thu,  6 Mar 2025 11:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E032066E1;
	Thu,  6 Mar 2025 11:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="DkNz6S35"
X-Original-To: cgroups@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D05C204F85;
	Thu,  6 Mar 2025 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258963; cv=fail; b=H99mPBreDwaoAatEpZ83qr8jJuRl1DuEyrRnHhJ1/HK9zIbsDq/8vG8HMczpxjE+riW6hVSHsjrkiqEChERsQmzrUwPP2I1P0dgiaQ+pATiK+uqbXZtryl/0Gj2Jmtgt/rL2wgvocp4go16+hvreQS+d99TN2OCN9xHMEGzDpes=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258963; c=relaxed/simple;
	bh=sklnNEwCAOqP6mkTI3a01pETl1TzUMWBSwiJ/609fuM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iFAG7c4hFXaZs3WniBDDp38aimoCJEjhw9rxaKDJQXmXR7IUDF84etKT0je+HBS+vc/jsyPpWE0dBOrjO6JgZe4JXAkjJsn2dpgMts91VTWXhxqWShkA0tzNURcwGpGS0SoeJhaSWbdkkMUwjlJr18NNXBN+YumDShZUixeGh2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=DkNz6S35; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5264giaI016154;
	Thu, 6 Mar 2025 11:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=sklnNEw
	CAOqP6mkTI3a01pETl1TzUMWBSwiJ/609fuM=; b=DkNz6S35dcEJ3ya5yBI1bv9
	xmCf1Ij1aTqO0ZWKzuL99MzD+6NByOxOdMJWf0K5KvtkQPuy4f+0me9GdDPefdac
	z9yQjPaoZK2tNiwWP4LML8w6A9ctKCzg/bXMyECmnFxHe8wnbH0NVN1/AOmOeixe
	VrZ+ACJ6oy1PFQqUENhbBB7E6DFgU5t91EaioY53Jn+t1mZBDZlwsGcJpBHGby9H
	HJLDJsWbX6mUk3sUGciKOxw52e7NGRXoV+DW+S6IK6nz3BR2ztJMQ8hfdxcrDJbg
	CKvbbh9g425+zOZK9iiDXuJVbtVs7n1NlUBKeH8zOGnXuc7DiKZu+Vzy2VtFsVw=
	=
Received: from os0p286cu010.outbound.protection.outlook.com (mail-japanwestazlp17011026.outbound.protection.outlook.com [40.93.130.26])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 456ur0rs1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 11:02:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bqa7myl2e1VR6T+nfC/8dXba0p2NYcxWh6xAnfHvwgJDfL/UX4WzwIbNOgcnLQAfMuaFJCsZbud/dM7nEasC4taYe1caCPJb9PBS7m9PRDSUp/Bg7EyA49c1OzoA9O+JoUYEabS8kYXAH3jYN3YYFbKffjygDkAm2vK7EhzjYtJvBWr+niBWXC6A73HzeY1Cu627WhS1MlZ/ic5k2B2plLy8upudWfOxy0JiG8XRHZxyuOIXaKT62CPZeVaRdZoAGrazxa9erXmxcPmOFLtcVSORq1gcERiZ9MoOr1rg+bCMaZivR3D+zKpwbXKxSVGg1uM9FqhrYas5UGg1YSndig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sklnNEwCAOqP6mkTI3a01pETl1TzUMWBSwiJ/609fuM=;
 b=nPhfSxZPrBo7D76Us/O0S2z017+Y0TJ0VFeouz3Y5BP+aij8Lyuf9nJtDuvbQZ2OY9LJldZ7Na7akLa/ChmuP8wtGLupx5IZ6sS5HYsiY4XcaKGFxkM/v9TK2/W1Z4c/4c1Qu8I4TCUAI0DOQW5hYibz6rRn1Pzara+iIQo2uPYjw3jI6XlrMqmY7q9p2EIl3lqOWsqteF/XTwjd0+XCcM0cPYpHPsR8N5ghVyNrFx2RivsBiswHM2EJ6AabZky+cUIZmRoZ5l8B10ax8UTkhYUsJvjbFrSOeEK4QnUkfs5z49gTenNmW9Y/sWCkcMQA8+tlr/YEAr8NXiN2eNR44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from OSZPR01MB6711.jpnprd01.prod.outlook.com (2603:1096:604:111::13)
 by TYCPR01MB7726.jpnprd01.prod.outlook.com (2603:1096:400:17b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 11:02:23 +0000
Received: from OSZPR01MB6711.jpnprd01.prod.outlook.com
 ([fe80::1fcf:d37b:e319:1b17]) by OSZPR01MB6711.jpnprd01.prod.outlook.com
 ([fe80::1fcf:d37b:e319:1b17%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 11:02:22 +0000
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
Thread-Index: AQHbjYTtFFcCGHzYHUi62vR2krD9qLNkucmAgAE5gPw=
Date: Thu, 6 Mar 2025 11:02:22 +0000
Message-ID:
 <OSZPR01MB67118A17B171687DB2F6FBC993CA2@OSZPR01MB6711.jpnprd01.prod.outlook.com>
References: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
 <20250305-rt-and-cpu-controller-doc-v1-2-7b6a6f5ff43d@sony.com>
 <thhej7ngafu6ivtpcjs2czjidd5xqwihvrgqskvcrd3w65fnp4@inmu3wuofcpr>
In-Reply-To: <thhej7ngafu6ivtpcjs2czjidd5xqwihvrgqskvcrd3w65fnp4@inmu3wuofcpr>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6711:EE_|TYCPR01MB7726:EE_
x-ms-office365-filtering-correlation-id: e5df6456-205d-4c3e-4acc-08dd5c9e5f1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?wvsrQT4jIKUVNWZvzAob4wZ1KQHVsGRhPrYz+sf5OarUF/JJmhZAtYtpAt?=
 =?iso-8859-1?Q?I7wmJj6lL7wGY+kHf/GBFLDmhmiZgbx9P2tNGNDb2afQAMIe4PUUzfgd3U?=
 =?iso-8859-1?Q?hli7ANw313Gc3G5mubBOEfI3O5UOd5bVACsTPe2usE3DRN6LJ1GQFxN1nW?=
 =?iso-8859-1?Q?OHD5a7a/AjB8od7JbGrNgdff3IJbHGRnTsaG3SOMyPBSYTdlMl01fv9NpH?=
 =?iso-8859-1?Q?3fcGXZl3bQk3EKcyoRDFCXa6wQERZhBq/U+Rg70SKH9iE6iuEwQQWsl8nw?=
 =?iso-8859-1?Q?LpvzWMUWk/+x2UTAmm6N6sPmM4PpaHnrcUKDrDBoJ26QJSD1gTPCWt3Q71?=
 =?iso-8859-1?Q?7TfAnDIED+V367j/3U0AGfLIfU45Nw9GPJ7MENb/wFjySiE+1qTwQXWBZ1?=
 =?iso-8859-1?Q?XpPI2N1/PBaP7kAv9VQV8JakNT03C6R8aGHdpEXyHKa9kiw/l+j5AHh4cH?=
 =?iso-8859-1?Q?X75HNO3+pbStYHfunSavAjL65oPqCMvTknJFlc5fhp9nT3l1eboTB3GlUB?=
 =?iso-8859-1?Q?FgVqb4FU6EZxkYbmMl0tqZeag0YULWS8pgFquHR8nlcxohdaSf8z7bu6+R?=
 =?iso-8859-1?Q?+jqZ/ilHXUG8sCBlA15OT9x49NriQPpesSG+lGArKNeMAz53Yc/j2K6bTx?=
 =?iso-8859-1?Q?BSqPdwppGVG8EYSWNuRc1f1DGcvf+Q49sR2cqOzjKabejgbTL0hCRCOYGw?=
 =?iso-8859-1?Q?7jJQa6jr+05ACvbJcqqhM3KJbkBNs9Z4Dwuv0xxLTAxB11v6sFZGupKqOl?=
 =?iso-8859-1?Q?rifl4MXRGFth0FN0WEBkiF0ExmDVQq9IZ+8BgYir5+AtZVl7jd/TWQYKwd?=
 =?iso-8859-1?Q?yhKsvr9nusPKa1mneYxdi6XdNiVYPYwOlnLBQxOsy9U6mXMkdiIcx7/Hla?=
 =?iso-8859-1?Q?47qm6AqYu1Sn7CBIMQf4dWCJXgfxbUJDs3+OsRcguWUynOA79zPr6ipfN+?=
 =?iso-8859-1?Q?H5yR4ubvt12nvLO16ejSGqzn71tpTO95z+d/hCjZ0cuV8oaHRRWayNf6iv?=
 =?iso-8859-1?Q?9xNq62g+t4C79NI0ImSO3U+n6V79Ci+OIkXUg7WNwiiRJuxI+CAzfQbRJz?=
 =?iso-8859-1?Q?z/SlJjGPQLX9taAhrI917OThdHoEHLWEWRL4g4FxCpcSCCU+O9C2cYpEog?=
 =?iso-8859-1?Q?bBnJf0lutC2RFxeQiS6j+MdgJkJtsBW/jJPji1hsVB3obmRDkWenkqihbY?=
 =?iso-8859-1?Q?0Jdk4929qDpK+odsGjYMerShsTzlaM2SZtv5BMLGrS3RmPp3exP8uEUuPd?=
 =?iso-8859-1?Q?cgHI98iPLnN4JyOImHLkcH2hH/MbrS+l/pcoDWJELK1UHew1iZwAWIv8j/?=
 =?iso-8859-1?Q?ANsNs5Vyoyds59gbzRZMFQHMVk1DcMU4R3JC1u48UwzPWiQuh7UaI3S5EV?=
 =?iso-8859-1?Q?b6XJBqafjBoBBpkvMkzIfQfF8qD8EON5/9lI7oGdYHfNFsDMLJjnIks2B9?=
 =?iso-8859-1?Q?DQ/ptZpbQ8vOtI9nbelI3Ga/OrpZiy0gS536hSTHJCbGMsNEBuYoUpSq3l?=
 =?iso-8859-1?Q?wtPGHP8j9PHnZ7gQvtr/xs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6711.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+jUChxNgXxu4Flr6NCLQM4vMdi1mnGtYjqPT6SglDFGaRsOQ/v+XxwymY6?=
 =?iso-8859-1?Q?clxvjubo9CfDRtCo5GN91csveIhmzpPEqYFR7DfWvhWOJNLqxyG73rul70?=
 =?iso-8859-1?Q?UmXoG92OL/lGRwGU+9tbwz5dQFI7h8w4ezspeYll806WBSQUH3vdy8wCoN?=
 =?iso-8859-1?Q?bkAF/3hw/qpYwx1kQTj7ntxHUw+s4Je15idZSZVTCXOQr9mmTv3JCfcDux?=
 =?iso-8859-1?Q?IBhp7Dg/GkQqCcx1cS1eVF/1AsP7olM2nA899c9nfBn3FTkXr/3ukmiG3g?=
 =?iso-8859-1?Q?zjChDzD4+atHdFulJpbQRlovpQ4lmLA0o1Y9C2ULoUr+kxtEIspGTD7HiH?=
 =?iso-8859-1?Q?qoANVntHjxXQu7C7oaqm2katdIjQYjvnRnobik3XzdkgvDHmwC6IFcr3c/?=
 =?iso-8859-1?Q?KLaFcfCgEH4cp/Wg5NMRuyqYH8JFUAOPvKp16x8tlFPy8NoTa6uWtNYpno?=
 =?iso-8859-1?Q?qyoFKuZ6ob+a8nE3iGvp7KOyA1iV1KVp+CL9VUeBYFixqVPoReHWVFQFXC?=
 =?iso-8859-1?Q?Dp5Q954NuJJLclIhoTI7ITRAG6KBCH7niCnJUc47vmR+UW6yC97nGZ+Xa2?=
 =?iso-8859-1?Q?4UsWa12W4vrHQphgbv3sEBOMT9uWqlwneOaYJ4IkrbZVBz8X78ypiolaqX?=
 =?iso-8859-1?Q?1GVyL46Yq1HpUDge/AlyHJvQ+OcLpuxSnitBWYYAG58KT5P26Otf6K+QR6?=
 =?iso-8859-1?Q?Q/8zvNXk2d9wubyGGpvuy4KF998s6LmGiTwlPlN/KDes6U1DRM4CpSm9Fv?=
 =?iso-8859-1?Q?TgJSpEJm3gkfLH1Nuk16awxUQ413x1FDF4x9xDzd0klZxYbdQfTeuW4/pc?=
 =?iso-8859-1?Q?I7iiNZgycFYIy/pzOiLQXjYjJCl2K2KR2ZZS+GOkvxg9UI6fn4NmFdhiqH?=
 =?iso-8859-1?Q?KuOnmZtIjYSbZ89eyiPM2kb0PubOaslY6YnL6g6RznIb2g0JQblCaKXu+8?=
 =?iso-8859-1?Q?23zS8VbNPQi975Rpl9/fSofLGOSuFb+7WAZiw9sQpIwsgOv3gxNTcPo8um?=
 =?iso-8859-1?Q?Tdmw3iZv2iK2jNO8G3nTGza74qq7RC1cEHMIQNTlHYyCGg6ePz9d3smVw8?=
 =?iso-8859-1?Q?gmvKM+3wvmlsEN0Ue2pwUk6RexxZZh59IbNc0/jqcfnrZJ7xorDyI12+CE?=
 =?iso-8859-1?Q?sq88A2vUZyeUA9ASfyyM7T+t7WiFN9rqCnJx9iifrwzQvLP6jnWVauCqg7?=
 =?iso-8859-1?Q?TkNQgvJynm2EMjiZMlXvSjtMO2shXJ6JNM6MMdrdYeAZCfdtpQ35OY/XDY?=
 =?iso-8859-1?Q?dxwxw4wnRKn0EJXirFIZjn/UCdP8knjob6Oz225suPjxkIdmO1I3atpCaL?=
 =?iso-8859-1?Q?/2FSWDsZmhKtRDWUuqFNIgMgxbSe+Qt3R6Xv5JAZX1QqiZpH3kt+SPT4O6?=
 =?iso-8859-1?Q?VeBwy5t8TAmPXQI2qK1GynjfoJaRzGBgHU5aICtS/6roh+dPolWfjGus5M?=
 =?iso-8859-1?Q?Dy+8h04tlRvVgWZFDx69aXKyxUup7gZjkZhQDknarw9ecHYu7dS11Or4Jd?=
 =?iso-8859-1?Q?sOOqISbSS2YPp2YjJ/Zxia8b4OWbz8C9Tf15n2DrhTq4mueCiOWZX50wpp?=
 =?iso-8859-1?Q?A410wx3xpv0DdHRcsafGXOLLOMuBImaDzWaowCL2BeOOxLJPYPZgqRl63e?=
 =?iso-8859-1?Q?F6M1tqCzOtUxr7cthowGTRq9l8BMlxVFR2YNuKWkQZeF/QRk7ZilR7pg?=
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
	wyaMETWbwagCNQfTZ3hF9JxHBurtLNPDCsPJB1fAsRqvR5qCgU8CzLI5BUslpbyc6wteGexZYX+7X+dF6Z2oGHDhEoZ7o625MrCIkv/uNqDJRuvw5j7+5TJj71ebVwxmng0O8vr1Acgl9Ow59DS9V3DdoZahsReD62S5FoKBwGTWQzk0dPkeRdeMAHlgsQFcljTybgBNk3bg/OxE/nL5kdwQqIRkiUg/jKw7UIAeyVE5qCIkRfuv8UGRBo/HwKB/53t/a5+UJ0poHF2sgVPSpd33fiv3qPyzpOoaTcOx7IWFL4mPoVUquPuEF21TJt67dsbK0cf9uEAKLHY6YDJ8pyuZNjieJzEPV+DdY48tNbTG+YlaeN7NK8HpU3+QdC0zjBW0VWxxLSyPGwJ2gkD6rigdOfsMWnNp9mtay9NnSNQfq1Es11ZJNi3pwQg4n+yEehzicXq7QCDQBRQFtAGIsQn3PVmzAPSUFFrIBBTdxF+xos0jMywXTGzU4GA0mkgkZGKC2ePr/hm+FH5AFYFWkJJYIa9oGkkAE/l51/+T1D2Q4F1ODGwJhWkPOScah2+XTiqDLDRoX119PT2R6Or1Os7/ShpsndpdT0ghDI6whinyTuXtAWAXzf3dYLMYIEjZ
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6711.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5df6456-205d-4c3e-4acc-08dd5c9e5f1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 11:02:22.6399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F0NcWKgr+rmm0N/6lHZ5YD+Me0E7JCp8KcHCaqMTw9O/Nnq9XTaSgnmMuWqS5+BWbOPcsPEzzQLDmYZXGnemfvUGURDz38X9c+Z/2yfOuEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7726
X-Proofpoint-ORIG-GUID: 5vV2z6PsGGRLtI9-0ErJkzVHb-igAmr_
X-Proofpoint-GUID: 5vV2z6PsGGRLtI9-0ErJkzVHb-igAmr_
X-Sony-Outbound-GUID: 5vV2z6PsGGRLtI9-0ErJkzVHb-igAmr_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01

Hi Michal,=0A=
=0A=
> Hello Shashank.=0A=
> =0A=
> On Wed, Mar 05, 2025 at 01:12:44PM +0900, Shashank Balaji via B4 Relay <d=
evnull+shashank.mahadasyam.sony.com@kernel.org> wrote:=0A=
> > From: Shashank Balaji <shashank.mahadasyam@sony.com>=0A=
> > =0A=
> > If the cpu controller is enabled in a CONFIG_RT_GROUP_SCHED=0A=
> > disabled setting, cpu.stat and cpu.pressure account for realtime=0A=
> > processes, and cpu.uclamp.{min, max} affect realtime processes as well.=
=0A=
> > None of the other interface files are affected by or affect realtime=0A=
> > processes.=0A=
> =0A=
> I'm not sure the changed formulation make it clearer.=0A=
> What was the unexpected value with !CONFIG_RT_GROUP_SCHED that made you=
=0A=
> change this docs?=0A=
> =0A=
> (Please note the docs is for generic cgroup, not only root cgroup.)=0A=
=0A=
The documentation covers what happens when CONFIG_RT_GROUP_SCHED is enabled=
,=0A=
i.e. all the realtime processes have to be in the root cgroup for the cpu=
=0A=
controller to be enabled. But what is not documented is how realtime proces=
ses=0A=
are treated with !CONFIG_RT_GROUP_SCHED. Initially I was under the impressi=
on=0A=
"oh, the other interface files seem to affect only processes under the fair=
=0A=
class scheduler, so maybe they don't affect realtime processes". But on fur=
ther=0A=
digging, I found that cpu.stat and cpu.pressure account for realtime proces=
ses,=0A=
and cpu.uclamp.{min, max} affect realtime processes as well.=0A=
=0A=
Do you think it should be rephrased to make it clearer?=0A=
=0A=
Thanks,=0A=
Shashank=

