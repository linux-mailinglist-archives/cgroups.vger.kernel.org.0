Return-Path: <cgroups+bounces-13124-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D16B0D16CE3
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 07:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 509E6304B3DA
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 06:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC132369964;
	Tue, 13 Jan 2026 06:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CagtPfzW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nD5d8SHa"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12418369235;
	Tue, 13 Jan 2026 06:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285173; cv=fail; b=R1Eaw0X+yQuE/1kqiTIV57DSA9ZO846swmrwwGEJt50QMcqxGLdPcGqLiALzp0joE2SvXDuFeYw/+iU2Mx43NSkgvms7ubRl2dR/hX7ZUJnqJP3CxG1YqGWTbaWP3IqUlXE9lvntp49rQ2LWuLF9jkuSbrH5q4+2SCbJhhbr90w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285173; c=relaxed/simple;
	bh=9t+o8Fyj1lPxoWKZns1U2v1bKGkIedWQ0wVNXrnNLog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uxv6h+vCg6H9ww1fIDS7PV6AGi+uZpcyGr2TlHXy7b/brAmzni3n9pkweOoW57RF2ySnXKNRx4lWqgSC1ZOi3Ez4OhzXilA8O6NZ4W0zvI2yZF/45pIL+CM1c7YWWgpArBn55oH3GzSI5pGIWvLGfKWjR7R1j++H9jq4kUlYyEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CagtPfzW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nD5d8SHa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1gnSW2753576;
	Tue, 13 Jan 2026 06:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nepYa/RVhpXFvZLEq40H3RuVXY9WRn5aouYwCmE7dto=; b=
	CagtPfzWx8/dcx+in4Sk5CLrjPAGJETTUqMLTAZJ13Ql6Ce2sfDisYUz2d7rUpZZ
	AiweAVzHQM2gs4gES1LE3GOtuc+8rqWwbt8toHg3xh1eWUGqpeSxYGsJ9/0yR/lI
	5pPds5HfMqru/liY+tU+YiVGjtMdflmzLs2cEh9+Y+7h2kXQwnP2hjJOetRfAfHp
	LRkJ6SoRYvWsfKs/fwcpH6lpb9EIMjNPI+wGXOKS0zoCdahoWsdV7hR1HbOeO+NN
	PQZCr6a+s8ZCVMh93WMlyU3rJGT3YjlJ+MOYMczS39N3UwfjKqN0s8B2Ew1o/X8S
	vd5XdEiGduHUjO5dwB/uSw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkpwgjwne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:19:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60D6EbRr005686;
	Tue, 13 Jan 2026 06:19:09 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd783shb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:19:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vj4m4U8zrvHqLTIElhToMtAXZu39jP8xaxeJhkMLTQZ7Z2mmXLlg6sguSpGV9Ek1+4Yo0kzVErlsa1UoUGpMZ76pkBJC0R4QfxA/qETRbimxFF/33bGQF8f5jR1EptZz8MU9XBycFbiL+b7g+N80yfk/3XGC+ZVn5Ckp9mupaFL9sg9+PykLRsJ40Pa8lvZJcOyCYpjY8tAs4l3tMp25IbQndT99B5DS4abbX5OLnM9OZpLcUpbygZAfx9+WR8bMd77uiNdCyTmyebLeXWTZyDs6gwgymHoOUtqwtGWmmgUnnEQQmMI9G4yh1CGVKJiceasIF24XxA2eun9UbDc3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nepYa/RVhpXFvZLEq40H3RuVXY9WRn5aouYwCmE7dto=;
 b=Y3PrkQW7+09pscY8hpbKubbJ11nd28vz1mZSfQJlPEFSx+sm7mdHgjtlO6N32EVyZqJKaVXkERVDAjI+1U6WjoUk+R3KLJ2nBc9QYPPlqHQGFz7ERTfnWn9pLLfiZ0m2FO2YA/4U0n14v3cQ/yydzediR7GpeDEOqVs4OkhAzpSv6/LbYzQMzo6XLXNJaIKVrQF15RlQA3JgVHUGfwELk1JZfXxMnGHxI0kP/GnNRfTZnu+nK/9lq8mGvZteN7jfbgmrbT0SzV39H1jAMrrnIwjsoofuMSGb631ckCdjR75OwWC/6+dxecBEzabPG/gA+9gR4tphnwnDRrfLCppbbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nepYa/RVhpXFvZLEq40H3RuVXY9WRn5aouYwCmE7dto=;
 b=nD5d8SHaYkp+ATyPZ+JmB7rOMzEcp57E/B72dBnINRmustUkAfo5xUMkOAB6dR+aO2EX1lHGd0jfbsK2rdmrRYE/ArUDy40EhQmoB2a9XWU6n6nHDKgkrEYIslzf+u+Mf1swCxrhYdqy6YUSvGTOFmTXdDJNK56oACHRl8BOA4c=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 06:19:07 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 06:19:07 +0000
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
Subject: [PATCH V6 4/9] mm/slab: abstract slabobj_ext access via new slab_obj_ext() helper
Date: Tue, 13 Jan 2026 15:18:40 +0900
Message-ID: <20260113061845.159790-5-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113061845.159790-1-harry.yoo@oracle.com>
References: <20260113061845.159790-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2PR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:100:55::23) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN4PR10MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: b8be667e-827e-4772-8e85-08de526ba813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s+Ui6MK4w49uSp6JrTYujfaZBBJx1nH764JuixnMea7IIirArkHZ4u11NN6Z?=
 =?us-ascii?Q?Ea4T6FMZKVCVLxa8+6s9pZ3wIew1HDLesbBO7uT3u5ERKZVFFuLyN5yMHJR+?=
 =?us-ascii?Q?C5mEsDHB+Zl4vrgwjHJz4Tj/QIeVbAp2dN3JmcmxyC+lbrK3VfLkHi5lctLG?=
 =?us-ascii?Q?KcR2+r5BpRO7GL/qO8guW/gjC+iONMR4Ex2K+V1sOvGSInBGmqcrJ+Y0LPM2?=
 =?us-ascii?Q?/hB5y03HKvKK7BW1oIOnnofXAOmnb8sGNVE15n0zWdArwA/RZ/OvYG2A49t6?=
 =?us-ascii?Q?JyRj33QWQnV7qGvVtvDfOxY0D6YW8dfBK53kNbldhiP2Eyna3Ln0qHrOwDIa?=
 =?us-ascii?Q?I5+iBxkaF/gtFT/YxRqzgIchtUT8QazIZvNPrqU09QZ5fzBK/MGXxxjseX8M?=
 =?us-ascii?Q?rLHaKIvue0yJy5nYN2ofoy1vJx/TTWLZKKG6si3ibUj8o19AW+MP5uHLiLWf?=
 =?us-ascii?Q?LnlddAN45BNlIvqqUe+8BEkQiVu6A8/IkoSVKOaZ7TvfO2E5WQclGCm8eEjF?=
 =?us-ascii?Q?Bf9AWKXanLU+mu+758H2BtAWGDlHoL6okVmZtZgqoyzmpyz5MnFkFD2BmaGV?=
 =?us-ascii?Q?vFTqHtYkvmeidKZGnlmQiKmVpY2+49KtZE06mcbWc3NCdWVmZksJoPwrMGdL?=
 =?us-ascii?Q?hkKFXZDg1+ZDBiAvrVQ/HzkW9AqcqKXna8pxPPTUHFn5/ONsMcXL7KFuO2vs?=
 =?us-ascii?Q?SqrDHge6aP+IRuKAWtw/slfg3JjO7sIVgWZVYT15LjSW6+HBc9Y37n7nrwDm?=
 =?us-ascii?Q?pTlISo9DPDzQ6MwvhEXbUWVwlvgg8EsSt/9Z+2b/syPe48H81TzMUiE/02Gc?=
 =?us-ascii?Q?2ek9msoP0qXwrjbqf5OJ1fSSkYR/B+BrN6VEfueDLkoGzhQySPhIGNcuAHtY?=
 =?us-ascii?Q?LEubSg9KkSYpAwrDAxuN3sWDZPsIuiz3BbhEsJi/3FbLM/FuULArz238rHjs?=
 =?us-ascii?Q?n7SS7M3INvGyrPTIE4U/Do2HtV2gRnSwXOM2bO6yk6q9wC8i0967AHanzr2f?=
 =?us-ascii?Q?/GMhe5HLzoEwdWiXNji8m5t7EbMXfUkqO48CGS1ymyoD2W7n/DhAkT8KiHJp?=
 =?us-ascii?Q?s2wFIcVHogDYSHYFfqISJDdOpiEPoeJXT1WGce0IbRLCA3Tyg4H7Fp0SwaPi?=
 =?us-ascii?Q?PPJRccmLqbYGS6GaLc4i3yXpj+/ZzU1piRM6SetrCNo5dM9g8PcDvk64cdGB?=
 =?us-ascii?Q?/3leLwe/uwFPzAGumOXqPnOPBJ4NiabCQZTxXQORWbUa/+3WmaQWE283NxqP?=
 =?us-ascii?Q?Vficr9JhnOpjbrhznetCtEIUIm4YT909YQQMkTCk1NxHYjsHYlrIdzYxFQ73?=
 =?us-ascii?Q?AT4359pqhF/ZA786/U2qr1bDc66PO38EsYF78xYH5IkERRu5eF619IrOHM07?=
 =?us-ascii?Q?KdBACVwZIZ4QRGmYUDD0j+pzfpYf0CKv7XIQDr0u8RBqxi17S6wq2Ug3ma6F?=
 =?us-ascii?Q?kZQXxx/KLY5LmAbd9FoV+3yr4OKmz19S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?90sj1KnkW7qnqkdhzuyJIC794MxQJp+skB3wl57eIbflveTDhKyzfbLTM2Ap?=
 =?us-ascii?Q?Wh07O/T2cswopMZu7oaSc0kkXvFUfBI/ZuKb0CGirJbtlPYLAiOOIuOvWPxZ?=
 =?us-ascii?Q?kc8tpBOFllTeTI1F8VQj010QG4GG1qFe0g7Srx2PXPzPNq9REa6xjlqOtRsK?=
 =?us-ascii?Q?pTiZE9lFmTwH9O62AVTxSIUmUsSPjFa/4TBQnxfkMWP1xZs+EqMoTRoxah04?=
 =?us-ascii?Q?r26tRXcUUqPlhuK1eCdikEyxKHj+2SNvRFZMyyUHXucI8EjCKLbnhvuPdgLN?=
 =?us-ascii?Q?dznFbeWRwGxCAkQbh0jcBTHQRU7SjilwIZex4aTrrQSSiiKJuh60wp2TL7mm?=
 =?us-ascii?Q?oxJ3u2rxheVzJGRwcurh3sWw2Er/d3OgfkmNMmhRuYU9j8D61dEx9iXrPBcp?=
 =?us-ascii?Q?z4cxaJTqbGeOt9r+3P0qRMFsmDgLLv8PAV9CS1pLnQoCvySJTu9m4LLo9MRW?=
 =?us-ascii?Q?EdGY8Qc7hjwzGkBxyW9rmb7I6XOfNdlIOSuCmABJ3QQVve7qEw9Ns6SXilLS?=
 =?us-ascii?Q?YGPnvyuL/fVhX29E4wB38RSzaxlPMssTVQfUBUqCdGeRquVKro+XH8KoQ0WD?=
 =?us-ascii?Q?jY2XmVjrqQIclaGlcg1tutavOotLMm3KKeXf17oBRRISUavdrM7xeFi4Vgbq?=
 =?us-ascii?Q?TsvMyHAIs3dDNidvWDblo4kIxOAoQ/6wyGjhNtsoO3n2mIgatmutNjk8zB6K?=
 =?us-ascii?Q?y8MtGnOWTWD0DNHBFC+B+xjsC5eqV1JXFcxJqtUxTF8trd3QPFaKtMvKosj9?=
 =?us-ascii?Q?YyWKQS3r/d16ekgOSKmnxMUbCnmVm8k/IjN3m5snujDi4otUd6ACRrUlBcys?=
 =?us-ascii?Q?ya59TCHOBj2VXEpUhiZWdRe/dkmhXlUhX9VIuiYdb50TWqAmCZAOJzA2Y03w?=
 =?us-ascii?Q?7qIIly/Uh1MoJV0hZUL8GbM5tmHTVnfmWYcPLq+g1DgNKBLdx9XpRnhyKddg?=
 =?us-ascii?Q?IwiYaC0KfoxUFbmsa0n7fcXcgpdDgkmSvJukMlWayr2XPHSIXAdHbM3XNlmN?=
 =?us-ascii?Q?n4bwJNInzVjTsfFKPCyp4CIu7hZ2uF3l3LsOK9CaTRuEtUVQW6wZBybKF98Z?=
 =?us-ascii?Q?W8B+0W5ZmPLbDFp5hV2Y8odYNv9PPFmpcuK0eVetEyB/xS1uxjsJ5yKGdR2z?=
 =?us-ascii?Q?aUxe88ifG0YximhHlK3urKykOgmsE4+e6FZDDZFxa96FJzMgb2A4AgGT+3CL?=
 =?us-ascii?Q?LlFXDjFouC49aYAM/X4E/Acl3VyyOpd7uaqHiLNjz5fu9EHru1OdUgeFF3C6?=
 =?us-ascii?Q?aU0lVVSR1WPhyIQVo7jyKKTKrI9zm8p+vZOVBZziq+i1AGQR5kiuGnyOkxVG?=
 =?us-ascii?Q?+99wZSR+7Kvv/kacUui2lK9iHL9RjCSTIRToub+3GXPs+REcMqApe3lmoqKl?=
 =?us-ascii?Q?KsXBbbX1pbAdqwzfImkJuiinzuJSsoujxMWPMgM/E501efBW0kAHUG8Uka/w?=
 =?us-ascii?Q?2eNR4o4qdWtD/QHR0teW6u2h9ioVsXQUCT4hE4+kRoVonHRgNDYyYLedyOWA?=
 =?us-ascii?Q?eu87y+azqMQ2nH6V0G3rVedZrGgFTP8zpwvQ57JybACRQL42v7YRtbQCRrcI?=
 =?us-ascii?Q?1nAUmSMoZdpCY8jeAZathXOjDiXC8cbz/qfkZFfu29ALoc0dPdyn7Np4bfwa?=
 =?us-ascii?Q?erTGnDMG1Ud3I+aGZxPnpZGJfNDWgTZ1BE/rdlk1dvKAmi24CV+y9FnBSzo3?=
 =?us-ascii?Q?/TMHZUzi6wYACJFlVNiEgOXg2CWKGs4gqChzmncREutFsSkiQjhWZxsKJ23J?=
 =?us-ascii?Q?98fvQDFZQw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oBMaLw5ZVxRuUTEEoat9ZziLCEXhIVa2zrHfMfLciredMmZQldL2DYVL585QIJhDZkWTmnDWhpgyNHk/zip3X/1D5loRWsdHafXE3e2WAz8kmURXVSV9wLXo2iUSxoX7Q4bJ37wYIUGIA/uu9wUSZ0RhefCvSW4bBMnjHBkCEHzM0UYzufm0CK4jK5mxKVh26J9OqUN9aGqzMoTlEINu2NnNtKg8ZuL0MtWwawW+wZTWGMtcEnapBRdVFb4cv8ZF5LZQ1hMG1VrbsTtNcZdh2tIquTf0iXfJJGGztS2DyR86QLkYl1B71Zxmhez+HZBcwUf5hTyUtQP3mkbXw6lHfkJhBZRsYHyNXQRhF5hgQ2jdRojA/yHcu4Pog+I0PZaOv4jKgFUo5QAgUUb2MMUF4c4StNh+2IZLrP3qBMU3qeKBZ7Wd3Kksv0KpaY93764P4oNtsUcOHnv3KqQ4HZG3mTJoLSS+14mNDYXx48c3ZIck2OXY8z7idcu9pWHMiTk6/EAorBgf3CIOEN3mD21jODKoyqen7Z1cowzbbQ4uYVSkH0+FG3CuzM1xMouU4V38ORX0bOejwFyeU01Hu1fP6IVbBmlNGEPsaejgyUBuoMo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8be667e-827e-4772-8e85-08de526ba813
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 06:19:07.0632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhsvXNYgSvydXNKEsX5H4ESx2ARO9AMUVYr/L2j6UU7g7Uthm4P78c82xj5EdZ58PDG+g6zVc/HpVovlqQb//Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601130050
X-Proofpoint-GUID: RkV0KfRqG6a5kyejQEoOCC9KhTZjVx6G
X-Proofpoint-ORIG-GUID: RkV0KfRqG6a5kyejQEoOCC9KhTZjVx6G
X-Authority-Analysis: v=2.4 cv=ZtLg6t7G c=1 sm=1 tr=0 ts=6965e3de cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=ZR5oq3Xs8z6_6OyQXH4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1MCBTYWx0ZWRfX+dgdsrCcvTC3
 afkAczwEgrrYpxmzSBiDXwlkq+YwqyouR4yCM242kELiIkuUFz+8TpuLUcjl8Rd7qCuNNlmx0Ue
 tNj820hDthE190f5G5HRJ+PIeWpohH8m2c6GXtd+SLVxDmnJ6+Iq0utDbD6tB9pBYIsGbq8OR7C
 yTQAi/xefASUqrbFhz2teni4Cm4h72Ra0c+R+KWZT8/LVGCx3Xm7JBkypLKSt89SvcNv40E1jV6
 BloBU28bLHIdzpWe/5gLRoZlNdJdvI1IDE//P+OS9qfDIR/fisGJp/wOI5w9KfHNrsAaEj/bBVY
 2EYIHhEhdk/ZKV0G5B1p0cSYD7Qk/iDFcK3pueUU+7JVImfZYf84ULE5JcgonN5x7UQUUF2Pz57
 8JXhMeFeTgOYWFyKiQWaW9/YnckZfQR8+P8s10ZSu4GK43oyY5iYc6G+A6fRn23GfSnPPxnHQMy
 0bbNnMXnq+mNZJcuL2g==

Currently, the slab allocator assumes that slab->obj_exts is a pointer
to an array of struct slabobj_ext objects. However, to support storage
methods where struct slabobj_ext is embedded within objects, the slab
allocator should not make this assumption. Instead of directly
dereferencing the slabobj_exts array, abstract access to
struct slabobj_ext via helper functions.

Introduce a new API slabobj_ext metadata access:

  slab_obj_ext(slab, obj_exts, index) - returns the pointer to
  struct slabobj_ext element at the given index.

Directly dereferencing the return value of slab_obj_exts() is no longer
allowed. Instead, slab_obj_ext() must always be used to access
individual struct slabobj_ext objects.

Convert all users to use these APIs.
No functional changes intended.

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/memcontrol.c | 23 ++++++++++++++++-------
 mm/slab.h       | 43 +++++++++++++++++++++++++++++++++++++------
 mm/slub.c       | 45 ++++++++++++++++++++++++++-------------------
 3 files changed, 79 insertions(+), 32 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index be810c1fbfc3..fd9105a953b0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2596,7 +2596,8 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
 	 * Memcg membership data for each individual object is saved in
 	 * slab->obj_exts.
 	 */
-	struct slabobj_ext *obj_exts;
+	unsigned long obj_exts;
+	struct slabobj_ext *obj_ext;
 	unsigned int off;
 
 	obj_exts = slab_obj_exts(slab);
@@ -2604,8 +2605,9 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
 		return NULL;
 
 	off = obj_to_index(slab->slab_cache, slab, p);
-	if (obj_exts[off].objcg)
-		return obj_cgroup_memcg(obj_exts[off].objcg);
+	obj_ext = slab_obj_ext(slab, obj_exts, off);
+	if (obj_ext->objcg)
+		return obj_cgroup_memcg(obj_ext->objcg);
 
 	return NULL;
 }
@@ -3191,6 +3193,9 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 	}
 
 	for (i = 0; i < size; i++) {
+		unsigned long obj_exts;
+		struct slabobj_ext *obj_ext;
+
 		slab = virt_to_slab(p[i]);
 
 		if (!slab_obj_exts(slab) &&
@@ -3213,29 +3218,33 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 					slab_pgdat(slab), cache_vmstat_idx(s)))
 			return false;
 
+		obj_exts = slab_obj_exts(slab);
 		off = obj_to_index(s, slab, p[i]);
+		obj_ext = slab_obj_ext(slab, obj_exts, off);
 		obj_cgroup_get(objcg);
-		slab_obj_exts(slab)[off].objcg = objcg;
+		obj_ext->objcg = objcg;
 	}
 
 	return true;
 }
 
 void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-			    void **p, int objects, struct slabobj_ext *obj_exts)
+			    void **p, int objects, unsigned long obj_exts)
 {
 	size_t obj_size = obj_full_size(s);
 
 	for (int i = 0; i < objects; i++) {
 		struct obj_cgroup *objcg;
+		struct slabobj_ext *obj_ext;
 		unsigned int off;
 
 		off = obj_to_index(s, slab, p[i]);
-		objcg = obj_exts[off].objcg;
+		obj_ext = slab_obj_ext(slab, obj_exts, off);
+		objcg = obj_ext->objcg;
 		if (!objcg)
 			continue;
 
-		obj_exts[off].objcg = NULL;
+		obj_ext->objcg = NULL;
 		refill_obj_stock(objcg, obj_size, true, -obj_size,
 				 slab_pgdat(slab), cache_vmstat_idx(s));
 		obj_cgroup_put(objcg);
diff --git a/mm/slab.h b/mm/slab.h
index e767aa7e91b0..dd23d861a8d1 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -509,10 +509,12 @@ static inline bool slab_in_kunit_test(void) { return false; }
  * associated with a slab.
  * @slab: a pointer to the slab struct
  *
- * Returns a pointer to the object extension vector associated with the slab,
- * or NULL if no such vector has been associated yet.
+ * Returns the address of the object extension vector associated with the slab,
+ * or zero if no such vector has been associated yet.
+ * Do not dereference the return value directly; use slab_obj_ext() to access
+ * its elements.
  */
-static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
+static inline unsigned long slab_obj_exts(struct slab *slab)
 {
 	unsigned long obj_exts = READ_ONCE(slab->obj_exts);
 
@@ -525,7 +527,29 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 		       obj_exts != OBJEXTS_ALLOC_FAIL, slab_page(slab));
 	VM_BUG_ON_PAGE(obj_exts & MEMCG_DATA_KMEM, slab_page(slab));
 #endif
-	return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
+
+	return obj_exts & ~OBJEXTS_FLAGS_MASK;
+}
+
+/*
+ * slab_obj_ext - get the pointer to the slab object extension metadata
+ * associated with an object in a slab.
+ * @slab: a pointer to the slab struct
+ * @obj_exts: a pointer to the object extension vector
+ * @index: an index of the object
+ *
+ * Returns a pointer to the object extension associated with the object.
+ */
+static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
+					       unsigned long obj_exts,
+					       unsigned int index)
+{
+	struct slabobj_ext *obj_ext;
+
+	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
+
+	obj_ext = (struct slabobj_ext *)obj_exts;
+	return &obj_ext[index];
 }
 
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
@@ -533,7 +557,14 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 
 #else /* CONFIG_SLAB_OBJ_EXT */
 
-static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
+static inline unsigned long slab_obj_exts(struct slab *slab)
+{
+	return 0;
+}
+
+static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
+					       unsigned long obj_exts,
+					       unsigned int index)
 {
 	return NULL;
 }
@@ -550,7 +581,7 @@ static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
 bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 				  gfp_t flags, size_t size, void **p);
 void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
-			    void **p, int objects, struct slabobj_ext *obj_exts);
+			    void **p, int objects, unsigned long obj_exts);
 #endif
 
 void kvfree_rcu_cb(struct rcu_head *head);
diff --git a/mm/slub.c b/mm/slub.c
index 5f75e0d5cf16..7c855b84e9e2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2058,7 +2058,7 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 
 static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 {
-	struct slabobj_ext *slab_exts;
+	unsigned long slab_exts;
 	struct slab *obj_exts_slab;
 
 	obj_exts_slab = virt_to_slab(obj_exts);
@@ -2066,13 +2066,15 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 	if (slab_exts) {
 		unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
 						 obj_exts_slab, obj_exts);
+		struct slabobj_ext *ext = slab_obj_ext(obj_exts_slab,
+						       slab_exts, offs);
 
-		if (unlikely(is_codetag_empty(&slab_exts[offs].ref)))
+		if (unlikely(is_codetag_empty(ext->ref)))
 			return;
 
 		/* codetag should be NULL here */
-		WARN_ON(slab_exts[offs].ref.ct);
-		set_codetag_empty(&slab_exts[offs].ref);
+		WARN_ON(ext->ref.ct);
+		set_codetag_empty(&ext->ref);
 	}
 }
 
@@ -2194,7 +2196,7 @@ static inline void free_slab_obj_exts(struct slab *slab)
 {
 	struct slabobj_ext *obj_exts;
 
-	obj_exts = slab_obj_exts(slab);
+	obj_exts = (struct slabobj_ext *)slab_obj_exts(slab);
 	if (!obj_exts) {
 		/*
 		 * If obj_exts allocation failed, slab->obj_exts is set to
@@ -2241,26 +2243,29 @@ static inline void free_slab_obj_exts(struct slab *slab)
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
 static inline struct slabobj_ext *
-prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
+prepare_slab_obj_ext_hook(struct kmem_cache *s, gfp_t flags, void *p)
 {
 	struct slab *slab;
+	unsigned long obj_exts;
 
 	slab = virt_to_slab(p);
-	if (!slab_obj_exts(slab) &&
+	obj_exts = slab_obj_exts(slab);
+	if (!obj_exts &&
 	    alloc_slab_obj_exts(slab, s, flags, false)) {
 		pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
 			     __func__, s->name);
 		return NULL;
 	}
 
-	return slab_obj_exts(slab) + obj_to_index(s, slab, p);
+	obj_exts = slab_obj_exts(slab);
+	return slab_obj_ext(slab, obj_exts, obj_to_index(s, slab, p));
 }
 
 /* Should be called only if mem_alloc_profiling_enabled() */
 static noinline void
 __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 {
-	struct slabobj_ext *obj_exts;
+	struct slabobj_ext *obj_ext;
 
 	if (!object)
 		return;
@@ -2271,14 +2276,14 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 	if (flags & __GFP_NO_OBJ_EXT)
 		return;
 
-	obj_exts = prepare_slab_obj_exts_hook(s, flags, object);
+	obj_ext = prepare_slab_obj_ext_hook(s, flags, object);
 	/*
 	 * Currently obj_exts is used only for allocation profiling.
 	 * If other users appear then mem_alloc_profiling_enabled()
 	 * check should be added before alloc_tag_add().
 	 */
-	if (likely(obj_exts))
-		alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
+	if (likely(obj_ext))
+		alloc_tag_add(&obj_ext->ref, current->alloc_tag, s->size);
 	else
 		alloc_tag_set_inaccurate(current->alloc_tag);
 }
@@ -2295,8 +2300,8 @@ static noinline void
 __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 			       int objects)
 {
-	struct slabobj_ext *obj_exts;
 	int i;
+	unsigned long obj_exts;
 
 	/* slab->obj_exts might not be NULL if it was created for MEMCG accounting. */
 	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
@@ -2309,7 +2314,7 @@ __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p
 	for (i = 0; i < objects; i++) {
 		unsigned int off = obj_to_index(s, slab, p[i]);
 
-		alloc_tag_sub(&obj_exts[off].ref, s->size);
+		alloc_tag_sub(&slab_obj_ext(slab, obj_exts, off)->ref, s->size);
 	}
 }
 
@@ -2368,7 +2373,7 @@ static __fastpath_inline
 void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 			  int objects)
 {
-	struct slabobj_ext *obj_exts;
+	unsigned long obj_exts;
 
 	if (!memcg_kmem_online())
 		return;
@@ -2383,7 +2388,8 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 static __fastpath_inline
 bool memcg_slab_post_charge(void *p, gfp_t flags)
 {
-	struct slabobj_ext *slab_exts;
+	unsigned long obj_exts;
+	struct slabobj_ext *obj_ext;
 	struct kmem_cache *s;
 	struct page *page;
 	struct slab *slab;
@@ -2424,10 +2430,11 @@ bool memcg_slab_post_charge(void *p, gfp_t flags)
 		return true;
 
 	/* Ignore already charged objects. */
-	slab_exts = slab_obj_exts(slab);
-	if (slab_exts) {
+	obj_exts = slab_obj_exts(slab);
+	if (obj_exts) {
 		off = obj_to_index(s, slab, p);
-		if (unlikely(slab_exts[off].objcg))
+		obj_ext = slab_obj_ext(slab, obj_exts, off);
+		if (unlikely(obj_ext->objcg))
 			return true;
 	}
 
-- 
2.43.0


