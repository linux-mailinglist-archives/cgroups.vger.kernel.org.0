Return-Path: <cgroups+bounces-8281-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F41ABE93E
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 03:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607391BA6333
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 01:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B501A5B88;
	Wed, 21 May 2025 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="K3AvOdU1"
X-Original-To: cgroups@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A5C148827;
	Wed, 21 May 2025 01:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747791744; cv=fail; b=OCxA9aRKLXi2o7YcCj1R/mXP4eSOCV5E4pqQ+LjKXnfCHaeay524PIG6UfAHxGT9RL7AaXWJOObYyVsL0cF2yq7jw/7gab6Hh4gV4BU5z1PwN3m4Y3HF56fHI7rRApvET5l9lCL04n5gbAsmRNdmwKCFKM80qCJVvCLL6Q3XK/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747791744; c=relaxed/simple;
	bh=0D7fVDl5vQ2cPrOXKARp+bddA85e0ESTVmwD18AuDtE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=AxxxHU7fB5bWDh3Jy8LXXdjUy0rAQ1IbE0+GWai8yFDgJOCU62MD8lEsnxLFRe+FpSFqNouf4OaFdM821K2d43ss/Z8nrMR/v+blnyCM9HNut6rSi/vM9U+kYP1D77jUDJ8QRfVh2J725NHouh9wXnMteQWVwOsoyVFaVETGMpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=K3AvOdU1; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L0VJo6030080;
	Wed, 21 May 2025 01:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=olqIwtq
	FPdw7NdMTSLdcxS1LUBo0VkYpI0jvdjcT7Do=; b=K3AvOdU1jLfyiDlOoM9mMNP
	9HRZqz6+4Sm3id7MuRfoFteLzuCoov2Pz4i03EKrMj4tUj8dru/ufNL55Sns4pp4
	+hYMr7uN7gKWuxRljdXry2bYD+OmNkFiJkuL8O/zC1EwjPT/9XinBTOHHTa/OtQq
	5UA7FIlGIgXT9uhiIlVMAtqMhn6bzPJN+HMYWpYykmVY9V5o1vDrEhpJq3hdBc4l
	xcjQO0SZWpcifmBdkaO0Ol486FelLEB+NWaN7aYWnVuWMNxmGtEEdkQDNwwLxZWG
	dljonOWkZc1KB0WlZnrEJP8Gp98XD+H5AYmv6fqF20dl7VVr5KaZ9U7VqX61TBQ=
	=
Received: from os0p286cu011.outbound.protection.outlook.com (mail-japanwestazlp17010002.outbound.protection.outlook.com [40.93.130.2])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 46rwh30aw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 01:15:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNjiHUgr1W7q0Sm9at+XYPxngpDo08dlLLWLn7FgA0njqYm9k2DGc5Q/t7S7oIkMuweDxWDVFmciliNzJaVnPe2Eiv8swS0GxLJwO8aD7A55yoMSyEbbleJDvrU3qHQjJch8ZfkjlGJuu21MActQvbZBOGF3am86eYtXLUpNx14qhAKeVfZhKIrWmZLqpD4SZp9b4pQNWJvKJlcsiTf73z9KH4u+/MZhpGZwr7i1tcnMNfcZzpxF1vAU4pIOIzig/tQnJx0kAox+mRvvkaT7IJktoIIV9/7W07KSZXrVsoNJ5TDVBbIU3AzH+sWfyM8Gx8l/OX6OOaCasxS1A6By3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wE63AEy09yFNGKVkDrTahGNaFc8RIaLPOUgPfRCn9s0=;
 b=tRSfp4BeX6Gzdy33dNqeP0CnQmt0UsDl5VS4Hgs1lc04OqDgFjFnioOaOVMxHBVjMjd589RBgzt77dWweFLZgYZxglYJePx7tDqgUQ1AC74OrhDbkI8cJlAY/vaHsam2Ae5K023FC0Xxn3ndDomEog9d/VbFnTm5nWmIFy6bC9AQQdhblx5VlcoRE3n+ziN5CFEdkXpbekzaD3Kw/giLdqjDKe22yXdhuDG1e8AuS8SNahdHVJgyvm3ZykZwApjCK1+2L+ZlAZ+/oYN3xQgKh21pYc3/TgpJOo/HXtbiactt19WL83C4lscPnhgd/5/xIYYNo8A8u8mcPu/sMrRwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from OSZPR01MB6711.jpnprd01.prod.outlook.com (2603:1096:604:111::13)
 by TYWPR01MB10473.jpnprd01.prod.outlook.com (2603:1096:400:2f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 01:14:53 +0000
Received: from OSZPR01MB6711.jpnprd01.prod.outlook.com
 ([fe80::1fcf:d37b:e319:1b17]) by OSZPR01MB6711.jpnprd01.prod.outlook.com
 ([fe80::1fcf:d37b:e319:1b17%5]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 01:14:53 +0000
From: "Shashank.Mahadasyam@sony.com" <Shashank.Mahadasyam@sony.com>
To: Tejun Heo <tj@kernel.org>
CC: Johannes Weiner <hannes@cmpxchg.org>,
        =?utf-8?B?TWljaGFsIEtvdXRuw70=?=
	<mkoutny@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shinya.Takumi@sony.com" <Shinya.Takumi@sony.com>
Subject: Re: [PATCH v2 1/3] cgroup, docs: be specific about bandwidth control
 of rt processes
Thread-Topic: [PATCH v2 1/3] cgroup, docs: be specific about bandwidth control
 of rt processes
Thread-Index: AQHbyZC28VEOOyXNOECCOtVrMpYh9bPb87KAgABUT5I=
Date: Wed, 21 May 2025 01:14:53 +0000
Message-ID:
 <OSZPR01MB67115CCC104221C27EE63709939EA@OSZPR01MB6711.jpnprd01.prod.outlook.com>
References: <20250520-rt-and-cpu-controller-doc-v2-0-70a2b6a1b703@sony.com>
 <20250520-rt-and-cpu-controller-doc-v2-1-70a2b6a1b703@sony.com>
 <aCziA1tUAnnGId6_@slm.duckdns.org>
In-Reply-To: <aCziA1tUAnnGId6_@slm.duckdns.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6711:EE_|TYWPR01MB10473:EE_
x-ms-office365-filtering-correlation-id: c16913a3-1910-48ea-fcf3-08dd9804e452
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VjBvR0J6bURCS1NFNTdpc0JOTlBHRy9waXNjMWRmRU40S1YwRXAzUlNjWWt3?=
 =?utf-8?B?SFlBeURxbnRyUlV1T3FuOGtYRlRxTVVMTGNURmhuYzVLRzVTdGQ0Umx5V0lx?=
 =?utf-8?B?eExuYmw4aU5uSGhQOUlBMDgzbjhRdytFMGs5L3Ntb1RMdnlDdnYrdytDb1J5?=
 =?utf-8?B?MFdtK2RiWmxzSzFOVkp6QVJPVUJvcXFQMXU0Z3gxSmsrVWtETThYMDA5Q3Rt?=
 =?utf-8?B?TEZ1dE5wcVJxRWlyazRjT0hkbjRtVGdVWWJOZk51MkEyNWlwY0dwbXBrZXIr?=
 =?utf-8?B?UmJNNnRXaEN0M0FFZDFJZTVPUTM1TCtZWFpjU1JxRzA2R2tlM245dVduNTZD?=
 =?utf-8?B?RzYzSzBVRXM1SkpXMW1YenMvaUJ3aE5ZS3lGeWZxKy9QT2xXb2g1MlZXNnJ0?=
 =?utf-8?B?UWNMNUJDWnlyOFIvTWhVOEM3V0NOdHU3emt6ayt5NGI2NXNJVlNBcnhqK3ZN?=
 =?utf-8?B?K29BbTZoTVJmdzdYbFdGdXBtNDRza1ZLWjI4TWgvSGxERFBoVFBlQzFCeTBN?=
 =?utf-8?B?WXZrNGJMK0RSSDlyZEVWN1BjZEhDcWhYa3pKcTdGS0t0cEl0SDk5RElJZlJ6?=
 =?utf-8?B?NHFZSlloN09MckNzb2RYYXRhS1pTT25NN3pHYW51dGFGY1dlV09vM3lLK0Fo?=
 =?utf-8?B?dXpvaU1xaUd0Z3JsQnZJMVRNRzZJR005bjI4K2IxTVA4aVM3S1dGMzA5Ly9G?=
 =?utf-8?B?RE96TkFSUWhCQWtLM3h4Y25EU29Za2d6RHNkYkJsU1czTThKVnQvVFJXODdH?=
 =?utf-8?B?c09sdVBNdngyaHMzbE5BWndWMnNFTitONXVpb2lxSHAxWUJaRzhwM2g1VUMw?=
 =?utf-8?B?UHJLNFFWRlBJOE5ramcvanV5UUJmNlVUblF1Tmh5OEx5VDEyU0JMT1FoMVNu?=
 =?utf-8?B?UjY0NWFaVXBZMFR4RkpnYjlMdjlkUStnYktnRlh3dFVPaEd6YlNablpvcmZ1?=
 =?utf-8?B?MFpDbUh1ZE14SDNaVzJ4OXorMFlyaFdaSnVOUWNlL2NrOCs2NHNvaThqNDkr?=
 =?utf-8?B?d3IyamRFMW1tY2FHWk40SnFMMFZWRWNhaXBJZ0NkRUQ2NzJHam5HN2tRWFZS?=
 =?utf-8?B?UWFCb3lIYnBRVG5nekF2d1EvdXp4TUVDd28xbXBPc0txUnV6aDdsNUMyNXNW?=
 =?utf-8?B?c0w4WjB4R3JWSlA0S2ZqeUQ5ejNYbmlxQU1WZUhlUFNSVVVSZzl4VjZzS3g5?=
 =?utf-8?B?V1RFZlYxTC9saHk0VU5idUgxem03QTZnZGc1QklrZm9OcWZBb21ScXM3Ym12?=
 =?utf-8?B?enRhRGNwc0MrL1ROc2V2d1pQcFU2QWFQT0VoeWlyUEZsWFlVb0hadnZNNmRO?=
 =?utf-8?B?MzdwYTBMdzJIdnhMTCttSENUbnZFbVp6eFE1ZkNSV0lNUnVGR2twcXJnS2w1?=
 =?utf-8?B?Mi9FZG5HWERSY2JuSjd5bEJWcndCdWVKVXVJdFNhRGhxUkFJVHpxNVRQRy9Y?=
 =?utf-8?B?UXMxL0lXU1BLTWNuRUhaYk1aamE5OW1ERkZhSWhlNytUMFZNUjhSS21JMVJN?=
 =?utf-8?B?SE5jSE1iNTd5RTR3WlJ3RUtwYlFlRTA3SVNnYVV5by9POU5DV2t0NmQ4RjJt?=
 =?utf-8?B?UEtvbGpVTWRUMTBMOHljR2NGNDFzaVhDSkcrM2FJaUxTODRqUTZaOFNER1k4?=
 =?utf-8?B?czkwVDlOOE4zY1lscUJaaGtaVUZGZGFITURZYkRmUW9rY2swUThoaEJDN2I3?=
 =?utf-8?B?RTEwNll4blU0eEZSUjMyMWtiR09SdnBjeDg3ZXN2aWZsRDBacTRIMUpIdm5j?=
 =?utf-8?B?OXJtQ09ldmZVTE80ckN0MUV5NlZlVXNSOEoyMk8yUldHcVlCSEhpVWM0YVJF?=
 =?utf-8?B?SXloUVp0cnVCbTZvQXI1Y0hwYmdsUy82U1c4Q3VGcERtclg1Uko1bmREeG5X?=
 =?utf-8?B?MDNkcnM4ek05Z1BodURrd1JVdHoxUndQWm9oUERPa09Wd3lmcGZUcVp0Mlp1?=
 =?utf-8?B?VlBYL3dwTDJrbHBDblhiMXZ4WHZXeHNCV3lrSjZiVnkzZmx6NFIwenJGdy9Z?=
 =?utf-8?B?OVp6TW95Y1F3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6711.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFIxUGR2YTVhdk5qSTExZlcreDV3VVQ3M3l2VlBvRmt5cUJwNUdrcXgxdWty?=
 =?utf-8?B?WmtZNlRCYzJVNmtGUTBiOGxpU0lpUFRmZC9DcktWcjcvUXcrbVpUTk56TXJk?=
 =?utf-8?B?YkFaaHhCVXhMSjhLU2NzRStQeDAxVmtHZ2NsUDRxWmI1QUNGTkJIQ0tDTDdP?=
 =?utf-8?B?THZOMHhqMzk1NEY5UHZuM0ZaNEg4MWVIUEc3ZGlGeGVhZzFPcy9jVWlGK1NP?=
 =?utf-8?B?RUwyVThZdm80Y0trVFlLb28yMlFaaDdQMGtuVENyYVYxY2lHL3ZBbitjSkFE?=
 =?utf-8?B?NHJOYXRla0o0Uk9uRllNVnNCUThXcUltQnBTZnhpc1pEb1Q1NVY1emIxVGJo?=
 =?utf-8?B?ZlF4MWpOaWoydGlBYTNJS1cvOVlrem9aUnhEY3cySHVqMm5zbE1IVE52U1Y0?=
 =?utf-8?B?aE9lNVNSRlp1Rmp1ZnBWM3YzZ0Nad1RMVWNJNmhwMThDQTFLMnZVQ21oSGRH?=
 =?utf-8?B?S05IenM0Y2tLcmRIdzY3c1U1QWVDNmorOFEzT2VBT0sxZ2JySjU2elBpdUwz?=
 =?utf-8?B?UE40Tk52RW15UzByS1dpQXJNMVAra25DcWp5Mk9GNjlPV3VGOWZOR1kzWVU5?=
 =?utf-8?B?M3Q5a2JyOGNaVU9wTWdSSEVva0plZWY4OE56Z0dWWHVBZEZBZ3hHNVVjc205?=
 =?utf-8?B?OG03Vjd5cFI2T0R6ZHhPQnorSm5SRVQ5a1pJUkR0bjF6U0V5L0hLTHlwWlho?=
 =?utf-8?B?dTd3bHlkeWh6Y1NSUUlFNVMrQmF5dDhtWGpYN205WmNBZVBycDFHNEM4bllY?=
 =?utf-8?B?TUgvKzkrWWcycENyQngzL0lXMEkyZDRZZE1UcCsrSDFtalV4cVhoTnhXaFRh?=
 =?utf-8?B?TDVtRVFRL3hkNkJRMWlkN3FaWUUvSjhPRTlUNFIxVWg3RGEzenpGTUVON2Jq?=
 =?utf-8?B?NzVRM01Yc2ZGMEVCaTZVTVYvVjI5UStyeXJEeUJIdUxpajFIZDVpSzJhK1k2?=
 =?utf-8?B?ZEtKZHVCR2xZTlEwVjl0VFNQaWpYT3NtaWhBOFk1bk5QOEZGZGNZcGFqTE1G?=
 =?utf-8?B?eXIyMXZYVWZVMHU0RzQ0ZlRSYWRJNlo5am11TmR4WmRHdHRRMTVvU29vV2VT?=
 =?utf-8?B?KzFXRkhUMnpXcjRGdnRZdzhEV2kwN3Znc3JreGxZa2E1Mm5la00xdXVWUm1i?=
 =?utf-8?B?NU9lTE9LUlhWZzV0eGFaUlFEZUkzdVJKQWpKQ0hBWjFWTUlBY0h4bEczQnVm?=
 =?utf-8?B?VCtQU2hsYzhqQ29uRlhxUkdDWUJwVmtjdHNIelIydTBGWEVQL0V0V3NnNTly?=
 =?utf-8?B?UHNDTGczVHpjM1Z6dStqSitzRHI1TnhkWXFmOFlpbno4U1VzNEZhTlpTb2lu?=
 =?utf-8?B?YWhZUkx3VXJkRWI4OFJneEx3eDdYZEVSWUVkRFNIZU1pdURuazB4ZHF2VTJv?=
 =?utf-8?B?UUdjalo2WHBaazJGMXNlcWFWcUs2T1lZSlZuL2NyRFZsdjBMVnl5eTkvZ2ZP?=
 =?utf-8?B?RnhZUDlJdU5pdSs5N2R1dENPcURvZVhSZXBkanBwSlc3am1OMkFIN3pQUHU1?=
 =?utf-8?B?QlBFWjk2NmZnTVNXbzdJSjJwS3Q3MXIxUE92Q2d1Qm5xQTZYY1FvU1NSY2dO?=
 =?utf-8?B?dFE0UllHYlo4Yis1RnZhOWgvcS9OS0JmNVp3VmJybHZvcGJpOFNmaWtTS0lj?=
 =?utf-8?B?bTcwalMxUlMybVBacGcydjllUjgrZkt0eEVnckdXSWdHNVNYSXhPdGswamlM?=
 =?utf-8?B?bFc5cWZ5WGRwdlpBMUhET01DeUhPaXp0L3JyMm9BcStJQnZaUmJybU1Kemo2?=
 =?utf-8?B?QWlmdkN5WlZFNzhUYXU4cXplWXFHRmJSdWxWOHdUYnErUGFFUHlmWWJFcDZp?=
 =?utf-8?B?czQ3cmVSM1Nqa2ZybHlDc0cwR1JCdWtsaEtVM3BHZFJnODYrQjJlVDRPRE1w?=
 =?utf-8?B?OU5EVDlQU21OMUx4L2R2NlZ3ZWIzN2tUMTRiTVgwSjZsek1jdVpFbmF4QzZV?=
 =?utf-8?B?bXhMdjdVNlFJWTd4MzkwVHUvSEJLdHZacjFaSnllYTJmUGNyNEZuaVVOMzRQ?=
 =?utf-8?B?VTdwWHY0eityYWMzQURTUm5kckdvWmZPMDU1ancyRmJpZnBkcGRFVjJJbDcv?=
 =?utf-8?B?OUoyYm5ySjRKby83RmR4S0w0bHVGaUZpQ3ZRRDA4UFd4NHBmMkhIaWc0V0Mw?=
 =?utf-8?B?Qi9ZWTdjQTE0Q3Y5WmVIZWdlK2oyelh3dnhpUjk1eGhPTjNNYUVEQWM0d1RT?=
 =?utf-8?Q?7go+ooRr+rQqsXytBDUHuFjyZcmBvcwDWgFxBSDqEfB1?=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BkT27tCUrT8WEDv28ZhTXqBJt87o42eqvrvPdlY3+46govuKDgOUNj8wzo9o63nDs4kJ6Fix69MfVPEkwycrKlpQabLDeO3gGNdkOgZBP4WDLRO1X+WpZVY3Ppoao/yCTJfYQyUttetfbZcz6OvU1ld0mC8yogJOTU0yvVnG+q/1eNrvD33PXz+K4CN6Q/u3fMuA49nX5HdCuAfDo+mkTQm3g/ND6iJ6zn7BqYSr157WBeSDjM1uke6zpnhnwUsG0fCDfUth4/E1vj4wmNBlPfxK1goeA3AdxobEUB36oNLuGNPHNQ7uuO3N3OexVBdeyE6/jJRhqFdFnLzw/KWvs8wJrWQo3vtX1jrlQo5LYaoYa5ZMvTV1Tb/BwLYqlJTg+9nkRHPGMIVZJaKfpjX3rO9VBuUPwGePMRadaHcR1HNy0pkG3n7uZAOAw0ihcrGxdEjYNfe2EsWsierTWFvP1/9hnQV+necKiQAIPlOttxL8etHTa5wpMCEhSB8UNVUCqRfp3p+y42Y3FYc9g4Yr6Ss0E4t0SIoP3BNtK7V0gVyHSCWr4EZlfTWToV71V0ben2CQ9bvZuwolFoYb2tjZHxv8PWh7HybNVLRms+iKPbFJ5JSmgikNTRBm4CMbGRcR
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6711.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16913a3-1910-48ea-fcf3-08dd9804e452
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 01:14:53.4359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 97AeZgEIgPCL6E+B61QORfcqhK/zMhXDmHGGniL2SRc3tQlRqNfhVhuurAuqlihNWGXvK6ZQf4m3k1NzYsOgXVaPwlvBgn5ThqwUgmmgpmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10473
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDAxMCBTYWx0ZWRfX2l+xZESN+lpt W63bdNflL57CXDij1Q7qcif0wXWpQcJ0kgT/2zX1kZJ2IKCPYK0cO2GnPz2n2T0ExxbRgltj56X qXO04+31A5ljQigv8q4vxDdgngYtAR6zf/MVd4roIaBxLrMCYJ4EMuwkZoQ6z0yD6P1vCWZvSh+
 V4sJaKNK+RlisseGzIeeRkcQvO5csdNLEP/Qw/sJAB9uFApEtPBjsPfr5eqrVqZZHZmb6IoLTn+ bz1q+c5KUt6/qoEvch/DslBNYR3mIzP22Pxjsilap34Tk4X6t4CsB/soyXMXK/ZwLjeU2yf1qbE 2Y47wgLUBmw4NyIS5MFnUQol+H8x2f5RdNlCplq/oDq/dSB7BkCBOOp09tM3w9qb3DwiIYVYLNs
 Zmrg/seI7NANRXsBQS0dR+Zhe0YaMAGlzdMAQPQfrB73CZNCH1hCVLGAnzKnpzFbWzmXBrDn
X-Proofpoint-GUID: MdY18CHUVg2y60L9ArOFx8V0lv_ajF8f
X-Proofpoint-ORIG-GUID: MdY18CHUVg2y60L9ArOFx8V0lv_ajF8f
X-Authority-Analysis: v=2.4 cv=Cvm/cm4D c=1 sm=1 tr=0 ts=682d2918 cx=c_pps a=VZPoZd6qAwltk118jDKH7w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=7j0FZ4iXMVMA:10 a=xR56lInIT_wA:10 a=VwQbUJbxAAAA:8 a=z6gsHLkEAAAA:8 a=ziBiD3pvh6hlvc8l1uUA:9 a=QEXdDO2ut3YA:10
X-Sony-Outbound-GUID: MdY18CHUVg2y60L9ArOFx8V0lv_ajF8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_10,2025-05-20_03,2025-03-28_01

Hi Tejun,

On 21 May 2025 5:11, Tejun Heo wrote:
> > -WARNING: cgroup2 cpu controller doesn't yet fully support the control =
of
> > +WARNING: cgroup2 cpu controller doesn't yet support the (bandwidth) co=
ntrol of
>
> This reads weird to me. Without the () part, it becomes "doesn't yet supp=
ort
> the control of". Maybe rephrase it a bit more?

I'm not sure how to rephrase it. It sounds fine to me =F0=9F=98=85 Moreover=
, "doesn't yet support the control of" was the wording when the warning par=
agraph on RT_GROUP_SCHED was added in commit c2f31b79 (cgroup: add warning =
about RT not being supported on cgroup2). Would removing the parentheses, m=
aking it "doesn't yet support the bandwidth control of", sound better?

Thank you

Regards,
Shashank

________________________________________
From: Tejun Heo <tj@kernel.org>
Sent: 21 May 2025 5:11
To: Mahadasyam, Shashank (SGC)
Cc: Johannes Weiner; Michal Koutn=C3=BD; Jonathan Corbet; cgroups@vger.kern=
el.org; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; Takumi, Sh=
inya (SGC)
Subject: Re: [PATCH v2 1/3] cgroup, docs: be specific about bandwidth contr=
ol of rt processes

On Tue, May 20, 2025 at 11:=E2=80=8A07:=E2=80=8A45PM +0900, Shashank Balaji=
 via B4 Relay wrote: > From: Shashank Balaji <shashank.=E2=80=8Amahadasyam@=
=E2=80=8Asony.=E2=80=8Acom> > > Signed-off-by: Shashank Balaji <shashank.=
=E2=80=8Amahadasyam@=E2=80=8Asony.=E2=80=8Acom> > --- > Documentation/admin=
-guide/cgroup-v2.=E2=80=8Arst


On Tue, May 20, 2025 at 11:07:45PM +0900, Shashank Balaji via B4 Relay wrot=
e:
> From: Shashank Balaji <shashank.mahadasyam@sony.com>
>
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 1a16ce68a4d7f6f8c9070be89c4975dbfa79077e..3b3685736fe9b12e96a273248=
dfb4a8c62a4b698 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1076,7 +1076,7 @@ cpufreq governor about the minimum desired frequenc=
y which should always be
>  provided by a CPU, as well as the maximum desired frequency, which shoul=
d not
>  be exceeded by a CPU.
>
> -WARNING: cgroup2 cpu controller doesn't yet fully support the control of
> +WARNING: cgroup2 cpu controller doesn't yet support the (bandwidth) cont=
rol of

This reads weird to me. Without the () part, it becomes "doesn't yet support
the control of". Maybe rephrase it a bit more?

Thanks.

--
tejun


