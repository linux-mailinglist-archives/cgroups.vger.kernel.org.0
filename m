Return-Path: <cgroups+bounces-13131-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE68D16CB6
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 07:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD7FC300F6B8
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 06:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8F7369223;
	Tue, 13 Jan 2026 06:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kD7JNVO6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UqIzZVP9"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661C228B4F0;
	Tue, 13 Jan 2026 06:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285197; cv=fail; b=gNruuZ9Ur2Pgs9X7dHIrXhQPJj8VzpqDHFetkzwayhZiurHmbZKfkjfcAT4mm1iW9cj0UAplcwtPBobeHPujX/7OHk6MAwHB9Fkd6SLdxeDTij4YjF/cAe1NtS4lYCizgbWpEaJNT+9lDZ8Rpjr0Nv/Vo+LpeXk/3EYggJgPj40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285197; c=relaxed/simple;
	bh=htWTjVlKTRTeWPDqukVmZtjJgU9GByl8+dQuUD+R0lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hWanHVuObYwidCdygVSriR2NQ2FjSL/U+ZMeFU1vBDN5bPxQ0xgqefVXDb1zijWk2/mgefvWGTScrr05erJMQ6tjms/dDc6IgsseqFYVba3OrSyza9qhWokhttVBZg/bl+0zK6ljYrREtEny+P7x/KnOzR7zg4g4/+eNmNpOWKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kD7JNVO6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UqIzZVP9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1hE2M2677475;
	Tue, 13 Jan 2026 06:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xhfiwp+MrCpdoeTV5cOsFGGRbQPLILDsQ27JS/GQNYA=; b=
	kD7JNVO6yU+XEVaul0pfUPauAP7ZZYXv4i39xQZFl66LAcFpN9clfvkcEOdEAJD4
	8S/P+SPIeJOEMtlHENRWE/HV17cApJgkcYeyD6IkEo5f2deQD6PfIM5CE6ZmXK2y
	Vv4RLy6/Vb62gYSIV8F4ZEhGohXG2yka2k0JKh5DKz5Et4xscSll1Gx3LeOGVIzk
	go6YAJsf4SZvjceWsnq0D05DJGtEaS6fuMNPPqh97g644m8XJBZLz6b6cvTrNYaf
	Wbv5FBvwJZwCy/tjvulSX6ksFXZvxs/4zcvo5osPdd542//UJtJfOTZl5EQ0ZTUw
	2mHqJes1J3q/ChN6ClHmsQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkrgntwc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:19:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60D5TI0C028706;
	Tue, 13 Jan 2026 06:19:25 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010060.outbound.protection.outlook.com [52.101.193.60])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd78b1qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:19:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKf3VbGQHqEj864mPvuN9UMzoNjNo0AwoVc/Dp1b/eo4w9dKhgRv1E3P1DG4AT36j3wopxl58Q9oK6rcqRSZBtbt2AA+AbFN69pIrNqTVNsUnkZD0e61L8BJ6IItvBh4GDqTuPtod6wvVDgLf92RtwIdstLKtC6AYEst1KN755IcSlM7CCAzTzFXJuSjMCITL8EUFr33s/+HuDM1vpzUGxweXaKL7/JpRxMV+OpM8x4DlsonQyvmPIq0qXnO70a6GQCMnxn2H/VojZwfvlxflgFqsa90FIa4iSPFN8NTOLx0D5OzqA6JH9Or0K8naEVtcsRmIOO7JJnIQudzz6akOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhfiwp+MrCpdoeTV5cOsFGGRbQPLILDsQ27JS/GQNYA=;
 b=CGFszEdSIpW+F8C4xph+gws9hLBEggGmGCvuWtGFXBAAR8chSw6vgUbFJa31AcqUCNN2RoV6G86Z2ZuoPn1kyq09TZ7GoHCLBEf7lUnRyiKlWAKWmFciuwJ4WrNDysUSWMPwbLZRiVex8Gsw/RdQAhWx9WEIZYQl73P+aD6QveSLUrfbajFvrIA3VWsciYKqw4vO4PHvRtIlEFGX8jcFZW/klYxb7k6dFeDIiRwFVq0zZzoU9/LAV8gBYjRTSmc0wh302bqqG4/bnuFn6Hi53dl4NtoOjMPp0+xuCJ2r+AQT4IA3W2QKSdygF9tDXYVboHr6Ul3Qj7gggc57tEn83w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhfiwp+MrCpdoeTV5cOsFGGRbQPLILDsQ27JS/GQNYA=;
 b=UqIzZVP9jWQEi1BJ8ht91qAzjC/Qj97WLhuUhgj3Z+f/tKQw9x/VmiVpPKClRoYHn5rpvXfReXYVH2MffUltkb84WlQjOsg7ic0M4kkcn7NgIWB+SiyfchU3hkCiCgZzPCSsxEud1VmwK7p+v0zPwhVglwMsgi9KUFMp3OI4/cU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 06:19:21 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 06:19:21 +0000
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
Subject: [PATCH V6 8/9] mm/slab: move [__]ksize and slab_ksize() to mm/slub.c
Date: Tue, 13 Jan 2026 15:18:44 +0900
Message-ID: <20260113061845.159790-9-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113061845.159790-1-harry.yoo@oracle.com>
References: <20260113061845.159790-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN4PR10MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: d1481879-1309-4c2d-0e62-08de526bb0f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LKUnHQ4GXQ2k69yrTgIrbcmDbAkAAcDuervXbVbvoK7pSI7yt2qJdU5Y6/Uh?=
 =?us-ascii?Q?u+Lx95C11otWOOMOIXQdNonZMQYLdCq6TmvvvyhbECF7HveizEVqQX7N9OUD?=
 =?us-ascii?Q?qulP+gT5mIRJ4x7BORgM0Fz76cuFf/Co8TYIHSu7fVWcup2eAGHWLzr3SJqN?=
 =?us-ascii?Q?xrPp6d3i3UN1VKg/nt+aZDVyK+JZM6c18cVj/XL2hELNJV8AAmjESmEsWxcA?=
 =?us-ascii?Q?cOetTnJmwG4wleXD64BbLN8NmrNa2LX5i/QUNp3ZCkU095+qrQh0jVAAMAJI?=
 =?us-ascii?Q?qUcAc9fbspIDQ9tzd7tkcmn2X1HgrAJUcgYpV021BHowEV2zPcb8LQqLHtrV?=
 =?us-ascii?Q?RMvBv4AgOIFHz9dp78TxPUMyLsvMgqEWKweeQlGNolSiszZOoUwjC2t1qpa1?=
 =?us-ascii?Q?67JTTg34b1MV2xeDsr4yFzSLT0Tq3geFDJNj+EdpYLdhOCj7pL5rHWH3MEtk?=
 =?us-ascii?Q?6XIiTAM73+u7SkJdurkDTxbdokXg8cMkmfi5pLa7CXZckCSHQSpUPG4ctt3N?=
 =?us-ascii?Q?acgey2RCZ/d34+AjmUXvmGx1RQ0aw3TaD5fV59i2qHNY1MUvvRRe03ztW7TG?=
 =?us-ascii?Q?N1NPLWhf0OOcQ11QyBW/h/1/Iu/xGrHvBJVPy4/K9uCR+27RuP3QHwTXEELD?=
 =?us-ascii?Q?d8gl7k7gP02kRqoPA8mTdJfin+YhF05KZCvq6pdV5bXa7XNxJYGygihtYYcz?=
 =?us-ascii?Q?HfIAdilKoA1WpUCCHNlwfKX3K7DfYJyzjC3QY51gvWMHYq4IWVD9fZr8XmO/?=
 =?us-ascii?Q?POiHXGtK3ARDTP2SocRi4zbdkZUaEvsCejy+t+afkUyI53l+hV/+iMn1Viiw?=
 =?us-ascii?Q?knIFr1CLLaSsZ3JMfiXnu89qBGmtTZNT4wjzdI2CnzZBMpbLDWIvKrmMuk/F?=
 =?us-ascii?Q?+/0L38spLmP0xgrCKKGZPeG68mmyLc1NPHxmncGjdQv2j7zIrYtmZJojNMaB?=
 =?us-ascii?Q?UROMhx+vEJP8WNRrWaZYwuZQ2Tm1Sz06UM7JvUg3K53xcGHwUWDmdVn3o7Ky?=
 =?us-ascii?Q?yy5Aagm1f8RIy2c2hwzBSfeN851BJiUi1PjIzBva2PhTcYjQD6KhB8V7j2OG?=
 =?us-ascii?Q?Vqo9oTWQQ/uXDI56Sdp4CMlXQ4knErBL6r2vSZLxBxqcEyMc4KniolwYA5Os?=
 =?us-ascii?Q?0n7swGhQ7kqrYI0KCfrxo0CN53/hmjiT+fha4UhMgamOoYP1mfC8cN1FjTAL?=
 =?us-ascii?Q?SZwoflnvLXUW4mwHc4Did68V6USK1HKP3vIo4xOkSW3m8COXErlQztUNDdQw?=
 =?us-ascii?Q?IUq6uqGqneHFVKQK3Guc4qp0xLdlnF9cGKobIcaP5LrHX6eO/9nRo9Ls1e0W?=
 =?us-ascii?Q?OhCf8uzJGKoWs0Lk1v6g7xD0YCo3lGnn0qq7ytRciDuVSCWgk2xOAIGdoNab?=
 =?us-ascii?Q?O2PSIQtfZb4QiJIlTxyXRUjPWWRTGwN0O5q5g8qqSEMIYN5dy9QefyBHK4ZY?=
 =?us-ascii?Q?UGpCky5NbPVSEq1l3bCjodjQNMwn7ktO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o1UoNR+YrzfxHmqFJgsQFx9/1sRv1ShTxR4Cx9GtTSu9yT4w6vhd90qMkffT?=
 =?us-ascii?Q?xG59HgzAzFjKE9/Dam4/cL85+q/RygbDlSXkkVW8VD09P4/yAJ0nu7FUMvDE?=
 =?us-ascii?Q?04gA6WpCsdTRa5NPqPIc1slVNIkJQujuNkijc8bLazCSUlH32E0LX1a4GUIR?=
 =?us-ascii?Q?7Zvrm+JQpy+KurC9zv89bnqYs9iMfWbdTKXXD71OCu1MiW986F50rfJkGLon?=
 =?us-ascii?Q?LfHWAHbsd+FqWnARoCA6Z0opTsEUj+5HU5C4/i8Zr0h5oYb994S4uD2Y9GMy?=
 =?us-ascii?Q?61ggH3WBvwrVvvGHLY79jB15/lKMX94k0TPkMJAMLXCImNiYJoHy5zZ6DK3h?=
 =?us-ascii?Q?vHKuQbofj1LfenfL2nGVNL1OwxcnwKYb1cirlvDK+57tjzIIHp5+Ag6hBjqr?=
 =?us-ascii?Q?N9paZSNJ3LS0Xq/372hvGB81jrHRr8h2Y52ZK0/nRS7rKIAKEoUKtQXY0Fgr?=
 =?us-ascii?Q?Hb5hxM6/uiRlGkO9AK1gtQFEwTe2DW514iJqMTG0MHm7fNkVt7GRqBPnLlfa?=
 =?us-ascii?Q?kPyt6CQt1Dqm1GWiL0Kx6sMap99r8zFnitvwzSy0mdOSBDd10JiV+88RbsmY?=
 =?us-ascii?Q?LJ3MOKiXA60IR2HE2FOdxTQFBfTniLHhn7Xceci7/Gl5LpC3QpATdTpPckaO?=
 =?us-ascii?Q?0fX9xPhlzctMXDMasTDdp5+dczmNKPXxx/Ho8AOhhOJyZykGCY0NAl+rQk9m?=
 =?us-ascii?Q?kU81qm560gSb1JGdi646PkX2TcZfnE67orKZVuDZ6qsCdBxZfCgG5/KcdD29?=
 =?us-ascii?Q?nVJtk7zRK1WcfU1qFllEVEnVVmjFLqSzJyk7ewJ42J6NAFCPQaJifT9NCMjd?=
 =?us-ascii?Q?WtdLprqWzvUA9H68NISHx22j56DTLB4vePp71VO0Qg0SGnQ9Dsud9D0KM5Eh?=
 =?us-ascii?Q?M0+dnYBRKguigAmQ3hAHEJCTKlH803Md4q0S4Bp1N6Ufx7FgluWkSMtbRL2t?=
 =?us-ascii?Q?phfEglvo3JkjqK7U1fKWH+hB/hRlfRlAB7/Re+nhFaOhbq+jjMvlAqlYouTr?=
 =?us-ascii?Q?631/zbj8u6dHfVJJZp31Gtu7IB4dbzOq+3SAMbE6EyXxeES7IlAO1Y8N0wXn?=
 =?us-ascii?Q?pyAT8oPORK67sAVayH+DL+z65Pxl+6RZHuJ2fHkzUbHrtefG9wNBj+FL2PPX?=
 =?us-ascii?Q?NIoiyHRvkFAwJFEB4xMdqTO838ZkWOm68EaUE2k3SadKwgzfR0xxM+RLafAU?=
 =?us-ascii?Q?pOIJYb9z29/KfudiL2vVGHjLON5X7FsL+dmVEHAyl9iZxttLPzI/22Yrjq/N?=
 =?us-ascii?Q?lCf7ZR0QGodIj86ngX3slmSjT0cCPM054ppfHFvt9xOFyM4m3zUGeqvWH+l3?=
 =?us-ascii?Q?rom7EotAP8MdkSmnxxfBSFSOkHSYAfWNLo6YURUd0/23s6yaBbL+48BRWVCq?=
 =?us-ascii?Q?G6m++A6b8n7EVBgywFoJA0s0obKu4IP5gBijhe+oYRpkE5U9+byazYwuNCNj?=
 =?us-ascii?Q?v4cuCjax11WTxaGNLSwP4Y5RUEuy4jKZgyUEwuojyGeZMz2CDgCgdxXxzVwk?=
 =?us-ascii?Q?4YRXy+WanDQPbw5JnRn+4sIn/j0c1MaRdVGuh4ci26Ajy4bO188TuJZgjS0P?=
 =?us-ascii?Q?HVES2MRcJLYDtzxI21/2wOxC/ip/GdMmYiwnOHjCJJ2cNW3gO0DHdA/IwOXZ?=
 =?us-ascii?Q?zbohvB4OMhC+ejtnn35JVTBRCY5Qn8bXUg6HjuFZrgsg8eZLWayerwsEu+DZ?=
 =?us-ascii?Q?wJrYZ+LJCsCV+aiBUKaiiHEi7CJBWwNZy5e1mjtcEvc8AZErYqiUR9cy1FmA?=
 =?us-ascii?Q?t+JBAEyo7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JdrAwxJ0sS3Hz7mYGPAM8E5SkSy+4DhQVWx+OGx7H06SJhYc4/ELhStw74Pg92xaI9ci5NNFioa2RW7hGkYId/LgakPVPB5vrT4q7o2xqIvX4WOf7s/JZP7AyHAChOScaCBLAL/4zn2mVgQpQfEL1l6YW1NPI9rZ3jJCHKjXiiw/2p3FBmu+u3RHi7wsUJWxy3ogL3kstsvXHM+0oAAiq35B3oBjbFXQyM76IzzjY1Q7wJoyV/kuUB06fT4nDZhZrXdV+9klXjSQeFX5udDHDQEYPkI7N9EXEqL8aiiPZlH99vETXdDvvpOYMED/pcVKJt66rbPn5qQF3ARVeoYQmkxSXddElcA+LVIScICIX6NmhifSvrzD7ihq7dWKVY29WuYzSSa+Z71D5LGVjOE5ZZ6futgQVyMVhE8poWdnzkQIUp4fS5zKQrBvSV6URMpLKeAH1bSnwlQgXUSStmTK3airbAQJWn59/o6bjzZxe3wfmen30myQiD0y3IOlUZ/uwiMokxgFMDmbBgQTYAp1NUrMBXjCj7F3fa1tnFPG3LilOczPB36WdmKXAFW/k+a6FFfUemRQZC86Li/jVI2zU6A8YXX60ajvaUunwjAsPsk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1481879-1309-4c2d-0e62-08de526bb0f1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 06:19:21.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3qOgOoTVe10V2yV6yNQllTzxFIFRHsBasUxdZbES6A1zgn/r7YTwQqpuYtGbnaM+K2re6PCwkeu/Ce/85JnvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601130050
X-Authority-Analysis: v=2.4 cv=B/G0EetM c=1 sm=1 tr=0 ts=6965e3ed cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=YIe_a-Ur92Aa_-LeloIA:9
X-Proofpoint-GUID: wtu-u8L-TMgfCrO2I9K9uImY4SWPXJz0
X-Proofpoint-ORIG-GUID: wtu-u8L-TMgfCrO2I9K9uImY4SWPXJz0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1MCBTYWx0ZWRfX/ah1nOYWnVs3
 tdz1/RR3f7WKfhdwMwQSw8TAroHmeb0ONWsdaTHMvE/5tUFchJQauCtv/bPzJbrQt2R/kXCUhrM
 LAZia+t1jo8hiNnLFh8a6Ljt8bL2cg9T+2HTQRXR1zXxeAUpPM7V3Fu6wWUQfle7qw6/2SC1OF7
 4dS1ElcBEDl06W1b1poyYBpxwcF7KNjAui/updkMC5qLVhplHKXQ8ID1mDu2KR/ia16YSqbtx+F
 uCviBgZD19uVO2F/jnHKXmmB+OMKajzD7xy8OUhHWDD9Ky6taDN7ITXK+LAL5SKMOEPpbvezNRD
 P/5xhk84pkLCm7pOh4QOQ+HA5sDpKZo1MOXH03lb/ZDN5aLQZb82ZuHA9xxpW39sYpUeTRrDio8
 fCnQFvuYYxkDk1ia6RtK9GRAZ3dNPbAMypYIUXfxyn9pYAA7WREqra5NFmmF3YK7q2EJbzb90Sc
 aBXAewbYMiDfBAnqdug==

To access SLUB's internal implementation details beyond cache flags in
ksize(), move __ksize(), ksize(), and slab_ksize() to mm/slub.c.

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slab.h        | 25 --------------
 mm/slab_common.c | 61 ----------------------------------
 mm/slub.c        | 86 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 86 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 5176c762ec7c..957586d68b3c 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -665,31 +665,6 @@ void kvfree_rcu_cb(struct rcu_head *head);
 
 size_t __ksize(const void *objp);
 
-static inline size_t slab_ksize(const struct kmem_cache *s)
-{
-#ifdef CONFIG_SLUB_DEBUG
-	/*
-	 * Debugging requires use of the padding between object
-	 * and whatever may come after it.
-	 */
-	if (s->flags & (SLAB_RED_ZONE | SLAB_POISON))
-		return s->object_size;
-#endif
-	if (s->flags & SLAB_KASAN)
-		return s->object_size;
-	/*
-	 * If we have the need to store the freelist pointer
-	 * back there or track user information then we can
-	 * only use the space before that information.
-	 */
-	if (s->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_STORE_USER))
-		return s->inuse;
-	/*
-	 * Else we can use all the padding etc for the allocation
-	 */
-	return s->size;
-}
-
 static inline unsigned int large_kmalloc_order(const struct page *page)
 {
 	return page[1].flags.f & 0xff;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index c4cf9ed2ec92..aed91fd6fd10 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -983,43 +983,6 @@ void __init create_kmalloc_caches(void)
 						       0, SLAB_NO_MERGE, NULL);
 }
 
-/**
- * __ksize -- Report full size of underlying allocation
- * @object: pointer to the object
- *
- * This should only be used internally to query the true size of allocations.
- * It is not meant to be a way to discover the usable size of an allocation
- * after the fact. Instead, use kmalloc_size_roundup(). Using memory beyond
- * the originally requested allocation size may trigger KASAN, UBSAN_BOUNDS,
- * and/or FORTIFY_SOURCE.
- *
- * Return: size of the actual memory used by @object in bytes
- */
-size_t __ksize(const void *object)
-{
-	const struct page *page;
-	const struct slab *slab;
-
-	if (unlikely(object == ZERO_SIZE_PTR))
-		return 0;
-
-	page = virt_to_page(object);
-
-	if (unlikely(PageLargeKmalloc(page)))
-		return large_kmalloc_size(page);
-
-	slab = page_slab(page);
-	/* Delete this after we're sure there are no users */
-	if (WARN_ON(!slab))
-		return page_size(page);
-
-#ifdef CONFIG_SLUB_DEBUG
-	skip_orig_size_check(slab->slab_cache, object);
-#endif
-
-	return slab_ksize(slab->slab_cache);
-}
-
 gfp_t kmalloc_fix_flags(gfp_t flags)
 {
 	gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
@@ -1235,30 +1198,6 @@ void kfree_sensitive(const void *p)
 }
 EXPORT_SYMBOL(kfree_sensitive);
 
-size_t ksize(const void *objp)
-{
-	/*
-	 * We need to first check that the pointer to the object is valid.
-	 * The KASAN report printed from ksize() is more useful, then when
-	 * it's printed later when the behaviour could be undefined due to
-	 * a potential use-after-free or double-free.
-	 *
-	 * We use kasan_check_byte(), which is supported for the hardware
-	 * tag-based KASAN mode, unlike kasan_check_read/write().
-	 *
-	 * If the pointed to memory is invalid, we return 0 to avoid users of
-	 * ksize() writing to and potentially corrupting the memory region.
-	 *
-	 * We want to perform the check before __ksize(), to avoid potentially
-	 * crashing in __ksize() due to accessing invalid metadata.
-	 */
-	if (unlikely(ZERO_OR_NULL_PTR(objp)) || !kasan_check_byte(objp))
-		return 0;
-
-	return kfence_ksize(objp) ?: __ksize(objp);
-}
-EXPORT_SYMBOL(ksize);
-
 #ifdef CONFIG_BPF_SYSCALL
 #include <linux/btf.h>
 
diff --git a/mm/slub.c b/mm/slub.c
index e4a4e01de42f..2b76f352c3b0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6948,6 +6948,92 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
 }
 EXPORT_SYMBOL(kmem_cache_free);
 
+static inline size_t slab_ksize(const struct kmem_cache *s)
+{
+#ifdef CONFIG_SLUB_DEBUG
+	/*
+	 * Debugging requires use of the padding between object
+	 * and whatever may come after it.
+	 */
+	if (s->flags & (SLAB_RED_ZONE | SLAB_POISON))
+		return s->object_size;
+#endif
+	if (s->flags & SLAB_KASAN)
+		return s->object_size;
+	/*
+	 * If we have the need to store the freelist pointer
+	 * back there or track user information then we can
+	 * only use the space before that information.
+	 */
+	if (s->flags & (SLAB_TYPESAFE_BY_RCU | SLAB_STORE_USER))
+		return s->inuse;
+	/*
+	 * Else we can use all the padding etc for the allocation
+	 */
+	return s->size;
+}
+
+/**
+ * __ksize -- Report full size of underlying allocation
+ * @object: pointer to the object
+ *
+ * This should only be used internally to query the true size of allocations.
+ * It is not meant to be a way to discover the usable size of an allocation
+ * after the fact. Instead, use kmalloc_size_roundup(). Using memory beyond
+ * the originally requested allocation size may trigger KASAN, UBSAN_BOUNDS,
+ * and/or FORTIFY_SOURCE.
+ *
+ * Return: size of the actual memory used by @object in bytes
+ */
+size_t __ksize(const void *object)
+{
+	const struct page *page;
+	const struct slab *slab;
+
+	if (unlikely(object == ZERO_SIZE_PTR))
+		return 0;
+
+	page = virt_to_page(object);
+
+	if (unlikely(PageLargeKmalloc(page)))
+		return large_kmalloc_size(page);
+
+	slab = page_slab(page);
+	/* Delete this after we're sure there are no users */
+	if (WARN_ON(!slab))
+		return page_size(page);
+
+#ifdef CONFIG_SLUB_DEBUG
+	skip_orig_size_check(slab->slab_cache, object);
+#endif
+
+	return slab_ksize(slab->slab_cache);
+}
+
+size_t ksize(const void *objp)
+{
+	/*
+	 * We need to first check that the pointer to the object is valid.
+	 * The KASAN report printed from ksize() is more useful, then when
+	 * it's printed later when the behaviour could be undefined due to
+	 * a potential use-after-free or double-free.
+	 *
+	 * We use kasan_check_byte(), which is supported for the hardware
+	 * tag-based KASAN mode, unlike kasan_check_read/write().
+	 *
+	 * If the pointed to memory is invalid, we return 0 to avoid users of
+	 * ksize() writing to and potentially corrupting the memory region.
+	 *
+	 * We want to perform the check before __ksize(), to avoid potentially
+	 * crashing in __ksize() due to accessing invalid metadata.
+	 */
+	if (unlikely(ZERO_OR_NULL_PTR(objp)) || !kasan_check_byte(objp))
+		return 0;
+
+	return kfence_ksize(objp) ?: __ksize(objp);
+}
+EXPORT_SYMBOL(ksize);
+
 static void free_large_kmalloc(struct page *page, void *object)
 {
 	unsigned int order = compound_order(page);
-- 
2.43.0


