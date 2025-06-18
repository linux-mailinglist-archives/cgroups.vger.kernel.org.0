Return-Path: <cgroups+bounces-8590-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A09FADF226
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 18:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B594A00B9
	for <lists+cgroups@lfdr.de>; Wed, 18 Jun 2025 16:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643FF2ED159;
	Wed, 18 Jun 2025 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bnaBaAcF"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533CA1E47A5;
	Wed, 18 Jun 2025 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750262781; cv=fail; b=PIcP2T4WaQiJVbi8tw7oM9xpgvNGnHnhI1x8X6MsZt0iIrca21sjV4rIk/83G8kH5iTwEAbgGTAuzcqhEOcQrbPxBbVXA1rPKu/USEHNL1xDS+tWTpzpUnusSxllF8SYLchskRIM9r/MD0/ZoLyogH/AeU76pCQuBWttDu7yfqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750262781; c=relaxed/simple;
	bh=6sqmWeacOHqjWX/8vzzpiOhFmc025Rmm4vhYDfe6uJE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dAmTpWGxu5Ezvzy9Hex7t1zTQy6qWt76Sa2Zwq44DpAJXSmKx5LdVts17t4yRUtDIY0YJ34c/MGKhxAQAKft/GrHR4TcLYnEMpSY9y2Ig5rs8LjXG9HNgxmdU9imy8l51C8LP7agb54+WbilSn+sMmIeoyEp8P1SkDOXwJHrC60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bnaBaAcF; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750262779; x=1781798779;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6sqmWeacOHqjWX/8vzzpiOhFmc025Rmm4vhYDfe6uJE=;
  b=bnaBaAcFSWJc3YsrjVQbKzXRlKzRoJLBd/tA8uvK5Nx2d4MU6RPHnk35
   n6oT/xabEA8m6NlRv7Oe+shjlkPyv/RoXrcpwL+ExSAqh5oZPGTGUXRmL
   mb2lUuC/eBROuVY/D1G1B+Pa1QPQ7DOAHQ+AxeNivDNcBFcGiRZEFrhbC
   LwlKxuW13esxMrINJMJUb3rDvsh+QCDHHZ2+JvH4Itsw7CM6XilaoMsk+
   qBJKs/DeNqkqOHtiggbDNoFNYTygYeoqie/IavE9uDY7CKhV7b+97llMt
   fmB3z23XumIwtWC+MN8FFJKqCWhz27VnzVI7cqC3TN+HeBBbeLzTvpAkL
   Q==;
X-CSE-ConnectionGUID: 6EvzNee9Sn+zYhOx9sAPHA==
X-CSE-MsgGUID: Ore3RbCvRnuPL6yrRaEdoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52410944"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52410944"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 09:06:18 -0700
X-CSE-ConnectionGUID: +DOiss8VSieLA23MQeV//Q==
X-CSE-MsgGUID: cyvDDw5XSNyuWdfczRKTtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="150399333"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 09:06:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 09:06:17 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 09:06:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.45)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 09:06:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vn7AWoWYo3hsd1LhQZ9eE37SdL/0EYB1aoONRAu97fFdigNhYO3pOoyL0HXrMOsjbyB+IKtfgeu53r1UROCAzq9WCMjzhP7JtCkHHnUgpkYJVZnnTFbnTOwDjoUtqSYNZsq3MQ1K2mEwwD//5D83HwMY4CB27gxJtpKjEnq4nF99IbQLZ3wxWDgIhWXwYrQPM6uM8x+OKDjDSYJVPO39rsM9yKWuJy95WgL4MkpV5BIsfwqKUW8qUmzajWP2cvOdgJ+0105/mhFNvCEO1rIhJ/mfXOLc7U9YeR4kMjmERHUS4DZH/i1UP+202k5vVntR99wHz3s9SSmEK1zz0wSCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbjOabSeIPf79sHKJz3A9J1pPPax1gTAejXTRCkVy9k=;
 b=er6s1EMu5uH8ga5sXOp28dBs9t4f/2UwVlr7zT6aMzVDDgMGuaeOyyEbBdhkTmp045yo8ylyE9bMumiqp4OaYGw3hS/gD9OBCC3XgdB3tpuzO431xSLHQwew1zMcowOyscbQFucZBezBHJMdiQPfgsYDSSQrE3P4JdR+KTfQRLeRuFqDwtb4EUoDoz17PTsHpbSaXVsbNrUj0KpOysV45B+8M5afYiRmZo3Ektg9/TtKBTocGr5TdQ1wpFBKYn1+6B8SLnO/KGDd9wPZfKQG6Xv2ytcNFyfUq6cnt2MX6MwipEm3wOl//tIjIfvUpKUA6iqZs16AnyA7Z190EyLK+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7894.namprd11.prod.outlook.com (2603:10b6:610:12c::17)
 by IA0PR11MB7282.namprd11.prod.outlook.com (2603:10b6:208:43a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Wed, 18 Jun
 2025 16:05:45 +0000
Received: from CH3PR11MB7894.namprd11.prod.outlook.com
 ([fe80::4d2:ecb9:b88:6c9a]) by CH3PR11MB7894.namprd11.prod.outlook.com
 ([fe80::4d2:ecb9:b88:6c9a%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:05:45 +0000
From: "Wlodarczyk, Bertrand" <bertrand.wlodarczyk@intel.com>
To: JP Kobryn <inwardvessel@gmail.com>
CC: "tj@kernel.org" <tj@kernel.org>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "mkoutny@suse.com" <mkoutny@suse.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cgroup/rstat: change cgroup_base_stat to atomic
Thread-Topic: [PATCH] cgroup/rstat: change cgroup_base_stat to atomic
Thread-Index: AQHb33LUrIYV3Cvt2k+rQD7YLlN2JLQH2D+AgAE1cTA=
Date: Wed, 18 Jun 2025 16:05:45 +0000
Message-ID: <CH3PR11MB78947E610456E1EDE1EE8B21F172A@CH3PR11MB7894.namprd11.prod.outlook.com>
References: <20250617102644.752201-2-bertrand.wlodarczyk@intel.com>
 <5f055416-9c49-42c0-9ba0-e45f6aaeac04@gmail.com>
In-Reply-To: <5f055416-9c49-42c0-9ba0-e45f6aaeac04@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7894:EE_|IA0PR11MB7282:EE_
x-ms-office365-filtering-correlation-id: 5cc25925-25a3-403d-073a-08ddae81fbe4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?I+FXSaxgoTAD1wjlGgpFccIW8oSL6/XJQZcSkMbwggQ+XKUY9T5gLNmGMDaO?=
 =?us-ascii?Q?kVdPMevKeD8bUl1fjIOqO88kxNIj4QJIuEjNmKt8Z/DJLUvDzPVXOImXGhMm?=
 =?us-ascii?Q?9kUAUNkFKjGTXxpIokOKCCMVfSj7TItYdSXlnuxZaykHNl3r+bgEt5FuWPsH?=
 =?us-ascii?Q?1Vvbs+4rjY/xl1PiKN9CFmyYOCe6yhiLT/e2dRn1kUkaaFh6SnCJwnXMBFdd?=
 =?us-ascii?Q?nKHYYdga+aHQr9GUemgIlppNBSZbQLlvZYI99Ije/oOaBM9MxmkorAAJOz4J?=
 =?us-ascii?Q?it0HjmLGI1qmldFbfLZL59wudxEIRO9onk0QvPQx0DLOGOK+WsRddluu8RC2?=
 =?us-ascii?Q?3H+EPvD6EJgwZCRTpl2itVMs7pH6d7pMRpXTVHLObLn2XE4/jYHpKgsDoBC6?=
 =?us-ascii?Q?WP6op/wiuslU0j26GGgzWKUVi+sF/G5Yo+TZl8B1fxh+i0xU+hLz2IzOd8C+?=
 =?us-ascii?Q?Qwx0x6wEKunUBdj+jV9YrfvKInzC8kp6wu3t3p/vWyVj4RvZBc97uHOD8rNX?=
 =?us-ascii?Q?UFRNFz3fE8r9HjNS29Ct4XMKLkHrD0g4bvqDWbnk7ORuklQDAHGHwo3vZ5y7?=
 =?us-ascii?Q?WhX4E1/O65cyVc91nCbQZRysj94IpwRDwmAm0M9FfAq/+S9B8Dmwdy0vbo/p?=
 =?us-ascii?Q?Lt2yEGLh5/933X1Tia50fxnhWAWrbonxIskLq3uSrZt2r7p+J6L7r1osrAa3?=
 =?us-ascii?Q?5eZk9M/KomD+GmT+MZ0rDdI2lQMe6eMQU8ihlXfPEqKM90qXEVUdV+Do8elV?=
 =?us-ascii?Q?JgwQjA8zlWQy578Jn8jaPjOMVPjHlSWxelhPZnbyXfNNjBOEhsPwKst4zhX1?=
 =?us-ascii?Q?fnPpL2YGXpy0OIP0YC6r7wSVxp6fRUnqn0UZUMnJ6x9o8ScKMwjLpL4Wv3Sn?=
 =?us-ascii?Q?hZ1K95zA9+9wo7jqEzxLQC8oEvBtp9WG07f1+8C6gVdBRyNUxeYQq8Xn1Ijs?=
 =?us-ascii?Q?VJpl7h/sK15Y7sLP+0lnjc+X22soxlW/w7Wp0QIW8klqYYZAAHmikS86ayO2?=
 =?us-ascii?Q?/BH9puUf27BeIGmQtQd+CDIOe+AqgJhwEo+6+KSrz57KskjQZbhIXKLc80oa?=
 =?us-ascii?Q?8ac1PMRhE+iNo7M6cTQyu3urX7iFFqnmBqd3saQIu7IfWFflukX/ip9VCg1I?=
 =?us-ascii?Q?Gteln8gBvxGO3J/nZs+eR1fJJX8E+btt3kGUn/W+P7hw9hnFtpYnO0wlHnt0?=
 =?us-ascii?Q?Vl8jEnU8EkCLC24fhkI4sQXkc2rhqFfrBgKgmaH/S6b+6o2V8/MzwLTQYh3M?=
 =?us-ascii?Q?XKGcn22zrvQ5q+tnIze67aVDFJy4xx5PX13BKP1l4rnlpdPWbm/4ZCCMuioZ?=
 =?us-ascii?Q?YRrA+IAr3sfV6HJSGJUqOlI6KER3wauadCQG123IQZbZDuoeV8qrxErcv8sX?=
 =?us-ascii?Q?ljTdnFgieUQ8p9EEy/u1+Ld5Xj9WAhwKz/oCFWfv/wr0By4pbzafsnY4dEot?=
 =?us-ascii?Q?UBt+T2yBqAZJGB0aRU/iAXQB3bGo4PyKO+J2gCJXz6j7vldj6fHj1A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB7894.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5EIT1ghnefSDcGAZGnJkMVR2YHf4UFP2YyoMj0wTbYiSyK+tLnr4jtt+AtIM?=
 =?us-ascii?Q?kKEFbw/1fAAQVvflveRY/pe501xHP5qIY3zCq7ggXKq198/y9NKBYcXYOY96?=
 =?us-ascii?Q?Qg4hFsMFilYCXteGdfQYnV083tLXeNGyr1FkZEPi+h3imrr1F3/RooueQQ43?=
 =?us-ascii?Q?1edQiq8CGYwMKwXCkYyzzmUeGMdc49t8bVZt0VybGyhukscgEH71DAKd+pkG?=
 =?us-ascii?Q?Xb4Kwq+kZKZQ7tnJV534g8pT0FnsG/BJqR5SyfkjHq9McTX62T8MQOFBnJ63?=
 =?us-ascii?Q?zesNHvcdMzai6Sb+7Abr+6WzKxgxk/Tf1rOOI5uAfj/PXhSyYoRI4GsWiBGA?=
 =?us-ascii?Q?urOGiHqyfeB9yqWlDZOOX3P2rm20zQTmNPFKuyNMiR5+n3EVtIw/vxd3mxc3?=
 =?us-ascii?Q?//LiQEjX7ZNqG/gNT+ljZMJGUJd7UWY0BfGyhRZFGrlJWPxqOg9I+QRwPxEy?=
 =?us-ascii?Q?CXEHlbZjwOKdpijROXaiwIXEbyYpBw2ApgsNGd/+glZ7JPQG5nJREeONU1tg?=
 =?us-ascii?Q?I7W4siR/PkhoYh346OHRGKaGkxr/rYv1ueOMmuBh98/AGbjPVxMjoZdqUznF?=
 =?us-ascii?Q?d0ARrj2iQHBBBbnkXxvnUrBlbYFSgm4jS8jmu1JpIzyVz9qBHg525uvEWEz3?=
 =?us-ascii?Q?XXE6orqPadl1/Mmg0D+4D9o0jPUo3dlpHj5jAPguzlZ6uXg4l8GlaoscNlCL?=
 =?us-ascii?Q?C4pywY8ZYG2e1aSz7EbNJj9ii+BaAR5lBMkLIZl/F+q5vwGn9kuPvq+o9+EU?=
 =?us-ascii?Q?y5+Dg6DMpPvzkNA3zEvVWP8lKqn2QQ8qwd2SFKEQ90yTn4W0WolEQWUUdvXY?=
 =?us-ascii?Q?sQYFvFVa4WcmFcS5KggD9FQi3wbb8ZP64SZSs8A7tH1dWAXZ9ElZ7CGpgUui?=
 =?us-ascii?Q?rGzGvH8BALTxl5VSl/QjeFIZ7CpdqrLn843EbxCzd3ajoKLeO8Ftqf3oGA/d?=
 =?us-ascii?Q?15YWcs6KE0XdijgC7RctGh2KdJZ6Jy7UClvPr7ajEPX3kFgAnAbuuLmCR9g1?=
 =?us-ascii?Q?ngmgHJzbQp+3mYUTshZ2EEfFeJy0eHaMqMS4jJtt8edZU8OiMdrZxRT3Y9cF?=
 =?us-ascii?Q?WTl6d/oBG6wny4Go22K/4vq0yms+RXGnTfa7+MOOo3GH+l2Fswtj5u5OMe+1?=
 =?us-ascii?Q?s+vPe3/HLKFJrFvArwwBTZJ5UijHGdQsWC5zx39pcpsqweiHMeth9YHCcVou?=
 =?us-ascii?Q?keAkALynSgJ7w9Jh6wol04K/mIjNUTuZ0XWNdtvaUI++mlFsj8GHSN7o2b1R?=
 =?us-ascii?Q?hJ0b/AN5nXGpoLiNsW/Z98fWJaah4k178QPKKZP/lvHylyOGQ31uJfWDinRt?=
 =?us-ascii?Q?66hAqTksqSGl3wfkWd7Iv7hn+F/OHGIIPZYbfzUTHRB9ZnQpDasY3f10TItW?=
 =?us-ascii?Q?zbgsg/rjTN3z0OFUUxhAOpHcfn4ZSZ94AsN4v9WrA73GMTreS8r6oRYFAFLQ?=
 =?us-ascii?Q?+C/rkybLr+xTpVMXjB2QeUf2jrMF/QltkgES2jTfLsQTvwy2ge6hVOHBk0KK?=
 =?us-ascii?Q?aRlfdROTqL52whURbsFP4T8wk404FEDQMd59oaRrXcMnImNq8MQNuI8vZVZq?=
 =?us-ascii?Q?kYyiog0ZfwErpwfFD6NUq6JOSpuHbl6Dm/0wFp8WwaGSnBekwFmRR11/ztu8?=
 =?us-ascii?Q?eg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7894.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc25925-25a3-403d-073a-08ddae81fbe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:05:45.6079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42ZlXBPlvGLeuVPZXGV7raDE+jLhcm9vtqjZMfZXwwgA5FlzUqJsMIFX0/L631Bd+Y060nyMwg9wdrIIcAM2yy7dd68+mlP9ZEp6KiQyhMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7282
X-OriginatorOrg: intel.com

Thank you for your time and review.=20

> The kernel currently faces scalability issues when multiple userspace=20
> programs attempt to read cgroup statistics concurrently.
>=20
> The primary bottleneck is the css_cgroup_lock in cgroup_rstat_flush,=20
> which prevents access and updates to the statistics of the css from=20
> multiple CPUs in parallel.
>=20
> Given that rstat operates on a per-CPU basis and only aggregates=20
> statistics in the parent cgroup, there is no compelling reason why=20
> these statistics cannot be atomic.

> Have you considered the "tearing" that will occur when writes and reads a=
re happening in parallel?
> The existing state is more of a snapshot approach. Changing the fields in=
volved to atomic and lockless reading/writing can result in inconsistent va=
lues, i.e. fieldA might be more current than fieldB.

Yes, I considered it. In our scenario, "tearing" means that we have the new=
er data then the last "snapshot" and the output doesn't sum up in
sum_exec_runtime. The "snapshot" suggests that these stats not need to be s=
uper precise because we're accepting outdated state.
I'm not considering "tearing" issue as very bad here.=20
Additionally, I'm sure that the "tearing" can happen but I didn't observe t=
hem during the benchmark runs.
That suggests that's a rare occurrence or I didn't trigger the right condit=
ion to expose the issue.

When multiple cpus tries to access the rstat the slowdown caused by css_bas=
e_lock is so massive that atomic change is preferable.
 It's better to get even "teared" result than spinlock cpus and disable irq=
 for such long time.=20
=20

> By eliminating the lock, each CPU can traverse its rstat hierarchy=20
> independently, without blocking. Synchronization is achieved during=20
> parent propagation through atomic operations.

> Even if the tearing scenario mentioned above is acceptable, removing the =
lock will break synchronization of flushing non-base stat subsystems.

> -static spinlock_t *ss_rstat_lock(struct cgroup_subsys *ss) -{
> -	if (ss)
> -		return &ss->rstat_ss_lock;

> This was needed for non-base stat subsystems like memory and io.

From what I could find in code the flush with css and cpu arguments is impl=
emented only in two subsystems: memory and io.
Both memory and io have its own locks for them.
I tested the benchmark (provided in gist) with memory.stat and io.stat hier=
archies.
In both cases the KCSAN doesn't have any issues, and performance is unchang=
ed in comparison to the commit
e04c78d86a9699d1 (Linux 6.16-rc2).
For cpu stats the performance is much better after patch.=20

I can't find a scenario when lack of this locks triggering some kind of iss=
ues.
Maybe you can help me with that?

Thanks,
Bertrand


