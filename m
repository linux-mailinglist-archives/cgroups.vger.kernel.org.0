Return-Path: <cgroups+bounces-12086-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67746C6DC8E
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 10:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF87F4F5AED
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 09:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A349533E364;
	Wed, 19 Nov 2025 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FAVM8b1c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q/aPJ1Hg"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DECD33C1A6;
	Wed, 19 Nov 2025 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544495; cv=fail; b=K24GkWzTNtSy1uJnrfSHgIKme8mAFdWABzYuRV8DqVvCPSoJkPBr7qSOaT4p28BCDJ0kEOkxxwBltXuDMpRWz8iO+zuUga6dihAk2yg8a+cnlJPrOCI8CfAhHtMlbXm4Yp9qrx27WLWHvpYT8T1dX9oh9knE9l3KzTHMxwUc8PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544495; c=relaxed/simple;
	bh=qWx3Jj+Wyk4m0qzjYJzlmTToNs+yJDyLDfuAT/N6O5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mT8Wqsmtx0SnL/+5uzArTt1cb3wpdPxCoslO5TJSxk+77bCweXS+5igqKg5L5YfenJ2h5LIZw4be3pMe5y1dMa1/jGul8roR9Ti5vMZmEASVEI/TgIFmW0Aq1C4C8at8kx2lGvRMBse0llpmWTXoNIC1kscdjCLLTYztAi8Vzoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FAVM8b1c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q/aPJ1Hg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ8uIOp031378;
	Wed, 19 Nov 2025 09:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=uxTLpnDEoCxpgTIQv7
	HYPeXKCbYhI0qBdJq/eLfYg/A=; b=FAVM8b1c43kopzx8fvg2qfOGwtRx5VZG9h
	ow4CX3l6q4HjaORYgTj8NXPger64sw8ME4eGCZGx4t3UkbdhK68J+n7aY5hpt4oB
	4vOsp+Jv39GHe0tV9cY1Jze6dGKVcRnmXhC57mMONrYppxoEzdie7p/U6TrpZFM2
	w/Kb5nNq4hyFgIHfEyncALfaA1IRKwFnFHfvEYpNiRjKUPjHn8ReJlnFqQQRhw2m
	UaKoujq3p+H5dwh09AsFq9PYeb+XhWXy+eJcAYQkBqI6YLBtNQTtJYNqUnuZc2PP
	SSqLUw3PriHogF+j4JgkBXKJXdy8FBaVC65e/VnsQ4VHBlhuZ8PQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbpxm7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 09:26:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ99tY0039893;
	Wed, 19 Nov 2025 09:26:37 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefymn52x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 09:26:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b294P8o/P3arbxvZ9AclRCyU9a4qI6784NjEbnb3XYwta52VMbFwc5RtOu3XhqGQZ0mOE4TtG1QwUuMwB+IS4xtoMDuiSPor9yqTOWBP/psj3E0zJ6iVPcq+oDLjeutq+01g98HTOFHk/nwvqIRm8HQBjeKgRjcurs+NtsGqU3YhaiT101cLaich2lqNbKtz/+oInrURYEhH3M1qVsMY4jPJHYgp4lXrNCUQENEiY+rQvzmvcoWnKYmzb24OXxJcGO/KHhOgstW4YdF/zRBq8FAPredl4J4uSaqNI8EXHmL6AfP6+M1N0FdtDAd68FyDZMvlh7mhLjNAd9f2WH4UBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxTLpnDEoCxpgTIQv7HYPeXKCbYhI0qBdJq/eLfYg/A=;
 b=LmiEZhFFiuFnfBrOygZi8C3St9ke/0Fs5gViR5vC62YFyjjqJtmYkPQSmiifsOmIE8ESkTCPwPh3IFURUcLGZsOg9iP1QvoCEf/M4wiqwIWa39hnJMqd6Suc0BwZw5fCYO2EGybdl610cI9h4fvCdCYAenXyA/MEAJ30A3M0S7f4JHkeSEF/YuBWM3luz8GCHU9xTVIOfbVEO72UEnQiHj4sxx1yNVr9xRowI1NTN7wivvfeL58ZlJNJAI+2Mds2hGc/s659ueh/gfNd7FMqGk6COWsbgXs19/sWxEanL28QXNYDrS156mn+BxgnLi/8Zdqi3amFTQIEbMOiUMhy+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxTLpnDEoCxpgTIQv7HYPeXKCbYhI0qBdJq/eLfYg/A=;
 b=q/aPJ1HgULi6Fxr18hM8tQMuxJ/RpVq9r6mARnCiQ5+snCArVi+J/7MQvan8qVKqnQzvgH0mYvsxHB0qyVhZBjtBJnRckrGpfKzxiE8UGDM0xtG1uGzWWCfP0QA4jYTk392O8kJyuLABraRNrut/et03Ue2olJPhIxXj5rjPeKg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH0PR10MB5179.namprd10.prod.outlook.com (2603:10b6:610:c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 09:26:35 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 09:26:35 +0000
Date: Wed, 19 Nov 2025 18:26:26 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
        ziy@nvidia.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
        axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v1 11/26] mm: page_io: prevent memory cgroup release in
 page_io module
Message-ID: <aR2NQl-w2O4PgvHr@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <3076467321061767e16ca7abbaa33998bfee97cc.1761658310.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3076467321061767e16ca7abbaa33998bfee97cc.1761658310.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SEWP216CA0021.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH0PR10MB5179:EE_
X-MS-Office365-Filtering-Correlation-Id: 918d32f5-8d00-426e-7c0d-08de274dbb7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vOdnybRWDbhnHznno3BaBSGbTzlpgvISwEDYhvlukwVBso+ka/MvFGX6NRBw?=
 =?us-ascii?Q?VeMDjIqLgNahRYeQW+RvdH+YENn9A8+0wITyG+LAdzdBYldXrCIPPl5DwKam?=
 =?us-ascii?Q?Y/eQm2zQ6Vx2kw148NgZAPrkGlSWP9CA95Up5vyfH0GnPEDmIphDh+Wmr4v9?=
 =?us-ascii?Q?wfEyNJb+GMZl2iEC8UDYHS8Z4YhTtxOEx7Hlxf1cHz5P8mZYc8pxcspbfPi5?=
 =?us-ascii?Q?pmgp+v9IIkyNNk2yWR7DAJ3kcF/uBIx5lLY1jNv1pVdr+B2IdX5zitJK9oZa?=
 =?us-ascii?Q?GD5FXMBuU1X/jmqkbx/DdDOFaRuaXc2cRVDkQ+I1o+nT2hXR04wJJljDSBTk?=
 =?us-ascii?Q?emHNy0vjOatw7u/t+bA8btQZLymnV/qDoSFwA/bfxXkAJDnewZ5HiTWpylgI?=
 =?us-ascii?Q?a2pFKAji12wjEpPaK0NjUgWxLVoYO7Xx/oj+r4erWll1qcrjzHUBbL4p8KbD?=
 =?us-ascii?Q?kCWGDo/pJuEmOGmGQ0YeuRwBXrjLlxBU6H0Dx4/XayRpYqFy+Zbf9AsYxIIZ?=
 =?us-ascii?Q?q4q1lt2hO/AcrBwlALZ0QNZoLKjgCPcEuajNDU8qFVnDSVbVR2tx5OuANSlH?=
 =?us-ascii?Q?0RTUtvUpooXuaxOPYVA64ROaRPSbglyug7uT68KOAO2MVDKyYEiXoYNIXFOy?=
 =?us-ascii?Q?i87RNadYio5PIonf0xm6ol6zXB4wABWrAId32Uc3Xy4q2XPsXlutDW/V9Qcm?=
 =?us-ascii?Q?p4VFo9WMl3xfN8U6z6uDiRu1whpuHwWkvMBHEkA+Oa6zLLWww3Fdd65rBIJN?=
 =?us-ascii?Q?OiqzUfyH9glRaZno9ALoZLjKWlj/CQObCux3qaQVVio8Dd4jBUXMtyRzobec?=
 =?us-ascii?Q?wZ0aD1BIpUobmQDeeFKqVBnEd9Mn6dWr/SSa+Wt8m6P2WyDbXbI5APPvW+gA?=
 =?us-ascii?Q?4yw3HHw/cUCOCLEstj0UvVFGII8vAWqmE6S4NOTS02Y9Y16Ur4Jl0sJlspH/?=
 =?us-ascii?Q?hAiEAThwxv1Cu1e4OBNO90vvCER4eWORlP2EZnOqyXT0oM0wX0K9vpgO6t/t?=
 =?us-ascii?Q?H/nY+ogbMMHP+sRjVgLB5TydoshJfDmENLRoYgOEFOMXvelj/qB4bmu9uzoF?=
 =?us-ascii?Q?0H5S07qCCAM0T2Bj++JfpYxubRSxzV6N+hnR25Dq0rCLFQByEqL7n/9MuxeJ?=
 =?us-ascii?Q?tUrMaPFTz/kr+EDsX8NXT13biCKcofyIyY0q1VQPLDSWQ3yS1dpfGe40VtSE?=
 =?us-ascii?Q?3NEf8bV+6v7jELSKizj3VHabbNypqP+RpOF7v52tKoJOouXDlm8kB/gTOj9a?=
 =?us-ascii?Q?6/l4v/9YAu+RRB1T1zaO5rw850OPFHumHuP60Me+H1TZFs9vOfAGbgrWFuep?=
 =?us-ascii?Q?XO8A+jZkq1/VzI0cVZlIwQlO6J8U960Evo1iMUb99bElT+CKxcfATkl4/ivd?=
 =?us-ascii?Q?uv9tBDGsrLhv8VyusJW+yPwmvRRgHBXnqJ3eNVtEws9jVYaMf7FFYPC3V8Ls?=
 =?us-ascii?Q?9NTjVEB/fLs+ekjCsTCuHix0l60su6rN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dxv9Gc0ST8HlDp7RfOdF1rywvrdyjcDHzK9ulfXR0J3h/61pdyNyIC+w6lnt?=
 =?us-ascii?Q?2SkeOZdKwYC7SvA60SO9WBcsWoIDmmQ4N9m8v6fk29NaqgvkJ1zwG+G+Z4bb?=
 =?us-ascii?Q?ofcasjHTZkYhc+cvSZxxBFn6DBDIhFZrqJy4x8lJV7nZCQSwhl0enPb1rsRV?=
 =?us-ascii?Q?pNxtA5SLQVnkslMcqs6aKk3qY31PiAiHc/R6xrBLYUtCG6j0j84UXBz3uQdc?=
 =?us-ascii?Q?ot+FK8KaBG00IgxlQKKMs2Fh9cXebRldvP0MqNF7UMGzUkgNiPl4nJixag55?=
 =?us-ascii?Q?fyI7MxJ7E9EJClbIDLZ0eFLIZWIRQHR1PGVG+D9yJ8Vjmjm0OlWAJDx69pwU?=
 =?us-ascii?Q?TH4K3s21yq0ApPOLLFJxgCWU8ZCq7/7ZpD4OykrumRRYa+c7dpybiDC06myA?=
 =?us-ascii?Q?ljrUzMcYrAlZEXcYq0K7wFz3nsjSv91zn9EvAGLvZ3c8MjNsyrrDbUQjQSHr?=
 =?us-ascii?Q?i+Cj0bjOksb1S+sf+3ko4ylFsPiNqZyhgv/2CVF8kPMne8edYmNmaJ5np2DM?=
 =?us-ascii?Q?Fz/dpWQ6yGki2Z/Ztd+aFf970miDW1C+6k9YoADiAt0Mc73Seu/g4MuqXJ+X?=
 =?us-ascii?Q?Wxv/WXcpmo5Wfe1gHJ2k8kePl84bOPZVCWEZgod8QcOUoTBQlWhJI4WHBUN1?=
 =?us-ascii?Q?xDiQWjKpl0/48RiL1KSSljgIfy66pIyiiNzkAP/ZyIwUTYutg8TQ+CV7lEiZ?=
 =?us-ascii?Q?aShK5gERRSf50xP/wtSKfLgpgMVq25AD+qWW9NHQVz4ZeFtMurcMiKxb3fFX?=
 =?us-ascii?Q?NLDTCL5+jWXlhQJkqV6rOo0xLSLMqlXiB2wSPfthnbBWICndGAESK10au3PZ?=
 =?us-ascii?Q?KiPuZwOmnn0Rv3WCyuJ00U6lnLrAJiuuai3XmBqBtgHeHlyL4brNaP8DmUrV?=
 =?us-ascii?Q?s4RDzl/1IGbMNzJXwfKIVddyoqKpS2n8P2qJvNT2yZXnv91mI8jc2D/bpy6w?=
 =?us-ascii?Q?GSSao/seuY2SwWh1xxKnSeJc8vc0FljFUZpDIQ/UxpQ1CYWUbh//RL8X7xkv?=
 =?us-ascii?Q?TcSS6Bt2mgv1jArZrvUQ0eTwT908DmbDXAj6OQVKq92bLL1k55Tv++fp/77z?=
 =?us-ascii?Q?rl4tgJ+O4yQGoKxY0WmJ/lLbM2Wv0L4k1za+ut8kjxcbVm93TFRop/bI2FsA?=
 =?us-ascii?Q?ALV+Nv5dzDa+6KefydYhiCb7qutKcw3HXIXNx+SbfugutM5rrUg0QebJbttM?=
 =?us-ascii?Q?EthgHGP9tkZCMjNuBq3HhrQxyMml6TzKy+5ht5JAJQJkutTi54RCS/2nqYdW?=
 =?us-ascii?Q?ZFesyebWRfXp0Ci7K3WKKRa8Xosk0SBb4Zey40StVTtRpnLAS1BpRVJPQ1cD?=
 =?us-ascii?Q?vRuoGDQuV30y6b504e8Vjwc3w1RwBPQHkySbIu2kM32YWb7pSb+TXBzRKLyp?=
 =?us-ascii?Q?ZcNVlC5xBeQ2utb/9JASfRv23ss973UC9Borz28g2vUC+C0kFXqTZ/lyb8MP?=
 =?us-ascii?Q?xuhRRVH60TH6j832SUfNjipxztrAHvhUR6YQ8gIvriLy50tb5yC4+6dSCb04?=
 =?us-ascii?Q?gpWFJ8/ejdfEapMLgPCc8bi4k0Nl0cx1SCqNtAidFTJlIB22EEvXD//+bLO6?=
 =?us-ascii?Q?RZSoIh7aY4NqaDHxIe+pGwy4Sij3KmzhFNtlpt9h?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uLcioGVheFL0r5hKPQaOTgwun6ZVXA+Av2Mou49i32yGulu0/zu1+UUXS46c4KXmI0WBlRGdqbS1lFpBra2o203BYsNj7YVChMLqUXixt8p3L89WJfQQf9qhFWHPXX6e7oojP4c6sJArGUnUpIDgA+0jR9cAVVX8FU1do2xfRBmnpzVK6Qj1Wp5lBrOnA1MngJ913+J2uPm35+3yJWE9t3gKOSX7NXm9eaYtJdGWppNzm84E6OZ59l2TVPCbiIDFOsaerVS80yZOPq8heEhWCczcAYL8IpW1+BL4J2GnkL7+QX3eN7eIsD3LmQ9TwJzoI2YWOtxFnkfda7DRdRyfVwhYElYrMlx8/nFcdyWvlHzKZiuP0I8sqw7tV2lMvS0qL4JQ3DuB3xFjHfUqSFxlHSRdMyhKbEPUDthmwlyKOxhOh+/e5MMF1K9vM4n+Ax24JqT1G0RzpfrBR/6ieOTdOSR1aHn5CvFGbbXnZoVF0G/poqBnFKMS9dJfyRgv4RFZ0AnQ6pyKrfixwHoEUAhMCoiu3k0WmfPqmPRz5/CVLDbsUMJGHRX5e/wXGy6gqmrLySqrCfoy5ySycm+3AqqSvRkgdlIn0rmXe+SOsuYHVwA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918d32f5-8d00-426e-7c0d-08de274dbb7b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 09:26:34.6683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RDti1KX9Vkjh2F5F+zL1HiFSa89UzZWFqwbr0GOO6rLkEl60nNR0wm7HwjDQjZ8P2IW+cf6BOcwClUzyhoLJKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=967 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX/B3lubLgxzv7
 o1VMIEwojvOEl4qxoVZ2nqWm0URR/A/MlISqvYTNaCZ6SYiW70+Thz7LsqJWLdn/LT/tkhhYE77
 LDiS5wegYMMnEUOaIxIK86uF0kL0RHnH/Wqk6IuwBjtGJetEUVDdPzqyjGUY6hmcnzFnhh1vuvV
 JonwCoLn28mad0b9eMzZz+e2aSHkiPd1dJ18nkXGRsZ0/2wK0dpxFc+QTf40gRZVvHdrQxU1bvH
 FpLg3mthfTCGoGgt24vwbPXavuGRwFFovdX8bTF1o31X3V4PHWOx7tEugRk/3MO40gpRiUrHlt2
 VrbNmoeF0ERx9g+VP6C6iXxzCRfItGLajS7r3X+AwKIOI0Lb29e/EAL28mYc7wgxh7ivbhKJhP5
 ur9DQfwzYL9na75Zc/kyzlPItao5N+OKTz71ghbUb/RK+gXuioo=
X-Proofpoint-ORIG-GUID: 5sGE0J1CG4fpDthZM3sX86mMnGw_KaDz
X-Proofpoint-GUID: 5sGE0J1CG4fpDthZM3sX86mMnGw_KaDz
X-Authority-Analysis: v=2.4 cv=a+o9NESF c=1 sm=1 tr=0 ts=691d8d4f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=yPCof4ZbAAAA:8 a=WKiVBPBMbvKHMXwaU68A:9 a=CjuIK1q_8ugA:10
 a=ZXulRonScM0A:10 cc=ntf awl=host:12099

On Tue, Oct 28, 2025 at 09:58:24PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the memory cgroup in swap_writepage() and

nit:                                          ^ swap_writeout()

> bio_associate_blkg_from_page().
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

