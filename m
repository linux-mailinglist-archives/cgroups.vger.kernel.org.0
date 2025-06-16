Return-Path: <cgroups+bounces-8542-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49774ADB8FB
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 20:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424173A3A59
	for <lists+cgroups@lfdr.de>; Mon, 16 Jun 2025 18:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650D228982D;
	Mon, 16 Jun 2025 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ptZUoZdZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s/4xhpy4"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5225A2BF01B;
	Mon, 16 Jun 2025 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750099258; cv=fail; b=LH8k5GQvjQ05UZTIfzoXvD4dowJFs2OovsYyNTffzeQdrG+GjbfM2uJYlmqwgti4RPWPF+JLK4vhsKSmxBjHoyIruZ6S43Uy5z6y4xpH1xgGOWOh3Y9AxTfPMkdAZIofosQaVVTWDB9aGzEJQrU1yNv1bLPK2eFN7xTITHEea3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750099258; c=relaxed/simple;
	bh=GOofBoaochkGYfRniTZnTvD0HDP+wiNiWE2iJeVqCuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ApwcEKXmIBCiG9O0sISA1D0hbR8/YK2fWKJ+sUyjv23XQQnsI/qIAyx0I2j1cesCGQ366Uxrrj3VE0/Hs8cqzFf2Z7x+7b6+kO/eUp2AHcMyWCmd0qeKUMdmijaUyfExVr/E0xb5BCEkZx06ysfRdspihV9tlLLRSIdkLs1+AxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ptZUoZdZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s/4xhpy4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GHuUjj017647;
	Mon, 16 Jun 2025 18:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=klhKWNXd2PVZhlmohk
	SF73qNG3ObvF0ikKdnISNMZEw=; b=ptZUoZdZGnYzPrBtKUNyQan46od1l9BN+G
	Hjqu2d+haKkm7qBSW5OEtPpmGME/xnZdnPZPDsiYxKzA8OBZttrquKqh7iQPawfW
	KKPdoEOOOWqM47NvSglTpC//GQWUDm+FOfhjhxraMpYiWXBqN4PeotgoRtB0zoTM
	cqQnnFjr11wygqyHSkljlmlDZSs47eiyk89O8nmfN5yqJz2sY8nzVtBw+iWgQ6E9
	QruRIMNz/Xr8ndPk5zf3xMM30DYHRvPvDZsHXla85wlmoALuhZOwEiDAvM+0V2cN
	N7YEV1Lsw5Is/xCS/WcbIdozWP8MGpYc6RSooPqUZkEIJV4+L02w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yp4kj3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 18:40:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GHbhnV036378;
	Mon, 16 Jun 2025 18:40:47 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2058.outbound.protection.outlook.com [40.107.102.58])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhesmdj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 18:40:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVlF6MalFwcRnO04/yMSixJfo+VPv96/a4m9Vl8+/VdjwH80ocq7tvCGRc1Fl9nq8eu2IJ7qLtJEeacBriuYWrCgMrExx6rn3iErj5nS8Aqooa7GC1M8TFicomkisCoYM1jPRhuHT8vijC/GzZJ8E+scI+uPpnVBFjGtpBVULHjqBa9PBguBbxvtO0RdMdaJ4V1KvMLPbf/f4hEQu088Di0Dhanirgi8T2vywB/FLst/Mjlmea1Txp3Y4pfVwJyFVZSikDYSI1Oejn/9F+aCvFHu6TYNaneKXdekHOgeHZ/56XXH77NDix/BQL0mxRiUt4p1CQhBPsz4QskPNCH/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klhKWNXd2PVZhlmohkSF73qNG3ObvF0ikKdnISNMZEw=;
 b=kbSB0fA8Sn1lAExoQSm9QduZMdNWxKexcRoUcTbetcRWNBZlNrxkavoKCTFWE1M1ZfAECqFW37YexnMgyDYs/Qii9RcaCPDOF/NWKbWIELJ7p6OzsdYCjQFzjhorE3bPm1BO9fF7ZNSndlwc2me/iuwAmGcu2KtZ1idnZGZrrjMEebX3kReVV45G5+9ck4w8ir1JT7GmoNfgpsRij7481nE8v1OhFMKg0QqVfWvBSm29d/ohkLqczLQEXg9q2OoX+ymH2YwXijtkDmk+QCdn2FeJMq36pcLZH4TD2BXKI4FApLmNvJWtIKwucGSYGkG+U/Er6te+FoIOY8FLxL2i4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klhKWNXd2PVZhlmohkSF73qNG3ObvF0ikKdnISNMZEw=;
 b=s/4xhpy4bNSDtXl5NLDwKNua+r3BO7PcmsgjrtJ+rO93R5vlXTkcCsRT0Kb5aE/FT8pxYgCHAYxfX5nXO4n0YYZ9iHsaSMaL+N7flDzfNw8VjV1Vb4vIY0CUDOoxqL+0yrASbc0MIuO4tAbieyO8yXK7b/KJ4vbAAdxwzBK+Mws=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8067.namprd10.prod.outlook.com (2603:10b6:208:50a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 18:40:45 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 18:40:44 +0000
Date: Mon, 16 Jun 2025 14:40:30 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: allison.henderson@oracle.com, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, tj@kernel.org,
        hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] rds: Expose feature parameters via sysfs
Message-ID: <aFBlHiguQpdB1e86@char.us.oracle.com>
References: <20250611224020.318684-1-konrad.wilk@oracle.com>
 <20250611224020.318684-2-konrad.wilk@oracle.com>
 <05ac7bdf-999c-487c-beb2-74153d03f6b1@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05ac7bdf-999c-487c-beb2-74153d03f6b1@lunn.ch>
X-ClientProxiedBy: BL1PR13CA0164.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d61b55b-3254-48f7-c22b-08ddad054db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RAaOic9uEKKHCLRx1F96RdjWMbwESK3WmEMxRIa2LzgLAQDnRQLowkXrN/O8?=
 =?us-ascii?Q?G+G7KYGDDqB+lyklv0vcMXf0Q/GaeKUmDTkSMF8tX5zTvRqITN6bqnMkAyn9?=
 =?us-ascii?Q?soGxh05S2RpsB8TMM0suS6yI/bOaU62Uhq/fFTx3n5khQp4PAE87fvRtAn+f?=
 =?us-ascii?Q?bWPJhGQaS5i2Zm3Yc2iOwDT6xKPh92H+ILoHzSW1qTzje5UeYCciFXg23IDZ?=
 =?us-ascii?Q?evurf16qriOSZGxv1xZx+SHVnlMTorg4gHN5n/f0sE7YwtkSDu+x85go8Kbd?=
 =?us-ascii?Q?kDE3PG5boZ01p9UOTFs5dnnQaL5LzRwgtdrSv4AlwgggjzwiEysaUbz4svz4?=
 =?us-ascii?Q?dtxh/+01qEaKB2x5OLYS+L7jav99GbwRNYVmDhbEZkk3yojMZmDTCGeTGsmx?=
 =?us-ascii?Q?yFbTbRquNcG8B2e4wez3RTcGyfxP6FyUuJ9T60LjWA/NJWryX8msiirmPSuw?=
 =?us-ascii?Q?ZBfeT7AyWrzHGPyb5sOWuqUxWoWcBgaBLGe8nAfH+jOQmXtN/zZ7Wkq2/csa?=
 =?us-ascii?Q?4dF7JpdtWe9nbViHQ5RLXEEDFwXQbWAWuBILX+y4AAqpmdCLzP7m0QkcdrTv?=
 =?us-ascii?Q?YE40jjfDwUixWft4JJprBSpbMjKb0G8UbyUtqufvJh2APF3KUIHHpMFuwhXq?=
 =?us-ascii?Q?FYpY9EnD6BMjhKh6Ttf/7lhUUA50JuwOg1toeaQjwEVtzbu8Gjv1jNsvQJyO?=
 =?us-ascii?Q?VUgMgVKz5iPQ2jeyt592GvXmaK+gA1Via1gRohPZg7oe4GwSlSh/AhsYhvnZ?=
 =?us-ascii?Q?eqCi6VVxKf2FwjYhcCOxMi3cLQJMOeoY7iewtlZHEYlRatJo47xjSo5Vv+tV?=
 =?us-ascii?Q?ELxozUW73VJwX/5F9YIq/ZfFrg6Fvj+R0unK2muCU6S9AoXJ7/2HRsgeeBoY?=
 =?us-ascii?Q?7FgP0izlcu3H0Wdhvdt8HMDEvu9rgwVmCssSdDJ80UIOCTzPVYm+myoZZecH?=
 =?us-ascii?Q?dAJ4uoRb/t4PT4EMS0FQcGDFCjmk4HqeBcjI/IN+fyd9Rv3vyJU0Ho5Vgdjd?=
 =?us-ascii?Q?UvmfCeBDGquPk0EjX8myXk7rVyurbppI4pIun1Sk4n1SfGlDX9JvBmtYVBsY?=
 =?us-ascii?Q?S6bmTeJ7X+jVAP8U5UpCD6ezfHUyKOU762BnTrC3/iz6dD989u658RGSndY5?=
 =?us-ascii?Q?u8w8anYqSXq55rQFOUubW1iJg5CqPIC8SbrYWwuC+B12vgp4WWbgt7YTu+Tz?=
 =?us-ascii?Q?ggNR5CbyhPNXxKGNKvlZZLnVKzvGcDhtydfm9EPMyPqkqkS6TtRk8Gm3m1TB?=
 =?us-ascii?Q?ZjEa74fw7h9gW/59pJnEmK6wF4sbi/HINuL77QSMu5ewABqbIrK6zV7ECy+a?=
 =?us-ascii?Q?LmbClraZwYblOeUdiPBYA1bkcqkFNlRLE3qzckXXQe7jPeDVXXohkZtajGIf?=
 =?us-ascii?Q?XQYgcIwX1/ChbwDq7lZsBw0czunKTfaLlx8W1qvZrVmQEsnSWCNBWADZtbvx?=
 =?us-ascii?Q?mfAew6T/vkE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?12xDD2voV3Nyt9UhF18g8Z+sHJKNhE8NnkYGL53TMe+vr9pwIefKKi1/iiBN?=
 =?us-ascii?Q?sFfAGFoE6/lugLuOIaFUCtisvISwOyKPGJ8BozM23Nsn3TKQmzWRs2oTRQdy?=
 =?us-ascii?Q?99xkO2wUMMeyxoETnJoWtPt0r2TzX2YXkM9QuThqNPuQPflmfYz8uXTgI5Iv?=
 =?us-ascii?Q?6mnW7PLBYWYdtA6uMTDv8QNcqSNshRSn71PcVmYi2F4qgM4WwEWKVa1BWgxl?=
 =?us-ascii?Q?xGngG+fyOgtHeRNkC1Jcf1iqyxoNaI8iAtB3m5is+tSfcx7kzUCWn3aowtiS?=
 =?us-ascii?Q?ksTym99VDTL96gaws9i9FKFuqp/3JQcfBgebpRk9kjKSKdLxdi9LysN97Uq6?=
 =?us-ascii?Q?wPXUelNLs9WNcWOthZi0UXjsAFd1LscreLlgidJuRzBl1vCU23CC38JbepD+?=
 =?us-ascii?Q?u4AgXd9+EwfQAh6JpuMrubaIx3wrhdDdoRERyBRuEplLCUa1LNLSvS3KXQRd?=
 =?us-ascii?Q?eXahM+w0bikkIiE18nG8XxQnXzFC4qZNJCqtR5r5pnkGlnXpqz1It892ps95?=
 =?us-ascii?Q?0iA3tiIlYBCCTqUOZB803wHECcd5M7q50N5bx1Aw00C7rAOI4gQ0E7EsEqpV?=
 =?us-ascii?Q?X4ohKQnW2N5eutBEEddAeCNJ3LYlkRACMM/27F/LlVnKc8IanyCvcErux/ZB?=
 =?us-ascii?Q?xT9Aa9G9F+WsCeIYkgMGHj98F5VtPXdwnm9nPR+9Vr2lqUOrnsFPVZ91CUFf?=
 =?us-ascii?Q?EgHro9dtSCDh/zTR/3PiQLyBPV4BoNqeYDiJ8yPdYycwUfiwYq6e2jUHsqwW?=
 =?us-ascii?Q?N5OXoFB238aSpp9+UuvgISunVESuDOAkPaPYqV2MQ70bW5KmlL2cCvzeW2/g?=
 =?us-ascii?Q?w/rX0mKGon/jHNx1cg7gqJMXg/XgybsMaxXLKl7E0BdWpWoqLsXfdDhGPWhf?=
 =?us-ascii?Q?JxXUeQbiMx/sQFrkeGEHW7vOIk4tCRJGH9LKOVkYKtTO8JMEepFciEEDzOOp?=
 =?us-ascii?Q?MWD5jIk/bV1DWQjQKBkj17p5LMuhFWdmuuzIf81GdIv6ZgKc0bSL4W+H4vtf?=
 =?us-ascii?Q?pT0KiuLAnIpUkt03G7B9PPQ1rkpUP68i4C97SCiLi6Dvjfij3isDrBRcxqcK?=
 =?us-ascii?Q?JwEf0iPqTePt/NScJG6s/pHylILmjBQ8cb0ymRktq3FTArZTzTsGHtfzKjqs?=
 =?us-ascii?Q?4rxEhUGDKhL69oc+Gpj4zNJvupf4eopj6mAULLdLtIzSy4KZRatAt/uye0VH?=
 =?us-ascii?Q?q1QQpOHj3UVg2CmvxqNHYxfcDVq3TSf90BC6A6ioz8kBlZdsToH0gppwPlrK?=
 =?us-ascii?Q?p1diUUiI3mrR8tClsDLo3OQ9vbTO0TqMK8f9sAapI4xZO9o26kqdZrFi/kGR?=
 =?us-ascii?Q?sbQ0A3RcSw77DJnQAMR/X6WPoa/9xiF72pmXlrtLtRyY80NV5Y6Q8rYgEB8e?=
 =?us-ascii?Q?9SGlysGMq1vW34Ujue6s/YF+Mj9tQK1bcl2h6URdWms93x1FBMfozNS4OGax?=
 =?us-ascii?Q?2tBD3IwqZODTyeFlpDbmFqhgfVVGz+hU21KYrPzAspHpcX4+h8ZgN/W6HNYQ?=
 =?us-ascii?Q?dNMEbkkUSFjwq34xmzqgNIqcTIOPD5MQihG9ok0MZZSJBNoUSC5uApuqxKph?=
 =?us-ascii?Q?wxaKk4XaaPVjXV7XzKVGDfRjZ2YTGqlRVIncm5hZoVHE4s34HBenZRyftYVE?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vdt6GWTBosRhs3rergcK1fETExhABZMsJcTLUwquu/VRcZCpx3oZWeVBRMZf7bLklPf9/4V1VdBDyBtXR/m9GoEqEQRYNu6tqhcw0xM3jhHoZTdA1vYeboQSKHUwwbopAN0JRBKFU3xK2Epv1ndM+1bXaqWuc/nvE0BNXILTyKlqHY3c2vmcZPMTpwEv32TDBcaw+6nXijcwySR3aVqIhgAWpUENgFQHig7s5hfxXFqezaLd74ECWE6nONvzwhWemzgBzlOA7aHpD3zZgoiqS8Re2cK6VoyfNB0ZdgycCy8DQk3ApblW6B3NCFrdn1oDZR3oW3z9mjKRsugx77QVS40wAm8BCa6sctJgExQ6hQjH/nKPqX4Y26HlmjXWELqcILhN83or+WojrtKpyk3zCU9AQjSjdzSal50gwOhr2Eh/5W2sCIeU0wuF3Q9avIO8DQWAQWJ0kjHu1BJTdb/29GWRrTbmVi8chFS0gwrmur+rVA01sAezPM8udQMON/XDZCqzgjhl6XcZnMQFRKn1Vj/kiGK6te3j6MsabotLdhBuYhJsJ3Nu4A1zjrCAPGJJ4RTEWuy+iO6P1elUTtVSPEBxcT1m+HIYrl5dftPhAPM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d61b55b-3254-48f7-c22b-08ddad054db7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 18:40:44.8757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQCvuOfZBQ8GP/3w9cO1kmRZcAvLHR44xRmKHz2/2wWy+hmFokiFSA2HuAIN1BENqJpngIomtCnZgq+p1Kuo2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8067
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506160126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEyNiBTYWx0ZWRfX7LHmUGGW89AO VEHEI5RLLTRPIrFcetw7caGN+5Rvx/80lsiv0rOA/z82ks0lNzk7beYLd1RQZfUwnKVEuuG5chm fJ8mSKVt7LPzrxxdA0U2MOAlBeRf+BNg2CFzJ3ahhZDVlp3e+UnLwEUXZ7rb5jNB7za5ClIxOBq
 epH/tDt9MHAEMPgWWgZv7VdO8o4YhuuBjLhSCY5WjeVNLobBR+L4xWKLfoGxGa8mQ7kyeB1MR9s ptBisX4pY9QFayiSMPDDTt8sIOI4gYL6qD+YNMBJu1Msb/AshxEi1I6NyCdzsuKAwTxq3UJodmm fTfEiN9S0/O9LEEy+T0yShA47lvmwa5jV4qAub75k3kBlKKSAbVjBqr/qgsogHVS+Av0DW9UX+e
 pPQy8RQzbGCgQFrfuNJjf7wAju/hs2mkmpHGvcONXQsUJviCgyFN4ybrIiT69csPeUKN1Lz6
X-Authority-Analysis: v=2.4 cv=K5EiHzWI c=1 sm=1 tr=0 ts=68506530 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=W8QsTb4b5T7U5S5YZd8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: fxUsg38aVPgQLKylRRn1OtWQQ6zXW2Xj
X-Proofpoint-ORIG-GUID: fxUsg38aVPgQLKylRRn1OtWQQ6zXW2Xj

On Fri, Jun 13, 2025 at 05:21:15PM +0200, Andrew Lunn wrote:
> On Wed, Jun 11, 2025 at 06:39:19PM -0400, Konrad Rzeszutek Wilk wrote:
> > We would like to have a programatic way for applications
> > to query which of the features defined in include/uapi/linux/rds.h
> > are actually implemented by the kernel.
> > 
> > The problem is that applications can be built against newer
> > kernel (or older) and they may have the feature implemented or not.
> > 
> > The lack of a certain feature would signify that the kernel
> > does not support it. The presence of it signifies the existence
> > of it.
> > 
> > This would provide the application to query the sysfs and figure
> > out what is supported.
> > 
> > This patch would expose this extra sysfs file:
> > 
> > /sys/kernel/rds/features
> 
> This should probably be documented somewhere under
> Documentation/ABI/stable.
> 
> > which would contain string values of what the RDS driver supports.
> > 
> > Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > ---
> >  net/rds/af_rds.c | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> > 
> > diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
> > index 8435a20968ef..46cb8655df20 100644
> > --- a/net/rds/af_rds.c
> > +++ b/net/rds/af_rds.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/module.h>
> >  #include <linux/errno.h>
> >  #include <linux/kernel.h>
> > +#include <linux/kobject.h>
> >  #include <linux/gfp.h>
> >  #include <linux/in.h>
> >  #include <linux/ipv6.h>
> > @@ -871,6 +872,33 @@ static void rds6_sock_info(struct socket *sock, unsigned int len,
> >  }
> >  #endif
> >  
> > +#ifdef CONFIG_SYSFS
> 
> include/linux/sysfs.h has a stub for when SYSFS is not enabled. So you
> should not need any #ifdefs
> 
>     Andrew

I could not for the life of me get the kernel to compile without
CONFIG_SYSFS, but here is the patch with the modifications you
enumerated:

From 46550ddbd78c878924e4398f07811aac63402ecf Mon Sep 17 00:00:00 2001
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Wed, 11 Jun 2025 15:29:39 -0400
Subject: [PATCH] rds: Expose feature parameters via sysfs

We would like to have a programatic way for applications
to query which of the features defined in include/uapi/linux/rds.h
are actually implemented by the kernel.

The problem is that applications can be built against newer
kernel (or older) and they may have the feature implemented or not.

The lack of a certain feature would signify that the kernel
does not support it. The presence of it signifies the existence
of it.

This would provide the application to query the sysfs and figure
out what is supported.

This patch would expose this extra sysfs file:

/sys/kernel/rds/features

which would contain string values of what the RDS driver supports.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
v3: Add the missing documentation
    Remove the CONFIG_SYSFS #ifdef machinations
---
 Documentation/ABI/stable/sysfs-driver-rds | 10 ++++++++
 net/rds/af_rds.c                          | 31 +++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-rds

diff --git a/Documentation/ABI/stable/sysfs-driver-rds b/Documentation/ABI/stable/sysfs-driver-rds
new file mode 100644
index 000000000000..d0b4fe0d3ce4
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-driver-rds
@@ -0,0 +1,10 @@
+What:          /sys/kernel/rds/features
+Date:          June 2025
+KernelVersion: 6.17
+Contact:       rds-devel@oss.oracle.com 
+Description:   This file will contain the features that correspond
+               to the include/uapi/linux/rds.h in a string format.
+
+	       The intent is for applications compiled against rds.h
+	       to be able to query and find out what features the
+	       driver supports.
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 8435a20968ef..cc9ade29c58f 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -33,6 +33,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/gfp.h>
 #include <linux/in.h>
 #include <linux/ipv6.h>
@@ -871,6 +872,31 @@ static void rds6_sock_info(struct socket *sock, unsigned int len,
 }
 #endif
 
+static ssize_t features_show(struct kobject *kobj, struct kobj_attribute *attr,
+			     char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "get_tos\n"
+			"set_tos\n"
+			"socket_cancel_sent_to\n"
+			"socket_get_mr\n"
+			"socket_free_mr\n"
+			"socket_recverr\n"
+			"socket_cong_monitor\n"
+			"socket_get_mr_for_dest\n"
+			"socket_so_transport\n"
+			"socket_so_rxpath_latency\n");
+}
+static struct kobj_attribute rds_features_attr = __ATTR_RO(features);
+
+static struct attribute *rds_sysfs_attrs[] = {
+	&rds_features_attr.attr,
+	NULL,
+};
+static const struct attribute_group rds_sysfs_attr_group = {
+	.attrs = rds_sysfs_attrs,
+	.name = "rds",
+};
+
 static void rds_exit(void)
 {
 	sock_unregister(rds_family_ops.family);
@@ -882,6 +908,7 @@ static void rds_exit(void)
 	rds_stats_exit();
 	rds_page_exit();
 	rds_bind_lock_destroy();
+	sysfs_remove_group(kernel_kobj, &rds_sysfs_attr_group);
 	rds_info_deregister_func(RDS_INFO_SOCKETS, rds_sock_info);
 	rds_info_deregister_func(RDS_INFO_RECV_MESSAGES, rds_sock_inc_info);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -923,6 +950,10 @@ static int __init rds_init(void)
 	if (ret)
 		goto out_proto;
 
+	ret = sysfs_create_group(kernel_kobj, &rds_sysfs_attr_group);
+	if (ret)
+		goto out_proto;
+
 	rds_info_register_func(RDS_INFO_SOCKETS, rds_sock_info);
 	rds_info_register_func(RDS_INFO_RECV_MESSAGES, rds_sock_inc_info);
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.43.5


