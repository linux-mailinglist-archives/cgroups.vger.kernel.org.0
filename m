Return-Path: <cgroups+bounces-14750-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMaPMUXQsGmLnQIAu9opvQ
	(envelope-from <cgroups+bounces-14750-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 03:15:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2721325AD2E
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 03:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F306310D6EE
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 02:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE5F322B74;
	Wed, 11 Mar 2026 02:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NEoNWLtT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iFC+1+vo"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567172A1BF;
	Wed, 11 Mar 2026 02:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773195231; cv=fail; b=ktr4PVZHtJj/UVb6yxf5dLeQooWtVXVTNhwz4jcBp8BsYBTXiziqWkfgRCKa7hTS6PtfqRlBtGXITrF1PJKaNrZpK4zW4BwwwtNEqaf1pGtL7mMHZ5DwFeFjy9MIIb5RGhyWO6F5IA0H/Mi+NKI7Lv8p0RlMSRhmdObYDAYGL+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773195231; c=relaxed/simple;
	bh=PMuYtIVxFN0o/1PI5C8uqlEwyHPzU0Si1v6vEfBE5Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QdiDm0hyMeZpiZuiL6jdqUy0DXMNnUGWqRJVIwtLFQbsMkhBGeFE3s7uwZCEEQaFYOiTft+bvxQMQGip6XXCp1qbixxwaBl0anaC9Kj87ok24Ekk2XAIvd56hXSSWvZ4TWrEyHt528IqOADa0S6n8JBYO1d3cbFIe3rCIPPT2cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NEoNWLtT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iFC+1+vo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AIjwDT2344167;
	Wed, 11 Mar 2026 02:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Xs18TDLVLW7JQO/RnF
	Plvfa1xKotWphcFT0nOD5Heng=; b=NEoNWLtTdh3ngcLtnLBS16DNW8yei6XBcE
	U4DOhk+vPMOxe1zldP2Lb5qQO822C6FCp22aC0WiCR3Higw24J5JKBo6ZITC67as
	lAEeVJxTRYabfRuYriAu5/CTSjEzBkMP0wyT5YA1c7//BJsSafsTCWaGnIHYnhac
	XjwiFGlC5sWHgYgLYAwGZtAthFPbOgGNBIWKrs6vRJQgv/1DhrpoJ/M++rE0hpoN
	YGD51gEQkdcKDez7coNY4S7CoPmGoyBbt8YURIwNDyXaOQ5ll/Esc2AxncH82fwI
	OHCcobguu3uXmMNGg1dZhgv52/4w79kb1bdNNVGSqpP+61B+KWMA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csks2m506-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 02:13:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62B0Smr1022742;
	Wed, 11 Mar 2026 02:13:30 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4crafawhqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 02:13:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ed18MaZAbvGoheDuu9hgjX1TymAZhz5QYemAD1sEblA9ZurgbPCk4bDOqqDTKigjdN/khQ8diNnt3SHkhCekUI+/Lrch4bY+j942kmoc6HnFlMO2xnPsg4nRutv6jZAf99xNiEvCud/1WW+I8X2byer89xwElYybogcfiSd0KDJG+/k5xvyopZkPLyLfE++pjKfv6rbrrS4N6G0BvsL7d6WK3wKCny4XJmJpXa4LqPon/OoB6/ULKty/s7fFQbgcO7Wr+bJXXOHawP25VSWhzD0gIwTzF3f1nYi0ROiNbMWWzFqBxP7mRe26nlJ8ROwoCiYrb2XQhZJ7BLccEDAyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs18TDLVLW7JQO/RnFPlvfa1xKotWphcFT0nOD5Heng=;
 b=nsWWkorbDsAD3eWZ6iznsgVtw6eWpDR8gYF3z2Av3TDmnnkedmVp/+bx2WOj76K17g1FvN2OAJ8x/Wo624VcfUex6LECGEcqmxlbxqGe2HvFJLCC6AX1GIfkRQsqPQ1g+rZ8aoEFYSHsxT5FkkR9GPzr03gsbMoF3wemiZPQgpImfrkOzSYqbdK0RkFimjm2v2cAj9Bms8L2WtOixOpyE0HwIumVIZFFVyNXEwDGV9UfQPLjyZdmpI6mdKrvDXuuOEQBNDa74RkXZS0/tUeo+AKFjl2ZYcO+OaLC2Er6bIQgWibhFbj5QJCCW/vVWJbLpqqx9NFfkjXTy+AIsyQPhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs18TDLVLW7JQO/RnFPlvfa1xKotWphcFT0nOD5Heng=;
 b=iFC+1+voLc34tKb50/SQbTErdzxpvi159s+nbMxyl95NUVAjtV9lSpk0XDpulJhwCvklTaVNwCzrd/kU8MKufUjwr8pDTNXp9QcsPbKh1BK57NgOJr7xtEuJMXi+MfLWQPf+aTCUwdKiam2Gy78PbHgcR89+OEcmWlEAuwztDEE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB997624.namprd10.prod.outlook.com (2603:10b6:8:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 02:13:28 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 02:13:28 +0000
Date: Wed, 11 Mar 2026 11:13:18 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: ranxiaokai627@163.com
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeel.butt@linux.dev, muchun.song@linux.dev,
        akpm@linux-foundation.org, vbabka@kernel.org, hao.li@linux.dev,
        cl@gentwo.org, rientjes@google.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ran.xiaokai@zte.com.cn
Subject: Re: [PATCH 0/2] fix kmem over-charging for embedded obj_exts array
Message-ID: <abDPvjUld-2BTpRa@hyeyoo>
References: <20260310113804.245647-1-ranxiaokai627@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310113804.245647-1-ranxiaokai627@163.com>
X-ClientProxiedBy: SE2P216CA0128.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB997624:EE_
X-MS-Office365-Filtering-Correlation-Id: 62088288-0263-4e9a-6c3e-08de7f13c875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1gYt9uwNC7gXEcDaqqtVxG6ovL2WS12K5oPiTJPu40ImHYddq93B/A0uB8hnfx0QGuyFaq0sJRYPaw4OeHlWlzUDHrf3lNQqJ4I5kH6A3O86e5x8ImUi2F6j2V5+xk7q/o3J059mwaERSI69j/zHcKW/90WtImRV3aXIEU1Ud6Bz9fs/Z86G5ZEgabXhZm61+BQJwT8Pmg+aifRZ9+6eTNM1Ka8XSHas4ZBon2stpz8k0zFEwnxwdZxu1jRDrkrLxmFHNhlFiqDUD1dqXt7Wl8ZxRZgjgimtyCWmZAic1whF9viI3nrFK9XjSRZjAbNoZTljc5S0keQZww+9jY7rKufxBsult1vYFYH/jQcVFpv5S22zR7L3z7SiKjcSNch2/TOqoVy14txZReonz3Gx8sdL+RXr4KerbTetYh9q3Jfq9kLYXTE0MCUh01wSsssgQY0gDNHGTrDlFU7IDL1tB5Xn1+Y5IbEZnPE83UtlwhyvV1lW4DrNO9cT4gEny4eR6oJVfQ6xuQfKgYpifREUiHlr+yxm99n4kG+gi2huRsSR0AhU9AHaBhrQpZiIlp0FHysjmXQYWRIL0K08X8DaYFxlssHU/fP0QMx8IsNkpt/zMMqPZXhozXAfkN8nqZ3ML6prCajdFQP2WcVLcaUkUy6gBkYPbfH7qqx4CdXZ4CKRbDSVR2Tqbem5jX5HsqWajMCvewIlpf6a4KKF/9tAabsqfzyVLqZzSH9Mr79JsYg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gxwvu2Do+YvzmPWoXGROPVrJEl9cSoVT7DuIIFCQzYGbz8nFTaeGYDxTz04p?=
 =?us-ascii?Q?8AuAF6v9adooFglU/7fX1wOWWDnZKAXfBvxADhzlP2eNmJI8dJSMFukzx4Hn?=
 =?us-ascii?Q?wkiwIVvwXVuWlhmMJrGlgON1DWoYFT+EuzF7tTFqFVhMgiLsT59/7wPZq0Mk?=
 =?us-ascii?Q?Tb0XTf8QV1KT5gyeIBJgNfeN1muapHKiMa+MCtDDS4SpR+iH4epDH9BYk/gE?=
 =?us-ascii?Q?oeVSjwwSCR/MBz0nZChwAk6jBPCzm4Y6PJjSVjRxZd7c7+eCzN7usSI/7kIO?=
 =?us-ascii?Q?iz/K6IHhXh+ZKtSwZFkxGmLs4DeWo81Ppv7UQXS3ACzZDkJX2fQDqqVQZJZP?=
 =?us-ascii?Q?X506/UwJ5GyiymmSYFFbaXOhNi+bldckzQFHEGkCSgAoB3NLLLaQn3FpRaPY?=
 =?us-ascii?Q?5cRgzhrEc8FqkBJiYZwoGAUcfE6K7tkKaOvnyN64mQsp3zUY9Hq07RZbG7ML?=
 =?us-ascii?Q?/ymIISelBwqU9bxxS3xIv2lFxa1bkIc6SjLTR4gU9Zw5RZecMtjarrLs+6xN?=
 =?us-ascii?Q?NCNdaQhpl/TotA6C8hvIfpn4P9FqnCSXLiUUUrQRk1ZYQdvsW2wYAqsrYUGb?=
 =?us-ascii?Q?uYVGKcMS/0qd4pqQkBgDTKxUq75+fZah9+IQZDi87edmw8XHAB+wb1x5do7Z?=
 =?us-ascii?Q?fmFHDoWp1OXfe/8AkKdIyIg49gae8lLVOHEuwgpugPhkbuBAhiLbCg/JD9p1?=
 =?us-ascii?Q?kM+Jp8V6149TJZ0GwPq937XC+bI0rPmf+b3m8O2rqQrxR8vs+FxDWQvXnYUc?=
 =?us-ascii?Q?j6y/hK8fo1tI8rZ6o5dRWt5hfUNerF9MJZAzw1be+eoxlL8d5vWBTCKc5EvK?=
 =?us-ascii?Q?V6d3FxgRpZNrw27lwwK4DUWyO1eGOpCJUGS9+AJKif8fQE2sa51SXcFpvMTv?=
 =?us-ascii?Q?qP6S7GZTlt1oeOeBsB/woel/FwODnwO64bQxYQeLCLcNIVn05bazf/NaAnQ1?=
 =?us-ascii?Q?KoGxLTWSvBf0uf2IfIjswczevN6CGHZd20sScbXq2wPifsHHfubneHkyfQH9?=
 =?us-ascii?Q?cfZHC47zhoZa1+NfJKVrhgM1o4roe0EzGYFtMCxZnWEQD8UBQSl0CE6i3O39?=
 =?us-ascii?Q?FgCUG9uQkQ0bmzqaBHYEYJNJPox5CbLVdCWBc753MpUlRCoYY9NwCw48KIYS?=
 =?us-ascii?Q?mo2OvkJhiy5iAGTmCVmLCH1+UslFet8TbECzBjA8bqT1ynvA99R5a6Q52aYu?=
 =?us-ascii?Q?ughEjZ7WV+QashqRMdpLyy5TPOqDJpyqveE3Hr8ZW1gWDPPmCoBmXuYsFj2m?=
 =?us-ascii?Q?dpMKCgqAlKT8Ba6HL69LwTgaapWfmxYupiwKQdmpgEBsw1AdlvpBNlgLDv0p?=
 =?us-ascii?Q?Rj1uc9ROAbADy+0AKy871+rbdOaz4irJXWtOU5unsob4poSOkJjqITREsjjC?=
 =?us-ascii?Q?GUE/+48MXja+wN+KFAqPLKOT2Q3OQgsfefnzdS8+kDBoKHkMMZqOYJOlOCdi?=
 =?us-ascii?Q?LWz8AZPgXNr+sg1VxWxtt9fbpzJfovzCAK9Tz3U+ahQeeT/HGdkwi3rC8HXb?=
 =?us-ascii?Q?x//0eK0keG+9XPXbK19F+A3HdFyB3X4fHYr92HHb2/0IqogNrPlSmsI2f0A/?=
 =?us-ascii?Q?VMS+Dq7gLSQVl/YpAoN+J/aCNd/YP8lrbrBMquFS24a1QLj0ePlDuz3L7/YE?=
 =?us-ascii?Q?VhK0MJFW30ZEoXuoHKqGDvq906raSCoJZkcf+U6or9L+BbXU+EGdvKWWRE5b?=
 =?us-ascii?Q?6ftiJtTnIBhpWZpgyJh3PRr57EYlYDksYDr6W32HeSle96gJs8WCa7NPHiim?=
 =?us-ascii?Q?7pXAnDXrpA=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	JdMOXNr0n4ux12ymRYx+4An19yg0ETcP8zqABtrJEqXhSWPR4yZZlK8YrgWp9IwlyXcMVrdbxzxrfhA2/66327UrBz9MNFSrIvBqMN1AaqgvnzSgtX9NS1NLXqYZ2nk7zojshsIfgyZCiEA5Fvgi4jDqnkr1c4FCstjA58jBzj3K+9IVDNpPlUASihnIargDwW/UpuYCk5+DHCDlXAKcs6esM/IObg6anO3m3rIrzoTEZu+6B3zkl2MCX7ArpdkCQ0CrvbayJ4XAkcs5pBVUHDqNN5TLIBZq0MwxbcFGZENczJWvRQZa1dFu52TgxBkVJ7RHZwCkgkWw1MloaDj50Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AqyrI1INPrMZY4ToJ9CIaH6GpDrduIZ2KsZiwV9fdyMDQnIGs8fgFlW7ICBOjIOnPcW7n8eXdstdPWo7l2MsqdhWsPWVlbK92y5soCrKZCcdGsImNGkJUm8if0tcF25C4osrcurRVI7379yVwS22vIyapyucy9IXrNzRNEL2BR/f6F979qlUfQv5pvDPf6DpBRaKOK6GcY2M5cn8FbBNI/KDuAkTITGiDWAkgWSCyTYxRM2PMPrhAY9AhK5PthYLuFsrzOtDYGSn5iBIVAjoJl9sf4oSTiCg3o4ODMa+mZICQ9Nz61ubi+vg2H7oE0jLOiCYGJbXQuUX/tAdJSjC+Hb57LMJDwnVJD3DR5B1CXTxfnyzRH7OOyAU/CKPLfSErnB9l7OM/sbf+arje/eoPV4UrMStuH1V+s5vhlNkO0ayg27/9z2VMSeeNBkiTA8btjsIgkjW9ypEscnppxsIsL9mP6N5A564CmSyJS6Xb2vG0bddRm7ZW3vyJ+rX4o1AEEyvQp0mZg0MsqWwv7GdWnWIiWQPwUmeDSNMkjqyLmNkSzQeoL1CuHIgB8dVgO1UP0PLxtNiO/YUlxSZ4KqBpZlWG73LbL6w1w2uxyc+rm8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62088288-0263-4e9a-6c3e-08de7f13c875
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 02:13:27.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHj66aBxLjbVitzYtNulHxTjR9CH38wrH+ir1hmpDgoibXLaAzHITTcS7jqjzhj/eqPVnA+nhlMhwXmtEBsq6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB997624
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=617 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603110017
X-Proofpoint-ORIG-GUID: SHALVD2rB4IdC_3uk-OxZRkmii8tzwkF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxNyBTYWx0ZWRfX2yeKGtLNiD6S
 ro9YlCyyL8QKyyn/g4Glx3ORgQdLsp5f2gjLhEkwPPvMfBF8ADze0rbZ0SMDgeBiws3RMUa5KZT
 1Yn2fhSyQBUhXIJKtAZV2wtalE9VgDxRoQW9ZWj2EO/ny+s/4iY3qVRvudTFqAydbcfeTeDjnLv
 NqR3/a/zOz2jFVuQ/mQDN99CMUzoMjCeZ7OUKcjM0tt0106DgN/PZpGa2ryO36NL5YTO0oTZVE9
 xFWui2ofuhuplZ4ws4VHXpBoJRXK5493ozjSHXh0Hnq25MXKMGwSS/YOIzW8kwo5LBsxGfO1orf
 ZlHnd7WfSKYBvEd3AmBqf1e0gZCSnLdTDSgJAxZTXGgOmBAm+g32LknZJFuzv1hgfXoq+MS0POW
 zEFmhu22Km6zIbJ8c/oM3Wv5pcxoU4v3nC1lDSGCeQF8mWnDXI4mB1M9E7R5fnANkiMBlS2p6y5
 sdkDv/yMhaVEtptYLuA==
X-Authority-Analysis: v=2.4 cv=S4vUAYsP c=1 sm=1 tr=0 ts=69b0cfcb cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=Byx-y9mGAAAA:8
 a=1RTuLK3dAAAA:8 a=T-E_Pbbg9PluJqT6cpkA:9 a=CjuIK1q_8ugA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-GUID: SHALVD2rB4IdC_3uk-OxZRkmii8tzwkF
X-Rspamd-Queue-Id: 2721325AD2E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14750-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.onmicrosoft.com:dkim,zte.com.cn:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 11:38:02AM +0000, ranxiaokai627@163.com wrote:
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> Since commit a77d6d338685 ("mm/slab: place slabobj_ext metadata
> in unused space within s->size"), the struct slabobj_ext array can
> use slab leftover space or be embedded into the slub object to save
> memory. In these cases, no extra kmalloc space is allocated for the
> obj_exts array.
> 
> However, obj_full_size() always returns extra sizeof(struct obj_cgroup *)
> bytes for every object, which leads to over-charging for slabs with
> embedded obj_exts.
> 
> This series optimizes obj_full_size() to check whether obj_exts uses
> slab leftover space or is embedded in the object. If so, only the object
> size is charged. Otherwise, the extra obj_cgroup pointer space is also
> charged.

Hi Ran,

At first look, I'm not sure if it's a good idea - although it's
allocated from wasted space, it's still memory that's needed to
charge objects.

But for "embedded into the slub object" case, yeah,
the metadata is charged twice, as it's already included in s->size.

Not having much expertise on memcg myself,
let's see what memcg folks say :)

> Patch1 moves obj_exts_in_slab() definition to slab.h so it can be
>        called from memcontrol.c.
> Patch2 updates obj_full_size() to avoid over-charging.
> 
> Ran Xiaokai (2):
>   mm/slab: move obj_exts_in_slab() definition to slab.h
>   memcg: fix kmem over-charging for embedded obj_exts array
> 
>  mm/memcontrol.c | 19 ++++++++++++++-----
>  mm/slab.h       | 19 +++++++++++++++++++
>  mm/slub.c       | 19 -------------------
>  3 files changed, 33 insertions(+), 24 deletions(-)
> 
> -- 
> 2.25.1
> 
> 
> 

-- 
Cheers,
Harry / Hyeonggon

