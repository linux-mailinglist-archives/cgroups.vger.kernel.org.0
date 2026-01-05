Return-Path: <cgroups+bounces-12910-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB342CF24CD
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 09:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AB2B300AB02
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 08:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA7829E116;
	Mon,  5 Jan 2026 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OIKFkST2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qNs+lii0"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7872370808;
	Mon,  5 Jan 2026 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767600200; cv=fail; b=Xr4qCeIiwmZDGFUpfa1y8Ss/QJ2DlBdYcRMbbvFBx1U8elZg/6jOHMeaXU4yrwsM2DxCTZRqAmm5l3klNlrFv5s/xiTwQ0Nqib0OkPwSTp9vShUYtWPmT7vwTYyZnLVwOjdWGbHz0QQ9QN45FiGGXQKkQVbXOsX8bggQq5qUR2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767600200; c=relaxed/simple;
	bh=WdiQQHYX9jlj+5jbO0jhAP1qqG90Ht99C96LNC5p7o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oJ4er2OJRhwZ6HM3SaZK9XBY42SVeRvGZKCySo8XMsCuUJAOgvhgdgjgQtqw+HV4gpxYPfngfXZWHokWhaj0y57pyTtYFJGa+eHxnzgat8ON+P/2oYEXh/miiblMvwbBpfxoAM1gXg6lShT3mQ9pF4CfPoEpR79Y6mxxM+p0/kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OIKFkST2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qNs+lii0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60501vox191951;
	Mon, 5 Jan 2026 08:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nmT2/eimzYvizrkfiSI5RtuA0QTDsOCdCd0UhJgGl2M=; b=
	OIKFkST2MIJb42BEy4Q5dSNPtkaqFsKPHFSAXioDOkyJOh+xI3o4KoFEqivPkcP3
	lIKtN1Otn9Z2Pubp+Ln0Q2lbrJFSYoFLRVqZxNs42RIww241LM/jTQfK3jo1NnxX
	w5yuvj7F/kNnX2+4/v8tVPROjHzMvDuq6SDXGG0oEuGwL5ERCyMrrU34T6PLcBJh
	Bd6VKePEwjeL5qwFehBNjLCDL9vE6McnbrTL22bnb60pw0C9+IUPveL2tMKj4xeN
	BALNDPMfG7UY27Mrn3xPLsAlUq2gYG6362WaseRbw/bIgDcPNTybyGbhpMtRK09a
	zh1lbvQYCtTeWhItDswIGg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev37sbgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 08:02:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6057XRtL033898;
	Mon, 5 Jan 2026 08:02:53 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj73vhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 08:02:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MW+8hBgK+poT/jeeSPZBRU1fkOMCJr8RfuIDbXdZUJm1GJd25IncXVWKni+T0pMtQijF9htxmXjT+y2QmZuoRd+Fi0PWJ/Lu74DRTaxz95pvqHOiKitao899IhHrpAuBqyrHCb727qbRJl0hQSmLUCQwl0wVu9JUeDxwiBcFmeB8xzY6mDarTluOepsi1eSA65Xb7oijp+gklmnMk89uIQSQPKiVI7qRjXPtLJwnz0zqBJZQK2RqEgtiy1sISeJmY47VvjLI6e1naNATNJdQKNcXqIzFYHCYGyykfph0cBmZ2qsD+SQwGKWvWHufXaZJQ/jnXTco0D4eVfWQBWUV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmT2/eimzYvizrkfiSI5RtuA0QTDsOCdCd0UhJgGl2M=;
 b=ahBN61g5xPAAo68WZzhCErRdRQq65Gc42n51bkEUae+VhTOyRCAbXHpsXx/CHEr4JAxAM2KgKwyTlZ0pbC0wCm2pCyNuOXS4uHVExnuO+7JdBFBsO4hTBgjJQ6b8CxuAlppLHrrxp8DBK2vnxF65io8KutjeV4swqzb+6SnxYnbtJ1aMY/R+8gFbmG3bIUNVmn4uNDmhdjXg6QP2cbaRkwflD6wP8BCl4AFoX/sa3yXgU3/SfWMYsiMwWp2+sCSIEeDeSBfHQFlxBcirRROteUgJCy9daw+NZrfQ2fyBe1MakYsNtj8T3JseLvGrveWy3nKxquEbJOleffvg4hGZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmT2/eimzYvizrkfiSI5RtuA0QTDsOCdCd0UhJgGl2M=;
 b=qNs+lii0EI/O6FDGMAr71fly8k41gpPp7P/565NJfqobXK/0Lynli9WjCb3N7SvKP5Bo8cPf4FBgG6PlKJZ6OSEcfDFlLL1BCQdsgoePvORaSXOKbtBtZ7AO1KDQdQFpO94Dvx2mbfEmQgxs6zqzPwIE6a7WcE7J2gVpKZbhvOs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7531.namprd10.prod.outlook.com (2603:10b6:610:139::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 08:02:51 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 08:02:51 +0000
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
Subject: [PATCH V5 3/8] ext4: specify the free pointer offset for ext4_inode_cache
Date: Mon,  5 Jan 2026 17:02:25 +0900
Message-ID: <20260105080230.13171-4-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260105080230.13171-1-harry.yoo@oracle.com>
References: <20260105080230.13171-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0076.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c6::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 07028005-394b-4638-29a2-08de4c30d2cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rEHjR5mgwWlGrCWutHtis9K+YCjNCRYQriu53Lg8plm0dFVr2hVETfgr920A?=
 =?us-ascii?Q?O5fY2GcELTG80WTILR6pUUVedBPwYt7cXvomwJA1d1fgCy9SKURlvogg/eoA?=
 =?us-ascii?Q?ur2RGanmWlNtXICRuRhnPPIyCxxRnLSwiX1+dqbRfqQlED+5UPh4GmGTfkd7?=
 =?us-ascii?Q?ccNsC21M+wJL+tE+8t3KsKFsC6HGJMPigXvG+ocfW1CFMxuA++aVnMt+f8Is?=
 =?us-ascii?Q?KGlxw0L+W79aCialRvF4AZvcZNYEVhDSrgIqqU6bMJUXBN3d+Be0OcpoLFJt?=
 =?us-ascii?Q?VVZ4G4KnvuD7tzr6TVRFCSvA5l6oTHouwjZ/TKHrB3yYni12tJXLMIyW7PrO?=
 =?us-ascii?Q?DJN8Pj6eW947bvUVk52H+XpQgnQa4zPyPYQ35s22wt7e1kIX01mSMe9kWKae?=
 =?us-ascii?Q?/Ul3m9MjnKa8UujMgCLh35Kxk2Jei/P2bYukRJ2jj2x3aaVdoW48CHf2h8+a?=
 =?us-ascii?Q?IMjNW6++RvLXW/wl3Kd5Ev9RwDq6SJyrZfLxrZ1z3nMpZZaELjjmkuLCaslK?=
 =?us-ascii?Q?1C2EZLgZQXD7unHXFYxjTBfkB3gTilVG+EeXR/wIvv+wLMUqjTDe3UmOWoWZ?=
 =?us-ascii?Q?TVS2wmBZ8841Tjofy8ajzo3B8ckcbrCCNU9q4ZG+oYvVx1XeGKH8rcA5/tfh?=
 =?us-ascii?Q?7suOvvCMYgC2ssuGBCoBrcbvjWaLURE841QzXwImb5h3b7V2oGgfUi6bQOyQ?=
 =?us-ascii?Q?3H7YmapNLHgYNYTy1HSLieU0BYFCt8aExLQLxNADSPS8z8AuVxERpaROpPeX?=
 =?us-ascii?Q?FKAuBKhOAx2bv900/JSvzpoCyRubpTl2umfI08K44chE5VbCXSbaItSJWPv2?=
 =?us-ascii?Q?+Xq/isOKk4jGWR/uSUdEbLyW97UqZMOplbEqwhF64fdkY4+jlYoQJO2W7S/1?=
 =?us-ascii?Q?8Pa9ifXq2f9hreGxNrpOzefzqQSr5o8sTqTmDQBTXCv6Kt70fHvkLMbMsezE?=
 =?us-ascii?Q?5z515+KaClo+cCfkTeutG9yTKu8WzPWxvBXxhahJrz3cYk2vJzJkADGr4ud6?=
 =?us-ascii?Q?bxh4LvMbMXArpmHKh9EHot95pxz7VwG9amz6Ln9kVeWdwPQFO9jyRLle/cyV?=
 =?us-ascii?Q?DorY9/A1qrYFw7QCkqBR64I2tBxkQSdqaSHuGE1APDsqPuzt0egsSAY5lO4z?=
 =?us-ascii?Q?I6OhzLpPtZaxxSMmfBByepj4dBY0+O3Oy1T4IoOSNIW0B3lFrq9ASsYmhukr?=
 =?us-ascii?Q?PGoul345LGnnt0UmG4Xecs+CQgYKENIJh29GZ5urAe1eCtZ30sIqPiIEu4sW?=
 =?us-ascii?Q?Yd544PsMDDfxVTY81tFWEHQBN2mcThyKUBMJgaE9iS/Y3o9BMAsDyYeyBX+l?=
 =?us-ascii?Q?dcZHkRj5aE1LN26pgdSpPlEZEUzaS7lGvNUdts3wEisj3ECpwaX0p1ps5a4F?=
 =?us-ascii?Q?tAUJIv2PV5lvPrVK6neFEcxkbB2SkomTzNyA+FrASFnVayaPFtpaINho6Jr+?=
 =?us-ascii?Q?iqY5mxQZT6eVU3EUOInBUCsPRmuXqghW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z0K+/Ew5BlZ5mXv10wsuP42/OzNyMZOXrKMuO2dF60iGIs8bp7BUMjD2xaLz?=
 =?us-ascii?Q?4wPA/1tM8gF3qHr9shsMqKYLWqAW/VjzHN5Y2S6AIIfgauRNQqqnY/cS3YDz?=
 =?us-ascii?Q?EC0PA6FMvQVl+PAe8G+Qgi808U710ZwDqsNl2aH1maZcBfwZSeezoe2cNLm/?=
 =?us-ascii?Q?6VoqPRlj0uKROQKtOrkGXQ2echRqIKzKz2jXox0B2PwN7FUzV+22jiRBH9uB?=
 =?us-ascii?Q?DT0DyJhX1oZ2IYAWalI1gjF4rsF5fBGgm8+H19o+gGMNfeVusAANxMNst7X2?=
 =?us-ascii?Q?iq9ILs9pPL60CNco1RDKgGfjLzTSaJ0pttq42g3WgaY19zBGL8h5jZZx1z8T?=
 =?us-ascii?Q?Fl9zFmeuZZ/czw9nfLGnoXB5NnBaGeDoLXWTUC6VXCQZcZf2RaWmpcE0UUbC?=
 =?us-ascii?Q?JjW+qpWGds90nuE+gCm/iYnU1Z7UA6ngb6TKGly9oy29jFJQzY0dEYw3pdQO?=
 =?us-ascii?Q?l9T/UWBipcctv//Z1vR2DNns61l0FFTbR+QHp9J4bf0Cz/EnEBE7e/TJVBxL?=
 =?us-ascii?Q?51mAigWhtzeIes8UzHP00O1tbx66mWyXPKTCjJDvT89iAs3AinwPxRcs+vGv?=
 =?us-ascii?Q?KidTgzFn61iS4FVpVnjlmXJGAWZG8U0n7IXNGFGhR81jRlgpNvJOyInrRGd/?=
 =?us-ascii?Q?9CJAITGfBJeEYCnepBwm0sHYc961pcWdIXnEfsYdAxH6BLspnTwhiOlhsmRX?=
 =?us-ascii?Q?APi3EOUjaJRLZiBkVZZsqoBEVZltIVEJ7uzqyTwR9YhVMbpV02T/fYXALTer?=
 =?us-ascii?Q?J+2OpWUgIoDinbytcWLzTbvB4ooujM8gbWCxuO9Uj8o1PFzTWRaj+dZ46TzH?=
 =?us-ascii?Q?b2JK1+DH72d1EA999AEz1GaBQ2LAXYzWTq9qCTA8ltCSCh50C4d67VvY8bz+?=
 =?us-ascii?Q?J+4Zs1zgum3nhbkBfQerc4g8qhCl5T83Tq6utTtWt+nxbZxth42GdHVqP+J2?=
 =?us-ascii?Q?5GZMbAtey9/286sJNNC2poxO14lsbrgacOoTGQPROG2NvdN/8Tc0f3CuZaD2?=
 =?us-ascii?Q?CU8uA4YqvAFU3X9IQpTj+mGIqQhRMHhZM4wc22GWG3/pQbEfoInn6JnPDXdA?=
 =?us-ascii?Q?ao66xSD8UQkXtNAgT64GoD55bWJlmC83cJrfZ1qN5juYcdyeIfJtfqaBbbYo?=
 =?us-ascii?Q?GivocBTqQovrNhtcAtmrAkfeMIt/NvkKwgPmqaZncMXxUxa6jvdQRnk7lsH2?=
 =?us-ascii?Q?JKLpjuQRjzdA2X/n5wHoMh8w7N/ku1FS38iIKkub3RuE+B6GxqfyKplQjmDO?=
 =?us-ascii?Q?2VqKzlqFdd8vohjMmtJqskhqlyr1RL/llqOAAOmmBiRgwOw8YkaqOFzi06rd?=
 =?us-ascii?Q?tVOdynwN0soaY06D3mvswLYvDSf8CjWZm+aBPlGezOSj2ejCWLdhtA8GBG8p?=
 =?us-ascii?Q?f8nPmFvlSqY4GCPwdNojtiXW3rEI2ECemP2M/S6/xYJjSNidvQHQDo0R/cWT?=
 =?us-ascii?Q?sha9+kLu6K/Q1dzXqEmDVnnnKY4w4oDIczqN8Th4y2U77XgTCOVN8loQNEUn?=
 =?us-ascii?Q?cxUX89jYsJ1ttRaq0lFI6GepMtsCD1P64n1FViIB46lQTNOLfSKhRxvkL3Mj?=
 =?us-ascii?Q?Lq/GbjmY5Q3tB1VQl1yARq8FaI5YztzPSBVeskEUlespsxtKwRpX8dNNzBLA?=
 =?us-ascii?Q?pCB936S3NObCLuMCIvwXtQ9bIPh6k1xt2l+MJbx//RGdz611cq8xGil5THca?=
 =?us-ascii?Q?WxJ7R7MLp7XwcHwxe09kwlvjzFJybjxv6dQ0gFDvnlY0spXex2cxm9Etw/2y?=
 =?us-ascii?Q?izNyZLPP4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XaWyh8dmYAgw2IKHqPGpKWezODQNYIqfPBtLTxZqSC5n3ubVxo5izcrN0s3KzJmo2NEuFIT7aohz5CrsakAin3B5wb39/Uh8LAY/lzSJI9Pg6U3lCnCBgvF41hLuDMz5fSlQ0vcglx5AjzjOGm9NanFVaOdUlh9Q7opW404YQRMfotnEGtS8VaRInrUcvNZ/gyeyYOKGJigJ0FK7tSGAslHW9YVevYwcprvSKLKfPrDAqxqhqgXYlzMeOb6HQhdXHMY69xfwUtmpK3tg/So4GlPDlp0jhKKslu44yq3U59X9tmB7QBigVG15dcxyJK/m4TEE4YAyxuk/Pco4qWBp0wDPsQtDXQOHTXelsH2qmRwTRQRgmbwvm31BZvEndx9DvO8pkJqq9wokS2XOJCWDmqRpy+T5/jMts/5n3GZJZ4ePUMCSgyP14ag9kLIJO7SwZyLhXBa64dzDm2AAhc275dDf3brztIqz7Dyz/HOy8sCChNaUXCX6fr5P6CdZ1buw7IfqGyBC4+toGA+aMKD8iSoL/S2Th1X2tg+Up/7RzMRZDt4CL63EHKWx4e47Fs23Eo5h0eoBNBRjID+ZTgP5i5gxRureAKDlv9p/AJmZAdo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07028005-394b-4638-29a2-08de4c30d2cb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 08:02:51.4073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGY5vfSYEiO7Zsm/PEo2k8gN8N/t0cEs/CKsFbuMqD+Mi3NsNJGpqblYIDitDJNzhRZv4GglN+RObpz8pee9dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601050071
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA3MSBTYWx0ZWRfX5SVcjrjxFl++
 gNGQM7EMkUQKKc9zZi3/Wo2TL2bDOIx8r9dRqc5wbp0S5JjozMBWtgoAai0ESe53uU81fW/GGBB
 J22o7WREG0gCLb+TFL4yyGIIASyePfBLOa5Igrk1MzE94B+oR2F7ZlLJG80LY9MgxvkFVqmIw2e
 GiUQQqxQYWNAEIK0Emn5xXnTU9Skg47/sYkgVfIW9GcEg0dv5BUAiQ7zdx5CHh4VsyPgtW7Jz0s
 /UgNaMFXzHmZFEDlrZOab89F5MOrn8fWFNbAD3fk/zMPxLjHRekFDtvJ73a4Al8t+UcPUecW/8k
 XRVPhWWdaQB6dhdiJsUp3ByzZXe9ovMamCVOxjjygryCTpKzBEGkyYzuSAeQKqE1n/1qbKdhOj2
 jEUdIi8Q+VLFTAbTniubnbMQHkKTkg7ZDFjgp/eU7EsEpepOlrSSsGX+2NZab7dJhTzMDOfXi/M
 ujtljGiaQn/osyQIf5g==
X-Proofpoint-GUID: Ru7UinuyUx9EsV-mCpHxvndGjlEQvXoZ
X-Proofpoint-ORIG-GUID: Ru7UinuyUx9EsV-mCpHxvndGjlEQvXoZ
X-Authority-Analysis: v=2.4 cv=F89at6hN c=1 sm=1 tr=0 ts=695b702e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
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


