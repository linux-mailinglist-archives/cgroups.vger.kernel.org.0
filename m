Return-Path: <cgroups+bounces-14632-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMCzBJArqWkC2wAAu9opvQ
	(envelope-from <cgroups+bounces-14632-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 08:06:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 597C620C29B
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 08:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAD523025D35
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 07:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42883481B1;
	Thu,  5 Mar 2026 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HMbBa0H7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GHKJ7m2+"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9568B3368B8
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694371; cv=fail; b=JB00RQQyGwpZK1l8f6plI5sCd0CooKIwhP4eT8fTkSq1iiPM1Ouk5ATVl507blx9wx+IcUMp74z8hYmwg4XRp/ktLuT6FT9cVUAKN36B4uVwfGzyKnzs6+eSwZnRS4nC2WnC6XDbxuyotwEupUOLGWY//SEMawGK1aMH7EQFBak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694371; c=relaxed/simple;
	bh=c2Q+Z1PAdBNOgw49kaErC7IIEw8a0zhJ/JdE2KOz3gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ler8b65SyrjGj8o+GuE56VvS48Rv/ap33qkqyocjha7hlENwNAuzENV5FBEOoG8BMgqvNVNsBdSoboRSMTz4Ghnh5CuMzQDO/EDed5nJqYyPL5hqZy8xu4A9HvGu/hFRSydL5MsHwTb80HyBznU2tZMHZbAKKgJOHjiCZu87bMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HMbBa0H7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GHKJ7m2+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6256aJ6F115755;
	Thu, 5 Mar 2026 07:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=lvCq9nHzoymVDDKHwG
	3DXUy4XCx8yYoPpxI8VqNBUaE=; b=HMbBa0H7fLj+eSFg4uJ8PH9Si6LB5PkhM1
	jPRxtPSlRCRMVtjzWwqGbJMObvs8n8PEkGQVzGWmbCLB7qXelT9zmtQc87k0l/uf
	8E9T1g1QhdoSjrXPjLKDxkciTFESc4zp91JNDlivzw9gXPQ6dVU8Oe6Id7t2Dvs+
	I76XX4BIgtXHFyZTEYjWt6g7Tu0iL+TqVHmqxnMJ+4vVy/3lGPvYp3M7+X6rbEzO
	NWqvRwQTjVeZdUYnY81JpKRlZQjB9VgYUL2FDNdrDnqNO7a+wSls22aGUnX683xv
	GlR3PsrRlSj4rvk67NqvPBUlZnKzy56Y5hcOb1xMhz87mBYdcWyQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cq4q881fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Mar 2026 07:05:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6255LAZJ034689;
	Thu, 5 Mar 2026 07:05:53 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptgw6sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Mar 2026 07:05:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XU5vG1douPPsLdy2jnUphmOjlrCPdXRJbXf35MLgHqUcJS2CUaKfjW8sBxirmcNkaqCf7NZF1zH2NUTQtn0caczCZy5njG7Xid/NL4MC6e/0ff5S8WD7+wwntKq6rSb4mX++qcPjIUsZ5o1aMnBXgD2cU1crjNIRDlnRbIVMoIdD/Y9DYwQEX9VmH5p4WQj0kKsNch9VyxIT05JHOp9Vy2hO3UVy2CJaCI7nzpoj7PX5mlkimz5tZCrgBg+O/ypmQWpYk9sFJzCvck/aZ4uL3GhGfv+iQyftyPsr9wKYmQRdBgkDCbKn/0z2o1L2prhnqDM4U7tEmgmfzHQ3ywDjUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvCq9nHzoymVDDKHwG3DXUy4XCx8yYoPpxI8VqNBUaE=;
 b=PPXImn16GoHBiKf0bfmgQSi2wLN24VZDIc+cqZXYkQa2GNfbOQH+u8hJYAeQFriV6TWZ4Fyycy58FlYROByyJ8EbB3kdRZ2LomPsuYxk6yTqhj7JfjV9hPswPIry8K//O+q+I8rGhJiWE7QMYUkSWvE2/MIzeCeyraIMTwP1SpX/dl0CDZ74pEKeJAXQku6tSlJ5R+/0RFmZxtCnIRPUqtXEKwgwAINZo+x7SVUlEnWKEtEDajX+PYqDfvvnJRYn+efKqLGrDEkgQnROYCtAtcMyi7ABjB58ceuLrdqkG3+gYirPturga/yScmKE5bac1ZXQhId6+dAlVJSN8WOX3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvCq9nHzoymVDDKHwG3DXUy4XCx8yYoPpxI8VqNBUaE=;
 b=GHKJ7m2+v76gfmOd8du7zOvUA5ntXLOtMWAHXIS23C1ej2eSSOW/hjNzzMv+Gkqbu392omGBu3pD1GOfk4aYME2Jt+0gt1s7iN+BhqVBGHurzI1BD+uY9iFR09i1/OMQrQ2LL+JXo+H/AzhM9YIKzXPtsE9YxhKyIAqMdT4DXsg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB7411.namprd10.prod.outlook.com (2603:10b6:610:187::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 07:05:28 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 07:05:28 +0000
Date: Thu, 5 Mar 2026 16:05:21 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cgroups@vger.kernel.org,
        cl@gentwo.org, hannes@cmpxchg.org, hao.li@linux.dev,
        linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
        rientjes@google.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        surenb@google.com, pfalcato@suse.de
Subject: Re: [PATCH] mm/slab: change stride type from unsigned short to
 unsigned int
Message-ID: <aakrMQ9fKG52WtxE@hyeyoo>
References: <20260303135722.2680521-1-harry.yoo@oracle.com>
 <41f1c856-2c41-4d11-96e6-079d95d8efbb@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41f1c856-2c41-4d11-96e6-079d95d8efbb@linux.ibm.com>
X-ClientProxiedBy: SE2P216CA0018.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 120875e0-8867-46de-28c8-08de7a8594e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	y86lMraDfFHN6ejl2gmOXPTKygtAcl6RQT0MEph5MK/ouSpLjyuROw5kfafLSB9BlO4njtky3xcvc1Wir/cNTK3rp/NNTYBNjpK63yHm3E2c6+hZpBSN5rWGczhj+cURAP44s5hm4UPo5jPf8KxA3h/E7h1k4SA/8keLT6H43kPptlwVJHZRjRMyPYERm0zjW84ENUIV0VCPFC4KNcvzoIGAXwY7P6Z3Qn6x/rHX/hHUJgM+kuQQq0HXZ+OUsZ5ji/9uapPQN3QXQCpljXtwRvsdfib+o6rPK4Aeks8GIOdHq43+de0yGw2grEAiCbl7kzq6RqM8gaBkVbSUfASHDSqCLj4faVDg1I5KXJj1Z2Rf0JwpSEaWdxymKFottzna6RhZOJwehNcCRmnDdocJ/TlpNuVSjrnimhwQP1b0GyFp/J4MYGMRfFzm4jxHZYistUKjuUHy+EevJcXT680Ak7KS8283VFz8SVx9/8peRVtOIpSUrBCbiDyBNC85ZrFeuCMGTMoTZH8FLTwsw+Z3J2gCLRZFX3V4C6If6ckDHuk2UpCoUlmwaG1fNYSHSLrCMU4kYZmJuVbM6rz/vtXlZhxTHS2Pgxe+JwjnbGdVV7XPKx0T6juzCHAbHkcC6cSsbgBh6DsH4dTxRnWVMRFGaBiI78g0LzSa4/NK40xR6QY6Cys0esG+legwUWIqAaPc+zBQSWvJH3b8nHYI7l2mTxs5odI0FnYuBSOpc55iOMX6ti+oZVqzGkSCIZixyub0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Gc0jKnsALw2aGax7+2XYxcJ9Tw17N0EawXYqLsxz0KQzLIaWbPIelovlOjn?=
 =?us-ascii?Q?kw4kun9J7LpWBmwfFRSxMKR5z5HpFyYb3gE5Zg4EMRAMaQDtGJmdGypbdkYH?=
 =?us-ascii?Q?FWn7j3lB5Eyb/CYkIXvo4VGduxrYoPvo5+EZwaqDuG48qXvbTQEo5r1qiq74?=
 =?us-ascii?Q?LKY6s/j6YiMSpK/p+x60cS8s9tapBYP+8IQMpWUTKFYoLKOX9S06d0e3fMFX?=
 =?us-ascii?Q?imGy+8TIS6ttw+T8LtGu5qJjJCTdl8HPgm8zhjOUDEunCobdi2CEnfLIwnRx?=
 =?us-ascii?Q?IqNfcBgkE7+UAUsFNwbz2pxCsyq34xkEHyKKK2BHePw4Osh693+z5YYpRGhZ?=
 =?us-ascii?Q?TivRAxqHw6QeKaEQjmZdeQqbQiCa2GKe/xvZiX7yMpu8p5gHMUHK0Z8++WWE?=
 =?us-ascii?Q?wYnHYA60+fMIrvKxVXk5/OyMpG1tbOrRcCu8eo+aG/mbJfxUyh9PvGojlavj?=
 =?us-ascii?Q?cctWGqu3+9c5U636g6CqN0nws1Rg6rrD07sqQjGilQDpCtZdWq+q+VG8c7jd?=
 =?us-ascii?Q?6klIPAiBJ9DNtl3WqVCmobk7qZKju16JQyPn2+V2JwAJIyytkfKYWirRK/g6?=
 =?us-ascii?Q?mA2IskXHoSUZd7WkVJkkjWdUZJJrKuyiklxObW+MmjaQ/DCGSOdzCrlZ63/e?=
 =?us-ascii?Q?H+cOmPeSmQupERPKf65Hqqcgg97j+Vb9qXT+MvGcCfncddwDWBFaRwaHp+V9?=
 =?us-ascii?Q?8/3L6c54JSqjTK7tstgTxe+85LjMHpClA0gAZ6lBnxab31Ynw/raYRRP5ZLg?=
 =?us-ascii?Q?K93r4FgOhbA2/p/Dy2B2nxPEB0QzobwQ26P/lkb6FlNGB3b27cLrdqGdl+9w?=
 =?us-ascii?Q?3ltgcrEGiyEt3I8Nbv1qktLZl7JH/WJbtmYe++i+VckXbfi0JCXnNpFHc9eE?=
 =?us-ascii?Q?hK8XUpQjzQwHfSBf3KNuTB1lEBZufitze6vOy4LTodgTDJbuUwdpoil9YAJm?=
 =?us-ascii?Q?ypTLOE4XcV29XmQxtDg8wmyoYozolG7o4PR9QE0OyS19TJ7pDBnAVX+SHO5j?=
 =?us-ascii?Q?EylZ6T8p1vR3yn2KpXXKfHiQfTnfWa2diPVn7uuqzTT37FT9Z2NGHhJ3xa9s?=
 =?us-ascii?Q?OvPa/K0zXecd/gGglU1t0vrjd2sa4AGwKRlF7GX7A0JODZGFLHDpu2caiZvc?=
 =?us-ascii?Q?iK73BCHjWugiW547qBfN0Nq0myoEbmZIj7Hp6/Dy1PdsJUaIyleVl6SbT+mM?=
 =?us-ascii?Q?iyRXRTXkVxRSdIi9aPzsNMb6WJHs7nI7fY/Eodkr52/qyR/Qx6cKOkDe5I4a?=
 =?us-ascii?Q?VmZ0SVjtC322ajPj+gHrdxUwyBr40ppEm/RSZADnae9yACXolCRyNBESdNcp?=
 =?us-ascii?Q?AbKGN/rCgmE3gUswFMihy2AKLeFuwdy+0JBIeZ86AlFepH93WnN8koL/Uw3l?=
 =?us-ascii?Q?pSEDN10Ooh3nXJHH8uN33uZlfQOMXZNlw0rW3sayPuP27CdD3zFoximKpaIf?=
 =?us-ascii?Q?eO9VfON10oglFsmi8ZcOVZyneRMpb6ke6MuBZN7er0Yf+UBiZ4/ieOX9YpHQ?=
 =?us-ascii?Q?xdIfSKT5iHxGe9WueEPYglyUnyGzaOng6l7TK00CtYPb1rKvZtKdSMIp4N4f?=
 =?us-ascii?Q?d6pw4bu6ZhTng5CkEmGN2VU/XE2/H0NmdSmciV20T5oFPO4gTHcLr1mlyoSB?=
 =?us-ascii?Q?2+/h5Ymq9UsUzRNuOCvl/DbCfH3IcH5WZxONoYvA0afeCpvfbXxSC7lkZEQ1?=
 =?us-ascii?Q?6gwAjJEThDIVGX1VUjkHh+J0fH4jhE99FWmJj+ycwWMvxiLseAC/12hc3Yei?=
 =?us-ascii?Q?/hde3/BiKA=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	OfW60kS9CN8I0e2TxcVTgtP7s0hl1DQ/xJqnrI8HNzAF99vbBflKWXDl1qN447z+9FYtjUwrbHdoyLzyKL3o2/M+DeXWS20oeOJGbn2rbDzE2YpPgmV42yIhFIOEDTMr54r82DsmgBfAr+Ju8VWE0jtZH7mhvcSvWK/qy+HYx5eyLgu0jHQ2PSMEoH1abvdliFJunepCwCK47rNJxAfeIEwS6gUBBGBcgXR/pvFIRHEu5zkuQLsLwM2tS8e1K6rlDu4UAVoqJUw6HKiiMqnLgNHqfcFPGy/r/U24aaw0VCQuTL2dvq9LoAaSZU3cgXk3rAOaIq0hFXGA5FdKrNLZMg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AR+Opio3++HllQTi6wKNgy3YfX5bHMXWAl4DoS3olQJ2blEy90gYsXst7kY7U/+sQKUw1el3J89i+D8wEPXcsDVNweVbvdDWYAb8rGdqpRBAhjCajLwweR9k+Sg2BZTBqzw3GMXHh7IQzN+k0SNEh3kemuOy6OqEPeBjoQbbuPgnwN2YiD10ZeheSDffN/Wbf/s42B6/dq9minp1HrrrQN7kPFT8Ln+O9Xnenijc0eG+rajiTFbRnk/VyoP/qyVMlyQiYJwR/AzBpygnpVTeCA+xnhnIyVhE7MPo9Cq9AOLwImx66sw/Axt+HDn4jJLQO2aq9qqH/7qZcCEnhrMm0BUwazYD/AAZqZHqGnYWGVIYkp7FxTJO0opb5WW25jUCSEYQseq9riCnigRCiffCmKnIoL+IqmkqZvxsSXZQ1kE5kKqEzLhe5wnmGipOCaslolE6GFjWsFXhlwTW+Yvt3Ra0RZWibo+b93HlNaQUKbGTE6XjrYaptMWK3SDLXLngVxZe+/aYy/phtS+BJ6z1MTdHWkV+yKzIHYXfsdJe9KdaapQ6FBR6lZawETS4KdiGIs6QzOiS0HEvKu+ON74C7EAKdD391cNdk1XFZG95FLE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 120875e0-8867-46de-28c8-08de7a8594e7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 07:05:28.1864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ksf0h91LoomAEn1M+zDYu0f2fxmlM5OS00ccl1r/P5qSQkHh9L9WmMMuSUXsqkzhBEkSYfhuooDEcnI8p5Rpqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603050054
X-Proofpoint-ORIG-GUID: zuIU7yX2mw7BJ7xhHRXyuq0e3YvPZMQt
X-Authority-Analysis: v=2.4 cv=cbjfb3DM c=1 sm=1 tr=0 ts=69a92b51 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=-t2xFmcfunMQa4MTBqgA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12266
X-Proofpoint-GUID: zuIU7yX2mw7BJ7xhHRXyuq0e3YvPZMQt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA1NCBTYWx0ZWRfXy5NQpb4lYGAh
 S9Czrg8g3Xlx5T877NLm+gTD1SbAiDwetdnvAfuDAdLTmYZsJI+NDbeidP3t0GDTeWjEoNdtTFq
 OcdmDxxCr0KkqjW3MkaUuqc0Me3bQnJx4dlPSGe53mOZtU9fEQzUCV45X4dC0lwXDl8zvrg2w+m
 OqiiDYe4v5u71S6Dbjqz3ZY5vvpOyykTxbeszLDTrpCyTdZFYC6JE2xtimXA0u0P31glLdH/0Us
 ZbW8Y37ZTYHReKcf0neyQPrpyCLnCLX+tMQdVrZCOaZtkcO3522rZfWOCB1d+6I3jQXF0/SN4HJ
 iJ5YjgBxbnGAS2bY1YXNl8mvYXsys9ZI/JjBjxY1A82YmlN7QPB1bIj8/WwzmZhXiqfMcQ47inu
 ykh2Yl4N/szAzNXERBn1SixJ2KT7uS0p9ILIv/MU7DDTazfxcleGA3ds6OfunCeX7ZIaSK2npwP
 ihjqStxyh73MJEgGwaxeYuDE0nyWc4kIqlxaOzsI=
X-Rspamd-Queue-Id: 597C620C29B
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14632-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:dkim,oracle.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 12:24:08PM +0530, Venkat Rao Bagalkote wrote:
> On 03/03/26 7:27 pm, Harry Yoo wrote:
> > Commit 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
> > defined the type of slab->stride as unsigned short, because the author
> > initially planned to store stride within the lower 16 bits of the
> > page_type field, but later stored it in unused bits in the counters
> > field instead.
> > 
> > However, the idea of having only 2-byte stride turned out to be a
> > serious mistake. On systems with 64k pages, order-1 pages are 128k,
> > which is larger than USHRT_MAX. It triggers a debug warning because
> > s->size is 128k while stride, truncated to 2 bytes, becomes zero:
> > 
> >    ------------[ cut here ]------------
> >    Warning! stride (0) != s->size (131072)
> >    WARNING: mm/slub.c:2231 at alloc_slab_obj_exts_early.constprop.0+0x524/0x534, CPU#6: systemd-sysctl/307
> >    Modules linked in:
> >    CPU: 6 UID: 0 PID: 307 Comm: systemd-sysctl Not tainted 7.0.0-rc1+ #6 PREEMPTLAZY
> >    Hardware name: IBM,9009-22A POWER9 (architected) 0x4e0202 0xf000005 of:IBM,FW950.E0 (VL950_179) hv:phyp pSeries
> >    NIP:  c0000000008a9ac0 LR: c0000000008a9abc CTR: 0000000000000000
> >    REGS: c0000000141f7390 TRAP: 0700   Not tainted  (7.0.0-rc1+)
> >    MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28004400  XER: 00000005
> >    CFAR: c000000000279318 IRQMASK: 0
> >    GPR00: c0000000008a9abc c0000000141f7630 c00000000252a300 c00000001427b200
> >    GPR04: 0000000000000004 0000000000000000 c000000000278fd0 0000000000000000
> >    GPR08: fffffffffffe0000 0000000000000000 0000000000000000 0000000022004400
> >    GPR12: c000000000f644b0 c000000017ff8f00 0000000000000000 0000000000000000
> >    GPR16: 0000000000000000 c0000000141f7aa0 0000000000000000 c0000000141f7a88
> >    GPR20: 0000000000000000 0000000000400cc0 ffffffffffffffff c00000001427b180
> >    GPR24: 0000000000000004 00000000000c0cc0 c000000004e89a20 c00000005de90011
> >    GPR28: 0000000000010010 c00000005df00000 c000000006017f80 c00c000000177a00
> >    NIP [c0000000008a9ac0] alloc_slab_obj_exts_early.constprop.0+0x524/0x534
> >    LR [c0000000008a9abc] alloc_slab_obj_exts_early.constprop.0+0x520/0x534
> >    Call Trace:
> >    [c0000000141f7630] [c0000000008a9abc] alloc_slab_obj_exts_early.constprop.0+0x520/0x534 (unreliable)
> >    [c0000000141f76c0] [c0000000008aafbc] allocate_slab+0x154/0x94c
> >    [c0000000141f7760] [c0000000008b41c0] refill_objects+0x124/0x16c
> >    [c0000000141f77c0] [c0000000008b4be0] __pcs_replace_empty_main+0x2b0/0x444
> >    [c0000000141f7810] [c0000000008b9600] __kvmalloc_node_noprof+0x840/0x914
> >    [c0000000141f7900] [c000000000a3dd40] seq_read_iter+0x60c/0xb00
> >    [c0000000141f7a10] [c000000000b36b24] proc_reg_read_iter+0x154/0x1fc
> >    [c0000000141f7a50] [c0000000009cee7c] vfs_read+0x39c/0x4e4
> >    [c0000000141f7b30] [c0000000009d0214] ksys_read+0x9c/0x180
> >    [c0000000141f7b90] [c00000000003a8d0] system_call_exception+0x1e0/0x4b0
> >    [c0000000141f7e50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
> > 
> > This leads to slab_obj_ext() returning the first slabobj_ext or all
> > objects and confuses the reference counting of object cgroups [1] and
> > memory (un)charging for memory cgroups [2].
> > 
> > Fortunately, the counters field has 32 unused bits instead of 16
> > on 64-bit CPUs, which is wide enough to hold any value of s->size.
> > Change the type to unsigned int.
> > 
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Closes: https://lore.kernel.org/lkml/ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com
> > Closes: https://lore.kernel.org/all/ddff7c7d-c0c3-4780-808f-9a83268bbf0c@linux.ibm.com
> > Fixes: 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> > 
> > Hi Venkat, could you please test this on top of 7.0-rc2 (instead of
> > 7.0-rc1) and see if the bugs [1] [2] are reproduced on your machine?
> 
> 
> Hello Harry,
> 
> Apologizes for delayed response,

No worries.

> I was out sick.

Ouch :( hope you feel better now.

> I have tested this patch on top of 7.0-rc2, and confirm, this patch fixes
> both the reported issue.
>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Thanks a lot for testing & confirming!

-- 
Cheers,
Harry / Hyeonggon

