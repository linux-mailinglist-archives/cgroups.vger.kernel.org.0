Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6546A5FB6EE
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 17:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiJKPYh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Oct 2022 11:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiJKPYT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Oct 2022 11:24:19 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2056.outbound.protection.outlook.com [40.92.99.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A02C171CE1;
        Tue, 11 Oct 2022 08:15:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDPPOBNCb2FVUXVatbNvkW0sfhePITiSY/RGnMtP9YtNaF6mMD5ocR5AMcLF31nBw8ttn9uF8h1Ji5zo9aXfPDkszUUU3Y9a4jr2hEO8TabOMgSMzxCs3HySM+IbaXEZRDfNPrbeZJ14AJ96rVU/OW/PzzJ84I4DRMZD2xXCf333Rsbqn1WwSzC7impE8n26qVHS1cF3JAxdjyNYFZeCDtp3N6+IFsvNZclwA2k8pLQREOy7uk6bPsD5T0b7RctWPELK90C/43mf6UjzBpM5cKqSFmKruVYijUetgI9lQyrjJ9AUVVvgFYtSlRSSmXdAbpVOlUrm2XXiClOSDr0UNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zo1Uyd5Cr+vUeOBgInoErdw02W2KCHswu/ahNGDjgQE=;
 b=hI1AE8kCCP5wPxIR/Jbz5usFuzpwUvBrh4vZJ68ctafvAuhhaRLAHzJGQ94KFWsdNTbO2FSSMziJd/2udg7L43ApJRlkwM11RvXQ3ZvDGJyyvCUuf/lJiQiQmRa7RGFDlt4OkpHNXyohOXCL4ad3CVkAG/FY8eiZjqqHM2OdyISS47lZPjbwNh6NqbtX7dRGr3y2vKZBqX1HPkzLfdfab6Q4NKGEkRqMenAAX4xbYjdO40zy8RtEOYLa/79stbsa1YL5881hPipvCTYAC2IP5sIEbSOiOCqJwmOFbjKC6RsK/wONNAbSc8A4L4dXAqdTYVypnKQQYF98/l20dLdlLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo1Uyd5Cr+vUeOBgInoErdw02W2KCHswu/ahNGDjgQE=;
 b=PLSTtEFBXU+g/sB/Hz08I+spMOtWRF+JKQV9X9vBw75vIwu8D8ptarpxb9ZZe6ezwTn9wJM+Fe/wxTCg5SxnDy/iUyyX32ke9tvamzGDMLm9eYk4K+gz4fq1vfuOyDm/c7CCRH8SPZ1fwwdFMkrmblb42yYvaPhUmWNMu6klps3AvUjjQ0FGexDJz9SxNrvV4TGtiSWMNiIoPpe7+q/c8iq8ev1Rw6GrYhDg1Gfkg09HIy+6Bs9/F673oqPBuGC70BhBjd2NAl5l5JRtii2qsE2TDsnykdb7tQLxyl88EHiANJF0pX3KN8K7zFDgofgo7XPzYL1PKmWCdXq+wVB7LQ==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OS3P286MB1855.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 14:53:28 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4722:62da:4861:9d73]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::4722:62da:4861:9d73%3]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 14:53:28 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     axboe@kernel.dk, tj@kernel.org, paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH 2/2] block: Make refcnt of bfq_group/bfq_queue atomic
Date:   Tue, 11 Oct 2022 22:52:46 +0800
Message-ID: <TYCP286MB2323F5B27A24ABA2CD1A3F70CA239@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221011145246.8656-1-set_pte_at@outlook.com>
References: <20221011145246.8656-1-set_pte_at@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [2RaW93Jzq6UaufPgovx1BuX/iN/nUzVG]
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20221011145246.8656-3-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OS3P286MB1855:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd74518-22f7-4248-176c-08daab985b61
X-MS-Exchange-SLBlob-MailProps: C/ir7cSdGluUOiRWeVrPQcQDBojfOWWe1TW2X6Jn/BWc2O0Rw+C7Lk6a/5DM0eHi2VdejA8/hifYP+XzBa51h2eVZni1GzwN5ZXV4rVPpSi64WEM8UqjrD+75YhscwMrvUKIkfZbfdtSIx8UBzU6lNhX5vFTQEv7YY0Ku8DKHyNDnZMVFzscSGlozy5pRW9FbSD/zrAPxhRYwJ2l3Ey0nxlyMN3mPqvDQuyzMT3WpevxT3btwc76f2Y3pL/oahzbZWDuuqCJBaARNA7SaBSOTc/4QCTTRxLLcpeSblSmLrrtvLlSKHXsSRntFCPzwlpHaAS4/FZqFMlJG33IhHHdUAw2O98FMqWiXzeGqKQIDQEqqvVCXpgaBXgd4GXggculJZy6siEjxiVgJrZIiHuZkj+MtWpLVnHyRBLQ0uBSGLDLbA78qjxkv5vpd7uxjdd9OLa4g0zm8OPdPfX5ZBXTUABAZGgMSZFTkqGU+Z1twqsr1h8wVuu+DYhqKS9gAgjUGX90pOxdCZvVokUUgW/uKCcIzllFGnOVeJ3CrD42bqsi/3SLMlUMUvfw1eSDtTQ6TJGikaUdBK/0TJIy50l9LQ6o7/Ga1CZiZovhnFOSL+0j9W6htxx4TZ53vO4CswJxy6p8Ro70zH8ZrI767YQlOGrg9OkZIQBwt8LYoa/htLqmoQvQ80nv7l+gvw1kVu5sLyRFCjiljxNC2imD1zThG8MEIapomBjvRzt0MDadbDU4TURlxWl83R3rjJ3ivyGv
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TJZzbOqEI9WzqjliobZhh1iCjMe/0W89rHkRP6Av1vk3qIhRH1RfbHJZUzA3OnFvtvZRpos6E1DvjGGfk00AgOO/3SnNA8Kk+nYQiZYC6Lo12ifCqK5gO5h2yGDoiFKQqkc3XvvwUHZ/EuakhUKQMJs6cAkGrQeXNK8ymYBVl0D8nzf8EhxGdNgVt5fulWeT5Sf35iIN2e5rtUR1+430US833jRQjmmrE9IFbaQbBCQqJfXWmIGIHPoYOWzmU4IVUKTSqlK6CNPs7Z3WbSyrkNVp91RWlNNDcuet/wYfwKDTp/R80WOSSVqu6QAdc2Jdz61Llfazf6Ow7BAvC6Q79C6kffXEczkkK6gqPFZmbBoqkZArMBJq4s1s2LWekt0GrRZMkvYIoRgzAzUv1pUZoEDDlnvXaeRlazUlBEikxcw70Jc0Crxee1LOygeyLx04cY8OOP99W+ES2H6RaosFbVEsAJEWgfWuDwtawtwmOBUkuTn+uTblz6wZqITXjNQ111QLUUi+jUnySk31ArBkK6lry02RWXUhdjJA5wU6UGvwmnkEQ9ZlJwWcrtaDpXDr4cl8+1i5IuVFAg+Kv7gyyIYFAp6lskjnY96958ozstc0HLYsM+gwoClZ6eXyaeJLn95VWPZUGzSSKvZn183D1zLGE8qpxB/ZyzelhUaPMNgZ5bFoPADoK35spjRsMQAp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ym4mqwZCjMAyu9RgeTX0+7qTk7sTlKnexCeop8MpeH8LVh/GkBvywWJTdNy1?=
 =?us-ascii?Q?u9ALbHXglV6evBlcXGZNG8uDsMyYJzD4XrCxArpZYFePrVur51vABkaIT5BL?=
 =?us-ascii?Q?9tGqSkxrq4kGbvkbbE6GMfg6TUhf3jdSLP3fD+ouCxYrHjNFHWvPP5oCfS8I?=
 =?us-ascii?Q?QU25lHjKRYC+gB3InPebTX2KkUWry37cYTSLz/qNlzShDQi3JoUz26oINZnP?=
 =?us-ascii?Q?vqRQ5JVziB5w3k09QcBfgCKJEuqiiQmSM1Yb/f4pLymMbQENAX3BhUtDUZso?=
 =?us-ascii?Q?lxDWynWRbdP/361NEf5bYiUr9kldDIcbG5PCW79Z2DOixoia+4RXzgf5UDVE?=
 =?us-ascii?Q?/RWVjarqm2mld22EU0LTAhozARstbov5FLfu5oseAT8GUyzuW0Lf0qfgnh/X?=
 =?us-ascii?Q?ll6YzvcIeckQyCITL1eQrMoxofQhbKV0MFLdbCnOkJWcE2dtOySHzSbjPQrc?=
 =?us-ascii?Q?ed+eAAXUELtwNDlVbaYUSAsbufELLuBKgXVjgsDvgWAgNGr/6VCuOggHkg6m?=
 =?us-ascii?Q?mU/7Y5VmM2WhNbB0to1uMeYnG6A1rHlUGN/r4Jr+OP2+H5uXuZl1TpsWP6oS?=
 =?us-ascii?Q?mTpmhGl170T8m7dEgOrzDKR/iWopWSoxoXwCVSJ9t5O+ckDyh1gfl1uJbJgc?=
 =?us-ascii?Q?QwcAldRo09oWfeRV90GzR7Z21cHJmWJ3zcPBkZSxR3i556TbMAHbY/kV8Ljl?=
 =?us-ascii?Q?cTjZYrIKF7SM23HMEuO9Td3HFxFtc/CZP+KkLM7KbFGeed0pelZlPF27zJvp?=
 =?us-ascii?Q?zmp7mC45RqtVYkLJWQf9YN+3Nv4CEBrkj0qYqqUFKIjN/jnle1X2l0KjS6/I?=
 =?us-ascii?Q?8SKFzAcgFbNEJkmjTALTwhXAVkl/RfVL10dbwsrfOM9+VSO5cwQpAMwyiefB?=
 =?us-ascii?Q?sx9lt1PiVz3/D4VoF8CitMioDbhgNitZqlLtcjW2wjwu/grplfvzQA2EIbu5?=
 =?us-ascii?Q?YewzcD5oA0rN7bZ8pd2S/s7dyOyjEfbxqYWmW1y8gyUv3+YhFZPgQ024kOL/?=
 =?us-ascii?Q?G1Fl/+5LbQhXAlWpECzQUNUwSEGXsSYwnRBWpdvp7vza6y0hIeoW0Bx8UbVP?=
 =?us-ascii?Q?W19Y7VL4sDOLsIuUehqFlXV+uKweAzx4aki61p86YLpim0iET+51L0M6lOu1?=
 =?us-ascii?Q?lJuAbWn1stgmKmhwtGxd6IaFCR2t3czEzA1WI5bwv1Dw/CU1U0fcrmUMRsU0?=
 =?us-ascii?Q?SIju5sz1AkN6MjTVd0/I1Ap3uuqbiupzsYRCZB16xkRZ6I3i6gzX/H4pVI9E?=
 =?us-ascii?Q?h8l7yu5dMwHYEVp9XNAf/bG7erDAx2eS9041YTqoIw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd74518-22f7-4248-176c-08daab985b61
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 14:53:28.6278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1855
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For most implementations of reference count, atomic_t is preferred
for their natural-born atomic ops capability.
Change the reference count of bfq_group/bfq_queue, both data structures
and related ops, into atomic.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 block/bfq-cgroup.c  |  8 +++----
 block/bfq-iosched.c | 54 +++++++++++++++++++++++----------------------
 block/bfq-iosched.h |  6 ++---
 block/bfq-wf2q.c    |  6 ++---
 4 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 144bca006463..714126ba21b6 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -316,14 +316,12 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
 
 static void bfqg_get(struct bfq_group *bfqg)
 {
-	bfqg->ref++;
+	atomic_inc(&bfqg->ref);
 }
 
 static void bfqg_put(struct bfq_group *bfqg)
 {
-	bfqg->ref--;
-
-	if (bfqg->ref == 0)
+	if (atomic_dec_and_test(&bfqg->ref))
 		kfree(bfqg);
 }
 
@@ -659,7 +657,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	 * Get extra reference to prevent bfqq from being freed in
 	 * next possible expire or deactivate.
 	 */
-	bfqq->ref++;
+	atomic_inc(&bfqq->ref);
 
 	/* If bfqq is empty, then bfq_bfqq_expire also invokes
 	 * bfq_del_bfqq_busy, thereby removing bfqq and its entity
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 7ea427817f7f..fbe5624be71f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -935,7 +935,7 @@ void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 inc_counter:
 	bfqq->weight_counter->num_active++;
-	bfqq->ref++;
+	atomic_inc(&bfqq->ref);
 }
 
 /*
@@ -1224,9 +1224,10 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 
 static int bfqq_process_refs(struct bfq_queue *bfqq)
 {
-	return bfqq->ref - bfqq->entity.allocated -
+	return atomic_read(&bfqq->ref) - bfqq->entity.allocated -
 		bfqq->entity.on_st_or_in_serv -
-		(bfqq->weight_counter != NULL) - bfqq->stable_ref;
+		(bfqq->weight_counter != NULL) -
+		atomic_read(&bfqq->stable_ref);
 }
 
 /* Empty burst list and add just bfqq (see comments on bfq_handle_burst) */
@@ -2818,7 +2819,7 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
 	 * expected to be associated with new_bfqq as they happen to
 	 * issue I/O.
 	 */
-	new_bfqq->ref += process_refs;
+	atomic_add(process_refs, &new_bfqq->ref);
 	return new_bfqq;
 }
 
@@ -5255,10 +5256,10 @@ void bfq_put_queue(struct bfq_queue *bfqq)
 	struct hlist_node *n;
 	struct bfq_group *bfqg = bfqq_group(bfqq);
 
-	bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p %d", bfqq, bfqq->ref);
+	bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p %d", bfqq,
+		     atomic_read(&bfqq->ref));
 
-	bfqq->ref--;
-	if (bfqq->ref)
+	if (!atomic_dec_and_test(&bfqq->ref))
 		return;
 
 	if (!hlist_unhashed(&bfqq->burst_list_node)) {
@@ -5328,7 +5329,7 @@ void bfq_put_queue(struct bfq_queue *bfqq)
 
 static void bfq_put_stable_ref(struct bfq_queue *bfqq)
 {
-	bfqq->stable_ref--;
+	atomic_dec(&bfqq->stable_ref);
 	bfq_put_queue(bfqq);
 }
 
@@ -5358,7 +5359,7 @@ static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 		bfq_schedule_dispatch(bfqd);
 	}
 
-	bfq_log_bfqq(bfqd, bfqq, "exit_bfqq: %p, %d", bfqq, bfqq->ref);
+	bfq_log_bfqq(bfqd, bfqq, "exit_bfqq: %p, %d", bfqq, atomic_read(&bfqq->ref));
 
 	bfq_put_cooperator(bfqq);
 
@@ -5507,7 +5508,7 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	INIT_HLIST_NODE(&bfqq->woken_list_node);
 	INIT_HLIST_HEAD(&bfqq->woken_list);
 
-	bfqq->ref = 0;
+	atomic_set(&bfqq->ref, 0);
 	bfqq->bfqd = bfqd;
 
 	if (bic)
@@ -5710,12 +5711,12 @@ static struct bfq_queue *bfq_do_or_sched_stable_merge(struct bfq_data *bfqd,
 			 * to prevent it from being freed,
 			 * until we decide whether to merge
 			 */
-			last_bfqq_created->ref++;
+			atomic_inc(&last_bfqq_created->ref);
 			/*
 			 * need to keep track of stable refs, to
 			 * compute process refs correctly
 			 */
-			last_bfqq_created->stable_ref++;
+			atomic_inc(&last_bfqq_created->stable_ref);
 			/*
 			 * Record the bfqq to merge to.
 			 */
@@ -5767,20 +5768,21 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 	 * prune it.
 	 */
 	if (async_bfqq) {
-		bfqq->ref++; /*
-			      * Extra group reference, w.r.t. sync
-			      * queue. This extra reference is removed
-			      * only if bfqq->bfqg disappears, to
-			      * guarantee that this queue is not freed
-			      * until its group goes away.
-			      */
+		atomic_inc(&bfqq->ref);
+		/*
+		 * Extra group reference, w.r.t. sync
+		 * queue. This extra reference is removed
+		 * only if bfqq->bfqg disappears, to
+		 * guarantee that this queue is not freed
+		 * until its group goes away.
+		 */
 		bfq_log_bfqq(bfqd, bfqq, "get_queue, bfqq not in async: %p, %d",
-			     bfqq, bfqq->ref);
+			     bfqq, atomic_read(&bfqq->ref));
 		*async_bfqq = bfqq;
 	}
 
 out:
-	bfqq->ref++; /* get a process reference to this queue */
+	atomic_inc(&bfqq->ref); /* get a process reference to this queue */
 
 	if (bfqq != &bfqd->oom_bfqq && is_sync && !respawn)
 		bfqq = bfq_do_or_sched_stable_merge(bfqd, bfqq, bic);
@@ -6059,7 +6061,7 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 		 */
 		bfqq_request_allocated(new_bfqq);
 		bfqq_request_freed(bfqq);
-		new_bfqq->ref++;
+		atomic_inc(&new_bfqq->ref);
 		/*
 		 * If the bic associated with the process
 		 * issuing this request still points to bfqq
@@ -6803,10 +6805,10 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 	}
 
 	bfqq_request_allocated(bfqq);
-	bfqq->ref++;
+	atomic_inc(&bfqq->ref);
 	bic->requests++;
 	bfq_log_bfqq(bfqd, bfqq, "get_request %p: bfqq %p, %d",
-		     rq, bfqq, bfqq->ref);
+		     rq, bfqq, atomic_read(&bfqq->ref));
 
 	rq->elv.priv[0] = bic;
 	rq->elv.priv[1] = bfqq;
@@ -6939,7 +6941,7 @@ static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
 		bfq_bfqq_move(bfqd, bfqq, bfqd->root_group);
 
 		bfq_log_bfqq(bfqd, bfqq, "put_async_bfqq: putting %p, %d",
-			     bfqq, bfqq->ref);
+			     bfqq, atomic_read(&bfqq->ref));
 		bfq_put_queue(bfqq);
 		*bfqq_ptr = NULL;
 	}
@@ -7092,7 +7094,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	 * will not attempt to free it.
 	 */
 	bfq_init_bfqq(bfqd, &bfqd->oom_bfqq, NULL, 1, 0);
-	bfqd->oom_bfqq.ref++;
+	atomic_inc(&bfqd->oom_bfqq.ref);
 	bfqd->oom_bfqq.new_ioprio = BFQ_DEFAULT_QUEUE_IOPRIO;
 	bfqd->oom_bfqq.new_ioprio_class = IOPRIO_CLASS_BE;
 	bfqd->oom_bfqq.entity.new_weight =
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 64ee618064ba..71ac0de80bb0 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -234,9 +234,9 @@ struct bfq_ttime {
  */
 struct bfq_queue {
 	/* reference counter */
-	int ref;
+	atomic_t ref;
 	/* counter of references from other queues for delayed stable merge */
-	int stable_ref;
+	atomic_t stable_ref;
 	/* parent bfq_data */
 	struct bfq_data *bfqd;
 
@@ -928,7 +928,7 @@ struct bfq_group {
 	char blkg_path[128];
 
 	/* reference counter (see comments in bfq_bic_update_cgroup) */
-	int ref;
+	atomic_t ref;
 	/* Is bfq_group still online? */
 	bool online;
 
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 8fc3da4c23bb..60a9a2c1fc8d 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -512,9 +512,9 @@ static void bfq_get_entity(struct bfq_entity *entity)
 	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
 
 	if (bfqq) {
-		bfqq->ref++;
+		atomic_inc(&bfqq->ref);
 		bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: %p %d",
-			     bfqq, bfqq->ref);
+			     bfqq, atomic_read(&bfqq->ref));
 	}
 }
 
@@ -1611,7 +1611,7 @@ bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
 		 * reference to the queue. If this is the case, then
 		 * bfqq gets freed here.
 		 */
-		int ref = in_serv_bfqq->ref;
+		int ref = atomic_read(&in_serv_bfqq->ref);
 		bfq_put_queue(in_serv_bfqq);
 		if (ref == 1)
 			return true;
-- 
2.25.1

