Return-Path: <cgroups+bounces-12581-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 269B1CD5BF2
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 12:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C5ED300EA3D
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 11:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F883148A8;
	Mon, 22 Dec 2025 11:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="onXLl3fk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PbyBwJny"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029B313E36;
	Mon, 22 Dec 2025 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401787; cv=fail; b=m92AhEuPSTTqftCWJZmcLuDFU63+Qo0zdtoa5o1iYEi5Vc4bedSxqPN0vmTGyOqKCaAJbffOsn1H6xGeBLDVltUhWW/R6Pr3ibAfaBUuMy1O6HvJEIECIfxPzmkRLDqizNn/hwy4nWklpj4ErArp5A0AczOHBS+9RBmfEn/vLeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401787; c=relaxed/simple;
	bh=dm3PEC2e4WQJXxoONjPWarzdzs6QnwpxJDX0CRSDXB0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i8KuTEWYKjv/qKcwTHI0P2MdZTgJVJD4GW6ubMgOoodz1wtf1aoipxG1IdNs9v8U/mA/eUj0licwyTwnWnRyO7FgC5kVNmgpykgHmwz020tf1d8nE6WzWrGT/6S8+ww9Yvt8IcNWJVnGBjHfaPU1q1wgkmQvwhl/DuWWugeWgMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=onXLl3fk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PbyBwJny; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMAlKZn2036328;
	Mon, 22 Dec 2025 11:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=rPmJZYVjv4IBnVgJ
	rUJyNCml2uT4VHLgfZB+pQP1KM0=; b=onXLl3fkmYaIthLaJeLze8JzDVzeivn5
	6h6NcEgxnr+iramEIkWIqAUGsTTuPc48kY6M8USr1E8LUe8Cp0NG2qRIfcZud7nn
	zUjHpMQLy4FyEejF+8MLM6cnqOk7zmJt0KLG5s14TEb+4tuV0z2wt1xDJRaDPBPR
	qF7EIr2tAgMLGFa5EaGQ97IrKfwckFu9Aeqz6ZgPPUWXh7A1pXhig4yAZnB86PTt
	nSLbZLxyxV9VgSs8OQSERkOwDNfVoaYM0RoSJ232GbpM1q1j9SweUsZcANFBI0W3
	XXgw9arHZR8zpp6mLuyDzcNiBj2XOHkOLAFPXl2onyBcGJKvIIH7gg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b74hqg0xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 11:09:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BMALjuO039962;
	Mon, 22 Dec 2025 11:09:02 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012027.outbound.protection.outlook.com [52.101.53.27])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j876nbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 11:09:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPZ9k4ww3Sa+vJapJtX7N19tQYUlVwJj+zbvduaFCsWav+Fvhr0zncnPdFZRoGmazU8X4uGgb3POmx3hcKzQb4gMRMc50PE7EA05kUWpRDBTWIaaCESPz9YInMZvmRRAyXmdB1KdpV/UN9K74lrVhqzJFQwKvunpy38uFo9mP6YZk99rKF7bkquT6Jf2f3EAq0ng+QT39x0vR4BOEXEZ3KAV/5KzwMq6DnxKozvKq2jfEEMJY1+WDcySG/LPSQLMCPtj8EW8S7TU8E3i9i2dBKjQAFY1nqw1F80cUUioXf+TD+7uvbiQ5PXTXmi3Bhm9/8ASsF64qvYRNXGSrklt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPmJZYVjv4IBnVgJrUJyNCml2uT4VHLgfZB+pQP1KM0=;
 b=DvGWVhOPVfDPQ7PABzHOiT6EUiKI57L/8wS5Ooql2ooBnfzVoyDSbcHVVX0uosaH9rFxNHPU+EqL/oBzRtZa/03rap2NiQg3A8jtnY+dD4aaimepICTtF/7uoAP2YV6/KpikmS/BRgL0VPWB+KBTcB/eXLha9cP4ddIfJdoHxVqIaMX0HiLSiOCIuVwWC1838z5q1S1JMyFfA/tUKFPstI3Roqr/H9a9Mu7NEyj9u5IK30mks5k2fJW0RSiT6FSe2yzu3lPyzlrVtmUbAfRmMKP3yDnp/KegXAeRhcVAys+wfnaVhh+LzhnqqKaRS2kZ0jNYFgGCh4UtFuJyKbqA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPmJZYVjv4IBnVgJrUJyNCml2uT4VHLgfZB+pQP1KM0=;
 b=PbyBwJny3u6wlUL3BZ58cYEtDijbWXmMiCjLURGQG5SM8ys3MyKqTdq1W8kctPqMPo628QsvHlQNJETpgWiCJZ1JKacrsV+hYOaB7ZmKifn9tWW1czf7qlgkyCTKVYf2RW5mojFASYr2ebkJbHo09+qmReTQz2iOzawh3FtndmA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4741.namprd10.prod.outlook.com (2603:10b6:510:3d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Mon, 22 Dec
 2025 11:08:57 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 11:08:56 +0000
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
Subject: [PATCH V4 0/8] mm/slab: reduce slab accounting memory overhead by allocating slabobj_ext metadata within unsed slab space
Date: Mon, 22 Dec 2025 20:08:35 +0900
Message-ID: <20251222110843.980347-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0055.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bd::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4741:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b9c7a7-59c4-45d1-8541-08de414a801f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7GXa1JXDeGUwQyIbg91zlRnDIE5QKZWnFBU+Kx+VhV7aII+GnvANMtx2HcmX?=
 =?us-ascii?Q?TSh2wgVvYiufaqnL4G5UqKB5DT6O+/1dUR+5b55eONi/BImSR23zfiBwF06D?=
 =?us-ascii?Q?eBPQznUZAb5WhUmKKAKr3hx0UbvFWSveOKrLcYbqQIUwC7wMELUa3uAg/dwL?=
 =?us-ascii?Q?A36Z/JiRPohWN8LI6/F/MKi4vvzC42+JXO0szJkj7RxhdZ9IaOzy3pP6oJVC?=
 =?us-ascii?Q?gpqKGmg9qERPPNDOoqpzmyWGf5EHmhr6cIae/tlsE4FNqBG00GdiwPIRkcnr?=
 =?us-ascii?Q?/oS8EwmI4UL3d7bo8lbQG8JIOn6CTNaftFhn1DWung4LcEDLIEHssGhiAlBR?=
 =?us-ascii?Q?xk/MGAciR8UvDIwxrHJxJsTBhgBAnwjJ2Ao2CfUCYWk+207BKv+9NZ69bh2K?=
 =?us-ascii?Q?owhXiK4CPj/WlsAzbxYksiirglsQxK1Xv29jqahMsyWvnsPDgz1KFHVJRT4d?=
 =?us-ascii?Q?t2btiQCSHXxIA6ybUoGsXcb47EaPX5iNLSP7NSO/4fybWyjDSZJM1wRAt7Lm?=
 =?us-ascii?Q?nWFJbLncOm5K2qEJr8xWyN94fFnLJPQQnHEQeGOb6PEMwWVV/Pzpy4rRaVk+?=
 =?us-ascii?Q?cNmEYnRvMnw/33QPGa90vvcCi1qxAsBQV3mHNolxDEh3JQItf5PckcgvYwI6?=
 =?us-ascii?Q?M2hjMmO2t0rbYiL9RZCl715n/RonavtI/xBCAjCAKAMryM36G2mSDXuvkHjH?=
 =?us-ascii?Q?5VsMoMccbyvrzvXtAITHIDKcBQ6T2cbHAKgisfCacn6fKi54e6jqRPSTE5XE?=
 =?us-ascii?Q?S3HE5bCHaf+BxzxBLrcxDLa5fls1L7JiLJkij2ejxgmuxYNLS7+FFW0irymu?=
 =?us-ascii?Q?AullsPTtVJsCxsANq7Io/9PE0eI7b4dMtbeUgFrNB3QjW8+djmfLmEUS3YQQ?=
 =?us-ascii?Q?6BFdcngTaLRpEdD0FVEZtk5qG4YW5bBSvkodtCClQX/GB+jMcbEJ3p8W6yZo?=
 =?us-ascii?Q?TdXrz4wiiWmcK5NyxtBnrlWN9dJ5FNmBF3IUI3aaF9YG5PUhUVmiND4dj3Kv?=
 =?us-ascii?Q?0mkAVKOIGEm7o8ZWVEqLN1rzKwuo3qwp7a+9CzkPM21dRJ3jlLmF0z4lAIjd?=
 =?us-ascii?Q?LE6pSahsruywbge7CfqOnYhAjmT17STHrFJLSr4raZEdXYCMmdtvgqnslM3F?=
 =?us-ascii?Q?hcjYLCYOQoAPRkivAr2sMaVXhJ9pfXwJfaAhtJllZ8GcFOkFcBDHJjWVmG9E?=
 =?us-ascii?Q?denU4R57dGQhTLkVAzTakefAwXvTUvMrjdI2ah8DiWorb7+FLnCijnu3heUD?=
 =?us-ascii?Q?uYwr593SW6jr1OAkLL/6s7cfy/CN4W9QG85VAMS6Ivfd+Q9sCue7hxp18X1O?=
 =?us-ascii?Q?pxbCEEj410KkzcXOj9iQXOMMspkL2VN8U5ELfh6GFRHw2A3dNIXksVCggw2D?=
 =?us-ascii?Q?NzEog2YiLEe86zZmsWHDn/GUro2Z9aYKHQ0bYP6khmHw1l/sGqSRA7UpszgF?=
 =?us-ascii?Q?UsCcNh2NVksPUY6zj32O54+YKxMAqqZqnsT7JjsEPyAeYF+Q2HoOcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l+EYp3xB8UVAOQjMQxmTjJEMdHo4zoTJWEKJqs+uVvncsSiDfltOH+m92UJD?=
 =?us-ascii?Q?mouiGBzOANDSogFpPvXax5JBdPzS7YYIWJipiyoAYUFTxuE4KNWYhZK4Dpp1?=
 =?us-ascii?Q?wrfPqZ4eKqAAc1oICZjCuuRzCcl+e+HziKiz5to7n/ReLJZYfcsRo7g94RHK?=
 =?us-ascii?Q?o4P3+u5HEY8D07SJTi7YCxkJRfl46e/xNlKWlztMYEBytkJfn8+PnBsW8xHB?=
 =?us-ascii?Q?fR81Q0nRvte4x0UHqZiiFhYBhCrXAELkZ6YR0KNXrx8gTjuuqzymU7J9MMbx?=
 =?us-ascii?Q?KEnuZETT2lSelowazG53smo8qquNpBuy0jv2sIOhsSstyXQAl6AOnpSToNt0?=
 =?us-ascii?Q?ZDeOINRLYGn8Wg9xyLPz2WeWEG5kjxA8k8HVgoS5H1nIVsFvP6l1N31zdCdX?=
 =?us-ascii?Q?0CN+8ODRC3CM6v59dckBb/u/b5ApI3VL1cjVTOim/ZQR5HtO+P5KbwaYvGJ6?=
 =?us-ascii?Q?aPzm8YRM5BA9+50wMxwGOilJuo6kDK6BQxTkNXg/CaZP4PQhYcblRtfyFyFr?=
 =?us-ascii?Q?tG7vxjfHr+wXH0gHKgQ4TBwh94C7C6AJNEi9nBAaRkk+Vor0C9C0U7dVJNEk?=
 =?us-ascii?Q?QZJHzjo9QB6Wx68U6iXd63Nzul3hAI6aDRdURHQyURC0L/MsyDmhavsKtujB?=
 =?us-ascii?Q?NbMV72t145Nqgx9nnL2NyJwAaHI0wDxk/rcbNTKkOAsK+8imxQgLlTKkAU3e?=
 =?us-ascii?Q?5N5jDXkoThDsJhF91a4++RrelRPKLpDdwApVSjAWGVK3nE7eN0MBUmYOzTw4?=
 =?us-ascii?Q?7TE/jKsjzwUubVQQtodbcyDizc/uHHfD6eWCF4ZI6Ykt7AbMTfDPWVnvd1B+?=
 =?us-ascii?Q?FW8um5IZcOZ3QlHo6bQCxY7mkQzM9vAqyQK57ymQVhPjrzcif6vn9LIhaE9l?=
 =?us-ascii?Q?imKMq0/K3EVQp19DlGWv/Pe/RMNGT/fW5XZ974usvZF9QASXew0nX5gnuugK?=
 =?us-ascii?Q?6sTBaD1H2umKKXevkr4UGq+Kg931JD+lfvY8Rot7zCw4+jXq1Y2xbAk8fyJl?=
 =?us-ascii?Q?a/cpvs/lEQFSmGCbnMfF+TdBwb2ijiB/lTPJyCHRsozcE4gGh0sDzYjWtSR2?=
 =?us-ascii?Q?vOMnys0epfVi+It3tdp3JxwfhyvnM/+CwZXZNHWAZppDrKrNTfmnQPK5Z5+z?=
 =?us-ascii?Q?RZnt2+j+XSlOgTNdb7gIjbWVy7hr20Gr0Gn0BkTcHbRCwYVRDyiNjrOve9H8?=
 =?us-ascii?Q?ohYtLgeXCvemR6P4LvH+TOHoVnUkHgRcOzn9edOuolu1pYqqsW37xTOZ6gXo?=
 =?us-ascii?Q?fzo/LXu6SH6acVvRqF+TaEaIkSQzltUfIh6UrdqezFV91hEMiuIPXa7Bpvto?=
 =?us-ascii?Q?tcQh/KIF2+deXIRszwS79wtBtfKppwgzO1hWPASQJX2+PWGeiDVcf7mY/SHO?=
 =?us-ascii?Q?OkBPfj6+k5jfnNBzZ3550raSBpSDU1kFFT13cAV+t/v27gMGRhYmhBsvo8Qv?=
 =?us-ascii?Q?VyEmTzm95OuWRbEUeczLnYuV/0xBxsxMd7xUezw4EiyDnNVUszUOnlgHXCGc?=
 =?us-ascii?Q?H80g/T+D8reuoRRQx9zm8l86q53RWzKvOqSNkKp4N7SnJEhQNSe1PFl+T9QF?=
 =?us-ascii?Q?LglouMCL1FEZT+vLjOKMOnixlTfYTxaMfwQZK0F4Ltma4l5k1xTGCCuW+hYG?=
 =?us-ascii?Q?/cNEkLUnmuaQht9RJaGBBlzh8naPEx0JyrOcepewo4DddbQOpKBGBXRFg6Sm?=
 =?us-ascii?Q?qKLhMjexUwZtNjSE/ld1CUNoyW09Kq3NapidIq0B3pvQRLdwiOjTvUIj9dQL?=
 =?us-ascii?Q?udaA8QgNVg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UDm9BhFjz92rof2CHYgktx/RWxrLaX3oMA9ryLJAx3Iy6aliWoAf0UXqSpqVhCrsr2BVmzY7XrEYaNm/hBGU3Yn8llZLC619Xjwr9m0j5mZP/J4NyAHZh1Ch6q8d2qvuXeY1+N3qFDHTN5OtEWgphn6ud3k6+TCZaRmWdJa08pDzniniKvU9KOOnGw9GVTsJl6nVnP3256MJ5qD1uYjRqXXJp0xj9xfZQnzUbSI4OLexEPp1cGPqlOzYMJHQ33DSX2VR38KUGWNP3QKMsoEZsKKsFwkIkpxopfxyTlTRSVh9+Ujqg2fRRgkShDm5kFSmdNSDHOzH/T58qLjeBgVaQ7Igpa6wms9cC5xR9RS1gifPoHF3dfW8QkFgAs9XS/cbF8nb7HRneBPsO2+onIFFzydrxRF0kpky3FOhK+iAJ84awuuw/VPHP4+rRsS7aouZBavYTS7Zbx7xjx99SuVHrXA/6FmZGHDpT8+/fqgvqcaSH6jkdn2cGFx6quSRv/IFv/ir0kBbckUh8UA6TAI03o1fO2J2WVuMFIi0dK01vkITHMu4823JlU5M9UrcQC5qI8Sa0/cgNnHqXPb8rCynpgEK7glBmOx6GkMa+raTfsY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b9c7a7-59c4-45d1-8541-08de414a801f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 11:08:56.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZGGxZturU2GuV4YntKA85ZOy1H6PmyEtXpIJM4b9D4s8c4MMQ/1wiUvviKBFNqbb2fSASUfpjN6oZKurAl7oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512220101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEwMSBTYWx0ZWRfX323B/ihSvGt4
 TxEfDSaiS/3ovgBztTw+jVT7C2cHRGpPJLetwksRfAiHGLRcW3KZl8nOKe89AZ/5CwlCUgIrXQz
 5QL6uWYm1CQf4odIFbhHp4KFBIvKqgOmuhMTno8xGlYy2hhqOKGQ3A3eMEkHFjskHok3ycevKrk
 B/yWSlx49vGezF9SbhtQDOxyU/wDaSLcA2UnJkjjzm3Y5Lf/f41kroEIwKUTYeC+cHUHO2Wk0Op
 /AXnh/weNBeMYknKRLXaAgdAIAJ48B/D7mB3CqZx6OIOpZ64lgWL+OjaX1upzU76040lSn36V/z
 CXbq2I4B7SW+nVgmTuK3RHenQxwQpxEPuVL+Xyc5Ah8bQuDUcYW7tozhEX67gg8LmZn3tuHX57e
 dQJSABjo/BuoNJ5WDfc9+f1EL0pqGVHAA+qULfPboFLSL+6nRkt67lV6uiXZ02BSCCE4Iu1skHn
 3mPwxn3YYBdc0eeQODA==
X-Proofpoint-ORIG-GUID: yFL9dRltAFlW5g-hYGa4jZ0Vct2zdGBv
X-Proofpoint-GUID: yFL9dRltAFlW5g-hYGa4jZ0Vct2zdGBv
X-Authority-Analysis: v=2.4 cv=B6q0EetM c=1 sm=1 tr=0 ts=694926cf b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=F2bBXNHfPZ7v51Lu1DoA:9

RFC V3: https://lore.kernel.org/linux-mm/20251027122847.320924-1-harry.yoo@oracle.com

I believe I addressed all comments in RFC V3 (except handling lazy
allocation of slabobj_exts, which I would prefer to do as future work).
Please let me know if I missed your comments.

If there is no major drawbacks or concerns coming up, I would like to push
this forward for 7.0 merge window after some review & testing.

Have a wonderful end of the year!

RFC V3 -> V4:
- Rebased onto the latest slab/for-next, dropped RFC
- The metadata alignment (after orig_size) fix is now included as patch 1
  of this series
- Patch 2: Document that use_freeptr_offset can be used for caches with
  constructor (Suren, Vlastimil)
- Patch 6: use get/put_slab_obj_exts() instead of
  metadata_access_enable/disable (Suren)
- Patch 7: Change !mem_cgroup_disabled() check to memcg_kmem_online()
  (Andrey Ryabinin)
- Added Reviewed-by, Suggested-by tags, thanks!

When CONFIG_MEMCG and CONFIG_MEM_ALLOC_PROFILING are enabled,
the kernel allocates two pointers per object: one for the memory cgroup
(obj_cgroup) to which it belongs, and another for the code location
that requested the allocation.

In two special cases, this overhead can be eliminated by allocating
slabobj_ext metadata from unused space within a slab:

  Case 1. The "leftover" space after the last slab object is larger than
          the size of an array of slabobj_ext.

  Case 2. The per-object alignment padding is larger than
          sizeof(struct slabobj_ext).

For these two cases, one or two pointers can be saved per slab object.
Examples: ext4 inode cache (case 1) and xfs inode cache (case 2).
That's approximately 0.7-0.8% (memcg) or 1.5-1.6%% (memcg + mem profiling)
of the total inode cache size.

Implementing case 2 is not straightforward, because the existing code
assumes that slab->obj_exts is an array of slabobj_ext, while case 2
breaks the assumption.

As suggested by Vlastimil, abstract access to individual slabobj_ext
metadata via a new helper named slab_obj_ext():

static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
                                               unsigned long obj_exts,
                                               unsigned int index)
{
        return (struct slabobj_ext *)(obj_exts + slab_get_stride(slab) * index);
} 

In the normal case (including case 1), slab->obj_exts points to an array
of slabobj_ext, and the stride is sizeof(struct slabobj_ext).

In case 2, the stride is s->size and
slab->obj_exts = slab_address(slab) + s->red_left_pad + (offset of slabobj_ext)

With this approach, the memcg charging fastpath doesn't need to care the
storage method of slabobj_ext.

Harry Yoo (8):
  mm/slab: use unsigned long for orig_size to ensure proper metadata
    align
  mm/slab: allow specifying free pointer offset when using constructor
  ext4: specify the free pointer offset for ext4_inode_cache
  mm/slab: abstract slabobj_ext access via new slab_obj_ext() helper
  mm/slab: use stride to access slabobj_ext
  mm/memcontrol,alloc_tag: handle slabobj_ext access under KASAN poison
  mm/slab: save memory by allocating slabobj_ext array from leftover
  mm/slab: place slabobj_ext metadata in unused space within s->size

 fs/ext4/super.c      |  20 ++-
 include/linux/slab.h |  39 +++--
 mm/memcontrol.c      |  31 +++-
 mm/slab.h            | 120 ++++++++++++++-
 mm/slab_common.c     |   8 +-
 mm/slub.c            | 345 +++++++++++++++++++++++++++++++++++--------
 6 files changed, 466 insertions(+), 97 deletions(-)

-- 
2.43.0


