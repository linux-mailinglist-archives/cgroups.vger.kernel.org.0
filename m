Return-Path: <cgroups+bounces-14726-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C7iKUuQr2kragIAu9opvQ
	(envelope-from <cgroups+bounces-14726-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 04:30:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0F8244D0D
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 04:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4629C31C100D
	for <lists+cgroups@lfdr.de>; Tue, 10 Mar 2026 03:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1426D3B961C;
	Tue, 10 Mar 2026 03:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AYDRT3FU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DlRTNwpF"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EA63AE191;
	Tue, 10 Mar 2026 03:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773113189; cv=fail; b=lTTCMmERHfkE6FxaD+Pr4NL036HQKL1Z3RLNuMrTTQBAGbavHVvaMMLNEbHeQcV9KLjHNjptK80W/bZty84efpi5dooCwyfQFNkbLGoB+RuXfZM9TCPL6iDSn7hWKGIkdbo+eVTQIgdvqzaYTtQnRaMjaOs+dqcGaJ4ryUasdRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773113189; c=relaxed/simple;
	bh=DMQtoglmXhnc1lD+PlC0sMnj4FZH8Jc/N9z6Cuti5GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EoiIrH7Y9Vnl+ePfZbBGvF2cxbdUTlXvMrBC1UObP6mnrd3sbsngrRCDV+aEmvw3ABjM96C4G4YRAlsxRzipqz86nsgyGGlJWSSwSj4+PUir8MVFzOHs+YHJspWCkZr7KGc3jhEgt7PrvmWG3NopBvVeAlmpXM4E3bZJYQ6F4gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AYDRT3FU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DlRTNwpF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629IN0rx2344410;
	Tue, 10 Mar 2026 03:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=REvQ/yEucPxvRhQd1P
	gcZC8KU9L2nD5peIpdfMlSdus=; b=AYDRT3FUJCFa/VlZ9ygC4Jh1sZ/jTgr6t8
	n6dAum7B1auVe0TLSwXdJmH692uCxuXQ5KbNjnUdX9VSbREeijHzltrYRLTA/4ji
	Mke0HEgW9SSueVCcSVTaYCp0z7fBdzxDalQVk5mRmVqBmfGjI57zpYWicXPMAPTe
	Ws0EZiUf1uP+E2p0D/Np61qxKV0ejQKAeUze/OBX5ynbjJ2AQnFhDD2z0eo9lOik
	81F9EEHXmgcaoEQk4M9L5Qg4LHo58jpjo+McPUA0TEA9ZrmLIb24MDLU6lyntXJK
	GA6W8XBnKOpfqkswjqMxJ/8ikEcwPsyxuBqnkyd7I4ayYXp2F9Cg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csks2j3qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 03:26:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62A11u7d022698;
	Tue, 10 Mar 2026 03:26:07 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4craf9h2ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 03:26:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsizGjDULUYo7ucjsGtCkrFE432G1VTmuPFsgtwPKjsx6bYsQkZ8N1t6zV3DLzT+qVGpGuEKiYrORHPbIugPksILq4v3Dc2cm1tu5Bcy6VT0Erw2rCgD3med1GT3iz1xEBcQHdY7iEFCJeHODaNJWoFkyGqOFoCrLulmi4YznF7BSwUV9LfElkvzVNIzy/F6//qGzY32Y3sNW+2J322zuFAMnP3IsjUiQJKsfz9UIcVYTvZt3rN7ikVoLInox6B1fxBdfexH193XCQoETsaO6oNOYDeLxYyjG8d1wILcBMNkFrH2K1HsmwIvOE+7+NRmr5CosT4jFR7TyhLjxmIVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REvQ/yEucPxvRhQd1PgcZC8KU9L2nD5peIpdfMlSdus=;
 b=c47U3owhP9Sw0eHdrcGViqB/kpG1NlVaJGR6amt68MdXDeuXHfWYHjixy87x0scN+lK4W05blNS511yKZ70ET+EeUZOiAhtmPSXBuvhjd51e22njLHt1XzrSEXAFODDRD1FaOqegavNk2Nn8V7zDvnjjWfK73JoUfIf2ZA5Cia6Jogu2f8TOB2jT3W0iuGmvIbp+JiXPan804aZ8DgXrTzeVgwRIfBe4gzq9cje+5SOhgGw7BS7gz606RppraiwKm3U8nhmIoDYvRGV0T3qjvf4hh1uyENMT8POYGn11ztnKzFpBtCSYaRsraKLuNvZzjnOit+BHVbxj/wgOVuM4tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REvQ/yEucPxvRhQd1PgcZC8KU9L2nD5peIpdfMlSdus=;
 b=DlRTNwpFA8mEja1k5KBpfT+/iFMNeipBSgtfeUr92aq52w4Lp+Dqz6CMPHZLa2KY4kyvsCR5B0wfRqIRdksMDyVbyvyWh4i7duTEQV3NIWi8ZNtTYZKPdIJZWeGGEzdrAaE3BXS6UbuMjNwLVH/LkaiTynJSJh6l6e/GUVHn5uc=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH8PR10MB6669.namprd10.prod.outlook.com (2603:10b6:510:221::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 03:26:03 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9678.023; Tue, 10 Mar 2026
 03:26:02 +0000
Date: Tue, 10 Mar 2026 12:25:52 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: vbabka@kernel.org
Cc: adilger.kernel@dilger.ca, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, hao.li@linux.dev,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, shicenci@gmail.com,
        cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev,
        viro@zeniv.linux.org.uk, surenb@google.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/slab: fix an incorrect check in obj_exts_alloc_size()
Message-ID: <aa-PQBn5d0-U-sKg@hyeyoo>
References: <aa5NmA25QsFDMhof@hyeyoo>
 <20260309072219.22653-1-harry.yoo@oracle.com>
 <0a25d83b-c6ea-4230-a89d-1f496b91764c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a25d83b-c6ea-4230-a89d-1f496b91764c@kernel.org>
X-ClientProxiedBy: SE2P216CA0195.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c5::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH8PR10MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: db9f8754-2132-42e5-7a9d-08de7e54c1b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	WBPwbW80A/RebGtxAjAZCJ0OW882Df3cymT2dmkZkSXRl0z02Uii7vCKUgnYFSznmTa/fpcGUwIfazNBLCA0R2MVqD5jCpErmz4MnBPm1C/rsZ3YhP/vbTH5PuhoTxLAWNiPr9JPUK38mSbEighmupJfBuApSYfPNqCJ6AAlih4KP7ocCnMp4NX0yXxcQztZCTxrdgRtnpZCsHNP8OlwptZFWJzmRZrc76QxvuOn/U0ZCqImRcdkxSDlCUupsLqtRmVdwuHlB732VtS6BwQE3Jn6PUqrWyCtTZNeR9WoJRy+roVXuYTeK6Zt3XJZBmBtYE4g1tGo3gGdJeg8ZPt6S2g2L9ne+Bsb2NRG+lQRR4H9E3C3tMRtMsdYKIflCbKER8xwLv4v8FkKLt/iagOT+0IqS8d8uElAgSO/wvofXa7rFYqMw0FOXBlzgkta/U3fqFIT5Hu9AIZFGqsmasddZB9HBg3MJ4gNEURG+xRO8gEseZjovBrCrFRjqj2tIMSWGtxfjUugIWVbLJ7ITkeXKWszsl87EPLWx7ISyvKJl/zD0wzyvtFRHuy5gNFZR3k3FysK1gSIPlh4Fl8itwekIoQidLlqxg7XBy/yXWsP4lmk74dwD1uG+hbztSXrqruz0YxokQ87U6BTQxhi0KJ/X9HoHy4+umBmDfAgWydAkJW5HTaidE40GzYtK9Efo++tFLp9InOvDtnpRMUAEFrFFbMbC0g/HXDpUOEVxfIrGW2/iTnqzPGEE7nPLkCZq/Q9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yafl44V/dwbKB3geOTgiUEhvPZBfLKWq65BlXwVnsm8AZk+ye/9n8+09aBt3?=
 =?us-ascii?Q?gM/ruqvdOvONe+mVr3HLLqa7jc7ymckSY6taw7r0uWoIL3yJgaAsGcQfJDq1?=
 =?us-ascii?Q?csd5jjdaQW7W4ENgy3DPAv3UyBbg6k1/SBmKtoQSQJU2PkjANbKRgPBTLvPw?=
 =?us-ascii?Q?PIbT2uYWAqsrmscx4fjEJTiZrLJ+7ogLDJfbvOq2Zf5/EvmBWUTY311NT4fG?=
 =?us-ascii?Q?hPnvQZBzEAycLY0ux55ZyfgJc1ZB499QS/6l/kYXFIFAdazg8AZioC47nlqB?=
 =?us-ascii?Q?x5mVcTMZgZUhN3TL2gTf4FdPxaBzUIJzSARQJj/1kEyFbE4qwKA72JiM2hNB?=
 =?us-ascii?Q?Fb5uklGavTIfinwq6p+buYYRLCFha3QXp+GYPT3JVxOj+9R/7g3yTgBi6Awz?=
 =?us-ascii?Q?qify1oke9+lRVUKNYvzFcvPT6eeqiTVViA5Zlw/avA8VU1NQmsk7toZpV0/3?=
 =?us-ascii?Q?jATTc4wnyq3acScog56Ntl+LW3KqBpFFfyWGOnHeVhetCRMOvtvMi8bycFzr?=
 =?us-ascii?Q?uLAqzeOA3pkbo7/1iPouyh6amqCUl7wGJA6+O+fhIl5P4tJ6d5tfKNREN/sK?=
 =?us-ascii?Q?8bUErqZuvDl6X4kkk/IQnV0Ap2+w7yMXL3RlE1tbFXgr4IeEEYLhPsvYxlz1?=
 =?us-ascii?Q?DlUHIzbfL+Ykrc+2Uj0xcWAx6BsY8PRfsiDyMgdIOAXdQnjVdwiSShSJfvYm?=
 =?us-ascii?Q?GcElO47diDrVHEQG5kNJZGeCeJe9lRTR4pMe026Er7klaNAXtNhYTpY9pZKY?=
 =?us-ascii?Q?mQjT4CEPhld+m5KW8fdUnPtIVE5/wTEBUlZPUksm55MeJwQe4C71BLYwtWPe?=
 =?us-ascii?Q?ss/3PCU26zAq3YCvC51PNhMbJ3Ir4QqXEGGh8E6PVdC1EWHZxVpW6GcLPZ3p?=
 =?us-ascii?Q?f/brHLBQH1w3oaChMQGhJ848aOzdflfHqkjX/bcPSk6EAbAKiaqGqyIO46jW?=
 =?us-ascii?Q?CxVuhXYdKQUMFvgOXw0lJpuJ5hIXIZA++l8C4grBri6XUYSqjM1vBLw00f97?=
 =?us-ascii?Q?NjVKFouvmshGaZD6bCccCnuOAk2nZ4E7TGCj43McUDKdfIdyIWbnq8GmSbHD?=
 =?us-ascii?Q?2NILO807ZnS0dCPqIuLsVouO0NmjYi6EZnbgLMkfeQ/pwv52VydKeaPh1CDa?=
 =?us-ascii?Q?uvKahfonvvEa1Yh0YdbOXe1z4kNd18VPbMfgOOgRKntrXzzYmLuqIZGvZR44?=
 =?us-ascii?Q?XsyjzFO2d/kVeM4OZA6PmL4+0jAAR4lrc88RWX/B2lFYc3K0mf2sRI+01zIF?=
 =?us-ascii?Q?OryKi9z47zixwPMO0Jzafu1elYYITIZ6WTCGH+tXAObbiJ1qtGUrb0iz5qc1?=
 =?us-ascii?Q?g6SPqRhIJjWl8Log3Z3seHQtQPHQxfObFCDPZx97iK33es9vD2sLtxqKvkTm?=
 =?us-ascii?Q?11pc1KU7i/x9+etF8/JNVr4fo6AnR4pHDCODV5KTxWC7YgwRbJtUcoEMXsET?=
 =?us-ascii?Q?T/PbhbliUWnDnWNHF+pA1DKwaWyiYxYn+GpUPdkS6BNyxt0g8jecqYcq2vwD?=
 =?us-ascii?Q?cRRmfyu5P7ykuBZWYN5r/rI0x3uQqKd4H74fvZ+PFDzaNLvw2dUzqGIUrXQn?=
 =?us-ascii?Q?TPIcCwFwjmlv3Xta5vhhZu3UnNv2FpnBqC9W1dy6b0UnJhMDoVnAjvYceGOb?=
 =?us-ascii?Q?4fiiwJRy6oIaxc4BR1mUbSA+Ft/jP47bdyY7U3CaF3PIY/aLY8YU9lemg9wr?=
 =?us-ascii?Q?F3qsFfWNNUPA/VQSmq9gmTshiSqmN/1wPng5CFCiIodxFu5MCYEeXHqG7Fxi?=
 =?us-ascii?Q?eaoiwBHq6g=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	bvaRArXUjtfiD+1yfEowJ1pP0J3J1HYEUFJiylTESSrXndG7amWQc/YsX4c54uIsdh0IgyzpiLOdUN1Wofo4KTgTx9C/Mi48MxORrrHcuUMnpC2rfJwuhHUwmF/op/+D8EkUXd1+ZQZle8pnzw9c692eN6SfUTn521wIaWAPL/yhor7fo5IM4ZVS8ZM/B72NTERwVJT1/4tE9zRATTrdt0NtQszgvhOldFUuRhD1yAWfieHCtwFRWuh1AhyETEG6lQ8mCEyWJrWYCQ6AvtdnS7cyJALshVMqinDnfYEpBsFQRjDgQm+Gj+a4w4CvX61vRKxiDC5PeAx6JlgfU43lvA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zxXoNmY0b5UbgDC5Sit87Mm/PXImx91fsc4gbx7FpJtoA4bjxSaY9070U4aYAZ5zBbSmXNq9r6JrDazElSbGo0x7b41xUL7y+uw0V9VtekQN5lFD/ogkg+TG7pG36lWD9DKFaxVTqRBUeD0gUSE1pGQJ0JoMG4EkkiOWq5Xyhd2kdlNPnV3E867hgkvQpOTUYAPIY3z+hPsInfF3nlNj62vnluWFYN868l0m+uXPazARmZkEuw2VLim2KLOxVOIpymBmagAE6KA+GcnsZM6sc+jRu3HDvKIByxJ3VAuNlDTS4xE1m94Hf3RD+HV9NZxr3fm35m227JSLQl9bE3eoVD+4Ktd2F0o5a5UK3lB5IUlEXdn/3sa/x+9vaV+wmQdw/ZWd7DtwbSjc2iSmZSU2QhFhy+5+d6RaHCKUmUM1IejYcJSTxtdZAAkBUOZXIu3MyXuxF/s28Ur4ipsrl+VOHI+Q/eUZ42D3UiXlb3lpXlDPd4mRSj0EHU4CYhYLJqm23VoLp84a2ybqrg/y3pcFNZ9EZ23gonVqjPs2po10RBuLrncgTOoFJw/vNvQXjJJTON23yhmTlSqtxo3fIf6A4kEoLO+tOycVQlLJfXbRZb4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9f8754-2132-42e5-7a9d-08de7e54c1b3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 03:26:02.7373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mq+Hskc6U10RL5IzIAfP7PmK13EL5y/4zRgxGYPKQ7LcfVqRSZNLfs0ytm9d6MrjlEMontu15YjoFgJCB9xUuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603100025
X-Proofpoint-ORIG-GUID: V6JY22Y2tIIFOZBPeIvwswWtZ-AgWmnM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDAyNSBTYWx0ZWRfX6M6IZEN1VQ9m
 mk28EG+BZOpZLRalJPqoUoOWXKOcQdqTu/g2SZ8EYfBdZbwHqXhfJB0BFRpf+ac5AtsrMmJHpro
 V14EKoTibMPvaS/zHAcohZjgNl4EWZzXh40yae6m3CQWDqpe+O6wTpxbG4IG5UaY+X2hymCJVl1
 Y2FHpolcY6O2dFZcimRclzCQ+N71jyOxlSRp2PAq8GdQKv36s4T4QMQMRfgnuyjHxaoeJCbnQ54
 QqAlTBDTAMT6O803sRVSMUVc56Arqi2FXnrR+uXzygYEoSbk6GrDHXCY6aSSuP/HSJxz/c3m63F
 pEINw/5QjvJlf2x3Q7ohCwMjAfeXAnM7KIKDiccKsJDlQbwCmU8hvoBSY/in8x3WTThDuibB3Xd
 sibQ3+SGsclrNIfnLjfWVhaqdrE1oxkKYveolTYff21yLFobUQhS6Aacg7Ri0At5hDoI7XytmPS
 w4YUxW8EUwOT8WYZI4g==
X-Authority-Analysis: v=2.4 cv=S4vUAYsP c=1 sm=1 tr=0 ts=69af8f50 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=l4GsR6Set8qm28su0esA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: V6JY22Y2tIIFOZBPeIvwswWtZ-AgWmnM
X-Rspamd-Queue-Id: 0D0F8244D0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[dilger.ca,linux-foundation.org,vger.kernel.org,cmpxchg.org,linux.dev,kvack.org,gmail.com,gentwo.org,google.com,zeniv.linux.org.uk];
	TAGGED_FROM(0.00)[bounces-14726-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.onmicrosoft.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 03:00:17PM +0100, vbabka@kernel.org wrote:
> On 3/9/26 08:22, Harry Yoo wrote:
> > obj_exts_alloc_size() prevents recursive allocation of slabobj_ext
> > array from the same cache, to avoid creating slabs that are never freed.
> > 
> > There is one mistake that returns the original size when memory
> > allocation profiling is disabled. The assumption was that
> > memcg-triggered slabobj_ext allocation is always served from
> > KMALLOC_CGROUP type. But this is wrong [1]: when the caller specifies
> > both __GFP_RECLAIMABLE and __GFP_ACCOUNT with SLUB_TINY enabled, the
> > allocation is served from normal kmalloc. This is because kmalloc_type()
> > prioritizes __GFP_RECLAIMABLE over __GFP_ACCOUNT, and SLUB_TINY aliases
> > KMALLOC_RECLAIM with KMALLOC_NORMAL.
> 
> Hm that's suboptimal (leads to sparsely used obj_exts in normal kmalloc
> slabs) and maybe separately from this hotfix we could make sure that with
> SLUB_TINY, __GFP_ACCOUNT is preferred going forward?

To be honest, I don't a have strong opinion on that.

Is grouping by mobility (for anti-fragmentation less) important on
SLUB_TINY systems?

> > As a result, the recursion guard is bypassed and the problematic slabs
> > can be created. Fix this by removing the mem_alloc_profiling_enabled()
> > check entirely. The remaining is_kmalloc_normal() check is still
> > sufficient to detect whether the cache is of KMALLOC_NORMAL type and
> > avoid bumping the size if it's not.
> > 
> > Without SLUB_TINY, no functional change intended.
> > With SLUB_TINY, allocations with __GFP_ACCOUNT|__GFP_RECLAIMABLE
> > now allocate a larger array if the sizes equal.
> > 
> > Reported-by: Zw Tang <shicenci@gmail.com>
> > Fixes: 280ea9c3154b ("mm/slab: avoid allocating slabobj_ext array from its own slab")
> > Closes: https://lore.kernel.org/linux-mm/CAPHJ_VKuMKSke8b11AZQw1PTSFN4n2C0gFxC6xGOG0ZLHgPmnA@mail.gmail.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> 
> Added to slab/for-next-fixes, thanks!

Thanks!

-- 
Cheers,
Harry / Hyeonggon

