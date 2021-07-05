Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88A73BBA65
	for <lists+cgroups@lfdr.de>; Mon,  5 Jul 2021 11:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhGEJnM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Jul 2021 05:43:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:36164 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230323AbhGEJnL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Jul 2021 05:43:11 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1659VahE016137;
        Mon, 5 Jul 2021 09:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=yzElunCAPcBRSK+qkbxIyTyUHG4LxTzy5doHzILW8Dw=;
 b=kfuxJcKnWJcJdFSUd9X8m5CvRK7HNaveiTxWy1rpZkQcbkJReFPI3810hJVFhTnfZtip
 xgYegnehdbpcDLs/9CDZAAE3aohKujJjuTdSe8/fFMS06k3jsoB1FdVgMusL0eAR1FDs
 rjJz9OWBlDRhCcKGhjBHFnKBzPBjkZygAUkmO097J3L9a+MhmKX0BJpNddPFMnWVdwRK
 Sj5wd0FApMijLsPpRDdr8qFPLtIOQ/h2ehIkIa/Dfq+FCdPtCcXP/BnmmkAmpY3h4OLy
 0n7Hm618XpCwvc48rEtuoJGDsyYL8tKR9oZeZVPgNWRzw5yFY7EMypT5Ry77zStZNyJ/ Ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39kw5k0cep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 09:40:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1659eD2S113470;
        Mon, 5 Jul 2021 09:40:33 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by aserp3020.oracle.com with ESMTP id 39jfq6fxcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jul 2021 09:40:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imC7y0uRlw66zAOihM/cyJ5ajs7kvgWctAH1PbIEou5qeTzrEP2JgOYYNOJkLGFiQWxLhya+2HS5dBMKVkVeJVJ5zta/3hcC5CUjiB3VYfHeqr+vRXkxWNt/o/8eEMXj/LdZLnmr/9Qy/N0HYdyxn/+7vIhmIAVcNxLH88QRrkE1ibN+35LrGCONrxf2094VjG2K/AnNx1v/v1Bw7jft2LJo1l52aO6IXS+hoGmCW3hzzbzgKQwPHC44GaaqEVW5H5YGIeNo9QeSsKcUTXQhmQAmUB93DlptspUMaggCr9AwUaEBaG2unltiRL/KOYpuWNBnYIfRPXNLSYYBTY9j5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzElunCAPcBRSK+qkbxIyTyUHG4LxTzy5doHzILW8Dw=;
 b=irYQOiXyye4dqh1xLTLG4q+MBFcqVkc0f2gdx9sMd0x19jaFZzbP45tgOd+KnHXetrT6GaF5yaRE62C2bPI3vmjqB5vZ605hSfynPyJB2Rl2emF88YkEz9k1791tqA+cXg7KUBHV0ShiNngk5Pc132BPYnqazDMWwcApUV4aHeh98vsnR0qqTn7kutI5xbOaFZI7eeObBtRzXBnsuno417b34CR+TlSgnub7lN2q/s+obKUt/na1OnECWyIiWA2u9hYeIU05h72leB2sR4votI3xBzsujGl67IXijkSQyzn/tU1G0JOvJE5ZtlqQSKHaXco17D1Yl+IpkVnCBdS/DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzElunCAPcBRSK+qkbxIyTyUHG4LxTzy5doHzILW8Dw=;
 b=M0odXdCpXVavqHlH4GISVjCR60H75BLbzq1JoemAyEc/5wCGH918SxLXP6KYwl7VIqAvDL40r5OgGGdGELR+FYmuSM3d+GY3yewzCYcH4UnqUt+Qu4Qr2It38aAR0H3xCjp13ws2CBEuXt9oOpkCcpfv+OjRthHLJ/2cBmYdx3s=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4402.namprd10.prod.outlook.com
 (2603:10b6:303:99::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Mon, 5 Jul
 2021 09:40:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 09:40:31 +0000
Date:   Mon, 5 Jul 2021 12:40:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org
Subject: [bug report] mm: memcontrol: switch to rstat
Message-ID: <YOLTfDNPZA1BYiok@mwanda>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Originating-IP: [102.222.70.252]
X-ClientProxiedBy: JNAP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mwanda (102.222.70.252) by JNAP275CA0018.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend Transport; Mon, 5 Jul 2021 09:40:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebb8afd1-a8b1-420f-45b0-08d93f98edb8
X-MS-TrafficTypeDiagnostic: CO1PR10MB4402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44020DC7653378F14A1B87B98E1C9@CO1PR10MB4402.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwyhmqZELP3uDlGD+XPrGbuQ2uo4/nPR6alFNPAQEp8ogCrJtfefpIlyJ5IHowhQdOdkE2gZ/puuPHGmKkK8PqkA65ceeZOMOosKURzrma3fmjj5tCa7sC38qDuxGGEAhHTpvob6G9a+JI9aSLB+fMW7jSgLk/Hy8af2Xl6ZZhczkvPNArQu36un6pmtJN5ptytT+NAh+jDUt+OD1zzjd8ypBsPqowaszyBbcPeXg496S6OpiaaasIVoxCCPnJ7nueCuTRsvivgWYb9MRYGRDuLNRgxeW98kOQBpmKFdsC8KP4m2s+IF5qQQRXXawl490ArvqErlMha3zSJ3CgF8rpJ+5W94d5EWv04mZZ9hZ6p36HDqkYInDB2DIamqitooOKjfCdlioNf2myhTFL4IrFXAOpNK4Utbjc1KpeOTRxHfZd3Oq6+FVG2quPxsifAXNDdSBKTCCU/UpI+rCMQexSBQCPMR73S0t9xY0acp69d0q9qmDa+kWTm5dfBGysEe+daAB3OGigBem9pzZkzhNo4JQMDj6kv2KWIzZOszJILQaRwtCDGRE0tBP3fT5hFAJKac2/PJ97QRrCSWWBWtNxLkuJaYGMVxl7pmDvcolQTlqqMyemio/6OLnIuCMWvH/vkA6dM/5MyEE6Y7L5379ze5ykKZgTc+jzouaPMmuswIzpDlKfahlH1GYIu5nMyn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(366004)(39860400002)(346002)(6916009)(6666004)(9686003)(83380400001)(38100700002)(6496006)(38350700002)(52116002)(4326008)(9576002)(8936002)(316002)(66946007)(55016002)(186003)(33716001)(478600001)(16526019)(44832011)(5660300002)(8676002)(66556008)(956004)(2906002)(66476007)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3MLRnq+p6WHsNAs+iePPBZeLt0ZIXcZmNBeJ00mjNjC1D8eKoIXA+BerEGtW?=
 =?us-ascii?Q?+MhyXH/zD3kjEeWwTrGCdVwr2T4j0OOit42+AKJ6mJrzXgcNBX9Y/w9rk6wQ?=
 =?us-ascii?Q?x3X1ZeUOq6Jh4TllGpt8jBtBL+2GRRPR4Vhm+aAWfnqeW9IHIi1cIO3G2Y+M?=
 =?us-ascii?Q?rXRBw5WgeOH7lEqwB9CFGiQe3QJiOpu5uMcFur3iHKpppJ3Jzr2alcZUIvcG?=
 =?us-ascii?Q?ZFz8eysgbpCAFhTAmPcnLkSnlYNZewdAgpE7x9fvuqToD2cSSBDcjeUylFVa?=
 =?us-ascii?Q?c8DHfGMgtQ4o+dZtXeuLTQ6EJd5pBDvOQF1eKhGz08XhUuWsAYRpt47kTPNs?=
 =?us-ascii?Q?wPKDrAsncVyhYqJsQpYb5vxO8n3oQ8CwYTEvV4sTBswgmTvNN+nSu7JPqmXf?=
 =?us-ascii?Q?AADGOSdT4txkSDX5ztETziruXBYvA7yhMpF0pvStvZqGGGZFIvHEWFij5RPU?=
 =?us-ascii?Q?94oyD6wDylfhfwXrhkpa8bJhlkC1N9mlhkXUx3Ek7IA5aI5akxn+Tzm5o6yH?=
 =?us-ascii?Q?VPi8WiteamnqdEQYrtGQ9JYXmTQzlvizpFlf8OdP6nTgjtB8yqyhR9925Tur?=
 =?us-ascii?Q?rVXQQIptc7LBxujkUWvTPngwXDlnhuP5o9EZnsg8G31fzipjihCjJf2OeY/0?=
 =?us-ascii?Q?18W/jjIL2YkBgUY+sBX1oDRo7r5+lWDaq+KT9V+JbbrGQ51pXCiorloKcuWD?=
 =?us-ascii?Q?M8UyP9ZBZtXAy9prcZ0364oEocAFz2gJVTaW8FqM4HMTJCDtU11U06WwH7kq?=
 =?us-ascii?Q?6p6GpuAKqx+2v2b5BXKlu9NeuQl06oloI6OiDGg5K6TCYGRFrsOk6gE5JZ9H?=
 =?us-ascii?Q?zLzjz7mO6T5d4auOOn96FA8jbDnQ0r3TyVh+5wrHFLm5PcdUlsPvg/rRsO8t?=
 =?us-ascii?Q?br9KqMB+J6Ix+gzdlFojY/HCNsTT/k4vbyJ4l8pz6g2jzfQTCYmMNyZ66Gp0?=
 =?us-ascii?Q?yvHjmjiyxxVAqJf63wspUyysvwkHicZnCnSgYX5o8or/GF98fPfFEfN6En8K?=
 =?us-ascii?Q?2qubjGo1hW7Cu5VEPWH4qOqSUol4tPhdUOMmSwfLdN7xPKMlnBio2hO0+ZGw?=
 =?us-ascii?Q?AquV7zSv9kxs3Tmd5V9gpP9orHFxFEgLBJJborv0qbt8g3+TD6sFZ/HDN6fE?=
 =?us-ascii?Q?DCz9UC5KV+iwg/lw/Ox62jXa8A6jQIpPnIO4zsfYJben7ZcgoeADyukwAHWc?=
 =?us-ascii?Q?WRxIjhzzqVdXKAyr4SFnibuDE5ryQtXIxASzBRPuhi8hYJi75RrVeHn41Api?=
 =?us-ascii?Q?PTgiVuVmY/fJywtD+4xjevmr9PmwRuBHBf1K9MGVAFtr7MT9b7qaSy0wEzkS?=
 =?us-ascii?Q?lCBmjcQceN0jE5EV+uiPxYKD?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb8afd1-a8b1-420f-45b0-08d93f98edb8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 09:40:31.1677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvukU7jq1ZgGiUkmWL/kJ7TzlZ2UDbY9I9cFPc0eN0jZEW50x/ItuPf3Uyc4goLpa8NoMx2SwHiLUz5pz1pS1A1SNxggrWVWozDVfB5pVN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4402
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10035 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=779
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107050051
X-Proofpoint-GUID: BGOvZ8Jnzo0ELDT8VHrlkAwxu4vdpisX
X-Proofpoint-ORIG-GUID: BGOvZ8Jnzo0ELDT8VHrlkAwxu4vdpisX
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello Johannes Weiner,

The patch 2d146aa3aa84: "mm: memcontrol: switch to rstat" from Apr
29, 2021, leads to the following static checker warning:

	kernel/cgroup/rstat.c:200 cgroup_rstat_flush()
	warn: sleeping in atomic context

mm/memcontrol.c
  3572  static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
  3573  {
  3574          unsigned long val;
  3575  
  3576          if (mem_cgroup_is_root(memcg)) {
  3577                  cgroup_rstat_flush(memcg->css.cgroup);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This is from static analysis and potentially a false positive.  The
problem is that mem_cgroup_usage() is called from __mem_cgroup_threshold()
which holds an rcu_read_lock().  And the cgroup_rstat_flush() function
can sleep.

  3578                  val = memcg_page_state(memcg, NR_FILE_PAGES) +
  3579                          memcg_page_state(memcg, NR_ANON_MAPPED);
  3580                  if (swap)
  3581                          val += memcg_page_state(memcg, MEMCG_SWAP);
  3582          } else {
  3583                  if (!swap)
  3584                          val = page_counter_read(&memcg->memory);
  3585                  else
  3586                          val = page_counter_read(&memcg->memsw);
  3587          }
  3588          return val;
  3589  }

regards,
dan carpenter
