Return-Path: <cgroups+bounces-12964-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00220D0156E
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 08:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2ABA30230F4
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 07:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB4E313264;
	Thu,  8 Jan 2026 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NPFYv428";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RSu0dCUI"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043C45695;
	Thu,  8 Jan 2026 07:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767855982; cv=fail; b=G7r3qcU8Mrq3ZntL/xNDOW5uDITEPIqw/bWUxdyr/huqmVH/b13aq8IeaLEV6s/1PVarPIaPciMbHfmhWcbF9Yy+vWDzygFUUnT2zotyEf7wjpnF+aG2IjCd7GgJyZ1RR9+DaeL5uf0PS7CaeHkqL4AcW0jjo/h5HmXxFr8eB7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767855982; c=relaxed/simple;
	bh=DhHVx8Voi4kYfsAUTpl+HWAAL/y+SmEf0z+Uo5T3tek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SAwYW05ZEXtvm282C9k+ioE2kGVo9G9Cn+gcd11FATox7OQX0fsI85Cif9P/4jqHggctzRCBHiOBeyFSxrtSiB7kzdzE3g7M4JRjlAUkNFCZuDSLTuhZ0uVNYOD2DPiqQukDIDdeuxBlS+3hM7BtXDclQTpjiYsUYUSIjmW+SRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NPFYv428; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RSu0dCUI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6086LX4J3780113;
	Thu, 8 Jan 2026 07:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wghNT0zYBeyVpzXTXO
	WJ+JDMkhKUtu47pKdvfD94F3E=; b=NPFYv428UbCLosu4p1t7byQiksFx8QRkYS
	0r/3lgDFyF2DMnZ01c9KbTmF/zWnntDWcfcqJ9MoBYdDg5Odx7qmPoXLDAZFsyI9
	wKMUeOCLBjqoCQ/YnTGlqCqepI6fMpmxFTSCYlbVHzUhVMiAYKihSCBqsjfeCnBg
	pkgDlNA/DYD7hT5bcg5Fe7fm0Fnh0jGo6w1RIp59pzc83uqEkmtVGpYssp+NHwed
	AhjZyOIzbRVrrJIfQl6/zkrTDnLdUYc+W2YeoSwcg0+JjiPXulExxkjDn0EbUytn
	FPLA06VrhGA56WgtoRnyCao1dCM7NnaQq9HxCnL8kRezaBWOlERg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bj784816m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 07:05:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6086YmA7026358;
	Thu, 8 Jan 2026 07:05:58 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011030.outbound.protection.outlook.com [40.93.194.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjn14ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 07:05:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXCRcDbtTtM+5PTWD8iDRKIx3PGymvT3LcK0IKYWCJZgKeC163HjZZTVVHBs9yDBqEzG5rgVsMCAbi3WdKKVt7xdjWBFif16rn2WDfLD79AIdy/afNjADu3g0FseG0HE8SO+tAyaa1pFHznwLp+LXWGZXkjzaCq8Jep+flpAr/ii1FphFU4rlye/LQpFOcNcpEJJQyVjYek322myj2plA18K1xbUzglCnxJU8Hr1qPLr1BSNK09XmGtCvPyuEP6WFpZ0grWzVFRMOHYCJeveTv8U2yWIqQSuX9d3rfY9PlA1nUzKvsNrjRZgsMGy+M8umXuXCL6lAU0g4IlKFOIRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wghNT0zYBeyVpzXTXOWJ+JDMkhKUtu47pKdvfD94F3E=;
 b=nablPUdzkVAp/y8XYwg5+NbastBwFsHOV6lWJQnKjlQu8YUQDyMuNpJv316BBc7sHNm9oF+Wu+7CsetGnHqkRz6Xa0i64z+fHIzXqFLUWH43mbhKThE3SGMs1/n/HyJWk3A+xqi8qXZYdprPylfSPNVsTgvzJz+tG+P1jZyKTshmLfxsxChFHpwQr8V33v4MVfNmRa/+aotIu1Gjlzu19PbDwhORP9Ba4yCqeFnAaEPrNSqSnLJzkOhGoPLzQCVJDWl7G7ncMYQy8Yj8inmesVoX2RUX5ba3SOg5wfU4ZkPyCsjTQ4RzInN1SlsevK27PqNLWondOCSRguNV36nj3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wghNT0zYBeyVpzXTXOWJ+JDMkhKUtu47pKdvfD94F3E=;
 b=RSu0dCUI2jL/U73uVCcRebaAeDD/vJCPn0/jdqOXRp6lLJVrY3NifDCJuhxDfjBlPKYeSD3ZXYFSvEZS/eKg/z+dEUl/MnLJK00+7/UvaeJ49wJKFVH7GtR1TueowINxDawWhufFpi0l/Fk380SI5chHkf2mqzA413wwzq9IsE4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA7PR10MB997775.namprd10.prod.outlook.com (2603:10b6:806:4cf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 07:05:56 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 07:05:56 +0000
Date: Thu, 8 Jan 2026 16:05:48 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, cl@gentwo.org,
        dvyukov@google.com, glider@google.com, hannes@cmpxchg.org,
        linux-mm@kvack.org, mhocko@kernel.org, muchun.song@linux.dev,
        rientjes@google.com, roman.gushchin@linux.dev, ryabinin.a.a@gmail.com,
        shakeel.butt@linux.dev, surenb@google.com, vincenzo.frascino@arm.com,
        yeoreum.yun@arm.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, hao.li@linux.dev
Subject: Re: [PATCH V5 0/8] mm/slab: reduce slab accounting memory overhead
 by allocating slabobj_ext metadata within unsed slab space
Message-ID: <aV9XTE7mHKWgHQZF@hyeyoo>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
 <14a0f149-5d22-4a3b-9cbf-3336d0783e9d@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14a0f149-5d22-4a3b-9cbf-3336d0783e9d@suse.cz>
X-ClientProxiedBy: SL2P216CA0194.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA7PR10MB997775:EE_
X-MS-Office365-Filtering-Correlation-Id: c8740a3f-897c-412d-313a-08de4e845e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nk5tEIuFHNe+RAawFBI5aADIRJDobl+oLjniNBOulkVGDyKv4Mpt6rWp9hsY?=
 =?us-ascii?Q?nSLn8XTXlD5Lz8cAa+LM9eOk1xz69Be7dUt6OSeMgL36YDqt5zNf1r6VnKDJ?=
 =?us-ascii?Q?+XucoeodoAac9wKqbxwUsbTL3G3Gp3uz+TF8mU+xYIh5EnbBsAI1jmlUzwBc?=
 =?us-ascii?Q?DcQxyRVvpFGtaiKNm2M7XtjDo7xT8BIy76xXukMZ2R0CjnKCx4pUAVqOewNs?=
 =?us-ascii?Q?u7bwAIRJQpN3wg5cnnWt1E+S4GrRWXQsHJp4aczBU4iLVxDtJVuErOk5edtP?=
 =?us-ascii?Q?dFt8xkedtm7fF6Fecediwj37xCk6DX/CjA/G1PXM/auEoGEIlC6UxS8NQ2uv?=
 =?us-ascii?Q?ajCYwCJByCqtZ8l9aLXFF0d9yQjMdOACLbMZsZi2x1D0QOSQb3Ud5VyhJnJD?=
 =?us-ascii?Q?LgpvQh41FVvJd7bXTnL2I+bWmBUQw7jqJBv3tEwCkD7bVTxg/O63cKB/wuuM?=
 =?us-ascii?Q?IQiNvNxO9iAWzAVTrtsQjzGRw4oOM79Igt0uz8XOdi4j8qiqcRCCI3e7lNZV?=
 =?us-ascii?Q?CpRdXXGVlQgZ5XAUrJrTHFRRRk6BWPw28oEL4kiXL7lnoqqam/2ws7bIyzxS?=
 =?us-ascii?Q?VKKHpceIKPQ2wWue9SSRilLftO/GUDFA7A+9E9zP0HPj1bf6yRdF0PrJ4MkO?=
 =?us-ascii?Q?gSHJJz4WHeJGJh07Pa0Dl7+qBksS8D6fSoHQuuXNDlymwiT5S7eeoJEafsWO?=
 =?us-ascii?Q?+LWUBXDum6MYjFGy8JkR6F1cFLWDUKfaL72K7pskPOK6QPtvUTAPRiG99H99?=
 =?us-ascii?Q?NK2AmhU9IbyIl/VbC8n9be+7AXxnhuoH+s0SpM4fluohxhNyhm2UTjGdbNul?=
 =?us-ascii?Q?DJu51lSn/YVVFpTy/Nf2T7JfzJBkbxa6vp2LNYF3ZxIGHvMALDJ3Rf5bHkgu?=
 =?us-ascii?Q?pCqY1Ec3FlRFZr0dYODCoGvrfg+EwNut+j/IFq70wq+tXbc/OKCKc7xnTe8X?=
 =?us-ascii?Q?XjGwaHVZ1f1hPyzVHRgWWR3bEFvJCsVgo3qC1VDA/9QX1kkG4tb8/A0mlGP5?=
 =?us-ascii?Q?D6wBOgJSiGHO1QTCv9DxDTMl209SLxsRlVwKiYeX7AOa2u1vPzyZdWI4uEOB?=
 =?us-ascii?Q?a0rSgFw3K4VWKHO9piZZSUbl6gbw1WvQERmB4zbm/+cUqOelga1Y7GkhORWl?=
 =?us-ascii?Q?oHr29FYML3gpcBngX1seQ9ggRSu8xLOIJ/JzhzganE3D0+CChjWC/m+CSexv?=
 =?us-ascii?Q?lFAkWbBV9x/peDAbhq/MFDMt58tqojdeMMaqA4YLJeQB++t3RhoikaBwzY5L?=
 =?us-ascii?Q?jm9kyhesIRmjsPf5yI2CUGxFyEMeaNCIlADdsPq+hkOfonLu59XKZ0+dg6N1?=
 =?us-ascii?Q?U/CnkhunNNlj+lq6dRxwfRpnlZ3f64/QfqWXLKpR/Bi6PfoIPcPGHYu2J8sL?=
 =?us-ascii?Q?ZttX3BnE+HLlZ9UsYQSyzArzwAhRvd6Rt+/aoF3owF1tUtnS8eKjMObBnj60?=
 =?us-ascii?Q?pg2FkaT4qFhqjCh5dvoU/BsVyPk/CTjCkh31QH3ICiakF+/ol/+kwA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sqSLJs7EJ9LxP5MmGOav+ZVrOgs/udy+wHn+UwUv8KY0Qctvun52wNTQmeRL?=
 =?us-ascii?Q?ciL33O9rg5oarI61r3HJ4Nkzyq9K1NQBBd6j15f40SZ7jCOKRSLoSTLrElyz?=
 =?us-ascii?Q?olFE7WWprIwm5ItpJK7GYDXrzCqnBucrrEUbZ7NCmjSvDlhcoHVPSNIQWbBS?=
 =?us-ascii?Q?jQsaa/Lb5qpX9029NDNxM0/0GA16d1K2dlA6C2dIfPmrF4dxa70AHf+E7GTr?=
 =?us-ascii?Q?VoCJV1jwxE8FywldXz3YonKSKTcFTRMdPzI77iWdrZT/tuVZiwy2Mb2DGVWr?=
 =?us-ascii?Q?YYmB0fq5cmBeuuySehhowDEEm8ZEWxEWCb4hMZCTicu6nycpVUIsQAP3dAT0?=
 =?us-ascii?Q?Rn0MFiyaD7UatD/cvcu0Qcmlet9mOjoI9E9Sps3UVKiQDFT8msq0+ZqZ0cwK?=
 =?us-ascii?Q?eixM+GCYjUdNOSwHWVbNjgnTvFoEp3CLdXvCQ7J+4Z8T8zc88pBqqsHSUIch?=
 =?us-ascii?Q?jvHiCnQZXc5BH/ijOt+vIsRGXbfPiERfE/O5SvZOTB+pweEyKCvKhBjmxXfF?=
 =?us-ascii?Q?6f3Z8y8mxGVXc640B02Kmi4kQhGL8FcwQ7CKApkustXPjIckXG8WcDIefKcb?=
 =?us-ascii?Q?X19JpnxBqmZ6k/tZAfBnlp/8W1HtZeG8SPydzXjHMHefrYyR7NbLirxbLFxN?=
 =?us-ascii?Q?DORzDGpsbs7pEd6jLmtivnVRsjhc7Ym9ADAm1dYiitJH7LWlPf4MQckYk3cd?=
 =?us-ascii?Q?1vrRmZpjIb/xN1yw01fKOvNKxubzCoK55jo0404yGRp/0M6VPu/rJ+befaHi?=
 =?us-ascii?Q?mlCmQ/37ZcDbqILGvVGDO2JOaBdbuzF+S4Ge2K2bdDTxznvozcvXtlzYdvOH?=
 =?us-ascii?Q?tBAxwGfUOWu7a7bIKDizqCGVsPYS+udEZOWkswCeptW18cMCHKYI9lgrVZ0N?=
 =?us-ascii?Q?002KOh1XIEvGJZ8n9cdwYVSkCT1k3PsbZIjxoWDnIXpNLLH51nQ68Un6SUsk?=
 =?us-ascii?Q?LLvzEOjWB/CvrMEfx6O5nvg6N1jfRiUrZY2camQnmmOJvhBmAwLLJkQJOzL3?=
 =?us-ascii?Q?MIhPXK0SJyFTc9kqk2YC4sNmXvXsoJuG+iUgIj09Zg2M0qlT8yO2vDS4svAI?=
 =?us-ascii?Q?r8PrP0O67vC0aVLtnk7HmOBHWIJZsKQO//ECs0Cy1MvLj7Y4y+cIcfz6pUhP?=
 =?us-ascii?Q?KgD/S1aJZeGD4X8BqmURz+hjZkMTCha/9yGLEeD839Dl5LvWWYeHoG368W0X?=
 =?us-ascii?Q?kNPw8I9jXBAZ0F7VUWOmTE1ievH1fBDj+YcgA3+lz2sFf9CCVRdzzuht1Z9n?=
 =?us-ascii?Q?5D6MKFYjMs8ZhmdpHLGElV6jxsYGOtiwiHbeWvE4nQV8Y/M2fJVvYxkVIcUF?=
 =?us-ascii?Q?xivcvlACJdC9IzKmV91WZ9l5Bm2Vv01ZFM0OvzfuWbR5BlMAK65zymdcfgum?=
 =?us-ascii?Q?siFBX8eF9jQz22ex9VQbbl64zXWo0IiQ5EutN9b0grm6EidKuhkpm6DXJFSD?=
 =?us-ascii?Q?b68wVum0fkc162zvvlrvbI9O4nA0jXC71brOmncjnHSbkSXilBpOIY6jxyUg?=
 =?us-ascii?Q?BTtC3HYPsEU6qMTwgSce6MAHIS+Jmu5PvBNgnK+/ZefTMSukhT2cT18sh8E5?=
 =?us-ascii?Q?zP9BlcvFKJpv7UEOVg86EctKYKZktM74zFG6r9tQ6bTR+drJhS6vjcnTy5uk?=
 =?us-ascii?Q?dD0GMnRdWHkaWIFJHvk/CWQMLOu3MVWB7PMCw0fYK5Jak8LNq6zP+WvMFTck?=
 =?us-ascii?Q?sYWP4/8yZIBbUbq3vP/4s1IaAeLxOdwiM1/ffTzRcRuMvoJOL/r0JBYJtaG6?=
 =?us-ascii?Q?BoUOjojh6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H41W7hwfM3ZKqqRNdulqTNxZzRI/r4fz3051xX4k6sfqWc10D5X0M9bxURo3MpabWcrwKhBEDYGRhK9pS4zHEl4Z/S3gzoNjVOvKDag2ii/rzcLGYVNqC+0jAl0EtVH7QhZpOvGfCFn86nGxkKV90Da+6KvsdESbp02RXYT/gkaxy9fTQ4+iADVNlgB8BTNa3GGW2ZPahz1fMO+rcRwafc3APLIDXjk/nnAb/Y7qLdVGx5kzzZcXKGHxZqQ/Kp2FyOgw4qjLmUbQ7kdYgY3T1R0/PHjNMpXHNKvVEXOnpB8IJh7zd+SPiowWoHWrQZfXP4wDEXxEjCmprnCf42jS41IdBdv6FRQ13vJH71tDnSvq3U0J775NI3Y603nasZ22ke89IFejHzKJ34sXkP38IXd5IzhHqGmp+FwDBA4IFGJ1N/G6bnJfNFbqXMgmY8Qy5ib6pFaYhg41YNu+9soi2jGOGEtlARaBEXNCyezhGBTsn6J0jgaBLuIuoOLwBZgzg4/JtyJa3TojECTNoftEXGnwaxxGbifCaanWcm9ZCEbmtRU6Jypw+41vl+Ye7r/62bGi6eXNGSAy2QhoY9UvSNEZFlza4hIw4OWED3EsIrs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8740a3f-897c-412d-313a-08de4e845e6a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 07:05:56.4446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FuOJeavn6w2sVgfY1snow3ZiUkJ4iQG5zqxONN4Twn7Fk9EUJm0PJevLcoLbv55yzrW7s9pAb8Qh/JOrixyvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR10MB997775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_01,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601080045
X-Authority-Analysis: v=2.4 cv=QNplhwLL c=1 sm=1 tr=0 ts=695f5757 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=7EVfwcA-leJCwKPsxWcA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 cc=ntf awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA0NiBTYWx0ZWRfX7s3a0jJXuBT6
 cTIX2RudqJPk6Gl/dACrmMs0oPLQS9k8Hr2KhpFUxuc+4Pvl48UwPnx3YR+yZUQSlEUzCpd4ELd
 ihn6EjqdQzT/iDTvxsFTQs2EQ+Ts5LD29goI6m8sxJwmhTRAQHXPgwdQRh3Xc2G1rd8Sc9GKXlz
 lDbtuluLBxVTdtpR5Dv8naxIaB140P/ykT1AW7jRIJIFFBPHqkzsoIzyT/00mIRw8/o46Y43KbB
 1oPNttqEfq8kFm2edhFzOv6eJQxr56SFlzEXrC4k+j5g5k2/VW8prT1Ylsza70cRAzqv7qmlseT
 HXovpM6nnUcaziBSIJfpm92/3IRH9usiHAAdwJTCltptOukkPueR21BbCaFjNpEcQ7ULqpF+mDZ
 XrhzoojIGDgDgL4/i/oBRUnjYRS8sXOk2mn5u2PrHUV2yif4u4pm1DgpFTWexsTGtSzu2oTtxSr
 WV7T46uvMPpWuUdVkvSUdi1HwOvg2Ww6J/VJc19g=
X-Proofpoint-GUID: 4HhBbg1TrzHY8cAnyBdHPYrkymqYDedt
X-Proofpoint-ORIG-GUID: 4HhBbg1TrzHY8cAnyBdHPYrkymqYDedt

On Wed, Jan 07, 2026 at 06:43:30PM +0100, Vlastimil Babka wrote:
> On 1/5/26 09:02, Harry Yoo wrote:
> > Happy new year!
> > 
> > V4: https://lore.kernel.org/linux-mm/20251027122847.320924-1-harry.yoo@oracle.com
> > V4 -> V5:
> > - Patch 4: Fixed returning false when the return type is unsigned long
> > - Patch 7: Fixed incorrect calculation of slabobj_ext offset (Thanks Hao!)
> 
> Besides the stuff pointed out the rest seemed ok to me.

Thanks for reviewing, Vlastimil!

> Can you resend with those addressed,

Will do.

> and rebased on slab.git slab/for-7.0/obj_metadata to avoid a conflict
> in patch 8/8 with Hao's comment update patch there?

Will do.

> I will add the series on top there then. Thanks!

Thanks a lot!

-- 
Cheers,
Harry / Hyeonggon

