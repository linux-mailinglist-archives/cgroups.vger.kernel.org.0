Return-Path: <cgroups+bounces-7815-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 534B8A9BBF9
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 02:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBBF4A3339
	for <lists+cgroups@lfdr.de>; Fri, 25 Apr 2025 00:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081918C1F;
	Fri, 25 Apr 2025 00:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q4tvfboB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ELlLotGU"
X-Original-To: cgroups@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F278F66;
	Fri, 25 Apr 2025 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745542397; cv=fail; b=c/IYqzPmt0OHpwQEr8ERNhIIdexzRl08pLqActDPicUrj52HzLqRC79BI6Wm4HPibUQHz2tuohlF6KvvyyU6uKjvNCP15ze4eH/3W0ukIJ0M86cy+IusW7rUUE+eKt+jeM8HbxguMhe2B6TYNitTOIMRgesecrLcAowXcyWn7tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745542397; c=relaxed/simple;
	bh=o9gETWeGS5PcThy526HDZMv8TfKO4eUqe/RD1oONOQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ABYV9crgqArnJhZePIUNqc/Lfv+ohMg4Lo0WM4EypketFh6yPh3OPs6/cjOqMJF5iKfUTVLZpNPDl4jdhscMT27AnCPmWtZbd2B1fAvBi3p4cyM8ge93WnJG0zH2Q49KfNZucDJdQ0thOkww4Zho2SFKgqYdbtJzk95vKt+7bjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Q4tvfboB; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ELlLotGU; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745542395; x=1777078395;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o9gETWeGS5PcThy526HDZMv8TfKO4eUqe/RD1oONOQE=;
  b=Q4tvfboBWbskaMsF9+0dalB8XvYvZQi+0a3tCjPR0dA1ceiYhsxifzpk
   CO8AuAaHel6qB9W4pKxXHkUM9+utEmQ/UmxifNs0RBaGGd0TcvDLNsZoX
   rLxG59HLZuXzCrV6w93tM+Q+mQJaXDGL086Qa/U//gaiRIdvR88Otacgm
   9pwWmuSQ1tblE6NFPjPVffcv3B/BsrjuUJfqTbOEEUNuOUvsHmmFpq4cg
   nzaZcbDIi7ceoLkDCxsOPsH/bOvvElDQZPWHnP3dLbUMU1BpcXdL8tDwN
   mE4XqwOTwn9BQccv6F/qdz6FAkm82Ork9+xc218NTKYGx0J99KXt8mEfa
   Q==;
X-CSE-ConnectionGUID: mrb74eLtQamu2FtxaEQjWQ==
X-CSE-MsgGUID: 7npAiciLQXS0M6pz9/YuiQ==
X-IronPort-AV: E=Sophos;i="6.15,237,1739808000"; 
   d="scan'208";a="79292460"
Received: from mail-centralusazlp17010003.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.3])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2025 08:53:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBYo7kfKBKXCEIbadh9dgjA4Vncd4Gai4tlxqbqt8jyc0325Mg3HcI/mk8dauS91zsNbnxiEJF6zLm41k2zIFZR98DQk15fyLeNbsCgbEN1r7yKJleBTfs+tz6NbzKxDV8+vhUKmxw11HD1BkhPJoZgg5xWd9D5WQRNO9M+Qflnzf+/nolxaNefw2HwayIBIwI+SgLuZxAljGbtEd0/a4VOMjGieVxchccX5VizfZLE8K1HPEfc1eZ2b9VMLU2ktHAOxi0d3lTxXKYuOx/LoASyJwJ04K2RTyhdxGkQNCYrjJTgbzjDd5kZZOD4g8zhs1NUxHv2A2mRSQDcP7KM0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDg7YCozpha6xER5KiV4Mcj4kuoon0up3l09Drd5AbQ=;
 b=T8OGgnVfjwOc1fv2MYl665gRKDf2Md8+DLQeYDShVxJZFohVmX6etbJthf/PniXcZXdxuZUsBjhoADEyuA2zSUJKX8O2Vwt9bE8LJcYjOWXH46yOtZ5ziZHqU3/yzNXZHykq6fhMSuOoh06r4L/8glVxRg4qwdbmv6bC9G6p6gjmbudwSOw/oWh7N2GvMQcwsEXBjqysDZGKzPCfgg5Pw826qnSnvrosgLtCvFDp/c8iUljQj+L+F91o3+TB9bDnrB7aAT3r4NsKM8EQ+2XpFMrXWBcBuYMR4yTIodjqzbzbiXYRh87ac+v0UsZg9khdvjTRRmbZs2kpcAa8ymXBfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDg7YCozpha6xER5KiV4Mcj4kuoon0up3l09Drd5AbQ=;
 b=ELlLotGUAzvv5vxBB0Voh0lV6s87LobIN1CdT0XxnVejFfsUnxQ4ZynQmOJ/wlRQAw06xOurtaWsEYJ+8doSTFI8ZcBxaCDr0FASCcnzYf1E/qWkIY6uQpeH6emWYEVPrwFJS9JMfuFqernjCperBzf2spUhUQwWri+h7HmcVTw=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by CO6PR04MB7825.namprd04.prod.outlook.com (2603:10b6:303:13b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 00:53:06 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320%6]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 00:53:06 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Waiman Long <llong@redhat.com>, "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: cgroup null pointer dereference
Thread-Topic: cgroup null pointer dereference
Thread-Index: AQHbs867Ho4DUg/FyECYHcuhUwZmwbOxxQUAgAHKuW0=
Date: Fri, 25 Apr 2025 00:53:06 +0000
Message-ID:
 <BY5PR04MB684951591DE83E6FD0CBD364BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
References:
 <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com>
In-Reply-To: <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|CO6PR04MB7825:EE_
x-ms-office365-filtering-correlation-id: f4c11e17-da3a-4576-bd6b-08dd83938a76
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?E4HNWdRFmojAdYWSfYMTgXEU9ikjZugXh+Vgm9XC0tAaZ4wTIC41+wjtlB?=
 =?iso-8859-1?Q?tPmybLupWZkZanKVdikm6V4sKJAE8RHWrnsyNtPV2ZbimJpkUvm7nAddON?=
 =?iso-8859-1?Q?2BPexkEZ0ncylrNKvd+pYNqh/0BbbUdnPZHQy1YXB/fP34FcWydTzHQrVr?=
 =?iso-8859-1?Q?e6HsDat/UNd+wXpVi4qQfWx0uKA0sRiSP5SD8/dNwDrd1ZZAeekswiHmRG?=
 =?iso-8859-1?Q?IIIdehqGceHlyE8g53qvwF+epwO1z04ScigKOObs0iD55E8Ag5yvj43v2K?=
 =?iso-8859-1?Q?M9lJQ0yMD2GbwGRfZU9WxJHxjOoi8fsHQcNh9nwj0OPwg4DkMiPuwOy3KG?=
 =?iso-8859-1?Q?FNwnMj1XLNCmryC+xUqGRonY3GgIRhUzAHAyphpIX+/qHN17MeZ0ElNc6i?=
 =?iso-8859-1?Q?8bx9FRd5Ps+FWnt7fqfXqN81dnsjhQ5DXGCs0R/jFvLwoCjmOOBQc6a3ov?=
 =?iso-8859-1?Q?ka+aYGV8o6QwnL/L59dgI4lKvXn4bBlwgN0ggyw8oShFVbnqgk6DRSsKwF?=
 =?iso-8859-1?Q?Ik3khYrPUn8/CZatoHzR9oVa3pIuOOFfV8jQ5eJyGwikti0UfTtB+XSFve?=
 =?iso-8859-1?Q?f4HYpibB3zDGSH83GaEOExkazXgMbxg7jgyvn7gw/qXFYEIz9/l6mO0H8Z?=
 =?iso-8859-1?Q?ahhhCnVKX4m6ZGDxdiNnXtUlacvhyjMe/Li97QuOl4MPfbiRlUR/b4Vn9d?=
 =?iso-8859-1?Q?97NH3J7p3GIQHljiRZh1khAuKCq2rJifCAOfXlQeS/9YASwwmNsbewx6YU?=
 =?iso-8859-1?Q?LHDa7qfnqG0qqsq2CW16MaoffMs7by/heKeEXxz77qew7fStqzYXkpVmK5?=
 =?iso-8859-1?Q?evQeO6UOy1k1dwjd3sjUYxZv88b8Lx5BYuWwf5mBAVFsffxeLq5fiqCKz+?=
 =?iso-8859-1?Q?TQVReV0Ql8uhxlWuQVZQYvVB58HDgheXLTj0wBsQN0VhcazRhqhiU9IISs?=
 =?iso-8859-1?Q?PaPiyWsxBfOz8EECcLiwvc6wBL5m5cbMLcx/cRl7+pauxV3+KhfnFAqW5u?=
 =?iso-8859-1?Q?B0AE0p+oQRtcb78dZouHAcSRqz5vdBhiRN6m/a9/wlrBrKvnfPKzpYiir/?=
 =?iso-8859-1?Q?D3U8NbahyMzORuG1E0/k6JhonCcP68QwZC3xDYi0KcyAJdEoBluK8NcPNR?=
 =?iso-8859-1?Q?GN4Ob2eXvdlmXJmGsLpHk9TZUQREtst5eJKtuLzsrgDsZVgjMh7lPz3jGF?=
 =?iso-8859-1?Q?09a7FuXSfPHXibvTjd/Un2VHmE5hQOpf2eX71lp0j50RZDZ1eQBcQVAQ3t?=
 =?iso-8859-1?Q?B2+miXL2t3k6FTLqbgnkmL5fp45Jwtf+bd+6+s/XfwWJiMfL5FOiFNF7yO?=
 =?iso-8859-1?Q?nKDkRw+6NwD3OHNepIR9q2BpQs380I6+KA3DgJNbB/DzXmTZInPCSn9N7P?=
 =?iso-8859-1?Q?Rrqc4OOwWIzNg+h+ROvtcQWUWRRPBjkZziJEfakMGQylTFTfiFaCmoZs0X?=
 =?iso-8859-1?Q?7yOrGCJ3tT9CmT7XvqJdQ/qnQg5Rvjmup+wuFJAppao663DSZWG9aB8Ype?=
 =?iso-8859-1?Q?zP3/nBau2MtPZGTzXkZYvgfkUwkEAW0cYSWwS25XMVmA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fYqFM/Vetrm5UXiE14AeNKyd+WXGvXfAwVlRuvhmseTu1xTwJgNuOSYncb?=
 =?iso-8859-1?Q?FJQtX4mOc3aVXW2l9b4BOjQ7UN7giqgx2ruM3VnwftlhuWIxeaHCFwjMKa?=
 =?iso-8859-1?Q?Ech39QpDMYW+i4NRIU+4/zSpFcfPNvkZEihvT4Io4Vf/94zttH0MuZUDOm?=
 =?iso-8859-1?Q?RMzo+AZ2OVReiD2XYHt1D49HuFYp+2VfJlLZqM1Z3UkD91bLNM1fZjXJ3v?=
 =?iso-8859-1?Q?Wb+KcGejDbVi/Olnf0rMboJoUQsbEADXLDhnkj0GSIf4KAs46WUTHTTPtC?=
 =?iso-8859-1?Q?NS04PyzNjWWth8AQHkMmRRyeJmkBdi/snIFtvjNUCh36HGV/xu7Uo+U/YH?=
 =?iso-8859-1?Q?2zqYLctRBioN3DvPtmHP3k/GFRW0j5fkJBhUscNdqS1UPlPfDoUIMp9CDi?=
 =?iso-8859-1?Q?vX3OYueBxf5mj7me0VSqOLkG+5Z13DFIzzubEUM8u5KS4p9WrsHsFT5ozU?=
 =?iso-8859-1?Q?XjFyd/pAmNdSNpZ9mEFzEHPFuqgMNd8msIQJw0/jlV6QPIf2ZoR5ml50eA?=
 =?iso-8859-1?Q?6RtDdvKj/+OrivJHo8Zkwj2mVEbI8GbDK5Bqqlr9gvQt54t6Nv5p+IC/PY?=
 =?iso-8859-1?Q?TIW9IlvpBSct/j+kptb3Fqz9D6At657No9jOyS/7du7FDxK1icf8iNaT8m?=
 =?iso-8859-1?Q?BFQ6Ng45esfGCuYzi01ezjDR/7Hyj9jI8W39lDYe8+TRhhHqi21AoTGpIT?=
 =?iso-8859-1?Q?gCDMwBKKXUitlI7bz1Ssjdy0Qqdo6ZufSr+kIFT6lrx0r+EHYP7LRhOXwo?=
 =?iso-8859-1?Q?QvkOKOTBsPSPpqA16itR8JFO9tGoJAIwkgYNr/FBjz22sfRD1BXiDXMrpy?=
 =?iso-8859-1?Q?ZiQZPOsVrJY2wPMAd3XkYpo1iswRoTnH3qR8C2OfwkBk2fKPH+XaBnQwl5?=
 =?iso-8859-1?Q?84VwLAZpoQN4QlUtZz83D9+TuB5CfJHBoWROV1XRCZiBCdrH68LD0q1GHU?=
 =?iso-8859-1?Q?Bbd8wQjabLIcRgc2mVxzLCpgVx3UBwrAY1gQnGRGQ4hPaVMyGJGnKKRKZC?=
 =?iso-8859-1?Q?trnmW+nM4y8ZwEF4KTj1Qtr+yPmhocCorfiiGSDTqKNU5kqy5rGciTk+Ow?=
 =?iso-8859-1?Q?R2n6IygntUvi2RGU8a7Xycb39+mwuEweGwDsZQurAZ0z/rytp/zo8w/S/U?=
 =?iso-8859-1?Q?dLGK5OSoKNgQTkeuCbEv9Hq1D5h6VJRvlvloisNgWCecOA4AT8n08l4vl1?=
 =?iso-8859-1?Q?BmZpQjbWFrFCwW8MidI5in1iQhDPVSf7D9XzGuOgH3j2a4d2iueFQcZkPy?=
 =?iso-8859-1?Q?GN5ZHIBm67PggK4m2Z417StxPli+uSWVAk7dEgtyOAFjfoRjRzyKnKrHw3?=
 =?iso-8859-1?Q?5B+1KHzkHWlIkiwttGSLSuhXjQ6uDMH8BaKyeS/filUe+baGEqk1QYN82A?=
 =?iso-8859-1?Q?4a5h7vU6l5GzefgfMr3lk4inertWueDUjXfhX1kqJseWmUoYT4pUV6Fm84?=
 =?iso-8859-1?Q?zZOYVpbGXrPKh620husqocGUs5TupJPcP6nJD4PobG0t2HOJdATY5ed3NH?=
 =?iso-8859-1?Q?4LBtmVltVvb4iEP46+zCdJIV1OwCoK6urrkdza27TigbtP1HwNWPgh/9no?=
 =?iso-8859-1?Q?dXKDxnAdUNwS/Nc3Y+IvpEMm4gj8i45q3Yy3tnWFWV6JMrm002rHnmmy8b?=
 =?iso-8859-1?Q?7x9EZZLAxUBQTenRVbBueCK/IXmCkIH7EV?=
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
	GFz4FXFpzGbMQYb7NWifUB4g3wGxLs0Ad9JFSHTsE1ZICp9cX9WidTCEks4Ung6EVQ5fWgjoD9S39X49EaI3p5iVZWd0YfV7h8o2JV8SQpZj01tsQCM2aTjaBsUZyQdaD8CqfKefR85aAeabQ6k0TjFBASmOEIzoVHJqSf6QCyFz6gm36BXnHYbiS5JANsHL0q8FaSSRviogZP5QGHy6dofH0W0QiYnQ58iYwEKK61rxdp3jNdfpG06O2f4lr0wd+Djc9GbSbgUPoemWQb3V/O/xZ/lf7O7VJX6rRjzYaQPZASJN1+bTzfO4lnxdbhSLPHrKgyovDuVD6Am1Kdt3lkxvybhS+6xHiArw5nbUb14qs+XbS/eK3yEySoZieR+MTMIh2rFvEi9RgRElOPA6PHxEaazhJlI4t8+Vx96e7jRnArZs7df+rRveTHHAxqRXNcVvbF/fWDfEF6/zx/nwHFPxySl6+fiu+tlilweoX2CCAOo+szFlgwTskHuxCBFlSoEm+/Ct+NrjTOw+8vj5K1F8C+KxmczKU7S5fNPoX5cVOjLppoj1mTlWybKl9QinLpJu0+T/qeyFUvnzqIyRhynq8PkZBa0ZLhGmn3daYx1V4NCeeHrbJED9PVDxasRC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c11e17-da3a-4576-bd6b-08dd83938a76
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 00:53:06.2316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bvrNHowRzxOApisl0fW8lO4KlQfspJYhiBEHdhqTBK9gG7GkUwMipndgwrOuvcwksA3I2mAdguObiA1AonOpcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7825

Hi Waiman,=0A=
=0A=
>On 4/23/25 1:30 PM, Kamaljit Singh wrote:=0A=
>> Hello,=0A=
>>=0A=
>> While running IOs to an nvme fabrics target we're hitting this null poin=
ter which causes=0A=
>> CPU hard lockups and NMI. Before the lockups, the Medusa IOs ran success=
fully for ~23 hours.=0A=
>>=0A=
>> I did not find any panics listing nvme or block driver calls.=0A=
>>=0A=
>> RIP: 0010:cgroup_rstat_flush+0x1d0/0x750=0A=
>> points to rstat.c, cgroup_rstat_push_children(), line 162 under second w=
hile() to the following code.=0A=
>>=0A=
>> 160                 /* updated_next is parent cgroup terminated */=0A=
>> 161                 while (child !=3D parent) {=0A=
>> 162                         child->rstat_flush_next =3D head;=0A=
>> 163                         head =3D child;=0A=
>> 164                         crstatc =3D cgroup_rstat_cpu(child, cpu);=0A=
>> 165                         grandchild =3D crstatc->updated_children;=0A=
>>=0A=
>> In my test env I've added a null check to 'child' and re-running the lon=
g-term test.=0A=
>> I'm wondering if this patch is sufficient to address any underlying issu=
e or is just a band-aid.=0A=
>> Please share any known patches or suggestions.=0A=
>>               -          while (child !=3D parent) {=0A=
>>               +         while (child && child !=3D parent) {=0A=
>=0A=
>Child can become NULL only if the updated_next list isn't parent=0A=
>terminated. This should not happen. A warning is needed if it really=0A=
>happens. I will take a further look to see if there is a bug somewhere.=0A=
=0A=
My test re-ran for 36+ hours without any CPU lockups or NMI. This patch see=
ms to have helped.=

