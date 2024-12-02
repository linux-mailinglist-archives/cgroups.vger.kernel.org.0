Return-Path: <cgroups+bounces-5726-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BFF9DFDF3
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 11:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AC1DB21848
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 10:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21211FC0F8;
	Mon,  2 Dec 2024 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oikJbdar";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VlaI/xCf"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74AB1F949;
	Mon,  2 Dec 2024 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133592; cv=fail; b=XH45Lu4zbx/suMwAGPDvXbgmzCqBkLwJkWXcIGcx5gSYYheGVl65CycqT7k4qi4/KEb17qlUD5hH+NE5ToLON1n1xbnr5DWObokG6TChvB4Zt6s2NUIvpwRyaaE5mqHQEya/1PJyzEGuKCd8OYlfbr85H1oKq/ugkPe4g8otkxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133592; c=relaxed/simple;
	bh=5JoRbla2bp5Qno92u/seV3kNOPx3VgM2RohSLCJUBfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dzEXYZ3xzFjlzEb5xR3n5ExkrXyRPa0GKmus2Ji3FEO/u4gVvIkDNgc2CFw+mbx/Qi/4OdnyVd+DyK3DZU6tZez29gHvU9CTP7X8NuDGnjXBUyPHEvNbcNrcwxJvCJu5pteBtjZ7vtuveHmOu3KR+wnaUZVZq5KyPpPLL1I8K1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oikJbdar; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VlaI/xCf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26WvTu023915;
	Mon, 2 Dec 2024 09:59:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=I+w2hwxa/YUTZZUnekajsBhLkqgjc8gxVVx749WCQws=; b=
	oikJbdarpCVPGTsV3u5q7zAS6VRB6LvUTlls7DFMJ0ZqPoGOwU8DZGd3hkn18qfq
	QkAMElTS0qWTf+J8uGPjO+xeSdy4NBFazXFrGpHZN16PyFmp7nEqYCCTs1uf9XgI
	egbazRCFIxNuqdAw3agxeFXa7LLlEv2ZDcMYn0JCdBDm/1lZq63NZowlBwA8nuk3
	BaFQyVSF/tq8lTD0ldYVru7lhO9RHMY5x1gKXPQl5fmGG+2fRlOq062VRJI2jkwX
	c25iJUvj0ScribmQAY6uvv/aoi1QCgKC9fbw0HSOatP9g2geDp/PPUtyNUH+iPoE
	TbPaFS9Fpev4Lw+SXZRdCQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437trbjhyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 09:59:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B27rbtY031481;
	Mon, 2 Dec 2024 09:59:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836s9xke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 09:59:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L30dh2RPRfN1fxfOYIJLQYvuNCAvNB2Mtw6rneIOhsgCoEyFdMGByuKgTL7S9XHh2LDsEpRP94MW9NhGwj9fmLatKnnZtE7smj5zJKa6CKCNa0tcpmIvitmY9wdCanFq5+u0N2qcG/ZjqoSjKT1MIcxU3vIvV6gJSF/D2PaiocxCNn9wUHJFxxqpnWTxyzs+PpmE0KN91piPtndDyN1/TJBF0kP5m9Y5kJIEGvykRhcDs5JlElRrpXTChGijw/9u0RYIvL9GCfm2Bg0bJ3odVNsmRNeU9pJ+gpgvK39BFkb2Lrs9gfc3IQ4hFxI7XgPCix8w2UbfklOI7UektuX8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+w2hwxa/YUTZZUnekajsBhLkqgjc8gxVVx749WCQws=;
 b=YYjVTmgKizIayxUrKD4HQD+YBPXiEcwKR1JCS38EhW419PxfzfIwNWKe0kljOENDEW4ZxDYUlBYGC8f3lhKnoQcRzAD9F4NWoavVLPYMBVlQXQx3QM1J2ux/W0hUxNrBp3kzKI0T/8SfSl3U/O7ceRdE5HuSN6K+G0pUau0izzzfNxL9V8daNp86Y31mx6MUCB+GEIxzPGzzmEY21MZJAeMMx+fmB/1nIYZZf3awTQakaM0jp66flpBUzWDyL2crTOmjAvvN/3WGbfPVBG0Oj5H/kx3zA0RuwTrs3uzFldq2LaH64JwiEyR7nYm04X3nGps7EDMQwB1wykzW7sJmlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+w2hwxa/YUTZZUnekajsBhLkqgjc8gxVVx749WCQws=;
 b=VlaI/xCfaSxGJlOnr6ESja4r5Uubc3fx9t2qm90HPJGYFfPStqnq75n7bCSh+TMR59kfvORg8qhIGlpnZ8HMLEbYyXFqWPjML3hQM2Vhsr+goJPJV3LQOyYF5SAC/hW8IywMWn3lr71npl4M3+JG4rNPchgHX7+3HynpknYrN18=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by CH2PR10MB4277.namprd10.prod.outlook.com (2603:10b6:610:7b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Mon, 2 Dec
 2024 09:59:42 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 09:59:41 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 1/2] cgroup: Make operations on the cgroup root_list RCU safe
Date: Mon,  2 Dec 2024 15:29:25 +0530
Message-ID: <20241202095926.89111-1-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024120252-abdominal-reimburse-d670@gregkh>
References: <2024120252-abdominal-reimburse-d670@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::19) To PH0PR10MB5563.namprd10.prod.outlook.com
 (2603:10b6:510:f2::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5563:EE_|CH2PR10MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: 6024cb50-65d5-4d9e-1f49-08dd12b80a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TVbYN9PTfOYcqquzQofFWvmxIngBdhmsoYP5pj+t5U1vqVelxOQ1aDR6s/kq?=
 =?us-ascii?Q?xd/6nunlIXn2LypR/prJG++DGHhFUeKpfVIjwdXtKf3ppbnXf3A+ZF5l9gVF?=
 =?us-ascii?Q?Meym1K3v9L7KUxcLnqxWTMXHwFa+TaDAiqe6PeRdhejW4oeqhIsLIN5gQlxT?=
 =?us-ascii?Q?Xml1q84pPz8mqNl7NplXAKuRLt5KeBHFtYmNTxSsJXyAhVjrjB1Nk2rzCZiO?=
 =?us-ascii?Q?Tt6RTZT96w5cPWqq624xZjB9i50VPuhgoi7934P/SxXnnUhXeSBLoEYCsvLQ?=
 =?us-ascii?Q?LV4YUQzNsOMgFXwFfC8h8MDaRmHzVNMqmRNFtAhLsX3a4KUMI2My4GClayzJ?=
 =?us-ascii?Q?OoySl+ucAy02FWT+dFtyhnE0mQRKkyzM2tVka9O4APoSt2WioN794oniXLvu?=
 =?us-ascii?Q?eX3jS7L0su6qCVa7OjU1sUKAv9eC2ClvNrmhCAY0/BSCwtaqezR6U5K/Fipv?=
 =?us-ascii?Q?fXI9n5/VeHrTkT4WNOsY6E7UjuPw9zmCuPtDicg2V2mXmSolK24GIKNU3lFg?=
 =?us-ascii?Q?srldNF0gVBvUEUyUwghkqPNUnW/OI9AvA78FTM8mNO5Db1uvKi+zOdLmrc8W?=
 =?us-ascii?Q?fT5fF862d/b4+aFLy+X8X6Ah1ZmtJ6NaHa046hUFwYwd/QtSAVe8LIIUZ3/8?=
 =?us-ascii?Q?M4CqJY6ZhwyKIvnoQuL6R/687xuXxvaoJpt8namTlG9wJLo3ybWfie4SpNVo?=
 =?us-ascii?Q?FmkTt/qGXgysp2CWVVkyFnwCO8mTQG5ZvdOc/re5BnphWAMPAWKbKMjvt+Dn?=
 =?us-ascii?Q?z5W7/46xSyjReA9+rnwFgWCXvjDcK/ZxySu6N/3CQ2yWdz1nkVN0jiXB7B6m?=
 =?us-ascii?Q?UWBc3hC8hY3F+kLWR+Mmxqop+B5Txf5kNvU1h+dtBfhpmg/Eod2IFoHZ1Pwx?=
 =?us-ascii?Q?cwaKcYlCLl/XribHZ+/US099CKQPQW2MvQ88XVkAos3TZD9B0D77yIiWkVLV?=
 =?us-ascii?Q?WJ+ehXMUdsGuIrURgDGVsTC1Ef/yVGB0Nb85FBEL9kByV+sOLJ0muY0Xq/YX?=
 =?us-ascii?Q?Jnkb28DEtN7j2VJWq33gcZos7KlXNt6hzfoiMtEadHTGEOiA5hQ55TZzziaP?=
 =?us-ascii?Q?p9x+UuIwHfeDywIeL5nvm5dMtdB1XPCDl7HWTnZc005E6BLHIY3a+Op/oKvu?=
 =?us-ascii?Q?cFlxlwdvGJrLTuD3MKsQ1rgQO3MT1vMEsBpWXzN/kzK3w3vhpgfr6ZBRuker?=
 =?us-ascii?Q?mDbb0hOKw9WtPUtXtAvisnHfVpnSowqSZF2Vhjo8lrdX2+JJPZr+SCqYNmeJ?=
 =?us-ascii?Q?TG86B2HziMrBkkmVfQcEsjW8vtnKbvuTDBeI2v40Ub9NXE5fekViu1ZEsq6f?=
 =?us-ascii?Q?gX2uPU7TUcffpvSE5hsALa19zYWVqRXarVULNw46ym2iDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kegVrkkaJ87YPCb5SKFczurz7biR7R+kdny+dCGKNdONhv/8sJA+l2SgiTsv?=
 =?us-ascii?Q?kIMCGCrZKz8viHCNi4Z6OoNi9JPeyD6I0Y0tgfpMjRTncU14+vCsOPJwG3k2?=
 =?us-ascii?Q?ct4iKOoR6VBia2ISbi44F5yNEKjxjyh1uXDOcMJOBbK6/R2LS67+L4xL5tIj?=
 =?us-ascii?Q?dk5VviMRJga2YifHLAc4KJSrXs2fTH9lkkYfiv69/BWLdyFbIL9W69lohP2Q?=
 =?us-ascii?Q?BlCEeZgZVPnimXkb3cg5o7sq+ebrYnRzo/I8Mai/8WfOXQ8IupzRPoP7/FMT?=
 =?us-ascii?Q?F8Oga48oc1rJsIqjjEDhXGtG833wB9T0e9e1OuHB/2h2XhORJnRzC+CNa+ng?=
 =?us-ascii?Q?uSzdWdVYXui00f7Sji5kJnJPlj0mRdxqQFislNIoiKVv/0rb5YpNdRhRljzv?=
 =?us-ascii?Q?uNeWQRGn8A0HdsrHZJc829pwGLnODvAroHldek7E/4cYIo3/b0rEQPBQbcDn?=
 =?us-ascii?Q?1sgtW9f2rEcfxQHW3551apwaym+dtt0C6QGtBJHlWEwIeuD8rieIpgMsc7sB?=
 =?us-ascii?Q?wkfGDBvTlVK3JO5v9Z4IVJWDIAR57QMfUagrl7nPbJIViLSq7ZLYTDirMT9J?=
 =?us-ascii?Q?t4z8fIJq3wwNWh3T8DXCFYNPjWVNlgGmDmg42sZom6vvoTRCqlmDo986HJFs?=
 =?us-ascii?Q?pw7VOk4bZYB2KOru67UoctoIH2Ru234JH0okBWp4oQzZQGWXFriOwaag844L?=
 =?us-ascii?Q?CToJQdaWsizLwfSyl92dD2SyVErsbULHgFBzujeCUMn3FibtaJnaC2hpl79Q?=
 =?us-ascii?Q?E7BCUGK1xwYAX1TREn+1/GBevDD9UU8bYMsQH42VxDTCM6TOq07UXrGW4y7p?=
 =?us-ascii?Q?5henYaLVjkP77AupZU3Ef3LyyIWjLRUjG0NM9+mnf7xwfebe2o8nFd0vhbzG?=
 =?us-ascii?Q?z6zm9EOJH472/VFZZ694vXJrqBtXLeZ63p3hwzLcfmOz1IZCkYL25cAiVuLu?=
 =?us-ascii?Q?WeztgsxRP0694kHEQkM25HvSbyg4z2f3oLbjHG1h37U27BUw9LK9jW9x9s1H?=
 =?us-ascii?Q?eTO4ajsJT7eZbsWf/RiWdsR/yxeh/7f+eRw7c5i3pvdk6xErfzbUWyBfWmP0?=
 =?us-ascii?Q?Fdnt5dq0xLwKxwofTOcRJt3MEEJbw+jOf+HufKhGc0EO872On7BgYpqvjpa3?=
 =?us-ascii?Q?d88Iyw0veNx2NbM3qk5cqlYx5i0jper9pQziJdUnFSXhesEFJMCTCd5nETDa?=
 =?us-ascii?Q?M54Px7ASx00Ra4y/RLHdR7jd8h7ULquDKqjdsDhYMX0d/LnXfIH1CFGZLMgl?=
 =?us-ascii?Q?ifPepqliKoWu4Hxd19iO8JRkIv8DfO4gNZG/c7HA7OmMduK6wsWBh6MKZ9dU?=
 =?us-ascii?Q?s7bAhsJW0S5F6fqeDFsEsCdd5Hu3uii+FOJ2pJ16RqJKhF3u+m6vcgi73BtQ?=
 =?us-ascii?Q?z6RuQDT+WvockSL98/nUDQhsckHbAnGO82nCn6apxfKWzafQTpvN3It7yXSa?=
 =?us-ascii?Q?VhTiR/OP16Xq7md+Eql1V7KKlfOc/GfrXrMm6ebVXr6jA9E3zS0V1GTdToTs?=
 =?us-ascii?Q?yjDdxP7KStPCybm2lIgH8AOVt8u57XuiSWjhvRhWZFrM4tRfxcGzamReijJI?=
 =?us-ascii?Q?GsPAgt1y8c7G2zk0S/pl0e1b1MwlU0kUinl3LhwCCpduSDnpb3fZGOCAVSCI?=
 =?us-ascii?Q?JKeFXb5wSYybuhS4+VrnTqJ1Gf9BfYBONliGafeJ6cswkPfjzHCurhWHn+Ph?=
 =?us-ascii?Q?7iK+Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S1U/aPJbgBzrnpvF5+K75vQbasFZ+DQmL9MEZFUTm9pO8I3XJ4GDnU0JxEJe4MaCyqdosF7NmHSOzUTEHNzAbIEMcl4cTSwFSPEekdAhsdaOzLAWc82e9k3Fv/A1+8Sx9BZQdQ5Bf2dY/eBrhwlwVj3JYDrS4pbTLZaEd1p+OSxGdaJHfkLCvqbfzj1Bf6vVRj2Qg5LAUQ7c5KM/bJuj42KeAVRf+8nhIZmWA1ch++hcBPF+1UJAcYCA6HQcgJ3eYkq95q9xWnLI4s2kOXhVY9n5G04HesJQVF1E24ZTWzcfFQfP4ienY3ydkk6vouaFeCes6PJ/ispQg6mhp7SsuTVbJ/YpBApCtyLAUEAPU9tbjE+jfvy10JpHV1cz3EdSpxvulXOMolAAXwaM/phSixAhivPX6bxqs/isvTsJnnPUQlPtxgU3P/FIMZsdSflxN3R1nIR3bo0mNCCX1D5Tktf+A7Yh9WG88UyBKUizNRYwb6Q2J5U3dRUEIC4bdLzfw3LW0qKqKLM2dG1KfzqUo3mm1lNNVJtGXfLZWyKSH8t6JGQfFSFyIffdt7xAXL4X1bhQfe+SYp6mVVNhFTZy7yNh4/qjKw/uyQaWpYws5o4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6024cb50-65d5-4d9e-1f49-08dd12b80a65
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 09:59:41.7862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sl912FAU0GYJlvKu6VFZq/FqMhxusApJBNMXgsIv7oxF3dPIP/4I4VvmNXROPGSaPhDW7IltzqBkYew/FnbbCcbWmrTyO3IVnmQ6OmWq/MY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_06,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412020088
X-Proofpoint-GUID: xcAsmkMEs3rZn3JYoEaAJuKtjm35Aym5
X-Proofpoint-ORIG-GUID: xcAsmkMEs3rZn3JYoEaAJuKtjm35Aym5

From: Yafang Shao <laoar.shao@gmail.com>

commit d23b5c577715892c87533b13923306acc6243f93 upstream.

At present, when we perform operations on the cgroup root_list, we must
hold the cgroup_mutex, which is a relatively heavyweight lock. In reality,
we can make operations on this list RCU-safe, eliminating the need to hold
the cgroup_mutex during traversal. Modifications to the list only occur in
the cgroup root setup and destroy paths, which should be infrequent in a
production environment. In contrast, traversal may occur frequently.
Therefore, making it RCU-safe would be beneficial.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[fp: adapt to 5.10 mainly because of changes made by e210a89f5b07
 ("cgroup.c: add helper __cset_cgroup_from_root to cleanup duplicated
 codes")]
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
[Shivani: Modified to apply on v5.4.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
Reviewed-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 include/linux/cgroup-defs.h     |  1 +
 kernel/cgroup/cgroup-internal.h |  3 ++-
 kernel/cgroup/cgroup.c          | 23 ++++++++++++++++-------
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index d15884957e7f..c64f11674850 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -517,6 +517,7 @@ struct cgroup_root {
 
 	/* A list running through the active hierarchies */
 	struct list_head root_list;
+	struct rcu_head rcu;
 
 	/* Hierarchy-specific flags */
 	unsigned int flags;
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 803989eae99e..bb85acc1114e 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -172,7 +172,8 @@ extern struct list_head cgroup_roots;
 
 /* iterate across the hierarchies */
 #define for_each_root(root)						\
-	list_for_each_entry((root), &cgroup_roots, root_list)
+	list_for_each_entry_rcu((root), &cgroup_roots, root_list,	\
+				lockdep_is_held(&cgroup_mutex))
 
 /**
  * for_each_subsys - iterate all enabled cgroup subsystems
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 79e57b6df731..273a8a42cb72 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1314,7 +1314,7 @@ void cgroup_free_root(struct cgroup_root *root)
 {
 	if (root) {
 		idr_destroy(&root->cgroup_idr);
-		kfree(root);
+		kfree_rcu(root, rcu);
 	}
 }
 
@@ -1348,7 +1348,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 	spin_unlock_irq(&css_set_lock);
 
 	if (!list_empty(&root->root_list)) {
-		list_del(&root->root_list);
+		list_del_rcu(&root->root_list);
 		cgroup_root_count--;
 	}
 
@@ -1401,7 +1401,6 @@ static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 {
 	struct cgroup *res = NULL;
 
-	lockdep_assert_held(&cgroup_mutex);
 	lockdep_assert_held(&css_set_lock);
 
 	if (cset == &init_css_set) {
@@ -1421,13 +1420,23 @@ static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 		}
 	}
 
-	BUG_ON(!res);
+	/*
+	 * If cgroup_mutex is not held, the cgrp_cset_link will be freed
+	 * before we remove the cgroup root from the root_list. Consequently,
+	 * when accessing a cgroup root, the cset_link may have already been
+	 * freed, resulting in a NULL res_cgroup. However, by holding the
+	 * cgroup_mutex, we ensure that res_cgroup can't be NULL.
+	 * If we don't hold cgroup_mutex in the caller, we must do the NULL
+	 * check.
+	 */
 	return res;
 }
 
 /*
  * Return the cgroup for "task" from the given hierarchy. Must be
- * called with cgroup_mutex and css_set_lock held.
+ * called with css_set_lock held to prevent task's groups from being modified.
+ * Must be called with either cgroup_mutex or rcu read lock to prevent the
+ * cgroup root from being destroyed.
  */
 struct cgroup *task_cgroup_from_root(struct task_struct *task,
 				     struct cgroup_root *root)
@@ -2012,7 +2021,7 @@ void init_cgroup_root(struct cgroup_fs_context *ctx)
 	struct cgroup_root *root = ctx->root;
 	struct cgroup *cgrp = &root->cgrp;
 
-	INIT_LIST_HEAD(&root->root_list);
+	INIT_LIST_HEAD_RCU(&root->root_list);
 	atomic_set(&root->nr_cgrps, 1);
 	cgrp->root = root;
 	init_cgroup_housekeeping(cgrp);
@@ -2094,7 +2103,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	 * care of subsystems' refcounts, which are explicitly dropped in
 	 * the failure exit path.
 	 */
-	list_add(&root->root_list, &cgroup_roots);
+	list_add_rcu(&root->root_list, &cgroup_roots);
 	cgroup_root_count++;
 
 	/*
-- 
2.45.2


