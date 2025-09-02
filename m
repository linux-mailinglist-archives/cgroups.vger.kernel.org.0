Return-Path: <cgroups+bounces-9604-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBD1B3F545
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 08:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5901A84A20
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 06:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03572E3373;
	Tue,  2 Sep 2025 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fELCVrVb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U5w2Ah1K"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDFD2E1F10;
	Tue,  2 Sep 2025 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756793949; cv=fail; b=H3u1olwnag+0VOQAgIqhDca74G2Q+H6lrQDfEyUUNzDMyhiItVonWOJ7FsPbyPyR4PlZZegP3Xy4mY0PWhjkbTTTWEs5qVaalDX4jEs+Eu1q7WDCICsCl0lj5f/kSd1udPsUm/zCVOu+fEOenTmHeaSS2IsIHjIU/Lj/hjvUltc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756793949; c=relaxed/simple;
	bh=bG+Sfe3HhsZeta/0MIoKp8nq4xIFv7qefU/DZe4XqGs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PPndnU59950yILPaZbC8L9RBv1R4vgiqhxY0RdzQh0/yraW8bsIWCwT2pdJf23gdgi3/whManr9e302gBQTsAjE3r25xZZwzfw2IhgY2D+xBrye41zEUcn3vmO74BbfDDRejL7wYGSgNKyvo/sTU5/7+vdaEhlx2bZZxUX+pDMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fELCVrVb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U5w2Ah1K; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5824goOB023542;
	Tue, 2 Sep 2025 06:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=l9pmymOOM/XJ5Ai1awgWC/pOH6K+WbKpcajh4P3oCxg=; b=
	fELCVrVbooWl34APgNWMP+h+h+S702IFGIgLV2jEQUtrmSEiE42uCrTh1zLsHBRr
	EYXXHtA12rS0kMHQH3RXKad3F9zWPBjkhRl/gxn3iAwia43MYSibGALvrPt3RnhT
	Sbt2FMPAF0oqIGKBh0/9Bk4DFZfKg40WIeeR0TVyOLZlOCLo0kBxF96Hg/s2GgB7
	v5d3ALtEs+rBfRG+KiDtnp7SXa2WZWcbVDG3KApHUnnNFVoMHrlNC8Ug25s4XXWN
	OaUbUlzg5lAtJ+w8M3q2AGRwtrE/Vy13QMm/f2ANU60cCXT+MD8IrsoTd1rGilJP
	/mqgHYFz4bGUZJx/zwat7w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmnba2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 06:18:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582645pW011716;
	Tue, 2 Sep 2025 06:18:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrercj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 06:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzv6VkBAAQUs6qZJHkbCJAI2uzqxOuga1QN0CLIRrDLfOn2iovV6iutU6w8yWx4ZO4rKv6WjnxHsW2xp2WWSx9WBX2jClTXZgDCINhHzRgnn5vCIqzHfnKk0W5oIskailzi/vTB2iBO2DIJcQCdNvd+mIPskyhhp9v8UsD5jvboj6ZlcTmU6A5yMQ+mqAPBqmJ2Gxp5FSKvYcjq58/RSZ6VaRHF9X/+iCI4hZKHDyI00dUrsV0196FBaKL8K28rgNAWqRRFF2hI2sIwu7w1xd09ey6o7O8f4klDijuoJ+oK9a9s7ls1TFBSuskcjNKK8l+YD+pnp62/somMuKYAitg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9pmymOOM/XJ5Ai1awgWC/pOH6K+WbKpcajh4P3oCxg=;
 b=X4NdZWLU/iAeczACni6SZ/GyPgUUSxgoFNubLgn3S9ZxImRzirlXOzKEiixz4KUwD1RyO9zC8vE0R5j2vnXpk6sKB6kY+kTMsKb132Ow5tyeAog2l3E1TkHOy3WDzkSRB+5x058QfH5hpBJaYZ1B5ZfvOrKpvxxrDm0YbJe43MsEYjFHu9KuF/uzA8zYSfOeolfEGMP8a54B9oohC1IPyIKl5PnZXrMYISSHNEpZ4LNDilh9tra17uVJ3rKQeEayd2UvM4HyaBLgxvi3l+iNxqaCsISATHiHnp4rCo8xWWopQ7RQoi5aXEBqVQWSTpP4D+14YEwPkiaiQlFhUa8h0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9pmymOOM/XJ5Ai1awgWC/pOH6K+WbKpcajh4P3oCxg=;
 b=U5w2Ah1K4M9JedOklpByvREcsr08naGkJIWoHmk9qbIs1Sa76T8lnia5pC/ssXgEtyiapD+8FzfzqPqL3bDR71kkF/Wpuv7eKivSDJySu4xcavDEmmDX25t9WtNrHJvp//WK48E6KnXzNrFjUZVtTwkoTbPZaVzl8GIapO6o0uc=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SA1PR10MB7832.namprd10.prod.outlook.com (2603:10b6:806:3a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:18:08 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:18:08 +0000
Message-ID: <def0970e-0bf7-4a6d-9b68-692b40aeecae@oracle.com>
Date: Tue, 2 Sep 2025 07:18:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/7] md/raid10: convert read/write to use
 bio_submit_split()
To: Christoph Hellwig <hch@infradead.org>, anthony <antmbox@youngman.org.uk>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, colyli@kernel.org, hare@suse.de,
        tieren@fnnas.com, axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
        song@kernel.org, akpm@linux-foundation.org, neil@brown.name,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20250825093700.3731633-1-yukuai1@huaweicloud.com>
 <20250825093700.3731633-5-yukuai1@huaweicloud.com>
 <aKxCJT6ul_WC94-x@infradead.org>
 <6c6b183a-bce7-b01c-8749-6e0b5a078384@huaweicloud.com>
 <aK1ocfvjLrIR_Xf2@infradead.org>
 <fe595b6a-8653-d1aa-0ae3-af559107ac5d@huaweicloud.com>
 <835fe512-4cff-4130-8b67-d30b91d95099@youngman.org.uk>
 <aK60bmotWLT50qt5@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aK60bmotWLT50qt5@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::12) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SA1PR10MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8f5e74-42ec-4219-75ae-08dde9e87bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHdCdGhhYnFCYS9mOHVLMzVCV2k3RGI4aGdFZDdQaW0yc2JlaXZFZzhySXBB?=
 =?utf-8?B?RDdvNnQ3U29ldGtBam9FbWVLQnliTUtVdWdXSzVMdXVJWlphM0ZpMVFFZ2FB?=
 =?utf-8?B?aFh2QTcwcm0xdzY5aE5KTE9FRS94R1VDZURsbTRVM0FkMy9zY2FCRzFFR0gx?=
 =?utf-8?B?RUt0bCtUYXplNHRKeWNad1A4Y2ZCaUV3RExEV2JRVXZXQzNiWDhxOFdvdk8w?=
 =?utf-8?B?WmFpUWh1KzY4NmYrR1hwcndQdkhtbDdaN0hHWVBEbVNMV2tWZmd0QVhmTC9o?=
 =?utf-8?B?ZytJWTU3cXY3dndXWXBrMnlUc0N1Q3N2eUlCV0lzU1Z0Z3N6c0NiUU82R1ZH?=
 =?utf-8?B?MEt5MU1lTGhtM1BXdVIwbUo1OExaZFYydVhqVk9qY2xVekpzS3FGY3dyQUJ6?=
 =?utf-8?B?aytLN1NuNnNPSVFFRVZ6VHQvVXFjYlEyTEVwakdiYU4wbjRtNm5JVlRWMDZy?=
 =?utf-8?B?Q3liOXBObDNSNTlBK29FM1ZGd3V0RkU5YTFRaEsvZVU2WDhPZzBxQUNTTXlP?=
 =?utf-8?B?RWRiN2hGakhCMzhVMm4ydlMrVVVqbVNzVnA1OFVBUStleHE5MW1JbVl2NFZr?=
 =?utf-8?B?OUk1M3JZcWhFcEhGRDlsQk5IL1NzUk9zTWd4VVZlUXVHK1lNSnZVajd4WGVH?=
 =?utf-8?B?MVZhOVVMZTI2dlpHeHU5VmJJOWlLTnU1aHdoWXBMM3dnaWhxcVVVZmUvbWJH?=
 =?utf-8?B?ZXNKekRlenhTMXdBejZ4QXZJZTJkYWJFcEkxWmxtK0FDMzVTb3RPc2UvVGwv?=
 =?utf-8?B?YVBJNE8rOWs2MDErek41OEhoZ043STdiT1pZUTBGcm96T1loWnlCMHFnTy9K?=
 =?utf-8?B?aFFYenY0N2JwbDBNWWRxWk8vSUVka3B0Y0ZkSHZNdWdwcTdQYTYxL1NBQ05x?=
 =?utf-8?B?UDV5OUJEL01waDlXbUlhWVFFazMxSndOMG8zamVVUkRRb3hRdG5RbzlrdXYv?=
 =?utf-8?B?aHRrVEJHVEkzVXJmVUs3eU1BY3F0cEFLTnhFRXZjSXlNT1l6bUlqb2ROK2d5?=
 =?utf-8?B?c0dzTFZuQmFvOFltdThIRzM1bkg2bDFqVEZWaUo2RHdSVXFvczdvdVlIeXRV?=
 =?utf-8?B?VXhYUDVKeTVHUmpoVVZDM01oZHdxRE5tWjQ5NlVJeHh2ZXduTzArZnB3NzM5?=
 =?utf-8?B?ODQ2eHJtRThzY2pXQlUvZU5QVmNkY3doMlgwQ1k0TENHR3RrbWp2QTAwaGUv?=
 =?utf-8?B?WXVaTzU3c1crUE1WV2VkNlQvNEJkZ05FMjY4bTJMb0pNVjJZQU5zdmhJVlRt?=
 =?utf-8?B?cjM3bFUxVVUydWlqaVN2TFg4SUJ4eTY1SngrajZyZzdOQ3RRYXVWSGVnQm03?=
 =?utf-8?B?YTNGS00zMzZkYlViSHdVVCticDArZUlFNld4WURZN2ZUa2EyS3RFd0ZJRDYw?=
 =?utf-8?B?ZkNTMzk1S2NlWW9aNkdFVXlxcTVudDVxMzJnZkZqM05haG5pMEJCSDZMV0Zo?=
 =?utf-8?B?OEtNcE9mbENCNWhwMVVoL2pSZTB5UlJyREJjbW9GbjJqU2w0V21jWGp5Wmhv?=
 =?utf-8?B?TEpLdGk2Sk5ISG8vdnhyaXBVRnJkWGVOcHNGRTBDNnZNZ3NsWUZObHJEaktV?=
 =?utf-8?B?VUt1WmZ3Wm93bHp0NjdPNmphU2FpQ1ozV0wrNmFBYWxiTVlYNHEzOC9ZT0h5?=
 =?utf-8?B?ZWN2bDBXMVNzajR0bWpRUWd6Wkgzbm1CR3dUbVkzZ1ZtL2RGTHhjTTdDSFBa?=
 =?utf-8?B?MHdnSXBQeDNmc3BmZ0ljQVRwTzd2SXJ5RzBLSmVnWEJrbzZuSzlVSlJzbnRV?=
 =?utf-8?B?ekNLbGs3Ujhodnp6eEtoNWUvZ0l0Zmh3dGdLWUFwbm9aVC9UYlNWcGZ2dlJL?=
 =?utf-8?B?U0R3Rmx5dkRxM0habTJlbFRGSGtTemZhTG16c2k5MDY5enJ6NUtLOWJLQSs3?=
 =?utf-8?B?TWZiRmFmTHdURTl1aWRPeHNobWZQUVQ5NUQzcCtSRWpwaG1OMXNRVXRJNkJQ?=
 =?utf-8?Q?EeZOoEtbHGY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFhlTXlSNDA5VjJzVzdpVjlRM2NETW1oYUVIcGFESFFjYkZLalVwK0ZwT1Jl?=
 =?utf-8?B?eGJDWkNVUDJ2ZEFJaG15bEZIKzFLK1k4MHFVcVMrWXF5cHM2VnVLV3J4RG05?=
 =?utf-8?B?QUJDaWdlSzMxV1NWZnRYRG81Sk85Q04zQ2hrZkxKR3dHaHRocld2ckp6Y2xV?=
 =?utf-8?B?bVI5ZXZPSWI1dllhVHZJZ2I1VGJ3RXRUVVFla3pjay9sVVBWN1lQU1gwZHpx?=
 =?utf-8?B?N2pvNTRhRGdnTDhMdzd1RXYrZ2NkL0tUVkhGdENoTnROcTVlckdQUWdyUnpL?=
 =?utf-8?B?OHF4OGdoWDlVUm1nblhGVGJZSkw0S2RoOFF3dW04KzBKdFVNaS8vTVIzMGsw?=
 =?utf-8?B?cUJwZGNFc3FNMENYd24wL2VxdnA4MWxxRklrb0NZRHNLS2N3ZkVjYU9EQnM4?=
 =?utf-8?B?aDU0eHljcHNlOFVPYkJEWncyNitiODhxNkw5UUpOcHB3YldpbG96S3VpRG51?=
 =?utf-8?B?RlZpakFoUTVBcUZldGhZOGZOamRqYWRjaXpFaUlFNUpDejY0VDZsbFN6eTND?=
 =?utf-8?B?SktNSmU3bzVNT3lzWmNqbmtZekpCWWx3TlRoMHJnWTBPZjI0a1h0VFZWVlFO?=
 =?utf-8?B?VDR4U1BsOE15UDBkcS9NSklXdSt2cWxWd3ZUZDQzdjJlMjF1am5PSGJqbHN3?=
 =?utf-8?B?VVM2VFZ3bkhLSnNRTHVJZExhelNEaDhvSzFEMTJsbFIrb0NUaTlTOWowZjQ2?=
 =?utf-8?B?cEVzRmtzSWlzR0VYQ3g2OEFLNnhSRjYxKzRYemV1N1N4Y1NwSnRaVzZsZGkz?=
 =?utf-8?B?aXYrUk1UcU5zQkZPdk9hWXdCQ0UxZXI0UmltSFFTcXhJL1oyTkNDcTRNQmtU?=
 =?utf-8?B?ZUhya3FHUTBhWHZLS2Nrbi9wVllVek9yMHY4UWVyS2NLSFgwTGhwSEl5bVd0?=
 =?utf-8?B?ZGVXc1RRc1g2VGp1aGk5Z1NNWElBa0k0NHN1WnVOS1BUZ0xFRkpnaTNveFhv?=
 =?utf-8?B?N0VFSS9TVmlsRU9mSklXVW8rMXp4L3RmTTRLNHp0bk5GaHcxUDloVzhaZmlR?=
 =?utf-8?B?d0RjRno5dWpqdEF4ZytFb2grTjc5NmhtOWxIWmdOOGt0MlI0T3AyYlNpTGFG?=
 =?utf-8?B?MUVwOGhXYmtRTUNuZTBOcEZEU3FUdEUvWFJ1Z0NpQzF2RHNhMUJSL2NlQ2FL?=
 =?utf-8?B?MTVWZlhRSVBSakphYVh2cHNvczR5NnBLMzQ4Q29nTFYwNkJRNmVYVjVTdHBN?=
 =?utf-8?B?amxJMUd0NXJncEJxRmp2VjNuWXRXakNnQ2cxbExLN1RQM25jUkJiOTl2Qlg1?=
 =?utf-8?B?bDdLQkdBZDloVDlUL3Nta3FwdGJ1RDJjbzRQeW5NenNkeTIxOHdETWoxV1JM?=
 =?utf-8?B?Y2pKVlhtMDhKU2NHdTJzVVU5eGU1SkRwK3JWek9pQ2V5V1dUQzhWOE9VYlN0?=
 =?utf-8?B?SUs5T09YWFkvR2NkdW9mbzVXTjJEU0FzbDRpVWlQMnlta285M3YwdEJaUXdw?=
 =?utf-8?B?OFd5M2xsR2F0eUk1Y1RnNHR2UjVEdW91QlVQYnA3eVFsQVp5c1lNZ0x1SEZK?=
 =?utf-8?B?a0VwQzNWZnlHbHlWcnBNSXBPbHBGeFJTMmZySHZDOVNyWDlNRzRkQWowK3ZK?=
 =?utf-8?B?TTVsOTBkM0FqaGdRNSt6d3RLa0ZOdmZHZ3BmSVhjejQzSGUzU0djNVNublY2?=
 =?utf-8?B?cHlrUllmcjFKZWhDZm92ZkRHb0lhTVIwc1VqN3RucTRCRlVWbGVwRmh1cXZt?=
 =?utf-8?B?OWorK3d6eE1JZG5zejRQeERUQWt2Y1R3VmgvbXg4aTdPNWtvZjFYRHNlTFhz?=
 =?utf-8?B?UEcvTkFETWdoWGZ3SnpPN2E3K0JrbEZZbWE2dFdLeWxsM0E1OVk3YkU3cW1h?=
 =?utf-8?B?UXNXNTdQclM5bE5sYnd6N05RdnVRVFUzdVBHNjNEOVNLc1kyQnUyQi9YUC9O?=
 =?utf-8?B?ODRJa1dwSXIzS1pNRmVzMU5SU0x1WFBzN1JwMkU5U2ZIVnArS05RN2VUMmNE?=
 =?utf-8?B?bTdQb1R6NGJPSkErSVNmZkpkTzRYcUczUmFJWGxzOFVUMzd6aWtJS0RQSWpH?=
 =?utf-8?B?V0UxYnpKMm01eDJlY21acHp6dElnME5JVGsvbytJU053MEF0bW4vSHlLTVZQ?=
 =?utf-8?B?NWNjcTg4UjFDZytSVzRjaGdKOTI2cVpKRWNMcnl0L3JQa2JkMkFWbURIRmxr?=
 =?utf-8?B?V0twWFd6ODc5QmlBSXkweGhEYS85SUJTVE94VUdOT1ZoK1VvdEJUYkVEd0dZ?=
 =?utf-8?B?Y2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0Ca7bcG/yJ69hQ1Z597VJ8XTSxDv8hz2XO3a0a6TKv3yqY3gyb4iQ6UGB/i0bxzu3LY/qKPK4CQK9VhBjWAjaZVEXqzCIHH7VLyy6HWDK7/JfzCewKUnnZ4iaFlFLw3GyLkqyqRtiN+4JBXojicX7kTUELt/gX6hdT6/4aaJvxJsSBZDpJczHan3k+rzsiX252iHbmwOvEnhY27ZmQZNdXdXV8r5ABlkp1fYWxnKdxSKK7IK9wSfWd4fRZfZsdC6sZhM7iYWVxlacbms0Ybi+n1RmA5Q5qACZhG3y//2WxNeWi+oVI5k3TD1YRAgcGoID7EtyhtuiiZ0d9n0lIVgCorGASWh9f73bC813WrlM8zNhfvGs5gw+ekZ2pkRIjzmP3Dus6klonpbMCtxSxRzQjA4c9woVDb6LeGl9oV5ZpuOflz1mo91sZzk89dzs2JWdUP4ciFQ47lO/rfltjlMHHrMSz9agUVE1hBBXp8kqMHlU3mqNReeuKNeIRObooZ9f6wFkkUwYmB5vnEjyq+ZgEv62AGeijtd0IOG+F4qSPdjOMJfLSXeEcTVFhc5S1lCBAZrqKh1Rv41A3sx6cFXOojzTxeKRoepogy+SnWH7is=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8f5e74-42ec-4219-75ae-08dde9e87bd6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:18:08.0534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c3g16jiM4Pksan6TjMJ7TfyiPQ+FOLM/MUJWVs5nBnL8GIaWJObo4QmySEgDGvkxtAyeyzhfZs5fg6hYgJoQYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=841 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020061
X-Authority-Analysis: v=2.4 cv=D8xHKuRj c=1 sm=1 tr=0 ts=68b68c38 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=Y9qhHAfR9t3_voJpZ7EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12068
X-Proofpoint-GUID: 0esf_02w6dUkq9K3o8-acZT-eGQR7IFC
X-Proofpoint-ORIG-GUID: 0esf_02w6dUkq9K3o8-acZT-eGQR7IFC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX9tAQszdha2Dt
 aKGTM5BAcIQvc9g1oNnIk6KeqB8lcJ9yI2T6Ov8kZz2jWCdNKA1lenzyGj8A84pUYUeprzOnqlJ
 nkeTb6b26GdELrSwonGXS7LU8sgzjF2ad2mvJt/MkQ3lb47PAShnbcnbZWkN58drvRvi7oUgG1/
 iMcdnHUaXYrdZWJXg4i2hYsny/+gk7OzAwwygLohF8Fs9UIPP0wiOxhl1FdObfY5tZCSrrko/rf
 dIy2iD34Ak4syB+D0W0xtps7CqiX97rsofJ94gitfjtMfdYzPo5a7GGIauefodler917mXS5Be4
 yeZYKkYKO33sd6B5SAJv+IIPYqB5uDcaN7pKs2dGFXHxwZ8T0LO8z3xkLbCbSYlW4rGp13xJzff
 0IDOTUVGcTz3Cst+x5lNQ2J0hL0IwA==

On 27/08/2025 08:31, Christoph Hellwig wrote:
> On Tue, Aug 26, 2025 at 06:35:10PM +0100, anthony wrote:
>> On 26/08/2025 10:14, Yu Kuai wrote:
>>>> Umm, that's actually a red flag.  If a device guarantees atomic behavior
>>>> it can't just fail it.  So I think REQ_ATOMIC should be disallowed
>>>> for md raid with bad block tracking.
>>>>
>>>
>>> I agree that do not look good, however, John explained while adding this
>>> that user should retry and fallback without REQ_ATOMIC to make things
>>> work as usual.
>>
>> Whether a device promises atomic write is orthogonal to whether that write
>> succeeds - it could fail for a whole host of reasons, so why can't "this is
>> too big to be atomic" just be another reason for failing?
> 
> Too big to be atomic is a valid failure reason.  But the limit needs
> to be documented in the queue limits beforehand.
> 
> 

What exactly could need to be documented?

We just report -EIO in this case (when we try to write to a bad blocks 
region with REQ_ATOMIC). In general, for RWF_ATOMIC, we report -EINVAL 
for too large/small a size.

BTW, do we realistically expect atomic writes HW support and bad blocks 
ever to meet?

Thanks,
John


