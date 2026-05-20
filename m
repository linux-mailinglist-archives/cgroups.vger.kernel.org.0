Return-Path: <cgroups+bounces-16127-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN6NOoSrDWqK1QUAu9opvQ
	(envelope-from <cgroups+bounces-16127-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 14:39:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E5458DE71
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 14:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAE4B3071DB6
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 12:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567BC3E169D;
	Wed, 20 May 2026 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UJm7vv1c";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="R9Fy2uXn"
X-Original-To: cgroups@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A35E3D6CDA;
	Wed, 20 May 2026 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779280424; cv=fail; b=mO6nxizfQrWkhDKourPwDaLkyg8RlyZ3iJPV1dDvVL5042lsAqM9Kvc1W4N6AbXtYjvYqzfK3UmHdiz0IOPkAp6p0uuDcu1SEsKNqKRpcfbboajV2eZyHssVdZZ/FF+tCoPiaZF1PCKEBlQG6TSk5xlv/inLTAq8K58HdSziDZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779280424; c=relaxed/simple;
	bh=bTHB113bI8QOMB3uUO4HXchXcOVkJIJ3kli3pEULleA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YNbAvoMmssD/WLZshP0Y8zF05ssNNyMopqRI6rvdAJwuftXEpDQTsWfa+4VXlSxCCUVR3gRDeS/j9iaEapfPp/P4t5pes/cv1lJ4PIiXqSCg8EI5hnj7UWICEWS03eump2U49l48reLPS0vaKs5X9Da721wy5l3/UMPmXBoyRjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UJm7vv1c; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=R9Fy2uXn; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1779280422; x=1810816422;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bTHB113bI8QOMB3uUO4HXchXcOVkJIJ3kli3pEULleA=;
  b=UJm7vv1cpNSN9W6KaEuDC8tszRDcv3M7R7/Nd20yfst6mYPLFfF4UiSG
   WE0RYUj9sDmq7rz1MfaIsDgDd4IggFBoWX1WV1v6qRi7qeb7W6QfEO38i
   IMt3A6pOK5l0jzeoXNxJSu89NXScNkCs8vivkZ9WiPY3TIdn9VwdVxT1N
   kgtAYgz8DQb+Dbf+fVQoSqxtbJp2O62qoRdMe9LN2YrIy3gwALTMPuSYE
   s10ouTZbiHGtLnIjmbGpUtsxnaNz7ypBTuKhQieL0klOi/il3MH05iLRJ
   hIG6aoh9cM1K7PT3lVQQ5TTZfJqs2otk8kH3d6AF7NCm/WKWC4KaD8Y3K
   A==;
X-CSE-ConnectionGUID: EMeIVROVRTCTjvJp3T/28w==
X-CSE-MsgGUID: c0BkNaUjSF6NZhTJi+pYLQ==
X-IronPort-AV: E=Sophos;i="6.23,244,1770566400"; 
   d="scan'208";a="146387287"
Received: from mail-westcentralusazon11010036.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.36])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 May 2026 20:33:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOLmuggXWf/lhLDQZyehqbj9oHmsnuDUoPCjFdp/tr/svgrRNEe/tVyicGklx7M/H+YxX811hHWFW4QZCIl15Y9rYKJfY1eiZpFcz1ldy6az8C02Iv1/SEn4/Ls23VAMeqnL1ZyV+LUo5/HKsKSTyx8LDPnL3XJsTQy7o1AVHKKb3XHMgwmXeB++k+0FbQXCICX55gbz1mJnnKKM6E2Ns/O9BBXm0DcyD5BxJz5uOTrlWdKRYmJIIZAf0CVu8aiyWPHzzos11vxnS1h7PqDh7Ab8jPt+AVGAzgzNsdtqaE8iSIb17nfAvA8ppV5UM5QVMgsJG6iXcFfqRlLovWgTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXnU7SmuXo1OtC1IWuxLPjxLvkx5TiA8VFTFIy/jWpU=;
 b=dqYxvpPwLL1qEfqohNYhyNna4Emlc0YiAZ1wIXFfv4us6LtKdee+CKqB7PgZWbe2T9Fgq6Vpob7DHcgJMZpbTc6hXSkNa/RQpKyHrOR0DMHNmYaMWGk+Y9pdCekg7yYE8wQgoqyxGG+DZihbt47AbzY2Stw9hfCtvd2Af70IySwabaXOUQd6WNA7WTds2qfDxiRyZTP4XzuxcpJSvLBYGtWKJde8KZt5ZsGuUdA4+WOh2JkSOcPnohKB4sVXXDGybsbD9d4CDy/7m9miCWPu9rgxyV77afjrxOcLMVrLmW3WOYfc0LAQLsA4EyYSFUEntinnoh/XA02eQA/UELDLYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXnU7SmuXo1OtC1IWuxLPjxLvkx5TiA8VFTFIy/jWpU=;
 b=R9Fy2uXnusySSBUZXj6pIDBjVUANTPLw6EslIgqUQG0rh41ObXEfC1LXT+ewrTCBqZiqWm5I6tqAQ8sJXkIylxEV4iAcuqsS67/DvUq5rZDuz0EhVyxxMeYnJK9R9mrag7yrfYH+ldKOyqaPNV6ZeU9qw4eFmgxNQN4exU5OJCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA6PR04MB9215.namprd04.prod.outlook.com
 (2603:10b6:806:419::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 12:33:29 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 12:33:27 +0000
Date: Wed, 20 May 2026 21:33:21 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Tao Cui <cuitao@kylinos.cn>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-throttle: schedule parent dispatch in tg_flush_bios()
Message-ID: <ag2owaQQoigp_fSV@shinmob>
References: <20260520062420.1762788-1-cuitao@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520062420.1762788-1-cuitao@kylinos.cn>
X-ClientProxiedBy: TY4PR01CA0061.jpnprd01.prod.outlook.com
 (2603:1096:405:370::16) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA6PR04MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: c143a0e1-8583-440b-76c1-08deb66bfe25
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|3023799007|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5nTdqNQ6To/jnuiifYFqs4icXHXIOMkWVI5AxLmN6jB6DOlWmzDrTmOQRyIxcpJ1N8ifAgqelB2ttWIOmTav7yauhWcrET+aYYoWIIc0FrcsOTVrD0N7AU0xq4LtCRkBzGFp6sivNZRohbKEqFaITmp3OmprIAcICp36/A7ulLs137z8Btb2Ok8c/1OWJmQYvlbCiDN6HOdeH3xuWDsWMqke8Qa8gurVjnwggpAw5igXEAQx+u09FYERAXCw01pefL4j88N+oEJxULnAGXpW4OTZSmTQ1WUT4ZogFE7A+x0ybhrOO1rAR2EQp7hE3FGSBa8vpuNtSqP0mzda3xkw6oQ7N1xhDNpBq9PB3y0q7GIatV3xPEV6MvEFD1ORPDVpxytwPdQzY/nZArWOcrawiNNxefUdq2P8TlAD/6qv4pNTvSvFebC/Hl8qIC7gnc4WL2CYH93qBUGRMOxzSi9Z7+rugLbhdGlRhkreYYQP6Qog2b9Ei0HtYGCNP/Vp4erabg+HOULO8A/4hI6eunz16tFWSaCXShc1UedqQIF55C5jHkbkcBK5OTcc23qgqKMT9rjmsebTR/Nc3j/ZsFlY7XHs0DlYFDPu6Lp3pvZ6tRXjpoMouNDGbynb1B4MtGqfyI+xOu71tWtIRQvfj70y9G268ju1sPPr5bMFmH2wYJTqHXRP2J/ZFgqwIQhBuGJq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(3023799007)(11063799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dq/BuCx7G3USJF98TYlfNb28ZZ2FRJHZr2rdenKoCX0dja9ZDmeMoGw7Sl9y?=
 =?us-ascii?Q?m0MixJlgwdaX85UQno5QqfOUNMX3A0wyqYZRxfCffe0eZrmgVEUrZyUqtJNC?=
 =?us-ascii?Q?yl1Lrnq4Obt7Dt6Vzw7fdT8LJQOmwlZbjV/o52tcv6WjFXVUeum/Y9VsKz+T?=
 =?us-ascii?Q?xnTyXvWYfuug9Nui3LSwUDJw1PnWWq4eVu8oJRAujPmcoz/Vc2UbWe7/mTpq?=
 =?us-ascii?Q?wTXJmZZwQYe/+4wJee/5qn235ybun/3V0jaN40HNtWTj02o4e6DKiFU/f55w?=
 =?us-ascii?Q?ct9l91l/hZHJVXXSmLf16bpHF/LyNwBQxzQlMwCTVlgwTA2IB9oM+BnhZfUk?=
 =?us-ascii?Q?+XSs7WUR3USwc05+el7JWpCWGBGmMMgkM+FyL2cFqb/3ZRO4aSBXJoaBuykm?=
 =?us-ascii?Q?10t2DzYM1B412cejH+tF10mK04zUpy1bnDJgkhiiHPF7wyWgjxW9A04SpGrE?=
 =?us-ascii?Q?OK13natEefH8ymWtVbUVwInCWe9L8JtatG3tCRDpWmTt0HRru1f080ri42QB?=
 =?us-ascii?Q?0LvOYEIpOTfJUs5WsBPfox649kCHJhjjGOwJSTQFY8R4Rf2Cr/tM1sHK4AqZ?=
 =?us-ascii?Q?c/Aq+r5yCX2X8LgYJcAorpTQdCGS8/LIcDDn8wVEdNXPgNfghFlKE/UQPBKL?=
 =?us-ascii?Q?i344xBHJy0zHgu5O1RN55R4HKFiNCV2hPs6LBm9K0xyYjXUFxKPbuzAk/H1C?=
 =?us-ascii?Q?v0dpuqIlcH7U8YzNjP+kUsmqO/pA1maIy4mvyXcy3VZGTCkin9W5woFRFkuY?=
 =?us-ascii?Q?UqXQ3q8fmc7KruG/7bYGl8Gw3DxXIs3hZNmLyM/MUUBQ3VqehjlQkZJOQl/G?=
 =?us-ascii?Q?Z1b+Ja0KiJdO0cRcLReUtjRPVQSbYsFayWehHYAxUdfr0DSdLvoDa2I1naTY?=
 =?us-ascii?Q?9TnIbhGv5DEpR7dk0QRxRdBhnl+hAxLnwp1g7OqIb5TCtbtUxdryLXvmzcRL?=
 =?us-ascii?Q?3Lj1K0V1vHdOfF/NR4++0amTG2splanDLSK5K0AOy3aoCfs4hSB9O0AfiTa+?=
 =?us-ascii?Q?nirRJJGTdpeVYTp+vdny50KV765d/cmT9XRw7TGXklw3rOI6bC+jah30dvGv?=
 =?us-ascii?Q?QNKzoywupYeqxyoyrp3zIW3BU3mhhOa1FtPRW0tKRWA46anArfaCMMR+fqOL?=
 =?us-ascii?Q?vgsi4qJMl/hVXS2BTOwUGLXo/6d71XUqpWbwnqa9eoAqCGeSnN/Ztx2SM1P8?=
 =?us-ascii?Q?/Z2dcnKcBEc2G6lVgbPwTk6n/ydoSt0L4zwoUntBEbrszNfO+kBNdApzet5C?=
 =?us-ascii?Q?Xm00SlW8NyzITKBKdb39TM/0hJNMqN43YHLSezfqF/CVNfZiC1gjf5CAUQ+y?=
 =?us-ascii?Q?1NSm+/ZYkTU9Cxsv8KmzkVhgsC96XC7iLCahbr82W8YvLFPgi/wE7TCyS3JR?=
 =?us-ascii?Q?sBxJD4fMA7MWGiu5PI8rewiU0nIvXncgKW6/qMl49/k7ts/H0Fd5i85DmmF7?=
 =?us-ascii?Q?WFMGvUnj7g97ZlVam29kkBPTPKfqwghjuryap5DvswHNu8xExDPqnC4arKQf?=
 =?us-ascii?Q?mOpbFUy0UfRfM4pFZZ7z37H3a8+YA7snpzY9QWOy0okSMMlbAJFsu9esAzrT?=
 =?us-ascii?Q?2boPo2M9NXu8pkKJXWNyTQ7H80YRKIq17XuJwy51e0TX/R0kJElnGnVHa8Rh?=
 =?us-ascii?Q?RFKM1svovyiICcO0ypooBkirD6D2v0a7sgA5s4LCcqNFsEXk11NpWbkpupyP?=
 =?us-ascii?Q?iQ1hDq0Oo91tEmAP3KXer86qtlc+3TF96cQROxhtR2I8lEzO2fz2ixyAtJtk?=
 =?us-ascii?Q?CgNmsCc+5R7omB+Xn1VWmUp0U3VjcYY=3D?=
X-Exchange-RoutingPolicyChecked:
	G+9bvZ43ggwAfezb9DF3SRk5Kje1cHnmXJxF8QFzFVCiO39AEm05/Is2EqH+Hhol6OLbM7xOZ7uoDIoxHsQqOjZfmoT6eSXcphjTK5oTiIFTnGsgW/tqqCUv2mjIMECWLDKH14fopKZgVSRcG9LyHvrO885AZMgK1x64xjg4XOiUEyLM5D+qfeeMdpUo+D9cz8TCokEEDd2e65lCoF3fvmBtKbh+g3FDHk7o5Ld8C4fLRNNtpFWF946/SysJLcwJQS74AUquJ5Gzi9dGQ9XcGKzaUoq8WvS91pcfjisa4IOSeFK7p0VFgp5eMhf4QIF/BoRuXh+++0rEwqunjfPK1g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aQJE7LGl7kVgCgvGM8bzRiFg1CGESCNvXcboc9K6Qzdymo4mGdG3skC1aD913LaCDEZLFB+IqI7g5YFoBEVUdsnzemQcQMra5HsG+lb5i1HwPHlWxd1etm8ZTmcuX6zjuFjHL79S2Rs7YKyKuKnFLW2CEno2dapd+VyTo0vnHjaCvZKCQXRoJknD81xaRRwiRL3b1pk4FO/WkzV+DyRgmPahtHRjRMTvVI8rpN2re/dP3dU/3ZLIRV8rUTTT3TrLIEnrvR2WsPa4w42rEJsS9fL2//GGIBQVRt/yzK05ThQpugLkLn6MZV43KxodY16rjM0GpghymJF5+ByX4pYey9r+CYfQ2fIjPCMKvE3wG1TYhiVU/dn8lNfKVK7ZSkvwpfR0n4uwkbfpVTk/jY1ESI6mTuzGOMm9dXsaMlDfhOLDPZAzLi9FJe/F5f1XHed9D+AwnNqEPp5NLSPY938rsK9rpnqHWuJwrnBGCBCIGXffSa8dZ7UF+RvE3UFzbXchA7QZgXKvUbHvZJ96wa6WpOiFNzPwWh4xxAsj9375XnUUtEvJsfGkIvVWT3yJMO0hXpYHIlPBrqJejMjZfgUXnqKAMB6VooLSH6f54CPVBqecQasg8s2uAukf4+cLYILH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c143a0e1-8583-440b-76c1-08deb66bfe25
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 12:33:27.5785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLckOyijvUExbzWBjkerhOAYGLqy6AaPZiifmzcImD14CKunuzAn8On+emHqvo+xp0kocQRnMtJPbJmwWk8OlbzZgpBJx/T9joF3xdT5ujI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9215
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16127-lists,cgroups=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shinichiro.kawasaki@wdc.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sharedspace.onmicrosoft.com:dkim,kylinos.cn:email,wdc.com:dkim]
X-Rspamd-Queue-Id: 50E5458DE71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On May 20, 2026 / 14:24, Tao Cui wrote:
> tg_flush_bios() schedules pending_timer on the child tg's own
> service_queue, which causes throtl_pending_timer_fn() to dispatch from
> the child's pending_tree.  For leaf cgroups this tree is empty, so the
> timer fires and exits without dispatching the throttled bio.
> 
> The throttled bio sits in the parent's pending_tree with disptime set
> to jiffies (THROTL_TG_CANCELING zeroes all dispatch times), but the
> parent's timer is never explicitly rescheduled.  The bio only gets
> dispatched when the parent timer eventually fires at its previously
> scheduled expiry.
> 
> Fix by calling throtl_schedule_next_dispatch(sq->parent_sq, true)
> instead, matching what tg_set_limit() already does.  This forces the
> parent's dispatch cycle to run immediately and flush all canceling
> bios without waiting for a stale timer.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

Hello Tao,

Trial runs of blktests CI for this patch caught the failure of test case
throtl/004 using scsi_debug device. I tried to recreate the failure manually.
I applied the patch on v7.1-rc4 kernel, and ran the test case and got the
result below. Is this failure expected?


# ./check throtl/004
throtl/004 (nullb) (delete disk while IO is throttled)       [passed]
    runtime  1.546s  ...  1.332s
throtl/004 (sdebug) (delete disk while IO is throttled)      [failed]
    runtime  2.654s  ...  2.435s
    --- tests/throtl/004.out    2026-03-20 14:25:50.478000000 +0900
    +++ /home/shin/Blktests/blktests/results/nodev_sdebug/throtl/004.out.bad    2026-05-20 21:26:14.470000000 +0900
    @@ -1,3 +1,2 @@
     Running throtl/004
    -Input/output error
     Test complete

