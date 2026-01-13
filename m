Return-Path: <cgroups+bounces-13154-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 344E4D191BC
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 14:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F452301461C
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35A53803F8;
	Tue, 13 Jan 2026 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qTDIfiV4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ERWYey3L"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22F4299949;
	Tue, 13 Jan 2026 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768311164; cv=fail; b=F/bHBL51ANJCrDx9DJZUzNikAgoVqZnHECnauouluzPo940lNj7I0fiouLBze2m2RpAjy6pNUE2RqKjwQYb8mjZEM4ul8j9bmHa688PO1WvpCNbMI1yibc0KBv7VqzY9DaF6qIboXulFLTtsrMSnl7pENdPEssSxAl2GnywWV3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768311164; c=relaxed/simple;
	bh=Rg13d+XP0GekpUMLapr5XBRyvP5YNqrOXIOKRFusre8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d1rlIXiP1uRwDjuUZ815I2dw+1uIBBRLMHrBImkc5Rd8wuAu/upVu/mMjzhnH77gZDlrkO0ZpSgslEm324wQlWam4YhT/li6r2TNqOEMPswDsCPU7x75oTWIWAyPSpPjVFQrChIy7X8MNA/VIvwV44ofqvRoRjyg0a/bEIyQa8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qTDIfiV4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ERWYey3L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D3JX4b2887789;
	Tue, 13 Jan 2026 13:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ngqctQ6tnR+Fe3SOg+
	ltJO6OGV6b7q1xtcEJNR8XCjk=; b=qTDIfiV4rScN4Oy8pLkQWiQOd/fs1nvrv4
	cNH3WcDY/0XR0F/u+fZHKESfVz6/JddykLpx/bYkT+JZofCH94QsA0zkJms5rkbC
	0b7PZgcMSWCptRF4/WT8iyAZ1wUGxAfKO7e30Gl5M+OraztWIF8/5+ot1a7MlnUz
	OLfRV3Vz5xLRcsqgJBJaDBr5pNaElbwD9pjmhNHbE29o6yQSL3XEw08VfohBSnfP
	Su+ffxStbiN5eSNtUXy5keONfb2q6aKFlkJ/zhbRQZb6jGidLAOrqG96PbqUmu+r
	xDW4wVlbo3jdK9aRg1wE74ZHb7kxigBKfYy1JLvwWuMJYR8n2gLQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkrr8bbyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 13:32:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60DD9r89035569;
	Tue, 13 Jan 2026 13:32:22 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd78r1km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 13:32:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAYWe3m7zh/MtrJ3vgY8nqWa50og9/X1ViWOd9ltC0Fo3kdn6a7J1Ran7mZNCi/6wu2QqxxsgK4LUiguDoWx/KWzd7tKah9ZMnQYF8UAcj7U9zcWRR1bdYTfFXoLSkeglev2pZCW/3g3v43I5FBMIXDnSBsXjTUnP6l4asVlZaDV+8XhHMIaHywWpTBGIQ8WhfRWvSBG94vPVksCgEgt2JtfTJB4SikoXbnMfp7gxjw3px6JjoF3yjP1w6NkPRtc96PfCi/VRCZk+q7kiaWM86o5kgWN7hZ6k5WCeAjcbMNJwfcnkVum1wVXBTPcJKhf9szrDL45QcsLAqeH3WIJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngqctQ6tnR+Fe3SOg+ltJO6OGV6b7q1xtcEJNR8XCjk=;
 b=IfabE8UV2mExmU7HosYjXIVhalhTz8SHSmMjH0KUi4lsow/P3JADSxVuZPxmzv25XSw1ulC7wHIWkm19Zon7o1LnGoymTXoVJdAA2tezeTg5wyf0xuxM78igaFnK104yvehcgY2rTe6oPDBhncopPFgtJvmRs5cJ4fqCLN0ZFBWnnnoJjgepQ61aJ7m115pvZj7ojfOlHpMmldm6CruEH4yaM9KQbP3u5uwtXrbNFdwA7OCp0VQRNNx2PQ8F7hRM4SMJFxMpKy9q+veeBqpZW3O5zFsTOxplVF9pcJMsYMEH9RpcfAGp0mfEjCcnh20YB0ZHzVvYGlyspJ3HRKqAIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngqctQ6tnR+Fe3SOg+ltJO6OGV6b7q1xtcEJNR8XCjk=;
 b=ERWYey3LefnBMFTQ69zdVgEnj0fPva1om2mnVxOZbTqdNHe83CUFpIhrhYVAiLGuE2LJyTZUQrBHytkRgRuuySHZ8ToXOj8EDLyTekY3LCf2AQIFBmawvyXnWedcP0JpJPwqL2pxhn8w81PAto4gK78dzUUcIy05QhZg8ndvEvM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SA2PR10MB4699.namprd10.prod.outlook.com (2603:10b6:806:118::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 13:32:19 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 13:32:19 +0000
Date: Tue, 13 Jan 2026 22:32:10 +0900
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
Subject: Re: [PATCH V6 9/9] mm/slab: place slabobj_ext metadata in unused
 space within s->size
Message-ID: <aWZJWkbosy9A_XBD@hyeyoo>
References: <20260113061845.159790-1-harry.yoo@oracle.com>
 <20260113061845.159790-10-harry.yoo@oracle.com>
 <fecd4166-618d-4d69-be02-d9b3e8f0f271@suse.cz>
 <aWZCHIYsFSaGzRYu@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWZCHIYsFSaGzRYu@hyeyoo>
X-ClientProxiedBy: SEWP216CA0007.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SA2PR10MB4699:EE_
X-MS-Office365-Filtering-Correlation-Id: 0059dde4-9b55-484d-838d-08de52a82c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VclDDWZ1UrA7cExYjSV2pMGQHKn3vzWE6dmVseyPQ0nYEBXyczkMsXwL6MwQ?=
 =?us-ascii?Q?NU8UdxWqt9XsFYGz3WbKtGFvJlmo/GGwXH5oga6GpKiI6cZghDTUU6B6WJIi?=
 =?us-ascii?Q?spq0D9T7ktxJHv27Z9iS2JFUPhjVGKJugbGyMU2zs56rD61oeyTFRNqzOgav?=
 =?us-ascii?Q?mCA39NnUws6dmfGK+2oBq8wW4rbeCG1Sc/SN0vDlzckg9MW+yOeeI2sW+NqV?=
 =?us-ascii?Q?MUlex6yzvkjYF9d08Ehs74cO/OoznARa7accXqsexIxIeiPZpr3j4/WaeWi2?=
 =?us-ascii?Q?JiCr7RAcIvyjSU6lOKyFZr1n5WaDFEAbTUc5Sai+6mdRFHQASVDfM95BtzCj?=
 =?us-ascii?Q?tl7ELHAW5CEToaSgI1CSWLs1DY3XpvQvCNMYXD+nk28Hmvi9dGCbMZE2745T?=
 =?us-ascii?Q?hfqHjaHHKrY1d4qG5M4wBq2OwHuXlkIkDiTvBMYF4LrjY1xDPaZmks7sWAOl?=
 =?us-ascii?Q?u0d3L9by6nNI+qPQfu2gRd0bs968G/fAleJAri+kTax+P1gabfpRdWK40DQf?=
 =?us-ascii?Q?U8IUxlTw/Hzuf5Gs0cNpTRBw3mspdOV9CM2JJGHlckCGINjdo+w6Xwmaatqz?=
 =?us-ascii?Q?zhrREadvsj4pfJ9VWR28nC/eIw3L6a8Oqp1QEgWhbtYDUacPg2DluLc8ieQz?=
 =?us-ascii?Q?IBuxGOdAL5qWRyu3+N94Lbo4qGJ93YTC3+DSE516CWDftr6/PO/eP2uq+BoF?=
 =?us-ascii?Q?deZQVApoLony+0Lajv1rEnngQ6Cfe642yCHy/kIy3n7yG2k7/kJ31e2pgSxl?=
 =?us-ascii?Q?tL8wJHgQEDybf17x2DQOmIDIZIrh4BqUYKHLP4PRP8ppWtii2WY5ZU2fM34B?=
 =?us-ascii?Q?bdwVf4053J2K09ich8SNPvgokKoyvks706Yo1jgz62E4k2y5BZL08oKu4GGH?=
 =?us-ascii?Q?vqNp+koadJVZlrTamZuWj/iAuo8f9OPzA0lvv7cpwhCU6g8qAohIyyd0aAx5?=
 =?us-ascii?Q?lkfqOmCXVJlqRcSHvt353z0X/EvoJIcUusD/AbF1zEUHtHshaiD9y+08Vk2p?=
 =?us-ascii?Q?bMphS/vhAIt20Z6c95c7QRGgfUu/rFPAw9rI2HznH4RC5cvX7qhj9hUzrMi8?=
 =?us-ascii?Q?ZFPwAbP6q3u7mhz2nuyHpJ5hv0xBnwVmQ/M/6x8+/+wcJrPos9XBbKt+RbOD?=
 =?us-ascii?Q?luiRNaZFV636wJsvsPczd8pJXYDVVH15YidiJomu2/UoOwRrS1HFk1b+EIUn?=
 =?us-ascii?Q?APuQVg3Ua2LuHl2inGgJF1TbO/zLWcWBmysazOwcXak5+8abPMpf8tVxasvd?=
 =?us-ascii?Q?gPNjeifCKWhCKgqzIWcWz9JOLvkaaMbqytZf18r3I51KX3xwf7VHavsu5c9v?=
 =?us-ascii?Q?/81vaJQAdW+36oYIMNomx/9n9S93OYsxJlEFmk4QYldZRruW7HBaV2Y6HjFK?=
 =?us-ascii?Q?JFtMwlhSSq0T5ird8fb7lMcuxZv8odTTeu4oSqseVKvZg1gu5S6jPBhg2e63?=
 =?us-ascii?Q?wJGocMNmInCJuW+vS2nzluXSm8BquLuB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e2RcIUQm1eJXe8DzTd7yzQXibhAXyRecrBtcJnJpyklvLE/S6l8OUFztuf6j?=
 =?us-ascii?Q?F9iMiVcdyOH58WARaShzGm1EC0uG/KvtLUs3gSt63lzOLxYioeSxibK1m0Ui?=
 =?us-ascii?Q?oVW1VQYzCOoLIdkvDIUkpsTeFRvHBi1puLxP81hewu7+iiXAuKxM7bsf1hBq?=
 =?us-ascii?Q?vRm4k9vO+NI913P+oTWOrLidehb36KYs8uomO0x6G5+U06NkL7vtCoYiNIpu?=
 =?us-ascii?Q?Vxaf6prsVLZaEK/2IeDfF79R7Cy1K5pFLe3fquvDXSSgKn7O5xlYPBB+Dd67?=
 =?us-ascii?Q?yk6YaQ+frcaAaiJ249Os1bKBx9lAq4DfEQDr1q1sraThu3JO/Ovzr76Wde53?=
 =?us-ascii?Q?aVlWCuF0ahfKUuR8kCo1ImibVVaDnsz2Jn6+6CI+szFxAwNA3dy3hEEjukLU?=
 =?us-ascii?Q?4pG3Dl1e0nflArB8X26QXdbSIBIib+ZD5y80SqJmyVGENCpSBEBEuX+39STO?=
 =?us-ascii?Q?CSigzU8pMw8plD6IBVcKRZC6KeRP3ZZtFga1vZT+2z12QHp+7j+BoZ0TMf3M?=
 =?us-ascii?Q?+7JZD3q4vXgquR8cG4AM77YE3agyalV795hb3wi7WGsHjqma8szJmuxyNL6p?=
 =?us-ascii?Q?suS9ljpd2q9pz+w+/UDNYacetiZqn+qdlSQ3ziYL2Cg2q9H7GFbrzvHYxHLc?=
 =?us-ascii?Q?sB3n0C29a5uM8IlbJbB+vukygjhze1GXLTmYlAOGyBGYGcIiDZj7Xu/ZCN1a?=
 =?us-ascii?Q?tKYVNef8UF0gIpsR5REHCbe1wZJtGPY7wHbKHuyKi6cayNYmPw9srQu/Ob4n?=
 =?us-ascii?Q?kLOv+wjnyLrmiKkfTQkl6uCcBKfmC8HinkHfyJLiMgiO+/ToCDcWxvzHLQbW?=
 =?us-ascii?Q?bzhQCMevGTfWhe1WrlGFYrdh9q79GrqNV1Cg6AggdTdeGGRvyVFFf1W7EIib?=
 =?us-ascii?Q?6K8gAhHZ5rxAxMpsHlZUOrxXId4t+ddBrL/sQTq6Qx6gonXJLUuaS+PtF17O?=
 =?us-ascii?Q?zPVEBA4K2gkD0jpQVcbFy/YN84IwDG/y2SCerD52fViFwdz1pXIJMyMWVdMN?=
 =?us-ascii?Q?wHfeR2+LKBbIgjslpwRUoQnkMneuEP5IwTbjZbjtgIppNRrGsMnT6e9U1i/z?=
 =?us-ascii?Q?hcdO/SqW1Yx+Vz45dFq/6mXBTIPadDFyn6VdwKvR+Cvi9RPMocv1/nfgUY3k?=
 =?us-ascii?Q?UhZpnORWNZ8pUIxBBs2Fuf+GrdbedW6HTTMh+xgOIpkEpogRkpwpRg9vTTad?=
 =?us-ascii?Q?/0AewMPadSHhoiOAlk86+t8w8W5x8Gqy3rNXBZWxDOYDu9uusU7VpJDf1ixT?=
 =?us-ascii?Q?gccblPs+MJ1+iZQAE9vI24mwhGMqWfQrtd1C9DdKkQ3hf1e826t1925OwqjI?=
 =?us-ascii?Q?Mkn5c+8amOkPkSIF/gQrl21I7Vpieb6vIMsGuibumVIUrLakxUKxcV2QiwFE?=
 =?us-ascii?Q?hrS0KH9GF0bwRgptA6D1z5sgnoCLpn2HVZJBNGaKiKxTCdQi+dN5yAuboiQP?=
 =?us-ascii?Q?ldyyjsmoQoRT8oaZ9NxqRvcDsrm2lyS9bW0zVhdsESCizO5MLze3IIPpiXI7?=
 =?us-ascii?Q?3UEFKVmLLf3lilPxOI59vsXb4Eaja7GIWdo5meRYOipKkvnAZClcmWEQtkBB?=
 =?us-ascii?Q?/7L/MfNt8jjyGp6/UVRrt6rCzCJD6u3oIHVHvEmqWFeKvWsPbijuKWAfMQv+?=
 =?us-ascii?Q?orM4nRP4fI6PYsPdQUgLoRXnN+EMjPVWWhERRNW4aMxVMomrQQ5TQUw99aUz?=
 =?us-ascii?Q?JuDhoNfJ1Y49pau8bNBE+VmWVyhvgLzvn1yocD7MF0ro+ZRA5NbTMRVlisf7?=
 =?us-ascii?Q?rB1GF0uTrA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8KE10eSewHIGfSrqhfof3cj4XZyuPHKzqQuEAsJ1rj8NHLIW7p+vd9QeRW4xlX7TJq5yxHR0FvJ5JVek4vnR3WMT9PkLAsGmxOmJOKfgxOSfkJLDvJqEN3WKe7F4mKcGljrcuyvwu/E2CjujL+NV5oCgAcFjMw1GpPjPaWoAKZvdOXB/sovPGcFkWHX3G4wDaHisKiuRY+FZd3xesT2c3wf/sSZfZaeafKPOPJG+VkxerfiCSyMqB/HGyrqbk2fqVVRUmtazqElv4JweFznO/tLXVCC34HnkQId0EU7cMhUnS/PehKuBC0dc2l5/cvEWjON2sQ/HBaijoNB59x7j8p/gAWJqyh4HRBDTV4gVgNLZV2Yipusand6HVhztEP+3/vpXAhknk3JAecY1HM4xohE5iCnO2uTjfOm+LrFGXfG78Fs7UrxsklvFSHasfc8q+zwwr0r5lREkUYv+XhoJOtZZrIzQ1X3dbxKOjxrSoxKgy9x0Dgs9cdcXJ+4dzw+v713o41007UfEZ3lN253HtRja60g45AT0YeAw1PiFArEXnJJy572fVuEfujGL01tqCs02gE5kQNynqHjOBleVGPUPyAZX2F0NZd1dCmBao3I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0059dde4-9b55-484d-838d-08de52a82c66
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 13:32:18.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjnGjiDJn6T/weA+DPHsb1ZnHK40JSL6B+El+f2aiFSRKIyMmJ1c4Df0Tswg7qh4yzgEJvcVdvK8ikaSY/EXnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601130113
X-Proofpoint-ORIG-GUID: XwmctUvanlzlHTnX5qGdvm7VIDDmfBwU
X-Proofpoint-GUID: XwmctUvanlzlHTnX5qGdvm7VIDDmfBwU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDExNCBTYWx0ZWRfX1JVlWJ8T4Etj
 jEGQZDXGW6ytBueAsr0noonkofKhAW7QAEk2ZBSvDMOXhtCsyqxp5c9fmTYcw0DYuISLqoo501z
 zYSObUkz4jnFvPeI7GuIHPHpIjslziFOW4cg9npzuAFFAg6rJteTMnFXL/zFdo+TFWeT7TMH5ll
 CJ8GIYuNizDwI72Gn3i4qIdKeOtbliMWn5WGfcv8o8nEUkGeFDSkiYBHLMXImUn40gow0FBkmj4
 IB1J3W63RK+oZSXgr8TqnkmnMDEEKOJKtjHFVkb8rBLQC79Di0EmDLC9lX3iUkWnW60UCIe9oPa
 GyitjBrNE57DWEwj1LCig+g3t2ilvllSZSo24YiFhNY8wUZZEeDoYMBdsZHk/i7PG55XxXwjzQG
 +pgj7HpOFoFbZKpjr6Lw6e//ku0IAzIeZFhpGRqYfXHZM+cGWq5xdW3fPnL082ulIVYb6Z+G8IM
 WFRVGEicKGirqBe6KpA==
X-Authority-Analysis: v=2.4 cv=QIllhwLL c=1 sm=1 tr=0 ts=69664967 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=7LbxQGxfWPbL_NtSuDMA:9 a=CjuIK1q_8ugA:10

On Tue, Jan 13, 2026 at 10:01:16PM +0900, Harry Yoo wrote:
> On Tue, Jan 13, 2026 at 01:50:31PM +0100, Vlastimil Babka wrote:
> > On 1/13/26 7:18 AM, Harry Yoo wrote:
> > > When a cache has high s->align value and s->object_size is not aligned
> > > to it, each object ends up with some unused space because of alignment.
> > > If this wasted space is big enough, we can use it to store the
> > > slabobj_ext metadata instead of wasting it.
> > > 
> > > On my system, this happens with caches like kmem_cache, mm_struct, pid,
> > > task_struct, sighand_cache, xfs_inode, and others.
> > > 
> > > To place the slabobj_ext metadata within each object, the existing
> > > slab_obj_ext() logic can still be used by setting:
> > > 
> > >   - slab->obj_exts = slab_address(slab) + (slabobj_ext offset)
> > >   - stride = s->size
> > > 
> > > slab_obj_ext() doesn't need know where the metadata is stored,
> > > so this method works without adding extra overhead to slab_obj_ext().
> > > 
> > > A good example benefiting from this optimization is xfs_inode
> > > (object_size: 992, align: 64). To measure memory savings, 2 millions of
> > > files were created on XFS.
> > > 
> > > [ MEMCG=y, MEM_ALLOC_PROFILING=n ]
> > > 
> > > Before patch (creating ~2.64M directories on xfs):
> > >   Slab:            5175976 kB
> > >   SReclaimable:    3837524 kB
> > >   SUnreclaim:      1338452 kB
> > > 
> > > After patch (creating ~2.64M directories on xfs):
> > >   Slab:            5152912 kB
> > >   SReclaimable:    3838568 kB
> > >   SUnreclaim:      1314344 kB (-23.54 MiB)
> > > 
> > > Enjoy the memory savings!
> > > 
> > > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > 
> > Does this look OK to you or was there a reason you didn't do it? :)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index ba15df4ca417..deb69bd9646a 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -981,8 +981,7 @@ static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
> >  #if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
> >  static bool obj_exts_in_object(struct kmem_cache *s, struct slab *slab)
> >  {
> > -       return obj_exts_in_slab(s, slab) &&
> > -              (slab_get_stride(slab) == s->size);
> > +       return obj_exts_in_slab(s, slab) && (s->flags & SLAB_OBJ_EXT_IN_OBJ);
> 
> There was a reason why I didn't do it :)
> 
> In alloc_slab_obj_exts_early(), when both
> obj_exts_fit_within_slab_leftover() and (s->flags & SLAB_OBJ_EXT_IN_OBJ)
> returns true, it allocates the metadata from the slab's leftover space.
> 
> I noticed it as I saw a slab error in slab_pad_check() complaining that
> the padding area was overwritten, but turned out the problem was
> because obj_exts_in_object() returning true when it shouldn't.

Perhaps a comment like this?

diff --git a/mm/slub.c b/mm/slub.c
index ba15df4ca417..c40c3559039e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -981,6 +981,15 @@ static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
 #if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
 static bool obj_exts_in_object(struct kmem_cache *s, struct slab *slab)
 {
+	/*
+	 * When SLAB_OBJ_EXT_IN_OBJ is set, slabobj_ext metadata can be stored
+	 * in one of two ways:
+	 * 1. As an array in the slab's leftover space (after the last object)
+	 * 2. Inline with each object (within s->size)
+	 *
+	 * The actual placement is determined by the stride size rather than
+	 * the SLAB_OBJ_EXT_IN_OBJ flag itself.
+	 */
 	return obj_exts_in_slab(s, slab) &&
 	       (slab_get_stride(slab) == s->size);
 }

