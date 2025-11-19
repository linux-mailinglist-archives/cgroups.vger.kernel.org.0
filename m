Return-Path: <cgroups+bounces-12089-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C58C8C6DEB0
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 11:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A6E0C2DF98
	for <lists+cgroups@lfdr.de>; Wed, 19 Nov 2025 10:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827A121D3F5;
	Wed, 19 Nov 2025 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BSYDzUjL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g+LTuSAB"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71C032E153;
	Wed, 19 Nov 2025 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547255; cv=fail; b=Rz0vSekMq1I6tneJugPfQnY2hf1d9gMInErYaloM7O9FFIHKLM5nBroBfN+vEmcttlu2BYUAamwPxIZ9c0mv03auMUqOroPbQQrDNqpDxgOE+xZCCvAG1mS4v+IrqWBWhYCIUi/Z02osT2Z9jJ8IG5xI2BHdn9NKt7VO5+0GygM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547255; c=relaxed/simple;
	bh=frdPKQYxPdSyRdVqlFBhrKklYdbvT+85S5tJ2tWr960=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aTZ0QqeHUShn5dHibnj8Qgq58iu72f7LJFtLJKMQa5qkJH3kjVG659UGUcHiILtANQgSczmwm+3sfTedCDz5q/SW50F0ypknnEtDH88pI7Q/9dIofuWBSUH4IHR+iD+V+UbDmMAu7hnoAAp1ulK4ToCHrHEJRLjGEOiKi6XDYN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BSYDzUjL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g+LTuSAB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ9OaVD010455;
	Wed, 19 Nov 2025 10:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JkXiuo28nBd+qr1w/E
	bhqxd3gcLcpLAqSnev7cCxv8s=; b=BSYDzUjLfCXd7Ho0aI4Gm0jINVahF/bgkS
	ADJn9Bvq0WknoSnypSzZgWSTdDMdJxalJSC1nrZhx3lvdiqrOuvdOdF3SWD59guc
	IhqjHVGEI+cJK1PCG3WHrxZH0eWRoeBmvO/6wO1jWFZ5aVvox2vmACP5OO8/C0KB
	fqAZ2RuvPYr/w0i+NwOrWCmwR7qUkrI3ayfUNMrLYwdmL5lV4hB8Afu/1Vwt0p79
	tRs7PuY0ZU7eA/FOC1BGFss43xw+nlRyLlmfjwpqqK5QcoYavcgT8aKPHKwJtCXN
	S314bF7WETa3dBXfx1ENU2VMSPQVJC0Yi78l9hNmZYzIahfke/kA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej8j6saa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 10:13:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ8A3cc036111;
	Wed, 19 Nov 2025 10:13:42 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefymnb60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 10:13:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yy+XKIzpL4ZU80GSPJpYpicw5nYjuj4OSsySuoWp0eEXOH+tNyoxpqMTTMpQkR3wNoXcZ3gX4rnel+XwFznzJRcLhtC0cM6o7Y74A+ZmE+N9SRzSeFpgQgoO2M5Mxi04OsZOhwKCFfDhZC2VJMbyeMUAI4UH2+iIUra1PmUCUF/cv04E0gGpkAWNBq//Xgs4MIt++9NdeQAgKDT3vGlOZD+TXTPVe9qAzqIywI31QCa9D9m5df6ed8ZFDt7c+L0/o1yfop2EMcQkkuT1jlpCPFd3IShsJkNQCjONXdPq9wIl5ifGutxjN1U+d8Gjsd8p7pwSpVj/Irkw1Vkj3FraFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkXiuo28nBd+qr1w/Ebhqxd3gcLcpLAqSnev7cCxv8s=;
 b=t3wwX0ST1ogLMOwIhUIvm3MiRATCQDmk3x7IgTcD+D1K8MsYSqm4XK+Yy8x2sNyu9KdZkjEI33O8H7O7ImbdfBfGabJiIMX0NXyiXAcTiB33ZEIvRiM3f997MB6MKJPeoQ4mppI1ieNT70Xl8YOZHjclxTv1XdrHwQNy7vEt5Uj+Zf81ScWRz0g1MYblF9FLNda31kH+fJL32uLrzKJmC34uVWect4dtU7W7rb+xF/OwB2QEcc49FLiRd+2CyAN1be+XK/Pm02RHGeFf56Vk1SJp9+wrLe9IyWqICB9d4JgcSnCnr+gznxL90cmMe69r6mswDF1XUfqjSiub7mEbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkXiuo28nBd+qr1w/Ebhqxd3gcLcpLAqSnev7cCxv8s=;
 b=g+LTuSABcicp1RfMKjWUuP/8VDQTRe3ONLpUPnJqfbN/DYzpjp/z6YKVUzGsw7hNJfWoMgazrllHVC5XS8tIgOTKkr+YGAdUduzbz54kMzCfc7V79wJpZeeM5Wkv2f7gNYOyr1jiGGgPSJdHJSOqrB3wAavJAhVBLCy7gxqDelQ=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB7486.namprd10.prod.outlook.com (2603:10b6:208:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 10:13:39 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 10:13:39 +0000
Date: Wed, 19 Nov 2025 19:13:28 +0900
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
Subject: Re: [PATCH v1 13/26] mm: mglru: prevent memory cgroup release in
 mglru
Message-ID: <aR2YSDDbhHfk4aNs@hyeyoo>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <da4182d4f912a00e0cbe377f424f1e94afd3e5c3.1761658310.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da4182d4f912a00e0cbe377f424f1e94afd3e5c3.1761658310.git.zhengqi.arch@bytedance.com>
X-ClientProxiedBy: SL2P216CA0128.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1::7)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b04fc4c-9d29-4587-285a-08de27544edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SMakmtCQBtEXi/ipmZq2p2A4tII+G4m/PEJYreMf80KSJrJE8yaDYcvo49Z9?=
 =?us-ascii?Q?xQ2E4JrVXh9vagKy0bJFBPvGzllb0Ww9MuVwClHDVl6NZBeXoG0H7JG9ta/L?=
 =?us-ascii?Q?ozWY1D9CzH3FpuBSy/XYO3j/guUgmpnoorYCe2im7mgVu6JQUbwpZGJLYyga?=
 =?us-ascii?Q?mi73o950dVS2+dtmfv0M/ODF7Z+lATBSZeUhpNg6JF68Pp3POwll1/kAiZoS?=
 =?us-ascii?Q?GbqpwLhijUnvLsd7CRDd01Y+Wvnd4hJX6J3kOVCSiFxSNrTEmXvmg+vkenC7?=
 =?us-ascii?Q?dse0cLnWgy9KLaxdt8ZdIVAwi/JbQU3JCSgPHab5IMvHStFEgi7lnWPB7/oc?=
 =?us-ascii?Q?jUQXKgwQgsqcQGnT9cQQmNkNwGOk3xnIqjPtweO4jy8O8c+pravKf93js/GT?=
 =?us-ascii?Q?j7uhMljxCzcZQ3daChK08Rbtg2i62aPh+bqm9z498m7O223N+zyaH8KkudWM?=
 =?us-ascii?Q?1vDUDwaWhpjnZKJ6XFr+ddnlFY2Pm7eqPAvy9/N9T8eKxA/H4Cr6EYrjBMWA?=
 =?us-ascii?Q?dF+s272L322EZaWqO7cvVU0MtscF2x8q9eOKKbEikpwZp3O5HrGmEvlZ7itk?=
 =?us-ascii?Q?Y+tWrwmk9NbyleIhXilRBSXP2qi0gQiHi0SNPQOqZkQj+oFr6qtJ6p+NLATt?=
 =?us-ascii?Q?haNxrlI2edFisn/UNy5czC0WwbK5KSeCG7MkdYPY7OZSgBSP3Hu+9+wufCqA?=
 =?us-ascii?Q?iaIBN/gbP+rgGU3IcW5Q6oAVwyoKbNGtYsiJLuc1o+YrUeAL9LDEkuZhFWGP?=
 =?us-ascii?Q?HeApmAeSGUjeu5MHs79wvwhgXg7kiecXk3R2wpe2Uc7ZM+2mp7ckR8XCpmqG?=
 =?us-ascii?Q?9FSE3kBVim6y1xvnmk9dSsnQPh9PDMRQWK+xx5syTjp1GQbJMhUmTx0LL58u?=
 =?us-ascii?Q?gYL+dYuRNGOr/fc2i0IPlAMRk8YmZ+KyDpVq2tiadjStDVaSqtpBcb9x2yHU?=
 =?us-ascii?Q?mO4S22/J6O5Ygxh40m7AtA6GGXRvg8lFhB8IEj6tTI8/b4Ho1WDidO8h0oIc?=
 =?us-ascii?Q?SC1queThkmyBnpkWcfegrJTPycUyDRyZz1MhHxXfTD1ZlYL4vL3rOtJpfqBg?=
 =?us-ascii?Q?PYR+kEETgSfFRDigr2Rxzi2HclWmKkoVkbyDsqTlJO154P97CeVRkGNtzLZm?=
 =?us-ascii?Q?JRCHas/GKG6VhOJgYuHLeA0ug3aN2AR6OiXf/XECRuztJ0+cfAiIc28WRETz?=
 =?us-ascii?Q?+TCuwAaQ67vKX0Gbt/E8l5vjYT5KCeTcAMZdlDSWzpMN7mMzok9SVGDssDZ+?=
 =?us-ascii?Q?5nP5Tk7AYXese2pgCixvDHCU0Xkopi5VxE/NTenFVnkUOC/yIzgDlp2Lq/ig?=
 =?us-ascii?Q?G5nvXXrQ9plf6XygP+gMHqSnsA7iJDpUZMSEztlAWvf5DMmy/aT5n3s8YbDM?=
 =?us-ascii?Q?D/NB7rXmlgFx7PcgT6YfbOcwa4MTxuYCfQp7vhzSdgwgdSRtXTnO+fiR3Ofx?=
 =?us-ascii?Q?9PrXl3hz1+XwJzjbNGHMpJg9vTWg411a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9eYj/lmqcitACzaufMAy/GozmeBnENVIsLnjoehtw/VRDW9H4OMkINI6mlKD?=
 =?us-ascii?Q?hxaUpdj0Pbk1OdGLc0cjqoAD7ysWnHG/VVLsJ6LwhhxJUoQwLaGzOjwYo4oX?=
 =?us-ascii?Q?QixK9TnWpPveMUJqtf2Tv1OjSUW9Cr7pC0PHJdbwSnNpoJ6zKltUBn4PPN+l?=
 =?us-ascii?Q?OhS/2XLEQL90lcZgdbLWGwM9pMsr6c1TQ9W/pG5QHEpC1tgrtHQEtXYGuEhX?=
 =?us-ascii?Q?Zvh5HKeWTvCfC49BQUHxUpdVZWJl7bq+EtiB1ZlLznZZg3iv+4igoSqg6HR0?=
 =?us-ascii?Q?WSTwiaT512Ie3h6eXyjKQL4gPpYep9a6d5yd648urE5R6wrqnKnTv6EhEXjO?=
 =?us-ascii?Q?KYfb/R+r+/Ad+bpoZ/yHaJXxfA7+ynBGsE3E+4I16SJCcBtEC1FhCwCdd6O5?=
 =?us-ascii?Q?D7kCmDZJYC7MpnI/rxBUfqXgrKxooSUnA+lq5ldiDBKXOURAJmew8JHQkc8G?=
 =?us-ascii?Q?Pqe69fvVv4arx+ROqYCcY/4OBAFhvkCsL8Tik7Ehw0tlichVJAUvAwda3c2C?=
 =?us-ascii?Q?DFoQImLdOZeCFjGQqKZ0Q5cRmBDT/gvlIPCEhenudDonqcHW4/Ito1IXUS88?=
 =?us-ascii?Q?NzssSD4R/aIKT5YnqHimytqHB0I3eQmgXC/UAodJV0xIb+HHIX7hNpPj/tZf?=
 =?us-ascii?Q?G5xNJUBWvxa68uEFiBN6OexZVeEwKtboCfoDgLCmQFo+0JKn8DM314Q4p+DI?=
 =?us-ascii?Q?dWUopr4sUpQXRyDOqo7N6dzCLcUQb6qJx4Wq0CRANDBbel2AXEIKw/kpGY04?=
 =?us-ascii?Q?4uZspflV9jjAqII7pROozuQ+oxLEXr7XLknnTWYxlRDrB3NIqXNKO3yDfQoC?=
 =?us-ascii?Q?xKdHsouBD6JnmBZTkRHezU02uvK0MH2uceVi130zr375iCkIOhAokG/q/xk6?=
 =?us-ascii?Q?ZtsfK/oX8PwoUXpC94SUyFOgx/wQg5dXGxn6DCCo4CahfA7tRs3zJ6Z1q5JV?=
 =?us-ascii?Q?jHhZbhaZmQ7QhRdz8zy46FE9jbnigU+X4+tP8GTogaUJYHpiwjFQucrJb3Gc?=
 =?us-ascii?Q?uLjPlR76iyFa2VcqPGRjMPH0+wZEu1f4tLYVxI1bMPsPy8I/S/MV6GvgLzhr?=
 =?us-ascii?Q?JJbv7BwV3FEPY7Dbemlp0YQu+lgKlpy5cEiVXpV0riZVkOH8A4bJYycuufT6?=
 =?us-ascii?Q?cwPUsz7JSZxRqog/oiZir1BjoG65vhT74fMXXIrKelF4r97qwt1UKJcv1i6y?=
 =?us-ascii?Q?5DvI94fT40PZ1N8/g9+S9qzG5ZcDqIe06WqBpwmisb4o9ZHbhwiq9Jv26kYM?=
 =?us-ascii?Q?EoNj71VU6oXQKciEPBV1Q2AYLN/bd2QRlogLroXZNcy3ZcnCX8COh7UpWUIw?=
 =?us-ascii?Q?FEtKJPBwl6j2+FnttaMQi4mdrerp8W5c91fe9shfWS4d1vxT5xadkVP9BpA0?=
 =?us-ascii?Q?J8jnmCgsKDhyyL83z/wkWQje4WxW/sHvv4b7Pdb3N6nEqHdRtnd5A91vE8hj?=
 =?us-ascii?Q?eoRvMa54R1kvWwU2TRhGC1q3puk9TZmw6IIRVRZp88dtJ+sqnwTfTMkbGb1q?=
 =?us-ascii?Q?canfwdJAFFXrNt5YqP/5Y1rW4HoRrDKIelplh0eHBAuuNi404pP5UmNXQn4l?=
 =?us-ascii?Q?Bp3q6s1eXvXZ2FDcVmbjtnRFST9rtv6jz0NNMPP+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+JH0Jm8wPVEkOWd9/ZEkrGYWQ/TptCltA5WVjkA48bMKg8O50DOvMDDlOAs+AaMsRWAh+A4xwMwNjeZtvROoP3a5RM4JTf8wgc0VVc3854x7mmdDDkrR4UUeSUdyLj0DmvkHxpbxqn2y98fRWG3q7Fnj9bgtzwBvLFYG/EftC8jcfQxUUO6C4vNqZALv/RjLeC5OYstK+DDZrAFeGMWGz8rP38iO1KwAhINKy8eNoT05tL6IQ0x7UY0cu4o5YNQ7tVCK4LiQggAAFIAnXtj3GvsMFrqZ3TNEgzklGzbCGIOcDnW+akj29wMf1+V0ida2gLEotyjHHXKHjwBujCl70sxX+l72wEgQPZPgDtVcpJuo2S907tdloznXKvzj4srFg2Pvq1FY2Pwz84nPxkdes+N+7IcN6D7DcLqB0ACSHZ42Gyz7Y98JgrsU8brwvWHeFceue7jgddD2kRCSURcT8ihRUxgOUhEM1K7lH8FC4OtDcig5ZYtgnAXQirrlRl30FxmUrrZul9yOiZyGEz8QKAWFtbD6aQegZpj50V6Ey37w6oK8tbADsfhPQwYdaEZQ6wPk3z7Fok095L3NVP5H6i/wqdxdeAoiatTQQLaVSH0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b04fc4c-9d29-4587-285a-08de27544edf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 10:13:39.1057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jA3aF7Cb50qKFjceuRaoRd/F6eBo7aKdEZi0ETNR2J7vQnW+T6w5a4WFXhwE3AtzwXAG78V7VnD93rCMGor1Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7486
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=719 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190080
X-Proofpoint-ORIG-GUID: xgOW4BL66FkdKqv6mpmbnuhwipdfflq3
X-Proofpoint-GUID: xgOW4BL66FkdKqv6mpmbnuhwipdfflq3
X-Authority-Analysis: v=2.4 cv=I7xohdgg c=1 sm=1 tr=0 ts=691d9857 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=968KyxNXAAAA:8 a=LDjQ5iJgGQJlDgXJjzYA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX8NHt/FWxBZM3
 XfKFYsB0hfM9W1POQZdoL/q+McQhtcPWae4wzGkDXtwyb6Hf1PcIJen3IlX9sd99sAb3cVi0sx0
 CxyRsx4VtkUldUC10I/YGo63P06Ue8UAplLZjGUOeAqk7qAndRXXwy23wGeHex+CbsbR8mzdO8D
 /DPr+6bSQokzvgvlu1jBrMFrYgANHypqztFulfsetw027BkCTcDUILpAxbqxkZQxlkeM8rQVkZd
 twuarp37CFDl/B/8LZrhg/6up7BHVwnIj8KNlN04YVkKJ/bYO1a/rgmf4VHmlmP8jXA1dxa7w+/
 h6bKoms9RzCB+yRaGOaLXI9KIbgUUv30CE1nhGi7mG2QapaT3Ntcf6obOIhdgPDsdL6TnWgFD/e
 7Yo7URAO+d+GFjPhIPHrvr5N5xUtisVS2urp8CB62pJixFDheUw=

On Tue, Oct 28, 2025 at 09:58:26PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding
> memory cgroup. To ensure safety, it will only be appropriate to
> hold the rcu read lock or acquire a reference to the memory cgroup
> returned by folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard
> against the release of the memory cgroup in mglru.
> 
> This serves as a preparatory measure for the reparenting of the
> LRU pages.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  mm/vmscan.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 660cd40cfddd4..676e6270e5b45 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4279,6 +4288,8 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
>  
>  	arch_leave_lazy_mmu_mode();
>  
> +	rcu_read_unlock();
> +
>  	/* feedback from rmap walkers to page table walkers */
>  	if (mm_state && suitable_to_scan(i, young))
>  		update_bloom_filter(mm_state, max_seq, pvmw->pmd);

mm_state has the same life cycle as mem_cgroup. So it should be
protected by rcu read lock?

-- 
Cheers,
Harry / Hyeonggon

