Return-Path: <cgroups+bounces-14727-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE7WBgKRr2kragIAu9opvQ
	(envelope-from <cgroups+bounces-14727-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 04:33:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AAA244D6F
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 04:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EF123149A32
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 03:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B95C3B960F;
	Tue, 10 Mar 2026 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q/Sj94LI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xnU2QIjI"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9701386C9;
	Tue, 10 Mar 2026 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773113427; cv=fail; b=n0VBluJMe9P74Rasg6GsvqTGx8Ek+nDSYFzXWROEpys2gZbjQ128L45STFuu75Fr3SUg3fxyL26aLn+2l43tRhNsFmDieqDdqv6xpQ1h3kWzSeCpaw13hjg7QL/W/cGGr55/Gw7/MnN98cxlfJqcOK78n6lqsV+JtKrpBqeq3h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773113427; c=relaxed/simple;
	bh=hoFipddVpPL1LueVwUYTMEt4b3TITIHo8+sOJY2Hz0M=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ot4q07Fj7IhY1AbTSdMhgnY9OZsvNCbbnd6cnkptONJmGm4C101wwhHDEWSjoltkqDsTwAtG1B2X1ASSumrWZOdXy2UnIwJzmP06KZDbmyaDshr6/wr+WPxCGJekTQUzj2nKtZj6h9yWfnuXzN661fYZygty5x1zVc53BlaI7yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q/Sj94LI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xnU2QIjI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629IMj1N094064;
	Tue, 10 Mar 2026 03:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qmCS6OAV4CNo9Or/U3
	60tKIGl2kfW0WTSryVuIPPLPE=; b=Q/Sj94LIQvp9mpnzI2sfLtFPXs12j6Xj9M
	0BPQ4Fh2PXGcNB4iLIAZZ7OqqgTDinW8S3pFBqw28Pko+R0fvnVNKHZdMK6oob0G
	yhbipxrYvtN8GbkrrM1efp3BcPp1lT9CdlyU8iZOxlGAwocZO62j0ELXt3sKDJ6M
	tSxujbexZmBsRcHT53KezNsS+XPtSZf8lE1MfWRYNI+POXuwjsXOXdmQq2n0jkSi
	ZGlmVW7DK0UyRG/gNlP2RcU6LU8GMBH47Hn8k0eVmmXh0c57hA3QdEQtzePcKnFB
	yc2OQPKLGq+pOpvtd/KiRDhrEa1wtHmjnK6oB15zD56ZehnbOztA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csmdkj42j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 03:30:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62A2gIrd020504;
	Tue, 10 Mar 2026 03:30:10 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011031.outbound.protection.outlook.com [40.93.194.31])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4crafdhacx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 03:30:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0vKmYXRkhLaqAlVYa+0yB3E/6wXn7txTsTrs56VYDkSRzZAp9a98R5cHa2BSDp9r4snnHCyAFfijqaVlLDfpCk0xth4hpNR1kpizNsETLYz7KoUZBCtiDftgOgOHTWtaDA+zFTyTHzRK/h1zp/ImRVd4XHwGgKbfaIdTEi5DOTxAjlCGUvdazniM529rB5YcGEqpraBlMkW7yt+3EEG5fw0LCIAFpRvaZXHV6G0QnvuCyNNgfJBgVFzAK3Imz0QOx4zzBYqtN1HvApLOqQtwmL+3eRQmlISarshZ5IXULdV8j1RZwRMqxC92BJVkPX/dz1naIaPV8YlXhSIyHehPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmCS6OAV4CNo9Or/U360tKIGl2kfW0WTSryVuIPPLPE=;
 b=Dm69JgnOm4E4Asj5G1J+QGkj5+p3oPLCpIr35cKIryk040xJok3qQGjRJnm48LDgE3g350BE3HsClSTfxyxbSsIc1oPkRdaMfO0GCqKbqtWc/ybUFsXkREFf4i/LE8/pL6MsWnchnj+HvwGeZ5Avlh5OapPMXBk/Lq95kKBAB2myCNiTY73MLx8t62kkfiJ/oHRRBuWXMgGLthjBgEKB7a5TynmLMWk+dM0f6jSbJxmUbWjF/FeITRQ0EQNEBOvP0kaexWWIe6ZMe2tQYbzTzO4JhGOgxzRi5I1sapvRL3RwgHlqUkHKXb03B2tICCojv570fJ+IjenpOZ29MilVDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmCS6OAV4CNo9Or/U360tKIGl2kfW0WTSryVuIPPLPE=;
 b=xnU2QIjI8BAgHuzTjuG3b1ZWT8EVDaXFEwjsfLjL/ZJSkqm+iIh6jSxoQsRNBJcbtMv0tucKKGpRYAkLTJvSfYyFbuoA6iyNG/2cSUf7Peygsz4rKibCJPPJteb1wJti0LcEmz8pE7NonA3hhxIIkWVblaELK95tiGDzfVHNjrI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH8PR10MB6669.namprd10.prod.outlook.com (2603:10b6:510:221::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 03:30:06 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9678.023; Tue, 10 Mar 2026
 03:30:06 +0000
Date: Tue, 10 Mar 2026 12:29:58 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: adilger.kernel@dilger.ca, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, hao.li@linux.dev,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, shicenci@gmail.com,
        vbabka@kernel.org, cl@gentwo.org, rientjes@google.com,
        roman.gushchin@linux.dev, viro@zeniv.linux.org.uk, surenb@google.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: fix an incorrect check in obj_exts_alloc_size()
Message-ID: <aa-QNh6bccp3PSM-@hyeyoo>
References: <aa5NmA25QsFDMhof@hyeyoo>
 <20260309072219.22653-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309072219.22653-1-harry.yoo@oracle.com>
X-ClientProxiedBy: SEWP216CA0011.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH8PR10MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: 1869e34c-62c7-4efc-8495-08de7e5552bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	VkIGWQ7HPMOvxzgJR9RXjFTsw+yw0uxGLPUXG2Yg4wX5diYaJORUP0U3cnfrQqwB0HVeXPnFMuv60ngr+DIYiwUlDKArlXmT1sKWI3mWwl+eas/56x8WYXvz9U2D/qs7NQvfil6af94FkyhIBWVeENpteNUbMxEojzXmjGDCNNTIOmt64Q9xxn1kjL7Pa0635R0Gm/MMgBK4KKxIjurS4eT6vTA1+jSPOOw65qHo5S7zc0UlR5+44ZDOg+2EhqxP3qU08Z0W7wYPW220ELn8WFB5hD4GokW2Y2LpWNQ3doRwpp3bI6pRIoU3FgEv6lAc+61MVP7IuQIC3vD6adp5QEf9yHemBSbsp0C2KEWNEvHqHTyTovagI94KXoeng9FPxY0t7P7NyGbBeFkjvII/8c4n+smExsrBCq9ac1rXQd6o404qteCIUULqvsyZ2YoTl/1/AhJiu0J36/PvvvZ7t6QPwNrMuhURedZLKb9h6HcXKsrWKDEgaNBLnjFucKnd2+KCp/qc3GGTO/JBJ3ZELDP5o/r8W0ux1XnWn2sPhdCrR9PR/NGc47IH91QB8x5FnwZzJB9tG8wsnyCd2GXXQuG34IVCHHdXk+sUy/5ed2snXapDLYTnDo+ToqBuc2pgGAf9k8LbCM6/mkti6t0xsccilZy2eiPZHNMNGJqOuTeax4UFjV/MKcOLCCwrFcWEXk2e+imeSxKiDPsJq6J3IT6oo3I34H5yqHk1C+B58jBWk/NWsj5narnGbphcf0yHIB9OW8cT71a8fiit3VIX43wRea9sIaIuXqIGot97YuY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8VukUfVJyh17PrV3uQZ5xFA3cRmvBYzhJVgUrEThOrgfkU2cdhzh5v69LFBD?=
 =?us-ascii?Q?zldOHYNpisX++pwQIm74OUoxCNWXV4nU3RJWMKqEy21JGXKW6K+6+r7+H9s7?=
 =?us-ascii?Q?ih9/zlu++GjbsUfg099oJY1F330nzxJMvK2PtAdo+2W/OWvmxXqgzoyLWCk9?=
 =?us-ascii?Q?KGk5FduJ/2m8J0ivqM+xfU+YvjqqJl6rl3FWsKXNxRJkNbSKgJiDIO2dueoP?=
 =?us-ascii?Q?Yo/Q206lpQ0dR/1W5qqCSr3AVGHn21LKnUYrs5nlBmNa3vvFXuMAs0BRyBEe?=
 =?us-ascii?Q?pGy418/SaFaIQIsZ2LGQMhJmYVrGSMQ6nV7xLDDycr2LYGAq+5ghdzyrrBwl?=
 =?us-ascii?Q?grCzoYNMMaKCPUDWPq1/uSq4q80ifk34VDDbHmusgmHyULsuWSGgeNJUm2iW?=
 =?us-ascii?Q?rsLvmTNEldX5wmxeXlbHzqTqX9u8w6Ccz1kI5W6iFGsOCUp7u2j9d1+9wulY?=
 =?us-ascii?Q?+M3H2Ihtl2Pduqcc4PhI3iu7V9UsB3DwZSZIKs7iNdL7HI+sdNAtRd7PbHat?=
 =?us-ascii?Q?6+OTRHTOOExnc0y9ggMJYBkBjD8IpvPnWgKMahQLSOrVKQo9XRNagoMzsZoF?=
 =?us-ascii?Q?Ue+4wY2rZOE9va8CZnF5PuC03ktjUL0rA1hWl1ldB7l4pW/bEb/LU8bs4+Wa?=
 =?us-ascii?Q?ud9PVonSZ6/SUtIz8w0uicR9S+qdZjkjJoynHOjXe0rkTwsJ3vv66NVh0nV0?=
 =?us-ascii?Q?DXkx3xVwVbche4gEk/EghxCrq8FDTNnNlhoQtXjBT/5JW03RsGrkDAaj+MM6?=
 =?us-ascii?Q?s4V098yODQBTwU10Vr9kxn3EHOYtcKrme/b9/7JT2YQFf0rxZqOmCp6kKMBo?=
 =?us-ascii?Q?k/gVs6Ht1/GoKsAJ6FIx8kLNHhTLaI6Bmgln0/d3b+wb4L9XLA5sAe+3LPtM?=
 =?us-ascii?Q?ErK/ADY8d1sIhWeXoLF7Ml2EeCN0jy9lSRiWI2bXITpRTjPhiUS/xDujm0I7?=
 =?us-ascii?Q?5nS9oTD1YTLckQ3bclyU2JBolNqQf4Ud6gUh2AWzlCIA50yQeLA8N2RuGmja?=
 =?us-ascii?Q?7MlDtX8mMhre0NwvjbRvfk8RZ8gupnWbGAGotLfnYgKv9oOkqmBNDW6KKHHY?=
 =?us-ascii?Q?0ShHnreg+lKHuLUyNWvTRulDqGtuWGhIcKD/R+/thyCneMviq1YLbayQzoyP?=
 =?us-ascii?Q?T8wG1X4S849zD1fOaRQVlQHU+I4iX1FrUiHoNxXZTr6PVqnMWerNfn33gCeC?=
 =?us-ascii?Q?MKmWv6U1Q4sZS6WrlHv37cwIRP/wWhhkWnJpnOMt1AWbwPaWqKLwI7Gv7OMu?=
 =?us-ascii?Q?ERorRSuZVTgdwLF/fBmQgc5wZZTB+NQJXtNNeuvRMTANmpE8mTE9ntkCF6hw?=
 =?us-ascii?Q?33mNJaMu6FfwUki2ZNKDhsIGTHlg5+0zgLxEAPjo/nGKfkF9bhE3iYPeClRd?=
 =?us-ascii?Q?Wali9TezgB9EvRyws/QcT/UxCUZ9B1UBab0m1a6ntmVajUneWJ5zUQnh5goV?=
 =?us-ascii?Q?SGRiE1r5KnIlyQcBKE0Caaq+Xyo+cGzDIiF5SDS6IYgUrkywdNCY23vTRydY?=
 =?us-ascii?Q?4EHNTJ7hQR1pWRZLNw30QqZXnAZDy6Z1uezVVAhWJhmebE1XT+HqJPuegHxY?=
 =?us-ascii?Q?tCl7asH9I1EIlYMJqGUNGZV+1wFYIKzerHA1/LJWbGCo/iXuOpXWR0lPLOjC?=
 =?us-ascii?Q?N35dJzCzCnIJ/sc6D8vbKqs57BHNnG8WQHyC7/NAt0+HZUxQ3+gOLxEGU5tg?=
 =?us-ascii?Q?ZagxA+NJLLePmpnQMrFtrnCJh9GU7r5TH9KRf4zDWMn8jckJNXvu8FKQOC3j?=
 =?us-ascii?Q?dwvhNZY37w=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	eL2RIJL9GQrH/n6MsX0T3job9DlPLe/Rg8/Fi6eKmVUl1odov+tvQVsRWxhYN989uMF4d6SzeIjUjJExlj0meo44DiK8oBMXDFd9jZ+QS8rOUBg9C3iWMNFNeSAyCl3DmXJ9YF5afbJBWMnvAAVk4ifSJ4Eoe1CD7a+8rlToi6jMbI5SS5wbOsEtVq5Lbio6lyl+otC59/6f+YX2UOhD9h23e7jUSXbJ7LiSS/DUYvO/h+U2lBAIxP2ktm7+io4X61cyeNztfWXCJzI5Z8lzgfksSItemu3e71FcAr7Osi4EKo7jgCjpcW0nQ3yuFrqkFL+bMmqSV/STakaUgpiR/w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UAdGMsS4NC4tFuAcdWVKZac7UE5N5BWtiNXZwFAElp2GEybDmQyrblr/IEBjX1Gz3QJko10b97W0JyNAqo+yeQqW5PZ72FoS9WJBQwVPG3ioRCwA2wUfcRj3Er283HOZUC/dhtbFBqPzjWT/Fr6pJja4ryuh0hlR/qdOkxAti4+kDMjexsWszjIVF56ZXWBd4vKvhRETnqv/1EX3UWVN8wrCHg4nbvqgXtZRtXeh9fkHBNR9/xnjX34vbcJunno8zsQdNQaDbyOrq8jfd5tUhcgtaE7K1U+wlHTvVoHtuBDd1Ww0lryHArhdk6raqkeRgiUw4avxPSzYrk78GZs1FV5JyGwceHKxiI7E2q5XkmYAuDrH8WCLuded1hmvzTz8dsrXMY0CEXxMbm5+U1L1fqZ+Mje53mhHCrmvSOvEQ1nXTW5H/bTgLWc59Cl+bGQvkVNNG5Uo8jI1YRqzTMn5HPQOZxdDJ42gBAIYvhia/3KYk1rsyGCnFd3gojxKID8qS8wCR46IpPIk5C7Y2Wqnd1y0JoQLfZkwlG51Tr5yqGd33cwSHw+wrz2hAvUEY8bldCO4g02kkk1Hkyj5RnHnMkMT0g8GhxNevDRd8pZ0BvE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1869e34c-62c7-4efc-8495-08de7e5552bf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 03:30:06.2143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKtataeQUSpqZOa+W7WxRJyODLvyGwj1kIHYGj03D60iViirB0LwQlM3snv37dC+D0QbCDYoMRG3XvKi77S+/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603100025
X-Authority-Analysis: v=2.4 cv=MuBfKmae c=1 sm=1 tr=0 ts=69af9043 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=sZFMqw-NpHMlxL5iuXIA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12272
X-Proofpoint-ORIG-GUID: OUNy5UkrMZwS0VbWAtWM-qfHJfdzdHvr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDAyNSBTYWx0ZWRfX4jwPcc2h9l5b
 Oj+9wHyd1gZSf+WDOu1VMSXLVn5h8Mg7FffnMgE0Bbw4Prl3Tr7OBdHduThF7yLa8FHg/osnExn
 wkMLzwztvcr8HHg7y/GL2aaSktbfsbSGSTl370C3jj5ylFeoseoFOPXl71ZKiEyNioMkwhHXVjz
 YiRVQaZ9OdTmFHs15zOE8M/GeMzJNwuZdI+98Pdm+zWbqwzVazhoaPPGH8O6POlxEjgH5oh9S1X
 1OU3giJv6Miyz2JbwGC9Xs4yfxJEOR1rQ1cEW5FwVq8/DqTO2yJAl/ScUG1hfvJYwO4Ojls6+R5
 j3yv24dI8WkWDS8E13MDPo5nGO1kr/b/+Ef3Dk+mgkT8xihi4PB6jKTylBkv2S21apeeLfkxTZj
 x6/oeIevr8a+TaswMvOzkhz2nsCT08my5N5WnmU5NRXKZqDop9rVqjoGPNIayXA8VrI4CRAmZdP
 M83gr2ANyTvXY1xRwYRnJlcfiJep1U4eUB0kFAz0=
X-Proofpoint-GUID: OUNy5UkrMZwS0VbWAtWM-qfHJfdzdHvr
X-Rspamd-Queue-Id: 79AAA244D6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14727-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:dkim,oracle.com:email,oracle.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[dilger.ca,linux-foundation.org,vger.kernel.org,cmpxchg.org,linux.dev,kvack.org,gmail.com,kernel.org,gentwo.org,google.com,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 04:22:19PM +0900, Harry Yoo wrote:
> obj_exts_alloc_size() prevents recursive allocation of slabobj_ext
> array from the same cache, to avoid creating slabs that are never freed.
> 
> There is one mistake that returns the original size when memory
> allocation profiling is disabled. The assumption was that
> memcg-triggered slabobj_ext allocation is always served from
> KMALLOC_CGROUP type. But this is wrong [1]: when the caller specifies
> both __GFP_RECLAIMABLE and __GFP_ACCOUNT with SLUB_TINY enabled, the
> allocation is served from normal kmalloc. This is because kmalloc_type()
> prioritizes __GFP_RECLAIMABLE over __GFP_ACCOUNT, and SLUB_TINY aliases
> KMALLOC_RECLAIM with KMALLOC_NORMAL.
> 
> As a result, the recursion guard is bypassed and the problematic slabs
> can be created. Fix this by removing the mem_alloc_profiling_enabled()
> check entirely. The remaining is_kmalloc_normal() check is still
> sufficient to detect whether the cache is of KMALLOC_NORMAL type and
> avoid bumping the size if it's not.
> 
> Without SLUB_TINY, no functional change intended.
> With SLUB_TINY, allocations with __GFP_ACCOUNT|__GFP_RECLAIMABLE
> now allocate a larger array if the sizes equal.
> 
> Reported-by: Zw Tang <shicenci@gmail.com>
> Fixes: 280ea9c3154b ("mm/slab: avoid allocating slabobj_ext array from its own slab")
> Closes: https://lore.kernel.org/linux-mm/CAPHJ_VKuMKSke8b11AZQw1PTSFN4n2C0gFxC6xGOG0ZLHgPmnA@mail.gmail.com [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
> 
> Zw Tang, could you please confirm that the warning disappears
> on your test environment, with this patch applied?

Oops, I think I saw Zw Tang's Tested-by: (thanks!), but appearently
it's not sent to linux-mm. Could you please add your Tested-by:
by replying to all, again?

-- 
Cheers,
Harry / Hyeonggon

