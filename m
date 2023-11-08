Return-Path: <cgroups+bounces-229-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A9A7E50AD
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 07:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4F86B2096A
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 06:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA9F440C;
	Wed,  8 Nov 2023 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XMUbasmo"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F72CA61;
	Wed,  8 Nov 2023 06:59:15 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A04D40;
	Tue,  7 Nov 2023 22:59:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IP4SwawffZYx0ULPPdlk5r9J4MPkMU5w32/fvdtxLoiIDOcwQgOjDfo1twpYwJHV7cNNmZqClRXaIrN3tbdX529dYD2cBD9BUoti9IA/GsJCo05JHAbR9a+PQkMwXmh2bycDKVXmiknePq67bXlnBOn5yFdKnyUjxxh3ZQeRrOimo/2kcMSVu6ETGKdm23/DmlOjpW2o9pJ4c+pqV7uQcNlsXtEiQ+LD2qj9HEEmpoVuhnCV3iKdsgazmY9qguyT9QLZAGkD0a4KCI0UrsSWoB8fVpa0J9Y6cvprb8nQLxroonHm7SC2jP/pqc8luVB+WbySc0nZLH658nuJL8oMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJwHBvKSRB1qLVBlu4jz1SWZbwHrtI5njMrqpET2i+0=;
 b=jZbefsMWX0q7n1lXgwzUTr1A+H0N+r8k+abc5ujKpapMibU72hWG/LQctdB1eTbDPNRgVYpUO6LwrfeLdQljY+sAdTfcDHBa3eMErTyNXUuvulxp9F2+RW3iwTvLtti6qEEo8+6l5zvgAejArQ/fnJBewDQiptHUDafbX1jZIXgD32qjnR6um4l0nVjInePVO75P8EZyuoZiODcaba4nPfNa5XQhpOeACunUBt75vZM3qOezlMeMlIA97lsh2tZPjiJOGpvknIgpfRampF3seZ/pilZ6wu0ZZnhp/rF/hJn8MYbj4djKHhSDnqbihFTQMTcv48UjsVKLPARXRDiBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJwHBvKSRB1qLVBlu4jz1SWZbwHrtI5njMrqpET2i+0=;
 b=XMUbasmo47WFPOJw++0kAMg2sUs7xZuGcj9P/yPnyeOoNhIvVWtd3zYd1wt5AfG4rri8upxMy9cYtLKKDs1K5s/47xsHqiPEvLhGhebrGUrPXmnCWVdETpqyy+PLZfcehdqRHrhA1IRF5l2w4vCucM0taQMcAZrnEdLPVi6fL9dDxzLHuAX4OwIcFQpAIC87rhC2dgL5vBMhZv/sCzoeZrw+IkxWBttpSTC/JQ9MdtwicXNL0FLj1Hvovo+g4Qk5Mk+PCI/Kx0lzfGQfzxUHxdxebA+thFWWSo8rCzT38RXJ39oYIYsQwRPn0RTZBeEuJ1dgthR9DyEe+/kPqgoniw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB3983.apcprd06.prod.outlook.com (2603:1096:400:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.31; Wed, 8 Nov
 2023 06:59:09 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 06:59:09 +0000
From: Huan Yang <link@vivo.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Liu Shixin <liushixin2@huawei.com>,
	Hugh Dickins <hughd@google.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: opensource.kernel@vivo.com,
	Huan Yang <link@vivo.com>
Subject: [RFC 0/4] Introduce unbalance proactive reclaim
Date: Wed,  8 Nov 2023 14:58:11 +0800
Message-Id: <20231108065818.19932-1-link@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB3983:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a78337a-4ed9-4b85-d066-08dbe02834ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AcDJ2+BNryLM9yibQTLXMhygNCh1US+C8tYqLOybfFxl9Fa4k8efUbFW4soBfow6f3SHrul/V62JXKFbSgbbVUPeEqTiY+MBB6fcZgUqUUI7BkZ4qsSsLcWjlKaNFkCUVoAhkBHL2yr8lECP7cNPHFNEEFg32QZfdPL9Db18djtxNWKzfAM0GN9oXUkBXmYOFTbi2ssRivrCvieejN4l3DqwLxcPtWDaDcliYAfo9sVJUzQ/q4sIR4oa3ok9rL61cMmVP+8r1jV7O2d7WQt8kyn84i30rPPir5odjoq5orZcbIqR8wFiuJvsPPf/kUfATLuP5yFUG5UWuN2ADf9UBK05Ue96NbBeauDvl0tBHRnQRp4/wWqCW2bMinQvOLifSmYZtbWTHLhaPxRPkLT3yINJYWPhBLQuVdvDJqD0FLRyjU+01kJoKhl4YnDSYJm5iPOScCaXd5//lwKyltwKS8k2nezylI5p8+Gz/ZxALmVMX3jm4zGMp5ZxaV1WaUo+pdm4nnJQfR2CIkeeOp0LuCBcrOulBadCLMhZgw6cBPzF+XOGq48XVfTvnYpUNLpkuwhw1NrCnwJT1qpFfssYJCrd9d6LQ33EhED+NtxE3M9q7YoaR8ZlqxdGmr2F7TqCrAmJnXD37SbGy1mWcF9xMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39850400004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6486002)(6512007)(5660300002)(6506007)(478600001)(52116002)(6666004)(83380400001)(8936002)(8676002)(4326008)(7416002)(316002)(2906002)(26005)(110136005)(66556008)(66476007)(66946007)(86362001)(41300700001)(38100700002)(2616005)(107886003)(1076003)(38350700005)(921008)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3jw5ZiC7AK/T6AYy3lwjCIg0CflrHoqdBJQoOIYFePcfG07tAs4toWm+CNkk?=
 =?us-ascii?Q?g2iuNJnIFbrCVEvnZuH/afWj9A/sFf1Rt0d0m+N9+oh5ca64EXfZVNyjWTAj?=
 =?us-ascii?Q?9h2AGjfpP+4gse2pV55thh9jeGOE+dzAdmipQXah/g3+Osy4wvrLhvsvEU/g?=
 =?us-ascii?Q?gPheuoJqY4NzEVThGFE+jjAhglw3BpnBs0Vuxb9JrQlf48M7x3vIZcmfAbpF?=
 =?us-ascii?Q?V+lwnTyEVo+YQrdBSLjxtDDWGIAXMQCEbARww7/k8UKJLUDa4r4mX2x9VPG0?=
 =?us-ascii?Q?Y3Gfv4MSdlNMWs+spJIwQKLSGhuZZQ7hmyx0iPE1vylGxf3Xf00QI+DQHHsu?=
 =?us-ascii?Q?PdK71y7vthXZIsfC2aw9GCGp4tZ/gVXSbHjSlzVrY101cuLiJJHAlTNxWc3c?=
 =?us-ascii?Q?uc9uEYn/8r8ZOM/Wi5elan3DOVV1xCPFroz+ON8KaZnSN/lDmQZ/l0mMIkon?=
 =?us-ascii?Q?CVLsp/IVZPIGLYveR58hk5ys5iiO9zKeeY+d24OUyU3oiLcFf9/r7t0FzI8f?=
 =?us-ascii?Q?Omak5VUe+KalDGGX0AwdAbNTK8cPwtTQ591NyF5IM/uerHy8TvYHe3eIZQtW?=
 =?us-ascii?Q?A0Qx+8olz/zSJvvy6pwNhZrvMBBrQxKP5G8nPIF6lU1maUE3FA1ViquPSFst?=
 =?us-ascii?Q?JB8kR24aFSEyffQXQiDwFJqvJWvcaLBvQ767Y4XPjfT22kTgXFpAV+B5w0bl?=
 =?us-ascii?Q?4pLH8USGR5CI8o4XAkTl0bILqD4fD9l/BT24y2aHEJ+r4Onb+D8xUZzyGjSh?=
 =?us-ascii?Q?+cNY9LW8Ep4a+8/RI4vV0s79iT04NlAiiy/3He5FaMTQP1FwcAWz9GaDps5l?=
 =?us-ascii?Q?ptKRNMNw31kyaRJQPtwRE+sG7qmYHchAfPTeQNb19W5Qm7tA3dndpOBAlkiV?=
 =?us-ascii?Q?mblmuOH3aZg6TYFSJXiUgJY5ETnR6OXQjQRaAmMxoCeFtJVjvgtTTcua8QHS?=
 =?us-ascii?Q?rshVUOTI8Ezlb19IVku3+tXqBu7ds8y15UD7B4N07fqN+GwsX8m5AWpmc2sC?=
 =?us-ascii?Q?wvtkNju/rPWCe6U/dinXOJlQoKyW3dOA+t4TWppsiu+D3wStm+pe6/WpdRQI?=
 =?us-ascii?Q?+VQgpUe29CMYDaPKQrtUyg94Nirj9ey5s+UPlXjcjmt12Ml6Pv3FgzvlFYUJ?=
 =?us-ascii?Q?4DpK3CC2o3Nkyw7YL4keNLTaFy8rCvTA9iccZt+bTa8h3M7l/SClD+Wn2BV6?=
 =?us-ascii?Q?r+/yVUDN39l0AK4esDsMrh7xkIOgrHUMGTIRKNwyQAkW43Qjl9KrFCLJWYLK?=
 =?us-ascii?Q?GB573iJoqWHavJq+wJyIyp/TUAu9K8j740Zw0xcHp1RpVUK16O9TfxjGEBrb?=
 =?us-ascii?Q?L44Ycc1R4roAlqKEl18tAthN5bl1Nvhz8app1symmVKQh3eOqpBSkVNk4QbJ?=
 =?us-ascii?Q?eHiHz1r9WW1GnGSzQHPinphZ9eoLketit+DwyeGO2+7+6G8YWYcQN3t/Cxof?=
 =?us-ascii?Q?lMUf+cxub557TB3CS5l0h9L9FONE/vNA4BjMxnj2H0KF2WGI7rfDYu+q/hen?=
 =?us-ascii?Q?gkSgtIAM9LnUADX06WMqRdVcQ6G0EAuXArT/Uvgc6lbcNFaEjf0ETTXypCwp?=
 =?us-ascii?Q?1Ok2uYZQbij+XVAPD0jmlGjcc+h/PJj3fGdxVSri?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a78337a-4ed9-4b85-d066-08dbe02834ca
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:59:09.3956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJkSgmpAWTASaVKRmesjeUOBOD8Cnet2AL2Io9MBhb5krXHg+BiGZ7wsnZQ8vviyUyJH8yqTO7wc+MDANvGGAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3983

In some cases, we need to selectively reclaim file pages or anonymous
pages in an unbalanced manner.

For example, when an application is pushed to the background and frozen,
it may not be opened for a long time, and we can safely reclaim the
application's anonymous pages, but we do not want to touch the file pages.

This patchset extends the proactive reclaim interface to achieve
unbalanced reclamation. Users can control the reclamation tendency by
inputting swappiness under the original interface. Specifically, users
can input special values to extremely reclaim specific pages.

Example:
  	echo "1G" 200 > memory.reclaim (only reclaim anon)
	  echo "1G" 0  > memory.reclaim (only reclaim file)
	  echo "1G" 1  > memory.reclaim (only reclaim file)

Note that when performing unbalanced reclamation, the cgroup swappiness
will be temporarily adjusted dynamically to the input value. Therefore,
if the cgroup swappiness is further modified during runtime, there may
be some errors.

However, this is acceptable because the interface is dynamically called
by the user and the timing should be controlled by the user.

This patchset did not implement the type-based reclamation as expected
in the documentation.(anon or file) Because in addition to extreme unbalanced
reclamation, this patchset can also adapt to the reclamation tendency
allocated according to swappiness, which is more flexible.

Self test
========
After applying the following patches and myself debug patch, my self-test
results are as follows:

1. LRU test
===========
  a. Anon unbalance reclaim
  ```
  cat memory.stat | grep anon
    inactive_anon 7634944
    active_anon 7741440

  echo "200M" 200 > memory.reclaim

  cat memory.stat | grep anon
    inactive_anon 0
    active_anon 0

  cat memory.reclaim_stat_summary(self debug interface)
    [22368]sh total reclaimed 0 file, 3754 anon, covered item=0
  ```

  b. File unbalance reclaim
  ```
  cat memory.stat | grep file
    inactive_file 82862080
    active_file 48664576

  echo "100M" 0 > memory.reclaim
  cat memory.stat | grep file
    inactive_file 34164736
    active_file 18370560

  cat memory.reclaim_stat_summary(self debug interface)
    [22368]sh total reclaimed 13732 file, 0 anon, covered item=0
  ```

2. MGLRU test
============
a. Anon unbalance reclaim
```
echo y > /sys/kernel/mm/lru_gen/enabled
cat /sys/kernel/mm/lru_gen/enabled
  0x0003

cat memory.stat | grep anon
  inactive_anon 17653760
  active_anon 1740800

echo "100M" 200 > memory.reclaim

cat memory.reclaim_stat_summary
  [8251]sh total reclaimed 0 file, 5393 anon, covered item=0
```

b. File unbalance reclaim
```
cat memory.stat | grep file
  inactive_file 17858560
  active_file 5943296

echo "100M" 0 > memory.reclaim

cat memory.stat | grep file
  inactive_file 491520
  active_file 2764800
cat memory.reclaim_stat_summary
  [8251]sh total reclaimed 5230 file, 0 anon, covered item=0
```

Patch 1-3 implement the functionality described above.
Patch 4 aims to implement proactive reclamation to the cgroupv1 interface
for use on Android.

Huan Yang (4):
  mm: vmscan: LRU unbalance cgroup reclaim
  mm: multi-gen LRU: MGLRU unbalance reclaim
  mm: memcg: implement unbalance proactive reclaim
  mm: memcg: apply proactive reclaim into cgroupv1

 .../admin-guide/cgroup-v1/memory.rst          |  38 +++++-
 Documentation/admin-guide/cgroup-v2.rst       |  16 ++-
 include/linux/swap.h                          |   1 +
 mm/memcontrol.c                               | 126 ++++++++++++------
 mm/vmscan.c                                   |  38 +++++-
 5 files changed, 169 insertions(+), 50 deletions(-)

-- 
2.34.1


