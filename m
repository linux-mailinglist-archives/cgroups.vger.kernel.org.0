Return-Path: <cgroups+bounces-12583-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC413CD5C31
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 12:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAF643022A9C
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 11:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55492314B75;
	Mon, 22 Dec 2025 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JR1dUPkg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cJqcJwf+"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ABF30F52C;
	Mon, 22 Dec 2025 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766401804; cv=fail; b=NgkRLOXxsPnxHPIfYVpuxonvXiUAiHGL0/4NxbecV3du59B0HRahpZHSF0iLfW8ulTtq/AyWON6h4HfR4a+t1Hl9vDj3Tpx3vv21XLVLSgLRbT+TOMQXFqiJ1X7NhofuBCDjhrShPapFNfOfKVWucHn5BWzv/mOiHu8f6rjwZeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766401804; c=relaxed/simple;
	bh=a4xKflMNrhe/H5hl4F3vsP3/XB90XoErqOBQp1Za5uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P9BV009MjuG3oWEhcBqJSA0hC/O58pf8DUsVs7GffT9RcIjwYY1zDGNTS6iLgFZw5DXUkF3QoQqYxcNjieUYZ6k4AiFShDH0uySNIBbcpWzyYeA5aSDKynyw/5/i/UxurauqjrO+FSVgd0dklgZ5NrV4TD6DWFh++eBErVgUzwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JR1dUPkg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cJqcJwf+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMA38bI2073578;
	Mon, 22 Dec 2025 11:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mhhdylc3s9FzOyPDoMxdrEKCzQknmYK+3fWjeEARqHE=; b=
	JR1dUPkg6TGnUy5nrYKGAIYgFsgGFHz1h/feRWVwRuZP3g3ww+I/K8hQj19UXzJP
	fDkmLEYKg+KE/tLTAKyBMrxcSBDe0MnA03fEl2Wry2eK6I4JNeJJbhE3gVczFHOv
	fR5W8acaRvC44/S1NxPKKOhD2kbo9f0QbjLtAosP8L1KV5slLTQxYEd46QWJIMFq
	N4dP02PXb3FVs1SvPgF1kkctHbNJpAEYiGqyKob8ajK3L5PJsROlWVohDcV/0pR/
	DxLzAoVptjRGbbaacr9h2ozmWMYp/GjqZDBLENzdqRpPd0Fty1PHmx/fECjfvUSP
	x8nPCqKGTHqf6V+bssw/fQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b73vvg28a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 11:09:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM9EWZR002438;
	Mon, 22 Dec 2025 11:09:25 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013056.outbound.protection.outlook.com [40.93.196.56])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j876mug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 11:09:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLWQ0kYorx+aCRr9+9RdbIzQqecosolSrbxLwe9TfDyXAhMij4Y7sNS7AJ7vMR3Mz6WjqRt/crYN1RoVrvKtAUbi5+eMK/WDfNUJm06a9xx2O2seQtUBoFYypOsjMMh7WdTWm2MOCo2KGEu46CenXWMhhMruwLO8bRWPwT6duPaXM8xh6i3p/PmtfGZ5aXILSbj2l4788b4N/pGaeaIlcXbtOhW1mmvqo7b5YzUWW5tWJLDvW89DGo5XfaxYN4wdpDtU7OedpDgUUN3LxY3S8pSgyw4SVnxWUCU2eWtO3FZ7yaBxDXCxW3pNqJYJfoTo2jQifFgsEoOeIdE2v/hIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhhdylc3s9FzOyPDoMxdrEKCzQknmYK+3fWjeEARqHE=;
 b=Q2Y8rFFQOjMmQQhE/v62D72dXFwUayGA1fvMSI+E4jsPFR92/HmZRoZZ2txWLEU0lkwmetLuf/klnZaS6EJfM5ISVxVaaqqYg4xDPKeY4tlWziYgGmA5icbdHMRib2oTGjM2Xk6BhFXp7P6Mc26/MoQE9s7rm5J7pglFAL/twHXiURp2v2lGZD61ZHQc54BFKjxX8u7SLmVC46+NPGhpM5uLMh1FZw0DWzfeSwTMuD4J9aPnbHcSZcBj5pIJJ54JhUpmlAwKeXbr7yRUoVsBJ0QgWW7i1EZ0VYN5Tnxsi7o2NO6yZ1YNFiTxbYiv2alFYCthslpqyE6aDMpXG2X7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhhdylc3s9FzOyPDoMxdrEKCzQknmYK+3fWjeEARqHE=;
 b=cJqcJwf+AJKfOft3hvYegDCcTT0KemoklICh7H6s3IOYBq0Z13lLSViOx0uOKeZLB5oi4lJX8yUwrw6/0odL6Vx6H4/aVQpxOONGxMkgNfRrs3hio1liCBvXVvg048yQa8EnXPq5AU1jsQIe4D5YcV3T4Yqw5gqNZ+ryByHTqaA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4741.namprd10.prod.outlook.com (2603:10b6:510:3d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Mon, 22 Dec
 2025 11:09:22 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 11:09:22 +0000
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
Subject: [PATCH V4 7/8] mm/slab: save memory by allocating slabobj_ext array from leftover
Date: Mon, 22 Dec 2025 20:08:42 +0900
Message-ID: <20251222110843.980347-8-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222110843.980347-1-harry.yoo@oracle.com>
References: <20251222110843.980347-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0040.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4741:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc823a4-55b3-45fb-b08f-08de414a8f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LiM6gv1bfuhh7cBXUhQMDV0vGRNaJKRweVlEKiMO1EVylv0vkc3JmYLhOA8W?=
 =?us-ascii?Q?8knopwCRXqqw2xiFFuE8qZz/fduRF/hYKP6YZ5CObEexf/2EPcLBRPOHrt68?=
 =?us-ascii?Q?X9ydDHTSNygdsTaZoUTeGfIjToQDfPKmVixq2GzoFPISJpQxNyavpU5YQp1R?=
 =?us-ascii?Q?R8qiYpp/allDvwVtGIVONbCAxTk3nkKxWse3K1cKHkDe0C/sh9zXPdQOAFJM?=
 =?us-ascii?Q?GM05AHYdbfylrkmX7ETPaOXgiwSzZmXyle6OUegjOAGGWSgMRjLZ8qVgCXck?=
 =?us-ascii?Q?gkawpyYI7TPO9ZJ7m6UTeizb1uS+HsX0kq4b6FmgaXz2K+2GApHHMw+Dt6mB?=
 =?us-ascii?Q?7h84Io/qmi/qnwvMubs1xaZSOARCaQiSNJP/nDzo/K8OzNCBLDmPe8Y8bRGy?=
 =?us-ascii?Q?zQvlytrpGiMdppYwqn+5gSw1EIQrClFzeTT9U0lXzMBUmASjqUCM0Ht63Q+0?=
 =?us-ascii?Q?CI+XW6F4ODcs8OL8LNyJ8fJ/jAMJjtDBrzFJTR2lZ0IPECsc5SysPD0f3oZq?=
 =?us-ascii?Q?xi48TJRKrvjQZmNxsLzIt5LxDwAy0qjUcT1wvYMHJGzAqi2BsaON11NPDlqy?=
 =?us-ascii?Q?WQse76fgpo5eS4iVPKlhygm2wxxrDe8tuGaE1x5Wl7vzPv8OaYHM+lzcfuL2?=
 =?us-ascii?Q?2KFXeTR15+5ICwkpPvReyE/9rCKJaESpKQX9WuCcIKytH7teOoUz9sZq6Uk5?=
 =?us-ascii?Q?OSr2oX2/b+1zwbhRrPtuRi1x6Lpggn95KWi8woJOXXkoYoTZhsVgTYyaXhxq?=
 =?us-ascii?Q?OmV306oYOF9PMHGJ6b5HKeHjEm+Mx/8neWDSg6wTylshwkeWKUfOtQmWgEEd?=
 =?us-ascii?Q?rJABdoSXl5Zarx6YerDjpMSeIK3pFz2LxrjV6eGH11vN/b2PcWAHLsZjoV5u?=
 =?us-ascii?Q?OuM13nR/SakIGhSLgXzoX5/UBQFj9iRaSe/++/gZsUbBC9SNFgdsOi6qrRrz?=
 =?us-ascii?Q?YjSOS+rw7avCHpX3gb1R3kq3wXnS3l/R6JOFsIvUX8mITZBFsCNxgcBmnMSe?=
 =?us-ascii?Q?0U3GAM+L1eBuVlkGaXZ5QgkXayQ8aG1d8sIZYLWdre2aooWa33YIrSzRqn/A?=
 =?us-ascii?Q?UcgNMf96yHDG/Mmv6lu+Y0hVB++e9WW8byWVxoRd4YghKNmSSuUt4STQHsUM?=
 =?us-ascii?Q?8s5nNxMm5aYSzCT06m2YAWLnVQbC0J8em9TvvRKorl+tOAeZNB7WhYcfJNxf?=
 =?us-ascii?Q?NfmpxdYcmCwa8y6jqEoizsDFjCCPEe8YUbwH6H1tHc4/peakRjgud3tKNCzI?=
 =?us-ascii?Q?lCPvjl7AgL3NFq2zFvGXMWsQRCTuJVVTFXOnomMvQnnS0PKtPDk8VWKeRT3k?=
 =?us-ascii?Q?rituYsIr1krQLL7Rh6fjfBfj9DZ9iF8529ooEsXDEzx8wf3u31Cbp9A9LqGk?=
 =?us-ascii?Q?3VC3eHQS9R4XtqL9+e+D3n5XgNkWNO2EdM11FtNwwC7Uc3E4bma5Phosg3+W?=
 =?us-ascii?Q?lAqMXIgv5cy35mEm/QA/SHfjwdWdWcJVkWUAyMVnNCKnFkrxhd9yFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b6eWYd19FHLJWxUu6U5zE81eFP32QuyI+uxD0+paWTiGIDvnFggoZ6WtwDlZ?=
 =?us-ascii?Q?JgyJ3z7+E3ut3sIwp0HuCB3fNvzDmTqKwktphexEzB+IH6gBoItF4+DZ0vwG?=
 =?us-ascii?Q?GW25p9mlwAWKZAP2pouRX1PlFldzRLQAwou55hyU8tY4DW8Q2CgTesbKIAn1?=
 =?us-ascii?Q?0eLmiLEG7Jma/wnIKW4X7QCzN90RK7IVExht3WUk73GKEGz6K7Er/RoUCmgu?=
 =?us-ascii?Q?ydHDqXZ/yB5UnK1+skZMNoGaANtqcPshw2LsxUJhnEK6M6FpsqDUZv4TCh4w?=
 =?us-ascii?Q?2FdUxjBO6Umik5JYzn6Pl1kwlfOd+Qie2kX3gum0Tp+VKaoRFn9jlfU88OUn?=
 =?us-ascii?Q?a74tb4oPi/7jzkZ+o95ZPA2KqATrTEl6YfIdh02gsEH0D5fomaBsTkWoATTs?=
 =?us-ascii?Q?s609Z+mTfIHglx94rizDVY7RiDQm6WttDyznilGwbq8ejuL5R1T3wi9dTPzD?=
 =?us-ascii?Q?dHBxra30uDev1R1WxClBhCoKopMwKgKv2/0TYMXkx5MYWZS0DoS+j6ZZtrPt?=
 =?us-ascii?Q?vFy5HXU0PA+cPijgg8IZzlYIfRY+qNPtUuVTaKkiwsD4C6l5enIhUCE+E7Ge?=
 =?us-ascii?Q?acm/4HkycoeKFle0k9+4OatfxAXHiK5gOblbvfb8wUFgqUx9kTKlVSm1iGJJ?=
 =?us-ascii?Q?1aI85rs90lwYs8fku5ux9uYaXk5ujeKJp6JrP7LYsLUDFt/F7UIOKDJtaya5?=
 =?us-ascii?Q?HNWGQ79x9zfKM2JUaPi5+vNovqdMGA4hBJ77/w/eB5kXrsNiECqTp1Efj5/7?=
 =?us-ascii?Q?yn602wFty7vPIu08KzEFHEcZs4Gk1kFOk6bLz2yLdwaUlwt+w8qR5QTHxCuF?=
 =?us-ascii?Q?26XS8dq2e65ld7nB2jyyoXTYG+2j93YCp4dODkU6hlAP5oltc712PEG0UYUb?=
 =?us-ascii?Q?rAvBGgilocvnV6bc/ylMqslHosPbaK7msgblbh0wlHX+pXRCI/f/s8Ksq7xA?=
 =?us-ascii?Q?/9P3OU5tuEkpm1SYzOqUrilczHhzxc3U0vlQOrd22WQECcXmIJaHkiKHS+Qo?=
 =?us-ascii?Q?iQZUyh710Ej6CRgnOp02Cjj9Zv7dXdPNFuzAlk8iVoj2WG4wPh783FOUh5Q5?=
 =?us-ascii?Q?D6ADOITIaeff0t2rv1ZRiFPQnCmE+UfFPefRlHv7Tk7ICuGWKQJX+pJ0cYCd?=
 =?us-ascii?Q?ULKBY2nvGCKsol1JNeWpwy0wtd22f7oSyERLGInr4IUIUzVLeetP07qQ1Fy+?=
 =?us-ascii?Q?9QSYTAHrB4gDQEsZZFKISh1BYMyYtjaZA8/mIiQgEPjktZ03+/Vd0qZPP9HO?=
 =?us-ascii?Q?SD0VcOnGDuA2g/bPv6vM+ONsd4onA9JJqr5xZJxdsB4IFgTae2rHx+AiXNJU?=
 =?us-ascii?Q?k3ye5OFBx3bKMjh8a8SWDWGusp3ugLaA0RRQVAjt7wP65kVq0DHxlY6UN+LH?=
 =?us-ascii?Q?F1yk0KEJnqbomTpnHfrAiAXh8bUmFqq6qOSfG9pKZbUFEEnrS/YGHJ01CkuV?=
 =?us-ascii?Q?/PuODhveORnqPpw66dnCdyAFD2qZnHOmphALqA7D/IXE/lP8rxPDiG+EtZGt?=
 =?us-ascii?Q?xvw7wXdGSXiO3k5ibt/1FCySdpal9zImRCg9AEQeM5OOB0nAJR7PBKh1phWd?=
 =?us-ascii?Q?QlDWZ3JagZmkZg27QcCvfAye3TbPVHXkUZdqh6kdEkh4q1hK8bUTU6gpaxH5?=
 =?us-ascii?Q?RE1dv7wNMGXboOCCsnIuVhbIDh4ZaN406mm5gb3O/p4PKIrdM4Eqt1Z77BRY?=
 =?us-ascii?Q?1SexotCLmd2Tl9rpaA3OvnKLqUFbUeCN+/anDc05mD1IGZ2NB+pUXSmMP5v9?=
 =?us-ascii?Q?MObDzn+JXg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U5EaG3dXjmmOZaNY23XB99VXxAf6tvqsKtKmBbqrd8nKFmm1q5JwF7Ijpy39xWuiSpkTkBRFZ3YmXAnRz13U7CkIB+er68IZaWlPLuAvQAIfVOXrzcXZYDRLnk5n23AXRtMk8tPupKuHwZ1CUdHGV2al5eB8WyiFa3AJ5vTdmDgk8Qy6qbRcHr8dbp74YUzgtjiXMV88OazmKjZPkr1Dz5+/HnCQJvVxSI9DD8zdyAQhAVXF639XJ8OQQRCuNO0momQqD4oCMALy9wdY470ComMXKOAyvmL0//y2h7GKj61qwp3QrIZ/N8x+AvIckCT2ItovfBh3BsJgFn65KdC33z2TmoE3Fm6TkNVjusSElQL2cDvOOcBvTM1rD0yfsbMuMWADtqIx/mV0u4C/biTKktBm0t/SpIus8kEKLC/FEEdQkABO0BcGgUidySvQgDzPwOE7l+yEuiVhM1FtrjbO0H+NmFnC0T/NEo9LgdDyktbW8t4Auu4qzoBymuYms2kczp48CPJgCZyIeilyo0QlV8LTY323uCE6+GWV+Aau/ZjbOotc9rbTZ4wTNS/EniYPDHqKwZZ1PrWgZukgB6OA1galhbI/FOMV6I92/b1hBKI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc823a4-55b3-45fb-b08f-08de414a8f4f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 11:09:22.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sjl1h5BaT0eC2GZXtIgnAaU6TTc/XZy73YUkBNQSNkgEmDLQuhlID+jtzXR84B0D1Ae05E7H6XMn881bCUcDzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512220101
X-Authority-Analysis: v=2.4 cv=VeX6/Vp9 c=1 sm=1 tr=0 ts=694926e6 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=JVGYsnW0c5-8z4_xaEwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDEwMSBTYWx0ZWRfXweYSQFAglIHp
 5WvnmcqgFfjurw0ziCKKrRXwj6Rxz0uFp8x0UwAXUghxBSaqqh408gno1X6O6MY65SRWPY1cbsP
 SkCTkeoqFiPDbBsKuXRq+2kw9lGtC3XPOi17GOTFXMfBZ9wge4GjnlIErCDQSYtxNDJ1QIVUxys
 5NS+zEwDJSBmA+YeRUAtiqxs1fTbglco6KuGfCTsq2JGY5zrr1x67a+Lyr7lo1Y3Q/3vG/OlFYG
 FNp4CUf0TqBPYPoou78bezdodMR8SeQxzB2pbxzCAwqg29wcQIltJog94imtFfQ5w6tN2UQxoV+
 0z4kIOc0Fm9o+6oY/OXXeZKMQ2DRJ1EHTZkBi5kehW6asT+Rmy/UjZvqsEiD84cfCGu3kO6ZkE9
 3HFgilve+UjxV/agndG+fbOsODEzxIfY6ijkyKtE1b7E3OfssSPj1AHExg8ioIVcyY5i9QEiCbc
 p0QH6nR3tqgFCRlxe6w==
X-Proofpoint-GUID: nmqiu84T9oz2fNjopSKsBAKgkRt6OgUi
X-Proofpoint-ORIG-GUID: nmqiu84T9oz2fNjopSKsBAKgkRt6OgUi

The leftover space in a slab is always smaller than s->size, and
kmem caches for large objects that are not power-of-two sizes tend to have
a greater amount of leftover space per slab. In some cases, the leftover
space is larger than the size of the slabobj_ext array for the slab.

An excellent example of such a cache is ext4_inode_cache. On my system,
the object size is 1144, with a preferred order of 3, 28 objects per slab,
and 736 bytes of leftover space per slab.

Since the size of the slabobj_ext array is only 224 bytes (w/o mem
profiling) or 448 bytes (w/ mem profiling) per slab, the entire array
fits within the leftover space.

Allocate the slabobj_exts array from this unused space instead of using
kcalloc() when it is large enough. The array is allocated from unused
space only when creating new slabs, and it doesn't try to utilize unused
space if alloc_slab_obj_exts() is called after slab creation because
implementing lazy allocation involves more expensive synchronization.

The implementation and evaluation of lazy allocation from unused space
is left as future-work. As pointed by Vlastimil Babka [1], it could be
beneficial when a slab cache without SLAB_ACCOUNT can be created, and
some of the allocations from the cache use __GFP_ACCOUNT. For example,
xarray does that.

To avoid unnecessary overhead when MEMCG (with SLAB_ACCOUNT) and
MEM_ALLOC_PROFILING are not used for the cache, allocate the slabobj_ext
array only when either of them is enabled.

[ MEMCG=y, MEM_ALLOC_PROFILING=n ]

Before patch (creating ~2.64M directories on ext4):
  Slab:            4747880 kB
  SReclaimable:    4169652 kB
  SUnreclaim:       578228 kB

After patch (creating ~2.64M directories on ext4):
  Slab:            4724020 kB
  SReclaimable:    4169188 kB
  SUnreclaim:       554832 kB (-22.84 MiB)

Enjoy the memory savings!

Link: https://lore.kernel.org/linux-mm/48029aab-20ea-4d90-bfd1-255592b2018e@suse.cz [1]
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/slub.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 151 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 39c381cc1b2c..3fc3d2ca42e7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -886,6 +886,99 @@ static inline unsigned long get_orig_size(struct kmem_cache *s, void *object)
 	return *(unsigned long *)p;
 }
 
+#ifdef CONFIG_SLAB_OBJ_EXT
+
+/*
+ * Check if memory cgroup or memory allocation profiling is enabled.
+ * If enabled, SLUB tries to reduce memory overhead of accounting
+ * slab objects. If neither is enabled when this function is called,
+ * the optimization is simply skipped to avoid affecting caches that do not
+ * need slabobj_ext metadata.
+ *
+ * However, this may disable optimization when memory cgroup or memory
+ * allocation profiling is used, but slabs are created too early
+ * even before those subsystems are initialized.
+ */
+static inline bool need_slab_obj_exts(struct kmem_cache *s)
+{
+	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
+		return true;
+
+	if (mem_alloc_profiling_enabled())
+		return true;
+
+	return false;
+}
+
+static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
+{
+	return sizeof(struct slabobj_ext) * slab->objects;
+}
+
+static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
+						    struct slab *slab)
+{
+	unsigned long objext_offset;
+
+	objext_offset = s->red_left_pad + s->size * slab->objects;
+	objext_offset = ALIGN(objext_offset, sizeof(struct slabobj_ext));
+	return objext_offset;
+}
+
+static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *s,
+						     struct slab *slab)
+{
+	unsigned long objext_offset = obj_exts_offset_in_slab(s, slab);
+	unsigned long objext_size = obj_exts_size_in_slab(slab);
+
+	return objext_offset + objext_size <= slab_size(slab);
+}
+
+static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
+{
+	unsigned long expected;
+	unsigned long obj_exts;
+
+	obj_exts = slab_obj_exts(slab);
+	if (!obj_exts)
+		return false;
+
+	if (!obj_exts_fit_within_slab_leftover(s, slab))
+		return false;
+
+	expected = (unsigned long)slab_address(slab);
+	expected += obj_exts_offset_in_slab(s, slab);
+	return obj_exts == expected;
+}
+#else
+static inline bool need_slab_obj_exts(struct kmem_cache *s)
+{
+	return false;
+}
+
+static inline unsigned int obj_exts_size_in_slab(struct slab *slab)
+{
+	return 0;
+}
+
+static inline unsigned long obj_exts_offset_in_slab(struct kmem_cache *s,
+						    struct slab *slab)
+{
+	return 0;
+}
+
+static inline bool obj_exts_fit_within_slab_leftover(struct kmem_cache *s,
+						     struct slab *slab)
+{
+	return false;
+}
+
+static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_SLUB_DEBUG
 
 /*
@@ -1405,7 +1498,15 @@ slab_pad_check(struct kmem_cache *s, struct slab *slab)
 	start = slab_address(slab);
 	length = slab_size(slab);
 	end = start + length;
-	remainder = length % s->size;
+
+	if (obj_exts_in_slab(s, slab)) {
+		remainder = length;
+		remainder -= obj_exts_offset_in_slab(s, slab);
+		remainder -= obj_exts_size_in_slab(slab);
+	} else {
+		remainder = length % s->size;
+	}
+
 	if (!remainder)
 		return;
 
@@ -2179,6 +2280,11 @@ static inline void free_slab_obj_exts(struct slab *slab)
 		return;
 	}
 
+	if (obj_exts_in_slab(slab->slab_cache, slab)) {
+		slab->obj_exts = 0;
+		return;
+	}
+
 	/*
 	 * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore its
 	 * corresponding extension will be NULL. alloc_tag_sub() will throw a
@@ -2194,6 +2300,35 @@ static inline void free_slab_obj_exts(struct slab *slab)
 	slab->obj_exts = 0;
 }
 
+/*
+ * Try to allocate slabobj_ext array from unused space.
+ * This function must be called on a freshly allocated slab to prevent
+ * concurrency problems.
+ */
+static void alloc_slab_obj_exts_early(struct kmem_cache *s, struct slab *slab)
+{
+	void *addr;
+	unsigned long obj_exts;
+
+	if (!need_slab_obj_exts(s))
+		return;
+
+	if (obj_exts_fit_within_slab_leftover(s, slab)) {
+		addr = slab_address(slab) + obj_exts_offset_in_slab(s, slab);
+		addr = kasan_reset_tag(addr);
+		obj_exts = (unsigned long)addr;
+
+		get_slab_obj_exts(obj_exts);
+		memset(addr, 0, obj_exts_size_in_slab(slab));
+		put_slab_obj_exts(obj_exts);
+
+		if (IS_ENABLED(CONFIG_MEMCG))
+			obj_exts |= MEMCG_DATA_OBJEXTS;
+		slab->obj_exts = obj_exts;
+		slab_set_stride(slab, sizeof(struct slabobj_ext));
+	}
+}
+
 #else /* CONFIG_SLAB_OBJ_EXT */
 
 static inline void init_slab_obj_exts(struct slab *slab)
@@ -2210,6 +2345,11 @@ static inline void free_slab_obj_exts(struct slab *slab)
 {
 }
 
+static inline void alloc_slab_obj_exts_early(struct kmem_cache *s,
+						       struct slab *slab)
+{
+}
+
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
 #ifdef CONFIG_MEM_ALLOC_PROFILING
@@ -3206,7 +3346,9 @@ static inline bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
 static __always_inline void account_slab(struct slab *slab, int order,
 					 struct kmem_cache *s, gfp_t gfp)
 {
-	if (memcg_kmem_online() && (s->flags & SLAB_ACCOUNT))
+	if (memcg_kmem_online() &&
+			(s->flags & SLAB_ACCOUNT) &&
+			!slab_obj_exts(slab))
 		alloc_slab_obj_exts(slab, s, gfp, true);
 
 	mod_node_page_state(slab_pgdat(slab), cache_vmstat_idx(s),
@@ -3270,9 +3412,6 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	slab->objects = oo_objects(oo);
 	slab->inuse = 0;
 	slab->frozen = 0;
-	init_slab_obj_exts(slab);
-
-	account_slab(slab, oo_order(oo), s, flags);
 
 	slab->slab_cache = s;
 
@@ -3281,6 +3420,13 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	start = slab_address(slab);
 
 	setup_slab_debug(s, slab, start);
+	init_slab_obj_exts(slab);
+	/*
+	 * Poison the slab before initializing the slabobj_ext array
+	 * to prevent the array from being overwritten.
+	 */
+	alloc_slab_obj_exts_early(s, slab);
+	account_slab(slab, oo_order(oo), s, flags);
 
 	shuffle = shuffle_freelist(s, slab);
 
-- 
2.43.0


