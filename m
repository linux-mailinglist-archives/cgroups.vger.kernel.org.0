Return-Path: <cgroups+bounces-12580-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35011CD5BEF
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 12:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DDB4300BEC0
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 11:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23341313E36;
	Mon, 22 Dec 2025 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZuAaUSeH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MxJ9Xbrx"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DDC13777E;
	Mon, 22 Dec 2025 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401781; cv=fail; b=l78LsDdTRhaEy1T6icdthFxqMZNtrCFweQp3X2zWyWUjboQNtHxHWf1OTtfB/dJf5oHNxqM+OGmQuSy6+m6fmzWCpjkTndqWU+35+T2WYAWF9LKHOR0mW+ts75YXatZb2ZPP5vEFBDoVAX/xY+buo9PRlWItgOwPmAjuVQpj6QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401781; c=relaxed/simple;
	bh=WdiQQHYX9jlj+5jbO0jhAP1qqG90Ht99C96LNC5p7o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rNLyRhTFFNZsblh6aOFFP+uKjOp3QqyyaaOx9/6INJVAy5GN0ZHyNdbxFGkN2QDFwHkEh3RvvsVhroI5KRT/ocSXcxsPcgE68nKd9sYCHYuF1VT3gLkZ23RzfG7ZEdXPqLFB/je57xwkjlkPOMUfG7ChJf5v8oUfh+aKgN8FApY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZuAaUSeH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MxJ9Xbrx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMB6emw2056286;
	Mon, 22 Dec 2025 11:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nmT2/eimzYvizrkfiSI5RtuA0QTDsOCdCd0UhJgGl2M=; b=
	ZuAaUSeHQlWSm5KFR/hToHcnBGXIGTAWH1z7cpXKCjstfaRQYT5LWhpqnYNU6vwr
	BESPEScbPM6tJg+dGURe0S5DNjwbOh4QldnVc255CNUoBJ0EXrHKzqLUMbPeS9zo
	26C6wT8YI74kOTJcQQyAvmI8z/9+X8W20ATd+lFgutKWC/y2x1y0w6WY5rEVO6E9
	3hGCrCucimwyjReZ0CYPBynGewMvQoNxzqj/NPbU5SFkbs5+AhPHpxggcoGP/X5N
	Zf41XnUKKaqcIMF2oEMZkPfCyFMIuPvxpcXT4WPcgEGqRHZ3qSuyBRVso3GC+rE3
	5T5um50bTJ5dyDOfkuSUuA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b74ttg0bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 11:09:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BMA0Bkk002534;
	Mon, 22 Dec 2025 11:09:12 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j876mnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 11:09:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcWrDzljw6uMPui5vruHxOTQFbkpf3cx4Yt8jJbMeJFKrnnxpKFVXwNh/bF/kEXw28blrVlcbPIedrnRTFMrZ1SLzq3ckNDlyRV4atJSasvSAPmI2yjnRuvgKx/nJhm6uKN19Fg6+5Mp6qEIJOcUCEaJyYnXiNJb0qz0kjzBH4hwU8IBKEguBQ5rYZzjgfGi05OVW8OsKV2hRZUccNPzgSQUm0dYG13pxnFpYHJ0BwLB2NTAF3wZ6Rh3L+15orArJKQ0EzYN8xhL4GFwDL0BHnf8O6t9N63ZxZuiM4o/t0ShNi5oXDEt6XK7FqFOImXVaC4QpiAlGxCH6qAtCHlDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmT2/eimzYvizrkfiSI5RtuA0QTDsOCdCd0UhJgGl2M=;
 b=TkH1hakDCsAh9RfhQaDcrydL2sPWHN3MvXeueYpab+d/PheIx2uJNMXGrruRkSCeM+oMKlDTEdiAUz/TCOl/qNZCrjnZfpsXzE8u2wH877/iwElJQyVw+syDsRFaxwNzO2MJjU1Jc6/gwxMU6hcQoDh7dAwbdsr1okvbk6C5OWUKNLnvbYxc7HVeN5/kQhrm3tY8yuTZ3knX4J5sbjwdmj0UEIv1LD5A6oTGAdTns932RTKzBZyBX6Mse0zLH9Cg2L6iIMCxBFSqG699nwlsuHgio8NNECk59UpVGrKj4d0z6Sc70KMeHm4zStUf+YCGcH8tWcqmGjqfH1aneFeVRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmT2/eimzYvizrkfiSI5RtuA0QTDsOCdCd0UhJgGl2M=;
 b=MxJ9XbrxIuDAoBjQKR3ZPKPfRpwrHwf+W07gJ3nu6iZ/wfSalb8zM7+xgahgyu82fUBcY4X9vCHs9f5SwZok/CgXzOa7LX9Emb6n+BBEw7kgXvrEy1cBngyK4GRcWyuiSPe6SYoqF9u30eqTkGKXw6PkmghNyQDDugr5kJPfiiY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4741.namprd10.prod.outlook.com (2603:10b6:510:3d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Mon, 22 Dec
 2025 11:09:08 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 11:09:08 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: akpm@linux-foundation.org, vbabka@suse.cz
Cc: andreyknvl@gmail.com, cl@gentwo.org, dvyukov@google.com, glider@google.com,
        hannes@cmpxchg.org, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        ryabinin.a.a@gmail.com, shakeel.butt@linux.dev, surenb@google.com,
        vincenzo.frascino@arm.com, yeoreum.yun@arm.com, harry.yoo@oracle.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        hao.li@linux.dev
Subject: [PATCH V4 3/8] ext4: specify the free pointer offset for ext4_inode_cache
Date: Mon, 22 Dec 2025 20:08:38 +0900
Message-ID: <20251222110843.980347-4-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222110843.980347-1-harry.yoo@oracle.com>
References: <20251222110843.980347-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0147.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c8::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4741:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fa5116-fa2b-42c7-8e69-08de414a86a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3ViaP8CAjojp8Uu9KvTvwzkWVvy0+h6ccdtKHIZE3MP7OVHZCq9nUk3dkOCu?=
 =?us-ascii?Q?FIhlpZWKG4/1f2uLptI7W91SFi9szTBgKLVTHzTjZYbK0/OD9xdPDi+OkLOP?=
 =?us-ascii?Q?h/7h9BeLbNEBInRfnkSYuOD48AkDj6HsQ8BONTpv2jxCW90J9KdjLE1Jv3sj?=
 =?us-ascii?Q?85ZCDiGXospgGORPPHNj8ju0NqbbL9/GKuhEZLlA/XbmgD7Qp7+5hVn9ExWU?=
 =?us-ascii?Q?zm/6uuohkBnEc0Q8OELVOE46wsP9DsRKWOKAUANKGPBBV7WnkDH1qlWcEaov?=
 =?us-ascii?Q?AI9j4zr96CrZLap59RsZzyL3KqqMUn1XZnUL5L56A18iYSBjxW0TxYuLfss8?=
 =?us-ascii?Q?bkxsWwKQokOHu4N1eZeXKTe8v46Km6kXSQBt14witiN7C5NSOMb8iKQG7Krd?=
 =?us-ascii?Q?Del3RiI0XTq3p5a6Gx4bQQBZt+aW3gV0+Mutj+T4GUfxK80OqE7dNqygizNv?=
 =?us-ascii?Q?ZdKZ3uAFMp8rQIiVTic2F6ShCVYj1op4Me/bGgVxW351n+izPPW5RA6pkNjH?=
 =?us-ascii?Q?QHGEKM9kk0MjMod1vASNmLAjsk3Ke3VINexyo7qvekKJGl6nQkORrFZ/KIay?=
 =?us-ascii?Q?Cya1TWe7lBOgk36V6vJhwqjNgAy4olluZ5tkGeRnBSA30/hCCGhmJT14Yvvq?=
 =?us-ascii?Q?qjIycd7g01yzeOuVuV4VIZhsDR9X11fE0AY/lVyFzlG8e4u5jQouvUrFaXVX?=
 =?us-ascii?Q?wHc6fdB9kgKhHOgu9oZ8Kx3RjhIH4qty3FuDZT+kc/nFNCW5PImzeyl6F6jP?=
 =?us-ascii?Q?cg/bciVwHJKl+50qIXcd4Hxlho/cync4E5QajWu1eofQdBF8u1gZWGXWjPyV?=
 =?us-ascii?Q?1mM4j2LoheuCmfNfPufC+8APbZe+ZIGctRwKm+L/p1h4fifDEWo6tiaLpnQ+?=
 =?us-ascii?Q?4a2hbAAE0IGMbkB+85/ldR2EdNmrKORV7RaTk5MxoXwF3PxCx3KcjLQVjX4d?=
 =?us-ascii?Q?iw2d9ONGUdS0HK+aEAcb0nZp0jlJUNBDjZUJPM+KWHKg2L8+MYMBJGNIiizb?=
 =?us-ascii?Q?FrAn+s5S5dg7E/yKyb9F+vvZcKZpi4q54DqZYrv216iu5ZWB0pzGq/x5YI4Q?=
 =?us-ascii?Q?/cbi+9R0TUSCG3Z4a/77saAykb0cUChnBxcmYriMWjhM31Xjcz/K6Ygjhe8C?=
 =?us-ascii?Q?A0iqyPUE7X391M60wIEIJI0CCC6eHpRtFD7Y2A5hJ5IEPpv32D+Q4PckecTp?=
 =?us-ascii?Q?lyDAiXNAV9KH/Js0bE5kqQkbqXlUFA2AeY6gS1+Cu/nfLlqD6QwjDik/fQKd?=
 =?us-ascii?Q?oLqhZBGGiWq1wEGqi8Fh6geYf5ezb4Hmz0ti0aliXsXtR4eSigDuyiGTJ3OE?=
 =?us-ascii?Q?czTXVLNg+KYE6BXTq+GvhHrNrezV9Wa9yFt1RB9xpV6Iep93SCABRh4ytYUX?=
 =?us-ascii?Q?xvYOQ06yzLTSS64+x+G5qOX0Q1qJuiHeYGHEtpXjGr384NY4N+juQmzpJ0Db?=
 =?us-ascii?Q?F+R+E+c5VgDKn9PF1uKKUQVEzfRmiRyq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GFiVB3bKn+TrLP5W9+MHDhmlr3/ixjyt5hntHfsAJsLp7ONJ/qy5FEks+l+q?=
 =?us-ascii?Q?dxw0ckDl9qQWu8sBtOW4KxEfM3tMxoSLrpM+jkhNEnthaF0yQuGcPX9nwX6F?=
 =?us-ascii?Q?ZgqxQWEDW89DqB3t8vMqYztVkBqe+2unSVBaLGzZBVoQfA5rRHk4+AeinJQ5?=
 =?us-ascii?Q?Bh+ky1vwQ4cQjJ3t+kqWhXsN3HTVwU4tLSHOVxV2iBB3XvW49kw48g+xNBwf?=
 =?us-ascii?Q?j5V0UQr0h+3zlzBO6JtKN7ts6FkAUd8zz8qRKfEPz9sPCg7A4TKlsiN13skQ?=
 =?us-ascii?Q?tTcrjRkV/LX3ytuIzntzpg5E7bcUJtr9U2hXaGQg5MKixHRmhR1RbcNZNR45?=
 =?us-ascii?Q?AiderJNIauOryyVYOSxCtnczTfcLXkso2Dn/JZCY8PPt2dwUiRW3aaVeKcbM?=
 =?us-ascii?Q?BG7oJ6RGcskvHCGUKxcfram26fZ+ABN5WtTJqKs6C6LY3Xmo6pFRALjLF1VS?=
 =?us-ascii?Q?fRVR9vSFFmcFg5rUIh525OEw//aVhZRN9PFRtZqFse+n9iSov3dwrYJxUbBG?=
 =?us-ascii?Q?y9Ng9UG3wjtqvz0DhYWv1+2dOafIMrBnbI8+k8qUQeYqh4WDyNeArw1fjIht?=
 =?us-ascii?Q?TDcB8v0cB5GVkns6GIaROQOd+1k6KRBGK7llnjy/xiQFEoPJCq5MUNSCZFIV?=
 =?us-ascii?Q?ybhFg81gVfBlKonHGIE6DyOX4QQEQttKzimQ2jffRxTZ1IWZ6zG4Jk+HxtQg?=
 =?us-ascii?Q?MS53j3T7hnS2ZN8kB6qLRJe3FTcDC2on9R/FDjGHlCw0+c1UbDHe+WEu2VEW?=
 =?us-ascii?Q?FeQiHJAAAzubZ86uquez3S17ZJz+2+vdz0lxeO3D9PqoIG4GFP5rcvFs268q?=
 =?us-ascii?Q?COvPaE+9NlBLPi5h9vqQ/2feqS5MAUKQAv/EX7w23c7TJS7X7c4QU3hRM+2M?=
 =?us-ascii?Q?GyWR639XRosMWE95YAdF1JDsP5IL7cDW2CBR6lcBEp+y0QJZXCLQXHRAbNor?=
 =?us-ascii?Q?kdzG11pY+CP/xK2DX1JgcJ2pUzWMwmIkG55N1k5eLONU3eRdo9ztAXatuPMZ?=
 =?us-ascii?Q?XgkDV+2W+u2QcoJl+sOrA5MGGe3d7upIr9r7uaTWN6Fs2gyPGcHkX1ZD55e3?=
 =?us-ascii?Q?VBLwgKJJJzi1Ol0QnCE6iKqbdI+50i8lOTbx+G45riN9uh3aDTpX0sKDnlib?=
 =?us-ascii?Q?koEKfjIFkURk8c+8Zqq8f/46siFJ+nUI85WNrYQRq+XglZqO9ysVYBo/oZ4A?=
 =?us-ascii?Q?XrpdD3T630AtuoCWHn1HlGGUjwWQjUGmoeSHgniMBkHrE7SsRonDJq/Zev02?=
 =?us-ascii?Q?o1pQlmSir8q+tUTKCRxSSHiDeTHX6TIMIDdpm+c5njgRp+zQk2cxhqM7Y3gl?=
 =?us-ascii?Q?jmeVU6Y2ADXF1M+vyg7yTUcsuCoCf7+dT7+gb4TfMikDTWizzvWhyTGSMCw5?=
 =?us-ascii?Q?IdqmQAtHqpFPDBIsy5Vbea3OiYO4LvVy+ewLxvRfz6dyiOpjKvRUPOrcZu+I?=
 =?us-ascii?Q?K+ImWuyfbBKPgw3BeBDuAmj/XcAxai4xNepUtcdDl8ni0rc7BcQCT+LMW6DN?=
 =?us-ascii?Q?IZkAWrVGqDHwq9l6bY3QcDuORzFi4SG/1v5QWhY52GCLTUd9H8756S/y7SBq?=
 =?us-ascii?Q?DmjPe/K6MhqFh51co6MIkHB9TSMfEKjbM5ugJok1qBAfssak84nDlmFYuzBB?=
 =?us-ascii?Q?UC1IytlCeUhUhWlIVp5pX+traNP8qAR83z1AhD7NZysfaDql575zqxT+rWl3?=
 =?us-ascii?Q?NnY6egPdBZsLbb216uEB9b6lTQwlvD/6kCqbFDWvkTrEhIs8AE8JrjEYffVE?=
 =?us-ascii?Q?qSR+HRoMXA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jTYz/GDLk00D1L3SHXIka0KLNi7qxqlyUgn/YHdBeGgViJ4WM8Toks56KZ/nWdvXaT7QhTiRiWfNdcMSW/DB+1SikixPRI3J0kK3jJ7prNUxaKdapG0GeSpJyU/xkGAaU/c0zjnlN9fCB5Kl6VlbBUDTjV64bY6qr8M4OtzQrx+NTGNGoySMML5eRmMgXoYf8GKm7hn7ahvUAtExNAs6AMIFcaJw3dA+yKDdf2iCpYt7DzwDUJz5J5QU6WCNP9rBP38hF19t5hbnXxuKnXd8CNwCroyYl1Hn0z6Z4/Kwsjv2GHoGblm425DhdP59p6eDjddV08wsbQ6CNOPerHTJQFAeewq2ANPiAzcr9GcXvQ5AiYT7dZHymU7Y5ad07xJUP2V7VhMPER+no9lX/8FT9yaMI/hyZd9mC6Y2Mwf/O4X2EVkjMonrIL8sWUaQrlSRxordEdVinDreNWlIjIJUVTRFWLnUyXL0benw6ZGVH6EkwVWTdAlRQ/0ueFFqPz2YpnIuO3CuiBGWACNOoy1umoiZaj0rhInyFkPzMHqUAVVgLzOSWAY2MT3rgeHg6Yu9sDT2V/uYBkhNwVdXcOgX9fOuD363Zy/ImXEzg4VGEU8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fa5116-fa2b-42c7-8e69-08de414a86a4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 11:09:07.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQlgGY5NtZurz+Sabtluz56bZFyMq4ZemSoF/l0i60lA4iP9oZOdr62OWiG8npW1zBlRXkW0chjWER1PiQZM6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512220101
X-Proofpoint-ORIG-GUID: slzLxv26FAulsVDPTvJcvufPZ34lp_-m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEwMSBTYWx0ZWRfX5dQ7Joq7D4Qb
 69uKwRZYiHApIcJ7kFSBKVp6e7d6jXkvrp74yqYtA56bQxBsaesirJvL/jS4AJ/uqsDHXjsJS3d
 EalWILmi8vHjmfSZs16EeoQDwejsU3Gucuq6PXibVIwrxAaIglBW+V04RqHHQQlTwAzJlM6Lv7s
 7Bpkv06II9VrtpBPvkv8Vb8kfK8AcVMfvcht5EEUwVE2oBSzUO7eaUZ4MAN1sPqUdk3EHsr9gYx
 Z5dZzX354KCmxpGSxz3cJfQo6nubssjrrXwFHw7kwg84I3dC+/6+ftkSBSOckpKlwvFRgHao/gH
 D64RLs5THGQqfV9wheIpAthqJqqiupWTqz2xIiqGkokXGiLl7/lgSn8RtQ5/dmsWavt2oP9a97E
 PdG4aXCslKnS2N4dtq0Sy+ECIa+AywDS7NJnGzUFNiDE5SqK/7tnvbhjoCr/XER9mh0PKz2sYCN
 PHMERE3O+MtyLHWbj+w==
X-Proofpoint-GUID: slzLxv26FAulsVDPTvJcvufPZ34lp_-m
X-Authority-Analysis: v=2.4 cv=d8H4CBjE c=1 sm=1 tr=0 ts=694926d9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=47mjobULUKt9l-LCgRsA:9

Convert ext4_inode_cache to use the kmem_cache_args interface and
specify a free pointer offset.

Since ext4_inode_cache uses a constructor, the free pointer would be
placed after the object to overwriting fields used by the constructor.
However, some fields such as ->i_flags are not used by the constructor
and can safely be repurposed for the free pointer.

Specify the free pointer offset at i_flags to reduce the object size.

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 fs/ext4/super.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 87205660c5d0..42580643a466 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1491,12 +1491,20 @@ static void init_once(void *foo)
 
 static int __init init_inodecache(void)
 {
-	ext4_inode_cachep = kmem_cache_create_usercopy("ext4_inode_cache",
-				sizeof(struct ext4_inode_info), 0,
-				SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
-				offsetof(struct ext4_inode_info, i_data),
-				sizeof_field(struct ext4_inode_info, i_data),
-				init_once);
+	struct kmem_cache_args args = {
+		.align = 0,
+		.useroffset = offsetof(struct ext4_inode_info, i_data),
+		.usersize = sizeof_field(struct ext4_inode_info, i_data),
+		.use_freeptr_offset = true,
+		.freeptr_offset = offsetof(struct ext4_inode_info, i_flags),
+		.ctor = init_once,
+	};
+
+	ext4_inode_cachep = kmem_cache_create("ext4_inode_cache",
+				sizeof(struct ext4_inode_info),
+				&args,
+				SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT);
+
 	if (ext4_inode_cachep == NULL)
 		return -ENOMEM;
 	return 0;
-- 
2.43.0


