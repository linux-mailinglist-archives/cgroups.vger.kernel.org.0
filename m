Return-Path: <cgroups+bounces-7757-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB22A996B4
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 19:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8891B86437
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 17:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F22265606;
	Wed, 23 Apr 2025 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kGtYC1Nq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Pvr1cFqe"
X-Original-To: cgroups@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F29215F5D;
	Wed, 23 Apr 2025 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429450; cv=fail; b=WDWAcYlanEytEU4ndfwF+z/oxFsB0GP5iLMyWW+pTDu3uHpUTJ0R8TXfOiTmQYcW4SvgSlDETykd7Cg4wAZvyviCs6r83izDNlTafjOeeMlqhECTsRESK978C5v69rqOPpriJRvElnpwRpyE3ax1KDAdsJNj1xaMQVGI/SUQzfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429450; c=relaxed/simple;
	bh=p2i/coO8KjXhxN9ekYUTqepBqQz4sr/JhHmwfeIZfUo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y0xJBYRCE8rwJ5Ukj9PAU1+2cdr1ydvLPDz9QIa1kJdK7QEK/J3RoR9g5PkfEOM/dwXoJOd6NVJKAT48Yqc15o3Nyz6u7odX4wusJhAFqe90RgFVGZDijWV1Zk0+xtmo14tKTl4Re38PCeSbMMtyq4FK95k1OJkVD+oMseA1sl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kGtYC1Nq; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Pvr1cFqe; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745429448; x=1776965448;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=p2i/coO8KjXhxN9ekYUTqepBqQz4sr/JhHmwfeIZfUo=;
  b=kGtYC1NqaHBmRFaxAperjFoFT5vUWChrHFmEK1NaD/BKWPT9zmAjZRof
   y8nQgPMrFQd7uM3AbksQ5xvc/aC82te05RIJq0G+4C62Cygvw3xVWPaau
   Agsx06MucJfavQEk+Ho1fL2L0oidbS4S/BxE6N+GA5q5ccmYq3xhAxgZM
   hoaBQmgVCHajiNJAo2TsCu2wJj2uzwOqLn8fAwmsga0GtBuF4Z9jVjSgM
   wZbHoDELiL0eXAL/xrDXzLO7eS5PYYu8oumzNDdZgeYgIAwtMrEbD2i+a
   juRfuV0Uh0pVcYe9aGO1WiC9CUYobwoJ5DFKDDTDdFg26Nw/W8qPeY5pK
   g==;
X-CSE-ConnectionGUID: GewPTJI6QCaRT1GGcfoR6Q==
X-CSE-MsgGUID: pc4jlb3OQEi7QGPtu1D7ag==
X-IronPort-AV: E=Sophos;i="6.15,233,1739808000"; 
   d="scan'208";a="79125120"
Received: from mail-sn1nam02lp2044.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.44])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2025 01:30:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5PvixY8INyr6WDvKveQpc85jZ+XOo4mKbhrarRwzYD/VmaUkHWnNnvBEiruxzd8D1DIuDd33NvqT59OekSIdPsiqNIzPvfPKEaJI7P9u+Bp5z8PeZhcjqh3LQXQBZngyp0GUg59LKYNffw6DjcCAlWPeFF6eTTrqrTHtIznvQtIdhqTnV52/lwHBakuUNZBwZLqWW/nek27Brl7r6F2us4kGUxGEa05n6PYYKxQUwkETIhZL0Coa0jaQE9GiwZZ8dnP7SWZr1HOqns6eORmmpntt8WN+g+pFp/vTJLxQyipccGTYbxawbmihMjKYTCHIWEP50PRxhb0VbDqMW5Scg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvWGqIG4K7P7KYF7VbrjxL7wvEiKALgTIUeqrur3CW8=;
 b=DCxIvNkv9QUysjRHUQTP+uNdZiX8VYGzhwbJu2seE7TXJn4bLTXQo6Y3jeTIeW/X5EbI4Tok6txwcfjvn7lpbeinIENz8k8S5nYg0QxPvA7AAFpdvCxMtUWU66BNUvVGAvhw1LW4aL+/vMzp7QbgkpUdYGwim4iyaFV2vAgXfOv4WpJR1nLSfx73L+JB9LFqxCwxM9zJrYrRAFSct6TFs4Ou2kvVBRs5z5tJ10LXtEaOgidYpDLCqUHaFZLVVzJv+YV/ktuZ+eUexoDAIa22L+jK0WV7U+wbfZhyG0DcsOFLT97/gEq6/bJ1dzo5cK1ljlur9+PivJmL2Mqd6ZtYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvWGqIG4K7P7KYF7VbrjxL7wvEiKALgTIUeqrur3CW8=;
 b=Pvr1cFqea6F3HdqhU8SKlSbyT0xcxB+OHhijz7rN4oDxICdHn4B9Qw2PpqRb49hOSwykj6BPa22hyIrc6reM4wssT1hYs3h0QLwisRIRD1JN2q3A4KpAUR7tLGA6mJ4NCNrlnLhVxlu10EMc6UiPUtpiULP240LFXY+mXlvvXhc=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by SA0PR04MB7466.namprd04.prod.outlook.com (2603:10b6:806:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 17:30:40 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320%6]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 17:30:40 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: cgroup null pointer dereference 
Thread-Topic: cgroup null pointer dereference 
Thread-Index: AQHbs867Ho4DUg/FyECYHcuhUwZmwQ==
Date: Wed, 23 Apr 2025 17:30:40 +0000
Message-ID:
 <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|SA0PR04MB7466:EE_
x-ms-office365-filtering-correlation-id: 377fd1e6-e002-49f5-4f92-08dd828c9198
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?qb3Yz+04lieafAImYCglnVmU8rXXf2Ii1XuBntIgX/bVnB3vL8Xs4xRd7s?=
 =?iso-8859-1?Q?gyvyBd+LVLra/O6Y2CxBZfQsccCR6g3D0J84YcEIo3C+nA2tH1rlm3CUAF?=
 =?iso-8859-1?Q?sAV3m+0YcjDABEb8P7CPNRJErStb/vcLwgaifjxWVF6c/M6LkK4UjJ5Qb8?=
 =?iso-8859-1?Q?SMErITe8RSjDGWP8qgb3XB2XITmhm6A1eB39MoEGwisfBAi4Kk4WxitnMk?=
 =?iso-8859-1?Q?7hE/O+02K3mhJ6Gh+NTYO+8Kgf2MM/wQOZkDRHHeNjzy2EAJKlzb+Y4BVS?=
 =?iso-8859-1?Q?42p9NWIchkBV3YMbg3GNlyg/fcqZfAvfoZejhwp5raSg1vSikI2biyFqsf?=
 =?iso-8859-1?Q?5ssJzq9tVrBUQRPjOZgDl9cp3UhwHRuIVVuFoTYv4Uc57GpgWYJq0BR6ZO?=
 =?iso-8859-1?Q?3jzsa/9L8ERt9ivT/m7SMCUpwrVNXPu1BTCih4X5vSnruUutZFb4MiaTdd?=
 =?iso-8859-1?Q?OqtGsIkPghxBfelrifb3rNk1hcdsmqAHKYtAlYMiB2992dGdFkaSH4XYym?=
 =?iso-8859-1?Q?wwCohugEkqxxQ44oDkI5TLNs0em4HmD2gECqsguzREIJLTB9FR2pRJTkJv?=
 =?iso-8859-1?Q?ERRHJKkkh0X7WwDkahVSjBxYNxA1g55qIb3S7nIw9l13p4Hot/VdXqo8Nv?=
 =?iso-8859-1?Q?LuRsWnPftrKnOFa8yx1edIwr259Dt/Qhw8BC0/bp9voL4rFMTTKnkinztq?=
 =?iso-8859-1?Q?d73XMw1+ggUaLla7U/4UwUdIDu/gBQ6r6I9oeZyAILB717zw3rVyEqSraL?=
 =?iso-8859-1?Q?yKJEsC4KY1FQlLNfwjRuzo9LXzPeX1yEhMfhqFGxA3BS+AHXzEjXkVnN42?=
 =?iso-8859-1?Q?A7d0P4N3uP01vh9Ax3p0oE/8QlCYEZ3bJO26kXDYh6KuUSSnwjh79/Fl/L?=
 =?iso-8859-1?Q?m2gz6CxJrYHxXsG7FHQvaKm0Ckta5iOVM/qWcuzVJ0ZUDhDXjkurqgTtNT?=
 =?iso-8859-1?Q?/VLgV7kRR5V7PdkB4GOYdV0xFv0R6UqZQidUaFP9GnWYlbCSSAmvyDoWX/?=
 =?iso-8859-1?Q?jAMZJil06xuXZpaaX+LBEAZjRF4xNnHVZ+m+ZvQILAyFPwRgfzutqkxpC+?=
 =?iso-8859-1?Q?AhHZX/bq0WRU5g5EQ549hx2KXFfcKUUJtjiyJhNHoF82u6xMnBCikaX1a8?=
 =?iso-8859-1?Q?FXjqlpfYFBJBeOp69Jetu8XqDDSU6Kga1fUnf6e0w10Ooc48rBuH+SPmdo?=
 =?iso-8859-1?Q?gQxNkF80ZyeOEsAt55rkGdvDN1eYPBimF2jRuiEoxlDRTyfUfb9PlnuH+x?=
 =?iso-8859-1?Q?P11HEfUME2EC24dYcjm7ceQvPFGZEo5+F3ejG1JGsjF1pBz/RAdeD0X/RH?=
 =?iso-8859-1?Q?lWVX4MF/E0Dd+pKioXq60IeOZKCO0pndFinxTK+2RnalthZJ1SApbY9vrv?=
 =?iso-8859-1?Q?g9+JPV2D3mhh5tcyihj5lhEHPcwyK5Wkzt8e+cUXaRBvOku2lsV6S5NrMW?=
 =?iso-8859-1?Q?JkTCMWejjnThRTTxVdY2tr3ky/TJ1tjpJFO63ZIisQPdSgeSTxhH8u/1SG?=
 =?iso-8859-1?Q?yJdh7EsED+PjzZQ4/sl9ZbFMFCBi6/YGAYHivC9WLEfA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CVf3ooPqZNEhhGEI9IAvmAziOoNrc5FxNqfYIv1HfdP5HxOP1lEIB+YTBU?=
 =?iso-8859-1?Q?MomQJsWHye/D/Zfey6aNoWd5hStqnjrizRfgNQfBlW3i09Lc3HDIn/CwjP?=
 =?iso-8859-1?Q?rfnFetGyNGn3JJaA32HPGVEzj2cz/mImsLaYgfRq6iyKiTruiX6qwqzKVx?=
 =?iso-8859-1?Q?HRjqv2rLhJCtZIJGiDuZAYNTOMAG+6awrW5eOMZtxu41/z08cjuVhruIZE?=
 =?iso-8859-1?Q?BM9H14de9R1O4NJdVJAfBu1k/0wiID97+KclQBhsaS/JP8sOdreMpQei9/?=
 =?iso-8859-1?Q?G4cCTJy4Iuel9XZMj22FH1JaJLiwvSI4PhuR2fCdrlZpsTKVcqNcpx9vbC?=
 =?iso-8859-1?Q?/Bd+iKYT/TJZey5YQUkFtmFZerHpM+kV8QbUOSa9hi13Ym54PGVi41XAYP?=
 =?iso-8859-1?Q?mit9ejLublrNnynQCjcIad4s45QxiQ8ZEsIfsg7pgkXRimYHSPPZegqXYw?=
 =?iso-8859-1?Q?jB5GKQY9PvDmmAEn2B68g/Cuspnyi9E5tdODcMBE4liKHuoZ4tWgQliUnF?=
 =?iso-8859-1?Q?l/gSKYlXgXu/EkA/ODq5LT7J2NuojSQ+H1CrFNeeWwzreDBM5oM+hVClIP?=
 =?iso-8859-1?Q?M+B3mmjRiY3AuyfzJidzPEHEnnHjvskTUTWBizcz3xd3Cg3mWwv4dZVnme?=
 =?iso-8859-1?Q?ilMWaHumlrpnOM2Flvy/6oTCFW2BUkxe2lCtBu18JY8BUxgGUdBYloZd6f?=
 =?iso-8859-1?Q?4FQHLXeLhzu4Q4wwCUsDNgFsgGNgP9+6cHBPot4JwgOlHMm+o0CfaM0BWl?=
 =?iso-8859-1?Q?QL/tqqLNMLNQB3D7K859cijDju74yXecZtd7htS9O8CMvvciTJ3Ywhvnmw?=
 =?iso-8859-1?Q?LG+CTkJnq6RyqEZhFjw887ESdy/ml5rkihG9mvQuO6F312LSluK0xaQeyz?=
 =?iso-8859-1?Q?b0o7z7mSU1vQ6ZXA0UsKnzy0Y2FyiYSysLCzu4jM/B0CdB4BdPxOluJZI2?=
 =?iso-8859-1?Q?SMf0qd6u68MSyy9B4RsfWm2hYXR+WJfVmiznSNEp/oADazLu+2YBmbAV4g?=
 =?iso-8859-1?Q?WkyGoxJsknOZXpE5256OtoVUb44XqrjhLBVpMvwSP8Mn2ChRFvQY4w+kHG?=
 =?iso-8859-1?Q?UhAlS+F7LbDqYTpmW7iPeZta0WnLc8HIGEWD9j/T3BNfDgIfesQN0SYkG1?=
 =?iso-8859-1?Q?HG1LQf4zm7yttPsNBfIGsJfhffp3A7ngHW9798b61jzH5lI/89tGixxrZk?=
 =?iso-8859-1?Q?J/HbYOgaBzbcFKWIZEZ72wrx3DC1HSyeScgTD5seWn+OkS56wHeyYJ1RgR?=
 =?iso-8859-1?Q?vhLb3sWgVyIKr7ocbf02M8qG/2JG6mesbce20+ijEi7lVwBou62UgnXNOL?=
 =?iso-8859-1?Q?lLzya0PUws3h1ZDD1jwjiKhxccCfil5i3gb2Um4nNpY/mvL/mTtUyY2N/P?=
 =?iso-8859-1?Q?1cCw1AacOrsxKS3VOASaTCJmxZFaXZ9tzjDcyzXAMOzUGGe06nn+hiH3aL?=
 =?iso-8859-1?Q?l0y4W+w8E8jqWynPysf+/hnb5KvPoqUx+U8ccpE2tK1dclZBJwfYfQHa1f?=
 =?iso-8859-1?Q?kRvj7E3WGbZlxOyg9CLKMOncwwS8VucQODBLDPEUxWIE1yNHO5RJoZPe78?=
 =?iso-8859-1?Q?wsUaYJtWag49vVcEydqyqISOMEDR8JPj7UHL/5UK4BV4Mf5BHxDYnve/oF?=
 =?iso-8859-1?Q?ElL/dxEFZZHBMquEWqMJdEvksZRqPVPgux?=
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
	dnt6nO3BsrriWw4/BoMAMZOV/uysIygCfru6fdPR5C9XmRNkd+AMIQh0CKtyzkCUAsd1jdZZad9bx5+tCs/83V62u03+Y6LWw5lkrpcTVkxqnBm8wzYUfFlFBwmrT2skIr78eBmKEZ5olMn58jDDoCxMYZuH9Y+rwqhQCmzek7oRDbjogJ1L+nunuDnKYqyJgIWbw+C08HkzOCC8/Ku6O7yA9QLxOoqszbmwpicTFoqrpb7DJvfdQGI5ugd8S1sjq8nsQHYanccQiVqVPyEV+E3sI7+qD7TLQoYtF04691nh3ony/W7w0qMqH1D6QXb4zz/mmT8Wsu9ueCkSt8s57byNguxfzHtpHBwqamEW4WlooFXvqfQE6iGARw3DixTmbC/ORAs4sgWD6HktV/wlGs4l421vnuLOdGX8LARzFBBip/IZxp0lRJptvmQEiHDm97lTOjiTyZPGhqLWMUbLKx3CxDGrplQ8qGn3tLe3NODogyD+U2iD9MY2xJROR0fKQfbmH7NUiRrq/5+XIlgb+BFPCzb6c4gXMve8UbPJ6Kg22/AgcCBS5r+omHNxUUebuUXtGkVCaSHuPfibxXEWXfiiOLoa5v8pxj/7aGQ7SKnNkP1wt+IP94eUgqyjKbF1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377fd1e6-e002-49f5-4f92-08dd828c9198
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 17:30:40.5917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cDF3roshQ9gYnWymGub/k7sSR5gEzKTCgiTchuS8/qAHo+HumCxdUa0JxtySpF+faX9pASkobzkLLUsXhKgQ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7466

Hello,=0A=
=0A=
While running IOs to an nvme fabrics target we're hitting this null pointer=
 which causes =0A=
CPU hard lockups and NMI. Before the lockups, the Medusa IOs ran successful=
ly for ~23 hours.=0A=
=0A=
I did not find any panics listing nvme or block driver calls.=0A=
=0A=
RIP: 0010:cgroup_rstat_flush+0x1d0/0x750=0A=
points to rstat.c, cgroup_rstat_push_children(), line 162 under second whil=
e() to the following code.=0A=
=0A=
160                 /* updated_next is parent cgroup terminated */=0A=
161                 while (child !=3D parent) {=0A=
162                         child->rstat_flush_next =3D head;=0A=
163                         head =3D child;=0A=
164                         crstatc =3D cgroup_rstat_cpu(child, cpu);=0A=
165                         grandchild =3D crstatc->updated_children;=0A=
=0A=
In my test env I've added a null check to 'child' and re-running the long-t=
erm test.=0A=
I'm wondering if this patch is sufficient to address any underlying issue o=
r is just a band-aid.=0A=
Please share any known patches or suggestions.=0A=
             -          while (child !=3D parent) {=0A=
             +         while (child && child !=3D parent) {=0A=
=0A=
Reference: git://git.infradead.org/nvme.git tags/nvme-6.15-2025-04-10=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=0A=
2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] BUG: kernel NULL pointe=
r dereference, address: 00000000000003d8=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] #PF: supervisor read a=
ccess in kernel mode=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] #PF: error_code(0x0000=
) - not-present page=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] PGD 0 P4D 0=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] Oops: Oops: 0000 [#1] =
SMP NOPTI=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] CPU: 19 UID: 0 PID: 34=
9623 Comm: kworker/u1029:0 Tainted: G            E       6.14.0+ #1 PREEMPT=
(voluntary)=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] Tainted: [E]=3DUNSIGNE=
D_MODULE=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] Hardware name: Supermi=
cro AS -1124US-TNRP/H12DSU-iN, BIOS 1.2 08/10/2020=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] Workqueue: events_unbo=
und flush_memcg_stats_dwork=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] RIP: 0010:cgroup_rstat=
_flush+0x1d0/0x750=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] Code: 0f 85 90 00 00 0=
0 48 85 d2 0f 84 95 00 00 00 4c 8b b2 c0 00 00 00 4c 8b 82 00 04 00 00 49 3=
9 d6 75 08 e9 d8 03 00 00 48 89 f2 <48> 8b 82 d8 03 00 00 4c 89 ba 00 04 00=
 00 49 81 fd 00 20 00 00 0f=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] RSP: 0018:ffffd08eb9a8=
bd90 EFLAGS: 00010086=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] RAX: ffff8eefcb7c9760 =
RBX: 0000000000000013 RCX: ffff8ef0dd42c000=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] RDX: 0000000000000000 =
RSI: 0000000000000000 RDI: 0000000000000000=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] RBP: ffffd08eb9a8be00 =
R08: 0000000000000000 R09: 0000000000000000=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] R10: 0000000000000000 =
R11: 0000000000000000 R12: ffffffff89bfd200=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] R13: 0000000000000013 =
R14: ffffffff89bfd200 R15: ffff8eb1979db000=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] FS:  0000000000000000(=
0000) GS:ffff8ef041434000(0000) knlGS:0000000000000000=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] CS:  0010 DS: 0000 ES:=
 0000 CR0: 0000000080050033=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] CR2: 00000000000003d8 =
CR3: 000000113b642000 CR4: 0000000000350ef0=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025] Call Trace:=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025]  <TASK>=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025]  __mem_cgroup_flush_st=
ats+0xf6/0x100=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025]  flush_memcg_stats_dwo=
rk+0x1a/0x50=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025]  process_one_work+0x19=
1/0x3e0=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025]  worker_thread+0x2e3/0=
x420=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025]  ? srso_return_thunk+0=
x5/0x5f=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025]  ? __pfx_worker_thread=
+0x10/0x10=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025]  kthread+0x10d/0x230=
=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025]  ? __pfx_kthread+0x10/=
0x10=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025]  ret_from_fork+0x47/0x=
70=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025]  ? __pfx_kthread+0x10/=
0x10=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025]  ret_from_fork_asm+0x1=
a/0x30=0A=
[2025-04-12 18:40:15.554] [Sat Apr 12 18:40:12 2025]  </TASK>=0A=

