Return-Path: <cgroups+bounces-15189-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKBmKwxo1Wm05gcAu9opvQ
	(envelope-from <cgroups+bounces-15189-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 22:24:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AA83B4872
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 22:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6BE8300D776
	for <lists+cgroups@lfdr.de>; Tue,  7 Apr 2026 20:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF55376BCC;
	Tue,  7 Apr 2026 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="AUhHRPEr"
X-Original-To: cgroups@vger.kernel.org
Received: from iad-out-013.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-013.esa.us-east-1.outbound.mail-perimeter.amazon.com [34.198.218.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A79029B78F;
	Tue,  7 Apr 2026 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=34.198.218.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593482; cv=fail; b=cdQQFS08bOKEGkf69gScgZkKsxCeY9hIjNKbF0QqEN/sEPUwyKXP/9l4XKyOpIqScBWCTAEy36rEw0cgTgVm7p1YEUgxqe35QPDlU2unk78lujBoMjaxw/Tytoe32eu7jgvd6bjof00JpSBPBldpX5JdP91waDYnq7eW/+PmnTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593482; c=relaxed/simple;
	bh=4l947GHg534kWuxgDdsr/D/jCmLe9w7U2jJdY6C2388=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KIbg5cOT71W35T648daktT5L9NXiJbb5VzCEXgxSOkZ0KVvrWkeQHq2P1SWQlzDMM8aIxnv+vsUYi/Wl0wLznfpGHHiBCqaP2jg9ZfXFNkIJuSEFce3HUtiPffvBRuarABp5EpHKeUEpc7Sr/lb99bubWLT5X4MB0wdNqEuIF0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=AUhHRPEr; arc=fail smtp.client-ip=34.198.218.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1775593481; x=1807129481;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=06FqoRIeHYDtA1v1SO5AfXQRZIsldTfXMXMaIRoLfls=;
  b=AUhHRPErfjvkinZy/a8x0daks6TDkH6ORZPRkbW+DvoKaYpMeQym6KJu
   ingvPCxM7V5/5njzZ11jfxb4Mgcu1sgG3vWHAfcbknxHYjFxZw6EpkvtV
   qZS4XVSfEL21t/Uav1EzzddU6GTq+UrwV/Lb0xw/XuGC9CD06ZEJO63gz
   JRhB2J8MpbfyaQnNZViLdrEW/kzf9ABZm/+tzlfBWu8/84TJv0+e4Ydo0
   2NO9Rljl/CqByZOX6sXL18LtQEM/5i8jDpn8DrVDVkEgEucfIgmdba34V
   51GgzpulAnjPK/dD5dPB4lBPpGGt+OkVd8xIeA9ckJmAXEM1cGheSMo/f
   Q==;
X-CSE-ConnectionGUID: lPnd7lvlReWXFO0TvdPshQ==
X-CSE-MsgGUID: Ut+ATXk2Qk+hMqDya2orMg==
X-IronPort-AV: E=Sophos;i="6.23,166,1770595200"; 
   d="scan'208";a="15183800"
Subject: Re: [PATCH] cgroup: add cpu.stat.percpu for per-CPU cgroup stats
Thread-Topic: [PATCH] cgroup: add cpu.stat.percpu for per-CPU cgroup stats
Received: from ip-10-4-10-75.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.10.75])
  by internal-iad-out-013.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 20:24:37 +0000
Received: from EX19MTAUEB002.ant.amazon.com [52.94.133.143:5793]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.17.255:2525] with esmtp (Farcaster)
 id 553e701c-8ba8-4dee-a16c-9874701cdaf1; Tue, 7 Apr 2026 20:24:37 +0000 (UTC)
X-Farcaster-Flow-ID: 553e701c-8ba8-4dee-a16c-9874701cdaf1
Received: from EX19EXOUEC002.ant.amazon.com (10.252.135.179) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 7 Apr 2026 20:24:36 +0000
Received: from EX19EXOUEA001.ant.amazon.com (10.252.134.47) by
 EX19EXOUEC002.ant.amazon.com (10.252.135.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 7 Apr 2026 20:24:36 +0000
Received: from DM2PR0701CU001.outbound.protection.outlook.com (10.252.135.199)
 by EX19EXOUEA001.ant.amazon.com (10.252.134.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37
 via Frontend Transport; Tue, 7 Apr 2026 20:24:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/IQgVSqU/6H25cyWPopBHUhnDjsPojrNogrsV8WpFHyjihHeRifHllo61yOUrTk2ptpA5P2hb2Lp8fyCYG7AIlIXLbRZvzTu+TinWYdPIkysRcCVFghiBomkHiTT/BgaC4WkodvnRCbRHqhGREeztEvjY/Wrq3ny+EglD62cahaDxSYcKcykzmZU44b+3FEONx/dX8Tg2lf8lwk4AzktwrOxkvQmHAxnQpHJv3c881pZtylRCyDhfDIfZJGy56RNECNPKCGbSI/bncOMT6GIKc23IS5ZKy3QTpIbxQett8J0Gg7kl9A8PCgg9pHz2ROkGrBTdCKsHg+T1oJKUjtXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06FqoRIeHYDtA1v1SO5AfXQRZIsldTfXMXMaIRoLfls=;
 b=MjlRuYlcwaq9uHP1UYXJfBZOrZC2hu87lBJ2lc0lXluTGPtaklDRjyJQ+qhdK8qN7IgTiv0bcb+Cns3mB1RiGut7kq4/Z9bgbLtOSeVo3QQVr/J/xJHpqwsn4bkeHUohz4rPEe7At7o1Zpv3c7JhmVFxNoY83K8hcyy8+NvgfrfU+pMbVkzloAV7ZrhwE++w7YLjTIEqz0tYZz+vSxux+u2CZVeo5OBSeFp55wyzbu3cuACJ2+npVNUym1f/d4YV+Wzb2NUBmXB4nQBxRRT1BLfEHi/mA+vuKLOLVksEQzbyr5Eyb8wu78NWITBbb7AOa454YdvUrTv+n92W1VGvFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from MW4PR18MB5206.namprd18.prod.outlook.com (2603:10b6:303:1bd::8)
 by PH0PR18MB4800.namprd18.prod.outlook.com (2603:10b6:510:cf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 20:24:33 +0000
Received: from MW4PR18MB5206.namprd18.prod.outlook.com
 ([fe80::3f29:8adc:e300:a9e5]) by MW4PR18MB5206.namprd18.prod.outlook.com
 ([fe80::3f29:8adc:e300:a9e5%6]) with mapi id 15.20.9769.014; Tue, 7 Apr 2026
 20:24:33 +0000
From: "Barro Raffel, Willy" <willybar@amazon.com>
To: Tejun Heo <tj@kernel.org>
CC: Johannes Weiner <hannes@cmpxchg.org>, =?iso-8859-1?Q?Michal_Koutn=FD?=
	<mkoutny@suse.com>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Bouron,
 Justinien" <jbouron@amazon.com>, "Kudrjavets, Gunnar" <gunnarku@amazon.com>
Thread-Index: AQHcxir67rrGqb+abUWGS5vu+cIhr7XT7BqAgAAgpQA=
Date: Tue, 7 Apr 2026 20:24:33 +0000
Message-ID: <adVoAK8ekj61qykD@6c7e67b75e78>
References: <20260407010642.3249-2-willybar@amazon.com>
 <adVMne0wsVCvc2hH@slm.duckdns.org>
In-Reply-To: <adVMne0wsVCvc2hH@slm.duckdns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5206:EE_|PH0PR18MB4800:EE_
x-ms-office365-filtering-correlation-id: ac268e9b-dcf6-469a-190e-08de94e3ae41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 8JgXQtq80oRpva02qi622vPkVNRPiDbKT9uUtQxna5cfn+8rB8exXq1KpvRoVM5iNaVqa61yHSQPNRKblHSHtfb+FM7+sbfXRpI+xKS2kkLw3XXyYIH7M539pfU46+I6OTeuuvBlJoDI3xattQRXkgMmmMkd8YNjYMLyeS8bNeNfjuQJH3dl8Qnb3zi8puLqK9F84EDYTNVUT3UawsM+PzJTrO4MpdCASoto55ZBRXhV0ISYXV2TypA6Mv7l0gzrnibUOMnGy63T88MW1b6u+DahFokvxOh6GKIuimeMer2nMsqnu3QHq0meE3UTRqO3gCp7V27iZcxXD4eFbcDhqNMunXH9C8MI+mU2AwyY1eRz2sf4HuolnF4k/EZvXGZFCKG9vjtoHPss96gCdWBlST18UtF4jAg9lyONAoueJwptli0tKGkYWMpNi57U1/IbEQjWX8Ovnxqn7/zXFJtyxP1FGOOmZZu/gLKO47f0IwsyhZ+tbWnUBc8d9cTSw8XTlXKi1QldYr0x7D3m+c0pW/VLfZwTMXaPEnJV4hpY3eK6QlRdlG7z4kOGnX9+0uQw0nuLnSLkUaIX5kdObAlfGknR1UgUHilSqCPFbosmCQs/akEva4ZZobidhlvs3e7+E3XrrEMswNIl8T93t+qGwkNj3RiSLhP9U9mdv3pBEWbhA0PKpDxkRpPp3rDhe7UaL3YyiO3FqAgmeF3U5yQWUNrkih0BIxDttshjUgigcEYSG1ZaUUSBBt6SkmLkG5SYDUWQYe5mOEVTbbDkkU9MZdGUs2jF/SXT/Dx7NJ7xbp8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5206.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7HMnxZ4QZPzT+vJWIJNJV9bdI6wxIEBCKHYGKS+E8Qbc6MFXjMZAAmv7Tw?=
 =?iso-8859-1?Q?GibxZFqVS1jUnS9GiUdH313DTtskzSX3vBPcFuLjV5MsW8ozfp24cSj8bp?=
 =?iso-8859-1?Q?P6pNALlricZFaZrZE8Bl00duaq9nfjF0rPtu6oy3Seywa9iLOYx0n8dbHz?=
 =?iso-8859-1?Q?APYL2QtXf5wEFIg8PoGeUeEi/1h0195Tb0nv4DuNUN+s0XochZCqXJR/2l?=
 =?iso-8859-1?Q?dXSdao+umMvCIafYQixNIO0pplKHYRVFDHws+EzlI5XG8DLmYmkO3kZlJb?=
 =?iso-8859-1?Q?1M75XG7tCkUrUcpmxLAqDFlezJ1aCQWVuWBuF9nnn3eJ3ftmLvqitDvzEB?=
 =?iso-8859-1?Q?YdBeuRfTd/qXQgjDhnHTmyLwgjXabyTvbi/aAki1WNYBV1DkTSBq/35APj?=
 =?iso-8859-1?Q?labkdGBfrpnjQ00P/o+MAW4ujUApTtE+ljjyi/sHeyItu1JjuXEifiysf0?=
 =?iso-8859-1?Q?tyW+YFCVeY7ZpN88quXONPicHZF2wg1TGF0J2djJmnNj8ukpMpgTzaxoMX?=
 =?iso-8859-1?Q?f/EG+oMe46Hl2CHfXV9CTbLH6g/aKIEpu0meomhFWHmdZiS6nPM52BTtAD?=
 =?iso-8859-1?Q?+Mw9WCovQs7dlo4J1+kC0ySvXG2wd0wc/rYzQ1zQGIg00FyCxoWRknIZzp?=
 =?iso-8859-1?Q?CWkf4ANEh6FM1vPf2aaOF+Ss3qZ+ZHg9WNqcaFhwQHDP26hw7HODoY4gg9?=
 =?iso-8859-1?Q?5jg9gvG8BUQPQk85p1lMbL6OOFb5MmHn348PRkrQ/B/GFsxdty6frnyfb0?=
 =?iso-8859-1?Q?1LWJ4hDerjWUmowEga5mSEL+sIgRQvTmqzl5KRRkpIZw0akK26BndYQWY4?=
 =?iso-8859-1?Q?5aSY2bnu3gZ8kDkS4I9gn3wIZ/kuZ0cy0NIMFKB8qxaImkHgdpuC3wa9iX?=
 =?iso-8859-1?Q?2dZ4TKkxSMYUXpYGqjBhh1NepvIxIfnVkRoCwTCx9QBV+i0oneuy33vbpV?=
 =?iso-8859-1?Q?6VSundwQ0/WkhmvKtp6RRwcLv+GxQ8hxh1KO3JJimZ1ssnTiQXtAYl0Dlh?=
 =?iso-8859-1?Q?AvrembHlmpaNBPbjrDBh8mrtIL5aXNoglbmmYd2FIXCbIE82DmgNx7wNfS?=
 =?iso-8859-1?Q?/uy3DVZrEMyVLg/n4NfF2ogCVR5zhTrDUmd3f7QP5bxGJ0J+1RPfhKZeTz?=
 =?iso-8859-1?Q?VakUAmLnBOxXtWtsFJ+UW8aa2CYZmwJ72xz7NEgcCBhHBVzaOrJBHenye0?=
 =?iso-8859-1?Q?OuxddabCQuqDOBphs6EMZzwS8GzeAGGB855sJyphyoL10uaWI72GpwxqGW?=
 =?iso-8859-1?Q?mNGpSi+u3XrscsQB/P0FmGcZrIhIrezPW4MyVD42p2SAeu72rhiFp+DBEU?=
 =?iso-8859-1?Q?y2q9kzxI0cmf6NwmHKPIHB4ESiwf9B3Siohl8SF+1xnQaCFxgL4m0+P+5n?=
 =?iso-8859-1?Q?7o7by75v9KC2UBKN+WlKd49U9YLQ9I1Kr22YQRgF8Ndq7QpuRp1mTNmzEF?=
 =?iso-8859-1?Q?w/04bP6BBEk5AM//3x4rP+4lSWRoeArDdE7hGhytq60ajNsOgu7doRv7So?=
 =?iso-8859-1?Q?Ely2m39V93bUu5iiZNZOZgUUSZRVSTsmNwxR7fdWYWdJCuWmwyc7P3gycw?=
 =?iso-8859-1?Q?+W1y/npAgTGdmZb5BgNYm9f4pJ9KkH5iKPokHTi4W++fqkKT1KR6t9mLlF?=
 =?iso-8859-1?Q?mBe+gaPmQ2u11Z9FesuR8G5QK6O/4rWL7Pz/+S2JycvntjL44S6+/41utR?=
 =?iso-8859-1?Q?HC2IB8TKperOJBel3R4df10i2umX1063zA4QYgL+fV/JDxurKwT/rfOe/O?=
 =?iso-8859-1?Q?z4tK8C1LScjJN3X4xeSINv1KvkqGuScENFNhgdy3Wa0ZS/RwtB6hUWAIx6?=
 =?iso-8859-1?Q?lld7gT/HRg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9251CA4EE47867469CA25AC1576D7DF2@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: V7B6Cy9jae2bdQ9gFis7UYosZOoIa9YRj62lXmPbOHksg2v4g+DkYWo33AFLgqQUIvsLw99BiVAiNpkzhBl1itV48i7tSnm9L1ANkvVcGRauXtPuVSBKIq7LRu5Uhg19fRDlknnoKFasaRt7TnA0A8gUOKNl02vEenpyOCmoSUQ5cLln/TR7EoROSybC4Mi//iLN4mnQsVUdqTulNFpXoEc3xDdOB6oRVrFEWnexS9Ib6NTaEus/xLQ77kzzlTGtGh0YV74LPcslDZ1mSCB56gmVTiSdDy6vzxGLvw4oE7Wr5uXGh4bVvg8sfu++DkhepSf64Dkmr+L6gug0Da0DxQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5206.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac268e9b-dcf6-469a-190e-08de94e3ae41
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 20:24:33.4826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nR2/g58pgKMVZyhsjiqpgHg0Q3XY9SIWmxu2uLBJQiRxRJbWOgig5BcuNqOMqhOae0tRIVLlPFpfHc08/6LPag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4800
X-OriginatorOrg: amazon.com
X-Spamd-Result: default: False [-6.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15189-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willybar@amazon.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 56AA83B4872
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 08:27:41AM -1000, Tejun Heo wrote:
>On Mon, Apr 06, 2026 at 06:06:43PM -0700, Willy Barro Raffel wrote:
>> Expose per-CPU subtree_bstat via a new cgroupfs file cpu.stat.percpu.
>> Each line shows one CPU cumulative stats in io.stat-style key=3Dvalue
>> format:
>>
>>   cpu0 usage_usec=3D123 user_usec=3D45 system_usec=3D78 nice_usec=3D0
>>   cpu1 usage_usec=3D456 user_usec=3D123 system_usec=3D333 nice_usec=3D0
>>
>> This completes the interface left as a TODO in commit 7716f383a583
>> ("Merge tag 'cgroup-for-6.6' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/tj/cgroup")
>> which added per-CPU subtree_bstat but only exposed it via BPF/drgn.
>
>Given how quickly cpu count is increasing with 1k CPUs on common prod
>machines not too far off, I'm not sure naively formatting output for every
>possible CPU is desirable.
>
>Thanks.
>
>--
>tejun

Good point. I can skip CPUs with zero stats in the output, i.e.: a cgroup r=
unning on 4 of 1024 CPUs would only produce 4 lines. Would that address you=
r concern?=

