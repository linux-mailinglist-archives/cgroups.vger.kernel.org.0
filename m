Return-Path: <cgroups+bounces-13126-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA11D16CFE
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 07:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3D573079C86
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 06:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18A1368291;
	Tue, 13 Jan 2026 06:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TSdyeJTq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fBpQirW+"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BE7221FBB;
	Tue, 13 Jan 2026 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768285187; cv=fail; b=UNrxPGGdqpwLgEv4tVdAAu0mYx9SvMIQsmnIZ1a+xT2g4cL/4UCml89c3jN9KB/9ooK19KhYYYMeY2Q8W1WWD8LKKAgw/3nmDzmEj/+G+guNC/VfCNeqDjTTJu9EXAFVyHVv1iYFgbd7lqBS3iv1k63fyR3zHLD7qEgLe+MQ5MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768285187; c=relaxed/simple;
	bh=sOONH03p/UGkiOpm7AP1MaU3wo/yixryQfg5IdPLQ54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g1VT2r7Y568jqx8CC9w03D2VQHm7f+YBv8YvBFjVUH7xpcsnlgmD02bcd95eMPUuFdExf1Xsaj8jLYAaY2rqrcXvSTza6XbhSYCyMtl3O40Q05UDi4lJEuIkLMWEJF7mnTb+X57+7qFlpdYHS52jfMZODAPg749nYkhA8ZiRpl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TSdyeJTq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fBpQirW+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1h8O22420224;
	Tue, 13 Jan 2026 06:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5PyV/eXNEuZviwCoCIAPLtnnrprGUCkq5WD1RXfup2w=; b=
	TSdyeJTqa7Erz3qVp226BVfDWsy9Y7gUHtgg8OSJb8FIyczVZn8odHT+HpngUOt4
	WZvQ/8svd/+ehuwl+g90SNJ0abzlnXGQP1mfh19CTAT7mr3EQwZ0Uzo445S1iYMg
	7Gte7gbOLy2Jnun4f7OnTxCzLam8LghzcJrgOhK2ybgv4J2dUocGscBfQcsLt0NA
	9k7z7bxWTbm67yk04JTTojP3LOeKEGcLJCa4Y6CDctQOOa+/Sbo/UJKvRBjmnt7s
	blT87K26US2+RyDf/m0kDAWD6uTQ+7pkrzAv0gK158ZoKzQX4sqaDWkwjZvnjM+c
	ODpGV1+Td1tlihemFArCrA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkre3tw99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:19:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60D67DKF004570;
	Tue, 13 Jan 2026 06:19:17 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd78b1m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:19:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZ8Nfp9Mx5S/u4Kk3FiNNDfCcTogHReqYG/Gj4ajRrBl/sLnJlDwbLZuZOdoTnBNjGtdMLk0h7d6s2IFkOmWd4/e68fO8qjhrC2RhNg6FBCHNvXl7gMqEFQLWUzFGC0Xc3zfltWFanS34EMCEAKsjP8vbr1hh+KW7Lr6w65lAUfQiQUYoPpR2nKPFY81nt4cNK2Y4Wmg7eF+Td237tCkfL+AJMx9lJCD/pegRpUc9dulAIZLVaAT5HdhhXs9c+NS8wrxXYR+PgR9aOnieoTrO6B/Xa8BupLegJinKqqm+P94OJUGTjnkQh7Gu4ribq30qKY0hXS9R2I2AbP9t3p5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PyV/eXNEuZviwCoCIAPLtnnrprGUCkq5WD1RXfup2w=;
 b=MmqykWLlEAYifpEJnwiY7aknKjFRdp33mXPfXjXioow2YyPBNG5wJrJN0tMZC8mG3Yzd4xrinpg507rV/UzQ3cSf0Y4cd5Ja9hoU9qqVvegcNgAwqJE9s5y79X4Qg+H+2AiU2oTYy/HEk/Jd8dlXi0LuJG+jqEBt9JhCcXoDZmOcge7EGDrWRgQl/kkHhJxzqxkjuWNX6TWmGfaHD5I+3LzScopcgBWDaln76dINdhdZy0jUVtHVUIPcYkb/eIZ2yDaa1hfVti2Li3BJtA3VQnXK+Wl8o4HRQEfRvaOHIZKQEdN9SVVTtN++NW+mOTj7aEXpVJTywOY3ycHQcakojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PyV/eXNEuZviwCoCIAPLtnnrprGUCkq5WD1RXfup2w=;
 b=fBpQirW+qcfpSu1gG+ogJ6OIb7cLNKdzq109F9Dc2qSlIeeXTwaQgxUh8t3chMZC7Pn4tc+erqCiMx2EZBJeG4IzPY5mJH2JMXBaDtQyvOzObHWHAH+Vi36R34YfLe5FlIhSpAPjuNSSbQPWW2Hu1HlZgXD0+SC0AHJ+xLduTBE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 06:19:14 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 06:19:14 +0000
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
Subject: [PATCH V6 6/9] mm/memcontrol,alloc_tag: handle slabobj_ext access under KASAN poison
Date: Tue, 13 Jan 2026 15:18:42 +0900
Message-ID: <20260113061845.159790-7-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113061845.159790-1-harry.yoo@oracle.com>
References: <20260113061845.159790-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0203.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c3::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN4PR10MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d63e94-3ae0-4f63-c670-08de526bac82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NzMcQoWd1RDqr9Q+SYJK5DQrFAagONSEFg1DvhY81hhrWj6T1xT7iOTx/97r?=
 =?us-ascii?Q?2Yp9WkJ1h6jmlIchH7Ubf2lLWZprnvhiZ5Pz4u8uCvf2LIkCA6EsOSZoD4tW?=
 =?us-ascii?Q?FwwHpCyQwv6Niy4fGoIuvop50/cu9IuhJ8aCP2XPocvwKU0atx6zpZwbDax5?=
 =?us-ascii?Q?yb2rfQr/WESLhVTOPA7xy8VbnoSvvZ2gxDw0ICs9ptDsCRZpwLjbPJZI7gpH?=
 =?us-ascii?Q?4LVfqaCnTIqcBvMxuVz4/T08LnPEIe/mBf19R1GDnHhlsg39HkeRBTRslPTQ?=
 =?us-ascii?Q?By+guCEqSizWrsolG7cmmZiV6xZVFW9XLldeRPBOFPZGwf5xUMHU15nOQgTl?=
 =?us-ascii?Q?apALeOcrig/Bnxk7nzpkW3D+t38evKZTmXlzOLeIQLjRI7WsIFNN77ABDrs+?=
 =?us-ascii?Q?7NkhJ3hCFm9v/fEtpdwoHEPvXuJHCeDIelAcLEEFhOXJuumSqYq+CRZ04kd8?=
 =?us-ascii?Q?gWxxcAo3dhpWepg5xnC3ZEXgBi/NwCnLsm9k2gHsYiCUqSSoJ4EmV/mQePPK?=
 =?us-ascii?Q?/7dB12vFvYr33HLUMxvKYCrCU8ZVeCbHeWuNhsy61VjFPdFZwC39zVO5hVpA?=
 =?us-ascii?Q?RvF3UwAXkLOPAOQrRkR28HqL3+Em4dRiITfm126WC52mvIL+wVFMMNV8dT67?=
 =?us-ascii?Q?0rkRRy2fdfOIoC6OyeTtbvZ0QillBnYKXPipqC6Vz3j0UpD3SGT60O+rdqeM?=
 =?us-ascii?Q?WORCySajmFx69URUiknZxsHsFANpX3TrLCdErfsnocU9hYVrfobI+ovnE2Ev?=
 =?us-ascii?Q?2zYgrK5ok283MheUGYe21fMYi5ZHH+8JsvSteJGgVJIV00E2//ageYRtiCgU?=
 =?us-ascii?Q?SA5S6ab36Sy1b7hEQx4B61xCxK+QRCxvyAOGf35mqjZtRK6iACu5CDuH53Qg?=
 =?us-ascii?Q?hSM1YF3ezwVC8yypWh0fzYyfA6eCr9D9UY8G92NhduJxgmuG456Ph1or2/9F?=
 =?us-ascii?Q?RJM8AKIEDah8kcZvDpfKmV+NlFPqJcAaYsZobtAoPiOHg1Y/oBAjsXAYu4jb?=
 =?us-ascii?Q?jNakucFHOmm2dHD7l1iFUJc3zEqXko1FlyY+p1EkJrh2fmbR8GpQKJiLt5t4?=
 =?us-ascii?Q?fW0SmDv52rk9nEadCVO2alCuRAjliHddVCCiRYBv+uiCVJSCVA/LQW5zZDIX?=
 =?us-ascii?Q?rXJMqbiwvIBH0j3QCxj6mIs0F4Q+T7e0ADy1b3xjPBYsGyIAg9n7GvlZoNsn?=
 =?us-ascii?Q?uF7FnPrDGgMrhvgiZDH9MF8hTv+/p9UtDOqfAEQgDqaLuaDFSeWUki76gEFD?=
 =?us-ascii?Q?RJsEvve/bWx6MitluJfXaULfMlup85/NSGtq2T4tAUSCxV0NA4hDuQ7LAsbI?=
 =?us-ascii?Q?YH+1wkQTMpVC+NzHwE9+lpbezIBpnMZQ/vbENlAyDu454tkLmUmU6Rte0IRo?=
 =?us-ascii?Q?muEZfrVuRh4aH3rUVVKn2bkRn/1l3BGfGh1mIYI9Q3KRThNlQPnQpCHxbhz0?=
 =?us-ascii?Q?Djbs1Uj8NXKmr2g7seu5QCqEwZq2984eIQzl2+dZbQfD7gT5XfjuRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7xD3luccOl+FJ5TKS7Bzijg8G6kF4F7DlLkhql9vI7RlfKGWXZManrJTuejC?=
 =?us-ascii?Q?/tqPTE7qoe+fRV7j+SJDco80mH5ar6XCR9QyiOlfR4tRV108G6AJpVP//j8G?=
 =?us-ascii?Q?T9+ADHd47ht32AaxZTYPuLKnYnRqLDbFAITd2qCIlbS2WDbvxLJBMxKkzHEM?=
 =?us-ascii?Q?qX48WcsBPfz8SWeHHt/cIlZZ0Y8FNGjy2KkQfULrLWtUKjn0tGW9LcyzwqJB?=
 =?us-ascii?Q?KofiSUKD9F2tbLQef6iDyHvJHb2XFyPhyZI1Nm6VdDcVu/Yml3XPQzrDJb2F?=
 =?us-ascii?Q?VPElV/oiUGC2o3qHvvEsA3JZg3eTOPS5dtCXckk2516SrNyVITa/m0OMlVMV?=
 =?us-ascii?Q?2iOH+I/3xrXvFCaUS9bTx5xRV/BBnwYAYX87TIzwCeUn4onzeo3lcZj0Ygg6?=
 =?us-ascii?Q?1/ySL57qcYNsEWmvICoMDAKiLhVEVCAM1ZOdwgIJrwC9Her3q7mZfcHLIstV?=
 =?us-ascii?Q?swxA9A2d3b/g7P4LvfJaHIakTYCe0eytYIcsvA/E/255+krQjGL8KKdzLQlG?=
 =?us-ascii?Q?7DGeuIB8Oofj92hgzJ3KNdurBV8CxVWUT+RBmXJ8hRKCXHMKvPgI5Zzji/yj?=
 =?us-ascii?Q?tkMZPNRXbXdO8vn6gLsZaVbv02xN9tS7wYuiVXXzo/jgnbCUU2NjWfrRvMT9?=
 =?us-ascii?Q?ZEF6OHBNjjI6P2qTS4XU6kCsMwid5+IUSZQfwvrUkWz7ms3JJKGHdYj4ZqCW?=
 =?us-ascii?Q?XtD+/rgNYuKE4ocRwGlFQqFJzjr/72joUO3U5R8WfuTLZQgEpT8qDGePansJ?=
 =?us-ascii?Q?x+Ht298pezWMn9TXSpNCfz2DY46T2XCBnisF+d9d+sCNQNQMWL5dKFK4nxpP?=
 =?us-ascii?Q?XvIfgPOJDlJAVa0u2U+a5l0YNwAaGDtAaPG0pkNsEzs8oxr7aBx1eDq0IToM?=
 =?us-ascii?Q?78MNY16dIcWbqbgpRLDLAtCrxWoqVzRmLt1VHivvin03p6Twd8ziGdyHETo3?=
 =?us-ascii?Q?QWKjeT94SiEEZKJ5sQYp7LiLK+YMZAdg9QwhoYEo8Sfc2wWcXZCIPELzB492?=
 =?us-ascii?Q?TlDdjrcffJslUsddhqPog9uFN8J71CFImV+0l3zK4Q8j36JNOqBqXBF1UUNm?=
 =?us-ascii?Q?v8Lnx56JRgG9vgRgPiDG+qG5capjy5AUfJbOqtR95GBzhISxPGgw7BDoAq9Z?=
 =?us-ascii?Q?E8jr4+WN3dLFhIBe2HGV1aFOzpiyOP9gWHy83gjoqZ9jC71YZAsx3gsSD+X3?=
 =?us-ascii?Q?EpnsrdpaoTh65Z0lxueq6C9J1wmMvDy1LB6VXRd+DFgWAwaCTCGqXlnPbWkc?=
 =?us-ascii?Q?rMwD8R6eOBXfM8c7SA9MI3K+xzCfNg7RORZbJnESaZtpjbz/hxCMFHTgtGfe?=
 =?us-ascii?Q?rwfHAr1WKpzK5vxAkkaDULmV1DUIOqZmZTwYOV6hV8v5MnSKqOrglbQlEmjY?=
 =?us-ascii?Q?S/ADa+JMbN+E4znuztunJ1ZaOPnyVDW+l9Xlqt2LqZX7VhjXokydCmB9XkcR?=
 =?us-ascii?Q?ccqE2tT+8oooUdBkpLZ51m3UiG9A8z/PX+dh3L2dCJBW/xPMnq0htafK8MpA?=
 =?us-ascii?Q?emxrY7+Ky0/0Bu/6MdpJMrMZpP5Ow7TBHywU0VmTXZs8J52aBh1QATkxaMNk?=
 =?us-ascii?Q?O7K4a9za12hdN01Bx/gFfSCRE0hY7LPrOQU51xQYFauBeqP4P5Am6fM3ukGG?=
 =?us-ascii?Q?hnSnEFrR0TGQIQtw8NwSKnju65zSilkSdQHjjetrRDyb5J9q8uw8Ph5POqRu?=
 =?us-ascii?Q?+UgvXQEoElSgfVqqwUYZdX1Vp2pwoJ1UM9X9z525vL8kUdOi8jB99yUVvea5?=
 =?us-ascii?Q?i7ORG1fk8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VeLECKEchphXtluNKao80ZQQV+rRjX6ShnLsmjlqj5C2SraF583DXgE1ZVCyq+0yZePjMW1Ay/Tdtq9fGZm5t8utPwwj+in1VIIk2eg9qNc3bWDdQth0JaU9DTe5Y5fTa5fms1bSSsw8oQGD44LKnMCXUm2gg9pF+PzlyPAAuX/i0LBVwnvVSDOqFmzSY4WgnxrHbVdihdFo2gykdW/bdmpfetZjDhACFCscvmIsq3QUqqKmRE2yjrIIvZp8/vNa0P8hb+zYRJbu3bqJHBpXwkmy0owYVPObfhee//XrTNGhu2cJqycCwQQtETTo+2waRj4FC0DmzUXF0bSLSM1eUGC+VUnkao7GT+Eek1BhSEq75SSmmU93df8nU4olLr8TuBvTf2y1Cgvw2ZbgzSkHybxMUxohGy2x9AaPqBQ87rs9Tsr34HAJN4Vv7OW6y03DVUAC2p+0fwTIrD+p5zqdb4JJi8g20qSsGFfoGiQ5WTRsN8HAv+qXc04EDU24rSGmWEDmD8bFplXrHOpYFitsiQvq4nYlqnAXdalgZzd1635Tgz3WjMQQpMeKp6U2kQ4ZQj/egvx3dsKfp0sjKAYFQK2UdOlyNYX1sYT8NmSeFiM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d63e94-3ae0-4f63-c670-08de526bac82
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 06:19:14.5177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjyh/jyq7+cYEps/MlcFqSVHmTq5MfyyOWC5tmKe7bE1uojoFgjEPmEtu2dO3n9TMiieTe7FHfkHE8rD+CB50A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601130050
X-Proofpoint-ORIG-GUID: EWa9P8Tny7-Y78ZJzNkVcddkryCrFmMb
X-Authority-Analysis: v=2.4 cv=YKOSCBGx c=1 sm=1 tr=0 ts=6965e3e5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=4y3Wp0Wu7Q92bxCIkH4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1MCBTYWx0ZWRfXwEAvVmb+dqRb
 aWRAX1KrQmhRByW+webYiftrbUfysZZE01n7zYHn9Am7fP0r5k4JknM1UFTnSACALyCxUcPMxAY
 OtqQz/5bGK8N5cWU5NsObqr+fxBeKvIkEM53oz7naO5N/yR5rEWu7LesgOrY5W4q/2jBxFHGvkn
 8dESvvNKpQLQcFGeTLtmq9x6fuxQ7veMrXahe27PXG8C4TGK0PI06XoRVPV2VbpOAeo5vBhtMNt
 j1uCnCK6gEgpjCJ3wnuCsF5RN03izJ2JeR2ZuyZHU1LbBlO0D2oWeGo19TvFmw4pQToHRdvQARU
 hIEQU61yJ4oebs/do7SWyarwzYhou17Bm1aa1PCGvXTk/YhubANAKRgLOTQoQyfnZ632++osOO7
 DZMecXhSbD1VhgzR6IXHmRV8P6HIJLxdkDN3NHQ7dCrNBu56UeSaH80DCRiSB2TocV+NMbePVS7
 O/w9NY8SAzjDcvrZdJw==
X-Proofpoint-GUID: EWa9P8Tny7-Y78ZJzNkVcddkryCrFmMb

In the near future, slabobj_ext may reside outside the allocated slab
object range within a slab, which could be reported as an out-of-bounds
access by KASAN.

As suggested by Andrey Konovalov [1], explicitly disable KASAN and KMSAN
checks when accessing slabobj_ext within slab allocator, memory profiling,
and memory cgroup code. While an alternative approach could be to unpoison
slabobj_ext, out-of-bounds accesses outside the slab allocator are
generally more common.

Move metadata_access_enable()/disable() helpers to mm/slab.h so that
it can be used outside mm/slub.c. However, as suggested by Suren
Baghdasaryan [2], instead of calling them directly from mm code (which is
more prone to errors), change users to access slabobj_ext via get/put
APIs:

  - Users should call get_slab_obj_exts() to access slabobj_metadata
    and call put_slab_obj_exts() when it's done.

  - From now on, accessing it outside the section covered by
    get_slab_obj_exts() ~ put_slab_obj_exts() is illegal.
    This ensures that accesses to slabobj_ext metadata won't be reported
    as access violations.

Call kasan_reset_tag() in slab_obj_ext() before returning the address to
prevent SW or HW tag-based KASAN from reporting false positives.

Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Suggested-by: Suren Baghdasaryan <surenb@google.com>
Link: https://lore.kernel.org/linux-mm/CA+fCnZezoWn40BaS3cgmCeLwjT+5AndzcQLc=wH3BjMCu6_YCw@mail.gmail.com [1]
Link: https://lore.kernel.org/linux-mm/CAJuCfpG=Lb4WhYuPkSpdNO4Ehtjm1YcEEK0OM=3g9i=LxmpHSQ@mail.gmail.com [2]
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/memcontrol.c | 12 +++++++--
 mm/slab.h       | 54 +++++++++++++++++++++++++++++++++++---
 mm/slub.c       | 69 ++++++++++++++++++++++++-------------------------
 3 files changed, 95 insertions(+), 40 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index fd9105a953b0..50ca00122571 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2604,10 +2604,16 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
 	if (!obj_exts)
 		return NULL;
 
+	get_slab_obj_exts(obj_exts);
 	off = obj_to_index(slab->slab_cache, slab, p);
 	obj_ext = slab_obj_ext(slab, obj_exts, off);
-	if (obj_ext->objcg)
-		return obj_cgroup_memcg(obj_ext->objcg);
+	if (obj_ext->objcg) {
+		struct obj_cgroup *objcg = obj_ext->objcg;
+
+		put_slab_obj_exts(obj_exts);
+		return obj_cgroup_memcg(objcg);
+	}
+	put_slab_obj_exts(obj_exts);
 
 	return NULL;
 }
@@ -3219,10 +3225,12 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 			return false;
 
 		obj_exts = slab_obj_exts(slab);
+		get_slab_obj_exts(obj_exts);
 		off = obj_to_index(s, slab, p[i]);
 		obj_ext = slab_obj_ext(slab, obj_exts, off);
 		obj_cgroup_get(objcg);
 		obj_ext->objcg = objcg;
+		put_slab_obj_exts(obj_exts);
 	}
 
 	return true;
diff --git a/mm/slab.h b/mm/slab.h
index ab7b3e386fbb..5176c762ec7c 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -510,6 +510,24 @@ bool slab_in_kunit_test(void);
 static inline bool slab_in_kunit_test(void) { return false; }
 #endif
 
+/*
+ * slub is about to manipulate internal object metadata.  This memory lies
+ * outside the range of the allocated object, so accessing it would normally
+ * be reported by kasan as a bounds error.  metadata_access_enable() is used
+ * to tell kasan that these accesses are OK.
+ */
+static inline void metadata_access_enable(void)
+{
+	kasan_disable_current();
+	kmsan_disable_current();
+}
+
+static inline void metadata_access_disable(void)
+{
+	kmsan_enable_current();
+	kasan_enable_current();
+}
+
 #ifdef CONFIG_SLAB_OBJ_EXT
 
 /*
@@ -519,8 +537,22 @@ static inline bool slab_in_kunit_test(void) { return false; }
  *
  * Returns the address of the object extension vector associated with the slab,
  * or zero if no such vector has been associated yet.
- * Do not dereference the return value directly; use slab_obj_ext() to access
- * its elements.
+ * Do not dereference the return value directly; use get/put_slab_obj_exts()
+ * pair and slab_obj_ext() to access individual elements.
+ *
+ * Example usage:
+ *
+ * obj_exts = slab_obj_exts(slab);
+ * if (obj_exts) {
+ *         get_slab_obj_exts(obj_exts);
+ *         obj_ext = slab_obj_ext(slab, obj_exts, obj_to_index(s, slab, obj));
+ *         // do something with obj_ext
+ *         put_slab_obj_exts(obj_exts);
+ * }
+ *
+ * Note that the get/put semantics does not involve reference counting.
+ * Instead, it updates kasan/kmsan depth so that accesses to slabobj_ext
+ * won't be reported as access violations.
  */
 static inline unsigned long slab_obj_exts(struct slab *slab)
 {
@@ -539,6 +571,17 @@ static inline unsigned long slab_obj_exts(struct slab *slab)
 	return obj_exts & ~OBJEXTS_FLAGS_MASK;
 }
 
+static inline void get_slab_obj_exts(unsigned long obj_exts)
+{
+	VM_WARN_ON_ONCE(!obj_exts);
+	metadata_access_enable();
+}
+
+static inline void put_slab_obj_exts(unsigned long obj_exts)
+{
+	metadata_access_disable();
+}
+
 #ifdef CONFIG_64BIT
 static inline void slab_set_stride(struct slab *slab, unsigned short stride)
 {
@@ -567,14 +610,19 @@ static inline unsigned short slab_get_stride(struct slab *slab)
  * @index: an index of the object
  *
  * Returns a pointer to the object extension associated with the object.
+ * Must be called within a section covered by get/put_slab_obj_exts().
  */
 static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
 					       unsigned long obj_exts,
 					       unsigned int index)
 {
+	struct slabobj_ext *obj_ext;
+
 	VM_WARN_ON_ONCE(obj_exts != slab_obj_exts(slab));
 
-	return (struct slabobj_ext *)(obj_exts + slab_get_stride(slab) * index);
+	obj_ext = (struct slabobj_ext *)(obj_exts +
+					 slab_get_stride(slab) * index);
+	return kasan_reset_tag(obj_ext);
 }
 
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
diff --git a/mm/slub.c b/mm/slub.c
index 41c541381627..14c58038a37e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -975,24 +975,6 @@ static slab_flags_t slub_debug;
 static const char *slub_debug_string __ro_after_init;
 static int disable_higher_order_debug;
 
-/*
- * slub is about to manipulate internal object metadata.  This memory lies
- * outside the range of the allocated object, so accessing it would normally
- * be reported by kasan as a bounds error.  metadata_access_enable() is used
- * to tell kasan that these accesses are OK.
- */
-static inline void metadata_access_enable(void)
-{
-	kasan_disable_current();
-	kmsan_disable_current();
-}
-
-static inline void metadata_access_disable(void)
-{
-	kmsan_enable_current();
-	kasan_enable_current();
-}
-
 /*
  * Object debugging
  */
@@ -2058,23 +2040,27 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 
 static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
 {
-	unsigned long slab_exts;
 	struct slab *obj_exts_slab;
+	unsigned long slab_exts;
 
 	obj_exts_slab = virt_to_slab(obj_exts);
 	slab_exts = slab_obj_exts(obj_exts_slab);
 	if (slab_exts) {
+		get_slab_obj_exts(slab_exts);
 		unsigned int offs = obj_to_index(obj_exts_slab->slab_cache,
 						 obj_exts_slab, obj_exts);
 		struct slabobj_ext *ext = slab_obj_ext(obj_exts_slab,
 						       slab_exts, offs);
 
-		if (unlikely(is_codetag_empty(ext->ref)))
+		if (unlikely(is_codetag_empty(ext->ref))) {
+			put_slab_obj_exts(slab_exts);
 			return;
+		}
 
 		/* codetag should be NULL here */
 		WARN_ON(ext->ref.ct);
 		set_codetag_empty(&ext->ref);
+		put_slab_obj_exts(slab_exts);
 	}
 }
 
@@ -2244,30 +2230,28 @@ static inline void free_slab_obj_exts(struct slab *slab)
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
 
-static inline struct slabobj_ext *
-prepare_slab_obj_ext_hook(struct kmem_cache *s, gfp_t flags, void *p)
+static inline unsigned long
+prepare_slab_obj_exts_hook(struct kmem_cache *s, struct slab *slab,
+			   gfp_t flags, void *p)
 {
-	struct slab *slab;
-	unsigned long obj_exts;
-
-	slab = virt_to_slab(p);
-	obj_exts = slab_obj_exts(slab);
-	if (!obj_exts &&
+	if (!slab_obj_exts(slab) &&
 	    alloc_slab_obj_exts(slab, s, flags, false)) {
 		pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
 			     __func__, s->name);
-		return NULL;
+		return 0;
 	}
 
-	obj_exts = slab_obj_exts(slab);
-	return slab_obj_ext(slab, obj_exts, obj_to_index(s, slab, p));
+	return slab_obj_exts(slab);
 }
 
+
 /* Should be called only if mem_alloc_profiling_enabled() */
 static noinline void
 __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 {
+	unsigned long obj_exts;
 	struct slabobj_ext *obj_ext;
+	struct slab *slab;
 
 	if (!object)
 		return;
@@ -2278,16 +2262,23 @@ __alloc_tagging_slab_alloc_hook(struct kmem_cache *s, void *object, gfp_t flags)
 	if (flags & __GFP_NO_OBJ_EXT)
 		return;
 
-	obj_ext = prepare_slab_obj_ext_hook(s, flags, object);
+	slab = virt_to_slab(object);
+	obj_exts = prepare_slab_obj_exts_hook(s, slab, flags, object);
 	/*
 	 * Currently obj_exts is used only for allocation profiling.
 	 * If other users appear then mem_alloc_profiling_enabled()
 	 * check should be added before alloc_tag_add().
 	 */
-	if (likely(obj_ext))
+	if (obj_exts) {
+		unsigned int obj_idx = obj_to_index(s, slab, object);
+
+		get_slab_obj_exts(obj_exts);
+		obj_ext = slab_obj_ext(slab, obj_exts, obj_idx);
 		alloc_tag_add(&obj_ext->ref, current->alloc_tag, s->size);
-	else
+		put_slab_obj_exts(obj_exts);
+	} else {
 		alloc_tag_set_inaccurate(current->alloc_tag);
+	}
 }
 
 static inline void
@@ -2313,11 +2304,13 @@ __alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p
 	if (!obj_exts)
 		return;
 
+	get_slab_obj_exts(obj_exts);
 	for (i = 0; i < objects; i++) {
 		unsigned int off = obj_to_index(s, slab, p[i]);
 
 		alloc_tag_sub(&slab_obj_ext(slab, obj_exts, off)->ref, s->size);
 	}
+	put_slab_obj_exts(obj_exts);
 }
 
 static inline void
@@ -2384,7 +2377,9 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 	if (likely(!obj_exts))
 		return;
 
+	get_slab_obj_exts(obj_exts);
 	__memcg_slab_free_hook(s, slab, p, objects, obj_exts);
+	put_slab_obj_exts(obj_exts);
 }
 
 static __fastpath_inline
@@ -2434,10 +2429,14 @@ bool memcg_slab_post_charge(void *p, gfp_t flags)
 	/* Ignore already charged objects. */
 	obj_exts = slab_obj_exts(slab);
 	if (obj_exts) {
+		get_slab_obj_exts(obj_exts);
 		off = obj_to_index(s, slab, p);
 		obj_ext = slab_obj_ext(slab, obj_exts, off);
-		if (unlikely(obj_ext->objcg))
+		if (unlikely(obj_ext->objcg)) {
+			put_slab_obj_exts(obj_exts);
 			return true;
+		}
+		put_slab_obj_exts(obj_exts);
 	}
 
 	return __memcg_slab_post_alloc_hook(s, NULL, flags, 1, &p);
-- 
2.43.0


