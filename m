Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849DD33B28C
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 13:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhCOMYQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 08:24:16 -0400
Received: from mail-vi1eur05on2097.outbound.protection.outlook.com ([40.107.21.97]:58770
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230139AbhCOMX5 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 15 Mar 2021 08:23:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6QPTDNrQi+hVh2T1HI8wYk7Gy8D3ZV/DUbea1WXXNPh6lrvOPp8U0xu7vcGTiAllcT2VRv/1K3MsvTfGkmBqx/Ky+U5A43DN7VE10lTVAlEihX41SmLUrgbdtRPldlDmUIRB8n7jODZUSyuVo1Anj2gfhIvaNJ6wF7pu1eg8Jron27hvlYvEys4vQA38v0UUOHAuhkRRjV8EUjyWYxMia0oIw959MMrmBdngGMUQ/eFgXFiEVQfbrvjvVhFplzlucOVlccsqWrvaFJp5bcLAvi4XRcfMTpeeLS/j4R20WoSNBtPW06SA1gUA4Qrie+vOh1o4D/PDwmbtsJx1z+RIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7Z6F+cv0Ao5paKpXOnMEoUI/whyUVLKmV0vrccOiW8=;
 b=iyJryUbA8T+tXG+W1Ipb0Awy5RKyLM+PRt3ZA74IlkYqqAqHFF/SovOAC8MROaepqLi3mto8lcuZMmOo2DCaTFLy1e7VXymNBPqWraevsgfPFRF19PcgyqbQH5lkr6ak92Ohtn1WbZSy1INHPlFYvrA/RX4KKv8st4Apg0AG9eA2ybN0NbFYV7TMIxZvVxnnpnZdWixph5Kdg2H/VsSahTJTu7laRfoM8pre/BdaOWDdRWoru7rx3vTMTNWxc2PX7t1ufDxGObrAreNxh3r/ecE7xvFox7Moab5LVa4i669OqKdeD9iNGuWZcByKP8OOGtjDHBQbnUex1LujuAEFsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7Z6F+cv0Ao5paKpXOnMEoUI/whyUVLKmV0vrccOiW8=;
 b=JQSccNvLt7KbafrVn3px+lm5uCHJJrAXMQzAXiNRIVdjpbMz+u6Qolr3JFo3DMh7jSjaLQ7ZnMzQT3jn2tqyM0nvPpz6ux/MPE/Qw94D8cQ1MXE6V+4p7GeiUGnzMWCS4V8fi05qCRBFn/lQvclIpWpTuRrHGgwtSMRWG/ID4qo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22) by VI1PR08MB2959.eurprd08.prod.outlook.com
 (2603:10a6:803:40::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 12:23:56 +0000
Received: from VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613]) by VI1PR0802MB2254.eurprd08.prod.outlook.com
 ([fe80::e4c3:b366:458c:c613%11]) with mapi id 15.20.3933.032; Mon, 15 Mar
 2021 12:23:55 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v2 7/8] memcg: accounting for tty_struct objects
To:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <YEnWUrYOArju66ym@dhcp22.suse.cz>
Message-ID: <61134897-703e-a2a8-6f0b-0bf6e1b79dda@virtuozzo.com>
Date:   Mon, 15 Mar 2021 15:23:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YEnWUrYOArju66ym@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: AM3PR07CA0062.eurprd07.prod.outlook.com
 (2603:10a6:207:4::20) To VI1PR0802MB2254.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM3PR07CA0062.eurprd07.prod.outlook.com (2603:10a6:207:4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.10 via Frontend Transport; Mon, 15 Mar 2021 12:23:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef103a4e-8942-4e3c-2ecb-08d8e7ad33cc
X-MS-TrafficTypeDiagnostic: VI1PR08MB2959:
X-Microsoft-Antispam-PRVS: <VI1PR08MB29597FC09F313E987657A30DAA6C9@VI1PR08MB2959.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/UpE7k5GCpdSAbyecWGOwt8kxHxALIpRFL7nTZAGS/X8JEdEMTz60Wb/wACHBDEMrb6TlQzkEP3neiLMhYa7um92aRvKH+zjgxzy1z+XiPqXgXBntw4NiNLbEjfa4WDON0KNNUl/1ffksltHl1zvM+5ooSZWbCdF6IwZmJ3Xy9ndrUaGOQIXBjRdBDHvQxFbxrL3AWpat/4FadMJYJNfX7FgSxIm0htqXhwsEN3oGnq9YEi8h9iVJPxjEz6QTC2fSoFBZyMxc3mMt4zoO0+5Yg7tkN/IkG7mA09zHRS836rlIS7DeI1GgaLe0C2A7J2a9TozioFthuCFdEOnhiHTFFqaa1o1aJqAZcfMy91mhdyVDiwV4hY4wNzsHXBVUIXm3tEVDEE/tMuM57zvgHU2B2EJGAkFMuMbHD0nlsaPzdApk34XtXAiKKj46z3ZuMZNHowJ74MglXPY3Ho7s6Q9YKiMduLXAv3teqBzZbaCeKQBCniPULHQtix9sp5HIrZBIGgvJjfOmYxWatpc8T8utR6mkRL+vL5mERs/XqvQJrOtuuBhgwJzYB1uqdh9Bf6zglpN/1BFBJ+uDjyvpGbmgeMxKorE2hDEyZqxu1MYx4jmwi+26ftIwCeBOExQaaEOhrlf23JpmuBAi87Amok/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0802MB2254.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(376002)(39840400004)(136003)(54906003)(956004)(8936002)(2616005)(5660300002)(31686004)(66946007)(16576012)(16526019)(4744005)(52116002)(6486002)(316002)(6916009)(8676002)(36756003)(26005)(66476007)(66556008)(31696002)(478600001)(4326008)(86362001)(2906002)(186003)(83380400001)(15650500001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cjl2TG1KN3dMOHFWSlliOUdDVWJDaU9lS3VzcGxIZ1Nvam1yWW9ES0NwdnBV?=
 =?utf-8?B?bm9CT29uOHMzVk8yRFJ3RmFsREdSbHlzbHU5Zm55YjRnSmIwZGdvNWJzaFV1?=
 =?utf-8?B?Y2QxRlp0alU3M2NKL2JEZjdwSFdHbVNzZVluOXhOVWZ4bDFOSjRVMzJGU1Nq?=
 =?utf-8?B?ZGdYeFdSVVBJWlBVc00zN2hEai96K3IvQXQrTjAxMGR4TThmQ3VHWnpYeUFm?=
 =?utf-8?B?TWZBZUU5SjlYVkdGSmFSOThjMm5kM2hVS3lNWGdIODBjQXYyMUw0OWJpM2xo?=
 =?utf-8?B?aFdRTndjdzRmTzhtVC9zTmFUMVJuUXEzUit0NHlZTDh3MGhhR0sxM2RuMXhZ?=
 =?utf-8?B?dHlwN0FZK3NPMUJ2ZHF5b1kvRDlkb0NHY0VSK0d0ZU9iU3JoampGdlVMYit0?=
 =?utf-8?B?UzVRS0R6Mk1ycU9KQ2dHRmwwbW9DT0ZVdUlOK09WaTE2dWUwQ3V4M1BpYVU1?=
 =?utf-8?B?SUk1QU1nK1hSZ0ltT0Iwb2c3bFV0T2ttQWpMeE05V0luS1NrRktLSGkwL0Ri?=
 =?utf-8?B?cUZaQ0RBRjd2SXhuWFIyWEtBSEJORDk1Y2dVUFY4YWR4UmIvY3daSHdnMEtW?=
 =?utf-8?B?ekZMbXY4a1NZTmNWdkxJai9CcXNBZXJRYXhUaU5YWEY5cStyQWRUeFRqM0RC?=
 =?utf-8?B?RzdudHpET2V0YUxVc3hRTWNGSmxlSEZyTWd5eE9xUW9taTRIZ1ovcTRDUitL?=
 =?utf-8?B?RUFYTjhtbkM1YXFsc1dURERJbkRWdHRKZzJPdDRudGcza3NNTzdTNXlkd0lE?=
 =?utf-8?B?ZFRDZXJpS2hkNFZFL3FUUlp1SUpmeEVpZXRuRktrQS9IU0FLMzNMSzBZS1RI?=
 =?utf-8?B?eFhTQzlRQzlPK0NKb0JoajhSbTdMb3NHNHJsenB3QWQ0VGdTYUlnaC9VbzUy?=
 =?utf-8?B?NlY4QXFOTFhJR1ZPMTZuQ3JHaHlJTTE0K2N5U0c4QW00RDk3NDNkQ0ZGellr?=
 =?utf-8?B?eHZkZzJNalBoekJRd0ZzenRSSDhpeFQwVG5OV2kwSHR1eUs4blk1WkpqeFFI?=
 =?utf-8?B?cVZkcHhkeENJOW5oYzR6VlZ6SHNnTlkyOXdRL0RZM0MzZysyRVN4M3hVMUZ1?=
 =?utf-8?B?SUMzV0dHdEpXM2dYei82UU5qSXBpbEJFd3ZZRzk3UHBUZVZ5b2FLK3Nmc0pZ?=
 =?utf-8?B?NTBJZ2ZjNndCK1NHdVVPN2kvZHo4ZWNNR3NQbGc3cHF0T05hNDlpV2dLckpB?=
 =?utf-8?B?eHM1a3hhSEwzeExZN3BoeEJQMjczSGhXZTdvcFd6NUUrb3gwdXpGS1VjV2hK?=
 =?utf-8?B?UjZJc1BkVUNwWDNabFZaQXdlMS95dnVHakpRNjZaQ0Q2SFV2ZUc5VWUvWEg2?=
 =?utf-8?B?K1dUNG5WYkYzRlhpVngydFBDSG9nSmUxOU8rUWkxbHpMYU5MaGFtdVRaanV4?=
 =?utf-8?B?N2lONTlVSXl0K1VuK2lONWgzTU9HcE1JcHJ1WjF3NVVSblFVRDVwczZzVXV2?=
 =?utf-8?B?R1hTdzJLMExiTGFQTjc1OXhsTUNkZU1Db1ZTNkxUemFUMWtNbStuZW9NVTlW?=
 =?utf-8?B?V1VoN29wUlh0d1F2a0xEUnRsazNEQWJEcHk0cjVhS0NEY0dkZ2FURkcyelpu?=
 =?utf-8?B?YTlqaVVNZHdFMmJ0dGh6UFdSTS8zbHVHR3k0TE9ycWF6OWI5eUx2dGVNNUR5?=
 =?utf-8?B?MmIyNldYK04rbTNoSWdJZDNRMy9BMkpHTloxWUF1UHJyWEVSSzU0NjhGQ3FP?=
 =?utf-8?B?NGIrWlQzQkpLalBmbXJtNXVhVnJkNmxUV0pkVWVIWmU5S2VyQVl1dGl2NW9S?=
 =?utf-8?Q?jeN7v+R391XvhMjqN5fzBA4LuN79htnOKwcTPmx?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef103a4e-8942-4e3c-2ecb-08d8e7ad33cc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2254.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 12:23:55.8582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5z+fkjyVZmMfHam7gduUVCYO9JoHgM236Sr+AN8/Kva/OnmAojD1COPJx6xY6qOfPVmrqaP/+RsHRuroH/u3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2959
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Non-accounted multi-page tty-related kenrel objects can be created
from inside memcg-limited container.
---
 drivers/tty/tty_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 74733ec..a3b881b 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1503,7 +1503,7 @@ void tty_save_termios(struct tty_struct *tty)
 	/* Stash the termios data */
 	tp = tty->driver->termios[idx];
 	if (tp == NULL) {
-		tp = kmalloc(sizeof(*tp), GFP_KERNEL);
+		tp = kmalloc(sizeof(*tp), GFP_KERNEL_ACCOUNT);
 		if (tp == NULL)
 			return;
 		tty->driver->termios[idx] = tp;
@@ -3128,7 +3128,7 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 {
 	struct tty_struct *tty;
 
-	tty = kzalloc(sizeof(*tty), GFP_KERNEL);
+	tty = kzalloc(sizeof(*tty), GFP_KERNEL_ACCOUNT);
 	if (!tty)
 		return NULL;
 
-- 
1.8.3.1

